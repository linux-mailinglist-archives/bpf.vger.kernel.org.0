Return-Path: <bpf+bounces-16026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8EB7FB0DE
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 05:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA377B211AA
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 04:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25884101D7;
	Tue, 28 Nov 2023 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dOVBBACm"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEE198
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 20:16:25 -0800 (PST)
Message-ID: <56c00185-0b14-40d8-b72b-5a79797b94c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701144983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocydM1nNBN5Nf43pURgrJeTdZHtYbKYgtEHTlEI7AZo=;
	b=dOVBBACmdrXRp+NIg2qwY7AM0LUUkaa6wxBnSC+G6px5D7KJZfDnywupgmYczgedNuiK+4
	PZXc0F9J52SDdSnJqhC9Z0sUCIYSJpcbrPg9b5/GBpL3TAynEhzK5fOtHsnsSJ1kFRmLjc
	sP4gYw9k1RudTPUdq48uEwSed3yldJE=
Date: Mon, 27 Nov 2023 20:16:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: max<min after jset
Content-Language: en-GB
To: Tao Lyu <tao.lyu@epfl.ch>, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, song@kernel.org, haoluo@google.com,
 martin.lau@linux.dev
Cc: bpf@vger.kernel.org, sanidhya.kashyap@epfl.ch,
 mathias.payer@nebelwelt.net, meng.xu.cs@uwaterloo.ca
References: <20231121173206.3594040-1-tao.lyu@epfl.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231121173206.3594040-1-tao.lyu@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/21/23 12:32 PM, Tao Lyu wrote:
> Hi,
>
> The eBPF program shown below leads to an reversed min and max
> after insn 6 "if w0 & 0x894b6a55 goto +2",
> whic means max < min.
>
> Here is the introduction how it happens.
>
> Before insn 6,
> the range of r0 expressed by the min and max field is
> min1 = 884670597, max1 = 900354100
> And the range expressed by the var_off=(0x34000000; 0x1ff5fbf))
> is min2=872415232, max2=905928639.
>
> ---min2-----------------------min1-----max1-----max2---
>
> Here we can see that the range expressed by var_off is wider than that of min and max.
>
> When verifying insn6,
> it first uses the var_off and immediate "0x894b6a55" to
> calculate the new var_off=(0x34b00000; 0x415aa).
> The range expressed by the new var_off is:
> min3=883949568, max3=884217258
>
> ---min2-----min3-----max3-----min1-----max1-----max2---
>
> And then it will calculate the new min and max by:
> (1) new-min = MAX(min3, min1) = min1
> (2) new-max = MIN(max3, max1) = max3
>
> ---min2-----min3-----max3-----min1-----max1-----max2---
>           "new-max"          "new-min"
>
> Now, the new-max becomes less than the new min.
>
> Notably, [min1, max1] can never make "w0 & 0x894b6a55 == 0"
> and thus cannot goes the fall-through branch.
> In other words, actually the fall-trough branch is a dead path.
>
> BTW, I cannot successfully compile this instruciton "if w0 != 0 goto +2;\"
> in the c inline assembly code.
> So I can only attach the bytecodes.
>
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>   .../selftests/bpf/verifier/jset_reversed_range.c  | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/verifier/jset_reversed_range.c
>
> diff --git a/tools/testing/selftests/bpf/verifier/jset_reversed_range.c b/tools/testing/selftests/bpf/verifier/jset_reversed_range.c
> new file mode 100644
> index 000000000000..734f492a2a96
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/jset_reversed_range.c
> @@ -0,0 +1,15 @@
> +{
> +    "BPF_JSET: incorrect scalar range",
> +    .insns = {
> +    BPF_MOV64_IMM(BPF_REG_5, 100),
> +    BPF_ALU64_IMM(BPF_DIV, BPF_REG_5, 3),
> +    BPF_ALU32_IMM(BPF_RSH, BPF_REG_5, 7),
> +    BPF_ALU64_IMM(BPF_AND, BPF_REG_5, -386969681),
> +    BPF_ALU64_IMM(BPF_SUB, BPF_REG_5, -884670597),
> +    BPF_MOV32_REG(BPF_REG_0, BPF_REG_5),
> +    BPF_JMP32_IMM(BPF_JSET, BPF_REG_0, 0x894b6a55, 1),
> +    BPF_MOV64_IMM(BPF_REG_0, 1),
> +    BPF_MOV64_IMM(BPF_REG_0, 0),
> +    BPF_EXIT_INSN(),
> +    },
> +},

Tao Lyu,

The llvm patch to support BPF_JSET asm has been merged into upstream.
    https://github.com/yonghong-song/llvm-project/commit/e247e6ff272ce70003ca67f62be178f332f9de0f

Now you can write inline asm code with BPF_JSET insn with latest llvm18.
If you intend to submit a patch to the kernel, please guard the test case
with
     #if __clang_major__ >= 18

This should also facilitate to add inline asm test cases with BPF_JSET
in bpf selftests.

Thanks,
Yonghong



