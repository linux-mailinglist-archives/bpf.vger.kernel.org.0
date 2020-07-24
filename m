Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94CE22BD22
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 06:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGXEsH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 00:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGXEsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 00:48:07 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAD4C0619D3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:07 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s21so6227760ilk.5
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sr+mR1vs8jqDLQwDZZRnkb6Ha3Hb1q3t2O8A32/5UxU=;
        b=Km6Koh1LMoTzXx4nc5IBb2nnboJjDqocxUJld32elh7YeCfuVVYARkHlAaQDF56Td+
         LWuwVI3LIm76dP6WZ9JgNs5ffma8FabhIiIXA7gP/juC6vwKJaeWYxgZ5VvybjU/v0yY
         VQUZBvGSOsOGuzKzOhvMMIS6eL0eclv6hwfTzchdJEpLxlRljEHvCGSjv60iggRFK54J
         AbAJlhxSp9V/XeuslUhIiFCDIHiWWjSVFmNOBhM8jNobfiSjgRbCbXOTPmRgF8SQgAfU
         StzWulNpS7j0PJfCyhv+p2H+7E3+Z2vzfaTeYX9qKIaQ9JVFQBcmYAmcRL4qVq4hjO0n
         UD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sr+mR1vs8jqDLQwDZZRnkb6Ha3Hb1q3t2O8A32/5UxU=;
        b=B/3byqBIUHLZUpIkhHiC0yfoker7/NBtyCzbTtrqtzYhQrOCY6soDTL9fYPHdb5HLa
         tKlGfhjiYwvSHyhAeTCC7qmJ6qVo3q1V449d4Srn/SQvaOcAELK22UI+otpCo/eOlW0M
         SQW0IO4JvClPHBbV3rbmBPZRg8O6GT0hPk0RXAEXVNj397byQM5DqCE4uEg6vEdBkGh1
         r2pzYFV6FuvWaqluRS5YG22pdduHtgfyrgW2muvZMDyA6P+l6vFL6FTDazIJqMDbd7+F
         ENBzkCdTqg3Ll5N8tI6fpM7yKV4yc3qtubdv36TgR0u8kKpk0sHNZjl7s22PMcNQ7/7l
         hq6g==
X-Gm-Message-State: AOAM532wu+ERNYSjRfEKepqjcYkdDPqCW9vp4lOdbBB0vddCPUQUHLsk
        oUxr287BJj8/i2H6gzOBv8uXF/zjbn6CcQ==
X-Google-Smtp-Source: ABdhPJy4i/1Mo/3xcTxqsL5Y7UJ025coGHB6vcV/u6Nd/Zbi7BLR5d8XkeTTt4HI/OX1PdmiKSfH2Q==
X-Received: by 2002:a92:4856:: with SMTP id v83mr8116303ila.125.1595566086346;
        Thu, 23 Jul 2020 21:48:06 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id o64sm2686579ilb.12.2020.07.23.21.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 21:48:05 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v6 bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by different programs at once
Date:   Thu, 23 Jul 2020 23:47:40 -0500
Message-Id: <cover.1595565795.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

To access the storage in a CGROUP_STORAGE map, one uses
bpf_get_local_storage helper, which is extremely fast due to its
use of per-CPU variables. However, its whole code is built on
the assumption that one map can only be used by one program at any
time, and this prohibits any sharing of data between multiple
programs using these maps, eliminating a lot of use cases, such
as some per-cgroup configuration storage, written to by a
setsockopt program and read by a cg_sock_addr program.

Why not use other map types? The great part of CGROUP_STORAGE map
is that it is isolated by different cgroups its attached to. When
one program uses bpf_get_local_storage, even on the same map, it
gets different storages if it were run as a result of attaching
to different cgroups. The kernel manages the storages, simplifying
BPF program or userspace. In theory, one could probably use other
maps like array or hash to do the same thing, but it would be a
major overhead / complexity. Userspace needs to know when a cgroup
is being freed in order to free up a space in the replacement map.

This patch set introduces a significant change to the semantics of
CGROUP_STORAGE map type. Instead of each storage being tied to one
single attachment, it is shared across different attachments to
the same cgroup, and persists until either the map or the cgroup
attached to is being freed.

User may use u64 as the key to the map, and the result would be
that the attach type become ignored during key comparison, and
programs of different attach types will share the same storage if
the cgroups they are attached to are the same.

How could this break existing users?
* Users that uses detach & reattach / program replacement as a
  shortcut to zeroing the storage. Since we need sharing between
  programs, we cannot zero the storage. Users that expect this
  behavior should either attach a program with a new map, or
  explicitly zero the map with a syscall.
This case is dependent on undocumented implementation details, 
so the impact should be very minimal.

Patch 1 introduces a test on the old expected behavior of the map
type.

Patch 2 introduces a test showing how two programs cannot share
one such map.

Patch 3 implements the change of semantics to the map.

Patch 4 amends the new test such that it yields the behavior we
expect from the change.

Patch 5 documents the map type.

Changes since RFC:
* Clarify commit message in patch 3 such that it says the lifetime
  of the storage is ended at the freeing of the cgroup_bpf, rather
  than the cgroup itself.
* Restored an -ENOMEM check in __cgroup_bpf_attach.
* Update selftests for recent change in network_helpers API.

Changes since v1:
* s/CHECK_FAIL/CHECK/
* s/bpf_prog_attach/bpf_program__attach_cgroup/
* Moved test__start_subtest to test_cg_storage_multi.
* Removed some redundant CHECK_FAIL where they are already CHECK-ed.

Changes since v2:
* Lock cgroup_mutex during map_free.
* Publish new storages only if attach is successful, by tracking
  exactly which storages are reused in an array of bools.
* Mention bpftool map dump showing a value of zero for attach_type
  in patch 3 commit message.

Changes since v3:
* Use a much simpler lookup and allocate-if-not-exist from the fact
  that cgroup_mutex is locked during attach.
* Removed an unnecessary spinlock hold.

Changes since v4:
* Changed semantics so that if the key type is struct
  bpf_cgroup_storage_key the map retains isolation between different
  attach types. Sharing between different attach types only occur
  when key type is u64.
* Adapted tests and docs for the above change.

Changes since v5:
* Removed redundant NULL check before bpf_link__destroy.
* Free BPF object explicitly, after asserting that object failed to
  load, in the event that the object did not fail to load.
* Rename variable in bpf_cgroup_storage_key_cmp for clarity.
* Added a lot of information to Documentation, more or less copied
  from what Martin KaFai Lau wrote.

YiFei Zhu (5):
  selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
  selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
  bpf: Make cgroup storages shared between programs on the same cgroup
  selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
  Documentation/bpf: Document CGROUP_STORAGE map type

 Documentation/bpf/index.rst                   |   9 +
 Documentation/bpf/map_cgroup_storage.rst      | 169 ++++++++
 include/linux/bpf-cgroup.h                    |  12 +-
 kernel/bpf/cgroup.c                           |  67 +--
 kernel/bpf/core.c                             |  12 -
 kernel/bpf/local_storage.c                    | 216 +++++-----
 .../bpf/prog_tests/cg_storage_multi.c         | 403 ++++++++++++++++++
 .../selftests/bpf/progs/cg_storage_multi.h    |  13 +
 .../bpf/progs/cg_storage_multi_egress_only.c  |  33 ++
 .../bpf/progs/cg_storage_multi_isolated.c     |  57 +++
 .../bpf/progs/cg_storage_multi_shared.c       |  57 +++
 11 files changed, 905 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/bpf/map_cgroup_storage.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c

-- 
2.27.0

