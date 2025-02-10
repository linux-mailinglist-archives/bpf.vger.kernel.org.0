Return-Path: <bpf+bounces-50937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1EAA2E7B7
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352E23A8C1D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E917C15B543;
	Mon, 10 Feb 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lj6juPHd"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BB1C1F3B;
	Mon, 10 Feb 2025 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179897; cv=none; b=TuHH5IzXn59csZ7EfpgffTRSfo2VyPkrv28g8Qn5DPNFfDUdq1apXpmpjjyG3pNRs8kDsjR9Sxrw+EalqrhiOrH+CPtXL7JYXhCI0w5abkDZCRaB0jlwF1X7sGwua8UJeW8p6aguYF+e8U8WhsXeTYV30cpC0ufy1VOpwd3ciTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179897; c=relaxed/simple;
	bh=pXGxIo5hn5kOmvtAgHj2x3TMkl0BfhjgSsLMST5UZsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqVG7DboH7qPW5AoSPQd+EnAm1tONwjXlEI+lmWH5PpY158h/TXdCsyLM1AQJbTdeSQ2lwrKk9B6G1IuXtr4Msn3Qrg9eFSCEcTc+dht/3v5mXaqIRD4Phy3OqDge5CZiEBZXZt0x7EuON6JZlFjtBDGh2qbNLv7bAqdoCeuJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lj6juPHd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Csho2nHTJojR4kG1I27uhgWuIKghIgeeXA2mkBpOoks=; b=Lj6juPHdtwNkVoknQTMeTyGjbu
	ESHY2wLJ/UG7qaJrJI1BNxOOU3YcTaJkDbs7PsZpK6Q0TMFnGr6Bf8zIGMDCPYxeYMYejSgboF2lc
	xTArcGjyj21uefzndwThQM3TUxqVT9PECXaZcsu7uhVzU74aBVdGvt3afMR88sZexWiq+0Ka2MYPi
	SQl46T8AvehS2MoevhlPLsiqPU/sFgJ//oneCsEjkJfrvZyVMTyp8St6+GDOvqpv5uaNn8XnK8om1
	jnljKIpjGo9sAxVyoX/V0WJvJnsndn2PYoj5eslhh+872qTWAxgH+xryS1HN6v6aB/CItLPrY8YrC
	fEy10S6w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thQ8W-000000006lL-1e85;
	Mon, 10 Feb 2025 09:31:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EE9B43003E1; Mon, 10 Feb 2025 10:31:27 +0100 (CET)
Date: Mon, 10 Feb 2025 10:31:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
Message-ID: <20250210093127.GD10324@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>

On Thu, Feb 06, 2025 at 02:54:08AM -0800, Kumar Kartikeya Dwivedi wrote:

> Additionally, eBPF programs attached to different parts of the kernel
> can introduce new control flow into the kernel, which increases the
> likelihood of deadlocks in code not written to handle reentrancy. There
> have been multiple syzbot reports surfacing deadlocks in internal kernel
> code due to the diverse ways in which eBPF programs can be attached to
> different parts of the kernel.  By switching the BPF subsystem’s lock
> usage to rqspinlock, all of these issues can be mitigated at runtime.

Only if the called stuff is using this new lock. IIRC we've had a number
of cases where eBPF was used to tie together 'normal' kernel functions
in a way that wasn't sound. You can't help there.

As an example, eBPF calling strncpy_from_user(), which ends up in fault
injection and badness happens -- this has been since fixed, but still.

