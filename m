Return-Path: <bpf+bounces-58749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FEAC14C5
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914D75007AA
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 19:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00801189919;
	Thu, 22 May 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lpY0aPgv"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6E581741
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747941924; cv=none; b=evRvoDVXG2IrBjK/xMJZAlmZdpvxUHhAR5btoOOEt+0y366nd6GlQkCzEahEj/FxSE6orGRNFNKBPvUNOGdN7vRTq0hJJTZlOGzSWYtjrbf+cU9M0cAG322OpntkiiBltCR/H1mLhqHT56FK8BJsyEYZ9wRy8gxXREXV/ofA0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747941924; c=relaxed/simple;
	bh=FYTA2YGOVavSHrzNFs6r/5f2tb2plMnbO0mKPNeYSOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXXUGx5PAYQ9zR4It0OOv2uaaVl3rkUI2VVB4Uf2o9fFTeEgTp1JA+eoIkmYsSmsHE3VoO3pF3/K/OgEkhPLmvValsCJHRfY/jGxByIp5RfnkLVG8wWMGRboH9dskOfPpeyL3OevFMFpFOFm/slrir6JYjNuyU21aW/mh5h4HNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lpY0aPgv; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3eb50302-d90c-4477-b296-f5f29a7d1eca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747941916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjZ8wY76miqnH4YT71rqtvPLrVN+UZp1HnTbatuwpPM=;
	b=lpY0aPgvIDFd9ZPcgNsY1y8pPpUUptnJ8MPIYDaPDjhCMAOzLa4wlZY0g6dDIf/YyGr1oN
	/qZAi6qOivPaJk0eZinfrZQBG56+VRPGwuj5PxgwIlmI9ktbExsHuvznWwFDZ4kKpSVUQM
	OEtZV5BwK83Wc06kpk45vNpM5GCij4Y=
Date: Thu, 22 May 2025 12:25:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6] bpf, sockmap: avoid using sk_socket after
 free when sending
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Michal Luczaj <mhal@rbox.co>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250516141713.291150-1-jiayuan.chen@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250516141713.291150-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/16/25 7:17 AM, Jiayuan Chen wrote:
> The sk->sk_socket is not locked or referenced in backlog thread, and
> during the call to skb_send_sock(), there is a race condition with
> the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
> will be affected.
> 
> Race conditions:
> '''
> CPU0                               CPU1
> 
> backlog::skb_send_sock
>    sendmsg_unlocked
>      sock_sendmsg
>        sock_sendmsg_nosec
>                                     close(fd):
>                                       ...
>                                       ops->release() -> sock_map_close()
>                                       sk_socket->ops = NULL
>                                       free(socket)
>        sock->ops->sendmsg
>              ^
>              panic here
> '''
> 
> The ref of psock become 0 after sock_map_close() executed.
> '''
> void sock_map_close()
> {
>      ...
>      if (likely(psock)) {
>      ...
>      // !! here we remove psock and the ref of psock become 0
>      sock_map_remove_links(sk, psock)
>      psock = sk_psock_get(sk);
>      if (unlikely(!psock))
>          goto no_psock; <=== Control jumps here via goto
>          ...
>          cancel_delayed_work_sync(&psock->work); <=== not executed
>          sk_psock_put(sk, psock);
>          ...
> }
> '''
> 
> Based on the fact that we already wait for the workqueue to finish in
> sock_map_close() if psock is held, we simply increase the psock
> reference count to avoid race conditions.
> 
> With this patch, if the backlog thread is running, sock_map_close() will
> wait for the backlog thread to complete and cancel all pending work.
> 
> If no backlog running, any pending work that hasn't started by then will
> fail when invoked by sk_psock_get(), as the psock reference count have
> been zeroed, and sk_psock_drop() will cancel all jobs via
> cancel_delayed_work_sync().
> 
> In summary, we require synchronization to coordinate the backlog thread
> and close() thread.
> 
> The panic I catched:
> '''
> Workqueue: events sk_psock_backlog
> RIP: 0010:sock_sendmsg+0x21d/0x440
> RAX: 0000000000000000 RBX: ffffc9000521fad8 RCX: 0000000000000001
> ...
> Call Trace:
>   <TASK>
>   ? die_addr+0x40/0xa0
>   ? exc_general_protection+0x14c/0x230
>   ? asm_exc_general_protection+0x26/0x30
>   ? sock_sendmsg+0x21d/0x440
>   ? sock_sendmsg+0x3e0/0x440
>   ? __pfx_sock_sendmsg+0x10/0x10
>   __skb_send_sock+0x543/0xb70
>   sk_psock_backlog+0x247/0xb80
> ...
> '''
> 
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Fixes: 4b4647add7d3 ("sock_map: avoid race between sock_map_close and sk_psock_put")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> V5 -> V6: Use correct "Fixes" tag.
> V4 -> V5:
> This patch is extracted from my previous v4 patchset that contained
> multiple fixes, and it remains unchanged. Since this fix is relatively
> simple and easy to review, we want to separate it from other fixes to
> avoid any potential interference.
> ---
>   net/core/skmsg.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 276934673066..34c51eb1a14f 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -656,6 +656,13 @@ static void sk_psock_backlog(struct work_struct *work)
>   	bool ingress;
>   	int ret;
>   
> +	/* Increment the psock refcnt to synchronize with close(fd) path in
> +	 * sock_map_close(), ensuring we wait for backlog thread completion
> +	 * before sk_socket freed. If refcnt increment fails, it indicates
> +	 * sock_map_close() completed with sk_socket potentially already freed.
> +	 */
> +	if (!sk_psock_get(psock->sk))

This seems to be the first use case to pass "psock->sk" to "sk_psock_get()".

I could have missed the sock_map details here. Considering it is racing with 
sock_map_close() which should also do a sock_put(sk) [?],
could you help to explain what makes it safe to access the psock->sk here?

> +		return;
>   	mutex_lock(&psock->work_mutex);
>   	while ((skb = skb_peek(&psock->ingress_skb))) {
>   		len = skb->len;
> @@ -708,6 +715,7 @@ static void sk_psock_backlog(struct work_struct *work)
>   	}
>   end:
>   	mutex_unlock(&psock->work_mutex);
> +	sk_psock_put(psock->sk, psock);
>   }
>   
>   struct sk_psock *sk_psock_init(struct sock *sk, int node)


