Return-Path: <bpf+bounces-15806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F67F72B5
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 12:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87907B21481
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765BB1DDD9;
	Fri, 24 Nov 2023 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F2510F1
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 03:29:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ScCS66KNWz4f3jHt
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 19:29:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9CA881A069A
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 19:29:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xEUiWBloME3Bw--.31197S4;
	Fri, 24 Nov 2023 19:29:26 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf v3 0/6] bpf: Fix the release of inner map
Date: Fri, 24 Nov 2023 19:30:27 +0800
Message-Id: <20231124113033.503338-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xEUiWBloME3Bw--.31197S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAry7Zw1rCF1kKw1fKw4rZrb_yoW5KFy8pF
	WrKr45Kr4ktry2qwnrGw47Xa4Syws5Ga4Ygr13Gr4rA3y5XryfZryIgFW5uF9xCrZ3tryF
	vw1ayas5G34DZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset aims to fix the release of inner map in map array or map
htab. The release of inner map is different with normal map. For normal
map, the map is released after the bpf program which uses the map is
destroyed, because the bpf program tracks the used maps. However bpf
program can not track the used inner map because these inner map may be
updated or deleted dynamically, and for now the ref-counter of inner map
is decreased after the inner map is remove from outer map, so the inner
map may be freed before the bpf program, which is accessing the inner
map, exits and there will be use-after-free problem as demonstrated by
patch #5.

The patchset fixes the problem by deferring the release of inner map.
The freeing of inner map is deferred according to the sleepable
attributes of the bpf programs which own the outer map. Patch #1 fixes
the warning when running the newly-added selftest under interpreter
mode. Patch #2 adds more parameters to .map_fd_put_ptr() to prepare for
the fix. Patch #3 fixes the potential use-after-free problem by using
call_rcu_tasks_trace() and call_rcu() to waiting for one tasks trace RCU
GP and one RCU GP unconditionally. Patch #4 optimizes the free of inner
map by removing the unnecessary RCU GP waiting. Patch #5 adds a selftest
to demonstrate the potential use-after-free problem. Patch #6 updates a
selftest to update outer map in syscall bpf program.

Please see individual patches for more details. And comments are always
welcome.

Change Log:
v3:
  * multiple variable renamings (Martin)
  * define BPF_MAP_RCU_GP/BPF_MAP_RCU_TT_GP as bit (Martin)
  * use call_rcu() and its variants instead of synchronize_rcu() (Martin)
  * remove unnecessary mask in bpf_map_free_deferred() (Martin)
  * place atomic_or() and the related smp_mb() together (Martin)
  * add patch #6 to demonstrate that updating outer map in syscall
    program is dead-lock free (Alexei)
  * update comments about the memory barrier in bpf_map_fd_put_ptr()
  * update commit message for patch #3 and #4 to describe more details

v2: https://lore.kernel.org/bpf/20231113123324.3914612-1-houtao@huaweicloud.com
  * defer the invocation of ops->map_free() instead of bpf_map_put() (Martin)
  * update selftest to make it being reproducible under JIT mode (Martin)
  * remove unnecessary preparatory patches

v1: https://lore.kernel.org/bpf/20231107140702.1891778-1-houtao@huaweicloud.com


Hou Tao (6):
  bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
  bpf: Add map and need_defer parameters to .map_fd_put_ptr()
  bpf: Defer the free of inner map when necessary
  bpf: Optimize the free of inner map
  selftests/bpf: Add test cases for inner map
  selftests/bpf: Test outer map update operations in syscall program

 include/linux/bpf.h                           |  19 ++-
 kernel/bpf/arraymap.c                         |  12 +-
 kernel/bpf/hashtab.c                          |   6 +-
 kernel/bpf/helpers.c                          |  13 +-
 kernel/bpf/map_in_map.c                       |  22 ++-
 kernel/bpf/map_in_map.h                       |   2 +-
 kernel/bpf/syscall.c                          |  43 +++++-
 kernel/bpf/verifier.c                         |   4 +
 .../selftests/bpf/prog_tests/map_in_map.c     | 141 ++++++++++++++++++
 .../selftests/bpf/prog_tests/syscall.c        |  30 +++-
 .../selftests/bpf/progs/access_map_in_map.c   |  93 ++++++++++++
 tools/testing/selftests/bpf/progs/syscall.c   |  91 ++++++++++-
 12 files changed, 444 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/access_map_in_map.c

-- 
2.29.2


