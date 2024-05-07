Return-Path: <bpf+bounces-28813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1778BE217
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B2228AFE3
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE31591E0;
	Tue,  7 May 2024 12:29:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F606156F39;
	Tue,  7 May 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084988; cv=none; b=gAlbsVnJ2dVJNmAP0SVdnhRvhV3my4w2A5IVCFoWJdHQo64i9/A5d29ACYxPxUIpYDtPCK6yNgLEklezCWjeRKh4ZgfFO1ijIAp3VoSbMRjBH35cyZO+KXND3+LjCLewuiHxyPxo+uOAWJhCvuG6XI8Et1x0NKozSdQZJdnCYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084988; c=relaxed/simple;
	bh=4oCXAkortoZz5MKblMkS8hnBvExAvAdJa4IbY8ib7ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WTmAesinySWtnWwgl+dcg4EyAouLSVMkfO0mRZxLXG1ae5uhNecttdL0H0RENwWP4ODvVlltFLlWBv4+mTCkbeaByk5lt80tOvmkPmnGA6dWHZx4MFj958HEa6vM/hLW3Yqswt1gChRUtKGtRiGcVZfwzQuHD0aRg+XPOhlcZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VYcvb2m0yzvRyB;
	Tue,  7 May 2024 20:26:19 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A31618007D;
	Tue,  7 May 2024 20:29:38 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 20:29:37 +0800
Message-ID: <b83c2369-eb9a-435c-8530-52a26dc39c09@huawei.com>
Date: Tue, 7 May 2024 20:29:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Fix typo in comment
Content-Language: en-US
To: Xiao Wang <xiao.w.wang@intel.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <luke.r.nels@gmail.com>,
	<xi.wang@gmail.com>, <bjorn@kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <haicheng.li@intel.com>
References: <20240507111618.437121-1-xiao.w.wang@intel.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240507111618.437121-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2024/5/7 19:16, Xiao Wang wrote:
> We can use either "instruction" or "insn" in the comment.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>   arch/riscv/net/bpf_jit.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 18a7885ba95e..c1b6b44a2f49 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -611,7 +611,7 @@ static inline u32 rv_nop(void)
>   	return rv_i_insn(0, 0, 0, 0, 0x13);
>   }
>   
> -/* RVC instrutions. */
> +/* RVC instructions. */
>   
>   static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
>   {
> @@ -740,7 +740,7 @@ static inline u16 rvc_swsp(u32 imm8, u8 rs2)
>   	return rv_css_insn(0x6, imm, rs2, 0x2);
>   }
>   
> -/* RVZBB instrutions. */
> +/* RVZBB instructions. */
>   static inline u32 rvzbb_sextb(u8 rd, u8 rs1)
>   {
>   	return rv_i_insn(0x604, rs1, 1, rd, 0x13);

Reviewed-by: Pu Lehui <pulehui@huawei.com>

