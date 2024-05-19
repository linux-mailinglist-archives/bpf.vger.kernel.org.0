Return-Path: <bpf+bounces-30017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F268C9738
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 00:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF4F1C20869
	for <lists+bpf@lfdr.de>; Sun, 19 May 2024 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A07317C;
	Sun, 19 May 2024 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSWQ/H/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164234E1D1;
	Sun, 19 May 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157088; cv=none; b=gDOLuef+SdVZt5KLaTn3sCygXo8F4fRoyWbzGhEHiO0UNlq76Acinjvq9tHkwWLmo6QLTe5hhZPfHeIHQ+IOXsiGZjdqIfPCkMgasiiYy22E9l82v2X7k1X1FbeldmvjuzCf1GqfsajV0WFcs5e3mkPTqEazu0Hrv5K97GLeR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157088; c=relaxed/simple;
	bh=fg7ohdBWKnULCMhyPwARV0dOMRmj1SHe/51R5ZciX10=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXM0gQ3Z8CJdW+EBNOclwThM0WL6YH9oZb+MAbqj1bWILUvPGP8s1q+oCuhcU/ln5JF3FskFaW9mWzOsMNuPZ328WnwooYuUONCz637DNIyZ4UYpAp9qMfpqpb4AvlcEDD02ClbC3/JmKLo/8Nx//MhmD3ZnIs5Y4r93A3QNin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSWQ/H/E; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34db6a29a1eso1552929f8f.1;
        Sun, 19 May 2024 15:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716157084; x=1716761884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=goIREiRJuXempbIzhjUceDqvcpesyLrumaZd4akCD6w=;
        b=fSWQ/H/EwdIK5qCNUZNXbt/iylVmYHuDMOp2mtWah0HW7eZlz5IuyDJc0gKP+K7qp5
         foxzqdomBynLDT9zkFlgmVYEyDRRTbNH4jZpx4QBFZKNRvHt44QpdvHVWWZ/f1TWnDNT
         CT3rFEbHCGrm0xo+5GtP5uKwyFmh7SPqhj84Ie/lncuk8Iu79WxDO+YGH8QzvVsQVzTo
         LPr4mxLkkKDTY2B4rsfHKilk+OL+EEoHIn9Iz9N9R3xyxaseMA6uMo5uD4YBMG8LDXjX
         Y0UT/QUSHQWukF52UDq8iX5n/M4nVaI/TF/a4uMhnhLSWOjmp+/q65CFewK1U6uMgQSW
         JtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157084; x=1716761884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goIREiRJuXempbIzhjUceDqvcpesyLrumaZd4akCD6w=;
        b=MXTf1Ud0+XUSH6oot5KYZuRGOJgTspX93XKu5PJPobM2zJyiNEsfWl2yICeBap3cy/
         7OBfTCzf+sCVbvLm26pw9xnMgrHoHVosOUWYgBQYFkq0c80v/EwGctZD7ytAxGvPWIRj
         B4om6eAPUmx6bg1C20bqVIHNhhlwHqLMdhtVKFPg0Gq7ABju0B7qF56kcA2D3W7gYbt+
         2vJi3XKMYU5PhnBbfGTwSQgnOQNOEceHvtJXrP1VhxQ3imerDeX1P2utCl9IplFPEuGi
         qEaHjY+Smey+9Ze3qIZccPfzujm2PnrknIpRWtzTWIL+/uYaTP4w4wz/IzzjWayAT0U0
         dN0A==
X-Forwarded-Encrypted: i=1; AJvYcCWEkYOJzs/GN/P8bTHKGARsRN7N/TGIIiZ42FNoGXf/WafqSUwubt3KYw5bcdBkaq/xOzegdmrAbc5HH9bs5w7qwLNNVEfK3jL6MHmaX4fVvQcHgROhkBvXGM47Oos5NuTwsv1njnDpBwRYsojD05tUg/F7Mg9KSUyGX0eNcRhcNsJH/CwQR1gL6qejqercgFSwHe9HyqRkTDd0sdTCOjFOVjmraM7Sw2AWyr2+ZEc3gqf+9Zwn3m/+Lj4j
X-Gm-Message-State: AOJu0YxSSxOXYU8zRUIe/HI9NZ7iB3K8qoRv8WourfKSKzW1xnU6zKWi
	Uqo2ty/x6cngf5OaVN4NKs0tBqG67PmUjeclEVVFM2WgG0yKsRv0
X-Google-Smtp-Source: AGHT+IFooj5S4I7pLSIpLa/QfqyyeoxWME22Mmc4N6Toc4dPXMTjaTNvv0sOrxRBboXlWwge+Rg/uQ==
X-Received: by 2002:adf:cd07:0:b0:351:d418:efac with SMTP id ffacd0b85a97d-351d418f351mr8377418f8f.32.1716157083989;
        Sun, 19 May 2024 15:18:03 -0700 (PDT)
Received: from krava ([83.240.61.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5750d5f21d6sm4392336a12.18.2024.05.19.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:18:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 May 2024 00:18:01 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <Zkp6mT2xag29dLTR@krava>
References: <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <20240515113525.GB6821@redhat.com>
 <0fa9634e9ac0d30d513eefe6099f5d8d354d93c1.camel@intel.com>
 <20240515154202.GE6821@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515154202.GE6821@redhat.com>

On Wed, May 15, 2024 at 05:42:03PM +0200, Oleg Nesterov wrote:
> On 05/15, Edgecombe, Rick P wrote:
> >
> > On Wed, 2024-05-15 at 13:35 +0200, Oleg Nesterov wrote:
> > >
> > > > I'm ok with not using optimized uretprobe when shadow stack is detected
> > > > as enabled and we go with current uretprobe in that case
> > >
> > > But how can we detect it? Again, suppose userspace does
> >
> > the rdssp instruction returns the value of the shadow stack pointer. On non-
> > shadow stack it is a nop. So you could check if the SSP is non-zero to find if
> > shadow stack is enabled.
> 
> But again, the ret-probed function can enable it before it returns? And we
> need to check if it is enabled on the function entry if we want to avoid
> sys_uretprobe() in this case. 

yea, that's another complexity

> Although I don't understand why we want to
> avoid it.

AFAIU the problem is that by using uretprobe syscall we make the kernel to
push data on shadow stack [1], which adds another way to modify shadow stack
as pointed out by Rick in here [2]:

 > Shadow stack allows for modification to the shadow stack only through a few
 > limited ways (call, ret, etc). The kernel has the ability to write through
 > shadow stack protections (for example when pushing and popping signal frames),
 > but the ways in which it does this are limited in order to try to prevent
 > providing extra capabilities to attackers wanting to craft their own shadow
 > stacks.


anyway I think we can fix that in another way by using the optimized trampoline,
but returning to the user space through iret when shadow stack is detected
(as I did in the first version, before you adjusted it to the sysret path).

we need to update the return address on stack only when returning through the
trampoline, but we can jump to original return address directly from syscall
through iret.. which is slower, but with shadow stack we don't care

basically the only change is adding the shstk_is_enabled check to the
following condition in SYSCALL_DEFINE0(uretprobe):

	if (regs->sp != sp || shstk_is_enabled())
		return regs->ax;

I'm testing patch below and it looks good so far, I'll add test code to run
existing tests on top of shadow stack as well (when detected).

I'll send new version with that

jirka


---
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 896909f306e3..4cb77e004615 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -22,6 +22,7 @@ void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
 int shstk_update_last_frame(unsigned long val);
+bool shstk_is_enabled(void);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
@@ -33,6 +34,7 @@ static inline void shstk_free(struct task_struct *p) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
 static inline int shstk_update_last_frame(unsigned long val) { return 0; }
+static inline bool shstk_is_enabled(void) { return false; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 9797d4cdb78a..059685612362 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -588,3 +588,8 @@ int shstk_update_last_frame(unsigned long val)
 	ssp = get_user_shstk_addr();
 	return write_user_shstk_64((u64 __user *)ssp, (u64)val);
 }
+
+bool shstk_is_enabled(void)
+{
+	return features_enabled(ARCH_SHSTK_SHSTK);
+}
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6402fb3089d2..5a952c5ea66b 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -12,6 +12,7 @@
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <linux/uaccess.h>
+#include <linux/syscalls.h>
 
 #include <linux/kdebug.h>
 #include <asm/processor.h>
@@ -308,6 +309,122 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 }
 
 #ifdef CONFIG_X86_64
+
+asm (
+	".pushsection .rodata\n"
+	".global uretprobe_trampoline_entry\n"
+	"uretprobe_trampoline_entry:\n"
+	"pushq %rax\n"
+	"pushq %rcx\n"
+	"pushq %r11\n"
+	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
+	"syscall\n"
+	".global uretprobe_syscall_check\n"
+	"uretprobe_syscall_check:\n"
+	"popq %r11\n"
+	"popq %rcx\n"
+
+	/* The uretprobe syscall replaces stored %rax value with final
+	 * return address, so we don't restore %rax in here and just
+	 * call ret.
+	 */
+	"retq\n"
+	".global uretprobe_trampoline_end\n"
+	"uretprobe_trampoline_end:\n"
+	".popsection\n"
+);
+
+extern u8 uretprobe_trampoline_entry[];
+extern u8 uretprobe_trampoline_end[];
+extern u8 uretprobe_syscall_check[];
+
+void *arch_uprobe_trampoline(unsigned long *psize)
+{
+	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	struct pt_regs *regs = task_pt_regs(current);
+
+	/*
+	 * At the moment the uretprobe syscall trampoline is supported
+	 * only for native 64-bit process, the compat process still uses
+	 * standard breakpoint.
+	 */
+	if (user_64bit_mode(regs)) {
+		*psize = uretprobe_trampoline_end - uretprobe_trampoline_entry;
+		return uretprobe_trampoline_entry;
+	}
+
+	*psize = UPROBE_SWBP_INSN_SIZE;
+	return &insn;
+}
+
+static unsigned long trampoline_check_ip(void)
+{
+	unsigned long tramp = uprobe_get_trampoline_vaddr();
+
+	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
+}
+
+SYSCALL_DEFINE0(uretprobe)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long err, ip, sp, r11_cx_ax[3];
+
+	if (regs->ip != trampoline_check_ip())
+		goto sigill;
+
+	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
+	if (err)
+		goto sigill;
+
+	/* expose the "right" values of r11/cx/ax/sp to uprobe_consumer/s */
+	regs->r11 = r11_cx_ax[0];
+	regs->cx  = r11_cx_ax[1];
+	regs->ax  = r11_cx_ax[2];
+	regs->sp += sizeof(r11_cx_ax);
+	regs->orig_ax = -1;
+
+	ip = regs->ip;
+	sp = regs->sp;
+
+	uprobe_handle_trampoline(regs);
+
+	/*
+	 * Some of the uprobe consumers has changed sp, we can do nothing,
+	 * just return via iret.
+	 * .. or shadow stack is enabled, in which case we need to skip
+	 * return through the user space stack address.
+	 */
+	if (regs->sp != sp || shstk_is_enabled())
+		return regs->ax;
+	regs->sp -= sizeof(r11_cx_ax);
+
+	/* for the case uprobe_consumer has changed r11/cx */
+	r11_cx_ax[0] = regs->r11;
+	r11_cx_ax[1] = regs->cx;
+
+	/*
+	 * ax register is passed through as return value, so we can use
+	 * its space on stack for ip value and jump to it through the
+	 * trampoline's ret instruction
+	 */
+	r11_cx_ax[2] = regs->ip;
+	regs->ip = ip;
+
+	err = copy_to_user((void __user *)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
+	if (err)
+		goto sigill;
+
+	/* ensure sysret, see do_syscall_64() */
+	regs->r11 = regs->flags;
+	regs->cx  = regs->ip;
+
+	return regs->ax;
+
+sigill:
+	force_sig(SIGILL);
+	return -1;
+}
+
 /*
  * If arch_uprobe->insn doesn't use rip-relative addressing, return
  * immediately.  Otherwise, rewrite the instruction so that it accesses
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..b503fafb7fb3 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -138,6 +138,9 @@ extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern void uprobe_handle_trampoline(struct pt_regs *regs);
+extern void *arch_uprobe_trampoline(unsigned long *psize);
+extern unsigned long uprobe_get_trampoline_vaddr(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..2816e65729ac 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1474,11 +1474,20 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
+void * __weak arch_uprobe_trampoline(unsigned long *psize)
+{
+	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+
+	*psize = UPROBE_SWBP_INSN_SIZE;
+	return &insn;
+}
+
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	unsigned long insns_size;
 	struct xol_area *area;
+	void *insns;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
@@ -1502,7 +1511,8 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
 	atomic_set(&area->slot_count, 1);
-	arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SIZE);
+	insns = arch_uprobe_trampoline(&insns_size);
+	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
 		return area;
@@ -1827,7 +1837,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
  *
  * Returns -1 in case the xol_area is not allocated.
  */
-static unsigned long get_trampoline_vaddr(void)
+unsigned long uprobe_get_trampoline_vaddr(void)
 {
 	struct xol_area *area;
 	unsigned long trampoline_vaddr = -1;
@@ -1878,7 +1888,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	if (!ri)
 		return;
 
-	trampoline_vaddr = get_trampoline_vaddr();
+	trampoline_vaddr = uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
 		goto fail;
@@ -2123,7 +2133,7 @@ static struct return_instance *find_next_ret_chain(struct return_instance *ri)
 	return ri;
 }
 
-static void handle_trampoline(struct pt_regs *regs)
+void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
 	struct return_instance *ri, *next;
@@ -2187,8 +2197,8 @@ static void handle_swbp(struct pt_regs *regs)
 	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
-	if (bp_vaddr == get_trampoline_vaddr())
-		return handle_trampoline(regs);
+	if (bp_vaddr == uprobe_get_trampoline_vaddr())
+		return uprobe_handle_trampoline(regs);
 
 	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
 	if (!uprobe) {

