Return-Path: <bpf+bounces-50874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92AA2D8AF
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F37D7A3560
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0541E1A3151;
	Sat,  8 Feb 2025 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NisdrG5a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE8243946;
	Sat,  8 Feb 2025 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046945; cv=none; b=QQOepBAqx8EemkCCbHVTQnw3EUlLxn+Cs/Y4MWjL4Zj8vqEvK54cA+W00Gi8WB68Z9JOo5man3Vyg1ddFLlVIEi6PlSlpd9bGKXs95tAEGK6ck6gu22JPlbwn9FPKl94YN3aIRNB7iYTWGBqg/ixYBN8WsRxu5+RFZPJqkFLVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046945; c=relaxed/simple;
	bh=f41av73b1EZpNR+Lr0++naKxVjrR8Ngu/ynWj0FCoqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpgTpgqd1HJlPhJjI1x/WHNr46Shr6y43AlK+QmgGoagdxW+Mp1EGrJo3wamel6CbEpWLDJdHJ04l0CheUWbKuef7oXLXRGfVUFoDJTQCaSQhSnXPn8U4kSSitrOmMUnXByb7vclNWg6Kyp36MA/e/WTKXe0p8+lVhS0a2sxKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NisdrG5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDEBC4CED6;
	Sat,  8 Feb 2025 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739046943;
	bh=f41av73b1EZpNR+Lr0++naKxVjrR8Ngu/ynWj0FCoqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NisdrG5aBDlsBrsD9yS6DZule39nLIVGrT+MgtCCiSOcP+xGQEmsEODscrS7Z8tJc
	 IwK3mzj8u8xyMw5afnJCxibubjlbO8kBBfEQfZNH7U2oWdL5Np98g+VT9AUsCtPYOA
	 s1XoG5i2CKZaOhJ+zLBWu4S9ltbc6cwXhn/iVd9K1rXDoD7u2eM6fTYSGPtfBVaZbs
	 pG0FAMsUX31aBKycwOZLSEX7jNNW+evBbB2KU6pYA28EYsuFW5ZQ/9hHySld0u62vI
	 0AzLU+sQ2jAfU+3ZxB1+DCFxiPuzDK90DNtBn/LH0148l9U/3Bscf7EpYH+6VGFmAT
	 7WELnuBemArbQ==
Date: Sat, 8 Feb 2025 12:35:43 -0800
From: Kees Cook <kees@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jann Horn <jannh@google.com>, Eyal Birger <eyal.birger@gmail.com>,
	luto@amacapital.net, wad@chromium.org, oleg@redhat.com,
	mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through
 seccomp
Message-ID: <202502081235.5A6F352985@keescook>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
 <CAG48ez1Pj6MT=RV-sogtNbw7WLLmCrC-3TkNfRjpcCif8iNGkA@mail.gmail.com>
 <Z6afa2Z4IYlIAbJ2@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6afa2Z4IYlIAbJ2@krava>

On Sat, Feb 08, 2025 at 01:03:55AM +0100, Jiri Olsa wrote:
> On Fri, Feb 07, 2025 at 04:27:09PM +0100, Jann Horn wrote:
> > On Sun, Feb 2, 2025 at 5:29 PM Eyal Birger <eyal.birger@gmail.com> wrote:
> > > uretprobe(2) is an performance enhancement system call added to improve
> > > uretprobes on x86_64.
> > >
> > > Confinement environments such as Docker are not aware of this new system
> > > call and kill confined processes when uretprobes are attached to them.
> > 
> > FYI, you might have similar issues with Syscall User Dispatch
> > (https://docs.kernel.org/admin-guide/syscall-user-dispatch.html) and
> > potentially also with ptrace-based sandboxes, depending on what kinda
> > processes you inject uprobes into. For Syscall User Dispatch, there is
> > already precedent for a bypass based on instruction pointer (see
> > syscall_user_dispatch()).
> > 
> > > Since uretprobe is a "kernel implementation detail" system call which is
> > > not used by userspace application code directly, pass this system call
> > > through seccomp without forcing existing userspace confinement environments
> > > to be changed.
> > 
> > This makes me feel kinda uncomfortable. The purpose of seccomp() is
> > that you can create a process that is as locked down as you want; you
> > can use it for some light limits on what a process can do (like in
> > Docker), or you can use it to make a process that has access to
> > essentially nothing except read(), write() and exit_group(). Even
> > stuff like restart_syscall() and rt_sigreturn() is not currently
> > excepted from that.
> > 
> > I guess your usecase is a little special in that you were already
> > calling from userspace into the kernel with SWBP before, which is also
> > not subject to seccomp; and the syscall is essentially an
> > arch-specific hack to make the SWBP a little faster.
> > 
> > If we do this, we should at least ensure that there is absolutely no
> > way for anything to happen in sys_uretprobe when no uretprobes are
> > configured for the process - the first check in the syscall
> > implementation almost does that, but the implementation could be a bit
> > stricter. It checks for "regs->ip != trampoline_check_ip()", but if no
> > uprobe region exists for the process, trampoline_check_ip() returns
> > `-1 + (uretprobe_syscall_check - uretprobe_trampoline_entry)`. So
> > there is a userspace instruction pointer near the bottom of the
> > address space that is allowed to call into the syscall if uretprobes
> > are not set up. Though the mmap minimum address restrictions will
> > typically prevent creating mappings there, and
> > uprobe_handle_trampoline() will SIGILL us if we get that far without a
> > valid uretprobe.
> 
> nice catch, I think change below should fix that

Thanks! Please backport this to -stable too. :)

-Kees

> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 0c74a4d4df65..9b8837d8f06e 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -368,19 +368,21 @@ void *arch_uretprobe_trampoline(unsigned long *psize)
>  	return &insn;
>  }
>  
> -static unsigned long trampoline_check_ip(void)
> +static unsigned long trampoline_check_ip(unsigned long tramp)
>  {
> -	unsigned long tramp = uprobe_get_trampoline_vaddr();
> -
>  	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
>  }
>  
>  SYSCALL_DEFINE0(uretprobe)
>  {
>  	struct pt_regs *regs = task_pt_regs(current);
> -	unsigned long err, ip, sp, r11_cx_ax[3];
> +	unsigned long err, ip, sp, r11_cx_ax[3], tramp;
> +
> +	tramp = uprobe_get_trampoline_vaddr();
> +	if (tramp == -1)
> +		goto sigill;
>  
> -	if (regs->ip != trampoline_check_ip())
> +	if (regs->ip != trampoline_check_ip(tramp))
>  		goto sigill;
>  
>  	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));

-- 
Kees Cook

