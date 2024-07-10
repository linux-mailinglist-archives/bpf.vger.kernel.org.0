Return-Path: <bpf+bounces-34484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72C92DC57
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 01:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1721C21F29
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2C14D2AC;
	Wed, 10 Jul 2024 23:07:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from norbury.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A077F0B;
	Wed, 10 Jul 2024 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652851; cv=none; b=K4UQiQBlAeZwjRC8XoEaeKBfI8ovYBxMTnYURwnpi28UTTRKJRKdFI/pCUqN3PsysZESr+qqXhBtqIamjfeuzREqq3zV4V6joeWP07EFKZWtDDimnTNi4XQyhYiDyYHK3RSPKYecBDipVT0WXZi3YpD2248WOLiejoL/osHjzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652851; c=relaxed/simple;
	bh=kDDaJhhmZmZ9d+vdcnUH//R8ZBzUJ5Lb2CTaE56W9mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJZ2Q1LSHC/5OQ4BCj7Wyg2svr978D/73UAQ9FVH4Ynqb6c2BFgQOkAE5XU9bU8H8FWuaP0+FvC9+FPRfwNyYBsW0st9u3H7Xmo2D53v1yhvJcl3w6oY+DDA7nQ/Srm3sj1DL6ZO2xg/66vRg8oBmCq04nnOqp79Q8t5wNy0q2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sRgOT-0014Ko-2D;
	Thu, 11 Jul 2024 09:06:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jul 2024 11:06:37 +1200
Date: Thu, 11 Jul 2024 11:06:37 +1200
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Fred Li <dracodingfly@gmail.com>, aleksander.lobakin@intel.com,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux@weissschuh.net,
	martin.lau@linux.dev, mkhalfella@purestorage.com, nbd@nbd.name,
	netdev@vger.kernel.org, pabeni@redhat.com, sashal@kernel.org,
	sdf@google.com, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH] net: linearizing skb when downgrade gso_size
Message-ID: <Zo8T/ZE+fyGaPZaE@gondor.apana.org.au>
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
 <20240708143128.49949-1-dracodingfly@gmail.com>
 <668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch>
 <Zo2auA2r/hkJWWcs@gondor.apana.org.au>
 <668dabd7e7066_1ce27f29435@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668dabd7e7066_1ce27f29435@willemb.c.googlers.com.notmuch>

On Tue, Jul 09, 2024 at 05:29:59PM -0400, Willem de Bruijn wrote:
>
> This is an unfortunate feature, but already exists.
> 
> It decreases gso_size to account for tunnel headers.

Growing the tunnel header is totally fine.  But you should not
decrease gso_size because of that.  Instead the correct course
of action is to drop the packet and generate an ICMP if it no
longer fits the MTU.

A router that resegments a TCP packet at the TCP-level (not IP)
is brain-dead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

