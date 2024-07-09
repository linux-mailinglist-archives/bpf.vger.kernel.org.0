Return-Path: <bpf+bounces-34284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E392C4D7
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BCE2814A7
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1023C187873;
	Tue,  9 Jul 2024 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0h7Wr0Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3CE187861
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557772; cv=none; b=WQoLWQCSMcL6AWdQgp476evUyI1bSg/6/sW1svd0WCBlKO4PkBifw8uFkutrZWkU2/gB1gwYr7eqXMo9x9IAQePkAJvwoU+ks4icJ2pgcm0iuppDZ20h/F4Rokj7vQWlxfYVsQdWIkd8Ha2LDb8uDso3NrR4ZDe8Dnh/WOGLJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557772; c=relaxed/simple;
	bh=vYyrBpzkRZI9HAtJcRaJBlpeRkvBiECfUfa7DYrUBvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMPTy8XOOrqrDZ8R+vPDPBitfkOC/VR6zY2mFi11jLDoGh3f7+W22E6KX8XGib8+xRbz4Tu6OdAp5rOlTtnZfVF73Sw5GvFddC8F3Fn4sntGurT9xToI4G/etjCX7XlJV406cnzPIIw6z7VxyTZI6ghAc1edBb1cVoi6yG3n268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0h7Wr0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E01C4AF15;
	Tue,  9 Jul 2024 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557772;
	bh=vYyrBpzkRZI9HAtJcRaJBlpeRkvBiECfUfa7DYrUBvE=;
	h=From:To:Cc:Subject:Date:From;
	b=p0h7Wr0ZspcYf7uyOIqvWIx3+Z1uuIfeRmYyd4jPvOt2Jk7QYKj72j8umuWslLRwm
	 LKFdVBuTHewNZqNuArgMKU8QqsQOgGC+193UifjFOryAyaNx9GFlxla2eAbViqow7P
	 0MhELdODtpQ+LUXrK7uGmvYI3RdivC1M8f9RDuE0Fw8KwGCQezjg26JyD5CCWI8kEF
	 q7KLgcNWiOb2nA16TO722SSp7C3NHWML9QzfrQTOqj8NVpyIOVRKvx0bRB9OwlEqvg
	 0rsRhBKNIpZ18bXcQddXBG1PIOBuT8jQihh/9qfQd79ApwH2somxykNyjqy64/woIf
	 svZdV2M0NEP1g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 00/10] Harden and extend ELF build ID parsing logic
Date: Tue,  9 Jul 2024 13:42:35 -0700
Message-ID: <20240709204245.3847811-1-andrii@kernel.org>
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

Along the way, we harden the logic to avoid TOCTOU problems. We also lift
existing limitations of only working as long as ELF program headers and build
ID note section is contained strictly within the very first page of ELF file.

We achieve all of the above without duplication of logic between sleepable and
non-sleepable modes through freader abstraction that manages underlying page
cache page (on demand) and giving a simple to use direct memory access
interface. With that, single page restrictions and adding sleepable mode
support is rather straightforward.

We also extend existing set of BPF selftests with a few tests targeting build
ID logic across sleepable and non-sleepabe contexts (we utilize sleepable and
non-sleepable uprobes for that).

   [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-4-andrii@kernel.org/

Andrii Nakryiko (10):
  lib/buildid: add single page-based file reader abstraction
  lib/buildid: take into account e_phoff when fetching program headers
  lib/buildid: remove single-page limit for PHDR search
  lib/buildid: rename build_id_parse() into build_id_parse_nofault()
  lib/buildid: implement sleepable build_id_parse() API
  lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
  lib/buildid: harden build ID parsing logic some more
  bpf: decouple stack_map_get_build_id_offset() from
    perf_callchain_entry
  bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack()
    helpers
  selftests/bpf: add build ID tests

 include/linux/bpf.h                           |   2 +
 include/linux/buildid.h                       |   4 +-
 kernel/bpf/stackmap.c                         | 131 +++++--
 kernel/events/core.c                          |   2 +-
 kernel/trace/bpf_trace.c                      |   5 +-
 lib/buildid.c                                 | 370 +++++++++++++-----
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++
 .../selftests/bpf/progs/test_build_id.c       |  31 ++
 tools/testing/selftests/bpf/uprobe_multi.c    |  34 ++
 tools/testing/selftests/bpf/uprobe_multi.ld   |  11 +
 11 files changed, 584 insertions(+), 129 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld

-- 
2.43.0


