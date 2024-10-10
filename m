Return-Path: <bpf+bounces-41664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 977429995B8
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328CEB2439B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0C61E6DD4;
	Thu, 10 Oct 2024 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giVnXvp+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B663D;
	Thu, 10 Oct 2024 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728602707; cv=none; b=uDnXUOJ7Ti+7TE6z55VGZ7Vi81C2tZO2KgfE/0A3NsbkugmKxOsMuLmEp5uZnkZnJsxFBF+sQDlVhdjFwpF8zO8QtsgFzm2G+bKJ18UjjbWJPhvfgjgF6U+lVpLxQGGCGunBlsMkKVfyw/At3AEZvClOwoML396114UIbH7BpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728602707; c=relaxed/simple;
	bh=SkeUhfgqXNji7w4xxQutN92ENbwE2DcNcHbbwYFp+6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtHaQ5Q8S004M++ThvrDDC1tdMrrja0doDU9/hevCewFpfjIVStoYHjNTfjH75mSGDFU64mTMfrlxET4A2+hmvdaiXxUmXmjMN6iMvgmNOoozeokBcB8xbGMQR2mSZsQxBEfcR+3PwaLbcLCG0xskvpMWop6zanqcEQY7/zjSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giVnXvp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3C1C4CEC5;
	Thu, 10 Oct 2024 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728602707;
	bh=SkeUhfgqXNji7w4xxQutN92ENbwE2DcNcHbbwYFp+6c=;
	h=From:To:Cc:Subject:Date:From;
	b=giVnXvp+04utXzc16EEnQh68Lf1FrjoJCHHdyNXB+Rz0+ecy3XTuXiE2xvypxdgqu
	 2MMZkEahxm8oMQEBMwnVGTf+VsHNh2hK3xoA75I2YLTqnesMiBeCs9/9Ad6Ht/xdqr
	 U4hzC2UgVZ1wmjT6D0Tbl4k9N2uYkwON+D2wNB5sygNUpRMkdHNwRveHWsMRrmElks
	 O0TK8Ato9cWzyOAOqiQcIJUMlLWsO3BUWRhIx+MoYifYNS7XFi5Jy/PhyAheSLhVaQ
	 A7Ai8un3gjGgF3B5dZvcM1skdqwqkXEw/Rd4Cy7soqGqjJb8MQfsNBgvPvsCVUNKkv
	 GbH44iX92QfgQ==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v5 bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc
Date: Thu, 10 Oct 2024 16:25:02 -0700
Message-ID: <20241010232505.1339892-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
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

v5 changes)

 * set PTR_UNTRUSTED for return value of bpf_get_kmem_cache()  (Alexei)
 * add KF_RCU_PROTECTED to bpf_get_kmem_cache().  See below.  (Song)
 * add WARN_ON_ONCE and comment in kmem_cache_iter_seq_next()  (Song)
 * change kmem_cache_iter_seq functions not to call BPF on intermediate stop
 * add a subtest to compare the kmem cache info with /proc/slabinfo  (Alexei)

v4: https://lore.kernel.org/lkml/20241002180956.1781008-1-namhyung@kernel.org

 * skip kmem_cache_destroy() in kmem_cache_iter_seq_stop() if possible  (Vlastimil)
 * fix a bug in the kmem_cache_iter_seq_start() for the last entry

v3: https://lore.kernel.org/lkml/20241002065456.1580143-1-namhyung@kernel.org/

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
kfunc will return a pointer to a slab from the address of a lock.

Actualy I'm not sure about the RCU lock - IIUC it doesn't protect the
kmem_cache itself but kmem_cache_destroy() calls some RCU barrier
functions, so having RCU read lock would protect the object from going
away by kfree_rcu() or something and then kmem_cache.  But please
correct me if I'm wrong.

And the test code is to read from the iterator and make sure it finds
a slab cache of the task_struct for the current task.

The code is available at 'bpf/slab-iter-v5' branch in
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
 kernel/bpf/kmem_cache_iter.c                  | 175 ++++++++++++++++++
 kernel/bpf/verifier.c                         |   5 +
 mm/slab_common.c                              |  19 ++
 .../bpf/prog_tests/kmem_cache_iter.c          | 115 ++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../selftests/bpf/progs/kmem_cache_iter.c     |  95 ++++++++++
 9 files changed, 419 insertions(+)
 create mode 100644 kernel/bpf/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_iter.c


base-commit: 5bd48a3a14df4b3ee1be0757efcc0f40d4f57b35
-- 
2.47.0.rc1.288.g06298d1525-goog


