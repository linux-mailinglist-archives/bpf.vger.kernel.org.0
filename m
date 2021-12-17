Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C328547814F
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhLQAcB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhLQAcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:32:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B071C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y17-20020a2586d1000000b005f6596e8760so1428344ybm.17
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V///VcFEBhjR6GeGnFgf0YY+klBa/s9b1Wa6vUmP1t4=;
        b=lMY15nnYkFC67MnTKRrxVsvfsvp1c6DUsxTl2p8Y2WMnVexVIOI2uZpNOg+VgxgL2M
         GyR5t2ofUH652cAOrCyMjltPANAXNmdxLNtMD2PBVELOWQGV/2p+QrMZXouGdE0lPaiP
         SOV5M906w8in40oKMlHGl2QV+UXVLNDzM0zqRDp/b6v5ZC7Fb0iNn0+yvzR8ZSoCyjT7
         Gf6XlidNChGkvnLV+LMZedIixZGP89hQOxfRN7fCKe6NxgZxvCO8GEqFPhEtkOqGBUj1
         fhdS0wlUJiyEvCeVUpnCE/WNB/VXMFUFLSsD/v7Cfw6Pif3jDWLTeCusLOdxAFCng2Up
         zzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V///VcFEBhjR6GeGnFgf0YY+klBa/s9b1Wa6vUmP1t4=;
        b=hyVitlxySjzTvGAkLpZT15Ep9jtlFHYG2SU/4XqScYMEvh0Er5gpm7qfrZq7bxOWbw
         mf0pKrVp9K+rF00vvZt00JqFzGH3OaL+v2JzC0W5SA+gcKv/Ino/2AKD23oWQmvFpDak
         FJhwg0b/kEKZCpV9+5nlS9TaNa0oLqvEAbN9DR+7hWEWy0RgdiD2Cx73c6j9buSzgxyY
         L0muYsd0T3+7W1Q8YFAfL+X6G6G03icY+PwHCUNs29pGs9jND72McHTU9K5BxsTvkDdo
         M89bv5djYkV5D3iAlUiVC4od6fMo15kXHVEVd53+IGo07B2A1Awa5upnYmC1o1qy/8/r
         AB7Q==
X-Gm-Message-State: AOAM530P1UpMBTs3YzPgyMGtOUNVY4C2GLrETTQY4U/3naBZvn4o6zfq
        1dXtofa27OLm7aPmJy5xJMzmeoqYRQo=
X-Google-Smtp-Source: ABdhPJx4tLgI4kg7SD9rKQCSLQbYtCHKkMQEprqokIi4WhctnsZSS51YehKmZH8rDJOxCY9C6muKhkCSM0g=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:9064:adcd:ab38:7d29])
 (user=haoluo job=sendgmr) by 2002:a05:6902:120e:: with SMTP id
 s14mr853207ybu.397.1639701119438; Thu, 16 Dec 2021 16:31:59 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:31:43 -0800
Message-Id: <20211217003152.48334-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH bpf-next v2 0/9] Introduce composable bpf types
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

Changes since v1:
 - use %u to print base_type(type) instead of %lu. (Andrii, patch 3/9)
 - improve reg_type_str() by appending '_or_null' and prepending 'rdonly_'.
   use preallocated buffer in 'bpf_env'.
 - unified handling of the previous XXX_OR_NULL in adjust_ptr_min_max_vals
   (Andrii, patch 4/9)
 - move PTR_TO_MAP_KEY up to PTR_TO_MAP_VALUE so that we don't have
   to change to drivers that assume the numeric values of bpf_reg.
   (patch 4/9)
 - reintroduce the typo from previous commits in fixes tags (Andrii, patch 7/9)
 - extensive comments on the reason behind folding flags in
   check_reg_type (Andrii, patch 8/9)
 
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

 v1:
   https://lwn.net/Articles/877938/

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

 include/linux/bpf.h                           | 101 +++-
 include/linux/bpf_verifier.h                  |  17 +
 kernel/bpf/btf.c                              |  12 +-
 kernel/bpf/cgroup.c                           |   2 +-
 kernel/bpf/helpers.c                          |  12 +-
 kernel/bpf/map_iter.c                         |   4 +-
 kernel/bpf/ringbuf.c                          |   2 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 491 +++++++++---------
 kernel/trace/bpf_trace.c                      |  26 +-
 net/core/bpf_sk_storage.c                     |   2 +-
 net/core/filter.c                             |  64 +--
 net/core/sock_map.c                           |   2 +-
 .../selftests/bpf/prog_tests/ksyms_btf.c      |  14 +
 .../bpf/progs/test_ksyms_btf_write_check.c    |  29 ++
 15 files changed, 444 insertions(+), 336 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

-- 
2.34.1.173.g76aa8bc2d0-goog

