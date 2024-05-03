Return-Path: <bpf+bounces-28545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA38BB4A8
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 22:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C25285FD0
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04D158D9D;
	Fri,  3 May 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJNjDVMe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0F155321;
	Fri,  3 May 2024 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767469; cv=none; b=VhjzIbxvk/VRoig7JvyHTSzWWCXdiVY4FJR5S+J5SfAcPaxo/aMtyRPNNMQf5bEQiRK+sbJrXdDGABXd4I0jSPxuTG/w8ROkiEEGZibZDFt2rt+N0tpSd3Bi7uD7xhZgSOosrw+TDuJkdCJWnKSxeekx1ih7rqDsx8VhkYsKEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767469; c=relaxed/simple;
	bh=vyZsYiKlF4nOHndUv9Dr2L04M+i797IctslKsozXv7k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtEq3v+SrRsAtBj6UEThB9RN/Yje/SgKkI/fFMED3XCt/FpY1zhViR+H6qza2h6bbBO/mR+VB9fCuWL7jDlaF+57YRfwBMmXaDti2It3lSvway9ZVQMTwpJ5dm8402UU5mOZy2Uz/Iys+9iBo/uWRxxgQLI1d4xu0vMqzQGXBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJNjDVMe; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e271acb015so973791fa.1;
        Fri, 03 May 2024 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714767466; x=1715372266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IWQYp5T2Zl1VQkBfkG2UPdbY2+2qD1xC85V4mipGdk=;
        b=MJNjDVMegfDoDXucydMarwn+L5Qaxfym+HiMV2goQkM+42yVOyRJ8Lbsmp7NsIQCGV
         /ezJKgDAWE6enduIT6V0GDi7q59by5Ee7k79EPJ6zyZF/7tR/x4iSBu7DT99JsS0FeqB
         k57b6Rd2Cuac26F4nvAEbUDO3aBvXNOeB0n09/Swi7BJvd8OkcQdLoVU/VsbdHkaSv8m
         dMKwdSxvRvCu/V6xt615qAEgskld8YZptkPUmYFOBANR0JQAhu4fzoULK/N18AzIgNTx
         fk4T/Hdwne/5mmxIMaRaTUCoayhlpy4dOC/kGlX1Yn/Aa9zlOBpuSeFHwJulzbOOTh8l
         coRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767466; x=1715372266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IWQYp5T2Zl1VQkBfkG2UPdbY2+2qD1xC85V4mipGdk=;
        b=W1eyWJqeaJuGLujzDceGLVsPNdV/STf8ae3uz1mlZMltwzWmUqkD7L5fbcxSqXa1kR
         5c2e+eDZ8wBzPko0w/mL2Ba0r9tRncKRP/a0bbP0ExjZV4LT54xvZQghFrzHlHn80doH
         9MNPRfCS+oudh0TXvHE695RvfUVDoAyuA2ww6up5FtFekTxWIYiolDe0nbY7lWACN1If
         V0oCCXF1y+iAcUTeNJuHIawNpgvPVfxce0c0lhLXiKma8NU7bsLCIsUK3z+y88m1/r+C
         twN5BpbQedBseTITTf7dULH7GLo7dco0NnZ6X52Q/6Zdt+0enOniRI6wWf+EEY7EDXPb
         J3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHEudf77a8s6hdgA0Z5dUr5a4ny2Q2W/QBbqs4escJjk0xy9ghn4XbNcTsjUuSotFWSMLFogTlG31vvnLb8oR0X7mE6ycm0kZ265Wv9LSJ8fh1N0fuEV4XV0mL1KEJNZ5CRE2UrqMbJqjZx62apRzzP1ydDX0tcDB8oKlVkarQJfZoKfzX8fh0FXdhwt0MzeLWxoovCeh4iFQtA3QdjQcz/tkgQzz4/M/XUk9xSNfjr2O+c5TQ7iW/75sX
X-Gm-Message-State: AOJu0Ywg2+i/MXgvekiked/NN/M8Ex8y2bGxMvthqOCRat8hx1Uarjn9
	863ZPge1WyqIi3KQoqZPsaEAfw3fRhlKWmQ+VrhS0ktH4TiTh/Wj
X-Google-Smtp-Source: AGHT+IEtIGM4F5KZzPi9VvGDIN5JQj/cCOTn+HlUGnzm7mBlNIItFfkHkfv9B/ZsX9SzV19oZT9crA==
X-Received: by 2002:a2e:3618:0:b0:2d8:be29:4ca9 with SMTP id d24-20020a2e3618000000b002d8be294ca9mr2679583lja.39.1714767465925;
        Fri, 03 May 2024 13:17:45 -0700 (PDT)
Received: from krava ([83.240.62.36])
        by smtp.gmail.com with ESMTPSA id q11-20020a056402248b00b005726b83071esm2085459eda.4.2024.05.03.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:17:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 May 2024 22:17:41 +0200
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <ZjVGZeY-_ySqgfER@krava>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-3-jolsa@kernel.org>
 <20240503113453.GK40213@noisy.programming.kicks-ass.net>
 <ZjTg2cunShA6VbpY@krava>
 <725e2000dc56d55da4097cface4109c17fe5ad1a.camel@intel.com>
 <ZjU4ganRF1Cbiug6@krava>
 <6c143c648e2eff6c4d4b5e4700d1a8fbcc0f8cbc.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c143c648e2eff6c4d4b5e4700d1a8fbcc0f8cbc.camel@intel.com>

On Fri, May 03, 2024 at 07:38:18PM +0000, Edgecombe, Rick P wrote:
> +Some more shadow stack folks from other archs. We are discussing how uretprobes
> work with shadow stack.
> 
> Context:
> https://lore.kernel.org/lkml/ZjU4ganRF1Cbiug6@krava/
> 
> On Fri, 2024-05-03 at 21:18 +0200, Jiri Olsa wrote:
> > 
> > hack below seems to fix it for the current uprobe setup,
> > we need similar fix for the uretprobe syscall trampoline setup
> 
> It seems like a reasonable direction.
> 
> Security-wise, applications cannot do this on themselves, or it is an otherwise
> privileged thing right?

when uretprobe is created, kernel overwrites the return address on user
stack to point to user space trampoline, so the setup is in kernel hands

with the hack below on top of this patchset I'm no longer seeing shadow
stack app crash on uretprobe.. I'll try to polish it and send out next
week, any suggestions are welcome ;-)

thanks,
jirka


---
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 42fee8959df7..d374305a6851 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -21,6 +21,8 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clon
 void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
+void uprobe_change_stack(unsigned long addr);
+void uprobe_push_stack(unsigned long addr);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 59e15dd8d0f8..804c446231d9 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -577,3 +577,24 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long arg2)
 		return wrss_control(true);
 	return -EINVAL;
 }
+
+void uprobe_change_stack(unsigned long addr)
+{
+	unsigned long ssp;
+
+	ssp = get_user_shstk_addr();
+	write_user_shstk_64((u64 __user *)ssp, (u64)addr);
+}
+
+void uprobe_push_stack(unsigned long addr)
+{
+	unsigned long ssp;
+
+	ssp = get_user_shstk_addr();
+	ssp -= SS_FRAME_SIZE;
+	write_user_shstk_64((u64 __user *)ssp, (u64)addr);
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+}
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 81e6ee95784d..259457838020 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -416,6 +416,7 @@ SYSCALL_DEFINE0(uretprobe)
 	regs->r11 = regs->flags;
 	regs->cx  = regs->ip;
 
+	uprobe_push_stack(r11_cx_ax[2]);
 	return regs->ax;
 
 sigill:
@@ -1191,8 +1192,10 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 		return orig_ret_vaddr;
 
 	nleft = copy_to_user((void __user *)regs->sp, &trampoline_vaddr, rasize);
-	if (likely(!nleft))
+	if (likely(!nleft)) {
+		uprobe_change_stack(trampoline_vaddr);
 		return orig_ret_vaddr;
+	}
 
 	if (nleft != rasize) {
 		pr_err("return address clobbered: pid=%d, %%sp=%#lx, %%ip=%#lx\n",

