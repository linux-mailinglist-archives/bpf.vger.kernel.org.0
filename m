Return-Path: <bpf+bounces-46833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3099F0A0F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 11:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9B828342E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE61C3BF7;
	Fri, 13 Dec 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YzVoyTUM"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBF1C3BE7;
	Fri, 13 Dec 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087074; cv=none; b=r39gzaMTVeRxyvHQOrLN1NYypL4jUaiailAWdaAhEDlchATBSKc4GME/msKhwZT7TAC13LubUKvxhYS7ZYG7TON2j5fS/U1zx5C9YIkChFVFlghMHrSyluBvRgyFyjaYKcGFTNqLnCaFPadDKKcj9bIWJG9WCCxz9QiHDGzP95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087074; c=relaxed/simple;
	bh=9jal2VahLy96XPiDIJleSTCKELmmzCYfJN6BnY0gfB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiMC2ms17RxcLVZoI7B9nw0PBFX0CNlnpNHXeitvUnJBv5eXfziWEd/vC67E3gG6lifrtEThFhKkxX+oO+hXd8ggvW6sPYF9MnaCsF6galKWFCMNQ1jpa/CI8aqkVl7QM2O7cnnUVFdnsesUWJ+wByOOY1HymL20lH6soGaEMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YzVoyTUM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wM7zL4wH+om2tKa4NMCs9jdln8VzYmbtWynNFpbCW3Y=; b=YzVoyTUMK0ufsh7yJ3E1aqZvyq
	RkzqnX5dPVyBSjzBSNd6lLVyXxCBCAID+b3eJBV7anMzNS2sp/b8+dMecDSOa8ay+BRW6ahtW0In+
	mvBC7qAK1H7mAU0DwwXqjAog0YvEXYFbiORAEkT5GnhNPjMMCuFHRuyRwm3Hpo/TT5dWsNDTXOfVQ
	FPsM4BJDVJcTXu6W8RlqpdOk1beKirgNMYfbek38vY01yTZylAOTVvLsn2O8r5XlLwedMC7eg3T3F
	ovlQl/LtRF3iPFp8cxvMSJab5UoIkTQT7vCwueSO0KhtkTszUQqcbR/6q9H8rRuccAmuZqV8jIZFA
	xzLzFMlg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3GE-0000000CJrr-1VHY;
	Fri, 13 Dec 2024 10:51:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D5CBA30049D; Fri, 13 Dec 2024 11:51:05 +0100 (CET)
Date: Fri, 13 Dec 2024 11:51:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <20241213105105.GB35539@noisy.programming.kicks-ass.net>
References: <20241211133403.208920-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>

On Wed, Dec 11, 2024 at 02:33:49PM +0100, Jiri Olsa wrote:
> hi,
> this patchset adds support to optimize usdt probes on top of 5-byte
> nop instruction.
> 
> The generic approach (optimize all uprobes) is hard due to emulating
> possible multiple original instructions and its related issues. The
> usdt case, which stores 5-byte nop seems much easier, so starting
> with that.
> 
> The basic idea is to replace breakpoint exception with syscall which
> is faster on x86_64. For more details please see changelog of patch 8.

So ideally we'd put a check in the syscall, which verifies it comes from
one of our trampolines and reject any and all other usage.

The reason to do this is that we can then delete all this code the
moment it becomes irrelevant without having to worry userspace might be
'creative' somewhere.

