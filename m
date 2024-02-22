Return-Path: <bpf+bounces-22536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583D8605AC
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 23:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF861F250E8
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AEC137926;
	Thu, 22 Feb 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpmBon58"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC3137925
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640797; cv=none; b=jdz7udXgru5Ih0cTiSgTGOWNtG9ksDunNWd1rOXrOXQi9zbdbet4ALpQFPPyC5wuFMEfSPZRnHu4ybhmZeMk8C9jYifmsN5czFaB3SqO1WB09gid5XDkn+gfEzMxhnCH4jK39hsQ/9lu/SgERBB5QypCNi3F+cr3vv172zAik0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640797; c=relaxed/simple;
	bh=kY+MSlkBXyBkmnvb+NaTneZsRI1XZ8ED3i+XLagur6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oa8obt+dMAWUC+lMbg2ltz3v90d6oGrhfdUPhvN2L/TNNz3ttuMmliYecq0AtZdsJ2BYovfXRDS7xQfwYXQ2lCzsMh7maU04JsHlxmnDGqnPd9GUU1CwM24LtNEr/VqpfX58u/+w1vMsyhlWW9b9jHn5eoFqkDPNR5i0B2Tdup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpmBon58; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607c5679842so2779987b3.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708640795; x=1709245595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvyBlmzvCQZn7YJtlhRv6cuFksnihPgBjQqmVbCumoc=;
        b=ZpmBon58zK1UX7kbSFOepJ4hs1qja/R8O5L4POFqykg3QH4FJgEVgiNuzj0qQMedme
         4unVGL5GSrlavi3/4CpK6BQa1ip0eWpVmUkVkibXIwXl0alL6odAX01QbIntxEDmDqP+
         V/EmAsHKF1DaWYSh3BxHTvqT54PTycWgbBiXL0QE4P2EnsK6Tazf+ifEazPQrQw4dxI+
         6qDpKuN0GOUBm5hLkSN8HAalXjZGhju0bOJXKQTclnSCSOH16tjFUSurz74J5Gmt6fdi
         eXd4tVaPFwvh7maOLhD1OkMhtTW3MiZgZSUSytMjH9johUDe5vKhpK7BFWre1uIy3JUe
         hMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640795; x=1709245595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvyBlmzvCQZn7YJtlhRv6cuFksnihPgBjQqmVbCumoc=;
        b=WQ71jFwsbRP+qJF32Hg7sFEyhRdEZ9stdeQcydxgFWaNIg7pu305PNlsklZFWVxH/b
         GrQ7W4lHkoPI1jXXIYUyll3rxr+NqeSbKKbHSTmHy/zAf9hB1+7BXO8Lhh+UChxZbO2h
         7mKyI+0hxoYRa0G98OzvvN+drbZgcGGnUCbwnwoHn8NSCjSkoXVJ6nNvo1Jfx0BJ8mpN
         FNKEsz5gTdczsuPAM0xbzqCXqAx5FU+1+IlkaVwEk14pohGVyir3UgZq2CuktDfkNsts
         4Dol5LTwikC1wySvOii1m3iDRuA4iixElte2dbZnZfWBVmEfYOnqB16OpHVbgIURylTx
         884A==
X-Gm-Message-State: AOJu0YzN9n+FQt7uesS9KbnLOsEZuEXlX8qYahLbeyCk/kWjAbej4Imb
	V4Rqzo2xK3QMHQqVkuG9MSkrlYrK1CEOx9duD/4P8fO1haXp54ewRs29nRf3
X-Google-Smtp-Source: AGHT+IE+Sv3rh+SRxHSqodb9K1iyCLLxOITK7SP6YoyxECdvH5005eWroJRx2bDsMCAqcHN3YsnM/A==
X-Received: by 2002:a0d:cb11:0:b0:608:b61c:1a4e with SMTP id n17-20020a0dcb11000000b00608b61c1a4emr207559ywd.15.1708640794528;
        Thu, 22 Feb 2024 14:26:34 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm3280666ywf.140.2024.02.22.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:26:34 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Test if shadow types work correctly.
Date: Thu, 22 Feb 2024 14:26:24 -0800
Message-Id: <20240222222624.1163754-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222222624.1163754-1-thinker.li@gmail.com>
References: <20240222222624.1163754-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Change the values of fields, including scalar types and function pointers,
and check if the struct_ops map works as expected.

The test changes the field "test_2" of "testmod_1" from the pointer to
test_2() to pointer to test_3() and the field "data" to 13. The function
test_2() and test_3() both compute a new value for "test_2_result", but in
different way. By checking the value of "test_2_result", it ensures the
struct_ops map works as expected with changes through shadow types.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 11 ++++++++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  8 ++++++++
 .../bpf/prog_tests/test_struct_ops_module.c   | 19 +++++++++++++++----
 .../selftests/bpf/progs/struct_ops_module.c   |  8 ++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 66787e99ba1b..098ddd067224 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -539,6 +539,15 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
 {
+	if (member->offset == offsetof(struct bpf_testmod_ops, data) * 8) {
+		/* For data fields, this function has to copy it and return
+		 * 1 to indicate that the data has been handled by the
+		 * struct_ops type, or the verifier will reject the map if
+		 * the value of the data field is not zero.
+		 */
+		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
+		return 1;
+	}
 	return 0;
 }
 
@@ -559,7 +568,7 @@ static int bpf_dummy_reg(void *kdata)
 	 * initialized, so we need to check for NULL.
 	 */
 	if (ops->test_2)
-		ops->test_2(4, 3);
+		ops->test_2(4, ops->data);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index c3b0cf788f9f..971458acfac3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,14 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+
+	/* The following fields are used to test shadow copies. */
+	char onebyte;
+	struct {
+		int a;
+		int b;
+	} unsupported;
+	int data;
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 8d833f0c7580..7d6facf46ebb 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -32,17 +32,23 @@ static void check_map_info(struct bpf_map_info *info)
 
 static void test_struct_ops_load(void)
 {
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct struct_ops_module *skel;
 	struct bpf_map_info info = {};
 	struct bpf_link *link;
 	int err;
 	u32 len;
 
-	skel = struct_ops_module__open_opts(&opts);
+	skel = struct_ops_module__open();
 	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
 		return;
 
+	skel->struct_ops.testmod_1->data = 13;
+	skel->struct_ops.testmod_1->test_2 = skel->progs.test_3;
+	/* Since test_2() is not being used, it should be disabled from
+	 * auto-loading, or it will fail to load.
+	 */
+	bpf_program__set_autoload(skel->progs.test_2, false);
+
 	err = struct_ops_module__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_module_load"))
 		goto cleanup;
@@ -56,8 +62,13 @@ static void test_struct_ops_load(void)
 	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
 	ASSERT_OK_PTR(link, "attach_test_mod_1");
 
-	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
-	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
+	/* test_3() will be called from bpf_dummy_reg() in bpf_testmod.c
+	 *
+	 * In bpf_testmod.c it will pass 4 and 13 (the value of data) to
+	 * .test_2.  So, the value of test_2_result should be 20 (4 + 13 +
+	 * 3).
+	 */
+	ASSERT_EQ(skel->bss->test_2_result, 20, "check_shadow_variables");
 
 	bpf_link__destroy(link);
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index b78746b3cef3..25952fa09348 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -21,9 +21,17 @@ void BPF_PROG(test_2, int a, int b)
 	test_2_result = a + b;
 }
 
+SEC("struct_ops/test_3")
+int BPF_PROG(test_3, int a, int b)
+{
+	test_2_result = a + b + 3;
+	return a + b + 3;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops testmod_1 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2,
+	.data = 0x1,
 };
 
-- 
2.34.1


