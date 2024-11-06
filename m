Return-Path: <bpf+bounces-44115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4639BE145
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 09:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E041C232B8
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757E51D5151;
	Wed,  6 Nov 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erDPJFAc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KiEKYLr8"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DD1CC898
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882733; cv=none; b=DUAy4wu4VfGmPP/9oPx8FqNNJR5Wzn8YhuCbVrJdPBjvTMSTPwMvd/t0Ka+j8kfGcov2CTg7kAkFcTR8KrIcT8UApV5i9aQl14GaNV/LKq/wlWIwOJ2PPW8TgjTpiYgcykN373j51HD0h2735PLO3yVmUFEkiIHdaEkzWzL2giY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882733; c=relaxed/simple;
	bh=LtdWU7l8cx3IqN+1uikb8AXINpF84dTmRScL4YkSfHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8Yn6vbO46/f0jnqKAPUx+KqcsIjMJ0lld0EGHZd/7QOStFRNAwsIT+Iq3mVc1d2yRmyx2sGMdu7LAap7LNpspjdLzVCEs9rAqij7opqJg0214yJrg8M0EN/niMTNNxZSbCcW5kmxVNnKKAEwbN1ujwPraGJ1QvI2W9zc050RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erDPJFAc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KiEKYLr8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 6 Nov 2024 09:45:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730882729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvxcUBPyxv+wd8R7BnIoELGy+csXSGkUY0FS0ldNshY=;
	b=erDPJFAcy2nIa56vmhq4lt9mdTwCc/AIZvx7sD1R3Dd9WX9OSoo8PDTOYObI4kC4/abspw
	IfDxi8/29ZqK2nMAPg1WegNo/ccfxaJFAVkfBPM6TMg/quvucZB//w0emH3nGiMT/isFUk
	bLax+/oTL72hXHs7p7lkwW2wyq92IuplZneZJpOFk40y1Ijz7MqutBV+nQTuGP5tPCTTV3
	i0xZnQ4O+58QW+XdhgcSDVkwds9BHCxrR60IGkBSmxmrF4EtaZXA6ph0y4X0XQy8Jlsq0R
	P7oqE6tIq3nPBjXuiiUY/QZsiD/54JxlCOHXjYwVOn/dxm7sjboEyY132liQcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730882729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvxcUBPyxv+wd8R7BnIoELGy+csXSGkUY0FS0ldNshY=;
	b=KiEKYLr8ra5SmjgAmlv39GgowJjIls90tLCHH4iUnd3rXL2KLT1P+/oZYtwe6lh9OmOHx4
	gv7tkuNKe+c9x/Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
	xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 0/3] Fix lockdep warning for htab of map
Message-ID: <20241106084527.4gPrMnHt@linutronix.de>
References: <20241106063542.357743-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106063542.357743-1-houtao@huaweicloud.com>

On 2024-11-06 14:35:39 [+0800], Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
Hi Hou,

> The patch set fixes a lockdep warning for htab of map. The
> warning is found when running test_maps. The warning occurs when
> htab_put_fd_value() attempts to acquire map_idr_lock to free the map id
> of the inner map while already holding the bucket lock (raw_spinlock_t).
> 
> The fix moves the invocation of free_htab_elem() after
> htab_unlock_bucket() and adds a test case to verify the solution. Please
> see the individual patches for details. Comments are always welcome.

Thank you.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I've seen that you didn't move check_and_free_fields() out of the bucket
locked section. Type BPF_TIMER does hrtimer_cancel() if the timer
happens to run on a remote CPU. On PREEMPT_RT this will acquire a
sleeping lock which is problematic due to the raw_spinlock_t.
Would it be okay, to cleanup the timer unconditionally via the
workqueue?

Sebastian

