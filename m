Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6E674CCF
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjATFw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjATFwY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:52:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D94E28D34;
        Thu, 19 Jan 2023 21:51:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so640102pjq.1;
        Thu, 19 Jan 2023 21:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kwCnJakJTn9sjc7fYoNGcrnwjXvaleeQl4wY0uxRZ4=;
        b=GaGUwTPP6wPnsOND3Fz2vgBD1byJy/sh1bHtkZ45fkQa7+zIkkBtC1dbZ9BbUWKKv1
         sgcdHtul1XG9GUBsDthDfMutpJAVD67UPMx6NMUo+xfBJGmcqNXrYMNAER7sxZByjGvQ
         4IcW5E1HpgWgxlST7EUs4TZcLQdjEjJTsvD4GOC9tT5vlxE/FxOBTaxkbY67kglgTm4p
         gFpp3TthEq7n7jB/2scRjTV2TNvRNtKTpcPGZiLhwoRw9fCs/6B3ZLOrQ2XAB6t15Ln4
         XSbz3QjIMfU5qUHWy25hl6VGSWj3j/1J+peZdY8cRPRZnzGIbeXlDw8PiEZT8tBquHOu
         VweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kwCnJakJTn9sjc7fYoNGcrnwjXvaleeQl4wY0uxRZ4=;
        b=vDKPGzjS4K6xWmLNVOrNmlj/Ym/D712dxBNZeuLc1yo0XRwS351Vn61kJOSKkCNMOR
         8Rksb0/HZCfZzZGkpm/i0Cg7zkpn37ELIXMLyweoRJACGKEgc1fuuuxB3Pq03LDMXaPY
         SrBDxwTOxoZJPBKSwDPYDhNSazYM0Sa5mxHkamkvkVHgxwsNjsTIGsgO7hpzqDyajnZh
         kWVgp4bFEuE861dq2XIfen6Z3gwA5MvxIGPOEtG923ENnFMB3g6oXcWqjhuE8dtiI7A9
         rrqcrp9BuGZZTaJ53WZS2jyMULtkF1rfFrlZ6s24qGPgQ55h4me24KVdTMLZGrEdyNTp
         2NcQ==
X-Gm-Message-State: AFqh2krA99oQOvgI/QpU6kbfNcbRgxSNXnc0hqjeL5Jifdd0uwZbOOOD
        Bvez72TiuQlrkvWOFsLdNGc=
X-Google-Smtp-Source: AMrXdXtP64xfcwKZ8lq4sdSuInkli+Piw/ZJto4RNxeshUvr9K/CC/HHNwKEjAFfB9sTtQcndKXuVQ==
X-Received: by 2002:a05:6a20:8e1f:b0:b8:89f5:4e96 with SMTP id y31-20020a056a208e1f00b000b889f54e96mr16920985pzj.26.1674193913416;
        Thu, 19 Jan 2023 21:51:53 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id 134-20020a62148c000000b0056bc30e618dsm25039856pfu.38.2023.01.19.21.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:51:52 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:51:49 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 5/8] selftests/bpf: Add nested trust selftests
 suite
Message-ID: <20230120055149.tfpv3yzbbsm6snqv@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-6-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119235833.2948341-6-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 05:58:30PM -0600, David Vernet wrote:
> Now that defining trusted fields in a struct is supported, we should add
> selftests to verify the behavior. This patch adds a few such testcases.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>  .../selftests/bpf/prog_tests/nested_trust.c   | 64 +++++++++++++++++++
>  .../selftests/bpf/progs/nested_trust_common.h | 12 ++++
>  .../bpf/progs/nested_trust_failure.c          | 33 ++++++++++
>  .../bpf/progs/nested_trust_success.c          | 29 +++++++++
>  5 files changed, 139 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/nested_trust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_common.h
>  create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_failure.c
>  create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_success.c
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 96e8371f5c2a..1cf5b94cda30 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -44,6 +44,7 @@ map_kptr                                 # failed to open_and_load program: -524
>  modify_return                            # modify_return attach failed: -524                                           (trampoline)
>  module_attach                            # skel_attach skeleton attach failed: -524                                    (trampoline)
>  mptcp
> +nested_trust                             # JIT does not support calling kernel function
>  netcnt                                   # failed to load BPF skeleton 'netcnt_prog': -7                               (?)
>  probe_user                               # check_kprobe_res wrong kprobe res from probe read                           (?)
>  rcu_read_lock                            # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
> diff --git a/tools/testing/selftests/bpf/prog_tests/nested_trust.c b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
> new file mode 100644
> index 000000000000..4d13612f5001
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include "nested_trust_failure.skel.h"
> +#include "nested_trust_success.skel.h"
> +
> +static const char * const nested_trust_success_testcases[] = {
> +	"test_read_cpumask",
> +};
> +
> +static void verify_success(const char *prog_name)
> +{
> +	struct nested_trust_success *skel;
> +	struct bpf_program *prog;
> +	struct bpf_link *link = NULL;
> +	int status;
> +	pid_t child_pid;
> +
> +	skel = nested_trust_success__open();
> +	if (!ASSERT_OK_PTR(skel, "nested_trust_success__open"))
> +		return;
> +
> +	skel->bss->pid = getpid();
> +
> +	nested_trust_success__load(skel);
> +	if (!ASSERT_OK_PTR(skel, "nested_trust_success__load"))
> +		goto cleanup;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach(prog);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> +		goto cleanup;
> +
> +	child_pid = fork();
> +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
> +		goto cleanup;
> +	if (child_pid == 0)
> +		_exit(0);
> +	waitpid(child_pid, &status, 0);
> +	ASSERT_OK(skel->bss->err, "post_wait_err");
> +
> +	bpf_link__destroy(link);
> +
> +cleanup:
> +	nested_trust_success__destroy(skel);
> +}
> +
> +void test_nested_trust(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(nested_trust_success_testcases); i++) {
> +		if (!test__start_subtest(nested_trust_success_testcases[i]))
> +			continue;
> +
> +		verify_success(nested_trust_success_testcases[i]);
> +	}
> +
> +	RUN_TESTS(nested_trust_failure);
> +}

Hmm. I thought RUN_TESTS() works for successes too.
Looking at test_loader.c:run_subtest() that should be the case.
Could you please double check?
verify_success() above shouldn't be needed.
