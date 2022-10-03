Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F45F329D
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJCPgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJCPf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 11:35:58 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D4EE25;
        Mon,  3 Oct 2022 08:35:33 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id j8so7097811qvt.13;
        Mon, 03 Oct 2022 08:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=92a4Cnc5tPeqgqWBbVZIo74Jg64wC+vTNQYZ2FKp4zY=;
        b=fVFswYEIaCB7OUBQs27EHkUPbuabwVRnGMudkohG/lhYHPwQr2qiSu8WFVCyLTGIbd
         uSR597n9nuUT/n/CnxLxXiKCD4p4rZ1MAFMIoHmlTdC1zalww1SbsSoO3lLPB0xLbqVt
         vS5mRzqALEbNXzVI6DqEYCU+ro44DsXs3xe94PkocgUE0uy5PJ0oSOYVdfBNkbVMqv/y
         pBhrFHY+RucjA2tnCT3h4y1uvvS71JBNjCNiEw7s+eGoUuUihGsZgRXCD0B0z9EHRNC0
         U8z63MT9fV5q0E3ngiIJXOl6hecPWf7GKFok5A+nthoGwzfp7b9t2oR41w9b4a5nUll0
         l8eg==
X-Gm-Message-State: ACrzQf0ydZZN2XV0MATQfY4IX9/RJwvvv5/CNDFZc+4e03mz/g3+pliy
        DtRbfy6H/40uxq10KSnYmog=
X-Google-Smtp-Source: AMsMyM4P7urGiTWPVvGZOVqcRESIxjPr8GOEXdC7OPbBsnleFTsFqiics/kEp/hS2nZyGWHvSAYDyQ==
X-Received: by 2002:ad4:574b:0:b0:4b1:7959:d98f with SMTP id q11-20020ad4574b000000b004b17959d98fmr9556610qvx.38.1664811332575;
        Mon, 03 Oct 2022 08:35:32 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::59bd])
        by smtp.gmail.com with ESMTPSA id b1-20020ac87541000000b0035bb6c3811asm9665970qtr.53.2022.10.03.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:35:32 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:35:38 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2 2/2] bpf/selftests: Add selftests for new task kfuncs
Message-ID: <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com>
References: <20221001144716.3403120-1-void@manifault.com>
 <20221001144716.3403120-3-void@manifault.com>
 <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 03, 2022 at 02:32:41AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat, 1 Oct 2022 at 16:47, David Vernet <void@manifault.com> wrote:
> >
> > A previous change added a series of kfuncs for storing struct
> > task_struct objects as referenced kptrs. This patch adds a new
> > task_kfunc test suite for validating their expected behavior.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> >  .../selftests/bpf/prog_tests/task_kfunc.c     | 155 ++++++++++++
> >  .../selftests/bpf/progs/task_kfunc_common.h   |  83 +++++++
> >  .../selftests/bpf/progs/task_kfunc_failure.c  | 225 ++++++++++++++++++
> >  .../selftests/bpf/progs/task_kfunc_success.c  | 113 +++++++++
> >  5 files changed, 577 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
> >  create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> > index 17e074eb42b8..4c34818ec1ee 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > @@ -75,3 +75,4 @@ user_ringbuf                             # failed to find kernel BTF type ID of
> >  lookup_key                               # JIT does not support calling kernel function                                (kfunc)
> >  verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
> >  kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
> > +task_kfunc                               # JIT does not support calling kernel function
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > new file mode 100644
> > index 000000000000..6c577fbca8f7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > @@ -0,0 +1,155 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > +
> > +#define _GNU_SOURCE
> > +#include <sys/wait.h>
> > +#include <test_progs.h>
> > +#include <unistd.h>
> > +
> > +#include "task_kfunc_failure.skel.h"
> > +#include "task_kfunc_success.skel.h"
> > +
> > +static size_t log_buf_sz = 1 << 20; /* 1 MB */
> > +static char obj_log_buf[1048576];
> > +
> > +static struct task_kfunc_success *open_load_task_kfunc_skel(void)
> > +{
> > +       struct task_kfunc_success *skel;
> > +       int err;
> > +
> > +       skel = task_kfunc_success__open();
> > +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +               return NULL;
> > +
> > +       skel->bss->pid = getpid();
> > +
> > +       err = task_kfunc_success__load(skel);
> > +       if (!ASSERT_OK(err, "skel_load"))
> > +               goto cleanup;
> > +
> > +       return skel;
> > +
> > +cleanup:
> > +       task_kfunc_success__destroy(skel);
> > +       return NULL;
> > +}
> > +
> > +static void run_success_test(const char *prog_name)
> > +{
> > +       struct task_kfunc_success *skel;
> > +       int status;
> > +       pid_t child_pid;
> > +       struct bpf_program *prog;
> > +       struct bpf_link *link = NULL;
> > +
> > +       skel = open_load_task_kfunc_skel();
> > +       if (!ASSERT_OK_PTR(skel, "open_load_skel"))
> > +               return;
> > +
> > +       if (!ASSERT_OK(skel->bss->err, "pre_spawn_err"))
> > +               goto cleanup;
> > +
> > +       prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> > +       if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> > +               goto cleanup;
> > +
> > +       link = bpf_program__attach(prog);
> > +       if (!ASSERT_OK_PTR(link, "attached_link"))
> > +               goto cleanup;
> > +
> > +       child_pid = fork();
> > +       if (!ASSERT_GT(child_pid, -1, "child_pid"))
> > +               goto cleanup;
> > +       if (child_pid == 0)
> > +               _exit(0);
> > +       waitpid(child_pid, &status, 0);
> > +
> > +       ASSERT_OK(skel->bss->err, "post_wait_err");
> > +
> > +cleanup:
> > +       bpf_link__destroy(link);
> > +       task_kfunc_success__destroy(skel);
> > +}
> > +
> > +static const char * const success_tests[] = {
> > +       "test_task_acquire_release",
> > +       "test_task_acquire_leave_in_map",
> > +       "test_task_xchg_release",
> > +       "test_task_get_release",
> > +};
> > +
> > +static struct {
> > +       const char *prog_name;
> > +       const char *expected_err_msg;
> > +} failure_tests[] = {
> > +       {"task_kfunc_acquire_untrusted", "arg#0 pointer type STRUCT task_struct must point"},
> > +       {"task_kfunc_acquire_null", "arg#0 pointer type STRUCT task_struct must point"},
> > +       {"task_kfunc_acquire_unreleased", "Unreleased reference"},
> > +       {"task_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
> > +       {"task_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
> > +       {"task_kfunc_get_null", "arg#0 expected pointer to map value"},
> > +       {"task_kfunc_xchg_unreleased", "Unreleased reference"},
> > +       {"task_kfunc_get_unreleased", "Unreleased reference"},
> > +       {"task_kfunc_release_untrusted", "arg#0 pointer type STRUCT task_struct must point"},
> > +       {"task_kfunc_release_null", "arg#0 pointer type STRUCT task_struct must point"},
> > +       {"task_kfunc_release_unacquired", "R1 must be referenced"},
> > +};
> > +
> > +static void verify_fail(const char *prog_name, const char *expected_err_msg)
> > +{
> > +       LIBBPF_OPTS(bpf_object_open_opts, opts);
> > +       struct task_kfunc_failure *skel;
> > +       int err, i;
> > +
> > +       opts.kernel_log_buf = obj_log_buf;
> > +       opts.kernel_log_size = log_buf_sz;
> > +       opts.kernel_log_level = 1;
> > +
> > +       skel = task_kfunc_failure__open_opts(&opts);
> > +       if (!ASSERT_OK_PTR(skel, "task_kfunc_failure__open_opts"))
> > +               goto cleanup;
> > +
> > +       skel->bss->pid = getpid();
> > +
> > +       for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
> > +               struct bpf_program *prog;
> > +               const char *curr_name = failure_tests[i].prog_name;
> > +
> > +               prog = bpf_object__find_program_by_name(skel->obj, curr_name);
> > +               if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> > +                       goto cleanup;
> > +
> > +               bpf_program__set_autoload(prog, !strcmp(curr_name, prog_name));
> > +       }
> > +
> > +       err = task_kfunc_failure__load(skel);
> > +       if (!ASSERT_ERR(err, "unexpected load success"))
> > +               goto cleanup;
> > +
> > +       if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
> > +               fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
> > +               fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> > +       }
> > +
> > +cleanup:
> > +       task_kfunc_failure__destroy(skel);
> > +}
> > +
> > +void test_task_kfunc(void)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(success_tests); i++) {
> > +               if (!test__start_subtest(success_tests[i]))
> > +                       continue;
> > +
> > +               run_success_test(success_tests[i]);
> > +       }
> > +
> > +       for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
> > +               if (!test__start_subtest(failure_tests[i].prog_name))
> > +                       continue;
> > +
> > +               verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_msg);
> > +       }
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
> > new file mode 100644
> > index 000000000000..bbb0a40572fd
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
> > @@ -0,0 +1,83 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > +
> > +#ifndef _TASK_KFUNC_COMMON_H
> > +#define _TASK_KFUNC_COMMON_H
> > +
> > +#include <errno.h>
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +struct __tasks_kfunc_map_value {
> > +       struct task_struct __kptr_ref * task;
> > +};
> > +
> > +struct hash_map {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __type(key, int);
> > +       __type(value, struct __tasks_kfunc_map_value);
> > +       __uint(max_entries, 1);
> > +} __tasks_kfunc_map SEC(".maps");
> > +
> > +struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
> > +struct task_struct *bpf_task_kptr_get(struct task_struct **pp) __ksym;
> > +void bpf_task_release(struct task_struct *p) __ksym;
> > +
> > +#define TEST_NAME_SZ 128
> > +
> > +/* The pid of the test process used to determine if a newly created task is the test task. */
> > +int pid;
> > +
> > +static inline struct __tasks_kfunc_map_value *tasks_kfunc_map_value_lookup(struct task_struct *p)
> > +{
> > +       s32 pid;
> > +       long status;
> > +
> > +       status = bpf_probe_read_kernel(&pid, sizeof(pid), &p->pid);
> > +       if (status)
> > +               return NULL;
> > +
> > +       return bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
> > +}
> > +
> > +static inline int tasks_kfunc_map_insert(struct task_struct *p)
> > +{
> > +       struct __tasks_kfunc_map_value local, *v;
> > +       long status;
> > +       struct task_struct *acquired, *old;
> > +       s32 pid;
> > +
> > +       status = bpf_probe_read_kernel(&pid, sizeof(pid), &p->pid);
> > +       if (status)
> > +               return status;
> > +
> > +       local.task = NULL;
> > +       status = bpf_map_update_elem(&__tasks_kfunc_map, &pid, &local, BPF_NOEXIST);
> > +       if (status)
> > +               return status;
> > +
> > +       v = bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
> > +       if (!v) {
> > +               bpf_map_delete_elem(&__tasks_kfunc_map, &pid);
> > +               return status;
> > +       }
> > +
> > +       acquired = bpf_task_acquire(p);
> > +       old = bpf_kptr_xchg(&v->task, acquired);
> > +       if (old) {
> > +               bpf_task_release(old);
> > +               return -EEXIST;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static inline bool is_test_kfunc_task(struct task_struct *task)
> > +{
> > +       int cur_pid = bpf_get_current_pid_tgid() >> 32;
> > +
> > +       return pid == cur_pid;
> > +}
> > +
> > +#endif /* _TASK_KFUNC_COMMON_H */
> > diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> > new file mode 100644
> > index 000000000000..4cf01bbc8a16
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> > @@ -0,0 +1,225 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +#include "task_kfunc_common.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +/* Prototype for all of the program trace events below:
> > + *
> > + * TRACE_EVENT(task_newtask,
> > + *         TP_PROTO(struct task_struct *p, u64 clone_flags)
> > + */
> > +
> > +SEC("tp_btf/task_newtask")
> > +int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_flags)
> > +{
> > +       struct task_struct *acquired, *stack_ptr;
> > +
> > +       if (!is_test_kfunc_task(task))
> > +               return 0;
> > +
> > +       /* Can't invoke bpf_task_acquire() on an untrusted, random pointer. */
> > +       stack_ptr = (struct task_struct *)0xcafef00d;
> 
> This seems like a misleading comment. 'stack_ptr' would just be a
> scalar, not a pointer. Maybe you should be testing this for an actual
> PTR_UNTRUSTED pointer instead. Load of a __kptr tagged pointer would
> be a good way.
> 
> Very soon a lot of other pointers obtained from pointer walking are
> going to be marked PTR_UNTRUSTED, so then we would cover those as well
> similar to this test.

Good point and good suggestion, let me update the test to do this.

> Also, could you include a test to make sure sleepable programs cannot
> call bpf_task_acquire? It seems to assume RCU read lock is held while
> that may not be true. If already not possible, maybe a WARN_ON_ONCE
> inside the helper to ensure future cases don't creep in.

I don't _think_ it's unsafe for a sleepable program to call
bpf_task_acquire(). My understanding is that the struct task_struct *
parameter to bpf_task_acquire() is not PTR_UNTRUSTED, so it's safe to
dereference directly in the kfunc. The implicit assumption here is that
the task was either passed to the BPF program (which is calling
bpf_task_acquire()) from the main kernel in something like a trace or
struct_ops callback, or it was a referenced kptr that was removed from a
map with bpf_kptr_xchg(), and is now owned by the BPF program. Given
that the ptr type is not PTR_UNTRUSTED, it seemed correct to assume that
the task was valid in bpf_task_acquire() regardless of whether we were
in an RCU read region or not, but please let me know if I'm wrong about
that.  Other kfuncs I saw such as bpf_xdp_ct_lookup() assumed that the
parameter passed by the BPF program (which itself was passing on a
pointer given to it by the main kernel) is valid as well.

Note that the difference between bpf_task_acquire() and
bpf_task_kptr_get() is that for bpf_task_kptr_get(), we're passing a
pointer to a kptr which could be swapped out and invalidated at any
moment by a bpf_kptr_xchg() elsewhere in the program.  That's why it's
necessary to enter an RCU read region before calling READ_ONCE(), and
why we have to do a refcount_inc_not_zero() rather than just a
refcount_inc() as we do in bpf_task_acquire().

Thanks,
David
