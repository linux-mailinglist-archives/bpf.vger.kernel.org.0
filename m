Return-Path: <bpf+bounces-51109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A6A303F9
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8F93A704E
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 06:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437341E9B2C;
	Tue, 11 Feb 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tt20c1bA"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD71D5147
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739256954; cv=none; b=omeglVpgJuDA2vg2SZlLH3U/iyL4hLZZle1zALFUfpAWcxrpMCJE1LQalvVqndHEHquuhvyHeiOfxWW/ckOKDDEj2QdL5n2m9N+bHAapmCSjjA2l/Y/xJMwP99hKIugkpJM6qpI3f+QgtAETsHWM3SlIofHzq0hlizLzinRcEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739256954; c=relaxed/simple;
	bh=U1/HE/+P4Vke9jaDcFO9AO8Ucrw1SSc9S8TqGyaAJm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeOwBzK3jlUS264UeKEY8MUWEIhjW/m2yECG91bCHbeX1tIUa+ibhMtANpNS6R+OSHKY3Ws1F/897eOfZjlsnIExY4lG1sFzADxjppoBifj+4JZxVhd2Agnp4RZketyyQbyHAy2l2F2uvY1IDZbX8WL/DPUBvZTUwsXRrUJc2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tt20c1bA; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <787db122-d9d3-4ceb-b8c8-36ed9590b49b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739256951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBmmjMNTTInn3bPIxx/t3FfX1VhkeNHK4TKQlUwysUY=;
	b=tt20c1bAysXWMq1CJ5AxOR4b6R3hT4Vmp7a9+KTi31+L5nLr9WiKdaW0Hwfl3XDdPaU21e
	l8dIupl6cDEQnLeMfFuxyqW7QL9ff4bZyfPsHIno/lxWWJDu1fudDjUtPLpCCOasP4duCa
	r4LZAJXBliJnqmmZFOIoN6PVlHZo6Gk=
Date: Mon, 10 Feb 2025 22:55:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 04/12] bpf: stop calling some sock_op BPF
 CALLs in new timestamping callbacks
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-5-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250208103220.72294-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/25 2:32 AM, Jason Xing wrote:
> Considering the potential invalid access issues, calling
> bpf_sock_ops_setsockopt/getsockopt, bpf_sock_ops_cb_flags_set,
> and the bpf_sock_ops_load_hdr_opt in the new timestamping
> callbacks will return -EOPNOTSUPP error value.

The "why" part is mostly missing. Why they are not safe to be used in the TX 
timestamping callbacks?

> 
> It also prevents the UDP socket trying to access TCP fields in
> the bpf extension for SO_TIMESTAMPING for the same consideration.
Let's remove this UDP part to avoid confusion. UDP has very little to do with 
disabling the helpers here.

"BPF_CALL" in the subject is not clear either. "BPF_CALL" can mean many things, 
such as calling BPF helpers, calling BPF kfuncs, or calling its own BPF 
subprograms, etc. In this case, it is the calling BPF helpers.

(Subject)
bpf: Disable unsafe helpers in TX timestamping callbacks

(Why)
New TX timestamping sock_ops callbacks will be added in the subsequent patch. 
Some of the existing BPF helpers will not be safe to be used in the TX 
timestamping callbacks.

The bpf_sock_ops_setsockopt, bpf_sock_ops_getsockopt, and 
bpf_sock_ops_cb_flags_set require owning the sock lock. TX timestamping 
callbacks will not own the lock.

The bpf_sock_ops_load_hdr_opt needs the skb->data pointing to the TCP header. 
This will not be true in the TX timestamping callbacks.

(What and How)
At the beginning of these helpers, this patch checks the bpf_sock->op to ensure 
these helpers are used by the existing sock_ops callbacks only.


