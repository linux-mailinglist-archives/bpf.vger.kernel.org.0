Return-Path: <bpf+bounces-26924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE048A6737
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88ABCB2121A
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84AD86657;
	Tue, 16 Apr 2024 09:35:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6F85952
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260142; cv=none; b=DDBZ6V0ZkT4uaWKBV9oW6Hy8iMd/aTgxLAySbpTUs1bP8ZdXlIJXI2aeLdKOHBGCy/6zo3PK4jQErhMQ3cf7pCVOc5Fw0mQ5uSxKOQLCVBTEpCjIW0K9cbI6qBXO1D+4EvF6w2IQlpQww/+Ql8EQXlT7gOgxqy/TFGZkIp87/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260142; c=relaxed/simple;
	bh=cL0PkvKYluUpzV4fWSrBYTXPiiBcxbvuNWi2nn4A5E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p/a8pczyORHZyCoaaoIl8F8UM1QxlvpXVItJPSSACuE6ZJ2jZOSrgDMc09a7sIhDnmMOusGbFLaY0FgRE/jAB/05fOAJeHhzBpF1zP9NfZ1djRKkBq6v/60WTMq6+T70waLjZk7FoEuIDX0PLkAMCkrl2mbKzfZMD6YGiG+kOEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VJf320VSzztRy8;
	Tue, 16 Apr 2024 17:32:46 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 33A07180080;
	Tue, 16 Apr 2024 17:35:37 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 17:35:36 +0800
Message-ID: <39b55f13-69a1-401e-b87e-1040e33c9368@huawei.com>
Date: Tue, 16 Apr 2024 17:35:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] riscv, bpf: Fix incorrect runtime stats
To: Xu Kuohai <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>
CC: Ivan Babrou <ivan@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20240416064208.2919073-1-xukuohai@huaweicloud.com>
 <20240416064208.2919073-3-xukuohai@huaweicloud.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240416064208.2919073-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)


On 2024/4/16 14:42, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> When __bpf_prog_enter() returns zero, the s1 register is not set to zero,
> resulting in incorrect runtime stats. Fix it by setting s1 immediately upon
> the return of __bpf_prog_enter().
> 
> Fixes: 49b5e77ae3e2 ("riscv, bpf: Add bpf trampoline support for RV64")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 15e482f2c657..e713704be837 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -730,6 +730,9 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
>   	if (ret)
>   		return ret;
>   
> +	/* store prog start time */
> +	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
> +
>   	/* if (__bpf_prog_enter(prog) == 0)
>   	 *	goto skip_exec_of_prog;
>   	 */
> @@ -737,9 +740,6 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
>   	/* nop reserved for conditional jump */
>   	emit(rv_nop(), ctx);
>   
> -	/* store prog start time */
> -	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
> -
>   	/* arg1: &args_off */
>   	emit_addi(RV_REG_A0, RV_REG_FP, -args_off, ctx);
>   	if (!p->jited)

Thanks.

Reviewed-by: Pu Lehui <pulehui@huawei.com>


