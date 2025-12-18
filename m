Return-Path: <bpf+bounces-77026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFAFCCD2B9
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 487723007FFB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA13161BB;
	Thu, 18 Dec 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vvNLXsLz"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8902F5308
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082396; cv=none; b=WfqmOQz0s0wRZBpeyqS5MEbFfKwdk4hSy5Az70n66/M9mEnJBmdLQtkmsxXV2bZ3ANQH1Xnh5uXyXBotXC1jiBqYPMRpSRhmWd6zEWO93YQU7hrcleSrf4e0hLPDm5kmFUpeCheTNfiKkinX6K7Ww/6B7W4b+wCDAhTsN3j0Okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082396; c=relaxed/simple;
	bh=UlE6+2Fa1x3o29PxLnPTQxa9DHSswPvD388GUb1fLDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoxUEgnIvVa9Yd+uUNLxJPUqW7bNnqgBPnL1EbrVsJrNr/SwyuElohPi1Q9hdaFZniMg6Mxof1uEtnxWpur30sFtVG4RzExYdUvccLXA/p6b7WCCdiZmVA/oIY5M40mWz9nqwgzBvJhxsWKrwF4Cg5bmJZjo/QQ3dVsFdLt+lfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vvNLXsLz; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0a58c79-eb85-41d2-bc17-7b507f57155a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766082382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk9zkrxndUi94GHHgKkt7+7sXifVn66L0kR3rsGhGxk=;
	b=vvNLXsLzcyxdXKcK4fHDYW0LPdn0Ie9CzTA4+3lHZGCParHllUcCY6XaM5knaTqUbj7VnF
	c3HRt992DN05dvyU3LaOVqe7NTgZVsUwVy4rHsWk4ZRbIdd7FbB8wPSqxXe/lewMkgjDxy
	jLq1uSuSgz4KjB8tE04p12SjyGLifnc=
Date: Thu, 18 Dec 2025 10:26:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf: xdp: unhandled error in xdp_test_run_init_page() leads to
 crash
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "dzm91@hust.edu.cn" <dzm91@hust.edu.cn>, M202472210@hust.edu.cn,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,
 hust-os-kernel-patches@googlegroups.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Yinhao Hu <dddddd@hust.edu.cn>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/18/25 2:43 AM, Yinhao Hu wrote:
> Our fuzzer tool discovered a user-memory-access vulnerability in the BPF
> subsystem. The vulnerability is triggered when building an `sk_buff`
> from an XDP frame that has not been properly initialized due to an
> unhandled initialization failure, causing the kernel to access an
> invalid memory address.
> 
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Root Cause
> 
> `xdp_test_run_setup()` attempts to create a `page_pool` with the page
> initialization callback `xdp_test_run_init_page()`.
> 
> During page initialization, `xdp_test_run_init_page()` calls
> `xdp_update_frame_from_buff()` to initialize an `xdp_frame`. However, if
> the available headroom in the associated `xdp_buff` is insufficient,
> `xdp_update_frame_from_buff()` returns an error. This error is not
> handled by `xdp_test_run_init_page()`, leaving the `xdp_frame`
> uninitialized.
> 
> Later, `xdp_test_run_batch()` retrieves this `xdp_frame` from the
> `page_pool`. Although it may attempt to partially reinitialize the frame
> via `reset_ctx()`, the failure from `xdp_update_frame_from_buff()` is
> still ignored.
> 
> Finally, `__xdp_build_skb_from_frame()` attempts to construct an
> `sk_buff` from the uninitialized `xdp_frame`. It reads uninitialized
> members (e.g., `data`, `headroom`, `frame_sz`) to compute a `hard_start`
> address, which is then passed to `build_skb_around()`. The underlying
> `__build_skb_around()` attempts to write to this invalid address,
> resulting in a kernel crash.
> 
> ## Execution Flow Visualization
> 
> ```
> Vulnerability Execution Flow
> |
> |--- 1. An XDP program is loaded with act XDP_PASS
> |
> |--- 2. `bpf(BPF_PROG_TEST_RUN, ...)` Syscall Execution
> |    |
> |    `-- bpf_test_run_xdp_live
> |        |
> |        `-- xdp_test_run_setup
> |        |   |
> |        |   `--> page_pool_create() with init callback
> xdp_test_run_init_page()
> |        |         |
> |        |         `--> xdp_update_frame_from_buff() may fail, but error
> is ignored, leaving xdp_frame uninitialized
> |        |
> |        `-- xdp_test_run_batch
> |             |
> |             |--> page_pool_dev_alloc_pages() returns page with
> uninitialized xdp_frame
> |             |
> |             `--> xdp_recv_frames
> |                   |
> |                   |--> __xdp_build_skb_from_frame() reads
> uninitialized xdpf members, computes invalid hard_start address, passes
> it to build_skb_around()
> |                   |
> |                   `--> __build_skb_around() writes to invalid address
> -> CRASH
> ```
> 

This looks a legit issue. Toke, please help to take a look.


