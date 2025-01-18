Return-Path: <bpf+bounces-49268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74EFA15EBC
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 21:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9C5165B8F
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151751B423A;
	Sat, 18 Jan 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+pRX5Dv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA21373;
	Sat, 18 Jan 2025 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737231715; cv=none; b=BFOTDTR33CHxT6ruBBgWwXRw1rQHSWJth7BZcW7acIlQtefbJjgYL+KZSgGXNfAnwdip3NR9VjbNElAvOq8PcLvOJa1uFjuKm3nQCyu5TRMsQz7oETmbzxeBLM6tCxur6hPB2cvrGA56Izs3DxvCsvPRQAPbEHZcFu5B4N8PCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737231715; c=relaxed/simple;
	bh=q9qsMX/HkCYxQZH+8I2kWPXE6XRaUuOPM9zDN8q9VCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlCMWCn3/fhRt4dKMLBKRMVqMcqr/cZGy6augfkj/USH6LLHR8sW+uyT2w118K/s1aIy6OrMnxbW+gOSRT9Bm8Nabi2m8vB4VtDNpKuc55qHuHakKSjT14N/S7hxWcNWnfARE50WtKLlihLuNNCCoKw9GuY6xkE45EZtHAH3zD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+pRX5Dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6730C4CED1;
	Sat, 18 Jan 2025 20:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737231715;
	bh=q9qsMX/HkCYxQZH+8I2kWPXE6XRaUuOPM9zDN8q9VCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+pRX5DvroieuQST+ihh6zSupRiMWWPB9OSko7ZYMi6LM/IiItfx8J2Cz5wh1wh1F
	 /uqh3bqBIoRDta5iMLj464zUvKLDvLUzl1fqyF742ZL7gxVT6tg7ujTXU17D13H6Hq
	 Xn6T9vQXxlaY9nQVHkhrRM7Y9qnbGo7xWltLobvC26DxMfzoF6hMKg2cSPppu+DnE8
	 uo5T1aRE85jH4wVZ7+sgbgaV5qbKOhjZFXzsN47X6DYaxLuR302Kv50U83/YRSeXcF
	 8PHHRnz8VHErbVnaA0ywTYIzMrA5110hydni2Rw705ATBFwUYUlJ3NuMiTiyLZChx6
	 /OUy2wEmbe58w==
Date: Sat, 18 Jan 2025 12:21:51 -0800
From: Kees Cook <kees@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <202501181212.4C515DA02@keescook>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117005539.325887-1-eyal.birger@gmail.com>

On Thu, Jan 16, 2025 at 04:55:39PM -0800, Eyal Birger wrote:
> Since uretprobe is a "kernel implementation detail" system call which is
> not used by userspace application code directly, it is impractical and
> there's very little point in forcing all userspace applications to
> explicitly allow it in order to avoid crashing tracked processes.

How is this any different from sigreturn, rt_sigreturn, or
restart_syscall? These are all handled explicitly by userspace filters
already, and I don't see why uretprobe should be any different. Docker
has had plenty of experience with fixing their seccomp filters for new
syscalls. For example, many times already a given libc will suddenly
start using a new syscall when it sees its available, etc.

Basically, this is a Docker issue, not a kernel issue. Seccomp is
behaving correctly. I don't want to start making syscalls invisible
without an extremely good reason. If _anything_ should be invisible, it
is restart_syscall (which actually IS invisible under certain
architectures).

-Kees

-- 
Kees Cook

