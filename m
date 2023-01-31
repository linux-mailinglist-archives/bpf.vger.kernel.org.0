Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722156820A2
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjAaAXQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjAaAXP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:23:15 -0500
Received: from out-231.mta0.migadu.com (out-231.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C8E12586
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:23:14 -0800 (PST)
Message-ID: <23c1f484-380a-c112-86a1-5e104fb981f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675124591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhdu29yOG2JI4UvfvGh5x55VRMVl1NSwl/G8pQdFaD8=;
        b=S1rQSfmssl2ttXW1yS6lMQrtFRnTTYLceNIVviWd5sOnCbzW9P0NsooRe4BZmzFvMdXc2g
        AGqP3b/nnKRdxiHERK5SypOF85be0LSXXsUjbeU5WaqZGWK4VmRLQN41sTaVkWY3OYCDHa
        YDkGz83l8AcfOXIOUF1MAJ59ddTAGHY=
Date:   Mon, 30 Jan 2023 16:22:57 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/6] selftest/bpf/benchs: Add benchmark for
 hashmap lookups
Content-Language: en-US
To:     Anton Protopopov <aspsk@isovalent.com>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <20230127181457.21389-7-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
In-Reply-To: <20230127181457.21389-7-aspsk@isovalent.com>
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

On 1/27/23 10:14 AM, Anton Protopopov wrote:
> +/* The number of slots to store times */
> +#define NR_SLOTS 32
> +
> +/* Configured by userspace */
> +u64 nr_entries;
> +u64 nr_loops;
> +u32 __attribute__((__aligned__(8))) key[256];
> +
> +/* Filled by us */
> +u64 __attribute__((__aligned__(256))) percpu_times_index[NR_SLOTS]; > +u64 __attribute__((__aligned__(256))) percpu_times[256][NR_SLOTS];
> +
> +static inline void patch_key(u32 i)
> +{
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +	key[0] = i + 1;
> +#else
> +	key[0] = __builtin_bswap32(i + 1);
> +#endif
> +	/* the rest of key is random and is configured by userspace */
> +}
> +
> +static int lookup_callback(__u32 index, u32 *unused)
> +{
> +	patch_key(index);
> +	return bpf_map_lookup_elem(&hash_map_bench, key) ? 0 : 1;
> +}
> +
> +static int loop_lookup_callback(__u32 index, u32 *unused)
> +{
> +	return bpf_loop(nr_entries, lookup_callback, NULL, 0) ? 0 : 1;
> +}
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int benchmark(void *ctx)
> +{
> +	u32 cpu = bpf_get_smp_processor_id();
> +	u32 times_index;
> +	u64 start_time;
> +
> +	times_index = percpu_times_index[cpu & 255] % NR_SLOTS;

percpu_times_index only has NR_SLOTS (32) elements?

> +	start_time = bpf_ktime_get_ns();
> +	bpf_loop(nr_loops, loop_lookup_callback, NULL, 0);
> +	percpu_times[cpu & 255][times_index] = bpf_ktime_get_ns() - start_time;
> +	percpu_times_index[cpu & 255] += 1;
> +	return 0;
> +}

