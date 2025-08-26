Return-Path: <bpf+bounces-66506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372D8B35394
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1990244996
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 05:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581F2F28FF;
	Tue, 26 Aug 2025 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZTlWE9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B32F1FDB;
	Tue, 26 Aug 2025 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187524; cv=none; b=jQWoiaW4BAhO1Ab/tSXXm11qNhy9QELCSiReIEJq2MPHNEpDSv878mdAiW5ZSnzM9ocWQhxwYzUd31AhDMbh2NE8WZmRpqP861AqXf7CUIfSQZSdIAPFHdCNmfWZVUT+71e0HJOUwUvfgqvpKc1bXK/QzsG0vDB+B7YhjajqfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187524; c=relaxed/simple;
	bh=0bP4afbL6bWHRgondaFRoclqPUbYzRAnYCAH0a0F/ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsK2u9XpT9bsCq2yEl4Ca5xvEkM/0L1WNm12AwiUEt6tCjiJqyMy6ypsLNryRxh5JWfG3QaMRil0LeSX3aMgPKWA1UGgn/KNyACFaea55sKHRDoNqvaV8qKRfURFstl2Cm8l4dc8k35/SGruZ5n3mEUkZViHOS+8FJ/ynsslaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZTlWE9y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b60fd5a1dso13620135e9.2;
        Mon, 25 Aug 2025 22:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756187520; x=1756792320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKYQ8pq0BweGc0Hdds105nsygQj88Q8QjXPEB7WbTzk=;
        b=LZTlWE9y6JqOFs+AvfKrlbamoladzvxMCmkTN9DdRai59qc+vAvOXk4Psah17Md9KV
         +GdX89pIhll6gw2RmS1Nk/hXn+pGYLNJq6jqEnnzqED960uf7d+9rVP4ZmEjM9+4Dq5S
         qcD29GCHxhZoEK8Ep9kx1ZyOPS5o7yItKtt3m90JI+jB+tNDHYlQyijp5NDfg6Pad3Z8
         tTZ0ITq29e0OUu2l+IGV+XSAlbl16HPKDouHlTLM+pUZ1TvBwacDKLeKoEQkIooSFZHw
         oOE6JEKfTOQxODPsMdf4aB1OyCHu7fl2EU5kmvQ722eA5MGSJiP49lcG4bG4xOKQW4dy
         zn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756187520; x=1756792320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKYQ8pq0BweGc0Hdds105nsygQj88Q8QjXPEB7WbTzk=;
        b=fl+dR433n1hHM9op0RIOhKJ3vkeQc4kAKNc7hr9zDBeRXNEBngh1KV4pTFq3Apeq/F
         8YLtBmQQEi384zKy89KOVOfHvAho2h+UVf+IBnzViUY9Jw20kTltAjolcvNxm97TrhAO
         t7HVM0qb3gVy8nkNAOOGpv+gl/3IqNK4OWETeoGqLmnbTYQQfgSTiOsV8SKJovmP+mQg
         g+s/YfveyUTHL4I3r/4I/ViNzs0l+nyLQfRLPxDdyDqcC726x/o3LR0RuJkrQRhceqPx
         wCZ2CWHH0C1MtGZBHC86uVbfw6YoBx488ISaZdKF53BGbvLvYim9R8bAs2iXK7ZcYXuZ
         KgjA==
X-Forwarded-Encrypted: i=1; AJvYcCUmgAeBpOiOlNgRac+l0Hs1oDCsEQ71FpCUi5FHhSWXm6G6g9+BZPkxuLitlmpWHHKj9Rw=@vger.kernel.org, AJvYcCVNrSCvRI//3fUuWNtCgR9wRBefDZQCnAyakG2Ki4ydtunB0Aspy1niZ1QQKb+tN56UE/UXCJzh90R4UbCWSZ5jVk43@vger.kernel.org, AJvYcCWl1e0dkd0RHg/5eHDc1PYzyH+77H/Aw8wEFNIzTOjcH7M5nVeJrVZtBBZJrsA7RsA+j4kjORUAFe1jirxi@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQCheW4kSp4pFVMOc85fIqERhT4r6qtF/WcL13byLKYCaVAvB
	9IKTpdx94b0ssEqtrONsQMWJV5Y4XOtMgw2jVoedjP9UAuxzoAp9wtYU
X-Gm-Gg: ASbGncsjuifdyxo+l1e+Go9Zeyfrnihl4IrbYSEHuaz5Z6eygFTZ6Eq9TFQnM/tXUDt
	+NsMWPTKVmGxOFFqRRhQ1RyyDfGWg+A2M2VVO5ENhTO/Rk2NlfjbubQYq+01E1CqBH1oXwykAq9
	HYyLWcrXvtKrpyUXsEeaEDSJ6C5H9R0pygj1GZ6j+Lh/MnYU1/z/kYT3+LiPI4OvsTBjUe5OXxq
	i2PR3KRCf3sc9Ira47AArTzjAZzHOIPCG6P+eVi4n/u8fTw+VTmRjLn6EyTrnPax9d/LaYpsa9t
	eAli8pKN1EqPZ6DWcJ3r5FDiO+LcISH82WnGe85P8Dzr9d0iirj+aXpsB4W3wAfu8vcUIscp8IL
	oZDQ1K0QN4ekIo6F01bevMLrxAagevb+/HeOdb2jonEzKwu2RMSamh00mxBlBV219
X-Google-Smtp-Source: AGHT+IFtRFES/JoDcwZlDGxdtCq+zEsEUm9Rstfn3B5thVgAWixmcq/XHt8zAsY3q7azZ7wBCJP17A==
X-Received: by 2002:a05:600c:1c98:b0:456:214f:f78d with SMTP id 5b1f17b1804b1-45b53cfa151mr105833345e9.22.1756187520386;
        Mon, 25 Aug 2025 22:52:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b575929a0sm133289025e9.25.2025.08.25.22.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 22:51:59 -0700 (PDT)
Date: Tue, 26 Aug 2025 06:51:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@kernel.org, oleg@redhat.com, andrii@kernel.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org, alx@kernel.org,
 eyal.birger@gmail.com, kees@kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, songliubraving@fb.com,
 yhs@fb.com, john.fastabend@gmail.com, haoluo@google.com,
 rostedt@goodmis.org, alan.maguire@oracle.com, David.Laight@ACULAB.COM,
 thomas@t-8ch.de, mingo@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH 2/6] uprobes/x86: Optimize is_optimize()
Message-ID: <20250826065158.1b7ad5fc@pumpkin>
In-Reply-To: <20250821123656.823296198@infradead.org>
References: <20250821122822.671515652@infradead.org>
	<20250821123656.823296198@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 14:28:24 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Make is_optimized() return a tri-state and avoid return through
> argument. This simplifies things a little.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/uprobes.c |   34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
> 
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1047,7 +1047,7 @@ static bool __is_optimized(uprobe_opcode
>  	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
>  }
>  
> -static int is_optimized(struct mm_struct *mm, unsigned long vaddr, bool *optimized)
> +static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
>  {
>  	uprobe_opcode_t insn[5];
>  	int err;
> @@ -1055,8 +1055,7 @@ static int is_optimized(struct mm_struct
>  	err = copy_from_vaddr(mm, vaddr, &insn, 5);
>  	if (err)
>  		return err;
> -	*optimized = __is_optimized((uprobe_opcode_t *)&insn, vaddr);
> -	return 0;
> +	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
>  }
>  
>  static bool should_optimize(struct arch_uprobe *auprobe)
> @@ -1069,17 +1068,14 @@ int set_swbp(struct arch_uprobe *auprobe
>  	     unsigned long vaddr)
>  {
>  	if (should_optimize(auprobe)) {
> -		bool optimized = false;
> -		int err;
> -
>  		/*
>  		 * We could race with another thread that already optimized the probe,
>  		 * so let's not overwrite it with int3 again in this case.
>  		 */
> -		err = is_optimized(vma->vm_mm, vaddr, &optimized);
> -		if (err)
> -			return err;
> -		if (optimized)
> +		int ret = is_optimized(vma->vm_mm, vaddr);
> +		if (ret < 0)
> +			return ret;
> +		if (ret)
>  			return 0;

Looks like you should swap over 0 and 1.
That would then be: if (ret <= 0) return ret;

	David

>  	}
>  	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN,
> @@ -1090,17 +1086,13 @@ int set_orig_insn(struct arch_uprobe *au
>  		  unsigned long vaddr)
>  {
>  	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
> -		struct mm_struct *mm = vma->vm_mm;
> -		bool optimized = false;
> -		int err;
> -
> -		err = is_optimized(mm, vaddr, &optimized);
> -		if (err)
> -			return err;
> -		if (optimized) {
> -			err = swbp_unoptimize(auprobe, vma, vaddr);
> -			WARN_ON_ONCE(err);
> -			return err;
> +		int ret = is_optimized(vma->vm_mm, vaddr);
> +		if (ret < 0)
> +			return ret;
> +		if (ret) {
> +			ret = swbp_unoptimize(auprobe, vma, vaddr);
> +			WARN_ON_ONCE(ret);
> +			return ret;
>  		}
>  	}
>  	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
> 
> 
> 


