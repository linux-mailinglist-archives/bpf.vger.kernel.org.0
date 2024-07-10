Return-Path: <bpf+bounces-34485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9892DC72
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 01:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D47D2830D0
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 23:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866014F9C5;
	Wed, 10 Jul 2024 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1+XfB5a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595B12BF23
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653353; cv=none; b=NMTOboxQVqMqZ14DeMVuJNOWOF8KdgR+Xi2Dbuzp+waWkrnKaCTu4LTMNSVSKr1GGJhnBe1+83lfM6m2GRGle6ipXKF/TrC3AF+t+w5KlrrKB0xzz7ihEzatr6HEGa1SD5+ylLUoJxu/9pBCw2tGeiMz2eVOK2vGlNM1RAMq74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653353; c=relaxed/simple;
	bh=97FLUtmU4HJT89z5jtI1w9UADdmkYNpPY2Utv+s2Cls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBKq1B9BrpMgpVqCprmGw1SfTuDqRdquHF7R/6QKgS3RMYeqwZ2Gbv6WZYH3fFmBUrrz0QjDwurgxP43FTcBj/ZTkpSovjb67+DoDrXqWlA9zFKYFGEntLdly51gS3tcNeVtVQka713VIrkaqV2x+hMtG7w6e9rp83NWDyEuYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1+XfB5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B49FC4AF09
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 23:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720653353;
	bh=97FLUtmU4HJT89z5jtI1w9UADdmkYNpPY2Utv+s2Cls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q1+XfB5auhaltcySKBLEuui8f5vwKWYXwLsqJT3v3qXrjrnTTAWPap3dpT1glZkQc
	 WdJbb6Hvei0FO8MFlU87Yz6mqSzeopzzEFKFgSTwECc16vT/79q3hJSgcJjY4HtZ3R
	 yaqxjdfawV93KQPk4cwxXS2gprerieV6N3QZdhY1tPArGkmvVIvrQtK9TUa4Gh+8pR
	 elegpcWPd13YnTibvp79tuPmTgy+1Z0kqHXLZlAEKOMwRKhpBB7N11FKNFvD+AdS7O
	 oXk9GjS1y1DNaTy7NdoByebElrdEckaEQ2f5uz8W3R8PlqIWKNSGD1lpGqK3FAVnZr
	 aKQHRC7IOsrLg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so438829a12.3
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 16:15:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3Uos5lWGycdSVbIL7ixgYQ1B4DhxBBP4thO1QABvJJK2kx94nwGEA0FaQ8QVjw0xfvo2vHPdswQ0hf9ds/EE8hKdD
X-Gm-Message-State: AOJu0YwIHBjLeuHkkWzYbJBay+CkyU/g0b77jlFlqVDrPQektwyl1A9f
	Ls4PraitqBztZbhLlIQnVm4Ha3XECOYz2dAHsVyt2xL61P1Ei4TmBt4HtpzfO1rAlBavMUEF+sF
	28CpVv8s7wjcnXEFRZoGNGKMa4XoFGqQAEy3I
X-Google-Smtp-Source: AGHT+IGr2V4LF1G8Eb2SMPuLiIeJSlBZdatPNJTj12WRyW6trJBwsbLli+UfOaLCjuW+x7bF6Xtwat83MwjQ3bpuHN4=
X-Received: by 2002:aa7:da54:0:b0:57d:ef3:c3b7 with SMTP id
 4fb4d7f45d1cf-594bbe2ba17mr3775696a12.36.1720653352023; Wed, 10 Jul 2024
 16:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710000500.208154-4-kpsingh@kernel.org> <b23e0868802853a9ab17e17fdc35c678@paul-moore.com>
In-Reply-To: <b23e0868802853a9ab17e17fdc35c678@paul-moore.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 11 Jul 2024 01:15:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com>
Message-ID: <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] security: Replace indirect LSM hook calls with
 static calls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Jul  9, 2024 KP Singh <kpsingh@kernel.org> wrote:
> >
> > LSM hooks are currently invoked from a linked list as indirect calls
> > which are invoked using retpolines as a mitigation for speculative
> > attacks (Branch History / Target injection) and add extra overhead whic=
h
> > is especially bad in kernel hot paths:
> >
> > security_file_ioctl:
> >    0xff...0320 <+0>:  endbr64
> >    0xff...0324 <+4>:  push   %rbp
> >    0xff...0325 <+5>:  push   %r15
> >    0xff...0327 <+7>:  push   %r14
> >    0xff...0329 <+9>:  push   %rbx
> >    0xff...032a <+10>: mov    %rdx,%rbx
> >    0xff...032d <+13>: mov    %esi,%ebp
> >    0xff...032f <+15>: mov    %rdi,%r14
> >    0xff...0332 <+18>: mov    $0xff...7030,%r15
> >    0xff...0339 <+25>: mov    (%r15),%r15
> >    0xff...033c <+28>: test   %r15,%r15
> >    0xff...033f <+31>: je     0xff...0358 <security_file_ioctl+56>
> >    0xff...0341 <+33>: mov    0x18(%r15),%r11
> >    0xff...0345 <+37>: mov    %r14,%rdi
> >    0xff...0348 <+40>: mov    %ebp,%esi
> >    0xff...034a <+42>: mov    %rbx,%rdx
> >
> >    0xff...034d <+45>: call   0xff...2e0 <__x86_indirect_thunk_array+352=
>
> >                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^
> >
> >     Indirect calls that use retpolines leading to overhead, not just du=
e
> >     to extra instruction but also branch misses.
> >
> >    0xff...0352 <+50>: test   %eax,%eax
> >    0xff...0354 <+52>: je     0xff...0339 <security_file_ioctl+25>
> >    0xff...0356 <+54>: jmp    0xff...035a <security_file_ioctl+58>
> >    0xff...0358 <+56>: xor    %eax,%eax
> >    0xff...035a <+58>: pop    %rbx
> >    0xff...035b <+59>: pop    %r14
> >    0xff...035d <+61>: pop    %r15
> >    0xff...035f <+63>: pop    %rbp
> >    0xff...0360 <+64>: jmp    0xff...47c4 <__x86_return_thunk>
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
>
> I don't want to rehash our previous discussions on this topic, but I do
> think we either need to simply delete the paragraph above or update it
> to indicate that all known side effects involving LSM callback return
> values have been addressed.  Removal is likely easier if for no other
> reason than we don't have to go back and forth with edits, but I can

Agreed, we can just delete this paragraph. Thanks!

- KP

> understand if you would prefer to have the paragraph in the commit
> description, albeit in a revised form.  If you want to go with the
> revised paragraph option, you don't need to keep resubmitting the
> patchset, once we agree on something I can do the paragraph swap when
> I merge the patchset.
>
> Otherwise, this patchset looks okay, but as I mentioned earlier, given
> we are at -rc7 this isn't something that I'm comfortable sending up to
> Linus during the upcoming merge window.  This is v6.12 material at this
> point.
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
> > There are some hooks that don't use the call_int_hook or
> > call_void_hook. These hooks are updated to use a new macro called
> > lsm_for_each_hook where the lsm_callback is directly invoked as an
> > indirect call.
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
> >  include/linux/lsm_hooks.h |  53 ++++++++--
> >  security/security.c       | 215 ++++++++++++++++++++++++++------------
> >  2 files changed, 195 insertions(+), 73 deletions(-)
>
> --
> paul-moore.com

