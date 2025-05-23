Return-Path: <bpf+bounces-58827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC2AC20C5
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583CB1C01C97
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A18227EB2;
	Fri, 23 May 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkibLZub"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3241C84BC;
	Fri, 23 May 2025 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995527; cv=none; b=qC1G9njwwBdR/n+q8+UQHe0sgLcuFCvmxkGlIYkzMpyAHVxvXvcQx49zmv5ZnQMQ5Q3iUxkEkauoKAsSh4aU3I8XjQbFGM09Z6CxdE2LCQuYZl0OA0pRB4n+RsFTs6dRAAz6yasHp5OsngodRuSTXuz6+YtL2q69MbQGb5hcBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995527; c=relaxed/simple;
	bh=72P9ggHoV4J+bO4ofT9fcvn9tIutz+Znr8TDQNlCs1g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkvWGSVmcD6L4XSebTd1SiBFAhhSUsHcCoe0+sdAJIe8cMrowOMyTc37RFw9148cWen5ak/MHTU5k1d56OVLnqurcquGfsm0NeX2uQdNgg9Fk4dWTHtNbPusQfrlT9KFXmuCig8JiOSic5tp2z0+4FBXt2FViikI6jzkQqCK1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkibLZub; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23229fdaff4so67202775ad.1;
        Fri, 23 May 2025 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747995525; x=1748600325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6KJN2FlupJaDrBN/rwQtbtbCqJO+xDvIXE5wiEhwe0M=;
        b=SkibLZub0asrq9RifO8jF5P9kLftCNmr8wiikimsWQR10A8hnv6dNRNfBllLy7aA7M
         naJerAhkTxwKDylsHX171ey6HGAuXOd/boegs8QwXDMGIzQ/OGj7OqmwPqwvK0he9q7o
         xL+yvTliWdjp6EmypRCd5tZlLtHxzOnMJ02kOCeRC7THrQFGPBD9eC3m06jUTu8gqrwn
         GzPDXove3mXWemexpYP8bQyP4a8dnkzDjkO8HZjK1A7zPoqXV0+qiRpCUBSxNfy2ztHs
         6hsanb3GxAJkIeLknyxPaG3lu6WZK0PlgqchLutKsnWgB0QFV/CFeJfkAu/kfvjFvlOv
         23PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995525; x=1748600325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KJN2FlupJaDrBN/rwQtbtbCqJO+xDvIXE5wiEhwe0M=;
        b=YCbPc8RPbaemG56/ckd9uZVT3VRrZdIQOsPtN6DyJglwls78oT2LME8KVqkAGUfV7d
         iU7HT+TGjWE7cMZFoyvAd8bCS/g+0eNL9H+2a/9O7YHPgky1G0D6pN1JysBA4ArbUerf
         8wNsrmPdtpYje3s0whq2owgjiu/ktcdkghBxO2rqKLpFvjTlxI4NLg/0OSIaCPXV0jA6
         TnR5OabVDOcOOzKS38zWAcM5+ar8BAIWg4t0P7zsm3vt7095xQ8mptrCvcOLNQaYLjMu
         S4AFHULnVmW8tA5HriTD+3s9f1P4i5ZFef2KWgMaVzlWSgjYfQZesyl3W8gf1XdtEpPx
         LJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWNIRCJDWUlKmx7NISSaMG9tIUVIol45mPLiwaV0pZEP/VeD9fkBcIVY3/qN04Gbfg52XQlxQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDo46M9a7dW73UN1CFJD6JvW0HHsGa8G1PqMZEM+75fUsofmR
	m6AYah5Szy/QxORaP8SbwOSM3Nn9j4BzKNOEClDcFXYD4AhRpHvqOv9j
X-Gm-Gg: ASbGncuWUxMYhj7gIiUkNw/ucizS93Ck1fcdDzDA1gyaHYvOzJub0O2z4O77vTd2xso
	JEWmjsE/6bqjwKX68mbmy1OjKkJLSSqocRMgPMfA3Nb0GO+Ne8GfY/gYtuqK8q1Xobu9K1RY/DP
	pJmejsWJWj8Hb6VAe8V7E3uXaCtnAMXDFL/n84020CNelFXanSg9+KAO0PDrrx0LxkKxE53xBvw
	ov9nxLT7oJrqnOkQWp58XlogGw4VQy8yvBTfYCphrSlHdmNs4fH5v2cTlAqkK3Oc0K6gKs6o9Ox
	VY2qn5JcyBa/jGGRxjGe+o/OBV8iVRsYiHKQ8AmES+1G4ahSazQcJXK2QsoLoBhj8mF+0hOASGL
	2WMQ/9O/GFmT0mVarCQ==
X-Google-Smtp-Source: AGHT+IFmShpvwaBJIDqU7rc4pNy7Qy5rh9n+RG1p84vrCSMPXU++D8ISgzF8X1UugO4w87qw9KfPYQ==
X-Received: by 2002:a17:903:41c7:b0:220:f59b:6e6 with SMTP id d9443c01a7336-233f218960amr31383745ad.8.1747995524618;
        Fri, 23 May 2025 03:18:44 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d460fsm6969177a91.23.2025.05.23.03.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:18:44 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 23 May 2025 03:18:42 -0700
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: Test basic task local
 data operations
Message-ID: <aDBLgh7UoMwA1H5P@kodidev-ubuntu>
References: <20250515211606.2697271-1-ameryhung@gmail.com>
 <20250515211606.2697271-3-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515211606.2697271-3-ameryhung@gmail.com>

On Thu, May 15, 2025 at 02:16:01PM -0700, Amery Hung wrote:
> Test basic operations of task local data with valid and invalid
> tld_create_key(). For invalid calls, make sure they return the right
> error code, and verifiy that no TLDs are inserted by trying fetching
> keys in the bpf program. For valid calls, first make sure the TLDs
> are created using tld_fetch_key(). Then, verify that they are task-
> specific with multiple user threads. This done by writing values unique
> to each thread to TLDs, reading them from both user space and bpf, and
> checking if the value read back are the same as the value written.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../bpf/prog_tests/test_task_local_data.c     | 163 ++++++++++++++++++
>  .../bpf/progs/test_task_local_data.c          |  81 +++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> new file mode 100644
> index 000000000000..738fc1c9d8a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <pthread.h>
> +#include <bpf/btf.h>
> +#include <test_progs.h>
> +
> +struct test_struct {
> +	__u64 a;
> +	__u64 b;
> +	__u64 c;
> +	__u64 d;
> +};
> +
> +#include "test_task_local_data.skel.h"
> +#include "task_local_data.h"
> +
> +/*
> + * Reset task local data between subtests by clearing metadata. This is only safe
> + * in selftests as subtests run sequentially. Users of task local data libraries
> + * should not do this.
> + */
> +static void reset_tld(void)
> +{
> +	if (tld_metadata_p)
> +		memset(tld_metadata_p, 0, PAGE_SIZE);
> +}
> +
> +/* Serialize access to bpf program's global variables */
> +static pthread_mutex_t global_mutex;
> +
> +#define TEST_BASIC_THREAD_NUM 63
> +static tld_key_t tld_keys[TEST_BASIC_THREAD_NUM];
> +
> +void *test_task_local_data_basic_thread(void *arg)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct test_task_local_data *skel = (struct test_task_local_data *)arg;
> +	struct test_struct *value2;
> +	int fd, err, tid, *value1;
> +
> +	fd = bpf_map__fd(skel->maps.tld_data_map);
> +
> +	value1 = tld_get_data(fd, tld_keys[0]);
> +	if (!ASSERT_OK_PTR(value1, "tld_get_data"))
> +		goto out;
> +
> +	value2 = tld_get_data(fd, tld_keys[1]);
> +	if (!ASSERT_OK_PTR(value1, "tld_get_data"))

Should this be 'value2'?

> +		goto out;
> +
> +	tid = gettid();
> +
> +	*value1 = tid + 0;
> +	value2->a = tid + 1;
> +	value2->b = tid + 2;
> +	value2->c = tid + 3;
> +	value2->d = tid + 4;
> +
> +	pthread_mutex_lock(&global_mutex);
> +	/*
> +	 * Run task_init which simulates an initialization bpf prog that runs once
> +	 * for every new task. The program saves keys for subsequent bpf programs.
> +	 */
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_init), &opts);
> +	ASSERT_OK(err, "run task_init");
> +	ASSERT_OK(opts.retval, "task_init retval");
> +	/* Run task_main that read task local data and save to global variables */
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_main), &opts);
> +	ASSERT_OK(err, "run task_main");
> +	ASSERT_OK(opts.retval, "task_main retval");
> +
> +	ASSERT_EQ(skel->bss->test_value1, tid + 0, "tld_get_data value1");
> +	ASSERT_EQ(skel->bss->test_value2.a, tid + 1, "tld_get_data value2.a");
> +	ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "tld_get_data value2.b");
> +	ASSERT_EQ(skel->bss->test_value2.c, tid + 3, "tld_get_data value2.c");
> +	ASSERT_EQ(skel->bss->test_value2.d, tid + 4, "tld_get_data value2.d");
> +	pthread_mutex_unlock(&global_mutex);
> +
> +	/* Make sure valueX are indeed local to threads */
> +	ASSERT_EQ(*value1, tid + 0, "value1");
> +	ASSERT_EQ(value2->a, tid + 1, "value2.a");
> +	ASSERT_EQ(value2->b, tid + 2, "value2.b");
> +	ASSERT_EQ(value2->c, tid + 3, "value2.c");
> +	ASSERT_EQ(value2->d, tid + 4, "value2.d");
> +
> +	*value1 = tid + 4;
> +	value2->a = tid + 3;
> +	value2->b = tid + 2;
> +	value2->c = tid + 1;
> +	value2->d = tid + 0;
> +
> +	/* Run task_main again */
> +	pthread_mutex_lock(&global_mutex);
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_main), &opts);
> +	ASSERT_OK(err, "run task_main");
> +	ASSERT_OK(opts.retval, "task_main retval");
> +
> +	ASSERT_EQ(skel->bss->test_value1, tid + 4, "tld_get_data value1");
> +	ASSERT_EQ(skel->bss->test_value2.a, tid + 3, "tld_get_data value2.a");
> +	ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "tld_get_data value2.b");
> +	ASSERT_EQ(skel->bss->test_value2.c, tid + 1, "tld_get_data value2.c");
> +	ASSERT_EQ(skel->bss->test_value2.d, tid + 0, "tld_get_data value2.d");
> +	pthread_mutex_unlock(&global_mutex);
> +
> +	tld_free();
> +out:
> +	pthread_exit(NULL);
> +}
> +
> +static void test_task_local_data_basic(void)
> +{
> +	struct test_task_local_data *skel;
> +	pthread_t thread[TEST_BASIC_THREAD_NUM];
> +	char dummy_key_name[TLD_NAME_LEN];
> +	tld_key_t key;
> +	int i, fd, err;
> +
> +	reset_tld();
> +
> +	ASSERT_OK(pthread_mutex_init(&global_mutex, NULL), "pthread_mutex_init");
> +
> +	skel = test_task_local_data__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	fd = bpf_map__fd(skel->maps.tld_data_map);
> +
> +	tld_keys[0] = tld_create_key(fd, "value1", sizeof(int));
> +	ASSERT_FALSE(tld_key_is_err(tld_keys[0]), "tld_create_key");
> +	tld_keys[1] = tld_create_key(fd, "value2", sizeof(struct test_struct));
> +	ASSERT_FALSE(tld_key_is_err(tld_keys[1]), "tld_create_key");
> +
> +	key = tld_create_key(fd, "value_not_exist",
> +			     PAGE_SIZE - sizeof(int) - sizeof(struct test_struct) + 1);
> +	ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
> +
> +	key = tld_create_key(fd, "value2", sizeof(struct test_struct));
> +	ASSERT_EQ(tld_key_err_or_zero(key), -EEXIST, "tld_create_key");
> +
> +	for (i = 2; i < TLD_DATA_CNT; i++) {
> +		snprintf(dummy_key_name, TLD_NAME_LEN, "dummy_value%d", i);
> +		tld_keys[i] = tld_create_key(fd, dummy_key_name, sizeof(int));
> +		ASSERT_FALSE(tld_key_is_err(tld_keys[i]), "tld_create_key");
> +	}
> +
> +	key = tld_create_key(fd, "value_not_exist", sizeof(struct test_struct));
> +	ASSERT_EQ(tld_key_err_or_zero(key), -ENOSPC, "tld_create_key");
> +
> +	for (i = 0; i < TEST_BASIC_THREAD_NUM; i++) {
> +		err = pthread_create(&thread[i], NULL, test_task_local_data_basic_thread, skel);
> +		if (!ASSERT_OK(err, "pthread_create"))
> +			goto out;
> +	}
> +
> +out:
> +	for (i = 0; i < TEST_BASIC_THREAD_NUM; i++)
> +		pthread_join(thread[i], NULL);
> +}
> +
> +void test_task_local_data(void)
> +{
> +	if (test__start_subtest("task_local_data_basic"))
> +		test_task_local_data_basic();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data.c b/tools/testing/selftests/bpf/progs/test_task_local_data.c
> new file mode 100644
> index 000000000000..4cf0630b19bd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_task_local_data.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "task_local_data.bpf.h"
> +
> +struct tld_keys {
> +	tld_key_t value1;
> +	tld_key_t value2;
> +	tld_key_t value_not_exist;
> +};
> +
> +struct test_struct {
> +	unsigned long a;
> +	unsigned long b;
> +	unsigned long c;
> +	unsigned long d;
> +};
> +
> +int test_value1;
> +struct test_struct test_value2;
> +
> +SEC("syscall")
> +int task_init(void *ctx)
> +{
> +	struct tld_object tld_obj;
> +	struct task_struct *task;
> +	int err;
> +
> +	task = bpf_get_current_task_btf();
> +	err = tld_object_init(task, &tld_obj);
> +	if (err)
> +		return 1;
> +
> +	if (!tld_fetch_key(&tld_obj, "value1", value1))
> +		return 2;
> +
> +	if (!tld_fetch_key(&tld_obj, "value2", value2))
> +		return 3;
> +
> +	if (tld_fetch_key(&tld_obj, "value_not_exist", value_not_exist))
> +		return 6;
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int task_main(void *ctx)
> +{
> +	struct tld_object tld_obj;
> +	struct test_struct *struct_p;
> +	struct task_struct *task;
> +	int err, *int_p;
> +
> +	task = bpf_get_current_task_btf();
> +	err = tld_object_init(task, &tld_obj);
> +	if (err)
> +		return 1;
> +
> +	int_p = tld_get_data(&tld_obj, value1, sizeof(int));
> +	if (int_p)
> +		test_value1 = *int_p;
> +	else
> +		return 2;
> +
> +	struct_p = tld_get_data(&tld_obj, value2, sizeof(struct test_struct));
> +	if (struct_p)
> +		test_value2 = *struct_p;
> +	else
> +		return 3;
> +
> +	int_p = tld_get_data(&tld_obj, value_not_exist, sizeof(int));
> +	if (int_p)
> +		return 4;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> +
> -- 
> 2.47.1
> 

