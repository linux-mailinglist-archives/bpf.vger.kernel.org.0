Return-Path: <bpf+bounces-14985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6098E7E9C31
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 13:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B9C280BE2
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F441D6A5;
	Mon, 13 Nov 2023 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F51D6AA
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 12:32:25 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED21984
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 04:32:20 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4STTMf0TPmz4f3mJH
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:32:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0B93E1A0173
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:32:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA5NF1Jl2c5BAw--.31533S4;
	Mon, 13 Nov 2023 20:32:15 +0800 (CST)
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
Subject: [PATCH bpf v2 0/5] bpf: Fix the release of inner map
Date: Mon, 13 Nov 2023 20:33:19 +0800
Message-Id: <20231113123324.3914612-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA5NF1Jl2c5BAw--.31533S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAry7Zw1rCF1kKw1fKw4rZrb_yoW5GF18pF
	WrKr45Kr4ktry7J3srG3W2qa4Syws5Kw1Yg3W3Kry5A3y5XryfZrWIgFW5uasxC3s3KFWF
	vw1aya4rW34DZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
updated or deleted dynamically, and for now the ref-count of inner map
is decreased after the inner map is remove from outer map, so the inner
map may be freed before the bpf program, which is accessing the inner
map, exits and there will be use-after-free problem as demonstrated by
patch #5.

The patchset fixes the problem by deferring the release of inner map.
The freeing of inner map is deferred according to the sleepable context
of the bpf programs which own the outer map. Patch #1 fixes the warning
when running the newly-added selftest under interpreter mode. Patch #2
adds more parameters to .map_fd_put_ptr(). Patch #3 fixes the potential
use-after-free problem by waiting for one RCU GP and one tasks trace RCU
GP unconditionally. Patch #4 optimizes the free of inner map by removing
the unnecessary RCU GP waiting and patch #5 add a selftest to
demonstrate the potential use-after-free problem.

Please see individual patches for more details. And comments are always
welcome.

Change Log:
v2:
  * defer the invocation of ops->map_free() instead of bpf_map_put() (Martin)
  * update selftest to make it being reproducible under JIT mode (Martin)
  * remove unnecessary preparatory patches

v1: https://lore.kernel.org/bpf/20231107140702.1891778-1-houtao@huaweicloud.com

Hou Tao (5):
  bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
  bpf: Add map and need_defer parameters to .map_fd_put_ptr()
  bpf: Defer the free of inner map when necessary
  bpf: Optimize the free of inner map
  selftests/bpf: Add test cases for inner map

 include/linux/bpf.h                           |  14 +-
 kernel/bpf/arraymap.c                         |  12 +-
 kernel/bpf/hashtab.c                          |   6 +-
 kernel/bpf/helpers.c                          |  13 +-
 kernel/bpf/map_in_map.c                       |  21 ++-
 kernel/bpf/map_in_map.h                       |   2 +-
 kernel/bpf/syscall.c                          |  16 ++
 kernel/bpf/verifier.c                         |   5 +
 .../selftests/bpf/prog_tests/map_in_map.c     | 141 ++++++++++++++++++
 .../selftests/bpf/progs/access_map_in_map.c   |  93 ++++++++++++
 10 files changed, 304 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/access_map_in_map.c

-- 
2.29.2


