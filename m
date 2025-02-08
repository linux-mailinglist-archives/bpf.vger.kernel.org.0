Return-Path: <bpf+bounces-50823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED7A2D1D9
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 01:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF0D3AE14E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 00:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A574F28E8;
	Sat,  8 Feb 2025 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeIuooAg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3DA23;
	Sat,  8 Feb 2025 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738973043; cv=none; b=jOZOGrU3/I/NYmevCjFyV+eOrIr9Kil1CC0voxY/j2tXA9kb7nr+hiAwKuvs4+fG2bc0Kjqx02oDTPHhZEsIauU0eIJEg/73dPxvmUDL4mB54nmRIApD786GfygqEHNSsaNwzZmKiaMTb2x+jZerOxue7VTDK1M4AO5I9pKVLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738973043; c=relaxed/simple;
	bh=2STvfBkzSCvzpdSOGbhHw9/tYsaPc4yptm9r05vncu4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLfHuuGsN5Oy9h8rsLmlidmwuEdk2mfIo7vHrZaY0mfj58m+bLqc4axyK1meP9Oy5rizLdcSO0kt9AMbw8vp0JCz0saKiWzlqlqnKCplsQMLcdwpeBQwNH0RWVzKty/NmVLKRvIb1mj6veDtb+JBM6zhgkgivTF/mWVmaNQ+eSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeIuooAg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dd4e26e79so6884f8f.1;
        Fri, 07 Feb 2025 16:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738973040; x=1739577840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QvLyhY6owKPW2I6LIaEqsveAbrbpfjuOOZhRQN2NfTg=;
        b=SeIuooAgeWjw7EA4GFBtLECVv7ZWJEkBvN0vw1zkwE06WHb9dnKiUnZqwEQ+au/QuH
         eThZtVt9D5EO3a9aGIqMZNSTUws8XCAWSzzuVRUuIH2nJj94obvWZdfImrpZ+0+uS8mY
         YWE8WGHgvVwylhivg3/JxR/0YdBGzU+JRPIK12oyfR74IlfQIodsF8CgFefBaWxJrcZB
         nHrvX45f50PihLgcUBblfo3O9NniC5oOAzebHYaReAPIcmxpb5Fkphcwodle3DWWXASa
         2qQuu3KMl5xt2jBy6f5VOnZMzNCTi9AALkGFU/tPFGx66ZGEQUbALXH3/ocL4B1nMKrf
         1xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738973040; x=1739577840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvLyhY6owKPW2I6LIaEqsveAbrbpfjuOOZhRQN2NfTg=;
        b=saKdoZzthahwm6jGaWlSDaDwEdFVEh/45WdTCkB6mxUOnxoIQuVmJDT+nrjs3E9fc8
         6ZceqQl9ylTewGhRf21tsHubHmvepPzYHe3JBTtehcwcf59ya3I9so+5Z39pTsgh+r3l
         i4P2W3fsOaj6KswWMjgACpVHHbxzeI6qtedo1btMVg4aUlh+uPgxsTnwBiNNCQvXRcI3
         y6uV+kCDVOersXpk2PrQEwvbzjAeTsA0zHkWyp8xLYrLDom+T6L/yvKp9nl9ROQgEARj
         AxBKOIk99QIFwijJixGQKfCQBZ9QpEUm6YbWj+oFe9cI4Rcprx7DGu40nINuqN9+9S7s
         gH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVGUCZPMDeDY5lHs5I4ripI6JjSEgbU7gHZu2UYvRLqqDGDMFyk5geDGtrSTLGFnpvEElkIRBHDAtDeqZwi@vger.kernel.org, AJvYcCVL4zDGHXndcbsdF4ptjhPk5KTkanNwburi6J1ET78H8AT2vzY4ogGdlz2GCuJZJZEDX54=@vger.kernel.org, AJvYcCVZ9qPcG9kvv0fsepu5DzsLzCW7XxzgydF6n08oUzTZsNSvWYaP5fdQgOgw6xQFi8vn/vhsdx1K4EZ+@vger.kernel.org, AJvYcCWP4zm3rpIGhKNFO6ot6PSgzmYvOV79zpGcKoaQA6yzOkiHWKCBGbW/7B72Z2b20el5BijHsd/R1KjLQnStUyqzRksD@vger.kernel.org
X-Gm-Message-State: AOJu0YxKeC+PUArwzNz8MVVUGUgG1oIYnFeLN7JBnFL33hJaDehXLrjR
	dom1YYAE9KxmGEyvMBXTNG0g9D0AV8z8rNXNDkqz/FzTjIsjwwmV
X-Gm-Gg: ASbGncubVX5FEUjb6rHVjQgpDil+HxEfoAeFkGhMiIgEHFT5CFB5BxbZK83Qzl+9/cJ
	RTxpwfrI0GUIHYaP6+s+A9LcENbRZuX2EMDyJ/5MSvMf7FHsujALn20XOcjKoBBDKCnqIunQj/s
	lD3QpJwmZS9yy72PQkBUcoCrcVXg9+EXBnmbcx2PpkNWt6jm4LMMwW5bgTXlv9axp8JXFSyWUP0
	GyNfAX0jHg4K3X+HlI6+2t+dAEQ5ILTk5EAZ+iAXuuVbDYFBjEnjhEW92eXEHuFIXVAHcFsJdD5
	i8LJQ26IR3aFEfEGJb2bBdo6
X-Google-Smtp-Source: AGHT+IGxECD89hAn1Ixdo4SeJV1zmM5RTDj2Hth3O4byoRJgQoykCw9yET/1VT7lC1auRqJvXra1/Q==
X-Received: by 2002:a05:6000:4021:b0:38c:1362:41b5 with SMTP id ffacd0b85a97d-38dc8d91f2amr3316788f8f.6.1738973039365;
        Fri, 07 Feb 2025 16:03:59 -0800 (PST)
Received: from krava (85-193-35-212.rib.o2.cz. [85.193.35.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ff64sm68170485e9.9.2025.02.07.16.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 16:03:58 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 8 Feb 2025 01:03:55 +0100
To: Jann Horn <jannh@google.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org, oleg@redhat.com,
	mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through
 seccomp
Message-ID: <Z6afa2Z4IYlIAbJ2@krava>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
 <CAG48ez1Pj6MT=RV-sogtNbw7WLLmCrC-3TkNfRjpcCif8iNGkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1Pj6MT=RV-sogtNbw7WLLmCrC-3TkNfRjpcCif8iNGkA@mail.gmail.com>

On Fri, Feb 07, 2025 at 04:27:09PM +0100, Jann Horn wrote:
> On Sun, Feb 2, 2025 at 5:29 PM Eyal Birger <eyal.birger@gmail.com> wrote:
> > uretprobe(2) is an performance enhancement system call added to improve
> > uretprobes on x86_64.
> >
> > Confinement environments such as Docker are not aware of this new system
> > call and kill confined processes when uretprobes are attached to them.
> 
> FYI, you might have similar issues with Syscall User Dispatch
> (https://docs.kernel.org/admin-guide/syscall-user-dispatch.html) and
> potentially also with ptrace-based sandboxes, depending on what kinda
> processes you inject uprobes into. For Syscall User Dispatch, there is
> already precedent for a bypass based on instruction pointer (see
> syscall_user_dispatch()).
> 
> > Since uretprobe is a "kernel implementation detail" system call which is
> > not used by userspace application code directly, pass this system call
> > through seccomp without forcing existing userspace confinement environments
> > to be changed.
> 
> This makes me feel kinda uncomfortable. The purpose of seccomp() is
> that you can create a process that is as locked down as you want; you
> can use it for some light limits on what a process can do (like in
> Docker), or you can use it to make a process that has access to
> essentially nothing except read(), write() and exit_group(). Even
> stuff like restart_syscall() and rt_sigreturn() is not currently
> excepted from that.
> 
> I guess your usecase is a little special in that you were already
> calling from userspace into the kernel with SWBP before, which is also
> not subject to seccomp; and the syscall is essentially an
> arch-specific hack to make the SWBP a little faster.
> 
> If we do this, we should at least ensure that there is absolutely no
> way for anything to happen in sys_uretprobe when no uretprobes are
> configured for the process - the first check in the syscall
> implementation almost does that, but the implementation could be a bit
> stricter. It checks for "regs->ip != trampoline_check_ip()", but if no
> uprobe region exists for the process, trampoline_check_ip() returns
> `-1 + (uretprobe_syscall_check - uretprobe_trampoline_entry)`. So
> there is a userspace instruction pointer near the bottom of the
> address space that is allowed to call into the syscall if uretprobes
> are not set up. Though the mmap minimum address restrictions will
> typically prevent creating mappings there, and
> uprobe_handle_trampoline() will SIGILL us if we get that far without a
> valid uretprobe.

nice catch, I think change below should fix that

thanks,
jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0c74a4d4df65..9b8837d8f06e 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -368,19 +368,21 @@ void *arch_uretprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
-static unsigned long trampoline_check_ip(void)
+static unsigned long trampoline_check_ip(unsigned long tramp)
 {
-	unsigned long tramp = uprobe_get_trampoline_vaddr();
-
 	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
 }
 
 SYSCALL_DEFINE0(uretprobe)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long err, ip, sp, r11_cx_ax[3];
+	unsigned long err, ip, sp, r11_cx_ax[3], tramp;
+
+	tramp = uprobe_get_trampoline_vaddr();
+	if (tramp == -1)
+		goto sigill;
 
-	if (regs->ip != trampoline_check_ip())
+	if (regs->ip != trampoline_check_ip(tramp))
 		goto sigill;
 
 	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));

