Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE6222FD7
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgGQAQy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 20:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgGQAQy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:54 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3309C061755
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 17:16:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i4so8311332iov.11
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0uB4LEhwB5afRd2rzG3DwmeDlw7LScfqHdvXwiETx0=;
        b=WZ5+YqTj5FmDvKv75AVsoE4Mky8ukBkvKMF4BwR9arBfBC6+DVBStlOM/qM0+cU9lw
         +rftK0zYdbNFeeKbajfNf2DhA/2bCdupWsr7/2d9ajUHy70WjF6Mf3VjMqs4Obj64IIa
         MZ0pLJwINxg6UcnFLrqJB00PB4bwmC9KO8nXs3TUS8j8dHm5f5VpTeP/Oi7gPpebKsJX
         8Yw/u7KMZ8f+VxLM8dXWVS6+3O/MFwV7DzkFGP4xl8KfWuZYVvkqqCJQG7JRv8KFsXm0
         ji+pHYeSgYB/o2pUV8W86tKeP2rMaakkyM7nZchkBgk50+XUEXw2yMzxoPmUCpjc3U3u
         s/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0uB4LEhwB5afRd2rzG3DwmeDlw7LScfqHdvXwiETx0=;
        b=igOD9E7HTv45lS92GnZPcQCIGsZRD2f7NpQ8dj0ZzATqxfyUBKLDN4yQdlZUOL5FXh
         hiPAcqderVEzIcIjxuORWKFtuiQsk8y0B4ljgk8boOA1xhfwceUPXQoiVJDNN/4XOy4p
         660DIKoOOfqRK8BzK33A8q6XBPV4Y3Ecpjh04oHeTDWY9Bl4i8Y2eQOZ5OxceazWg2g8
         yb3c0Ga+aNn8xLZFndnMG0VbrjCVn5dqCarfVPEVPMIz3552ItwTvJv7dianz2QaD1Rz
         oAehP2b3JAqZjMKe3X9KYC0/JXXDuRNC/YNEFpv/XtPAITHufIiuZ/h4PZYbHc77Sbjy
         1Nrg==
X-Gm-Message-State: AOAM530ct+V4sPBXi4ESezgpdGTyqcAh+N1OliC9wug5duZeeaQiVIwp
        BCY2fDCOLKh9mmC/mELbYpnnXc6xOkBTKQ==
X-Google-Smtp-Source: ABdhPJwaZCRF6tvL+bd8x4ramOJM8tDfBGcyF6Cfu6SVRlAWfX9sQb4KbeMLCoI1uAXZob0hsVu6HQ==
X-Received: by 2002:a92:25c9:: with SMTP id l192mr7005393ill.135.1594945012922;
        Thu, 16 Jul 2020 17:16:52 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id m5sm3427493ilg.18.2020.07.16.17.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:52 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by different programs at once
Date:   Thu, 16 Jul 2020 19:16:24 -0500
Message-Id: <cover.1594944827.git.zhuyifei@google.com>
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
 kernel/bpf/local_storage.c                    |  85 +++---
 tools/include/uapi/linux/bpf.h                |   2 +-
 .../bpf/prog_tests/cg_storage_multi.c         | 265 ++++++++++++++++++
 .../selftests/bpf/progs/cg_storage_multi.h    |  13 +
 .../progs/cg_storage_multi_egress_ingress.c   |  45 +++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  33 +++
 12 files changed, 551 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/bpf/map_cgroup_storage.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c

-- 
2.27.0

