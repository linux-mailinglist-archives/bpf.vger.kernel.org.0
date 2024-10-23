Return-Path: <bpf+bounces-42869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA249ABCF5
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 06:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459571C227B8
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 04:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0174139CEF;
	Wed, 23 Oct 2024 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzPQUCRh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E378249F
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729658360; cv=none; b=Ctg3EtQJ8TNr7pBPy/65c5eSit318vIsKwoXYdtgct8v4eVR2JeNKC44Xr3WOP+Wd6hoinMZfsFu6K9niqkKL0Tgwn4bVOD9+LVCQ3PwlJkTmWQugsJOViHgCLEklgqPKBq55OW+POTHUvlLb6ETYiXHDxqvf4v3gL7/b/L47dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729658360; c=relaxed/simple;
	bh=R4koJzpIjYR86FSm3H9Em2fkW2MiW86BajO5KxHB+8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewDyELLYPGkKVSiVoD0EMsymLIqiGLeJj86dygJ6r9lpZzI+6a7x4Jm34eOGiRT2rMSvF5lIUgG+YjvdRn0ttxwKK5AzwQHflfjzbjbuJ8PohEj2LAG7Un0wfZ4GCrrcOHYVTBmvdoj90Q9GfIL6QdOjfTekGArQrCnWlyZ93Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzPQUCRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF11C4CEC6;
	Wed, 23 Oct 2024 04:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729658359;
	bh=R4koJzpIjYR86FSm3H9Em2fkW2MiW86BajO5KxHB+8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzPQUCRhK3PySkrIrQbecac2Ix8mSHPtpvhxkBxVTZ3RFMcZeJNLmBqupBNLEO55e
	 lIWqoC9YpsGjlKZUGgRiyZedaozxW0AlKGCq/Xe6MbJn/aaZqoMQtUVSNwAbj7/S45
	 5sriQyv3DhILfuP8AfFVpKw0W0M+YNC30X2h9/t5WW8NDX5LF+KcyfUc+aE8xVkgl9
	 yt9AEERuFF32nBCi3mtNR3bgAoextHSCkpw/IRZ0/qadpc5xjAQZnfuBHcx027w1/q
	 ETqs+u0VyamhZ6f71EnMbZ78//aLyb0zEtr+O7pxArE8W+Zkf8OXwrf5Q8fjKMsLWO
	 Xbfm9yM6dStbQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: validate generic bpf_object and subskel APIs work together
Date: Tue, 22 Oct 2024 21:39:08 -0700
Message-ID: <20241023043908.3834423-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241023043908.3834423-1-andrii@kernel.org>
References: <20241023043908.3834423-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new subtest validating that bpf_object loaded and initialized
through generic APIs is still interoperable with BPF subskeleton,
including initialization and reading of global variables.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/subskeleton.c    | 76 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/subskeleton.c b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
index 9c31b7004f9c..fdf13ed0152a 100644
--- a/tools/testing/selftests/bpf/prog_tests/subskeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
@@ -46,7 +46,8 @@ static int subskeleton_lib_subresult(struct bpf_object *obj)
 	return result;
 }
 
-void test_subskeleton(void)
+/* initialize and load through skeleton, then instantiate subskeleton out of it */
+static void subtest_skel_subskeleton(void)
 {
 	int err, result;
 	struct test_subskeleton *skel;
@@ -76,3 +77,76 @@ void test_subskeleton(void)
 cleanup:
 	test_subskeleton__destroy(skel);
 }
+
+/* initialize and load through generic bpf_object API, then instantiate subskeleton out of it */
+static void subtest_obj_subskeleton(void)
+{
+	int err, result;
+	const void *elf_bytes;
+	size_t elf_bytes_sz = 0, rodata_sz = 0, bss_sz = 0;
+	struct bpf_object *obj;
+	const struct bpf_map *map;
+	const struct bpf_program *prog;
+	struct bpf_link *link = NULL;
+	struct test_subskeleton__rodata *rodata;
+	struct test_subskeleton__bss *bss;
+
+	elf_bytes = test_subskeleton__elf_bytes(&elf_bytes_sz);
+	if (!ASSERT_OK_PTR(elf_bytes, "elf_bytes"))
+		return;
+
+	obj = bpf_object__open_mem(elf_bytes, elf_bytes_sz, NULL);
+	if (!ASSERT_OK_PTR(obj, "obj_open_mem"))
+		return;
+
+	map = bpf_object__find_map_by_name(obj, ".rodata");
+	if (!ASSERT_OK_PTR(map, "rodata_map_by_name"))
+		goto cleanup;
+
+	rodata = bpf_map__initial_value(map, &rodata_sz);
+	if (!ASSERT_OK_PTR(rodata, "rodata_get"))
+		goto cleanup;
+
+	rodata->rovar1 = 10;
+	rodata->var1 = 1;
+	subskeleton_lib_setup(obj);
+
+	err = bpf_object__load(obj);
+	if (!ASSERT_OK(err, "obj_load"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(obj, "handler1");
+	if (!ASSERT_OK_PTR(prog, "prog_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	map = bpf_object__find_map_by_name(obj, ".bss");
+	if (!ASSERT_OK_PTR(map, "bss_map_by_name"))
+		goto cleanup;
+
+	bss = bpf_map__initial_value(map, &bss_sz);
+	if (!ASSERT_OK_PTR(rodata, "rodata_get"))
+		goto cleanup;
+
+	result = subskeleton_lib_subresult(obj) * 10;
+	ASSERT_EQ(bss->out1, result, "out1");
+
+cleanup:
+	bpf_link__destroy(link);
+	bpf_object__close(obj);
+}
+
+
+void test_subskeleton(void)
+{
+	if (test__start_subtest("skel_subskel"))
+		subtest_skel_subskeleton();
+	if (test__start_subtest("obj_subskel"))
+		subtest_obj_subskeleton();
+}
-- 
2.43.5


