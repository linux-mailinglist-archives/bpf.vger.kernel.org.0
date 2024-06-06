Return-Path: <bpf+bounces-31505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78F8FF0B2
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF761F26177
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C31195998;
	Thu,  6 Jun 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ea/6DwlU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52114683;
	Thu,  6 Jun 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687911; cv=none; b=onNh5EC6BEfcgYm1/jvJpnkBBX8Dx2N1BE175dTMpxeKqGVd7bKbjl6sBXCk/l6KYc/oHzB/8Kcb973eUj3+inSBIB+GpamOQ1/7ftLgjA9+uSGegraE4SUfnarOC06grbUi6UsZ6N8AiaOammeU0iTL+iptL/v7jTm8pW/XLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687911; c=relaxed/simple;
	bh=DtanzRsthCcn3+G1Cn9fimpb6JHqO6rQCVVL4tx+BEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rY2eOKu6B++DBCGEHunrdwjLK6vVpyUzLg+dk2BPupvNFgipYb8mmNpTd/59mhEtOtFbfU1VLNxQT+NxvRPMmiisVsK3CZUtLvUIZrryZOjsryKnwMmo4TA0XUTDSq9J1QyF/MXxAdYYTTAHuubCfwdw6CVNr9VQJnrl3B6xTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ea/6DwlU; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717687909; x=1749223909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y7Y+PvGO0CQloWLoTsu6I+HdcAyeqFwEd7a0MUZvlLw=;
  b=ea/6DwlUlpn34dmzZ5AgriF5J+eUGjr+8QT9kuYKWaKRL84WlJ73SLdJ
   1GAOJYhBpFyGNd5IGyYKx7qj4ce3O881jp2OAMJxzUQgW4aOCq7XCZOkS
   Op2tQBo6h+X/G69+5AOPzZYJuuKB+s0/l3NtA09PGwZEbOWZkzSeluigp
   8=;
X-IronPort-AV: E=Sophos;i="6.08,219,1712620800"; 
   d="scan'208";a="94859207"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:31:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:2940]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.12:2525] with esmtp (Farcaster)
 id 440a231d-40e0-4ddf-bfe8-fcb3c2c616ac; Thu, 6 Jun 2024 15:31:46 +0000 (UTC)
X-Farcaster-Flow-ID: 440a231d-40e0-4ddf-bfe8-fcb3c2c616ac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 6 Jun 2024 15:31:44 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 6 Jun 2024 15:31:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
CC: <bpf@vger.kernel.org>, <jakub@cloudflare.com>, <john.fastabend@gmail.com>,
	<netdev@vger.kernel.org>, <vincent.whitchurch@datadoghq.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next 1/5] net: Add splice_read to prot
Date: Thu, 6 Jun 2024 08:31:33 -0700
Message-ID: <20240606153133.68761-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240606-sockmap-splice-v1-1-4820a2ab14b5@datadoghq.com>
References: <20240606-sockmap-splice-v1-1-4820a2ab14b5@datadoghq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Thu, 06 Jun 2024 11:27:52 +0200
> From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> 
> The TCP BPF code will need to override splice_read(), so add it to prot.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> ---
>  include/net/inet_common.h |  3 +++
>  include/net/sock.h        |  3 +++
>  net/ipv4/af_inet.c        | 18 +++++++++++++++++-
>  net/ipv4/tcp_ipv4.c       |  1 +
>  net/ipv6/af_inet6.c       |  2 +-
>  net/ipv6/tcp_ipv6.c       |  1 +
>  6 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/inet_common.h b/include/net/inet_common.h
> index c17a6585d0b0..2a6480d0d575 100644
> --- a/include/net/inet_common.h
> +++ b/include/net/inet_common.h
> @@ -35,6 +35,9 @@ void __inet_accept(struct socket *sock, struct socket *newsock,
>  		   struct sock *newsk);
>  int inet_send_prepare(struct sock *sk);
>  int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
> +ssize_t inet_splice_read(struct socket *sk, loff_t *ppos,
> +			 struct pipe_inode_info *pipe, size_t len,
> +			 unsigned int flags);
>  void inet_splice_eof(struct socket *sock);
>  int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>  		 int flags);
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 5f4d0629348f..a152552a64a5 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1238,6 +1238,9 @@ struct proto {
>  					   size_t len);
>  	int			(*recvmsg)(struct sock *sk, struct msghdr *msg,
>  					   size_t len, int flags, int *addr_len);
> +	ssize_t			(*splice_read)(struct socket *sock,  loff_t *ppos,
> +					       struct pipe_inode_info *pipe, size_t len,
> +					       unsigned int flags);
>  	void			(*splice_eof)(struct socket *sock);
>  	int			(*bind)(struct sock *sk,
>  					struct sockaddr *addr, int addr_len);
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index e03ba4a21c39..c9a23296ac82 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -870,6 +870,21 @@ void inet_splice_eof(struct socket *sock)
>  }
>  EXPORT_SYMBOL_GPL(inet_splice_eof);
>  
> +ssize_t inet_splice_read(struct socket *sock, loff_t *ppos,
> +			 struct pipe_inode_info *pipe, size_t len,
> +			 unsigned int flags)
> +{
> +	const struct proto *prot;
> +	struct sock *sk = sock->sk;
> +
> +	prot = READ_ONCE(sk->sk_prot);
> +	if (prot->splice_read)
> +		return prot->splice_read(sock, ppos, pipe, len, flags);

INDIRECT_CALL_1() (or _2() in the next patch) can be used.


> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(inet_splice_read);
> +
>  INDIRECT_CALLABLE_DECLARE(int udp_recvmsg(struct sock *, struct msghdr *,
>  					  size_t, int, int *));
>  int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
> @@ -1073,7 +1088,7 @@ const struct proto_ops inet_stream_ops = {
>  	.mmap		   = tcp_mmap,
>  #endif
>  	.splice_eof	   = inet_splice_eof,
> -	.splice_read	   = tcp_splice_read,
> +	.splice_read	   = inet_splice_read,
>  	.set_peek_off      = sk_set_peek_off,
>  	.read_sock	   = tcp_read_sock,
>  	.read_skb	   = tcp_read_skb,
> @@ -1107,6 +1122,7 @@ const struct proto_ops inet_dgram_ops = {
>  	.recvmsg	   = inet_recvmsg,
>  	.mmap		   = sock_no_mmap,
>  	.splice_eof	   = inet_splice_eof,
> +	.splice_read	   = inet_splice_read,

Does SOCK_DGRAM need this change ?  If no, inet_splice_read() can
return splice_read() directly.

