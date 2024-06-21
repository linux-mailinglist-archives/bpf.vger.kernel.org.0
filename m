Return-Path: <bpf+bounces-32759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BA4912E16
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4E72824B9
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 19:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FDB17A93A;
	Fri, 21 Jun 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA6fsPyL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C613B59F;
	Fri, 21 Jun 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999220; cv=none; b=D9NYVQjgrDkLh+OyM+ivhyLTWkexX11x/IIaWcROUHAJLAfm/y3VWssGhTwDqY+uaT2jw4BjaQmx3KPrnm/s6pC+dZx48rowEleALwdqjq7zLhIrzmva0eg63dWNkj6D/Bu96hzUajRCSSYlloHEr0n8hO1PtjC4oitCPCpLssU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999220; c=relaxed/simple;
	bh=yU2z2DJZv7XHWtM2QjUWji5BSc6J409Zd0oe+r/st2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/OHCa44UvuID7vE93EPUcTIwie6SprwywlupDct0hrKJ5t4OBH4V54K+BszMHj/WURYyuIwMW0O7yCHtspxACtBPCqmRhzj+1P+yvSA6Y82r5BGiFIwR1pTqLEufgJfPzCiEpcuXW4LDVHc8UwqMRzjq9DvSB2mn8ArHFwvapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA6fsPyL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706354409e1so2121562b3a.2;
        Fri, 21 Jun 2024 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718999218; x=1719604018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0t/8hzhEOnJgauoqC4P/3+Tol7cjVc8S0pcKauAPzM=;
        b=eA6fsPyLkSoVW/h7yr9AZfhWQzXYCsAutTA3sljr424tbTWAnhoeX4eg20TrYrh9YK
         7gaSV64KoXWOwGGfaAhysoZqQrbw8G6Z2gB6CTdOYlzkbrJpVDSZuIVlVyoppemmQxL/
         ReppQwzvcI2ms/rlwrp/3rYAER3PIGbxP5TkZnYMn1eVvsnHdiLcXm3H6E/WfYncVhRK
         AadowA9paw5uNFbS5CJTYE/7x5v3RlUbYPLLw53wQTwbEZ4l08gxL5UALepf4LyZBj8S
         CtDExViOr6XqJVdWr6hm8GDbcTK3kF5WGOwGQUdH4mTv1y/WR52hTJX4zeoMhbh68wQ+
         ktoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999218; x=1719604018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0t/8hzhEOnJgauoqC4P/3+Tol7cjVc8S0pcKauAPzM=;
        b=DA3Z2Uh3cj0gDU/+9J+B6WelYzWU+atreJd8nmdC9j3x2zxq38DiCsGJSpQoMXKHYH
         PU117rItci+cqiSU4i7bEDWmTRdMfEzij0Q+s1ZbHYiEOWwMvCLP+tuKlSf/+yfhF5Ri
         UTIq/joctJ+4yOOlr6Ne2Br9xi1QQe9gTyIdSAi9jPA4wZnJ8E9Rep9VtcHCMbc0WFlc
         k/X0JWtLujqMDAc4z0iG0MtrWg1FrM1Ek4kNjfOWcpvJBu8ci6oGWWQ9czOGgPalUYS0
         8uZr0r6PxcidupOB3GICPAIEIshtWQ5KQwDuxPQz59v0NCC3DwxHGmQLn+UhpuI/wTDc
         jECQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnCzyIroHs5snBUmlxDOQDDWnbptQNsNs+9REBc1l9AnpV0aVqPzt/f0LUPiPNxu+rp6C5Nrq9HgrTAU5wbJVnMD4W1iJ8IipQbh5EcpadFoze100dtETnRz7uMev1VCG8
X-Gm-Message-State: AOJu0Yw3P3TJkARx17nd1xqPXMnfhIjVxHB+HpT1DoNZ19X/+FIID520
	qBNi7Ayy8v48Dl+I+/7s1qpbHRfGx1ObrcbWcZbBdHyzQv41rHts
X-Google-Smtp-Source: AGHT+IE5LoO3qFQ9l13F4NQXJx6hQoOceSXfH80tyyB6SBsXpEF0710urKuzaFNPqa9hrndu/kbu7A==
X-Received: by 2002:a05:6a00:22c5:b0:705:ddbf:5c05 with SMTP id d2e1a72fcca58-70629c4204cmr12741427b3a.11.1718999217674;
        Fri, 21 Jun 2024 12:46:57 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512d6483sm1840279b3a.178.2024.06.21.12.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:46:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 21 Jun 2024 09:46:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <ZnXYsHw1gOZ4jlp2@slm.duckdns.org>
References: <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>

Hello,

On Thu, Jun 20, 2024 at 03:42:48PM -0700, Linus Torvalds wrote:
...
> Btw, indirect calls are now expensive enough that when you have only a
> handful of choices, instead of a variable
> 
>         class->some_callback(some_arguments);
> 
> you might literally be better off with a macro that does
> 
>        #define call_sched_fn(class, name, arg...) switch (class) { \
>         case &fair_name_class: fair_name_class.name(arg); break; \
>         ... unroll them all here..
> 
> which then just generates a (very small) tree of if-statements.
> 
> Again, this is entirely too ugly to do unless people *really* care.
> But for situations where you have a small handful of cases known at
> compile-time, it's not out of the question, and it probably does
> generate better code.

I'll update the patch description to point to the previous message just in
case and apply it to sched_ext/for-6.11.

Thanks.

-- 
tejun

