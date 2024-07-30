Return-Path: <bpf+bounces-36083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66FF9421A8
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148351C23E51
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785718CC06;
	Tue, 30 Jul 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9GNZdLc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3041684BE
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371958; cv=none; b=Ta82oOD47KamLwZLjtS2ef2AFd9mobgpWVUNBl6SlxI+/OeP8nwmrKz+obONbbUiiobhQV+5Dov5qemLyodK8Fpd9wGxE1CF3hikwxj2GY4kTQB+myLJ/G29L9tHnsIlj68Oxy1HkI/KbKlpSJo8EMaG+o1TWRtl6xqNRtwx+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371958; c=relaxed/simple;
	bh=mYH2sieZgwgmDgI4KOAA8U1nIcciTpOh3t+Ty3X8b2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hP7XhsCYQR1YuOgEO8hwRLrrVRkNuY7lelpUGwPRXXjEy0C16EoIiPSmRagG6g2OK50j55N9G+VuAHkhF8sDmMdeWpXYkrChItuGapvKXJZzgXNWabRCKkNA+Qglg9iPv3VrBz0L6JYmQ2mOl50xdRF6mcKIeTM7qVNBi9pWhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9GNZdLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AA3C32782;
	Tue, 30 Jul 2024 20:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722371957;
	bh=mYH2sieZgwgmDgI4KOAA8U1nIcciTpOh3t+Ty3X8b2w=;
	h=From:To:Cc:Subject:Date:From;
	b=R9GNZdLcv55TEN8Z6OMDS+kE7DUjIOIRmfflm/RIOO0jsYFB2A6M97kPJXSStthD8
	 CAjFUSnGyTC24LRj/6a/mLzhaW37GDDUR2IptxUzZ3iMUewI1kHpNCoDPWcOoiforJ
	 k5te+PIW6yYF7yebg0d5yTmr34f+3NApAzBMgIAXmRxWU/WoSA++W/iVnN+XHI4QFa
	 9/wvfB18NQral7y/ue8Rh8GlUhr981M4MTS2bc4Niu5qm4FuwtQoq9YUL0OdVDNbCH
	 x7yu+qoTAzrdtfCGl9OmuF2YPQYdSLSB37/5lfJvPbTsI9wkKfeeJJuLcqAJIyD3+h
	 qXhlEdHj4E9WA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	jannh@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 bpf-next 00/10] Harden and extend ELF build ID parsing logic
Date: Tue, 30 Jul 2024 13:39:04 -0700
Message-ID: <20240730203914.1182569-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patch set is to extend existing ELF build ID parsing logic,
currently mostly used by BPF subsystem, with support for working in sleepable
mode in which memory faults are allowed and can be relied upon to fetch
relevant parts of ELF file to find and fetch .note.gnu.build-id information.

This is useful and important for BPF subsystem itself, but also for
PROCMAP_QUERY ioctl(), built atop of /proc/<pid>/maps functionality (see [0]),
which makes use of the same build_id_parse() functionality. PROCMAP_QUERY is
always called from sleepable user process context, so it doesn't have to
suffer from current restrictions of build_id_parse() which are due to the NMI
context assumption.

Along the way, we harden the logic to avoid TOCTOU problems. This is the very
first patch, which can be backported to older releases, if necessary.

We also lift existing limitations of only working as long as ELF program
headers and build ID note section is contained strictly within the very first
page of ELF file.

We achieve all of the above without duplication of logic between sleepable and
non-sleepable modes through freader abstraction that manages underlying page
cache page (on demand) and giving a simple to use direct memory access
interface. With that, single page restrictions and adding sleepable mode
support is rather straightforward.

We also extend existing set of BPF selftests with a few tests targeting build
ID logic across sleepable and non-sleepabe contexts (we utilize sleepable and
non-sleepable uprobes for that).

   [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-4-andrii@kernel.org/

v2->v3:
  - remove unneeded READ_ONCE()s and force phoff to u64 for 32-bit mode (Andi);
  - moved hardening fixes to the front for easier backporting (Jann);
  - call freader_cleanup() from build_id_parse_buf() for consistency (Jiri);
v1->v2:
  - ensure MADV_PAGEOUT works reliably by paging data in first (Shakeel);
  - to fix BPF CI build optionally define MADV_POPULATE_READ in selftest.

Andrii Nakryiko (10):
  lib/buildid: harden build ID parsing logic
  lib/buildid: add single page-based file reader abstraction
  lib/buildid: take into account e_phoff when fetching program headers
  lib/buildid: remove single-page limit for PHDR search
  lib/buildid: rename build_id_parse() into build_id_parse_nofault()
  lib/buildid: implement sleepable build_id_parse() API
  lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
  bpf: decouple stack_map_get_build_id_offset() from
    perf_callchain_entry
  bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack()
    helpers
  selftests/bpf: add build ID tests

 include/linux/bpf.h                           |   2 +
 include/linux/buildid.h                       |   4 +-
 kernel/bpf/stackmap.c                         | 131 ++++--
 kernel/events/core.c                          |   2 +-
 kernel/trace/bpf_trace.c                      |   5 +-
 lib/buildid.c                                 | 385 +++++++++++++-----
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++
 .../selftests/bpf/progs/test_build_id.c       |  31 ++
 tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++
 tools/testing/selftests/bpf/uprobe_multi.ld   |  11 +
 11 files changed, 594 insertions(+), 141 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld

-- 
2.43.0


