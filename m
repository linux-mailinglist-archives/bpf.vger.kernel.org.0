Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C66F683995
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 23:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjAaWuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 17:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjAaWue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 17:50:34 -0500
Received: from out-77.mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60402413B
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 14:50:33 -0800 (PST)
Message-ID: <6faf60d9-b125-2bde-715b-f0bd3b637777@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675205431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OaH8ngzg1yHGzJ8Ek18JUHqNiulKIB1z3Rvodu9gOI=;
        b=OeY9hmHs6csLJcK1HUmXo6dA44cePeWgvs0hq+e1e7Id/W1vESMwAajlYQQ74oHSJ3hpNA
        CXlnK87o7pHLKRYhhlxbcCHPWM5MlAJ6Jy9ZgBxTuupoHbzuEZQQ/MCyzrakFFtRFEwYHl
        cTvQ3EYTyU5PInIVSDlWEukNbDNZ5jY=
Date:   Tue, 31 Jan 2023 14:50:24 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/6] selftest/bpf/benchs: Add benchmark for
 hashmap lookups
Content-Language: en-US
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <20230127181457.21389-7-aspsk@isovalent.com>
 <23c1f484-380a-c112-86a1-5e104fb981f9@linux.dev> <Y9j2EccwJnOsiFuV@lavr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Y9j2EccwJnOsiFuV@lavr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/31/23 3:05 AM, Anton Protopopov wrote:
> On 23/01/30 04:22, Martin KaFai Lau wrote:
>> On 1/27/23 10:14 AM, Anton Protopopov wrote:
>>> +/* The number of slots to store times */
>>> +#define NR_SLOTS 32
>>> +
>>> +/* Configured by userspace */
>>> +u64 nr_entries;
>>> +u64 nr_loops;
>>> +u32 __attribute__((__aligned__(8))) key[256];
>>> +
>>> +/* Filled by us */
>>> +u64 __attribute__((__aligned__(256))) percpu_times_index[NR_SLOTS]; > +u64 __attribute__((__aligned__(256))) percpu_times[256][NR_SLOTS];
>>> +
>>> +static inline void patch_key(u32 i)
>>> +{
>>> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>> +	key[0] = i + 1;
>>> +#else
>>> +	key[0] = __builtin_bswap32(i + 1);
>>> +#endif
>>> +	/* the rest of key is random and is configured by userspace */
>>> +}
>>> +
>>> +static int lookup_callback(__u32 index, u32 *unused)
>>> +{
>>> +	patch_key(index);
>>> +	return bpf_map_lookup_elem(&hash_map_bench, key) ? 0 : 1;
>>> +}
>>> +
>>> +static int loop_lookup_callback(__u32 index, u32 *unused)
>>> +{
>>> +	return bpf_loop(nr_entries, lookup_callback, NULL, 0) ? 0 : 1;
>>> +}
>>> +
>>> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
>>> +int benchmark(void *ctx)
>>> +{
>>> +	u32 cpu = bpf_get_smp_processor_id();
>>> +	u32 times_index;
>>> +	u64 start_time;
>>> +
>>> +	times_index = percpu_times_index[cpu & 255] % NR_SLOTS;
>>
>> percpu_times_index only has NR_SLOTS (32) elements?
> 
> Yes, the idea was the following. One measurement (bpf prog execution) takes
> about 20-80 ms (depending on the key/map size). So in 2-3 seconds we can get
> about NR_SLOTS elements. For me 32 looked like enough to get stats for this
> benchmark. Do you think this is better to make the NR_SLOTS
> bigger/configurable?

I thought percpu_times_index[] is the next slot to use for a particular cpu in 
percpu_times[256][NR_SLOTS]. 256 is the max number of cpu supported? It is doing 
"cpu" & 255 also. Should it be sized as percpu_times_index[256] instead then?

May be #define what 256 is here such that it can have a self describe name.

> 
>>> +	start_time = bpf_ktime_get_ns();
>>> +	bpf_loop(nr_loops, loop_lookup_callback, NULL, 0);
>>> +	percpu_times[cpu & 255][times_index] = bpf_ktime_get_ns() - start_time;
>>> +	percpu_times_index[cpu & 255] += 1;
>>> +	return 0;
>>> +}
>>

