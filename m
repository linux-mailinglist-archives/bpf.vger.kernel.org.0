Return-Path: <bpf+bounces-28035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01DD8B494E
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 05:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3B81C20FA9
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 03:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72A823A6;
	Sun, 28 Apr 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAa0tBlv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93820ED
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273802; cv=none; b=dojvc51ZwK5TLZZt3mv9x5JY0VqdPY6H8kQisR9Q//eIEKaTlmEek4QqEvyZCt0Q08Ukgu9glS+ny+h7OOpxmlGfb9waZrvX9Xn05TfQDCrJOnnC6Cy4HkzZWElLDog0SU1A/xwHXuuBC7531uAD8BtzbtqD8VL7mukxww2bFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273802; c=relaxed/simple;
	bh=f3ERFM9Oj5nWnafsoH+s7sxf2OiWiW9ATrnjp9gISoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7/TV1op2txl8pyUEg9Kq1knUvMgv5WoR/MD/zDP+ha+l4k98POvvYM5L70n9hlQj8VD7YSHbmCrqeSdDx17UKG8yrRfwX0aaq1a684gdqdGd68v6zaKmv1Pi8wxCvoNPmIXL72Eowp9qdf5o7GugEg5llxzj9lAP8fK1+2Qyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAa0tBlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40ABC4AF17;
	Sun, 28 Apr 2024 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714273801;
	bh=f3ERFM9Oj5nWnafsoH+s7sxf2OiWiW9ATrnjp9gISoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAa0tBlvus6oNXBbcPGUbru+p+R/4Aft1ZAvPnuy1V6AOh5qn/YP0APSu2ZxlyINN
	 ibT3DbrhQsLwMsckVjEq7b+X5xC0SIBeypqNk0fJcRzho2yFv39E7NPR3YfQuFBQNS
	 ypDsnX4eU3JT3s9HLuipIr/qxseAE8yAdMAVvckJ/tZnbz8455EZS/l3O4VZS+zHtF
	 yTXKleiMP7RSYYZv6Puo7a4Vktqpy6MrYSlxtvrtfaF+WcbUVSQH2ioGl5dhcD0hBY
	 3txMjTxxIedhnUiHSTyWkKZexje3uPM3BrFtZiBC7dn4wwr1G6zES9wrLPJ0mkcz+D
	 um2CB8C6fjUxg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: validate nulled-out struct_ops program is handled properly
Date: Sat, 27 Apr 2024 20:09:54 -0700
Message-ID: <20240428030954.3918764-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240428030954.3918764-1-andrii@kernel.org>
References: <20240428030954.3918764-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftests validating that it's possible to have some struct_ops
callback set declaratively, then disable it (by setting to NULL)
programmatically. Libbpf should detect that such program should be
loaded, even if host kernel doesn't have type information for it.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/test_struct_ops_module.c    | 18 ++++++++++++++++--
 .../selftests/bpf/progs/struct_ops_module.c    |  7 +++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 7cf2b9ddd3e1..bd39586abd5a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -66,6 +66,7 @@ static void test_struct_ops_load(void)
 	 * auto-loading, or it will fail to load.
 	 */
 	bpf_program__set_autoload(skel->progs.test_2, false);
+	bpf_map__set_autocreate(skel->maps.testmod_zeroed, false);
 
 	err = struct_ops_module__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_module_load"))
@@ -103,6 +104,10 @@ static void test_struct_ops_not_zeroed(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
 		return;
 
+	skel->struct_ops.testmod_zeroed->zeroed = 0;
+	/* zeroed_op prog should be not loaded automatically now */
+	skel->struct_ops.testmod_zeroed->zeroed_op = NULL;
+
 	err = struct_ops_module__load(skel);
 	ASSERT_OK(err, "struct_ops_module_load");
 
@@ -118,6 +123,7 @@ static void test_struct_ops_not_zeroed(void)
 	 * value of "zeroed" is non-zero.
 	 */
 	skel->struct_ops.testmod_zeroed->zeroed = 0xdeadbeef;
+	skel->struct_ops.testmod_zeroed->zeroed_op = NULL;
 	err = struct_ops_module__load(skel);
 	ASSERT_ERR(err, "struct_ops_module_load_not_zeroed");
 
@@ -148,15 +154,23 @@ static void test_struct_ops_incompatible(void)
 {
 	struct struct_ops_module *skel;
 	struct bpf_link *link;
+	int err;
 
-	skel = struct_ops_module__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
 		return;
 
+	bpf_map__set_autocreate(skel->maps.testmod_zeroed, false);
+
+	err = struct_ops_module__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
 	link = bpf_map__attach_struct_ops(skel->maps.testmod_incompatible);
 	if (ASSERT_OK_PTR(link, "attach_struct_ops"))
 		bpf_link__destroy(link);
 
+cleanup:
 	struct_ops_module__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 63b065dae002..40109be2b3ae 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -63,10 +63,17 @@ struct bpf_testmod_ops___zeroed {
 	int zeroed;
 };
 
+SEC("?struct_ops/test_3")
+int BPF_PROG(zeroed_op)
+{
+	return 1;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops___zeroed testmod_zeroed = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2_v2,
+	.zeroed_op = (void *)zeroed_op,
 };
 
 struct bpf_testmod_ops___incompatible {
-- 
2.43.0


