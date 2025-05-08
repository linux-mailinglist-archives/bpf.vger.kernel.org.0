Return-Path: <bpf+bounces-57808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D864AB05FE
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE8A3BC79C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60116224AF2;
	Thu,  8 May 2025 22:35:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EBE24B28
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743740; cv=none; b=ATt6DN1HItxFQXbkltWfgpZpAJDt3jhaF1STHzNOQVn9d/JkQZL/LiYV9K7dixEMzTCwXyks4rXMT56h2F5F16Bg9WmKgaDhat67HHRKcGEadg052NvwsN4GayJ9YSQ9RJeSJusFxXnCKbwZ31GlUB0FS2qRMoOzMj5E/2qZe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743740; c=relaxed/simple;
	bh=20pTxcgjOkKiPiT7gW3UetRQbzU/AqVD6qXVGkqm9LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHNg8v5Ijc1u0n8mvunImEvlQBInXK+Z/LagqGLJO6lzQEwtkqVDSyB35IVVgnBzseO/f83MHwccpEqphwYVihF6h1zRo0ZL48XIqqLjZivzz+lsMLzh65TRgxf9lHycX8uIkchdscHxYmMtSiufoleog8MXZo3wULh0PbvWQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 33810722317F; Thu,  8 May 2025 15:35:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/4] bpf: Implement mprog API on top of existing cgroup progs
Date: Thu,  8 May 2025 15:35:24 -0700
Message-ID: <20250508223524.487875-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current cgroup prog ordering is appending at attachment time. This is not
ideal. In some cases, users want specific ordering at a particular cgroup
level. For example, in Meta, we have a case where three different
applications all have cgroup/setsockopt progs and they require specific
ordering. Current approach is to use a bpfchainer where one bpf prog
contains multiple global functions and each global function can be
freplaced by a prog for a specific application. The ordering of global
functions decides the ordering of those application specific bpf progs.
Using bpfchainer is a centralized approach and is not desirable as
one of applications acts as a daemon. The decentralized attachment
approach is more favorable for those applications.

To address this, the existing mprog API ([2]) seems an ideal solution wit=
h
supporting BPF_F_BEFORE and BPF_F_AFTER flags on top of existing cgroup
bpf implementation. More specifically, the support is added for prog/link
attachment with BPF_F_BEFORE and BPF_F_AFTER. The kernel mprog
interface ([2]) is not used and the implementation is directly done in
cgroup bpf code base. The mprog 'revision' is also implemented in
attach/detach/replace, so users can query revision number to check the
change of cgroup prog list.

The patch set contains 4 patches. Patch 1 adds revision support for
cgroup bpf progs. Patch 2 implements mprog API implementation for
prog/link attach and revision update. Patch 3 adds a new libbpf
API to do cgroup link attach with flags like BPF_F_BEFORE/BPF_F_AFTER.
Patch 4 adds two tests to validate the implementation.

  [1] https://lore.kernel.org/r/20250224230116.283071-1-yonghong.song@lin=
ux.dev
  [2] https://lore.kernel.org/r/20230719140858.13224-2-daniel@iogearbox.n=
et

Changelogs:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250411011523.1838771-1-yonghong.s=
ong@linux.dev/
    - Change cgroup_bpf.revisions from atomic64_t to u64.
    - Added missing bpf_prog_put in various places.
    - Rename get_cmp_prog() to get_anchor_prog(). The implementation trie=
s to
      find the anchor prog regardless of whether id_or_fd is non-NULL or =
not.
    - Rename bpf_cgroup_prog_attached() to is_cgroup_prog_type() and hand=
le
      BPF_PROG_TYPE_LSM properly (with BPF_LSM_CGROUP attach type).
    - I kept 'id || id_or_fd' condition as the condition 'id' is also use=
d
      in mprog.c so I assume it is okay in cgroup.c as well.

Yonghong Song (4):
  cgroup: Add bpf prog revisions to struct cgroup_bpf
  bpf: Implement mprog API on top of existing cgroup progs
  libbpf: Support link-based cgroup attach with options
  selftests/bpf: Add two selftests for mprog API based cgroup progs

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/cgroup.c                           | 144 +++-
 kernel/bpf/syscall.c                          |  44 +-
 kernel/cgroup/cgroup.c                        |   5 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  44 +
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.c                        |  28 +
 tools/lib/bpf/libbpf.h                        |  15 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/cgroup_mprog_opts.c        | 752 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_mprog_ordering.c    |  77 ++
 .../selftests/bpf/progs/cgroup_mprog.c        |  30 +
 14 files changed, 1123 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
pts.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
rdering.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_mprog.c

--=20
2.47.1


