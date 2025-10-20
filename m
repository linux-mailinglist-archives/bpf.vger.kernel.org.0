Return-Path: <bpf+bounces-71438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE87BF2E28
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 20:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E2C04F38FE
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631262D0267;
	Mon, 20 Oct 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+2Cawv0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC3354AF9;
	Mon, 20 Oct 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983971; cv=none; b=OtDqFQffGNrDRsABahl/4UiW+mESwE2GZTimCcObDFWsBWMFN5o2huesRCClAVr9aLKi8njQsCyZidn/AGiNX0Q8pbTDauhf7lRXesfMhasNKqLnlV0Xvwg/ZrAzS1QldeqCqP8on7VpadeV8f5aRZO7fZ7xt0qgarO6f5Exqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983971; c=relaxed/simple;
	bh=y0Js1n+RgfK1HjkfoTzTBPaRF6A+v4l7TKrJErzr800=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmO7z3qX5c2o56X7QPxENobOmrlLk8cQST/YhQY+w4Uo032JoS3XERAyYlp1wRLIsGAK3Ga9h7P5PBiRDQ5LaLMbgcwYi4XtxO2QNk1ejTiP7SF+F+jI47MqSbwtNWcfUcth1GzKQiIcyvHu+GQg6/6bJOHUJCHy9WqFSuQ7mcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+2Cawv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87AFC4CEF9;
	Mon, 20 Oct 2025 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983971;
	bh=y0Js1n+RgfK1HjkfoTzTBPaRF6A+v4l7TKrJErzr800=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+2Cawv0umyhAffaYYVfXUJJM5t1M+iOY9ueur0EeCXfyIGF3yf5cRIdw9jSkGfhm
	 6iIEBIZUZp4JxvpUGgt8nVRAif+2/kdPwr+DSZexcoHqdy4EB2EUsaBHeGSf2E8XZ/
	 dlp52QE02+D1077gJ//5NchMos+v65imNpwKd2ALyJXeapLozipBpJ9YcYDGTStteP
	 9y1uI26C36tDU4hJFP8yZM+tla5GfLeLUNO4rORYQZbGh2cMdKs0QJm3xfPIYDgESN
	 YAYyf5ptPN4setS8+NMbXCxfXJCIYjorRN+cxBHPlYVBRb1vO7RSa87XvOW3QinTKN
	 DZ6UoIVrsV0bA==
Date: Mon, 20 Oct 2025 11:12:51 -0700
From: Kees Cook <kees@kernel.org>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <202510201112.3BC3BFF@keescook>
References: <20251014223349.it.173-kees@kernel.org>
 <20251014224334.2344521-3-kees@kernel.org>
 <aO-QV3kSxaYMaZqc@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO-QV3kSxaYMaZqc@horms.kernel.org>

On Wed, Oct 15, 2025 at 01:15:19PM +0100, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 03:43:25PM -0700, Kees Cook wrote:
> > Update all struct proto_ops bind() callback function prototypes from
> > "struct sockaddr *" to "struct sockaddr_unspec *" to avoid lying to the
> > compiler about object sizes. Calls into struct proto handlers gain casts
> > that will be removed in the struct proto conversion patch.
> > 
> > No binary changes expected.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> ...
> 
> > diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
> > index b99ba14f39d2..0a795901e4f2 100644
> > --- a/net/mctp/af_mctp.c
> > +++ b/net/mctp/af_mctp.c
> > @@ -49,7 +49,7 @@ static bool mctp_sockaddr_ext_is_ok(const struct sockaddr_mctp_ext *addr)
> >  	       !addr->__smctp_pad0[2];
> >  }
> >  
> > -static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
> > +static int mctp_bind(struct socket *sock, struct sockaddr_unspec *addr, int addrlen)
> >  {
> >  	struct sock *sk = sock->sk;
> >  	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
> > @@ -128,7 +128,7 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
> >  /* Used to set a specific peer prior to bind. Not used for outbound
> >   * connections (Tag Owner set) since MCTP is a datagram protocol.
> >   */
> > -static int mctp_connect(struct socket *sock, struct sockaddr *addr,
> > +static int mctp_connect(struct socket *sock, struct sockaddr_unspec *addr,
> >  			int addrlen, int flags)
> >  {
> >  	struct sock *sk = sock->sk;
> 
> Hi Kees,
> 
> The change to mctp_connect() results GCC 15.2.0 warning as follows:
> 
> net/mctp/af_mctp.c:632:27: error: initialization of 'int (*)(struct socket *, struct sockaddr *, int,  int)' from incompatible pointer type 'int (*)(struct socket *, struct sockaddr_unspec *, int,  int)' [-Wincompatible-pointer-types]
>   632 |         .connect        = mctp_connect,
>       |                           ^~~~~~~~~~~~
> 
> As I don't see other _connect functions updated in this patch,
> perhaps it is out of place here and should be dropped from this patch.

Whoops, yes. Thank you! This should be part of the "connect" proto_ops
patch. I'm not sure how it ended up in here. I will move it. :)

-Kees

-- 
Kees Cook

