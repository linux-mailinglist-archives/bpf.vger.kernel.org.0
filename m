Return-Path: <bpf+bounces-38983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D996D1A3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805CB285BFC
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0EC19B3D8;
	Thu,  5 Sep 2024 08:11:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EC199249;
	Thu,  5 Sep 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523884; cv=none; b=jRvPg1mP+7FyaBKaq6Y/KeyIlZV9RNSeb96DEOHdakkcNck0gu4zURhHgG4nKlwkhm8A1zvkfcbACCeJU3I0EaaMvivPS3HogkYTdyKrA6N3RUqELOgAX1lECQgxq1ZH6384QO7yoknkWgfiBmzfBIfyWFCtyb89VrehLuq0E9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523884; c=relaxed/simple;
	bh=clDdIUEKVeiyjVQeDc44MqSrn4f4vzBWF+gE624PUIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxu1RgI+1l0PWe+87/MT57cU/PTX/SjKUdFYMbbTuQuzAYK0TsPKpmtE5CXZHGNpx8FJ/vq+YViMCogtNOWBmtHCClomR2jEhRBg4p8TkhP/0bN79Zlvzc3419VGtQk40TkMUQ9U1N+5Fg5KXWYRoLA+iVjbONsCnm8dGui1rQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzsWJ1ctSz4f3jkP;
	Thu,  5 Sep 2024 16:11:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8CAF41A15EB;
	Thu,  5 Sep 2024 16:11:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S4;
	Thu, 05 Sep 2024 16:11:18 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v3 02/10] selftests/bpf: Rename fallback in bpf_dctcp to avoid naming conflict
Date: Thu,  5 Sep 2024 08:13:53 +0000
Message-Id: <20240905081401.1894789-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905081401.1894789-1-pulehui@huaweicloud.com>
References: <20240905081401.1894789-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW8GF1fAF15Zr48ZrW5ZFb_yoW5CF4kpa
	4kZ3yYyF1xJFW3Jw17GrWqgFWFkws5XrWYkan7Wr15Ar17XryxWrs7KF4Yga9xWrZ5uwnx
	Aas2g3s3Ar1kZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jI
	sjbUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Recently, when compiling bpf selftests on RV64, the following
compilation failure occurred:

progs/bpf_dctcp.c:29:21: error: redefinition of 'fallback' as different kind of symbol
   29 | volatile const char fallback[TCP_CA_NAME_MAX];
      |                     ^
/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h:86812:15: note: previous definition is here
 86812 | typedef u32 (*fallback)(u32, const unsigned char *, size_t);

The reason is that the `fallback` symbol has been defined in
arch/riscv/lib/crc32.c, which will cause symbol conflicts when vmlinux.h
is included in bpf_dctcp. Let we rename `fallback` string to
`fallback_cc` in bpf_dctcp to fix this compilation failure.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 2 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 1d494b4453f4..409a06975823 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -285,7 +285,7 @@ static void test_dctcp_fallback(void)
 	dctcp_skel = bpf_dctcp__open();
 	if (!ASSERT_OK_PTR(dctcp_skel, "dctcp_skel"))
 		return;
-	strcpy(dctcp_skel->rodata->fallback, "cubic");
+	strcpy(dctcp_skel->rodata->fallback_cc, "cubic");
 	if (!ASSERT_OK(bpf_dctcp__load(dctcp_skel), "bpf_dctcp__load"))
 		goto done;
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index 02f552e7fd4d..7cd73e75f52a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -26,7 +26,7 @@ static bool before(__u32 seq1, __u32 seq2)
 
 char _license[] SEC("license") = "GPL";
 
-volatile const char fallback[TCP_CA_NAME_MAX];
+volatile const char fallback_cc[TCP_CA_NAME_MAX];
 const char bpf_dctcp[] = "bpf_dctcp";
 const char tcp_cdg[] = "cdg";
 char cc_res[TCP_CA_NAME_MAX];
@@ -71,10 +71,10 @@ void BPF_PROG(bpf_dctcp_init, struct sock *sk)
 	struct bpf_dctcp *ca = inet_csk_ca(sk);
 	int *stg;
 
-	if (!(tp->ecn_flags & TCP_ECN_OK) && fallback[0]) {
+	if (!(tp->ecn_flags & TCP_ECN_OK) && fallback_cc[0]) {
 		/* Switch to fallback */
 		if (bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
-				   (void *)fallback, sizeof(fallback)) == -EBUSY)
+				   (void *)fallback_cc, sizeof(fallback_cc)) == -EBUSY)
 			ebusy_cnt++;
 
 		/* Switch back to myself and the recurred bpf_dctcp_init()
@@ -87,7 +87,7 @@ void BPF_PROG(bpf_dctcp_init, struct sock *sk)
 
 		/* Switch back to fallback */
 		if (bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
-				   (void *)fallback, sizeof(fallback)) == -EBUSY)
+				   (void *)fallback_cc, sizeof(fallback_cc)) == -EBUSY)
 			ebusy_cnt++;
 
 		/* Expecting -ENOTSUPP for tcp_cdg_res */
-- 
2.34.1


