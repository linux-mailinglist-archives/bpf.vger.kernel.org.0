Return-Path: <bpf+bounces-66529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB40B356C0
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 10:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A89A2A06C1
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF492F99A5;
	Tue, 26 Aug 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkJjqqwR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A78288C1E;
	Tue, 26 Aug 2025 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196737; cv=none; b=gpbUpT/5bzi6vyZ/HbGuWVU8YlUx4is05eartY92DMGPupWkH+UXdUkJs7Z4OyZNWG/o4ios8kYt5O87YehTEfJJqmGsZSL6YcRriqaiCAgxicVcTyMGFsz8qtN7IO2jHkyyX1mlNQWYX/fNzY6cjYWIV4+BsTy9heQA5c4RyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196737; c=relaxed/simple;
	bh=jV9QznAEm1hdpuMJtLtg211F801jTzjdPlDG+IHYxs8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpkIwxfwwn8VVE//sbSrZCGqa4DKRxHo+I5fKh28Wy4TW00/dbN57qJEC8wvtjjilCQoRNn5gJvEB2GJRzrMbgKcaWl/mu3FUYHwLNjY+EBJo7YwWsb31aCSfJ4701WsWIdzlDr6cySQnSBm1rmxfErzUnwyP3bR05loWtrC7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkJjqqwR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso2471626f8f.0;
        Tue, 26 Aug 2025 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756196732; x=1756801532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Yw+OyrvJ/9yvKZdr/nNUy5EAOlQT2UEcVt87HrLB4=;
        b=hkJjqqwRS9T69WAwiwwBBmHUcFZkBXEipb8gPMwMxI7YeOa5vPbPlCV2ul46yVlHCC
         DzKAhDcEoBuyFeAzNhc5lR+3KfDNfnHpr4698JagvnGa3+dVaj6CZCAEM4DIPMLno7AW
         KA3sz5AKzYGHjSPbO/MqTajKsPCdyFZrvvMf+rhfS18zNppSM9Lf1jtJi2tyvV3QTEGi
         xNAt2v4D+TH60SE00iId/CpnvkVBnYEKpOw4ZavCRY/rPS4D+PqVHJiRgFzUYggwnChz
         qGS4LKWLXh/kNm4vXIEz4QrMJeJXVkfwYRYmM9LRAOqTlSWiBPKNx+EhBx1FELoBmaGq
         lbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196732; x=1756801532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/Yw+OyrvJ/9yvKZdr/nNUy5EAOlQT2UEcVt87HrLB4=;
        b=T3vpGz97rFUmaJzPNHnqZWmkXu/ta1PmK0W1SJNOKxcpn0yFeghP/s2pU/o/BDAGKp
         MwMnacPVKDC+bdJ2p+sUKQsJPbFnEmn+5IdCmLwR3m5jIDYvjYIy9o8Gpp4u3kjl8yT5
         0/93ZslewBwmuhxq+O8gLlukfk5GwlB+gvbayJD0jhFkMYc+p5Gfi92PtzdnozXlb6J2
         3qsM7Zb10pPCcfHKQgkas0RUFdEZqPuM2anKi76YHrndH9iAEj808mOdrHG8wMMKrLjt
         PDg5DxGwOMNML4zyUCh0KZreNAuDu/Z9joq91WObJRB5yqwjpF1vlpSSXyOUHaw5JcKD
         Pm8w==
X-Forwarded-Encrypted: i=1; AJvYcCWFM0ZgqqGVqQ1SqeL8mYDjipwcMOHBtid8dYD7riOIhfYhlu3mjNJ/ef6C7noLGBkAWx+OhJ84QpmvHhhwdhpdEYBd@vger.kernel.org, AJvYcCWebQQWLLQFfZZrdcpNsaA32BKWnxR81Oq7lsTyy5Ttj51mw7gJXqJpuQHRPafMBLIZax3tXR+voGJOSJG0@vger.kernel.org, AJvYcCXg9CBNQDPvpyJVHTkO/SswqvMIFsXdeAOZfqqP0+QZ54QiuesfcLOXfsntvqr5dLsHXg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyat0BZ026/LGpNp/EdtTY2yqdooTlx6ihStRAeTYQPb59zOqVS
	7Y5fQUI1IX9gCP5y1hOZedKQu+fybR/o7MjhLH1V90m80+2uUlAx1Eon
X-Gm-Gg: ASbGncsKb6cVZpENO4N1cFmr52ga5JVDKdgE/DZRl1aJxhwbwlHNuRu7L9xFLpzHolo
	rziiQFbVvatBvHQfyuV2uaCwnfz5U/+Id3grnN7sCQCS5WCaaAnTWLEknF/9DRM7As93MqdqBQ4
	AQrDyta9nTsAWd2wxtQMmTb626CcbE/1rGfm79ptnVw5Y73XI092RwhrdUIAtMHdmYFZiAdZo9i
	pWk4kTMjpjjHZosQw++Pa7ibC6krTvj7FWZt6Ly3AL53tspiMjNL/zSdx8I9avkQ1OTl5F/fjxk
	0kYfiniQWBLIkVBx4mYfSoqmZKv34EudXp+Rp0iq4CGeOklBwELXWuoXm7bBixKzl1NcWsE=
X-Google-Smtp-Source: AGHT+IGSPiAB25OLIeOd7EFCzQ2c6ROIJ+KjpslsUZs6f1QirhQirc3bB/Snb6y+dJxp4/X0dGQSxg==
X-Received: by 2002:a05:6000:2dc1:b0:3c9:80bd:3905 with SMTP id ffacd0b85a97d-3c980bd44dfmr4188733f8f.4.1756196732354;
        Tue, 26 Aug 2025 01:25:32 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cbb710172fsm862690f8f.48.2025.08.26.01.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:25:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 Aug 2025 10:25:29 +0200
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
	andrii@kernel.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, alx@kernel.org, eyal.birger@gmail.com,
	kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@aculab.com, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 2/6] uprobes/x86: Optimize is_optimize()
Message-ID: <aK1veaIWBv3dZUUP@krava>
References: <20250821122822.671515652@infradead.org>
 <20250821123656.823296198@infradead.org>
 <20250826065158.1b7ad5fc@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826065158.1b7ad5fc@pumpkin>

On Tue, Aug 26, 2025 at 06:51:58AM +0100, David Laight wrote:
> On Thu, 21 Aug 2025 14:28:24 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Make is_optimized() return a tri-state and avoid return through
> > argument. This simplifies things a little.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kernel/uprobes.c |   34 +++++++++++++---------------------
> >  1 file changed, 13 insertions(+), 21 deletions(-)
> > 
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -1047,7 +1047,7 @@ static bool __is_optimized(uprobe_opcode
> >  	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
> >  }
> >  
> > -static int is_optimized(struct mm_struct *mm, unsigned long vaddr, bool *optimized)
> > +static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
> >  {
> >  	uprobe_opcode_t insn[5];
> >  	int err;
> > @@ -1055,8 +1055,7 @@ static int is_optimized(struct mm_struct
> >  	err = copy_from_vaddr(mm, vaddr, &insn, 5);
> >  	if (err)
> >  		return err;
> > -	*optimized = __is_optimized((uprobe_opcode_t *)&insn, vaddr);
> > -	return 0;
> > +	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
> >  }
> >  
> >  static bool should_optimize(struct arch_uprobe *auprobe)
> > @@ -1069,17 +1068,14 @@ int set_swbp(struct arch_uprobe *auprobe
> >  	     unsigned long vaddr)
> >  {
> >  	if (should_optimize(auprobe)) {
> > -		bool optimized = false;
> > -		int err;
> > -
> >  		/*
> >  		 * We could race with another thread that already optimized the probe,
> >  		 * so let's not overwrite it with int3 again in this case.
> >  		 */
> > -		err = is_optimized(vma->vm_mm, vaddr, &optimized);
> > -		if (err)
> > -			return err;
> > -		if (optimized)
> > +		int ret = is_optimized(vma->vm_mm, vaddr);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (ret)
> >  			return 0;
> 
> Looks like you should swap over 0 and 1.
> That would then be: if (ret <= 0) return ret;

hum, but if it's not optimized (ret == 0) we need to follow up with
installing breakpoint through following uprobe_write_opcode call

also I noticed we mix int/bool return, perhaps we could do fix below

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0a8c0a4a5423..853abb2a5638 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1064,7 +1064,7 @@ static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
 	err = copy_from_vaddr(mm, vaddr, &insn, 5);
 	if (err)
 		return err;
-	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
+	return __is_optimized((uprobe_opcode_t *)&insn, vaddr) ? 1 : 0;
 }
 
 static bool should_optimize(struct arch_uprobe *auprobe)

