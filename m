Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACB21AAFD
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 00:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGIWzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 18:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIWzK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 18:55:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727BC08C5CE
        for <bpf@vger.kernel.org>; Thu,  9 Jul 2020 15:55:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i4so4048492iov.11
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2020 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfyKMx3St+REUch6P2sRofd3+6kCnm57+ogeeU6iISY=;
        b=We5djwMFbul/yMnZ18lHEriS/pRDkCtynmWD1QFOKjPcCuhWpV0nBR2sFNKwSAobrI
         vyf8BHfoOMk91savZ20kgHTR88kVRDDXXNq+kzpPfV33B0GwF8XPW35dCT6L/wa4sYUC
         UxNcSLya7rCgy4KjK3PrQWxJIhrbPOPy0MrFtSjK/ZZzS/rYFt1ss5hPEE03Bj/eL7TG
         8do7f1jEiRsYc5QQwEJXqZw2c5Hl6kZSOvKCSMmi+fJLc/LgDmg+lQkY2NA//8Wsf6Ps
         JX+l2F+dw7tyNoqq4O2HBHlATJzseqRJBl67qVSzLe2rJpHll4yZZR/mhFnLdIeMI3CY
         inQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfyKMx3St+REUch6P2sRofd3+6kCnm57+ogeeU6iISY=;
        b=Asinvi3ThnFcqqoVAADRJxXreFpgaT74x1A7KWE6x2hLC5PDfI4W6dj433dj6Sh493
         zTs9I5Xw6DX9bm0EDO6PYJAwyCYM9VOWOobSGRHsWyVOrisU0EscJjlX4nmhlwMsaZmd
         WIqkZHoM4yKjM8CotQwFzV1FCQ7eKTUfFr+U0b3pemxMs6WLy4t8kDBcYhoIfEpE07iu
         REuIlCOFgMquiiZinRKVwdmjmt+w/L+vU7zJV7stOA+drxWzrkemjRyjJqiijjBJGYiF
         GOHVZrMKGdISuGJXNi43wHt6lD3z+EFiigrxMwg1kXgapwTYSt5J1KQ0Zlf+4ulhTcmS
         jvYQ==
X-Gm-Message-State: AOAM532k7Ns2zGZMSF5zSJ4Ml6Isa6sWtxpCZZX3y1cHFBfxTyIun5dC
        y+WzMAHGwQU2hHjjAky0QGVUQXnA+dnLgQ==
X-Google-Smtp-Source: ABdhPJz4eo0Tv9lP36j8E7opbWO2c5lDpa380KaMjqmWs6QTQQGpuGPL7lK3blWkpBeH8cU7M+G4CA==
X-Received: by 2002:a02:a19c:: with SMTP id n28mr74629265jah.13.1594335309490;
        Thu, 09 Jul 2020 15:55:09 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id q2sm2552416ilp.82.2020.07.09.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:55:08 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v2 bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by different programs at once
Date:   Thu,  9 Jul 2020 17:54:46 -0500
Message-Id: <cover.1594333800.git.zhuyifei@google.com>
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

How could this break existing users?
* Users that uses detach & reattach / program replacement as a
  shortcut to zeroing the storage. Since we need sharing between
  programs, we cannot zero the storage. Users that expect this
  behavior should either attach a program with a new map, or
  explicitly zero the map with a syscall.
* Programs that expect isolation from different attach types. In
  reality, attaching the same program to different attach types,
  relying on that expected_attach_type not being enforced, should
  rarely happen, if at all.
Both cases are dependent on undocumented implementation details,
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

YiFei Zhu (5):
  selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
  selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
  bpf: Make cgroup storages shared across attaches on the same cgroup
  selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
  Documentation/bpf: Document CGROUP_STORAGE map type

 Documentation/bpf/index.rst                   |   9 +
 Documentation/bpf/map_cgroup_storage.rst      |  95 +++++++
 include/linux/bpf-cgroup.h                    |  15 +-
 include/uapi/linux/bpf.h                      |   2 +-
 kernel/bpf/cgroup.c                           |  42 ++-
 kernel/bpf/core.c                             |  12 -
 kernel/bpf/local_storage.c                    |  77 +++--
 tools/include/uapi/linux/bpf.h                |   2 +-
 .../bpf/prog_tests/cg_storage_multi.c         | 265 ++++++++++++++++++
 .../selftests/bpf/progs/cg_storage_multi.h    |  13 +
 .../progs/cg_storage_multi_egress_ingress.c   |  45 +++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  33 +++
 12 files changed, 520 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/bpf/map_cgroup_storage.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c

-- 
2.27.0

