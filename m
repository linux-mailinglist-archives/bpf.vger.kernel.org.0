Return-Path: <bpf+bounces-57030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07AAA4182
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 05:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373B317F71B
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 03:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6881C32FF;
	Wed, 30 Apr 2025 03:49:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFB199943
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984940; cv=none; b=U/z2TuWUqRL5w30XyjAASpE3T7ZE67I0tPs8n4yh6sIMnnco+nWUxBvS7vOCS3lUM8qjkoWYtWZE3MFY9dgpb2dVX1polboi+Z/zRkIJ8PGLkvwGgElAS3/+Jzni4cQq5+/kwyU1kivv1TWE8T4DCURyNW99l3Br4UyHrd6G6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984940; c=relaxed/simple;
	bh=zc6iwdL+UDRzFNzMaIBnJUuZbDbkiGfsOkee8d8ybYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vCrWcoRrLS5K6VNI1xeNhYwPPXTFJqI3XxD5TyjePZnD8AcTHrrVZ2gdWt/7Ll4UBtOQsgJEewm92zQnGgJG9HGHe7zyHlAC4XC41DmkHXqvVEvsOEHgGgOygk+ShDz4oxktgdW/F3kh7VMj8oZjJvves0X96HdHOuIu+E6FuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZnNVB510nz27hVW;
	Wed, 30 Apr 2025 11:49:38 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 26E17140275;
	Wed, 30 Apr 2025 11:48:54 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Apr 2025 11:48:52 +0800
Message-ID: <05cf616f-659d-4e27-97ee-95c516ad4468@huawei.com>
Date: Wed, 30 Apr 2025 11:48:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/8] bpf, riscv64: Skip redundant zext
 instruction after load-acquire
Content-Language: en-US
To: Peilin Ye <yepeilin@google.com>, <bpf@vger.kernel.org>
CC: <linux-riscv@lists.infradead.org>, Andrea Parri <parri.andrea@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
	<joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu
	<neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
References: <cover.1745970908.git.yepeilin@google.com>
 <875edd356603dd5d7be30b79b97d8ee15ebc59b3.1745970908.git.yepeilin@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <875edd356603dd5d7be30b79b97d8ee15ebc59b3.1745970908.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/4/30 8:50, Peilin Ye wrote:
> Currently, the verifier inserts a zext instruction right after every 8-,
> 16- or 32-bit load-acquire, which is already zero-extending.  Skip such
> redundant zext instructions.
> 
> While we are here, update that already-obsolete comment about "skip the
> next instruction" in build_body().  Also change emit_atomic_rmw()'s
> parameters to keep it consistent with emit_atomic_ld_st().
> 
> Note that checking 'insn[1]' relies on 'insn' not being the last
> instruction, which should have been guaranteed by the verifier; we
> already use 'insn[1]' elsewhere in the file for similar purposes.
> Additionally, we don't check if 'insn[1]' is actually a zext for our
> load-acquire's dst_reg, or some other registers - in other words, here
> we are relying on the verifier to always insert a redundant zext right
> after a 8/16/32-bit load-acquire, for its dst_reg.
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 23 ++++++++++++++++++-----
>   arch/riscv/net/bpf_jit_core.c   |  3 +--
>   2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index b71a9c88fb4f..4cb50dbbe94b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -607,8 +607,13 @@ static void emit_store_64(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
>   	emit_sd(RV_REG_T1, 0, rs, ctx);
>   }
>   
> -static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, struct rv_jit_context *ctx)
> +static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
> +			     struct rv_jit_context *ctx)
>   {
> +	u8 code = insn->code;
> +	s32 imm = insn->imm;
> +	s16 off = insn->off;
> +
>   	switch (imm) {
>   	/* dst_reg = load_acquire(src_reg + off16) */
>   	case BPF_LOAD_ACQ:
> @@ -627,6 +632,12 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, struct rv_
>   			break;
>   		}
>   		emit_fence_r_rw(ctx);
> +
> +		/* If our next insn is a redundant zext, return 1 to tell
> +		 * build_body() to skip it.
> +		 */
> +		if (BPF_SIZE(code) != BPF_DW && insn_is_zext(&insn[1]))
> +			return 1;
>   		break;
>   	/* store_release(dst_reg + off16, src_reg) */
>   	case BPF_STORE_REL:
> @@ -654,10 +665,12 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, struct rv_
>   	return 0;
>   }
>   
> -static int emit_atomic_rmw(u8 rd, u8 rs, s16 off, s32 imm, u8 code,
> +static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
>   			   struct rv_jit_context *ctx)
>   {
> -	u8 r0;
> +	u8 r0, code = insn->code;
> +	s16 off = insn->off;
> +	s32 imm = insn->imm;
>   	int jmp_offset;
>   	bool is64;
>   
> @@ -2026,9 +2039,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	case BPF_STX | BPF_ATOMIC | BPF_W:
>   	case BPF_STX | BPF_ATOMIC | BPF_DW:
>   		if (bpf_atomic_is_load_store(insn))
> -			ret = emit_atomic_ld_st(rd, rs, off, imm, code, ctx);
> +			ret = emit_atomic_ld_st(rd, rs, insn, ctx);
>   		else
> -			ret = emit_atomic_rmw(rd, rs, off, imm, code, ctx);
> +			ret = emit_atomic_rmw(rd, rs, insn, ctx);
>   		break;
>   
>   	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index f8cd2f70a7fb..f6ca5cfa6b2f 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -26,9 +26,8 @@ static int build_body(struct rv_jit_context *ctx, bool extra_pass, int *offset)
>   		int ret;
>   
>   		ret = bpf_jit_emit_insn(insn, ctx, extra_pass);
> -		/* BPF_LD | BPF_IMM | BPF_DW: skip the next instruction. */
>   		if (ret > 0)
> -			i++;
> +			i++; /* skip the next instruction */
>   		if (offset)
>   			offset[i] = ctx->ninsns;
>   		if (ret < 0)

Reviewed-by: Pu Lehui <pulehui@huawei.com>

