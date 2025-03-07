Return-Path: <bpf+bounces-53627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA5A575C1
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 00:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875533AE4A0
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 23:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE21A21C198;
	Fri,  7 Mar 2025 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FO2imdoW"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2F19006F
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388799; cv=none; b=oLEGDs2B+zGcJk8vuaE2pfAH3JpZQ7AvxEjQJ3U3Fzr05nun7dyS4YXSBvmFnalu+SNE716SjydYLq/opHbCTrGpUv+2L4E6OEKa6DNPRMMF8M4T6ymycUYldpQr0j3NfmLIfVudHR6aK9Abv2MZMLUS8hpHbjo0kQm8OPPRMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388799; c=relaxed/simple;
	bh=Ebv2NV91OCNQXSYHHSUbT/KiUWtYgd3bIWJIY+XN1dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkZa92WQVt05NI/LkvwlvCu7Zis4JXBHCA/YyUa7L2MoYy1gw2uNfwINu1JkivW6z3JTFML4X6GXJBe1JkXKN/3pMF2UQrOVDTPiR40wanNTWPt9VpI58eGWVt8iv29flT17HlMJh9aDAmjHQj+f5OjSqwM6gmZg0fFGqwMJmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FO2imdoW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a66af5a8-1aa4-481a-b57e-b3076cc520b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741388794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7mOr/JUIgsRCP7gGAEXe5RGnSy/p32Ta5M9tneOAGg=;
	b=FO2imdoWeqFVmWGTn7eHflgNauMLIobXkc4w/YolGf9PPyEi/aOu2DlzfO8RI5fLiBdfMe
	3spCbSqgVr0UmCMi2dy8IgKX5eQZQCXh8ecXUagmf5jc0jWdKCGHHHh1D1UpSwDasbtyja
	/xbcwRR0cHo3mCjSCdVrsYM8KBCjUmk=
Date: Fri, 7 Mar 2025 15:06:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to tracing
 programs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, jolsa@kernel.org, bpf@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>
References: <20250227182830.90863-1-mahe.tardy@gmail.com>
 <96dbd7df-1fa7-4caa-a52c-372d696e0f38@linux.dev>
 <Z8WBIR72Zu5x50N9@MTARDY-M-GJC6>
 <36637c9d-b6bc-4b8c-a2fd-9800c5a7a6dc@linux.dev>
 <Z8nVRtg7XwkOHjuv@MTARDY-M-GJC6>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Z8nVRtg7XwkOHjuv@MTARDY-M-GJC6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/6/25 9:03 AM, Mahe Tardy wrote:
>>>> The immediate question is whether sock_net(sk) must be non-NULL for tracing.
>>> We discussed this offline with Daniel Borkmann and we think that it
>>> might not be the question. The get_netns_cookie(NULL) call allows us to
>>> compare against get_netns_cookie(sock) to see whether the sock's netns
>>> is equal to the init netns and thus dispatch different logic.
>> bpf_get_netns_cookie(NULL) should be fine.
>>
>> I meant to ask if sock_net(sk) may return NULL for a non NULL sk. Please check.
> Oh sorry for the confusion, I investigated with my humble kernel
> knowledge: essentially sock_net(sk) is doing sk->sk_net->net, retrieving
> the net struct representing the network namespace, to later extract the
> cookie, and thus dereference the returned pointer (here is the concern).
> The sk_net intermediary (in reality __sk_common.skc_net) is here because
> of the possibility of switching on/off network namespaces via
> CONFIG_NET_NS. It's a possible_net_t type containing (or not) the struct
> net pointer, explaining why we use write/read_pnet to no-op or return
> the global net ns.
> 
> Now by adding this helper to tracing progs, it allows to call this
> function in any function entry or function exit, but unlike kprobes,
> it's not possible to just hook at an obvious arbitrary point in the code
> where the net ns would be NULL in the sock struct. With that in mind, I
> failed to crash the kernel tracing a function (some candidates were
> inlined). I mostly grepped for sock_net_set, but I lack the knowledge to

Thanks for checking.

I took a quick look at the callers of sock_net_set. I suspect 
"fentry/sk_prot_alloc" and "lsm/sk_alloc" could have a NULL?

> guarantee that this could not happen right now or in the future. Maybe
> that would be just safer to add a check and return 0 in that case if
> that's ok? Not sure since the helper returns an 8-byte long opaque
> number which thus includes 0 as a valid value.

I assume net_cookie 0 is invalid, but then it leaks the implementation details 
of what is a valid cookie in a uapi helper

  * u64 bpf_get_netns_cookie(void *ctx)
  * ...
  *      Return
  *              A 8-byte long opaque number

Note that, the tracing program can already read most fields of the sk, including 
sk->sk_net.net->net_cookie. Therefore, what this patch aims to achieve has 
already been supported in tracing. It can also save a helper call.

The only thing that may be missing in your use case is determining the init_net. 
I don't think reading a global kernel variable has been supported yet. Not sure 
if init_net must have net_cookie 1. Otherwise, we could consider to add a kfunc 
to return &init_net, which could be used to compare with sk->sk_net.net. Having 
a pointer to &init_net might be more useful for other tracing use cases in general.

