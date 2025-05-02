Return-Path: <bpf+bounces-57284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB59AA7AC3
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE3C9E0516
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9520CCCC;
	Fri,  2 May 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrdP2DL6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445EA1FAC48;
	Fri,  2 May 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216992; cv=none; b=S1YwlFkWC4Njk/ag1oIjil9g6ScWnU2ontbX6yqp/A0yxoZdwdEZwnvGtK8QdIOeMC4PnzGodcqY5LXtqILL+4awKCjA9sUQYnPlsGazPsgMIKtKiQNxJFx0jdmrui1TsqM/Ut+kOFGU2aoxGKcn75aV3/ZqOXJqrBX0rzWQxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216992; c=relaxed/simple;
	bh=h7914hPzIB1s4VYY437uzzwjiwHqmYSy67zGZfIQcZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6hVG4iJmFH234zHvnlCNHhG/37BMsD5Sd5vu18MZavUOFVhh29E9IWAqWDVhpRI07mFJtOBs/xkNRfz/0cyY1G3+1A8pXRwTDBrHIYkNTaTSBuspnTTDfzIOM42/u2u1bXD12XeqRN9hYuGR3Ux3vMxwctY3eEUJnLDDsRY16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrdP2DL6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33677183so30100615ad.2;
        Fri, 02 May 2025 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746216990; x=1746821790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqaNgKeGThUQ6f+Ev4JAqaFPHXVZyijKyvVLH0FvmPI=;
        b=CrdP2DL6ysFeJeaYxZqJAC64/+eLUmZZWUEuS14HTop7rRrE6gnAh4IoISN/JYJt5p
         0GDlzPcOyqT8aioHUuaFlcBB6c8VCW43/6AAbh5uAt6W081M7hSKrGeY3eCL4PhYOrG/
         e94SxrT57M4rxW/+hl3aQypA/mw/Xs17h26+XRbs3KVd68wCewc9FS2E5ApLkrr+XS10
         81cbDlVa2cecwh2lDtJl3nszkYIOQ0TlF4UerrHgdDppdUKm6922/QK5x8f8HHiTMIP/
         iarMlnmGEl3ZAEo1Fe+UdgkLG/BG/WwwXtC+vTjXg4Vba9Gl7n+3gACC6mQNT9LlYwN+
         hD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746216990; x=1746821790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqaNgKeGThUQ6f+Ev4JAqaFPHXVZyijKyvVLH0FvmPI=;
        b=eeLiVUDpS+2j36L/8F6oNiBIeYucvNbRhd2mQV9zVKfV0H7lg2Cw7J7UyPu5OGqogt
         69lHuXnHIUz2RSn+o2+7n0pHUA+QksYlnTkbF4lUj3jbJAgR/+1wbCVt02QwdaP+XJ0K
         AcAJ9GUP8poeCLCFYeeWL61F8TRphtVGU5KE1okJ61xCnCnCX5tq2VOumwRAydi4wX9h
         r1p3D3xK9IGGodN+uPZ1pKhGBqTCMjrt70uGtqpjQYFgQwwc27zjaOQdqoDQslJ0mYhQ
         mFLdLk6OD08lh/bs2nWLW4pqqUZBlpb+8+Ilteb2xPf58hgZq0qYtSwDnQVSSNZMOGkH
         k85g==
X-Gm-Message-State: AOJu0YysuTISCTPb3cggxgVOJRaHun6wS3ZppCzgKEX1PpySN182BywE
	efHAvYUj022TrQwdY57lMAwviLMeHWll1DknW+XiXvIsSPVqyUdljDaRZw==
X-Gm-Gg: ASbGncsohaoZK3Jaeu8aRlA2PtQim0d/E0w8aRjnHC8k1eF/WgyXdRpIQoI+bZhwb1+
	oeocZmOGuSnKNHpLSTTLI4sJ+HU45b0BOCnCLfosuv1vhzZWpVaTT8JK+KD0JpggA9jyOLyL+xe
	O5dh5WyFwa1aaCrS7UeCW9Cyg3VTdy40k2NCbpEu1bFzmeI62faN7Wz05yfWCpKkEbu8c3LjuCt
	GV8iw/fU/Bk/LCEkwyu0xSlxyhNSvcZ5O5JX3okTz+X50yDNQNNBelVkhpp0fn95Hw1IGXs1MFD
	1a17TB44WLhAOarw5+RxL0TIa6FFm2f90woKi9lLxA==
X-Google-Smtp-Source: AGHT+IG1Qge8qujO/SIeuASY2frHmtONpqTpgb0ud035QGQ1CV4S5UrvDgfRKBUx+Hbiu60n8Jh+CA==
X-Received: by 2002:a17:903:22cb:b0:223:54e5:bf4b with SMTP id d9443c01a7336-22e1036c14bmr66489735ad.25.1746216990309;
        Fri, 02 May 2025 13:16:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522fa58sm11850895ad.242.2025.05.02.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:16:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v2 5/5] selftests/bpf: Cleanup bpf qdisc selftests
Date: Fri,  2 May 2025 13:16:24 -0700
Message-ID: <20250502201624.3663079-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502201624.3663079-1-ameryhung@gmail.com>
References: <20250502201624.3663079-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some cleanups:
- Remove unnecessary kfuncs declaration
- Use _ns in the test name to run tests in a separate net namespace
- Call skeleton __attach() instead of bpf_map__attach_struct_ops() to
  simplify tests.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 50 ++++---------------
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  6 ---
 2 files changed, 11 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 53154544b28c..c4d797f95da9 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -50,42 +50,32 @@ static void do_test(char *qdisc)
 static void test_fifo(void)
 {
 	struct bpf_qdisc_fifo *fifo_skel;
-	struct bpf_link *link;
 
 	fifo_skel = bpf_qdisc_fifo__open_and_load();
 	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
 		return;
 
-	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		bpf_qdisc_fifo__destroy(fifo_skel);
-		return;
-	}
+	if (!ASSERT_OK(bpf_qdisc_fifo__attach(fifo_skel), "bpf_qdisc_fifo__attach"))
+		goto out;
 
 	do_test("bpf_fifo");
-
-	bpf_link__destroy(link);
+out:
 	bpf_qdisc_fifo__destroy(fifo_skel);
 }
 
 static void test_fq(void)
 {
 	struct bpf_qdisc_fq *fq_skel;
-	struct bpf_link *link;
 
 	fq_skel = bpf_qdisc_fq__open_and_load();
 	if (!ASSERT_OK_PTR(fq_skel, "bpf_qdisc_fq__open_and_load"))
 		return;
 
-	link = bpf_map__attach_struct_ops(fq_skel->maps.fq);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		bpf_qdisc_fq__destroy(fq_skel);
-		return;
-	}
+	if (!ASSERT_OK(bpf_qdisc_fq__attach(fq_skel), "bpf_qdisc_fq__attach"))
+		goto out;
 
 	do_test("bpf_fq");
-
-	bpf_link__destroy(link);
+out:
 	bpf_qdisc_fq__destroy(fq_skel);
 }
 
@@ -97,18 +87,14 @@ static void test_qdisc_attach_to_mq(void)
 			    .handle = 0x11 << 16,
 			    .qdisc = "bpf_fifo");
 	struct bpf_qdisc_fifo *fifo_skel;
-	struct bpf_link *link;
 	int err;
 
 	fifo_skel = bpf_qdisc_fifo__open_and_load();
 	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
 		return;
 
-	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		bpf_qdisc_fifo__destroy(fifo_skel);
-		return;
-	}
+	if (!ASSERT_OK(bpf_qdisc_fifo__attach(fifo_skel), "bpf_qdisc_fifo__attach"))
+		goto out;
 
 	SYS(out, "ip link add veth0 type veth peer veth1");
 	hook.ifindex = if_nametoindex("veth0");
@@ -121,7 +107,6 @@ static void test_qdisc_attach_to_mq(void)
 
 	SYS(out, "tc qdisc delete dev veth0 root mq");
 out:
-	bpf_link__destroy(link);
 	bpf_qdisc_fifo__destroy(fifo_skel);
 }
 
@@ -133,18 +118,14 @@ static void test_qdisc_attach_to_non_root(void)
 			    .handle = 0x11 << 16,
 			    .qdisc = "bpf_fifo");
 	struct bpf_qdisc_fifo *fifo_skel;
-	struct bpf_link *link;
 	int err;
 
 	fifo_skel = bpf_qdisc_fifo__open_and_load();
 	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
 		return;
 
-	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		bpf_qdisc_fifo__destroy(fifo_skel);
-		return;
-	}
+	if (!ASSERT_OK(bpf_qdisc_fifo__attach(fifo_skel), "bpf_qdisc_fifo__attach"))
+		goto out;
 
 	SYS(out, "tc qdisc add dev lo root handle 1: htb");
 	SYS(out_del_htb, "tc class add dev lo parent 1: classid 1:1 htb rate 75Kbit");
@@ -156,7 +137,6 @@ static void test_qdisc_attach_to_non_root(void)
 out_del_htb:
 	SYS(out, "tc qdisc delete dev lo root htb");
 out:
-	bpf_link__destroy(link);
 	bpf_qdisc_fifo__destroy(fifo_skel);
 }
 
@@ -232,14 +212,8 @@ static void test_default_qdisc_attach_to_mq(void)
 	bpf_qdisc_fifo__destroy(fifo_skel);
 }
 
-void test_bpf_qdisc(void)
+void test_ns_bpf_qdisc(void)
 {
-	struct netns_obj *netns;
-
-	netns = netns_new("bpf_qdisc_ns", true);
-	if (!ASSERT_OK_PTR(netns, "netns_new"))
-		return;
-
 	if (test__start_subtest("fifo"))
 		test_fifo();
 	if (test__start_subtest("fq"))
@@ -250,8 +224,6 @@ void test_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
-
-	netns_free(netns);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
index 7e7f2fe04f22..3754f581b328 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -14,12 +14,6 @@
 
 struct bpf_sk_buff_ptr;
 
-u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
-void bpf_kfree_skb(struct sk_buff *p) __ksym;
-void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
-void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns) __ksym;
-void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb) __ksym;
-
 static struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
 {
 	return (struct qdisc_skb_cb *)skb->cb;
-- 
2.47.1


