Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F1B4CB26F
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 23:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiCBWpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 17:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCBWpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 17:45:07 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D911AA35
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 14:44:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso2693192pjq.1
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OaO1C0A4RZhi03jLNSxHuTDNX8GQ/eMEG0fY/WrHb+M=;
        b=MNG1Ks8osFyWJTPwiVxi+tD60/qdUaKjNAP8JHI3YsL0UG69XBtNRPhRitmUcZGzk8
         0r77FnQ2bNrpViSwUMaQgFV5c87jkemVhQsk/RmjFR5c3UAVBseuc2hDrMFxUFzia+Ra
         t9ohVgz37vDlNbWAkCWbfZ9nzyfJyN2+ceiromb5L1WRriVeWaJW8xWam1cNWm/ztxbE
         akGp9fBDA8ec558PIW2hrsPOv4bmOXPv6K/69/wChTubzAYE8l5GlQrpvm/oHEtHWkYu
         EH/68TxCgdwN2hnM6OY90zJx4DpdSgWPx6wqXN1P+tBTxwZVSaPw6wjnVNGMQwOoPrgu
         IoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OaO1C0A4RZhi03jLNSxHuTDNX8GQ/eMEG0fY/WrHb+M=;
        b=X2I0NvjtOiHsMWzmgrahZ7dkIqA7ckOJDijkM+FB5c3vhDSbs3+O9S2RmyHrj7r84R
         96N00xgs5Ymbm6KQOhLtSETsOHZZGyS63H4WJUgrcm4H86iURnIlnUBxgEW1H123lN1y
         f0nJuIzEHca0CqaHg2PGnbobqA4k9jaEQqCX9u+CH/T5tJqYR/CszMa/J1YvDpWp02Ve
         arRBCbgo6i+DIc7aGSwCVo2Tf0cmItvq8R4fZZE80KGld2B2LFzsWVUL8RDKkm5o0SV6
         g258fM64VW42RmjklExaBkSBfNdcZgaV7j3rwe4Hf0CIhTiq8SfQqx7LURVWTtfL70Ik
         6evw==
X-Gm-Message-State: AOAM53058y6v/zqJg2AyhNwVbzzvOGVxGuyJZAscmoMeCIOrPzNYILYE
        jEaNTsRMYL5ObN/yw2FWcrVBfJfpfc4=
X-Google-Smtp-Source: ABdhPJz/SztYfESW6PZFHbS6aUPLY2ETCM/5PteB/K2GaClzAqyUscB49kg8e73vcPwMKeb/PBppmA==
X-Received: by 2002:a17:90a:7885:b0:1be:d757:fa73 with SMTP id x5-20020a17090a788500b001bed757fa73mr2058265pjk.169.1646261060320;
        Wed, 02 Mar 2022 14:44:20 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:156b])
        by smtp.gmail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm163876pgp.15.2022.03.02.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:44:19 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:44:18 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
Message-ID: <20220302224418.5ph7nkzx2qmcy36n@ast-mbp.dhcp.thefacebook.com>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
 <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
 <20220302215640.2thsbd4blxbfd7tk@kafai-mbp>
 <20220302223020.3vmwknct24pplzzr@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302223020.3vmwknct24pplzzr@apollo.legion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 04:00:20AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Thu, Mar 03, 2022 at 03:26:40AM IST, Martin KaFai Lau wrote:
> > On Wed, Mar 02, 2022 at 03:12:18PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Wed, Mar 02, 2022 at 08:50:24AM IST, Martin KaFai Lau wrote:
> > > > On Tue, Mar 01, 2022 at 12:27:43PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > Let's ensure that the PTR_TO_BTF_ID reg being passed in to release kfunc
> > > > > always has its offset set to 0. While not a real problem now, there's a
> > > > > very real possibility this will become a problem when more and more
> > > > > kfuncs are exposed.
> > > > >
> > > > > Previous commits already protected against non-zero var_off. The case we
> > > > > are concerned about now is when we have a type that can be returned by
> > > > > acquire kfunc:
> > > > >
> > > > > struct foo {
> > > > > 	int a;
> > > > > 	int b;
> > > > > 	struct bar b;
> > > > > };
> > > > >
> > > > > ... and struct bar is also a type that can be returned by another
> > > > > acquire kfunc.
> > > > >
> > > > > Then, doing the following sequence:
> > > > >
> > > > > 	struct foo *f = bpf_get_foo(); // acquire kfunc
> > > > > 	if (!f)
> > > > > 		return 0;
> > > > > 	bpf_put_bar(&f->b); // release kfunc
> > > > >
> > > > > ... would work with the current code, since the btf_struct_ids_match
> > > > > takes reg->off into account for matching pointer type with release kfunc
> > > > > argument type, but would obviously be incorrect, and most likely lead to
> > > > > a kernel crash. A test has been included later to prevent regressions in
> > > > > this area.
> > > > >
> > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/btf.c | 15 +++++++++++++--
> > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > index 7f6a0ae5028b..ba6845225b65 100644
> > > > > --- a/kernel/bpf/btf.c
> > > > > +++ b/kernel/bpf/btf.c
> > > > > @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > >
> > > > > +	if (is_kfunc)
> > > > > +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > > > > +						BTF_KFUNC_TYPE_RELEASE, func_id);
> > > > >  	/* check that BTF function arguments match actual types that the
> > > > >  	 * verifier sees.
> > > > >  	 */
> > > > > @@ -5816,6 +5819,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > > >  							regno, reg->ref_obj_id, ref_obj_id);
> > > > >  						return -EFAULT;
> > > > >  					}
> > > > > +					/* Ensure that offset of referenced PTR_TO_BTF_ID is
> > > > > +					 * always zero, when passed to release function.
> > > > > +					 * var_off has already been checked to be 0 by
> > > > > +					 * check_func_arg_reg_off.
> > > > > +					 */
> > > > > +					if (rel && reg->off) {
> > > > Here is another reg->off check for PTR_TO_BTF_ID on top of the
> > > > one 'check_func_arg_reg_off' added to the same function in patch 2.
> > > > A nit, I also found passing ARG_DONTCARE in patch 2 a bit convoluted
> > > > considering the btf func does not need ARG_* to begin with.
> > > >
> > >
> > > Right, arg_type doesn't really matter here (unless we start indicating in BTF we
> > > want to take ringbuf allocation directly without size parameter or getting size
> > > from BTF type).
> > >
> > > > How about directly use the __check_ptr_off_reg() here instead of
> > > > check_func_arg_reg_off()?  Then patch 1 is not needed.
> > > >
> > > > Would something like this do the same thing (uncompiled code) ?
> > > >
> > >
> > > I should have included a link to the previous discussion, sorry about that:
> > > https://lore.kernel.org/bpf/20220223031600.pvbhu3dbwxke4eia@apollo.legion
> > Ah. Thanks for the link.  I didn't go back to the list since the set is
> > tagged v1 ;)
> >
> 
> Right, I split the first patch out and then added this patch, so it felt more
> appropriate to tag it as v1. But I will include this link in the cover letter
> going forward.
> 
> > > Yes, this should also do the same thing, but the idea was to avoid keeping the
> > > same checks in multiple places. For now, there is only the special case of
> > > ARG_TYPE_PTR_TO_ALLOC_MEM and PTR_TO_BTF_ID that require some special handling,
> > > the former of which is currently not relevant for kfunc, but adding some future
> > > type and ensuring kfunc, and helper do the offset checks correctly just means
> > > updating check_func_arg_reg_off.
> > >
> > > reg->off in case of PTR_TO_BTF_ID reg for release kfunc is a bit of a special
> > > case. We should also do the same thing for BPF helpers, now that I look at it,
> > > but there's only one which takes a PTR_TO_BTF_ID right now (bpf_sk_release), and
> > > it isn't problematic currently, but now that referenced PTR_TO_BTF_ID is used it
> > > is quite possible to support it in more BPF helpers later and forget to prevent
> > > such case.
> > >
> > > So, it would be possible to move this check inside check_func_arg_reg_off, based
> > > on a new bool is_release_func parameter, and relying on the assumption that only
> > > one referenced register can be passed to helper or kfunc at a time (already
> > > enforced for both BPF helpers and kfuncs).
> > >
> > > Basically, instead of doing type == PTR_TO_BTF_ID for fixed_off_ok inside it, we
> > > will do:
> > >
> > > 	fixed_off_ok = false;
> > > 	if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
> > > 		fixed_off_ok = true;
> > For the preemptive fix on release func and non zero reg->off,
> > should it be a release-without-acquire error instead of a ptr-type/reg->off error?
> > The fix should be either clearing the reg->ref_obj_id earlier or at least treat
> > ref_obj_id as zero here and then fallthrough the existing release-without-acquire
> > error.  It is more to do with the ref_obj_id becomes invalid after reg->off
> > becoming non-zero instead of reg->off is not allowed for a specific ptr
> > type.  It is better to separate this preemptive fix to another set.
> >
> 
> So IIUC what you're saying is that once someone performs increment, we reset the
> ref_obj_id to 0, then the reference state is still present so
> check_reference_leak would complain, but releasing such modified register won't
> work since ref_obj_id is 0 (so no ref state for that ref_obj_id).
> 
> But I think clang (or even user writing BPF ASM) would be well within its rights
> to temporarily add an offset to the register, pass member pointer to some other
> helper, or read some data, and then decrement it again to shift the pointer
> backwards setting reg->off to 0. Then they should be able to again pass such
> register to release helper or kfunc. I think it would be unlikely (you can save
> original pointer to caller saved reg, or spill to stack, or use offset in LDX,
> etc.) but certainly not impossible.

I don't think llvm will ever do such thing. Passing into a helper means
that the register is scratched. It won't be reused after the call.
Saving modified into a stack to restore later just to do a math on it
goes against "optimization" goal of the compiler.

> I think the key point is that we want to make user pass the register as it was
> when it was acquired, they can do any changes to off between acquire and
> release, just that it should be set back to 0 when release function is called.

Correct and this patch is covering that.
I'm not sure what is the contention point here.
Sorry I'm behind the mailing list.

> > >
> > > Again, given we can only pass one referenced reg, if we see release func and a
> > > reg with ref_obj_id, it is the one being released.
> > >
> > > In the end, it's more of a preference thing, if you feel strongly about it I can
> > > go with the __check_ptr_off_reg call too.
> > Yeah, it is a preference thing and not feeling strongly.
> > Without the need for the release-func/reg->off preemptive fix, adding
> > one __check_ptr_off_reg() seems to be a cleaner fix to me but
> > I won't insist.

fwiw I like patches 1-3.
I think extra check here for release func is justified on its own.
Converting it into:
  fixed_off_ok = false;
  if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
          fixed_off_ok = true;
obfuscates the check to me.
if (rel && reg->off) check
is pretty obvious.
