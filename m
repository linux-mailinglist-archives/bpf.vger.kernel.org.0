Return-Path: <bpf+bounces-28688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5548BD19D
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1270228488F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A9E155341;
	Mon,  6 May 2024 15:38:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3412F2C;
	Mon,  6 May 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009893; cv=none; b=G80LFLcFA5GpznApt0t8XDPOu1Svq29vWg6nh5XZ7ptJDKDx9xlJUN3eD02nZ5uzEHiU50SfUDfNlO0IcqLIF8pnNC4wkiFzEGKf0PWxMBF5jquOkczO9Bkm6mjbKH+lHIwZX+sPF7PSAZ95GctSBMpiRoEVScjgMASLZ8IC/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009893; c=relaxed/simple;
	bh=KsKttnModc95STUcrfxqiV25av+zrqovFOTXQe8hQ6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uoB4OB/E1RFaThb/JWBHkue8YUGjKqwn/UH2GQ0cywH49trlf6F+wi6pK+y3ME4KzFhtJLbkc8oAT9jwVjdEYYxfOMyVnoY8R85Yeg42Ac5l21icZ21tZYj/YCD3ROaAzfHnryuNK+98N6Au/I8W/NMHuet4rmYaApHTfIOXPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VY5893TxrzNw6Y;
	Mon,  6 May 2024 23:35:21 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AE2218007D;
	Mon,  6 May 2024 23:38:06 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 6 May 2024 23:38:05 +0800
Message-ID: <5df237e2-5bfd-4f31-a168-abfbf7808822@huawei.com>
Date: Mon, 6 May 2024 23:38:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] riscv, bpf: make some atomic operations fully ordered
To: Puranjay Mohan <puranjay@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <puranjay12@gmail.com>
References: <20240505201633.123115-1-puranjay@kernel.org>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240505201633.123115-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2024/5/6 4:16, Puranjay Mohan wrote:
> The BPF atomic operations with the BPF_FETCH modifier along with
> BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT implements
> all atomic operations except BPF_CMPXCHG with relaxed ordering.
> 
> Section 8.1 of the "The RISC-V Instruction Set Manual Volume I:
> Unprivileged ISA" [1], titled, "Specifying Ordering of Atomic
> Instructions" says:
> 
> | To provide more efficient support for release consistency [5], each
> | atomic instruction has two bits, aq and rl, used to specify additional
> | memory ordering constraints as viewed by other RISC-V harts.
> 
> and
> 
> | If only the aq bit is set, the atomic memory operation is treated as
> | an acquire access.
> | If only the rl bit is set, the atomic memory operation is treated as a
> | release access.
> |
> | If both the aq and rl bits are set, the atomic memory operation is
> | sequentially consistent.
> 
> Fix this by setting both aq and rl bits as 1 for operations with
> BPF_FETCH and BPF_XCHG.
> 
> [1] https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf
> 
> Fixes: dd642ccb45ec ("riscv, bpf: Implement more atomic operations for RV64")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index ec9d692838fc..fb5d1950042b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -498,33 +498,33 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
>   		break;
>   	/* src_reg = atomic_fetch_<op>(dst_reg + off16, src_reg) */
>   	case BPF_ADD | BPF_FETCH:
> -		emit(is64 ? rv_amoadd_d(rs, rs, rd, 0, 0) :
> -		     rv_amoadd_w(rs, rs, rd, 0, 0), ctx);
> +		emit(is64 ? rv_amoadd_d(rs, rs, rd, 1, 1) :
> +		     rv_amoadd_w(rs, rs, rd, 1, 1), ctx);
>   		if (!is64)
>   			emit_zextw(rs, rs, ctx);
>   		break;
>   	case BPF_AND | BPF_FETCH:
> -		emit(is64 ? rv_amoand_d(rs, rs, rd, 0, 0) :
> -		     rv_amoand_w(rs, rs, rd, 0, 0), ctx);
> +		emit(is64 ? rv_amoand_d(rs, rs, rd, 1, 1) :
> +		     rv_amoand_w(rs, rs, rd, 1, 1), ctx);
>   		if (!is64)
>   			emit_zextw(rs, rs, ctx);
>   		break;
>   	case BPF_OR | BPF_FETCH:
> -		emit(is64 ? rv_amoor_d(rs, rs, rd, 0, 0) :
> -		     rv_amoor_w(rs, rs, rd, 0, 0), ctx);
> +		emit(is64 ? rv_amoor_d(rs, rs, rd, 1, 1) :
> +		     rv_amoor_w(rs, rs, rd, 1, 1), ctx);
>   		if (!is64)
>   			emit_zextw(rs, rs, ctx);
>   		break;
>   	case BPF_XOR | BPF_FETCH:
> -		emit(is64 ? rv_amoxor_d(rs, rs, rd, 0, 0) :
> -		     rv_amoxor_w(rs, rs, rd, 0, 0), ctx);
> +		emit(is64 ? rv_amoxor_d(rs, rs, rd, 1, 1) :
> +		     rv_amoxor_w(rs, rs, rd, 1, 1), ctx);
>   		if (!is64)
>   			emit_zextw(rs, rs, ctx);
>   		break;
>   	/* src_reg = atomic_xchg(dst_reg + off16, src_reg); */
>   	case BPF_XCHG:
> -		emit(is64 ? rv_amoswap_d(rs, rs, rd, 0, 0) :
> -		     rv_amoswap_w(rs, rs, rd, 0, 0), ctx);
> +		emit(is64 ? rv_amoswap_d(rs, rs, rd, 1, 1) :
> +		     rv_amoswap_w(rs, rs, rd, 1, 1), ctx);
>   		if (!is64)
>   			emit_zextw(rs, rs, ctx);
>   		break;

Reviewed-by: Pu Lehui <pulehui@huawei.com>

