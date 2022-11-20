Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34063631283
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 06:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiKTFKF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 00:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTFKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 00:10:04 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9561501;
        Sat, 19 Nov 2022 21:10:03 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id k2so6142296qkk.7;
        Sat, 19 Nov 2022 21:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kX4C5mresU6DVkVZ7iKD8cw9DYKMN5cRJv7I6lGAyDo=;
        b=1hFMnC4l+rDMED6tsuivWtdp0hyxZNKGXvH/cVWI+WB4j4T1BLYGhc/4UoLYA/fyxS
         Mz0GwJzR1K9wA4oLK4PN5GwVeZ7vD82OaNSv6Y9iWWwd4ZuKZf3rVWfi6CTWYrUpr/qs
         nyA892PpRGo2ilNb9F54McK6UDkWieUS/DdBROD/kWcIIRBiLHcpq2v000ns7QXmTW9i
         2KjCqtlqo4w5AcnW8WJSolWusrU04xlhUip6hhbIGUKjpz0zcmidajlnIR5m/ktS7ZAZ
         yys2wbFzUmsOqxvsIjhCjUrlpFn7I7KyMx/p/EbyOzJCx6xrAILmR68FZhJSnz/woiAY
         JdUw==
X-Gm-Message-State: ANoB5plw7970u6ZxgXTpojH2pj+PTFVfE6TsjuWUaW+I723+uVBphP0f
        PFx0n/R0cVNK6H8b0KmlzW0=
X-Google-Smtp-Source: AA0mqf7svXhD9T/4VldjXBp/ct8AZQN/yb3+z06H7cO5ZuigSYQ0pUuljFW7OtQCs11xyX/h8CRibA==
X-Received: by 2002:a37:9a01:0:b0:6fa:2d2b:b80d with SMTP id c1-20020a379a01000000b006fa2d2bb80dmr11792540qke.742.1668921001897;
        Sat, 19 Nov 2022 21:10:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6319])
        by smtp.gmail.com with ESMTPSA id k21-20020ac86055000000b003a50c9993e1sm4700755qtm.16.2022.11.19.21.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 21:10:01 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next v9 0/4] Support storing struct task_struct objects as kptrs
Date:   Sat, 19 Nov 2022 23:10:00 -0600
Message-Id: <20221120051004.3605026-1-void@manifault.com>
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
v8 -> v9:
- Moved check for release register back to where we check for
  !PTR_TO_BTF_ID || socket. Change the verifier log message to
  reflect really what's being tested (the presence of unsafe
  modifiers) (Alexei)
- Fix verifier_test error tests to reflect above changes
- Remove unneeded parens around bitwise operator checks (Alexei)
- Move updates to reg_type_str() which allow multiple type modifiers
  to be present in the prefix string, to a separate patch (Alexei)
- Increase TYPE_STR_BUF_LEN size to 128 to reflect larger prefix size
  in reg_type_str().

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

David Vernet (4):
  bpf: Allow multiple modifiers in reg_type_str() prefix
  bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
  bpf: Add kfuncs for storing struct task_struct * as a kptr
  bpf/selftests: Add selftests for new task kfuncs

 Documentation/bpf/kfuncs.rst                  |  30 +-
 include/linux/bpf.h                           |  30 ++
 include/linux/bpf_verifier.h                  |   9 +-
 include/linux/btf.h                           |  65 +++--
 kernel/bpf/btf.c                              |   8 +
 kernel/bpf/helpers.c                          |  78 +++++-
 kernel/bpf/verifier.c                         |  84 ++++--
 kernel/trace/bpf_trace.c                      |   2 +-
 net/ipv4/bpf_tcp_ca.c                         |   4 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     | 159 +++++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  71 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 260 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 149 ++++++++++
 tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
 .../selftests/bpf/verifier/ref_tracking.c     |   4 +-
 16 files changed, 886 insertions(+), 70 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

-- 
2.38.1

