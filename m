Return-Path: <bpf+bounces-44078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED89BD95E
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 00:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5F31F23C25
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49959216450;
	Tue,  5 Nov 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a+Zo2N/C"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B81D4352
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847697; cv=none; b=pJMzAs6WH1u7kFfm6alej0V4wDYhPCjjI1op2QY4AtOkflvZmZaq3BzukHVMSs3qb5eh4PY00+zIjEOI6tLGruHkaFGEhjtX0KWxpNffe5fFlfFwzOLiDiSLnFYSv0l/Iee3LZ4Y07ztcRstPvNe6LRF0R573a9cOkbYMJo1Xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847697; c=relaxed/simple;
	bh=eW24geUt291/KVdr3GdYHvRU9FoMXlMPQM+nyoo7rqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG+6geDNwyMjOx5mBawwoLSDDOUVNPpejUP+PvXOMd0HnpwfC2AX1/OuaBeq9FuCPDaMkiPpTk4GUzXbJ1aCXnDFj/Cx0q623Au2q9p6f3FLQ5bf6lsBGTCU/5Gm/3GJ8U2gYuNY9+nhwwHN/nPYdBHzA7fFH+QZ15HjQeTv1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a+Zo2N/C; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a1c943f7-a775-48a9-9c20-4780baff9d71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730847693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HH8KCX9LJu0at8jeQ5zmEN9oFfpMBfc7nhjOJMv8Xm8=;
	b=a+Zo2N/CCHeKcR17foDukQ6ASzjPS5LqG37f1MGiKs7PyMuXRbGzhk0QfJXLzsWYtJ9cF+
	EwiuhnP4bXArR9YTLbCcju+yFgbibnwmgUzy9kEJTX8KJbAs+fiIUauFiFoeeGffEh9Ko3
	GPRdAQCdACbTdo+pa8JYs89iAeSjEds=
Date: Tue, 5 Nov 2024 15:01:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf] bpf: Add sk_is_inet and IS_ICSK check in
 tls_sw_has_ctx_tx/rx
To: zijianzhang@bytedance.com
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 stfomichev@gmail.com, netdev@vger.kernel.org
References: <20241030161855.149784-1-zijianzhang@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241030161855.149784-1-zijianzhang@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/30/24 9:18 AM, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> As the introduction of the support for vsock and unix sockets in sockmap,
> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
> vsock and af_unix sockets have vsock_sock and unix_sock instead of
> inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
> pointer and cause page fault in function tls_sw_ctx_rx.

> Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
> Fixes: e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")

Please tag the correct commit that introduced the bug. These SHAs are before the 
vsock and unix sock support was added.

pw-bot: cr


