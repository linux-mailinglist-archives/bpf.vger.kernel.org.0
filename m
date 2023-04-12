Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627A86DFD65
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDLSX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLSX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 14:23:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F71D273F
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:23:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4410117pjc.1
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681323807; x=1683915807;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HJm9m/6WKGorAkdx7Dnvf8R92kHgeurQKz4UocRAcjI=;
        b=bem0cOx7Mm7ItfiIBN7Oz/lo8HYN6Y1fBEc52jzFcsX5B+9ARSHmkSBYQ3NY+nUEqz
         /qmowhpQ9ypjo3nV8X+hslUXmE0UKAHure8VBLEMbIpBRIgQQiJBLewmDlOYK0juZejL
         xdclKY8ud3nvh5LqZPhv01vPoNHsMBe3R0d6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323807; x=1683915807;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJm9m/6WKGorAkdx7Dnvf8R92kHgeurQKz4UocRAcjI=;
        b=ilkkAC6MgmGWX6UHm/3ekfK6VP9gZ8Dphny5aiJSmU9gHi5LgOqx1UG6bGpXJLsBD4
         qXkkVEX3+S/fkXhPg432yjaL1eazUeuDxQwgFZGKp4iUtGcXzMP3ILmcE94PY8HhcrGL
         ef+Q1XV3pzcCsQEqNDLUwkgoxbeaVKEnwQ4N830NB76fwMn0PmLPardxEMcjJ5eBiNfQ
         X7D6W/lYkzT2Vxx5lei2S+kikfsjXscT3x6b1eUpcQe/OYJ827HdqY20eWqQiqYLpnHP
         u+hbftwAaMZMkfMLpXTbRb/IKK3+RBneN2idSr7y7ZMvLrOcqzLNG0lR2BmI3Yiwrxkx
         hEPg==
X-Gm-Message-State: AAQBX9eo+NLxzq8Fj6BZyJBdHx1GkyPY09ce7RoeKdzachByKcpDGsFh
        USE8jc7gXzp3cMG4W98AFQ9JYQ==
X-Google-Smtp-Source: AKy350YBpiGGMPsioJfSYi5pAtPdDR+a7HMFICYaZspDw999GJP8XSBkhsEVAsM2V17wgXKppHu4+A==
X-Received: by 2002:a17:90a:f481:b0:237:24eb:99d8 with SMTP id bx1-20020a17090af48100b0023724eb99d8mr168274pjb.19.1681323806778;
        Wed, 12 Apr 2023 11:23:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a5a4900b00246ea338c96sm1714353pji.53.2023.04.12.11.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:23:26 -0700 (PDT)
Message-ID: <6436f71e.170a0220.75de.385b@mx.google.com>
X-Google-Original-Message-ID: <202304121121.@keescook>
Date:   Wed, 12 Apr 2023 11:23:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/8] selftests/bpf: validate new
 bpf_map_create_security LSM hook
References: <20230412043300.360803-1-andrii@kernel.org>
 <20230412043300.360803-6-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412043300.360803-6-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 09:32:57PM -0700, Andrii Nakryiko wrote:
> Add selftests that goes over every known map type and validates that
> a combination of privileged/unprivileged modes and allow/reject/pass-through
> LSM policy decisions behave as expected.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/lsm_map_create.c | 143 ++++++++++++++++++
>  .../selftests/bpf/progs/lsm_map_create.c      |  32 ++++
>  tools/testing/selftests/bpf/test_progs.h      |   6 +
>  3 files changed, 181 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_map_create.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c b/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
> new file mode 100644
> index 000000000000..fee78b0448c3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#include "linux/bpf.h"
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "cap_helpers.h"
> +#include "lsm_map_create.skel.h"
> +
> +static int drop_priv_caps(__u64 *old_caps)
> +{
> +	return cap_disable_effective((1ULL << CAP_BPF) |
> +				     (1ULL << CAP_PERFMON) |
> +				     (1ULL << CAP_NET_ADMIN) |
> +				     (1ULL << CAP_SYS_ADMIN), old_caps);
> +}
> +
> +static int restore_priv_caps(__u64 old_caps)
> +{
> +	return cap_enable_effective(old_caps, NULL);
> +}
> +
> +void test_lsm_map_create(void)
> +{
> +	struct btf *btf = NULL;
> +	struct lsm_map_create *skel = NULL;
> +	const struct btf_type *t;
> +	const struct btf_enum *e;
> +	int i, n, id, err, ret;
> +
> +	skel = lsm_map_create__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	skel->bss->my_tid = syscall(SYS_gettid);
> +	skel->bss->decision = 0;
> +
> +	err = lsm_map_create__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
> +	if (!ASSERT_OK_PTR(btf, "btf_parse"))
> +		goto cleanup;
> +
> +	/* find enum bpf_map_type and enumerate each value */
> +	id = btf__find_by_name_kind(btf, "bpf_map_type", BTF_KIND_ENUM);
> +	if (!ASSERT_GT(id, 0, "bpf_map_type_id"))
> +		goto cleanup;
> +
> +	t = btf__type_by_id(btf, id);
> +	e = btf_enum(t);
> +	n = btf_vlen(t);
> +	for (i = 0; i < n; e++, i++) {
> +		enum bpf_map_type map_type = (enum bpf_map_type)e->val;
> +		const char *map_type_name;
> +		__u64 orig_caps;
> +		bool is_map_priv;
> +		bool needs_btf;
> +
> +		if (map_type == BPF_MAP_TYPE_UNSPEC)
> +			continue;
> +
> +		/* this will show which map type we are working with in verbose log */
> +		map_type_name = btf__str_by_offset(btf, e->name_off);
> +		ASSERT_OK_PTR(map_type_name, map_type_name);
> +
> +		switch (map_type) {
> +		case BPF_MAP_TYPE_ARRAY:
> +		case BPF_MAP_TYPE_PERCPU_ARRAY:
> +		case BPF_MAP_TYPE_PROG_ARRAY:
> +		case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
> +		case BPF_MAP_TYPE_CGROUP_ARRAY:
> +		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
> +		case BPF_MAP_TYPE_HASH:
> +		case BPF_MAP_TYPE_PERCPU_HASH:
> +		case BPF_MAP_TYPE_HASH_OF_MAPS:
> +		case BPF_MAP_TYPE_RINGBUF:
> +		case BPF_MAP_TYPE_USER_RINGBUF:
> +		case BPF_MAP_TYPE_CGROUP_STORAGE:
> +		case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
> +			is_map_priv = false;
> +			needs_btf = false;
> +			break;
> +		case BPF_MAP_TYPE_SK_STORAGE:
> +		case BPF_MAP_TYPE_INODE_STORAGE:
> +		case BPF_MAP_TYPE_TASK_STORAGE:
> +		case BPF_MAP_TYPE_CGRP_STORAGE:
> +			is_map_priv = true;
> +			needs_btf = true;
> +			break;
> +		default:
> +			is_map_priv = true;
> +			needs_btf = false;
> +		}
> +
> +		/* make sure we delegate to kernel for final decision */
> +		skel->bss->decision = 0;
> +
> +		/* we are normally under sudo, so all maps should succeed */
> +		ret = libbpf_probe_bpf_map_type(map_type, NULL);
> +		ASSERT_EQ(ret, 1, "default_priv_mode");
> +
> +		/* local storage needs custom BTF to be loaded, which we
> +		 * currently can't do once we drop privileges, so skip few
> +		 * checks for such maps
> +		 */
> +		if (needs_btf)
> +			goto skip_if_needs_btf;
> +
> +		/* now let's drop privileges, and chech that unpriv maps are
> +		 * still possible to create
> +		 */
> +		if (!ASSERT_OK(drop_priv_caps(&orig_caps), "drop_caps"))
> +			goto cleanup;
> +
> +		ret = libbpf_probe_bpf_map_type(map_type, NULL);
> +		ASSERT_EQ(ret, is_map_priv ? 0 : 1,  "default_unpriv_mode");
> +
> +		/* allow any map creation for our thread */
> +		skel->bss->decision = 1;
> +		ret = libbpf_probe_bpf_map_type(map_type, NULL);
> +		ASSERT_EQ(ret, 1, "lsm_allow_unpriv_mode");
> +
> +		/* reject any map creation for our thread */
> +		skel->bss->decision = -1;
> +		ret = libbpf_probe_bpf_map_type(map_type, NULL);
> +		ASSERT_EQ(ret, 0, "lsm_reject_unpriv_mode");
> +
> +		/* restore privileges, but keep reject LSM policy */
> +		if (!ASSERT_OK(restore_priv_caps(orig_caps), "restore_caps"))
> +			goto cleanup;
> +
> +skip_if_needs_btf:
> +		/* even with all caps map create will fail */
> +		skel->bss->decision = -1;
> +		ret = libbpf_probe_bpf_map_type(map_type, NULL);
> +		ASSERT_EQ(ret, 0, "lsm_reject_priv_mode");
> +	}
> +
> +cleanup:
> +	btf__free(btf);
> +	lsm_map_create__destroy(skel);
> +}

This test looks good! One meta-comment about testing would be: are you
sure each needs to be ASSERT instead of EXPECT? (i.e. should forward
progress through this test always be aborted when a check fails?)

> diff --git a/tools/testing/selftests/bpf/progs/lsm_map_create.c b/tools/testing/selftests/bpf/progs/lsm_map_create.c
> new file mode 100644
> index 000000000000..093825c68459
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lsm_map_create.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <errno.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int my_tid;
> +/* LSM enforcement:
> + *   - 0, delegate to kernel;
> + *   - 1, allow;
> + *   - -1, reject.
> + */
> +int decision;
> +
> +SEC("lsm/bpf_map_create_security")
> +int BPF_PROG(allow_unpriv_maps, union bpf_attr *attr)
> +{
> +	if (!my_tid || (u32)bpf_get_current_pid_tgid() != my_tid)
> +		return 0; /* keep processing LSM hooks */
> +
> +	if (decision == 0)
> +		return 0;
> +
> +	if (decision > 0)
> +		return 1; /* allow */
> +
> +	return -EPERM;
> +}
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 10ba43250668..12f9c6652d40 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -23,6 +23,7 @@ typedef __u16 __sum16;
>  #include <linux/perf_event.h>
>  #include <linux/socket.h>
>  #include <linux/unistd.h>
> +#include <sys/syscall.h>
>  
>  #include <sys/ioctl.h>
>  #include <sys/wait.h>
> @@ -176,6 +177,11 @@ void test__skip(void);
>  void test__fail(void);
>  int test__join_cgroup(const char *path);
>  
> +static inline int gettid(void)
> +{
> +	return syscall(SYS_gettid);
> +}
> +
>  #define PRINT_FAIL(format...)                                                  \
>  	({                                                                     \
>  		test__fail();                                                  \
> -- 
> 2.34.1
> 

-- 
Kees Cook
