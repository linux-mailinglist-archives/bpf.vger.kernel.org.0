Return-Path: <bpf+bounces-28128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97FF8B5FB0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C73B2274A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBD286642;
	Mon, 29 Apr 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s6vU/A9j"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB483CBA
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410526; cv=none; b=JnWALDiGf2JsRI3wKq1CQHxHiK2OY7WgQUxq34kMcAayf++7de4mGtxOYyrum3JAVOu6j/kkZ3+xZVwg4SmMOvYyEt25s7hVpFHbwo3OQc1O9e+c65+YGdO/04knCSngTuBzoWrFp+Fsk97VRvqup2hEG/+BkHgfO/Fx7DtXf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410526; c=relaxed/simple;
	bh=pBoJ+Gll31Xj9j3GHNALM0gtOApoA2F/MU0V1C2N6aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTzLoy7z8wdchHtc/2z8nDB92TVvArzfI2OF+3/PrpML/ic1e3T86r8y2jKIR65XT9Zoqfu7vlba5Es5BBC/wjxrfeAYU2Tskzth0PAcIr7pvBbs8kaGfqW9KoGAKVPzGcbLx5FqFLDf34flsJtMyQX4hl1q6S1iNZ8JMnnIpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s6vU/A9j; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c155a66-34be-4789-8036-484ec01891ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714410521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBoJ+Gll31Xj9j3GHNALM0gtOApoA2F/MU0V1C2N6aI=;
	b=s6vU/A9jYClpsp4VFTW2ogPS6JgjXbPf1ETP5oFavTYvz0CpTIaVY26QfuHl5BsvTYoe1P
	zOUMuN33FfqOfjz4KGNQ5Auilr5XmKC98IdIliuAWZnuORR7L9moXhqcvtx/8mhHCoqw9L
	Fj1hOKPqGekmZqmLWwKvF6rkc3cyWN8=
Date: Mon, 29 Apr 2024 10:08:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] bpf: Use struct_size()
Content-Language: en-GB
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20240429121323.3818497-1-andriy.shevchenko@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240429121323.3818497-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/29/24 5:13 AM, Andy Shevchenko wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


