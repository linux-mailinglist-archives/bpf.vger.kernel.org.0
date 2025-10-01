Return-Path: <bpf+bounces-70076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A31BB04FA
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 14:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21EAA4E1081
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AE2D0C9B;
	Wed,  1 Oct 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3a4hoL2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65053227EA8;
	Wed,  1 Oct 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321364; cv=none; b=ENpArOUgEmMG01aXhJQPiEwDRC1uzoK7QukFkpcEPqCvgMpGRpsPfJLzhrUitIHNTJNQ6MGQNvQl/DnXlZXfjHehCwwiwdSyHT0cjTdV6ZlYxX2UJQ//vYT42i6w+2EQsqjsjYlq5uURdb+cXCrhqj/iEkEg9sRMwDg9EFtz/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321364; c=relaxed/simple;
	bh=ExoeYddEgjz4kXFpdY53mEysmc9belE65sSSmlfynVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYLRG9pvqf87a6R38JmuhtCnzBz9XBGVyoGKvlnovRUlJtwLcH8TvNcTi1sEFo4Crb+w1PatmxeCOweBfgamATW6YlHsR6/LYe3Lm09VtDQRpqy/D5Ptco0XrRAZRvCXl4tTsBLlVamPe2UWZOWT44nO2Vk2YYDQH0Pny/QcgqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3a4hoL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8428C116C6;
	Wed,  1 Oct 2025 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759321363;
	bh=ExoeYddEgjz4kXFpdY53mEysmc9belE65sSSmlfynVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3a4hoL21USYfS63S4N0JMZxCf15F9u4bQC5Erll3OIwMo569Tur29KBG5YdJT6p9
	 Ka1yihgLn8ayjDMmwixiGJzRA5TECL1jznwJ/rmiNoTcZb89lW8QFZT1mtWfJBvFtS
	 +l9xcT4EieGyn6uN+Gq65ruhObHizSuJ2meL9to1/L/VvEq38dux9t65a+/o2giPkS
	 jq15upuGZv7kR+LdJkkF+bUc0vW5q+nCeulHtuao0nGygE27g6r9fXUkfrvImnMu55
	 r/wwgz61lQmzpG5YPB6OguLw35VHS9sC+MQyj6nCZZx6wATrHYqVpAEyqLXXk5ZOmx
	 IUo8i3XA2hziQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf 2/3] selftests/bpf: Fix typo in subtest_basic_usdt after merge conflict
Date: Wed,  1 Oct 2025 14:22:22 +0200
Message-ID: <20251001122223.170830-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001122223.170830-1-jolsa@kernel.org>
References: <20251001122223.170830-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use proper 'called' variable name.

Fixes: ae28ed4578e6 ("Merge tag 'bpf-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 4f7f45e69315..f4be5269fa90 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -142,7 +142,7 @@ static void subtest_basic_usdt(bool optimized)
 		goto cleanup;
 #endif
 
-	alled = TRIGGER(1);
+	called = TRIGGER(1);
 
 	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
 	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
-- 
2.51.0


