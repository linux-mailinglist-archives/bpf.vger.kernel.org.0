Return-Path: <bpf+bounces-52929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9556FA4A651
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32FD16D703
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE21DF26F;
	Fri, 28 Feb 2025 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB9MvK7b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244E1D9346;
	Fri, 28 Feb 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783653; cv=none; b=DqK32KgBN6q6iA9euoFW88d3f5Ge7yOLAE3Z4b/Seqph5EAvVssiuPN/P5k8mDTQVp03dlP5Iyumk70/Q2niAQ0n82mHa6t3PuhWjugTVJT/C67zTvKCHObATJnVNj/epS0AqIrlztC6LoiAvNXVt4cY7qQwkYW3Dj3meBnfHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783653; c=relaxed/simple;
	bh=8RG2zJ8ZSWvpFH5aWI1BbUFsc54DW/KQffx2NzNXFrU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMWb42xRNZkDRT8RfNnQlk4xuqzmtmjnZE8jt/aFYmjhbFXaKwFV8NV/QUIVpfLMCWPulIVftUK1wBYf4NpCmBkrxnuFh3Yrovyi3LUoCJ4bZJ7rAUwjyefGWB2DA6pjR2JBtuQy1+OpERY7on7fAZnGegbav7dnJHWYODYFxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB9MvK7b; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so17144495e9.1;
        Fri, 28 Feb 2025 15:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783649; x=1741388449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mPdgDUvvU1Eb/kClux6e7e+YhMrhzs3u+muZdJdG7Q=;
        b=hB9MvK7b/Ghs3VXaFZelBdcLAAxrxZY4/rFDhTc5FbcORIxbTFuwWDNhaka+FCV8U9
         eGgPwkTSV0bXpw7gzlfY6a4WSTLIDnmsXTP3slD1NsVHUWXLbOXUwZfT1P6uQUlvdCkX
         tpTwr02gR2cpJ+IMgxcaA/uj7nGYopMohwud4hfnCyC8cWNLrDL7U5p/sJOC+F2b1wnQ
         mNrwX32vMSnEnDh5aTYxZYOyoBkl/3/e6cDffXBQ1JQYDnifoDYdXB1IyLiTrf2FuZPX
         4GA3nDAHE5Gkp6SzP36DpqJ1YJOoQFf19+885h3n9S4gFXrmb9cooB45JhELdS67VKBZ
         s2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783649; x=1741388449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mPdgDUvvU1Eb/kClux6e7e+YhMrhzs3u+muZdJdG7Q=;
        b=Rm8iZdhxxDZJRt93IF2K4oxB36sOkaG/kkdYte+hCqgxKXAoQYtGNQNbXhYid54a3G
         jvOp+BZ1ulsuLei5rBOJoBSuRZEGTti0wBHOZ2CIT9uWno9uMRmsng5ZbsqVH8Xe6+yj
         L1nV5Bl99LeKMctZ9P8XIFfGIyvMHixaQoHS9Q0BVluMcNP4FkWRi7kjD44qZAWCgUaC
         3OKE529IviTp1MljELdbmjVlxl8E58f7IrZyi/yMYIq7obCNTlFQuI4Lz8z60kvZUIyJ
         VUrM0B+05IfgbX6gsX/8gN6X/5WWy2dQsEyOrz7SwU2OWhczRtyLCs6dHxXibTpISyVR
         W4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7W8wMYbKKXiSo1UICqv8hHSdn3P/AtdgTaLknAQpVO8qn9/h6Q4V9PCjhI5DiSt3vBkAILiEY4uiK6Wr6bjSA9Rxq@vger.kernel.org, AJvYcCXJuXxgFbnXrSEkc8aieorVjeEud2cz/olU78aYJ6D3LrVDvho/OyHsR6ZSV/JNoXVxDr+N5EHkYVTb5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BCjavBXWOqyivz4EWF8OAvaBId9IPlFRqhHUKgdmhUDOT+Pm
	ca/cysjhuxzAbIJST9GBPoWECrTFpfu7tSodZ0OouuatKeYt/rTY
X-Gm-Gg: ASbGnctrZkw/7i2JvMMp7B+ABa8r8HtViCjJ10tSxyiQKyFDzbVWvrmOSCfdkS2jC8X
	7uoCw4S08UGb363sd3lWJD08LD3t5OPLPxbhawHRYRLKb9HCCVyDPUUB3BLwF+5rdVSfMOvgW3n
	wZmom90oAYw8cKm2e56crziOz7s9BviiSJ9WMj3u111BmKzJt7QqVx9jQ54QAjDebvAcXwUdM5V
	EeK8F/o96wV/wZCJozRr8DS5UVu0qGDDpvUm2UVsErslQltbcXgcnKWk/HJxbufKrvddlQA7uSZ
	uSXZz3Z7ln4MY/rEbX+lQIxJG0Kowi13
X-Google-Smtp-Source: AGHT+IEVo5FUkeVcDQoQ+qCzYLuUrxT4Sg2n8KhR+YouwK4EuUE5NKj95diSlMmvhGTkHqQp9CTfFg==
X-Received: by 2002:a05:600c:198f:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-43ba625f4e9mr44233465e9.8.1740783649546;
        Fri, 28 Feb 2025 15:00:49 -0800 (PST)
Received: from krava (85-193-35-41.rib.o2.cz. [85.193.35.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bad347823sm17046455e9.0.2025.02.28.15.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:00:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 1 Mar 2025 00:00:44 +0100
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv2 12/18] uprobes/x86: Add support to optimize uprobes
Message-ID: <Z8JAHHM4xqEQA2f3@krava>
References: <20250224140151.667679-1-jolsa@kernel.org>
 <20250224140151.667679-13-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224140151.667679-13-jolsa@kernel.org>

On Mon, Feb 24, 2025 at 03:01:44PM +0100, Jiri Olsa wrote:

SNIP

> @@ -1523,15 +1698,23 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
>  {
>  	int rasize = sizeof_long(regs), nleft;
>  	unsigned long orig_ret_vaddr = 0; /* clear high bits for 32-bit apps */
> +	unsigned long off = 0;
> +
> +	/*
> +	 * Optimized uprobe goes through uprobe trampoline which adds 4 8-byte
> +	 * values on stack, check uprobe_trampoline_entry for details.
> +	 */
> +	if (!swbp)
> +		off = 4*8;

ok, now when I started to add the missing register modifications in uprobe syscall,
I realized we will modify the regs->sp appropriately already in the uprobe syscall
(before the code above is hit)

so we don't need this code and we can get rid of the swbp flag and patch#7 completely

jirka

>  
> -	if (copy_from_user(&orig_ret_vaddr, (void __user *)regs->sp, rasize))
> +	if (copy_from_user(&orig_ret_vaddr, (void __user *)regs->sp + off, rasize))
>  		return -1;
>  
>  	/* check whether address has been already hijacked */
>  	if (orig_ret_vaddr == trampoline_vaddr)
>  		return orig_ret_vaddr;
>  
> -	nleft = copy_to_user((void __user *)regs->sp, &trampoline_vaddr, rasize);
> +	nleft = copy_to_user((void __user *)regs->sp + off, &trampoline_vaddr, rasize);
>  	if (likely(!nleft)) {
>  		if (shstk_update_last_frame(trampoline_vaddr)) {
>  			force_sig(SIGSEGV);

SNIP

