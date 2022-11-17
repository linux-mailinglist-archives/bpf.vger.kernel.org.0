Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5041162E641
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 22:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbiKQVDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 16:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiKQVDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 16:03:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAEA24080;
        Thu, 17 Nov 2022 13:03:47 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2971425pjt.0;
        Thu, 17 Nov 2022 13:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8RvZ4CHDBSCsDMjoArI7xcTtTta9Gi4ASsSoLYztRo=;
        b=hJVy2w8b0w92SpJuaIxjWE4iHbkjdkqsfh5p9uQxtl0OrxpEJg39TO8Nul62z2cMXV
         VK12gyrLjbFZpJAP2bITAuHGi0sBHZlsBmHRd3WgNmMs/T6AdefnICwIrwuWCk5Yvp6B
         U7gdIBa+vm8JDPTVbqKBdFOGZ2bb1IoXC1dXE+9Ss3tkj57GepBQK4+KaoAqwFxQ3kWx
         35ix6OxskZAJ15qzI00MBJjUuo60mVD4BRUEQUnDyUo/pIVuwYVfrUPNNhdCy4YRzJI6
         jP8JLpKBn9vzhGrJYBhByf76nPomXOc5nGJxPqjceGje94y4aT19zdyDjmjVAdKtLRWq
         vVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G8RvZ4CHDBSCsDMjoArI7xcTtTta9Gi4ASsSoLYztRo=;
        b=8OXpr7Dc1i5W36tlX/ul7vvI/WbPd4goityR+UlSUIkzf185F78ie1jDhmBmF13F+E
         5K/5yclfQqdaK4AtgYr+IhMxzzICPWtL5XNyZBldBPFLvM/8ZbL2Nd6Pc55xNl9+wZk2
         93s2LZ9VAuTORB6jbwNGlZXGnxzU8BSe0RXL0GYkm4yRm0PkJOTuqmQbX170BaVGwDEV
         Imh1KFX/zhA7yBQlLPcpnw5Vj9JJE5doEd0ZAOLkIBGX8MvOXgHJpH5JHsC5j43OnY0v
         fJU8JMe+YB4XeRFkR9l8iq3d11nbGPFEXHe99oiUoxXzFGZFWWy/qNS2eAdkiIPm73aM
         iVLg==
X-Gm-Message-State: ANoB5pn0s9mJRHkQv15STH4GthwWpG76IvkEc4ICynysoVoSPdgqZqAo
        TVKV7HsWavGnj++Uqrif0C8=
X-Google-Smtp-Source: AA0mqf6052HzKW+bZnlUjRHjO3aRvcye5ABEJYX4Fnumb+KiRIgYet0TkCAVjgAAv7toIv5auduhYg==
X-Received: by 2002:a17:90b:810:b0:200:6637:a9e3 with SMTP id bk16-20020a17090b081000b002006637a9e3mr4405467pjb.176.1668719027089;
        Thu, 17 Nov 2022 13:03:47 -0800 (PST)
Received: from localhost ([2605:59c8:47b:5f10:de79:4af7:b6d9:b113])
        by smtp.gmail.com with ESMTPSA id k23-20020a6568d7000000b004770122d235sm1447089pgt.77.2022.11.17.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:03:46 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:03:45 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, memxor@gmail.com, yhs@fb.com,
        song@kernel.org, sdf@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, haoluo@google.com,
        tj@kernel.org, kernel-team@fb.com, linux-kernel@vger.kernel.org
Message-ID: <6376a1b12bb4d_4101208d@john.notmuch>
In-Reply-To: <20221117032402.2356776-1-void@manifault.com>
References: <20221117032402.2356776-1-void@manifault.com>
Subject: RE: [PATCH bpf-next v7 0/3] Support storing struct task_struct
 objects as kptrs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet wrote:
> Now that BPF supports adding new kernel functions with kfuncs, and
> storing kernel objects in maps with kptrs, we can add a set of kfuncs
> which allow struct task_struct objects to be stored in maps as
> referenced kptrs.
> 
> The possible use cases for doing this are plentiful.  During tracing,
> for example, it would be useful to be able to collect some tasks that
> performed a certain operation, and then periodically summarize who they
> are, which cgroup they're in, how much CPU time they've utilized, etc.
> Doing this now would require storing the tasks' pids along with some
> relevant data to be exported to user space, and later associating the
> pids to tasks in other event handlers where the data is recorded.
> Another useful by-product of this is that it allows a program to pin a
> task in a BPF program, and by proxy therefore also e.g. pin its task
> local storage.

Sorry wasn't obvious to me (late to the party so if it was in some
other v* described apologies). Can we say something about the life
cycle of this acquired task_structs because they are incrementing
the ref cnt on the task struct they have potential to impact system.
I know at least we've had a few bugs in our task struct tracking
that has led to various bugs where we leak references. In our case
we didn't pin the kernel object so the leak is just BPF memory and
user space memory, still sort of bad because we would hit memory
limits and get OOM'd. Leaking kernel task structs is worse though.

quick question. If you put acquired task struct in a map what
happens if user side deletes the entry? Presumably this causes the
release to happen and the task_struct is good to go. Did I miss
the logic? I was thinking you would have something in bpf_map_free_kptrs
and a type callback to release() the refcnt?

> 
> In order to support this, we'll need to expand KF_TRUSTED_ARGS to
> support receiving trusted, non-refcounted pointers. It currently only
> supports either PTR_TO_CTX pointers, or refcounted pointers. What this
> means in terms of the implementation is that btf_check_func_arg_match()
> would have to add another condition to its logic for checking if
> a ptr needs a refcount to also require that the pointer has at least one
> type modifier, such as a new modifier we're adding called PTR_TRUSTED
> (described below). Note that PTR_UNTRUSTED is insufficient for this
> purpose, as it does not cover all of the possible pointers we need to
> watch out for, though. For example, a pointer obtained from walking a
> struct is considered "trusted" (or at least, not PTR_UNTRUSTED). To
> account for this and enable us to expand KF_TRUSTED_ARGS to include
> allow-listed arguments such as those passed by the kernel to tracepoints
> and struct_ops callbacks, this patch set also introduces a new
> PTR_TRUSTED type flag modifier which records if a pointer was obtained
> passed from the kernel in a trusted context.
> 
> In closing, this patch set:
> 
> 1. Adds the new PTR_TRUSTED register type modifier flag, and updates the
>    verifier and existing selftests accordingly.
> 2. Expands KF_TRUSTED_ARGS to also include trusted pointers that were
>    not obtained from walking structs. 
> 3. Adds a new set of kfuncs that allows struct task_struct* objects to be
>    used as kptrs.
> 4. Adds a new selftest suite to validate these new task kfuncs.
> 
> --
> Changelog:
> v6 -> v7:
> - Removed the PTR_WALKED type modifier, and instead define a new
>   PTR_TRUSTED type modifier which is set on registers containing
>   pointers passed from trusted contexts (i.e. as tracepoint or
>   struct_ops callback args) (Alexei)
> - Remove the new KF_OWNED_ARGS kfunc flag. This can be accomplished
>   by defining a new type that wraps an existing type, such as with
>   struct nf_conn___init (Alexei)
> - Add a test_task_current_acquire_release testcase which verifies we can
>   acquire a task struct returned from bpf_get_current_task_btf().
> - Make bpf_task_acquire() no longer return NULL, as it can no longer be
>   called with a NULL task.
> - Removed unnecessary is_test_kfunc_task() checks from failure
>   testcases.
> 
> v5 -> v6:
> - Add a new KF_OWNED_ARGS kfunc flag which may be used by kfuncs to
>   express that they require trusted, refcounted args (Kumar)
> - Rename PTR_NESTED -> PTR_WALKED in the verifier (Kumar)
> - Convert reg_type_str() prefixes to use snprintf() instead of strncpy()
>   (Kumar)
> - Add PTR_TO_BTF_ID | PTR_WALKED to missing struct btf_reg_type
>   instances -- specifically btf_id_sock_common_types, and
>   percpu_btf_ptr_types.
> - Add a missing PTR_TO_BTF_ID | PTR_WALKED switch case entry in
>   check_func_arg_reg_off(), which is required when validating helper
>   calls (Kumar)
> - Update reg_type_mismatch_ok() to check base types for the registers
>   (i.e. to accommodate type modifiers). Additionally, add a lengthy
>   comment that explains why this is being done (Kumar)
> - Update convert_ctx_accesses() to also issue probe reads for
>   PTR_TO_BTF_ID | PTR_WALKED (Kumar)
> - Update selftests to expect new prefix reg type strings.
> - Rename task_kfunc_acquire_trusted_nested testcase to
>   task_kfunc_acquire_trusted_walked, and fix a comment (Kumar)
> - Remove KF_TRUSTED_ARGS from bpf_task_release(), which already includes
>   KF_RELEASE (Kumar)
> - Add bpf-next in patch subject lines (Kumar)
> 
> v4 -> v5:
> - Fix an improperly formatted patch title.
> 
> v3 -> v4:
> - Remove an unnecessary check from my repository that I forgot to remove
>   after debugging something.
> 
> v2 -> v3:
> - Make bpf_task_acquire() check for NULL, and include KF_RET_NULL
>   (Martin)
> - Include new PTR_NESTED register modifier type flag which specifies
>   whether a pointer was obtained from walking a struct. Use this to
>   expand the meaning of KF_TRUSTED_ARGS to include trusted pointers that
>   were passed from the kernel (Kumar)
> - Add more selftests to the task_kfunc selftest suite which verify that
>   you cannot pass a walked pointer to bpf_task_acquire().
> - Update bpf_task_acquire() to also specify KF_TRUSTED_ARGS.
> 
> v1 -> v2:
> - Rename tracing_btf_ids to generic_kfunc_btf_ids, and add the new
>   kfuncs to that list instead of making a separate btf id list (Alexei).
> - Don't run the new selftest suite on s390x, which doesn't appear to
>   support invoking kfuncs.
> - Add a missing __diag_ignore block for -Wmissing-prototypes
>   (lkp@intel.com).
> - Fix formatting on some of the SPDX-License-Identifier tags.
> - Clarified the function header comment a bit on bpf_task_kptr_get().
> 
> David Vernet (3):
>   bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
>   bpf: Add kfuncs for storing struct task_struct * as a kptr
>   bpf/selftests: Add selftests for new task kfuncs
> 
>  Documentation/bpf/kfuncs.rst                  |  28 +-
>  include/linux/bpf.h                           |  25 ++
>  include/linux/btf.h                           |  66 ++--
>  kernel/bpf/btf.c                              |  44 ++-
>  kernel/bpf/helpers.c                          |  83 ++++-
>  kernel/bpf/verifier.c                         |  45 ++-
>  kernel/trace/bpf_trace.c                      |   2 +-
>  net/ipv4/bpf_tcp_ca.c                         |   4 +-
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../selftests/bpf/prog_tests/task_kfunc.c     | 160 +++++++++
>  .../selftests/bpf/progs/task_kfunc_common.h   |  81 +++++
>  .../selftests/bpf/progs/task_kfunc_failure.c  | 304 ++++++++++++++++++
>  .../selftests/bpf/progs/task_kfunc_success.c  | 127 ++++++++
>  tools/testing/selftests/bpf/verifier/calls.c  |   4 +-
>  .../selftests/bpf/verifier/ref_tracking.c     |   4 +-
>  15 files changed, 906 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
>  create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c
> 
> -- 
> 2.38.1


