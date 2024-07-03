Return-Path: <bpf+bounces-33782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C59926674
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C542283BA9
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57F1836CA;
	Wed,  3 Jul 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7OjyOZL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F601426C
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025701; cv=none; b=Zwp+BeHzeWwlBbepBqh5wYDm9ciQIFIyLkoHHqatQCHyOUjNw8d52oa5F3Q5BEjhDuhJ8ruqzK50IwPGg0wjR5gOOAEsmRFQFtR8yiBwl9WFm+jvKCeJdTnzeXNhOIgYn6XpcMPrdt5SygIhLNvKjTlybWeEf9OQlQYq7h4Ackc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025701; c=relaxed/simple;
	bh=6BkqlMXppNscJCQHWu2J1dXFevUBHHrSBjRG1IqhLhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGrg55ZGTrm/WyPAM778WRd4XTOKLK1QXfrgHcNUVTB17xP6cZSYsdYWveE2o1PH9LIzkLCpDjDuba+L55/uNoEZSZesSBoyljg1Pd+uZqSBDeQs9NsEj7txreM/086DvmvchjZECGUTOSfQ4o0mCXiKREBr4MXi2xkVD7mAg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7OjyOZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBAAC3277B
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720025701;
	bh=6BkqlMXppNscJCQHWu2J1dXFevUBHHrSBjRG1IqhLhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s7OjyOZL3Ljz1rLAprptB3QQAo7ntrrFkutOf3pM7LZSXkJiQLcPSigbv1Cw/k0Xh
	 n//dJtevnWn38jQyx0XbmyM/v/ChuBGLxIE0M20Yb363X4m7hiw4e9+YXRaUve4f6Z
	 3ZNB5ACzeRYPaINAooSnhEksNPctavLQs6L1kTWTkwb9Ce/aPtCtYZTG1CA51QTxkJ
	 iEpqtURHcH6Zh1TOYbkibHCra2W77jENgv2y6fXVVstS50S0Dz8UyCFavUcW+tRgNW
	 lqTAQxfiGFJCU/yskfKlnCbUzCKFx3pQE+yIOStVxgTDlwzhJOMwq6t/lqaz3z1MG0
	 dCRVnEZFwp1eQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e9a920e73so872126e87.2
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 09:55:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURSNa86CcPJKjHcKkF7TXBcRVoKeog2grzb2xTF45JL1akL51G+OjZAlwEd1CGt5pylvPWLMMzw/D3CCnZHjeGGenf
X-Gm-Message-State: AOJu0Yxhyr7RcucUinczpZpAqtgmoWPhD/O7CehK5pKE8WbHiV1pkW47
	2WUzcyGLWq1jOEGgDyyo3TL1QqBpOcH2apQZ7gZ9ZpgSdhdnQwUZDZBtaMeiAA2Wu3L+12Dcbjp
	i4r+oLS4sAJFKxt19JBXZsN8Os/F75LNp0k0i
X-Google-Smtp-Source: AGHT+IE736FfVm4z7Siy4FYv8rIU6pG0hmhNouMFPyGsMsxwe2nPueXhE/4IuvoztHDVTNehBN5jJT0pbBQdeFOrxrM=
X-Received: by 2002:a05:6512:3dab:b0:52c:d085:9978 with SMTP id
 2adb3069b0e04-52e82733e8amr8760059e87.62.1720025699465; Wed, 03 Jul 2024
 09:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
In-Reply-To: <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 3 Jul 2024 18:54:48 +0200
X-Gmail-Original-Message-ID: <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
Message-ID: <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> >
> > LSM hooks are currently invoked from a linked list as indirect calls
> > which are invoked using retpolines as a mitigation for speculative
> > attacks (Branch History / Target injection) and add extra overhead whic=
h
> > is especially bad in kernel hot paths:

[...]

> should fix the more obvious problems.  I'd like to know if you are
> aware of any others?  If not, the text above should be adjusted and
> we should reconsider patch 5/5.  If there are other problems I'd
> like to better understand them as there may be an independent
> solution for those particular problems.

We did have problems with some other hooks but I was unable to dig up
specific examples though, it's been a while. More broadly speaking, a
default decision is still a decision. Whereas the intent from the BPF
LSM is not to make a default decision unless a BPF program is loaded.
I am quite worried about the holes this leaves open, subtle bugs
(security or crashes) we have not caught yet and PATCH 5/5 engineers away
 the problem of the "default decision".

>
> > With the hook now exposed as a static call, one can see that the
> > retpolines are no longer there and the LSM callbacks are invoked
> > directly:
> >
> > security_file_ioctl:
> >    0xff...0ca0 <+0>:  endbr64
> >    0xff...0ca4 <+4>:  nopl   0x0(%rax,%rax,1)
> >    0xff...0ca9 <+9>:  push   %rbp
> >    0xff...0caa <+10>: push   %r14
> >    0xff...0cac <+12>: push   %rbx
> >    0xff...0cad <+13>: mov    %rdx,%rbx
> >    0xff...0cb0 <+16>: mov    %esi,%ebp
> >    0xff...0cb2 <+18>: mov    %rdi,%r14
> >    0xff...0cb5 <+21>: jmp    0xff...0cc7 <security_file_ioctl+39>
> >                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >    Static key enabled for SELinux
> >
> >    0xffffffff818f0cb7 <+23>:  jmp    0xff...0cde <security_file_ioctl+6=
2>
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^
> >
> >    Static key enabled for BPF LSM. This is something that is changed to
> >    default to false to avoid the existing side effect issues of BPF LSM
> >    [1] in a subsequent patch.
> >
> >    0xff...0cb9 <+25>: xor    %eax,%eax
> >    0xff...0cbb <+27>: xchg   %ax,%ax
> >    0xff...0cbd <+29>: pop    %rbx
> >    0xff...0cbe <+30>: pop    %r14
> >    0xff...0cc0 <+32>: pop    %rbp
> >    0xff...0cc1 <+33>: cs jmp 0xff...0000 <__x86_return_thunk>
> >    0xff...0cc7 <+39>: endbr64
> >    0xff...0ccb <+43>: mov    %r14,%rdi
> >    0xff...0cce <+46>: mov    %ebp,%esi
> >    0xff...0cd0 <+48>: mov    %rbx,%rdx
> >    0xff...0cd3 <+51>: call   0xff...3230 <selinux_file_ioctl>
> >                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >    Direct call to SELinux.
> >
> >    0xff...0cd8 <+56>: test   %eax,%eax
> >    0xff...0cda <+58>: jne    0xff...0cbd <security_file_ioctl+29>
> >    0xff...0cdc <+60>: jmp    0xff...0cb7 <security_file_ioctl+23>
> >    0xff...0cde <+62>: endbr64
> >    0xff...0ce2 <+66>: mov    %r14,%rdi
> >    0xff...0ce5 <+69>: mov    %ebp,%esi
> >    0xff...0ce7 <+71>: mov    %rbx,%rdx
> >    0xff...0cea <+74>: call   0xff...e220 <bpf_lsm_file_ioctl>
> >                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >    Direct call to BPF LSM.
> >
> >    0xff...0cef <+79>: test   %eax,%eax
> >    0xff...0cf1 <+81>: jne    0xff...0cbd <security_file_ioctl+29>
> >    0xff...0cf3 <+83>: jmp    0xff...0cb9 <security_file_ioctl+25>
> >    0xff...0cf5 <+85>: endbr64
> >    0xff...0cf9 <+89>: mov    %r14,%rdi
> >    0xff...0cfc <+92>: mov    %ebp,%esi
> >    0xff...0cfe <+94>: mov    %rbx,%rdx
> >    0xff...0d01 <+97>: pop    %rbx
> >    0xff...0d02 <+98>: pop    %r14
> >    0xff...0d04 <+100>:        pop    %rbp
> >    0xff...0d05 <+101>:        ret
> >    0xff...0d06 <+102>:        int3
> >    0xff...0d07 <+103>:        int3
> >    0xff...0d08 <+104>:        int3
> >    0xff...0d09 <+105>:        int3
> >
> > While this patch uses static_branch_unlikely indicating that an LSM hoo=
k
> > is likely to be not present. In most cases this is still a better choic=
e
> > as even when an LSM with one hook is added, empty slots are created for
> > all LSM hooks (especially when many LSMs that do not initialize most
> > hooks are present on the system).
> >
> > There are some hooks that don't use the call_int_hook and
> > call_void_hook.
>
> I think you mean "or" and not "and", yes?

Yep, thanks, fixed.

>
> > These hooks are updated to use a new macro called
> > lsm_for_each_hook where the lsm_callback is directly invoked as an
> > indirect call. These are updated in a subsequent patch to also use
> > static calls.
> >
> > Below are results of the relevant Unixbench system benchmarks with BPF =
LSM
> > and SELinux enabled with default policies enabled with and without thes=
e
> > patches.
> >
> > Benchmark                                               Delta(%): (+ is=
 better)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > Execl Throughput                                             +1.9356
> > File Write 1024 bufsize 2000 maxblocks                       +6.5953
> > Pipe Throughput                                              +9.5499
> > Pipe-based Context Switching                                 +3.0209
> > Process Creation                                             +2.3246
> > Shell Scripts (1 concurrent)                                 +1.4975
> > System Call Overhead                                         +2.7815
> > System Benchmarks Index Score (Partial Only):                +3.4859
> >
> > In the best case, some syscalls like eventfd_create benefitted to about=
 ~10%.
> >
> > [1] https://lore.kernel.org/linux-security-module/20220609234601.202636=
2-1-kpsingh@kernel.org/
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Song Liu <song@kernel.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/lsm_hooks.h |  72 ++++++++++++--
> >  security/security.c       | 198 ++++++++++++++++++++++++++------------
> >  2 files changed, 197 insertions(+), 73 deletions(-)
>
> ...
>
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index efd4a0655159..a66ca68485a2 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -30,19 +30,66 @@
> >  #include <linux/init.h>
> >  #include <linux/rculist.h>
> >  #include <linux/xattr.h>
> > +#include <linux/static_call.h>
> > +#include <linux/unroll.h>
> > +#include <linux/jump_label.h>
> > +#include <linux/lsm_count.h>
> > +
> > +#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOO=
K##_##IDX
> > +
> > +/*
> > + * Identifier for the LSM static calls.
> > + * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
> > + * IDX is the index of the static call. 0 <=3D NUM < MAX_LSM_COUNT
> > + */
> > +#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
> > +
> > +/*
> > + * Call the macro M for each LSM hook MAX_LSM_COUNT times.
> > + */
> > +#define LSM_LOOP_UNROLL(M, ...)              \
> > +do {                                         \
> > +     UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)   \
> > +} while (0)
> > +
> > +#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__=
)
>
> All of the macros above (SECURITY_HOOK_ACTIVE_KEY, LSM_STATIC_CALL,
> LSM_LOOP_UNROLL, and LSM_DEFINE_UNROLL) are only used in
> security/security.c, yes?  If so, is there a reason why they are
> defined here and not in security/security.c?

Fair point, fixed.

>
> > diff --git a/security/security.c b/security/security.c
> > index 9c3fb2f60e2a..e0ec185cf125 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -112,6 +113,51 @@ static __initconst const char *const builtin_lsm_o=
rder =3D CONFIG_LSM;
> >  static __initdata struct lsm_info **ordered_lsms;
> >  static __initdata struct lsm_info *exclusive;
> >
> > +
> > +#ifdef CONFIG_HAVE_STATIC_CALL
> > +#define LSM_HOOK_TRAMP(NAME, NUM) \
> > +     &STATIC_CALL_TRAMP(LSM_STATIC_CALL(NAME, NUM))
> > +#else
> > +#define LSM_HOOK_TRAMP(NAME, NUM) NULL
> > +#endif
> > +
> > +/*
> > + * Define static calls and static keys for each LSM hook.
> > + */
> > +
> > +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
> > +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
> > +                             *((RET(*)(__VA_ARGS__))NULL));          \
> > +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
> > +
> > +#define LSM_HOOK(RET, DEFAULT, NAME, ...)                            \
> > +     LSM_DEFINE_UNROLL(DEFINE_LSM_STATIC_CALL, NAME, RET, __VA_ARGS__)
> > +#include <linux/lsm_hook_defs.h>
> > +#undef LSM_HOOK
> > +#undef DEFINE_LSM_STATIC_CALL
>
> If you end up respinning the patchset, drop the two blank lines
> before the DEFINE_LSM_STATIC_CALL and LSM_HOOK definitions.

Done.

>
> > @@ -856,29 +916,43 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx=
, u32 *uctx_len,
> >   * call_int_hook:
> >   *   This is a hook that returns a value.
> >   */
> > +#define __CALL_STATIC_VOID(NUM, HOOK, ...)                            =
    \
> > +do {                                                                  =
    \
> > +     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {    \
> > +             static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    =
    \
> > +     }                                                                =
    \
> > +} while (0);
> >
> > -#define call_void_hook(FUNC, ...)                            \
> > -     do {                                                    \
> > -             struct security_hook_list *P;                   \
> > -                                                             \
> > -             hlist_for_each_entry(P, &security_hook_heads.FUNC, list) =
\
> > -                     P->hook.FUNC(__VA_ARGS__);              \
> > +#define call_void_hook(HOOK, ...)                                 \
> > +     do {                                                      \
> > +             LSM_LOOP_UNROLL(__CALL_STATIC_VOID, HOOK, __VA_ARGS__); \
> >       } while (0)
> >
> > -#define call_int_hook(FUNC, ...) ({                          \
> > -     int RC =3D LSM_RET_DEFAULT(FUNC);                         \
> > -     do {                                                    \
> > -             struct security_hook_list *P;                   \
> > -                                                             \
> > -             hlist_for_each_entry(P, &security_hook_heads.FUNC, list) =
{ \
> > -                     RC =3D P->hook.FUNC(__VA_ARGS__);         \
> > -                     if (RC !=3D LSM_RET_DEFAULT(FUNC))        \
> > -                             break;                          \
> > -             }                                               \
> > -     } while (0);                                            \
> > -     RC;                                                     \
> > +
> > +#define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)                   =
    \
> > +do {                                                                  =
    \
> > +     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {  \
> > +             R =3D static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__=
);    \
> > +             if (R !=3D LSM_RET_DEFAULT(HOOK))                        =
      \
> > +                     goto LABEL;                                      =
    \
> > +     }                                                                =
    \
> > +} while (0);
> > +
> > +#define call_int_hook(HOOK, ...)                                     \
> > +({                                                                   \
> > +     __label__ out;                                                  \
>
> This is another only-if-you-respin, consider /out/OUT/ so it is more
> consistent.

Done. I will do a re-spin as we do have some fixes.

>
> > +     int RC =3D LSM_RET_DEFAULT(HOOK);                                =
 \
> > +                                                                     \
> > +     LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, HOOK, out, __VA_ARGS__); \
> > +out:                                                                 \
> > +     RC;                                                             \
> >  })
> >
> > +#define lsm_for_each_hook(scall, NAME)                                =
       \
> > +     for (scall =3D static_calls_table.NAME;                          =
 \
> > +          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
> > +             if (static_key_enabled(&scall->active->key))
>
> This is probably a stupid question, but why use static_key_enabled()
> here instead of static_branch_unlikely() as in the call_XXX_macros?

The static_key_enabled is a check for the key being enabled, whereas
the static_branch_likely is for laying out the right assembly code
(jump tables etc.) and based on the value of the static key, here we
are not using the static calls or even keys, rather we are following
back from direct calls to indirect calls and don't really need any
jump tables in the slow path.

We also get rid of this macro in the
subsequent patch, but we might need to keep it around if we leave
security_getselfattr alone.

- KP

>
> --
> paul-moore.com

