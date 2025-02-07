Return-Path: <bpf+bounces-50777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBCDA2C711
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDBF3AD7DB
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5F61EB19D;
	Fri,  7 Feb 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+WEOEPZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A51EB1A9
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942069; cv=none; b=GRlS6jmE6CloCfYuea2njJW8fIk4zfwbpLm2NGGX1+l0TB2B6xyFmxm7rgqMWTFzLy/TM1U0L8IDt8NYPW5hX1o0Pd0zQxO1llusPCN923aE54KMeZmGg74h8CrmgW+kd38e5iRjSJTGnvpgV2khg+DCacK7zxA3xQZ3/OUDDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942069; c=relaxed/simple;
	bh=F4j0KkSbpmD5d1hZhFwZpCkYNFkzmXINbPi2uJ87EwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJW2nL6gP8PnDZ1g67And30h298ITbpYGGK7XbqMxJUmXOOgzCaE0ReBfLboLjJ2uruYID+7u9NWH9NanNLxYJvQxz1Bl8HNcl6z81PdLKw/HP5qC7SMqbgYlSKq+lRsCM9Ou4JcMy4TFkNlwLF2of5JLy1qnGo3dhoXzDb1S04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+WEOEPZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dcd33d9d9dso10553a12.0
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942066; x=1739546866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4j0KkSbpmD5d1hZhFwZpCkYNFkzmXINbPi2uJ87EwA=;
        b=K+WEOEPZBusFmWVzafxm9BwPE7etbs6sP+Rs/FzkdIWODkl/x0h+JCpWWm55UWCPWk
         Fs+7gTcFfMYGWdVras1s5wFKE7tQ9rmiEXrjDRzjLOwQ7NJ9WwLY8SKGTgn3UvfZOT/j
         b5vIWlMMnmf963hyzk36SgSqBdfQ8mI6eZFJShMIP5l76ApgTOgSUZK2nHs7l8clojb7
         IbcU9mopg6LrSrfGeNe6fGbTa4+YzE6qj0bQ859e3xbHJt+IuSBkfFxvlOlbYldo8hjS
         Zj/jSPHfqbOtN0lm2SafdXddR2WBSJAZjEEBK16U/o17Jp6omUomgRBBKK3kko9uzL8b
         6WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942066; x=1739546866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4j0KkSbpmD5d1hZhFwZpCkYNFkzmXINbPi2uJ87EwA=;
        b=kw8kFQtX/ryqhZoKe6B49kQSk3CY8CMIk6ou3zKuWogWhNIulkD9X4xD3YYDu8zfBs
         O0xskwQQcMB573llfP8oAF1AZJ28bRWy4tppoDyk03NJvH0CDPdOBu4ZGiB5fwbw1hMt
         RQS1Hd/EWmDr3wLA2Y1AxaMVfiIfo4Zvrlc261Sw8K20TLFspv7mgdCuM0B7Np70R125
         cDu17TvbQaESLmmJ5pg8/TYI4IcSjXG8y0wqbq2aYwHFoUfnr0wjGzfvY6rjwQ07xWET
         AXTzjdbi24KVU+IHZWQCoQIWjEHq35qpZwyblDVNpciTKRVzcrZ2FdDTD/omkCxyz72m
         tPFg==
X-Forwarded-Encrypted: i=1; AJvYcCVyDRUYuKNuOMtqrPcsY8nmuRLy1IOJl+YeA1bMneu3l278T+aVrvXkaZew5EzYMM8b3Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+T8BAxlfzE+KBbUaGs7lCnmcyk4jBjI9pM4se3PjHd9dsWEX8
	U8CgyGeyegLyzQNdBM2sGSgw7dlVzMuZDU35D/pCayXrOnGF4zBFqoaDCE65DZjKAW/TTnNcxMI
	KvHsas2QCArC1nnxK9zDQOMfEmrvjmK9YTVFb
X-Gm-Gg: ASbGncvekRh/g+u35F2SWq94U8H9cy1fPA76Li/c+M1TL3OjbblvEDvmmV2VWkPHAhf
	f3pl7mb7c5+OnBkilUUsn/jX3+m5+BbnARl9zfphgQ0Ya/355H5XoVEhhmzcclkEFq4LgmwQaP9
	4eU09yOaQcetArG8GBQS9KG/A=
X-Google-Smtp-Source: AGHT+IEABdgK9eHRB4H0WezxqoVghBHcRPYWNAOuQN7T+MNlzRlH684F1NSJpUngreTS9WPWXZN59E97viGK5BDWvz8=
X-Received: by 2002:a05:6402:517c:b0:5dc:d08e:e128 with SMTP id
 4fb4d7f45d1cf-5de47da7d23mr74223a12.5.1738942065552; Fri, 07 Feb 2025
 07:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202162921.335813-1-eyal.birger@gmail.com>
In-Reply-To: <20250202162921.335813-1-eyal.birger@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 7 Feb 2025 16:27:09 +0100
X-Gm-Features: AWEUYZnrwNzsLd1SX3TTXp9my4IROz2Zr8KCBuJa7WZQ86FVBE2pL8vu6wsQ824
Message-ID: <CAG48ez1Pj6MT=RV-sogtNbw7WLLmCrC-3TkNfRjpcCif8iNGkA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through seccomp
To: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 5:29=E2=80=AFPM Eyal Birger <eyal.birger@gmail.com> =
wrote:
> uretprobe(2) is an performance enhancement system call added to improve
> uretprobes on x86_64.
>
> Confinement environments such as Docker are not aware of this new system
> call and kill confined processes when uretprobes are attached to them.

FYI, you might have similar issues with Syscall User Dispatch
(https://docs.kernel.org/admin-guide/syscall-user-dispatch.html) and
potentially also with ptrace-based sandboxes, depending on what kinda
processes you inject uprobes into. For Syscall User Dispatch, there is
already precedent for a bypass based on instruction pointer (see
syscall_user_dispatch()).

> Since uretprobe is a "kernel implementation detail" system call which is
> not used by userspace application code directly, pass this system call
> through seccomp without forcing existing userspace confinement environmen=
ts
> to be changed.

This makes me feel kinda uncomfortable. The purpose of seccomp() is
that you can create a process that is as locked down as you want; you
can use it for some light limits on what a process can do (like in
Docker), or you can use it to make a process that has access to
essentially nothing except read(), write() and exit_group(). Even
stuff like restart_syscall() and rt_sigreturn() is not currently
excepted from that.

I guess your usecase is a little special in that you were already
calling from userspace into the kernel with SWBP before, which is also
not subject to seccomp; and the syscall is essentially an
arch-specific hack to make the SWBP a little faster.

If we do this, we should at least ensure that there is absolutely no
way for anything to happen in sys_uretprobe when no uretprobes are
configured for the process - the first check in the syscall
implementation almost does that, but the implementation could be a bit
stricter. It checks for "regs->ip !=3D trampoline_check_ip()", but if no
uprobe region exists for the process, trampoline_check_ip() returns
`-1 + (uretprobe_syscall_check - uretprobe_trampoline_entry)`. So
there is a userspace instruction pointer near the bottom of the
address space that is allowed to call into the syscall if uretprobes
are not set up. Though the mmap minimum address restrictions will
typically prevent creating mappings there, and
uprobe_handle_trampoline() will SIGILL us if we get that far without a
valid uretprobe.

