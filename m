Return-Path: <bpf+bounces-76230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F0ECAB872
	for <lists+bpf@lfdr.de>; Sun, 07 Dec 2025 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E813301F27C
	for <lists+bpf@lfdr.de>; Sun,  7 Dec 2025 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A02DA77D;
	Sun,  7 Dec 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dT9iEdgx"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB92D6407
	for <bpf@vger.kernel.org>; Sun,  7 Dec 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765129373; cv=none; b=PXuuDvnQmKATwFepV3QfQMm4KFcwTHvzsVh6sGqR4pfFQ5LVvkHCoL185Dst1pY0cUjM1K1hCB64AOuTl0KaStzd2MktS2GK0rja/fcY5ODq3SzkJttTVYullNq9kNnDDG5wskVeSrO1EziL7ksqFkBKCc/Uql69+Vj4QZxLYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765129373; c=relaxed/simple;
	bh=R/rqsivhRnbaf7aFRy7SKPIbXhOSFIGzuG4YB/v31Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcTf3ZLSfeJCyc/n+l6ePgV67KfsUBZ+Gq6wHnTU0nqQL83so5jxoYBVDrGKPBhNCDj+qd+0lE37HAWDBZNzI0yJrVYkEmEZAm2LrGrloAM4GdHA8nPRAesqFhsdxvvSPV38eHSa7qiw2NFlopuAZ3YSn4lT2HA9DPejF0wB/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dT9iEdgx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <327d78d8-8562-4865-a4de-9eeb4dd0ba03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765129368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/rqsivhRnbaf7aFRy7SKPIbXhOSFIGzuG4YB/v31Bo=;
	b=dT9iEdgxWXvf9mE5RWgb33gGS0H+i6BRRWPfe35C1N3xVkTWnHiWgxTfg7LFCsbrV/T5L7
	OW50ZRMjlurEnWiyOd6vVL7RwjECN2nUUt4/oxGQXZa6lfc0LneL75KGjsAGhZutjxJC/7
	AUBWVrYMM/C0Dnp4P5uJEEMtRDQ0ibA=
Date: Sun, 7 Dec 2025 09:42:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_seq_read docs for increased buffer
 size
Content-Language: en-GB
To: "T.J. Mercier" <tjmercier@google.com>, menglong.dong@linux.dev,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251207091005.2829703-1-tjmercier@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251207091005.2829703-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/7/25 1:10 AM, T.J. Mercier wrote:
> Commit af65320948b8 ("bpf: Bump iter seq size to support BTF
> representation of large data structures") increased the fixed buffer
> size from PAGE_SIZE to PAGE_SIZE << 3, but the docs for the function
> didn't get updated at the same time. Update them.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


