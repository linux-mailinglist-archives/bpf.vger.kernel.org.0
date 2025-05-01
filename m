Return-Path: <bpf+bounces-57166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C902AA663C
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B581BA617E
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA71E26B0B6;
	Thu,  1 May 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3FbD09Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3072690EC;
	Thu,  1 May 2025 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138634; cv=none; b=GEjbLVoG31PrLmQx9fVNNOX/O6ZVIDcRYWgbFd2WmuLJ89xr9AXSdC9MhhD70kLx/2A0eipUgqUybp+isDMmxrp5y6GtgI4oTB7Z70xXDzh35sVwDg0F4txV6ENUtDleiTgm6Ururimw3w1ciXlhZGNeAku3L5iwDc7Eln5zz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138634; c=relaxed/simple;
	bh=lO2u3VJCsueg9xV30Z4hy2soY4RgbCxO/T7FbQ+Z+XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=looUTFLUFtxilBwY6KQySeIb2OBZElJOnTsweGdUV9qL5ZzCzJfX5DcknP4bcDrgxmYwvPX4dLcY7YfzWjfQ6kiBOaCDjK3INKoF59QeVM8eTcaz24u3LvuyVSHmy2LSyvcFpgcwu/E61MegNaHGCw6+CfgJQOqRWza/3ruLTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3FbD09Y; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b1a1930a922so1041495a12.3;
        Thu, 01 May 2025 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746138631; x=1746743431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NblxzsqS7O+HCyVf+pNfGGrnJpw2Ljjumz78jhM5b1E=;
        b=f3FbD09YUYP/Fm+sSa/87nc7u56KWlu3U97QLLe3fiMRsonIRJMLNso/R9ZyEU8Khr
         VX4yxlD6VrzkeNPu4LSNypqK22MD3Epznrn0e03JwJnrObCaeoAPwdi+9hzBgdhIBDhG
         5OFW9Nt/kmXObrWN5r6kID1OrdQgP2IGClJr4r1rsFn/25ChwFY/F5rAVzz7ochMFkDv
         QGhkO4euhes2Nu9tLHm7SRQiqQATJrLLNyyry2uC9YVGa27/9QjW0z8vFhFXoVIaSJUm
         Cvu75wTTdLHzkRMtOGFMl0U78N94P+Bj/gChkIKeecVbCa9xernUFZyODoKowTyAhrVi
         ULfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138631; x=1746743431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NblxzsqS7O+HCyVf+pNfGGrnJpw2Ljjumz78jhM5b1E=;
        b=KMOIpWet6dzdnLZCIHQ8tAWMJiNlGfm+nVdHEXPIPjpthC4FEXYkcAirs1zD5zJCBv
         9hMRt2EEq1LAhKFfjHwTpKqiXefmCPHosnqB2C9wgUiJwFL/aGT2SAoBSnleo3VM6VSV
         zh3iUMNvNs5X9v5cuk4JXBwNgS8IgCxl0ux82f6pnRoMhklX2VQEp9exsa14OVjzxn7d
         zSAxLriEFxglYoo/cyAC+zUPos10wl0iLdLvj+pqVrbBNO4SsNAA7MbBGXQRjymC1vao
         z/HkJ6mFtJMM+pJ8YKAyhGtiDktL73Mu9mWNM0hTtbi8M9nzyrS46ImLyeVZJyEwiFb0
         Oh8Q==
X-Gm-Message-State: AOJu0YzCKWpoIcyuPSCzMwm51/C2lq9wcnBBAC0AbYEUI11NYOI8aXWE
	DTFlzRpAnck+1mhnoSMQpvuruHoCuv5edQPh2poKrFf2iiOb5Yo/1g3K2A==
X-Gm-Gg: ASbGncvuH6IVQESHthK8TAZe8dmbO1VXSGbJ3KHLN2NRdro8gy9qvSge5psfYyyJBhu
	zQjUgLXbjY/Ot6JcRWzmJOiL9GZq++wEo5pPkLM2rjG5FxnuGN5woonBwGmCbSdOhuGGgdbxKCA
	gGe8tyPsX4o9ASgMUxkPptMjs8SzHRXGG7B475s3vbKe0+vZZgl0iBEEVtaUgEYiEeyqsl4TgRP
	1p+Td8zw6p1EM0EujKHGK3CO/2ZgH3pXA2m8LUVja6XugIzaT3j4kUhoyfv/9UPmI37Aha3uRHe
	7RF0t0/KTxiQc02cXrwHy1p0hO6OUdw=
X-Google-Smtp-Source: AGHT+IE9ZxV4cKuk64Bb8L3jukv3Heh18bEqmNG8QwQthdTGPSCYyS9IxWy76fqsNrWQShq6cL6C1g==
X-Received: by 2002:a17:90b:2641:b0:30a:3e8e:492c with SMTP id 98e67ed59e1d1-30a4e682ad7mr953478a91.32.1746138630829;
        Thu, 01 May 2025 15:30:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e10914b21sm1440645ad.178.2025.05.01.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:30:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v1 5/5] selftests/bpf: Cleanup bpf qdisc selftests
Date: Thu,  1 May 2025 15:30:25 -0700
Message-ID: <20250501223025.569020-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223025.569020-1-ameryhung@gmail.com>
References: <20250501223025.569020-1-ameryhung@gmail.com>
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c   | 10 +---------
 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h |  6 ------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 8afaf71cfadd..2c10816c2d9e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -249,14 +249,8 @@ static void test_default_qdisc_attach_to_mq(void)
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
@@ -267,8 +261,6 @@ void test_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
-
-	netns_free(netns);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
index 65a2c561c0bb..c495da1c43db 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -12,12 +12,6 @@
 
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
 
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


