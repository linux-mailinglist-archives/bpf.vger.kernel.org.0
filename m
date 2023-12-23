Return-Path: <bpf+bounces-18640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED481D38D
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 11:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB750283BB3
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22013BA52;
	Sat, 23 Dec 2023 10:39:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727509456
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sy0zH1c9mz4f3jXP
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 18:39:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1BF2F1A01A9
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 18:39:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCH1QvquIZljMSpEQ--.5375S4;
	Sat, 23 Dec 2023 18:39:40 +0800 (CST)
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
	Eduard Zingerman <eddyz87@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 0/3] bpf: inline bpf_kptr_xchg()
Date: Sat, 23 Dec 2023 18:40:39 +0800
Message-Id: <20231223104042.1432300-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCH1QvquIZljMSpEQ--.5375S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kAr17Jw1xGr1xJr4Dtwb_yoW5JFW5pa
	yft343tr42qFy2kw43GwnFqa4Fvws5Wry5Xr1fAr9Yyw1DZFy8Xr1fKr4F9r9xWFWYqFyr
	Zr1Igr9xC3Z8tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The motivation of inlining bpf_kptr_xchg() comes from the performance
profiling of bpf memory allocator benchmark [1]. The benchmark uses
bpf_kptr_xchg() to stash the allocated objects and to pop the stashed
objects for free. After inling bpf_kptr_xchg(), the performance for
object free on 8-CPUs VM increases about 2%~10%. However the performance
gain comes with costs: both the kasan and kcsan checks on the pointer
will be unavailable. Initially the inline is implemented in do_jit() for
x86-64 directly, but I think it will more portable to implement the
inline in verifier.

Patch #1 supports inlining bpf_kptr_xchg() helper and enables it on
x86-4. Patch #2 factors out a helper for newly-added test in patch #3.
Patch #3 tests whether the inlining of bpf_kptr_xchg() is expected.
Please see individual patches for more details. And comments are always
welcome.

Change Log:
v2:
  * rebased on bpf-next tree
  * drop patch #1 in v1 due to discussion in [2]
  * patch #1: add the motivation in the commit message, merge patch #1
              and #3 into the new patch in v2. (Daniel)
  * patch #2/#3: newly-added patch to test the inlining of
                 bpf_kptr_xchg() (Eduard)

v1: https://lore.kernel.org/bpf/95b8c2cd-44d5-5fe1-60b5-7e8218779566@huaweicloud.com/

[1]: https://lore.kernel.org/bpf/20231221141501.3588586-1-houtao@huaweicloud.com/
[2]: https://lore.kernel.org/bpf/fd94efb9-4a56-c982-dc2e-c66be5202cb7@huaweicloud.com/

Hou Tao (3):
  bpf: Support inlining bpf_kptr_xchg() helper
  selftests/bpf: Factor out get_xlated_program() helper
  selftests/bpf: Test the inlining of bpf_kptr_xchg()

 arch/x86/net/bpf_jit_comp.c                   |  5 ++
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             | 10 ++++
 kernel/bpf/helpers.c                          |  1 +
 kernel/bpf/verifier.c                         | 17 +++++++
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 44 ----------------
 .../bpf/prog_tests/kptr_xchg_inline.c         | 51 +++++++++++++++++++
 .../selftests/bpf/progs/kptr_xchg_inline.c    | 28 ++++++++++
 tools/testing/selftests/bpf/test_verifier.c   | 47 +----------------
 tools/testing/selftests/bpf/testing_helpers.c | 42 +++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  6 +++
 11 files changed, 163 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_inline.c

-- 
2.29.2


