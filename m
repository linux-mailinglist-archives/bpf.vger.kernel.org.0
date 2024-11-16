Return-Path: <bpf+bounces-45001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D804B9CFBB4
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 01:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D461F22FA3
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1998DD529;
	Sat, 16 Nov 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eqv7VY2h"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D02F2D
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717195; cv=none; b=USOIYxMCL/lPEIz1A97mlJAIhX1EPbuLWHqMoDkcNEnFzYwxwHk0ZiTjswl/lqLZh3ZcZL992eQ++5/+u12qXvdDkoVCV16svDjOb6F+faMUlmMyomSJ3ccSADiWEB6PTg+PnmEwc3RzLUs7VcolpC0e9m9F7ZbnLCSnmEsfbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717195; c=relaxed/simple;
	bh=F6fU7KlLSzUs1gveo2BCh7OFm372YDhjsxyCVNn+gQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1gPBj/EuhqBgGgDL0kVYqpgLdQQWHTQppLeEBCICMNNb1wxIaDSFAmH4rj2PjnYFW6vQHckEBs2A135+A6ZjUDqTunaqRgvXw5tW6FepX03FMAonK+W/tSctisua3hal86T+2zercQbkAXakmGwhhKMfGxPfPsRAKOfliyd3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eqv7VY2h; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb9476ac-74da-4a58-b997-14b25d3ec2a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731717186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6fU7KlLSzUs1gveo2BCh7OFm372YDhjsxyCVNn+gQw=;
	b=eqv7VY2hqwalOemrPrMnqrHOsLRx0dzdCNIWgJGlTfxdGhEbUIFRU6taalMso/HIkZsKaz
	JflZEFhlDgBvvNXxsd9DkJXRYCutgMfxGt8XtWvG+D9JCmraW74oi8BkSdzS6TAoOPwbCu
	5Pc6mO51yuHeWL2Qd6DTdYVrLTEVAwU=
Date: Fri, 15 Nov 2024 16:32:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ARC: bpf: Correct conditional check in 'check_jmp_32'
To: Shahab Vahedi <list+bpf@vahedi.org>
Cc: vadim.fedorenko@linux.dev, tarang.raval@siliconsignals.io,
 Vineet Gupta <vgupta@kernel.org>, bpf@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
References: <20241113134142.14970-1-hardevsinh.palaniya@siliconsignals.io>
 <920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.org>
 <f5f49eee8979985439408e7bd6fbd1534e91a115@vahedi.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <f5f49eee8979985439408e7bd6fbd1534e91a115@vahedi.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/15/24 07:55, Shahab Vahedi wrote:
> Hi Vineet,
>
> Could you pick up this patch [1] in your "next"?
>
> Thanks,
> Shahab
>
> [1]
> https://lore.kernel.org/bpf/920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.org/T/#t

Done. Given We are in the last week this all will land in 6.13 cycle.

-Vineet

