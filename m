Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04C226F53
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgGTTzH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 15:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGTTzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 15:55:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1442C061794
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 12:55:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p205so18890606iod.8
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 12:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U45wqHTeuSHioOahPCIBGsiWtdDsaEfwDATXxXvi7Yg=;
        b=mkNNafDA246M4hb4jMbE53ptZlOFAF9nVIf/x4oUOyDR5ZseY0vImsx9670fd+yXBT
         oQQo5UXqxrRVws3u6yGohYIvN3zucqkEr1iI0Hbx0BuS8SlpHfiPryDVvkVeYzbHgxkX
         2S12v2M/XG1orLF9F1wuvZ5/8jGAdtkJ2YIqVxN/mXGG4RFR5WZfhvwZz4m272GoxgYz
         T3vDNezXRUdpaevP6ROHnIh2eGZiCDZdqKvdPy9byJtjBbgEn7UbaHMWcxywf39tASQG
         Naz+QLnpikALPVq2TzA88vfnjn8GEKsJcHq5RmoIxcVm+mIRWki/cl5CK6veKsvJLA8C
         rpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U45wqHTeuSHioOahPCIBGsiWtdDsaEfwDATXxXvi7Yg=;
        b=GmvxbyMZChu+q85/ZgwzgqWWg7oj5OTY562hPLQtekjJQ3aNnGmeA27jJV7e8kGgKi
         WJqCPog+Cj+WlqFYVKDf4wKhHGR8lrv5eqE2RqiLAdwGI/EBNxGKkHHngEBgbkRpKUW5
         w3Rt4oaxRlYqocOa4iycf+MHRtBSKswCGwTcuizBRdN2bMubY8oQI5FO4CLhFJ/jyfwV
         InsLRIjXlXFq43V8WvvVdWy3+c/SXHJVaUhHyIBIEbERdERo2wqOZrNdSynD8X5hwW/a
         kwAmnGpRCVTbClrYHnqec98S0rvJ02Sn/we6lGkvghnhpyRAkGxJwi4Kq21kL6UVuqmE
         Bvfw==
X-Gm-Message-State: AOAM533t5nWc0Pc+NeqUSSZ2qnqocLQBzK+NtBInNSIiG3G14ctTRjnL
        cMyEYcORBCtmw0UVZ5jiBQwFFCIYLbyGDQ==
X-Google-Smtp-Source: ABdhPJxQQzz/zXxLCDczFIhikOdv7MXcors1J5HLc0vmje/MhboPjxDYtjgUAnk0hM5EHFNgdH69TQ==
X-Received: by 2002:a02:cf3b:: with SMTP id s27mr27167131jar.72.1595274905688;
        Mon, 20 Jul 2020 12:55:05 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id v10sm9347174ilj.40.2020.07.20.12.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:55:05 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by different programs at once
Date:   Mon, 20 Jul 2020 14:54:50 -0500
Message-Id: <cover.1595274799.git.zhuyifei@google.com>
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

The attach_type field of the map key struct bpf_cgroup_storage_key
is now unused. If userspace reads it it will always be zero. If
userspace sends us a non-zero value it will be ignored.

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
* Userspace that does memcmp on the storage key when fetching
  map keys. In reality, if user wants to use a fixed key they
  would use {delete,lookup,update}_elem, rather than get_next_key.
These cases are dependent on undocumented implementation details, 
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
 kernel/bpf/cgroup.c                           |  69 +++--
 kernel/bpf/core.c                             |  12 -
 kernel/bpf/local_storage.c                    |  73 ++---
 tools/include/uapi/linux/bpf.h                |   2 +-
 .../bpf/prog_tests/cg_storage_multi.c         | 265 ++++++++++++++++++
 .../selftests/bpf/progs/cg_storage_multi.h    |  13 +
 .../progs/cg_storage_multi_egress_ingress.c   |  45 +++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  33 +++
 12 files changed, 536 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/bpf/map_cgroup_storage.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c

-- 
2.27.0

