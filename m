Return-Path: <bpf+bounces-37727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04FA95A078
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D24E2859DD
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B84C199945;
	Wed, 21 Aug 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NAlGDohl"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED21D12EB
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252085; cv=none; b=XjMcaECIRQazMPlh3QHHl8ZPI0THeiDvL6SLN9NnqaQcQ6V8b22TDVuyrOOp7l/vZqjf2kA8yVafwQI7N6D4hOCftolX1qeogTpiSvU9UyLR2Gst/MdRSRj4hcTQWVvKpdDo21SZWBWfErCls/nu6i/5M64+8vQchvDjVgYz1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252085; c=relaxed/simple;
	bh=EcYPFuZhiJBj8IOqHO6Mmp6zhAT+4ELbAFDkIEqYdD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QikyUD++mHI8EgSUcg36+1Ize3uwzzQlbmcn7iQechJy3fGXvG86MfBWpqwbGwCukiju2GZwDW8CSXquQB+R8L+n+9CXmantfimud2e+qf613h6Py0VNXAdsQz1NHg5/OghoOquBbt3dUwXWtWs/U+G0R0bUa6ogkMLXXF1EdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NAlGDohl; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82ae0ebb-b56f-4a91-a5f8-65f48b4da1ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724252081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxsl7rC0lc/mAnpKwTNAaUOxixujtXxrmqKuzLZ9p68=;
	b=NAlGDohlEKd8qgY+IgqDbYBd1YQiZMXPjtqv9eBjBTQysNdIbzYOs/zZXUR6/GMSU057Dv
	i1qLf+UpMy8duU4eOgPtAIr1rnJlxbwc+p4zo/z7R2UQn7f7FklQESkJSxHlWq+tIRHUZa
	50FbSJodVGtueexA1YUoESteld2TBkQ=
Date: Wed, 21 Aug 2024 07:54:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] selftest: bpf: Remove mssind boundary check
 in test_tcp_custom_syncookie.c.
Content-Language: en-GB
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240821013425.49316-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240821013425.49316-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/20/24 6:34 PM, Kuniyuki Iwashima wrote:
> Smatch reported a possible off-by-one in tcp_validate_cookie().
>
> However, it's false positive because the possible range of mssind is
> limited from 0 to 3 by the preceding calculation.
>
>    mssind = (cookie & (3 << 6)) >> 6;
>
> Now, the verifier does not complain without the boundary check.
> Let's remove the checks.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/6ae12487-d3f1-488b-9514-af0dac96608f@stanley.mountain/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>

