Return-Path: <bpf+bounces-77178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B879CD193D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 20:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F643304D494
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC534E75B;
	Fri, 19 Dec 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pi5swshZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910E342C9E
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168043; cv=none; b=pZp0hCTk/FriiTKO8EgLSgrUNYjhYguLEC+jijCCAggH1TpNnksEgjci4ri545VXC3/MoPFZKukFXN4zOghCaEyM+DAFN0bar9vUMj1mNSCjknudTkinsZ8PHxh09Aq2Xcm3VoIg8jP8EkUNGjqyjOmZJgW9j3+WknCmBM6aJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168043; c=relaxed/simple;
	bh=f/9WlNlDvz+RKHyGglF9xjnqFIM7fG1mPMblYNc71Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0hF+MYXuxvHvAjNKvaPiLg4QA2DHHdDQ7CwdW2Nt+UNKTogsysrCaaITImpLBx1LsfMNB/lCeq1x43iQhrmIehcSPHIHqLt9nK2gguJQ4/zIfmnzqy6gtN65lvUXqXqMyYYqNWF0d/k/BNUcspadXq1MK1UDs5qxtp5Ms8sW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pi5swshZ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766168027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g55rWkJhqcFv/045X8ZtuPxRw3uqQmw2iX5kyd0Ox7A=;
	b=Pi5swshZeWnVNqAAVpLb3YZ3HVInI3m4X1vguYx1rowuoBCy7K5Pt8Dl2rHE7CEi4xQYd/
	+oaoZk32YDnx5mN2SSypcAVEnfggLKi60njoA0SZMN8c/XKDQ7Aj9K15u4esyavO+XyRy/
	YqpRa1Xpgwn9Gl7SY+Vx1I3K9sLQBHE=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v7 0/8] resolve_btfids: Support for BTF modifications
Date: Fri, 19 Dec 2025 10:13:13 -0800
Message-ID: <20251219181321.1283664-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series changes resolve_btfids and kernel build scripts to enable
BTF transformations in resolve_btfids. Main motivation for enhancing
resolve_btfids is to reduce dependency of the kernel build on pahole
capabilities [1] and enable BTF features and optimizations [2][3]
particular to the kernel.

Patches #1-#4 in the series are non-functional changes in
resolve_btfids.

Patch #5 makes kernel build notice pahole version changes between
builds.

Patch #6 changes minimum version of pahole required for
CONFIG_DEBUG_INFO_BTF to v1.22

Patch #7 makes a small prep change in selftests/bpf build.

The last patch (#8) makes significant changes in resolve_btfids and
introduces scripts/gen-btf.sh. See implementation details in the patch
description.

Successful BPF CI run: https://github.com/kernel-patches/bpf/actions/runs/20378061470

[1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
[2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
[3] https://lore.kernel.org/bpf/20251119031531.1817099-1-dolinux.peng@gmail.com/

---

v6->v7:
  - documentation edits in patches #5 and #6 (Nicolas)

v6: https://lore.kernel.org/bpf/20251219020006.785065-1-ihor.solodrai@linux.dev/

v5->v6:
  - patch #8: fix double free when btf__distill_base fails (reported by AI)
    https://lore.kernel.org/bpf/e269870b8db409800045ee0061fc02d21721e0efadd99ca83960b48f8db7b3f3@mail.kernel.org/

v5: https://lore.kernel.org/bpf/20251219003147.587098-1-ihor.solodrai@linux.dev/

v4->v5:
  - patch #3: fix an off-by-one bug (reported by AI)
    https://lore.kernel.org/bpf/106b6e71bce75b8f12a85f2f99e75129e67af7287f6d81fa912589ece14044f9@mail.kernel.org/
  - patch #8: cleanup GEN_BTF in Makefile.btf

v4: https://lore.kernel.org/bpf/20251218003314.260269-1-ihor.solodrai@linux.dev/

v3->v4:
  - add patch #4: "resolve_btfids: Always build with -Wall -Werror"
  - add patch #5: "kbuild: Sync kconfig when PAHOLE_VERSION changes" (Alan)
  - fix clang cross-compilation (LKP)
    https://lore.kernel.org/bpf/cecb6351-ea9a-4f8a-863a-82c9ef02f012@linux.dev/
  - remove GEN_BTF env variable (Andrii)
  - nits and cleanup in resolve_btfids/main.c (Andrii, Eduard)
  - nits in a patch bumping minimum pahole version (Andrii, AI)

v3: https://lore.kernel.org/bpf/20251205223046.4155870-1-ihor.solodrai@linux.dev/

v2->v3:
  - add patch #4 bumping minimum pahole version (Andrii, Alan)
  - add patch #5 pre-fixing resolve_btfids test (Donglin)
  - add GEN_BTF var and assemble RESOLVE_BTFIDS_FLAGS in Makefile.btf (Alan)
  - implement --distill_base flag in resolve_btfids, set it depending
    on KBUILD_EXTMOD in Makefile.btf (Eduard)
  - various implementation nits, see the v2 thread for details (Andrii, Eduard)

v2: https://lore.kernel.org/bpf/20251127185242.3954132-1-ihor.solodrai@linux.dev/

v1->v2:
  - gen-btf.sh and other shell script fixes (Donglin)
  - update selftests build (Donglin)
  - generate .BTF.base only when KBUILD_EXTMOD is set (Alan)
  - proper endianness handling for cross-compilation
  - change elf_begin mode from ELF_C_RDWR_MMAP to ELF_C_READ_MMAP_PRIVATE
  - remove compressed_section_fix()
  - nit NULL check in patch #3 (suggested by AI)

v1: https://lore.kernel.org/bpf/20251126012656.3546071-1-ihor.solodrai@linux.dev/

Ihor Solodrai (8):
  resolve_btfids: Rename object btf field to btf_path
  resolve_btfids: Factor out load_btf()
  resolve_btfids: Introduce enum btf_id_kind
  resolve_btfids: Always build with -Wall -Werror
  kbuild: Sync kconfig when PAHOLE_VERSION changes
  lib/Kconfig.debug: Set the minimum required pahole version to v1.22
  selftests/bpf: Run resolve_btfids only for relevant .test.o objects
  resolve_btfids: Change in-place update with raw binary output

 Documentation/process/changes.rst             |   4 +-
 Documentation/scheduler/sched-ext.rst         |   1 -
 MAINTAINERS                                   |   1 +
 Makefile                                      |  15 +-
 init/Kconfig                                  |   2 +-
 lib/Kconfig.debug                             |  13 +-
 scripts/Makefile.btf                          |  21 +-
 scripts/Makefile.modfinal                     |   5 +-
 scripts/Makefile.vmlinux                      |   2 +-
 scripts/gen-btf.sh                            | 157 ++++++++
 scripts/link-vmlinux.sh                       |  42 +-
 tools/bpf/resolve_btfids/Makefile             |   3 +-
 tools/bpf/resolve_btfids/main.c               | 358 ++++++++++++------
 tools/sched_ext/README.md                     |   1 -
 tools/testing/selftests/bpf/.gitignore        |   3 +
 tools/testing/selftests/bpf/Makefile          |  11 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |   4 +-
 17 files changed, 448 insertions(+), 195 deletions(-)
 create mode 100755 scripts/gen-btf.sh

-- 
2.52.0


