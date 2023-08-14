Return-Path: <bpf+bounces-7743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E717C77BEE4
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A079E2810CE
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B09C8F6;
	Mon, 14 Aug 2023 17:28:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C9C2FF
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:28:26 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A5120
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:28:24 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 63F3D24C21F11; Mon, 14 Aug 2023 10:28:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 00/15] Add support for local percpu kptr
Date: Mon, 14 Aug 2023 10:28:09 -0700
Message-Id: <20230814172809.1361446-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch set [1] implemented cgroup local storage BPF_MAP_TYPE_CGRP_STORAGE
similar to sk/task/inode local storage and old BPF_MAP_TYPE_CGROUP_STORAG=
E
map is marked as deprecated since old BPF_MAP_TYPE_CGROUP_STORAGE map can
only work with current cgroup.

Similarly, the existing BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE map
is a percpu version of BPF_MAP_TYPE_CGROUP_STORAGE and only works
with current cgroup. But there is no replacement which can work
with arbitrary cgroup.

This patch set solved this problem but adding support for local
percpu kptr. The map value can have a percpu kptr field which holds
a bpf prog allocated percpu data. The below is an example,

  struct percpu_val_t {
    ... fields ...
  }

  struct map_value_t {
    struct percpu_val_t __percpu *percpu_data_ptr;
  }

In the above, 'map_value_t' is the map value type for a
BPF_MAP_TYPE_CGRP_STORAGE map. User can access 'percpu_data_ptr'
and then read/write percpu data. This covers BPF_MAP_TYPE_PERCPU_CGROUP_S=
TORAGE
and more. So BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE map type
is marked as deprecated.

In additional, local percpu kptr supports the same map type
as other kptrs including hash, lru_hash, array, sk/inode/task/cgrp
local storage. Please for individual patches for details.

  [1] https://lore.kernel.org/all/20221026042835.672317-1-yhs@fb.com/

Yonghong Song (15):
  bpf: Add support for non-fix-size percpu mem allocation
  bpf: Add BPF_KPTR_PERCPU_REF as a field type
  bpf: Add alloc/xchg/direct_access support for local percpu kptr
  bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu
    obj
  selftests/bpf: Update error message in negative linked_list test
  libbpf: Add __percpu macro definition
  selftests/bpf: Add bpf_percpu_obj_{new,drop}() macro in
    bpf_experimental.h
  selftests/bpf: Add tests for array map with local percpu kptr
  bpf: Mark OBJ_RELEASE argument as MEM_RCU when possible
  selftests/bpf: Remove unnecessary direct read of local percpu kptr
  selftests/bpf: Add tests for cgrp_local_storage with local percpu kptr
  bpf: Allow bpf_spin_lock and bpf_list_head in allocated percpu data
    structure
  selftests/bpf: Add tests for percpu struct with bpf list head
  selftests/bpf: Add some negative tests
  bpf: Mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated

 include/linux/bpf.h                           |  25 ++-
 include/linux/bpf_verifier.h                  |   1 +
 include/uapi/linux/bpf.h                      |   9 +-
 kernel/bpf/btf.c                              |   5 +
 kernel/bpf/core.c                             |   8 +-
 kernel/bpf/helpers.c                          |  49 +++++
 kernel/bpf/memalloc.c                         |  14 +-
 kernel/bpf/syscall.c                          |  26 ++-
 kernel/bpf/verifier.c                         | 164 +++++++++++++---
 tools/include/uapi/linux/bpf.h                |   9 +-
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  |  31 +++
 .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 165 ++++++++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  | 183 ++++++++++++++++++
 .../progs/percpu_alloc_cgrp_local_storage.c   | 105 ++++++++++
 .../selftests/bpf/progs/percpu_alloc_fail.c   | 100 ++++++++++
 .../percpu_alloc_nested_special_fields.c      | 121 ++++++++++++
 18 files changed, 958 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_array.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_l=
ocal_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_nested=
_special_fields.c

--=20
2.34.1


