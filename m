Return-Path: <bpf+bounces-2804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DFC7341D6
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A622816C6
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128EDA934;
	Sat, 17 Jun 2023 15:11:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5774C8C
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 15:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4045C433C8
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687014709;
	bh=tYXe/sF0t8rSqqvaQ9sYHepENz9fitDctkvT8d1L3eI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vI+QcUHzxoLVDOaIVNuHRYXzn4HOL0lE+Db3nOQW4KEhPC1khsdKJjnRouSi7reCz
	 K7RNrHrOFrpPgiI68rscwEXLACBI5hapb7zkjUD0zf9lm7Aqrn3qP9qRGnZFLj+Z9t
	 W2JyV+Y2Jb278ECRnwgwmDoLn+/qpDrk8h04Y1YcjCzjz9hZHSlvfxKZqXRSsHJA7N
	 onEDlsPoPLI7SUCV0QjRhZWngYhvK75hiwdc+xyyEWlqMiUhnX62Ae3xaAAsThGZx9
	 381qTokKlpBdQpXKEKojb2KQb3zf6rdLXjIJyjILkJ7p7/f2skNCAcNhsg7TbUZ6mD
	 dwOMrB0nwPJRA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso2268531a12.3
        for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 08:11:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDxmEuw4ZtWCy+n61TB/voUw47AwsJsHNZEFzO4hs1fU2b58oUgg
	6N8Dg4CCSp84zENf6o/x4sZX8jvcH0ob6ZgMz4cC/A==
X-Google-Smtp-Source: ACHHUZ6p4GM2zi3gudwl13Eo5r3bP70lpYUwN2ee4n9wjCA9mJksRt8lDISV+0mRghIDhGkMeIDcve5X1N3sKn7MQWo=
X-Received: by 2002:aa7:cd77:0:b0:51a:2d05:ccb5 with SMTP id
 ca23-20020aa7cd77000000b0051a2d05ccb5mr3515354edb.35.1687014707905; Sat, 17
 Jun 2023 08:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616000441.3677441-1-kpsingh@kernel.org> <20230616000441.3677441-6-kpsingh@kernel.org>
 <578a54c4-8d62-12b2-1a6b-0e242da9fcab@schaufler-ca.com>
In-Reply-To: <578a54c4-8d62-12b2-1a6b-0e242da9fcab@schaufler-ca.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 17 Jun 2023 17:11:37 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6eJ9Tbt=f5tR0Qtpkyw7d=UFFm1tLK7DFY_XGZs-rN3Q@mail.gmail.com>
Message-ID: <CACYkzJ6eJ9Tbt=f5tR0Qtpkyw7d=UFFm1tLK7DFY_XGZs-rN3Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 3:15=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 6/15/2023 5:04 PM, KP Singh wrote:
> > This config influences the nature of the static key that guards the
> > static call for LSM hooks.
> >
> > When enabled, it indicates that an LSM static call slot is more likely
> > to be initialized. When disabled, it optimizes for the case when static
> > call slot is more likely to be not initialized.
> >
> > When a major LSM like (SELinux, AppArmor, Smack etc) is active on a
> > system the system would benefit from enabling the config. However there
> > are other cases which would benefit from the config being disabled
> > (e.g. a system with a BPF LSM with no hooks enabled by default, or an
> > LSM like loadpin / yama). Ultimately, there is no one-size fits all
> > solution.
> >
> > with CONFIG_SECURITY_HOOK_LIKELY enabled, the inactive /
> > uninitialized case is penalized with a direct jmp (still better than
> > an indirect jmp):
> >
> > function security_file_ioctl:
> >    0xffffffff818f0c80 <+0>:   endbr64
> >    0xffffffff818f0c84 <+4>:   nopl   0x0(%rax,%rax,1)
> >    0xffffffff818f0c89 <+9>:   push   %rbp
> >    0xffffffff818f0c8a <+10>:  push   %r14
> >    0xffffffff818f0c8c <+12>:  push   %rbx
> >    0xffffffff818f0c8d <+13>:  mov    %rdx,%rbx
> >    0xffffffff818f0c90 <+16>:  mov    %esi,%ebp
> >    0xffffffff818f0c92 <+18>:  mov    %rdi,%r14
> >    0xffffffff818f0c95 <+21>:  jmp    0xffffffff818f0ca8 <security_file_=
ioctl+40>
> >
> >    jump to skip the inactive BPF LSM hook.
> >
> >    0xffffffff818f0c97 <+23>:  mov    %r14,%rdi
> >    0xffffffff818f0c9a <+26>:  mov    %ebp,%esi
> >    0xffffffff818f0c9c <+28>:  mov    %rbx,%rdx
> >    0xffffffff818f0c9f <+31>:  call   0xffffffff8141e3b0 <bpf_lsm_file_i=
octl>
> >    0xffffffff818f0ca4 <+36>:  test   %eax,%eax
> >    0xffffffff818f0ca6 <+38>:  jne    0xffffffff818f0cbf <security_file_=
ioctl+63>
> >    0xffffffff818f0ca8 <+40>:  endbr64
> >    0xffffffff818f0cac <+44>:  jmp    0xffffffff818f0ccd <security_file_=
ioctl+77>
> >
> >    jump to skip the empty slot.
> >
> >    0xffffffff818f0cae <+46>:  mov    %r14,%rdi
> >    0xffffffff818f0cb1 <+49>:  mov    %ebp,%esi
> >    0xffffffff818f0cb3 <+51>:  mov    %rbx,%rdx
> >    0xffffffff818f0cb6 <+54>:  nopl   0x0(%rax,%rax,1)
> >                               ^^^^^^^^^^^^^^^^^^^^^^^
> >                               Empty slot
> >
> >    0xffffffff818f0cbb <+59>:  test   %eax,%eax
> >    0xffffffff818f0cbd <+61>:  je     0xffffffff818f0ccd <security_file_=
ioctl+77>
> >    0xffffffff818f0cbf <+63>:  endbr64
> >    0xffffffff818f0cc3 <+67>:  pop    %rbx
> >    0xffffffff818f0cc4 <+68>:  pop    %r14
> >    0xffffffff818f0cc6 <+70>:  pop    %rbp
> >    0xffffffff818f0cc7 <+71>:  cs jmp 0xffffffff82c00000 <__x86_return_t=
hunk>
> >    0xffffffff818f0ccd <+77>:  endbr64
> >    0xffffffff818f0cd1 <+81>:  xor    %eax,%eax
> >    0xffffffff818f0cd3 <+83>:  jmp    0xffffffff818f0cbf <security_file_=
ioctl+63>
> >    0xffffffff818f0cd5 <+85>:  mov    %r14,%rdi
> >    0xffffffff818f0cd8 <+88>:  mov    %ebp,%esi
> >    0xffffffff818f0cda <+90>:  mov    %rbx,%rdx
> >    0xffffffff818f0cdd <+93>:  pop    %rbx
> >    0xffffffff818f0cde <+94>:  pop    %r14
> >    0xffffffff818f0ce0 <+96>:  pop    %rbp
> >    0xffffffff818f0ce1 <+97>:  ret
> >
> > When the config is disabled, the case optimizes the scenario above.
> >
> > security_file_ioctl:
> >    0xffffffff818f0e30 <+0>:   endbr64
> >    0xffffffff818f0e34 <+4>:   nopl   0x0(%rax,%rax,1)
> >    0xffffffff818f0e39 <+9>:   push   %rbp
> >    0xffffffff818f0e3a <+10>:  push   %r14
> >    0xffffffff818f0e3c <+12>:  push   %rbx
> >    0xffffffff818f0e3d <+13>:  mov    %rdx,%rbx
> >    0xffffffff818f0e40 <+16>:  mov    %esi,%ebp
> >    0xffffffff818f0e42 <+18>:  mov    %rdi,%r14
> >    0xffffffff818f0e45 <+21>:  xchg   %ax,%ax
> >    0xffffffff818f0e47 <+23>:  xchg   %ax,%ax
> >
> >    The static keys in their disabled state do not create jumps leading
> >    to faster code.
> >
> >    0xffffffff818f0e49 <+25>:  xor    %eax,%eax
> >    0xffffffff818f0e4b <+27>:  xchg   %ax,%ax
> >    0xffffffff818f0e4d <+29>:  pop    %rbx
> >    0xffffffff818f0e4e <+30>:  pop    %r14
> >    0xffffffff818f0e50 <+32>:  pop    %rbp
> >    0xffffffff818f0e51 <+33>:  cs jmp 0xffffffff82c00000 <__x86_return_t=
hunk>
> >    0xffffffff818f0e57 <+39>:  endbr64
> >    0xffffffff818f0e5b <+43>:  mov    %r14,%rdi
> >    0xffffffff818f0e5e <+46>:  mov    %ebp,%esi
> >    0xffffffff818f0e60 <+48>:  mov    %rbx,%rdx
> >    0xffffffff818f0e63 <+51>:  call   0xffffffff8141e3b0 <bpf_lsm_file_i=
octl>
> >    0xffffffff818f0e68 <+56>:  test   %eax,%eax
> >    0xffffffff818f0e6a <+58>:  jne    0xffffffff818f0e4d <security_file_=
ioctl+29>
> >    0xffffffff818f0e6c <+60>:  jmp    0xffffffff818f0e47 <security_file_=
ioctl+23>
> >    0xffffffff818f0e6e <+62>:  endbr64
> >    0xffffffff818f0e72 <+66>:  mov    %r14,%rdi
> >    0xffffffff818f0e75 <+69>:  mov    %ebp,%esi
> >    0xffffffff818f0e77 <+71>:  mov    %rbx,%rdx
> >    0xffffffff818f0e7a <+74>:  nopl   0x0(%rax,%rax,1)
> >    0xffffffff818f0e7f <+79>:  test   %eax,%eax
> >    0xffffffff818f0e81 <+81>:  jne    0xffffffff818f0e4d <security_file_=
ioctl+29>
> >    0xffffffff818f0e83 <+83>:  jmp    0xffffffff818f0e49 <security_file_=
ioctl+25>
> >    0xffffffff818f0e85 <+85>:  endbr64
> >    0xffffffff818f0e89 <+89>:  mov    %r14,%rdi
> >    0xffffffff818f0e8c <+92>:  mov    %ebp,%esi
> >    0xffffffff818f0e8e <+94>:  mov    %rbx,%rdx
> >    0xffffffff818f0e91 <+97>:  pop    %rbx
> >    0xffffffff818f0e92 <+98>:  pop    %r14
> >    0xffffffff818f0e94 <+100>: pop    %rbp
> >    0xffffffff818f0e95 <+101>: ret
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  security/Kconfig    | 11 +++++++++++
> >  security/security.c | 13 ++++++++-----
> >  2 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 52c9af08ad35..bd2a0dff991a 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -32,6 +32,17 @@ config SECURITY
> >
> >         If you are unsure how to answer this question, answer N.
> >
> > +config SECURITY_HOOK_LIKELY
> > +     bool "LSM hooks are likely to be initialized"
> > +     depends on SECURITY
> > +     default y
> > +     help
> > +       This controls the behaviour of the static keys that guard LSM h=
ooks.
> > +       If LSM hooks are likely to be initialized by LSMs, then one get=
s
> > +       better performance by enabling this option. However, if the sys=
tem is
> > +       using an LSM where hooks are much likely to be disabled, one ge=
ts
> > +       better performance by disabling this config.
> > +
> >  config SECURITYFS
> >       bool "Enable the securityfs filesystem"
> >       help
> > diff --git a/security/security.c b/security/security.c
> > index 4aec25949212..da80a8918e7d 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -99,9 +99,9 @@ static __initdata struct lsm_info *exclusive;
> >   * Define static calls and static keys for each LSM hook.
> >   */
> >
> > -#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
> > -     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
> > -                             *((RET(*)(__VA_ARGS__))NULL));          \
> > +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)               \
> > +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),       \
> > +                             *((RET(*)(__VA_ARGS__))NULL));    \
>
> This is just a cosmetic change, right? Please fix it in the original
> patch when you respin, not here. I spent way to long trying to figure out
> why you had to make a change.

Sorry about this, I will fix it when I respin.

>
> >       DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
> >
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...)                            \
> > @@ -110,6 +110,9 @@ static __initdata struct lsm_info *exclusive;
> >  #undef LSM_HOOK
> >  #undef DEFINE_LSM_STATIC_CALL
> >
> > +#define security_hook_active(n, h) \
> > +     static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY, &SECURITY_HOOK_A=
CTIVE_KEY(h, n))
> > +
>
> Please don't use the security_ prefix here. It's a local macro, use hook_=
active()
> or, if you must, lsm_hook_active().

Ack, will use lsm_hook_active.

>
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

