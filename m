Return-Path: <bpf+bounces-59055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80966AC5F50
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA151BA3C1A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194A1C8604;
	Wed, 28 May 2025 02:28:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630623D544
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399337; cv=none; b=mDzQOT0dzy1bwI12a8+oMdko1Jqw64dbsIwsz2isubPJ/p9P2lVb+86bXILXpl3ob4yGIKnHfmRE/6CK+eJShWsOM9WCrpFPnMkoPoSIPUUWL54gQvEs9QiWNw5ugQorF/zycjxf8OmoaS9/EUE/qom5PIKwfKUJMYYL/zBELfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399337; c=relaxed/simple;
	bh=OOfLUdkGKq1aH7sedKst34tJOTzg/fl11tB8zmH2no8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/4dGSSFBt2TZtbl347ge4hUt6/26zp4UJ0zB2JdaSDi/rkDRwZ978BCLblGBl/lar0F0Sth35BZ6UlbqBkrZS+Aa3LAn0BWIiRiqshDozF8fNCTtRVym9q4VRdU0Baev0OhpMY6E70hmarb1PX4/LZ8LqPHrrTpsVm/2aqqXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b6YMy2CwVzYQtpn
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 10:28:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6CFB41A07BB
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 10:28:45 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgCXoWTadDZoq5N+Ng--.64358S2;
	Wed, 28 May 2025 10:28:43 +0800 (CST)
Message-ID: <82d65377-2d00-4d1d-8312-c5a85c129c9b@huaweicloud.com>
Date: Wed, 28 May 2025 10:28:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, arm64: Remove unused-but-set function and
 variable.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 alexis.lothore@bootlin.com, kernel-team@fb.com
References: <20250528002704.21197-1-alexei.starovoitov@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250528002704.21197-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCXoWTadDZoq5N+Ng--.64358S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr13XFWfCFWUAF43ZryfXrb_yoW8tFWUpw
	43AwnxCr40qrWkWa4vqa1UAr15KF4DXr429FWUGFWFga90vryDWF1rKa1fCrWYy3yqka1r
	JF4Y9rn0yw1qv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 5/28/2025 8:27 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Remove unused-but-set function and variable to fix the build warning:
>     arch/arm64/net/bpf_jit_comp.c: In function 'arch_bpf_trampoline_size':
>>> arch/arm64/net/bpf_jit_comp.c:2547:6: warning: variable 'nregs' set but not used [-Wunused-but-set-variable]
>      2547 |  int nregs, ret;
>           |      ^~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505280643.h0qYcSCM-lkp@intel.com/
> Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 21 ++-------------------
>   1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index b5c3ab623536..14d4c6ac4ca0 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2520,21 +2520,6 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	return ctx->idx;
>   }
>   
> -static int btf_func_model_nregs(const struct btf_func_model *m)
> -{
> -	int nregs = m->nr_args;
> -	int i;
> -
> -	/* extra registers needed for struct argument */
> -	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
> -		/* The arg_size is at most 16 bytes, enforced by the verifier. */
> -		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> -			nregs += (m->arg_size[i] + 7) / 8 - 1;
> -	}
> -
> -	return nregs;
> -}
> -
>   int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   			     struct bpf_tramp_links *tlinks, void *func_addr)
>   {
> @@ -2543,10 +2528,8 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   		.idx = 0,
>   	};
>   	struct bpf_tramp_image im;
> -	struct arg_aux  aaux;
> -	int nregs, ret;
> -
> -	nregs = btf_func_model_nregs(m);
> +	struct arg_aux aaux;
> +	int ret;
>   
>   	ret = calc_arg_aux(m, &aaux);
>   	if (ret < 0)

Oops, sorry for not noticing that nregs is set but not used.

Now that the number of regs for both struct and non-struct
args is calculated in calc_arg_aux(), we can safely drop
btf_func_model_nregs().

Acked-by: Xu Kuohai <xukuohai@huawei.com>


