Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19D5F4D70
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 03:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJEBjx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 21:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJEBjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 21:39:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB82BE5
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 18:39:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l22so19657487edj.5
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 18:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IamKvobUld+SgUUUefkz4nRzVxmjol43Hcv1igaaVG4=;
        b=etxWcQRX3fY3rBRxrP4+FLpbL2iB4YJm7tz30YsuR/FNVlsG0WVA3KkB6SaknlqOB7
         4VDi/WDrolvtLyOIbRzTfn74lob079SImqsZHdF9RTA4TjONPJxMhQ7877ftyUKiA6Tn
         Gl1+LpxqKgq07XNOBQJyPz2+MkU0X75xMpe4/ZrR4oIeSqXzn3SDZlkyDGGZNsq1/HY7
         htAbHvIak3E0kOSfSrYmeFyQpH3mjIjcX/YZl6PXrtJVXQ1VyuxvzxmVBWbg/kqfpQ2Y
         9E2J0B5NWXx5jD7z1In/XPZ5XzzGOI4EI+dVqcq04iJI3MidKp6VKhVagM1ObQ7xQ10f
         hmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IamKvobUld+SgUUUefkz4nRzVxmjol43Hcv1igaaVG4=;
        b=5ezluz/2W8iX09CRMwmX9GMU5VjhXU6Fu+YIIHo9PTU5HpsqWiqGwZWr0JLNcirfoJ
         2tE/TsAstRzHGbfBBC71chTr8x8hQ8TOBLYDpjnyaKSuY91DldgATKbIjMXdi4AAnnzM
         Cro2I8N8ujl07QjvkIZAlkQ9Az4hf6VO8iEbVZj6daFHRq0dOckbWqYERDN248emd8yJ
         KLQM679wke8GIhAQLr1mRIQPQCPYRt4zCFbWWGQsJg8+QQLGpScO9ZbtVxgb3q8cPYZZ
         ptk+UNQ4mVRZt4Y+n8P9sPem8p/3KhwTeRfzd5iP2C+OvM0y7KAXX3pKyW7Ssy8Tyz0q
         KDlg==
X-Gm-Message-State: ACrzQf0A187CXkkzLjiStpu6HyXqrJ0jFMErcZJ+E9EmSv8Wl3gzU618
        fTcHx1U2QHPXQYaMfNhIbMtxrwfu8WImT4NyupU=
X-Google-Smtp-Source: AMsMyM7GDcKuZ4IOm74Ixr+i93V33sJqpJin9GO01H62JXmlCihESYZLJy4Sn4AaArxNciUNbu590GC31eU48CnOwRk=
X-Received: by 2002:a05:6402:1205:b0:458:c1b2:e428 with SMTP id
 c5-20020a056402120500b00458c1b2e428mr15898139edw.94.1664933985876; Tue, 04
 Oct 2022 18:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221004222725.2813510-1-sdf@google.com> <YzzQ2mI/srLNazNO@google.com>
In-Reply-To: <YzzQ2mI/srLNazNO@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 Oct 2022 18:39:34 -0700
Message-ID: <CAADnVQKyqJRGYn4ty5PaL2vAUnTo0ohY1CF3k_kpc=whEbhdPA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: make DEBUG_INFO_BTF_MODULES selectable independently
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Oct 4, 2022 at 5:33 PM <sdf@google.com> wrote:
>
> On 10/04, Stanislav Fomichev wrote:
> > We're having an issue where we have a recent clang that seems
> > to generate kind_flag for enums (aka, adding signed/unsigned).
> > Trying to install a module on a kernel that doesn't have commit
> > 6089fb325cf7 ("bpf: Add btf enum64 support") returns the following:
>
> > [    3.176954] BPF:Invalid btf_info kind_flag
>
> > The enum that it complains about doesn't seem to have anything special
> > except having a sign:
>
> > [1721] ENUM 'perf_event_state' encoding=SIGNED size=4 vlen=6
> >          'PERF_EVENT_STATE_DEAD' val=-4
> >          'PERF_EVENT_STATE_EXIT' val=-3
> >          'PERF_EVENT_STATE_ERROR' val=-2
> >          'PERF_EVENT_STATE_OFF' val=-1
> >          'PERF_EVENT_STATE_INACTIVE' val=0
> >          'PERF_EVENT_STATE_ACTIVE' val=1
>
> > We are not currently using CONFIG_DEBUG_INFO_BTF_MODULES and
> > don't plan to use module BTF, so it's preferable to be able
> > to explicits disable it in the kernel config. Unfortunately,
> > because that kconfig option doesn't have a name, it's not
> > possible to flip it independently from CONFIG_DEBUG_INFO_BTF.
> > Let's add a name to make sure module BTF is user-controllable.
>
> [..]
>
> > (Not sure, but maybe the right fix is to also have a stable patch
> >   to relax that "Invalid btf_info kind_flag" check?)
>
> Answering to myself, looks like we do need the following for
> non-enum64-compatible older/stable kernels:
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 3cfba41a0829..928f4955090a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3301,11 +3301,6 @@ static s32 btf_enum_check_meta(struct
> btf_verifier_env *env,
>                 return -EINVAL;
>         }
>
> -       if (btf_type_kflag(t)) {
> -               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> -               return -EINVAL;
> -       }
> -
>         if (t->size > 8 || !is_power_of_2(t->size)) {
>                 btf_verifier_log_type(env, t, "Unexpected size");
>                 return -EINVAL;
>
> Anything I'm missing? Feels like any pre-6089fb325cf7 ("bpf: Add btf
> enum64 support") kernel will have an issue with a recent clang
> that puts sign into kflag?
>
>
> > Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
> > and pahole supports it")
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   lib/Kconfig.debug | 1 +
> >   1 file changed, 1 insertion(+)
>
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index c77fe36bb3d8..6336a697c9f5 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -326,6 +326,7 @@ config PAHOLE_HAS_SPLIT_BTF
> >       def_bool $(success, test `$(PAHOLE) --version | sed
> > -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
>
> >   config DEBUG_INFO_BTF_MODULES
> > +     bool "Generate BTF module typeinfo"
> >       def_bool y
> >       depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> >       help

Not quite following.
Are you saying instead of backporting enum64 support
to older kernels you'd prefer to add this patch to upstream
and backport this smaller patch?
