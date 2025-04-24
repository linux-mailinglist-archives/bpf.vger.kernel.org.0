Return-Path: <bpf+bounces-56569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682DFA99E5D
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 03:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EB07AB2B9
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021B1D5CE5;
	Thu, 24 Apr 2025 01:38:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61E1C8601
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458720; cv=none; b=KD9jd/Gi5nuc6jKORPSPUG67+imsp+UBBMHxW/mXM9/28eMsN56eOBQBiWpE4xPcggVGfV37/gfUbX+Wbgp41Y7ep8WUj8xnNf5QdKrV6cnqxWRTAtsd3bdx4auFy6iQK6a/IXKXCju+g8UAbjLswN5xyQqlomSLFYRZXmMXhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458720; c=relaxed/simple;
	bh=uwyL6Tc8tazVHX4LLcTl8e9uRjFucr6q5zKy0hIGRUk=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RjP1CEBNNObdnBw5FK+ebOuD7WiC7m2vl2in2LQfxfrO+4wJVPKJLbuhKjWFNMNGUc9Bf60yxXgreyqzLUxtkP+qUsUN+zQCOBNlketjR9/72ru2h9Ov9G2v+wWYp9TVWA4KuJ8X+6z4zq0xPEB4w0fTfYp7NE+1f0rlqTH0PFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZjdsG3bfbz4f3jY8
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 09:38:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7A5131A058E
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 09:38:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAnesQalgloXiDvKA--.44174S2;
	Thu, 24 Apr 2025 09:38:34 +0800 (CST)
Subject: Re: [PATCH v2 bpf 2/2] selftests/bpf: add test for softlock when
 modifying hashmap while iterating
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>, bpf@vger.kernel.org
References: <20250423171159.122478-1-brandon.kammerdiener@intel.com>
 <20250423171159.122478-3-brandon.kammerdiener@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ae6599f3-fbe6-8c79-eba2-c43e1461d814@huaweicloud.com>
Date: Thu, 24 Apr 2025 09:38:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250423171159.122478-3-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAnesQalgloXiDvKA--.44174S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy8Aw4kWw1rCryrZw13Arb_yoWrGw1kpa
	yjkFW3KF1fX3W7X343A343ZFsaqwsYqw15ZayxtryrJryDJrn7Xr4xKFnIgF95Ga98Zw1Y
	9a9agrsxW3yUXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 4/24/2025 1:12 AM, Brandon Kammerdiener wrote:
> Add test that modifies the map while it's being iterated in such a way that
> hangs the kernel thread unless the _safe fix is applied to
> bpf_for_each_hash_elem.
>
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>

Acked-by: Hou Tao <houtao1@huawei.com>

With some nits below.
> ---
>  .../selftests/bpf/prog_tests/for_each.c       | 37 +++++++++++++++++++
>  .../bpf/progs/for_each_hash_modify.c          | 30 +++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
> index 09f6487f58b9..f4092464d75e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/for_each.c
> +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
> @@ -6,6 +6,7 @@
>  #include "for_each_array_map_elem.skel.h"
>  #include "for_each_map_elem_write_key.skel.h"
>  #include "for_each_multi_maps.skel.h"
> +#include "for_each_hash_modify.skel.h"
>
>  static unsigned int duration;
>
> @@ -203,6 +204,40 @@ static void test_multi_maps(void)
>  	for_each_multi_maps__destroy(skel);
>  }
>
> +static void test_for_each_hash_modify(void)
> +{
> +	struct for_each_hash_modify *skel;
> +	int max_entries, i, err;
> +	__u64 key, val;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		.data_in = &pkt_v4,
> +		.data_size_in = sizeof(pkt_v4),
> +		.repeat = 1
> +	);
> +
> +	skel = for_each_hash_modify__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "for_each_hash_modify__open_and_load"))
> +		return;
> +
> +	max_entries = bpf_map__max_entries(skel->maps.hashmap);
> +	for (i = 0; i < max_entries; i++) {
> +		key = i;
> +		val = i;
> +		err = bpf_map__update_elem(skel->maps.hashmap, &key, sizeof(key),
> +					   &val, sizeof(val), BPF_ANY);
> +		if (!ASSERT_OK(err, "map_update"))
> +			goto out;
> +	}
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_access), &topts);
> +	ASSERT_OK(err, "bpf_prog_test_run_opts");

Also need to check topts.retval.
> +	duration = topts.duration;

The "duration = xx" statement is unnecessary for ASSERT_OK macro.
> +
> +out:
> +	for_each_hash_modify__destroy(skel);
> +}
> +
>  void test_for_each(void)
>  {
>  	if (test__start_subtest("hash_map"))
> @@ -213,4 +248,6 @@ void test_for_each(void)
>  		test_write_map_key();
>  	if (test__start_subtest("multi_maps"))
>  		test_multi_maps();
> +	if (test__start_subtest("for_each_hash_modify"))
> +		test_for_each_hash_modify();

Considering that all these tests are for_each test, I think it would be
better to rename the name of subtest to hash_modify just like other
tests case does.
>  }
> diff --git a/tools/testing/selftests/bpf/progs/for_each_hash_modify.c b/tools/testing/selftests/bpf/progs/for_each_hash_modify.c
> new file mode 100644
> index 000000000000..82307166f789
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/for_each_hash_modify.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Intel Corporation */
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 128);
> +	__type(key, __u64);
> +	__type(value, __u64);
> +} hashmap SEC(".maps");
> +
> +static int cb(struct bpf_map *map, __u64 *key, __u64 *val, void *arg)
> +{
> +	bpf_map_delete_elem(map, key);
> +	bpf_map_update_elem(map, key, val, 0);
> +	return 0;
> +}
> +
> +SEC("tc")
> +int test_pkt_access(struct __sk_buff *skb)
> +{
> +	(void)skb;
> +
> +	bpf_for_each_map_elem(&hashmap, cb, NULL, 0);
> +
> +	return 0;
> +}
> --
> 2.49.0
>
>
> .


