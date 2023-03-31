Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B986D1FD2
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjCaMOp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 08:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCaMOn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 08:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE681DFB2;
        Fri, 31 Mar 2023 05:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8562F6287A;
        Fri, 31 Mar 2023 12:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855E4C433D2;
        Fri, 31 Mar 2023 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680264881;
        bh=aVZf/XrJJHV2m+r63DZrMTx0gyiGjL25k+dDKUwAHkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aE922uonF/7WRWrJeKn6iKOvlCfXRfex9uaJGpuAkyvwmTJRjsQ6i7d/nci30QGnm
         VNT53NrL4vBcOxeu6CNj7NU6LBuTmzTvUO0MXi87TlXI4iI3iZL/2c32j26M4ZCca5
         c2Wa/03xxVZnqDxPGJvYY3q8BisavVMuvSBMuYL2w/kOOP3smZf1ElCNuGhVmftymb
         DAnmTeGHNOFkF6otRnHIDpKOd7s3Sibm9roAy4mZHJhl1f5poX4LENQG6pNAR9AEP7
         04pDqrYSyq5SEZCAUTpbzvXmUEIstkJsTx/UxqSypafvc6togrYQHNDjP8kX/Cf3rg
         2U0pNbSrzMbWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 50EE24052D; Fri, 31 Mar 2023 09:14:39 -0300 (-03)
Date:   Fri, 31 Mar 2023 09:14:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com
Subject: Re: [PATCH dwarves] fprintf: Fix `*` not being printed for pointers
 with btf_type_tag
Message-ID: <ZCbOr4pwrX7JVnCZ@kernel.org>
References: <20230330212700.697124-1-eddyz87@gmail.com>
 <ZCbOdWCKKzLlprIs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCbOdWCKKzLlprIs@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 31, 2023 at 09:13:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 31, 2023 at 12:27:00AM +0300, Eduard Zingerman escreveu:
> > Recent change to fprintf (see below) causes incorrect `type_fprintf()`
> > behavior for pointers annotated with btf_type_tag, for example:
> > 
> >     $ cat tag-test.c
> >     #define __t __attribute__((btf_type_tag("t1")))
> > 
> >     struct foo {
> >       int __t *a;
> >     } g;
> > 
> >     $ clang -g -c tag-test.c -o tag-test.o && \
> >       pahole -J tag-test.o && pahole --sort -F dwarf tag-test.o
> >     struct foo {
> >     	int                        a;                    /*     0     8 */
> >     	...
> >     };
> > 
> > Note that `*` is missing in the pahole output.
> > The issue is caused by `goto next_type` that jumps over the
> > `tag__name()` that is responsible for pointer printing.
> > 
> > As agreed in [1] `type__fprintf()` is modified to skip type tags for
> > now and would be modified to emit type tags later.
> > 
> > The change in `__tag__name()` is necessary to avoid the following behavior:
> > 
> >     $ cat tag-test.c
> >     #define __t __attribute__((btf_type_tag("t1")))
> > 
> >     struct foo {
> >       int __t *a;
> >       int __t __t *b;
> >     } g;
> > 
> >     $ clang -g -c tag-test.c -o tag-test.o && \
> >       pahole -J tag-test.o && pahole --sort -F dwarf tag-test.o
> >     struct foo {
> >     	int  *                     a;                    /*     0     8 */
> >     	int   *                    b;                    /*     8     8 */
> >             ...
> >     };
> > 
> > Note the extra space before `*` for field `b`.
> > 
> > The issue was reported and tracked down to the root cause by
> > Arnaldo Carvalho de Melo.
> > 
> > Links:
> > [1] https://lore.kernel.org/dwarves/20230314230417.1507266-1-eddyz87@gmail.com/T/#md82b04f66867434524beec746138951f26a3977e
> > 
> > Fixes: e7fb771f2649 ("fprintf: Correct names for types with btf_type_tag attribute")
> > Reported-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > Link: https://lore.kernel.org/dwarves/20230314230417.1507266-1-eddyz87@gmail.com/T/#mc630bcd474ddd64c70d237edd4e0590dc048d63d
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  dwarves_fprintf.c | 37 +++++++++++++++++++++++++++++--------
> >  1 file changed, 29 insertions(+), 8 deletions(-)
> > 
> > diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> > index 1e6147a..818db2d 100644
> > --- a/dwarves_fprintf.c
> > +++ b/dwarves_fprintf.c
> > @@ -572,7 +572,6 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
> >  	case DW_TAG_restrict_type:
> >  	case DW_TAG_atomic_type:
> >  	case DW_TAG_unspecified_type:
> > -	case DW_TAG_LLVM_annotation:
> >  		type = cu__type(cu, tag->type);
> >  		if (type == NULL && tag->type != 0)
> >  			tag__id_not_found_snprintf(bf, len, tag->type);
> > @@ -618,6 +617,13 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
> >  	case DW_TAG_variable:
> >  		snprintf(bf, len, "%s", variable__name(tag__variable(tag)));
> >  		break;
> > +	case DW_TAG_LLVM_annotation:
> > +		type = cu__type(cu, tag->type);
> > +		if (type == NULL && tag->type != 0)
> > +			tag__id_not_found_snprintf(bf, len, tag->type);
> > +		else if (!tag__has_type_loop(tag, type, bf, len, NULL))
> > +			__tag__name(type, cu, bf, len, conf);
> > +		break;
> >  	default:
> >  		snprintf(bf, len, "%s%s", tag__prefix(cu, tag->tag, pconf),
> >  			 type__name(tag__type(tag)) ?: "");
> > @@ -677,6 +683,22 @@ static size_t type__fprintf_stats(struct type *type, const struct cu *cu,
> >  	return printed;
> >  }
> >  
> > +static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t id)
> > +{
> > +	struct tag *type;
> > +
> > +	for (;;) {
> > +		if (id == 0)
> > +			break;
> > +		type = cu__type(cu, id);
> > +		if (type == NULL || type->tag != DW_TAG_LLVM_annotation || type->type == id)
> > +			break;
> > +		id = type->type;
> > +	}
> > +
> > +	return id;
> > +}
> 
> This part I didn't understand, do you see any possibility of a
> DW_TAG_LLVM_annotation pointing to another DW_TAG_LLVM_annotation?

I _think_ its a noop, so will test your patch as-is, thanks!

- Arnaldo
 
> - Arnaldo
> 
> > +
> >  static size_t union__fprintf(struct type *type, const struct cu *cu,
> >  			     const struct conf_fprintf *conf, FILE *fp);
> >  
> > @@ -778,19 +800,17 @@ inner_struct:
> >  
> >  next_type:
> >  	switch (type->tag) {
> > -	case DW_TAG_pointer_type:
> > -		if (type->type != 0) {
> > +	case DW_TAG_pointer_type: {
> > +		type_id_t ptype_id = skip_llvm_annotations(cu, type->type);
> > +
> > +		if (ptype_id != 0) {
> >  			int n;
> > -			struct tag *ptype = cu__type(cu, type->type);
> > +			struct tag *ptype = cu__type(cu, ptype_id);
> >  			if (ptype == NULL)
> >  				goto out_type_not_found;
> >  			n = tag__has_type_loop(type, ptype, NULL, 0, fp);
> >  			if (n)
> >  				return printed + n;
> > -			if (ptype->tag == DW_TAG_LLVM_annotation) {
> > -				type = ptype;
> > -				goto next_type;
> > -			}
> >  			if (ptype->tag == DW_TAG_subroutine_type) {
> >  				printed += ftype__fprintf(tag__ftype(ptype),
> >  							  cu, name, 0, 1,
> > @@ -811,6 +831,7 @@ next_type:
> >  			}
> >  		}
> >  		/* Fall Thru */
> > +	}
> >  	default:
> >  print_default:
> >  		printed += fprintf(fp, "%-*s %s", tconf.type_spacing,
> > -- 
> > 2.40.0
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
