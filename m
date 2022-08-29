Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C35A50AD
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH2PvM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 11:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiH2PvK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 11:51:10 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB486C33
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 08:51:09 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSh2V-000FYg-V5; Mon, 29 Aug 2022 17:51:03 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSh2V-000Gwp-Em; Mon, 29 Aug 2022 17:51:03 +0200
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases for htab
 update
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220829023709.1958204-1-houtao@huaweicloud.com>
 <20220829023709.1958204-4-houtao@huaweicloud.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0d87fd92-3654-6185-e50e-664c1e35c7b2@iogearbox.net>
Date:   Mon, 29 Aug 2022 17:51:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220829023709.1958204-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/29/22 4:37 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> One test demonstrates the reentrancy of hash map update on the same
> bucket should fail, and another one shows concureently updates of
> the same hash map bucket should succeed and not fail due to
> the reentrancy checking for bucket lock.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   .../selftests/bpf/prog_tests/htab_update.c    | 126 ++++++++++++++++++
>   .../testing/selftests/bpf/progs/htab_update.c |  29 ++++
>   2 files changed, 155 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_update.c
>   create mode 100644 tools/testing/selftests/bpf/progs/htab_update.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> new file mode 100644
> index 000000000000..2bc85f4814f4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <test_progs.h>
> +#include "htab_update.skel.h"
> +
> +struct htab_update_ctx {
> +	int fd;
> +	int loop;
> +	bool stop;
> +};
> +
> +static void test_reenter_update(void)
> +{
> +	struct htab_update *skel;
> +	unsigned int key, value;
> +	int err;
> +
> +	skel = htab_update__open();
> +	if (!ASSERT_OK_PTR(skel, "htab_update__open"))
> +		return;
> +
> +	/* lookup_elem_raw() may be inlined and find_kernel_btf_id() will return -ESRCH */
> +	bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
> +	err = htab_update__load(skel);
> +	if (!ASSERT_TRUE(!err || err == -ESRCH, "htab_update__load") || err)
> +		goto out;
> +
> +	skel->bss->pid = getpid();
> +	err = htab_update__attach(skel);
> +	if (!ASSERT_OK(err, "htab_update__attach"))
> +		goto out;
> +
> +	/* Will trigger the reentrancy of bpf_map_update_elem() */
> +	key = 0;
> +	value = 0;
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, 0);
> +	if (!ASSERT_OK(err, "add element"))
> +		goto out;
> +
> +	ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> +out:
> +	htab_update__destroy(skel);
> +}
> +
> +static void *htab_update_thread(void *arg)
> +{
> +	struct htab_update_ctx *ctx = arg;
> +	cpu_set_t cpus;
> +	int i;
> +
> +	/* Pinned on CPU 0 */
> +	CPU_ZERO(&cpus);
> +	CPU_SET(0, &cpus);
> +	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
> +
> +	i = 0;
> +	while (i++ < ctx->loop && !ctx->stop) {
> +		unsigned int key = 0, value = 0;
> +		int err;
> +
> +		err = bpf_map_update_elem(ctx->fd, &key, &value, 0);
> +		if (err) {
> +			ctx->stop = true;
> +			return (void *)(long)err;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static void test_concurrent_update(void)
> +{
> +	struct htab_update_ctx ctx;
> +	struct htab_update *skel;
> +	unsigned int i, nr;
> +	pthread_t *tids;
> +	int err;
> +
> +	skel = htab_update__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "htab_update__open_and_load"))
> +		return;
> +
> +	ctx.fd = bpf_map__fd(skel->maps.htab);
> +	ctx.loop = 1000;
> +	ctx.stop = false;
> +
> +	nr = 4;
> +	tids = calloc(nr, sizeof(*tids));
> +	if (!ASSERT_NEQ(tids, NULL, "no mem"))
> +		goto out;
> +
> +	for (i = 0; i < nr; i++) {
> +		err = pthread_create(&tids[i], NULL, htab_update_thread, &ctx);
> +		if (!ASSERT_OK(err, "pthread_create")) {
> +			unsigned int j;
> +
> +			ctx.stop = true;
> +			for (j = 0; j < i; j++)
> +				pthread_join(tids[j], NULL);
> +			goto out;
> +		}
> +	}
> +
> +	for (i = 0; i < nr; i++) {
> +		void *thread_err = NULL;
> +
> +		pthread_join(tids[i], &thread_err);
> +		ASSERT_EQ(thread_err, NULL, "update error");
> +	}
> +
> +out:
> +	if (tids)
> +		free(tids);
> +	htab_update__destroy(skel);
> +}
> +
> +void test_htab_update(void)
> +{
> +	if (test__start_subtest("reenter_update"))
> +		test_reenter_update();
> +	if (test__start_subtest("concurrent_update"))
> +		test_concurrent_update();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/htab_update.c b/tools/testing/selftests/bpf/progs/htab_update.c
> new file mode 100644
> index 000000000000..7481bb30b29b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/htab_update.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +} htab SEC(".maps");
> +
> +int pid = 0;
> +int update_err = 0;
> +
> +SEC("?fentry/lookup_elem_raw")
> +int lookup_elem_raw(void *ctx)
> +{
> +	__u32 key = 0, value = 1;
> +
> +	if ((bpf_get_current_pid_tgid() >> 32) != pid)
> +		return 0;
> +
> +	update_err = bpf_map_update_elem(&htab, &key, &value, 0);
> +	return 0;
> +}

The test fails the CI on s390x, link:

https://github.com/kernel-patches/bpf/runs/8062792183?check_suite_focus=true

   All error logs:
   test_reenter_update:PASS:htab_update__open 0 nsec
   test_reenter_update:PASS:htab_update__load 0 nsec
   libbpf: prog 'lookup_elem_raw': failed to attach: ERROR: strerror_r(-524)=22
   libbpf: prog 'lookup_elem_raw': failed to auto-attach: -524
   test_reenter_update:FAIL:htab_update__attach unexpected error: -524 (errno 524)
   #83/1    htab_update/reenter_update:FAIL
   #83      htab_update:FAIL
   Summary: 189/973 PASSED, 27 SKIPPED, 1 FAILED

You'd have to add this to the s390 denylist, see also tools/testing/selftests/bpf/DENYLIST.s390x .
