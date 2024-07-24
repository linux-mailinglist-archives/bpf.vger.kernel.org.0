Return-Path: <bpf+bounces-35567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA81093B947
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564C0B244D3
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C513C9DE;
	Wed, 24 Jul 2024 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd07yyYT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D46F068
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861534; cv=none; b=mTsPU23oS/unCGFUg255DMUAjGLSCgbMT1yTYfI6oBff1B4qme4SM0SHpKXy8Kdda374447Az5tqOE6GOHVxCBlAMqPMvK+gDpKj5EfJuWI4wbxZWlcKNL9fOwtwOUo8bEACxqvuAnCawIWXH3v1wXKLcl+lZExBQmvBpo7v5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861534; c=relaxed/simple;
	bh=XMp6rg0dpcHBxT1oYcemWawXRE/lV7nLw3KEvZZanRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UR7Hl2awyPrXKts7J0zbiPobRqnUSCJ9cIv2PL52bWN/LSOxexyne64BgnRkHQg+WZrcUvshVBH8IIZYVXogjKqGj2jABMptS7rqF0/jbeeEi9pGk177bVZoOgEooLLae5KVwAllcBbi2NLL+7rVuwqtnnfSIHB1+O23mCKeSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd07yyYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6D4C32781;
	Wed, 24 Jul 2024 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861533;
	bh=XMp6rg0dpcHBxT1oYcemWawXRE/lV7nLw3KEvZZanRI=;
	h=From:To:Cc:Subject:Date:From;
	b=Vd07yyYTMdjVyw3Sxjb/zlpxFsCHH0mXooTgwejA7vZbI3DhLxTcSYzMGyD2bRLlG
	 gfhnCAlUMyXzBFBH6rccDXxZPWlOrYBDtbKkH9WZgK+wO9Z/7MGNIW9WkIg8o/Yik1
	 vND1rY31utbmW+8npirM4+CFkFa0taX0eU+nrDBKlbdcsaIm3kgKhOJSpMDbOcyRYg
	 tySrHmZXSER7boPvTq2RnYG2gBWWopR+i5vx+mmi5jg7Syxx/xSF7OaGC7bYm/L8e8
	 BZCYuyHdHyw9lW+fPkzgYUw2MSBRTELYn6JvW8QelTjuZSGds0xvzQsjg5G1QGkJ8w
	 TAue2rqzOp+lQ==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 00/10] Harden and extend ELF build ID parsing logic
Date: Wed, 24 Jul 2024 15:52:00 -0700
Message-ID: <20240724225210.545423-1-andrii@kernel.org>
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

v1->v2:
  - ensure MADV_PAGEOUT works reliably by paging data in first (Shakeel);
  - to fix BPF CI build optionally define MADV_POPULATE_READ in selftest.

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
 tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++
 tools/testing/selftests/bpf/uprobe_multi.ld   |  11 +
 11 files changed, 591 insertions(+), 129 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld

-- 
2.43.0


