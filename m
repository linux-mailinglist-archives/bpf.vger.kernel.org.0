Return-Path: <bpf+bounces-16578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6158035CE
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1961C20B37
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4494D25776;
	Mon,  4 Dec 2023 14:03:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DBC90
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 06:03:24 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SkQP11Qdxz4f3lDd
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:03:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D647C1A09A8
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:03:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHShAl3G1l+wflCg--.13401S4;
	Mon, 04 Dec 2023 22:03:19 +0800 (CST)
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
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf v5 0/7] bpf: Fix the release of inner map
Date: Mon,  4 Dec 2023 22:04:18 +0800
Message-Id: <20231204140425.1480317-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHShAl3G1l+wflCg--.13401S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAry7Zw1rCF1kKw1fKw4rZrb_yoWrtrW5pF
	WrKr45Krs7try2vwsrCw47Wa4rtws5K34jgF13Gr4rA3yYqryxZr4IgFW5uF98ur95K34F
	vw4ava4rW34DZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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
patch #6.

The patchset fixes the problem by deferring the release of inner map.
The freeing of inner map is deferred according to the sleepable
attributes of the bpf programs which own the outer map. Patch #1 fixes
the warning when running the newly-added selftest under interpreter
mode. Patch #2 adds more parameters to .map_fd_put_ptr() to prepare for
the fix. Patch #3 fixes the incorrect value of need_defer when freeing
the fd array. Patch #4 fixes the potential use-after-free problem by
using call_rcu_tasks_trace() and call_rcu() to wait for one tasks trace
RCU GP and one RCU GP unconditionally. Patch #5 optimizes the free of
inner map by removing the unnecessary RCU GP waiting. Patch #6 adds a
selftest to demonstrate the potential use-after-free problem. Patch #7
updates a selftest to update outer map in syscall bpf program.

Please see individual patches for more details. And comments are always
welcome.

Change Log:
v5:
 * patch #3: rename fd_array_map_delete_elem_with_deferred_free() to
             __fd_array_map_delete_elem() (Alexei)
 * patch #5: use atomic64_t instead of atomic_t to prevent potential
             overflow (Alexei)
 * patch #7: use ptr_to_u64() helper instead of force casting to initialize
             pointers in bpf_attr (Alexei)

v4: https://lore.kernel.org/bpf/20231130140120.1736235-1-houtao@huaweicloud.com
  * patch #2: don't use "deferred", use "need_defer" uniformly
  * patch #3: newly-added, fix the incorrect value of need_defer during
              fd array free.
  * patch #4: doesn't consider the case in which bpf map is not used by
              any bpf program and only use sleepable_refcnt to remove
	      unnecessary tasks trace RCU GP (Alexei)
  * patch #4: remove memory barriers added due to cautiousness (Alexei)

v3: https://lore.kernel.org/bpf/20231124113033.503338-1-houtao@huaweicloud.com
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

Hou Tao (7):
  bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
  bpf: Add map and need_defer parameters to .map_fd_put_ptr()
  bpf: Set need_defer as false when clearing fd array during map free
  bpf: Defer the free of inner map when necessary
  bpf: Optimize the free of inner map
  selftests/bpf: Add test cases for inner map
  selftests/bpf: Test outer map update operations in syscall program

 include/linux/bpf.h                           |  15 +-
 kernel/bpf/arraymap.c                         |  33 ++--
 kernel/bpf/core.c                             |   4 +
 kernel/bpf/hashtab.c                          |   6 +-
 kernel/bpf/helpers.c                          |  13 +-
 kernel/bpf/map_in_map.c                       |  17 ++-
 kernel/bpf/map_in_map.h                       |   2 +-
 kernel/bpf/syscall.c                          |  40 ++++-
 kernel/bpf/verifier.c                         |   4 +-
 .../selftests/bpf/prog_tests/map_in_map.c     | 141 ++++++++++++++++++
 .../selftests/bpf/prog_tests/syscall.c        |  30 +++-
 .../selftests/bpf/progs/access_map_in_map.c   |  93 ++++++++++++
 tools/testing/selftests/bpf/progs/syscall.c   |  96 +++++++++++-
 13 files changed, 453 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/access_map_in_map.c

-- 
2.29.2


