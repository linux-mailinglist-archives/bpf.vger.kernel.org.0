Return-Path: <bpf+bounces-53564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1BA566DA
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 12:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CCA3AB0BC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826C21885A;
	Fri,  7 Mar 2025 11:35:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB51217F5C
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347306; cv=none; b=Iexx/7QWaii7vgb0sw94J4+jMdFJWy0sQwmg+CMwzx5blp5xo1pdPisghSZ6a4tjOefSIANPPznQKVybrAORoJq1wQjf/HLqGiZC/z4GtWg/tM3YF6AxqQKmuJ6a9sE9dmNmlZn/i25Y6lBFLOfcp9pGaOS4tcXIeAd3U64x0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347306; c=relaxed/simple;
	bh=xWsYkbg+rxZHEvRwuWr0xp7+H4qeZT65KKMmMiqPyuE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RtKjVteTCKIltLnkeyZhJp0s7gR1P7qMFLbbr9P7NkoTttx1sREFLK5bLsTuQhRkhFpbMtAmKaQ41OHNqR2biCABD+s/WorWEBCkYjfWcyaE9OZjy4y5HVyWc3GZw+VxeVKFRdtx0qQ9GInhUF/FjWsoUuPeunJaNKUDfwZZyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z8PMd1l66z4f3jMx
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 19:34:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6F1C81A058E
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 19:34:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXOV7f2cpne0E1Fw--.26835S2;
	Fri, 07 Mar 2025 19:34:59 +0800 (CST)
Subject: Re: [PATCH v5 2/4] selftests: bpf: add bpf_cpumask_fill selftests
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 tj@kernel.org, memxor@gmail.com
References: <20250307041738.6665-1-emil@etsalapatis.com>
 <20250307041738.6665-3-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <410954bb-167e-4e33-196d-799bbdacafb1@huaweicloud.com>
Date: Fri, 7 Mar 2025 19:34:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307041738.6665-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDXOV7f2cpne0E1Fw--.26835S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43uF48WFyxKr1xKw1kGrg_yoW5XF15pa
	ykZ3yjkFWxtFs7W3W7J39rWFy5W3WvganYyw18Kr9rur9xJ3s7Xr1IgF17Jr98WrZY9rn5
	Za4qgrZ3Ww48ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/7/2025 12:17 PM, Emil Tsalapatis wrote:
> Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask to
> a bit pattern provided by a BPF program.

bpf_cpumask_populate instead of bpf_cpumask_fill ?
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/prog_tests/cpumask.c        |   3 +
>  .../selftests/bpf/progs/cpumask_common.h      |   1 +
>  .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
>  .../selftests/bpf/progs/cpumask_success.c     | 113 ++++++++++++++++++
>  4 files changed, 155 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> index e58a04654238..9b09beba988b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> @@ -25,6 +25,9 @@ static const char * const cpumask_success_testcases[] = {
>  	"test_global_mask_nested_deep_rcu",
>  	"test_global_mask_nested_deep_array_rcu",
>  	"test_cpumask_weight",
> +	"test_populate_reject_small_mask",
> +	"test_populate_reject_unaligned",
> +	"test_populate",
>  };
>  
>  static void verify_success(const char *prog_name)
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
> index 4ece7873ba60..86085b79f5ca 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_common.h
> +++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
> @@ -61,6 +61,7 @@ u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym __weak;
>  u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
>  				   const struct cpumask *src2) __ksym __weak;
>  u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym __weak;
> +int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__sz) __ksym __weak;
>  
>  void bpf_rcu_read_lock(void) __ksym __weak;
>  void bpf_rcu_read_unlock(void) __ksym __weak;

SNIP
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
> index 80ee469b0b60..51f3dcf8869f 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -770,3 +770,116 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
>  		bpf_cpumask_release(mask2);
>  	return 0;
>  }
> +
> +SEC("tp_btf/task_newtask")
> +__success

Why add __success annotation here ? It is unnecessary and will lead to
double run as you had noticed.


