Return-Path: <bpf+bounces-28541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E238BB3CE
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 21:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CAC1C237CC
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D12158866;
	Fri,  3 May 2024 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKvL27KE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC1156F2A;
	Fri,  3 May 2024 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763912; cv=none; b=GWh4xyXLoX5n3UzBQ1GPZtSdql1Y2eJS5hBQ/gnKmuwPx3pJ5RpkBXkeoyGLpz2GDp7SyKH0dxysIcSXaLzmzNZde8c7dtb2JufGW2TI6kanbestIlhnZf7idRdABV1lv1PA453jkOfRZ+T+70qtqaVMdfij9eVoLS98hewGy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763912; c=relaxed/simple;
	bh=Cf9LoRUpPjAh+yLyJB4d5K3369qJcbMglaMH7KY/O5I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6dvo/0RlTIO+RlFBLpLX3jtcuzM5dtA7ux0pf+PlYAYIiAxoSr+nUo7HCIFT5Sh4Q8L2dWHbx/ff2mktOVb16Fnq6tvdZHAoXTh7EWdklUSJMA0/7OYlqGdMAtsm00qpd2hI3GWQAgcmoMqG230vKuL9Md4Tgti4RmJ8j4jGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKvL27KE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5544fd07easo1465701066b.0;
        Fri, 03 May 2024 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714763909; x=1715368709; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6aq4UQcdpcKwckp57zb2we9p40MZ5pzcBeJbE0PaEe8=;
        b=JKvL27KE2qSmFTbHT3DnJk19eRmc8tYNVLIn9YU8X8PHBQY8wr+OTwPnUvu8SqFEwO
         Fsl55q2iBrbqxPwtCjEMe5Qq6dbVLMs1XHUc2u0t1avjjNNKrCOQ1RpmQKCkFL1vEuK4
         5qohQiAxOjScYix4+Sn1JbXJy5esXQGaKiBU+LxUgW5oce2CoLQxDhgvmgvFfDYVxmVV
         MBLX7R5op/LIkvoALgG7YF/biubKWnDdj0otdO+zkPY6epQmpbqXUTJMkrVSIOMvlqJ8
         2Mad6loI+QVpJcmyLkyUgCrpEBwQtA8oBBgyo6LkbPSd9WGVItsL352VAkEW+Yq23Yxz
         IsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763909; x=1715368709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aq4UQcdpcKwckp57zb2we9p40MZ5pzcBeJbE0PaEe8=;
        b=NH7UWAIP1jO0w5s9zPT2mxfbBxbUrDOtYUUo/UtslBKTM24yT9rGMh95ZkePh+12db
         5Wv7dCJJBpVfd0Qmr5A9yJTBVsP7m3Jm3N36bwb4W5NbvnMoevh2/srOeJzDFfp1DzS5
         BcYQtNawAynqIYKAhDb5A6Od1V9FfCQHFd67nYnZQOeFKu3X/FmG3PH4ZwGNxThNMiQe
         udKEGVPpUg16eP0qhlcu+TQonjLqHQgMA5JOr5aIEtImNNYPZ/rcCSPYH+RlHTFQnDa5
         rJU6N8m7tCaD7it+XS3HIZ9HioPcJ1PBc1KBO2HQMMR61RY5z65PVW9WoVLUUIUFGgn3
         phug==
X-Forwarded-Encrypted: i=1; AJvYcCUF8uU+Cf5fglxcldK2PPkjBXJZRZ5sSw/F7bIJE+OpAg08YJrYiEhSxU8PnhCnd8Kcdif2Y4WI5y50OLowInF+eXGu9uQDPD5geK57SSupWawySRftdaYBUkhcsanu+Myi8RwBUPiFBGKXQoeW4ePLDrZmvTLQ+QUo6AeoOgZjvEcr/bJgRJFpZ6HjcEmFd3GUVogTPW802CaWA4p6EkyvpkgqCfmOmjlkVg4FwlscbzAsev9BTo8ShQxk
X-Gm-Message-State: AOJu0YzTnx/MLXyp4ijHlhB1lwcx/8pkCdRS1UuquTCPbzaNt21VFOKN
	GeBY2R1zk/FLmN5kg63HzcQFZnUW+4PeSM/3k8J6g4iVQpZEpBql
X-Google-Smtp-Source: AGHT+IH3PC/LlW/jHmTN85qf2LBTbgiAMP6Up8zHTigpFCHasVU/hv3IlOZVVnIm5jTFS2fJ/94rdQ==
X-Received: by 2002:a50:9993:0:b0:570:5e7f:62cb with SMTP id m19-20020a509993000000b005705e7f62cbmr2156480edb.29.1714763908575;
        Fri, 03 May 2024 12:18:28 -0700 (PDT)
Received: from krava ([83.240.62.36])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402517100b0056fe755f1e6sm1978876ede.91.2024.05.03.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:18:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 May 2024 21:18:25 +0200
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"yhs@fb.com" <yhs@fb.com>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <ZjU4ganRF1Cbiug6@krava>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-3-jolsa@kernel.org>
 <20240503113453.GK40213@noisy.programming.kicks-ass.net>
 <ZjTg2cunShA6VbpY@krava>
 <725e2000dc56d55da4097cface4109c17fe5ad1a.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <725e2000dc56d55da4097cface4109c17fe5ad1a.camel@intel.com>

On Fri, May 03, 2024 at 03:53:15PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-05-03 at 15:04 +0200, Jiri Olsa wrote:
> > On Fri, May 03, 2024 at 01:34:53PM +0200, Peter Zijlstra wrote:
> > > On Thu, May 02, 2024 at 02:23:08PM +0200, Jiri Olsa wrote:
> > > > Adding uretprobe syscall instead of trap to speed up return probe.
> > > > 
> > > > At the moment the uretprobe setup/path is:
> > > > 
> > > >    - install entry uprobe
> > > > 
> > > >    - when the uprobe is hit, it overwrites probed function's return
> > > > address
> > > >      on stack with address of the trampoline that contains breakpoint
> > > >      instruction
> > > > 
> > > >    - the breakpoint trap code handles the uretprobe consumers execution
> > > > and
> > > >      jumps back to original return address
> 
> Hi,
> 
> I worked on the x86 shadow stack support.
> 
> I didn't know uprobes did anything like this. In hindsight I should have looked
> more closely. The current upstream behavior is to overwrite the return address
> on the stack?
> 
> Stupid uprobes question - what is actually overwriting the return address on the
> stack? Is it the kernel? If so perhaps the kernel could just update the shadow
> stack at the same time.

yes, it's in kernel - arch_uretprobe_hijack_return_addr .. so I guess
we need to update the shadow stack with the new return value as well

> 
> > > > 
> > > > This patch replaces the above trampoline's breakpoint instruction with new
> > > > ureprobe syscall call. This syscall does exactly the same job as the trap
> > > > with some more extra work:
> > > > 
> > > >    - syscall trampoline must save original value for rax/r11/rcx registers
> > > >      on stack - rax is set to syscall number and r11/rcx are changed and
> > > >      used by syscall instruction
> > > > 
> > > >    - the syscall code reads the original values of those registers and
> > > >      restore those values in task's pt_regs area
> > > > 
> > > >    - only caller from trampoline exposed in '[uprobes]' is allowed,
> > > >      the process will receive SIGILL signal otherwise
> > > > 
> > > 
> > > Did you consider shadow stacks? IIRC we currently have userspace shadow
> > > stack support available, and that will utterly break all of this.
> > 
> > nope.. I guess it's the extra ret instruction in the trampoline that would
> > make it crash?
> 
> The original behavior seems problematic for shadow stack IIUC. I'm not sure of
> the additional breakage with the new behavior.

I can see it's broken also for current uprobes

> 
> Roughly, how shadow stack works is there is an additional protected stack for
> the app thread. The HW pushes to from the shadow stack with CALL, and pops from
> it with RET. But it also continues to push and pop from the normal stack. On
> pop, if the values don't match between the two stacks, an exception is
> generated. The whole point is to prevent the app from overwriting its stack
> return address to return to random places.
> 
> Userspace cannot (normally) write to the shadow stack, but the kernel can do
> this or adust the SSP (shadow stack pointer). So in the kernel (for things like
> sigreturn) there is an ability to do what is needed. Ptracers also can do things
> like this.

hack below seems to fix it for the current uprobe setup,
we need similar fix for the uretprobe syscall trampoline setup

jirka


---
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 42fee8959df7..99a0948a3b79 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -21,6 +21,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clon
 void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
+void uprobe_change_stack(unsigned long addr);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 59e15dd8d0f8..d2c4dbe5843c 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -577,3 +577,11 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long arg2)
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
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 81e6ee95784d..88afbeaacb8f 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -348,7 +348,7 @@ void *arch_uprobe_trampoline(unsigned long *psize)
 	 * only for native 64-bit process, the compat process still uses
 	 * standard breakpoint.
 	 */
-	if (user_64bit_mode(regs)) {
+	if (0 && user_64bit_mode(regs)) {
 		*psize = uretprobe_syscall_end - uretprobe_syscall_entry;
 		return uretprobe_syscall_entry;
 	}
@@ -1191,8 +1191,10 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 		return orig_ret_vaddr;
 
 	nleft = copy_to_user((void __user *)regs->sp, &trampoline_vaddr, rasize);
-	if (likely(!nleft))
+	if (likely(!nleft)) {
+		uprobe_change_stack(trampoline_vaddr);
 		return orig_ret_vaddr;
+	}
 
 	if (nleft != rasize) {
 		pr_err("return address clobbered: pid=%d, %%sp=%#lx, %%ip=%#lx\n",

