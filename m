Return-Path: <bpf+bounces-58451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C29ABAB18
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49749E3339
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EF320ADCF;
	Sat, 17 May 2025 16:27:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD7205E02
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499257; cv=none; b=AB+uH3V02wv89PZfuQBVy0D9JdEFpXTmP8PEA2T8tkzf8WtWQ9NLv0DAxBzlPYjl4hePeqmnZA+Zy7iClcqJIzVFc8RRWMeRaP1icq6lY7mjaK0Ks59FFoIXGmGa7ymcL/Doeyu10ePmDaIMcjmLM0XAG+VkCsN84DoD30WaP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499257; c=relaxed/simple;
	bh=Rk/IfZ+YCOMaiyBLdsCYoj58WsoVVPrRaXpWrzwoUhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPFBw4POXfk6QFx/QvTPNKynn5wdXqxOVhP3smSx42c6V1s3G66Eq7hvqddyef4UuVEUG0xsoUKwWY+shUP944bMrkUCVkZm76rzsOA4UCZQk2CAFyO16rrCHRB6BHq4nc/6plmcwtsZ3Q0i4Jrm0maluQFqVkRpLrcV5uzAIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 06A867A25952; Sat, 17 May 2025 09:27:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/5] bpf: Implement mprog API on top of existing cgroup progs
Date: Sat, 17 May 2025 09:27:20 -0700
Message-ID: <20250517162720.4077882-1-yonghong.song@linux.dev>
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

The patch set contains 5 patches. Patch 1 adds revision support for
cgroup bpf progs. Patch 2 implements mprog API implementation for
prog/link attach and revision update. Patch 3 adds a new libbpf
API to do cgroup link attach with flags like BPF_F_BEFORE/BPF_F_AFTER.
Patches 4 and 5 add two tests to validate the implementation.

  [1] https://lore.kernel.org/r/20250224230116.283071-1-yonghong.song@lin=
ux.dev
  [2] https://lore.kernel.org/r/20230719140858.13224-2-daniel@iogearbox.n=
et

Changelogs:
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20250508223524.487875-1-yonghong.so=
ng@linux.dev/
    - Big change to replace get_anchor_prog() to get_prog_list() so the
      'struct bpf_prog_list *' is returned directly.
    - Support 'BPF_F_BEFORE | BPF_F_AFTER' attachment if the prog list is=
 empty
      and flags do not have 'BPF_F_LINK | BPF_F_ID' and id_or_fd is 0.
    - Add BPF_F_LINK support.
    - Patch 4 is added to reuse id_from_prog_fd() and id_from_link_fd().
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

Yonghong Song (5):
  cgroup: Add bpf prog revisions to struct cgroup_bpf
  bpf: Implement mprog API on top of existing cgroup progs
  libbpf: Support link-based cgroup attach with options
  selftests/bpf: Move some tc_helpers.h functions to test_progs.h
  selftests/bpf: Add two selftests for mprog API based cgroup progs

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/cgroup.c                           | 195 ++++-
 kernel/bpf/syscall.c                          |  43 +-
 kernel/cgroup/cgroup.c                        |   5 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  44 +
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.c                        |  28 +
 tools/lib/bpf/libbpf.h                        |  15 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/cgroup_mprog_opts.c        | 749 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_mprog_ordering.c    |  77 ++
 .../selftests/bpf/prog_tests/tc_helpers.h     |  28 -
 .../selftests/bpf/progs/cgroup_mprog.c        |  30 +
 tools/testing/selftests/bpf/test_progs.h      |  28 +
 16 files changed, 1197 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
pts.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
rdering.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_mprog.c

--=20
2.47.1


