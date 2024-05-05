Return-Path: <bpf+bounces-28636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6848BC282
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A311C2042B
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9BF3C064;
	Sun,  5 May 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZcmSy3I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73EE54C
	for <bpf@vger.kernel.org>; Sun,  5 May 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714926334; cv=none; b=CCWFtfVwkSXvzm7D+37Eg8on5Olo9VlmUYVe/Zm+enr/B0jSGDRH0Cbxomu8b89rLQDFep7Id9Ihz7pInS58S60Vbbke5uiqt7Uw2dhn/mKj1vBO+/geWOptOioiiUxEa+rz6nFVmk1JOOqmjcIsrVdis4AB8p6xiH2oIK6nHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714926334; c=relaxed/simple;
	bh=s4JftUNg3BpOtCSPERy+H+sdZvOj4cNBfHhsrGnpQ5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tly00TyKskrBZBKBH8zTPuEMX9ZN273G7gjC+Z4QmoaGz+Zv4ULx2pWkDs7+7ter+tKZC4p4L0d6rxnHnnSjyDRgo+RzfQOzUz5T8pPvAN0L32DTZyiGaaoPyWsa55YZm917G0CN9bvdErWgYHj2fd5WIwRfBQ+kO1IlcPWYmds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZcmSy3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A718C4AF18
	for <bpf@vger.kernel.org>; Sun,  5 May 2024 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714926333;
	bh=s4JftUNg3BpOtCSPERy+H+sdZvOj4cNBfHhsrGnpQ5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CZcmSy3I7isqA9FYDSbRX/daPRnvBPGziE13VOlRAmHLHcfCqPG7ocGMUSUaCUvXY
	 U0oWFjU0jupjLkntO+S17Y1o7KejQnIsV/5vaEfUbenqx+NEKTGbmJFJ0Wy9mGJBPi
	 xCgoMz4l0JQ3Nd1YMG89jLJSUvSUi171kFpf2T52ylpAJqHYfpwsr/mY4xquugI/8W
	 kN1A5rH8PSthsoWXdPl2iq58fepFG2pLaix3d1cQMz4qxSJIxLigUMv3yHiLkxIcc/
	 QRiRb28qcNLrByEd3qRHNZAmueGm5r3yPmrQf4zN9u2yU2B1ZwSI+/6YaZTjoASTWs
	 6BenR6AcPa1ew==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso22489551fa.0
        for <bpf@vger.kernel.org>; Sun, 05 May 2024 09:25:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwEt8sndlnaVoMMy+6X+gsIcnipYi1ArKJzUBXM2hcr64JHAw2s
	kJzETVDkuQqw5yHDbujmXnqUGOO7T9TgFKbZ3CAEQtChSo+TI8uCxzaFO4gTz1USgDyYjE//5om
	EPheyL64eZ0Tu1NoxmDFDEM+HP4UN0pb7FGqm
X-Google-Smtp-Source: AGHT+IEEVG67tO/tn1sBqCzOgaT8k3fp83nxBCm9TvwgV/3jnxLgHNJGPhUr9Z6mMjHtFeA0kXzlyum2f1IKpy7Xoh0=
X-Received: by 2002:a2e:a0d2:0:b0:2db:a9c9:4c5e with SMTP id
 f18-20020a2ea0d2000000b002dba9c94c5emr7652441ljm.21.1714926331931; Sun, 05
 May 2024 09:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207124918.3498756-5-kpsingh@kernel.org> <f7e8a16b0815d9d901e019934d684c5f@paul-moore.com>
In-Reply-To: <f7e8a16b0815d9d901e019934d684c5f@paul-moore.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sun, 5 May 2024 18:25:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Pn+hA0yT0UeZEuwSr+ryytw5--Q0nUb+G+fWY5QMhRA@mail.gmail.com>
Message-ID: <CACYkzJ7Pn+hA0yT0UeZEuwSr+ryytw5--Q0nUb+G+fWY5QMhRA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To: Paul Moore <paul@paul-moore.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, andrii@kernel.org, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:38=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Feb  7, 2024 KP Singh <kpsingh@kernel.org> wrote:
> >
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
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
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
> > index ba63d8b54448..e95f0a5cb409 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -110,11 +110,14 @@ struct lsm_id {
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
> >       const struct lsm_id             *lsmid;
> > +     bool                            default_enabled;
>
> Ugh.  We've already got an lsm_static_call::active field, I don't want
> to see another enable/active/etc. flag unless there is absolutely no way
> this works otherwise.

The field default_enabled is used at the time of initialization. The
lsm_static_call::active is a static key which we really cannot use at
initialization time from the various LSMs directly. I don't see a way
out of this one IMHO.

>
> >  } __randomize_layout;
> >
> >  /*
> > @@ -164,7 +167,15 @@ static inline struct xattr *lsm_get_xattr_slot(str=
uct xattr *xattrs,
> >  #define LSM_HOOK_INIT(NAME, CALLBACK)                        \
> >       {                                               \
> >               .scalls =3D static_calls_table.NAME,      \
> > -             .hook =3D { .NAME =3D CALLBACK }            \
> > +             .hook =3D { .NAME =3D CALLBACK },           \
> > +             .default_enabled =3D true                 \
> > +     }
> > +
> > +#define LSM_HOOK_INIT_DISABLED(NAME, CALLBACK)               \
> > +     {                                               \
> > +             .scalls =3D static_calls_table.NAME,      \
> > +             .hook =3D { .NAME =3D CALLBACK },           \

[...]

               static_branch_disable(scalls->active);
> > +             }
> > +     }
> > +}
>
> More ugh.  If we're going to solve things this way, let's make it a
> proper LSM interface and not a BPF LSM specific hack; I *really* don't
> want to see individual LSMs managing the lsm_static_call or
> security_hook_list entries.
>

Fair, and that makes the implementation much simpler too. I created a
security_hook_toggle function in security.c which implements this
functionality.

- KP

> > diff --git a/security/security.c b/security/security.c
> > index e05d2157c95a..40d83da87f68 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -406,7 +406,8 @@ static void __init lsm_static_call_init(struct secu=
rity_hook_list *hl)
> >                       __static_call_update(scall->key, scall->trampolin=
e,
> >                                            hl->hook.lsm_callback);
> >                       scall->hl =3D hl;
> > -                     static_branch_enable(scall->active);
> > +                     if (hl->default_enabled)
> > +                             static_branch_enable(scall->active);
> >                       return;
> >               }
> >               scall++;
> > --
> > 2.43.0.594.gd9cf4e227d-goog
>
> --
> paul-moore.com

