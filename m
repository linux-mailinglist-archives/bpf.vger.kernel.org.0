Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577DA5F6B70
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJFQUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiJFQUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 12:20:20 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F59638D
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 09:20:18 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i9so1231276ilv.9
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+fbAYDscmyrlnNvxtnZbtkbVTO3HgReSAJ0SpJ8JJw0=;
        b=RRM0bMuw7j4tI+9nfN3MM9i7eJcrZmONXrUR6ySNaGCP46fDOG/udwybtvzPVn/2mH
         nS2BoZkC0FkkX41y51OZNaLRlQrlmPrCImsvWs7mpkfHgSny9LUq8QQAqKu+wcbb0dMZ
         bBVrocVqWAcQWGOUyDM6ehXIhQvNGovW0yZrRD+Evkqg3K5zChGwZ5kBpS3XA3JV141I
         QT6Y4MIuSAT2EQt4xr199QuiA3J7RLZhOUU8VFOLkU6UoeKjh9eHyvSL7s6irX6nMjhM
         QyCoeo4/jHsAAB1WY8kdtxXDcD6NUnonsNVMwvhfoAamc0p12hbJ2p3usBBMrjDfw970
         o/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fbAYDscmyrlnNvxtnZbtkbVTO3HgReSAJ0SpJ8JJw0=;
        b=NYGIQUpZNpDoirAPJ+w0JeSsW0BaYtk1CGi3Md44nNf9JukDSVrvxZOWlQjHbqbDMh
         rplCei3HPNKlMUGy+pzGo2aco/EUrBxMtj5W454/rq9Q/IcygmNtTzKrxCa/s3O4IXPN
         vxKhrKy7UWglcvxQbkSp+AM97RO2UEMXNQk2WtGUBWVTfJGynhOyAaD5yXQqZK0CgdNs
         KwGjizlbEY5HhTvTG4bBMFWPrWWgePz4WdMv2+HMeyzJncMBmiNYwltPwl5G9NToNvPX
         TQauPpVF03T/5SeTNo4h3GvSqNJnv4WNH73mA+B/9xQWB+o7nh/dDy1aJDlG+KAjuMfb
         gIbQ==
X-Gm-Message-State: ACrzQf2X84hZEfdQ/J4uJDHkmCLBr6fAo/jI7uq+DjYmKb7RVkB4BUa7
        DQl6XrmZPcFsrpvGzKkqaku23XbfjFDwE8znwh1+vQ==
X-Google-Smtp-Source: AMsMyM43AGaOzr1f0NU7m6o79aDtAa6DztT8MAXQ+jRVyo94k7fynuDyqIwEY3aQWHzNQu9JJUjD2f+08EGPz96JeME=
X-Received: by 2002:a05:6e02:1bc9:b0:2f1:9ee8:246d with SMTP id
 x9-20020a056e021bc900b002f19ee8246dmr203117ilv.246.1665073217818; Thu, 06 Oct
 2022 09:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221004222725.2813510-1-sdf@google.com> <YzzQ2mI/srLNazNO@google.com>
 <CAADnVQKyqJRGYn4ty5PaL2vAUnTo0ohY1CF3k_kpc=whEbhdPA@mail.gmail.com>
 <CAKH8qBstTdOGK8GXpy_-5D_4ebuhwWSYe-tRnhdz17oDb3EcAA@mail.gmail.com>
 <CAEf4BzYnxD5mrYjcCHfCObQDkdMAC+3aZ1EeAoVOoyqENpk53Q@mail.gmail.com> <Yz6CB5uQISg3j9dq@krava>
In-Reply-To: <Yz6CB5uQISg3j9dq@krava>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 6 Oct 2022 09:20:06 -0700
Message-ID: <CAKH8qBu0ptKbMVvoMpgN2tyk84ZGvwuCJLjesqw-_8QtSRLqpw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: make DEBUG_INFO_BTF_MODULES selectable independently
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>
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

On Thu, Oct 6, 2022 at 12:21 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Oct 05, 2022 at 04:28:49PM -0700, Andrii Nakryiko wrote:
> > On Tue, Oct 4, 2022 at 7:04 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > On Tue, Oct 4, 2022 at 6:39 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Oct 4, 2022 at 5:33 PM <sdf@google.com> wrote:
> > > > >
> > > > > On 10/04, Stanislav Fomichev wrote:
> > > > > > We're having an issue where we have a recent clang that seems
> > > > > > to generate kind_flag for enums (aka, adding signed/unsigned).
> > > > > > Trying to install a module on a kernel that doesn't have commit
> > > > > > 6089fb325cf7 ("bpf: Add btf enum64 support") returns the following:
> > > > >
> > > > > > [    3.176954] BPF:Invalid btf_info kind_flag
> > > > >
> > > > > > The enum that it complains about doesn't seem to have anything special
> > > > > > except having a sign:
> > > > >
> > > > > > [1721] ENUM 'perf_event_state' encoding=SIGNED size=4 vlen=6
> > > > > >          'PERF_EVENT_STATE_DEAD' val=-4
> > > > > >          'PERF_EVENT_STATE_EXIT' val=-3
> > > > > >          'PERF_EVENT_STATE_ERROR' val=-2
> > > > > >          'PERF_EVENT_STATE_OFF' val=-1
> > > > > >          'PERF_EVENT_STATE_INACTIVE' val=0
> > > > > >          'PERF_EVENT_STATE_ACTIVE' val=1
> > > > >
> > > > > > We are not currently using CONFIG_DEBUG_INFO_BTF_MODULES and
> > > > > > don't plan to use module BTF, so it's preferable to be able
> > > > > > to explicits disable it in the kernel config. Unfortunately,
> > > > > > because that kconfig option doesn't have a name, it's not
> > > > > > possible to flip it independently from CONFIG_DEBUG_INFO_BTF.
> > > > > > Let's add a name to make sure module BTF is user-controllable.
> > > > >
> > > > > [..]
> > > > >
> > > > > > (Not sure, but maybe the right fix is to also have a stable patch
> > > > > >   to relax that "Invalid btf_info kind_flag" check?)
> > > > >
> > > > > Answering to myself, looks like we do need the following for
> > > > > non-enum64-compatible older/stable kernels:
> > > > >
> > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > index 3cfba41a0829..928f4955090a 100644
> > > > > --- a/kernel/bpf/btf.c
> > > > > +++ b/kernel/bpf/btf.c
> > > > > @@ -3301,11 +3301,6 @@ static s32 btf_enum_check_meta(struct
> > > > > btf_verifier_env *env,
> > > > >                 return -EINVAL;
> > > > >         }
> > > > >
> > > > > -       if (btf_type_kflag(t)) {
> > > > > -               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> > > > > -               return -EINVAL;
> > > > > -       }
> > > > > -
> > > > >         if (t->size > 8 || !is_power_of_2(t->size)) {
> > > > >                 btf_verifier_log_type(env, t, "Unexpected size");
> > > > >                 return -EINVAL;
> > > > >
> > > > > Anything I'm missing? Feels like any pre-6089fb325cf7 ("bpf: Add btf
> > > > > enum64 support") kernel will have an issue with a recent clang
> > > > > that puts sign into kflag?
> > > > >
> > > > >
> > > > > > Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
> > > > > > and pahole supports it")
> > > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > > ---
> > > > > >   lib/Kconfig.debug | 1 +
> > > > > >   1 file changed, 1 insertion(+)
> > > > >
> > > > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > > > index c77fe36bb3d8..6336a697c9f5 100644
> > > > > > --- a/lib/Kconfig.debug
> > > > > > +++ b/lib/Kconfig.debug
> > > > > > @@ -326,6 +326,7 @@ config PAHOLE_HAS_SPLIT_BTF
> > > > > >       def_bool $(success, test `$(PAHOLE) --version | sed
> > > > > > -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
> > > > >
> > > > > >   config DEBUG_INFO_BTF_MODULES
> > > > > > +     bool "Generate BTF module typeinfo"
> > > > > >       def_bool y
> > > > > >       depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> > > > > >       help
> > > >
> > > > Not quite following.
> > > > Are you saying instead of backporting enum64 support
> > > > to older kernels you'd prefer to add this patch to upstream
> > > > and backport this smaller patch?
> > >
> > > Yeah, sorry, it took me a while to build the context, I might still be
> > > missing something.
> > >
> > > So far it seems that disabling DEBUG_INFO_BTF_MODULES is not enough.
> > > It looks like as long as the older kernels still have that
> > > btf_type_kflag enum check, compiling them with a fairly recent clang
> > > won't work?
> > > Or do we expect those users to use pahole's --skip_encoding_btf_enum64
> > > which seems to fallback to the old way?
> >
> > Clang doesn't generate kernel or kernel module's BTF, so it has
> > nothing to do with this. It's pahole that needs to be told to not
> > generate kflag bit for enum on older kernels.
> > --skip_encoding_btf_enum64 is not exactly that, seems like we need
> > another flag to disable the sign bit for enum?
> >
> > cc'ed Arnaldo as well.
> >
> > >
> > > I guess I'm still trying to understand whether we care about
> > > old/stable kernels + recent llvm combination.
> >
> > I think it's similar to --skip_encoding_btf_enum64, so I'd say yes?
>
> hi,
> this seems like the issue we fixed recently where BTF with enum64 won't
> pass stable kernel verifier.. we did fix for stable 5.19 and 5.15:
>   https://lore.kernel.org/bpf/20220904131901.13025-1-jolsa@kernel.org/
>   https://lore.kernel.org/bpf/20220916171234.841556-1-yakoyoku@gmail.com/
>
> I did not do 5.10 fix as explained in here:
>   https://lore.kernel.org/bpf/YyeYUEHyR%2FnHM8NT@krava/

Oh, great, thanks for the pointer! That's what I was looking for :-)

> jirka
