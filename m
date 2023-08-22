Return-Path: <bpf+bounces-8243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACC4784188
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0792F1C20B2E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAE1C9F0;
	Tue, 22 Aug 2023 13:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264937F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:06:16 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C97CD8
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:06:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVV3408dYz4f3m8d
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:06:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBH16m+suRk0ldIBQ--.4082S4;
	Tue, 22 Aug 2023 21:06:08 +0800 (CST)
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
Subject: [PATCH bpf-next 0/3] bpf: Enable preemption after irq_work_raise() completes
Date: Tue, 22 Aug 2023 21:38:04 +0800
Message-Id: <20230822133807.3198625-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBH16m+suRk0ldIBQ--.4082S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4rAr4DWFWfKr1UuFykXwb_yoW8JFy7pF
	4fKryFya1kAFy7Jrya93Z2yryrGa1rXr48Kr1fXFyUZ395JrykJr1xKr15Wr93JrWjqFWr
	Zr4vkF4kCw18Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset aims to fix the problem that bpf_mem_alloc() may return
NULL unexpectedly when multiple bpf_mem_alloc() are invoked concurrently
under process context and there is still free memory available. The
problem was found when doing stress test for qp-trie but the same
problem also exists for bpf_obj_new() as demonstrated in patch #3.

Patch #1 fixes the race between unit_alloc() and unit_alloc(). Patch
#2 fixes the race between unit_alloc() and unit_free(). And patch #3
adds a selftest for the problem. Please see individual patches for more
details. And comments are always welcome.

Hou Tao (3):
  bpf: Enable preemption after irq_work_raise() in unit_alloc()
  bpf: Enable preemption after irq_work_raise() in unit_free{_rcu}()
  selftests/bpf: Test preemption between bpf_obj_new() and
    bpf_obj_drop()

 kernel/bpf/memalloc.c                         |  12 ++
 .../bpf/prog_tests/preempted_bpf_ma_op.c      |  89 +++++++++++++++
 .../selftests/bpf/progs/preempted_bpf_ma_op.c | 106 ++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempted_bpf_ma_op.c

-- 
2.29.2


