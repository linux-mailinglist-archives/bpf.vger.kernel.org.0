Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28FA2160AF
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 22:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgGFUyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 16:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFUyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 16:54:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6309C061755
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 13:54:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i25so40980351iog.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlP7ilQtVEXdH66ijRxl3KqmG58cxjCgZq5Ryo/yoJQ=;
        b=H+++hETzIy1NbhrW61JBK8ve6UXNIgeRDXDmvBHev1sbKRJ4+A5UkHCCCARYsme3om
         fP0ua0rIlDEFBnOj4frt+NvXt1GW9ZA3cHY9OXLmBMpysyv2SV8Zx5MP7jp6m12onGUH
         6MV+7zc1e/9VZ8CACGc2l4a9PxPPl4ShAnh/UMd6A5VJrcrsiW6ki1ijnOJRrXawHV8B
         CvbGTj6L+6ghNzldFjqEqWE25Vi9ksYuDQMXlLdauZtis6vcCoeb9THqE75R/8JsCUm3
         R7iDaUfAbuAErxPJoJTDmqDln9I9LrI1+n8VBlichDVmwhUOlHNXP7lSJ0uirmgsDPde
         Fo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlP7ilQtVEXdH66ijRxl3KqmG58cxjCgZq5Ryo/yoJQ=;
        b=Eml/zPdqKROQUbW8vsNldEWWbn7KL35IGN5YDOVsQ7rU3XDfgZOHQixN5mgW7pUcg8
         R0Z10XWmT/1NRADQ5kJ7D0GU9+/28kHhSBjzVtuVx7gEm5LvpR8r4cTIeZ6+qjpFvF2t
         QUg7kH0a32jRLYMVwKlPTr3QwbRlvW8ncqj1ePmR4YGa8MVf/M7HFIKlXt2glrfHXl38
         k+pnXcjHvFHa2eWDIISbHU6XiGvOC6wslqXYyWRyHrUoog0hDsdOuRF6HjSeYcF7SdoK
         EYxtgLKkjwlJx/7jQHhbai9vSN10bu/UD3SV9dqda/rD0/NVf+u1bUlNG2/OwXdV2apX
         3DQg==
X-Gm-Message-State: AOAM531NHBsB7wGf25KfR3iq/3LMCxx15HeQdlmixoECN6pyp4Axzvnw
        /thDn3pmpNmCLOJ3q4OPlOZJMuOz
X-Google-Smtp-Source: ABdhPJxziHiDa8fgOmXSw2/PqxF2hcx7nFVRm9eXTa6/AtvzcpMrrt9e18YvlTeBdHNd8P/DphEvLA==
X-Received: by 2002:a02:2401:: with SMTP id f1mr54077588jaa.66.1594068850974;
        Mon, 06 Jul 2020 13:54:10 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id r124sm10744198iod.40.2020.07.06.13.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:54:10 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by different programs at once
Date:   Mon,  6 Jul 2020 15:51:17 -0500
Message-Id: <cover.1594065127.git.zhuyifei@google.com>
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
 kernel/bpf/local_storage.c                    |  77 +++---
 tools/include/uapi/linux/bpf.h                |   2 +-
 .../bpf/prog_tests/cg_storage_multi.c         | 242 ++++++++++++++++++
 .../selftests/bpf/progs/cg_storage_multi.h    |  13 +
 .../progs/cg_storage_multi_egress_ingress.c   |  45 ++++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  33 +++
 12 files changed, 497 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/bpf/map_cgroup_storage.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c

-- 
2.27.0

