Return-Path: <bpf+bounces-33783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8792667A
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9719283E33
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11F1836D0;
	Wed,  3 Jul 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm2NHPDS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1017B407
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025739; cv=none; b=oaeq3GULv7OMGi2AS9RDpabA+Gl7CpUYSOeiLrYLwMsvLPgToFYtBHTvUg2SIUDmQVOl4sqmXSaFf6oM0TLXD3VrliLc4xbg10R29u6Px1U2cdY7JFGSXDp1BV2viythzCONbfmVgFhXLhbbCxvuMX7tY1Ed3E7fq8jqOZWAaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025739; c=relaxed/simple;
	bh=zbSYZcx9k7ldEVXVIqqMZ9drSjQBNHn00gNwhqZtgdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIMYdEhhW9hWv2qGYSbbCI/MH0LBBNKPEtn+/qpAgSOqAt3BYuUcT5VBMaBtZ2wuZ5waORUS8cXwCStG4lMRu11HLeFpf5PtdPTotEFO2Tcibrd+tbesKxJMboCIlzq2EImJosFn3Z9xc63qwWKTSrORLJtuFuM/7HVwEoMcswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm2NHPDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AB8C4AF11
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720025739;
	bh=zbSYZcx9k7ldEVXVIqqMZ9drSjQBNHn00gNwhqZtgdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vm2NHPDStevnFe85znuk0AyguHCtB37lEc2ph/eXIezuV393sXc8HAmZG/hAxGjhk
	 fUZRFV0LgP6c98VQimYOtAsnz9g0DxzcP+SZOehLb+LasZ/XuuHQropD5m700l49Q1
	 ALInh+eWVvQ4KEQ8BsDUu5dOe0XcMbCp64IO9A1T8ihts3UrdLmJtifR/s96tpZPvi
	 nJNY0EOdgOhOnTVkGpiYuUjdx2+dWRlMtvhfa7qO3RqZrmsYMH55OvNYOnTM7PsBhl
	 u9MPrEJJ7mXoXNv+RfQUxHvxotK0uvvRGQeXk9szkeDQrIs65q/QHmdzmyy/xpwFrX
	 9smoxmOCgKsbQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso3988653a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 09:55:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJAXQ8aGv/xQWlHq9TozKDjtPYx9IfSZA2gifS9dxJ6g9e0lBHvWy6Nxm2ddBXbOnAWkxZW3BUEseCDCU5PNoxnvWP
X-Gm-Message-State: AOJu0YwcCainoqmBRlnMwGIoN08fMmD3wpYs+CcdwNrn2RHLLfNRc4Sq
	7jcOXUQjDD0CwNLvvXqUgCmF8ntdu3tgpkhLkOvfoLscamrCG+BLGIrtbScwHD6EZHkIfcRp3rT
	fNh+8lUVrPQWFsZ5pwd2aC5yu6OTWQ/1RykeO
X-Google-Smtp-Source: AGHT+IHzlUunL43xIXIdlW8y1PF7zcZLeaU3smzlRqch4vSESjwL1HqAi47OPvvcojDrkUMTPSyjWNie9S9Q/36wv3M=
X-Received: by 2002:a05:6402:3481:b0:58b:1737:1149 with SMTP id
 4fb4d7f45d1cf-58b17371464mr4441999a12.4.1720025738145; Wed, 03 Jul 2024
 09:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-6-kpsingh@kernel.org> <5e39b1c8134f25c822c3665cc1884c0b@paul-moore.com>
In-Reply-To: <5e39b1c8134f25c822c3665cc1884c0b@paul-moore.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 3 Jul 2024 18:55:27 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5VBRTy=7h4+fgpoqg0rbZZxw6kJOPiJVRJfMhCZAik1A@mail.gmail.com>
Message-ID: <CACYkzJ5VBRTy=7h4+fgpoqg0rbZZxw6kJOPiJVRJfMhCZAik1A@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
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
> > BPF LSM hooks have side-effects (even when a default value's returned)
> > as some hooks end up behaving differently due to the very presence of
> > the hook.
> >
> > The static keys guarding the BPF LSM hooks are disabled by default and
> > enabled only when a BPF program is attached implementing the hook
> > logic. This avoids the issue of the side-effects and also the minor
> > overhead associated with the empty callback.
> >
> > security_file_ioctl:
> >    0xff...0e30 <+0>:  endbr64
> >    0xff...0e34 <+4>:  nopl   0x0(%rax,%rax,1)
> >    0xff...0e39 <+9>:  push   %rbp
> >    0xff...0e3a <+10>: push   %r14
> >    0xff...0e3c <+12>: push   %rbx
> >    0xff...0e3d <+13>: mov    %rdx,%rbx
> >    0xff...0e40 <+16>: mov    %esi,%ebp
> >    0xff...0e42 <+18>: mov    %rdi,%r14
> >    0xff...0e45 <+21>: jmp    0xff...0e57 <security_file_ioctl+39>
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> >    Static key enabled for SELinux
> >
> >    0xff...0e47 <+23>: xchg   %ax,%ax
> >                       ^^^^^^^^^^^^^^
> >
> >    Static key disabled for BPF. This gets patched when a BPF LSM
> >    program is attached
> >
> >    0xff...0e49 <+25>: xor    %eax,%eax
> >    0xff...0e4b <+27>: xchg   %ax,%ax
> >    0xff...0e4d <+29>: pop    %rbx
> >    0xff...0e4e <+30>: pop    %r14
> >    0xff...0e50 <+32>: pop    %rbp
> >    0xff...0e51 <+33>: cs jmp 0xff...0000 <__x86_return_thunk>
> >    0xff...0e57 <+39>: endbr64
> >    0xff...0e5b <+43>: mov    %r14,%rdi
> >    0xff...0e5e <+46>: mov    %ebp,%esi
> >    0xff...0e60 <+48>: mov    %rbx,%rdx
> >    0xff...0e63 <+51>: call   0xff...33c0 <selinux_file_ioctl>
> >    0xff...0e68 <+56>: test   %eax,%eax
> >    0xff...0e6a <+58>: jne    0xff...0e4d <security_file_ioctl+29>
> >    0xff...0e6c <+60>: jmp    0xff...0e47 <security_file_ioctl+23>
> >    0xff...0e6e <+62>: endbr64
> >    0xff...0e72 <+66>: mov    %r14,%rdi
> >    0xff...0e75 <+69>: mov    %ebp,%esi
> >    0xff...0e77 <+71>: mov    %rbx,%rdx
> >    0xff...0e7a <+74>: call   0xff...e3b0 <bpf_lsm_file_ioctl>
> >    0xff...0e7f <+79>: test   %eax,%eax
> >    0xff...0e81 <+81>: jne    0xff...0e4d <security_file_ioctl+29>
> >    0xff...0e83 <+83>: jmp    0xff...0e49 <security_file_ioctl+25>
> >    0xff...0e85 <+85>: endbr64
> >    0xff...0e89 <+89>: mov    %r14,%rdi
> >    0xff...0e8c <+92>: mov    %ebp,%esi
> >    0xff...0e8e <+94>: mov    %rbx,%rdx
> >    0xff...0e91 <+97>: pop    %rbx
> >    0xff...0e92 <+98>: pop    %r14
> >    0xff...0e94 <+100>:        pop    %rbp
> >    0xff...0e95 <+101>:        ret
> >
> > This patch enables this by providing a LSM_HOOK_INIT_RUNTIME variant
> > that allows the LSMs to opt-in to hooks which can be toggled at runtime
> > which with security_toogle_hook.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++-
> >  kernel/bpf/trampoline.c   | 40 +++++++++++++++++++++++++++++++++++----
> >  security/bpf/hooks.c      |  2 +-
> >  security/security.c       | 36 ++++++++++++++++++++++++++++++++++-
> >  4 files changed, 101 insertions(+), 7 deletions(-)
>
> I didn't look at this one too closely, see my previous comments in
> patch 3/5, but I did catch one typo, see below ...
>
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index a66ca68485a2..dbe0f40f7f67 100644
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
> > +     bool                            runtime;
> >  } __randomize_layout;
>
> The comment header doesn't match the struct fields, "default_state" vs
> "runtime".

Good catch, apologies for the omission.

>
> --
> paul-moore.com

