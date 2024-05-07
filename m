Return-Path: <bpf+bounces-28746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3209B8BD872
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DC9283058
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF864F;
	Tue,  7 May 2024 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEWJd9QQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79715182
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040842; cv=none; b=sC3nEAGB7WO6U/Gm0Z1VUTKkp52sO1eCLcZM3vOHgvrV1SzqAGbf1PMj4Blxwq2oh5JdkhZbWumikDhMpxpLmqJ8UIZQrgPl+tCkktCk7MYN8so9KXLn6j646UHFhoIDkU/LOB9xFCqFL4yxm8t9MuTiMrvV5OjpPQyyKbIH6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040842; c=relaxed/simple;
	bh=dQQq9QxTiVWzy4mMz4Rznb6ePGi0v3bayiJutnO3pcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPOfVQe6M7oP7/YecVty2jieDTJEAWo2e/EsLDjIvKBqwe8g5bq9heJ7tS2WfkIKQxu1Wicv/lux1UyTXiR5evCeCTrtGi9jFFIQlXDmmfK1W7V5Wu45snCil0wkr/6lkkDFVOMD3sH8LPegMRByCvRIhh2QccjENRoz9MD0nbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEWJd9QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66E2C3277B;
	Tue,  7 May 2024 00:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040842;
	bh=dQQq9QxTiVWzy4mMz4Rznb6ePGi0v3bayiJutnO3pcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEWJd9QQRmwrIOE+QSC2KrShbB2HLYptfubGyMB0mk8UlpK73HZUQlYuOeyj1+fuc
	 c+GYXH8CUGgrJX8DhEGH7oA9qQ5QFQdSJmrVz3pDs66sQAqbEYSJisOvsIdTgl9dj4
	 hDgQ6n/T07umifVP/GsfzdlP6Yk+PgEHn0P4NrkkRcW6fFeqWPGww7ocXSAkNGU4LB
	 0RxrpYDZc4yFGYMVI8MuzrUhIAu+bMIbVR2prNWB/l7CGxNbjzDShZ8O5zNXGOdR+s
	 XKkr22UNiTULTv5/yaV44Qp5sCziZUjeTm1PooF3wM/g+nqY5UC7vqJWJEMAephcrg
	 csPdnNzpqtJiA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 7/7] selftests/bpf: shorten subtest names for struct_ops_module test
Date: Mon,  6 May 2024 17:13:35 -0700
Message-ID: <20240507001335.1445325-8-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507001335.1445325-1-andrii@kernel.org>
References: <20240507001335.1445325-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drive-by clean up, we shouldn't use meaningless "test_" prefix for
subtest names.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/test_struct_ops_module.c     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 3785b648c8ad..29e183a80f49 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -244,13 +244,13 @@ static void test_struct_ops_forgotten_cb(void)
 
 void serial_test_struct_ops_module(void)
 {
-	if (test__start_subtest("test_struct_ops_load"))
+	if (test__start_subtest("struct_ops_load"))
 		test_struct_ops_load();
-	if (test__start_subtest("test_struct_ops_not_zeroed"))
+	if (test__start_subtest("struct_ops_not_zeroed"))
 		test_struct_ops_not_zeroed();
-	if (test__start_subtest("test_struct_ops_incompatible"))
+	if (test__start_subtest("struct_ops_incompatible"))
 		test_struct_ops_incompatible();
-	if (test__start_subtest("test_struct_ops_null_out_cb"))
+	if (test__start_subtest("struct_ops_null_out_cb"))
 		test_struct_ops_nulled_out_cb();
 	if (test__start_subtest("struct_ops_forgotten_cb"))
 		test_struct_ops_forgotten_cb();
-- 
2.43.0


