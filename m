Return-Path: <bpf+bounces-13867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB477DE9A6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50AD5B2103A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F810E7;
	Thu,  2 Nov 2023 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuISDnSn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C6372
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 00:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28299C433CB
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 00:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698885987;
	bh=jmZ6JK5yc8r3VLqVSAB2x19ipb6u/KQQFmQVR4i0uEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LuISDnSnDphPdkjtvWERV+rlOI6OTcIKzgDCIAybhgdP77I30CJcaDi3vRqkiKKy/
	 fPBQXD6Z1RvSHOJ/ai4w2bUpFtODgZjn1yueT/N4YUXcurdNj/UwNkTnQKCX9nYeUd
	 95McsYLX5TBJ8AQpnPryxrcd55Jd25nrC4xQ/UPrxKKlJiuTbyV6N7bVnhMOJxfVVF
	 ke6bIPLgQ+vZGp+i8Pc9jG/8Mm9Vqxy+pnXPqfgRiwS7+4VcMEo+xuBZypKQR6kb0y
	 0gZ1DC0HfyFzh10sgYVoyz8Z6NSZJaWh2dvHoLpU5ZRVYlCFDOdVD8lQRvNfu4yPK8
	 hGOIk+t3sN9Hg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507a62d4788so433579e87.0
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 17:46:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YxuBUgupIuQuFfc+6iu9dKh/H3jCzlT7mSW12FT20iMh9/7MmO6
	OjJHdBd9S8gGD2JN2CetTCJ/c99sRdeNGFpK9okELw==
X-Google-Smtp-Source: AGHT+IHz6TnrkYQJRZVzs3muywyfLzw13BeplImjzMKnd96+76aXNDvi5vhVmb+gBkxS231NNt7Su2GXya1gdeeWy+g=
X-Received: by 2002:a19:ac0a:0:b0:4ff:a04c:8a5b with SMTP id
 g10-20020a19ac0a000000b004ffa04c8a5bmr11878036lfc.47.1698885985273; Wed, 01
 Nov 2023 17:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006204701.549230-1-kpsingh@kernel.org> <20231006204701.549230-5-kpsingh@kernel.org>
 <ZSPRrtkKtf9WyBOy@krava>
In-Reply-To: <ZSPRrtkKtf9WyBOy@krava>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 2 Nov 2023 01:46:14 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5PKECadW+B9ybJUidDb6SVb6L4A2xWqwh6ybkhfZ+eag@mail.gmail.com>
Message-ID: <CACYkzJ5PKECadW+B9ybJUidDb6SVb6L4A2xWqwh6ybkhfZ+eag@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 9, 2023 at 12:11=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Oct 06, 2023 at 10:47:00PM +0200, KP Singh wrote:
> > BPF LSM hooks have side-effects (even when a default value is returned)=
,
> > as some hooks end up behaving differently due to the very presence of
> > the hook.
> >
> > The static keys guarding the BPF LSM hooks are disabled by default and
> > enabled only when a BPF program is attached implementing the hook
> > logic. This avoids the issue of the side-effects and also the minor
> > overhead associated with the empty callback.
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
> >    0xffffffff818f0e45 <+21>:  jmp    0xffffffff818f0e57 <security_file_=
ioctl+39>
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^
> >
> >    Static key enabled for SELinux
> >
> >    0xffffffff818f0e47 <+23>:  xchg   %ax,%ax
> >                               ^^^^^^^^^^^^^^
> >
> >    Static key disabled for BPF. This gets patched when a BPF LSM progra=
m
> >    is attached
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
> >    0xffffffff818f0e63 <+51>:  call   0xffffffff819033c0 <selinux_file_i=
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
> >    0xffffffff818f0e7a <+74>:  call   0xffffffff8141e3b0 <bpf_lsm_file_i=
octl>
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
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> small nit, but looks good
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
>
> > ---
> >  include/linux/bpf_lsm.h   |  5 +++++
> >  include/linux/lsm_hooks.h | 13 ++++++++++++-
> >  kernel/bpf/trampoline.c   | 24 ++++++++++++++++++++++++
> >  security/bpf/hooks.c      | 25 ++++++++++++++++++++++++-
> >  security/security.c       |  3 ++-
> >  5 files changed, 67 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index 1de7ece5d36d..5bbc31ac948c 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog=
,
> >
> >  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
> >  bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
> > +void bpf_lsm_toggle_hook(void *addr, bool value);
>
> nit, this could be static, unless there are future plans ;-)

Actually, this is called from trampoline.c and cannot be static.

- KP

>
> >
> >  static inline struct bpf_storage_blob *bpf_inode(
> >       const struct inode *inode)
> > @@ -78,6 +79,10 @@ static inline void bpf_lsm_find_cgroup_shim(const st=
ruct bpf_prog *prog,
> >  {
> >  }
> >
> > +static inline void bpf_lsm_toggle_hook(void *addr, bool value)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_BPF_LSM */
> >
> >  #endif /* _LINUX_BPF_LSM_H */
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index c77a1859214d..57ffe4eb6d30 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -97,11 +97,14 @@ struct lsm_static_calls_table {
> >   * @scalls: The beginning of the array of static calls assigned to thi=
s hook.
> >   * @hook: The callback for the hook.
> >   * @lsm: The name of the lsm that owns this hook.
> > + * @default_state: The state of the LSM hook when initialized. If set =
to false,
> > + * the static key guarding the hook will be set to disabled.
> >   */
> >  struct security_hook_list {
> >       struct lsm_static_call  *scalls;
> >       union security_list_options     hook;
> >       const char                      *lsm;
> > +     bool                            default_state;
> >  } __randomize_layout;
> >
> >  /*
> > @@ -151,7 +154,15 @@ static inline struct xattr *lsm_get_xattr_slot(str=
uct xattr *xattrs,
> >  #define LSM_HOOK_INIT(NAME, CALLBACK)                        \
> >       {                                               \
> >               .scalls =3D static_calls_table.NAME,      \
> > -             .hook =3D { .NAME =3D CALLBACK }            \
> > +             .hook =3D { .NAME =3D CALLBACK },           \
> > +             .default_state =3D true                   \
> > +     }
> > +
> > +#define LSM_HOOK_INIT_DISABLED(NAME, CALLBACK)               \
> > +     {                                               \
> > +             .scalls =3D static_calls_table.NAME,      \
> > +             .hook =3D { .NAME =3D CALLBACK },           \
> > +             .default_state =3D false                  \
> >       }
> >
> >  extern char *lsm_names;
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index e97aeda3a86b..44788e2eaa1b 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/bpf_verifier.h>
> >  #include <linux/bpf_lsm.h>
> >  #include <linux/delay.h>
> > +#include <linux/bpf_lsm.h>
> >
> >  /* dummy _ops. The verifier will operate on target program's ops. */
> >  const struct bpf_verifier_ops bpf_extension_verifier_ops =3D {
> > @@ -510,6 +511,21 @@ static enum bpf_tramp_prog_type bpf_attach_type_to=
_tramp(struct bpf_prog *prog)
> >       }
> >  }
> >
> > +static void bpf_trampoline_toggle_lsm(struct bpf_trampoline *tr,
> > +                                   enum bpf_tramp_prog_type kind)
> > +{
> > +     struct bpf_tramp_link *link;
> > +     bool found =3D false;
> > +
> > +     hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
> > +             if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > +                     found  =3D true;
> > +                     break;
> > +             }
> > +     }
> > +     bpf_lsm_toggle_hook(tr->func.addr, found);
> > +}
> > +
> >  static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, str=
uct bpf_trampoline *tr)
> >  {
> >       enum bpf_tramp_prog_type kind;
> > @@ -549,6 +565,10 @@ static int __bpf_trampoline_link_prog(struct bpf_t=
ramp_link *link, struct bpf_tr
> >
> >       hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
> >       tr->progs_cnt[kind]++;
> > +
> > +     if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > +             bpf_trampoline_toggle_lsm(tr, kind);
> > +
> >       err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> >       if (err) {
> >               hlist_del_init(&link->tramp_hlist);
> > @@ -582,6 +602,10 @@ static int __bpf_trampoline_unlink_prog(struct bpf=
_tramp_link *link, struct bpf_
> >       }
> >       hlist_del_init(&link->tramp_hlist);
> >       tr->progs_cnt[kind]--;
> > +
> > +     if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > +             bpf_trampoline_toggle_lsm(tr, kind);
> > +
> >       return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> >  }
> >
> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > index cfaf1d0e6a5f..47e1a4777ec9 100644
> > --- a/security/bpf/hooks.c
> > +++ b/security/bpf/hooks.c
> > @@ -8,7 +8,7 @@
> >
> >  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init =3D {
> >       #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> > -     LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> > +     LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
> >       #include <linux/lsm_hook_defs.h>
> >       #undef LSM_HOOK
> >       LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> > @@ -32,3 +32,26 @@ DEFINE_LSM(bpf) =3D {
> >       .init =3D bpf_lsm_init,
> >       .blobs =3D &bpf_lsm_blob_sizes
> >  };
> > +
> > +void bpf_lsm_toggle_hook(void *addr, bool value)
> > +{
> > +     struct lsm_static_call *scalls;
> > +     struct security_hook_list *h;
> > +     int i, j;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
> > +             h =3D &bpf_lsm_hooks[i];
> > +             if (h->hook.lsm_callback !=3D addr)
> > +                     continue;
> > +
> > +             for (j =3D 0; j < MAX_LSM_COUNT; j++) {
> > +                     scalls =3D &h->scalls[j];
> > +                     if (scalls->hl !=3D &bpf_lsm_hooks[i])
> > +                             continue;
> > +                     if (value)
> > +                             static_branch_enable(scalls->active);
> > +                     else
> > +                             static_branch_disable(scalls->active);
> > +             }
> > +     }
> > +}
> > diff --git a/security/security.c b/security/security.c
> > index ce4c0a9107ea..f45e875b6d93 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -382,7 +382,8 @@ static void __init lsm_static_call_init(struct secu=
rity_hook_list *hl)
> >                       __static_call_update(scall->key, scall->trampolin=
e,
> >                                            hl->hook.lsm_callback);
> >                       scall->hl =3D hl;
> > -                     static_branch_enable(scall->active);
> > +                     if (hl->default_state)
> > +                             static_branch_enable(scall->active);
> >                       return;
> >               }
> >               scall++;
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
> >

