Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBF5F5D37
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 01:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJEX3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 19:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJEX3E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 19:29:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A285A9F
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 16:29:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id l22so557536edj.5
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w0yT2Mnv2tj0pUclF9eWQkVJxIBkoOII71s3ozr1a4E=;
        b=dJNxlUfD5FHVsjZG3wYLrBjwHaw14/73eyL78jpRFzcQvaywQ2RAeCrmx/4BrzkTZ2
         C+c+n/Cw4o8PJY6kgUfkGpUvDMbxbWEZiM6JtukwZLNAgnVJ20shHSfAK3kupBx/44yO
         DfoaFWSM6fD9sno+8WRPvgoIKUay472oaGAE0WU+tbWLyROKA3Nj5ZxNlWetj/7ERTK/
         wSLXta3m5YfWKsU0r74QbmwRVoUQyH/h5+yjpQ2f1Nvl7g5a1IPCuEknfsFIJEGnqc6m
         BODzPmCj+AS4Ktj7JCNAopyfUsvZDt+3J39jrSUSPJiqkX8GZEGolMeUggHEDkGXx3Tu
         vnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0yT2Mnv2tj0pUclF9eWQkVJxIBkoOII71s3ozr1a4E=;
        b=fL32UyaHeWQWFViXO8/E1EsqmUVcc6rQB56WV/m7jiehM+qCFzw+yBhOZBKTm5CKRL
         1gI94MMvY775bT5CDV+rzx3qYDyP6o9WMU2581YNtIKAG2wf/vPka/rOt1atemdEHBGw
         mxa2G8PSTqju8SoT+nOGFeLnr4nLdJODdhaB/O2JPXPw00Sx8foFL+mfbmTvZmQIF85V
         U3ldhBf+Zv0/jobWLZYidHk/dNCA4qijbpWuzosa6xgo23sD25ih5obfTa5fQpb2Vs1j
         8CB/9cLclYHZWj+Kw4JXA6rlD1dCL20ZoVCLRGD1Kjdc1EeU86J7E5+HKl6sv1I6cUgn
         A93Q==
X-Gm-Message-State: ACrzQf1/tG7BWj1vHcCzy0Lu6D5aGzNb8GyacvF/h5RCtxN8NFzZv3J0
        KW0Tk+8OwC9UCRlaWuwHMmz0GWAyTPFUCVUAhneyDJRGiL8=
X-Google-Smtp-Source: AMsMyM4Y7Ju8YJ+yt4+wIAg24+p5Zw0q/Ke+qZcn8zLc+gZhhQ9Rsw5ad49GH8NHqF/tYffSwCJTlD2gcRiuJ3vO9ME=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr1955309edv.232.1665012542051; Wed, 05
 Oct 2022 16:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221004222725.2813510-1-sdf@google.com> <YzzQ2mI/srLNazNO@google.com>
 <CAADnVQKyqJRGYn4ty5PaL2vAUnTo0ohY1CF3k_kpc=whEbhdPA@mail.gmail.com> <CAKH8qBstTdOGK8GXpy_-5D_4ebuhwWSYe-tRnhdz17oDb3EcAA@mail.gmail.com>
In-Reply-To: <CAKH8qBstTdOGK8GXpy_-5D_4ebuhwWSYe-tRnhdz17oDb3EcAA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 16:28:49 -0700
Message-ID: <CAEf4BzYnxD5mrYjcCHfCObQDkdMAC+3aZ1EeAoVOoyqENpk53Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: make DEBUG_INFO_BTF_MODULES selectable independently
To:     Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 4, 2022 at 7:04 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Oct 4, 2022 at 6:39 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 4, 2022 at 5:33 PM <sdf@google.com> wrote:
> > >
> > > On 10/04, Stanislav Fomichev wrote:
> > > > We're having an issue where we have a recent clang that seems
> > > > to generate kind_flag for enums (aka, adding signed/unsigned).
> > > > Trying to install a module on a kernel that doesn't have commit
> > > > 6089fb325cf7 ("bpf: Add btf enum64 support") returns the following:
> > >
> > > > [    3.176954] BPF:Invalid btf_info kind_flag
> > >
> > > > The enum that it complains about doesn't seem to have anything special
> > > > except having a sign:
> > >
> > > > [1721] ENUM 'perf_event_state' encoding=SIGNED size=4 vlen=6
> > > >          'PERF_EVENT_STATE_DEAD' val=-4
> > > >          'PERF_EVENT_STATE_EXIT' val=-3
> > > >          'PERF_EVENT_STATE_ERROR' val=-2
> > > >          'PERF_EVENT_STATE_OFF' val=-1
> > > >          'PERF_EVENT_STATE_INACTIVE' val=0
> > > >          'PERF_EVENT_STATE_ACTIVE' val=1
> > >
> > > > We are not currently using CONFIG_DEBUG_INFO_BTF_MODULES and
> > > > don't plan to use module BTF, so it's preferable to be able
> > > > to explicits disable it in the kernel config. Unfortunately,
> > > > because that kconfig option doesn't have a name, it's not
> > > > possible to flip it independently from CONFIG_DEBUG_INFO_BTF.
> > > > Let's add a name to make sure module BTF is user-controllable.
> > >
> > > [..]
> > >
> > > > (Not sure, but maybe the right fix is to also have a stable patch
> > > >   to relax that "Invalid btf_info kind_flag" check?)
> > >
> > > Answering to myself, looks like we do need the following for
> > > non-enum64-compatible older/stable kernels:
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 3cfba41a0829..928f4955090a 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -3301,11 +3301,6 @@ static s32 btf_enum_check_meta(struct
> > > btf_verifier_env *env,
> > >                 return -EINVAL;
> > >         }
> > >
> > > -       if (btf_type_kflag(t)) {
> > > -               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> > > -               return -EINVAL;
> > > -       }
> > > -
> > >         if (t->size > 8 || !is_power_of_2(t->size)) {
> > >                 btf_verifier_log_type(env, t, "Unexpected size");
> > >                 return -EINVAL;
> > >
> > > Anything I'm missing? Feels like any pre-6089fb325cf7 ("bpf: Add btf
> > > enum64 support") kernel will have an issue with a recent clang
> > > that puts sign into kflag?
> > >
> > >
> > > > Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
> > > > and pahole supports it")
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >   lib/Kconfig.debug | 1 +
> > > >   1 file changed, 1 insertion(+)
> > >
> > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > index c77fe36bb3d8..6336a697c9f5 100644
> > > > --- a/lib/Kconfig.debug
> > > > +++ b/lib/Kconfig.debug
> > > > @@ -326,6 +326,7 @@ config PAHOLE_HAS_SPLIT_BTF
> > > >       def_bool $(success, test `$(PAHOLE) --version | sed
> > > > -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
> > >
> > > >   config DEBUG_INFO_BTF_MODULES
> > > > +     bool "Generate BTF module typeinfo"
> > > >       def_bool y
> > > >       depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> > > >       help
> >
> > Not quite following.
> > Are you saying instead of backporting enum64 support
> > to older kernels you'd prefer to add this patch to upstream
> > and backport this smaller patch?
>
> Yeah, sorry, it took me a while to build the context, I might still be
> missing something.
>
> So far it seems that disabling DEBUG_INFO_BTF_MODULES is not enough.
> It looks like as long as the older kernels still have that
> btf_type_kflag enum check, compiling them with a fairly recent clang
> won't work?
> Or do we expect those users to use pahole's --skip_encoding_btf_enum64
> which seems to fallback to the old way?

Clang doesn't generate kernel or kernel module's BTF, so it has
nothing to do with this. It's pahole that needs to be told to not
generate kflag bit for enum on older kernels.
--skip_encoding_btf_enum64 is not exactly that, seems like we need
another flag to disable the sign bit for enum?

cc'ed Arnaldo as well.

>
> I guess I'm still trying to understand whether we care about
> old/stable kernels + recent llvm combination.

I think it's similar to --skip_encoding_btf_enum64, so I'd say yes?
