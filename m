Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD6065152A
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 23:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiLSWCK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 17:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSWCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 17:02:08 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C93A13D6F;
        Mon, 19 Dec 2022 14:02:05 -0800 (PST)
Message-ID: <7cfaaafa-0eda-a314-5b22-7e22c029f4ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671487323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jeMl8VJ+fwZuXpHKe24Q4We7CTOO+dhXk2qUAXDZqk=;
        b=bpUuYU9a4fKO7Kx6bU+uT/xaNrfBElnpGlFAwKTBkJ0uaAYGrhvjL1pjlMlDuMsK0+Pv/E
        kgHIdf8f6HYVVnTXL6SWtgSMM7cQcBjYJmAOCcgmNE7rz1N9BvKZqEOGBNSbqf98XEupPL
        /pvsyKSXKqwt9O9jfTuv0zs7iiN7dBk=
Date:   Mon, 19 Dec 2022 14:01:58 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: check null propagation
 only neither reg is PTR_TO_BTF_ID
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20221213030436.17907-1-sunhao.th@gmail.com>
 <20221213030436.17907-2-sunhao.th@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221213030436.17907-2-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/12/22 7:04 PM, Hao Sun wrote:
> Verify that nullness information is not porpagated in the branches
> of register to register JEQ and JNE operations if one of them is
> PTR_TO_BTF_ID.

Thanks for the fix and test.

> 
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>   .../bpf/verifier/jeq_infer_not_null.c         | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
> index 67a1c07ead34..b2b215227d97 100644
> --- a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
> +++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
> @@ -172,3 +172,25 @@
>   	.prog_type = BPF_PROG_TYPE_XDP,
>   	.result = ACCEPT,
>   },
> +{
> +	"jne/jeq infer not null, PTR_TO_MAP_OR_NULL unchanged with PTR_TO_BTF_ID reg",
> +	.insns = {
> +	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
> +	BPF_LD_MAP_FD(BPF_REG_1, 0),
> +	/* r6 = bpf_map->inner_map_meta; */
> +	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),

This bpf_map->inner_map_meta requires CO-RE. It works now but could be fragile 
in different platform and in the future bpf_map changes. Take a look at the 
map_ptr_kern.c which uses "__attribute__((preserve_access_index))" at the 
"struct bpf_map".

Please translate this verifer test into a proper bpf prog in C code such that it 
can use the CO-RE in libbpf.  It should run under test_progs instead of 
test_verifier. The bpf prog can include the "vmlinux.h" to get the 
"__attribute__((preserve_access_index))" for free.  Take a look at 
https://lore.kernel.org/all/20221207201648.2990661-2-andrii@kernel.org/ which 
has example on how to check verifier message in test_progs.


> +	/* r0 = map_lookup_elem(r1, r2); */
> +	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> +	/* if (r0 == r6) read *r0; */
> +	BPF_JMP_REG(BPF_JEQ, BPF_REG_6, BPF_REG_0, 1),
> +	BPF_EXIT_INSN(),
> +	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.fixup_map_hash_8b = { 3 },
> +	.prog_type = BPF_PROG_TYPE_XDP,
> +	.result = REJECT,
> +	.errstr = "R0 invalid mem access 'map_value_or_null'",
> +},

