Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4891449F8B
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 01:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhKIAd4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 19:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKIAd4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 19:33:56 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4CC061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 16:31:11 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id f16-20020a170902ce9000b001436ba39b2bso761757plg.3
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 16:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LEenkkXYDa5VwCQJSviVj3LjzjAWnUa4z4PbuhfAajc=;
        b=VSvi5KZ9a4iNDjYKvGVS2zJkp6y+l1ywpKs4duSZckPVIAgs9hk43cRdxewpyHxDmc
         JC20cRW+ZPutrHHLeWcYQ5u7FuBpLG+GjWF4yL9PXjjTSzGaoHG0xjRNw2mg8vO2USNe
         LqSxtCwke9yDbVh/Q920GOtVUQCNNOTgvfQFAGTK69qI3TGETycJADtPnoCbP/1Bhi4n
         EZvUCeV9XoXo5Ri2yFnzdJUVu7hJq5SYYCGc1HGgRPb8Sm40Msq11C/dAUlFsURe+naa
         vAFl7bFfkZ8XEy6f6JcM5xfVJn3+oyOaNwpO8Id4wpsY11bPr+PYjJLv+RpO/FYTJvKh
         5d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LEenkkXYDa5VwCQJSviVj3LjzjAWnUa4z4PbuhfAajc=;
        b=vfgv/AXXYRa3su97HEIdIyopNRbEQMKWqY2uUe5eDtK7h6hw0rUTZr0GkwYFDfaETa
         TSWOk4w/Na85IMueeURzRrOCSrp7GOv8IZoWV//Xg6AKYks8WTUwnBfdMUa+HoevD3uE
         fk8A0G/GRq/IvHDIx5G1J2YwNeAULZQw5LmHbRGA7rZ1AobsGNAyYuuptr1gGeAbrZYd
         CUzj8D17yOs+98YIY9GqLjPjWWjKk/kIfDB1Kj1R4O3Y+WRUCYiayeeEHVG0ZYNj1PqP
         tAPHUObCyt6gcpuGJS3+FdsVgmIkmuhaL/lujYzrqvlw5mkOY1XeuUc5fUFnjH9dpsn0
         IVdw==
X-Gm-Message-State: AOAM530+qIqi0rbn/JhpjEzMXm+0SkqbKILP9hQWzAuyVIACRheV1kj2
        QwHcwlnvppUrP/Yoh2AxitNWBqc2BR8=
X-Google-Smtp-Source: ABdhPJy7f3q+omleFdgpf7Daa23yF2VOLlFryzRYqSP7j8uR0wixZC0eqDs/lpRVBbEN1Pq11agnNc77YXc=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a17:90a:c3:: with SMTP id
 v3mr93995pjd.0.1636417870138; Mon, 08 Nov 2021 16:31:10 -0800 (PST)
Date:   Mon,  8 Nov 2021 16:30:49 -0800
Message-Id: <20211109003052.3499225-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v3 bpf-next 0/3] bpf: Prevent writing read-only memory
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are currently two ways to modify a kernel memory in bpf programs:
 1. declare a ksym of scalar type and directly modify its memory.
 2. Pass a RDONLY_BUF into a helper function which will override
 its arguments. For example, bpf_d_path, bpf_snprintf.

This patchset fixes these two problem. For the first, we introduce a
new reg type PTR_TO_RDONLY_MEM for the scalar typed ksym, which forbids
writing. For the second, we introduce a new arg type ARG_CONST_PTR_TO_MEM
to differentiate the arg types that only read the memory from those
that may write the memory. The previous ARG_PTR_TO_MEM is now only
compatible with writable memories. If a helper doesn't write into its
argument, it can use ARG_CONST_PTR_TO_MEM, which is also compatible
with read-only memories.

In v2, Andrii suggested using the name "ARG_PTR_TO_RDONLY_MEM", but I
find it is sort of misleading. Because the new arg_type is compatible
with both write and read-only memory. So I chose ARG_CONST_PTR_TO_MEM
instead.

Hao Luo (3):
  bpf: Prevent write to ksym memory
  bpf: Introduce ARG_CONST_PTR_TO_MEM
  bpf/selftests: Test PTR_TO_RDONLY_MEM

 include/linux/bpf.h                           | 20 +++++-
 include/uapi/linux/bpf.h                      |  4 +-
 kernel/bpf/btf.c                              |  2 +-
 kernel/bpf/cgroup.c                           |  2 +-
 kernel/bpf/helpers.c                          | 12 ++--
 kernel/bpf/ringbuf.c                          |  2 +-
 kernel/bpf/syscall.c                          |  2 +-
 kernel/bpf/verifier.c                         | 60 +++++++++++++----
 kernel/trace/bpf_trace.c                      | 26 ++++----
 net/core/filter.c                             | 64 +++++++++----------
 tools/include/uapi/linux/bpf.h                |  4 +-
 .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 ++++
 .../bpf/progs/test_ksyms_btf_write_check.c    | 29 +++++++++
 13 files changed, 168 insertions(+), 73 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

-- 
2.34.0.rc0.344.g81b53c2807-goog

