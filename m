Return-Path: <bpf+bounces-73376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315AC2DBF1
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48733BC17B
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA12320A22;
	Mon,  3 Nov 2025 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M4T8VlaL"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931831D73A
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195823; cv=none; b=AZ1uIyzIlAh6LraY3TeJDe9yp9W5NyiKjrWE1kEckqFlHjPpPUj+8MqRVep7tW1dR0xJBTzZYzxewKkhQ9GR2YB75zvQcZcx9D6VIaePpOt97/W2d8WyNnjqMHI24JH6zsXSA8A3WTZ+AO/+ba9+YKPASePHgOq34bAjjIu0VlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195823; c=relaxed/simple;
	bh=DRdD/oa2LBfwgdxugl2ih22opWDhm664nNc55RLi++c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNntYqXRgrVI6f+G7Z9+pC+vxIln+Rn9+il02MGTP8CO5qTovmCwduJZOyyuR16EmTlvFIA6fBCPakISjtAo2cfrtP1p1/Nb8U1y0D72/j3GOtzfmSyks7x06Tac7X0+jonEtLdBTawVdf2RjAOEiVMAnkUKAw3v/K+zSqcNB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M4T8VlaL; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <67580a99-8bfd-45f9-8ff8-90b333ca4b40@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762195816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lEQ0/FmnlXGFxxS0Cz1ESrUCbtzIeDsVwpcSc/F0Vo=;
	b=M4T8VlaL+L/67W074C6cZlQghMeWJTgkjYE0cz4ci6f2nmeZRNHjzlOLQx5CzqFmFz+dPF
	nh+9qz/oX726I3f1fJopEwJ5orgdNMhbJk7vC0y4hDM8maVnqWAXE34K+Q5m3+I+zCMTiA
	QI71s2Zjiak/WQlMuJ15l/GaWv/zcQA=
Date: Mon, 3 Nov 2025 10:50:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf: missing transport_header validation in bpf_prog_test_run_skb
 triggers WARNING
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, daniel@iogearbox.net
Cc: bpf@vger.kernel.org, dddddd@hust.edu.cn, dzm91@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com, ast@kernel.org, andrii@kernel.org
References: <521587d9.3a2f4.19a4918cc8b.Coremail.kaiyanm@hust.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <521587d9.3a2f4.19a4918cc8b.Coremail.kaiyanm@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/3/25 1:42 AM, 梅开彦 wrote:
> Our fuzzer tool discovered a missing check for `transport_header` field initialization
> in the `bpf_prog_test_run_skb` function within the Linux kernel's BPF subsystem. This
> vulnerability will lead to a WARNING issue.
> 
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Root Cause
> 
> In the `bpf_prog_test_run_skb` funtion, the `skb` created for BPF program execution
> may have uninitialized `transport_header` (remaining as the magic value ~0U).
> When the BPF program calls `bpf_skb_check_mtu` helper, it eventually reaches
> `skb_gso_validate_network_len()` which assumes `skb->transport_header` is properly
> set. The access to uninitialized transport header through `skb_transport_header()`
> triggers the WARNING.
> 
> ## Reproduction Steps
> 
> 1. **BPF Program**: Load a simple BPF program that calls `bpf_check_mtu`
>     
> 2. **Context**: Create `__sk_buff` with following fields:
>      - `skb->gso_size = 0x1`
>      - `skb->ifindex = 0x0e`
>      This would ensure the `skb_gso_validate_network_len()` funtion could be reached
> within the `bpf_skb_check_mtu` helper.
> 
> 3. **Trigger**: Execute the program via `BPF_PROG_TEST_RUN`
>     The kernel detects the uninitialized `transport_header` field in `skb_transport_header` and
> triggers WARNING.
>      
> 
> ## KASAN Report
> 
> ```
> WARNING: CPU: 0 PID: 9932 at ./include/linux/skbuff.h:3071 skb_transport_header include/linux/skbuff.h:3071 [inline]

I think it needs a skb_reset_transport_header in bpf_prog_test_run_skb().


