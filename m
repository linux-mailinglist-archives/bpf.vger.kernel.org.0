Return-Path: <bpf+bounces-12557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146E7CDA73
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 13:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7F81F22D8D
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD82D781;
	Wed, 18 Oct 2023 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F720307
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:32:41 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F47181
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 04:32:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S9TGk0rl7z4f3knx
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 19:32:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnfd1Mwi9l9jYmDQ--.41845S4;
	Wed, 18 Oct 2023 19:32:30 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
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
	houtao1@huawei.com,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH bpf-next v2 0/7] bpf: Fixes for per-cpu kptr
Date: Wed, 18 Oct 2023 19:33:36 +0800
Message-Id: <20231018113343.2446300-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnfd1Mwi9l9jYmDQ--.41845S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUXrWkXrWxGFyrKw1DAwb_yoW8tr43pF
	Wftr4rtr4vqFyxGw1xKr109a4rZw48WF17J3WfWw15ZFZIqry2qrs2gF45uas8tFZIgF13
	tr9xGFs3Ca4jvw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset aims to fix the problems found in the review of per-cpu
kptr patch-set [0]. Patch #1 moves pcpu_lock after the invocation of
pcpu_chunk_addr_search() and it is a micro-optimization for
free_percpu(). The reason includes it in the patch is that the same
logic is used in newly-added API pcpu_alloc_size(). Patch #2 introduces
pcpu_alloc_size() for dynamic per-cpu area. Patch #2 and #3 use
pcpu_alloc_size() to check whether or not unit_size matches with the
size of underlying per-cpu area and to select a matching bpf_mem_cache.
Patch #4 fixes the freeing of per-cpu kptr when these kptrs are freed by
map destruction. The last patch adds test cases for these problems.

Please see individual patches for details. And comments are always
welcome.

Change Log:
v2:
  * add a new patch "don't acquire pcpu_lock for pcpu_chunk_addr_search()"
  * patch 2: change type of bit_off and end to unsigned long (Andrew)
  * patch 2: rename the new API as pcpu_alloc_size and follow 80-column convention (Dennis)
  * patch 5: move the common declaration into bpf.h (Stanislav, Alxei)

v1: https://lore.kernel.org/bpf/20231007135106.3031284-1-houtao@huaweicloud.com/

[0]: https://lore.kernel.org/bpf/20230827152729.1995219-1-yonghong.song@linux.dev

Hou Tao (7):
  mm/percpu.c: don't acquire pcpu_lock for pcpu_chunk_addr_search()
  mm/percpu.c: introduce pcpu_alloc_size()
  bpf: Re-enable unit_size checking for global per-cpu allocator
  bpf: Use pcpu_alloc_size() in bpf_mem_free{_rcu}()
  bpf: Move the declaration of __bpf_obj_drop_impl() to bpf.h
  bpf: Use bpf_global_percpu_ma for per-cpu kptr in
    __bpf_obj_drop_impl()
  selftests/bpf: Add more test cases for bpf memory allocator

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_mem_alloc.h                 |   1 +
 include/linux/percpu.h                        |   1 +
 kernel/bpf/helpers.c                          |  24 ++-
 kernel/bpf/memalloc.c                         |  38 ++--
 kernel/bpf/syscall.c                          |   6 +-
 mm/percpu.c                                   |  34 +++-
 .../selftests/bpf/prog_tests/test_bpf_ma.c    |  20 +-
 .../testing/selftests/bpf/progs/test_bpf_ma.c | 180 +++++++++++++++++-
 9 files changed, 269 insertions(+), 36 deletions(-)

-- 
2.29.2


