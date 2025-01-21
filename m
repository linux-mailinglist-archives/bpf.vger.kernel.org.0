Return-Path: <bpf+bounces-49416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BADA187C9
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 23:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339BC188BB39
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8291F8ADD;
	Tue, 21 Jan 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOuCQrsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E6187FE4;
	Tue, 21 Jan 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499107; cv=none; b=juNI3pl3ydUZdhzDUbuh387clEJXyMGkh3iCbKubektaWwPz+S5cFqHmLGcNkd+APFItMru/4Kq2Ml7VgSjduau0UaWnn8r7k4h0LKPFYck66LEYmEVqy6v0Ud/uoY3Wv/ogWRP3JJlIHNRDeHIbstCMj5ATrt3uvQsPJl1PLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499107; c=relaxed/simple;
	bh=IiYBdtN8+kUip8EwEkxRpTbCERxaPT45SZvkXeZf1GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X89sVc6dC4N8m2yDux5G+SBtU5hvBzfJHS492fGg76ep2DBXeEONVQ9a0IZAB07u5lyK6NcvBv5l9PvNxnx9j8gidOE91PQUq5L+msialVcycRVVfqIvJvyk17WjpH1zynyqh+hvzz6VOlQMScfXUTiuUp7p8FPwuIPAI2cAbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOuCQrsV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21636268e43so137088485ad.2;
        Tue, 21 Jan 2025 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737499105; x=1738103905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QBmFNF9CU6iEPIp52Swx+xlInIwAj5N3NR5T+2s9s0=;
        b=hOuCQrsVjoTOsj8qURll5dMy7xYB/yQfNCNFg9IJwTNFReTfzIgQ4SY022O232dd8C
         7VkjseYtqThWo9YzIGClqYIF9JLrrrnWQZCaYcBXH1MArRlKa5bjU3kq9N+jKEI5Ulvu
         t1tVhdAruX9KM3STCEKD5uS01vilnOQGToEjQe0sVKnUZTALQYLZ1CIygsUGplrAMCrL
         Kq038KdZIZ/1klhhDO+T7czdQ0rPKuKU5iRNoaP2PtGwfSKGzOkQf2iVLdg2oC1VJGZL
         9A6X6vRXaoHSIactalk3IApFtZiTUobWdpTd+eovFAGRltroyY2jXuUjUPLNsmxGroY2
         qmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737499105; x=1738103905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QBmFNF9CU6iEPIp52Swx+xlInIwAj5N3NR5T+2s9s0=;
        b=dn9gRYvWSvqBIteUE8HDiNkko35F21YywjTpfR5MSgwmGOjqtMugNfZ7f1Q1Y9u4+6
         no8d6NhdfhFcyj/oY5Rjv/HAAEgaIqDXVyBkOiJbSGhGN/v50s05pc9ikd4Vog08iNzW
         R9cWN5tcIbt1aO5QqQkI6uqtMfU+fQFaEMIK3ek/cJVTTDIS81DVAQiosar0buzaSrR5
         tdrkgeIMqE95V+kWL9NgSCAqbwL8inav4TbCjvFbAMwleGj6kIWm1yq+bnEqs9PHcEFG
         dzbKuevDY02c98BxyfeKxnfPkE9EhPKrEIBUUMpCJmTWlDfUCDqJNuBewAyhhsPC4zUo
         mPAA==
X-Forwarded-Encrypted: i=1; AJvYcCUDKhoNvCHIgXUVfn0R9GMoiCwP8GgFb8D36e7605pTomkCaavWPEHvlllWgXxCqU7QzTk=@vger.kernel.org, AJvYcCVNmTLKArn5jsnhgd9vEnSqXe2pg3x5XjNNdmyqwt8tjZw31tMDSPTa8z0VuYdBn5ed5TZucoWQqNsL@vger.kernel.org, AJvYcCWNHNLIx34FAV52jR/oQQW8RXfRJ3FLhWVWGxA3Jz1FGTanF3z7aX7P3HlAFhvRFyJ0VstDK0azrWrVbEa2uxc7veWG@vger.kernel.org, AJvYcCWxc/Fxby+mHcFOjTIgWVSQYkS1XUqF+VvH2mCYL+zV949q7PTa2yNSUwD3mlPgZ35zxPXkGZce@vger.kernel.org, AJvYcCXcfG5F6F6k1Y9HDuMtLhe1lbgon+gBsEMOZ1d+A9TFwD55RS+5TItfxbviHjS+SLUt82q6v0ZADBcRkH3Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaOG7+6kBT/mI3aZ8aUijBj6lmjeY5xiEA9EV+tunN2dbdKlm
	v+rpgKcn2ygHtSAfB2B3p6VIsfeTObJx1gDscQ8wIuFtYtzhfrS4+X3U00PqtweZt+vaI9iHQKc
	7ZkDzYwmaVUxDECdDaVaTgBOd6GU=
X-Gm-Gg: ASbGncttytDurrlmdYOW3utzzU3xoWGwrGy7OHPPSvaQtt4S+4dHeIZa0aakDgnxV8t
	5AEhaG2DEupH+cOf0EXPxSWKa0tLmXFV8J8HB04F9Ce01Xk7x+azoDjLjXvolepxd1ok=
X-Google-Smtp-Source: AGHT+IEb0G90JnUb++0qPTelMMSZe3TRHWq+Fq4dqRtw+7t73B1scPakh3a2X/neoODL/siWVyCBZ1BPUUofYk7+D0M=
X-Received: by 2002:a05:6a21:3285:b0:1e1:f281:8cec with SMTP id
 adf61e73a8af0-1eb21498383mr29031250637.10.1737499104890; Tue, 21 Jan 2025
 14:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook> <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org> <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <Z4-xeFH0Mgo3llga@krava> <20250121111631.6e830edd@gandalf.local.home> <Z4_Riahgmj-bMR8s@krava>
In-Reply-To: <Z4_Riahgmj-bMR8s@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Jan 2025 14:38:09 -0800
X-Gm-Features: AbW1kvYiltR-mpN54P95qZGx9A5ZmJJyHCcX2_kRHm9_GN1BzcWeXina4gS657M
Message-ID: <CAEf4BzZv3s0NtrviQ1MCCwZMO-SqCsiQF-WXpG6_-p4u5GeA2A@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eyal Birger <eyal.birger@gmail.com>, luto@amacapital.net, 
	wad@chromium.org, oleg@redhat.com, ldv@strace.io, mhiramat@kernel.org, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 8:55=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Jan 21, 2025 at 11:16:31AM -0500, Steven Rostedt wrote:
> >
> > [ Watching this with popcorn from the sidelines, but I'll chime in anyw=
ay ]
> >
> > On Tue, 21 Jan 2025 15:38:48 +0100
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > I'm still trying to come up with some other solution but wanted
> > > to exhaust all the options I could think of
> >
> > I think this may have been mentioned, but is there a way that the kerne=
l
> > could know that this system call is being monitored by seccomp, and if =
so,
> > just stick with the interrupt version? If not, enable the system call?
>
> yes [1], the problem with that solution is that we install uretprobe
> trampoline at function's uprobe entry probe, so we won't catch case
> where seccomp is enabled in this probed function, like:
>
>   foo
>     uprobe -> install uretprobe trampoline
>     ...
>     seccomp(SECCOMP_MODE_STRICT..
>     ...
>     ret -> execute uretprobe trampoline with sys_uretprobe
>
>
> I thought we could perhaps switch existing uretprobe trampoline to
> int3 when we are in sys_seccomp, but another user thread might be
> already executing the existing uretprobe trampoline, so I don't
> think we can do that

Jiri,

We should abandon the vector of "let's try to detect whether someone
is blocking sys_uretprobe" as a solution, I don't believe it's
possible. Blocking sys_uretprobe is too dynamic of a thing. There is
an arbitrary periods of time between adding uretprobe trampoline
(i.e., sys_uretprobe) and actually disabling sys_uretprobe through
seccomp (or even BPF: LSM or even kprobes can do that, why not?), and
userspace can flip this decision many times over.

And as Oleg said, sysctl
"please-make-my-uretprobe-2x-faster-assuming-i-know-about-this-option"
makes no sense either, this will basically almost never get enabled.


Kees,

You said yourself that sys_uretprobe is no different from rt_sigreturn
and restart_syscall, so why would we rollback sys_uretprobe if we
wouldn't rollback rt_sigreturn/restart_syscall? Given it's impossible,
generally speaking, to know if userspace is blocking the syscall (and
that can change dynamically and very frequently), any improvement or
optimization that kernel would do with the help of special syscall is
now prohibited, effectively. That doesn't seem wise to restrict the
kernel development so much just because libseccomp blocks any unknown
syscall by default.

I'm OK either asking libseccomp to learn about sys_uretprobe and not
block it (like systemd is doing), or if we want to bend over
backwards, prevent user policy from filtering theses special syscalls
which are meant to be used by kernel only. We can't single out
sys_uretprobe just because it's the newest of this special cohort.

You also asked "what if userspace wants to block uprobes"? If that's
really the goal, that would be done at uprobe attachment time, not
when uprobe is (conceptually) attached, new process is forked, and
kernel installs uretprobe trampoline with uretprobe syscall. Or just
control that through (lack of) capabilities. Using seccomp to block
*second part of uretprobe handling* doesn't make much sense. It's just
the wrong place for that.

P.S. Also using FRED as an excuse for not doing sys_uretprobe is
manipulative. When we get FRED-enabled CPUs widely available and
deployed *and* all (or at least majority of) the currently used CPUs
are decommissioned, only then we can realistically talk about
sys_uretprobe being unnecessary. That's years and years. sys_uretprobe
is necessary and important *right now* and will be for the foreseeable
future.

>
> jirka
>
>
> [1] https://lore.kernel.org/bpf/20250114123257.GD19816@redhat.com/

