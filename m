Return-Path: <bpf+bounces-43537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7B9B5F47
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 10:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BCBEB21308
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4071E2616;
	Wed, 30 Oct 2024 09:53:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEB1E230C
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281996; cv=none; b=e0AiewQkUOMjBBmIcWjowkET7vUZYHeRzOGj3ZwgSAiW/wFimmh2dTcYs78rablO+oNw3pUqaq1KIUcIm+Jht7Q0vv51TM+wMXZzmcVmwPH1UUad1sztAdMK7iKYSfwFkxhxPLwiPq31Q2ERSc3A7V3BV2P9v4GScRDS5FGHtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281996; c=relaxed/simple;
	bh=5nNYhrbMmxaB2EP7T8vbeOpxSUD1iR5DhOUecPieD/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a2LuQ9/+4Ir5FrYtM+ALEXLRybjcfFrMIJWIoWBuApABIDggdcLaykDCj9jo/LQivIGk9YAqgR+w6h32Cb3ghMiDNsyhWETcFFrySO7GbFjFSz8J2a95AkkMFscj6VUB2RhaKPLMxr7AEOY5Fd8efoVOpsrkyOnPFGT0ZhnSSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xdj9M4Xg8z4f3m7h
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:52:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3D61A1A0196
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:53:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4cAAiJn97dvAQ--.24244S4;
	Wed, 30 Oct 2024 17:53:05 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v4 0/5] Fixes for bits iterator
Date: Wed, 30 Oct 2024 18:05:11 +0800
Message-Id: <20241030100516.3633640-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4cAAiJn97dvAQ--.24244S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW7WrWrCry7KrWfKw1kGrg_yoW8CF18pF
	W3Jw45tr4kJF43JwnIk3W2ka4Fyw4rKayUWFsxtw15CF48ur1q9r18KrW5uasrJFWfGF17
	Zr1vk3Z3Ga4UZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUFku4UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set fixes several issues in bits iterator. Patch #1 fixes the
kmemleak problem of bits iterator. Patch #2~#3 fix the overflow problem
of nr_bits. Patch #4 fixes the potential stack corruption when bits
iterator is used on 32-bit host. Patch #5 adds more test cases for bits
iterator.

Please see the individual patches for more details. And comments are
always welcome.

---
v4:
 * patch #1: add ack from Yafang
 * patch #3: revert code-churn like changes:
   (1) compute nr_bytes and nr_bits before the check of nr_words.
   (2) use nr_bits == 64 to check for single u64, preventing build
       warning on 32-bit hosts.
 * patch #4: use "BITS_PER_LONG == 32" instead of "!defined(CONFIG_64BIT)"

v3: https://lore.kernel.org/bpf/20241025013233.804027-1-houtao@huaweicloud.com/T/#t
  * split the bits-iterator related patches from "Misc fixes for bpf"
    patch set
  * patch #1: use "!nr_bits || bits >= nr_bits" to stop the iteration
  * patch #2: add a new helper for the overflow problem
  * patch #3: decrease the limitation from 512 to 511 and check whether
    nr_bytes is too large for bpf memory allocator explicitly
  * patch #5: add two more test cases for bit iterator

v2: http://lore.kernel.org/bpf/d49fa2f4-f743-c763-7579-c3cab4dd88cb@huaweicloud.com

Hou Tao (5):
  bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
  bpf: Add bpf_mem_alloc_check_size() helper
  bpf: Check the validity of nr_words in bpf_iter_bits_new()
  bpf: Use __u64 to save the bits in bits iterator
  selftests/bpf: Add three test cases for bits_iter

 include/linux/bpf_mem_alloc.h                 |  3 +
 kernel/bpf/helpers.c                          | 54 +++++++++++++---
 kernel/bpf/memalloc.c                         | 14 ++++-
 .../selftests/bpf/progs/verifier_bits_iter.c  | 61 ++++++++++++++++++-
 4 files changed, 118 insertions(+), 14 deletions(-)

-- 
2.29.2


