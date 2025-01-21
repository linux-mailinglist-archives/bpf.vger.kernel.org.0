Return-Path: <bpf+bounces-49417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D123BA187D6
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 23:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C613A46BB
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2471F8AE5;
	Tue, 21 Jan 2025 22:46:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69218AE2;
	Tue, 21 Jan 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499580; cv=none; b=Nr4BQ9gjGE5bC9eNT/adRHvwT0hrol5bC9qwlqzOUoIcEhvJtQWzFj0zPEj7cXE8LAQe5s00HDQh51V1giScPehyB6wKr5GLpf5C5vFRLwQMSvKV17v6bHNisKkR+npBXmogDeLLmrRkYGLySrfHnQRcxl4JKK/Wuev1OCg8J14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499580; c=relaxed/simple;
	bh=DZIpeq852zUG33mgVWw5ogrz72PCddSbLSmujiDUlLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UF4/372WSEtc4loMRTjn6Afb602gfxfFgA+2Ge91X42oBwvPCj2bi5dDh338QEjKJD3+4GKrwCQEN/uwIvJ8iAx+s3WpK/Sd0wto7hQNvOxZZvUgnu0SeNA0ZYK4Lqfsh7tP8aLk+2lQ6xK6rxRPK5mrmUDY44hJY2zcXOoPAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C49C4CEDF;
	Tue, 21 Jan 2025 22:46:16 +0000 (UTC)
Date: Tue, 21 Jan 2025 17:46:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, Eyal Birger
 <eyal.birger@gmail.com>, luto@amacapital.net, wad@chromium.org,
 oleg@redhat.com, ldv@strace.io, mhiramat@kernel.org, andrii@kernel.org,
 alexei.starovoitov@gmail.com, cyphar@cyphar.com, songliubraving@fb.com,
 yhs@fb.com, john.fastabend@gmail.com, peterz@infradead.org,
 tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, ast@kernel.org,
 rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
 linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250121174620.06a0c811@gandalf.local.home>
In-Reply-To: <CAEf4BzZv3s0NtrviQ1MCCwZMO-SqCsiQF-WXpG6_-p4u5GeA2A@mail.gmail.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
	<202501181212.4C515DA02@keescook>
	<CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
	<8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
	<CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
	<Z4-xeFH0Mgo3llga@krava>
	<20250121111631.6e830edd@gandalf.local.home>
	<Z4_Riahgmj-bMR8s@krava>
	<CAEf4BzZv3s0NtrviQ1MCCwZMO-SqCsiQF-WXpG6_-p4u5GeA2A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 14:38:09 -0800
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> You said yourself that sys_uretprobe is no different from rt_sigreturn
> and restart_syscall, so why would we rollback sys_uretprobe if we
> wouldn't rollback rt_sigreturn/restart_syscall? Given it's impossible,
> generally speaking, to know if userspace is blocking the syscall (and
> that can change dynamically and very frequently), any improvement or
> optimization that kernel would do with the help of special syscall is
> now prohibited, effectively. That doesn't seem wise to restrict the
> kernel development so much just because libseccomp blocks any unknown
> syscall by default.

What happens if the system call is hit when there was no uprobe attached to
it? Perhaps it should segfault? That is, this system call is only used when
the kernel attaches it, if the kernel did not attach it, perhaps there's
some malicious code that is trying to use it for some CVE corner case. But
if it always crashes when added, the only thing the malicious code can do
by adding this system call is to crash the application. That shouldn't be a
problem, as if malicious code can add a system call, it can also change the
code to crash as well.

Perhaps the security folks would feel better if there were other
protections against this system call when not used as expected?

-- Steve

