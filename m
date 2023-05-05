Return-Path: <bpf+bounces-154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B76F8B8C
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FE51C21A1D
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FFFC10;
	Fri,  5 May 2023 21:47:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC8DF71
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:47:23 +0000 (UTC)
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27245BB0
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 14:47:06 -0700 (PDT)
Message-ID: <9dcd94cd-d0b8-b86a-f566-42ddea6dfdf2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1683323224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvUs5Nj8siZe5X0uJB7nJTqPfiBbfGoYcaFA5wZiVJk=;
	b=LL27wr9Gn5/JvAW9D+xNpBccoUuuoi/okURKXk7JWKTIxhMViPA8/b9tkGJOug7anG6hb6
	SjfZFI0PPl/D5kAEM4T1JSVzeZ2nSgMIShTx1DQ5T66+W30po7SCXy9iGfRTNaTqipq7Rv
	1qrEUUE+wENaKLsM9kxiH/YjFjtgI/4=
Date: Fri, 5 May 2023 14:47:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/4] selftests/bpf: Update EFAULT
 {g,s}etsockopt selftests
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20230504184349.3632259-1-sdf@google.com>
 <20230504184349.3632259-3-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230504184349.3632259-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/4/23 11:43 AM, Stanislav Fomichev wrote:
> @@ -648,6 +676,49 @@ static struct sockopt_test {
>   
>   		.error = EFAULT_SETSOCKOPT,
>   	},
> +	{
> +		.descr = "setsockopt: ignore >PAGE_SIZE optlen",
> +		.insns = {
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
> +			BPF_MOV64_IMM(BPF_REG_0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		.attach_type = BPF_CGROUP_SETSOCKOPT,
> +		.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
> +
> +		.set_level = SOL_IP,
> +		.set_optname = IP_TOS,
> +		.set_optval = { 1 << 3 },
> +		.set_optlen = PAGE_SIZE + 1,
> +
> +		.get_level = SOL_IP,
> +		.get_optname = IP_TOS,
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +		.get_optval = { 1 << 3, 0, 0, 0 }, /* the changes are ignored */
> +#else
> +		.get_optval = { 0, 0, 0, 1 << 3 }, /* the changes are ignored */

This fails in s390 (big endian?): 
https://github.com/kernel-patches/bpf/actions/runs/4895136324/jobs/8740562449

I don't think it needs special treatment here on different __BYTE_ORDER. Other 
tests in this file also don't do that.

> +#endif
> +		.get_optlen = 4,
> +	},


