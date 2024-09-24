Return-Path: <bpf+bounces-40253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402998442D
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 13:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23F61F21B93
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257631A4F04;
	Tue, 24 Sep 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai/VPV1F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2C1A4E98
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176070; cv=none; b=k4NpF4xzgrx3l12QT5/Z0XU9hdR2wNQUJw3CZeOHQLgSOd36/ytSNen3sl6xM0Ygwe+9K89JQVEOnUJR25CPx3HgK7XnYqDuSjyAxyRK+kk+CZzhVNwSIJkly62dwYsC1uYYoM6ZXHuM7FaYdWOVT77yozYb7hl+1gv7LBOp+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176070; c=relaxed/simple;
	bh=8G37jGGd8Ye5q1WU19cVMSSjIr5L8SNGnVOyyv3/R/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0rAnJ0+MULzmcgo7EoIiaaROsX9IhdIj8xpOH/iTFVWnYF8S2MGOk2VN+bLSTJxPlmSobIeyBJ/IVmk/rzeisIeSSpntyGW5CVw3B2ZLviOXI2h6yTRRQQ3TM97Pwfwn3W0n5OVXzEwndSntyRqfhWIO8lw3uo0M0hVJWnAVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai/VPV1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99516C4CEC4;
	Tue, 24 Sep 2024 11:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727176070;
	bh=8G37jGGd8Ye5q1WU19cVMSSjIr5L8SNGnVOyyv3/R/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ai/VPV1FV4GsnErA50+ujCLvLxu7HoCY5+AqH0WB8HuOLaqLjWfOYeDCWGlcUyZGu
	 n19FbAnqbksPIDp5QDB5UGet0rX9OcbR/x89pLF0F74A6rYHDGHUjPQsX9DbOBJwrF
	 7ySR7kH/V2CBBcWOSJyilvQaM6Wd2tUzI56lxdHqT9t2IA8Ti0XzbNGHLvcpb+p9RM
	 fnhn7vK/hhEEQnSU7kn8kifQGjWjkfm6Z5osZdyb+CLt4ucvFXct/5KJIh57MTJykW
	 Ny+bBzczqqh9/fL6OBnAv14WnFRdUCvgsh0WdODJRG+VnezlhSUsWc/t5NBrIowQcP
	 7ht5kw5jrpRTA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Bail out quickly from failing consumer test
Date: Tue, 24 Sep 2024 13:07:31 +0200
Message-ID: <20240924110731.2644249-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924110731.2644249-1-jolsa@kernel.org>
References: <20240924110731.2644249-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's bail out from consumer test after we hit first fail,
so we don't pollute the log with many instances with possibly
the same error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_multi_test.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index c1ac813ff9ba..2c39902b8a09 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -836,10 +836,10 @@ uprobe_consumer_test(struct uprobe_multi_consumers *skel,
 	return 0;
 }
 
-static void consumer_test(struct uprobe_multi_consumers *skel,
-			  unsigned long before, unsigned long after)
+static int consumer_test(struct uprobe_multi_consumers *skel,
+			 unsigned long before, unsigned long after)
 {
-	int err, idx;
+	int err, idx, ret = -1;
 
 	printf("consumer_test before %lu after %lu\n", before, after);
 
@@ -881,13 +881,17 @@ static void consumer_test(struct uprobe_multi_consumers *skel,
 			fmt = "idx 2/3: uretprobe";
 		}
 
-		ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt);
+		if (!ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt))
+			goto cleanup;
 		skel->bss->uprobe_result[idx] = 0;
 	}
 
+	ret = 0;
+
 cleanup:
 	for (idx = 0; idx < 4; idx++)
 		uprobe_detach(skel, idx);
+	return ret;
 }
 
 static void test_consumers(void)
@@ -939,9 +943,11 @@ static void test_consumers(void)
 
 	for (before = 0; before < 16; before++) {
 		for (after = 0; after < 16; after++)
-			consumer_test(skel, before, after);
+			if (consumer_test(skel, before, after))
+				goto out;
 	}
 
+out:
 	uprobe_multi_consumers__destroy(skel);
 }
 
-- 
2.46.0


