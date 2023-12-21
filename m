Return-Path: <bpf+bounces-18536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5A81B959
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CFD1F22652
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D16D6D0;
	Thu, 21 Dec 2023 14:14:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6068336086
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwsqP5gYyz4f3l13
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:13:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0DE7E1A0600
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:13:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhAkSIRl5A8DEQ--.16750S4;
	Thu, 21 Dec 2023 22:13:58 +0800 (CST)
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
Subject: [PATCH bpf-next 0/2] bpf: Add benchmark for bpf memory allocator
Date: Thu, 21 Dec 2023 22:14:59 +0800
Message-Id: <20231221141501.3588586-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhAkSIRl5A8DEQ--.16750S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar15tFy5tFykAFy8Kr1DAwb_yoW8Ar1xpF
	4fKw15tr1rJF17tw4fCayqqFyfAwn5ZrWYkF12vFn8Zw47Xry8ZryxKrWrZF9xC3ySvr1r
	Zw4vgr4fu3W0v37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to add a benchmark for bpf memory allocator to test
both its alloc/free ratio and the memory usage.

Patch #1 is a preparatory patch which moves bench specific metrics into
union of structs, so newly-added benchmark can add metrics which doesn't
fit with the existing one easily. Patch #2 is the benchmark patch. It
tests the performance through the following steps:
1) find the inner array by using the cpu number as key
2) allocate at most 64 128-bytes-sized objects through bpf_obj_new()
3) stash these objectes into the inner array through bpf_kptr_xchg()
4) account the time used in step 1)~3)
5) calculate the performance in M/s: alloc_cnt * 1000 / alloc_tim_ns
6) calculate the memory usage by reading slub field in memory.stat file
   and get the final value after subtracting the base value.

Please see individual patches for more details. And comments are always
welcome.

Hou Tao (2):
  selftests/bpf: Move bench specific metrics into union of structs
  selftests/bpf: Add benchmark for bpf memory allocator

 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  13 +-
 tools/testing/selftests/bpf/bench.h           |  22 +-
 .../selftests/bpf/benchs/bench_bpf_ma.c       | 273 ++++++++++++++++++
 .../selftests/bpf/benchs/bench_htab_mem.c     |  10 +-
 .../bench_local_storage_rcu_tasks_trace.c     |  10 +-
 .../selftests/bpf/progs/bench_bpf_ma.c        | 222 ++++++++++++++
 7 files changed, 535 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_ma.c
 create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_ma.c

-- 
2.29.2


