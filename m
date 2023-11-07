Return-Path: <bpf+bounces-14416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 722687E4170
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 15:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671C4B20C4E
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2930F9F;
	Tue,  7 Nov 2023 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081613212
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 14:05:57 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B0A3
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:05:56 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SPqkQ6LHSz4f3kpj
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 340311A0199
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhA_REpl+VkmAQ--.3051S4;
	Tue, 07 Nov 2023 22:05:53 +0800 (CST)
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
Subject: [PATCH bpf 00/11] bpf: Fix the release of inner map
Date: Tue,  7 Nov 2023 22:06:51 +0800
Message-Id: <20231107140702.1891778-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhA_REpl+VkmAQ--.3051S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4fCr4UXrW3Jr47XF13Arb_yoW8Kw1kpa
	yrGr45Kr4ktFnrJ343WanFg3WFyws5J34Yq3W3Kr1Yyw15XryxZrWIgFW5XF9xGry5JFWr
	Zw1Yya4rW34DXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch-set aims to fix the release of inner map in map array or map
htab. The release of inner map is different with normal map. For normal
map, the map is released after the bpf program which uses the map is
destroyed, because the bpf program tracks the used maps. However bpf
program can not track the used inner map because these inner map may be
updated or deleted dynamically, and for now the ref-count of inner map
is decreased after the inner map is overrided or deleted from map in
map, so the inner map may be released before the bpf program which is
accessing the inner map exits and there will be use-after-free problem
as demonstrate by patch #11.

The patchset fixes the problem by deferring the decrease of ref-count of
inner map. Patch #1 fixes the warning when running the newly-added
selftest. Patch #2~#6 add necessary helpers, patch #7~#8 fix the problem
for map array and map htab, patch #9 removes unused helpers and patch
#10~#11 update test add add new test cases. Please check individual
patches for more details. And comments are always welcome.

Regards,
Tao

Hou Tao (11):
  bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
  bpf: Reduce the scope of rcu_read_lock when updating fd map
  bpf: Use GFP_KERNEL in bpf_event_entry_gen()
  bpf: Add need_defer parameter to .map_fd_put_ptr()
  bpf: Add bpf_map_of_map_fd_{get,put}_ptr() helpers
  bpf: Add bpf_map_of_map_fd_sys_lookup_elem() helper
  bpf: Defer bpf_map_put() for inner map in map array
  bpf: Defer bpf_map_put() for inner map in map htab
  bpf: Remove unused helpers for map-in-map
  selftests/bpf: Remove the liveness test for inner map
  selftests/bpf: Add test cases for inner map

 include/linux/bpf.h                           |   6 +-
 kernel/bpf/arraymap.c                         |  40 +++--
 kernel/bpf/hashtab.c                          |  33 +++--
 kernel/bpf/helpers.c                          |  13 +-
 kernel/bpf/map_in_map.c                       |  60 ++++++--
 kernel/bpf/map_in_map.h                       |  16 +-
 kernel/bpf/syscall.c                          |   4 -
 .../selftests/bpf/prog_tests/btf_map_in_map.c |  26 +---
 .../selftests/bpf/prog_tests/map_in_map.c     | 138 ++++++++++++++++++
 .../selftests/bpf/progs/access_map_in_map.c   |  99 +++++++++++++
 10 files changed, 359 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/access_map_in_map.c

-- 
2.29.2


