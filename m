Return-Path: <bpf+bounces-69347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A7B94CB1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE1D7AD646
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACE3314B9E;
	Tue, 23 Sep 2025 07:34:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EBD242938;
	Tue, 23 Sep 2025 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612883; cv=none; b=po0r8e9jKs2lJcaaGLmqVXh9AS+bZiynsZHSSgWkx6+0WSB9piQwuZEp4DVUlx7zNiB5UWeGwBGfQQLJHQ2e5VSP6f7CCvrRIqCF/2VfaboH4Jtsl/xNMU73brPFZK8OWhZ6uKXd0Tfth9dshXVRcj/TcMR5YooxI6GFLwwZlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612883; c=relaxed/simple;
	bh=hpwsI3FdxZKmmkhnouyPb8s1V33yJi/17bA4ZtYmFEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AAhS96OS+WZjnj5YE7SFH/MA1qahzcorZAMht9GbuoeZR6LCvSOug2+85fYA7/hEB2m2ZXiiNhz4Wn5Q3Ep10wiNWO36MjgVuIXL5QiJmuCrf5X+53kKdxkNi9a+DQV2uNL5o/9FiiXsucKLRhNn+NrPZ3QGtfyPsad70QU5yIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cWBYN6W1lztTWp;
	Tue, 23 Sep 2025 15:33:44 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id CF8AA1800B1;
	Tue, 23 Sep 2025 15:34:37 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 15:34:36 +0800
Message-ID: <97c8e410-5482-42cc-85e1-5c22bfd1d192@huawei.com>
Date: Tue, 23 Sep 2025 15:34:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] riscv: bpf: Fix uninitialized symbol 'retval_off'
Content-Language: en-US
To: Chenghao Duan <duanchenghao@kylinos.cn>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <bjorn@kernel.org>,
	<puranjay@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>
CC: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>, <alex@ghiti.fr>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250922062244.822937-1-duanchenghao@kylinos.cn>
 <20250922062244.822937-2-duanchenghao@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250922062244.822937-2-duanchenghao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/9/22 14:22, Chenghao Duan wrote:
> In the __arch_prepare_bpf_trampoline() function, retval_off is only
> meaningful when save_ret is true, so the current logic is correct.
> However, in the original logic, retval_off is only initialized under
> certain conditions; for example, in the fmod_ret logic, the compiler is
> not aware that the flags of the fmod_ret program (prog) have set
> BPF_TRAMP_F_CALL_ORIG, which results in an uninitialized symbol
> compilation warning.
> 
> So initialize retval_off unconditionally to fix it.
> 
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 9883a55d61b5..8475a8ab5715 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	stack_size += 16;
>   
>   	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> -	if (save_ret) {
> +	if (save_ret)
>   		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
> -		retval_off = stack_size;
> -	}
> +	retval_off = stack_size;
>   
>   	stack_size += nr_arg_slots * 8;
>   	args_off = stack_size;

Reviewed-by: Pu Lehui <pulehui@huawei.com>

