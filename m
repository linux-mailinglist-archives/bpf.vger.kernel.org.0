Return-Path: <bpf+bounces-77074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14876CCE107
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E549305935A
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71BD176FB1;
	Fri, 19 Dec 2025 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQVTfrfX"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05017D2;
	Fri, 19 Dec 2025 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766104343; cv=none; b=dB+GemJVFPySVQi8vPIyJYhNM+TpHYWF/pV85J6SBUzMwDRP21FNCfZKoC2p291ejSNTT3dS2spzAv++phm0D8Ck3/v4u1rCUCEo3tzqAWboo6gLcDSLY1hIRTuDMFGDbMDTwpLjAyqxPbXoG1AmBqWp7P9k2Krzie95s+qON1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766104343; c=relaxed/simple;
	bh=/9F8U6krMVz7I8HAc2L42gRERllz5l8PhuoTUHi4uAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCIE9czlRpUgBN4MgwKhAhcM+BRPadeEUAjN5TVDWPNxjL0s0PSvbWq7oGl972WdgTr1Jn21q3q52V8v2SkXE9Pff3CEfGIFx+6Z7tLc7ATVuOf1bd03rDfIZBLQ2pJfe8/l9lahj9M6JFkoLabqXXs64D+eE2taFHtWHW8efI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQVTfrfX; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766104328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3rKyjbF5xMDrEJBv7zRhMTWeZC0Uc25dvwa9mjEsxL8=;
	b=LQVTfrfXuu6QEsex3DxCPpbEUtn/reCiUJUp/xVwg2Rb8zADm6jWo3JfIejj7VEHOP0RUN
	XIecANLTQ+Y9HXVjT/diByT+WpvApwXYucXM/Zrm+iaU2sWFvHEMGERESOUMKlG26B51hW
	4Sl9KSMPgVuKuVoka1mKVcblzdUa5Vo=
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
Subject: [PATCH bpf-next v5 0/8] resolve_btfids: Support for BTF modifications
Date: Thu, 18 Dec 2025 16:31:39 -0800
Message-ID: <20251219003147.587098-1-ihor.solodrai@linux.dev>
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

Successful BPF CI run: https://github.com/kernel-patches/bpf/actions/runs/20353330265

[1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
[2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
[3] https://lore.kernel.org/bpf/20251119031531.1817099-1-dolinux.peng@gmail.com/

---

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

 Documentation/scheduler/sched-ext.rst         |   1 -
 MAINTAINERS                                   |   1 +
 Makefile                                      |   9 +-
 init/Kconfig                                  |   2 +-
 lib/Kconfig.debug                             |  13 +-
 scripts/Makefile.btf                          |  21 +-
 scripts/Makefile.modfinal                     |   5 +-
 scripts/Makefile.vmlinux                      |   2 +-
 scripts/gen-btf.sh                            | 157 ++++++++
 scripts/link-vmlinux.sh                       |  42 +--
 tools/bpf/resolve_btfids/Makefile             |   3 +-
 tools/bpf/resolve_btfids/main.c               | 356 ++++++++++++------
 tools/sched_ext/README.md                     |   1 -
 tools/testing/selftests/bpf/.gitignore        |   3 +
 tools/testing/selftests/bpf/Makefile          |  11 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |   4 +-
 16 files changed, 441 insertions(+), 190 deletions(-)
 create mode 100755 scripts/gen-btf.sh

-- 
2.52.0


