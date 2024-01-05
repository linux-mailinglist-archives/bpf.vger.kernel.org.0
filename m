Return-Path: <bpf+bounces-19122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49C825257
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 11:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6391F25549
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB925554;
	Fri,  5 Jan 2024 10:47:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E92286B9
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T60X51jmlz4f3jHg
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 18:47:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 91EA21A0946
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 18:47:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAXZw013pdlA+1eFg--.49979S4;
	Fri, 05 Jan 2024 18:47:19 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/3] bpf: inline bpf_kptr_xchg()
Date: Fri,  5 Jan 2024 18:48:16 +0800
Message-Id: <20240105104819.3916743-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXZw013pdlA+1eFg--.49979S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW5JFWUtFWUKryDXF4rAFb_yoW5Xw43pa
	yft343Kr42qFy2kw43GwnFqa4Fyws5Wry5Xr1fA3sYy3WUZFy8Xr1fKrWF9r9xWFZ0gFyr
	Ar1I9rySk3WktFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
v3:
  * rebased on bpf-next tree
  * patch 1 & 2: Add Rvb-by and Ack-by tags from Eduard
  * patch 3: use inline assembly and naked function instead of c code
             (suggested by Eduard)

v2: https://lore.kernel.org/bpf/20231223104042.1432300-1-houtao@huaweicloud.com/
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
 .../selftests/bpf/progs/kptr_xchg_inline.c    | 48 +++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c   | 47 +----------------
 tools/testing/selftests/bpf/testing_helpers.c | 42 +++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  6 +++
 11 files changed, 183 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_inline.c

-- 
2.29.2


