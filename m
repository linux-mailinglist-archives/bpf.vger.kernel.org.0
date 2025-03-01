Return-Path: <bpf+bounces-52948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5558EA4A740
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EA17AA1EC
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027B1B95B;
	Sat,  1 Mar 2025 00:56:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF25BA3D
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790609; cv=none; b=eqi6qDKYcnNrp2vvu2syhrA8gI7JDuBWoURWDToLlN3uI9hiFm/qijiOGy9inX0LpvU5EI7Qlbebq68YXd1tyyrthNaCX6JsXazgtX6LrmWqXRjjxdEojw2RQkWANZ5YSLBIFiYDYRVcSLP1b5MhGXby/zZyTpumtBUb0dizJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790609; c=relaxed/simple;
	bh=PCkU1W7QZe8ya7OlFFVfXtJFTVJbbHq2i1dIooZXPWU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZNo3nZhwdCJRjF6o9CQqD0Zq3ERsqjHqmnBhl3+KTkziycYWSxn9goqIaKERL232dawguI1CnssHWnBwmWsVkgkIPSxA7j9NaJXnKF2KSMtMKcYfq3q77PfL0G+SKaCBzRTV9YluDUw3sw+e6U0JmpTwLy9FEaOs48EENWzkNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z4RTs0PWbz4f3lg7
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 08:56:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6F1141A018D
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 08:56:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDHd3hEW8JnScB_FA--.49340S2;
	Sat, 01 Mar 2025 08:56:40 +0800 (CST)
Subject: Re: [PATCH 1/2] bpf: add kfunc for populating cpumask bits
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.de, eddyz87@gmail.com, yonghong.song@linux.dev
References: <20250228003321.1409285-1-emil@etsalapatis.com>
 <20250228003321.1409285-2-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9c51ec81-d7e3-679e-055d-8f82a73766ef@huaweicloud.com>
Date: Sat, 1 Mar 2025 08:56:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250228003321.1409285-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDHd3hEW8JnScB_FA--.49340S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4ftFy3WrWUtrW5ZFyxZrb_yoW8Cryxpr
	1UJrWjkrW8t393Ww47J3WUGrn8G34vqwn293ZrCry5CFW2qwn5Jr1DXF1UX343Wr1DCr1U
	JryqqFWS9w17XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/28/2025 8:33 AM, Emil Tsalapatis wrote:
> Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF
> memory.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  kernel/bpf/cpumask.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index cfa1c18e3a48..a13839b3595f 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -420,6 +420,26 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
>  	return cpumask_weight(cpumask);
>  }
>  
> +/**
> + * bpf_cpumask_fill() - Populate the CPU mask from the contents of
> + * a BPF memory region.
> + *
> + * @cpumask: The cpumask being populated.
> + * @src: The BPF memory holding the bit pattern.
> + * @src__sz: Length of the BPF memory region in bytes.
> + *
> + */
> +__bpf_kfunc int bpf_cpumask_fill(struct cpumask *cpumask, void *src, size_t src__sz)
> +{
> +	/* The memory region must be large enough to populate the entire CPU mask. */
> +	if (src__sz < BITS_TO_BYTES(nr_cpu_ids))
> +		return -EACCES;
> +
> +	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);

Should we use src__sz < bitmap_size(nr_cpu_ids) instead ? Because in
bitmap_copy(), it assumes the size of src should be bitmap_size(nr_cpu_ids).
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
> @@ -448,6 +468,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> +BTF_ID_FLAGS(func, bpf_cpumask_fill, KF_RCU)
>  BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
>  
>  static const struct btf_kfunc_id_set cpumask_kfunc_set = {


