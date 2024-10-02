Return-Path: <bpf+bounces-40743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D7B98CD6D
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AFD28626C
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 06:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C2E146A86;
	Wed,  2 Oct 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnrpS7VG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA92F34;
	Wed,  2 Oct 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852098; cv=none; b=j75rxEdMZBONrkC9WMJq5btxsmyO67JF48SuQHrboDaOjP0WDO1aGLRARxFdn2DRpq+FP+BTKqYZ/Q4sm2ROo/w0xffb9eoCqfEr0GwgGcKlrGl3YzySf6ZdXrwrdYnqrGBbvCdgodM0obo45il7NhuxmTa6Yg0Way6soqjuGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852098; c=relaxed/simple;
	bh=ikD39xTNdK1VPFn+b9rmFZukD7yDctdhfRaFL9vvfSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVK+0raPKvtgBsbd3mXvTvrCnSpLCQ2FZx2Mqn3QKZzcifanVxGq3YmvYhfy7wPHm4moCCM/T6kQb88HoGQwcFsOel7IEadTY0+V5zTL66K18JNn3oICgUAQgt1tN1ZBIjlPl9F3kuoNt8LXat1yDZMh4L4VT9YOug1Euu7LKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnrpS7VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA26C4CEC5;
	Wed,  2 Oct 2024 06:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727852098;
	bh=ikD39xTNdK1VPFn+b9rmFZukD7yDctdhfRaFL9vvfSI=;
	h=From:To:Cc:Subject:Date:From;
	b=cnrpS7VGnmvG/4KZpDiB9fb65Tzxt2vVukuCUEeV9RoTxMgqZ14jQpjTlxG3e/lR3
	 6Qwo9CPncVy4LKXq34pt3A8nt0Ge/KLoZYtfXsPXwuKImbCw0rtqszcsYCzYSVkXDI
	 k8O89gKWHdEITW4akKeMJJywZ/1zkP3RFCRtIg/LnPpmmh+DqrCLJTwYvapeUODaPU
	 noSjA9/gw6+dcA45pyNizHifqg6orWWVEHlO1ehFRQKAX84u2BEwmUTckS4WCoyv6O
	 ZJkhMWZ8vLyFm/yq7If+hk0Pz4+USYnn5mJ7JgPmfsueCWWRilqIoyK+cKVFp0ilc4
	 srq2PzqcIFJXQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v3 bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc
Date: Tue,  1 Oct 2024 23:54:53 -0700
Message-ID: <20241002065456.1580143-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm proposing a new iterator and a kfunc for the slab memory allocator
to get information of each kmem_cache like in /proc/slabinfo or
/sys/kernel/slab in more flexible way.

v3 changes)

 * rework kmem_cache_iter not to hold slab_mutex when running BPF  (Alexei)
 * add virt_addr_valid() check  (Alexei)
 * fix random test failure by running test with the current task  (Hyeonggon)

v2: https://lore.kernel.org/lkml/20240927184133.968283-1-namhyung@kernel.org/

 * rename it to "kmem_cache_iter"
 * fix a build issue
 * add Acked-by's from Roman and Vlastimil (Thanks!)
 * add error codes in the test for debugging

v1: https://lore.kernel.org/lkml/20240925223023.735947-1-namhyung@kernel.org/

My use case is `perf lock contention` tool which shows contended locks
but many of them are not global locks and don't have symbols.  If it
can tranlate the address of the lock in a slab object to the name of
the slab, it'd be much more useful.

I'm not aware of type information in slab yet, but I was told there's
a work to associate BTF ID with it.  It'd be definitely helpful to my
use case.  Probably we need another kfunc to get the start address of
the object or the offset in the object from an address if the type
info is available.  But I want to start with a simple thing first.

The kmem_cache_iter iterates kmem_cache objects under slab_mutex and
will be useful for userspace to prepare some work for specific slabs
like setting up filters in advance.  And the bpf_get_kmem_cache()
kfunc will return a pointer to a slab from the address of a lock.  And
the test code is to read from the iterator and make sure it finds a
slab cache of the task_struct for the current task.

The code is available at 'bpf/slab-iter-v3' branch in
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (3):
  bpf: Add kmem_cache iterator
  mm/bpf: Add bpf_get_kmem_cache() kfunc
  selftests/bpf: Add a test for kmem_cache_iter

 include/linux/btf_ids.h                       |   1 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/kmem_cache_iter.c                  | 165 ++++++++++++++++++
 mm/slab_common.c                              |  19 ++
 .../bpf/prog_tests/kmem_cache_iter.c          |  64 +++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../selftests/bpf/progs/kmem_cache_iter.c     |  66 +++++++
 8 files changed, 324 insertions(+)
 create mode 100644 kernel/bpf/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_iter.c


base-commit: 9502a7de5a61bec3bda841a830560c5d6d40ecac
-- 
2.46.1.824.gd892dcdcdd-goog


