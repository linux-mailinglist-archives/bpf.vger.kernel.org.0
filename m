Return-Path: <bpf+bounces-34203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599A92B375
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3FE1F23255
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0345C14BFB4;
	Tue,  9 Jul 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5pvPy0f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735114E2E6;
	Tue,  9 Jul 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516615; cv=none; b=p12ziLh6gubXP0TikZ+zkbfaIllS4Z8HsfZqSzI6mZf2EfVWpdbi9z3onZFl9mpE7bqEcF9zGlG+sQcNBMArWXB9GgsQsNIeTB63kiHd+O50C7sKNbACrwkyl6l93e4KkRm5cMThJeZZQsw0an2+CEl/gwTTHrqHTPhRkuu8u/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516615; c=relaxed/simple;
	bh=60zEMjX7htBU0OqT1VipLkt5OIQycGxibF5IvB/pNzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbPSuB1ILmNI0vOS6uoYRoMamQ+e0svhn/8S1AnIrNGsme/BmrQFaNsZS2tFMW1wTFMgMfERsZmu/lkHcfQL1AAQMA9RdUg9MFDCLU8Q/qf+XLT6qdqERxiguepFAJoUiY0rKjTY2Dp043HJPha671JERIiv6MJnDp1JRtVlHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5pvPy0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50E1C32786;
	Tue,  9 Jul 2024 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516615;
	bh=60zEMjX7htBU0OqT1VipLkt5OIQycGxibF5IvB/pNzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5pvPy0fRlGBxmbtbl4wg7ealufSzJFD0PtH8s9dlbSBHwXgy5HD6lUFtnTxvCbqX
	 k6hnFO7wqCgkxxzjHA4Nj0ObPE/y19MsMleAPnx6P3blGve9cTwMx5pPbQb+IyQA5p
	 +BrRaHeNEaYU+Ah5qE7unmGUQjL+/WBcpnN1oTK+TEeO8jiYJO2ZJLIArGhTkD3wTZ
	 o+hQuK/yJ9Uo/AFGbtaZEs1F95JQnm4wKHgcVaGOlKdL569Qthcy4c0WRNmC15eukQ
	 81rJVBVoWtaFtFiSf1EcGohXyBRQAIzjVraTlINInB8PcwAaHlPK3QyqzyFWPovpej
	 Av2UsectCnMXg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v11 2/9] selftests/bpf: Add ASSERT_OK_FD macro
Date: Tue,  9 Jul 2024 17:16:18 +0800
Message-ID: <ded75be86ac630a3a5099739431854c1ec33f0ea.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a new dedicated ASSERT macro ASSERT_OK_FD to test whether a socket
FD is valid or not. It can be used to replace macros ASSERT_GT(fd, 0, ""),
ASSERT_NEQ(fd, -1, "") or statements (fd < 0), (fd != -1).

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 0ba5a20b19ba..4f7b91c25b1e 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -377,6 +377,14 @@ int test__join_cgroup(const char *path);
 	___ok;								\
 })
 
+#define ASSERT_OK_FD(fd, name) ({					\
+	static int duration = 0;					\
+	int ___fd = (fd);						\
+	bool ___ok = ___fd >= 0;					\
+	CHECK(!___ok, (name), "unexpected fd: %d\n", ___fd);		\
+	___ok;								\
+})
+
 #define SYS(goto_label, fmt, ...)					\
 	({								\
 		char cmd[1024];						\
-- 
2.43.0


