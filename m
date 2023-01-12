Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C99C666BA7
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 08:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjALHfr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 02:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjALHfp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 02:35:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA6FBE06
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 23:35:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2FD2B81DAA
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1D2C433EF
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673508937;
        bh=pT6qBK3u9t5MKdx4Za6f5K02gF1ptlftc/jyzZFDmu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ddzkIcsJ4EzLxeAWx7cTC+Lg9oMa/ZmtUYpFVsNtHzv7gw2crsVS+m9Ldzcbpla97
         daVcEiJXOfCIvs7t5uts33b7EjeckUSqgsGO/ZE++fuY+53elOmM6RMZzhGMAMLLp2
         iQMeghHkGQ+xK79PtFO4hlr//yNSPTMMcnt/EPsFYTEg86EckDWD0kS3H7ErXvcUtE
         5vrjZXS12RCv+Cv0GQe1hMsbzZHOEXGLZxPYHoxdFHOtk2zxwIJ4qDfXwoojArCLbd
         sMS7zHR3Hcq9wpqfSTbClNXMFmHzeQ41ekcwMU3pzRCTbadv9xJT1Dom8ekzpYiLDo
         QtULM6OOHkddg==
Received: by mail-lf1-f52.google.com with SMTP id bf43so27198541lfb.6
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 23:35:37 -0800 (PST)
X-Gm-Message-State: AFqh2krCn1c1C4WtKhid1dbFZDm6ybyyuoBoRp5rsP769WmZQaAhhdvA
        qvVabLcsNiBeWV1EPG+Iwj3fKDeumY0SOHsAyr4=
X-Google-Smtp-Source: AMrXdXs+/oM45w9cc7qPn0MV3SXpL6mb2AeehbfQhdkUdztczN+bBnQI30v2yC2BzrYcVOaTZWq8DaoyJKrHsQQE84Q=
X-Received: by 2002:a05:6512:1395:b0:4b5:b46b:17c7 with SMTP id
 p21-20020a056512139500b004b5b46b17c7mr8007816lfa.215.1673508935200; Wed, 11
 Jan 2023 23:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
 <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com>
 <Y7YQHC4FgYuLWmab@maniforge.lan> <CAEf4BzaJ4h4o+nrApBPABZ8zu-f+TpuV4FUvEfHsrLRsu1bObw@mail.gmail.com>
 <20230106025420.6xdhhjsknhdhbu3d@MacBook-Pro-6.local> <CAEf4BzZTYcGNVWL7gSPHCqao_Ehx_3P7YK6r+p_-hrvpE8fEvA@mail.gmail.com>
 <CAPhsuW4ix_Q_nBSMnOzQr3GJAozN0PUcgh2K=4mcYpUXQDTYYg@mail.gmail.com> <CAADnVQJOrxwMJMrb8EmvsVbhwWF3HGAxR95BUi1WjoTxbrGOHg@mail.gmail.com>
In-Reply-To: <CAADnVQJOrxwMJMrb8EmvsVbhwWF3HGAxR95BUi1WjoTxbrGOHg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 11 Jan 2023 23:35:22 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4D=HM7pnDDYA0nOUz8oBqoxwgui0TVOib69rgc3V3Txw@mail.gmail.com>
Message-ID: <CAPhsuW4D=HM7pnDDYA0nOUz8oBqoxwgui0TVOib69rgc3V3Txw@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 8:24 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
[...]

> >
> > 1. Do we want stable kfuncs (as stable as helpers)? Do we want
> >    almost stable kfuncs?
>
> Yes. We've touched on some of that earlier.
> We can talk about a range:
> unstable, deprecated, starting to deprecate, stable
> plus orthogonal versioning scheme.
>
> > Will most users of stable APIs be as happy
> >    with almost stable alternatives?
>
> kfuncs are very much analogous to EXPORT_SYMBOL_GPL.
> There is no versioning scheme, nor deprecation scheme for that.
> Yet in-kernel and out-of-tree users have been dealing with it.
> There are kABI things that make things stable to various degrees.
> So 'happy' is relative.
> Using that analogy...
> In-kernel bpf progs won't care. unstable or not they will get
> carried along automatically when kfuncs change.
> Out of tree bpf progs can be divided to kernel dependent
> and kernel independent. The former are similar to in-tree
> with extra pain that can be mitigated with kfunc detection.
> The latter will always use stable with understandable deprecation path.
> Yet it's all in theory.
> In practice networking folks are using conntrack kfuncs and
> xfrm kfuncs assuming we will make it all work somehow,
> though right now we're saying kfuncs are unstable only.

I think we need something more stable than EXPORT_SYMBOL_GPL,
because: 1) there are more OOT bpf progs than OOT drivers;
2) some BPF developers (network people in KP's categories)
have less kernel experience, and thus have a stronger
preference for more stable APIs. The range of stability on top
of EXPORT_SYMBOL_GPL could be really helpful for these
users.

>
> So 'happy' and 'pain' are relative depending on the usefulness
> of kfunc. If bpf prog needs a feature it will use it.
> If it's a shiny new feature, the prog authors might wait
> until kfunc stabilizes.
> Which is exactly the point.
> We can wish for something to be useful, but we won't know
> until we actually use it for real and not in some selftest.
>
> And it becomes chicken and egg. If it's a cool new feature
> the bpf prog wants it to be stable to rely on it later,
> but because it's so new it's not clear whether it's actually useful,
> so we shouldn't be declaring it stable and cause kernel pains.
>
> > 2. Do we decide the stability of a kfunc when it is first added? Or
> >     do we plan to promote (maybe also demote?) stability later?
>
> Claiming that something is stable on day one
> is a subjective opinion of the developer who's adding that feature.
> There could even be a giant user space project next to it
> attempting to use that feature, but we've seen that with other
> uapi-s in the past.

With the range of stability, stable could mean "not going away for
at least 5 years". Then claiming something is stable means "I/we
will support it for at least 5 years". It is probably not too crazy to
make this type of promises for some core APIs.

>
> > 3. Besides stability, what are the concerns with kfuncs? How hard
> >     is it to resolve them?
> >     AFAICT, the concerns are: require BTF, require trampoline.
>
> Only the former. kfuncs do not require bpf trampoline.
>
> $ git grep bpf_jit_supports_kfunc_call
> arch/arm64/net/bpf_jit_comp.c:bool bpf_jit_supports_kfunc_call(void)
> arch/loongarch/net/bpf_jit.c:bool bpf_jit_supports_kfunc_call(void)
> arch/x86/net/bpf_jit_comp.c:bool bpf_jit_supports_kfunc_call(void)
> arch/x86/net/bpf_jit_comp32.c:bool bpf_jit_supports_kfunc_call(void)
>
> iirc I've seen the patches for risc-v and arm32.

Thanks for the correction. Reading commits that enabled kfunc for
different archs, I think it is easier than enabling trampolines.

AFAICT, more stability of some kfuncs and better availability of
kfuncs should address most of the concerns. I would like to hear
Andrii's thoughts on this.

Thanks,
Song

>
> >     Anything else? I guess we will never remove BTF dependency.
> >     Trampoline dependency is hard to resolve, but still possible?
> >
> > 4. We have feature-rich BPF with Linux-x86_64. Do we need some
> >    bare-minimal BPF, say for Linux-MIPS, or Windows-ARM, or
> >    even nvme-something? I guess this is also related to the BPF
> >    standard?
>
> It's not related to ISA standardization.
> We're not even talking about BTF standardization.
> Nor about psABI (calling convention and such).
> It's going to happen much much later.
