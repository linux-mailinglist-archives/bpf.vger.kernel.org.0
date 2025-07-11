Return-Path: <bpf+bounces-63036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208AB018A1
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 11:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27CE3B74ED
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7827EFF5;
	Fri, 11 Jul 2025 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AfLkMO6E"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1827E1AC
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227168; cv=none; b=m4OeSoAKP2Sqe/FbvH4nn7daZOjXawAYBnF9Sr2+MfGqZEtKqIk3s6eZB2lBl67bUVxPgw165mLoNO1rBAJn0PXvd6fYHk8Iw4jfPZhcQeO47HR4tAbwZ3brDZFG3x+Kp69Lhb2pEcUaN1squAyOGbF4HPd+pQ5Ir6L3PS9pQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227168; c=relaxed/simple;
	bh=Z2fbt4ZMkqcpdteW12kCStIL0WQeB29wtyk0cZqu9Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQAtHMIMidz4Wx63YwIPrVaq+rcB5oU1olpJSGm4DMPGYF5I5aUySW4gCuxHLn+15I1fX+gVtrSLH5u71vLMxMg+eCt/vXlTboWQV3Do4paAQLGWqULSYZzIMQqy/Fq6NNiyGMDZz//+/ZtkuVM2fFWvEYV7WFtVBjEA422s85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AfLkMO6E; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752227164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYdnTAguL4o2oJrb1acoqmop89YA3GwF4mvs4rZ/2SI=;
	b=AfLkMO6E5diEEUriY+RgKd74OTB/kOUrwUGGPQsGJjHC++Zhgy7LMVQi84X995JJEAkjB1
	moSBpGUhxeYyIImfUB9ZWino42JxUx6ygxP77yZNj7DCoc1Lq4HaDV3OPDiqrFXs2+usQh
	wLQd54jDJEV6ekGv/wllzdnf4l6KJeA=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 2/2] bpf/selftests: Add selftests for token info
Date: Fri, 11 Jul 2025 17:45:17 +0800
Message-ID: <20250711094517.931999-2-chen.dylane@linux.dev>
In-Reply-To: <20250711094517.931999-1-chen.dylane@linux.dev>
References: <20250711094517.931999-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A previous change added bpf_token_info to get token info with
bpf_get_obj_info_by_fd, this patch adds a new test for token info.

 #461/12  token/bpf_token_info:OK

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index cfc032b910c..a16f25bdd4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -1047,6 +1047,36 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 
 #define bit(n) (1ULL << (n))
 
+static int userns_bpf_token_info(int mnt_fd, struct token_lsm *lsm_skel)
+{
+	int err, token_fd = -1;
+	struct bpf_token_info info;
+	u32 len = sizeof(struct bpf_token_info);
+
+	/* create BPF token from BPF FS mount */
+	token_fd = bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "token_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	memset(&info, 0, len);
+	err = bpf_obj_get_info_by_fd(token_fd, &info, &len);
+	if (!ASSERT_ERR(err, "bpf_obj_get_token_info"))
+		goto cleanup;
+	if (!ASSERT_EQ(info.allowed_cmds, bit(BPF_MAP_CREATE), "token_info_cmds_map_create"))
+		goto cleanup;
+	if (!ASSERT_EQ(info.allowed_progs, bit(BPF_PROG_TYPE_XDP), "token_info_progs_xdp"))
+		goto cleanup;
+
+	/* The BPF_PROG_TYPE_EXT is not set in token */
+	ASSERT_EQ(info.allowed_progs, bit(BPF_PROG_TYPE_EXT), "token_info_progs_ext");
+
+cleanup:
+	zclose(token_fd);
+	return err;
+}
+
 void test_token(void)
 {
 	if (test__start_subtest("map_token")) {
@@ -1150,4 +1180,13 @@ void test_token(void)
 
 		subtest_userns(&opts, userns_obj_priv_implicit_token_envvar);
 	}
+	if (test__start_subtest("bpf_token_info")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_MAP_CREATE),
+			.progs = bit(BPF_PROG_TYPE_XDP),
+			.attachs = ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_bpf_token_info);
+	}
 }
-- 
2.48.1


