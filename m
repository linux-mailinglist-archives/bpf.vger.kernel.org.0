Return-Path: <bpf+bounces-37786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1E095A85A
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC871B21042
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1F17CA19;
	Wed, 21 Aug 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZRVrjZYW"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA217C9EA
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283315; cv=none; b=JL6MmnS8P07shdRvffAQlbuQJG6r7n82lsq+JpJvpP+/1e9OU81alD++uMEaBsM7BJe6jXayt/cH7je7FIYO4LyRPgf/JOdIiAmfA0k00LZaUw5CwLIQACoVEVybuFwWOXUsRjgWtylz8NEEyC5ZAAELmnMXqLDQJOzH+38DsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283315; c=relaxed/simple;
	bh=JtoVD/Rz6445Pllrir2sUAMzNJ1c9BzjOy7KeGBQffM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLdIqxidFZLUH+83ddQrBK/etqnr+FNtiXD/RIj9XtZWewciicuYb0gGzzI6rgnN9D3uxXOTzQu1kNTpdSK6s75Nlthfl66IkS/LsjXMeEoLObqNpn2v8fXpeUzTsSFhsY8QinYsnOB9bkYCKKP1mj6ntTIBxKmfXE2bXDCaMHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZRVrjZYW; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724283311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1E8zLWG9vB0lDCtRjRaMsUBDJyaY5b4HpTsKjD1g4w4=;
	b=ZRVrjZYWkiffPur0irx+TYEPhdDw/EYy53RBejZm25+sDfZePa2XDyVyJyGKIx6nmB9u8s
	hZNgSTeZUU2ojfZhE2rnK23SEUc4wAkCd41jUnOLw/M93lu4waWUMUmJLR3dWNxfOqmaRo
	avJkhA7K+yAGIXqAn2YsiLW/vfkN/PA=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/8] selftests/bpf: attach struct_ops maps before test prog runs
Date: Wed, 21 Aug 2024 16:34:33 -0700
Message-ID: <20240821233440.1855263-4-martin.lau@linux.dev>
In-Reply-To: <20240821233440.1855263-1-martin.lau@linux.dev>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Eduard Zingerman <eddyz87@gmail.com>

In test_loader based tests to bpf_map__attach_struct_ops()
before call to bpf_prog_test_run_opts() in order to trigger
bpf_struct_ops->reg() callbacks on kernel side.
This allows to use __retval macro for struct_ops tests.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/test_loader.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 12b0c41e8d64..01feba554a41 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -729,11 +729,13 @@ void run_subtest(struct test_loader *tester,
 {
 	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
 	struct bpf_program *tprog = NULL, *tprog_iter;
+	struct bpf_link *link, *links[32] = {};
 	struct test_spec *spec_iter;
 	struct cap_state caps = {};
 	struct bpf_object *tobj;
 	struct bpf_map *map;
 	int retval, err, i;
+	int links_cnt = 0;
 	bool should_load;
 
 	if (!test__start_subtest(subspec->name))
@@ -823,6 +825,26 @@ void run_subtest(struct test_loader *tester,
 		if (restore_capabilities(&caps))
 			goto tobj_cleanup;
 
+		/* Do bpf_map__attach_struct_ops() for each struct_ops map.
+		 * This should trigger bpf_struct_ops->reg callback on kernel side.
+		 */
+		bpf_object__for_each_map(map, tobj) {
+			if (!bpf_map__autocreate(map) ||
+			    bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+				continue;
+			if (links_cnt >= ARRAY_SIZE(links)) {
+				PRINT_FAIL("too many struct_ops maps");
+				goto tobj_cleanup;
+			}
+			link = bpf_map__attach_struct_ops(map);
+			if (!link) {
+				PRINT_FAIL("bpf_map__attach_struct_ops failed for map %s: err=%d\n",
+					   bpf_map__name(map), err);
+				goto tobj_cleanup;
+			}
+			links[links_cnt++] = link;
+		}
+
 		if (tester->pre_execution_cb) {
 			err = tester->pre_execution_cb(tobj);
 			if (err) {
@@ -837,9 +859,14 @@ void run_subtest(struct test_loader *tester,
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
 			goto tobj_cleanup;
 		}
+		/* redo bpf_map__attach_struct_ops for each test */
+		while (links_cnt > 0)
+			bpf_link__destroy(links[--links_cnt]);
 	}
 
 tobj_cleanup:
+	while (links_cnt > 0)
+		bpf_link__destroy(links[--links_cnt]);
 	bpf_object__close(tobj);
 subtest_cleanup:
 	test__end_subtest();
-- 
2.43.5


