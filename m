Return-Path: <bpf+bounces-70752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA28BCDFA4
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 18:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0138D425E3F
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623ED2FC01C;
	Fri, 10 Oct 2025 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK1FC+sd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0461FBCA1
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114776; cv=none; b=JweHAVqTV3mNhXK9UBpW39Tyee0VhTZyVoP5MbivxvFbnr7ZKa3jrDI2JaYBHexDYYBL64gsnJ3Fh2uQ8Rqfz70/POz+YT9QFiOsP+eSSBdMP0tNje4zj1eeUcedIGovxzbDOSLa6GOHh9SuRSDXHB4gMhjrcNwqHlBXxx1NaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114776; c=relaxed/simple;
	bh=OK3mlYHrBhjsqdShYPkPY39S/qJMteE9QrBk0ffHnxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+VjJbu02KQHezrmMKE1k3RkoD/QiK3bCqm7oNyYdQSW+M/Mma0bEwaDxSXM4iTnfTv1pRLC0qAtaagOQwhNOPtGTxIbp/UlHzOebBgfTXqJ5U8XVRbpGxpKlbfvfkBnThaPz6FOeY910lxe00yrw8mFx+zjV1al1mREaOjZFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK1FC+sd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so25680335e9.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760114773; x=1760719573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuD2O+9xxsRCwa8mJDr/TYBbIhIc5VvWZjuKU+rYkRU=;
        b=eK1FC+sdkGU8fbn22HXnr+68DBaPTtEuY1ZjldxM5Pk1PEhGQ2Ol37cuGU9KX0mRxt
         8oYGUKfcKcqFs+9ssbYZJClpi4E22RftF6RJefu/CNRv9Pok1z3k3jhpaghim06uJSXE
         3hfMB1no57n4eJIDtMyBadLH8RoFOPRn72rbaMeTUKQQjgIpzr86r7oZl3mmrHdNy8wG
         uOa1cv3OEKbJY9pbvhUCXXbRyVP8Q0NfvluNvwt6dCpeOfjUbf+Qu6TnUPbGI80qngZa
         BA/IojgpA075epQHA0/TWQhblKa+4vY8FrsflYfBnf+ux8IQOBr7q78H2bawOZEdjcww
         c9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760114773; x=1760719573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuD2O+9xxsRCwa8mJDr/TYBbIhIc5VvWZjuKU+rYkRU=;
        b=iqgaPba9ddmhNwsRe3jY5I2p0AmXd/ut7N1dkqeIw2JWk8jbnksCp1HzPRcl1oy9mv
         UqJRBQGpovWzqzfFsNZ6KgPdBHxRYQp9mlMku6IyHqx+56ic3W0ge1OJ/JA8Ii4A0RA4
         fDtqSTpVvlBAwl7FbsSQ/ohwx0Rur6qS67QfEYX5ZExiq9xxTbDaS+lMYxvr6EEDTN64
         tbRAzCmE66amLYEA0tWzjJb+XYqcKPNMMFpJqod3RGFj36ptbh3Cd/iFPZxprTt8arQK
         t2TKjUlpxQ1PzpA7X9RHIPKPqo2WefHO/7a4iOjzYxD0AduXWHEcTMoPPWcg1BrDsGm4
         vhew==
X-Gm-Message-State: AOJu0YzxFmOOiIBkh62D8beuUyN16Ee7Gp8HhblGJImi/rPqCWz51dEc
	pdmrhKYUB7k5ls+K/y7E0EPkk2gGe1TQ13oYlyVuF0ByCCLbjHGpzDojqISIzw==
X-Gm-Gg: ASbGncsvLwdBDY29NIIgkj/I8bKcWWfBd8BEVG7ayUmXxeh5MIFRaCGpuSHSub69VE3
	nUToVWFdy0WyALhcXhFMAI7qHtB3wgHx546dDNlxlkqkCEfZXnrqRXoHumg1YHSFbfz7jV/ZsfH
	4uO95uJxKEjauwn3KQjWOyPxH1TYpznpDgARiwErm21OX07aWW5wsM0zegTPv9n2Cslgxkcp2r6
	cUhsEHD/uC2rXRB/aaF4aUdAVquSvxypY80y1xKmAg97wtrYXkXysUkjWv47RcJPA5ceHOksFRl
	gnGpqVun7Vu3Htvh51vupwfyw9GKWS+eLExXYXydKW4aLcO7mRV4VY05lwsatcgQJLTjnDgtg63
	DEq0AdhCxD+U04moOx5pB/dt38uRzCvvt1IJTNrWuj98p
X-Google-Smtp-Source: AGHT+IHoxppG42WqTIsFnoWip4CtH/uXtfz94lCD1T6yWjHdCYaPVyTnBy30N4LY4ldnZPQb15gFmA==
X-Received: by 2002:a05:6000:2dc9:b0:425:86c8:c4ff with SMTP id ffacd0b85a97d-42666ac7259mr8506463f8f.22.1760114773365;
        Fri, 10 Oct 2025 09:46:13 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0987sm4891243f8f.38.2025.10.10.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 09:46:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: add bpf_wq tests
Date: Fri, 10 Oct 2025 17:46:05 +0100
Message-ID: <20251010164606.147298-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
References: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/prog_tests/wq.c   | 56 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/wq.c        | 17 ++++++
 .../testing/selftests/bpf/progs/wq_failures.c | 23 ++++++++
 3 files changed, 96 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 99e438fe12ac..15c67d23128b 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -38,3 +38,59 @@ void serial_test_failures_wq(void)
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
+	if (!ASSERT_OK(err, "map reuse fd")) {
+		close(map_fd);
+		goto out;
+	}
+
+	insns = bpf_program__insns(skel->progs.test_map_no_btf);
+	if (!ASSERT_OK_PTR(insns, "insns ptr"))
+		goto out;
+
+	insn_cnt = bpf_program__insn_cnt(skel->progs.test_map_no_btf);
+	if (!ASSERT_GT(insn_cnt, 0u, "insn cnt"))
+		goto out;
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
+	if (!ASSERT_LT(ret, 0, "prog load failed")) {
+		if (ret > 0)
+			close(ret);
+		goto out;
+	}
+
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


