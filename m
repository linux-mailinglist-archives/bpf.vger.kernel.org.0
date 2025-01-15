Return-Path: <bpf+bounces-48908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0013A11AD3
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 08:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E113A68ED
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783D31DB145;
	Wed, 15 Jan 2025 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4o1B/H8c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0j/rHbG"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297331DB135
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925765; cv=none; b=tMDLUwVdpThDWwhI1tYg5tZb1moVIMCczF9KXwmQdXYz6LBiyFpXkJPzLMocV9GtF92F0M3d9GNeqsqGYxOjb2u6vcKKYQ46xaUc7ZXV1eRyGxJZKV7UQ2kqqfLLBIm4sPssHB/dWUaV8f+CfGB8B6jNLb3th34guDrXkTmQzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925765; c=relaxed/simple;
	bh=M0TH0Fmvc6e8YJWWPgGOTP3dCUZloJdQzFtlPJvKWw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y28nfg5RC7NE1FrAH10fjFiM85+Ic93ufKPU4VNLBAjA3RwJmIqUq0XkS1HYN8LZb1eTDqI86EhnjFjk3C8FBVGgHaubRnRrbS1HgzRVamR9Qr3ClK54DfAOHwU5wYBCdzbpWRVWssTaQTNeqCK73AtRe8cK+ENLIsF/JkJ9Sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4o1B/H8c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0j/rHbG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 08:22:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736925761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udPXADjrwDYlPxB0H+QGHkoHz0Re/g9IAr4Idf25SEo=;
	b=4o1B/H8cs57gWWJBd8WzLfKG53DYuGzBOOtClDcFfvugx0VgWUjsuwBOAU7nKdVWIs893Y
	btPZYbEIfDQpEEzFJxtKMZYc6vewXC/8FGVYSIAVk6H2B9UVC2yEB+bvw6qoHCmHpy26DO
	FwpWggeWtDofU6/+NAII5RTqIHBVMho/ipFLQ+cIYs4zxiwdHIGbzvFsDj+tW3ceU3sf/w
	0TzCHFmCV7Hrca9zS3zf+ChuIltsuSEk9lua2uJGQcLXJQYIkcIj/nG3QJYol0v4eauYeb
	E4NXTZ+RhtA5btQZnoxNac2aYEhhJnYMbrjVwOpY9mcxq1oLeaCb8VRV+milOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736925761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udPXADjrwDYlPxB0H+QGHkoHz0Re/g9IAr4Idf25SEo=;
	b=n0j/rHbGTskiJngmmVolSgXk/hmdW0/o6d5qsmh7xPx2xYYiRn0BU4KPs/XMHGBOH0vunY
	5NRB5xE/SjguyUBA==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce
 local_trylock_irqsave()
Message-ID: <20250115072240.FovdxYXQ@linutronix.de>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-4-alexei.starovoitov@gmail.com>
 <CAADnVQKJVWxaOMM=-faRh=1TBK=HNm8iOWD536Q_65+W4X=gVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQKJVWxaOMM=-faRh=1TBK=HNm8iOWD536Q_65+W4X=gVw@mail.gmail.com>

On 2025-01-14 18:23:21 [-0800], Alexei Starovoitov wrote:
> 
> Sebastian,
> 
> could you please review/ack this patch ?

I will look at this (and the other things sent) tomorrow, or FRI at the
latest. 

Sebastian

