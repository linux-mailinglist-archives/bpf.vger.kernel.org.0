Return-Path: <bpf+bounces-71231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B9BEAF42
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E073B742707
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C79A2E8DE3;
	Fri, 17 Oct 2025 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEhDZuxX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDA330B06
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719866; cv=none; b=UgQK5WgZpqVJBVHMKMFsYi3JTth91cQcemp1i5pKM69T0vplpluCLlp2ibOpgS7VNvVQqrcbg6FUD97LG4tDDTN5r4+AcRT/U77lFk1hBTqipWtfJCn48jnUSPhxpHgR4yUyAK0CsR6xe8IaxKR/cv0HYDO0SpLv8BjXoiI8Y4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719866; c=relaxed/simple;
	bh=DijK7mhWwYVOxIyzibTg54Wi4a9vb19C09kBTTuVa7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vut641dWRX6K559lLAL0LVpdyMdmo3qkFXSbmX7QEZ23bvJLJQNipWrXPyuDezvSFYHuNHotsWUx2RO/oqT5z3zNqqXiyD47jIUQ43Qb+dxtxhCLau8Z0K32gYIF7GPE5pOE+zfXvVXETID/koVsnC3O9Xp7YV7MvRDGtJc/1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEhDZuxX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-273a0aeed57so42061045ad.1
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760719864; x=1761324664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HZKLGC9mqTaVg3U9c9WAZWok5dj2ahWXAPGG4E8xx0=;
        b=CEhDZuxXmXXUg6OJ3FAb+J3D79pHKCA60N13hFgNDwte7uUyTwDa3UFhNAUf/BXzi0
         gX9HSZ3B0fH8o+RURIN91pGlh8KuctyFIhLi31D7iwxTEn3K96mYnCV8p/QtEXwPanL/
         tFyLF02pCk9qJW74iQBIdKFkSmTHnR5KApGWmOk6dET+U1AfQ5y7zD4D5okC7QUaVePs
         po0K/aco+Q0bP3HxTpr/9oWvKhPaXfrOcTYemV1PLEsupFpLK2e8Z5KEzz5CmzQIGmrD
         ppKjWPkN8Ami0KUrwK6g15+TLSbYglRIRlcTkPzsHVvpuS/2rTxh/pK5fvfDu2OUTs12
         S7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719864; x=1761324664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HZKLGC9mqTaVg3U9c9WAZWok5dj2ahWXAPGG4E8xx0=;
        b=jxG2ETOKRi5iW3x29zvVyQeMpmg8WdgjFO+xBIqjsXam76F4JZhXngBWohXBKEhFVj
         I32zTtlc0V3eW0piklNCqgAISVAemSEu5j89vBTCb511OZiIzcIAChF4WMd+0Q023uv1
         iaFycper027a3gK/JcHrnrwjMjEsNDZxFDZ1X7wibEIVkjCqc5l+B07NYoF7nJjk2Zvf
         DHhadWCOIbuDzhNnGfW8bWvNZsJfKYB5tJuV1paCbqXRGHeAlcvE4W5/XNBgV4RfW2lc
         guwG1PuuNN/Sx34az38p6Pu4jugA+SgVdSA5ZZdDzPAhSuOjpiVfKbdLcb+8gCwMwrJZ
         G01A==
X-Forwarded-Encrypted: i=1; AJvYcCUgZWVkOx7AFEPWrW9QC7pSjjdlNAgykhHLfQyylwaTC40arXb1Kkn1p9Z2jX25JumBX+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5ljej1meDdp/v6MTrF8kanhxgfNJtPqSL9oPjqJ2zDP+hmce
	xacieVPS66LIuAPBIzcf3SuLf2KX5p73269VJvZSr0qqBF8DHvpIjR1NOLKn6NQvGVzH2s/paXY
	zwkS5WYTepHRQ91AWcizC+POSqaSCpGI=
X-Gm-Gg: ASbGncvqbPkZB0I5D/wcfpl103Duz/JshWbayXG9LEiqomzM2+AjOELLibvHgQNdOe/
	2cZGL1ldNGBKIWZH+/tJYHKlF/2GWeJdQPUVyJstqTyX1IIMaXgsEqYlY4FwOFajP0//g4mLWdk
	YvQTlzssZUgKrDHaIlDJTCSRadyDSJLStQL8cFHjPn7HTsR751krs4iOD1hDYHsBbqV/xakkjbU
	BK6j0vop7yiX6sWpZrvzFUSltnrdSJE38edKVCTshpAgZWmsx9baBStCg==
X-Google-Smtp-Source: AGHT+IEmBdeyOwCA4D2F7P15szAuX41QHYg9bAmYX8+r+pj7USO0T3lmNP8zH5MMHFHZyZL5QH8SU6CRuNhPt/tB+zM=
X-Received: by 2002:a17:903:110e:b0:267:99be:628e with SMTP id
 d9443c01a7336-290918cbe20mr93895725ad.2.1760719864327; Fri, 17 Oct 2025
 09:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <20251015161155.120148-12-mykyta.yatsenko5@gmail.com> <188b00961e374aeec9b1aac53cb25416e502ef67.camel@gmail.com>
 <CAEf4BzYoA_T2zM7+ED88PMe2VNpybrduFObUB83QegGewB2O5A@mail.gmail.com> <df068351-62a9-4bf6-938d-076a3d2443fa@gmail.com>
In-Reply-To: <df068351-62a9-4bf6-938d-076a3d2443fa@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Oct 2025 09:50:52 -0700
X-Gm-Features: AS18NWCVD6AEaZCu6yjckVdLZ4yLtsaYUITOiDOX-jeVPJNUKbWTn2g__FpKJvE
Message-ID: <CAEf4BzY9nnyinkSdHkUtc9vnW=Y6D=BAxHzT=pJkt67KnCEtaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/11] selftests/bpf: add file dynptr tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 6:38=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 10/16/25 21:29, Andrii Nakryiko wrote:
> > On Wed, Oct 15, 2025 at 2:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> >> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> >>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>
> >>> Introducing selftests for validating file-backed dynptr works as
> >>> expected.
> >>>   * validate implementation supports dynptr slice and read operations
> >>>   * validate destructors should be paired with initializers
> >>>   * validate sleepable progs can page in.
> >>>
> >>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >>> ---
> >> I get the following error report when running this test on top of [1].
> >>
> >> [1] 48a97ffc6c82 ("bpf: Consistently use bpf_rcu_lock_held() everywher=
e")
> >>
> >> ---
> >>
> >> [   11.790725] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> [   11.790999] WARNING: possible recursive locking detected
> >> [   11.791195] 6.17.0-gbfd75250bee0 #1 Tainted: G           OE
> >> [   11.791418] --------------------------------------------
> >> [   11.791446] test_progs/153 is trying to acquire lock:
> >> [   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: __mi=
ght_fault (mm/memory.c:7081 (discriminator 4))
> >> [   11.791446]
> >> [   11.791446] but task is already holding lock:
> >> [   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bpf_=
find_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_lock.=
h:41 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bpf/=
task_iter.c:751)
> >> [   11.791446]
> >> [   11.791446] other info that might help us debug this:
> >> [   11.791446]  Possible unsafe locking scenario:
> >> [   11.791446]
> >> [   11.791446]        CPU0
> >> [   11.791446]        ----
> >> [   11.791446]   lock(&mm->mmap_lock);
> >> [   11.791446]   lock(&mm->mmap_lock);
> >> [   11.791446]
> >> [   11.791446]  *** DEADLOCK ***
> >> [   11.791446]
> >> [   11.791446]  May be due to missing lock nesting notation
> >> [   11.791446]
> >> [   11.791446] 2 locks held by test_progs/153:
> >> [   11.791446]  #0: ffffffff85a73be0 (rcu_read_lock_trace){....}-{0:0}=
, at: bpf_task_work_callback (./include/linux/rcupdate.h:331 (discriminator=
 1) ./include/linux/rcupdate_trace.h:58 (discriminator 1) ./include/linux/r=
cupdate_trace.h:102 (discriminator 1) kernel/bpf/helpers.c:4101 (discrimina=
tor 1))
> >> [   11.791446]  #1: ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at:=
 bpf_find_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_=
lock.h:41 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel=
/bpf/task_iter.c:751)
> >> [   11.791446]
> >> [   11.791446] stack backtrace:
> >> [   11.791446] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> >> [   11.791446] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.3-4.el9 04/01/2014
> >> [   11.791446] Call Trace:
> >> [   11.791446]  <TASK>
> >> [   11.791446]  dump_stack_lvl (lib/dump_stack.c:122)
> >> [   11.791446]  print_deadlock_bug.cold (kernel/locking/lockdep.c:3044=
)
> >> [   11.791446]  __lock_acquire (kernel/locking/lockdep.c:3897 kernel/l=
ocking/lockdep.c:5237)
> >> [   11.791446]  ? __pfx___up_read (kernel/locking/rwsem.c:1350)
> >> [   11.791446]  lock_acquire (kernel/locking/lockdep.c:470 kernel/lock=
ing/lockdep.c:5870 kernel/locking/lockdep.c:5825)
> >> [   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
> >> [   11.791446]  ? __pfx___might_resched (kernel/sched/core.c:8880)
> >> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:22=
1)
> >> [   11.791446]  __might_fault (mm/memory.c:7081 (discriminator 7))
> > cc'ing some mm folks for help
> >
> > Is it a lockdep implementation detail that __might_fault is taking
> > mmap_lock, or __might_fault is asserting that when fault is allowed,
> > something (presumably kernel's page fault handler) might take
> > mmap_lock? It's not clear to me.
> >
> > bpf_find_vma() clearly is holding mmap_lock, so if that's unsafe, we'd
> > have to make sure that bpf_find_vma() cannot be called in a sleepable
> > BPF program.
> >
> Do we want to have a finer granularity, for example just disallow
> calls to copy_from_user type of functions in the bpf_find_vma callback?

I think this means that bpf_find_vma() is not compatible with BPF
sleepable programs, not just with with bpf_copy_from_user(). Same
stands for task_vma iterator, as it does mmap locking just as well.

We should look into avoiding mmap locking altogether and using RCU
protection and per-VMA locks instead. Suren recently made use of that
in /proc/PID/maps/PROCMAP_QUERY. This will have to be dependent on
CONFIG_PER_VMA_LOCK, unfortunately.

Suren, Shakeel, do you see any other way to avoid taking mmap_lock,
but let BPF safely work in VMA while allowing page faults (that's what
we mean by "BPF sleepable mode")?

