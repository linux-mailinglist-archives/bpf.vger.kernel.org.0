Return-Path: <bpf+bounces-71947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6961C024D7
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36AD85443EB
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FFF26FA5A;
	Thu, 23 Oct 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5UmEEzd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44326E718;
	Thu, 23 Oct 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235289; cv=none; b=bRumun6yZtMRth+c50W6yaG/zv3sw4zy7CBvmmNukrvrd6kFQYtHcSLl/AP40m9cif9Q3ZW8BCXdT293APnCJ89VZxU0KZ1eXgjv++81vv6ZKzJZPJiwOLRxVxyC4j21cG74v314jwfyIt+kJ17apSunsKKQ5eQly69ePqCjUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235289; c=relaxed/simple;
	bh=QR0xo9kwz4C5B32D+8W39liiu/5N5EbAo7By0ltQ3So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWCbiXKZzbQHsUtcbpp9sVK7Bc6Kk9JU2IeIhwWgGW6eLr/LamLSVEjCh0QuEOA8t8x2sk/vdE5eYYNTn3CBqLmo/JzGj/XMFncmd1fI4PGwJG0ue4Dt15Np0LG8Y73DI3oSSwUrnKJy7dCPHbQIWJEYGcm99SkEwtNQAIEvl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5UmEEzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CDBC4CEFD;
	Thu, 23 Oct 2025 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235289;
	bh=QR0xo9kwz4C5B32D+8W39liiu/5N5EbAo7By0ltQ3So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5UmEEzdgVMM2s3DmIzIkfVrcjFHhMCeIXoKlqvXiVAI8ZwCCQuWsvYOr371c5XPw
	 eGveeU5fB/WE/TmLBQx9GcrnCoNpGSBB8ZRyNw1PEfEeloWpcoVOFRS8J+VMveE4bJ
	 jiZj2EOxzfExM667AaeSQ2ZJOweEGywkCrdmzLK9/eCtnAFnDA6NdXaJ1dUnh+viQP
	 YaOcKd1iWUk6hUxjgeLPf/epNdnwdLVPCBsc/gXG3jPx8z1Iwi0JpOm9jfijj4VWM9
	 eabJcM7Tc4kcSIdp07X08DhOq2UFUz+QjMMQx2c8OCSve+HVp3JJa2gzruZYXandds
	 rF1Y2JB0GA7mA==
Date: Thu, 23 Oct 2025 09:01:28 -0700
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/9] net/l2tp: Add missing sa_family validation in
 pppol2tp_sockaddr_get_info
Message-ID: <202510230900.5754A094@keescook>
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-2-kees@kernel.org>
 <52c7bbac-da08-44d5-b1ec-315ce001b42a@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c7bbac-da08-44d5-b1ec-315ce001b42a@redhat.com>

On Thu, Oct 23, 2025 at 12:47:32PM +0200, Paolo Abeni wrote:
> On 10/20/25 11:26 PM, Kees Cook wrote:
> > While reviewing the struct proto_ops connect() and bind() callback
> > implementations, I noticed that there doesn't appear to be any
> > validation that AF_PPPOX sockaddr structures actually have sa_family set
> > to AF_PPPOX. The pppol2tp_sockaddr_get_info() checks only look at the
> > sizes.
> > 
> > I don't see any way that this might actually cause problems as specific
> > info fields are being populated, for which the existing size checks are
> > correct, but it stood out as a missing address family check.
> > 
> > Add the check and return -EAFNOSUPPORT on mismatch.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  net/l2tp/l2tp_ppp.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> > index 5e12e7ce17d8..b7a9c224520f 100644
> > --- a/net/l2tp/l2tp_ppp.c
> > +++ b/net/l2tp/l2tp_ppp.c
> > @@ -535,6 +535,13 @@ struct l2tp_connect_info {
> >  static int pppol2tp_sockaddr_get_info(const void *sa, int sa_len,
> >  				      struct l2tp_connect_info *info)
> >  {
> > +	const struct sockaddr_unspec *sockaddr = sa;
> > +
> > +	if (sa_len < offsetofend(struct sockaddr, sa_family))
> > +		return -EINVAL;
> > +	if (sockaddr->sa_family != AF_PPPOX)
> > +		return -EAFNOSUPPORT;
> 
> I fear we can't introduce this check, as it could break existing
> user-space application currently passing random data into sa_family but
> still able to connect successfully.

Isn't sa_family kind of the critical determining factor on how the
network stack decides to handle sockaddr stuff? I'll drop it for now,
I guess, but that's surprising to me.

-Kees

-- 
Kees Cook

