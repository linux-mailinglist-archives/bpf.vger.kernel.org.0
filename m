Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CAA22A9BD
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGWHlF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGWHlF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 03:41:05 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4612EC0619DC
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 00:41:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l17so5256146iok.7
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DKkXxZOxV2ztRHPdrOQ4F41hkLbfBZkv9yWC3xtR6Ck=;
        b=LtTpre25ydxk/CE9IsnQ3dpCYIzt9VW6lIES7yTDmvKDc3b4MK2lz3Kf4KJkxKp0uK
         oq2U8rwX/69NSn30yG3FxTsLz/U0D/6bPpYCl/lNIdWrcnyNxOqvrveLMBMgYL5pQ31P
         7b4429osNjdsgllS04AV4OXsLDzY25Ic8+4tu7JxhCOhYhmWIVn/fTJ7vKqBMO5W+6uE
         jmqWjOIAuvj3o8bhv6uT9/LQkOmYX59tdndbFTMmsysS7d3/9/TfV6ZkzJVGtWv1aPRj
         rEaXZMHoeRb517PvY1bfJaLYbcTyEVlx7ohZwW88HI3+0I9Fd4jbUomHdA+Z2/SOFEIo
         qEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DKkXxZOxV2ztRHPdrOQ4F41hkLbfBZkv9yWC3xtR6Ck=;
        b=qhHUVIeLpCYEDFKOUhNYngugprowXBX+fPrZ1Gh87hYTVCi8TaR82Niu0fSVFUPWvG
         P1Fe97zh+wTOP6So+GUR0umjinIQ9C7EdumOspfAftBim/xmpXvkEHhC7MU8iExe3S+i
         ZT7yLll1O6ZICTZMiTYs6zyqXxtH3pOvrhg7JwGVVDwlGgIU9l7WfoESUeTI8lbOghrK
         jhgFaDfstJqzk6qbaTHRT37bM0WuT/Cw7RaMeKWFKveFx7nzoJdDENk7cyNp5aQNdGpm
         mI53SkjFyyEAMs0iN29TbmTk/ObuiL5WUjO3P5fu5vrxOEXdfwyGgt5VhjBL/HjTvG4M
         cHSg==
X-Gm-Message-State: AOAM532cnER4CpuNX1S4lo6HLOHHEEgsAfD5voz7SBQE4K/mEmFvXCyO
        YOsS4KUPPcJ9pbMiww3DoKOTBC+G3cd1XQ==
X-Google-Smtp-Source: ABdhPJwCzpEX4ngqcT9clwmxwOFYqKL09vDVAEHobdCsQ3SZpgXqQkdyFwEBbClAFp1fB1NtToMhww==
X-Received: by 2002:a5d:97d1:: with SMTP id k17mr3682506ios.100.1595490064169;
        Thu, 23 Jul 2020 00:41:04 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id c9sm1035552ilm.57.2020.07.23.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 00:41:03 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by different programs at once
Date:   Thu, 23 Jul 2020 02:40:53 -0500
Message-Id: <cover.1595489786.git.zhuyifei@google.com>
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

YiFei Zhu (5):
  selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
  selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
  bpf: Make cgroup storages shared between programs on the same cgroup
  selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
  Documentation/bpf: Document CGROUP_STORAGE map type

 Documentation/bpf/index.rst                   |   9 +
 Documentation/bpf/map_cgroup_storage.rst      |  97 ++++
 include/linux/bpf-cgroup.h                    |  12 +-
 kernel/bpf/cgroup.c                           |  67 +--
 kernel/bpf/core.c                             |  12 -
 kernel/bpf/local_storage.c                    | 216 ++++-----
 .../bpf/prog_tests/cg_storage_multi.c         | 417 ++++++++++++++++++
 .../selftests/bpf/progs/cg_storage_multi.h    |  13 +
 .../bpf/progs/cg_storage_multi_egress_only.c  |  33 ++
 .../bpf/progs/cg_storage_multi_isolated.c     |  57 +++
 .../bpf/progs/cg_storage_multi_shared.c       |  57 +++
 11 files changed, 847 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/bpf/map_cgroup_storage.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c

-- 
2.27.0

