Return-Path: <bpf+bounces-63799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3BB0AF05
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1DE5871DE
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7117236453;
	Sat, 19 Jul 2025 09:14:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6823D283;
	Sat, 19 Jul 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916472; cv=none; b=sA+UugEH0Oe4Rp6+nSJf5mE88/SY95JOghp/2aQBUb5k6ri31bkTv2zO6tExLhXxOLCBnwzzFBvUNVKdAS5iQ+elHEnYmr0uz+TFM9o2hE/WBrPh7jR818u6URSpXX6tR/ZBFgs1JrQmDf50J/r0I72rRZ8NjEUJnqMkBLAf9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916472; c=relaxed/simple;
	bh=1RyxC+Wor3JwVpOaea7sc7S00uf2LUgWPxGe7w24Muo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUtmpYq5Q3ZWmoe/oA4uFmDmgp8CgoU81w7aU3gTgAoWj7XG/W7WeIHXmfV+SXYjAajJvy/R9L6x6dRNhLws1mMbQibTkO+GjEG211XpywWFgcruuR4DNLjKn02bcR9yvges+PppA4wfdpTOKEs1qj+ynQPeoc9iwqhkrd9SeFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw16M2ZzKHMrP;
	Sat, 19 Jul 2025 17:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 881CE1A188D;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S12;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 10/10] selftests/bpf: Enable arena atomics tests for RV64
Date: Sat, 19 Jul 2025 09:17:30 +0000
Message-Id: <20250719091730.2660197-11-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S12
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DurWkJw13ury7Xry8AFb_yoW8CFy5pF
	48ZF98ta4Fgr42kas3tF4UZr4rCws5ArWUCFWqgw4DG3ZrJ3yxKF92ka98ArZ0ga4S9ry5
	Aw10q3sI9r48Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Enable arena atomics tests for RV64.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/progs/arena_atomics.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index a52feff98112..d1841aac94a2 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -28,7 +28,8 @@ bool skip_all_tests = true;
 
 #if defined(ENABLE_ATOMICS_TESTS) &&		  \
 	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
 bool skip_lacq_srel_tests __attribute((__section__(".data"))) = false;
 #else
 bool skip_lacq_srel_tests = true;
@@ -314,7 +315,8 @@ int load_acquire(const void *ctx)
 {
 #if defined(ENABLE_ATOMICS_TESTS) &&		  \
 	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
 
 #define LOAD_ACQUIRE_ARENA(SIZEOP, SIZE, SRC, DST)	\
 	{ asm volatile (				\
@@ -365,7 +367,8 @@ int store_release(const void *ctx)
 {
 #if defined(ENABLE_ATOMICS_TESTS) &&		  \
 	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
 
 #define STORE_RELEASE_ARENA(SIZEOP, DST, VAL)	\
 	{ asm volatile (			\
-- 
2.34.1


