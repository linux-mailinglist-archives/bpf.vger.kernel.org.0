Return-Path: <bpf+bounces-10520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5B7A92F9
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487A528184C
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5248F6B;
	Thu, 21 Sep 2023 09:14:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C08F55
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 09:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBD8C4AF5C
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 09:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695287670;
	bh=45WXeAp5zzdY7Jl6oOa61+XDw1UowCDn0WF1np7AH2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dZ0U1e3rapiKo5VuHCGJTJk2zYs+VoWM0s5uh822Fo/yae+MrQs/Tnw7/YDmHXZAe
	 Of/nQ1CnvDoBKQNkw1Ew0sPxEatbn3GLdj3PzrZXrVtgFIxrIPfkyPzzhRC3Cwuswb
	 +H1aZc0n3mXboel2jhz1krH73vs73+xHzHrtGVTiVwuL1NGeDs5JqrmWM44g8xffQP
	 YQDE1DAcV88hUQ8Dn/1f9PuFiwExavBfoy4k4bwxMCasvnpmfPRo80ho/PhLKbSTPO
	 +ucjy7edhAxPhEB3XZQFYDNDTFHPFgwL8q8TI08AnprfJ9mjRjRxZ7e91prhwOYhWw
	 pIR2RR/H0eojQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso770114a12.3
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 02:14:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YxEMQ97+zfACrSoF3vYPcX+biTxdhrOjkbfJrzOSH4FhmZeGb2k
	K4XadQnbpIEV9PwsCxdidpEO5aQSB3J1Oy0/vjjTog==
X-Google-Smtp-Source: AGHT+IHUrSoHF1HQdvHE1LK8+8THeIPWotYBsZ4xS6+fiVWwWrKFLrh/oSX8wnEyQYSdIOWk4gbm4lb+vxCboU+y9Ak=
X-Received: by 2002:a05:6402:174f:b0:533:4c67:c911 with SMTP id
 v15-20020a056402174f00b005334c67c911mr414821edx.19.1695287668168; Thu, 21 Sep
 2023 02:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-4-kpsingh@kernel.org>
 <c97a7e4a-e209-2648-b741-fd882b933ddd@schaufler-ca.com>
In-Reply-To: <c97a7e4a-e209-2648-b741-fd882b933ddd@schaufler-ca.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 21 Sep 2023 11:14:17 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4L0m+DUXnDwnhokCNZm+W7kFs3e-hbfS2hjuL3zkE53g@mail.gmail.com>
Message-ID: <CACYkzJ4L0m+DUXnDwnhokCNZm+W7kFs3e-hbfS2hjuL3zkE53g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[...]

> > [1] https://lore.kernel.org/linux-security-module/20220609234601.202636=
2-1-kpsingh@kernel.org/
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Good job on reducing the impact in security.c.

Thanks!

> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


On Wed, Sep 20, 2023 at 8:11=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 9/18/2023 2:24 PM, KP Singh wrote:
> > LSM hooks are currently invoked from a linked list as indirect calls
> > which are invoked using retpolines as a mitigation for speculative
> > attacks (Branch History / Target injection) and add extra overhead whic=
h
> > is especially bad in kernel hot paths:
> >
> > security_file_ioctl:
> >    0xffffffff814f0320 <+0>:   endbr64
> >    0xffffffff814f0324 <+4>:   push   %rbp
> >    0xffffffff814f0325 <+5>:   push   %r15
> >    0xffffffff814f0327 <+7>:   push   %r14
> >    0xffffffff814f0329 <+9>:   push   %rbx
> >    0xffffffff814f032a <+10>:  mov    %rdx,%rbx
> >    0xffffffff814f032d <+13>:  mov    %esi,%ebp
> >    0xffffffff814f032f <+15>:  mov    %rdi,%r14
> >    0xffffffff814f0332 <+18>:  mov    $0xffffffff834a7030,%r15
> >    0xffffffff814f0339 <+25>:  mov    (%r15),%r15
> >    0xffffffff814f033c <+28>:  test   %r15,%r15
> >    0xffffffff814f033f <+31>:  je     0xffffffff814f0358 <security_file_=
ioctl+56>
> >    0xffffffff814f0341 <+33>:  mov    0x18(%r15),%r11
> >    0xffffffff814f0345 <+37>:  mov    %r14,%rdi
> >    0xffffffff814f0348 <+40>:  mov    %ebp,%esi
> >    0xffffffff814f034a <+42>:  mov    %rbx,%rdx
> >
> >    0xffffffff814f034d <+45>:  call   0xffffffff81f742e0 <__x86_indirect=
_thunk_array+352>
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^
> >
> >     Indirect calls that use retpolines leading to overhead, not just du=
e
> >     to extra instruction but also branch misses.
> >
> >    0xffffffff814f0352 <+50>:  test   %eax,%eax
> >    0xffffffff814f0354 <+52>:  je     0xffffffff814f0339 <security_file_=
ioctl+25>
> >    0xffffffff814f0356 <+54>:  jmp    0xffffffff814f035a <security_file_=
ioctl+58>
> >    0xffffffff814f0358 <+56>:  xor    %eax,%eax
> >    0xffffffff814f035a <+58>:  pop    %rbx
> >    0xffffffff814f035b <+59>:  pop    %r14
> >    0xffffffff814f035d <+61>:  pop    %r15
> >    0xffffffff814f035f <+63>:  pop    %rbp
> >    0xffffffff814f0360 <+64>:  jmp    0xffffffff81f747c4 <__x86_return_t=
hunk>
> >
> > The indirect calls are not really needed as one knows the addresses of
> > enabled LSM callbacks at boot time and only the order can possibly
> > change at boot time with the lsm=3D kernel command line parameter.
> >
> > An array of static calls is defined per LSM hook and the static calls
> > are updated at boot time once the order has been determined.
> >
> > A static key guards whether an LSM static call is enabled or not,
> > without this static key, for LSM hooks that return an int, the presence
> > of the hook that returns a default value can create side-effects which
> > has resulted in bugs [1].
> >
> > With the hook now exposed as a static call, one can see that the
> > retpolines are no longer there and the LSM callbacks are invoked
> > directly:
> >
> > security_file_ioctl:
> >    0xffffffff818f0ca0 <+0>:   endbr64
> >    0xffffffff818f0ca4 <+4>:   nopl   0x0(%rax,%rax,1)
> >    0xffffffff818f0ca9 <+9>:   push   %rbp
> >    0xffffffff818f0caa <+10>:  push   %r14
> >    0xffffffff818f0cac <+12>:  push   %rbx
> >    0xffffffff818f0cad <+13>:  mov    %rdx,%rbx
> >    0xffffffff818f0cb0 <+16>:  mov    %esi,%ebp
> >    0xffffffff818f0cb2 <+18>:  mov    %rdi,%r14
> >    0xffffffff818f0cb5 <+21>:  jmp    0xffffffff818f0cc7 <security_file_=
ioctl+39>
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^
> >    Static key enabled for SELinux
> >
> >    0xffffffff818f0cb7 <+23>:  jmp    0xffffffff818f0cde <security_file_=
ioctl+62>
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^
> >
> >    Static key enabled for BPF LSM. This is something that is changed to
> >    default to false to avoid the existing side effect issues of BPF LSM
> >    [1] in a subsequent patch.
> >
> >    0xffffffff818f0cb9 <+25>:  xor    %eax,%eax
> >    0xffffffff818f0cbb <+27>:  xchg   %ax,%ax
> >    0xffffffff818f0cbd <+29>:  pop    %rbx
> >    0xffffffff818f0cbe <+30>:  pop    %r14
> >    0xffffffff818f0cc0 <+32>:  pop    %rbp
> >    0xffffffff818f0cc1 <+33>:  cs jmp 0xffffffff82c00000 <__x86_return_t=
hunk>
> >    0xffffffff818f0cc7 <+39>:  endbr64
> >    0xffffffff818f0ccb <+43>:  mov    %r14,%rdi
> >    0xffffffff818f0cce <+46>:  mov    %ebp,%esi
> >    0xffffffff818f0cd0 <+48>:  mov    %rbx,%rdx
> >    0xffffffff818f0cd3 <+51>:  call   0xffffffff81903230 <selinux_file_i=
octl>
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^
> >    Direct call to SELinux.
> >
> >    0xffffffff818f0cd8 <+56>:  test   %eax,%eax
> >    0xffffffff818f0cda <+58>:  jne    0xffffffff818f0cbd <security_file_=
ioctl+29>
> >    0xffffffff818f0cdc <+60>:  jmp    0xffffffff818f0cb7 <security_file_=
ioctl+23>
> >    0xffffffff818f0cde <+62>:  endbr64
> >    0xffffffff818f0ce2 <+66>:  mov    %r14,%rdi
> >    0xffffffff818f0ce5 <+69>:  mov    %ebp,%esi
> >    0xffffffff818f0ce7 <+71>:  mov    %rbx,%rdx
> >    0xffffffff818f0cea <+74>:  call   0xffffffff8141e220 <bpf_lsm_file_i=
octl>
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^
> >    Direct call to BPF LSM.
> >
> >    0xffffffff818f0cef <+79>:  test   %eax,%eax
> >    0xffffffff818f0cf1 <+81>:  jne    0xffffffff818f0cbd <security_file_=
ioctl+29>
> >    0xffffffff818f0cf3 <+83>:  jmp    0xffffffff818f0cb9 <security_file_=
ioctl+25>
> >    0xffffffff818f0cf5 <+85>:  endbr64
> >    0xffffffff818f0cf9 <+89>:  mov    %r14,%rdi
> >    0xffffffff818f0cfc <+92>:  mov    %ebp,%esi
> >    0xffffffff818f0cfe <+94>:  mov    %rbx,%rdx
> >    0xffffffff818f0d01 <+97>:  pop    %rbx
> >    0xffffffff818f0d02 <+98>:  pop    %r14
> >    0xffffffff818f0d04 <+100>: pop    %rbp
> >    0xffffffff818f0d05 <+101>: ret
> >    0xffffffff818f0d06 <+102>: int3
> >    0xffffffff818f0d07 <+103>: int3
> >    0xffffffff818f0d08 <+104>: int3
> >    0xffffffff818f0d09 <+105>: int3
> >
> > While this patch uses static_branch_unlikely indicating that an LSM hoo=
k
> > is likely to be not present, a subsequent makes it configurable. In mos=
t
> > cases this is still a better choice as even when an LSM with one hook i=
s
> > added, empty slots are created for all LSM hooks (especially when many
> > LSMs that do not initialize most hooks are present on the system).
> >
> > There are some hooks that don't use the call_int_hook and
> > call_void_hook. These hooks are updated to use a new macro called
> > security_for_each_hook where the lsm_callback is directly invoked as an
> > indirect call. Currently, there are no performance sensitive hooks that
> > use the security_for_each_hook macro. However, if, some performance
> > sensitive hooks are discovered, these can be updated to use static call=
s
> > with loop unrolling as well using a custom macro.
> >
> > [1] https://lore.kernel.org/linux-security-module/20220609234601.202636=
2-1-kpsingh@kernel.org/
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Good job on reducing the impact in security.c.
>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>
> > ---
> >  include/linux/lsm_hooks.h |  70 +++++++++++--
> >  security/security.c       | 208 +++++++++++++++++++++++++-------------
> >  2 files changed, 199 insertions(+), 79 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index dcb5e5b5eb13..eb9afe93496f 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -29,26 +29,77 @@
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
> >
> >  union security_list_options {
> >       #define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__=
);
> >       #include "lsm_hook_defs.h"
> >       #undef LSM_HOOK
> > +     void *lsm_callback;
> >  };
> >
> > -struct security_hook_heads {
> > -     #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> > -     #include "lsm_hook_defs.h"
> > +/*
> > + * @key: static call key as defined by STATIC_CALL_KEY
> > + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> > + * @hl: The security_hook_list as initialized by the owning LSM.
> > + * @active: Enabled when the static call has an LSM hook associated.
> > + */
> > +struct lsm_static_call {
> > +     struct static_call_key *key;
> > +     void *trampoline;
> > +     struct security_hook_list *hl;
> > +     /* this needs to be true or false based on what the key defaults =
to */
> > +     struct static_key_false *active;
> > +};
> > +
> > +/*
> > + * Table of the static calls for each LSM hook.
> > + * Once the LSMs are initialized, their callbacks will be copied to th=
ese
> > + * tables such that the calls are filled backwards (from last to first=
).
> > + * This way, we can jump directly to the first used static call, and e=
xecute
> > + * all of them after. This essentially makes the entry point
> > + * dynamic to adapt the number of static calls to the number of callba=
cks.
> > + */
> > +struct lsm_static_calls_table {
> > +     #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> > +             struct lsm_static_call NAME[MAX_LSM_COUNT];
> > +     #include <linux/lsm_hook_defs.h>
> >       #undef LSM_HOOK
> >  } __randomize_layout;
> >
> >  /*
> >   * Security module hook list structure.
> >   * For use with generic list macros for common operations.
> > + *
> > + * struct security_hook_list - Contents of a cacheable, mappable objec=
t.
> > + * @scalls: The beginning of the array of static calls assigned to thi=
s hook.
> > + * @hook: The callback for the hook.
> > + * @lsm: The name of the lsm that owns this hook.
> >   */
> >  struct security_hook_list {
> > -     struct hlist_node               list;
> > -     struct hlist_head               *head;
> > +     struct lsm_static_call  *scalls;
> >       union security_list_options     hook;
> >       const char                      *lsm;
> >  } __randomize_layout;
> > @@ -97,10 +148,12 @@ static inline struct xattr *lsm_get_xattr_slot(str=
uct xattr *xattrs,
> >   * care of the common case and reduces the amount of
> >   * text involved.
> >   */
> > -#define LSM_HOOK_INIT(HEAD, HOOK) \
> > -     { .head =3D &security_hook_heads.HEAD, .hook =3D { .HEAD =3D HOOK=
 } }
> > +#define LSM_HOOK_INIT(NAME, CALLBACK)                        \
> > +     {                                               \
> > +             .scalls =3D static_calls_table.NAME,      \
> > +             .hook =3D { .NAME =3D CALLBACK }            \
> > +     }
> >
> > -extern struct security_hook_heads security_hook_heads;
> >  extern char *lsm_names;
> >
> >  extern void security_add_hooks(struct security_hook_list *hooks, int c=
ount,
> > @@ -138,5 +191,6 @@ extern struct lsm_info __start_early_lsm_info[], __=
end_early_lsm_info[];
> >               __aligned(sizeof(unsigned long))
> >
> >  extern int lsm_inode_alloc(struct inode *inode);
> > +extern struct lsm_static_calls_table static_calls_table __ro_after_ini=
t;
> >
> >  #endif /* ! __LINUX_LSM_HOOKS_H */
> > diff --git a/security/security.c b/security/security.c
> > index 7b0052e96806..c2c2cf6b711f 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -30,6 +30,8 @@
> >  #include <linux/string.h>
> >  #include <linux/msg.h>
> >  #include <net/flow.h>
> > +#include <linux/static_call.h>
> > +#include <linux/jump_label.h>
> >
> >  /* How many LSMs were built into the kernel? */
> >  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> > @@ -73,7 +75,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENT=
IALITY_MAX + 1] =3D {
> >       [LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
> >  };
> >
> > -struct security_hook_heads security_hook_heads __ro_after_init;
> >  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> >
> >  static struct kmem_cache *lsm_file_cache;
> > @@ -92,6 +93,51 @@ static __initconst const char *const builtin_lsm_ord=
er =3D CONFIG_LSM;
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
> > +
> > +/*
> > + * Initialise a table of static calls for each LSM hook.
> > + * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CA=
LL_KEY)
> > + * and a trampoline (STATIC_CALL_TRAMP) which are used to call
> > + * __static_call_update when updating the static call.
> > + */
> > +struct lsm_static_calls_table static_calls_table __ro_after_init =3D {
> > +#define INIT_LSM_STATIC_CALL(NUM, NAME)                               =
       \
> > +     (struct lsm_static_call) {                                      \
> > +             .key =3D &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),   =
 \
> > +             .trampoline =3D LSM_HOOK_TRAMP(NAME, NUM),               =
 \
> > +             .active =3D &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),        =
 \
> > +     },
> > +#define LSM_HOOK(RET, DEFAULT, NAME, ...)                            \
> > +     .NAME =3D {                                                      =
 \
> > +             LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)           \
> > +     },
> > +#include <linux/lsm_hook_defs.h>
> > +#undef LSM_HOOK
> > +#undef INIT_LSM_STATIC_CALL
> > +};
> > +
> >  static __initdata bool debug;
> >  #define init_debug(...)                                              \
> >       do {                                                    \
> > @@ -152,7 +198,7 @@ static void __init append_ordered_lsm(struct lsm_in=
fo *lsm, const char *from)
> >       if (exists_ordered_lsm(lsm))
> >               return;
> >
> > -     if (WARN(last_lsm =3D=3D LSM_COUNT, "%s: out of LSM slots!?\n", f=
rom))
> > +     if (WARN(last_lsm =3D=3D LSM_COUNT, "%s: out of LSM static calls!=
?\n", from))
> >               return;
> >
> >       /* Enable this LSM, if it is not already set. */
> > @@ -325,6 +371,25 @@ static void __init ordered_lsm_parse(const char *o=
rder, const char *origin)
> >       kfree(sep);
> >  }
> >
> > +static void __init lsm_static_call_init(struct security_hook_list *hl)
> > +{
> > +     struct lsm_static_call *scall =3D hl->scalls;
> > +     int i;
> > +
> > +     for (i =3D 0; i < MAX_LSM_COUNT; i++) {
> > +             /* Update the first static call that is not used yet */
> > +             if (!scall->hl) {
> > +                     __static_call_update(scall->key, scall->trampolin=
e,
> > +                                          hl->hook.lsm_callback);
> > +                     scall->hl =3D hl;
> > +                     static_branch_enable(scall->active);
> > +                     return;
> > +             }
> > +             scall++;
> > +     }
> > +     panic("%s - Ran out of static slots.\n", __func__);
> > +}
> > +
> >  static void __init lsm_early_cred(struct cred *cred);
> >  static void __init lsm_early_task(struct task_struct *task);
> >
> > @@ -404,11 +469,6 @@ int __init early_security_init(void)
> >  {
> >       struct lsm_info *lsm;
> >
> > -#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> > -     INIT_HLIST_HEAD(&security_hook_heads.NAME);
> > -#include "linux/lsm_hook_defs.h"
> > -#undef LSM_HOOK
> > -
> >       for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; =
lsm++) {
> >               if (!lsm->enabled)
> >                       lsm->enabled =3D &lsm_enabled_true;
> > @@ -524,7 +584,7 @@ void __init security_add_hooks(struct security_hook=
_list *hooks, int count,
> >
> >       for (i =3D 0; i < count; i++) {
> >               hooks[i].lsm =3D lsm;
> > -             hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> > +             lsm_static_call_init(&hooks[i]);
> >       }
> >
> >       /*
> > @@ -762,29 +822,41 @@ static int lsm_superblock_alloc(struct super_bloc=
k *sb)
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
> > +#define call_void_hook(FUNC, ...)                                 \
> > +     do {                                                      \
> > +             LSM_LOOP_UNROLL(__CALL_STATIC_VOID, FUNC, __VA_ARGS__); \
> >       } while (0)
> >
> > -#define call_int_hook(FUNC, IRC, ...) ({                     \
> > -     int RC =3D IRC;                                           \
> > -     do {                                                    \
> > -             struct security_hook_list *P;                   \
> > -                                                             \
> > -             hlist_for_each_entry(P, &security_hook_heads.FUNC, list) =
{ \
> > -                     RC =3D P->hook.FUNC(__VA_ARGS__);         \
> > -                     if (RC !=3D 0)                            \
> > -                             break;                          \
> > -             }                                               \
> > -     } while (0);                                            \
> > -     RC;                                                     \
> > +#define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)                   =
    \
> > +do {                                                                  =
    \
> > +     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {  \
> > +             R =3D static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__=
);    \
> > +             if (R !=3D 0)                                            =
      \
> > +                     goto LABEL;                                      =
    \
> > +     }                                                                =
    \
> > +} while (0);
> > +
> > +#define call_int_hook(FUNC, IRC, ...)                                 =
       \
> > +({                                                                   \
> > +     __label__ out;                                                  \
> > +     int RC =3D IRC;                                                  =
 \
> > +     LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, FUNC, out, __VA_ARGS__); \
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
> > +
> >  /* Security operations */
> >
> >  /**
> > @@ -1020,7 +1092,7 @@ int security_settime64(const struct timespec64 *t=
s, const struct timezone *tz)
> >   */
> >  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int cap_sys_admin =3D 1;
> >       int rc;
> >
> > @@ -1031,8 +1103,8 @@ int security_vm_enough_memory_mm(struct mm_struct=
 *mm, long pages)
> >        * agree that it should be set it will. If any module
> >        * thinks it should not be set it won't.
> >        */
> > -     hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, l=
ist) {
> > -             rc =3D hp->hook.vm_enough_memory(mm, pages);
> > +     lsm_for_each_hook(scall, vm_enough_memory) {
> > +             rc =3D scall->hl->hook.vm_enough_memory(mm, pages);
> >               if (rc <=3D 0) {
> >                       cap_sys_admin =3D 0;
> >                       break;
> > @@ -1184,13 +1256,12 @@ int security_fs_context_dup(struct fs_context *=
fc, struct fs_context *src_fc)
> >  int security_fs_context_parse_param(struct fs_context *fc,
> >                                   struct fs_parameter *param)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int trc;
> >       int rc =3D -ENOPARAM;
> >
> > -     hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_pa=
ram,
> > -                          list) {
> > -             trc =3D hp->hook.fs_context_parse_param(fc, param);
> > +     lsm_for_each_hook(scall, fs_context_parse_param) {
> > +             trc =3D scall->hl->hook.fs_context_parse_param(fc, param)=
;
> >               if (trc =3D=3D 0)
> >                       rc =3D 0;
> >               else if (trc !=3D -ENOPARAM)
> > @@ -1553,19 +1624,19 @@ int security_dentry_init_security(struct dentry=
 *dentry, int mode,
> >                                 const char **xattr_name, void **ctx,
> >                                 u32 *ctxlen)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int rc;
> >
> >       /*
> >        * Only one module will provide a security context.
> >        */
> > -     hlist_for_each_entry(hp, &security_hook_heads.dentry_init_securit=
y,
> > -                          list) {
> > -             rc =3D hp->hook.dentry_init_security(dentry, mode, name,
> > +     lsm_for_each_hook(scall, dentry_init_security) {
> > +             rc =3D scall->hl->hook.dentry_init_security(dentry, mode,=
 name,
> >                                                  xattr_name, ctx, ctxle=
n);
> >               if (rc !=3D LSM_RET_DEFAULT(dentry_init_security))
> >                       return rc;
> >       }
> > +
> >       return LSM_RET_DEFAULT(dentry_init_security);
> >  }
> >  EXPORT_SYMBOL(security_dentry_init_security);
> > @@ -1625,7 +1696,7 @@ int security_inode_init_security(struct inode *in=
ode, struct inode *dir,
> >                                const struct qstr *qstr,
> >                                const initxattrs initxattrs, void *fs_da=
ta)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       struct xattr *new_xattrs =3D NULL;
> >       int ret =3D -EOPNOTSUPP, xattr_count =3D 0;
> >
> > @@ -1643,9 +1714,8 @@ int security_inode_init_security(struct inode *in=
ode, struct inode *dir,
> >                       return -ENOMEM;
> >       }
> >
> > -     hlist_for_each_entry(hp, &security_hook_heads.inode_init_security=
,
> > -                          list) {
> > -             ret =3D hp->hook.inode_init_security(inode, dir, qstr, ne=
w_xattrs,
> > +     lsm_for_each_hook(scall, inode_init_security) {
> > +             ret =3D scall->hl->hook.inode_init_security(inode, dir, q=
str, new_xattrs,
> >                                                 &xattr_count);
> >               if (ret && ret !=3D -EOPNOTSUPP)
> >                       goto out;
> > @@ -2405,7 +2475,7 @@ int security_inode_getsecurity(struct mnt_idmap *=
idmap,
> >                              struct inode *inode, const char *name,
> >                              void **buffer, bool alloc)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int rc;
> >
> >       if (unlikely(IS_PRIVATE(inode)))
> > @@ -2413,9 +2483,8 @@ int security_inode_getsecurity(struct mnt_idmap *=
idmap,
> >       /*
> >        * Only one module will provide an attribute with a given name.
> >        */
> > -     hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, =
list) {
> > -             rc =3D hp->hook.inode_getsecurity(idmap, inode, name, buf=
fer,
> > -                                             alloc);
> > +     lsm_for_each_hook(scall, inode_getsecurity) {
> > +             rc =3D scall->hl->hook.inode_getsecurity(idmap, inode, na=
me, buffer, alloc);
> >               if (rc !=3D LSM_RET_DEFAULT(inode_getsecurity))
> >                       return rc;
> >       }
> > @@ -2440,7 +2509,7 @@ int security_inode_getsecurity(struct mnt_idmap *=
idmap,
> >  int security_inode_setsecurity(struct inode *inode, const char *name,
> >                              const void *value, size_t size, int flags)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int rc;
> >
> >       if (unlikely(IS_PRIVATE(inode)))
> > @@ -2448,9 +2517,8 @@ int security_inode_setsecurity(struct inode *inod=
e, const char *name,
> >       /*
> >        * Only one module will provide an attribute with a given name.
> >        */
> > -     hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, =
list) {
> > -             rc =3D hp->hook.inode_setsecurity(inode, name, value, siz=
e,
> > -                                             flags);
> > +     lsm_for_each_hook(scall, inode_setsecurity) {
> > +             rc =3D scall->hl->hook.inode_setsecurity(inode, name, val=
ue, size, flags);
> >               if (rc !=3D LSM_RET_DEFAULT(inode_setsecurity))
> >                       return rc;
> >       }
> > @@ -2524,7 +2592,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
> >   */
> >  int security_inode_copy_up_xattr(const char *name)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int rc;
> >
> >       /*
> > @@ -2532,9 +2600,8 @@ int security_inode_copy_up_xattr(const char *name=
)
> >        * xattr), -EOPNOTSUPP if it does not know anything about the xat=
tr or
> >        * any other error code in case of an error.
> >        */
> > -     hlist_for_each_entry(hp,
> > -                          &security_hook_heads.inode_copy_up_xattr, li=
st) {
> > -             rc =3D hp->hook.inode_copy_up_xattr(name);
> > +     lsm_for_each_hook(scall, inode_copy_up_xattr) {
> > +             rc =3D scall->hl->hook.inode_copy_up_xattr(name);
> >               if (rc !=3D LSM_RET_DEFAULT(inode_copy_up_xattr))
> >                       return rc;
> >       }
> > @@ -3414,10 +3481,10 @@ int security_task_prctl(int option, unsigned lo=
ng arg2, unsigned long arg3,
> >  {
> >       int thisrc;
> >       int rc =3D LSM_RET_DEFAULT(task_prctl);
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >
> > -     hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
> > -             thisrc =3D hp->hook.task_prctl(option, arg2, arg3, arg4, =
arg5);
> > +     lsm_for_each_hook(scall, task_prctl) {
> > +             thisrc =3D scall->hl->hook.task_prctl(option, arg2, arg3,=
 arg4, arg5);
> >               if (thisrc !=3D LSM_RET_DEFAULT(task_prctl)) {
> >                       rc =3D thisrc;
> >                       if (thisrc !=3D 0)
> > @@ -3814,12 +3881,12 @@ EXPORT_SYMBOL(security_d_instantiate);
> >  int security_getprocattr(struct task_struct *p, const char *lsm,
> >                        const char *name, char **value)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >
> > -     hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) =
{
> > -             if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
> > +     lsm_for_each_hook(scall, getprocattr) {
> > +             if (lsm !=3D NULL && strcmp(lsm, scall->hl->lsm))
> >                       continue;
> > -             return hp->hook.getprocattr(p, name, value);
> > +             return scall->hl->hook.getprocattr(p, name, value);
> >       }
> >       return LSM_RET_DEFAULT(getprocattr);
> >  }
> > @@ -3839,12 +3906,12 @@ int security_getprocattr(struct task_struct *p,=
 const char *lsm,
> >  int security_setprocattr(const char *lsm, const char *name, void *valu=
e,
> >                        size_t size)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >
> > -     hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) =
{
> > -             if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
> > +     lsm_for_each_hook(scall, setprocattr) {
> > +             if (lsm !=3D NULL && strcmp(lsm, scall->hl->lsm))
> >                       continue;
> > -             return hp->hook.setprocattr(name, value, size);
> > +             return scall->hl->hook.setprocattr(name, value, size);
> >       }
> >       return LSM_RET_DEFAULT(setprocattr);
> >  }
> > @@ -3896,15 +3963,15 @@ EXPORT_SYMBOL(security_ismaclabel);
> >   */
> >  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int rc;
> >
> >       /*
> >        * Currently, only one LSM can implement secid_to_secctx (i.e thi=
s
> >        * LSM hook is not "stackable").
> >        */
> > -     hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, li=
st) {
> > -             rc =3D hp->hook.secid_to_secctx(secid, secdata, seclen);
> > +     lsm_for_each_hook(scall, secid_to_secctx) {
> > +             rc =3D scall->hl->hook.secid_to_secctx(secid, secdata, se=
clen);
> >               if (rc !=3D LSM_RET_DEFAULT(secid_to_secctx))
> >                       return rc;
> >       }
> > @@ -4947,7 +5014,7 @@ int security_xfrm_state_pol_flow_match(struct xfr=
m_state *x,
> >                                      struct xfrm_policy *xp,
> >                                      const struct flowi_common *flic)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int rc =3D LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
> >
> >       /*
> > @@ -4959,9 +5026,8 @@ int security_xfrm_state_pol_flow_match(struct xfr=
m_state *x,
> >        * For speed optimization, we explicitly break the loop rather th=
an
> >        * using the macro
> >        */
> > -     hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow=
_match,
> > -                          list) {
> > -             rc =3D hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
> > +     lsm_for_each_hook(scall, xfrm_state_pol_flow_match) {
> > +             rc =3D scall->hl->hook.xfrm_state_pol_flow_match(x, xp, f=
lic);
> >               break;
> >       }
> >       return rc;

