Return-Path: <bpf+bounces-34128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408A92A9D2
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 21:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF5F1C21310
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225CB1CD2B;
	Mon,  8 Jul 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBfJrmbq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092079FD;
	Mon,  8 Jul 2024 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467043; cv=none; b=itO4MN/HozEg1XWBzWQ4hu/3V1UYY9e87Q8Dep3LMplzjkg4hjsMCE4vIGFOD2VNMZjtwjsjI68t9AW2yGAss0aIIusH4yxNtmEOqySRvJdnFEH8GItwY22nwtOhxP271yZMpQ8b5wNzcYmAZ03gL1XjByP6BKOoOvJTzzPNKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467043; c=relaxed/simple;
	bh=QqsIjAwAx9n+inGkLP22a0n82rYg97l4n/OFS3+ObVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQBCRnqNZWKb3UweaN3pDYw+POLsDl8zfGXbtOqJdIicS8T37Hms4NvJTXqtgEAVJMiwdUE/lvv0Gbkg2hevjaeQQxpZGsTRdrYA6iw/wLZSH28Q+mq0QCworwsb1d37kwTMnNoGPfCK7znTf7th7lpxrKVDBlLaSw9iWWY9Qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBfJrmbq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso3156357a12.2;
        Mon, 08 Jul 2024 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720467041; x=1721071841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KmNcC+I9gtqNl0qK6Sv3GvWp2GJox/ne1ngUcC0thQ=;
        b=SBfJrmbq+IN4WdB+zrWafp7X5AZuLq/dX3eEqNtAJKR2U5gdTinF+3dpNrEbmNtD+e
         ZbQCbqnKbqBwPAM5tdpxvH4d6VtRqEIHbGoaskjn2PRNPi7eKX3cX2bmFQAY2TpdFXIk
         Yfbfpy4NBqHFOOmaCCaIr2fPVw09LY3MCVWoRVvBClesm3B/1NOhTn/buefhvRPF0Zl8
         Y8VM0/PxBvuDaD7UNF0ZEEyacabyHM7E1rEJZsol/rC214ejwOom6DMwo3NWpd5fxtgK
         UHZ5obQFvPf0R44JjwyrcTv9qPrrzeiDUJxRKPDNF1gDwWINJiSxD5Gclccdzsd2tWg0
         sr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467041; x=1721071841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KmNcC+I9gtqNl0qK6Sv3GvWp2GJox/ne1ngUcC0thQ=;
        b=m06S0oesH+bZZRiZsXnPvR4Ni64qDshFtRkg4YczKtINGZclhanUaihts1LOrKYo3m
         iF+vll5LzGQiETrkx7EvfrNYKV4L1wADRfLYsAkQJ4XnNLxZcXdBV6iIPDqkO8O6J2N+
         RaDK4QcNruAghXtTSe+UqG4dmARq8Ke0iZxJDKoQyJBLI5G1yJy3ZVjx/Xgw2owdtSMD
         IxrnkZHSAIcJ704eTzJ1IuC7AaR8WyDcY7fyn1X6QKdViNCi+zQ/3s/oJBQ3YqCuLERD
         JYDHBmosF8miJ75jiyCEP4gwe47vjnXRh1ZbrRy/UVHZ5N0UEw/SYG56Sv7Lg2tW3xFc
         aPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNrztED0U/kcpuI3A7MHh9DsjE3MmsdAd2XT7AEPCSymvOVuO/0EaXRml0bvys1P0gwEyfPRbHuL7YhkJ3CYzqRB6ld+Gyv6RR2o//hWHqgVmXmukElDjNycWHdI8k/K+S
X-Gm-Message-State: AOJu0YzwUZTaB0vFV07YoZ7uxJd9qsKeYQiCNCFDcfdRQyBaW992/IXt
	ydXocpvno1xTQkW2Wp3EeUh3TNCfPum1FPNmLXhM0X8xtGIefc+I
X-Google-Smtp-Source: AGHT+IGyl/jS9MvDQyLMzLqanEZPeD0lXGN0ufhqi4CP0RDFUXeihZ73BJMdoiaHHL2bgtohShPEDg==
X-Received: by 2002:a05:6a21:3086:b0:1c2:8d3f:796 with SMTP id adf61e73a8af0-1c29822d057mr349495637.25.1720467040914;
        Mon, 08 Jul 2024 12:30:40 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab75a8sm2201765ad.156.2024.07.08.12.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:30:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 09:30:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
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
	kernel-team@meta.com, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Disallow loading BPF
 scheduler if isolcpus= domain isolation is in effect
Message-ID: <Zow-XrnYpDmdyg9O@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-10-tj@kernel.org>
 <20240624113212.GL31592@noisy.programming.kicks-ass.net>
 <ZnnijsMAQYgCnrZF@slm.duckdns.org>
 <20240625082926.GT31592@noisy.programming.kicks-ass.net>
 <ZntVjZ3a2k5IGbzE@slm.duckdns.org>
 <20240626082342.GY31592@noisy.programming.kicks-ass.net>
 <ZnxXej8h46lmzrAP@slm.duckdns.org>
 <Zny_5syk1K74HP0D@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zny_5syk1K74HP0D@slm.duckdns.org>

On Wed, Jun 26, 2024 at 03:27:02PM -1000, Tejun Heo wrote:
> sched_domains regulate the load balancing for sched_classes. A machine can
> be partitioned into multiple sections that are not load-balanced across
> using either isolcpus= boot param or cpuset partitions. In such cases, tasks
> that are in one partition are expected to stay within that partition.
> 
> cpuset configured partitions are always reflected in each member task's
> cpumask. As SCX always honors the task cpumasks, the BPF scheduler is
> automatically in compliance with the configured partitions.
> 
> However, for isolcpus= domain isolation, the isolated CPUs are simply
> omitted from the top-level sched_domain[s] without further restrictions on
> tasks' cpumasks, so, for example, a task currently running in an isolated
> CPU may have more CPUs in its allowed cpumask while expected to remain on
> the same CPU.
> 
> There is no straightforward way to enforce this partitioning preemptively on
> BPF schedulers and erroring out after a violation can be surprising.
> isolcpus= domain isolation is being replaced with cpuset partitions anyway,
> so keep it simple and simply disallow loading a BPF scheduler if isolcpus=
> domain isolation is in effect.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Link: http://lkml.kernel.org/r/20240626082342.GY31592@noisy.programming.kicks-ass.net
> Cc: David Vernet <void@manifault.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

