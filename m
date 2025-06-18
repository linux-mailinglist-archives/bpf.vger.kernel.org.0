Return-Path: <bpf+bounces-60932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC4ADEE8F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75114A2D79
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEB2EA754;
	Wed, 18 Jun 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5sV/vX2"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EB27E1C3;
	Wed, 18 Jun 2025 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254892; cv=none; b=nFnB9q+rwILowz8KBs2FlN43gR/gqxL7aXIIG1PtLXjY4mAWJguxykl5KY8dCHQHUiL2dNY+xSxFugLrHBmDIbRakpPBLzoktWwc8gaLV0b7BR4LcSyOSLemHd4lT4v5tm+SEhn9rs9LaTZUCrcjJJtKIl97DlZUb+Ph1sc5F1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254892; c=relaxed/simple;
	bh=pvW1CRR134EKmeKRL5efep3pSjvW8VBS2sAmgRAFSP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSgiGNxGy0lyiXa1LO43lJOlNmGLV+G8C7ISLEFvE967dEi3BaC0G980wbKngIBIQGpP6HMC5Fhio/vaS0b/Q60kSGU2J0e//iILqWA2NihPzve4zN5HNq7YwOSdHAGYcCw2dF2sNQGqZgo228+a4cka+AQYkjYjtuYhmgFmsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O5sV/vX2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w9yqpTZitW3WjaEp6tdJZdLaIjQ2otv3TLDZX825m8Y=; b=O5sV/vX2qxLkYTb82zvJ9RuUMI
	Ddvw+wJer8agERqyXbGmkWjb9pFMfqITyXSlKUul/uv8Vip7ZJa13Nolzs8NB4hOtrFIUIWKaU1vM
	rM692xxx30mp5/iWb/hgICziu6DtMDDNP6xxl17s2oB5PSYIJtbwJ/mk/lLLzt8dp3wIFa7xMw93t
	mL3LS2TT7TUHuuN9pLGkcHFN1JB9HXd7TtFePkDCUMvnp1ew3D/qggN/q/OcqxoD8p9z8K/UsT+tv
	L1LQ3gcSyZmgMRexOJ8+7WZTIA1uMgjAb3POF+N+WhltBEvIMucUMRxfVXn6Lr0hrM8h4bzS/7tcC
	gF3GoU0Q==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRtFV-000000044gU-0rgS;
	Wed, 18 Jun 2025 13:54:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02CDE307FB7; Wed, 18 Jun 2025 15:54:44 +0200 (CEST)
Date: Wed, 18 Jun 2025 15:54:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 04/14] unwind_user/deferred: Add
 unwind_deferred_trace()
Message-ID: <20250618135443.GN1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.433111891@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.433111891@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:25PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add a function that must be called inside a faultable context that will
> retrieve a user space stack trace. The function unwind_deferred_trace()
> can be called by a tracer when a task is about to enter user space, or has
> just come back from user space and has interrupts enabled.

This is word salad; I really can't make much of it.

Let me go read the patch to see if that makes more sense.

