Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191924CB37B
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 01:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiCCAIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiCCAIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:08:37 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECD74858
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:07:50 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id k7so2744745ilo.8
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iujg601tHIeH6JI2SX+HmwstH2QXhq9enqND6zcsXJ8=;
        b=kL8sMFNYf7WHe8mDxrIj0BIcxWywgK05GkGIlcAYqvq7MY06SIh8XFaclGn/B43sB5
         ZbTKoHl+wVQfRbvCUv8b9PEr5J3c4lqQEPwUZYzkmbOGg9EPx7B+PgGAYtyujMX9k2oU
         VE8UVsXJvk0IqCEAt5vqlCBc4ZGiWMBAlU1R70hp1F9FhJvRc9aToMGal3gcXNDQyOjq
         D1yaSCdSR3iu+hfcQWwqdB0/UjYkO4ZIzkjsXMy1unQn2D8uq68JFfRNdvGJWlofiTQ5
         nxHzPBLSw0cW+71s8jY9AvwxonCZG17Of6Agx3rr0SHh2aYa2iMwVyRh7p+M8JafrGpl
         zITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iujg601tHIeH6JI2SX+HmwstH2QXhq9enqND6zcsXJ8=;
        b=F1hqPRZrRkuTK6lfu11PEIh6AoBvfw55OBPsppzNOO5FfrEMgwUNzF/ZmSQ2julKi6
         C+2LyEmnVfBTJqOa+K72sTxwLM6d2ZXhAaUIxYuOA/ZxKxcxQ2rtfNU3QrC7q8vTqkO1
         BcWpTddsXShqkxr4A3BAj0tyBSNpLwKijjsiL4wiph/Jm4kVinV21msiWuLF607Hj8wC
         jkmtI3GIR2ryQzw1vbwMjBG63E3TJ35WoWSiI3K+JZIesBrvsJYSzQoQ4TDGzS4mhvqc
         GTryCXNsrqxeOOsJxi+c8OJmrwdGhCydj5vvWRz1MAEflUdK07yefpmOpu+siqtKMngC
         725w==
X-Gm-Message-State: AOAM531KZQODbCT8aGCjnYWRSt6KE7CStFbQQCb/UV1NX/09FsU5KKKj
        l7ejOWB51dhunjYW710uxtSMuEtVwFw=
X-Google-Smtp-Source: ABdhPJwKDlhrIZ9cEN2U07zavwxIkZdfuZymbOTyRaI6Z79AY/U++edIjg0YVFtD3ODP7LSlVLa4gA==
X-Received: by 2002:a63:c1d:0:b0:365:7d16:f648 with SMTP id b29-20020a630c1d000000b003657d16f648mr28091590pgl.517.1646262050404;
        Wed, 02 Mar 2022 15:00:50 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id t1-20020a634441000000b00372cb183243sm189626pgk.1.2022.03.02.15.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:00:50 -0800 (PST)
Date:   Thu, 3 Mar 2022 04:30:47 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
Message-ID: <20220302230047.7xjekpuivrbno5cp@apollo.legion>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
 <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
 <20220302215640.2thsbd4blxbfd7tk@kafai-mbp>
 <20220302223020.3vmwknct24pplzzr@apollo.legion>
 <20220302224418.5ph7nkzx2qmcy36n@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302224418.5ph7nkzx2qmcy36n@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 04:14:18AM IST, Alexei Starovoitov wrote:
> On Thu, Mar 03, 2022 at 04:00:20AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Thu, Mar 03, 2022 at 03:26:40AM IST, Martin KaFai Lau wrote:
> > > On Wed, Mar 02, 2022 at 03:12:18PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > On Wed, Mar 02, 2022 at 08:50:24AM IST, Martin KaFai Lau wrote:
> > > > > On Tue, Mar 01, 2022 at 12:27:43PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > > Let's ensure that the PTR_TO_BTF_ID reg being passed in to release kfunc
> > > > > > always has its offset set to 0. While not a real problem now, there's a
> > > > > > very real possibility this will become a problem when more and more
> > > > > > kfuncs are exposed.
> > > > > >
> > > > > > Previous commits already protected against non-zero var_off. The case we
> > > > > > are concerned about now is when we have a type that can be returned by
> > > > > > acquire kfunc:
> > > > > >
> > > > > > struct foo {
> > > > > > 	int a;
> > > > > > 	int b;
> > > > > > 	struct bar b;
> > > > > > };
> > > > > >
> > > > > > ... and struct bar is also a type that can be returned by another
> > > > > > acquire kfunc.
> > > > > >
> > > > > > Then, doing the following sequence:
> > > > > >
> > > > > > 	struct foo *f = bpf_get_foo(); // acquire kfunc
> > > > > > 	if (!f)
> > > > > > 		return 0;
> > > > > > 	bpf_put_bar(&f->b); // release kfunc
> > > > > >
> > > > > > ... would work with the current code, since the btf_struct_ids_match
> > > > > > takes reg->off into account for matching pointer type with release kfunc
> > > > > > argument type, but would obviously be incorrect, and most likely lead to
> > > > > > a kernel crash. A test has been included later to prevent regressions in
> > > > > > this area.
> > > > > >
> > > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > > ---
> > > > > >  kernel/bpf/btf.c | 15 +++++++++++++--
> > > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > > index 7f6a0ae5028b..ba6845225b65 100644
> > > > > > --- a/kernel/bpf/btf.c
> > > > > > +++ b/kernel/bpf/btf.c
> > > > > > @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > > > >  		return -EINVAL;
> > > > > >  	}
> > > > > >
> > > > > > +	if (is_kfunc)
> > > > > > +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > > > > > +						BTF_KFUNC_TYPE_RELEASE, func_id);
> > > > > >  	/* check that BTF function arguments match actual types that the
> > > > > >  	 * verifier sees.
> > > > > >  	 */
> > > > > > @@ -5816,6 +5819,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > > > >  							regno, reg->ref_obj_id, ref_obj_id);
> > > > > >  						return -EFAULT;
> > > > > >  					}
> > > > > > +					/* Ensure that offset of referenced PTR_TO_BTF_ID is
> > > > > > +					 * always zero, when passed to release function.
> > > > > > +					 * var_off has already been checked to be 0 by
> > > > > > +					 * check_func_arg_reg_off.
> > > > > > +					 */
> > > > > > +					if (rel && reg->off) {
> > > > > Here is another reg->off check for PTR_TO_BTF_ID on top of the
> > > > > one 'check_func_arg_reg_off' added to the same function in patch 2.
> > > > > A nit, I also found passing ARG_DONTCARE in patch 2 a bit convoluted
> > > > > considering the btf func does not need ARG_* to begin with.
> > > > >
> > > >
> > > > Right, arg_type doesn't really matter here (unless we start indicating in BTF we
> > > > want to take ringbuf allocation directly without size parameter or getting size
> > > > from BTF type).
> > > >
> > > > > How about directly use the __check_ptr_off_reg() here instead of
> > > > > check_func_arg_reg_off()?  Then patch 1 is not needed.
> > > > >
> > > > > Would something like this do the same thing (uncompiled code) ?
> > > > >
> > > >
> > > > I should have included a link to the previous discussion, sorry about that:
> > > > https://lore.kernel.org/bpf/20220223031600.pvbhu3dbwxke4eia@apollo.legion
> > > Ah. Thanks for the link.  I didn't go back to the list since the set is
> > > tagged v1 ;)
> > >
> >
> > Right, I split the first patch out and then added this patch, so it felt more
> > appropriate to tag it as v1. But I will include this link in the cover letter
> > going forward.
> >
> > > > Yes, this should also do the same thing, but the idea was to avoid keeping the
> > > > same checks in multiple places. For now, there is only the special case of
> > > > ARG_TYPE_PTR_TO_ALLOC_MEM and PTR_TO_BTF_ID that require some special handling,
> > > > the former of which is currently not relevant for kfunc, but adding some future
> > > > type and ensuring kfunc, and helper do the offset checks correctly just means
> > > > updating check_func_arg_reg_off.
> > > >
> > > > reg->off in case of PTR_TO_BTF_ID reg for release kfunc is a bit of a special
> > > > case. We should also do the same thing for BPF helpers, now that I look at it,
> > > > but there's only one which takes a PTR_TO_BTF_ID right now (bpf_sk_release), and
> > > > it isn't problematic currently, but now that referenced PTR_TO_BTF_ID is used it
> > > > is quite possible to support it in more BPF helpers later and forget to prevent
> > > > such case.
> > > >
> > > > So, it would be possible to move this check inside check_func_arg_reg_off, based
> > > > on a new bool is_release_func parameter, and relying on the assumption that only
> > > > one referenced register can be passed to helper or kfunc at a time (already
> > > > enforced for both BPF helpers and kfuncs).
> > > >
> > > > Basically, instead of doing type == PTR_TO_BTF_ID for fixed_off_ok inside it, we
> > > > will do:
> > > >
> > > > 	fixed_off_ok = false;
> > > > 	if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
> > > > 		fixed_off_ok = true;
> > > For the preemptive fix on release func and non zero reg->off,
> > > should it be a release-without-acquire error instead of a ptr-type/reg->off error?
> > > The fix should be either clearing the reg->ref_obj_id earlier or at least treat
> > > ref_obj_id as zero here and then fallthrough the existing release-without-acquire
> > > error.  It is more to do with the ref_obj_id becomes invalid after reg->off
> > > becoming non-zero instead of reg->off is not allowed for a specific ptr
> > > type.  It is better to separate this preemptive fix to another set.
> > >
> >
> > So IIUC what you're saying is that once someone performs increment, we reset the
> > ref_obj_id to 0, then the reference state is still present so
> > check_reference_leak would complain, but releasing such modified register won't
> > work since ref_obj_id is 0 (so no ref state for that ref_obj_id).
> >
> > But I think clang (or even user writing BPF ASM) would be well within its rights
> > to temporarily add an offset to the register, pass member pointer to some other
> > helper, or read some data, and then decrement it again to shift the pointer
> > backwards setting reg->off to 0. Then they should be able to again pass such
> > register to release helper or kfunc. I think it would be unlikely (you can save
> > original pointer to caller saved reg, or spill to stack, or use offset in LDX,
> > etc.) but certainly not impossible.
>
> I don't think llvm will ever do such thing. Passing into a helper means
> that the register is scratched. It won't be reused after the call.
> Saving modified into a stack to restore later just to do a math on it
> goes against "optimization" goal of the compiler.
>
> > I think the key point is that we want to make user pass the register as it was
> > when it was acquired, they can do any changes to off between acquire and
> > release, just that it should be set back to 0 when release function is called.
>
> Correct and this patch is covering that.
> I'm not sure what is the contention point here.
> Sorry I'm behind the mailing list.
>
> > > >
> > > > Again, given we can only pass one referenced reg, if we see release func and a
> > > > reg with ref_obj_id, it is the one being released.
> > > >
> > > > In the end, it's more of a preference thing, if you feel strongly about it I can
> > > > go with the __check_ptr_off_reg call too.
> > > Yeah, it is a preference thing and not feeling strongly.
> > > Without the need for the release-func/reg->off preemptive fix, adding
> > > one __check_ptr_off_reg() seems to be a cleaner fix to me but
> > > I won't insist.
>
> fwiw I like patches 1-3.
> I think extra check here for release func is justified on its own.
> Converting it into:
>   fixed_off_ok = false;
>   if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
>           fixed_off_ok = true;
> obfuscates the check to me.

I was talking of putting this inside check_func_arg_reg_off. I think we should
do the same check for BPF helpers as well (rn only one supports releasing
PTR_TO_BTF_ID, soon we may have others). Just passing a bool to
check_func_arg_reg_off to indicate we are checking for release func (helper or
kfunc have same rules here) would allow putting this check inside it.

> if (rel && reg->off) check
> is pretty obvious.

--
Kartikeya
