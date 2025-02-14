Return-Path: <bpf+bounces-51617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DEA3681E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DEE3A6310
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199941FC0F4;
	Fri, 14 Feb 2025 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJRmh7RB"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86591DC198
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571116; cv=none; b=lmczWK36OuYdJO717DjjKP50uyWboXDpXUVoSA6n92w96uifpxgzEPhyURmSeZ6h2gjUzA/tWgjWp3yAu4dXB0Ewqyo2d5Yzo1IkSIOICX3uhVuDQKgGPAYYzT3ZUbCQXXOsGI+2Ll5gLHDMvvdpDQOrVPx4X4GYUSZl5OvOkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571116; c=relaxed/simple;
	bh=MxEfRbTTUEvD/LyNwNYkAl+DmhWTP5pzJ0R+SLtjwro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el4mCxdBKeMvFq9om/zM6QqYLsqvIeo9qm9fsjyQL1oTQcR6UQXmSkh9+Tv0A50pm6dlAinYZ7PkRf+frhT4Xl+nMQbg36/gHZJqO1bKSvC6zgSh1ZPNAfCSlHxxX54+mIuDpxK8KO5VOj4nTa9p8gA2Cl6Y6QnxZHkNlVdTWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJRmh7RB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44668201-cf8b-49c1-9dd0-90e0e5a95457@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739571102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vl0te2J9Y7cl11roWtJDotLT029Xxpyp8BvBndYP0/U=;
	b=vJRmh7RBEMjVs7Ljgmz+9160GjBNlqRuiRlX1Ws703FJd5bpYuBD/F4ptDQgrLWVRfw6kL
	1Ai3etzw59k9nwHNnn+71uDzrusBF7hQ+34y33sl/TWFHIrvzsJ66oUkko3GFAz1z7SHa3
	+rEQUAzvB4G82l3Z9S5fTDhrixUBaNQ=
Date: Fri, 14 Feb 2025 14:11:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] bpf-next: Introduced to support the ULP to get or
 set sockets
To: Jakub Kicinski <kuba@kernel.org>
Cc: zhangmingyi <zhangmingyi5@huawei.com>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Xin Liu <liuxin350@huawei.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, mptcp@lists.linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com,
 liwei883@huawei.com, tianmuyang@huawei.com
References: <202502140959.f66e2ba6-lkp@intel.com>
 <62294c30-ca75-4075-8d4b-3801194bd92c@linux.dev>
 <20250214132007.54dd0693@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250214132007.54dd0693@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 1:20 PM, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 22:23:39 -0800 Martin KaFai Lau wrote:
>> On 2/13/25 6:13 PM, kernel test robot wrote:
>>> [ 71.196846][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
>>> [ 71.196856][ T3759] ? __schedule (kernel/sched/core.c:5380)
>>> [ 71.196866][ T3759] __mutex_lock (kernel/locking/mutex.c:587 kernel/locking/mutex.c:730)
>>> [ 71.196872][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
>>> [ 71.196878][ T3759] ? rcu_read_unlock (include/linux/rcupdate.h:335)
>>> [ 71.196885][ T3759] ? mark_held_locks (kernel/locking/lockdep.c:4323)
>>> [ 71.196889][ T3759] ? lock_sock_nested (net/core/sock.c:3653)
>>> [ 71.196898][ T3759] mutex_lock_nested (kernel/locking/mutex.c:783)
>>
>> This is probably because __tcp_set_ulp is now under the rcu_read_lock() in patch 1.
>>
>> Even fixing patch 1 will not be enough. The bpf cgrp prog (e.g. sockops) cannot
>> sleep now, so it still cannot call bpf_setsockopt(TCP_ULP, "tls") which will
>> take a mutex. This is a blocker :(
> 
> Oh, kbuild bot was nice enough to CC netdev, it wasn't CCed on
> the submission.

Ah. I also didn't notice netdev was not cc-ed. will pay attention in the future.

> 
> I'd really rather we didn't allow setting ULP from BPF unless there
> is a strong and clear use case. The ULP configuration and stacking
> is a source of many bugs. And the use case here AFAIU is to allow
> attaching some ULP from an OOT module to a socket, which I think
> won't make core BPF folks happy either, right?

If the in-tree ulp does not work, there is little reason to do it for the 
out-of-tree module only.

My question on the ulp use case went to silence in v1, so we can assume it is 
out-of-tree ulp only. I also asked to replace the "smc" ulp testing with a more 
real "tls" ulp testing to see how it goes first. It does not work as the bot 
reported it.


