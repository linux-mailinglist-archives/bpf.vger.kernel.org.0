Return-Path: <bpf+bounces-11615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316357BC805
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 15:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7610282327
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0E273FD;
	Sat,  7 Oct 2023 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927592376E
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 13:50:00 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD3BA
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 06:49:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S2mrH5PSdz4f3lfD
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 21:49:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnvdz9YSFl4YF2CQ--.30763S4;
	Sat, 07 Oct 2023 21:49:52 +0800 (CST)
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
Subject: [PATCH bpf-next 0/6] bpf: Fixes for per-cpu kptr
Date: Sat,  7 Oct 2023 21:51:00 +0800
Message-Id: <20231007135106.3031284-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnvdz9YSFl4YF2CQ--.30763S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1rArW5tr4fAF4fur4fuFg_yoW8XFyDpF
	Wftw1rtr40qFs7Gw1fWr1xua4rZw48GF1xG3WxX345ZrZaqry2qr40grW5uF90kFW29r1F
	y3sIgr1fCasrAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset aims to fix the problems found in the review of per-cpu
kptr patch-set [0]. Patch #1 introduces alloc_size_percpu() for dynamic
per-cpu area. Patch #2 and #3 use alloc_size_percpu() to check
whether or not unit_size matches with the size of underlying per-cpu
area and to select a matching bpf_mem_cache. Patch #4 fixes the freeing
of per-cpu kptr when these kptr is freed by map destruction. The last
patch adds test cases for these problems.

Please see individual patches for details. And comments are always
welcome.

[0]: https://lore.kernel.org/bpf/20230827152729.1995219-1-yonghong.song@linux.dev

Hou Tao (6):
  mm/percpu.c: introduce alloc_size_percpu()
  bpf: Re-enable unit_size checking for global per-cpu allocator
  bpf: Use alloc_size_percpu() in bpf_mem_free{_rcu}()
  bpf: Move the declaration of __bpf_obj_drop_impl() to internal.h
  bpf: Use bpf_global_percpu_ma for per-cpu kptr in
    __bpf_obj_drop_impl()
  selftests/bpf: Add more test cases for bpf memory allocator

 include/linux/bpf_mem_alloc.h                 |   1 +
 include/linux/percpu.h                        |   1 +
 kernel/bpf/helpers.c                          |  25 ++-
 kernel/bpf/internal.h                         |  11 ++
 kernel/bpf/memalloc.c                         |  41 ++--
 kernel/bpf/syscall.c                          |   8 +-
 mm/percpu.c                                   |  29 +++
 .../selftests/bpf/prog_tests/test_bpf_ma.c    |  20 +-
 .../testing/selftests/bpf/progs/test_bpf_ma.c | 180 +++++++++++++++++-
 9 files changed, 282 insertions(+), 34 deletions(-)
 create mode 100644 kernel/bpf/internal.h

-- 
2.29.2


