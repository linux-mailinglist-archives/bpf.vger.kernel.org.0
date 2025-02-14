Return-Path: <bpf+bounces-51528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA13A35702
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322667A5E52
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC821FFC7F;
	Fri, 14 Feb 2025 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D3aQKjVG"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655D1FFC42
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514243; cv=none; b=OSopyfKKpz4oZr5gfIOcOfZKh7ULnXosX+Se+hB9q9xdacRMEdK/oM1sekRfR3EnOHq6TCxsv4iCoJrB8GzK6yolIfhNv0YNZcudFpPMiOpsO5RbrQCpxxBSLiv16nODWBlzloSGtCajZl0YmhpEDCY1HlFQY1381OtRMAVoYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514243; c=relaxed/simple;
	bh=wi38qL4hRFPiH6TC9t4UGHznNQ9DN1QZEgbMufLoo5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTvlPZXdVeWY5YSaCTc7/Pe4s4pu526+ogLt5SGwXbBnXpkYXMyWFM/VVyZh1Y1u8+V3rn/j6nXZTlO7vQQdcBPpaG3pL74oPPTsPJJxwZkUteLQcEu66WP7xBmaPQtCRbDzgLBTRCi8MFOYp/OhzDjtSudCE+unnTP6JgJ7qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D3aQKjVG; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <62294c30-ca75-4075-8d4b-3801194bd92c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739514230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLNWS0Gi46HHTQY+75W8wmzAhQ0Osq+x3p1UxBkY/XE=;
	b=D3aQKjVGAW8ksyeaLYg4dEx8r23eSbcckLQdzaUA1uR/SpFOcOWk3grlR0rhtUFXeOy+/w
	uAIfiZbT3ygvkXSVzgjcist2mxUf6At+L9V12RCK71ns31wW2P2p1+tewxHERRymynR/qO
	ouJpgg/4s/tByrv7vqK7lvyEzrlG/xU=
Date: Thu, 13 Feb 2025 22:23:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] bpf-next: Introduced to support the ULP to get or
 set sockets
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Xin Liu <liuxin350@huawei.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, mptcp@lists.linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com,
 liwei883@huawei.com, tianmuyang@huawei.com
References: <202502140959.f66e2ba6-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <202502140959.f66e2ba6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 6:13 PM, kernel test robot wrote:
> [   71.182999][ T3759] =============================
> [   71.183907][ T3759] [ BUG: Invalid wait context ]
> [   71.184819][ T3759] 6.14.0-rc1-00030-g8f510de3f26b #1 Tainted: G        W       T
> [   71.186327][ T3759] -----------------------------
> [   71.187265][ T3759] trinity-c4/3759 is trying to lock:
> [ 71.188287][ T3759] c37b35e0 (tcpv4_prot_mutex){....}-{4:4}, at: tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
> [   71.189847][ T3759] other info that might help us debug this:
> [   71.191018][ T3759] context-{5:5}
> [   71.191678][ T3759] 2 locks held by trinity-c4/3759:
> [ 71.192635][ T3759] #0: ecffcd80 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock (include/net/sock.h:1625)
> [ 71.194220][ T3759] #1: c3500498 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (include/linux/rcupdate.h:336)
> [   71.196078][ T3759] stack backtrace:
> [   71.196797][ T3759] CPU: 0 UID: 65534 PID: 3759 Comm: trinity-c4 Tainted: G        W       T  6.14.0-rc1-00030-g8f510de3f26b #1 8ad64aae41fa4cb8babad52c8f50e0a7d5e34569
> [   71.196807][ T3759] Tainted: [W]=WARN, [T]=RANDSTRUCT
> [   71.196809][ T3759] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   71.196812][ T3759] Call Trace:
> [ 71.196818][ T3759] dump_stack_lvl (lib/dump_stack.c:123)
> [ 71.196825][ T3759] dump_stack (lib/dump_stack.c:130)
> [ 71.196830][ T3759] __lock_acquire (kernel/locking/lockdep.c:4830 kernel/locking/lockdep.c:4900 kernel/locking/lockdep.c:5178)
> [ 71.196840][ T3759] lock_acquire (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853)
> [ 71.196846][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
> [ 71.196856][ T3759] ? __schedule (kernel/sched/core.c:5380)
> [ 71.196866][ T3759] __mutex_lock (kernel/locking/mutex.c:587 kernel/locking/mutex.c:730)
> [ 71.196872][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
> [ 71.196878][ T3759] ? rcu_read_unlock (include/linux/rcupdate.h:335)
> [ 71.196885][ T3759] ? mark_held_locks (kernel/locking/lockdep.c:4323)
> [ 71.196889][ T3759] ? lock_sock_nested (net/core/sock.c:3653)
> [ 71.196898][ T3759] mutex_lock_nested (kernel/locking/mutex.c:783)

This is probably because __tcp_set_ulp is now under the rcu_read_lock() in patch 1.

Even fixing patch 1 will not be enough. The bpf cgrp prog (e.g. sockops) cannot 
sleep now, so it still cannot call bpf_setsockopt(TCP_ULP, "tls") which will 
take a mutex. This is a blocker :(

> [ 71.196904][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
> [ 71.196909][ T3759] tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
> [ 71.196916][ T3759] tcp_set_ulp (net/ipv4/tcp_ulp.c:140 net/ipv4/tcp_ulp.c:166)
> [ 71.196923][ T3759] do_tcp_setsockopt (net/ipv4/tcp.c:3747)
> [ 71.196934][ T3759] tcp_setsockopt (net/ipv4/tcp.c:4032)
> [ 71.196939][ T3759] ? sock_common_recvmsg (net/core/sock.c:3833)
> [ 71.196946][ T3759] sock_common_setsockopt (net/core/sock.c:3838)
> [ 71.196952][ T3759] do_sock_setsockopt (net/socket.c:2298)
> [ 71.196961][ T3759] __sys_setsockopt (net/socket.c:2323)
> [ 71.196967][ T3759] __ia32_sys_setsockopt (net/socket.c:2326)
> [ 71.196972][ T3759] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-054-20250212/./arch/x86/include/generated/asm/syscalls_32.h:367)
> [ 71.196979][ T3759] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339)
> [ 71.196985][ T3759] entry_INT80_32 (arch/x86/entry/entry_32.S:942)

