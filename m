Return-Path: <bpf+bounces-34282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFA92C45E
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3081F23656
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D241D1509BE;
	Tue,  9 Jul 2024 20:17:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from norbury.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9012F38B;
	Tue,  9 Jul 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556260; cv=none; b=rp7kQPDV69II785x0wzgmYcbDzbkMYmmBi3Mq98+CAa8yB5vqkcl/NPVjKnJB1n0Zy8Cb59phR/4nzN7S3eF+/gmDn2JOMzda2hoh8pwwLwFByzaD1b+knmOViRK+OkngVIodDZseIRzU4LVqrc1nTy6oNpWyxxYhfWHbt4OOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556260; c=relaxed/simple;
	bh=aDXYKdOsbYa9NVvVc/Y3413Jmz6BQ9Zvegm4KpVhp0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTKPPesBCEXUl02Xtlk4UlhsPLwu3mOe7XnhBzBctdQds4CITp67IFcRwuU906s+8Dvw42DqKRyx0KwC5cAJUmhcVkj5hJ7nG5Jhhn1CbvcmaE9N6scs5U1B38C0jdr+4QwIl+ViL5ItWZvFFkDrU9mq2qCZRQegI9huMtSDm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sRHGi-000cOG-1j;
	Wed, 10 Jul 2024 06:16:57 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jul 2024 08:16:56 +1200
Date: Wed, 10 Jul 2024 08:16:56 +1200
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
Message-ID: <Zo2auA2r/hkJWWcs@gondor.apana.org.au>
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
 <20240708143128.49949-1-dracodingfly@gmail.com>
 <668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch>

On Tue, Jul 09, 2024 at 11:53:21AM -0400, Willem de Bruijn wrote:
>
> > +		/* Due to header grow, MSS needs to be downgraded.
> > +		 * There is BUG_ON When segment the frag_list with
> > +		 * head_frag true so linearize skb after downgrade
> > +		 * the MSS.
> > +		 */

This sounds completely wrong.  You should never grow the TCP header
by changing gso_size.  What is the usage-scenario for this?

Think about it, if a router forwards a TCP packet, and ends up
growing its TCP header and then splits the packet into two, then
this router is brain-dead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

