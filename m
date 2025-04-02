Return-Path: <bpf+bounces-55129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3FA789CA
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 10:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4DD7A5593
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2B4234988;
	Wed,  2 Apr 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YHS1H/M3"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3A9444;
	Wed,  2 Apr 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582448; cv=none; b=ZJb6IxVgBEwfcdSCoyECwy5lKV1DxGjKjMu/G1I4tXP4VaSrUu3EDf54MdR4UN3meKRl+5NlNA4IC9BuakKrodjYRKM3QHfTh29YYBH1MvrMpG11vHsYrW7nExTpBXN4YnFymmMB1zab++BqynCvqValRPeIxyzlTDlcArt0Zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582448; c=relaxed/simple;
	bh=/p5KyyDeY6EhaaIczC3E1Tyu+hSNJoEc7qlNuWVwSaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKWgpzSqLko0aEct6FBCvsL83hAr4B7jOWASeVxpolP2YJmkbcJOhlEMXqMX/aWM9nqTdKtAA6rz/gHQ2Rxw909zcpXejqxoQ6Aqe81G96mqMk1sHf+J59rNTBFFmIDKnneYi50u28DpkuUJGhlFlu2GtrTWQn6dLOm218PaZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YHS1H/M3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q8SnHO64AmYjaSODSHRV3RdeqspHDn1YnPMSbq1wERE=; b=YHS1H/M3v4YONBE08FEwr90XBi
	c4L7Xv06X66VFJKCkBtGUKH4x5hi9c92gmpVRoJaqAV1sz2B6IahSxxgacoqtDUgimAXXEFcR2l9H
	Nyg5hMWUI+AS+ntrA+8w/zVYSEzTx0OsGH1cTKDFa4aeUDJt3kIDX0l/HFz5ljT/40WtgK01YqKd5
	osFM6oiXUTUYQPmtolWIRs6l+iYhpA1NRS7uTLlgNH+DaZnqELKpIpka/qrEp5Wr1OdVSd/vGk6BX
	GzSUtzLwAAmxjhSso56p5AkrSQuudhTzMdnw8Go+FfHkfUX8uw6knAxHRcAHXgy+j9TdFK+6E2ADF
	0u+kfDRg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tztRO-00000006za7-3zy1;
	Wed, 02 Apr 2025 08:27:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 85F3D30049D; Wed,  2 Apr 2025 10:27:18 +0200 (CEST)
Date: Wed, 2 Apr 2025 10:27:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, mingo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mhocko@kernel.org, rostedt@goodmis.org,
	oleg@redhat.com, brauner@kernel.org, glider@google.com,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <20250402082718.GU5880@noisy.programming.kicks-ass.net>
References: <20250401184021.2591443-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401184021.2591443-1-andrii@kernel.org>

On Tue, Apr 01, 2025 at 11:40:21AM -0700, Andrii Nakryiko wrote:
> It is useful to be able to access current->mm to, say, record a bunch of
> VMA information right before the task exits (e.g., for stack
> symbolization reasons when dealing with short-lived processes that exit
> in the middle of profiling session). We currently do have
> trace_sched_process_exit() in the exit path, but it is called a bit too
> late, after exit_mm() resets current->mm to NULL, which makes it
> unsuitable for inspecting and recording task's mm_struct-related data
> when tracing process lifetimes.
> 
> There is a particularly suitable place, though, right after
> taskstats_exit() is called, but before we do exit_mm(). taskstats
> performs a similar kind of accounting that some applications do with
> BPF, and so co-locating them seems like a good fit.
> 
> Moving trace_sched_process_exit() a bit earlier would solve this problem
> as well, and I'm open to that.

I don't see a problem with moving it.

