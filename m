Return-Path: <bpf+bounces-76087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C319ECA519A
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 20:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77EA1306EE9B
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526634AAED;
	Thu,  4 Dec 2025 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XjxC7aFT"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34534AB0B
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875777; cv=none; b=avcNi87FvG2s/tUl9iviocC3NpDSHdmqOURgxalcwUPHzJTcUM0mqxvqgq/a56Urv+RJrW5KfUVTdnG5IlKA7fEC4AmZpegRmddzfZpB0fyj0PN4+70qor+pY+VBJKw3VKfcS/bCQWsqeHj4+9ySlmHmqKZmFeJIoXdsyWQ2r+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875777; c=relaxed/simple;
	bh=8QqMHn395gjILbfWZLrNtsZLdkM7F9T77/AVK16lBwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAJQDJTdpckFvrEwJ2wZGo7+uIqk7WvJgoSuOQQxqsJHmWHeBOS4eW5xOjq0zWy01tMkS32keb+uvgmp97XGHgJb5mEOlsbUTQG+hRqwTJjRi2znroBYKDD5r+M/qNal+mCRlrSK79H8YvzMPMHfjpQHuvlWf72h5R/ZOjfCk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XjxC7aFT; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <33750d4d-a451-40e7-8642-5c3a3b5e001c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764875759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SqJVsgPXrE/NXdzxz+yXxv/Ri3/90MygDa9S80ailo=;
	b=XjxC7aFTKVRuJs3xK3Z9gC7JLLz5BTXTMVmtPqWIrNqmdS0qcT38hAe36UfBOt/Kk5fUw0
	oR4i9yoe0ntvSyJZkw7RBLaHk+M5jCZZIPCpqIyhQWpo2bbfl7H4XqN9YWyeZ2hdSDFneo
	PqXOJPwf5Al2tRTZek9gPZ5yF1nqO0Y=
Date: Thu, 4 Dec 2025 11:15:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] net: smc: SMC_HS_CTRL_BPF should depend on BPF_JIT
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1764843951.git.geert@linux-m68k.org>
 <988c61e5fea280872d81b3640f1f34d0619cfbbf.1764843951.git.geert@linux-m68k.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <988c61e5fea280872d81b3640f1f34d0619cfbbf.1764843951.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/4/25 2:29 AM, Geert Uytterhoeven wrote:
> If CONFIG_BPF_SYSCALL=y, but CONFIG_BPF_JIT=n:
> 
>      net/smc/smc_hs_bpf.c: In function ‘bpf_smc_hs_ctrl_init’:
>      include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=unused-value]
>       2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
> 	  |                                                  ^~~~~~~~~~~~~~~~
>      net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro ‘register_bpf_struct_ops’
>        139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
> 	  |                ^~~~~~~~~~~~~~~~~~~~~~~
> 
> While this compile error is caused by a bug in <linux/bpf.h>, none of
> the code in net/smc/smc_hs_bpf.c becomes effective if CONFIG_BPF_JIT is
> not enabled.  Hence add a dependency on BPF_JIT.
> 
> While at it, add the missing newline at the end of the file.
> 
> Fixes: 15f295f55656658e ("net/smc: bpf: Introduce generic hook for handshake flow")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   net/smc/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> index 325addf83cc69f6c..277ef504bc26ef89 100644
> --- a/net/smc/Kconfig
> +++ b/net/smc/Kconfig
> @@ -22,10 +22,10 @@ config SMC_DIAG
>   
>   config SMC_HS_CTRL_BPF
>   	bool "Generic eBPF hook for SMC handshake flow"
> -	depends on SMC && BPF_SYSCALL
> +	depends on SMC && BPF_JIT && BPF_SYSCALL
>   	default y
>   	help
>   	  SMC_HS_CTRL_BPF enables support to register generic eBPF hook for SMC
>   	  handshake flow, which offer much greater flexibility in modifying the behavior
>   	  of the SMC protocol stack compared to a complete kernel-based approach. Select
> -	  this option if you want filtring the handshake process via eBPF programs.
> \ No newline at end of file
> +	  this option if you want filtring the handshake process via eBPF programs.

I have applied patch 2 to the bpf tree. Thanks.


