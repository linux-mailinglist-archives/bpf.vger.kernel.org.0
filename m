Return-Path: <bpf+bounces-20315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1112883BDF2
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 10:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A508F1F2E8FC
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C673A1CA82;
	Thu, 25 Jan 2024 09:52:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CCE1CD02;
	Thu, 25 Jan 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176334; cv=none; b=t4G0eCK/5QtEKQ1pCDq7iHLytkQmeXXp7eB2VEVbcpz4Ru8joH3oah2HHSENrC3VxVvPL4c8qC7ADCP/Ew2JpBOHYvEUDOivM1Jrz1FxAvE9KN8Hv7CrH2Q3NBJQwF3po/f+B7b6+MmpVVVMUBcbvRhMtBASOayaDxaK0/0OYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176334; c=relaxed/simple;
	bh=StG+/eVbGK2/dVKyODarUOD8vIXXM+MXKHc4ky+fXlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQh1rxRr1+6Ofv1SSeDZY4KWdRxI4pFGfpv/ncEX+MGF1tENok071lOJYNINzIr7NEvuZ0R6W1jqnhltCLyuM3G+qG1Y/kNjSlUeaJ9H7jiO2E8OMa4yAjjixvQaRD1qVZEmVxzTyd2ZIWHHbIaAVDBaqWuyyexij3If5lN5v+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rSvxo-005s2C-0g; Thu, 25 Jan 2024 17:24:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 25 Jan 2024 17:24:12 +0800
Date: Thu, 25 Jan 2024 17:24:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
	Victor Stewart <v@nametag.social>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v8 2/3] bpf: crypto: add skcipher to bpf crypto
Message-ID: <ZbIovBWdpDrwFw0V@gondor.apana.org.au>
References: <20240115220803.1973440-1-vadfed@meta.com>
 <20240115220803.1973440-2-vadfed@meta.com>
 <dc3f48ee-2742-4c59-96a1-a06ffa1d7712@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3f48ee-2742-4c59-96a1-a06ffa1d7712@linux.dev>

On Wed, Jan 24, 2024 at 05:14:56PM -0800, Martin KaFai Lau wrote:
> On 1/15/24 2:08 PM, Vadim Fedorenko wrote:
> > Implement skcipher crypto in BPF crypto framework.
> > 
> > Signed-off-by: Vadim Fedorenko<vadfed@meta.com>
> > ---
> > v7 -> v8:
> > - Move bpf_crypto_skcipher.c to crypto and make it part of
> >    skcipher module. This way looks more natural and makes bpf crypto
> >    proper modular. MAINTAINERS files is adjusted to make bpf part
> >    belong to BPF maintainers.
> > v6 - v7:
> > - style issues
> > v6:
> > - introduce new file
> > ---
> >   MAINTAINERS                  |  8 ++++
> >   crypto/Makefile              |  3 ++
> >   crypto/bpf_crypto_skcipher.c | 82 ++++++++++++++++++++++++++++++++++++
> 
> The changes are mostly isolated to the new bpf_crypto_skcipher.c file
> addition to the crypto/ but still will be helpful to get an Ack from the
> crypto maintainers (Herbert?).

Looks good to me.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

