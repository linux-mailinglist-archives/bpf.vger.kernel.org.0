Return-Path: <bpf+bounces-59474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6981FACBE93
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227123A5821
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 02:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF342A96;
	Tue,  3 Jun 2025 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1HpnKKy"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5523FE4
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748918713; cv=none; b=lm2A96hey+09nMYamKZ36HkKDKp26IXZzrv5L76gvyxrB58t6K9mBMDXcTXUQif4PgsLFfHfMdVAcyaTxpilB/xyUfGtITDmE878+MptGhzdwALtxqh6z0u1sAweAdYKmTV65DNIWoJWr0tSpkbdiKZumsO7IKPE3nztk8SBBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748918713; c=relaxed/simple;
	bh=LY8bBkHbJnSTbSMf3iu85ghuR8eEtCYY2nS1ixpfmlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYrZPRaSepQ6+LTaRQN4zZUWLIQTG95AEQ9Q1y6BvppXhkSB82/9422FOq3hNMRu2ig/CyCq9tOaDU4ehjBCGjAuzAaJM3+GyspYjmHbPz5CAUGPn/oxxgGPSkOU858zxQMrNrvdRwGcfuy19GbQNjiwgSh7dF/USmXyWNFdCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1HpnKKy; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e8a00cb-a5ac-4e5e-b157-62215933fb7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748918708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9kzoqgoSnKGZBekY5RB08ovalEivW5x3W7/fO+qlWo=;
	b=a1HpnKKyghspShwYM/DKAjKwK7O1CDysnb7/W3EZBBQVdNkHPkSI2g2l+6yai1G+OLQ0ia
	DB7GdWAj1zUqn0MfMd8x+VQAu/p/uKLg2qK1tdlO3TM6Und23H2cuayPbPxVIfndd6TKbT
	nRJmoURat+u5XLCnHaE2OlCRYIXitT4=
Date: Tue, 3 Jun 2025 10:45:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
References: <20250526162146.24429-1-leon.hwang@linux.dev>
 <20250526162146.24429-3-leon.hwang@linux.dev>
 <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com>
 <CAEf4Bzbw9G4HhL4_ecbgc2=bDbZuVEA2zLnChgqT_WCsq11krQ@mail.gmail.com>
 <CAADnVQLxzJMAYymtWMFZb6eAK+ha_shRfh+m3W3yFO4dLn-YeA@mail.gmail.com>
 <CAEf4BzYUW4oAm4JJ-Kh4HhtfP4GXuQFx+tJ3p7vjMpPYoVv5GQ@mail.gmail.com>
 <d6f9ca33-977f-4486-9d62-8f497858764b@linux.dev>
 <CAEf4BzZ1A6+uhX5gvCKSZUjvj_TG00-13jEWKbmqfXYEQ5fEZA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZ1A6+uhX5gvCKSZUjvj_TG00-13jEWKbmqfXYEQ5fEZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/6/25 07:50, Andrii Nakryiko wrote:
> On Wed, May 28, 2025 at 7:44 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 29/5/25 00:05, Andrii Nakryiko wrote:
>>> On Tue, May 27, 2025 at 7:35 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>
>> [...]
>>
>>>>
>>>> I guess this can be a follow up.
>>>> With extra flag lookup/update/delete can look into a new field
>>>> in that anonymous struct:
>>>>         struct { /* anonymous struct used by BPF_MAP_*_ELEM and
>>>> BPF_MAP_FREEZE commands */
>>>>                 __u32           map_fd;
>>>>                 __aligned_u64   key;
>>>>                 union {
>>>>                         __aligned_u64 value;
>>>>                         __aligned_u64 next_key;
>>>>                 };
>>>>                 __u64           flags;
>>>>         };
>>>>
>>>
>>> Yep, we'd have two flags: one for "apply across all CPUs", and another
>>> meaning "apply for specified CPU" + new CPU number field. Or the same
>>> flag with a special CPU number value (0xffffffff?).
>>>
>>>> There is also "batch" version of lookup/update/delete.
>>>> They probably will need to be extended as well for consistency ?
>>>> So I'd only go with the "use data to update all CPUs" flag for now.
>>>
>>> Agreed. But also looking at generic_map_update_batch() it seems like
>>> it just routes everything through single-element updates, so it
>>> shouldn't be hard to add batch support for all this either.
>>
>> Regarding BPF_MAP_UPDATE_{ELEM,BATCH} support for percpu_array maps —
>> would it make sense to split the flags field as [cpu | flags]?
> 
> We coul;d encode CPU number as part of flags, but I'm not sure what we
> are trying to achieve here. Adding a dedicated field for cpu number
> would be in line of what we did for BPF_PROG_TEST_RUN, so I don't see
> a big problem.
> 

It's to avoid breaking existing APIs, such as libbpf's
bpf_map_update_elem() and bpf_map__update_elem(). Otherwise, we would
need to introduce new percpu-specific versions, like
bpf_map_update_percpu_elem() and bpf_map__update_percpu_elem().

Thanks,
Leon


