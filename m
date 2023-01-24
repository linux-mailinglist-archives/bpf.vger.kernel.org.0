Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCEB679BC0
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjAXO1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjAXO1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:27:04 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFAB457C8
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 06:26:59 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-16323754f81so734421fac.0
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 06:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lla3bxWHDvaqyEW+l+ZdvmeUoEDNvjCcGgKdgriTugE=;
        b=3SGdsrCJZDAdV0r3tq0Ob7Dn0K1NcW6qKieIylm2bkkFvzl37/+SG9JqNT1Zl2rGu/
         YUycmCI0z5+/WyoqlQe+T+Qx04VC9cd7pzHXW6KW1oAJam2G6Rrqr274rujxb5ks/9oC
         iD8ECaOEn+Z0nNPuRvJQFZLQuAX5ilWaEwfuceAPv8GC2OnavstIVPUzRzrvuOGcLFSH
         gEulbfWE5+PRO5GAmHC2wjW6ztp0vrsNVga0c2oCqGvNMJ9EVKsufvTFT/GlttaRNL8j
         4+L9tBG1/HgxFdEM4nCgR4s5l6TRbdoyiXJGtSj+KLJqobWTeFjrRgujITcZGPRAYN4a
         9CdQ==
X-Gm-Message-State: AFqh2koOu1V/+4uk2/09fxgvBG9ICx0jjCfH7KeC9iNOb2nARt4Tutj3
        5M3hIkg54yXa/3PtLzi8QCccx2YStRVg6qeO
X-Google-Smtp-Source: AMrXdXs9jFesHazH/VX9SgxtE4CP8RXOdDCsr+drkWy1DF0rn9y7vfgB9Ejf3xjjbKYKo6vM1SkPJA==
X-Received: by 2002:a05:6870:4d06:b0:150:ce03:d0fe with SMTP id pn6-20020a0568704d0600b00150ce03d0femr15387943oab.13.1674570418729;
        Tue, 24 Jan 2023 06:26:58 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id y21-20020a376415000000b006e07228ed53sm1525203qkb.18.2023.01.24.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:26:58 -0800 (PST)
Date:   Tue, 24 Jan 2023 08:26:59 -0600
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, roberto.sassu@huawei.com
Subject: Re: [PATCH v1 bpf-next 1/2] selftests/bpf: Clean up user_ringbuf,
 cgrp_kfunc, task_kfunc, kfunc_dynptr_param tests
Message-ID: <Y8/qsy9HitJHf9Hm@maniforge.lan>
References: <20230123202648.1800946-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123202648.1800946-1-joannelkoong@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 12:26:47PM -0800, Joanne Koong wrote:
> Clean up user_ringbuf, cgrp_kfunc, task_kfunc, and kfunc_dynptr_param
> tests to use the generic verification tester for checking verifier
> rejections. The generic verification tester uses btf_decl_tag-based
> annotations for verifying that the tests fail with the expected log
> messages.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Thanks for the cleanup patches!

> ---
>  .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 69 +-----------------
>  .../bpf/prog_tests/kfunc_dynptr_param.c       | 72 ++++---------------
>  .../selftests/bpf/prog_tests/task_kfunc.c     | 71 +-----------------
>  .../selftests/bpf/prog_tests/user_ringbuf.c   | 62 +---------------
>  .../selftests/bpf/progs/cgrp_kfunc_failure.c  | 17 ++++-
>  .../selftests/bpf/progs/task_kfunc_failure.c  | 18 +++++

FYI, the task_kfunc suite was already taken care of in [0].

[0]: https://lore.kernel.org/bpf/20230120021844.3048244-1-void@manifault.com/

Otherwise, for the rest of the patch:

Acked-by: David Vernet <void@manifault.com>

>  .../bpf/progs/test_kfunc_dynptr_param.c       |  4 ++
>  .../selftests/bpf/progs/user_ringbuf_fail.c   | 31 +++++---
>  8 files changed, 77 insertions(+), 267 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> index 973f0c5af965..b3f7985c8504 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> @@ -8,9 +8,6 @@
>  #include "cgrp_kfunc_failure.skel.h"
>  #include "cgrp_kfunc_success.skel.h"
>  
> -static size_t log_buf_sz = 1 << 20; /* 1 MB */
> -static char obj_log_buf[1048576];
> -
>  static struct cgrp_kfunc_success *open_load_cgrp_kfunc_skel(void)
>  {
>  	struct cgrp_kfunc_success *skel;
> @@ -89,65 +86,6 @@ static const char * const success_tests[] = {
>  	"test_cgrp_get_ancestors",
>  };
>  
> -static struct {
> -	const char *prog_name;
> -	const char *expected_err_msg;
> -} failure_tests[] = {
> -	{"cgrp_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
> -	{"cgrp_kfunc_acquire_fp", "arg#0 pointer type STRUCT cgroup must point"},
> -	{"cgrp_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 function"},
> -	{"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
> -	{"cgrp_kfunc_acquire_null", "arg#0 pointer type STRUCT cgroup must point"},
> -	{"cgrp_kfunc_acquire_unreleased", "Unreleased reference"},
> -	{"cgrp_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
> -	{"cgrp_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
> -	{"cgrp_kfunc_get_null", "arg#0 expected pointer to map value"},
> -	{"cgrp_kfunc_xchg_unreleased", "Unreleased reference"},
> -	{"cgrp_kfunc_get_unreleased", "Unreleased reference"},
> -	{"cgrp_kfunc_release_untrusted", "arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket"},
> -	{"cgrp_kfunc_release_fp", "arg#0 pointer type STRUCT cgroup must point"},
> -	{"cgrp_kfunc_release_null", "arg#0 is ptr_or_null_ expected ptr_ or socket"},
> -	{"cgrp_kfunc_release_unacquired", "release kernel function bpf_cgroup_release expects"},
> -};
> -
> -static void verify_fail(const char *prog_name, const char *expected_err_msg)
> -{
> -	LIBBPF_OPTS(bpf_object_open_opts, opts);
> -	struct cgrp_kfunc_failure *skel;
> -	int err, i;
> -
> -	opts.kernel_log_buf = obj_log_buf;
> -	opts.kernel_log_size = log_buf_sz;
> -	opts.kernel_log_level = 1;
> -
> -	skel = cgrp_kfunc_failure__open_opts(&opts);
> -	if (!ASSERT_OK_PTR(skel, "cgrp_kfunc_failure__open_opts"))
> -		goto cleanup;
> -
> -	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
> -		struct bpf_program *prog;
> -		const char *curr_name = failure_tests[i].prog_name;
> -
> -		prog = bpf_object__find_program_by_name(skel->obj, curr_name);
> -		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> -			goto cleanup;
> -
> -		bpf_program__set_autoload(prog, !strcmp(curr_name, prog_name));
> -	}
> -
> -	err = cgrp_kfunc_failure__load(skel);
> -	if (!ASSERT_ERR(err, "unexpected load success"))
> -		goto cleanup;
> -
> -	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
> -		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
> -		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> -	}
> -
> -cleanup:
> -	cgrp_kfunc_failure__destroy(skel);
> -}
> -
>  void test_cgrp_kfunc(void)
>  {
>  	int i, err;
> @@ -163,12 +101,7 @@ void test_cgrp_kfunc(void)
>  		run_success_test(success_tests[i]);
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
> -		if (!test__start_subtest(failure_tests[i].prog_name))
> -			continue;
> -
> -		verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_msg);
> -	}
> +	RUN_TESTS(cgrp_kfunc_failure);
>  
>  cleanup:
>  	cleanup_cgroup_environment();
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> index 72800b1e8395..8cd298b78e44 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> @@ -10,17 +10,11 @@
>  #include <test_progs.h>
>  #include "test_kfunc_dynptr_param.skel.h"
>  
> -static size_t log_buf_sz = 1048576; /* 1 MB */
> -static char obj_log_buf[1048576];
> -
>  static struct {
>  	const char *prog_name;
> -	const char *expected_verifier_err_msg;
>  	int expected_runtime_err;
>  } kfunc_dynptr_tests[] = {
> -	{"not_valid_dynptr", "cannot pass in dynptr at an offset=-8", 0},
> -	{"not_ptr_to_stack", "arg#0 expected pointer to stack or dynptr_ptr", 0},
> -	{"dynptr_data_null", NULL, -EBADMSG},
> +	{"dynptr_data_null", -EBADMSG},
>  };
>  
>  static bool kfunc_not_supported;
> @@ -38,29 +32,15 @@ static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
>  	return 0;
>  }
>  
> -static void verify_fail(const char *prog_name, const char *expected_err_msg)
> +static bool has_pkcs7_kfunc_support(void)
>  {
>  	struct test_kfunc_dynptr_param *skel;
> -	LIBBPF_OPTS(bpf_object_open_opts, opts);
>  	libbpf_print_fn_t old_print_cb;
> -	struct bpf_program *prog;
>  	int err;
>  
> -	opts.kernel_log_buf = obj_log_buf;
> -	opts.kernel_log_size = log_buf_sz;
> -	opts.kernel_log_level = 1;
> -
> -	skel = test_kfunc_dynptr_param__open_opts(&opts);
> -	if (!ASSERT_OK_PTR(skel, "test_kfunc_dynptr_param__open_opts"))
> -		goto cleanup;
> -
> -	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> -	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> -		goto cleanup;
> -
> -	bpf_program__set_autoload(prog, true);
> -
> -	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
> +	skel = test_kfunc_dynptr_param__open();
> +	if (!ASSERT_OK_PTR(skel, "test_kfunc_dynptr_param__open"))
> +		return false;
>  
>  	kfunc_not_supported = false;
>  
> @@ -72,26 +52,18 @@ static void verify_fail(const char *prog_name, const char *expected_err_msg)
>  		fprintf(stderr,
>  		  "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not supported\n",
>  		  __func__);
> -		test__skip();
> -		goto cleanup;
> -	}
> -
> -	if (!ASSERT_ERR(err, "unexpected load success"))
> -		goto cleanup;
> -
> -	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
> -		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
> -		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> +		test_kfunc_dynptr_param__destroy(skel);
> +		return false;
>  	}
>  
> -cleanup:
>  	test_kfunc_dynptr_param__destroy(skel);
> +
> +	return true;
>  }
>  
>  static void verify_success(const char *prog_name, int expected_runtime_err)
>  {
>  	struct test_kfunc_dynptr_param *skel;
> -	libbpf_print_fn_t old_print_cb;
>  	struct bpf_program *prog;
>  	struct bpf_link *link;
>  	__u32 next_id;
> @@ -103,21 +75,7 @@ static void verify_success(const char *prog_name, int expected_runtime_err)
>  
>  	skel->bss->pid = getpid();
>  
> -	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
> -
> -	kfunc_not_supported = false;
> -
> -	old_print_cb = libbpf_set_print(libbpf_print_cb);
>  	err = test_kfunc_dynptr_param__load(skel);
> -	libbpf_set_print(old_print_cb);
> -
> -	if (err < 0 && kfunc_not_supported) {
> -		fprintf(stderr,
> -		  "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not supported\n",
> -		  __func__);
> -		test__skip();
> -		goto cleanup;
> -	}
>  
>  	if (!ASSERT_OK(err, "test_kfunc_dynptr_param__load"))
>  		goto cleanup;
> @@ -147,15 +105,15 @@ void test_kfunc_dynptr_param(void)
>  {
>  	int i;
>  
> +	if (!has_pkcs7_kfunc_support())
> +		return;
> +
>  	for (i = 0; i < ARRAY_SIZE(kfunc_dynptr_tests); i++) {
>  		if (!test__start_subtest(kfunc_dynptr_tests[i].prog_name))
>  			continue;
>  
> -		if (kfunc_dynptr_tests[i].expected_verifier_err_msg)
> -			verify_fail(kfunc_dynptr_tests[i].prog_name,
> -			  kfunc_dynptr_tests[i].expected_verifier_err_msg);
> -		else
> -			verify_success(kfunc_dynptr_tests[i].prog_name,
> -				kfunc_dynptr_tests[i].expected_runtime_err);
> +		verify_success(kfunc_dynptr_tests[i].prog_name,
> +			kfunc_dynptr_tests[i].expected_runtime_err);
>  	}
> +	RUN_TESTS(test_kfunc_dynptr_param);
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> index 18848c31e36f..f79fa5bc9a8d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> @@ -9,9 +9,6 @@
>  #include "task_kfunc_failure.skel.h"
>  #include "task_kfunc_success.skel.h"
>  
> -static size_t log_buf_sz = 1 << 20; /* 1 MB */
> -static char obj_log_buf[1048576];
> -
>  static struct task_kfunc_success *open_load_task_kfunc_skel(void)
>  {
>  	struct task_kfunc_success *skel;
> @@ -83,67 +80,6 @@ static const char * const success_tests[] = {
>  	"test_task_from_pid_invalid",
>  };
>  
> -static struct {
> -	const char *prog_name;
> -	const char *expected_err_msg;
> -} failure_tests[] = {
> -	{"task_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
> -	{"task_kfunc_acquire_fp", "arg#0 pointer type STRUCT task_struct must point"},
> -	{"task_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 function"},
> -	{"task_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
> -	{"task_kfunc_acquire_null", "arg#0 pointer type STRUCT task_struct must point"},
> -	{"task_kfunc_acquire_unreleased", "Unreleased reference"},
> -	{"task_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
> -	{"task_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
> -	{"task_kfunc_get_null", "arg#0 expected pointer to map value"},
> -	{"task_kfunc_xchg_unreleased", "Unreleased reference"},
> -	{"task_kfunc_get_unreleased", "Unreleased reference"},
> -	{"task_kfunc_release_untrusted", "arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket"},
> -	{"task_kfunc_release_fp", "arg#0 pointer type STRUCT task_struct must point"},
> -	{"task_kfunc_release_null", "arg#0 is ptr_or_null_ expected ptr_ or socket"},
> -	{"task_kfunc_release_unacquired", "release kernel function bpf_task_release expects"},
> -	{"task_kfunc_from_pid_no_null_check", "arg#0 is ptr_or_null_ expected ptr_ or socket"},
> -	{"task_kfunc_from_lsm_task_free", "reg type unsupported for arg#0 function"},
> -};
> -
> -static void verify_fail(const char *prog_name, const char *expected_err_msg)
> -{
> -	LIBBPF_OPTS(bpf_object_open_opts, opts);
> -	struct task_kfunc_failure *skel;
> -	int err, i;
> -
> -	opts.kernel_log_buf = obj_log_buf;
> -	opts.kernel_log_size = log_buf_sz;
> -	opts.kernel_log_level = 1;
> -
> -	skel = task_kfunc_failure__open_opts(&opts);
> -	if (!ASSERT_OK_PTR(skel, "task_kfunc_failure__open_opts"))
> -		goto cleanup;
> -
> -	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
> -		struct bpf_program *prog;
> -		const char *curr_name = failure_tests[i].prog_name;
> -
> -		prog = bpf_object__find_program_by_name(skel->obj, curr_name);
> -		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> -			goto cleanup;
> -
> -		bpf_program__set_autoload(prog, !strcmp(curr_name, prog_name));
> -	}
> -
> -	err = task_kfunc_failure__load(skel);
> -	if (!ASSERT_ERR(err, "unexpected load success"))
> -		goto cleanup;
> -
> -	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
> -		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
> -		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> -	}
> -
> -cleanup:
> -	task_kfunc_failure__destroy(skel);
> -}
> -
>  void test_task_kfunc(void)
>  {
>  	int i;
> @@ -155,10 +91,5 @@ void test_task_kfunc(void)
>  		run_success_test(success_tests[i]);
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
> -		if (!test__start_subtest(failure_tests[i].prog_name))
> -			continue;
> -
> -		verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_msg);
> -	}
> +	RUN_TESTS(task_kfunc_failure);
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> index dae68de285b9..3a13e102c149 100644
> --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> @@ -19,8 +19,6 @@
>  
>  #include "../progs/test_user_ringbuf.h"
>  
> -static size_t log_buf_sz = 1 << 20; /* 1 MB */
> -static char obj_log_buf[1048576];
>  static const long c_sample_size = sizeof(struct sample) + BPF_RINGBUF_HDR_SZ;
>  static const long c_ringbuf_size = 1 << 12; /* 1 small page */
>  static const long c_max_entries = c_ringbuf_size / c_sample_size;
> @@ -663,23 +661,6 @@ static void test_user_ringbuf_blocking_reserve(void)
>  	user_ringbuf_success__destroy(skel);
>  }
>  
> -static struct {
> -	const char *prog_name;
> -	const char *expected_err_msg;
> -} failure_tests[] = {
> -	/* failure cases */
> -	{"user_ringbuf_callback_bad_access1", "negative offset dynptr_ptr ptr"},
> -	{"user_ringbuf_callback_bad_access2", "dereference of modified dynptr_ptr ptr"},
> -	{"user_ringbuf_callback_write_forbidden", "invalid mem access 'dynptr_ptr'"},
> -	{"user_ringbuf_callback_null_context_write", "invalid mem access 'scalar'"},
> -	{"user_ringbuf_callback_null_context_read", "invalid mem access 'scalar'"},
> -	{"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
> -	{"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
> -	{"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
> -	{"user_ringbuf_callback_reinit_dynptr_mem", "Dynptr has to be an uninitialized dynptr"},
> -	{"user_ringbuf_callback_reinit_dynptr_ringbuf", "Dynptr has to be an uninitialized dynptr"},
> -};
> -
>  #define SUCCESS_TEST(_func) { _func, #_func }
>  
>  static struct {
> @@ -700,42 +681,6 @@ static struct {
>  	SUCCESS_TEST(test_user_ringbuf_blocking_reserve),
>  };
>  
> -static void verify_fail(const char *prog_name, const char *expected_err_msg)
> -{
> -	LIBBPF_OPTS(bpf_object_open_opts, opts);
> -	struct bpf_program *prog;
> -	struct user_ringbuf_fail *skel;
> -	int err;
> -
> -	opts.kernel_log_buf = obj_log_buf;
> -	opts.kernel_log_size = log_buf_sz;
> -	opts.kernel_log_level = 1;
> -
> -	skel = user_ringbuf_fail__open_opts(&opts);
> -	if (!ASSERT_OK_PTR(skel, "dynptr_fail__open_opts"))
> -		goto cleanup;
> -
> -	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> -	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> -		goto cleanup;
> -
> -	bpf_program__set_autoload(prog, true);
> -
> -	bpf_map__set_max_entries(skel->maps.user_ringbuf, getpagesize());
> -
> -	err = user_ringbuf_fail__load(skel);
> -	if (!ASSERT_ERR(err, "unexpected load success"))
> -		goto cleanup;
> -
> -	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
> -		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
> -		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> -	}
> -
> -cleanup:
> -	user_ringbuf_fail__destroy(skel);
> -}
> -
>  void test_user_ringbuf(void)
>  {
>  	int i;
> @@ -747,10 +692,5 @@ void test_user_ringbuf(void)
>  		success_tests[i].test_callback();
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
> -		if (!test__start_subtest(failure_tests[i].prog_name))
> -			continue;
> -
> -		verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_msg);
> -	}
> +	RUN_TESTS(user_ringbuf_fail);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
> index a1369b5ebcf8..45f67d697864 100644
> --- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
> @@ -5,6 +5,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
>  
> +#include "bpf_misc.h"
>  #include "cgrp_kfunc_common.h"
>  
>  char _license[] SEC("license") = "GPL";
> @@ -28,6 +29,7 @@ static struct __cgrps_kfunc_map_value *insert_lookup_cgrp(struct cgroup *cgrp)
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("R1 must be referenced or trusted")
>  int BPF_PROG(cgrp_kfunc_acquire_untrusted, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *acquired;
> @@ -45,6 +47,7 @@ int BPF_PROG(cgrp_kfunc_acquire_untrusted, struct cgroup *cgrp, const char *path
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("arg#0 pointer type STRUCT cgroup must point")
>  int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *acquired, *stack_cgrp = (struct cgroup *)&path;
> @@ -57,6 +60,7 @@ int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp, const char *path)
>  }
>  
>  SEC("kretprobe/cgroup_destroy_locked")
> +__failure __msg("reg type unsupported for arg#0 function")
>  int BPF_PROG(cgrp_kfunc_acquire_unsafe_kretprobe, struct cgroup *cgrp)
>  {
>  	struct cgroup *acquired;
> @@ -69,6 +73,7 @@ int BPF_PROG(cgrp_kfunc_acquire_unsafe_kretprobe, struct cgroup *cgrp)
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("cgrp_kfunc_acquire_trusted_walked")
>  int BPF_PROG(cgrp_kfunc_acquire_trusted_walked, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *acquired;
> @@ -80,8 +85,8 @@ int BPF_PROG(cgrp_kfunc_acquire_trusted_walked, struct cgroup *cgrp, const char
>  	return 0;
>  }
>  
> -
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("arg#0 pointer type STRUCT cgroup must point")
>  int BPF_PROG(cgrp_kfunc_acquire_null, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *acquired;
> @@ -96,6 +101,7 @@ int BPF_PROG(cgrp_kfunc_acquire_null, struct cgroup *cgrp, const char *path)
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("Unreleased reference")
>  int BPF_PROG(cgrp_kfunc_acquire_unreleased, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *acquired;
> @@ -108,6 +114,7 @@ int BPF_PROG(cgrp_kfunc_acquire_unreleased, struct cgroup *cgrp, const char *pat
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("arg#0 expected pointer to map value")
>  int BPF_PROG(cgrp_kfunc_get_non_kptr_param, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *kptr;
> @@ -123,6 +130,7 @@ int BPF_PROG(cgrp_kfunc_get_non_kptr_param, struct cgroup *cgrp, const char *pat
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("arg#0 expected pointer to map value")
>  int BPF_PROG(cgrp_kfunc_get_non_kptr_acquired, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *kptr, *acquired;
> @@ -141,6 +149,7 @@ int BPF_PROG(cgrp_kfunc_get_non_kptr_acquired, struct cgroup *cgrp, const char *
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("arg#0 expected pointer to map value")
>  int BPF_PROG(cgrp_kfunc_get_null, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *kptr;
> @@ -156,6 +165,7 @@ int BPF_PROG(cgrp_kfunc_get_null, struct cgroup *cgrp, const char *path)
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("Unreleased reference")
>  int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *kptr;
> @@ -175,6 +185,7 @@ int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgroup *cgrp, const char *path)
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("Unreleased reference")
>  int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *kptr;
> @@ -194,6 +205,7 @@ int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup *cgrp, const char *path)
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket")
>  int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const char *path)
>  {
>  	struct __cgrps_kfunc_map_value *v;
> @@ -209,6 +221,7 @@ int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const char *path
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("arg#0 pointer type STRUCT cgroup must point")
>  int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *path)
>  {
>  	struct cgroup *acquired = (struct cgroup *)&path;
> @@ -220,6 +233,7 @@ int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *path)
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
>  int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *path)
>  {
>  	struct __cgrps_kfunc_map_value local, *v;
> @@ -251,6 +265,7 @@ int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *path)
>  }
>  
>  SEC("tp_btf/cgroup_mkdir")
> +__failure __msg("release kernel function bpf_cgroup_release expects")
>  int BPF_PROG(cgrp_kfunc_release_unacquired, struct cgroup *cgrp, const char *path)
>  {
>  	/* Cannot release trusted cgroup pointer which was not acquired. */
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> index 1b47b94dbca0..e6950d6a9cf0 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> @@ -5,6 +5,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
>  
> +#include "bpf_misc.h"
>  #include "task_kfunc_common.h"
>  
>  char _license[] SEC("license") = "GPL";
> @@ -27,6 +28,7 @@ static struct __tasks_kfunc_map_value *insert_lookup_task(struct task_struct *ta
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("R1 must be referenced or trusted")
>  int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *acquired;
> @@ -44,6 +46,7 @@ int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_f
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 pointer type STRUCT task_struct must point")
>  int BPF_PROG(task_kfunc_acquire_fp, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *acquired, *stack_task = (struct task_struct *)&clone_flags;
> @@ -56,6 +59,7 @@ int BPF_PROG(task_kfunc_acquire_fp, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("kretprobe/free_task")
> +__failure __msg("reg type unsupported for arg#0 function")
>  int BPF_PROG(task_kfunc_acquire_unsafe_kretprobe, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *acquired;
> @@ -68,6 +72,7 @@ int BPF_PROG(task_kfunc_acquire_unsafe_kretprobe, struct task_struct *task, u64
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("R1 must be referenced or trusted")
>  int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *acquired;
> @@ -81,6 +86,7 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
>  
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 pointer type STRUCT task_struct must point")
>  int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *acquired;
> @@ -95,6 +101,7 @@ int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("Unreleased reference")
>  int BPF_PROG(task_kfunc_acquire_unreleased, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *acquired;
> @@ -107,6 +114,7 @@ int BPF_PROG(task_kfunc_acquire_unreleased, struct task_struct *task, u64 clone_
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 expected pointer to map value")
>  int BPF_PROG(task_kfunc_get_non_kptr_param, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *kptr;
> @@ -122,6 +130,7 @@ int BPF_PROG(task_kfunc_get_non_kptr_param, struct task_struct *task, u64 clone_
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 expected pointer to map value")
>  int BPF_PROG(task_kfunc_get_non_kptr_acquired, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *kptr, *acquired;
> @@ -140,6 +149,7 @@ int BPF_PROG(task_kfunc_get_non_kptr_acquired, struct task_struct *task, u64 clo
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 expected pointer to map value")
>  int BPF_PROG(task_kfunc_get_null, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *kptr;
> @@ -155,6 +165,7 @@ int BPF_PROG(task_kfunc_get_null, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("Unreleased reference")
>  int BPF_PROG(task_kfunc_xchg_unreleased, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *kptr;
> @@ -174,6 +185,7 @@ int BPF_PROG(task_kfunc_xchg_unreleased, struct task_struct *task, u64 clone_fla
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("Unreleased reference")
>  int BPF_PROG(task_kfunc_get_unreleased, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *kptr;
> @@ -193,6 +205,7 @@ int BPF_PROG(task_kfunc_get_unreleased, struct task_struct *task, u64 clone_flag
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket")
>  int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_flags)
>  {
>  	struct __tasks_kfunc_map_value *v;
> @@ -208,6 +221,7 @@ int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_f
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 pointer type STRUCT task_struct must point")
>  int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *acquired = (struct task_struct *)&clone_flags;
> @@ -219,6 +233,7 @@ int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
>  int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
>  {
>  	struct __tasks_kfunc_map_value local, *v;
> @@ -251,6 +266,7 @@ int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("release kernel function bpf_task_release expects")
>  int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_flags)
>  {
>  	/* Cannot release trusted task pointer which was not acquired. */
> @@ -260,6 +276,7 @@ int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
>  int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 clone_flags)
>  {
>  	struct task_struct *acquired;
> @@ -273,6 +290,7 @@ int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 cl
>  }
>  
>  SEC("lsm/task_free")
> +__failure __msg("reg type unsupported for arg#0 function")
>  int BPF_PROG(task_kfunc_from_lsm_task_free, struct task_struct *task)
>  {
>  	struct task_struct *acquired;
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index f4a8250329b2..2fbef3cc7ad8 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -10,6 +10,7 @@
>  #include <errno.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
>  
>  extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
>  extern void bpf_key_put(struct bpf_key *key) __ksym;
> @@ -19,6 +20,7 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
>  
>  struct {
>  	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +	__uint(max_entries, 4096);
>  } ringbuf SEC(".maps");
>  
>  struct {
> @@ -33,6 +35,7 @@ int err, pid;
>  char _license[] SEC("license") = "GPL";
>  
>  SEC("?lsm.s/bpf")
> +__failure __msg("cannot pass in dynptr at an offset=-8")
>  int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
>  {
>  	unsigned long val;
> @@ -42,6 +45,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
>  }
>  
>  SEC("?lsm.s/bpf")
> +__failure __msg("arg#0 expected pointer to stack or dynptr_ptr")
>  int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
>  {
>  	unsigned long val;
> diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> index f3201dc69a60..03ee946c6bf7 100644
> --- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> +++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> @@ -16,6 +16,7 @@ struct sample {
>  
>  struct {
>  	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
> +	__uint(max_entries, 4096);
>  } user_ringbuf SEC(".maps");
>  
>  struct {
> @@ -39,7 +40,8 @@ bad_access1(struct bpf_dynptr *dynptr, void *context)
>  /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
>   * not be able to read before the pointer.
>   */
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("negative offset dynptr_ptr ptr")
>  int user_ringbuf_callback_bad_access1(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, bad_access1, NULL, 0);
> @@ -61,7 +63,8 @@ bad_access2(struct bpf_dynptr *dynptr, void *context)
>  /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
>   * not be able to read past the end of the pointer.
>   */
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("dereference of modified dynptr_ptr ptr")
>  int user_ringbuf_callback_bad_access2(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, bad_access2, NULL, 0);
> @@ -80,7 +83,8 @@ write_forbidden(struct bpf_dynptr *dynptr, void *context)
>  /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
>   * not be able to write to that pointer.
>   */
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'dynptr_ptr'")
>  int user_ringbuf_callback_write_forbidden(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, write_forbidden, NULL, 0);
> @@ -99,7 +103,8 @@ null_context_write(struct bpf_dynptr *dynptr, void *context)
>  /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
>   * not be able to write to that pointer.
>   */
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
>  int user_ringbuf_callback_null_context_write(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, null_context_write, NULL, 0);
> @@ -120,7 +125,8 @@ null_context_read(struct bpf_dynptr *dynptr, void *context)
>  /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
>   * not be able to write to that pointer.
>   */
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
>  int user_ringbuf_callback_null_context_read(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, null_context_read, NULL, 0);
> @@ -139,7 +145,8 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
>  /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
>   * not be able to read past the end of the pointer.
>   */
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("cannot release unowned const bpf_dynptr")
>  int user_ringbuf_callback_discard_dynptr(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
> @@ -158,7 +165,8 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
>  /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
>   * not be able to read past the end of the pointer.
>   */
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("cannot release unowned const bpf_dynptr")
>  int user_ringbuf_callback_submit_dynptr(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
> @@ -175,7 +183,8 @@ invalid_drain_callback_return(struct bpf_dynptr *dynptr, void *context)
>  /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
>   * not be able to write to that pointer.
>   */
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("At callback return the register R0 has value")
>  int user_ringbuf_callback_invalid_return(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, invalid_drain_callback_return, NULL, 0);
> @@ -197,14 +206,16 @@ try_reinit_dynptr_ringbuf(struct bpf_dynptr *dynptr, void *context)
>  	return 0;
>  }
>  
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("Dynptr has to be an uninitialized dynptr")
>  int user_ringbuf_callback_reinit_dynptr_mem(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_mem, NULL, 0);
>  	return 0;
>  }
>  
> -SEC("?raw_tp/")
> +SEC("?raw_tp")
> +__failure __msg("Dynptr has to be an uninitialized dynptr")
>  int user_ringbuf_callback_reinit_dynptr_ringbuf(void *ctx)
>  {
>  	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_ringbuf, NULL, 0);
> -- 
> 2.30.2
> 
