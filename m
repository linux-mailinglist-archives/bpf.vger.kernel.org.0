Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A55F4D94
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 04:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJECEU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 22:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJECET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 22:04:19 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89CC6919D
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 19:04:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e205so11905063iof.1
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 19:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dFbTJ9mMzaLTkfUt2fdSX/ZWHRMxU873UEohZnTOhFI=;
        b=kWrqL/efcujb+cP45RpjWZWp21iSPG/Pe3LvNgap10ycRGrv/+KjesmBeivtIG5eNk
         9tKh5haiBd53LOW3JALouxNKBFsUWQ/ZkNZizIJYqUH1HQE0dQqNvBywn+Bo0rE0nmci
         TIkmFrDk4MF1Qyjk0azrqsS0vdn6UYbWlEME6JY7hVCi+paHbqwNUEg4pOv6yraONlQN
         0n3Hp7O7Q75QhV8qZu10kj4Rhz0+/R/39+wdzsecEcBkCrb3Nzn8H/abbbwwZjufLrX1
         cDyLT0IkpUm4ssv9axVyxqqvL0igH5EQ2pX7PPYDhBWsN48sHfWkss1Fi3Mx+892B6zG
         8E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dFbTJ9mMzaLTkfUt2fdSX/ZWHRMxU873UEohZnTOhFI=;
        b=r/Wll+WlVVA8Mrdqwb8ps0/8vN3zdU7VLRWk9kLtGpZw7QDKp07bCIuK67rKxnT5uK
         uqOkOdLYJPM4fbvqvGfpJmqsVztnBehXX7ll2G9AD7vg+MKpj6buhAO5emcjM5ogIbh5
         IK65XDudXv8U0ogAvyItbSHlbHRU9pfCpan2xBkd0K+GwnCOwyYuLdHlQ8Tp6V5RPIfD
         j3Vf+Py6tRseSCwGdJrjS4NOalN5KuzqcuLJijdCL5GjJWtqZC0PHzaLEbYoK+Sj5AdP
         GdVbrfxKjsH4T+N32gChmizSJ0bz+4lhe53BjkMzevUKmhM4sHzfS59gWNsx/hC11Ckn
         7fjg==
X-Gm-Message-State: ACrzQf3RP6KSsVmJAX/Y3dCSm3vLwQ943yz3N67GLJSBZJchXd8k+JPv
        jc7lAt7WD16h92+4NVH5Feun4TPtAjDHQuq/LqTgTKmT8q21Q4FW
X-Google-Smtp-Source: AMsMyM5mSt8CRVNyiv5cZKQYtacc8zcnHJaSxX+KDXRL6yAaREMNe4QpxVA/xAiFHPwqs+qDd8TlR2VPFwGlQqrZyz4=
X-Received: by 2002:a5d:9ac1:0:b0:6a3:1938:e6b0 with SMTP id
 x1-20020a5d9ac1000000b006a31938e6b0mr12088239ion.186.1664935457199; Tue, 04
 Oct 2022 19:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221004222725.2813510-1-sdf@google.com> <YzzQ2mI/srLNazNO@google.com>
 <CAADnVQKyqJRGYn4ty5PaL2vAUnTo0ohY1CF3k_kpc=whEbhdPA@mail.gmail.com>
In-Reply-To: <CAADnVQKyqJRGYn4ty5PaL2vAUnTo0ohY1CF3k_kpc=whEbhdPA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 4 Oct 2022 19:04:06 -0700
Message-ID: <CAKH8qBstTdOGK8GXpy_-5D_4ebuhwWSYe-tRnhdz17oDb3EcAA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: make DEBUG_INFO_BTF_MODULES selectable independently
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 4, 2022 at 6:39 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 4, 2022 at 5:33 PM <sdf@google.com> wrote:
> >
> > On 10/04, Stanislav Fomichev wrote:
> > > We're having an issue where we have a recent clang that seems
> > > to generate kind_flag for enums (aka, adding signed/unsigned).
> > > Trying to install a module on a kernel that doesn't have commit
> > > 6089fb325cf7 ("bpf: Add btf enum64 support") returns the following:
> >
> > > [    3.176954] BPF:Invalid btf_info kind_flag
> >
> > > The enum that it complains about doesn't seem to have anything special
> > > except having a sign:
> >
> > > [1721] ENUM 'perf_event_state' encoding=SIGNED size=4 vlen=6
> > >          'PERF_EVENT_STATE_DEAD' val=-4
> > >          'PERF_EVENT_STATE_EXIT' val=-3
> > >          'PERF_EVENT_STATE_ERROR' val=-2
> > >          'PERF_EVENT_STATE_OFF' val=-1
> > >          'PERF_EVENT_STATE_INACTIVE' val=0
> > >          'PERF_EVENT_STATE_ACTIVE' val=1
> >
> > > We are not currently using CONFIG_DEBUG_INFO_BTF_MODULES and
> > > don't plan to use module BTF, so it's preferable to be able
> > > to explicits disable it in the kernel config. Unfortunately,
> > > because that kconfig option doesn't have a name, it's not
> > > possible to flip it independently from CONFIG_DEBUG_INFO_BTF.
> > > Let's add a name to make sure module BTF is user-controllable.
> >
> > [..]
> >
> > > (Not sure, but maybe the right fix is to also have a stable patch
> > >   to relax that "Invalid btf_info kind_flag" check?)
> >
> > Answering to myself, looks like we do need the following for
> > non-enum64-compatible older/stable kernels:
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 3cfba41a0829..928f4955090a 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -3301,11 +3301,6 @@ static s32 btf_enum_check_meta(struct
> > btf_verifier_env *env,
> >                 return -EINVAL;
> >         }
> >
> > -       if (btf_type_kflag(t)) {
> > -               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> > -               return -EINVAL;
> > -       }
> > -
> >         if (t->size > 8 || !is_power_of_2(t->size)) {
> >                 btf_verifier_log_type(env, t, "Unexpected size");
> >                 return -EINVAL;
> >
> > Anything I'm missing? Feels like any pre-6089fb325cf7 ("bpf: Add btf
> > enum64 support") kernel will have an issue with a recent clang
> > that puts sign into kflag?
> >
> >
> > > Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
> > > and pahole supports it")
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >   lib/Kconfig.debug | 1 +
> > >   1 file changed, 1 insertion(+)
> >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index c77fe36bb3d8..6336a697c9f5 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -326,6 +326,7 @@ config PAHOLE_HAS_SPLIT_BTF
> > >       def_bool $(success, test `$(PAHOLE) --version | sed
> > > -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
> >
> > >   config DEBUG_INFO_BTF_MODULES
> > > +     bool "Generate BTF module typeinfo"
> > >       def_bool y
> > >       depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> > >       help
>
> Not quite following.
> Are you saying instead of backporting enum64 support
> to older kernels you'd prefer to add this patch to upstream
> and backport this smaller patch?

Yeah, sorry, it took me a while to build the context, I might still be
missing something.

So far it seems that disabling DEBUG_INFO_BTF_MODULES is not enough.
It looks like as long as the older kernels still have that
btf_type_kflag enum check, compiling them with a fairly recent clang
won't work?
Or do we expect those users to use pahole's --skip_encoding_btf_enum64
which seems to fallback to the old way?

I guess I'm still trying to understand whether we care about
old/stable kernels + recent llvm combination.
