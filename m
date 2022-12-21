Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DE2653829
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiLUVVd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 16:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiLUVVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 16:21:32 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5168322B35;
        Wed, 21 Dec 2022 13:21:31 -0800 (PST)
Message-ID: <18e1219a-d2b2-0373-1f30-fcf83acd328f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671657689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZUs0Oi+KQ6ND7Xr4JK7sAaYTromssvZdryVCNE4E8E=;
        b=kUsg/pqNcucRnMDDXoSqn/4qnyug7Z9+bB4VEfwvYpk5pgRkOQyOFhaikO0PD5jeCaTf89
        YRVKicwgMLH+BdcT4eoKA7c8RiVyockir7mDP3EIHJckUUJ8UnjlWbejxyw/OkPxIbCY0e
        uPfaQlLu7qOWPbeVPlCb3Ab1OlwSY0E=
Date:   Wed, 21 Dec 2022 13:21:25 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: check null propagation
 only neither reg is PTR_TO_BTF_ID
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20221213030436.17907-1-sunhao.th@gmail.com>
 <20221213030436.17907-2-sunhao.th@gmail.com>
 <7cfaaafa-0eda-a314-5b22-7e22c029f4ad@linux.dev>
 <7EAED688-C971-410E-BA56-9629CF9B3C91@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7EAED688-C971-410E-BA56-9629CF9B3C91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/21/22 5:46 AM, Hao Sun wrote:
> Hi,
> 
> I’ve tried something like the bellow, but soon realized that this
> won’t work because once compiler figures out `inner_map` equals
> to `val`, it can choose either reg to write into in the following
> path, meaning that this program can be rejected due to writing
> into read-only PTR_TO_BTF_ID reg, and this makes the test useless.

hmm... I read the above a few times but I still don't quite get it.  In 
particular, '...can be rejected due to writing into read-only PTR_TO_BTF_ID 
reg...'.  Where is it writing into a read-only PTR_TO_BTF_ID reg in the 
following bpf prog?  Did I overlook something?

> 
> Essentially, we want two regs, one points to PTR_TO_BTD_ID, one
> points to MAP_VALUR_OR_NULL, then compare them and deref map val.

If I read this request correctly, I guess the compiler has changed 'ret = *val' 
to 'ret = *inner_map'?  Thus, the verifier did not reject because it deref a 
PTR_TO_BTF_ID?

> It’s hard to implement this in C level because compilers decide
> which reg to use but not us, maybe we can just drop this test.

Have you tried inline assembly.  Something like this (untested):

         asm volatile (
                 "r8 = %[val];\n"
                 "r9 = %[inner_map];\n"
		"if r8 != r9 goto +1;\n"
                 "%[ret] = *(u64 *)(r8 +0);\n"
                 :[ret] "+r"(ret)
                 : [inner_map] "r"(inner_map), [val] "r"(val)
                 :"r8", "r9");

Please attach the verifier output in the future.  It will be easier to understand.

> 
> thoughts?
>    
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 1);
> +	__type(key, u64);
> +	__type(value, u64);
> +} m_hash SEC(".maps");
> +
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'map_value_or_null")
> +int jeq_infer_not_null_ptr_to_btfid(void *ctx)
> +{
> +	struct bpf_map *map = (struct bpf_map *)&m_hash;
> +	struct bpf_map *inner_map = map->inner_map_meta;
> +	u64 key = 0, ret = 0, *val;
> +
> +	val = bpf_map_lookup_elem(map, &key);
> +	/* Do not mark ptr as non-null if one of them is
> +	 * PTR_TO_BTF_ID, reject because of invalid access
> +	 * to map value.
> +	 */
> +	if (val == inner_map)
> +		ret = *val;
> +
> +	return ret;
> +}

