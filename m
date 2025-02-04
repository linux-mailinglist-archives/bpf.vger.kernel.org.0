Return-Path: <bpf+bounces-50351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4265A26951
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500953A4658
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F078149DF4;
	Tue,  4 Feb 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JIsYA9bD"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0313D8B1
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631801; cv=none; b=t5TRLznIuw2/yNLCSrwVtR9uCD+bgGqHddQcNJYmrX/nLMIR88QvTc8P3f3bowAVO9JglaKVVsGebqNX2msskhx/hYsX/bh1a9FFjP8R0tuKVtuNdestTpvLFNSn5h0Kazjziy2sVEIGy8j3Yi9qAXF7CGaS4igy8JrFxAhMelo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631801; c=relaxed/simple;
	bh=EbOcrYcYNr4YhzNprx5r4lU/EYgYADP+IV5FUQYuq/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnZ7nPkNIL7vegtsh/8NwZOSpFLkFhS92TRFq4yIYNVb3fB74/qUMbzv3rFF5MPndQ5eBZ/PoDM+mKytCMy34pesn2PfSsD/B22jDhab5YSWSL501LMbmTR6orjFTtoIPLnqHgCjB6H5gTNZBtOvzVmC5PWy8SwsTZ3fm6B5OZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JIsYA9bD; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738631791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9P43Br6+E+aNNmgA7sVC2hl7wNB8r20DCMH8tSkpBJg=;
	b=JIsYA9bD7ipwO0SgwtzOBeEY53sjSfIqeqDy/Ng3f5K268NC3vlkuyDd9jbYFlQMOwGw4d
	OqhptowP5wxSU4oSnZ1SwQvcAv5cG4i8poiYQkEW9eKVpmf3/UfxE88IPkXHLgEVB1ITRO
	+u0v30zzASe99eU8vv7Qq/a2x2clWVI=
Date: Mon, 3 Feb 2025 17:16:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 11/13] net-timestamp: add a new callback in
 tcp_tx_timestamp()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-12-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
> Introduce the callback to correlate tcp_sendmsg timestamp with other
> points, like SND/SW/ACK. We can let bpf trace the beginning of
> tcp_sendmsg_locked() and fetch the socket addr, so that in

Instead of "fetch the socket addr...", should be "store the sendmsg timestamp at 
the bpf_sk_storage ...".

> tcp_tx_timestamp() we can correlate the tskey with the socket addr.


> It is accurate since they are under the protect of socket lock.
> More details can be found in the selftest.

The selftest uses the bpf_sk_storage to store the sendmsg timestamp at 
fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_timestamp (i.e. 
BPF_SOCK_OPS_TS_SND_CB added in this patch).

> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/uapi/linux/bpf.h       | 7 +++++++
>   net/ipv4/tcp.c                 | 1 +
>   tools/include/uapi/linux/bpf.h | 7 +++++++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 800122a8abe5..accb3b314fff 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7052,6 +7052,13 @@ enum {
>   					 * when SK_BPF_CB_TX_TIMESTAMPING
>   					 * feature is on.
>   					 */
> +	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
> +					 * is triggered. For TCP, it stays
> +					 * in the last send process to
> +					 * correlate with tcp_sendmsg timestamp
> +					 * with other timestamping callbacks,
> +					 * like SND/SW/ACK.

Do you have a chance to look at how this will work at UDP?


