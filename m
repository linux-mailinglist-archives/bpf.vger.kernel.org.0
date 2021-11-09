Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD3844A47E
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhKICTR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhKICTQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCABC061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so28182295yba.11
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qz5scgADGMichO5oLtQ0V6IHs/3BfBRxB07mIzET0NY=;
        b=Iwwxnk5OkhlAfXhDT6v4K7iPSdJsJmLzC4KeityQ6kZP+on6D1nhkA81KD8Jf4BG9f
         a+l3OOcEWGFs2Kg183d3Pd19gvLHsipuZDXTewJCkoAvuV0vZuAg1CbB4hQbrR1X0MB9
         cCMG9RCXGznSd8FzHAmXvmZ2LKG+p7g2f2HdvflcfQfPTcqknXd2TuWxM6IY5lGa+J2W
         rvylr3Ov3N4L/djKd70CqhXIFfUhrUzPJ8DJKOL3I+647pkil2sHwk0tvD+SSbAqnhGv
         0iIP/vOGIlaSqKb+TTthh9v8b1gpUmoCoeGU/+zVfGYWGO/k7Vub6IGmWFxTvkcKHLqz
         oPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qz5scgADGMichO5oLtQ0V6IHs/3BfBRxB07mIzET0NY=;
        b=1BW5IOf7BPI5LyIiMOYv6CyjUMKlChzHs9tL64SQwCdbRA3J/eMnRK8Bm3s+Oid6yx
         9AW454OYU9vct3ROsL7WljwhIBGzubkF+Av5cL4AB79QFaguWIADKhsZ+qfYwrxqtRz2
         5zqIh+6u+4l73FkCpo/hy5zbEfa/ltjL48cgEVSVxYm2Jpg8r/RI0Ys5H/tNEAMF9HWq
         odOO8kKA3Zene+3xIWXPLgBY8PvXSjZoJ7pubzL8E8WkRMdJYxA7zyGbVy1jaUtGciU4
         zGF5TV7mmUYPNoY0JXaMtoZQUdtemeXtsiodPz8alQ1/xBzjskZwvkxzmgYRHDGUJaim
         r5kQ==
X-Gm-Message-State: AOAM530rFa4VzsalJm0iH7aJSQxPsVdDncEXIaNFXdqQgiEay8z1lVIp
        5OZYI3hOEcyyt9xQI+yI4x890g48px0=
X-Google-Smtp-Source: ABdhPJxkj4ABQ9pfAk1qoe/N3DBrXZ6cs3FY97/3GRrbdy0PDhObnS2LqXGD2pC1vURhPezpzGf47BPQr08=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a25:42d7:: with SMTP id p206mr4294370yba.494.1636424190756;
 Mon, 08 Nov 2021 18:16:30 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:15 -0800
Message-Id: <20211109021624.1140446-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 0/9] bpf: Clean up _OR_NULL arg types
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

This is a pure cleanup patchset that tries to use flag to mark whether
an arg may be null. It replaces enum bpf_arg_type with a struct. Doing
so allows us to embed the properties of arguments in the struct, which
is a more scalable solution than introducing a new enum. This patchset
performs this transformation only on arg_type. If it looks good,
follow-up patches will do the same on reg_type and ret_type.

The first patch replaces 'enum bpf_arg_type' with 'struct bpf_arg_type'
and each of the rest patches transforms one type of ARG_XXX_OR_NULLs.

This is purely refactoring patch and should not have any behavior
changes.

Hao Luo (9):
  bpf: Replace enum bpf_arg_type with struct.
  bpf: Remove ARG_PTR_TO_MAP_VALUE_OR_NULL
  bpf: Remove ARG_PTR_TO_MEM_OR_NULL
  bpf: Remove ARG_CONST_SIZE_OR_ZERO
  bpf: Remove ARG_PTR_TO_CTX_OR_NULL
  bpf: Remove ARG_PTR_TO_SOCKET_OR_NULL
  bpf: Remove ARG_PTR_TO_ALLOC_MEM_OR_NULL
  bpf: Rename ARG_CONST_ALLOC_SIZE_OR_ZERO
  bpf: Rename ARG_PTR_TO_STACK_OR_NULL

 include/linux/bpf.h            | 102 ++---
 kernel/bpf/bpf_inode_storage.c |  15 +-
 kernel/bpf/bpf_iter.c          |  11 +-
 kernel/bpf/bpf_lsm.c           |  10 +-
 kernel/bpf/bpf_task_storage.c  |  15 +-
 kernel/bpf/btf.c               |   8 +-
 kernel/bpf/cgroup.c            |  31 +-
 kernel/bpf/core.c              |   8 +-
 kernel/bpf/helpers.c           | 138 ++++---
 kernel/bpf/ringbuf.c           |  32 +-
 kernel/bpf/stackmap.c          |  45 +-
 kernel/bpf/syscall.c           |  16 +-
 kernel/bpf/task_iter.c         |  13 +-
 kernel/bpf/verifier.c          | 179 ++++----
 kernel/trace/bpf_trace.c       | 267 +++++++-----
 net/core/bpf_sk_storage.c      |  41 +-
 net/core/filter.c              | 729 +++++++++++++++++----------------
 net/core/sock_map.c            |  48 +--
 net/ipv4/bpf_tcp_ca.c          |   4 +-
 19 files changed, 932 insertions(+), 780 deletions(-)

-- 
2.34.0.rc0.344.g81b53c2807-goog

