Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D12662E94F
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiKQXFk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbiKQXFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:05:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E426749097
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:05:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s5so4731956edc.12
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y2kOr1LAG1+rr06SlbXwaN4Fyu7lnCR4pWOUebacD9c=;
        b=BDnToLXmnkWxZMGPBxGfHvJLAlNxksr2CoKlJysUEyzoca3C6c+uEtb0mcIXd7ujNX
         Lb8SNH9moGtFWQg87ttdyfXlltm2qYDq+A3p7IIKphUUw/XMp6TI3Zk3TwbkYuIaRWGi
         I9/9AJdj3VWkmTE3A9OlzNtMuEg+YjjBno5B7J2mvp4KHh8dd2HcUh29Afp/GwI8dFtE
         B5zDxXpxFc8MSLNEwWM1qsEllQ3KE/A0408BHJHj/UupFYgew3bLJVsdOQmSHd9N4NYi
         WtdtcX+gmCO2tSAxxJPO9Fc+94XoluHgWg34ZBHO4X4bHGbULQAzWso0JijfS38dW77y
         Rj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2kOr1LAG1+rr06SlbXwaN4Fyu7lnCR4pWOUebacD9c=;
        b=71I7lER/00LTtAm5axZQuhk7vZytEC+g0ZJm02GTFpqP3OsGH3POAN+18hMMEuXEYX
         w8Urr+T2inmtIbaw+w0VktcfCj+LUZsz+CO73fDGNWvmvkyeNEtExUioWNXNy9x2bRNg
         olg5UGxBV1rN+atUBfUkR3ejYWz5Uld2M0ZP7YBSYZLNENrCJNp/uk0kHOrQsn7uh1Rs
         +BGY4YPEAlf1kNlsup3WV7I0cvx9r/ASLr94xByARgiKJfP23DSbqnXN7oQvW6qqotLw
         02nvvrcRlnXjEKnHNyPIK9mlNAA+EfEw+4Is3903qYULTljInfmfTmGEsqLYM/6zhsHo
         6Fpg==
X-Gm-Message-State: ANoB5pl+RDHZ8V+LpL8Jur1gKthZw8m65gPYKF2PhSobE24AbR1KswHN
        WvVpHqXu/0GQbnXr+LcFw4L4O9Qo7OM+rkld3Ds=
X-Google-Smtp-Source: AA0mqf47419fCZoHgK1lnM69IGsgJmOF7WjuSCKOt4kfUNsvMPLiYTCFjNHctoL6Gcfb5l7Z5RHPaC2YqGVdmNWEKL8=
X-Received: by 2002:aa7:d604:0:b0:461:d726:438f with SMTP id
 c4-20020aa7d604000000b00461d726438fmr4025367edr.333.1668726333140; Thu, 17
 Nov 2022 15:05:33 -0800 (PST)
MIME-Version: 1.0
References: <20221117225510.1676785-1-memxor@gmail.com> <20221117225510.1676785-23-memxor@gmail.com>
In-Reply-To: <20221117225510.1676785-23-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 17 Nov 2022 15:05:21 -0800
Message-ID: <CAADnVQKHibbQUNkwvd0g3YDK8n7k6g21=_TFd1=ccRFYJWrsOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 22/23] selftests/bpf: Add BPF linked list API tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 2:56 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Include various tests covering the success and failure cases. Also, run
> the success cases at runtime to verify correctness of linked list
> manipulation routines, in addition to ensuring successful verification.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../selftests/bpf/prog_tests/linked_list.c    | 255 ++++++++
>  .../testing/selftests/bpf/progs/linked_list.c | 370 +++++++++++
>  .../testing/selftests/bpf/progs/linked_list.h |  56 ++
>  .../selftests/bpf/progs/linked_list_fail.c    | 581 ++++++++++++++++++
>  5 files changed, 1263 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
>  create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
>  create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
>  create mode 100644 tools/testing/selftests/bpf/progs/linked_list_fail.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index be4e3d47ea3e..072243af93b0 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -33,6 +33,7 @@ ksyms_module                             # test_ksyms_module__open_and_load unex
>  ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
>  ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
>  libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
> +linked_list                             # JIT does not support calling kernel function                                (kfunc)

probably needs it in arm64 denylist as well.

>  lookup_key                               # JIT does not support calling kernel function                                (kfunc)
>  lru_bug                                  # prog 'printk': failed to auto-attach: -524
>  map_kptr                                 # failed to open_and_load program: -524 (trampoline)
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> new file mode 100644
> index 000000000000..32ff1684a7d3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "linked_list.skel.h"
> +#include "linked_list_fail.skel.h"
> +
> +static char log_buf[1024 * 1024];
> +
> +static struct {
> +       const char *prog_name;
> +       const char *err_msg;
> +} linked_list_fail_tests[] = {
> +#define TEST(test, off) \
> +       { #test "_missing_lock_push_front", \
> +         "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
> +       { #test "_missing_lock_push_back", \
> +         "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
> +       { #test "_missing_lock_pop_front", \
> +         "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
> +       { #test "_missing_lock_pop_back", \
> +         "bpf_spin_lock at off=" #off " must be held for bpf_list_head" },
> +       TEST(kptr, 32)
> +       TEST(global, 16)
> +       TEST(map, 0)
> +       TEST(inner_map, 0)
> +#undef TEST
> +#define TEST(test, op) \
> +       { #test "_kptr_incorrect_lock_" #op, \
> +         "held lock and object are not in the same allocation\n" \
> +         "bpf_spin_lock at off=32 must be held for bpf_list_head" }, \
> +       { #test "_global_incorrect_lock_" #op, \
> +         "held lock and object are not in the same allocation\n" \
> +         "bpf_spin_lock at off=16 must be held for bpf_list_head" }, \
> +       { #test "_map_incorrect_lock_" #op, \
> +         "held lock and object are not in the same allocation\n" \
> +         "bpf_spin_lock at off=0 must be held for bpf_list_head" }, \
> +       { #test "_inner_map_incorrect_lock_" #op, \
> +         "held lock and object are not in the same allocation\n" \
> +         "bpf_spin_lock at off=0 must be held for bpf_list_head" },
> +       TEST(kptr, push_front)
> +       TEST(kptr, push_back)
> +       TEST(kptr, pop_front)
> +       TEST(kptr, pop_back)
> +       TEST(global, push_front)
> +       TEST(global, push_back)
> +       TEST(global, pop_front)
> +       TEST(global, pop_back)
> +       TEST(map, push_front)
> +       TEST(map, push_back)
> +       TEST(map, pop_front)
> +       TEST(map, pop_back)
> +       TEST(inner_map, push_front)
> +       TEST(inner_map, push_back)
> +       TEST(inner_map, pop_front)
> +       TEST(inner_map, pop_back)
> +#undef TEST
> +       { "map_compat_kprobe", "tracing progs cannot use bpf_list_head yet" },
> +       { "map_compat_kretprobe", "tracing progs cannot use bpf_list_head yet" },
> +       { "map_compat_tp", "tracing progs cannot use bpf_list_head yet" },
> +       { "map_compat_perf", "tracing progs cannot use bpf_list_head yet" },
> +       { "map_compat_raw_tp", "tracing progs cannot use bpf_list_head yet" },
> +       { "map_compat_raw_tp_w", "tracing progs cannot use bpf_list_head yet" },
> +       { "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
> +       { "obj_new_no_composite", "bpf_obj_new type ID argument must be of a struct" },
> +       { "obj_new_no_struct", "bpf_obj_new type ID argument must be of a struct" },
> +       { "obj_drop_non_zero_off", "R1 must have zero offset when passed to release func" },
> +       { "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
> +       { "obj_new_acq", "Unreleased reference id=" },
> +       { "use_after_drop", "invalid mem access 'scalar'" },
> +       { "ptr_walk_scalar", "type=scalar expected=percpu_ptr_" },
> +       { "direct_read_lock", "direct access to bpf_spin_lock is disallowed" },
> +       { "direct_write_lock", "direct access to bpf_spin_lock is disallowed" },
> +       { "direct_read_head", "direct access to bpf_list_head is disallowed" },
> +       { "direct_write_head", "direct access to bpf_list_head is disallowed" },
> +       { "direct_read_node", "direct access to bpf_list_node is disallowed" },
> +       { "direct_write_node", "direct access to bpf_list_node is disallowed" },
> +       { "write_after_push_front", "only read is supported" },
> +       { "write_after_push_back", "only read is supported" },
> +       { "use_after_unlock_push_front", "invalid mem access 'scalar'" },
> +       { "use_after_unlock_push_back", "invalid mem access 'scalar'" },
> +       { "double_push_front", "arg#1 expected pointer to allocated object" },
> +       { "double_push_back", "arg#1 expected pointer to allocated object" },
> +       { "no_node_value_type", "bpf_list_node not found for allocated object\n" },
> +       { "incorrect_value_type",
> +         "operation on bpf_list_head expects arg#1 bpf_list_node at offset=0 in struct foo, "
> +         "but arg is at offset=0 in struct bar" },
> +       { "incorrect_node_var_off", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
> +       { "incorrect_node_off1", "bpf_list_node not found at offset=1" },
> +       { "incorrect_node_off2", "arg#1 offset=40, but expected bpf_list_node at offset=0 in struct foo" },
> +       { "no_head_type", "bpf_list_head not found for allocated object" },
> +       { "incorrect_head_var_off1", "R1 doesn't have constant offset" },
> +       { "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
> +       { "incorrect_head_off1", "bpf_list_head not found at offset=17" },
> +       { "incorrect_head_off2", "bpf_list_head not found at offset=1" },
> +       { "pop_front_off",
> +         "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) "
> +         "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) refs=2,4\n"
> +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=ptr_or_null_ expected=percpu_ptr_" },
> +       { "pop_back_off",
> +         "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) "
> +         "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) refs=2,4\n"
> +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=ptr_or_null_ expected=percpu_ptr_" },
> +};
> +
> +static void test_linked_list_fail_prog(const char *prog_name, const char *err_msg)
> +{
> +       LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
> +                                               .kernel_log_size = sizeof(log_buf),
> +                                               .kernel_log_level = 1);
> +       struct linked_list_fail *skel;
> +       struct bpf_program *prog;
> +       int ret;
> +
> +       skel = linked_list_fail__open_opts(&opts);
> +       if (!ASSERT_OK_PTR(skel, "linked_list_fail__open_opts"))
> +               return;
> +
> +       prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +       if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +               goto end;
> +
> +       bpf_program__set_autoload(prog, true);
> +
> +       ret = linked_list_fail__load(skel);
> +       if (!ASSERT_ERR(ret, "linked_list_fail__load must fail"))
> +               goto end;
> +
> +       if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
> +               fprintf(stderr, "Expected: %s\n", err_msg);
> +               fprintf(stderr, "Verifier: %s\n", log_buf);
> +       }
> +
> +end:
> +       linked_list_fail__destroy(skel);
> +}
> +
> +static void clear_fields(struct bpf_map *map)
> +{
> +       char buf[24];
> +       int key = 0;
> +
> +       memset(buf, 0xff, sizeof(buf));
> +       ASSERT_OK(bpf_map__update_elem(map, &key, sizeof(key), buf, sizeof(buf), 0), "check_and_free_fields");
> +}
> +
> +enum {
> +       TEST_ALL,
> +       PUSH_POP,
> +       PUSH_POP_MULT,
> +       LIST_IN_LIST,
> +};
> +
> +static void test_linked_list_success(int mode, bool leave_in_map)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts,
> +               .data_in = &pkt_v4,
> +               .data_size_in = sizeof(pkt_v4),
> +               .repeat = 1,
> +       );
> +       struct linked_list *skel;
> +       int ret;
> +
> +       skel = linked_list__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "linked_list__open_and_load"))
> +               return;
> +
> +       if (mode == LIST_IN_LIST)
> +               goto lil;
> +       if (mode == PUSH_POP_MULT)
> +               goto ppm;
> +
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_push_pop), &opts);
> +       ASSERT_OK(ret, "map_list_push_pop");
> +       ASSERT_OK(opts.retval, "map_list_push_pop retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.array_map);
> +
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_push_pop), &opts);
> +       ASSERT_OK(ret, "inner_map_list_push_pop");
> +       ASSERT_OK(opts.retval, "inner_map_list_push_pop retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.inner_map);
> +
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop), &opts);
> +       ASSERT_OK(ret, "global_list_push_pop");
> +       ASSERT_OK(opts.retval, "global_list_push_pop retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.data_A);
> +
> +       if (mode == PUSH_POP)
> +               goto end;
> +
> +ppm:
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_push_pop_multiple), &opts);
> +       ASSERT_OK(ret, "map_list_push_pop_multiple");
> +       ASSERT_OK(opts.retval, "map_list_push_pop_multiple retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.array_map);
> +
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_push_pop_multiple), &opts);
> +       ASSERT_OK(ret, "inner_map_list_push_pop_multiple");
> +       ASSERT_OK(opts.retval, "inner_map_list_push_pop_multiple retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.inner_map);
> +
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_multiple), &opts);
> +       ASSERT_OK(ret, "global_list_push_pop_multiple");
> +       ASSERT_OK(opts.retval, "global_list_push_pop_multiple retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.data_A);
> +
> +       if (mode == PUSH_POP_MULT)
> +               goto end;
> +
> +lil:
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_in_list), &opts);
> +       ASSERT_OK(ret, "map_list_in_list");
> +       ASSERT_OK(opts.retval, "map_list_in_list retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.array_map);
> +
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_in_list), &opts);
> +       ASSERT_OK(ret, "inner_map_list_in_list");
> +       ASSERT_OK(opts.retval, "inner_map_list_in_list retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.inner_map);
> +
> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_in_list), &opts);
> +       ASSERT_OK(ret, "global_list_in_list");
> +       ASSERT_OK(opts.retval, "global_list_in_list retval");
> +       if (!leave_in_map)
> +               clear_fields(skel->maps.data_A);
> +end:
> +       linked_list__destroy(skel);
> +}
> +
> +void test_linked_list(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(linked_list_fail_tests); i++) {
> +               if (!test__start_subtest(linked_list_fail_tests[i].prog_name))
> +                       continue;
> +               test_linked_list_fail_prog(linked_list_fail_tests[i].prog_name,
> +                                          linked_list_fail_tests[i].err_msg);
> +       }
> +       test_linked_list_success(PUSH_POP, false);
> +       test_linked_list_success(PUSH_POP, true);
> +       test_linked_list_success(PUSH_POP_MULT, false);
> +       test_linked_list_success(PUSH_POP_MULT, true);
> +       test_linked_list_success(LIST_IN_LIST, false);
> +       test_linked_list_success(LIST_IN_LIST, true);
> +       test_linked_list_success(TEST_ALL, false);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
> new file mode 100644
> index 000000000000..2c7b615c6d41
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/linked_list.c
> @@ -0,0 +1,370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_experimental.h"
> +
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +#endif
> +
> +#include "linked_list.h"
> +
> +static __always_inline
> +int list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
> +{
> +       struct bpf_list_node *n;
> +       struct foo *f;
> +
> +       f = bpf_obj_new(typeof(*f));
> +       if (!f)
> +               return 2;
> +
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_front(head);
> +       bpf_spin_unlock(lock);
> +       if (n) {
> +               bpf_obj_drop(container_of(n, struct foo, node));
> +               bpf_obj_drop(f);
> +               return 3;
> +       }
> +
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_back(head);
> +       bpf_spin_unlock(lock);
> +       if (n) {
> +               bpf_obj_drop(container_of(n, struct foo, node));
> +               bpf_obj_drop(f);
> +               return 4;
> +       }
> +
> +
> +       bpf_spin_lock(lock);
> +       f->data = 42;
> +       bpf_list_push_front(head, &f->node);
> +       bpf_spin_unlock(lock);
> +       if (leave_in_map)
> +               return 0;
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_back(head);
> +       bpf_spin_unlock(lock);
> +       if (!n)
> +               return 5;
> +       f = container_of(n, struct foo, node);
> +       if (f->data != 42) {
> +               bpf_obj_drop(f);
> +               return 6;
> +       }
> +
> +       bpf_spin_lock(lock);
> +       f->data = 13;
> +       bpf_list_push_front(head, &f->node);
> +       bpf_spin_unlock(lock);
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_front(head);
> +       bpf_spin_unlock(lock);
> +       if (!n)
> +               return 7;
> +       f = container_of(n, struct foo, node);
> +       if (f->data != 13) {
> +               bpf_obj_drop(f);
> +               return 8;
> +       }
> +       bpf_obj_drop(f);
> +
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_front(head);
> +       bpf_spin_unlock(lock);
> +       if (n) {
> +               bpf_obj_drop(container_of(n, struct foo, node));
> +               return 9;
> +       }
> +
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_back(head);
> +       bpf_spin_unlock(lock);
> +       if (n) {
> +               bpf_obj_drop(container_of(n, struct foo, node));
> +               return 10;
> +       }
> +       return 0;
> +}
> +
> +
> +static __always_inline
> +int list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
> +{
> +       struct bpf_list_node *n;
> +       struct foo *f[8], *pf;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(f); i++) {
> +               f[i] = bpf_obj_new(typeof(**f));
> +               if (!f[i])
> +                       return 2;
> +               f[i]->data = i;
> +               bpf_spin_lock(lock);
> +               bpf_list_push_front(head, &f[i]->node);
> +               bpf_spin_unlock(lock);
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(f); i++) {
> +               bpf_spin_lock(lock);
> +               n = bpf_list_pop_front(head);
> +               bpf_spin_unlock(lock);
> +               if (!n)
> +                       return 3;
> +               pf = container_of(n, struct foo, node);
> +               if (pf->data != (ARRAY_SIZE(f) - i - 1)) {
> +                       bpf_obj_drop(pf);
> +                       return 4;
> +               }
> +               bpf_spin_lock(lock);
> +               bpf_list_push_back(head, &pf->node);
> +               bpf_spin_unlock(lock);
> +       }
> +
> +       if (leave_in_map)
> +               return 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(f); i++) {
> +               bpf_spin_lock(lock);
> +               n = bpf_list_pop_back(head);
> +               bpf_spin_unlock(lock);
> +               if (!n)
> +                       return 5;
> +               pf = container_of(n, struct foo, node);
> +               if (pf->data != i) {
> +                       bpf_obj_drop(pf);
> +                       return 6;
> +               }
> +               bpf_obj_drop(pf);
> +       }
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_back(head);
> +       bpf_spin_unlock(lock);
> +       if (n) {
> +               bpf_obj_drop(container_of(n, struct foo, node));
> +               return 7;
> +       }
> +
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_front(head);
> +       bpf_spin_unlock(lock);
> +       if (n) {
> +               bpf_obj_drop(container_of(n, struct foo, node));
> +               return 8;
> +       }
> +       return 0;
> +}
> +
> +static __always_inline
> +int list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
> +{
> +       struct bpf_list_node *n;
> +       struct bar *ba[8], *b;
> +       struct foo *f;
> +       int i;
> +
> +       f = bpf_obj_new(typeof(*f));
> +       if (!f)
> +               return 2;
> +       for (i = 0; i < ARRAY_SIZE(ba); i++) {
> +               b = bpf_obj_new(typeof(*b));
> +               if (!b) {
> +                       bpf_obj_drop(f);
> +                       return 3;
> +               }
> +               b->data = i;
> +               bpf_spin_lock(&f->lock);
> +               bpf_list_push_back(&f->head, &b->node);
> +               bpf_spin_unlock(&f->lock);
> +       }
> +
> +       bpf_spin_lock(lock);
> +       f->data = 42;
> +       bpf_list_push_front(head, &f->node);
> +       bpf_spin_unlock(lock);
> +
> +       if (leave_in_map)
> +               return 0;
> +
> +       bpf_spin_lock(lock);
> +       n = bpf_list_pop_front(head);
> +       bpf_spin_unlock(lock);
> +       if (!n)
> +               return 4;
> +       f = container_of(n, struct foo, node);
> +       if (f->data != 42) {
> +               bpf_obj_drop(f);
> +               return 5;
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(ba); i++) {
> +               bpf_spin_lock(&f->lock);
> +               n = bpf_list_pop_front(&f->head);
> +               bpf_spin_unlock(&f->lock);
> +               if (!n) {
> +                       bpf_obj_drop(f);
> +                       return 6;
> +               }
> +               b = container_of(n, struct bar, node);
> +               if (b->data != i) {
> +                       bpf_obj_drop(f);
> +                       bpf_obj_drop(b);
> +                       return 7;
> +               }
> +               bpf_obj_drop(b);
> +       }
> +       bpf_spin_lock(&f->lock);
> +       n = bpf_list_pop_front(&f->head);
> +       bpf_spin_unlock(&f->lock);
> +       if (n) {
> +               bpf_obj_drop(f);
> +               bpf_obj_drop(container_of(n, struct bar, node));
> +               return 8;
> +       }
> +       bpf_obj_drop(f);
> +       return 0;
> +}
> +
> +static __always_inline
> +int test_list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head)
> +{
> +       int ret;
> +
> +       ret = list_push_pop(lock, head, false);
> +       if (ret)
> +               return ret;
> +       return list_push_pop(lock, head, true);
> +}
> +
> +static __always_inline
> +int test_list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *head)
> +{
> +       int ret;
> +
> +       ret = list_push_pop_multiple(lock ,head, false);
> +       if (ret)
> +               return ret;
> +       return list_push_pop_multiple(lock, head, true);
> +}
> +
> +static __always_inline
> +int test_list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head)
> +{
> +       int ret;
> +
> +       ret = list_in_list(lock, head, false);
> +       if (ret)
> +               return ret;
> +       return list_in_list(lock, head, true);
> +}
> +
> +SEC("tc")
> +int map_list_push_pop(void *ctx)
> +{
> +       struct map_value *v;
> +
> +       v = bpf_map_lookup_elem(&array_map, &(int){0});
> +       if (!v)
> +               return 1;
> +       return test_list_push_pop(&v->lock, &v->head);
> +}
> +
> +SEC("tc")
> +int inner_map_list_push_pop(void *ctx)
> +{
> +       struct map_value *v;
> +       void *map;
> +
> +       map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
> +       if (!map)
> +               return 1;
> +       v = bpf_map_lookup_elem(map, &(int){0});
> +       if (!v)
> +               return 1;
> +       return test_list_push_pop(&v->lock, &v->head);
> +}
> +
> +SEC("tc")
> +int global_list_push_pop(void *ctx)
> +{
> +       return test_list_push_pop(&glock, &ghead);
> +}
> +
> +SEC("tc")
> +int map_list_push_pop_multiple(void *ctx)
> +{
> +       struct map_value *v;
> +       int ret;
> +
> +       v = bpf_map_lookup_elem(&array_map, &(int){0});
> +       if (!v)
> +               return 1;
> +       return test_list_push_pop_multiple(&v->lock, &v->head);
> +}
> +
> +SEC("tc")
> +int inner_map_list_push_pop_multiple(void *ctx)
> +{
> +       struct map_value *v;
> +       void *map;
> +       int ret;
> +
> +       map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
> +       if (!map)
> +               return 1;
> +       v = bpf_map_lookup_elem(map, &(int){0});
> +       if (!v)
> +               return 1;
> +       return test_list_push_pop_multiple(&v->lock, &v->head);
> +}
> +
> +SEC("tc")
> +int global_list_push_pop_multiple(void *ctx)
> +{
> +       int ret;
> +
> +       ret = list_push_pop_multiple(&glock, &ghead, false);
> +       if (ret)
> +               return ret;
> +       return list_push_pop_multiple(&glock, &ghead, true);
> +}
> +
> +SEC("tc")
> +int map_list_in_list(void *ctx)
> +{
> +       struct map_value *v;
> +       int ret;
> +
> +       v = bpf_map_lookup_elem(&array_map, &(int){0});
> +       if (!v)
> +               return 1;
> +       return test_list_in_list(&v->lock, &v->head);
> +}
> +
> +SEC("tc")
> +int inner_map_list_in_list(void *ctx)
> +{
> +       struct map_value *v;
> +       void *map;
> +       int ret;
> +
> +       map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
> +       if (!map)
> +               return 1;
> +       v = bpf_map_lookup_elem(map, &(int){0});
> +       if (!v)
> +               return 1;
> +       return test_list_in_list(&v->lock, &v->head);
> +}
> +
> +SEC("tc")
> +int global_list_in_list(void *ctx)
> +{
> +       return test_list_in_list(&glock, &ghead);
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/testing/selftests/bpf/progs/linked_list.h
> new file mode 100644
> index 000000000000..8db80ed64db1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/linked_list.h
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef LINKED_LIST_H
> +#define LINKED_LIST_H
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_experimental.h"
> +
> +struct bar {
> +       struct bpf_list_node node;
> +       int data;
> +};
> +
> +struct foo {
> +       struct bpf_list_node node;
> +       struct bpf_list_head head __contains(bar, node);
> +       struct bpf_spin_lock lock;
> +       int data;
> +       struct bpf_list_node node2;
> +};
> +
> +struct map_value {
> +       struct bpf_spin_lock lock;
> +       int data;
> +       struct bpf_list_head head __contains(foo, node);
> +};
> +
> +struct array_map {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __type(key, int);
> +       __type(value, struct map_value);
> +       __uint(max_entries, 1);
> +};
> +
> +struct array_map array_map SEC(".maps");
> +struct array_map inner_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __type(value, int);
> +       __array(values, struct array_map);
> +} map_of_maps SEC(".maps") = {
> +       .values = {
> +               [0] = &inner_map,
> +       },
> +};
> +
> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
> +
> +private(A) struct bpf_spin_lock glock;
> +private(A) struct bpf_list_head ghead __contains(foo, node);
> +private(B) struct bpf_spin_lock glock2;

The latest llvm crashes with a bug here:

fatal error: error in backend: unable to write nop sequence of 4 bytes

Please see BPF CI.

So far I wasn't able to find a manual workaround :(
Please give it a shot too.

Or disable the test for this case for now?
