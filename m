Return-Path: <bpf+bounces-51252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448A8A3278E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF06416671D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631420E329;
	Wed, 12 Feb 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er8PhO+V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A651DFDE;
	Wed, 12 Feb 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368295; cv=none; b=QAkDno5AvwPms2umjBRxm4VWZAlL7K6Usw6k0T5pOc3NjH6yABb3vrzJW5Ch0jL78NEFJpXV92Z5Kfbnt8pWyocZ4EXSRFU21mjo/XmrMa40Z23+XsPS/k2gSRcRqy8DkJSnidgjEdDLPTXrKvxxKxPdZGQKy3ueHK7H+HBcQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368295; c=relaxed/simple;
	bh=9YjzMBkUgd4USe1LdFDokt2j7fxzypWig1WTfc8rg1s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLxII1Iv0W5XhZ63OPN++R/jeDWtM2wsWdTpYaYOSSfNEgVGWJpk+sRhazM1UHGVCBjz62I0q9Woc6a64hGQkv8VhseEJudEerkgOwfLhZfTIc9h9RhRedOmQlU5FXi0dQECT2rMp7T99hzWaCoJyxi4QhPNZiXCWIZCmYbcAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er8PhO+V; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7fa1bc957so73308366b.2;
        Wed, 12 Feb 2025 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368292; x=1739973092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWgaRORqR0FRFMsVrMYjxpMIPGLqqeGvJvZVUdyaQXc=;
        b=er8PhO+V70RG0D6ktEM8M68OzOCGGlX8JWXUvqOEA/a4AldCBTe+WP8Ic3oVBr8Bsj
         mjW5w/34rS0yeldeAprtjW/PXNB+dabiubzd4GXjN/JatPh2BzLuz3JE6JwvbXrwxedO
         4MlZh5mBBhhUHB0ykpZ6aGY5QIvQyGs3aq7SBqS3hljy9nsX9d/0THUXmi9vLRfwpDKx
         b03xnToJD5XGPAmQgJnjK6V1yqmgB0D0RMzWVJ9d0oUeT/JlFt0Ls0vt/ylZ6WG26VUM
         Q05intpJNGTqOWzdjC6eewQxY7lOij8HCyQIvij+YUdokVpB74ri034UMpz3i+hVz6Iy
         JoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368292; x=1739973092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWgaRORqR0FRFMsVrMYjxpMIPGLqqeGvJvZVUdyaQXc=;
        b=FP204KvAwCA1rXRpzGgweBB0qxg3MgVnO93ZR4k/0oJvSyykcexvou+wuvIlgV0WZg
         yni3RfSnbl4RmJ1JuY07lNNemcjcgHf4W/9Zh81W2bA1ulxtNYG8i3WD6JAPXwTtD+M8
         e0TbREKsxxvIdREoawAdBa45vppKWggeVKN0uU7QEyb2cj/Bru/qecgvK0HHqLlH4r6n
         bRGxGkZhumRLeyWNvkdceS86EXRs5IFarYoHZdf7oF0G42gRk+PoMbMnzAps6FsbXKb8
         Ij74paT7OwsZ/ebmjbYZn52T4N8tQwAxMKwnSIZfxQq8XsO2Et14RHKzv0DO3zVUdjGH
         S5dw==
X-Forwarded-Encrypted: i=1; AJvYcCWCSLnW3MyjV1GRAFhvhGopeuZTef4nNDtASFPmwL0NYh0RB5JJkkXfd4vI/Nbf+YkvxWFZIN+AYaLL7mqN@vger.kernel.org, AJvYcCWU46EZ3r57vSEME7OxzaTgNnWriCZ2UI/z+W7tOeJK5QHEQEME/RWKKnqZGj4CHDBYLqM=@vger.kernel.org, AJvYcCWWCMz0OIxFiPpubQsxJ8qXhIfn0a4QH7uvrKGAyuTDgsd0BBu4z2+Y6lNPiGkpm6DlZhARcVzKAeQ8@vger.kernel.org, AJvYcCWcwF3y2pJR3PK9FzLU4+PmFVXcxgZLPO87aDVybOCAvzAYADIvOG0zmCG/8cmXIuta8u+IfjdW/8vmfSEeDTOfbN/b@vger.kernel.org, AJvYcCWs5MkpRBFhRlgxw17QoCTnkgItpkl5uJfHeZ5xrPnNI6epb2q8vyB51JFXDbd3qDgHnD7rD9jD@vger.kernel.org
X-Gm-Message-State: AOJu0YzinVksDhon430LWd6XhEWbeWslq/anZ91ACLkQfDhtC4li1MlS
	ofZtSuyh3YbE0FIeNzokgSWOG5gb2I+yfIr92NTWldDHvYV1QDjF
X-Gm-Gg: ASbGncvm3J172nAYIOOHp+YWcR9/C1v9lf0vX9AHGAjE6/JuQ9CCFj+gf8q20eVTe4A
	apYBLLXDfXAy7uA35zdppOswh1eg/H/AcZoDtNU6ODkDKivHWyPStitlkRa3DEEPU5ByJ8YoeHx
	f2tfWYERlyyMjgSrFAT5zTE4hPP6kxu/jFjN1/0VIa03JnRwebFBipjPJ9ZPqU3fPRWdp8RrmvT
	evpwjpyXz1MH1oNT25DV9L0VOblixLUPDUNSkwNP25dJuMLps1y1/sH28hMa+xbQ5ix534xX9P1
	nCkVyEI=
X-Google-Smtp-Source: AGHT+IFX9i/vrDhYBpxdXVYrHiw2AvtaHV+PAHbqipVnrLTRgL04qKCaZmY29JuXIGDQq2EMjSNTaA==
X-Received: by 2002:a17:907:1909:b0:ab7:f24d:4874 with SMTP id a640c23a62f3a-ab7f33444abmr306419466b.1.1739368291818;
        Wed, 12 Feb 2025 05:51:31 -0800 (PST)
Received: from krava ([2a00:102a:5024:e483:e531:7f9e:99e:ba32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7aa374d92sm850029366b.153.2025.02.12.05.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:51:31 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 12 Feb 2025 14:51:28 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
	bpf <bpf@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv2 perf/core] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <Z6ynYCT-xS7DQ5iq@krava>
References: <20250211111559.2984778-1-jolsa@kernel.org>
 <CAEf4BzYPmtUirnO3Bp+3F3d4++4ttL_MZAG+yGcTTKTRK2X2vw@mail.gmail.com>
 <CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
 <20250211165940.GB9174@redhat.com>
 <20250212130509.ce1987095c6b17b26d3ee40a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212130509.ce1987095c6b17b26d3ee40a@kernel.org>

On Wed, Feb 12, 2025 at 01:05:09PM +0900, Masami Hiramatsu wrote:
> On Tue, 11 Feb 2025 17:59:41 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > On 02/11, Alexei Starovoitov wrote:
> > >
> > > > > +#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)
> > >
> > > If you respin anyway maybe use ~0UL instead?
> > > In the above and in
> > > uprobe_get_trampoline_vaddr(),
> > > since
> > >
> > > unsigned long trampoline_vaddr = -1;
> > 
> > ... or -1ul in both cases.
> > 
> > I agree, UPROBE_NO_TRAMPOLINE_VADDR has a single user, looks
> > a bit strange...
> 
> I think both this function and uprobe_get_trampoline_vaddr()
> should use the same macro as a token.
> (and ~0UL is a bit more comfortable for me too :) )
> 
> ----
> unsigned long uprobe_get_trampoline_vaddr(void)
> {
> 	struct xol_area *area;
> 	unsigned long trampoline_vaddr = -1;
> ----


sounds good, I'll send new version with change below if there
are no objections

thanks,
jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..015b2a6bac11 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -357,19 +357,23 @@ void *arch_uprobe_trampoline(unsigned long *psize)
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
+	/* If there's no trampoline, we are called from wrong place. */
+	tramp = uprobe_get_trampoline_vaddr();
+	if (tramp == UPROBE_NO_TRAMPOLINE_VADDR)
+		goto sigill;
 
-	if (regs->ip != trampoline_check_ip())
+	/* Make sure the ip matches the only allowed sys_uretprobe caller. */
+	if (regs->ip != trampoline_check_ip(tramp))
 		goto sigill;
 
 	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b1df7d792fa1..a6bec560bdbc 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -39,6 +39,8 @@ struct page;
 
 #define MAX_URETPROBE_DEPTH		64
 
+#define UPROBE_NO_TRAMPOLINE_VADDR	(~0UL)
+
 struct uprobe_consumer {
 	/*
 	 * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ca797cbe465..e8af2f75b094 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2160,8 +2160,8 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
  */
 unsigned long uprobe_get_trampoline_vaddr(void)
 {
+	unsigned long trampoline_vaddr = UPROBE_NO_TRAMPOLINE_VADDR;
 	struct xol_area *area;
-	unsigned long trampoline_vaddr = -1;
 
 	/* Pairs with xol_add_vma() smp_store_release() */
 	area = READ_ONCE(current->mm->uprobes_state.xol_area); /* ^^^ */

