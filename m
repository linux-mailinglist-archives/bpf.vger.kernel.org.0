Return-Path: <bpf+bounces-44120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706BC9BE378
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 11:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CC21F22E1A
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0E41DB377;
	Wed,  6 Nov 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="soJ/E+uf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U9y4bLjF"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545D1D9341
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887514; cv=none; b=skGy5BZNHflavJTDdjJzrCQVehJtYKDVUzApQjhAA2SoDLYLlU6RAUicZh0ge4hzGUFCWGkQyAOf01A/YQXvXOvbKH4m/NO/IG7P/Eza/dNSw1tajYbgYamValPcD7ZGf/JlJ5gq3cK4zdsZfL0yNi0caw7cqazOWz0PZ9zPc98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887514; c=relaxed/simple;
	bh=QX4l/IhwakdnApfSndwdz9F8PkdFDKfVea8aed3J13k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpaoKDPUxZRCHz2K624vBB1mTUvpJKkvN1W0U0wSAtSgObbwdDG9aa6hMWXgDd8M1LG3DEmSvM+ZGeRvEqemsYoPdY8MDxDGpJmGwoQznGHM/82uGIku4b7gIENB7s9b9MWMNC/WMaZPRm5KG5HBvWg2BLu5mfHUAZhHJAlcMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=soJ/E+uf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U9y4bLjF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 6 Nov 2024 11:05:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730887511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SjmgkWlw6HP4qSnNSg9lxuyPMsdtRM1NdY8WNCs47RU=;
	b=soJ/E+ufZTh4LF/T2cIClYZNQ/frk34ocUiA0m6LrRoS2Rhd4vJ4IYB/q7e6KB/XJfoK2v
	EFc4HLddz9eQ3XTGuk/YmmgqgOOj0rHNmg1JHq6/8dth6XveWSUCGXTJd63raS5e2zTpW5
	KzarM8iP4oA0lXyaak0kWT1fltpgVUHeAiu3UKarfFrEjSK7CTTA/pXMi+Fm09Qa+Rj2RW
	+ZTHXSPej4capSByyZHUSQBSJ3RXeUWuuSrm8LwuooExNP2YQM6y3LRaxeKZ1CxJOmPPJQ
	u03lyqsC+ws7FF1/Ndh9GkggUW+ywwCC2v2q6ZBHlG/WJveBvnlO+39h13ztYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730887511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SjmgkWlw6HP4qSnNSg9lxuyPMsdtRM1NdY8WNCs47RU=;
	b=U9y4bLjFv2a4qYJ/MAybOU5sfVyTeks0M5Z86kPjBQ2kVR20PaTnEinp/Ass5o2nT+KhvA
	ZmBX5xPobz1px+Dw==
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
Message-ID: <20241106100509.7hAottpx@linutronix.de>
References: <20241106063542.357743-1-houtao@huaweicloud.com>
 <20241106084527.4gPrMnHt@linutronix.de>
 <892b3592-0896-7634-ed44-9ba610242eb3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <892b3592-0896-7634-ed44-9ba610242eb3@huaweicloud.com>

On 2024-11-06 17:48:59 [+0800], Hou Tao wrote:
> Hi,
Hi,

> Yes. The patch set still invokes check_and_free_fields() under the
> bucket lock when updating an existing element in a pre-allocated htab. I
> missed the hrtimer case. For the sleeping lock, you mean the
> cpu_base->softirq_expiry_lock in hrtimer_cancel_waiting_running(), right

Yes.

> ? Instead of cancelling the timer in workqueue, maybe we could save the
> old value temporarily in the bucket lock, and try to free it outside of
> the bucket lock or disabling the extra_elems logic temporarily for the
> case ?

Well, it is up to you. Either:

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab286..b077af12fc9b4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1593,10 +1593,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 * To avoid these issues, punt to workqueue context when we are in a
 	 * timer callback.
 	 */
-	if (this_cpu_read(hrtimer_running))
-		queue_work(system_unbound_wq, &t->cb.delete_work);
-	else
-		bpf_timer_delete_work(&t->cb.delete_work);
+	queue_work(system_unbound_wq, &t->cb.delete_work);
 }
 
 /* This function is called by map_delete/update_elem for individual element and

Or something smarter where you cancel the timer outside of the bucket
lock.

Sebastian

