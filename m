Return-Path: <bpf+bounces-77104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790ECCE38D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CBF0306AE1E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ABD284674;
	Fri, 19 Dec 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gI98l/io"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912EC28000B
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109639; cv=none; b=HSQQDDgec+4W3F3g/3vI4jxeY458ms1i+FPkH0WTcGcpIlK/dlBZBHXzY4D+cIN1FkEDwoOJiw76ELwj8vIPCIDxLYy5f/rrWuyI441Ko+oLPvGI2nzr5NATx+U3RIVnAYTr3mcWTcu0TUkhKVKp0MubWhfRGhJXTjKcPDorhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109639; c=relaxed/simple;
	bh=+L8/Od1GmtQad3hgduaEBm5cAGozldSw8UtRlHqykdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVtqwdbXPOFZxmSdE0n51IjXCDR383y3BCOB4HNVjsHhFg/vblCKpK8/BKveSH3KJ2yyQa54kzSWNPy12wJo+OtPgFgiSk1+Sl2QV6Tutb0/N2QFi2aX0tuI/PYd9GBfk4/da5TC8aEeoWHNp/SvxgqaXSt1YSrLuUpW3ft4d8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gI98l/io; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766109624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+HZQh2xoesiaxye5wqm6/BBkSDuC7ggMw3RMptLyUQ0=;
	b=gI98l/ioibZHrwQoytali7SeYokmhOiUKnZSF9Q5etLNhB3cWFTUcIni27u8gLQs8JG/72
	ePV/P2V1m53EMQ7w9O4xENJ+ClzVEapHh/6YP1lRKbtMmWEevxrTLYAhXXjWYqrhg8/C4c
	kkqp5dkEX3FIJb2ChnlBfo9/ZtmPx1I=
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
Subject: [PATCH bpf-next v6 0/8] resolve_btfids: Support for BTF modifications
Date: Thu, 18 Dec 2025 17:59:58 -0800
Message-ID: <20251219020006.785065-1-ihor.solodrai@linux.dev>
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

 Documentation/scheduler/sched-ext.rst         |   1 -
 MAINTAINERS                                   |   1 +
 Makefile                                      |   9 +-
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
 16 files changed, 443 insertions(+), 190 deletions(-)
 create mode 100755 scripts/gen-btf.sh

-- 
2.52.0


