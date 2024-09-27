Return-Path: <bpf+bounces-40428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D544D988A38
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B44C28104E
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BA1C1AD1;
	Fri, 27 Sep 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K15c/Fa4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD08EEA6;
	Fri, 27 Sep 2024 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727462496; cv=none; b=lZeX7iR6/0rISMJ7TwQ8Fo2FvXdDroXNSJ+f7X9gaGNCTL76ktIw4sh4Ka1GPQAO9XBSW7kI2mTgNqGh/amogizQ/rwuXCVn9uQGP3b3N0B/JfQTnV9nPCh8msTjePUrPtftxF/RKg7CWi6re1TnZRXip4U1AmlOEQY5/GZlV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727462496; c=relaxed/simple;
	bh=djFsDLX/zPhywfaWe9kuIOBlVP1tbaN3Cb2qCVNHtag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMM9yoqp+VqwViwJBq/I0D3bjvZPzQf3ZMDu1AFAkDp+v1kh0g2L0ke6YpMNRXqoxFdTukDzX83KoL+0QxTKS49Ir5FBB4eAj09inw1nf+SxQ+/CFYqGrMv0Ui3D/VWa9wDslnOTx7T6xo7dXJOtw9R9IErYHFyBfObRO79oNRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K15c/Fa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A11AC4CED1;
	Fri, 27 Sep 2024 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727462495;
	bh=djFsDLX/zPhywfaWe9kuIOBlVP1tbaN3Cb2qCVNHtag=;
	h=From:To:Cc:Subject:Date:From;
	b=K15c/Fa4IssMrnMcNRtDZ4ZfJY2zLaXDrpGgEnHpYKLoiLIuQzcNqrj1tG7KIjkZz
	 n7sigAgo8SL8tdVuT2SHNI3ncG1dPKKLs7J6uysXouXstWbSwMgtjLIYm9D1LE4joJ
	 pnY8kqsiunrDXDfewGRp4JTB1gYaowM8E/WDFHhaNJsl93YmCrl9gMK/8YEAYYOMwg
	 cuyBbOGQ+SL08sVCMjiJw9NWd4xLVfKLM4oAphLEAw/EnCISkPoW8Ds5WOU/8o0ktU
	 CgsotGk/rxKx7MJgsRExdnv/Co9p8I1aKxETboVQa9qHoU2oHruIQHN0nKydDhYHpA
	 2LkyMOcgAhWCQ==
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
Subject: [RFC/PATCH bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc (v2)
Date: Fri, 27 Sep 2024 11:41:30 -0700
Message-ID: <20240927184133.968283-1-namhyung@kernel.org>
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

v2 changes)

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

The slab_iter iterates kmem_cache objects under slab_mutex and will be
useful for userspace to prepare some work for specific slabs like
setting up filters in advance.  And the bpf_get_slab_cache() kfunc
will return a pointer to a slab from the address of a lock.  And the
test code is to read from the iterator and make sure it finds a slab
cache of the task_struct for the current task.

The code is available at 'bpf/slab-iter-v2' branch in
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
 kernel/bpf/kmem_cache_iter.c                  | 131 ++++++++++++++++++
 mm/slab_common.c                              |  16 +++
 .../bpf/prog_tests/kmem_cache_iter.c          |  64 +++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../selftests/bpf/progs/kmem_cache_iter.c     |  66 +++++++++
 8 files changed, 287 insertions(+)
 create mode 100644 kernel/bpf/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_iter.c

-- 
2.46.1.824.gd892dcdcdd-goog


