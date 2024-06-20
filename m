Return-Path: <bpf+bounces-32644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD2911574
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63F0282A7B
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D761369BB;
	Thu, 20 Jun 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D92K22+l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E23823DC;
	Thu, 20 Jun 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921569; cv=none; b=LOxGsLTA2bWeqH0uxQ8jaXMyC70I6KincpLHfOcPn/8LTeNT3yeqDNYrRF+BxEow+is19/7mOwbqTI9TfNeTY57EpBjmNN5OMFZaUxXEIDorcnx/JYlFeBORWyinJMeJSFKogdk20rKjVsDXQ0NhhULegMgBpMIZgienPnqkoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921569; c=relaxed/simple;
	bh=McFdFhFys/PJszK340ZE1UMzKFHFFTT446F3mihA0Fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5uPcufdJ9vVLWx4oqlrsxDDhVeyhS/DKa5Dhthaf3mRaVCzXdCJfvWB6+RsnTH4ZUJyvTzeM/EIEf4QlmqsJsmKmkMM5ER0ni1+klchKXd1D7t01oWZRsrXIG+IckarXeWYvJ+449XAFmqKBG1YJEIGAv4OdE//2u0uUF0h7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D92K22+l; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718921568; x=1750457568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dJth7/j4c4y/GYGXwpBRMUEd9u4X+uJ0ya7Z4iQmPfs=;
  b=D92K22+lr0N9wb4az5xmKvoZP+AlLGfeqqE1l7HOC66WjQxHeXT+/oAc
   o835pBsISkEim75X9b8mzCWo+vkDjYffq763s9tooLeg08DeNDw1In96/
   A7HuzCsrvcB2sa2PEBS/AQVmFbuDn8IzBP2J/CBV6RGKWE6O6OEsSpv9f
   o=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="98307744"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 22:12:39 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:58362]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 5bd8988a-0bff-4c7f-bcc8-35ac088a9125; Thu, 20 Jun 2024 22:12:38 +0000 (UTC)
X-Farcaster-Flow-ID: 5bd8988a-0bff-4c7f-bcc8-35ac088a9125
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 22:12:34 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 22:12:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<jakub@cloudflare.com>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
Date: Thu, 20 Jun 2024 15:12:23 -0700
Message-ID: <20240620221223.66096-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240620203009.2610301-1-mhal@rbox.co>
References: <20240620203009.2610301-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Sorry for not mentioning this before, but could you replace "net" with
"bpf" in Subject and rebase the patch on bpf.git so that we can trigger
the patchwork's CI ?

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git


From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 20 Jun 2024 22:20:05 +0200
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
> ---
>  net/unix/af_unix.c  | 30 +++++++++++++++++++++++++++++-
>  net/unix/unix_bpf.c |  3 +++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 5e695a9a609c..3a55d075f199 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2653,10 +2653,38 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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

	mutex_unlock(&u->iolock);

I think we can drop mutex here as the skb is already unlinked
and no receiver can touch it.

and the below part can be like the following not to slow down
the common case:

	if (!skb)
		return err;

> +
> +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +	if (skb) {

	if (unlikely(skb == READ_ONCE(u->oob_skb))) {


> +		bool drop = false;
> +
> +		spin_lock(&sk->sk_receive_queue.lock);
> +		if (skb == u->oob_skb) {

		if (likely(skb == u->oob_skb)) {

> +			WRITE_ONCE(u->oob_skb, NULL);
> +			drop = true;
> +		}
> +		spin_unlock(&sk->sk_receive_queue.lock);
> +
> +		if (drop) {
> +			WARN_ON_ONCE(skb_unref(skb));
> +			kfree_skb(skb);
> +			skb = NULL;
> +			err = -EAGAIN;
			return -EAGAIN;

> +		}
> +	}
> +#endif

	return recv_actor(sk, skb);

Thanks!

> +
> +	mutex_unlock(&u->iolock);
> +	return skb ? recv_actor(sk, skb) : err;
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
> 2.45.1

