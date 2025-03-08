Return-Path: <bpf+bounces-53632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50FEA5774E
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 02:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EDF3B3DBB
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED48876034;
	Sat,  8 Mar 2025 01:38:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B44EB38
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741397883; cv=none; b=IBdcH1X/4sN4bpo4bkYgs8WRk7quRLvBvFO2A/NuTN5PNZdZT/9SMEDphkBCCv7HoEgajllbU5WjjcBbQO9/C0TjUDVK8eTwFVDWqJ+5sObGm6C2y5dtO23OFuL7RhhNz9GZHLbK7UGslH/gfIubslqOiDqvoWalXKX1RXd0tok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741397883; c=relaxed/simple;
	bh=+9jTNp+YTh3dIKnRfH5yzESBm3KtFnUlXYqNxvHhpUE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c+3KD2GXidKMs9+4qmhAHZbzL3a6OYpsXw9L1kY71apWr8dz7WjVo2f4sRVXFcYBd1yvvody/6AolBDa15AoMbFoiN54G+V3BqKQzeH6ISDgVTrBtXtQrZ8YzJU8hLb9OYaGkAlw+GEBioFteHN6I9UCJUL5jaGWoyNvCSLWEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z8m4L5ZHQz4f3jLs
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 09:37:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A43E81A10EA
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 09:37:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAXIGNwn8tnfutRFw--.13944S2;
	Sat, 08 Mar 2025 09:37:55 +0800 (CST)
Subject: Re: [PATCH v6 2/4] selftests: bpf: add bpf_cpumask_populate selftests
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 tj@kernel.org, memxor@gmail.com
References: <20250307153847.8530-1-emil@etsalapatis.com>
 <20250307153847.8530-3-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e47ddddc-f25d-cbf1-e9ef-0953a4b499b6@huaweicloud.com>
Date: Sat, 8 Mar 2025 09:37:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307153847.8530-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAXIGNwn8tnfutRFw--.13944S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4kZrW7JF4xGFWkZFyUtrb_yoWrAFy8pa
	ykX3yYkFWxtFsrW3W7JwsruFW5W3WvganYkw15Gry3Ar9rJ3s7Jr1IgF1UJrnxWrZY9F1f
	Za4qgrZ8Ww48AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UQ6p9UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/7/2025 11:38 PM, Emil Tsalapatis wrote:
> Add selftests for the bpf_cpumask_populate helper that sets a
> bpf_cpumask to a bit pattern provided by a BPF program.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/prog_tests/cpumask.c        |   3 +
>  .../selftests/bpf/progs/cpumask_common.h      |   1 +
>  .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
>  .../selftests/bpf/progs/cpumask_success.c     | 110 ++++++++++++++++++
>  4 files changed, 152 insertions(+)
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
> index 80ee469b0b60..23ef2737af50 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -770,3 +770,113 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
>  		bpf_cpumask_release(mask2);
>  	return 0;
>  }
> +
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_populate_reject_small_mask, struct task_struct *task, u64 clone_flags)
> +{
> +	struct bpf_cpumask *local;
> +	u8 toofewbits;
> +	int ret;
> +

Sorry for bringing up it so later. It seems it is better to add an
is_test_task() check for these success tests.


