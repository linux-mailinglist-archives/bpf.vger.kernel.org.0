Return-Path: <bpf+bounces-9494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33923798806
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637D21C20C39
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774E63B8;
	Fri,  8 Sep 2023 13:39:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238663AD
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:39:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674A1BC1
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 06:39:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rhxzm5PQjz4f3kk8
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 21:39:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHVqkPJPtkRmSwCg--.44307S4;
	Fri, 08 Sep 2023 21:39:29 +0800 (CST)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf 0/4] Fix the unmatched unit_size of bpf_mem_cache
Date: Fri,  8 Sep 2023 21:39:19 +0800
Message-Id: <20230908133923.2675053-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHVqkPJPtkRmSwCg--.44307S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF48Kry5XFyrXr13Zr4xJFb_yoW8Xw1kpa
	4Iyw1FkFykZF1xKw4xu34I9ayrJwnYg3W5G3WfXryUZ3yrWrykXr48KrW5XF98trWSqF1f
	Zr1kKFn3Ca1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset aims to fix the reported warning [0] when the unit_size of
bpf_mem_cache is mismatched with the object size of underly slab-cache.

Patch #1 fixes the warning by adjusting size_index according to the
value of KMALLOC_MIN_SIZE, so bpf_mem_cache with unit_size which is
smaller than KMALLOC_MIN_SIZE or is not aligned with KMALLOC_MIN_SIZE
will be redirected to bpf_mem_cache with bigger unit_size. Patch #2
doesn't do prefill for these redirected bpf_mem_cache to save memory.
Patch #3 adds further error check in bpf_mem_alloc_init() to ensure the
unit_size and object_size are always matched and to prevent potential
issues due to the mismatch.

Please see individual patches for more details. And comments are always
welcome.

[0]: https://lore.kernel.org/bpf/87jztjmmy4.fsf@all.your.base.are.belong.to.us

Hou Tao (4):
  bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
  bpf: Don't prefill for unused bpf_mem_cache
  bpf: Ensure unit_size is matched with slab cache object size
  selftests/bpf: Test all valid alloc sizes for bpf mem allocator

 kernel/bpf/memalloc.c                         |  87 ++++++++++++-
 .../selftests/bpf/prog_tests/test_bpf_ma.c    |  50 +++++++
 .../testing/selftests/bpf/progs/test_bpf_ma.c | 123 ++++++++++++++++++
 3 files changed, 256 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_ma.c

-- 
2.29.2


