Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8DD2115AB
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 00:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGAWOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 18:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgGAWOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 18:14:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5DBC08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 15:14:16 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t27so17515708ill.9
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q1qSuCTo0dSuTlQjfmI71A5EcssAnGIPDJTBZcFFWms=;
        b=GIfhDxeuZj99B1JGNdanYOPV2apiDPClagQO8xd5+Bm+JhnsWn8yQWXaK8sm4pTaFu
         JMGb67bGCLUXMOV5+jxa9tb/ujUXHs8B35k3T3wkAl4mUhPsSPs4FFc1LFAMyeYI1zll
         h4FHnl47wgd2D0H67IynNUTZrjuacmdrRly1uFfr1yudPoakE0SQO2Nfv7QL/HVObved
         5OutC4GsuR+1PlaU772LMorrAJmZxpCzjarsgQ3C7tT1+msvTdInqeonH84uaPbD7ecn
         FnSoxVddKKqhphnKOYqBe7WJ+vYw31wM0SppSzV6MNwhjC8mnavBqWxFOS3OPmU5hgF0
         cWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q1qSuCTo0dSuTlQjfmI71A5EcssAnGIPDJTBZcFFWms=;
        b=aKlXOXK/VVetKXbsh4UrGznyvPtetcElgNZafnej03al1pQbpaB2cE67AFKRX6Bo57
         6cS6QxHRYZlV9W9Ud/nZls5WW6fLbqaLod4nda3xU+jzHYqssNBOvj4DEob1LpH43sNe
         IJLEuEG/138DOR6QOocLUUVQzihz2OnTAceaLFr1HxrpOCEhIXUq7Sz9K2tUWf3+s3pF
         Yn4CSj7GEJGo0aL4xGhuiBJl1Mlt380qNjWIyR4VAtmWtmeZjDPI3SaEMJw6s2LqIq2k
         waQ1YSoK7btRpa/MsEWJANU66GEUG+9Rn7/o62JuIYbsZSE22O0vMm79kx55Nddm/xz/
         lGyQ==
X-Gm-Message-State: AOAM532v3D+vdk1NuDPbn25/2jgfE9o5mNGIk2cUGSehzYeZUzOgTEGy
        cz4AgyfhyYwweLD3d4bGb2gjpcH/TLrMag==
X-Google-Smtp-Source: ABdhPJxaLO1AQOJuU6RxOMpqowf2J9Qst+aACmtgs4N+Xo1g44PWJhYAv01x/5eMm+nzuDP/7yHa6w==
X-Received: by 2002:a05:6e02:1250:: with SMTP id j16mr9954610ilq.293.1593641655976;
        Wed, 01 Jul 2020 15:14:15 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id t83sm4051543ilb.47.2020.07.01.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:14:15 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by different programs at once
Date:   Wed,  1 Jul 2020 17:13:53 -0500
Message-Id: <cover.1593638618.git.zhuyifei@google.com>
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
 kernel/bpf/cgroup.c                           |  46 ++--
 kernel/bpf/core.c                             |  12 -
 kernel/bpf/local_storage.c                    |  77 +++---
 tools/include/uapi/linux/bpf.h                |   2 +-
 .../bpf/prog_tests/cg_storage_multi.c         | 242 ++++++++++++++++++
 .../selftests/bpf/progs/cg_storage_multi.h    |  13 +
 .../progs/cg_storage_multi_egress_ingress.c   |  45 ++++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  33 +++
 12 files changed, 497 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/bpf/map_cgroup_storage.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c

-- 
2.27.0

