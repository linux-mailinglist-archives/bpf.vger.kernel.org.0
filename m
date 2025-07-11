Return-Path: <bpf+bounces-63068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6138BB0229A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4131580CE4
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3712EF9A3;
	Fri, 11 Jul 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD23y5be"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC312F0C4B;
	Fri, 11 Jul 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254838; cv=none; b=t25q8smOt/yJe3nExUYoEet9xF4bzG2wrPc6o/IxdDhkHWQJ4gh46afJKgoHX9m6VSTtcmq7tgBdrWVD8EZ5VxRCOYKC67xEcUOsV/kJwZYWPNA4as/b8r68WDHpykYBxg3nXEpqyDl0dE+rODbq68KN/MTXyNsmmG8AegrTYEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254838; c=relaxed/simple;
	bh=cNZFmBkOS3jQ3ZVGfw6BKPEf+R4uiKYY5R6FN9eB/As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx+4yqT4SbqQ+qCK6t75BIe92BAC7ngMwC//pvdv55RdJS9cqd65xz9pSMqZ5Ep+okpv85+McM2NNyOPsZNkAy+/S9pmmYxjSISY32nWtDnsIuBA6QX6UgTPTLisCxZPfhN3xqdAZNGqYNcDGobepDNWATfLKohJIgGVrzpMtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD23y5be; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dea2e01e4so21196505ad.1;
        Fri, 11 Jul 2025 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752254837; x=1752859637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fysRHsKzHK/c33ZLgzxKxc8ghDabYrIAdXWZiyAsxtM=;
        b=VD23y5bewiJi+x4kG02enOYV4lbr0uPnUo/tG0+HeAAZgc+Aty4xv7l1H6Pjq3WtXn
         N4IlFfEheasv4dgtQHdX8iFL8/IC7auBwmcAY9b02822PbsIxqpctg1/9qmpfbTh64sa
         tSTAoMhnKpCpQ6fVwI4X3+fbFjaBxdTi0Z7NOLQRCOk9Z3srq2+36OFXJsm+A+cQRkTh
         NLxcH+B2w7g63U8+RHiBS+w+FSstqP865c9sv0S7AkOKyN1ktnaR8cG+6Ii1TcAwgnN7
         hCj8UGYLbF0ypVWKQR/LpejDjaa+Ty6Sd/vXaWnmp6u6nX7UWd1tjyksNQaUx6EFDFTQ
         N6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254837; x=1752859637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fysRHsKzHK/c33ZLgzxKxc8ghDabYrIAdXWZiyAsxtM=;
        b=h3HrM8xrBdzR55aaCV+E0tZIoo9JInD035WytUV76KkmvOQ2S+fYbJ20ALJrEJ0TTm
         mFr7OQ9pyjRdBhpMRvWMWtMkwnB20WLiROKR4US1eIVbSO1ojyNVrT7475wei/9KtbbZ
         A+GhGQTaeUER3MUFDhWLyQEoASJ7CfRpkaY10BDEzIMXYaBvhxRMZ5jfejNFDMn1hHXG
         +rHMWgsdDivx1R0VPdEbQV7T3lNBy3ExEhyYpynPQ5DwqWc6JRasMQnif83upd2KUKMU
         Z4caif17WLL6/O7Q/AXWdOc9kZZVyi6ulc+HYI3S9UPAEC8rqTyGVWS6uegfIbO6dzEH
         BVoA==
X-Forwarded-Encrypted: i=1; AJvYcCV55bVojkjJTwSgeZ3LijC9UXrDdF97aowvuCzV47QBqHyqEHRiA+EkdKC3ujOS2epyV78=@vger.kernel.org, AJvYcCWw3cFU6KOZ7TLhgmglT5eGrikojjPUHgm+7Oe1wug6TyJJqdpJLGgCqQNcn2Zj5H6DTF+sHnzq@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhzWXaj+iNhm6VTTdAYndLmlg0I2lu58cnuC2zFrQ8bBIHlpg
	bi+uRgPM8+iuhf/ibHfN178N3CH6xJResSzU2uNjh4lb3rTyVAnybXTplhC3fg==
X-Gm-Gg: ASbGncvhowXuAianAWAE49obX4J/EcJnQ5tpmra26kxGdr74//Nqrb5NF8TKy/PqfkO
	QGoiGOnct3Kn5F8oVRt7xKZtMJlZ7KqpxnvX7DSskIwskmoxHEEFcTMcr3kPqbErHrjLiMJ3dvb
	nVq5ktybkTrR43A31mKdnMa4WnA75k/HsrstqygVFvOgRG3RV+K2yPc1JPOx+KV7PLyR9bkXmmO
	RldaVP0euAreHou+3aUHzQO768hlPYDVCrr7YM+4c9Q8PvpYgCFtMSxLQC/76OyWhx4l9KeE7mz
	bBkAqGFox1JlfPLnztrwdV5/qWVL2l213CSX3ziQ4aE6Yvuw6jccD1gA0WlTraRRFV1GyE8VgA+
	HO6k0VhowkRO7nVTCJM/unCQ=
X-Google-Smtp-Source: AGHT+IHKwdBkeVlSOSJ7iood+G7ApKNd8CNg4/1mSbiXWQN2uqvmwwHN4ToyZlZS9C8DuR4GRZWLIw==
X-Received: by 2002:a17:902:e5d1:b0:234:eb6:a35d with SMTP id d9443c01a7336-23dede7d5c5mr59048175ad.27.1752254836546;
        Fri, 11 Jul 2025 10:27:16 -0700 (PDT)
Received: from gmail.com ([98.97.39.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42853b5sm49519995ad.4.2025.07.11.10.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:27:16 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:27:11 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: vincent.whitchurch@datadoghq.comy
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] net: Add splice_read to prot
Message-ID: <20250711172711.qe2tgvwckswzgedh@gmail.com>
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
 <20250709-sockmap-splice-v3-1-b23f345a67fc@datadoghq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-sockmap-splice-v3-1-b23f345a67fc@datadoghq.com>

On 2025-07-09 14:47:57, Vincent Whitchurch via B4 Relay wrote:
> From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> 
> The TCP BPF code will need to override splice_read(), so add it to prot.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> ---
>  include/net/inet_common.h |  3 +++
>  include/net/sock.h        |  3 +++
>  net/ipv4/af_inet.c        | 13 ++++++++++++-
>  net/ipv4/tcp_ipv4.c       |  1 +
>  net/ipv6/af_inet6.c       |  2 +-
>  net/ipv6/tcp_ipv6.c       |  1 +
>  6 files changed, 21 insertions(+), 2 deletions(-)
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
> index 4c37015b7cf7..4bdebcbcca38 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1280,6 +1280,9 @@ struct proto {
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
> index 76e38092cd8a..9c521d252f66 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -868,6 +868,17 @@ void inet_splice_eof(struct socket *sock)
>  }
>  EXPORT_SYMBOL_GPL(inet_splice_eof);
>  
> +ssize_t inet_splice_read(struct socket *sock, loff_t *ppos,
> +			 struct pipe_inode_info *pipe, size_t len,
> +			 unsigned int flags)
> +{
> +	struct sock *sk = sock->sk;
> +
> +	return INDIRECT_CALL_1(sk->sk_prot->splice_read, tcp_splice_read, sock,
> +			       ppos, pipe, len, flags);
> +}

Could we do a indirect_call_2 here?  something like this?

  INDIRECT_CALL_2(sk->sk_prot->splice_read, tcp_splice_read ...

Otherwise the series looks reasonable to me.

