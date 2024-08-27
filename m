Return-Path: <bpf+bounces-38199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E1296182E
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123311C22BD8
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA61D2781;
	Tue, 27 Aug 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZmGpkmB"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDD1C57AB
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788150; cv=none; b=j/Up/D8EMHaSful/u3lq83VfLFdHpV0NMHyg2zyZgKFB9sltuU66jKr+JzBInXHb5nT/va2sjaisRPLplND6sSALVrv9+OVmz/4MM38mqVXuZObsjf2CClbSeU+rFf//DiMqKuEl1rXnUuA8k20YcOV0ajXaRmLE0/C0TQ1LCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788150; c=relaxed/simple;
	bh=bUWUr2YM9V4CJyljJXpSNKbmY++CsZb0OjxWcS17gws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1COhHVSouE53wB1OmSZ3N0bUap4bnu6Mg1k6vwKRd/0byQs/hNCBXochNpGbUHkeo5mhPvK22HBC0OlouvwPHJZU901EmvzLHuDDK9xx+H+g0zj3Fkeo/7/V6chttoTEaFaefg60ChIAwz/YrjNYjKklDDKpGc+KaVSbzZ6wx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZmGpkmB; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724788146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgTv7h60Ej9PxyDyDOkIzPkWP2Ddv0oc+ny/BYrMGQs=;
	b=fZmGpkmBNWBSidJ3i9nfwGOdDEXSU6xRHKcNy+SIm2Xh9nlPpBtpMQo9a+Syqn6m5hh1ZV
	2lUoz4aq4kJmI0tGZ8yQisHHu88d9iofGNr5kNlxaPPcG/RhYGPlu66VUartGdvZ9Ari3v
	jh2VLghZcTL3reiAT5pXXRGqJ77yBTY=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v4 bpf-next 5/9] selftests/bpf: attach struct_ops maps before test prog runs
Date: Tue, 27 Aug 2024 12:48:28 -0700
Message-ID: <20240827194834.1423815-6-martin.lau@linux.dev>
In-Reply-To: <20240827194834.1423815-1-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
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
index 4223cffc090e..3e9b009580d4 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -890,11 +890,13 @@ void run_subtest(struct test_loader *tester,
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
@@ -999,6 +1001,26 @@ void run_subtest(struct test_loader *tester,
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
@@ -1013,9 +1035,14 @@ void run_subtest(struct test_loader *tester,
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


