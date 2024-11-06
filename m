Return-Path: <bpf+bounces-44108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5529BDECB
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 07:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6F1F2473F
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 06:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877201922F0;
	Wed,  6 Nov 2024 06:23:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A41917EB
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874225; cv=none; b=iSV9KihreVjs23RjapOlTADP9O8uTtEKXxhsbdccVYa0T8i6lu1sgqLfaTcXubcQoaTuPARUmKGBPjzVkZqSmWqStsSDCkyd80OLdeC/Lt16oeb3J10NTa01GIOEmgmsJaN95uEgrbtGmTtF8sGcYme7bB3qeJZ7Y2P8PzT1scM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874225; c=relaxed/simple;
	bh=VE8dq5/sOhKCq8urVABuy7B+VsowMzKtrzdFKKj3tH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3cOPV+wb4jyVR/RWK/GCB7iZMp0jKZdMEkXtCoXkGLUHaWKa87NhgSCumhOcmwAlBF0YkaeSULegt4/en4HnLENrue8vv8R8qs4hLggKJt6qLfJjuTqTRfEe4WOGs8CC2PCUVYFcEvnKbfne9WjW5H/MATUN7z0ciICdQxwXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XjwBC14JLz4f3jXm
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 14:23:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 211591A058E
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 14:23:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVhCytn_SX4Aw--.24568S6;
	Wed, 06 Nov 2024 14:23:32 +0800 (CST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 2/3] selftests/bpf: Move ENOTSUPP from bpf_util.h
Date: Wed,  6 Nov 2024 14:35:41 +0800
Message-Id: <20241106063542.357743-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241106063542.357743-1-houtao@huaweicloud.com>
References: <20241106063542.357743-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVhCytn_SX4Aw--.24568S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1xKrW3GFWrJF13Xw15XFb_yoWrGF4Upa
	4kJw1jkF1SgF13tr17GrW2gF4SgFsrXrWYkr1Igr98ZrsrX3s7Xr4xKFW5XF9xWrZYqrs3
	Z34xKrn8uw48Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Moving the definition of ENOTSUPP into bpf_util.h to remove the
duplicated definitions in multiple files.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/bpf_util.h              | 4 ++++
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 4 ----
 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 4 ----
 tools/testing/selftests/bpf/prog_tests/sock_addr.c  | 4 ----
 tools/testing/selftests/bpf/test_maps.c             | 4 ----
 tools/testing/selftests/bpf/test_verifier.c         | 4 ----
 6 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 10587a29b967..8cba5821a1d5 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -59,4 +59,8 @@ static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
 	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 #endif
 
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
 #endif /* __BPF_UTIL__ */
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 409a06975823..b7d1b52309d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -16,10 +16,6 @@
 #include "tcp_ca_kfunc.skel.h"
 #include "bpf_cc_cubic.skel.h"
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index 130a3b21e467..6df25de8f080 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -10,10 +10,6 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 static struct btf *btf;
 
 static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index a6ee7f8d4f79..b2efabbed220 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -23,10 +23,6 @@
 #include "getpeername_unix_prog.skel.h"
 #include "network_helpers.h"
 
-#ifndef ENOTSUPP
-# define ENOTSUPP 524
-#endif
-
 #define TEST_NS                 "sock_addr"
 #define TEST_IF_PREFIX          "test_sock_addr"
 #define TEST_IPV4               "127.0.0.4"
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 905d5981ace1..8b40e9496af1 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -26,10 +26,6 @@
 #include "test_maps.h"
 #include "testing_helpers.h"
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 int skips;
 
 static struct bpf_map_create_opts map_opts = { .sz = sizeof(map_opts) };
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 610392dfc4fb..447b68509d76 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -42,10 +42,6 @@
 #include "../../../include/linux/filter.h"
 #include "testing_helpers.h"
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_EXPECTED_INSNS	32
 #define MAX_UNEXPECTED_INSNS	32
-- 
2.29.2


