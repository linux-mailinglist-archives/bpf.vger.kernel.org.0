Return-Path: <bpf+bounces-44081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2B9BD99C
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 00:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EBF1C22989
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 23:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D41216A0B;
	Tue,  5 Nov 2024 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nfz5DoZ0"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2348215F7C
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848789; cv=none; b=mcm5le6WJPM7DU9hrAMK0PRuFZMl6RPqj6VRXuEnnDsu2Me0bXQ/gAogtlJMsIOIiLl0luMZ81P8jf5QLtGttJnVTXhPPlw3K8EtlZDs8EoMX4pXKYDTqeOS2LVgFnTTgz9snDNeta2a5gvoCfTQqPSwmnQI0pnSeP5U0IFVjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848789; c=relaxed/simple;
	bh=UvUw+nZkfgvHZSnMi5K26kkqZH/MltB2oTM9Z1ipxac=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ceCwEzDN8PiotVm9vesTs6tyGLqIPiorGZAqM+HJwyKnFeUiEZ9HGnJ9uhgluPfISKnQ6Go/Ijzb+HkjZh7zQmVlsRWmk5SOhdFx1N8Z3FuzJEV8btLWDbDcwKvFgvEVbX3DVV2qxQlb8p3jk9zk+RgE01Ax6SEkSyHO6i8L/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nfz5DoZ0; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60dee6f7-e423-4644-839e-95231beca854@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730848785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRnij9lJmJVg04bILk0ZhJO+jQ1/NVNxQUlXArvHXHE=;
	b=Nfz5DoZ0duS7M7k1j3WdMs7FT2UxPsPd9w+HdTnVrm8of9UN3ql1hKTlQZOVwzB0lRU8gq
	N1ypW2yPKjU5orpZx5JsOP+F0bIHpuXilHs56t9kV4TaWpmNrKvHO5EGX8LcFugKyu+8Wc
	LmeWnvH+zdQ2cfPLT4DPxijK53ccopk=
Date: Tue, 5 Nov 2024 15:19:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf] bpf: Add sk_is_inet and IS_ICSK check in
 tls_sw_has_ctx_tx/rx
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: zijianzhang@bytedance.com
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 stfomichev@gmail.com, netdev@vger.kernel.org
References: <20241030161855.149784-1-zijianzhang@bytedance.com>
 <a1c943f7-a775-48a9-9c20-4780baff9d71@linux.dev>
Content-Language: en-US
In-Reply-To: <a1c943f7-a775-48a9-9c20-4780baff9d71@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/5/24 3:01 PM, Martin KaFai Lau wrote:
> On 10/30/24 9:18 AM, zijianzhang@bytedance.com wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> As the introduction of the support for vsock and unix sockets in sockmap,
>> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
>> vsock and af_unix sockets have vsock_sock and unix_sock instead of
>> inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
>> pointer and cause page fault in function tls_sw_ctx_rx.
> 
>> Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
>> Fixes: e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")
> 
> Please tag the correct commit that introduced the bug. These SHAs are before the 
> vsock and unix sock support was added.

I just read the v1. Please also keep the "Acked-by: Stanislav Fomichev 
<sdf@fomichev.me>".


