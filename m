Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3969C5ADDDC
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 05:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiIFDPn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Sep 2022 23:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiIFDPj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 23:15:39 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C3F27CD7;
        Mon,  5 Sep 2022 20:15:37 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b142so7933514iof.10;
        Mon, 05 Sep 2022 20:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DL2uVwExbtWwEe4F5r/jWUr5/aKbKx+Lizws5HPBS20=;
        b=iR8pv6HblribuScgnquxx0UhX4eILA5+v836mbx6m403NXEdKJM23ZoYO2BlFtCw8c
         lsl48lme9v02LIlFqNZxKk3teZkYaU1M66LybsOIupX3OOO7RvbF+HKblJeoH7eb9csI
         x4/QQ4doGfJe8aHGGb6ZzWhRBuWLlm+ffmuwswWUIYPYgMvVQN/xTYYGhk9R/OIvnDIE
         KBAY5whycKTqW5KT97FEBxHbjMp8kkdO4xEMWg13kmDLGIiSPsTa/vTYqE+8v5Q6c2O5
         EGuLEskm90lWrrIFX09nulZ6tv3y5GDkqeaZNlG0ROAXRyjC7hpJFgbURYEShnoKJTu6
         /V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DL2uVwExbtWwEe4F5r/jWUr5/aKbKx+Lizws5HPBS20=;
        b=718YGMp04QjdMgOB08JJHysYmfapYWTAPg2JXC3KXGJmbtVTRjJl9foILkqfGl1B7r
         SrethYRMrqnS8MPetslyaSU+WKzOH5/aQDosIHRuf8/gKe+dHcrl9XvR6yCRDRgNXdLW
         ghHIyDmDwaq9Va4tJYze95Ge0PqkIDU4Or3es6hvAgkfNfMnxRLWUHStmbwZqC8kgiwk
         ecDzPCM57QziE616o7xeW4V7CqE87H2aGU9syIkWv6lm4HcceskrfpuboYOyPPFcG2O0
         BlqhSehEGyD1LWMhKvqvWlnb+4hg5ag/W06psPHwfQDS3+dGFRT9mehPNDhEZk6zzgOQ
         xxzQ==
X-Gm-Message-State: ACgBeo0FV+m4yXLvTrTYMDvqRggDkdzuo7zZR+Con/9Bc6wjogxKfL/L
        l9CXeWxhfIdLT/6BaYuD9s19hCZ62T/fpyOiAsw=
X-Google-Smtp-Source: AA6agR7NL95rTJB757aHAtPmC4jTTLo1zqco1PQMANVQCqJ4DSJd9xys/J7bctVb2mGpSORoBpWDJvSynT36BYY2eMI=
X-Received: by 2002:a05:6602:2d8b:b0:688:ece0:e1da with SMTP id
 k11-20020a0566022d8b00b00688ece0e1damr23547118iow.18.1662434137169; Mon, 05
 Sep 2022 20:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-13-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-13-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 05:15:01 +0200
Message-ID: <CAP01T750hFZbHdRTzSSeWpc95Omp2-PLmOojhMohFGJD=yrTzg@mail.gmail.com>
Subject: Re: [PATCH v16 12/12] selftests/bpf: Add tests for dynamic pointers
 parameters in kfuncs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 5 Sept 2022 at 16:36, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add tests to ensure that only supported dynamic pointer types are accepted,
> that the passed argument is actually a dynamic pointer, and that the passed
> argument is a pointer to the stack.
>
> The tests are currently in the deny list for s390x (JIT does not support
> calling kernel function).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../bpf/prog_tests/kfunc_dynptr_param.c       | 103 ++++++++++++++++++
>  .../bpf/progs/test_kfunc_dynptr_param.c       |  57 ++++++++++
>  3 files changed, 161 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 4e305baa5277..9a6dc3671c65 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -71,3 +71,4 @@ cgroup_hierarchical_stats                # JIT does not support calling kernel f
>  htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
>  lookup_key                               # JIT does not support calling kernel function                                (kfunc)
>  verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
> +kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> new file mode 100644
> index 000000000000..ea655a5c9d8b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2022 Facebook
> + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + */
> +
> +#include <test_progs.h>
> +#include "test_kfunc_dynptr_param.skel.h"
> +
> +static size_t log_buf_sz = 1048576; /* 1 MB */
> +static char obj_log_buf[1048576];
> +
> +static struct {
> +       const char *prog_name;
> +       const char *expected_err_msg;
> +} kfunc_dynptr_tests[] = {
> +       {"dynptr_type_not_supp",
> +        "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type"},
> +       {"not_valid_dynptr",
> +        "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized"},
> +       {"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack"},
> +};
> +
> +static bool kfunc_not_supported;
> +
> +static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
> +                          va_list args)
> +{
> +       if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in kernel or module BTFs\n"))
> +               return 0;
> +
> +       if (strcmp(va_arg(args, char *), "bpf_verify_pkcs7_signature"))
> +               return 0;
> +
> +       kfunc_not_supported = true;
> +       return 0;
> +}
> +
> +static void verify_fail(const char *prog_name, const char *expected_err_msg)
> +{
> +       struct test_kfunc_dynptr_param *skel;
> +       LIBBPF_OPTS(bpf_object_open_opts, opts);
> +       libbpf_print_fn_t old_print_cb;
> +       struct bpf_program *prog;
> +       int err;
> +
> +       opts.kernel_log_buf = obj_log_buf;
> +       opts.kernel_log_size = log_buf_sz;
> +       opts.kernel_log_level = 1;
> +
> +       skel = test_kfunc_dynptr_param__open_opts(&opts);
> +       if (!ASSERT_OK_PTR(skel, "test_kfunc_dynptr_param__open_opts"))
> +               goto cleanup;
> +
> +       prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +       if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +               goto cleanup;
> +
> +       bpf_program__set_autoload(prog, true);
> +
> +       bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
> +
> +       kfunc_not_supported = false;
> +
> +       old_print_cb = libbpf_set_print(libbpf_print_cb);
> +       err = test_kfunc_dynptr_param__load(skel);
> +       libbpf_set_print(old_print_cb);
> +
> +       if (err < 0 && kfunc_not_supported) {
> +               fprintf(stderr,
> +                 "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not supported\n",
> +                 __func__);
> +               test__skip();
> +               goto cleanup;
> +       }
> +
> +       if (!ASSERT_ERR(err, "unexpected load success"))
> +               goto cleanup;
> +
> +       if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
> +               fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
> +               fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> +       }
> +
> +cleanup:
> +       test_kfunc_dynptr_param__destroy(skel);
> +}
> +
> +void test_kfunc_dynptr_param(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(kfunc_dynptr_tests); i++) {
> +               if (!test__start_subtest(kfunc_dynptr_tests[i].prog_name))
> +                       continue;
> +
> +               verify_fail(kfunc_dynptr_tests[i].prog_name,
> +                           kfunc_dynptr_tests[i].expected_err_msg);
> +       }
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> new file mode 100644
> index 000000000000..2f09f91a1576
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + */
> +
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct bpf_dynptr {
> +       __u64 :64;
> +       __u64 :64;
> +} __attribute__((aligned(8)));
> +
> +extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> +                                     struct bpf_dynptr *sig_ptr,
> +                                     struct bpf_key *trusted_keyring) __ksym;
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> +} ringbuf SEC(".maps");
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("?lsm.s/bpf")
> +int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
> +            unsigned int size)
> +{
> +       char write_data[64] = "hello there, world!!";
> +       struct bpf_dynptr ptr;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
> +
> +       return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
> +}
> +
> +SEC("?lsm.s/bpf")
> +int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
> +{
> +       unsigned long val;
> +
> +       return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
> +                                         (struct bpf_dynptr *)&val, NULL);
> +}
> +
> +SEC("?lsm.s/bpf")
> +int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
> +{
> +       unsigned long val;
> +
> +       return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
> +                                         (struct bpf_dynptr *)val, NULL);

Please also include a test where you cause the dynptr to be set to
NULL, e.g. by passing invalid stuff to ringbuf_reserve_dynptr, and
then try to pass it to bpf_verify_pkc7_signature.

> +}
> --
> 2.25.1
>
