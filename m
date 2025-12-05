Return-Path: <bpf+bounces-76182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B887CA97FC
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 23:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 191863177CB1
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD92E7635;
	Fri,  5 Dec 2025 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p90w8aGW"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE72E7F0B
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764973907; cv=none; b=RrGwo9TgorWqIFnQgfepV9cEivf6f0XD12Til2M/fNJTXoR67ewe8+qTF9Y/Op1MMEr+wLU9qxF++SR8FbSAehvOn2wfskTZd51h2OADBi1PWQvzgRqfk5x3a2feJ94WShS5FAay57N1mD0pok/9FuwRwkGTq843v5vECcgFonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764973907; c=relaxed/simple;
	bh=ZNqm7oHIZbNL752IYqIC32qC+PVXZwaW3tAgaYNsH2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRhUDfEZujPcPembipgsiBmflMCSHsgJ5rDHlVm9K+4BCEBCuot3FUDLVD4B5Waly1tsL1cRKOgEIG21NphQKBsJAtowLxe5GABoVK5G+8+d/gUsDdOn2F+p+LRCcHHvhd+U5HYhF0IsjoRaNIipkPRoROuxkWXLGmtRtHEZ9vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p90w8aGW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764973893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tpWED5TFtlhM0TqckEPc2BmxoqJxSKCvf8fdQQdyKV4=;
	b=p90w8aGWjcp2z9/esRxRjw5wqxqhbtTTAMrOfvahYCiHPJyjXTFLBoYIgJwcd1nam5kIqF
	x9oC6ZE0Nb8kupmRIoYugHk5y/rhyMCAeyqR5WtPojQYf2yGObdnb5ko6fI75mtRFi7Nh5
	Exil4VcGkFdtc4wQji16ZRtF7xjmOFI=
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
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v3 0/6] resolve_btfids: Support for BTF modifications
Date: Fri,  5 Dec 2025 14:30:40 -0800
Message-ID: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
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

Patches #1-#3 in the series are non-functional refactoring in
resolve_btfids.

Patch #4 changes minimum version of pahole required for
CONFIG_DEBUG_INFO_BTF to v1.22

Patch #5 makes a small prep change in selftests/bpf build.

The last patch (#6) makes significant changes in resolve_btfids and
introduces scripts/gen-btf.sh. See implementation details in the patch
description.

Successful CI run: https://github.com/kernel-patches/bpf/actions/runs/19976024062?pr=10438

[1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
[2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
[3] https://lore.kernel.org/bpf/20251119031531.1817099-1-dolinux.peng@gmail.com/

---

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

Ihor Solodrai (6):
  resolve_btfids: Rename object btf field to btf_path
  resolve_btfids: Factor out load_btf()
  resolve_btfids: Introduce enum btf_id_kind
  lib/Kconfig.debug: Set the minimum required pahole version to v1.22
  selftests/bpf: Run resolve_btfids only for relevant .test.o objects
  resolve_btfids: change in-place update with raw binary output

 MAINTAINERS                                   |   1 +
 lib/Kconfig.debug                             |  13 +-
 scripts/Makefile.btf                          |  26 +-
 scripts/Makefile.modfinal                     |   5 +-
 scripts/Makefile.vmlinux                      |   2 +-
 scripts/gen-btf.sh                            | 157 ++++++++
 scripts/link-vmlinux.sh                       |  46 +--
 tools/bpf/resolve_btfids/main.c               | 355 ++++++++++++------
 tools/sched_ext/README.md                     |   1 -
 tools/testing/selftests/bpf/.gitignore        |   3 +
 tools/testing/selftests/bpf/Makefile          |  11 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |   4 +-
 12 files changed, 434 insertions(+), 190 deletions(-)
 create mode 100755 scripts/gen-btf.sh

-- 
2.52.0


