Return-Path: <bpf+bounces-15765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD97F65CE
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 18:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAB6B20F90
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD898495DE;
	Thu, 23 Nov 2023 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oEnXBxnC"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9000211F
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 09:55:20 -0800 (PST)
Message-ID: <e66bc493-1b75-4fef-bc1f-dc6b30936133@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700762118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKLluB87sKF0SuNDbBGBGXDgAqWJRwLMJk94B+anxlg=;
	b=oEnXBxnCjmHxHnhOUL+347qAL7zu9jZDlnvyV493R7WpRZRdRu3kqbijM0l3JCmC5BPoRq
	35OsZwcLj4gCcHgLBWYQTmIyZUy2u2QuON9Wt1UB//QqP/Cp1gcw4zXnsHne8rN+zCpD9b
	6KFBdvlDkhbggglEmeLoLd6uSfGSJiI=
Date: Thu, 23 Nov 2023 09:55:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: sockmap, af_unix stream sockets need to
 hold ref for pair sock
Content-Language: en-GB
To: John Fastabend <john.fastabend@gmail.com>, martin.lau@kernel.org,
 jakub@cloudflare.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20231122192452.335312-1-john.fastabend@gmail.com>
 <20231122192452.335312-2-john.fastabend@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231122192452.335312-2-john.fastabend@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/22/23 2:24 PM, John Fastabend wrote:
> AF_UNIX stream sockets are a paired socket. So sending on one of the pairs
> will lookup the paired socket as part of the send operation. It is possible
> however to put just one of the pairs in a BPF map. This currently
> increments the refcnt on the sock in the sockmap to ensure it is not
> free'd by the stack before sockmap cleans up its state and stops any
> skbs being sent/recv'd to that socket.
>
> But we missed a case. If the peer socket is closed it will be
> free'd by the stack. However, the paired socket can still be
> referenced from BPF sockmap side because we hold a reference
> there. Then if we are sending traffic through BPF sockmap to
> that socket it will try to dereference the free'd pair in its
> send logic creating a use after free.  And following splat,
>
>     [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
>     [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
>     [...]
>     [59.905468] Call Trace:
>     [59.905787]  <TASK>
>     [59.906066]  dump_stack_lvl+0x130/0x1d0
>     [59.908877]  print_report+0x16f/0x740
>     [59.910629]  kasan_report+0x118/0x160
>     [59.912576]  sk_wake_async+0x31/0x1b0
>     [59.913554]  sock_def_readable+0x156/0x2a0
>     [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
>     [59.916398]  sock_sendmsg+0x20e/0x250
>     [59.916854]  skb_send_sock+0x236/0xac0
>     [59.920527]  sk_psock_backlog+0x287/0xaa0
>
> To fix let BPF sockmap hold a refcnt on both the socket in the
> sockmap and its paired socket.  It wasn't obvious how to contain
> the fix to bpf_unix logic. The primarily problem with keeping this
> logic in bpf_unix was: In the sock close() we could handle the
> deref by having a close handler. But, when we are destroying the
> psock through a map delete operation we wouldn't have gotten any
> signal thorugh the proto struct other than it being replaced.
> If we do the deref from the proto replace its too early because
> we need to deref the skpair after the backlog worker has been
> stopped.
>
> Given all this it seems best to just cache it at the end of the
> psock and eat 8B for the af_unix and vsock users.
>
> Notice dgram sockets are OK because they handle locking already.
>
> Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>   include/linux/skmsg.h | 1 +
>   include/net/af_unix.h | 1 +
>   net/core/skmsg.c      | 2 ++
>   net/unix/af_unix.c    | 2 --
>   net/unix/unix_bpf.c   | 5 +++++
>   5 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index c1637515a8a4..fbe628961cf8 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -106,6 +106,7 @@ struct sk_psock {
>   	struct mutex			work_mutex;
>   	struct sk_psock_work_state	work_state;
>   	struct delayed_work		work;
> +	struct sock			*skpair;
>   	struct rcu_work			rwork;
>   };
>   
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 824c258143a3..49c4640027d8 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -75,6 +75,7 @@ struct unix_sock {
>   };
>   
>   #define unix_sk(ptr) container_of_const(ptr, struct unix_sock, sk)
> +#define unix_peer(sk) (unix_sk(sk)->peer)
>   
>   #define peer_wait peer_wq.wait
>   
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 6c31eefbd777..6236164b9bce 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -826,6 +826,8 @@ static void sk_psock_destroy(struct work_struct *work)
>   
>   	if (psock->sk_redir)
>   		sock_put(psock->sk_redir);
> +	if (psock->skpair)
> +		sock_put(psock->skpair);
>   	sock_put(psock->sk);
>   	kfree(psock);
>   }
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3e8a04a13668..87dd723aacf9 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -212,8 +212,6 @@ static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
>   }
>   #endif /* CONFIG_SECURITY_NETWORK */
>   
> -#define unix_peer(sk) (unix_sk(sk)->peer)
> -
>   static inline int unix_our_peer(struct sock *sk, struct sock *osk)
>   {
>   	return unix_peer(osk) == sk;
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index 2f9d8271c6ec..7e7791029198 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -159,12 +159,17 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
>   
>   int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>   {
> +	struct sock *skpair = unix_peer(sk);

The above assignment is redundant.

> +
>   	if (restore) {
>   		sk->sk_write_space = psock->saved_write_space;
>   		sock_replace_proto(sk, psock->sk_proto);
>   		return 0;
>   	}
>   
> +	skpair = unix_peer(sk);
> +	sock_hold(skpair);
> +	psock->skpair = skpair;
>   	unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
>   	sock_replace_proto(sk, &unix_stream_bpf_prot);
>   	return 0;

