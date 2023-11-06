Return-Path: <bpf+bounces-14288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089477E21FD
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 13:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68862814BD
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A818043;
	Mon,  6 Nov 2023 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YTjYm5Yi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEC19443
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:43:58 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D9B8
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 04:43:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso7530495a12.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 04:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699274635; x=1699879435; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+CljpizNaKMJtlhWDMYHbIGy2sGb70nOe+eKxsqv8bw=;
        b=YTjYm5YiGHtrp2mLQlGmKxNgxMBjEeiJ8B9uK2DoLA1hqSZHA6NY5X58/tcOvGtMX+
         gZCoui0cY8Dl4oHL1e0h75PCKGqzGEE17qC2rxOj9GJn9W9z7Ews2VeLb6kU35YNAf3f
         1ZDPjGzECxLpWXvbT+4lvQg0qY70Z/4RgDAf9E42TIDUw1HzVP2iYMU2aBEmsO3+BD6+
         /mr8hPLsyxYDHbQx9Y530YShg0edTad95wfNxJLHrfkJUhFJZrDyxgJksyGH0jFw7PpM
         PaOOfggrFG5qQvYTWRRV3xWQfS24kWzvctArLKGhQDyUY1dGBzVMAnBaKvKu+4RA0pW0
         lzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699274635; x=1699879435;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CljpizNaKMJtlhWDMYHbIGy2sGb70nOe+eKxsqv8bw=;
        b=wv8yp+1fp3epZ1keD2GV8bkZD6KeQfpJUd3OQnWOe2VOHM7E9Df6+HEZKKTUasu0l5
         NEoUK8+VHcMtplpK7Ni8AVVCrLJgPdVoFoipFcLm2m3KA5q+hZGve6CXLttFgFKD/Fsw
         8TrPJoSjqSyrQqGFC+6YojkygnIUweK0KT/hqPTHKvWVS8cuO6rzUFxAcf2Nv/FJc4Tp
         /99auGcpcqWQQwUZZ3F62MBjD1fZQnpWS0mcPR/tE/AN+ktRG+EQhf/ExXU0Xj5Bhp22
         G3MhqHvN2mAv/dUTJmez7cFtW6hXreLUfwKiraYe3XOSbHL0eaPDaZj0x6P3gbVMkv3Q
         VWuA==
X-Gm-Message-State: AOJu0YzTyec1UXmGtdETYc4W8Hc665kLBiyOHysAB2dfzYKM9pvyKCXm
	AlOtIm6a6yihApzfG/+t0OFvlQ==
X-Google-Smtp-Source: AGHT+IFz9uyurQv4q7IAXh5dqdf/GR0tCJGpcjx7xqFCbfmiFREIls/hhLNjm5d1J/Rbh3UTmfYzJA==
X-Received: by 2002:a05:6402:d6b:b0:541:29c8:959b with SMTP id ec43-20020a0564020d6b00b0054129c8959bmr19496699edb.39.1699274634876;
        Mon, 06 Nov 2023 04:43:54 -0800 (PST)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id u14-20020a50c04e000000b005412c0ba2f9sm4398147edd.13.2023.11.06.04.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 04:43:54 -0800 (PST)
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-2-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangyingliang@huawei.com,
 martin.lau@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref
 for pair sock
Date: Mon, 06 Nov 2023 13:35:55 +0100
In-reply-to: <20231016190819.81307-2-john.fastabend@gmail.com>
Message-ID: <87cywnjblh.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
> AF_UNIX sockets are a paired socket. So sending on one of the pairs
> will lookup the paired socket as part of the send operation. It is
> possible however to put just one of the pairs in a BPF map. This
> currently increments the refcnt on the sock in the sockmap to
> ensure it is not free'd by the stack before sockmap cleans up its
> state and stops any skbs being sent/recv'd to that socket.
>
> But we missed a case. If the peer socket is closed it will be
> free'd by the stack. However, the paired socket can still be
> referenced from BPF sockmap side because we hold a reference
> there. Then if we are sending traffic through BPF sockmap to
> that socket it will try to dereference the free'd pair in its
> send logic creating a use after free.  And following splat,
>
>    [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
>    [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
>    [...]
>    [59.905468] Call Trace:
>    [59.905787]  <TASK>
>    [59.906066]  dump_stack_lvl+0x130/0x1d0
>    [59.908877]  print_report+0x16f/0x740
>    [59.910629]  kasan_report+0x118/0x160
>    [59.912576]  sk_wake_async+0x31/0x1b0
>    [59.913554]  sock_def_readable+0x156/0x2a0
>    [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
>    [59.916398]  sock_sendmsg+0x20e/0x250
>    [59.916854]  skb_send_sock+0x236/0xac0
>    [59.920527]  sk_psock_backlog+0x287/0xaa0
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
> Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  include/linux/skmsg.h |  1 +
>  include/net/af_unix.h |  1 +
>  net/core/skmsg.c      |  2 ++
>  net/unix/af_unix.c    |  2 --
>  net/unix/unix_bpf.c   | 10 ++++++++++
>  5 files changed, 14 insertions(+), 2 deletions(-)
>

[...]

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3e8a04a13668..87dd723aacf9 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -212,8 +212,6 @@ static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
>  }
>  #endif /* CONFIG_SECURITY_NETWORK */
>  
> -#define unix_peer(sk) (unix_sk(sk)->peer)
> -
>  static inline int unix_our_peer(struct sock *sk, struct sock *osk)
>  {
>  	return unix_peer(osk) == sk;
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index 2f9d8271c6ec..705eeed10be3 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -143,6 +143,8 @@ static void unix_stream_bpf_check_needs_rebuild(struct proto *ops)
>  
>  int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  {
> +	struct sock *skpair;
> +
>  	if (sk->sk_type != SOCK_DGRAM)
>  		return -EOPNOTSUPP;
>  
> @@ -152,6 +154,9 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
>  		return 0;
>  	}
>  
> +	skpair = unix_peer(sk);
> +	sock_hold(skpair);
> +	psock->skpair = skpair;
>  	unix_dgram_bpf_check_needs_rebuild(psock->sk_proto);
>  	sock_replace_proto(sk, &unix_dgram_bpf_prot);
>  	return 0;

unix_dgram should not need this, since it grabs a ref on each sendmsg.

I'm not able to reproduce this bug for unix_dgram.

Have you seen any KASAN reports for unix_dgram from syzcaller?

> @@ -159,12 +164,17 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
>  
>  int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  {
> +	struct sock *skpair = unix_peer(sk);
> +
>  	if (restore) {
>  		sk->sk_write_space = psock->saved_write_space;
>  		sock_replace_proto(sk, psock->sk_proto);
>  		return 0;
>  	}
>  
> +	skpair = unix_peer(sk);
> +	sock_hold(skpair);
> +	psock->skpair = skpair;
>  	unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
>  	sock_replace_proto(sk, &unix_stream_bpf_prot);
>  	return 0;


