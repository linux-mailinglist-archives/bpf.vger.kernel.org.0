Return-Path: <bpf+bounces-55553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0928CA82CA1
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3D7189D983
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B0B26FA6E;
	Wed,  9 Apr 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFg0sYN0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25D2676C2;
	Wed,  9 Apr 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216672; cv=none; b=kxd1MT8bIGJ6ZnwFctfk3HbJvP9aTJFWw990HB2eqQ7EnuFARi3toHXiZfvbYvbgKnepAwiWljrh2ePsi4FGeuNjTgiCH6UihCkTr0rh3fKfSn1QkflzhYkXtwRvNd3ZW5/qnSwjvTmgG1sY+7sDQ07z8l3MHjCuOCEkkHSc2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216672; c=relaxed/simple;
	bh=x1T50N9xg5E5T/M2ZN4F9VL0fowGj/0cq3XugwJFSx8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS276v/sCc1g7aL21rXoUwscs+q3y6gNx8yWvAJ9ZC88zZ9Jx5ZfhAu2pl5crRAXe/XFD6ybpN85j/3ekvD04bg2L4C6hSs4pbpYNHylESP//Z8IrNFEUfffagyE9CFtgNDJbbyaJ0ls2X8ujlolwHekX86cl4RCA8aIMNQeQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFg0sYN0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aca99fc253bso227627566b.0;
        Wed, 09 Apr 2025 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744216669; x=1744821469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9xLNQUNJGehmOqToVNse1/3nCRIcDqbLWt+mHrRoq8=;
        b=LFg0sYN0cXxYRCXijHBQ9pUjnhCLfSjk7aBBWDagQnS0IxPwxz/bBJUBaoabZyymsQ
         jFtB/kdyj8X0olZ1IZvN8FqhCk0pXrpjva6wpXBR88GLzTt6vtTV0B9bvJtHCrJkq4kw
         IzXfeUTGmoOSzUSrRtD1BjGfMGB3A7hW31EHIes4K61SpYjZdlhUtAr0vAtcbfXzZ/vj
         qhYdezRMtpcTUxS45nQsJGKIZoH+wYNyQkBljtZj7nZ0MXKmrO/DVNPSGABSq2FSkW3h
         xFhzGpu67YEdwogYSEKRghNvHHnGtyz9wHL6itR9lPkqXJN3itgXtF6rdyjpslbRCuTw
         8OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216669; x=1744821469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9xLNQUNJGehmOqToVNse1/3nCRIcDqbLWt+mHrRoq8=;
        b=BYjV+LOyfGKpNHKIjcNEo59tHOv+hYN3hQ4k80sfbmib6nt5ZJfBHJSluQ1m5POcT7
         lL7hWjjv04LApQkUFWCXuihfKkNvZ/prgT8FHfI2CQ3YZ4TtcZzPevh3GNLXeCadhrkR
         dXiqhjoNkG4r8OZpg7X8U+F2O7AE7Xg4G+14cstYwbqj+hsrKaW10IRm/sruwIoikehc
         L6QoXehkzthnJOhjI2ATOb69q7W1eDW5ipGBkQio8q7rucQyG9XOn8TrPWdGcqJecnsu
         /5nXqf795Jluxe+3NCCGtCSisww4fYyLa3C8ctuu46xJE89x//kc/YhgffHPuibWYKkr
         kneg==
X-Forwarded-Encrypted: i=1; AJvYcCVL63gbIGAu3SvCKztf2KSitB/W5tzrMO3zLY+lpblPy8cwuh+XE3+f51xSXtg+DQWIlav6slf34+f49iJ7FAGpjXYX@vger.kernel.org, AJvYcCWFxvdeSgSIIFkkidbN1kaWAub0pZLLxr9hdWYtiGzO/kUixnJJ7N3WG6zQzRf+DYWmqto=@vger.kernel.org, AJvYcCWadbtz9GMwK/8C674u0a5hUi0l3AzuVSEpevNdSxht/Kv7+0S5HlFFJViCpUlLVn2UPY5Ejuqb6GT/5bbk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8sHHuWIx9lVPhPVCP4gPKoV7hMZ68bllZ9rOKC7IiOlu4CCH
	uYIRUJDvvky117DW3wWKqqjRgbtvLePXowEQ5zFZXEIjUhSl68Dg
X-Gm-Gg: ASbGncsK48hH7qNckzlFsNYbVlURffml29dJ8AlKzX0gGpjcuYRdrT6ciW4DtcODnPR
	UL9GLDZt/Emhc4EnQJeMX2XtJQpWbNnXmsQhJg8Pvu2qIZO1ZCC1R9K/0hzqlkWqRkdM8xNME+p
	Gu3G0f8m7GtKY+SBBxbB7ddfeMfUR/rq7hPyKc1F4Sjn0w6nyuDeJaWSgnvVf7JInIcIXAEQOQU
	9vvAUpl/C6A3MsxHHZhY1ZPkL+JIO8eoKPiBZL8BcPswCSj083It7CwLkTEtAtQ/RwK6FPkyc+0
	MpYJb+TWlYVrb2aULHsHVzIlYnfan79aIGfdG+b5X/P6LRdq2EYzUKum
X-Google-Smtp-Source: AGHT+IEralBWeH45K00pDpPHn5tEjXFg5r3qlnrO7/shpzOMdjLfT40VNzjRbIYo26ZVF67IobJwxQ==
X-Received: by 2002:a17:906:6a0d:b0:ac8:1142:a9e5 with SMTP id a640c23a62f3a-aca9d6fc7damr289598366b.47.1744216668763;
        Wed, 09 Apr 2025 09:37:48 -0700 (PDT)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce72f5sm121807366b.173.2025.04.09.09.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:37:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 9 Apr 2025 18:37:45 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH 1/2] uprobes/x86: Add support to emulate nop5 instruction
Message-ID: <Z_aiWdks8SA3mtX6@krava>
References: <20250408211310.51491-1-jolsa@kernel.org>
 <20250409112839.GA32748@redhat.com>
 <Z_ZjIerx-QvY7BSI@krava>
 <20250409131115.GD32748@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409131115.GD32748@redhat.com>

On Wed, Apr 09, 2025 at 03:11:16PM +0200, Oleg Nesterov wrote:
> On 04/09, Jiri Olsa wrote:
> >
> > On Wed, Apr 09, 2025 at 01:28:39PM +0200, Oleg Nesterov wrote:
> > > On 04/08, Jiri Olsa wrote:
> > > >
> > > > --- a/arch/x86/kernel/uprobes.c
> > > > +++ b/arch/x86/kernel/uprobes.c
> > > > @@ -608,6 +608,16 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > > >  		*sr = utask->autask.saved_scratch_register;
> > > >  	}
> > > >  }
> > > > +
> > > > +static int is_nop5_insn(uprobe_opcode_t *insn)
> > > > +{
> > > > +	return !memcmp(insn, x86_nops[5], 5);
> > > > +}
> > > > +
> > > > +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> > > > +{
> > > > +	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
> > > > +}
> > >
> > > Why do we need 2 functions? Can't branch_setup_xol_ops() just use
> > > is_nop5_insn(insn->kaddr) ?
> >
> > I need is_nop5_insn in other changes I have in queue, so did not want
> > to introduce extra changes
> 
> But I didn't suggest to remove is_nop5_insn(), I meant that
> branch_setup_xol_ops() can do
> 
> 	if (is_nop5_insn(insn->kaddr))
> 		goto setup;
> or
> 	if (is_nop5_insn(auprobe->insn))
> 		goto setup;
> 
> this even looks more readable to me. but I won't insist.
> 
> > > For the moment, lets forget about compat tasks on a 64-bit kernel, can't
> > > we simply do something like below?
> >
> > I sent similar change (CONFIG_X86_64 only) in this thread:
> >   https://lore.kernel.org/bpf/Z_O0Z1ON1YlRqyny@krava/T/#m59c430fb5a30cb9faeb9587fd672ea0adbf3ef4f
> >
> > uprobe won't attach on nop9/10/11 atm,
> 
> Ah, OK, I didn't know. But this means that nop9/10/11 will be rejected
> by uprobe_init_insn() -> is_prefix_bad() before branch_setup_xol_ops() is
> called, right? So I guess it is safe to use ASM_NOP_MAX. Nevermind.
> 
> > also I don't have practical justification
> > for doing that.. nop5 seems to have future, because of the optimization
> 
> OK, I won't insist, up to you.
> 
> Just it looks a bit strange to me. Even if we do not have a use-case
> for other nops, why we can't emulate them all just for consistency?

we can, I went with nop5 just for simplicity, if you think
having all nops support is better, let's do that

I checked and compact process executes 64bit nops just fine,
so we should be ok there

> 
> And given that emulate_nop5_insn() compares the whole insn with
> x86_nops[5], I guess we don't even need to check OPCODE1(insn)...

right

> Nevermind.
> 
> So, once again, I won't argue.

I'm happy to go with your version, wdyt?

thanks,
jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..63ecc5f6c235 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -840,12 +840,16 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
+	/* x86_nops[i]; same as jmp with .offs = 0 */
+	for (i = 1; i <= ASM_NOP_MAX; ++i) {
+		if (!memcmp(insn->kaddr, x86_nops[i], i))
+			goto setup;
+	}
+
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
 		break;
-	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
-		goto setup;
 
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);

