Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39E9606B39
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 00:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJTWYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJTWYb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 18:24:31 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2860E1;
        Thu, 20 Oct 2022 15:24:28 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id g11so591236qts.1;
        Thu, 20 Oct 2022 15:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXl6NMHcb+y+51/1Cf2ZJ8INvRZOWm3tGnvyAd9NO5M=;
        b=g1nkXKODyhUa4YRbi54gUGOPBVpb0kgxcT3nAo7HkIvd4eXIeMcq/8f9XGweY/MX5i
         WGe8P9QHKwaqMZEWg6d8XEu5K38fo96zF+jnxZEdN3nbdFRX7Nclx4PLui6i3zuBnimc
         6GK+jYD2c6e9w/Ndt/gKpLChRtQq8Bls8bjKbNyPei14YclTCblTCx1PBwLYyxOy/RkI
         xDe1Bjj7KpwUAsDmqX9VO53mwPSYgwl35ku8eRWNXacKqI9QcrkHOMMlE3qNGCS/+y34
         UNsVVBogd6ej+I7q6egjBOc0kn5iV//TDSFR6mNhnRcLpk6SrOmadxTbdgmbnZzhAJJk
         hTzQ==
X-Gm-Message-State: ACrzQf3eiX30RZBRS5ewVDreDl+BehIXDK0XVCJmJIueSEwCiS2hk4iZ
        onE1JNRnBVyFdM2N8wtaERI6sDdSR7w7mQ==
X-Google-Smtp-Source: AMsMyM7cbmnmPcUL6eDoPHikS8f54NYtvXAbh82OZUeEebkHKX+JLNXM8oCiaI+0FjydxlUAMRAxmQ==
X-Received: by 2002:ac8:5955:0:b0:39c:c040:a866 with SMTP id 21-20020ac85955000000b0039cc040a866mr13187960qtz.25.1666304667508;
        Thu, 20 Oct 2022 15:24:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::80b7])
        by smtp.gmail.com with ESMTPSA id d12-20020a05622a15cc00b003995f6513b9sm7023930qty.95.2022.10.20.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:24:26 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v6 0/3] Support storing struct task_struct objects as kptrs
Date:   Thu, 20 Oct 2022 17:24:13 -0500
Message-Id: <20221020222416.3415511-1-void@manifault.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=no autolearn_force=no
        version=3.4.6
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
means in terms of the implementation is that btf_check_func_arg_match()
would have to add another condition to its logic for checking if
a ptr needs a refcount to also require that the pointer has at least one
type modifier, such as a new modifier we're adding called PTR_WALKED
(described below). Note that PTR_UNTRUSTED is insufficient for this
purpose, as it does not cover all of the possible pointers we need to
watch out for, though. For example, a pointer obtained from walking a
struct is considered "trusted" (or at least, not PTR_UNTRUSTED). To
account for this and enable us to expand KF_TRUSTED_ARGS, this patch set
also introduces a new PTR_WALKED type flag modifier which records if a
pointer was obtained from walking a struct.

Additionally, while loosening the restrictions of KF_TRUSTED_ARGS does
expand the availability of the flag to more possible kfunc variants, it
also removes some restrictions that are required by some existing
kfuncs. For example, kfuncs like bpf_ct_{g,s}et_status() expect a struct
nf_conn___init * argument that was allocated on behalf of the program by
bpf_skb_ct_alloc(), rather than which was allocated and passed by the
kernel in a tracepoint handler. We do not want to allow other struct
nf_conn___init pointers that are not "owned" by the BPF program to be
passed to these kfuncs.  To address this, we also add a KF_OWNED_ARGS
kfunc flag which is identical to KF_TRUSTED_ARGS, but is more
restrictive in that it also requires the BPF program to own a reference
to an object.

Authors please note, in my opinion it's not 100% clear whether
KF_OWNED_ARGS is really the right abstraction. Consider, for example, if
two KF_ACQUIRE kfuncs are exposed which return a reference to the same
type of object, with one of them actually allocating the object, and the
other just taking a reference on an object that was acquired by the main
kernel. This flag would not sufficiently express that only the object
that was returned by the kfunc that _allocated_ the object should be
allowed to be passed to KF_OWNED_ARGS. On the other hand, it seems like
a reasonable flag for providing the equvialent semantics to the existing
version of KF_TRUSTED_ARGS. Much of how all this works will likely
change over time as well. For example, eventually it would be nice if we
could specify constraints per-arg, rather than on the whole kfunc, using
something like type tagging (not yet available in gcc).

In closing, this patch set:

1. Adds the new PTR_WALKED register type modifier flag, and updates the
   verifier and existing selftests accordingly.
2. Expands KF_TRUSTED_ARGS to also include trusted pointers that were
   not obtained from walking structs. 
3. Adds the new KF_OWNED_ARGS kfunc flag to specify kfuncs that can only
   accept trusted, refcounted objects. Updates the existing kfuncs that
   require these semantics to use this new kfunc flag.
4. Adds a new set of kfuncs that allows struct task_struct* objects to be
   used as kptrs.
5. Adds a new selftest suite to validate these new task kfuncs.

--
Changelog:

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

 Documentation/bpf/kfuncs.rst                  |  49 ++-
 include/linux/bpf.h                           |   6 +
 include/linux/btf.h                           |  60 +++-
 kernel/bpf/btf.c                              |  18 +-
 kernel/bpf/helpers.c                          |  86 ++++-
 kernel/bpf/verifier.c                         |  66 +++-
 net/bpf/test_run.c                            |   2 +-
 net/netfilter/nf_conntrack_bpf.c              |   8 +-
 net/netfilter/nf_nat_bpf.c                    |   2 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/map_kptr.c       |   2 +-
 .../selftests/bpf/prog_tests/task_kfunc.c     | 160 +++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  83 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 315 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 132 ++++++++
 tools/testing/selftests/bpf/verifier/calls.c  |   4 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   2 +-
 17 files changed, 943 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

-- 
2.38.0

