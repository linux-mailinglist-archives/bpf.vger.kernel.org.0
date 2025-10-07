Return-Path: <bpf+bounces-70517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91376BC222E
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 18:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B381E4F8148
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722C2E7F14;
	Tue,  7 Oct 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndegEVzh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5228F5
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855177; cv=none; b=hBexsAsR0waWLu2mU+haG/tnCFhhtnNO4/wjxrVX1guJQLT8fyWDboK0YQGbfwiOYXRYkWIzFwsHuNUjRlCBURCMWQGGOuAlIpZmbtLcMCbDZ2axW4vB+vHEJzi+HUIlIlJsCkciyRXwg8l6p9Hh/SbovWnkZKSGyv2FSjiYU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855177; c=relaxed/simple;
	bh=GDHqtQBySMepgWGLQMoimWGa5eYw/Q+5JpTqXuz88TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geCXJviyJ90+223wtfx2+7ojoapSH3DQqIZzmMESlgVsvQWBU2EYoJtI7CT35i4ml9fy/ul6rT28hnonvFl8InRl8HBB9EXpihAGqg0QrRixGUpj8efH3RjrT2GiaVSI2WSfg30L3Tecrv9wQP1lcPyDTRi1SjegLTKglG/x+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndegEVzh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so72484095e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759855174; x=1760459974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgO0PQP2c8pn6Qm87YdiruJbTohbvNdV4I93NPIreaU=;
        b=ndegEVzhV5arv19dDJOitc82yjolY2f8IoFjZs4ghDF7c0wS2fjo3vEp04qwMPSyAg
         yWWJl4X3HckTSL7p5DzBiF6QlJyCQ/sysBu1dzUE5b+Ss93/FQrjrwOvWms/3SU/ORNC
         gZW0zkm2hhtatXTQsgu/zL971vo1AEun0KxwJLT2u1texf33v/2KgdasguvCxoBgs4vL
         1rmhiGbwvRpHiN5KxD5m4mlT4kKw5PDAfc/J5gnA1Ixp9WR23MFGenqzVSYWtS2kGubd
         e5gCGPtq0046UclFIusIWSGUx1WpthhOStjw8mJUdM3ByFTDexKNSFCs35+O8Bex12/2
         IOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855174; x=1760459974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgO0PQP2c8pn6Qm87YdiruJbTohbvNdV4I93NPIreaU=;
        b=rS7W+8ikYD9yE3VEOgCNOj1SC2qotBDZXgtA2GKl4nPBxleNFhMyLwAgVks4DcY8v+
         oOXODcjdGHbxNZp00XnsbGLFUUoOwO24KSMHDrRc7MdTIY8jYXKjiU0Rda08FEJD1imR
         VK87WMNPx5rxLyGvJQEOGRxPAKnMdybKDcy6PRE+JE7vkpBKHT6NNxHwaDJ6pAUL0L3s
         PEvYbGSydQHFtjI3+chZt6tNgTjNx1pMPp0Up12TuXoG5xJsUjXPwS69Ai1eDySdq7//
         tDbXJc+ZmHkDNv9fMZ3szKhRcST/rSQnea6MRHv9UUXMXGDSJ482PkvT3s9RdprtKXo6
         uSJw==
X-Gm-Message-State: AOJu0YzDOdrupL+rzX/tdDuckV155tHPS3vLVacyJP6sUQgl/o3j2n4q
	Wj1np88LADhrrJGFDjIZBP8afLcZSrofAN3UyjTvdARgqqu5mLPUWjmFccLb9A==
X-Gm-Gg: ASbGnctvPm5f5HgyN7wFA6hqSrW7/6bieC/aZU38kYQ1UpXZfThe/YhPGEUzlIdf/1y
	o3aiuQ0VuqLU/zJ3Z9gIDFuaqdzZ89VcvuyKDOOBt3Pr0KdL4ERu+Ho3opiRUbbqgEkmsspdCdQ
	FdPoDP/PTTyYPdZhwPnQfoVrxrQ7no6cYyaIeKXCpe6BXoVsRDyrznYbC1p89bazI3H5uxPe55Z
	Dk0P24qocKzd59wi05Iesypr8RPNBzMAmARo7pEAK3xdQ8yPTMoSyEXjx+houO3XAm8aXpyIovY
	3m82jxVJSce6z//tOT2dFCjeLjz86ONam5K1fI4kU6qMKn64gr5bkdaQCQ/2wF8SGeI/yJYJwVR
	HyBXX1p+NcZOY4NnnFv/EErnV/jTatU18on2GBBkqfx9n5g==
X-Google-Smtp-Source: AGHT+IGLhOpnZI2LYWTZA99oxYS5lb7+8M0QBP1kPBbWYyQLNNpGNQESKPe0Z5cvDhtU9lSulFK1nQ==
X-Received: by 2002:a05:600c:1e28:b0:46e:394b:4991 with SMTP id 5b1f17b1804b1-46fa9aa0e3amr2084465e9.11.1759855174128;
        Tue, 07 Oct 2025 09:39:34 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm26211659f8f.2.2025.10.07.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:39:33 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: add bpf_wq tests
Date: Tue,  7 Oct 2025 17:39:29 +0100
Message-ID: <20251007163930.731312-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007163930.731312-1-mykyta.yatsenko5@gmail.com>
References: <20251007163930.731312-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_wq selftests to verify:
 * BPF program using non-constant offset of struct bpf_wq is rejected
 * BPF program using map with no BTF for storing struct bpf_wq is
 rejected

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/wq.c   | 44 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/wq.c        | 17 +++++++
 .../testing/selftests/bpf/progs/wq_failures.c | 23 ++++++++++
 3 files changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 99e438fe12ac..e4241119769b 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -38,3 +38,47 @@ void serial_test_failures_wq(void)
 {
 	RUN_TESTS(wq_failures);
 }
+
+static void test_failure_map_no_btf(void)
+{
+	struct wq *skel = NULL;
+	char log[8192];
+	const struct bpf_insn *insns;
+	size_t insn_cnt;
+	int ret, err, map_fd;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .log_size = sizeof(log), .log_buf = log,
+		    .log_level = 2);
+
+	skel = wq__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "skel__prepare"))
+		goto out;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "map_no_btf", sizeof(__u32), sizeof(__u64), 100,
+				NULL);
+	if (!ASSERT_GT(map_fd, -1, "map create"))
+		goto out;
+
+	err = bpf_map__reuse_fd(skel->maps.array, map_fd);
+	if (!ASSERT_OK(err, "map reuse fd"))
+		goto out;
+
+	insns = bpf_program__insns(skel->progs.test_map_no_btf);
+	insn_cnt = bpf_program__insn_cnt(skel->progs.test_map_no_btf);
+	ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
+
+	ASSERT_NEQ(ret, 0, "prog load failed");
+	ASSERT_HAS_SUBSTR(log, "map 'map_no_btf' has to have BTF in order to use bpf_wq",
+			  "log complains no map BTF");
+out:
+	wq__destroy(skel);
+}
+
+void test_wq_custom(void)
+{
+	if (test__start_subtest("test_failure_map_no_btf"))
+		test_failure_map_no_btf();
+}
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 2f1ba08c293e..25be2cd9d42c 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -187,3 +187,20 @@ long test_call_lru_sleepable(void *ctx)
 
 	return test_elem_callback(&lru, &key, wq_callback);
 }
+
+SEC("tc")
+long test_map_no_btf(void *ctx)
+{
+	struct elem *val;
+	struct bpf_wq *wq;
+	int key = 42;
+
+	val = bpf_map_lookup_elem(&array, &key);
+	if (!val)
+		return -2;
+
+	wq = &val->w;
+	if (bpf_wq_init(wq, &array, 0) != 0)
+		return -3;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index 4240211a1900..d06f6d40594a 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -142,3 +142,26 @@ long test_wrong_wq_pointer_offset(void *ctx)
 
 	return -22;
 }
+
+SEC("tc")
+__log_level(2)
+__failure
+__msg(": (85) call bpf_wq_init#")
+__msg("R1 doesn't have constant offset. bpf_wq has to be at the constant offset")
+long test_bad_wq_off(void *ctx)
+{
+	struct elem *val;
+	struct bpf_wq *wq;
+	int key = 42;
+	u64 unknown;
+
+	val = bpf_map_lookup_elem(&array, &key);
+	if (!val)
+		return -2;
+
+	unknown = bpf_get_prandom_u32();
+	wq = &val->w + unknown;
+	if (bpf_wq_init(wq, &array, 0) != 0)
+		return -3;
+	return 0;
+}
-- 
2.51.0


