Return-Path: <bpf+bounces-45065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF79D076E
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 02:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC9DB21116
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 01:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF12F855;
	Mon, 18 Nov 2024 01:13:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986D175BF
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892438; cv=none; b=jnN/eeGEHifT2sKnG/qmRPCZ7Ps//VTetQwzF0ZkM5p3zNkT301063QL1dl+IhvnlzWdI0SQZ215YXGKhySRfmL35U+lVBw4mJi1cd/YNsI4ZjybeF7kPiobc4pwuHBvZD7eJWyXICxvp5EnqM2ZQ3JxRiMqUs09XorPrlFtUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892438; c=relaxed/simple;
	bh=DdA1PbFjubhIDgObznYrbOhMHrVixV9Yw1JtsAWK3rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=USnqJSMyKcBnY0kKX/vh+5KPpL2m2O9hHsr2C0g9i2Mzvng84hOeJIIOAywZ2vN/m+D69H9AzoRCSqUiPRGTfWF2Ax1w2Xju4FzKfUzL/RYM71gjmOKJR+CaWu1D28Ms0krRALBlU3SywW7kdpnYaG7Vhz+hpuDpITtuArhdKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xs8Lr5Tmfz4f3jsg
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:55:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 326C61A0359
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:56:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4eckDpn2G5fCA--.44635S13;
	Mon, 18 Nov 2024 08:56:06 +0800 (CST)
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
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 09/10] selftests/bpf: Move test_lpm_map.c to map_tests
Date: Mon, 18 Nov 2024 09:08:07 +0800
Message-Id: <20241118010808.2243555-10-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241118010808.2243555-1-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4eckDpn2G5fCA--.44635S13
X-Coremail-Antispam: 1UD129KBjvJXoWxCw45tFyrWF1kXw4xZFykuFg_yoW5WFWfpa
	48t3WqkF1SvFnxX3WxuayUZF40gFsrXw40y3W8try5Zrn7Jr1xtr1xKFW7JFnxurZ3XFnx
	Aas3KFyfZFy8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Move test_lpm_map.c to map_tests/ to include LPM trie test cases in
regular test_maps run. Most code remains unchanged, including the use of
assert(). Only reduce n_lookups from 64K to 512, which decreases
test_lpm_map runtime from 37s to 0.7s.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/.gitignore                 |  1 -
 tools/testing/selftests/bpf/Makefile                   |  2 +-
 .../lpm_trie_map_basic_ops.c}                          | 10 +++-------
 3 files changed, 4 insertions(+), 9 deletions(-)
 rename tools/testing/selftests/bpf/{test_lpm_map.c => map_tests/lpm_trie_map_basic_ops.c} (99%)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index c2a1842c3d8b..e9c377001f93 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -5,7 +5,6 @@ bpf-syscall*
 test_verifier
 test_maps
 test_lru_map
-test_lpm_map
 test_tag
 FEATURE-DUMP.libbpf
 FEATURE-DUMP.selftests
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6ad3b1ba1920..7eeb3cbe18c7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -83,7 +83,7 @@ CLANG_CPUV4 := 1
 endif
 
 # Order correspond to 'make run_tests' order
-TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
+TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
 	test_sockmap \
 	test_tcpnotify_user test_sysctl \
 	test_progs-no_alu32
diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
similarity index 99%
rename from tools/testing/selftests/bpf/test_lpm_map.c
rename to tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
index d98c72dc563e..f375c89d78a4 100644
--- a/tools/testing/selftests/bpf/test_lpm_map.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
@@ -223,7 +223,7 @@ static void test_lpm_map(int keysize)
 	n_matches = 0;
 	n_matches_after_delete = 0;
 	n_nodes = 1 << 8;
-	n_lookups = 1 << 16;
+	n_lookups = 1 << 9;
 
 	data = alloca(keysize);
 	memset(data, 0, keysize);
@@ -770,16 +770,13 @@ static void test_lpm_multi_thread(void)
 	close(map_fd);
 }
 
-int main(void)
+void test_lpm_trie_map_basic_ops(void)
 {
 	int i;
 
 	/* we want predictable, pseudo random tests */
 	srand(0xf00ba1);
 
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
 	test_lpm_basic();
 	test_lpm_order();
 
@@ -792,6 +789,5 @@ int main(void)
 	test_lpm_get_next_key();
 	test_lpm_multi_thread();
 
-	printf("test_lpm: OK\n");
-	return 0;
+	printf("%s: PASS\n", __func__);
 }
-- 
2.29.2


