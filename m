Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE5E4629AE
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhK3BdM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbhK3BdM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590CC061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:29:54 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x14-20020a627c0e000000b0049473df362dso11849150pfc.12
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hD8xWu/YKHaQLM6d3MiaZOr2V4Gqib9Jlw+GqeZmIek=;
        b=puxaUtpjELnMoFzaJdni8weWhwdX++jyv3BARf50csVVzhdEeq5y6vaA4zlVGaj9cF
         dXAnGbwmoebx2Z8iN6jYMBuofvXseZkt/F44wA4a7u2ahKovuEVE6NJa8OsMbUb2pVLJ
         h+WODMPPyDoPGNuudBdy6/Fs4QrzMOAQQbrfi0G9TLM1CW0AvkWYVugoqwj9HNJaStXz
         DLeFy8haGeA0khqz/QyWyTe1M7tX/a74uVfkLxw7KVF4dQPn04DwAANBA/8YYZ1B9l/d
         1f0HwC0/9WYlTPUyHBg0SEKP/TZ38WuCopp1/jnV/xb1CcCu5SrWnTVkezlcUGhewSHX
         MgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hD8xWu/YKHaQLM6d3MiaZOr2V4Gqib9Jlw+GqeZmIek=;
        b=oPfLPZTjy8/4rBPFFyRWK4VsKIVhaAoYqFOH5n7Nx0eoUjnfatyeSG1GP6M2WUhSJb
         CGc4LgwoqWGZ8KoRl8uz2Hxt8/OgartVikYRL9DOOD7UAcbd1MZUOq/z467m5UcDhGvR
         ow+zzgvSwyuJZFz4FCdQm2wOjqgvhnRWz89JojauVgM2lbUduYTKhv1jMlvjAk+8tMih
         wfLK90T55zhhuhQF9ME8MaRAjVUfafBGf8SqH1+2p+xEv0AWAy0OB+34itDr+hw/4fJp
         Kh4nXTNuKuihga8b/qDEYlRzDAoSLOaY7n/oZ3Gn7ta50ZUtuh4kwXA1ienQWFZVjZsN
         rhyg==
X-Gm-Message-State: AOAM533DQ3EdnLJZfrA+yohq2PacuudHGujvPZ8OQiQ1BNvUnILsGTXu
        o9/NqHe5WFB8pXLiH0yjsijMIlDi5OI=
X-Google-Smtp-Source: ABdhPJy9vJmDZgpVL/hWETymsjfs5dkOBiLBWiSnE/yLS7OOyxNEeFGQCWky+vx/41T8wrC+X53dLloVV90=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bbf5:5c09:9dfe:483c])
 (user=haoluo job=sendgmr) by 2002:a17:90b:1486:: with SMTP id
 js6mr122146pjb.0.1638235793405; Mon, 29 Nov 2021 17:29:53 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:29:39 -0800
Message-Id: <20211130012948.380602-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC PATCH bpf-next v2 0/9] Introduce composable bpf types
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

The purpose of the cleanup is to find a scalable way to expressing type
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

Previous versions of this patchset:

[1] https://lore.kernel.org/bpf/20211109003052.3499225-1-haoluo@google.com/T/
[2] https://lore.kernel.org/bpf/20211109021624.1140446-8-haoluo@google.com/T/

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

 include/linux/bpf.h                           | 105 +++-
 kernel/bpf/btf.c                              |  13 +-
 kernel/bpf/cgroup.c                           |   2 +-
 kernel/bpf/helpers.c                          |  12 +-
 kernel/bpf/map_iter.c                         |   4 +-
 kernel/bpf/ringbuf.c                          |   2 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 455 +++++++++---------
 kernel/trace/bpf_trace.c                      |  26 +-
 net/core/bpf_sk_storage.c                     |   2 +-
 net/core/filter.c                             |  64 +--
 net/core/sock_map.c                           |   2 +-
 .../selftests/bpf/prog_tests/ksyms_btf.c      |  14 +
 .../bpf/progs/test_ksyms_btf_write_check.c    |  29 ++
 14 files changed, 414 insertions(+), 318 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

-- 
2.34.0.384.gca35af8252-goog

