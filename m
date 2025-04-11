Return-Path: <bpf+bounces-55701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C68AA8511E
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 03:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33297B3AFC
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 01:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC7225D6;
	Fri, 11 Apr 2025 01:15:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8141469D
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334140; cv=none; b=lJAJiMltG73JlCcm6pKUcGAQbLZYo6y49i2jukXD2Jt5ksBBU0/ltiuULjDxyfyRezf6mgL9Tcys/+BMMMcU8HWUFz2QUFT7eVafq3poGePvpP9zN55GAQFGzZnAy/JmcdWZ+JNoWvWNNQQVugjnmB0mPOw7RjyQsaxZ1qcQt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334140; c=relaxed/simple;
	bh=tI/jwp1zc3vqgUHBcLEzYXi2iVxZszWUCFmSOsJw+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0b4xI/tFH3jY+IEGaD7zuy15P6gp1sIBdydU6UvX7eOWpSoLINZCbsCLz3xYtvgnKJFQTaMJuynAvoz7fPeFA8JH8vlHLab97aWVSXXs4ZJSr/SvX8X1vZE5XkUvfb01sUZzUCEN7XAALyRqxDzfezkNHu4WZk6frGn1s9scmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CBE2C514902F; Thu, 10 Apr 2025 18:15:23 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 0/4] bpf: Implement mprog API on top of existing cgroup progs
Date: Thu, 10 Apr 2025 18:15:23 -0700
Message-ID: <20250411011523.1838771-1-yonghong.song@linux.dev>
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
Using bpftrainer is a centralized approach and is not desirable as
one of applications acts as a deamon. The decentralized attachment
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

Yonghong Song (4):
  cgroup: Add bpf prog revisions to struct cgroup_bpf
  bpf: Implement mprog API on top of existing cgroup progs
  libbpf: Support link-based cgroup attach with options
  selftests/bpf: Add two selftests for mprog API based cgroup progs

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/cgroup.c                           | 151 +++-
 kernel/bpf/syscall.c                          |  58 +-
 kernel/cgroup/cgroup.c                        |   5 +-
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  44 +
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.c                        |  28 +
 tools/lib/bpf/libbpf.h                        |  15 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/cgroup_mprog_opts.c        | 752 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_mprog_ordering.c    |  77 ++
 .../selftests/bpf/progs/cgroup_mprog.c        |  30 +
 14 files changed, 1138 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
pts.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
rdering.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_mprog.c

--=20
2.47.1


