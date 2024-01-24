Return-Path: <bpf+bounces-20154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5AF839D8B
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 01:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3781F27D00
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE3A32;
	Wed, 24 Jan 2024 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rCBv13ot"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB09EC5
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055187; cv=none; b=AC2Qj3zYSymz+QipvPk176cIp+DDgvVNwdc/AIU/o75GZwP/LW6VrgmxBftLdpCGMZTc7d4U+bivlZfDur2aDz9u1MM7++V9h5MgS5ajXYR6D6mzAFKcKwDgk0UfWomff/9ZD9nSDE74+mz33+8Ifg9mzu+lPYlP5JXHumbosGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055187; c=relaxed/simple;
	bh=uwVSjsvlbhuMnsKVH4UGJGHpdO8kjjkWtArFvCLXA9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c57FeifOuN48G565+NMSqzmud2W1HebvZnpCIPNKVWVEolxM63jgVUqyAdnL+nw1KedKGQKqmdHMFGNjkX84ari74DJY5fp+mxdV4xHKMC+YJpO8b5jNviv1ZpPiTKeaN9RXHu1eXqwMkueP99lMHPyVwBAEMAbODkJObWPXIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rCBv13ot; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a0dc098-9b21-4f0b-96a4-de2f55bc8147@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706055181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uwVSjsvlbhuMnsKVH4UGJGHpdO8kjjkWtArFvCLXA9Y=;
	b=rCBv13otE4UjPoXNyLTYU5RvKOY20gcBeXUdSewh+2tU/gHxpxHuLW/GUMsMv9lx67OBKC
	IzmsqTzZyaeorylyX8eIY/Y3hbQz4sOGcwkzVooK/ibQaH3uVi1fGplBC1qKmtALrk9H1m
	VwxfjhOdnKz1QODqoUCMf+4bUxOXzR4=
Date: Tue, 23 Jan 2024 16:12:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/3] bpf: make common crypto API for TC/XDP
 programs
Content-Language: en-US
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, Victor Stewart <v@nametag.social>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20240115220803.1973440-1-vadfed@meta.com>
 <52e5df2c-1faf-479f-8b64-a5d0c86c82e5@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <52e5df2c-1faf-479f-8b64-a5d0c86c82e5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/23/24 9:51 AM, Vadim Fedorenko wrote:
> gentle ping here? it's more than a week with no feedback...

It is in my list. I have some backlog. will try to get to it tomorrow.

