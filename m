Return-Path: <bpf+bounces-65804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B05B28996
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 03:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CCD1C86F8F
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8AC136988;
	Sat, 16 Aug 2025 01:28:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629211114;
	Sat, 16 Aug 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307689; cv=none; b=BKaRLW018pQgrgeW5rttETH0KZjW6loOGtKt/0Ei41DRjVq2tf/JpVQ8ClEFRr152WMd2at4c2/998J65hj/6ZSzXl0638pZec8MQbHnGDepZbs9pVqpxj5YFRbSBvdn/fqNzQs5Rm3RdbcTuqUvB4MQ96AOLgdqwHmGD5QGG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307689; c=relaxed/simple;
	bh=2k0b29S8o863X0npYe699cUZ9vR4xXbB5aKgwrfhg1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cdhU9d5JYBDjhQKeC7jBUdxckS6c6dJ42AHyuTYLDgtaw/wI9ijciQk/8xubxuxih1cz9XkB+CvFtIJXK9HgKruGE5kcpmm6oL7itKwtfH1x7UgToAdqw6E34mLoclmbHofRntwChzRnU1NQkMMdti6jnhuqXR8gDkaRQKXmoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c3h7r48NhzdcBV;
	Sat, 16 Aug 2025 09:23:36 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 9918A1401E9;
	Sat, 16 Aug 2025 09:27:57 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 Aug 2025 09:27:56 +0800
Message-ID: <40d38745-a790-4f34-8eef-8038069b976d@huawei.com>
Date: Sat, 16 Aug 2025 09:27:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv, bpf: use lw when reading int cpu in
 BPF_MOV64_PERCPU_REG
Content-Language: en-US
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	<bpf@vger.kernel.org>
CC: <stable@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
 <20250812090256.757273-3-rkrcmar@ventanamicro.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250812090256.757273-3-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/8/12 17:02, Radim Krčmář wrote:
> emit_ld is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
> The struct currently has a hole after cpu, so little endian accesses
> seemed fine.
> 
> Fixes: 19c56d4e5be1 ("riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 10e01ff06312..6e1554d89681 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1356,7 +1356,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   				emit_mv(rd, rs, ctx);
>   #ifdef CONFIG_SMP
>   			/* Load current CPU number in T1 */
> -			emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu),
> +			emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu),
>   				RV_REG_TP, ctx);
>   			/* Load address of __per_cpu_offset array in T2 */
>   			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);

Reviewed-by: Pu Lehui <pulehui@huawei.com>

