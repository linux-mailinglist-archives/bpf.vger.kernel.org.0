Return-Path: <bpf+bounces-22275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A385B00A
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 01:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C441F2262D
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A123CA;
	Tue, 20 Feb 2024 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MxcQKqSj"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42515B1
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389138; cv=none; b=iAXGvHjALOAkKHAj8ImYxZa2ozuVsB5MQ3VTadwwG8J8XuAsIIej4uYnvKo/1RlLU9pkintWw16n4LUgbfLtOtTS9kmATfVWEsZBanPrATtG/X+GykOs/ikRnC1FMCwcW7hZBwXGDRZ+YXo9mJ0dxFKs+ZqZbUAe7EvR+NF+ciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389138; c=relaxed/simple;
	bh=PTGdfnTqOTyfPPmJF6P56GWTI5dGaVoiA9MU6OtfPCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WD7D+StXE5ZBHaTPX88N0JQjW5syINyN24brzHT7l/4HXh7l1iju9K/KxAj+Tfex5he531fx7xMPMFManJq5S0JuDQHjw/61s6NJAicMn8RgK9pNpKVUbwYLok+7aFivVhXMwR8UE0I8B0xuYUMFQUgSLMfihuT/u6lrBxz9VN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MxcQKqSj; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8860ed5-9bcb-41cb-8138-90e961a5da52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708389135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsmguUHau342SfbHLOVNtR9V3/JwuhZ6WhopaAOtzWw=;
	b=MxcQKqSjkY4MCjQl8EgjqTAYyWcN9mkCCxLCx3dSmF4bUvofw+PrK5SFu4MHkiOt7oYSEI
	p9VpoZBWwr8MRAN/7Hp8BEdJ9YUDxX+WXFWIK3ZS1rPx6KxBBBBwedRQ9pwJlPjPZNpy1D
	397ThPYzQLbXtBdWtijI1GQXv/kb4z8=
Date: Mon, 19 Feb 2024 16:32:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: test case for
 callback_depth states pruning logic
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, kuniyu@amazon.com
References: <20240216150334.31937-1-eddyz87@gmail.com>
 <20240216150334.31937-4-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240216150334.31937-4-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/16/24 7:03 AM, Eduard Zingerman wrote:
> The test case was minimized from mailing list discussion [0].
> It is equivalent to the following C program:
>
>      struct iter_limit_bug_ctx { __u64 a; __u64 b; __u64 c; };
>
>      static __naked void iter_limit_bug_cb(void)
>      {
>      	switch (bpf_get_prandom_u32()) {
>      	case 1:  ctx->a = 42; break;
>      	case 2:  ctx->b = 42; break;
>      	default: ctx->c = 42; break;
>      	}
>      }
>
>      int iter_limit_bug(struct __sk_buff *skb)
>      {
>      	struct iter_limit_bug_ctx ctx = { 7, 7, 7 };
>
>      	bpf_loop(2, iter_limit_bug_cb, &ctx, 0);
>      	if (ctx.a == 42 && ctx.b == 42 && ctx.c == 7)
>      	  asm volatile("r1 /= 0;":::"r1");
>      	return 0;
>      }
>
> The main idea is that each loop iteration changes one of the state
> variables in a non-deterministic manner. Hence it is premature to
> prune the states that have two iterations left comparing them to
> states with one iteration left.
> E.g. {{7,7,7}, callback_depth=0} can reach state {42,42,7},
> while {{7,7,7}, callback_depth=1} can't.
>
> [0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


