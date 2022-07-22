Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496957E543
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiGVRTF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbiGVRTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:19:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38194624B2
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:19:00 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGJF5Q2Jz67W0D;
        Sat, 23 Jul 2022 01:14:21 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:18:56 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 00/15] bpf: Per-operation map permissions
Date:   Fri, 22 Jul 2022 19:18:21 +0200
Message-ID: <20220722171836.2852247-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the bpf_map security hook, an eBPF program is able to restrict access
to a map. For example, it might allow only read accesses and deny write
accesses.

Unfortunately, libbpf and bpftool don't specify permissions accurately.
Regardless of the operation, they always request read-write permissions. As
a consequence, even if they request a read-like operation, such as a map
lookup, that operation unexpectedly fails even if the eBPF program allows
it.

Even worse, since search operations also request read-write permissions,
the iteration stops when a write-protected map is encountered, making the
other maps inaccessible even if operations on them are allowed.

At low level, the problem is that libbpf and bpftool always set open_flags
and file_flags to zero, when they request a file descriptor for a map.
Unfortunately, the kernel translates this into a request with read-write
permissions. open_flags and file_flags can be set for example to
BPF_F_RDONLY or BPF_F_WRONLY respectively for read-like and write-like
permissions.

Which permissions should be requested depends on the type of operation
performed. For example, map lookup or show are clearly read-like
operations. This can be also seen in the kernel: map_lookup_elem(), first
gets the permissions from the file descriptor and then checks if the
FMODE_CAN_READ flag is set. If yes, map_lookup_elem() continues its
execution.

The goal of this patch set is to propagate the needed permissions from the
implementation of the bpftool subcommands, where the exact permissions can
be determined, down to libbpf and ultimately to the kernel.

To ensure that permissions can be specified for every bpftool operation,
changes are implemented bottom-up. First, libbpf is extended with an _opts
variant for each bpf_*_get_fd_by_id() function, and for bpf_obj_get(). The
original version of those functions is kept for compatibility reasons.

Second, functions in bpftool that directly called the original version now
call the _opts variant, and are modified by introducing a new opts
parameter to propagate it to the callers. This process is repeated until
reaching the leaf, the implementation of the bpftool subcommand where
finally the correct permissions can be set.

One exception to the propagation is made for map search operations. In this
case, the operation is clearly read-like, so the permission requested is
always read-only, regardless of what the caller passed. If the caller
requested additional permissions, and there is a match in the search, a new
file descriptor with needed permissions is obtained.

The _opts variants also accept NULL as argument. In this case, open_flags
and file_flags will be still set to zero as before this patch set. This
makes it possible to select the operations for which we would like to set
permissions more precisely, and leave the rest as it is.

This patch set has been tested by developing a small eBPF program that
introduces three maps: one with read-only access (data_input), one with
read-write access (data_input_w), and finally one for perf-related tests
(data_input_perf).

The test checks the _opts variants introduced in libbpf, and also the
modifications done to bpftool. The test ensures that operations succeeds
when the correct permissions are specified, and also ensures that the
operations cannot be done when insufficient permissions were requested.
Finally, the test ensures that the search operation works as expected,
that it is not blocked on write-protected maps.

This patch set does not fix the case of read-protected maps
(confidentiality use case). Since search requires the read permission,
iteration will stop as per the current behavior. A way to fix that could
be to introduce a new eBPF command, BPF_OBJ_GET_INFO_BY_ID, which could
call the bpf_map security hook with O_ACCESS open flags. LSMs could then
be aware that this is a request for attributes, and not a read of map data,
and enforce policies with finer granularity.

The patch set is organized as follows.

Patch 1 allows users to build bpftool with static libraries, for increased
portability of the binary, especially for testing.

Patch 2 sets open_flags as last field for bpf_*_get_fd_by_id(), except for
bpf_map_get_fd_by_id() for which that field is already set.

Patches 3-7 introduce the _opts variant for the bpf_*_get_fd_by_id() and
bpf_obj_get() functions.

Patches 8-13 propagate the bpf_get_fd_opts structure from libbpf to the
bpftool subcommand implementation and map search, and complete the switch
to the new libbpf functions.

Patch 14 adjusts permissions for map operations depending on the operation
type.

Finally, patch 15 adds a test to verify the correctness of permissions
requested.

As future work, permissions can be set for other eBPF objects as well, such
as progs and links, as soon as the kernel supports access control on them.

Changelog

v2:
  - Add a new parameter to each bpf_*_get_fd_by_id_opts() function, for
    symmetry (suggested by Andrii)
  - Always call the _opts variant of bpf_*_get_fd_by_id() and bpf_obj_get()
    in bpftool
  - Replace flags parameter with opts (suggested by Andrii)
  - Set open_flags as last field of bpf_prog_by_id(),
    bpf_btf_get_fd_by_id() and bpf_link_get_fd_by_id() in the kernel
  - Add open_flags kernel feature autodetection
  - Directly set the bpftool command line in the test without using
    snprintf() (suggested by Andrii)
  - Request write-only permission for update and delete map operations
  - Request read-only permission for pinning maps, and for retrieving the
    file descriptor of the inner map in map of maps
  - Add patch to build bpftool with static libraries
  - Add more tests: map of maps, perf, iterator

v1:
  - Define per-operation permissions rather than retrying access with
    read-only permission (suggested by Daniel)
    https://lore.kernel.org/bpf/20220530084514.10170-1-roberto.sassu@huawei.com/

Roberto Sassu (15):
  bpftool: Attempt to link static libraries
  bpf: Set open_flags as last bpf_attr field for bpf_*_get_fd_by_id()
    funcs
  libbpf: Introduce bpf_prog_get_fd_by_id_opts()
  libbpf: Introduce bpf_map_get_fd_by_id_opts()
  libbpf: Introduce bpf_btf_get_fd_by_id_opts()
  libbpf: Introduce bpf_link_get_fd_by_id_opts()
  libbpf: Introduce bpf_obj_get_opts()
  bpftool: Add opts parameter to open_obj_pinned_any() and
    open_obj_pinned()
  bpftool: Add opts parameter to *_parse_fd() functions
  bpftool: Add opts parameter to *_parse_fds()
  bpftool: Add opts parameter to map_parse_fd_and_info()
  bpftool: Add opts parameter in struct_ops functions
  bpftool: Complete switch to bpf_*_get_fd_by_id_opts()
  bpftool: Adjust map permissions
  selftests/bpf: Add map access tests

 kernel/bpf/syscall.c                          |   6 +-
 tools/bpf/bpftool/Makefile                    |  22 +++
 tools/bpf/bpftool/btf.c                       |  27 ++-
 tools/bpf/bpftool/btf_dumper.c                |   2 +-
 tools/bpf/bpftool/cgroup.c                    |   8 +-
 tools/bpf/bpftool/common.c                    |  85 +++++---
 tools/bpf/bpftool/iter.c                      |   6 +-
 tools/bpf/bpftool/link.c                      |  15 +-
 tools/bpf/bpftool/main.h                      |  25 ++-
 tools/bpf/bpftool/map.c                       |  56 ++++--
 tools/bpf/bpftool/map_perf_ring.c             |   7 +-
 tools/bpf/bpftool/net.c                       |   2 +-
 tools/bpf/bpftool/prog.c                      |  22 ++-
 tools/bpf/bpftool/struct_ops.c                |  55 ++++--
 tools/lib/bpf/bpf.c                           |  87 +++++++-
 tools/lib/bpf/bpf.h                           |  19 ++
 tools/lib/bpf/libbpf.c                        |   4 +
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_internal.h               |   3 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../bpf/prog_tests/map_check_access.c         | 186 ++++++++++++++++++
 .../bpf/progs/test_map_check_access.c         | 112 +++++++++++
 22 files changed, 657 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_check_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_check_access.c

-- 
2.25.1

