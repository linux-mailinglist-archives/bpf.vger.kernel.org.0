Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5584CB253
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 23:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiCBWbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 17:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiCBWbI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 17:31:08 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDEDE86A9
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 14:30:23 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id z2so2822721plg.8
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0lckhfFueGg9exxx8rqezeAnepFbInBGbHUtasmTmfo=;
        b=PNxXYvkajYEOhrdDOAf+LPHD/fnXg+t/agLpNR1Y3svoBHLJ0ySS9HGubwZlLse1rW
         CCX9+83R5O7M15ELmGXHMwsgqoO8sQmwYV4Lg3oSi2Zf5/lgwjVMmMFev3xznTouJEfD
         8tY1lnsIzeZihzeRn0/dA48IJWa/9TkUSznBjjEEC4off8gLeGya+Tn146diqW5xL1k2
         fGQj8Y8Jxb9Z+xqTPa8E3wEcd8Q0qs7MgduMU43QNDN9s/1oAUz2oD2w+aiulBYln895
         ZfsVeoL9fUUAc/7hq5fF60HK8t+Vg9U37kf6umUWAQrl3/eQn9urfeATWr7o65qIFhHf
         ZUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0lckhfFueGg9exxx8rqezeAnepFbInBGbHUtasmTmfo=;
        b=G/xa3/aWWypPyvDB/3yc7EHjYMFL+pb+k5Mue7okFzwnPV+WpmRCvHgEiaa5gkrV6x
         EgpDUBMFN3ozCXIGO6gkDNA+IwFaP6g+92hxm6LBX4RwFBYRKDIB0eCM3aR2F5oZywol
         EwkyUT9iYQe1J3gUr1sIhTqnY0HgU14jqKq3x4vOzULz9qbJXJ/wFI1wByoU0Zos9QNR
         gRfCp2tLIIC8cgxx7h95pCQj2YRD8iP8O/MQHf4oVebNKAyLZS1BdSQWrz4NFrCrX5aa
         8IwFlTo/nCIZfp4qylu3bsEIj8FmELlr5dhesHSX58fgMZ0IO7LfMYu+3zx4aJGQlBSM
         o9RQ==
X-Gm-Message-State: AOAM531aEpvWUUbWChp6DXQgO7vkAuRNP8uBE7Xdw8EDnGiVFxuUhNlB
        uiyqOY33Zsmq93GZsZZXhTRVkm+2TS8=
X-Google-Smtp-Source: ABdhPJxoJQIQkPoWKPvovDRG7XeCntNEJv1dQdGkfLf1D7hQTTdxn/fiUeJ+sQ8maOS0Db/SRvvl6Q==
X-Received: by 2002:a17:90a:69e6:b0:1be:f28f:3bb6 with SMTP id s93-20020a17090a69e600b001bef28f3bb6mr2073810pjj.44.1646260223100;
        Wed, 02 Mar 2022 14:30:23 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id 15-20020a63174f000000b00368e62da013sm143708pgx.56.2022.03.02.14.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:30:22 -0800 (PST)
Date:   Thu, 3 Mar 2022 04:00:20 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
Message-ID: <20220302223020.3vmwknct24pplzzr@apollo.legion>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
 <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
 <20220302215640.2thsbd4blxbfd7tk@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302215640.2thsbd4blxbfd7tk@kafai-mbp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 03:26:40AM IST, Martin KaFai Lau wrote:
> On Wed, Mar 02, 2022 at 03:12:18PM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Wed, Mar 02, 2022 at 08:50:24AM IST, Martin KaFai Lau wrote:
> > > On Tue, Mar 01, 2022 at 12:27:43PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > Let's ensure that the PTR_TO_BTF_ID reg being passed in to release kfunc
> > > > always has its offset set to 0. While not a real problem now, there's a
> > > > very real possibility this will become a problem when more and more
> > > > kfuncs are exposed.
> > > >
> > > > Previous commits already protected against non-zero var_off. The case we
> > > > are concerned about now is when we have a type that can be returned by
> > > > acquire kfunc:
> > > >
> > > > struct foo {
> > > > 	int a;
> > > > 	int b;
> > > > 	struct bar b;
> > > > };
> > > >
> > > > ... and struct bar is also a type that can be returned by another
> > > > acquire kfunc.
> > > >
> > > > Then, doing the following sequence:
> > > >
> > > > 	struct foo *f = bpf_get_foo(); // acquire kfunc
> > > > 	if (!f)
> > > > 		return 0;
> > > > 	bpf_put_bar(&f->b); // release kfunc
> > > >
> > > > ... would work with the current code, since the btf_struct_ids_match
> > > > takes reg->off into account for matching pointer type with release kfunc
> > > > argument type, but would obviously be incorrect, and most likely lead to
> > > > a kernel crash. A test has been included later to prevent regressions in
> > > > this area.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  kernel/bpf/btf.c | 15 +++++++++++++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 7f6a0ae5028b..ba6845225b65 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >  		return -EINVAL;
> > > >  	}
> > > >
> > > > +	if (is_kfunc)
> > > > +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > > > +						BTF_KFUNC_TYPE_RELEASE, func_id);
> > > >  	/* check that BTF function arguments match actual types that the
> > > >  	 * verifier sees.
> > > >  	 */
> > > > @@ -5816,6 +5819,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >  							regno, reg->ref_obj_id, ref_obj_id);
> > > >  						return -EFAULT;
> > > >  					}
> > > > +					/* Ensure that offset of referenced PTR_TO_BTF_ID is
> > > > +					 * always zero, when passed to release function.
> > > > +					 * var_off has already been checked to be 0 by
> > > > +					 * check_func_arg_reg_off.
> > > > +					 */
> > > > +					if (rel && reg->off) {
> > > Here is another reg->off check for PTR_TO_BTF_ID on top of the
> > > one 'check_func_arg_reg_off' added to the same function in patch 2.
> > > A nit, I also found passing ARG_DONTCARE in patch 2 a bit convoluted
> > > considering the btf func does not need ARG_* to begin with.
> > >
> >
> > Right, arg_type doesn't really matter here (unless we start indicating in BTF we
> > want to take ringbuf allocation directly without size parameter or getting size
> > from BTF type).
> >
> > > How about directly use the __check_ptr_off_reg() here instead of
> > > check_func_arg_reg_off()?  Then patch 1 is not needed.
> > >
> > > Would something like this do the same thing (uncompiled code) ?
> > >
> >
> > I should have included a link to the previous discussion, sorry about that:
> > https://lore.kernel.org/bpf/20220223031600.pvbhu3dbwxke4eia@apollo.legion
> Ah. Thanks for the link.  I didn't go back to the list since the set is
> tagged v1 ;)
>

Right, I split the first patch out and then added this patch, so it felt more
appropriate to tag it as v1. But I will include this link in the cover letter
going forward.

> > Yes, this should also do the same thing, but the idea was to avoid keeping the
> > same checks in multiple places. For now, there is only the special case of
> > ARG_TYPE_PTR_TO_ALLOC_MEM and PTR_TO_BTF_ID that require some special handling,
> > the former of which is currently not relevant for kfunc, but adding some future
> > type and ensuring kfunc, and helper do the offset checks correctly just means
> > updating check_func_arg_reg_off.
> >
> > reg->off in case of PTR_TO_BTF_ID reg for release kfunc is a bit of a special
> > case. We should also do the same thing for BPF helpers, now that I look at it,
> > but there's only one which takes a PTR_TO_BTF_ID right now (bpf_sk_release), and
> > it isn't problematic currently, but now that referenced PTR_TO_BTF_ID is used it
> > is quite possible to support it in more BPF helpers later and forget to prevent
> > such case.
> >
> > So, it would be possible to move this check inside check_func_arg_reg_off, based
> > on a new bool is_release_func parameter, and relying on the assumption that only
> > one referenced register can be passed to helper or kfunc at a time (already
> > enforced for both BPF helpers and kfuncs).
> >
> > Basically, instead of doing type == PTR_TO_BTF_ID for fixed_off_ok inside it, we
> > will do:
> >
> > 	fixed_off_ok = false;
> > 	if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
> > 		fixed_off_ok = true;
> For the preemptive fix on release func and non zero reg->off,
> should it be a release-without-acquire error instead of a ptr-type/reg->off error?
> The fix should be either clearing the reg->ref_obj_id earlier or at least treat
> ref_obj_id as zero here and then fallthrough the existing release-without-acquire
> error.  It is more to do with the ref_obj_id becomes invalid after reg->off
> becoming non-zero instead of reg->off is not allowed for a specific ptr
> type.  It is better to separate this preemptive fix to another set.
>

So IIUC what you're saying is that once someone performs increment, we reset the
ref_obj_id to 0, then the reference state is still present so
check_reference_leak would complain, but releasing such modified register won't
work since ref_obj_id is 0 (so no ref state for that ref_obj_id).

But I think clang (or even user writing BPF ASM) would be well within its rights
to temporarily add an offset to the register, pass member pointer to some other
helper, or read some data, and then decrement it again to shift the pointer
backwards setting reg->off to 0. Then they should be able to again pass such
register to release helper or kfunc. I think it would be unlikely (you can save
original pointer to caller saved reg, or spill to stack, or use offset in LDX,
etc.) but certainly not impossible.

I think the key point is that we want to make user pass the register as it was
when it was acquired, they can do any changes to off between acquire and
release, just that it should be set back to 0 when release function is called.

> >
> > Again, given we can only pass one referenced reg, if we see release func and a
> > reg with ref_obj_id, it is the one being released.
> >
> > In the end, it's more of a preference thing, if you feel strongly about it I can
> > go with the __check_ptr_off_reg call too.
> Yeah, it is a preference thing and not feeling strongly.
> Without the need for the release-func/reg->off preemptive fix, adding
> one __check_ptr_off_reg() seems to be a cleaner fix to me but
> I won't insist.

--
Kartikeya
