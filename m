Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7AF5F6198
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 09:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJFHVu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 03:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJFHVt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 03:21:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F6543CF
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 00:21:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bu30so1238065wrb.8
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 00:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OoEjEw/R1mtrfdhOSFjNCEyqH6r1bV20ETpjyEKlQu4=;
        b=bF8ewHJEwDpwlumyf+sPAtY4u1bE+IioOa8/fKyeu5dXg8oDIiRnqcJU3KZbFjRE95
         K0yLI/bN7lhyCPyfhxbsEl9tXcmH1KmrGAVdeXtpiW5i7UwZnXQcruxwd3mdeQ1Yf9JG
         Hf/M3EYhKY76/kInh5DvoZ0gPlc6QhEFul7B/H35jCDxdYZS4rM7lzHeQDVNHh303115
         0PhVTxzospCYMb3BrYe+exS/uOjMYx04DCtsz6/2MEFO1CrYp8YV0LA/IrAn8hCzDgGA
         GYuoRF9Nlzt8GhKsNfjhURt5+ErRgWdCSK0iZjkZMvUgo2P5tvXx+TwOjcOg4PeJLyTa
         CGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoEjEw/R1mtrfdhOSFjNCEyqH6r1bV20ETpjyEKlQu4=;
        b=TKIEE5McJZR3St6Xx8NI2CUToZyDSjyOMiW1wpQV73BAZQVrBF7GWgMaB1gs/Ulg2u
         dYE/nJttgYSpUlnZ+9192RwhZD1+VKOcVY5DwwXZrafyHKWEqOyI5Ba1cfLhnb5e0NzS
         A1zt/xmlhofmXMQjBtGWSQ5bpa//AZE9njU5hdJUtadOltfAZ1cPClTJVKXvjsMUtuhm
         x8GyX3Ybhx/326kiKJRAYOeDYTIRHV8H+5jLg/C8Dt6bmylEWnpxhqREM90hX0egh38V
         kFSqgAMbcbBII9PSg/aA/skPNQMm0dFi2rXOLjJdcwG+530K5itvTdzcZtxUl5dHfZu/
         5q3w==
X-Gm-Message-State: ACrzQf2ulPEtJZm491XUAwdKu5UGOWJGHBqSEniq6ud4xcQYRM7yobEg
        Iqlm8aLTTKbcDNVutYNKmoA=
X-Google-Smtp-Source: AMsMyM49tKNLmLkayIGcHpok1b7qX8iT1wj7uH2pT8ad1sp/YXn1AXwPWbDRBU5KZxbsrGeP8N0wrg==
X-Received: by 2002:a05:6000:15ce:b0:226:f2ab:516d with SMTP id y14-20020a05600015ce00b00226f2ab516dmr2077032wry.264.1665040906657;
        Thu, 06 Oct 2022 00:21:46 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm4749603wmg.29.2022.10.06.00.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:21:46 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 09:21:43 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: make DEBUG_INFO_BTF_MODULES selectable
 independently
Message-ID: <Yz6CB5uQISg3j9dq@krava>
References: <20221004222725.2813510-1-sdf@google.com>
 <YzzQ2mI/srLNazNO@google.com>
 <CAADnVQKyqJRGYn4ty5PaL2vAUnTo0ohY1CF3k_kpc=whEbhdPA@mail.gmail.com>
 <CAKH8qBstTdOGK8GXpy_-5D_4ebuhwWSYe-tRnhdz17oDb3EcAA@mail.gmail.com>
 <CAEf4BzYnxD5mrYjcCHfCObQDkdMAC+3aZ1EeAoVOoyqENpk53Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYnxD5mrYjcCHfCObQDkdMAC+3aZ1EeAoVOoyqENpk53Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 04:28:49PM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 4, 2022 at 7:04 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Tue, Oct 4, 2022 at 6:39 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Oct 4, 2022 at 5:33 PM <sdf@google.com> wrote:
> > > >
> > > > On 10/04, Stanislav Fomichev wrote:
> > > > > We're having an issue where we have a recent clang that seems
> > > > > to generate kind_flag for enums (aka, adding signed/unsigned).
> > > > > Trying to install a module on a kernel that doesn't have commit
> > > > > 6089fb325cf7 ("bpf: Add btf enum64 support") returns the following:
> > > >
> > > > > [    3.176954] BPF:Invalid btf_info kind_flag
> > > >
> > > > > The enum that it complains about doesn't seem to have anything special
> > > > > except having a sign:
> > > >
> > > > > [1721] ENUM 'perf_event_state' encoding=SIGNED size=4 vlen=6
> > > > >          'PERF_EVENT_STATE_DEAD' val=-4
> > > > >          'PERF_EVENT_STATE_EXIT' val=-3
> > > > >          'PERF_EVENT_STATE_ERROR' val=-2
> > > > >          'PERF_EVENT_STATE_OFF' val=-1
> > > > >          'PERF_EVENT_STATE_INACTIVE' val=0
> > > > >          'PERF_EVENT_STATE_ACTIVE' val=1
> > > >
> > > > > We are not currently using CONFIG_DEBUG_INFO_BTF_MODULES and
> > > > > don't plan to use module BTF, so it's preferable to be able
> > > > > to explicits disable it in the kernel config. Unfortunately,
> > > > > because that kconfig option doesn't have a name, it's not
> > > > > possible to flip it independently from CONFIG_DEBUG_INFO_BTF.
> > > > > Let's add a name to make sure module BTF is user-controllable.
> > > >
> > > > [..]
> > > >
> > > > > (Not sure, but maybe the right fix is to also have a stable patch
> > > > >   to relax that "Invalid btf_info kind_flag" check?)
> > > >
> > > > Answering to myself, looks like we do need the following for
> > > > non-enum64-compatible older/stable kernels:
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 3cfba41a0829..928f4955090a 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -3301,11 +3301,6 @@ static s32 btf_enum_check_meta(struct
> > > > btf_verifier_env *env,
> > > >                 return -EINVAL;
> > > >         }
> > > >
> > > > -       if (btf_type_kflag(t)) {
> > > > -               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> > > > -               return -EINVAL;
> > > > -       }
> > > > -
> > > >         if (t->size > 8 || !is_power_of_2(t->size)) {
> > > >                 btf_verifier_log_type(env, t, "Unexpected size");
> > > >                 return -EINVAL;
> > > >
> > > > Anything I'm missing? Feels like any pre-6089fb325cf7 ("bpf: Add btf
> > > > enum64 support") kernel will have an issue with a recent clang
> > > > that puts sign into kflag?
> > > >
> > > >
> > > > > Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
> > > > > and pahole supports it")
> > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > ---
> > > > >   lib/Kconfig.debug | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > >
> > > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > > index c77fe36bb3d8..6336a697c9f5 100644
> > > > > --- a/lib/Kconfig.debug
> > > > > +++ b/lib/Kconfig.debug
> > > > > @@ -326,6 +326,7 @@ config PAHOLE_HAS_SPLIT_BTF
> > > > >       def_bool $(success, test `$(PAHOLE) --version | sed
> > > > > -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
> > > >
> > > > >   config DEBUG_INFO_BTF_MODULES
> > > > > +     bool "Generate BTF module typeinfo"
> > > > >       def_bool y
> > > > >       depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> > > > >       help
> > >
> > > Not quite following.
> > > Are you saying instead of backporting enum64 support
> > > to older kernels you'd prefer to add this patch to upstream
> > > and backport this smaller patch?
> >
> > Yeah, sorry, it took me a while to build the context, I might still be
> > missing something.
> >
> > So far it seems that disabling DEBUG_INFO_BTF_MODULES is not enough.
> > It looks like as long as the older kernels still have that
> > btf_type_kflag enum check, compiling them with a fairly recent clang
> > won't work?
> > Or do we expect those users to use pahole's --skip_encoding_btf_enum64
> > which seems to fallback to the old way?
> 
> Clang doesn't generate kernel or kernel module's BTF, so it has
> nothing to do with this. It's pahole that needs to be told to not
> generate kflag bit for enum on older kernels.
> --skip_encoding_btf_enum64 is not exactly that, seems like we need
> another flag to disable the sign bit for enum?
> 
> cc'ed Arnaldo as well.
> 
> >
> > I guess I'm still trying to understand whether we care about
> > old/stable kernels + recent llvm combination.
> 
> I think it's similar to --skip_encoding_btf_enum64, so I'd say yes?

hi,
this seems like the issue we fixed recently where BTF with enum64 won't
pass stable kernel verifier.. we did fix for stable 5.19 and 5.15:
  https://lore.kernel.org/bpf/20220904131901.13025-1-jolsa@kernel.org/
  https://lore.kernel.org/bpf/20220916171234.841556-1-yakoyoku@gmail.com/

I did not do 5.10 fix as explained in here:
  https://lore.kernel.org/bpf/YyeYUEHyR%2FnHM8NT@krava/

jirka
