Return-Path: <bpf+bounces-70160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4540BB1DFC
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7063C2A358E
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7630DD2E;
	Wed,  1 Oct 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ClgI4vCd"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A717A2FC
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354996; cv=none; b=Vs2GStR3BL2oQ339tokBLVANpR8Cip0BB9romlYxNe5XQ9euR1q9xK3i8gobBhc4nDZzis+T+yPvuTYjcrrngpBtq1SngMfW4UY4wrcIKzx5wDfnVPy0l/VnzsfDfLQCT/8E4PWqw6Y4vRKNLWlVXZ8dgkErAIaPv5cXabNXiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354996; c=relaxed/simple;
	bh=5KNsGz/3iIWTWUlZ8TsCApXlUItm8rhipCf+UgUgQVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHLxY4r7xsbwLMPUSO9OhW3xIJHcyESmNw1DfPnT6CBLYLCqGyj167Fi6T+mn4L+OTDy9eWVnTEmwcGrBaP0uTR9Xrm01wCaUApC2DuSkaV0fpgB8qQqoZp+NtywnYOtSu1eWhW19EmYnfNo01d33CdeVgxRy2aMxfOxGp/Z2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ClgI4vCd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0993af39-d1eb-4f5f-89d7-8dc50ed4fbba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759354991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7/RMIhNDVHbHa17EcQAai+utoTe7jdhmIte5sYjEYY=;
	b=ClgI4vCdOrB5H5nV0C/VI489j5lNIumLDe1vmpl814cVYvbN8M7X6KyxeXgFdGVzw4216T
	mS5KKnq90rKSls3fbTef/SmO290XhsivkjIvsrxgC0mAMzEXzAfPKMSsLvXD7YBqKo2FW7
	ZWxZkJN+52ZyoZkuI3Ftjlj1d8tuwLY=
Date: Wed, 1 Oct 2025 14:43:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
Content-Language: en-GB
To: yazhoutang@foxmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 Yazhou Tang <tangyazhou518@outlook.com>,
 Shenghao Yuan <shenghaoyuan0928@163.com>, Tianci Cao <ziye@zju.edu.cn>
References: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/30/25 8:04 AM, yazhoutang@foxmail.com wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> When verifying BPF programs, the check_alu_op() function validates
> instructions with ALU operations. The 'offset' field in these
> instructions is a signed 16-bit integer.
>
> The existing check 'insn->off > 1' was intended to ensure the offset is
> either 0, or 1 for BPF_MOD/BPF_DIV. However, because 'insn->off' is
> signed, this check incorrectly accepts all negative values (e.g., -1).
>
> This commit tightens the validation by changing the condition to
> '(insn->off != 0 && insn->off != 1)'. This ensures that any value
> other than the explicitly permitted 0 and 1 is rejected, hardening the
> verifier against malformed BPF programs.
>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>

Thanks for the fix. The change looks good to me.
It would be great if you can add a small inline-asm based
test case as mentioned by Eduard.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/verifier.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9fb1f957a093..8979a84f9253 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15739,7 +15739,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   	} else {	/* all other ALU ops: and, sub, xor, add, ... */
>   
>   		if (BPF_SRC(insn->code) == BPF_X) {
> -			if (insn->imm != 0 || insn->off > 1 ||
> +			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
>   			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
>   				verbose(env, "BPF_ALU uses reserved fields\n");
>   				return -EINVAL;
> @@ -15749,7 +15749,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   			if (err)
>   				return err;
>   		} else {
> -			if (insn->src_reg != BPF_REG_0 || insn->off > 1 ||
> +			if (insn->src_reg != BPF_REG_0 || (insn->off != 0 && insn->off != 1) ||
>   			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
>   				verbose(env, "BPF_ALU uses reserved fields\n");
>   				return -EINVAL;


