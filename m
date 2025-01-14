Return-Path: <bpf+bounces-48744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAEFA102EC
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB13E3A3EDB
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3DD24024E;
	Tue, 14 Jan 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGbrWr+r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042081C3BFC;
	Tue, 14 Jan 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846548; cv=none; b=CCPkiBkUDxZr/WmhN2y1f3ETXDKYh/y7AkccNWiL3WuyW8G+se3/hsoGYsN71tGZf4hXTuf9oS25ClEknpvKZWpX4rOq7vQuFtQ9LTkQenIl2684BEITdeEMl1dKWbVnxFMFvKa6O4BF3FrEKhxE6X+RvjaSDRs/Qj+VDpvbUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846548; c=relaxed/simple;
	bh=Qaqw/d9lC8CQsh5JeVzC/oI36XG6E1brH0p1uKNHmcs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxNFnzvPjvprfdK/jObj/THiUmyMW5pemzMvEq8TJPyFt8jJWhZzgurZWTd7J+ifP6cdHiHygwxfEqMLURCoBTBcuSnYPjVTgzl0XVlWna5cOATtGyX6nhFkpMT9IGC3L9Vz4lcHM2tiL4LCJVDgzDf1KipSEti1VeOUZ2Hp9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGbrWr+r; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso8748008a12.3;
        Tue, 14 Jan 2025 01:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736846544; x=1737451344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y19IXkkrU0Tlnmx/cY2VULRAPR2qxUW7RFc1gfNzto4=;
        b=TGbrWr+rK95QrLsbSQOGBsNGuiOTBguhZx4Fiw4APWFszmsSybexFnFFmo2OqwFk4Z
         glQECWfxODK8TwyLWnsSSa+TVaSNS1SeueGIdo05InTdblWFBcDfvANycMhFg6gkyvg6
         WSHPn9MXeM2zvpAPJ1v3Ypy0EcTW9XTXwyxb5UC5nq688DMwwQLNXwrci+e9CIA17qPP
         0N7sYf2yjgnilnUF/EqW9nr0wsTpB+Z14FyYUyf5PBco2BicFY+EjgLo/Y165XgS0U7E
         09x4/m0o0iTtbs14EfzMcYZjllNY20LDHfFqZJlr4nBcbouCM4ahmYa9UqI4vG88Tpi4
         e2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736846544; x=1737451344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y19IXkkrU0Tlnmx/cY2VULRAPR2qxUW7RFc1gfNzto4=;
        b=suFahoNOjIjVKA/wOFJoQpU5PWAthupsvDJ/9dtaC4eSJGt+5/wNYbSuCDCvLg9L/T
         mlYi+G5AgbCwpDL+Bf1SwV2GbElsmq/SiDXj9UsbKtG+av7h/0/bYiCushkHL2IA9JY9
         tSr3zwMhflG7nba24FcXdh1x4YswIqa6ErtyoE2M8O+nE8G7YlGZAEW4UxnX/qwSQNz4
         TbYHs+rLRGufyTm8HEQwDGi2m2/1QS3spPX+BpGYRX4ZRx47JCyoDBn+B66SQsPgnlW1
         SKppzlZwx8A+hQTM0Rmfg6AHWnXF3rD4uXcS60udUqxK15RkpEiDd/qle1+ET6Gy4rW9
         vZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCU4/OPVVp27hESrzcacW8EGeM5NlEq5Eu4E7soOLe037p3AwbgJ/9CjyDO05zfEZjwahQQ=@vger.kernel.org, AJvYcCUmJ0TYi/iyJ6GvzEjqouKDpLB5oK1rQmbRm/zb4yzg5gtBi9aLY0GJTrWe2Gofj/zu47i6DKLCxS1R@vger.kernel.org, AJvYcCUwBqRwXoKgslFNCj4jePbpVhMLEACk2d6Ceyzq696dnfu024ezgqw7q1Oca/KMmlYsU4UtcLxzcWJhJl42@vger.kernel.org, AJvYcCW0f34uKR0YD26EUZRR5kLMd3A9puogOQE3wJmMaMM9uwk/MZyKYdyZv+l2y2A2lFFtly2HN8XuhjkK0NHL0A58rww0@vger.kernel.org
X-Gm-Message-State: AOJu0YzJqgV0giO5VKOr0XWdCxCuAUOwbHd5kc+ZjDtfogTUOitBz2q1
	em4rvamB5ZC88KIxqaWqsJVeWofInx2S7J7RGvMHnCzmEytPHTlD
X-Gm-Gg: ASbGnctYsNRCT3SFrqJ/+CjM25amlU5vt2k2JzH3vgxfWOoHw/90A7q43WZmPFMJ4Mg
	j8aWXQp0+RAMnId50+aBNqUyTzGSY0uaKGiWJ2LrfayRUQBL8rQlqQqCo+Ni2Nd/DTVeOpaXufR
	Wt1FwI12hi7Pa4scIKXW/m1NfUylVmzxKK6wFEdsp5smVSmbU31lSEAyjzW3De8o46ap2cBr9mM
	OZ+kiVZk+YQ8ZEypbwFA3Q7YuZvTn7WNiTvJ7/GnD4=
X-Google-Smtp-Source: AGHT+IEENe7uSO6cl5ihExesxc+fRy3dZ2MxJUC+SkU4WBbrzsIHip58ZI1NsW5j0XMoOR5R2zKotA==
X-Received: by 2002:a05:6402:354a:b0:5d2:7396:b0ed with SMTP id 4fb4d7f45d1cf-5d972e0e3abmr51801849a12.14.1736846543949;
        Tue, 14 Jan 2025 01:22:23 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9645fddsm601930766b.169.2025.01.14.01.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 01:22:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Jan 2025 10:22:20 +0100
To: Jiri Olsa <olsajiri@gmail.com>, oleg@redhat.com
Cc: Aleksa Sarai <cyphar@cyphar.com>, Eyal Birger <eyal.birger@gmail.com>,
	mhiramat@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <Z4YszJfOvFEAaKjF@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4K7D10rjuVeRCKq@krava>

On Sat, Jan 11, 2025 at 07:40:15PM +0100, Jiri Olsa wrote:
> On Sat, Jan 11, 2025 at 02:25:37AM +1100, Aleksa Sarai wrote:
> > On 2025-01-10, Eyal Birger <eyal.birger@gmail.com> wrote:
> > > Hi,
> > > 
> > > When attaching uretprobes to processes running inside docker, the attached
> > > process is segfaulted when encountering the retprobe. The offending commit
> > > is:
> > > 
> > > ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> > > 
> > > To my understanding, the reason is that now that uretprobe is a system call,
> > > the default seccomp filters in docker block it as they only allow a specific
> > > set of known syscalls.
> > 
> > FWIW, the default seccomp profile of Docker _should_ return -ENOSYS for
> > uretprobe (runc has a bunch of ugly logic to try to guarantee this if
> > Docker hasn't updated their profile to include it). Though I guess that
> > isn't sufficient for the magic that uretprobe(2) does...
> > 
> > > This behavior can be reproduced by the below bash script, which works before
> > > this commit.
> > > 
> > > Reported-by: Rafael Buchbinder <rafi@rbk.io>
> 
> hi,
> nice ;-) thanks for the report, the problem seems to be that uretprobe syscall
> is blocked and uretprobe trampoline does not expect that
> 
> I think we could add code to the uretprobe trampoline to detect this and
> execute standard int3 as fallback to process uretprobe, I'm checking on that

hack below seems to fix the issue, it's using rbx to signal that uretprobe
syscall got executed, if not, trampoline does int3 and executes uretprobe
handler in the old way

unfortunately now the uretprobe trampoline size crosses the xol slot limit so
will need to come up with some generic/arch code solution for that, code below
is neglecting that for now

jirka


---
 arch/x86/kernel/uprobes.c | 24 ++++++++++++++++++++++++
 include/linux/uprobes.h   |  1 +
 kernel/events/uprobes.c   | 10 ++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..b54863f6fa25 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -315,14 +315,25 @@ asm (
 	".global uretprobe_trampoline_entry\n"
 	"uretprobe_trampoline_entry:\n"
 	"pushq %rax\n"
+	"pushq %rbx\n"
 	"pushq %rcx\n"
 	"pushq %r11\n"
+	"movq $1, %rbx\n"
 	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
 	"syscall\n"
 	".global uretprobe_syscall_check\n"
 	"uretprobe_syscall_check:\n"
+	"or %rbx,%rbx\n"
+	"jz uretprobe_syscall_return\n"
 	"popq %r11\n"
 	"popq %rcx\n"
+	"popq %rbx\n"
+	"popq %rax\n"
+	"int3\n"
+	"uretprobe_syscall_return:\n"
+	"popq %r11\n"
+	"popq %rcx\n"
+	"popq %rbx\n"
 
 	/* The uretprobe syscall replaces stored %rax value with final
 	 * return address, so we don't restore %rax in here and just
@@ -338,6 +349,16 @@ extern u8 uretprobe_trampoline_entry[];
 extern u8 uretprobe_trampoline_end[];
 extern u8 uretprobe_syscall_check[];
 
+#define UINSNS_PER_PAGE                 (PAGE_SIZE/UPROBE_XOL_SLOT_BYTES)
+
+bool arch_is_uretprobe_trampoline(unsigned long vaddr)
+{
+	unsigned long start = uprobe_get_trampoline_vaddr();
+	unsigned long end = start + 2*UINSNS_PER_PAGE;
+
+	return vaddr >= start && vaddr < end;
+}
+
 void *arch_uprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
@@ -418,6 +439,9 @@ SYSCALL_DEFINE0(uretprobe)
 	regs->r11 = regs->flags;
 	regs->cx  = regs->ip;
 
+	/* zero rbx to signal trampoline that uretprobe syscall was executed */
+	regs->bx  = 0;
+
 	return regs->ax;
 
 sigill:
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e0a4c2082245..dbde57a68a1b 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -213,6 +213,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
+bool arch_is_uretprobe_trampoline(unsigned long vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index fa04b14a7d72..73df64109f38 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1703,6 +1703,11 @@ void * __weak arch_uprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
+bool __weak arch_is_uretprobe_trampoline(unsigned long vaddr)
+{
+	return vaddr == uprobe_get_trampoline_vaddr();
+}
+
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
@@ -1725,8 +1730,9 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->vaddr = vaddr;
 	init_waitqueue_head(&area->wq);
-	/* Reserve the 1st slot for get_trampoline_vaddr() */
+	/* Reserve the first two slots for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
+	set_bit(1, area->bitmap);
 	insns = arch_uprobe_trampoline(&insns_size);
 	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
 
@@ -2536,7 +2542,7 @@ static void handle_swbp(struct pt_regs *regs)
 	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
-	if (bp_vaddr == uprobe_get_trampoline_vaddr())
+	if (arch_is_uretprobe_trampoline(bp_vaddr))
 		return uprobe_handle_trampoline(regs);
 
 	rcu_read_lock_trace();
-- 
2.47.1


