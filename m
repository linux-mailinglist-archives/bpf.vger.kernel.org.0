Return-Path: <bpf+bounces-35749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418BC93D803
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 20:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71961F21316
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D42E633;
	Fri, 26 Jul 2024 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhKsIdQ/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EB17C7AC
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017332; cv=none; b=N7594UFa8SlL0rK2h30rgQlCBYZBsxsM8HjssGZbUtJYLVe2hjmuIZykOuI277CSR5q106lHC07qmd220GOvQ2ge4aN8tj6zrFm8d6xvCkOd6W2UtlrYz7LnRz9Z9DNXvzdmKY9GrfAKM+W0/lTJjah+4tyBsyarSyxo6dXBI7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017332; c=relaxed/simple;
	bh=JqLR++rFAwplVGvIJ1zfcjtYJMc9TPjXA7ey5o+scT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ic6BkBChl1iLN2PIbcMKQHF+Gil0wEyI/JCIBwS3NT3VwStM/CFTnkJteYarimUB8OI/9ZMvU8BcfaLn64jXMDD0Y5rZHWsjNHa4xNgucJXJQVPBWDtKC12xo+L3oUmfRnQepirvmeOOX4133blhaB7yuZuXZG7rsQaKfb/f2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhKsIdQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6938C4AF07;
	Fri, 26 Jul 2024 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017332;
	bh=JqLR++rFAwplVGvIJ1zfcjtYJMc9TPjXA7ey5o+scT8=;
	h=From:To:Cc:Subject:Date:From;
	b=IhKsIdQ/KfXUQ8fcrLquNMJyJtR4A+Y+3LUxe0TXFbI1xdJ3Y7OStEh9Pd/Nrh8+u
	 SAgdD/zT+OkqMFUOJTZOSzDPTdFA3jhRLs4kV1CXKCNRvOvitUu2DnqXtIgezbCJzf
	 oG5LEp4gWS+K94PzVlwZIq/Wb65DMdvTfXaLtiz10qAfL4pUO4qdLDOLvYN2DkhGIM
	 iHnrdsOdf0Mo5WNFkgi6xcs+2bpylIjpOTi0Ig9xrMFYbkWRxMa+VFhyyzQ1GAuC0q
	 nGuL4+LM7ZAVPW2I7OjavDX2vOJUgdzyy49s27ddI99mRbGJcylnB+7XNTcJXfPK8n
	 f6GRNsEjGE2rQ==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf/selftests: Fix ASSERT_OK condition check in uprobe_syscall test
Date: Fri, 26 Jul 2024 20:08:47 +0200
Message-ID: <20240726180847.684584-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixing ASSERT_OK condition check in uprobe_syscall test,
otherwise we return from test on pipe success.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index bd8c75b620c2..797de47f8197 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -253,7 +253,7 @@ static void test_uretprobe_syscall_call(void)
 	struct uprobe_syscall_executed *skel;
 	int pid, status, err, go[2], c;
 
-	if (ASSERT_OK(pipe(go), "pipe"))
+	if (!ASSERT_OK(pipe(go), "pipe"))
 		return;
 
 	skel = uprobe_syscall_executed__open_and_load();
-- 
2.45.2


