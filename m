Return-Path: <bpf+bounces-42813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF79AB5D7
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D79284527
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F41C9DF7;
	Tue, 22 Oct 2024 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hmWLnRqa"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B31C9B7B
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620857; cv=none; b=JdFreoEomVLy14gNUa7W81X5L+TRE00O86DbQWqlLvQ7YEM3hX3Zy+M40jkbB8imhoG3VgD3hvLiApmBC12gMVVUkI4kG6uEEQk4pti5AYZXhb7Zx1yJKCzCP4zSYyQ8o8EUY2co+QyRXxJ2hx90b0nhuOuWW7+0he7HIwmkkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620857; c=relaxed/simple;
	bh=u4w8HXkqzKfsOIrMc4EK+VIMQPrTO97ibfWdvwYiz6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEkhAE4xIwswbg2/BZz6qGdOlK2k/ZocJGIJZwCAtGcgIV0vNHsHI6SAP50OhrIWMTaH2PQyu0klWt2XGT7KI6G/k4LA6uTSDZbi/XkJubqtsHHGpCznT71MOchgDjgjOcdONq2MLzne/IX6I3FgLvnzvL5WqcDEUvTGZvWTrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hmWLnRqa; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c8fb835-b0cb-428b-ab07-e20f905eb19f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729620853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igfEk9SJB5y0AGC7xhAPYYHSee2FiOr115Ym2mOgvQI=;
	b=hmWLnRqaOUiaJjkXKVx5Z6mJ/tHcnkVDIIOfW8A8knPJ5olfECcBgkqn+qsVHjUcO8Svgs
	bYDy/bPUAhvFSuKivQKVsKL1u9PPc/5dRHYtwFoD4w3av83jpAwXdFkeK6qIMsWZlLZ9G2
	earKNNEQus/1kS/t5J3a5LT8RrZdGQg=
Date: Tue, 22 Oct 2024 11:14:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN
 infoleak
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <bpf@vger.kernel.org>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
References: <20241019071149.81696-1-danielyangkang@gmail.com>
 <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev>
 <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/21/24 6:37 PM, Daniel Yang wrote:
>> A test in selftests/bpf is needed to reproduce and better understand this.
> I don't know much about self tests but I've just been using the syzbot
> repro and #syz test at the link in the patch:
> https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090. Testing
> the patch showed that the uninitialized memory was not getting written
> to memory.
> 
>> Only bpf_clone_redirect() is needed to reproduce or other bpf_skb_*() helpers calls
>> are needed to reproduce?

If only bpf_clone_redirect() is needed, it should be simple to write a selftest 
to reproduce it. It also helps to catch future regression.

Please tag the next respin as "bpf" also.

> 
>  From what I can see in the crash report here:
> https://syzkaller.appspot.com/text?tag=CrashReport&x=10ba3ca9980000,
> only bpf_clone_redirect() is needed to trigger this issue. The issue
> seems to be that bpf_try_make_head_writable clones the skb and creates
> uninitialized memory but __bpf_tx_skb() gets called and the ethernet
> header never got written, resulting in the skb having a data section
> without a proper mac header. Current check:
> 
> if (unlikely(skb->mac_header >= skb->network_header || skb->len == 0))
> {
> **drop packet**
> }
> 
> in __bpf_redirect_common() is insufficient since it only checks if the
> mac header is misordered or if the data length is 0. So, any packet
> with a malformed MAC header that is not 14 bytes but is not 0 doesn't
> get dropped. Adding bounds checks for mac header size should fix this.
> And from what I see in the syz test of this patch, it does.
> 
> Are there any possible unexpected issues that can be caused by this?


