Return-Path: <bpf+bounces-20285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDC83B670
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 02:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC2D288013
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 01:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B301388;
	Thu, 25 Jan 2024 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ClM5r74R"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E61877
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145305; cv=none; b=M1fu7avaVLaceidKJIUOKzE/nndq+2yrgI+ZrkytTKUh8zvW22E3OQ7hV93ekYcmyK56NEpTB9DlF5/asSa0QilGKuzo/MpLasWq1VgqjN5XGz40boMq3NAAfIR+O64Ia8/HCYTqem9Kut7QCLHapJ5tK7S01FP1VF2mRodZWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145305; c=relaxed/simple;
	bh=hzyJkUTEs52IWyV61vJNQMqYELAP0A332YcLg8iSzVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aE4Y983HsYyWKYgyW396ymulw9hdkwvX0Qa+cy8ZDkNN1/3ncYte2gQHcZkzQE4Pg3zkvN0Q+G2l/UXa79nDjzXYdDzHmpOCinEutL/zByG9U+5bU03Lj70CAh3Lwv46y+APNKipGhShuH9di+ZfG3u3NbvDAuhysRVo7dr5N7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ClM5r74R; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc3f48ee-2742-4c59-96a1-a06ffa1d7712@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706145300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0PO8xO9F1SVKfgGtnyH6jE1mCiWv5MpXO5GY7Qonc4=;
	b=ClM5r74Rnn3hHVISfha17ASNWFcUEmbyQXAK+HmMELWzvLk/FbehhQtE0bj2kdwdeZ9rsA
	u8kBPcW84chxhHxSgwT8TXFLAWd2T4jkj7NTbfr4p+Y7jgZz8gLxj6XSxoJDBmuHJW1A+J
	Rh87IoaxXx85ToTGUJntb9KoxGewx2Y=
Date: Wed, 24 Jan 2024 17:14:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 2/3] bpf: crypto: add skcipher to bpf crypto
Content-Language: en-US
To: Vadim Fedorenko <vadfed@meta.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, Victor Stewart <v@nametag.social>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>
References: <20240115220803.1973440-1-vadfed@meta.com>
 <20240115220803.1973440-2-vadfed@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240115220803.1973440-2-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/24 2:08 PM, Vadim Fedorenko wrote:
> Implement skcipher crypto in BPF crypto framework.
> 
> Signed-off-by: Vadim Fedorenko<vadfed@meta.com>
> ---
> v7 -> v8:
> - Move bpf_crypto_skcipher.c to crypto and make it part of
>    skcipher module. This way looks more natural and makes bpf crypto
>    proper modular. MAINTAINERS files is adjusted to make bpf part
>    belong to BPF maintainers.
> v6 - v7:
> - style issues
> v6:
> - introduce new file
> ---
>   MAINTAINERS                  |  8 ++++
>   crypto/Makefile              |  3 ++
>   crypto/bpf_crypto_skcipher.c | 82 ++++++++++++++++++++++++++++++++++++

The changes are mostly isolated to the new bpf_crypto_skcipher.c file addition 
to the crypto/ but still will be helpful to get an Ack from the crypto 
maintainers (Herbert?).

