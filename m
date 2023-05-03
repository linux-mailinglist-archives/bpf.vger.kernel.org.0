Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7736F4E25
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 02:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjECA31 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 20:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjECA30 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 20:29:26 -0400
Received: from out-44.mta0.migadu.com (out-44.mta0.migadu.com [91.218.175.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E6E1FFB
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 17:29:25 -0700 (PDT)
Message-ID: <9cc9a5f6-35cd-cfa3-8034-18dac9f20d6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683073763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7iRyZUBjp4T9gxPWsguSElMXmMNkIz9bGnF8tC9851U=;
        b=DN+J/mOl9Mv3OE8ka3YRhNUKlaXZC4h4ItXVr9o4kVK3Y44M6YLWivlpTF6ySTUGEQ9M+/
        7L6OIP2CsNEBPdYtQY2GJ9BeflfHovLru0YBdYI3MlVjim6QW13qOTxU7OgGe7GD2FkFs1
        Z9Kzs8NCcdntWHIufHi3vacGxT5ZoHo=
Date:   Tue, 2 May 2023 17:29:19 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] selftests/bpf: Update EFAULT
 {g,s}etsockopt selftests
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
References: <20230501194825.2864150-1-sdf@google.com>
 <20230501194825.2864150-3-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230501194825.2864150-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/23 12:48 PM, Stanislav Fomichev wrote:
> Instead of assuming EFAULT, let's assume the BPF program's
> output is ignored.
> 
> Remove "getsockopt: deny arbitrary ctx->retval" because it
> was actually testing optlen. We have separate set of tests
> for retval.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   .../selftests/bpf/prog_tests/sockopt.c        | 98 +++++++++++++++++--
>   1 file changed, 92 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> index aa4debf62fc6..a7bc9dc93ce0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> @@ -5,6 +5,10 @@
>   static char bpf_log_buf[4096];
>   static bool verbose;
>   
> +#ifndef PAGE_SIZE
> +#define PAGE_SIZE 4096
> +#endif
> +
>   enum sockopt_test_error {
>   	OK = 0,
>   	DENY_LOAD,
> @@ -273,10 +277,30 @@ static struct sockopt_test {
>   		.error = EFAULT_GETSOCKOPT,
>   	},
>   	{
> -		.descr = "getsockopt: deny arbitrary ctx->retval",
> +		.descr = "getsockopt: ignore >PAGE_SIZE optlen",
>   		.insns = {
> -			/* ctx->retval = 123 */
> -			BPF_MOV64_IMM(BPF_REG_0, 123),
> +			/* write 0xFF to the first optval byte */
> +
> +			/* r6 = ctx->optval */
> +			BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,
> +				    offsetof(struct bpf_sockopt, optval)),
> +			/* r2 = ctx->optval */
> +			BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
> +			/* r6 = ctx->optval + 1 */
> +			BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
> +
> +			/* r7 = ctx->optval_end */
> +			BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1,
> +				    offsetof(struct bpf_sockopt, optval_end)),
> +
> +			/* if (ctx->optval + 1 <= ctx->optval_end) { */
> +			BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
> +			/* ctx->optval[0] = 0xF0 */
> +			BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xFF),
> +			/* } */
> +
> +			/* ctx->retval = 0 */
> +			BPF_MOV64_IMM(BPF_REG_0, 0),


This is an interesting test case. One more question just came to my mind,
does it make sense to also ignore the bpf-prog's 'ctx->retval = 0' in getsockopt 
considering its optval change has already been ignored. Something like:

	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d 
(max_optlen=%d)\n",
				     ctx.optlen, max_optlen);
			ret = retval;
                         goto out;
                 }
                 ret = -EFAULT;
                 goto out;
         }


>   			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
>   				    offsetof(struct bpf_sockopt, retval)),
>   
> @@ -287,9 +311,10 @@ static struct sockopt_test {
>   		.attach_type = BPF_CGROUP_GETSOCKOPT,
>   		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
>   
> -		.get_optlen = 64,
> -
> -		.error = EFAULT_GETSOCKOPT,
> +		.get_level = 1234,
> +		.get_optname = 5678,
> +		.get_optval = {}, /* the changes are ignored */
> +		.get_optlen = PAGE_SIZE + 1,
>   		}
>   
> +		if (optlen > sizeof(test->get_optval))
> +			optlen = sizeof(test->get_optval);
> +
>   		if (memcmp(optval, test->get_optval, optlen) != 0) {
>   			errno = 0;
>   			log_err("getsockopt returned unexpected optval");

