Return-Path: <bpf+bounces-34129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A446492A9E9
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F71F22129
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633BF6F2E3;
	Mon,  8 Jul 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mcmCwwN+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751B1CD3D;
	Mon,  8 Jul 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467523; cv=none; b=GOQflek/Oxp70B0goOtkYV5q9FhsnXXz8Pwf5xNZH0o/c+3In9lww83IoO+cG6B0l2aNaOlNIlOBt1PVaBXtgNLtZ9acyV8Tj8JutOEIKtwqvxauQUl/oYLr456OsVcF9cX3nIAa2V1ROslUplUklHjDT20QyCrz7k23f5HBnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467523; c=relaxed/simple;
	bh=RTJ+hggeJZB8ODwiAXzM2+2WiLfIshV4OLijwhI7wM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeEIxogayZViPp+euwJfLmFX61llM4J3FsYhBUyo5pOy/VPXD4tGRqIVgGQTzcyl0U7VNP/Sl9Mb/mcFHAAMJzpyFFkrZZCtlYfaKvKsUnBGlUdJmZgXmMui0plOGpAoQJ2ELASmdzBRDmtQW21Qpp7Vf+JFGJyiL4MFRFU1EEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mcmCwwN+; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720467521; x=1752003521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OSsIpF/a28bJRFswEdHaZgwaYC+QevUN84+rJOAer9I=;
  b=mcmCwwN+gDlnYZv5VMUbNWkKEvda6rwds/PJoNMkoKq71T7Pd2w7CiDm
   xuBm07p6qTp0Uq+M+SirC1fArWkbwH3rP3SbWWYZYxI5MbXMCZBIBgvDZ
   u8Q7xTDpi+Zizbks9sMyo1WGiNj13ydaVtBSR/rJQYdROWkVs6h+5nTMk
   k=;
X-IronPort-AV: E=Sophos;i="6.09,192,1716249600"; 
   d="scan'208";a="103513989"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 19:38:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:29918]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.210:2525] with esmtp (Farcaster)
 id 737ceb2e-cda8-4d19-bad3-72b8653ce7bc; Mon, 8 Jul 2024 19:38:38 +0000 (UTC)
X-Farcaster-Flow-ID: 737ceb2e-cda8-4d19-bad3-72b8653ce7bc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 19:38:33 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 19:38:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <Rao.Shoaib@oracle.com>, <bpf@vger.kernel.org>, <cong.wang@bytedance.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <jakub@cloudflare.com>,
	<john.fastabend@gmail.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH bpf v3 1/4] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
Date: Mon, 8 Jul 2024 12:38:20 -0700
Message-ID: <20240708193820.3392-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240707222842.4119416-2-mhal@rbox.co>
References: <20240707222842.4119416-2-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Sun,  7 Jul 2024 23:28:22 +0200
> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
> with an `oob_skb` pointer. BPF redirecting does not account for that: when
> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
> results in a single skb that may be accessed from two different sockets.
> 
> Take the easy way out: silently drop MSG_OOB data targeting any socket that
> is in a sockmap or a sockhash. Note that such silent drop is akin to the
> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
> 
> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  net/unix/af_unix.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
>  net/unix/unix_bpf.c |  3 +++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 142f56770b77..11cb5badafb6 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2667,10 +2667,49 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  
>  static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  {
> +	struct unix_sock *u = unix_sk(sk);
> +	struct sk_buff *skb;
> +	int err;
> +
>  	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
>  		return -ENOTCONN;
>  
> -	return unix_read_skb(sk, recv_actor);
> +	mutex_lock(&u->iolock);
> +	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
> +	mutex_unlock(&u->iolock);
> +	if (!skb)
> +		return err;
> +
> +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
> +		bool drop = false;
> +
> +		unix_state_lock(sk);
> +
> +		if (sock_flag(sk, SOCK_DEAD)) {
> +			unix_state_unlock(sk);
> +			kfree_skb(skb);
> +			return -ECONNRESET;
> +		}
> +
> +		spin_lock(&sk->sk_receive_queue.lock);
> +		if (likely(skb == u->oob_skb)) {
> +			WRITE_ONCE(u->oob_skb, NULL);
> +			drop = true;
> +		}
> +		spin_unlock(&sk->sk_receive_queue.lock);
> +
> +		unix_state_unlock(sk);
> +
> +		if (drop) {
> +			WARN_ON_ONCE(skb_unref(skb));
> +			kfree_skb(skb);
> +			return -EAGAIN;
> +		}
> +	}
> +#endif
> +
> +	return recv_actor(sk, skb);
>  }
>  
>  static int unix_stream_read_generic(struct unix_stream_read_state *state,
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index bd84785bf8d6..bca2d86ba97d 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -54,6 +54,9 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  	struct sk_psock *psock;
>  	int copied;
>  
> +	if (flags & MSG_OOB)
> +		return -EOPNOTSUPP;
> +
>  	if (!len)
>  		return 0;
>  
> -- 
> 2.45.2

