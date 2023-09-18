Return-Path: <bpf+bounces-10279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A804C7A4A93
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60083281B01
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B81D54E;
	Mon, 18 Sep 2023 13:27:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13C6FB8
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 13:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C21C433AB
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695043668;
	bh=NpDQaIq8slcpBBgt5F7J36tVVCzb5GbvEyBtCzOBLa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UoxmHwOgqyogWMleGl7hlYN60HkduLBu56UN6a+4DTfHcLmBgI+h1pf5qWAePe/Uk
	 IbqBJP8SKRqIWxZyTr+dA2QAoihC53I3syrPshrD/i/O5neW3R+fPbjb3iGdp37RLZ
	 PUdOuzTbvs0TwPzO9bOg8mIwcy0VrhLPrhJDaxSCW9pnAU6NYFC+tSP6v32rkmfRBx
	 zGjl8ZbkzUCq8QUI8X2aE309WAaqmFZba1mAvrVYeU9nX6XOnDOChV6HaXRN8E9GjK
	 ODvI9HpRdEj0ikMDnSA2QtIT/66Ed0qf87vgraicOICuSilQc/0/T4wfou04qrvFUu
	 WrlEUzbRWL6fA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso5437422a12.3
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 06:27:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YzVgaX9bp69xIWPUHkBEDyVd2E4QZujGXeCuUpl1BtYG48lGui8
	/mPUhcnZhU6pL4meBVq9vEDnQlt+/815mNS4evz2Dw==
X-Google-Smtp-Source: AGHT+IHVacgZlb19m5SNsEYtq+vvIEOgYDfqOIvL1EGeUP6of8LJwyHm479IBQOjE2k7UHwxocOqT8Qvp9EQwMirE8w=
X-Received: by 2002:aa7:d58b:0:b0:530:4f4b:9d1a with SMTP id
 r11-20020aa7d58b000000b005304f4b9d1amr7872098edq.5.1695043666738; Mon, 18 Sep
 2023 06:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616000441.3677441-1-kpsingh@kernel.org> <20230616000441.3677441-6-kpsingh@kernel.org>
 <202306201356.CF454506@keescook>
In-Reply-To: <202306201356.CF454506@keescook>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 18 Sep 2023 15:27:36 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Nv+_L_scpZL3L32AZtradq6yTeN9adz0ayihe3PpHsw@mail.gmail.com>
Message-ID: <CACYkzJ7Nv+_L_scpZL3L32AZtradq6yTeN9adz0ayihe3PpHsw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 10:59=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Fri, Jun 16, 2023 at 02:04:41AM +0200, KP Singh wrote:
> > [...]
> > @@ -110,6 +110,9 @@ static __initdata struct lsm_info *exclusive;
> >  #undef LSM_HOOK
> >  #undef DEFINE_LSM_STATIC_CALL
> >
> > +#define security_hook_active(n, h) \
> > +     static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY, &SECURITY_HOOK_A=
CTIVE_KEY(h, n))
> > +
> >  /*
> >   * Initialise a table of static calls for each LSM hook.
> >   * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CA=
LL_KEY)
> > @@ -816,7 +819,7 @@ static int lsm_superblock_alloc(struct super_block =
*sb)
> >   */
> >  #define __CALL_STATIC_VOID(NUM, HOOK, ...)                            =
    \
> >  do {                                                                  =
    \
> > -     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {    \
> > +     if (security_hook_active(NUM, HOOK)) {                           =
    \
> >               static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    =
    \
> >       }                                                                =
    \
> >  } while (0);
> > @@ -828,7 +831,7 @@ do {                                               =
                            \
> >
> >  #define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)                   =
    \
> >  do {                                                                  =
    \
> > -     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {  \
> > +     if (security_hook_active(NUM, HOOK)) {    \
> >               R =3D static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__=
);    \
> >               if (R !=3D 0)                                            =
      \
> >                       goto LABEL;                                      =
    \
>
> I actually think I'd prefer there be no macro wrapping
> static_branch_maybe(), just for reading it more easily. i.e. people
> reading this code are going to expect the static_branch/static_call code
> patterns, and seeing "security_hook_active" only slows them down in
> understanding it. I don't think it's _that_ ugly to have it all typed
> out. e.g.:

Done and agreed, especially given that this is behind a macro anyways.


>
>         if (static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY,             =
    \
>                                 &SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)) {  =
    \
>                 R =3D static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__=
);    \
>                 if (R !=3D 0)                                            =
      \
>                         goto LABEL;                                      =
    \
>
>
>
> --
> Kees Cook

