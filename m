Return-Path: <bpf+bounces-43124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524B9AF694
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 03:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761A51C210D9
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4281DFF5;
	Fri, 25 Oct 2024 01:20:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010EBBA3D
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819230; cv=none; b=dFWapGH0s2UZXCWlZHLphscmshLUROqWLt1E/X/zi5p3VDIyKxfZ1fUHrLQUvOVs3EgMTBlGZM/eQKVPaXhepeybVS1LTD3JI/kXqEW8r0yoD/0AnsbA1GHRnrV6aGwwbn85ebjpsXlfEH7SZzIU45I2m8IKzeaWnDZDm2/8OgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819230; c=relaxed/simple;
	bh=6r6Sns46FceMvuIF4u/qeHio/99MV29YGEKN3I+f1R8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jv7RjE6i+iJjNcdOA0/YT8s8Sq/vBqnaS0ixZNRkd28VZ+m5/cgsEyJWxcGYO2Nj0yvlEQkMNZWWNCewWAKhpc1aTF/24Dw0IckR6UYXAGijJo8lkGeG4bajFPY87OPdzJZmikeu3JWvbbod9XKAEuyZEz/BvsOl0eHxvu3fkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZQ1y59scz4f3jRC
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 397091A0359
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCn28dU8hpnhzUqFA--.57458S4;
	Fri, 25 Oct 2024 09:20:22 +0800 (CST)
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
Subject: [PATCH bpf v3 0/5] Fixes for bits iterator
Date: Fri, 25 Oct 2024 09:32:28 +0800
Message-Id: <20241025013233.804027-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28dU8hpnhzUqFA--.57458S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJrykZw1xCFWxuw1UKFyDKFg_yoW8Xr1fpF
	W3Xw4Yqr4kAF47Jw1ak3W2ka4Fkw4FkayUWrsIqw1DCF1Uur90gry8GrW5Wa45JFZ3WFyx
	Zr1vkFn3Gay8XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The patch set fixes some issues for bits iterator. Patch #1 fixes the
kmemleak problem of bits iterator. Patch #2~#3 fix the overflow problem
of nr_bits. Patch #4 fixes the potential stack corruption when bits
iterator is used on 32-bit host. Patch #5 adds more test cases for bits
iterator.

Please see the individual patches for more details. And comments are
always welcome.

---
v3:
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
 kernel/bpf/helpers.c                          | 62 +++++++++++++++----
 kernel/bpf/memalloc.c                         | 14 ++++-
 .../selftests/bpf/progs/verifier_bits_iter.c  | 61 +++++++++++++++++-
 4 files changed, 123 insertions(+), 17 deletions(-)

-- 
2.29.2


