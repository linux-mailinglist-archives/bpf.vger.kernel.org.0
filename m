Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5A46AE56
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbhLFX0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbhLFX0A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:00 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B2C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:31 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id x23-20020a634a17000000b003252e908ce3so7638484pga.1
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Fd6ObZ84PiwyU6QeMGO4sLjfGJds5C9mjK8ZBFR4FOc=;
        b=PiRqFqPe2HVTfFMqVS+bEztF+SqAT8rtvdNal52AGGhTg6FpCgEEkazJV2AJzupWRs
         dZJh0BxpVQvAjHE2jKNv1sWSZ0KitfcvBEoDt9mSSgtKEtOHiPxiYd9/uujq0Pc7ebpL
         eureaFRp7t9cRX9L4o96xiLkgL0UVqbpE0sGVR6l57HNGEI/2pdeqANJCnXF6VKTCh3k
         /z+4nfj+TbXrOQLq2wajMrxuIjBDmGHgppEgAvtwrT8ipKWVyOmSS+Cv2+tkfPzb4Ze+
         Sf8eKchshzlMZ06IskzhyILRTqlctFWUF2pUd9gCvOYSjWI0o+Td5sLiJ2tV3HMiBcej
         Ekcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Fd6ObZ84PiwyU6QeMGO4sLjfGJds5C9mjK8ZBFR4FOc=;
        b=UiprCWPqD4iKLugAtRdxySGMwe2c8o9jsxObZaLRDEqELUWsKFsN+wJrG1ZJI3j7qT
         ciQkYu8dfAH/cL5mseob/s/cJyKzzwLVUlAsR4cr4UH09bniuNfx4jMTIehiSWUZhK3v
         okDvX8W0AdoizYM2DrGaj6KyKJI29UZwGPYUOjhEaujtHTm6jBUV9wbiwEQcjydZlFWU
         l+bQifbU/p3n7KoOMn0m3Gl+d7WyvCdfKWMzMzhSTQ8p3b7VEx1/D6R5f9plHLIkukgX
         LGbGgpWtnW8Kcr1DZyPG7D9HpALy7JbIQuKO/CCwJP4g7mHFKx6L9HJg+Hn99KmZ4EeZ
         AwnQ==
X-Gm-Message-State: AOAM53067CookqKTrgcSy24epW8TLwhJc6DUTi+Nsn/bikF9f11uDzQ4
        rt35B8Y6TO5+YGGX6dF8JIa6auqnp/c=
X-Google-Smtp-Source: ABdhPJzuEWzU1vttaNO9YnnbTs/WJIAQlOn1ubKpNLxPt3xf2sokiHHj3H3/VJnnEWPuy/aKzCMaqltIv3M=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a63:5f11:: with SMTP id t17mr5532119pgb.388.1638832950736;
 Mon, 06 Dec 2021 15:22:30 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:18 -0800
Message-Id: <20211206232227.3286237-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 0/9] Introduce composable bpf types
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set consists of two changes:

 - a cleanup of arg_type, ret_type and reg_type which try to make those
   types composable. (patch 1/9 - patch 6/9)
 - a bug fix that prevents bpf programs from writing kernel memory.
   (patch 7/9 - patch 9/9)

The purpose of the cleanup is to find a scalable way to express type
nullness and read-onliness. This patchset introduces two flags that
can be applied on all three types: PTR_MAYBE_NULL and MEM_RDONLY.
Previous types such as ARG_XXX_OR_NULL can now be written as

 ARG_XXX | PTR_MAYBE_NULL

Similarly, PTR_TO_RDONLY_BUF is now "PTR_TO_BUF | MEM_RDONLY".

Flags can be composed, as ARGs can be both MEM_RDONLY and MAYBE_NULL.

 ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY

Based on this new composable types, patch 7/9 applies MEM_RDONLY on
PTR_TO_MEM, in order to tag the returned memory from per_cpu_ptr as
read-only. Therefore fixing a previous bug that one can leverage
per_cpu_ptr to modify kernel memory within BPF programs.

Patch 8/9 generalizes the use of MEM_RDONLY further by tagging a set of
helper arguments ARG_PTR_TO_MEM with MEM_RDONLY. Some helper functions
may override their arguments, such as bpf_d_path, bpf_snprintf. In this
patch, we narrow the ARG_PTR_TO_MEM to be compatible with only a subset
of memory types. This prevents these helpers from writing read-only
memories. For the helpers that do not write its arguments, we add tag
MEM_RDONLY to allow taking a RDONLY memory as argument.

Changes since RFC v2:

 - renamed BPF_BASE_TYPE to a more succinct name base_type and move its
   definition to bpf_verifier.h. Same for BPF_TYPE_FLAG. (Alexei)
 - made checking MEM_RDONLY in check_reg_type() universal (Alexei)
 - ran through majority of test_progs and fixed bugs in RFC v2:
   - fixed incorrect BPF_BASE_TYPE_MASK. The high bit of GENMASK should
     be BITS - 1, rather than BITS. patch 1/9.
   - fixed incorrect conditions when checking ARG_PTR_TO_MAP_VALUE in
     check_func_arg(). See patch 2/9.
   - fixed a bug where PTR_TO_BTF_ID may be combined with MEM_RDONLY,
     causing the check in check_mem_access() to fall through to the
     'else' branch. See check_helper_call() in patch 7/9.
 - fixed build failure on netronome driver. Entries in bpf_reg_type have
   been ordered. patch 4/9.
 - fixed build warnings of using '%d' to print base_type. patch 4/9
 - unify arg_type_may_be_null() and reg_type_may_be_null() into a single
   type_may_be_null().

Previous versions:

 RFC v2:
   https://lwn.net/Articles/877171/

 RFC v1:
   https://lore.kernel.org/bpf/20211109003052.3499225-1-haoluo@google.com/T/
   https://lore.kernel.org/bpf/20211109021624.1140446-8-haoluo@google.com/T/

Hao Luo (9):
  bpf: Introduce composable reg, ret and arg types.
  bpf: Replace ARG_XXX_OR_NULL with ARG_XXX | PTR_MAYBE_NULL
  bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
  bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL
  bpf: Introduce MEM_RDONLY flag
  bpf: Convert PTR_TO_MEM_OR_NULL to composable types.
  bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
  bpf: Add MEM_RDONLY for helper args that are pointers to rdonly mem.
  bpf/selftests: Test PTR_TO_RDONLY_MEM

 drivers/net/ethernet/netronome/nfp/bpf/fw.h   |   4 +-
 include/linux/bpf.h                           |  99 +++-
 include/linux/bpf_verifier.h                  |  13 +
 kernel/bpf/btf.c                              |  12 +-
 kernel/bpf/cgroup.c                           |   2 +-
 kernel/bpf/helpers.c                          |  12 +-
 kernel/bpf/map_iter.c                         |   4 +-
 kernel/bpf/ringbuf.c                          |   2 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 464 ++++++++----------
 kernel/trace/bpf_trace.c                      |  26 +-
 net/core/bpf_sk_storage.c                     |   2 +-
 net/core/filter.c                             |  64 +--
 net/core/sock_map.c                           |   2 +-
 .../selftests/bpf/prog_tests/ksyms_btf.c      |  14 +
 .../bpf/progs/test_ksyms_btf_write_check.c    |  29 ++
 16 files changed, 416 insertions(+), 335 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

-- 
2.34.1.400.ga245620fadb-goog

