Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7656F55DAE5
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiF0Qn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiF0Qn2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 12:43:28 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D9DEBD
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 09:43:27 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id C691724002A
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 18:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656348204; bh=IyUvi7V19IaRfn4ugg9lUzrftgBj1gIce8beJfKTCfY=;
        h=Date:From:To:Cc:Subject:From;
        b=ribODehmbDnCtv62uzgCaUAq+pmQuQbcRDZbeszou+vVVcL18sn7c19U7KupFWH2v
         xrqW4JwCzwvucgwV0CEMRakYnMVhd53c3m6AGvZNEEYsAEnxe2KoUadg6WR7AInikn
         kRv46ifMCDdXOnlzO11prjpEZMGvWbZsTI6oURQ/MIRF7qTPgFnlTnZKLssirxnC2V
         5g8fbOd9HlVK8zwd5fFiTSxpT1yNJxnrUMyu0eZGGI0tIvVqtDej+rn6/6nEXQ3/ps
         TIM8e1HCbIb4BkHHUEl6gz0yIR+1hEqA0MGwxv+L4aLyUdYoSXJSBDIwMsSNZO/52w
         6Gi/PSDpN19mw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LWtp06ccqz6tn0;
        Mon, 27 Jun 2022 18:43:20 +0200 (CEST)
Date:   Mon, 27 Jun 2022 16:43:17 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, joannelkoong@gmail.com,
        Mauricio =?utf-8?Q?V=C3=A1squez?= <mauricio@kinvolk.io>
Subject: Re: [PATCH bpf-next v2 2/9] bpftool: Honor BPF_CORE_TYPE_MATCHES
 relocation
Message-ID: <20220627164317.k7rkbrtlkzsa4ypk@muellerd-fedora-MJ0AC3F3>
References: <20220623212205.2805002-1-deso@posteo.net>
 <20220623212205.2805002-3-deso@posteo.net>
 <a4770a25-b78a-d721-4d30-ae58feec965c@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4770a25-b78a-d721-4d30-ae58feec965c@isovalent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 12:37:09PM +0100, Quentin Monnet wrote:
> 2022-06-23 21:21 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> > bpftool needs to know about the newly introduced BPF_CORE_TYPE_MATCHES
> > relocation for its 'gen min_core_btf' command to work properly in the
> > present of this relocation.
> > Specifically, we need to make sure to mark types and fields so that they
> > are present in the minimized BTF for "type match" checks to work out.
> > However, contrary to the existing btfgen_record_field_relo, we need to
> > rely on the BTF -- and not the spec -- to find fields. With this change
> > we handle this new variant correctly. The functionality will be tested
> > with follow on changes to BPF selftests, which already run against a
> > minimized BTF created with bpftool.
> > 
> > Cc: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  tools/bpf/bpftool/gen.c | 107 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> > 
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 480cbd8..6cd0ed 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -1856,6 +1856,111 @@ static int btfgen_record_field_relo(struct btfgen_info *info, struct bpf_core_sp
> >  	return 0;
> >  }
> >  
> > +/* Mark types, members, and member types. Compared to btfgen_record_field_relo,
> > + * this function does not rely on the target spec for inferring members, but
> > + * uses the associated BTF.
> > + *
> > + * The `behind_ptr` argument is used to stop marking of composite types reached
> > + * through a pointer. This way, we keep can keep BTF size in check while
> 
> Typo, "we keep can keep"

Fixed. Thanks!

> > + * providing reasonable match semantics.
> > + */
> > +static int btfgen_mark_types_match(struct btfgen_info *info, __u32 type_id, bool behind_ptr)
> > +{
> > +	const struct btf_type *btf_type;
> > +	struct btf *btf = info->src_btf;
> > +	struct btf_type *cloned_type;
> > +	int i, err;
> > +
> > +	if (type_id == 0)
> > +		return 0;
> > +
> > +	btf_type = btf__type_by_id(btf, type_id);
> > +	/* mark type on cloned BTF as used */
> > +	cloned_type = (struct btf_type *)btf__type_by_id(info->marked_btf, type_id);
> > +	cloned_type->name_off = MARKED;
> > +
> > +	switch (btf_kind(btf_type)) {
> > +	case BTF_KIND_UNKN:
> > +	case BTF_KIND_INT:
> > +	case BTF_KIND_FLOAT:
> > +	case BTF_KIND_ENUM:
> > +	case BTF_KIND_ENUM64:
> > +		break;
> > +	case BTF_KIND_STRUCT:
> > +	case BTF_KIND_UNION: {
> > +		struct btf_member *m = btf_members(btf_type);
> > +		__u16 vlen = btf_vlen(btf_type);
> > +
> > +		if (behind_ptr)
> > +			break;
> > +
> > +		for (i = 0; i < vlen; i++, m++) {
> > +			/* mark member */
> > +			btfgen_mark_member(info, type_id, i);
> > +
> > +			/* mark member's type */
> > +			err = btfgen_mark_types_match(info, m->type, false);
> > +			if (err)
> > +				return err;
> > +		}
> > +		break;
> > +	}
> > +	case BTF_KIND_CONST:
> > +	case BTF_KIND_FWD:
> > +	case BTF_KIND_VOLATILE:
> > +	case BTF_KIND_TYPEDEF:
> > +		return btfgen_mark_types_match(info, btf_type->type, false);
> > +	case BTF_KIND_PTR:
> > +		return btfgen_mark_types_match(info, btf_type->type, true);
> > +	case BTF_KIND_ARRAY: {
> > +		struct btf_array *array;
> > +
> > +		array = btf_array(btf_type);
> > +		/* mark array type */
> > +		err = btfgen_mark_types_match(info, array->type, false);
> > +		/* mark array's index type */
> > +		err = err ? : btfgen_mark_types_match(info, array->index_type, false);
> > +		if (err)
> > +			return err;
> > +		break;
> > +	}
> > +	case BTF_KIND_FUNC_PROTO: {
> > +		__u16 vlen = btf_vlen(btf_type);
> > +		struct btf_param *param;
> > +
> > +		/* mark ret type */
> > +		err = btfgen_mark_types_match(info, btf_type->type, false);
> > +		if (err)
> > +			return err;
> > +
> > +		/* mark parameters types */
> > +		param = btf_params(btf_type);
> > +		for (i = 0; i < vlen; i++) {
> > +			err = btfgen_mark_types_match(info, param->type, false);
> > +			if (err)
> > +				return err;
> > +			param++;
> > +		}
> > +		break;
> > +	}
> > +	/* tells if some other type needs to be handled */
> > +	default:
> > +		p_err("unsupported kind: %s (%d)", btf_kind_str(btf_type), type_id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Mark types, members, and member types. Compared to btfgen_record_field_relo,
> > + * this function does not rely on the target spec for inferring members, but
> > + * uses the associated BTF.
> > + */
> > +static int btfgen_record_types_match_relo(struct btfgen_info *info, struct bpf_core_spec *targ_spec)
> 
> Nit: Maybe btfgen_record_type_match_relo() ("type" singular), for
> consistency with btfgen_record_type_relo()?

Sure, changed.

> > +{
> > +	return btfgen_mark_types_match(info, targ_spec->root_type_id, false);
> > +}
> > +
> >  static int btfgen_record_type_relo(struct btfgen_info *info, struct bpf_core_spec *targ_spec)
> >  {
> >  	return btfgen_mark_type(info, targ_spec->root_type_id, true);
> > @@ -1882,6 +1987,8 @@ static int btfgen_record_reloc(struct btfgen_info *info, struct bpf_core_spec *r
> >  	case BPF_CORE_TYPE_EXISTS:
> >  	case BPF_CORE_TYPE_SIZE:
> >  		return btfgen_record_type_relo(info, res);
> > +	case BPF_CORE_TYPE_MATCHES:
> > +		return btfgen_record_types_match_relo(info, res);
> >  	case BPF_CORE_ENUMVAL_EXISTS:
> >  	case BPF_CORE_ENUMVAL_VALUE:
> >  		return btfgen_record_enumval_relo(info, res);
> 
> Aside from the minor nits, the patch looks good to me. Thanks!

Thanks for your review!

Daniel

> Acked-by: Quentin Monnet <quentin@isovalent.com>
