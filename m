Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCE6D0326
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjC3L3M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 07:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjC3L3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 07:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253598A69;
        Thu, 30 Mar 2023 04:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A9D62026;
        Thu, 30 Mar 2023 11:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C8FC433EF;
        Thu, 30 Mar 2023 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680175747;
        bh=89r/ZQqYEAb0CiFW+TT/nv8JNV7foZ9Ti/EXAlOgso0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvkH2L61gvQNsL5Q8Chw6EkESQiqBrWbvnQ3g9OyfT9LzQISwbQ9yHfZlT6zSt6Zz
         r4Iddm2SdrwwXv92AkcZgGYFC/kQ8GntG+q6IN4ZxffbxCZpPaI5Vq3MyT4f7es/YN
         +/7kLxLY5B+j2o2tZIq7Tbdd/PBPOgHNWZlTxDg6bIarntIJ4mJqKVf2cwwY9n5Gcd
         Bv9im2Hp+bIxCV7hcAkmqEBVsrzeboeJtrSWezujB+P6j/3IplBljrG6Ef2lGlYs/c
         uTDeukRXehQyx1VKWNWzPSiLqcfYlvYD89gT3IdJi6Jpv6XW5yPuXW/XPhy1FA4pOO
         p5TK0i1Z+0wkw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF05E4052D; Thu, 30 Mar 2023 08:29:04 -0300 (-03)
Date:   Thu, 30 Mar 2023 08:29:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
Message-ID: <ZCVygOn0+zKFEqW2@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
 <20230314230417.1507266-2-eddyz87@gmail.com>
 <ZCLy0hjyR3KuYy3e@kernel.org>
 <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
 <ZCMHKFdmjVpOSNsJ@kernel.org>
 <50a160d802ad3f84e91cf05c8f541e0c2e388fc8.camel@gmail.com>
 <ZCNZcl1mkC9yhwDD@kernel.org>
 <fabfc71fd43be48f68019c911c6a3af1412f4635.camel@gmail.com>
 <ZCRctmB2yrwgsNMh@kernel.org>
 <f9664121426c5665ff0fc8cb61c466689beadd36.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9664121426c5665ff0fc8cb61c466689beadd36.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 29, 2023 at 07:02:45PM +0300, Eduard Zingerman escreveu:
> On Wed, 2023-03-29 at 12:43 -0300, Arnaldo Carvalho de Melo wrote:
> [...]
> > > > diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> > > > index 1e6147a82056c188..1ecc24321bf8f975 100644
> > > > --- a/dwarves_fprintf.c
> > > > +++ b/dwarves_fprintf.c
> > > > @@ -788,8 +788,15 @@ next_type:
> > > >  			if (n)
> > > >  				return printed + n;
> > > >  			if (ptype->tag == DW_TAG_LLVM_annotation) {
> > > > -				type = ptype;
> > > > -				goto next_type;
> > > > +				// FIXME: Just skip this for now, we need to print this annotation
> > > > +				// to match the original source code.
> > > > +
> > > > +				if (ptype->type == 0) {
> > > > +					printed += fprintf(fp, "%-*s %s", tconf.type_spacing, "void *", name);
> > > > +					break;
> > > > +				}
> > > > +
> > > > +				ptype = cu__type(cu, ptype->type);
> > > >  			}
> > > >  			if (ptype->tag == DW_TAG_subroutine_type) {
> > > >  				printed += ftype__fprintf(tag__ftype(ptype),
> > > 
> > > This explains why '*' was missing, but unfortunately it breaks apart
> > > when there are multiple type tags, e.g.:
> > > 
> > > 
> > >     $ cat tag-test.c
> > >     #define __t __attribute__((btf_type_tag("t1")))
> > >     
> > >     struct foo {
> > >       int  (__t __t *a)(void);
> > >     } g;
> > >     $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o && pahole --sort -F dwarf tag-test.o
> > >     struct foo {
> > >     	int ()(void)   *           a;                    /*     0     8 */
> > >     
> > >     	/* size: 8, cachelines: 1, members: 1 */
> > >     	/* last cacheline: 8 bytes */
> > >     };
> > >     $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o && pahole --sort -F btf tag-test.o
> > >     struct foo {
> > >     	int ()(void)   *           a;                    /*     0     8 */
> > >     
> > >     	/* size: 8, cachelines: 1, members: 1 */
> > >     	/* last cacheline: 8 bytes */
> > >     };
> > >     
> > > What I don't understand is why pointer's type is LLVM_annotation.
> > 
> > Well, that is how it is encoded in BTF and then you supported it in:
> > 
> > Author: Eduard Zingerman <eddyz87@gmail.com>
> > Date:   Wed Mar 15 01:04:14 2023 +0200
> > 
> >     btf_loader: A hack for BTF import of btf_type_tag attributes`
> 
> To be honest, I was under impression that I add a workaround and the
> preferred way is to do what dwarf loader does with
> btf_type_tag_ptr_type::annots.
>  
> > I find it natural, and think that annots thing is a variation on how to
> > store modifiers for types, see, this DW_TAG_LLVM_annotation is in the
> > same class as 'restrict', 'const', 'volatile', "atomic", etc
> > 
> > I understand that for encoding _DWARF_ people preferred to make it as a
> > child DIE to avoid breaking existing DWARF consumers, but in
> > pahole's dwarf_loader.c we can just make it work like BTF and insert the
> > btf_type_tag in the chain, just like 'const', etc, no?
> > 
> > pahole wants to print those annotation just like it prints 'const',
> > 'volatile', etc.
> 
> Actually, if reflecting physical structure of the DWARF is not a goal,

Well reflecting the physical structure of DWARF _pre_
DW_TAG_llvm_annotation was the goal, but now, since this was done
differently of DW_TAG_const_type, DW_TAG_pointer_type, etc, as one link
in the chain, to avoid breaking existing DWARF consumers, we ended up
with this annot thing, but the internal representation in pahole can
continue being as a chain, as BTF does, right?

> forgoing "annots" fields altogether and treating type tags as derived
> types should make support for btf:type_tag (the v2 version) simpler.

I think it should simplify as we're used to these chains.
 
> Then, getting back to the current issue, I need to add
> skip_llvm_annotations function with a loop inside, right?

You can, to remove them completely and its like they don't exist for
dwarf_fprintf.c, but what I think should be done is to actually print
them, to reconstruct the original source code.

You can start removing them and we can work later on properly printing
it, so that we can get 1.25 out of the door as there are multiple
requests for it to be released to solve other problems with using 1.24.

- Arnaldo
 
> > > Probably, the cleanest solution would be to make DWARF and BTF loaders
> > > work in a similar way and attach LLVM_annotation as `annots` field of
> > > the `struct btf_type_tag_ptr_type`. Thus, avoiding 'LLVM_annotation's
> > > in the middle of type chains. I'll work on this.
