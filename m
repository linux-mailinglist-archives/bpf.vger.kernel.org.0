Return-Path: <bpf+bounces-48226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369CA05488
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 08:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164F1160E3F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 07:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09211AAE13;
	Wed,  8 Jan 2025 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="paY837tS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yk/YEReR"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6519F42D
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321352; cv=none; b=iKADoH8hj6M338bHWFxGRUNRRBj9ibIoNbQALnKQOuwNjIFByFzfmo+gClnmq1j2TeJ9RiyC0JfrFsAPC9EMyhGwGp3BNKclr7W5nTP8tfIFPIN1xAC0SjJcifk+LTeDb4BWJbSPQ6lET0/0p+J9dKuP/HRxreHuCUexJCu2bNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321352; c=relaxed/simple;
	bh=LgewvT1d9Utx/xtCb/ngY8uuV0DNAuVjaZR/xlUZ2sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ4nGU0lF4F1GsIggAzrhUufh2xRe/6qE2fQLf7/UXtIkMl48xsNvix2KdK7gc/1T5SYbC35LKLtqp1icHUuAo7mGva6CN3aC8eBg+P6YEuYGikSFDMGEknjdebicaA0xheWZQuhdJb3ZQrutUa1eRSp6fTqZWAUTnwnUhXslIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=paY837tS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yk/YEReR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 8 Jan 2025 08:29:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736321348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgewvT1d9Utx/xtCb/ngY8uuV0DNAuVjaZR/xlUZ2sU=;
	b=paY837tS+W7UH++oq/7rpcsRuiXUCO7Lvvl+laeTtNdjCMvK/shBVT5G+7/xQy5XsWtO2q
	2NGd4yXE4VICjYnvfs6iRwj9lcGDu5bLYTegGQqJOUJmYCbSLxU3EVm0+rMXhdN3czMJQB
	XXufW+0ovOWdAsbd1Gl7q9vr3TYcsr1ojv+GF8ZZuCP1c2SNJgEr/qkklxXGeufi//aIwr
	nEVeMgrgqf8vwjB7FUNl1pjEBtsoMTf7w5eaN32rRsgaeNHcTFSobClkkQcQNN/pwD4alv
	nUlSAGPaiTEpzArj64NDLZtvqR9CCDC3hfCM1B/jB5Y0snBzDcr1irGnZPurBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736321348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgewvT1d9Utx/xtCb/ngY8uuV0DNAuVjaZR/xlUZ2sU=;
	b=yk/YEReRJ5oNFveffNLnhVYTLDp3yjfznbTyGjMDcZAGdIoZdvDayRmsejTarwkLV/z3Ke
	oDTXbVa+Q0Li76AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, xukuohai@huawei.com,
	"houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [PATCH bpf-next 0/7] Free htab element out of bucket lock
Message-ID: <20250108072906.chgNtc8S@linutronix.de>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
 <9b4ebbaf-dd3c-85a4-2d17-18b8805ea5fb@huaweicloud.com>
 <9685012a-1332-95a1-a8ef-dfd25f5cd072@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9685012a-1332-95a1-a8ef-dfd25f5cd072@huaweicloud.com>

On 2025-01-08 09:24:02 [+0800], Hou Tao wrote:
> @Sebastian
> Is it possible that softirq_expiry_lock is changed to a raw-spin-lock
> instead ?

No. The point is to PI-boost the timer-task by the task that is
canceling the timer. This is possible if the timer-task got preempted by
the canceling task - both can't be migrated to another CPU and if the
canceling task has higher priority then it will continue to spin and
live lock the system.
Making the expire lock raw would also force every timer to run with
disabled interrupts which would not allow to acquire any spinlock_t
locks.

Sebastian

