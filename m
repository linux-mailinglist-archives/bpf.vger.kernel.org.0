Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C58631106
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 22:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiKSVHw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 16:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKSVHv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 16:07:51 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446DE165A2;
        Sat, 19 Nov 2022 13:07:50 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id s4so5262147qtx.6;
        Sat, 19 Nov 2022 13:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ajk56ksnuDEREB9BIEHMkNkC+0nnDWdR8c4K6few/dI=;
        b=Tgn3FR2IJYzeT6kviddkudwRIW7/3IWHrxksRt9yCMoej0h8R+RP3t79u72FoR7CTY
         mYTBT+Vc82lw+7QZYL51X88koyPSc00WVc/Sa+6lB1NqS1mKr55AcHi/AaNIMYXbLtKC
         V6DluKOB8GAVQgwek2gLB/XQkQ4/GsNKVzqectDRT0e8QRPcxd+f+Zgx5RycDRIQRvDd
         dR5yNsOKFXXHnwoCo47KG2LiDd68EIKs3M8Wh9EYJRRcuUdIzmloZpAvZA5boInCcQ/i
         DtHK83bJfM3/SlL8vMPTMc3XuCs0kVgE/F0AVjgvRcjmaCeJiNRw9T0Lk9P22TeEfsQc
         eehg==
X-Gm-Message-State: ANoB5pko78AOlNiTcaKTuvoFc2oPaDgcgPsz/8Xlgqei56t3A4rD8fgN
        /+B0oglqqCO0HeX/QVbmgopcuVMg3lS7rH9r
X-Google-Smtp-Source: AA0mqf5sxbDXQ1a81RlXt3D80AbfX2Nj2Y5gGxzTc/VuB+5MmfQzX/ePr341EoCieuLgJnrblMdBjQ==
X-Received: by 2002:ac8:488a:0:b0:3a5:8508:16d8 with SMTP id i10-20020ac8488a000000b003a5850816d8mr12029968qtq.415.1668892069154;
        Sat, 19 Nov 2022 13:07:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6319])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006bbf85cad0fsm5462883qkp.20.2022.11.19.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 13:07:48 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next v8 0/3] Support storing struct task_struct objects as kptrs
Date:   Sat, 19 Nov 2022 15:07:45 -0600
Message-Id: <20221119210748.3325667-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TVD_PH_BODY_ACCOUNTS_PRE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that BPF supports adding new kernel functions with kfuncs, and
storing kernel objects in maps with kptrs, we can add a set of kfuncs
which allow struct task_struct objects to be stored in maps as
referenced kptrs.

The possible use cases for doing this are plentiful.  During tracing,
for example, it would be useful to be able to collect some tasks that
performed a certain operation, and then periodically summarize who they
are, which cgroup they're in, how much CPU time they've utilized, etc.
Doing this now would require storing the tasks' pids along with some
relevant data to be exported to user space, and later associating the
pids to tasks in other event handlers where the data is recorded.
Another useful by-product of this is that it allows a program to pin a
task in a BPF program, and by proxy therefore also e.g. pin its task
local storage.

In order to support this, we'll need to expand KF_TRUSTED_ARGS to
support receiving trusted, non-refcounted pointers. It currently only
supports either PTR_TO_CTX pointers, or refcounted pointers. What this
means in terms of the implementation is that check_kfunc_args() would
have to also check for the PTR_TRUSTED or MEM_ALLOC type modifiers when
determining if a trusted KF_ARG_PTR_TO_ALLOC_BTF_ID or
KF_ARG_PTR_TO_BTF_ID pointer requires a refcount.

Note that PTR_UNTRUSTED is insufficient for this purpose, as it does not
cover all of the possible types of potentially unsafe pointers. For
example, a pointer obtained from walking a struct is not PTR_UNTRUSTED.
To account for this and enable us to expand KF_TRUSTED_ARGS to include
allow-listed arguments such as those passed by the kernel to tracepoints
and struct_ops callbacks, this patch set also introduces a new
PTR_TRUSTED type flag modifier which records if a pointer was obtained
passed from the kernel in a trusted context.

Currently, both PTR_TRUSTED and MEM_ALLOC are used to imply that a
pointer is trusted. Longer term, PTR_TRUSTED should be the sole source
of truth for whether a pointer is trusted. This requires us to set
PTR_TRUSTED when appropriate (e.g. when setting MEM_ALLOC), and unset it
when appropriate (e.g. when setting PTR_UNTRUSTED). We don't do that in
this patch, as we need to do more clean up before this can be done in a
clear and well-defined manner.

In closing, this patch set:

1. Adds the new PTR_TRUSTED register type modifier flag, and updates the
   verifier and existing selftests accordingly. Also expands
   KF_TRUSTED_ARGS to also include trusted pointers that were not obtained
   from walking structs. 
2. Adds a new set of kfuncs that allows struct task_struct* objects to be
   used as kptrs.
3. Adds a new selftest suite to validate these new task kfuncs.

--
Changelog:
v7 -> v8:
- Rebased onto Kumar's latest patch set which, adds a new MEM_ALLOC reg
  type modifier for bpf_obj_new() calls.
- Added comments to bpf_task_kptr_get() describing some of the subtle
  races we're protecting against (Alexei and John)
- Slightly rework process_kf_arg_ptr_to_btf_id(), and add a new
  reg_has_unsafe_modifiers() function which validates that a register
  containing a kfunc release arg doesn't have unsafe modifiers. Note
  that this is slightly different than the check for KF_TRUSTED_ARGS.
  An alternative here would be to treat KF_RELEASE as implicitly
  requiring KF_TRUSTED_ARGS.
- Export inline bpf_type_has_unsafe_modifiers() function from
  bpf_verifier.h so that it can be used from bpf_tcp_ca.c. Eventually this
  function should likely be changed to bpf_type_is_trusted(), once
  PTR_TRUSTED is the real source of truth.

v6 -> v7:
- Removed the PTR_WALKED type modifier, and instead define a new
  PTR_TRUSTED type modifier which is set on registers containing
  pointers passed from trusted contexts (i.e. as tracepoint or
  struct_ops callback args) (Alexei)
- Remove the new KF_OWNED_ARGS kfunc flag. This can be accomplished
  by defining a new type that wraps an existing type, such as with
  struct nf_conn___init (Alexei)
- Add a test_task_current_acquire_release testcase which verifies we can
  acquire a task struct returned from bpf_get_current_task_btf().
- Make bpf_task_acquire() no longer return NULL, as it can no longer be
  called with a NULL task.
- Removed unnecessary is_test_kfunc_task() checks from failure
  testcases.

v5 -> v6:
- Add a new KF_OWNED_ARGS kfunc flag which may be used by kfuncs to
  express that they require trusted, refcounted args (Kumar)
- Rename PTR_NESTED -> PTR_WALKED in the verifier (Kumar)
- Convert reg_type_str() prefixes to use snprintf() instead of strncpy()
  (Kumar)
- Add PTR_TO_BTF_ID | PTR_WALKED to missing struct btf_reg_type
  instances -- specifically btf_id_sock_common_types, and
  percpu_btf_ptr_types.
- Add a missing PTR_TO_BTF_ID | PTR_WALKED switch case entry in
  check_func_arg_reg_off(), which is required when validating helper
  calls (Kumar)
- Update reg_type_mismatch_ok() to check base types for the registers
  (i.e. to accommodate type modifiers). Additionally, add a lengthy
  comment that explains why this is being done (Kumar)
- Update convert_ctx_accesses() to also issue probe reads for
  PTR_TO_BTF_ID | PTR_WALKED (Kumar)
- Update selftests to expect new prefix reg type strings.
- Rename task_kfunc_acquire_trusted_nested testcase to
  task_kfunc_acquire_trusted_walked, and fix a comment (Kumar)
- Remove KF_TRUSTED_ARGS from bpf_task_release(), which already includes
  KF_RELEASE (Kumar)
- Add bpf-next in patch subject lines (Kumar)

v4 -> v5:
- Fix an improperly formatted patch title.

v3 -> v4:
- Remove an unnecessary check from my repository that I forgot to remove
  after debugging something.

v2 -> v3:
- Make bpf_task_acquire() check for NULL, and include KF_RET_NULL
  (Martin)
- Include new PTR_NESTED register modifier type flag which specifies
  whether a pointer was obtained from walking a struct. Use this to
  expand the meaning of KF_TRUSTED_ARGS to include trusted pointers that
  were passed from the kernel (Kumar)
- Add more selftests to the task_kfunc selftest suite which verify that
  you cannot pass a walked pointer to bpf_task_acquire().
- Update bpf_task_acquire() to also specify KF_TRUSTED_ARGS.

v1 -> v2:
- Rename tracing_btf_ids to generic_kfunc_btf_ids, and add the new
  kfuncs to that list instead of making a separate btf id list (Alexei).
- Don't run the new selftest suite on s390x, which doesn't appear to
  support invoking kfuncs.
- Add a missing __diag_ignore block for -Wmissing-prototypes
  (lkp@intel.com).
- Fix formatting on some of the SPDX-License-Identifier tags.
- Clarified the function header comment a bit on bpf_task_kptr_get().

David Vernet (3):
  bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
  bpf: Add kfuncs for storing struct task_struct * as a kptr
  bpf/selftests: Add selftests for new task kfuncs

 Documentation/bpf/kfuncs.rst                  |  30 +-
 include/linux/bpf.h                           |  30 ++
 include/linux/btf.h                           |  65 +++--
 kernel/bpf/btf.c                              |   9 +
 kernel/bpf/helpers.c                          |  78 +++++-
 kernel/bpf/verifier.c                         |  92 +++++--
 kernel/trace/bpf_trace.c                      |   2 +-
 net/ipv4/bpf_tcp_ca.c                         |   4 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     | 159 +++++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  71 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 260 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 149 ++++++++++
 tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
 .../selftests/bpf/verifier/ref_tracking.c     |   4 +-
 15 files changed, 888 insertions(+), 68 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

-- 
2.38.1

