Return-Path: <bpf+bounces-62918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90BCB003EC
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 15:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D3C1C80CC4
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6226D4D4;
	Thu, 10 Jul 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZXfde5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982725F995;
	Thu, 10 Jul 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154959; cv=none; b=PARKbmz/GvE2li7JMjK+j1a+LAV8qKYdWKiNOOWe1R6Z/zWnC+i23tgi8t/YqQrieC6H6VRL5f+KqJW1KEawLRyqonIUsc1P3ItC00+aDJzlLxcBCOovFazAm8N2STGA5IMn+75pYFkP9r13N9W0WvjhUvL5CHgIb38UrYTHUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154959; c=relaxed/simple;
	bh=/rxMRUEkRaHDUkR38UuqRy4okB2bxejm4JUutNL8sjI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1XN8DrYwH2Dy/RrZ6mMqZGsQwbKIOrKMqGj1+ElexOoSQsNhAPBbWyClJ8yq9EENF+WI526Pe02dMS+5EEbsJv2dYRoCFcP6G97JebWTI3dDIZa26AUZ/xujoazHIntyREOnI13ZYFSIY02WvcXJN/kOSe5Yktawv9GIGrVH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZXfde5E; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso622785f8f.3;
        Thu, 10 Jul 2025 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752154956; x=1752759756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qxPYSfmGEaTu7IijXvJrNmea414EV9xmgzdA7CtC60=;
        b=nZXfde5EHAy1vGqWk1UgCloxQ2wvrK5bg6ARRGIrfU2K4vDy/ddZD1eZROHfPqcXjF
         4t2SsLAdmj0sk9Azb5Feul2GWhedPfTwdyYeS3XxBJMANRgnk1VJEOxlCaordeTLAX4G
         /tSErml0NE4LNqTkLWfsz7Yr1pAqXsGgmIVeYu255l8iNhDzsCdoNtQiK4/OdtaEZuzj
         7uL1nBY7Tv+BVUsoLQn1CXQK9b32tuin+Vp3i7wqWIY8bsWsLYfM9jUatcdmayT7yXIa
         YgtzgltrkqIMtwhGsTrxi+AcD+FF5NQKY7uJLyO3j9T/VWBeO9VPyCIXwPNQsmZmF/Bw
         6xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154956; x=1752759756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qxPYSfmGEaTu7IijXvJrNmea414EV9xmgzdA7CtC60=;
        b=EokYUC3X0uYTUA9qr62CQUqUAL+jO/mp5vTKhw8BCr4yLwY3KSLyN6ZsKR3O8fNQDo
         wwzwKxx6enRvF2CaF57zaSiN/ZfW/BSxgkaEy8Zih2giQEuirsm4Omaxk4dQHAHxOmTD
         H+XcxEAgYqJKW5+kCKBgK3vHCFkRervWL/v5hhKFxcTGCysIPiuCQNohzD+NECI8SCRG
         DF0Gz3I9vp+WoPQ4RfeUEtRZO2Qud8ttcs9tKlRlQcEFxULlj+yne7wMBr8+G3YZIC8q
         yx4BMUsAXEXNpAG0lsTs3A6PJLKZyoluYD/H6PAivPppIkoGzf7wVRSPs2yOPWn16yy+
         lFIg==
X-Forwarded-Encrypted: i=1; AJvYcCUcaXXcIQofhDhBY/use9xTMeeTuxMCmx2gp8t5ZsRA95UZei17fpr0ws805VGq7+JYH6tYtf5CeTQvzUiXczDJrIC+@vger.kernel.org, AJvYcCVnHxYiHNuei0o9VcdIj734KIoJaFJLfZdprLyeqDGrL6X/vxUxQIiFzdDNolZs2BN95wA=@vger.kernel.org, AJvYcCVzh4/R+kAG6PXbSru2bw3MtoxZNCRrP8XY6STUgGJbrs/jk5w60sJAASlws1/sjg1tcfNnbFn2fNvh7DwS@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWg8qOLHP5fkh1qaPsocnLc3ezGTywQkvv+uk8oG8a2G+wZG0
	ovwUyyr7ax7Clg6CkDFYD7H2odBDdMUeQtzyPs+xJux0jtwE8TC4qyfj
X-Gm-Gg: ASbGncsvePk9KT070OMOX9MIT+GCSCYSGOyXxexICc0RyaH8sC5NmfkXJH42STn0i10
	UsAH/15mDNrvgJgdXYto3O1ccDkwIMa1e0EtR/1QT+16qJ6WRscq14lEx2TLSLJg9dQKVT0y7P0
	53Cign9SEmeAmXsOQJ/EDOc/jG++4rHlFnMt5N9c2Zjpcn9aFhnLh3HON+FUrKGQTelTk74WUvx
	R3dTEj3QyIj5eAycdSYaGQ4eXtDpPEBbnoSLP7Go/gM63XYGuzxS4KdEH6oooO0ocLdValFyaHs
	XWFS18JqMExEfSMAyThF8LE0bs8Ye+t3ekhG
X-Google-Smtp-Source: AGHT+IG1d0xnvmWxFdS34PVwqumri1XNuY+ZN4paBlqiv6sef7DWcYdK6ETUUhc7zaM1zJdrXSUXaQ==
X-Received: by 2002:a05:6000:18ab:b0:3a5:2beb:7493 with SMTP id ffacd0b85a97d-3b5e44e4a30mr6134161f8f.9.1752154955451;
        Thu, 10 Jul 2025 06:42:35 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::42b7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1997sm1961062f8f.10.2025.07.10.06.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 06:42:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 10 Jul 2025 15:42:33 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv4 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aG_DSXNFol_03h75@krava>
References: <20250708132333.2739553-1-jolsa@kernel.org>
 <20250708132333.2739553-9-jolsa@kernel.org>
 <20250710160233.8750ccd59b3b9d62e78491e5@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710160233.8750ccd59b3b9d62e78491e5@kernel.org>

On Thu, Jul 10, 2025 at 04:02:33PM +0900, Masami Hiramatsu wrote:
> Hi Jiri,
> 
> On Tue,  8 Jul 2025 15:23:17 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding support to add special mapping for user space trampoline with
> > following functions:
> > 
> >   uprobe_trampoline_get - find or add uprobe_trampoline
> >   uprobe_trampoline_put - remove or destroy uprobe_trampoline
> > 
> > The user space trampoline is exported as arch specific user space special
> > mapping through tramp_mapping, which is initialized in following changes
> > with new uprobe syscall.
> > 
> > The uprobe trampoline needs to be callable/reachable from the probed address,
> > so while searching for available address we use is_reachable_by_call function
> > to decide if the uprobe trampoline is callable from the probe address.
> > 
> > All uprobe_trampoline objects are stored in uprobes_state object and are
> > cleaned up when the process mm_struct goes down. Adding new arch hooks
> > for that, because this change is x86_64 specific.
> > 
> > Locking is provided by callers in following changes.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 169 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/uprobes.h   |   6 ++
> >  kernel/events/uprobes.c   |  10 +++
> >  kernel/fork.c             |   1 +
> >  4 files changed, 186 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 77050e5a4680..6336bb961907 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -608,6 +608,175 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  		*sr = utask->autask.saved_scratch_register;
> >  	}
> >  }
> > +
> > +static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
> > +{
> > +	return -EPERM;
> > +}
> > +
> > +static struct page *tramp_mapping_pages[2] __ro_after_init;
> > +
> > +static struct vm_special_mapping tramp_mapping = {
> > +	.name   = "[uprobes-trampoline]",
> > +	.mremap = tramp_mremap,
> > +	.pages  = tramp_mapping_pages,
> > +};
> > +
> > +struct uprobe_trampoline {
> > +	struct hlist_node	node;
> > +	unsigned long		vaddr;
> > +};
> > +
> > +static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
> > +{
> > +	long delta = (long)(vaddr + 5 - vtramp);
> > +
> > +	return delta >= INT_MIN && delta <= INT_MAX;
> > +}
> > +
> > +#define __4GB		 (1UL << 32)
> > +#define MASK_4GB	~(__4GB - 1)
> > +#define PAGE_COUNT(addr) ((addr & ~MASK_4GB) >> PAGE_SHIFT)
> > +
> > +static unsigned long find_nearest_trampoline(unsigned long vaddr)
> > +{
> > +	struct vm_unmapped_area_info info = {
> > +		.length     = PAGE_SIZE,
> > +		.align_mask = ~PAGE_MASK,
> > +	};
> > +	unsigned long limit, low_limit = PAGE_SIZE, high_limit = TASK_SIZE;
> > +	unsigned long cross_4GB, low_4GB, high_4GB;
> > +	unsigned long low_tramp, high_tramp;
> > +	unsigned long call_end = vaddr + 5;
> > +
> > +	/*
> > +	 * The idea is to create a trampoline every 4GB, so we need to find free
> > +	 * page closest to the 4GB alignment. We find intersecting 4GB alignment
> > +	 * address and search up and down to find the closest free page.
> 
> It is not guaranteed to be able to find unmapped 4GB aligned page.
> I still think just finding the nearest area is better (simpler and
> good enough.)
> 
> 	if (check_add_overflow(call_end, INT_MIN, &low_limit))
> 		low_limit = PAGE_SIZE;
> 
> 	high_limit = call_end + INT_MAX;
> 
> 	/* Search up from intersecting 4GB alignment address. */
> 	info.low_limit = call_end;
> 	info.high_limit = min(high_limit, TASK_SIZE);
> 	high_tramp = vm_unmapped_area(&info);
> 
> 	/* Search down from intersecting 4GB alignment address. */
> 	info.low_limit = max(low_limit, PAGE_SIZE);
> 	info.high_limit = call_end;
> 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> 	low_tramp = vm_unmapped_area(&info);
> 
> See below;
> 
> > +	 */
> > +
> > +	low_4GB = call_end & MASK_4GB;
> > +	high_4GB = low_4GB + __4GB;
> > +
> > +	/* Restrict limits to be within (PAGE_SIZE,TASK_SIZE) boundaries. */
> > +	if (!check_add_overflow(call_end, INT_MIN, &limit))
> > +		low_limit = limit;
> 
> if not overflow, low_limit = limit = call_end - 2GB.
> 
> * if call_end := 2GB + 4095, limit can be 4095 < PAGE_SIZE. 
>   at the same time, low_4G == 0.
> 
> Note that low_limit can be > low_4G or < low_4G.
> 
> > +	if (low_limit == PAGE_SIZE)
> > +		low_4GB = low_limit;
> 
> If overflow, low_4GB = PAGE_SIZE too.
> 
> In summary, 
> 
> (a) 0 < call_end < 2GB: (overflow)
>   low_limit := PAGE_SIZE
>   low_4GB := PAGE_SIZE
> 
> (b) 2GB <= call_end < 2GB + PAGE_SIZE:
>   low_limit := call_end - 2GB (>= 0, < PAGE_SIZE)
>   low_4GB := 0 (= call_end & MASK_4GB)
> 
> (c) call_end == 2GB + PAGE_SIZE:
>   low_limit := PAGE_SIZE
>   low_4GB := PAGE_SIZE
> 
> (d) 2GB + PAGE_SIZE <= call_end < 4GB:
>   low_limit := call_end - 2GB (> PAGE_SIZE)
>   low_4GB := 0
> 
> (e) 4GB <= call_end:
>   low_limit := call_end - 2GB (> 2GB)
>   low_4GB := call_end & MASK_4GB (> 4GB)
> 
> Maybe (b) and (d) cases are unexpected?
> 
> 
> > +
> > +	high_limit = call_end + INT_MAX;
> 
> This should not overflow, OK.
> 
> > +	if (high_limit > TASK_SIZE)
> > +		high_limit = high_4GB = TASK_SIZE;
> > +
> > +	/* Get 4GB alligned address that's within 2GB distance from call_end */
> > +	if (low_limit <= low_4GB)
> 
> This means call_end is within the [low_4GB, low_4GB + 2GB).
> Call this case as (A)
> 
> > +		cross_4GB = low_4GB;
> > +	else
> > +		cross_4GB = high_4GB;
> 
> And this case as (B).
> 
> > +
> > +	/* Search up from intersecting 4GB alignment address. */
> > +	info.low_limit = cross_4GB;
> > +	info.high_limit = high_limit;
> > +	high_tramp = vm_unmapped_area(&info);
> 
> This searches the unmapped pages from low_limit.
> In (A) case, this starts from low_4GB to high_limit.
> In (B) case, this starts from high_4GB to high_limit.
> 
> So basically you search the unmapped area around the 4GB
> aligned address instead of the nearest area of the vaddr.
> But it is not guarantee that can find unmapped area near
> the 4GB aligned address.

ok, as you said the current code does the same logic but from 4GB
aligned address, while you suggest nearest page from the caller

I can't think of any benefit one way or the other apart from that
your change is less code, I ended up with code below

thanks,
jirka


---
+static unsigned long find_nearest_trampoline(unsigned long vaddr)
+{
+	struct vm_unmapped_area_info info = {
+		.length     = PAGE_SIZE,
+		.align_mask = ~PAGE_MASK,
+	};
+	unsigned long low_limit, high_limit;
+	unsigned long low_tramp, high_tramp;
+	unsigned long call_end = vaddr + 5;
+
+	if (check_add_overflow(call_end, INT_MIN, &low_limit))
+		low_limit = PAGE_SIZE;
+
+	high_limit = call_end + INT_MAX;
+
+	/* Search up from the caller address. */
+	info.low_limit = call_end;
+	info.high_limit = min(high_limit, TASK_SIZE);
+	high_tramp = vm_unmapped_area(&info);
+
+	/* Search down from the caller address. */
+	info.low_limit = max(low_limit, PAGE_SIZE);
+	info.high_limit = call_end;
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	low_tramp = vm_unmapped_area(&info);
+
+	if (IS_ERR_VALUE(high_tramp) && IS_ERR_VALUE(low_tramp))
+		return -ENOMEM;
+	if (IS_ERR_VALUE(high_tramp))
+		return low_tramp;
+	if (IS_ERR_VALUE(low_tramp))
+		return high_tramp;
+
+	/* Return address that's closest to the caller address. */
+	if (call_end - low_tramp < high_tramp - call_end)
+		return low_tramp;
+	return high_tramp;
+}

