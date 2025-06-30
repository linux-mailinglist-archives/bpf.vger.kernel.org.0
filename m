Return-Path: <bpf+bounces-61811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ECDAEDACF
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330013AEB87
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3574248F5E;
	Mon, 30 Jun 2025 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tpd+UT8e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609E23F43C;
	Mon, 30 Jun 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282658; cv=none; b=YW+tG2Kd8jZ7KE+y+pVdwsJgGXB03EdW8Xyk88KqVIvZ32d+Fd5faBdux2JIY7+5NuaWKZG0No62sarcOdZialWBwYuuxh7LNqjbJ8ELbJxIORULkPFCBSog/Q1L4aDO7xsSVf35mMJFBEzKWPd45V8a7k413MU6rDhDiCjAO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282658; c=relaxed/simple;
	bh=30Pfe3K/0ULXHT6Ngu68BVu+1Fkyxw7HsC2jentrXJk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp9PnHC6Jjk+R+Wg6Ap5ruFSjrbYPo7jI/0RZM5q4kxqTjigxRSkeEKt86uI87Popguw1E+voz0wiuaRGK9yHY9SAOeeFJTNEd712qPnxAr2ZtQKhe3D7csPnaz46KE1yaABpsVcsup+6b3oaTJJKAY6t9GE4EQ35tezIbNhZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tpd+UT8e; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so4272904a12.1;
        Mon, 30 Jun 2025 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751282654; x=1751887454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjv/TRLGDGPIQELelbprN6OpsnoW9wWLI6zBeF+8h4g=;
        b=Tpd+UT8etFh9zMPgBpUoY4CQNGDd22GCS3LfGXI9SyPl9Tta7GHjFjn+GOsAg7wjGO
         nNniH/6L1D4oTncBIOR8vdS7ZEoBGdKEBfkuczE8Hvc/7vqt88HgitIbhETSkAQmk41B
         7a5uBnk4T+9CI4ccCKorakBnBfRsvJasdH1gM45GJvA78FcQ5fe6oFcLg8fJimzqWGvJ
         +iaz0HfbIfGk6TsQrC18sZEhj/GO0fJFtYraB1YNqMwdlGAY8HUS+ug11y6x//WeZrqB
         HvnrXnd1rRwLFcnRrWhhgUwQ2JJ1jVQ/v1YKpz5pIBcDESYRjckLuj2gkbaxYy2eS+Zt
         OQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751282654; x=1751887454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjv/TRLGDGPIQELelbprN6OpsnoW9wWLI6zBeF+8h4g=;
        b=m3nA3oWd6slAGaL4maZEkiN3sLkgbpc51whdojBdszCWHHKIGXA1ugeElKZo1hgF5b
         fM07uWqcuLzLxg+7hd9k/y4xqgjfr/inm3SvCPPapAjOUI+E3/zL6jAuZoZwc8GS+csK
         Tz3lfvjHYbsdfgRki/9Y/DabA8QYq0Xq2oci9rGv9ep16v7Qjn2MmpQ3Ln2yy0flLzJ1
         JHqoh1gXi9EMhLyRlCl0t+6l0pvAKv4IJ77URnG5+rlmoXTtrWmeEDrWy3ncspdFXU/Z
         ZvXbrXKupEOC9ZhEEE8ycDeCU+54X8VShoYbT0j66bkkmwDqHhh5+YrOO3y2PtW94ugc
         oC0g==
X-Forwarded-Encrypted: i=1; AJvYcCXl4Njm1O9aFhotyABLAXh5tCx6dGuNYVON0/ZKkOj26BEDsGo7H5L3VxdHwNjfkhhODQU8Jdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/gjoLHL1r7SYfeN2vmAWp60Ch63VzVnq01pekeMUFTUv/xlu
	HlXX97giPAdjNQ1iCzBa+AE6mRf0Kq2VhruDx8+W2scKGfvdEaQKRMtG
X-Gm-Gg: ASbGncunruf25pG96WjoH/E2RqwRuGut6AL6V5hFCc4Af7t4yLBNWiMJfclJ+rnaQkt
	BwbioWheLExdj8b+31TPHTwxFS89hFsTE3hWi2UheerE0FOd6GsEnnF0KM2PR+aGU4qdnXh5V63
	7Ux9Lr8oWzbGJbPS+z+G6gJNzRnajO+PvNgArhMohvXhtoGALeNNVOJXmBNLeMKnAbqVmceT3rH
	F9KFHaf1ky2v4V9Ee+Nst90RdozKKkYbF2PjFSMrX1pNl202Qa0EeDxf2Bjqcddk3gQrES/v+cn
	Zivuu9LQMoNJpcSaJAHppwL+QFtZPr9NfZhv9vJYHTX1BIkM
X-Google-Smtp-Source: AGHT+IFmWF77qP1a7Dic+ZXeWIHypUq+U4/gKKHRfyVPRRvCrtF30lfis37cUliVlDw8+L+tg737vg==
X-Received: by 2002:a17:907:930a:b0:ad8:914b:7d15 with SMTP id a640c23a62f3a-ae34fd33136mr1142862166b.7.1751282654007;
        Mon, 30 Jun 2025 04:24:14 -0700 (PDT)
Received: from krava ([173.38.220.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35aad8275sm624735066b.23.2025.06.30.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 04:24:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Jun 2025 13:24:11 +0200
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: Test basic task local
 data operations
Message-ID: <aGJz2waYK8mhvB49@krava>
References: <20250627233958.2602271-1-ameryhung@gmail.com>
 <20250627233958.2602271-3-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627233958.2602271-3-ameryhung@gmail.com>

On Fri, Jun 27, 2025 at 04:39:56PM -0700, Amery Hung wrote:
> Test basic operations of task local data with valid and invalid
> tld_create_key().
> 
> For invalid calls, make sure they return the right error code and check
> that the TLDs are not inserted by running tld_get_data("
> value_not_exists") on the bpf side. The call should a null pointer.
> 
> For valid calls, first make sure the TLDs are created by calling
> tld_get_data() on the bpf side. The call should return a valid pointer.
> 
> Finally, verify that the TLDs are indeed task-specific (i.e., their
> addresses do not overlap) with multiple user threads. This done by
> writing values unique to each thread, reading them from both user space
> and bpf, and checking if the value read back matches the value written.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../bpf/prog_tests/test_task_local_data.c     | 191 ++++++++++++++++++
>  .../bpf/progs/test_task_local_data.c          |  65 ++++++
>  2 files changed, 256 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> new file mode 100644
> index 000000000000..53cdb8466f8e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -0,0 +1,191 @@
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

hi,
I can't compile this on my config, bacause of the KGDB_TESTS config
that defines struct test_struct

progs/test_task_local_data.c:16:8: error: redefinition of 'test_struct'
   16 | struct test_struct {
      |        ^
/home/jolsa/kernel/linux-qemu-1/tools/testing/selftests/bpf/tools/include/vmlinux.h:141747:8: note: previous definition is here
 141747 | struct test_struct {


also I have these tests passing localy, but it's failing CI:
  https://github.com/kernel-patches/bpf/actions/runs/15939264078/job/44964987935

thanks,
jirka


> +
> +#define TLD_FREE_DATA_ON_THREAD_EXIT
> +#define TLD_DYN_DATA_SIZE 4096
> +#include "task_local_data.h"
> +
> +#include "test_task_local_data.skel.h"
> +
> +TLD_DEFINE_KEY(value0_key, "value0", sizeof(int));
> +
> +/*
> + * Reset task local data between subtests by clearing metadata. This is safe
> + * as subtests run sequentially. Users of task local data libraries
> + * should not do this.
> + */
> +static void reset_tld(void)
> +{
> +	if (TLD_READ_ONCE(tld_metadata_p)) {
> +		/* Remove TLDs created by tld_create_key() */
> +		tld_metadata_p->cnt = 1;
> +		tld_metadata_p->size = TLD_DYN_DATA_SIZE;
> +		memset(&tld_metadata_p->metadata[1], 0,
> +		       (TLD_MAX_DATA_CNT - 1) * sizeof(struct tld_metadata));
> +	}
> +}
> +
> +/* Serialize access to bpf program's global variables */
> +static pthread_mutex_t global_mutex;
> +
> +static tld_key_t *tld_keys;
> +
> +#define TEST_BASIC_THREAD_NUM TLD_MAX_DATA_CNT
> +
> +void *test_task_local_data_basic_thread(void *arg)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct test_task_local_data *skel = (struct test_task_local_data *)arg;
> +	int fd, err, tid, *value0, *value1;
> +	struct test_struct *value2;
> +
> +	fd = bpf_map__fd(skel->maps.tld_data_map);
> +
> +	value0 = tld_get_data(fd, value0_key);
> +	if (!ASSERT_OK_PTR(value0, "tld_get_data"))
> +		goto out;
> +
> +	value1 = tld_get_data(fd, tld_keys[0]);
> +	if (!ASSERT_OK_PTR(value1, "tld_get_data"))
> +		goto out;
> +
> +	value2 = tld_get_data(fd, tld_keys[1]);
> +	if (!ASSERT_OK_PTR(value2, "tld_get_data"))
> +		goto out;
> +
> +	tid = gettid();
> +
> +	*value0 = tid + 0;
> +	*value1 = tid + 1;
> +	value2->a = tid + 2;
> +	value2->b = tid + 3;
> +	value2->c = tid + 4;
> +	value2->d = tid + 5;
> +
> +	pthread_mutex_lock(&global_mutex);
> +	/* Run task_main that read task local data and save to global variables */
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_main), &opts);
> +	ASSERT_OK(err, "run task_main");
> +	ASSERT_OK(opts.retval, "task_main retval");
> +
> +	ASSERT_EQ(skel->bss->test_value0, tid + 0, "tld_get_data value0");
> +	ASSERT_EQ(skel->bss->test_value1, tid + 1, "tld_get_data value1");
> +	ASSERT_EQ(skel->bss->test_value2.a, tid + 2, "tld_get_data value2.a");
> +	ASSERT_EQ(skel->bss->test_value2.b, tid + 3, "tld_get_data value2.b");
> +	ASSERT_EQ(skel->bss->test_value2.c, tid + 4, "tld_get_data value2.c");
> +	ASSERT_EQ(skel->bss->test_value2.d, tid + 5, "tld_get_data value2.d");
> +	pthread_mutex_unlock(&global_mutex);
> +
> +	/* Make sure valueX are indeed local to threads */
> +	ASSERT_EQ(*value0, tid + 0, "value0");
> +	ASSERT_EQ(*value1, tid + 1, "value1");
> +	ASSERT_EQ(value2->a, tid + 2, "value2.a");
> +	ASSERT_EQ(value2->b, tid + 3, "value2.b");
> +	ASSERT_EQ(value2->c, tid + 4, "value2.c");
> +	ASSERT_EQ(value2->d, tid + 5, "value2.d");
> +
> +	*value0 = tid + 5;
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
> +	ASSERT_EQ(skel->bss->test_value0, tid + 5, "tld_get_data value0");
> +	ASSERT_EQ(skel->bss->test_value1, tid + 4, "tld_get_data value1");
> +	ASSERT_EQ(skel->bss->test_value2.a, tid + 3, "tld_get_data value2.a");
> +	ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "tld_get_data value2.b");
> +	ASSERT_EQ(skel->bss->test_value2.c, tid + 1, "tld_get_data value2.c");
> +	ASSERT_EQ(skel->bss->test_value2.d, tid + 0, "tld_get_data value2.d");
> +	pthread_mutex_unlock(&global_mutex);
> +
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
> +	int i, err;
> +
> +	reset_tld();
> +
> +	ASSERT_OK(pthread_mutex_init(&global_mutex, NULL), "pthread_mutex_init");
> +
> +	skel = test_task_local_data__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	tld_keys = calloc(TEST_BASIC_THREAD_NUM, sizeof(tld_key_t));
> +	if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
> +		goto out;
> +
> +	ASSERT_FALSE(tld_key_is_err(value0_key), "TLD_DEFINE_KEY");
> +	tld_keys[0] = tld_create_key("value1", sizeof(int));
> +	ASSERT_FALSE(tld_key_is_err(tld_keys[0]), "tld_create_key");
> +	tld_keys[1] = tld_create_key("value2", sizeof(struct test_struct));
> +	ASSERT_FALSE(tld_key_is_err(tld_keys[1]), "tld_create_key");
> +
> +	/*
> +	 * Shouldn't be able to store data exceed a page. Create a TLD just big
> +	 * enough to exceed a page. TLDs already created are int value0, int
> +	 * value1, and struct test_struct value2.
> +	 */
> +	key = tld_create_key("value_not_exist",
> +			     TLD_PAGE_SIZE - 2 * sizeof(int) - sizeof(struct test_struct) + 1);
> +	ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
> +
> +	key = tld_create_key("value2", sizeof(struct test_struct));
> +	ASSERT_EQ(tld_key_err_or_zero(key), -EEXIST, "tld_create_key");
> +
> +	/* Shouldn't be able to create the (TLD_MAX_DATA_CNT+1)-th TLD */
> +	for (i = 3; i < TLD_MAX_DATA_CNT; i++) {
> +		snprintf(dummy_key_name, TLD_NAME_LEN, "dummy_value%d", i);
> +		tld_keys[i] = tld_create_key(dummy_key_name, sizeof(int));
> +		ASSERT_FALSE(tld_key_is_err(tld_keys[i]), "tld_create_key");
> +	}
> +	key = tld_create_key("value_not_exist", sizeof(struct test_struct));
> +	ASSERT_EQ(tld_key_err_or_zero(key), -ENOSPC, "tld_create_key");
> +
> +	/* Access TLDs from multiple threads and check if they are thread-specific */
> +	for (i = 0; i < TEST_BASIC_THREAD_NUM; i++) {
> +		err = pthread_create(&thread[i], NULL, test_task_local_data_basic_thread, skel);
> +		if (!ASSERT_OK(err, "pthread_create"))
> +			goto out;
> +	}
> +
> +out:
> +	for (i = 0; i < TEST_BASIC_THREAD_NUM; i++)
> +		pthread_join(thread[i], NULL);
> +
> +	if (tld_keys) {
> +		free(tld_keys);
> +		tld_keys = NULL;
> +	}
> +	tld_free();
> +	test_task_local_data__destroy(skel);
> +}
> +
> +void test_task_local_data(void)
> +{
> +	if (test__start_subtest("task_local_data_basic"))
> +		test_task_local_data_basic();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data.c b/tools/testing/selftests/bpf/progs/test_task_local_data.c
> new file mode 100644
> index 000000000000..94d1745dd8d4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_task_local_data.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "task_local_data.bpf.h"
> +
> +struct tld_keys {
> +	tld_key_t value0;
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
> +int test_value0;
> +int test_value1;
> +struct test_struct test_value2;
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
> +	int_p = tld_get_data(&tld_obj, value0, "value0", sizeof(int));
> +	if (int_p)
> +		test_value0 = *int_p;
> +	else
> +		return 2;
> +
> +	int_p = tld_get_data(&tld_obj, value1, "value1", sizeof(int));
> +	if (int_p)
> +		test_value1 = *int_p;
> +	else
> +		return 3;
> +
> +	struct_p = tld_get_data(&tld_obj, value2, "value2", sizeof(struct test_struct));
> +	if (struct_p)
> +		test_value2 = *struct_p;
> +	else
> +		return 4;
> +
> +	int_p = tld_get_data(&tld_obj, value_not_exist, "value_not_exist", sizeof(int));
> +	if (int_p)
> +		return 5;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.47.1
> 
> 

