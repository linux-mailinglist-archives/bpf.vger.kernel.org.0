Return-Path: <bpf+bounces-57638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAEEAAD658
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F8B46472A
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF372116E9;
	Wed,  7 May 2025 06:42:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD41BD01D
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600158; cv=none; b=a/o9Zf52GQMjfuFT5p58KbdGbSe43sci2zYpMqA8Hbp0+CI5KUqbhc43iK46DwLLy5hLC0p/HNyoaVyd6PjGgvPYL0wxFKxBF5sS+LSQn1GuZnqC0kGjpyZ+Npy7IXJ/JXkeErx+H7AlfAmymooOcsfd/xkpbKCqfYNY0KAra3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600158; c=relaxed/simple;
	bh=EF5x5D9zmItYpAiCUD9w9tTgMEvRi90vJs1mX5pjG4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I41D8qBpsOolg9shgZ2QDzbZof6WEPb7I1zqCLK3QiWUXR5uszcIZFWjv/BgskBjPie67C6xt2jg9UGkbDCO+hffs/0a/q+WE1cAMdOLlpPMx9PKT4vXKS2+6X0nvHiJzUUkmpO74prV1wKIP2g6twfuZ61QeGIX2GqruO694Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zsly22qhpz1R7kw;
	Wed,  7 May 2025 14:40:26 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B20014027A;
	Wed,  7 May 2025 14:42:32 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 14:42:30 +0800
Message-ID: <3739f76d-ffe3-43b9-99ac-b121f85a2361@huawei.com>
Date: Wed, 7 May 2025 14:42:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/8] bpf/verifier: Handle BPF_LOAD_ACQ
 instructions in insn_def_regno()
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
References: <cover.1746588351.git.yepeilin@google.com>
 <09cb2aec979aaed9d16db41f0f5b364de39377c0.1746588351.git.yepeilin@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <09cb2aec979aaed9d16db41f0f5b364de39377c0.1746588351.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/5/7 11:42, Peilin Ye wrote:
> In preparation for supporting BPF load-acquire and store-release
> instructions for architectures where bpf_jit_needs_zext() returns true
> (e.g. riscv64), make insn_def_regno() handle load-acquires properly.
> 
> Acked-by: Björn Töpel <bjorn@kernel.org>
> Tested-by: Björn Töpel <bjorn@rivosinc.com> # QEMU/RVA23
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   kernel/bpf/verifier.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 99aa2c890e7b..28f5a7899bd6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3649,16 +3649,16 @@ static int insn_def_regno(const struct bpf_insn *insn)
>   	case BPF_ST:
>   		return -1;
>   	case BPF_STX:
> -		if ((BPF_MODE(insn->code) == BPF_ATOMIC ||
> -		     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) &&
> -		    (insn->imm & BPF_FETCH)) {
> +		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
> +		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
>   			if (insn->imm == BPF_CMPXCHG)
>   				return BPF_REG_0;
> -			else
> +			else if (insn->imm == BPF_LOAD_ACQ)
> +				return insn->dst_reg;
> +			else if (insn->imm & BPF_FETCH)
>   				return insn->src_reg;
> -		} else {
> -			return -1;
>   		}
> +		return -1;
>   	default:
>   		return insn->dst_reg;
>   	}

lgtm, thanks
Reviewed-by: Pu Lehui <pulehui@huawei.com>

