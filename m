Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576EB6F35C5
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjEASYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEASY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 14:24:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174B13A
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 11:24:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5212ed3b16eso1412309a12.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682965467; x=1685557467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cyrzpNd2c7gaAc1oqSQMCJ/QolEeldozvBNnNDOj5+k=;
        b=DnMY79noAMZIEFpsM9pUvkEx9VQrcYI7ZgXuwAZe/6MRVZwg67HZZ2xGA/xDrSmTe6
         i1HnMBO11JNO+uCVVpamxgYEevzdkhCcg8W+u1qdbCo2/mzJp/FEX70WQ1AL5A6WYt07
         b+fVedP5jKqEp+5+UusMciMzMVzjyVyebfXoxCnb92jSCWFueAnNVns9gjkXX4yN3qK+
         QIbEaJM0POirhLdp8IWWJcq7Fa9W/l7Oq/ruzHpBBM5kkCrRIejrS2nKc12MH0BwvFh+
         EihglQAPh+rsYm9LSrFOCPnfcsexYH0t/0XvhXirRHZE8A6GfsTmj5vYaIo5H5+1v2Lf
         GxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682965467; x=1685557467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyrzpNd2c7gaAc1oqSQMCJ/QolEeldozvBNnNDOj5+k=;
        b=LrLoGCyFaUP7d/zIMsHaqoH54+y7FUtUWOVrJjhMl4VbAgrP/6O6gm2rw6WxTexS6C
         W5MCAXYa2rjUTmhdF+zTk/ck3+lnJVe4+gG8vlhNAwmMXzYr/Ui/lXjAXacRtl37Ztkq
         pJwhzJOwtBei6w9A+PUBakOFFxK0gsBGlyEiVCdFksE8YRvxTxy/UOm8Ge86MUReOviX
         +OgqEIwN2DUZ9LMFDBOui9MZ4DSUBIDmhIPfgLeVEb4mg1ZPAOMJ248luE25n9wljzw2
         RSSZLb/AlFR0CP6n3PyxZ/RMOLfsWjn/7ac4rYEB7Z6n49tyV4DjXV/n3nltfJPlFYK+
         84/A==
X-Gm-Message-State: AC+VfDwB+Z7NgdIQLC6jsSs63uf53fXI4+12+EzJFNIyIi7GOOu36rGT
        fe5xsZQr9Bzrfpcx29XM/enN4j8=
X-Google-Smtp-Source: ACHHUZ5k8XHiSx38IGdzelrOQdr6EpI+VwPDu+FizVXuTdxTdtO5JmwmqaS+ybW4TMmPogpLe8VpFok=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6904:0:b0:51b:500e:55d3 with SMTP id
 e4-20020a636904000000b0051b500e55d3mr3622469pgc.6.1682965467155; Mon, 01 May
 2023 11:24:27 -0700 (PDT)
Date:   Mon, 1 May 2023 11:24:25 -0700
In-Reply-To: <20230428222754.183432-3-inwardvessel@gmail.com>
Mime-Version: 1.0
References: <20230428222754.183432-1-inwardvessel@gmail.com> <20230428222754.183432-3-inwardvessel@gmail.com>
Message-ID: <ZFAD2VKGJWGUnxHb@google.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: selftests for resizing datasec maps
From:   Stanislav Fomichev <sdf@google.com>
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/28, JP Kobryn wrote:
> This patch adds test coverage for resizing datasec maps. There are two
> tests which run a bpf program that sums the elements in the datasec array.
> After the datasec array is resized, each elements is assigned a value of 1
> so that the sum will be equal to the length of the array. Assertions are
> done to verify this. The first test attempts to resize to an aligned
> length while the second attempts to resize to a mis-aligned length where
> rounding up is expected to occur. The third test attempts to resize maps
> that do not meet the necessary criteria and assertions are done to confirm
> error codes are returned.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  .../bpf/prog_tests/global_map_resize.c        | 187 ++++++++++++++++++
>  .../bpf/progs/test_global_map_resize.c        |  33 ++++
>  2 files changed, 220 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_resize.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_resize.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
> new file mode 100644
> index 000000000000..f38df37664a7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +#include "test_global_map_resize.skel.h"
> +#include "test_progs.h"
> +
> +static void run_program(void)
> +{
> +	(void)syscall(__NR_getpid);
> +}
> +
> +static int setup(struct test_global_map_resize **skel)
> +{
> +	if (!skel)
> +		return -1;
> +
> +	*skel = test_global_map_resize__open();
> +	if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
> +		return -1;
> +
> +	(*skel)->rodata->pid = getpid();
> +
> +	return 0;
> +}
> +
> +static void teardown(struct test_global_map_resize **skel)
> +{
> +	if (skel && *skel)
> +		test_global_map_resize__destroy(*skel);
> +}
> +
> +static int resize_test(struct test_global_map_resize *skel,
> +		__u32 element_sz, __u32 desired_sz)
> +{
> +	int ret = 0;
> +	struct bpf_map *map;
> +	__u32 initial_sz, actual_sz;
> +	size_t nr_elements;
> +	int *initial_val;
> +	size_t initial_val_sz;
> +
> +	map = skel->maps.data_my_array;
> +
> +	initial_sz = bpf_map__value_size(map);
> +	ASSERT_EQ(initial_sz, element_sz, "initial size");
> +
> +	/* round up desired size to align with element size */
> +	desired_sz = roundup(desired_sz, element_sz);
> +	ret = bpf_map__set_value_size(map, desired_sz);
> +	if (!ASSERT_OK(ret, "bpf_map__set_value_size"))
> +		return ret;
> +
> +	/* refresh map pointer to avoid invalidation issues */
> +	map = skel->maps.data_my_array;
> +
> +	actual_sz = bpf_map__value_size(map);
> +	ASSERT_EQ(actual_sz, desired_sz, "resize");
> +
> +	/* set the expected number of elements based on the resized array */
> +	nr_elements = roundup(actual_sz, element_sz) / element_sz;
> +	skel->rodata->n = nr_elements;
> +
> +	/* create array for initial map value */
> +	initial_val_sz = element_sz * nr_elements;
> +	initial_val = malloc(initial_val_sz);
> +	if (!ASSERT_OK_PTR(initial_val, "malloc initial_val")) {
> +		ret = -ENOMEM;
> +
> +		goto cleanup;
> +	}
> +
> +	/* fill array with ones */
> +	for (int i = 0; i < nr_elements; ++i)
> +		initial_val[i] = 1;
> +
> +	/* set initial value */
> +	ASSERT_EQ(initial_val_sz, actual_sz, "initial value size");
> +
> +	ret = bpf_map__set_initial_value(map, initial_val, initial_val_sz);
> +	if (!ASSERT_OK(ret, "bpf_map__set_initial_val"))
> +		goto cleanup;
> +
> +	ret = test_global_map_resize__load(skel);
> +	if (!ASSERT_OK(ret, "test_global_map_resize__load"))
> +		goto cleanup;
> +
> +	ret = test_global_map_resize__attach(skel);
> +	if (!ASSERT_OK(ret, "test_global_map_resize__attach"))
> +		goto cleanup;
> +
> +	/* run the bpf program which will sum the contents of the array */
> +	run_program();
> +
> +	if (!ASSERT_EQ(skel->bss->sum, nr_elements, "sum"))
> +		goto cleanup;
> +
> +cleanup:
> +	if (initial_val)
> +		free(initial_val);
> +
> +	return ret;
> +}
> +
> +static void global_map_resize_aligned_subtest(void)
> +{
> +	struct test_global_map_resize *skel;
> +	const __u32 element_sz = (__u32)sizeof(int);
> +	const __u32 desired_sz = (__u32)sysconf(_SC_PAGE_SIZE) * 2;
> +
> +	/* preliminary check that desired_sz aligns with element_sz */
> +	if (!ASSERT_EQ(desired_sz % element_sz, 0, "alignment"))
> +		return;
> +
> +	if (setup(&skel))
> +		goto teardown;
> +
> +	if (resize_test(skel, element_sz, desired_sz))
> +		goto teardown;
> +
> +teardown:
> +	teardown(&skel);
> +}
> +
> +static void global_map_resize_roundup_subtest(void)
> +{
> +	struct test_global_map_resize *skel;
> +	const __u32 element_sz = (__u32)sizeof(int);
> +	/* set desired size a fraction of element size beyond an aligned size */
> +	const __u32 desired_sz = (__u32)sysconf(_SC_PAGE_SIZE) * 2 + element_sz / 2;
> +
> +	/* preliminary check that desired_sz does NOT align with element_sz */
> +	if (!ASSERT_NEQ(desired_sz % element_sz, 0, "alignment"))
> +		return;
> +
> +	if (setup(&skel))
> +		goto teardown;
> +
> +	if (resize_test(skel, element_sz, desired_sz))
> +		goto teardown;
> +
> +teardown:
> +	teardown(&skel);
> +}
> +
> +static void global_map_resize_invalid_subtest(void)
> +{
> +	int err;
> +	struct test_global_map_resize *skel;
> +	struct bpf_map *map;
> +	const __u32 desired_sz = 8192;
> +
> +	if (setup(&skel))
> +		goto teardown;
> +
> +	/* attempt to resize a global datasec map which is an array
> +	 * BUT is with a var in same datasec
> +	 */
> +	map = skel->maps.data_my_array_and_var;
> +	err = bpf_map__set_value_size(map, desired_sz);
> +	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__set_value_size"))
> +		goto teardown;
> +
> +	/* attempt to resize a global datasec map which is NOT an array */
> +	map = skel->maps.data_my_non_array;
> +	err = bpf_map__set_value_size(map, desired_sz);
> +	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__set_value_size"))
> +		goto teardown;
> +
> +teardown:
> +	teardown(&skel);
> +}
> +
> +void test_global_map_resize(void)
> +{
> +	if (test__start_subtest("global_map_resize_aligned"))
> +		global_map_resize_aligned_subtest();
> +
> +	if (test__start_subtest("global_map_resize_roundup"))
> +		global_map_resize_roundup_subtest();
> +
> +	if (test__start_subtest("global_map_resize_invalid"))
> +		global_map_resize_invalid_subtest();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> new file mode 100644
> index 000000000000..cffbba1b6020
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +const volatile pid_t pid;
> +const volatile size_t n;
> +
> +int my_array[1] SEC(".data.my_array");
> +
> +int my_array_with_neighbor[1] SEC(".data.my_array_and_var");
> +int my_var_with_neighbor SEC(".data.my_array_and_var");
> +
> +int my_non_array SEC(".data.my_non_array");
> +
> +int sum = 0;
> +
> +SEC("tp/syscalls/sys_enter_getpid")
> +int array_sum(void *ctx)
> +{
> +	if (pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +
> +	sum = 0;
> +
> +	for (size_t i = 0; i < n; ++i)
> +		sum += my_array[i];
> +
> +	return 0;
> +}
> -- 
> 2.40.0
> 
