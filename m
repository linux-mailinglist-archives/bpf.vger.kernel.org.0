Return-Path: <bpf+bounces-53440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23597A54032
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 02:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09563A17B0
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 01:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE9918DB1E;
	Thu,  6 Mar 2025 01:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6632AD13
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226226; cv=none; b=BwK8kuhZBaUjBUhA/pl0k80IjY5Rb2u18Ttn2oBD+cCOY2vWXFGosUNzqo4C9G627EUWdwydjwy0WcQQroOJT5BIBHNVs1p6AsxVx5eqXfHPICNciNBU9JZhgsyXcGxvl+1H83UAxfv56YVuf3l4YIg7eOHLIPdXuwFfjylcQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226226; c=relaxed/simple;
	bh=six3z/02m/Oglk+Yis2+uVB8ia5hkEdKppsbmE3JCtY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hYbTx3SizI2p5iCxswR7cA0Zxm6poT4+ZlhQ0s5Pcydg0T/DpKpwcqU/Qbt9gyfBTxh7+jtGgoAmUN2UTtlB2t4OzLmXkgGN04ykWJ5eN/P+JrREoy/1AAurvX7pnWtO+ypNyoq8EW4RVZ2RT9UsfvF9+wJZ/MO7BZdqLfvmilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z7XbG4DKKz4f3jtG
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 09:56:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 632861A06D7
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 09:56:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB32V3oAMlnjzauFg--.17844S2;
	Thu, 06 Mar 2025 09:56:59 +0800 (CST)
Subject: Re: [PATCH v4 2/3] selftests: bpf: add bpf_cpumask_fill selftests
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 tj@kernel.org, memxor@gmail.com
References: <20250305211235.368399-1-emil@etsalapatis.com>
 <20250305211235.368399-3-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7deb7f8c-d196-ac21-4857-9f8deb65b1f5@huaweicloud.com>
Date: Thu, 6 Mar 2025 09:56:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250305211235.368399-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB32V3oAMlnjzauFg--.17844S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw43Gr18Jw4DZrWxGryDWrg_yoW7KFy3pF
	W8XrWakFWUtF48Ww47XanrGFn8K34vq3Wvv3W5GryfAFy3Jrs7tr4jga4Utw43Wr1qk3Wx
	X3yqgrsFgw17CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/6/2025 5:12 AM, Emil Tsalapatis wrote:
> Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask to
> a bit pattern provided by a BPF program.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
>  .../selftests/bpf/progs/cpumask_success.c     | 114 ++++++++++++++++++
>  2 files changed, 152 insertions(+)

My local build failed due to the missed declaration of
"bpf_cpumask_populate" in cpumask_common.h. It reported the following error:

progs/cpumask_success.c:788:8: error: call to undeclared function
'bpf_cpumask_populate'; ISO C99 and later do not support implicit fun
ction declarations [-Wimplicit-function-declaration]
  788 |         ret = bpf_cpumask_populate((struct cpumask *)local,
&toofewbits, sizeof(toofewbits));

Don't know the reason why CI succeeded.

> diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
> index b40b52548ffb..8a2fd596c8a3 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
> @@ -222,3 +222,41 @@ int BPF_PROG(test_invalid_nested_array, struct task_struct *task, u64 clone_flag
>  
>  	return 0;
>  }
> +
> +SEC("tp_btf/task_newtask")
> +__failure __msg("type=scalar expected=fp")
> +int BPF_PROG(test_populate_invalid_destination, struct task_struct *task, u64 clone_flags)
> +{
> +	struct bpf_cpumask *invalid = (struct bpf_cpumask *)0x123456;
> +	u64 bits;
> +	int ret;
> +
> +	ret = bpf_cpumask_populate((struct cpumask *)invalid, &bits, sizeof(bits));
> +	if (!ret)
> +		err = 2;
> +
> +	return 0;
> +}
> +
> +SEC("tp_btf/task_newtask")
> +__failure __msg("leads to invalid memory access")
> +int BPF_PROG(test_populate_invalid_source, struct task_struct *task, u64 clone_flags)
> +{
> +	void *garbage = (void *)0x123456;
> +	struct bpf_cpumask *local;
> +	int ret;
> +
> +	local = create_cpumask();
> +	if (!local) {
> +		err = 1;
> +		return 0;
> +	}
> +
> +	ret = bpf_cpumask_populate((struct cpumask *)local, garbage, 8);
> +	if (!ret)
> +		err = 2;
> +
> +	bpf_cpumask_release(local);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
> index 80ee469b0b60..5dc0fe9940dc 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -757,6 +757,7 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
>  	mask1 = bpf_cpumask_create();
>  	mask2 = bpf_cpumask_create();
>  
> +
>  	if (!mask1 || !mask2)
>  		goto free_masks_return;

An extra newline.
>  
> @@ -770,3 +771,116 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
>  		bpf_cpumask_release(mask2);
>  	return 0;
>  }
> +
> +SEC("tp_btf/task_newtask")
> +__success

For tp_btf, bpf_prog_test_run() doesn't run the prog and it just returns
directly, therefore, the prog below is not exercised at all. How about
add test_populate_reject_small_mask into cpumask_success_testcases
firstly, then switch these test cases to use __success() in a following
patch ?
> +int BPF_PROG(test_populate_reject_small_mask, struct task_struct *task, u64 clone_flags)
> +{
> +	struct bpf_cpumask *local;
> +	u8 toofewbits;
> +	int ret;
> +
> +	local = create_cpumask();
> +	if (!local)
> +		return 0;
> +
> +	/* The kfunc should prevent this operation */
> +	ret = bpf_cpumask_populate((struct cpumask *)local, &toofewbits, sizeof(toofewbits));
> +	if (ret != -EACCES)
> +		err = 2;
> +
> +	bpf_cpumask_release(local);
> +
> +	return 0;
> +}
> +
> +/* Mask is guaranteed to be large enough for bpf_cpumask_t. */
> +#define CPUMASK_TEST_MASKLEN (sizeof(cpumask_t))
> +
> +/* Add an extra word for the test_populate_reject_unaligned test. */
> +u64 bits[CPUMASK_TEST_MASKLEN / 8 + 1];
> +extern bool CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS __kconfig __weak;
> +
> +SEC("tp_btf/task_newtask")
> +__success

Same for test_populate_reject_unaligned.
> +int BPF_PROG(test_populate_reject_unaligned, struct task_struct *task, u64 clone_flags)
> +{
> +	struct bpf_cpumask *mask;
> +	char *src;
> +	int ret;
> +
> +	/* Skip if unaligned accesses are fine for this arch.  */
> +	if (CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> +		return 0;
> +
> +	mask = bpf_cpumask_create();
> +	if (!mask) {
> +		err = 1;
> +		return 0;
> +	}
> +
> +	/* Misalign the source array by a byte. */
> +	src = &((char *)bits)[1];
> +
> +	ret = bpf_cpumask_populate((struct cpumask *)mask, src, CPUMASK_TEST_MASKLEN);
> +	if (ret != -EINVAL)
> +		err = 2;
> +
> +	bpf_cpumask_release(mask);
> +
> +	return 0;
> +}
> +
> +
> +SEC("tp_btf/task_newtask")
> +__success
> +int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
> +{
> +	struct bpf_cpumask *mask;
> +	bool bit;
> +	int ret;
> +	int i;
> +
> +	/* Set only odd bits. */
> +	__builtin_memset(bits, 0xaa, CPUMASK_TEST_MASKLEN);
> +
> +	mask = bpf_cpumask_create();
> +	if (!mask) {
> +		err = 1;
> +		return 0;
> +	}
> +
> +	/* Pass the entire bits array, the kfunc will only copy the valid bits. */
> +	ret = bpf_cpumask_populate((struct cpumask *)mask, bits, CPUMASK_TEST_MASKLEN);
> +	if (ret) {
> +		err = 2;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Test is there to appease the verifier. We cannot directly
> +	 * access NR_CPUS, the upper bound for nr_cpus, so we infer
> +	 * it from the size of cpumask_t.
> +	 */
> +	if (nr_cpus < 0 || nr_cpus >= CPUMASK_TEST_MASKLEN * 8) {
> +		err = 3;
> +		goto out;
> +	}
> +
> +	bpf_for(i, 0, nr_cpus) {
> +		/* Odd-numbered bits should be set, even ones unset. */
> +		bit = bpf_cpumask_test_cpu(i, (const struct cpumask *)mask);
> +		if (bit == (i % 2 != 0))
> +			continue;
> +
> +		err = 4;
> +		break;
> +	}
> +
> +out:
> +	bpf_cpumask_release(mask);
> +
> +	return 0;
> +}
> +
> +#undef CPUMASK_TEST_MASKLEN


