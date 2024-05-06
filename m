Return-Path: <bpf+bounces-28667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED158BCC73
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B612851BF
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F023F142E82;
	Mon,  6 May 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnlGjZpy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139E757EA;
	Mon,  6 May 2024 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992986; cv=none; b=AUhxb7a2E3vk7mHI1kZ9r0LOi7ByzmJ4Sz5KJC/iACLHAd3IHXKKqJi3CnLa3ckYr7oPK+x2G5Tp7IOEEVCesUaKL8xKeBlc48VpMLvsBXkvpgmALWVrtxmFrU5kdevwX3XvVevpA5bTliuNJ4FIAvt2YXpJg5uEhHivMB9rVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992986; c=relaxed/simple;
	bh=9NMb3EO3F0DiZNApYRXR91yw6W3gYPuvTxhlybc4//M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD5Mvfz2Mmrk5SJfvwKe3B8WyKhS8ueUgj8Ds6FD22X+bMZEIRHpBAfEb/CYyDhqXs5YZ+OyLJwkFGRRyncOoFxL1jR5i0eL2ibi/Sxs6H0veuC7vjJRdA1i2nHIRNAnrQCju86Q3TvwyS5ubVbEcZ+0iX+YmiEFkmyAYEKJd9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnlGjZpy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so2854885e87.1;
        Mon, 06 May 2024 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714992983; x=1715597783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BJIBSGbrgOG9NZBqdWmimHdMF70VT1B2wz13vLxdkPs=;
        b=lnlGjZpypPGy5SwST+GkLjxQ+n/wMDWmm0PJ+yrB/wQOYddPpAb2CdYa7whtZEv8Sn
         UOUeLISO2cxILNyLgXS1L3s3NJ0bGT6SL/8ZlQDnEG8sVDbAPWYVAnYYCxJ0o4nKbYpz
         eFs9rRBCDKzE+hUjWhf3m7JeisKE1K0P9/tq88Ev1+TlVU8RfgCrOBaHWtPhlOyAir9/
         8P1Jw2rChxadmQDYjgZzMKaNMxSHYW5aprOlFlLG5/SOESAugUedF6Sqp/ZgIoZOMqx1
         ob8xI+WabuTWMMPpAV62t2qmWTtCQ8nzK7Itxx6cVav874ReLD5ca/ufYYtIFmsg2WUx
         xpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714992983; x=1715597783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJIBSGbrgOG9NZBqdWmimHdMF70VT1B2wz13vLxdkPs=;
        b=e5cFkbV34NaOpVJ9eFmxZNx3xyelsaUDilHcyVkTClNmo1ERgKbX7otLiV7dkQrbcz
         jCRcEdjjWDESjuzUI4NKk6/Ccf4w1aDz/jGbFW5Erv4CPk0VOUg/xPl7pi7AGkZ5qiEp
         4se/NEsE6J18Kc2h4nsjW346YxlhykPX5Hz1c5LpnPU34t+qQ59TnxXebcbCpTFAFNxM
         AjKhGA4NHeh1NgiSC6jaUDzVkkWingUgvu7TzA9vIc/tSqm9uoTa1X0A263Gv9tBBHFx
         44gr9+Js6cm+ePpuyWE36XFRKJv7sDGQofaGSEL7wT5Jj3fOmwm6CkO9AvtMexbC0EJK
         gynw==
X-Forwarded-Encrypted: i=1; AJvYcCW6DmT1m9B9Fs0FLyt7/n5fnqgpSXT78TsZSMqgflEC/Eul0KHwFYz6QrB0vMfjVp1EXdXojFJVTYqVl1tmUNbJgeVjk8JxL4Yde0H279i9sxD0Ggcr6urC2OVgX0YNiovIunsykWUcAyy10QBcJq6rzV77I2FbNMXWFENRIs2JBsrTCnBROLubaLu9ECZrRLn5ESpSrQ5Crd7fycR4iGszGEybHL4l+BV5YIGA8DA1PVnCZIkIx0qU+psm
X-Gm-Message-State: AOJu0Yw8dDpGkcqSi5/STPiDKu3XYkDK/txyhO2ejzKRwh4gP5bUdz2E
	juj1Kiqo6RwkxaRclViJfNM78TQ3JGrzmNsqFGQv/xBLie+16SC2
X-Google-Smtp-Source: AGHT+IHCyK3/NNaNYRQTAL/JlLw+JMtaPREdI4MoupuAb10ad8JIR+dA1NVUrOJvGL0InQatybz/Ug==
X-Received: by 2002:ac2:5932:0:b0:51f:2a80:a982 with SMTP id v18-20020ac25932000000b0051f2a80a982mr8741080lfi.47.1714992982348;
        Mon, 06 May 2024 03:56:22 -0700 (PDT)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id el24-20020a170907285800b00a59b9263f59sm2194092ejc.102.2024.05.06.03.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 03:56:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 6 May 2024 12:56:19 +0200
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
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
	"oleg@redhat.com" <oleg@redhat.com>, "yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <Zji3U131RJtQDdA_@krava>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-3-jolsa@kernel.org>
 <20240503113453.GK40213@noisy.programming.kicks-ass.net>
 <ZjTg2cunShA6VbpY@krava>
 <725e2000dc56d55da4097cface4109c17fe5ad1a.camel@intel.com>
 <ZjU4ganRF1Cbiug6@krava>
 <6c143c648e2eff6c4d4b5e4700d1a8fbcc0f8cbc.camel@intel.com>
 <ZjVGZeY-_ySqgfER@krava>
 <d2e0e53581e26358ee0b3d188a07795878938d2f.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2e0e53581e26358ee0b3d188a07795878938d2f.camel@intel.com>

On Fri, May 03, 2024 at 08:35:24PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-05-03 at 22:17 +0200, Jiri Olsa wrote:
> > when uretprobe is created, kernel overwrites the return address on user
> > stack to point to user space trampoline, so the setup is in kernel hands
> 
> I mean for uprobes in general. I'm didn't have any specific ideas in mind, but
> in general when we give the kernel more abilities around shadow stack we have to
> think if attackers could use it to work around shadow stack protections.
> 
> > 
> > with the hack below on top of this patchset I'm no longer seeing shadow
> > stack app crash on uretprobe.. I'll try to polish it and send out next
> > week, any suggestions are welcome ;-)
> 
> Thanks. Some comments below.
> 
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
> > index 42fee8959df7..d374305a6851 100644
> > --- a/arch/x86/include/asm/shstk.h
> > +++ b/arch/x86/include/asm/shstk.h
> > @@ -21,6 +21,8 @@ unsigned long shstk_alloc_thread_stack(struct task_struct
> > *p, unsigned long clon
> >  void shstk_free(struct task_struct *p);
> >  int setup_signal_shadow_stack(struct ksignal *ksig);
> >  int restore_signal_shadow_stack(void);
> > +void uprobe_change_stack(unsigned long addr);
> > +void uprobe_push_stack(unsigned long addr);
> 
> Maybe name them:
> shstk_update_last_frame();
> shstk_push_frame();

ok

> 
> 
> >  #else
> >  static inline long shstk_prctl(struct task_struct *task, int option,
> >                                unsigned long arg2) { return -EINVAL; }
> > diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> > index 59e15dd8d0f8..804c446231d9 100644
> > --- a/arch/x86/kernel/shstk.c
> > +++ b/arch/x86/kernel/shstk.c
> > @@ -577,3 +577,24 @@ long shstk_prctl(struct task_struct *task, int option,
> > unsigned long arg2)
> >                 return wrss_control(true);
> >         return -EINVAL;
> >  }
> > +
> > +void uprobe_change_stack(unsigned long addr)
> > +{
> > +       unsigned long ssp;
> 
> Probably want something like:
> 
> 	if (!features_enabled(ARCH_SHSTK_SHSTK))
> 		return;

ok

> 
> So this doesn't try the below if shadow stack is disabled.
> 
> > +
> > +       ssp = get_user_shstk_addr();
> > +       write_user_shstk_64((u64 __user *)ssp, (u64)addr);
> > +}
> 
> Can we know that there was a valid return address just before this point on the
> stack? Or could it be a sigframe or something?

when uprobe hijack the return address it assumes it's on the top of the stack,
so it's saved and replaced with address of the user space trampoline

> 
> > +
> > +void uprobe_push_stack(unsigned long addr)
> > +{
> > +       unsigned long ssp;
> 
> 	if (!features_enabled(ARCH_SHSTK_SHSTK))
> 		return;
> 
> > +
> > +       ssp = get_user_shstk_addr();
> > +       ssp -= SS_FRAME_SIZE;
> > +       write_user_shstk_64((u64 __user *)ssp, (u64)addr);
> > +
> > +       fpregs_lock_and_load();
> > +       wrmsrl(MSR_IA32_PL3_SSP, ssp);
> > +       fpregs_unlock();
> > +}
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 81e6ee95784d..259457838020 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -416,6 +416,7 @@ SYSCALL_DEFINE0(uretprobe)
> >         regs->r11 = regs->flags;
> >         regs->cx  = regs->ip;
> >  
> > +       uprobe_push_stack(r11_cx_ax[2]);
> 
> I'm concerned this could be used to push arbitrary frames to the shadow stack.
> Couldn't an attacker do a jump to the point that calls this syscall? Maybe this
> is what peterz was raising.

of course never say never, but here's my reasoning why I think it's ok

the page with the syscall trampoline is mapped in user space and can be
found in procfs maps file under '[uprobes]' name

the syscall can be called only from this trampoline, if it's called from
anywhere else the calling process receives SIGILL

now if you run the uretprobe syscall without any pending uretprobe for
the task it will receive SIGILL before it gets to the point of pushing
address on the shadow stack

and to configure the uretprobe you need to have CAP_PERFMON or CAP_SYS_ADMIN

if you'd actually managed to get the pending uretprobe instance, the shadow
stack entry is going to be used/pop-ed right away in the trampoline with
the ret instruction

and as I mentioned above it's ensured that the syscall is returning to the
trampoline and it can't be called from any other place

> 
> >         return regs->ax;
> >  
> >  sigill:
> > @@ -1191,8 +1192,10 @@ arch_uretprobe_hijack_return_addr(unsigned long
> > trampoline_vaddr, struct pt_regs
> >                 return orig_ret_vaddr;
> >  
> >         nleft = copy_to_user((void __user *)regs->sp, &trampoline_vaddr,
> > rasize);
> > -       if (likely(!nleft))
> > +       if (likely(!nleft)) {
> > +               uprobe_change_stack(trampoline_vaddr);
> >                 return orig_ret_vaddr;
> > +       }
> >  
> >         if (nleft != rasize) {
> >                 pr_err("return address clobbered: pid=%d, %%sp=%#lx,
> > %%ip=%#lx\n",
> 

I'll try to add uprobe test under tools/testing/selftests/x86/test_shadow_stack.c
and send that and change below as part of new version

thanks for the comments,
jirka


---
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 42fee8959df7..2e1ddcf98242 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -21,6 +21,8 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clon
 void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
+int shstk_update_last_frame(unsigned long val);
+int shstk_push_frame(unsigned long val);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
@@ -31,6 +33,8 @@ static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
 static inline void shstk_free(struct task_struct *p) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
+static inline int shstk_update_last_frame(unsigned long val) { return 0; }
+static inline int shstk_push_frame(unsigned long val) { return 0; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 59e15dd8d0f8..66434dfde52e 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -577,3 +577,32 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long arg2)
 		return wrss_control(true);
 	return -EINVAL;
 }
+
+int shstk_update_last_frame(unsigned long val)
+{
+	unsigned long ssp;
+
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	ssp = get_user_shstk_addr();
+	return write_user_shstk_64((u64 __user *)ssp, (u64)val);
+}
+
+int shstk_push_frame(unsigned long val)
+{
+	unsigned long ssp;
+
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	ssp = get_user_shstk_addr();
+	ssp -= SS_FRAME_SIZE;
+	if (write_user_shstk_64((u64 __user *)ssp, (u64)val))
+		return -EFAULT;
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+	return 0;
+}
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 81e6ee95784d..ae6c3458a675 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -406,6 +406,11 @@ SYSCALL_DEFINE0(uretprobe)
 	 * trampoline's ret instruction
 	 */
 	r11_cx_ax[2] = regs->ip;
+
+	/* make the shadow stack follow that */
+	if (shstk_push_frame(regs->ip))
+		goto sigill;
+
 	regs->ip = ip;
 
 	err = copy_to_user((void __user *)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
@@ -1191,8 +1196,13 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 		return orig_ret_vaddr;
 
 	nleft = copy_to_user((void __user *)regs->sp, &trampoline_vaddr, rasize);
-	if (likely(!nleft))
+	if (likely(!nleft)) {
+		if (shstk_update_last_frame(trampoline_vaddr)) {
+			force_sig(SIGSEGV);
+			return -1;
+		}
 		return orig_ret_vaddr;
+	}
 
 	if (nleft != rasize) {
 		pr_err("return address clobbered: pid=%d, %%sp=%#lx, %%ip=%#lx\n",

