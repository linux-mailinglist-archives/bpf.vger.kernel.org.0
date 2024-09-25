Return-Path: <bpf+bounces-40323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997F698692D
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 00:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA82839E4
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 22:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B7156C73;
	Wed, 25 Sep 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nog7Mu8r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57A13D891;
	Wed, 25 Sep 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303425; cv=none; b=cxrVOCQG6Xmc1vtrAkiNW5537Tu1uMYisx3+5Bz3+tuUiGP2TUnZUzCI7vHY29G8sfB8ppzECpOANtB779/g9X9ZAupupsywsu+uAFgXvzIg7t6zuqjIrNRf9pGaO1smYPfdkaP140IPz970z8EsCzn7kJlzb+yqImRlhFOWfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303425; c=relaxed/simple;
	bh=/wpNuyYlQgTLd8to7yv58RW9K/fnJNPPR7Yi9IPGjww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twUTCMNbDadO3Ej2mWIZVfeWFG5snw9iF87zzqm3wCV/azjwte7Wgc1WJ8fGNboqE+JUT+uEhlo1A9b897f1e0aLjSD0sf8DO1n5Sq9pSXnFW5jKd5qHVxaTDso8uMTIa1Z9ZvUvH7FpeidFqpYaXplXc/OiTIrIlQm1MLLu6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nog7Mu8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF73CC4CEC3;
	Wed, 25 Sep 2024 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727303424;
	bh=/wpNuyYlQgTLd8to7yv58RW9K/fnJNPPR7Yi9IPGjww=;
	h=From:To:Cc:Subject:Date:From;
	b=Nog7Mu8ryCZIbKiU+7l2FP2MewyEIKi52moHSJyUsIYX3gegdE3ejjnLfaq5M0o/b
	 a6deA05wMrLbyO0tzRI82+imB0c5GsmMLOvgsVwTiuHyrAC3K4i8XgZrY0qFBFCh2A
	 l7dwnt91wtbhHEinc9g9ObRIRZpZrQxJiDqwhaKE0Z//BwFYEmwdf+sN3mRnsXDwDL
	 8JpdKFXAq41biEuyplUCfv27kj6yZ6zSg56wxIFKxNIRbeJAMzV4pSHFQdjfz+H67s
	 fRCcXQjwTn7KsM+dF00n2Hh+TmUxzVH7IykxOgE3lf21yWDlIiNm07GijRmr87+kbz
	 k09AM+jhu3u5A==
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
	linux-mm@kvack.org
Subject: [RFC/PATCH bpf-next 0/3] bpf: Add slab iterator and kfunc (v1)
Date: Wed, 25 Sep 2024 15:30:20 -0700
Message-ID: <20240925223023.735947-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
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
/sys/kernel/slab.  Maybe I need to call it kmem_cache iter but slab
was short and easier to call. :)

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

The code is available at 'bpf/slab-iter-v1' branch in
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (3):
  bpf: Add slab iterator
  mm/bpf: Add bpf_get_slab_cache() kfunc
  selftests/bpf: Add a test for slab_iter

 include/linux/btf_ids.h                       |   1 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/slab_iter.c                        | 131 ++++++++++++++++++
 mm/slab_common.c                              |  14 ++
 .../selftests/bpf/prog_tests/slab_iter.c      |  64 +++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 tools/testing/selftests/bpf/progs/slab_iter.c |  62 +++++++++
 8 files changed, 281 insertions(+)
 create mode 100644 kernel/bpf/slab_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/slab_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/slab_iter.c

-- 
2.46.0.792.g87dc391469-goog


