Return-Path: <bpf+bounces-70982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43367BDE6DC
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D5BB50439B
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8BE326D6D;
	Wed, 15 Oct 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE3Z9E/q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C81324B23;
	Wed, 15 Oct 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530525; cv=none; b=mK8Qkxib+qdDUF6HcpVwoi/pb5akq6dxh6ZxypahH0fiWFuWoqZnCxu8sx1yt01mMseG5vNmVB8FJy4gnXZP62Toz4ENkqARgSDtIeZWGL3pF2WQKBd82B9LVe3TOWHkJUDiKSr4yLGw73kjtLig8EVCcyHWDLCoeprMVFZL01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530525; c=relaxed/simple;
	bh=YPswrlQwwLu8FYXnYOzGnvarrdjVr/9DyXQlG/aeEh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtnuoUDViVZVJQyKDgNoz1B6/rEvhrUibQWntBQ/etNehct7W32Df6+HriFuZiBMs41FBtccnot/O34wBNaKECHSJ6Oyo9OhNdWzy2Ca1qhBxVlmE1L4c6vy5o5my1lw7S1S7OkAy/9hLR61bfPRmvZzD8c386URwLrTc4zIGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE3Z9E/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE25C4CEF8;
	Wed, 15 Oct 2025 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530524;
	bh=YPswrlQwwLu8FYXnYOzGnvarrdjVr/9DyXQlG/aeEh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oE3Z9E/qzX4Azx46kjXyfx12jewfSNXslmQj9nf7WKVKQlvR7NMVXSvyKUsQc51lA
	 tpsB+kkpzKorbFD+Vbk8ZrsxBBtKalcAaMMEBBcaQSSJFZWeTe+AkgzXT5JOZUsLo1
	 bzdQQNvU7vDjXDP9Loq0vuTiG0L9MzzRARU1evidnlmXa5nlDyODZN6IGCEOwf8C5J
	 bk2FjEpmEuhOJKdybL8wrafqIXtLlxTHlBl4ej2OvfLAghdDrmqhoWoJDKBmUTiMRO
	 BzCi1zyAnIl9iFlpoj4TPiLmD2tOV3bBe7Ln3il8OZM2tq6bS5OEiuHK4GbqjRbkCM
	 HtIZQNUJL3X4w==
Date: Wed, 15 Oct 2025 13:15:19 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 03/10] net: Convert proto_ops bind() callbacks to use
 sockaddr_unspec
Message-ID: <aO-QV3kSxaYMaZqc@horms.kernel.org>
References: <20251014223349.it.173-kees@kernel.org>
 <20251014224334.2344521-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014224334.2344521-3-kees@kernel.org>

On Tue, Oct 14, 2025 at 03:43:25PM -0700, Kees Cook wrote:
> Update all struct proto_ops bind() callback function prototypes from
> "struct sockaddr *" to "struct sockaddr_unspec *" to avoid lying to the
> compiler about object sizes. Calls into struct proto handlers gain casts
> that will be removed in the struct proto conversion patch.
> 
> No binary changes expected.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

...

> diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
> index b99ba14f39d2..0a795901e4f2 100644
> --- a/net/mctp/af_mctp.c
> +++ b/net/mctp/af_mctp.c
> @@ -49,7 +49,7 @@ static bool mctp_sockaddr_ext_is_ok(const struct sockaddr_mctp_ext *addr)
>  	       !addr->__smctp_pad0[2];
>  }
>  
> -static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
> +static int mctp_bind(struct socket *sock, struct sockaddr_unspec *addr, int addrlen)
>  {
>  	struct sock *sk = sock->sk;
>  	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
> @@ -128,7 +128,7 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
>  /* Used to set a specific peer prior to bind. Not used for outbound
>   * connections (Tag Owner set) since MCTP is a datagram protocol.
>   */
> -static int mctp_connect(struct socket *sock, struct sockaddr *addr,
> +static int mctp_connect(struct socket *sock, struct sockaddr_unspec *addr,
>  			int addrlen, int flags)
>  {
>  	struct sock *sk = sock->sk;

Hi Kees,

The change to mctp_connect() results GCC 15.2.0 warning as follows:

net/mctp/af_mctp.c:632:27: error: initialization of 'int (*)(struct socket *, struct sockaddr *, int,  int)' from incompatible pointer type 'int (*)(struct socket *, struct sockaddr_unspec *, int,  int)' [-Wincompatible-pointer-types]
  632 |         .connect        = mctp_connect,
      |                           ^~~~~~~~~~~~

As I don't see other _connect functions updated in this patch,
perhaps it is out of place here and should be dropped from this patch.

...

-- 
pw-bot: cr

