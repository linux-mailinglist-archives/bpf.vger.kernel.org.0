Return-Path: <bpf+bounces-63922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6FEB0C685
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FAE7B149D
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF70429E11B;
	Mon, 21 Jul 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ejmzv/xb"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774691C07D9;
	Mon, 21 Jul 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108617; cv=none; b=eq88bVKJa8QBhdWa07Eul53pZD7MGud3IivZuDt9RfkCJURmnW3KGsVoV4JSdmw5Q0RooPH29Y7JmJmowCbn+VvA2L3FFQTlZFFx9iZFfJiLcl4awqa3t41QNwLDvTM6uYL+qkq5q7hnyZBaSVJK/G+9VCZ5kE1q16ef0nHt52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108617; c=relaxed/simple;
	bh=Cuo1H/j6PyYGZhqnOc7J+ZKmt4K5j3OPO3gVDNfi8Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlTtZ7reBalxxHd+0rN620c/SbcAGWVYkTgWDECWimLZzhtFdcdIaPs3QqCobbgpT7NgWuST16kHCREKSwKBe6PXl0ohsqyKB+4vrpLY7++anVJXlzMCYgfhX5rvzv+hietja1dJkrPSzqQ7sIEC+67BTMUROf/vPjklYeRntNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ejmzv/xb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <75da23a0-5351-4209-b8eb-236c8806b539@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753108612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVhKA1X+9r8f/FUH0A6kHrg/wVcnDzUKPcoSz/rjuDQ=;
	b=ejmzv/xbtyuk3b0X3VyUQaw6Meb68Xt1+gu+HX+SaXgPb4XEwCRJgLnQmMP+thQ0lu6OgD
	RMuytHSGkQxmYSOdJm11lyYzuFrtwFno4SJGowv0Fdiw3uUf9ZFJY+DiJWDSZgO3v6YUII
	xEsBUAHmp0sAoqAMVGOBvVsbd8GudDA=
Date: Mon, 21 Jul 2025 07:36:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Add LPM trie microbenchmarks
Content-Language: en-GB
To: Matt Fleming <matt@readmodwrite.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Shuah Khan <shuah@kernel.org>,
 kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Matt Fleming <mfleming@cloudflare.com>, Netdev <netdev@vger.kernel.org>
References: <20250718150554.48210-1-matt@readmodwrite.com>
 <81cd8749-6212-4fcf-8e1a-5eba5a8e2a73@kernel.org>
 <CAENh_ST_8XN2+QT8xz1gcKyovwEGwO-j2-YHbMj6GrWuZcgRag@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAENh_ST_8XN2+QT8xz1gcKyovwEGwO-j2-YHbMj6GrWuZcgRag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/21/25 6:01 AM, Matt Fleming wrote:
> On Sat, Jul 19, 2025 at 2:15 PM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>> On 18/07/2025 17.05, Matt Fleming wrote:
>>
>>> [...]
>>> diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
>>> new file mode 100644
>>> index 000000000000..c335718cc240
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
>>> @@ -0,0 +1,175 @@
>> [...]
>>> +
>>> +static __always_inline void atomic_inc(long *cnt)
>>> +{
>>> +     __atomic_add_fetch(cnt, 1, __ATOMIC_SEQ_CST);
>>> +}
>>> +
>>> +static __always_inline long atomic_swap(long *cnt, long val)
>>> +{
>>> +     return __atomic_exchange_n(cnt, val, __ATOMIC_SEQ_CST);
>>> +}
>> For userspace includes we have similar defines in bench.h.
>> Except they use __ATOMIC_RELAXED and here __ATOMIC_SEQ_CST.
>> Which is the correct to use?
>>
>> For BPF kernel-side do selftests have another header file that define
>> these `atomic_inc` and `atomic_swap` ?
> Actually, we can side step this problem completely by consistently
> using __sync_fetch_and_add() for duration_ns and hits and removing the
> atomic operations for DELETE, which doesn't need atomicity anyway
> since only a single producer can run.

__sync_fetch_and_add() and __atomic_add_fetch() have the same
semantics. So indeed tt would be good to just use one of them.

>
> I'll send a v2.


