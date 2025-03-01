Return-Path: <bpf+bounces-52949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D159A4A754
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 02:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A7A3BC77D
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078A134B0;
	Sat,  1 Mar 2025 01:16:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1C63A9
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740791773; cv=none; b=IqV95MpIoN9LGKwkbL2QwWdENC89eZ8Hn6IqRA1+iDqd4XyUSFWM1pziPbGh96IWQQRUJNeHaUTCBzhYRetNQFscgVFXJ23r5ZzQNACUQats/x4K92oLTo9bcGSC0RUj8IKpErW5ECN9bFmd8ZZvVmNMusUskDVO97xyW1d//nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740791773; c=relaxed/simple;
	bh=7sgyXyzJiNy0esD57o5hH108Ys+is2EH/DoK61+ePxQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jw2EAD24+yxj/eRN+XRFUIil9Kbuo43oQ6P+7aM1UsAtMkj2PL5iZL3bvk91d7N8rMzW6/zg4GCLZjDlon4WNcyiPmJOE8bKjH3rIH+9GExheRAWTbFVnoEQff4CWFwvtflFSkwFwzUxRCIHH2yx6/u1u783oX/F9QYXkQ4VUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z4Rw95N2Zz4f3lx6
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 09:15:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD24B1A0DF8
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 09:15:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgD3WF3LX8JnG_TFFA--.18865S2;
	Sat, 01 Mar 2025 09:15:59 +0800 (CST)
Subject: Re: [PATCH 2/2] selftests: bpf: add bpf_cpumask_fill selftests
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.de, eddyz87@gmail.com, yonghong.song@linux.dev
References: <20250228003321.1409285-1-emil@etsalapatis.com>
 <20250228003321.1409285-3-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <d75cc812-b622-c200-dcf3-a91bbea6a37c@huaweicloud.com>
Date: Sat, 1 Mar 2025 09:15:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250228003321.1409285-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgD3WF3LX8JnG_TFFA--.18865S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw43Gr18Jw4DZrW7ZFy7KFg_yoW7XF4xpF
	ykurZ8KFWIyF1xW3W7AanrAF95Ka1vvw4vvw1rZry5AF9rJr4kJr4IgF1UJ3yfGrWDCw1x
	Z39Fgr4agr4UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/28/2025 8:33 AM, Emil Tsalapatis wrote:
> Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask to
> a bit pattern provided by a BPF program.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  2 +
>  .../selftests/bpf/progs/cpumask_success.c     | 23 ++++++
>  .../selftests/bpf/progs/verifier_cpumask.c    | 77 +++++++++++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpumask.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 8a0e1ff8a2dc..4dd95e93bd7e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -23,6 +23,7 @@
>  #include "verifier_cgroup_storage.skel.h"
>  #include "verifier_const.skel.h"
>  #include "verifier_const_or.skel.h"
> +#include "verifier_cpumask.skel.h"
>  #include "verifier_ctx.skel.h"
>  #include "verifier_ctx_sk_msg.skel.h"
>  #include "verifier_d_path.skel.h"
> @@ -155,6 +156,7 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
>  void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
>  void test_verifier_const(void)                { RUN(verifier_const); }
>  void test_verifier_const_or(void)             { RUN(verifier_const_or); }
> +void test_verifier_cpumask(void)              { RUN(verifier_cpumask); }

Why is a new file necessary ? Is it more reasonable to add these success
and failure test cases in cpumask_success.c and cpumask_failure.c ?
>  void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
>  void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
>  void test_verifier_d_path(void)               { RUN(verifier_d_path); }
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
> index 80ee469b0b60..f252aa2f3090 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -770,3 +770,26 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
>  		bpf_cpumask_release(mask2);
>  	return 0;
>  }
> +
> +SEC("syscall")
> +__success
> +int BPF_PROG(test_fill_reject_small_mask)
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
> +	ret = bpf_cpumask_fill((struct cpumask *)local, &toofewbits, sizeof(toofewbits));
> +	if (ret != -EACCES)
> +		err = 2;

The check may not be true when running local with a smaller NR_CPUS. It
will be more reasonable to adjust the size according to the value of
nr_cpu_ids.
> +
> +	bpf_cpumask_release(local);
> +
> +	return 0;
> +}
> +
> diff --git a/tools/testing/selftests/bpf/progs/verifier_cpumask.c b/tools/testing/selftests/bpf/progs/verifier_cpumask.c
> new file mode 100644
> index 000000000000..bb84dd36beac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_cpumask.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#include "cpumask_common.h"
> +
> +#define CPUMASK_TEST_MASKLEN (8 * sizeof(u64))
> +
> +u64 bits[CPUMASK_TEST_MASKLEN];
> +
> +SEC("syscall")
> +__success
> +int BPF_PROG(test_cpumask_fill)
> +{
> +	struct bpf_cpumask *mask;
> +	int ret;
> +
> +	mask = bpf_cpumask_create();
> +	if (!mask) {
> +		err = 1;
> +		return 0;
> +	}
> +
> +	ret = bpf_cpumask_fill((struct cpumask *)mask, bits, CPUMASK_TEST_MASKLEN);
> +	if (!ret)
> +		err = 2;

It would be better to also test the cpu bits in the cpumask after
bpf_cpumask_fill() is expected.
> +
> +	if (mask)
> +		bpf_cpumask_release(mask);

The "if (mask)" check is unnecessary.
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("bpf_cpumask_fill: invalid cpumask target")
> +__failure __msg("type=scalar expected=fp")
> +int BPF_PROG(test_cpumask_fill_cpumask_invalid)
> +{
> +	struct bpf_cpumask *invalid = (struct bpf_cpumask *)0x123456;
> +	int ret;
> +
> +	ret = bpf_cpumask_fill((struct cpumask *)invalid, bits, CPUMASK_TEST_MASKLEN);
> +	if (!ret)
> +		err = 2;
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("bpf_cpumask_fill: invalid cpumask source")
> +__failure __msg("leads to invalid memory access")
> +int BPF_PROG(test_cpumask_fill_bpf_invalid)
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
> +	ret = bpf_cpumask_fill((struct cpumask *)local, garbage, CPUMASK_TEST_MASKLEN);
> +	if (!ret)
> +		err = 2;
> +
> +	bpf_cpumask_release(local);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";


