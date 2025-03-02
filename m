Return-Path: <bpf+bounces-52992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA91A4B05D
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 09:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C88A18921E7
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC41D1D5CC4;
	Sun,  2 Mar 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="E10MfKsd"
X-Original-To: bpf@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA08821;
	Sun,  2 Mar 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740902712; cv=none; b=mpjQwlqZj4FKjdcafdnRnkt+ICQgizNDJSoKNLPDZZ8pLOHVIkj2IGnkhXt98X3h7sC+g0hu2y5A5k0+ZW0o4rsab/4O0k1Cuj747eCVkLpW8m2+OsjYRJjnfk6tML9H1yBQOlo+GM1be4G0wfxw6Ciu0oGNfqLWckydesRnAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740902712; c=relaxed/simple;
	bh=vFBscNvn43Eo7mNk3OWfaCZl/Sdz1fWoqWghplWw754=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQelP0vyfuWw2edhG+2mI9uJ6EVTuC44phqCgySJ6Y57SRTlO1DaJ392WJ6Qlt53tfWLcTa42pT48GO/mSwUdJoM97sj0l7hVBGst0Ud+YhZARrs9C10lwvJx3UqR6FmJsgzH7eYFugJsDUyrjpstmkMM0JSSUBv/Uw9IjOFkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=E10MfKsd; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DE+XaspNw+bjDHZpYfudWu/9Y9HlzAhVJKGj7BFTqTg=; b=E10MfKsdRt81V+gXMxNWfSiQy6
	DRBYPqsubf3IrrpiQVOuZeyMHhc4iAgIYbuQxLwZlrmSgxrppxEj823o0qxOtHgCdGTX/mIgH15UN
	lVDMCZQgnJb4b1GetQH3kB29KqnLz8eEtY7EVolM50AJg/0gd6qNyY6b9uWSA+Y0G2cJKfborPuZq
	loXlEDeAPfFhZjOSYjQnATlsNk6/kUh5nEy/uPvu8unlCr+mMcvlbU3fv2+ccG+OkKAaKap7wHi8x
	Gf8Us+90ez2a+cVcm3/FTCZh9SgBP0WFdX1FOeFXSu9p3Qas7KDzKqEvaiHVlOVKp5r/wwyy9y93H
	tZipyV0Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1toeJd-0030nD-2t;
	Sun, 02 Mar 2025 16:04:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Mar 2025 16:04:49 +0800
Date: Sun, 2 Mar 2025 16:04:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: bpf - Add MODULE_DESCRIPTION for skcipher
Message-ID: <Z8QRIcNHanNCKLsV@gondor.apana.org.au>
References: <20250217125601.3408746-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217125601.3408746-1-arnd@kernel.org>

On Mon, Feb 17, 2025 at 01:55:55PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All modules should have a description, building with extra warnings
> enabled prints this outfor the for bpf_crypto_skcipher module:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/bpf_crypto_skcipher.o
> 
> Add a description line.
> 
> Fixes: fda4f71282b2 ("bpf: crypto: add skcipher to bpf crypto")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/bpf_crypto_skcipher.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

