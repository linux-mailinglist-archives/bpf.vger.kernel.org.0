Return-Path: <bpf+bounces-47691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899D9FE3DA
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 09:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCFA1882893
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CB31A0BF1;
	Mon, 30 Dec 2024 08:44:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B41A0BC9;
	Mon, 30 Dec 2024 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735548275; cv=none; b=agkTUMuZdV9llKslLGBPidPhOnm/ulQ8aDcoZ18DAdZOoLL+Pgc3CqlrOQPoG1Kp9D4VLVhauL8YRC39A7xlvwo3uWQCluGxM5d7NO1a1v3W9D6BBLd2qFeObEQxSIJqGP09hp8gX+Vcy6rQQUhJFEU1flmVJva98GJfNo5wpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735548275; c=relaxed/simple;
	bh=NIKhsuOF+4VRamFZBGexqq4b3abde8Lybemix6We3YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jguioKEX7DN46IMBVcxn9kZBloUpYX+ZvrSd+lpc0NSYT1b5YUQdw+RL5wEhe7Cq6z+bMlmdWiF65cYT5ujq+eWw2HQ2pInQx5b4CLzUewwD89sRTlvR1IBfG06yvidyRJzZ5RPfuDv4GRkv+8kdfzdCaRv4Ac8pVDDAHTe0Je4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YM8ly4TVVz4f3jqb;
	Mon, 30 Dec 2024 16:44:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6107E1A1381;
	Mon, 30 Dec 2024 16:44:29 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDn2qxqXXJn0_ycFw--.16795S2;
	Mon, 30 Dec 2024 16:44:27 +0800 (CST)
Message-ID: <6763d7c3-7971-477f-aa47-cb2fdf4b08e2@huaweicloud.com>
Date: Mon, 30 Dec 2024 16:44:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] bpf, arm64: Emit A64_{ADD,SUB}_I when
 possible in emit_{lse,ll_sc}_atomic()
Content-Language: en-US
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <3b84fa17ab72f3f69e09e0032452d17eb13b80db.1735342016.git.yepeilin@google.com>
 <953c7241e82496cb7a8b5a8724028ad646cd0896.1735342016.git.yepeilin@google.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <953c7241e82496cb7a8b5a8724028ad646cd0896.1735342016.git.yepeilin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDn2qxqXXJn0_ycFw--.16795S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5GF1ktr4Dur4UCry5twb_yoW5Cr4UpF
	43Wwn3C39Fvr1Yva4xAF47Jw45Kan5try7ur1UJw4fCw1qvryjgF18Kw45CFW5Za48tw4f
	CFyqkFsxCa4UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/28/2024 7:36 AM, Peilin Ye wrote:
> Currently in emit_{lse,ll_sc}_atomic(), if there is an offset, we add it
> to the base address by emitting two instructions, for example:
> 
>    if (off) {
>            emit_a64_mov_i(1, tmp, off, ctx);
>            emit(A64_ADD(1, tmp, tmp, dst), ctx);
>    ...
> 
> As pointed out by Xu, we can combine the above into a single A64_ADD_I
> instruction if 'is_addsub_imm(off)' is true, or an A64_SUB_I, if
> 'is_addsub_imm(-off)' is true.
> 
> Suggested-by: Xu Kuohai <xukuohai@huaweicloud.com>
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
> Hi all,
> 
> This was pointed out by Xu in [1] .  Tested on x86-64, using
> PLATFORM=aarch64 CROSS_COMPILE=aarch64-linux-gnu- vmtest.sh:
> 
> LSE:
>    * ./test_progs-cpuv4 -a atomics,arena_atomics
>      2/15 PASSED, 0 SKIPPED, 0 FAILED
>    * ./test_verifier
>      790 PASSED, 0 SKIPPED, 0 FAILED
> 
> LL/SC:
> (In vmtest.sh, changed '-cpu' QEMU option from 'cortex-a76' to
>   'cortex-a57', to make LSE atomics unavailable.)
>    * ./test_progs-cpuv4 -a atomics
>      1/7 PASSED, 0 SKIPPED, 0 FAILED
>    * ./test_verifier
>      790 PASSED, 0 SKIPPED, 0 FAILED
> 
> Thanks,
> Peilin Ye
> 
> [1] https://lore.kernel.org/bpf/f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com/
> 
>   arch/arm64/net/bpf_jit_comp.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 9040033eb1ea..f15bbe92fed9 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -649,8 +649,14 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   	u8 reg = dst;
>   
>   	if (off) {
> -		emit_a64_mov_i(1, tmp, off, ctx);
> -		emit(A64_ADD(1, tmp, tmp, dst), ctx);
> +		if (is_addsub_imm(off)) {
> +			emit(A64_ADD_I(1, tmp, reg, off), ctx);
> +		} else if (is_addsub_imm(-off)) {
> +			emit(A64_SUB_I(1, tmp, reg, -off), ctx);
> +		} else {
> +			emit_a64_mov_i(1, tmp, off, ctx);
> +			emit(A64_ADD(1, tmp, tmp, reg), ctx);
> +		}
>   		reg = tmp;
>   	}
>   	if (arena) {
> @@ -721,7 +727,7 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   	const s32 imm = insn->imm;
>   	const s16 off = insn->off;
>   	const bool isdw = BPF_SIZE(code) == BPF_DW;
> -	u8 reg;
> +	u8 reg = dst;
>   	s32 jmp_offset;
>   
>   	if (BPF_MODE(code) == BPF_PROBE_ATOMIC) {
> @@ -730,11 +736,15 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   		return -EINVAL;
>   	}
>   
> -	if (!off) {
> -		reg = dst;
> -	} else {
> -		emit_a64_mov_i(1, tmp, off, ctx);
> -		emit(A64_ADD(1, tmp, tmp, dst), ctx);
> +	if (off) {
> +		if (is_addsub_imm(off)) {
> +			emit(A64_ADD_I(1, tmp, reg, off), ctx);
> +		} else if (is_addsub_imm(-off)) {
> +			emit(A64_SUB_I(1, tmp, reg, -off), ctx);
> +		} else {
> +			emit_a64_mov_i(1, tmp, off, ctx);
> +			emit(A64_ADD(1, tmp, tmp, reg), ctx);
> +		}
>   		reg = tmp;
>   	}
>   

Thanks, this looks good to me, but we now have serveral repetitive code
snippets like this. It would be better to refactor them into a common
function.


