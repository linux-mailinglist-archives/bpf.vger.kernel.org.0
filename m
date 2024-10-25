Return-Path: <bpf+bounces-43153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A968F9B01B8
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC7C1C22130
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AC11FCC65;
	Fri, 25 Oct 2024 11:53:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EC81B6D1E;
	Fri, 25 Oct 2024 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857227; cv=none; b=IPZXJvFRs0mwtOqBxKjn51pH9LA2HGEft2hSdW9ZXYrWR7WHUBzm7VGLA1Dn0WER5GmMHAHu/ROctOeJKx50dv65uve1vkJMrzQdb/Yrg4+V2QAfEoEH+qTCuT9HgchgfATbs9qNmGXd7lsWRMjrz5f0jRBuKr/T08UuiQvfzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857227; c=relaxed/simple;
	bh=E8IZjkPATRam4qXEyFXpRCwV1QVIYJ+/Ps3Uv3lW6VU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qv/7eHHFZRq4+1wCx/QwC5VdlXGZ2X8Pk+xl8cyht4ddti4x65f7/c1bXrdUiHH8sZRuAAb6WNLs5XXJMvqeDXN5OgNrh5G4c6UoSpZSGBW3HhP37VlDmV6cQ5a5W1USoS5l9WO7yTUmx0cXp5GEDyRYuoh6oaKMDgDYLMg0T7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZh4c6Ct9z4f3lgR;
	Fri, 25 Oct 2024 19:53:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 313071A018D;
	Fri, 25 Oct 2024 19:53:39 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgD3bSq_hhtne5XEEw--.21641S2;
	Fri, 25 Oct 2024 19:53:39 +0800 (CST)
Subject: Re: [PATCH] selftests/bpf: Add test for trie_get_next_key()
To: Byeonguk Jeong <jungbu2855@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <ZxoOdzdMwvLspZiq@localhost.localdomain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7affe124-770d-a31b-c588-4492e45297cc@huaweicloud.com>
Date: Fri, 25 Oct 2024 19:53:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZxoOdzdMwvLspZiq@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgD3bSq_hhtne5XEEw--.21641S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWxGFWktF1rXr18GrW3ZFb_yoWrXryfpF
	WrKa4DKrWfXF1UXa1rXa4xJFn0kr4xua1jvas5WryUG3sxtrnxAr4xKFWUCryfCrZ2qF43
	ua12g3s5trZFqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/24/2024 5:08 PM, Byeonguk Jeong wrote:
> Add a test for out-of-bounds write in trie_get_next_key() when a full
> path from root to leaf exists and bpf_map_get_next_key() is called
> with the leaf node. It may crashes the kernel on failure, so please
> run in a VM.
>
> Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
> ---
>  .../bpf/map_tests/lpm_trie_map_get_next_key.c | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
>
> diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
> new file mode 100644
> index 000000000000..85b916b69411
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * WARNING
> + * -------
> + *  This test suite may crash the kernel, thus should be run in a VM.
> + */
> +

The comments above are unnecessary, please remove it.
> +#define _GNU_SOURCE
> +#include <linux/bpf.h>
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +
> +#include <test_maps.h>
> +
> +struct test_lpm_key {
> +	__u32 prefix;
> +	__u32 data;
> +};
> +
> +struct get_next_key_ctx {
> +	struct test_lpm_key key;
> +	bool start;
> +	bool stop;
> +	int map_fd;
> +	int loop;
> +};
> +
> +static void *get_next_key_fn(void *arg)
> +{
> +	struct get_next_key_ctx *ctx = arg;
> +	struct test_lpm_key next_key;
> +	int i;

int i = 0;
> +
> +	while (!ctx->start)
> +		usleep(1);
> +
> +	while (!ctx->stop && i++ < ctx->loop)
> +		bpf_map_get_next_key(ctx->map_fd, &ctx->key, &next_key);
> +
> +	return NULL;
> +}
> +
> +static void abort_get_next_key(struct get_next_key_ctx *ctx, pthread_t *tids,
> +			       unsigned int nr)
> +{
> +	unsigned int i;
> +
> +	ctx->stop = true;
> +	ctx->start = true;
> +	for (i = 0; i < nr; i++)
> +		pthread_join(tids[i], NULL);
> +}
> +
> +/* This test aims to prevent regression of future. As long as the kernel does
> + * not panic, it is considered as success.
> + */
> +void test_lpm_trie_map_get_next_key(void)
> +{
> +#define MAX_NR_THREADS 256

Are 8 threads sufficient to reproduce the problem ?
> +	LIBBPF_OPTS(bpf_map_create_opts, create_opts,
> +		    .map_flags = BPF_F_NO_PREALLOC);
> +	struct test_lpm_key key = {};
> +	__u32 val = 0;
> +	int map_fd;
> +	const __u32 max_prefixlen = 8 * (sizeof(key) - sizeof(key.prefix));
> +	const __u32 max_entries = max_prefixlen + 1;
> +	unsigned int i, nr = MAX_NR_THREADS, loop = 4096;
> +	pthread_t tids[MAX_NR_THREADS];
> +	struct get_next_key_ctx ctx;
> +	int err;
> +
> +	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, "lpm_trie_map",
> +				sizeof(struct test_lpm_key), sizeof(__u32),
> +				max_entries, &create_opts);
> +	CHECK(map_fd == -1, "bpf_map_create(), error:%s\n",
> +	      strerror(errno));

CHECK(map_fd == -1, "bpf_map_create()", "error:%s\n", strerror(errno));
It seems you didn't build test it.
> +
> +	for (i = 0; i <= max_prefixlen; i++) {
> +		key.prefix = i;
> +		err = bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
> +		CHECK(err, "bpf_map_update_elem()", "error:%s\n",
> +		      strerror(errno));
> +	}
> +
> +	ctx.start = false;
> +	ctx.stop = false;
> +	ctx.map_fd = map_fd;
> +	ctx.loop = loop;
> +	memcpy(&ctx.key, &key, sizeof(key));
> +
> +	for (i = 0; i < nr; i++) {
> +		err = pthread_create(&tids[i], NULL, get_next_key_fn, &ctx);
> +		if (err) {
> +			abort_get_next_key(&ctx, tids, i);
> +			CHECK(err, "pthread_create", "error %d\n", err);
> +		}
> +	}
> +
> +	ctx.start = true;
> +	for (i = 0; i < nr; i++)
> +		pthread_join(tids[i], NULL);
> +
> +	printf("%s:PASS\n", __func__);
> +
> +	close(map_fd);
> +}


