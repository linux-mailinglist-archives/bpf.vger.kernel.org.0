Return-Path: <bpf+bounces-26248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87DB89D1DF
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633F41F24468
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 05:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6156742;
	Tue,  9 Apr 2024 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNqFhXWH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97A5465D;
	Tue,  9 Apr 2024 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712639947; cv=none; b=Va3107CZrwtNROIwQz59Z1jmQ+cIC95vLBrlIOha+8ziuhlEqhEpYiK8c+Q9VeLHWu9gTxn10N5Jvmi6pRFFMwtTvtN5Mh4MnhpVPUoNj980PezwRpD9e63WfUj2o2N/pOR17gF7BGj3ue6y6tjKLKbkxglHvFWHssfcErfOjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712639947; c=relaxed/simple;
	bh=pxtZsQzsrFzTf5hlamv+xZaGazrmSilttmcacnT6NkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8Spt6WpOxYTM+xp9ZJLlW3WrmV4Kys/hHQS7vSmG9TxiwzuxkPMmrCyZoSOzrg+l0yiBc2DnKg5lT0Os0sqtjGtwrkgDJLR7ien9mtnKyqnPVNxqlMsWACrO4JGngXdUbMnOn3CrW0toGKtYw+gnJlu7570aqDthcX3oHbJZ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNqFhXWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71374C433F1;
	Tue,  9 Apr 2024 05:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712639947;
	bh=pxtZsQzsrFzTf5hlamv+xZaGazrmSilttmcacnT6NkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNqFhXWHcThphlUaFiLOACWSYdyY/O3mAFTiFvchziiZUCtU59aIrpFxIGPaqYBl4
	 g/WEouSe3d363UOYNY9czK4dz01zfYYcODBITK4Ur4zyjA7cnjCejOWxFFSx8taAtg
	 LvtGt7nMnWlsJxq6bshcDbckkU+GLFJ1l89CqCzCX1ydajV2zdHIpq5oTK8EFmmdC6
	 tbR/Gj0Q7Bg+VHm+38tz+HNWg8h4mOFrxWre1PPk8UT0JqJgwyI0wGwPXMLOqO65a9
	 ttZZPyGuvHF9E0FTmycINdKHpBlNahRD87HI7qqUcIYTWrjpdPZwUGGAuS0XlDbRPV
	 41pYmTRe9gTfw==
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
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf v4 2/2] selftests/bpf: Fix umount cgroup2 error in test_sockmap
Date: Tue,  9 Apr 2024 13:18:40 +0800
Message-Id: <0399983bde729708773416b8488bac2cd5e022b8.1712639568.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712639568.git.tanggeliang@kylinos.cn>
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch fixes the following "umount cgroup2" error in test_sockmap.c:

 (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2

Cgroup fd cg_fd should be closed before cleanup_cgroup_environment().

Fixes: 13a5f3ffd202 ("bpf: Selftests, sockmap test prog run without setting cgroup")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 4feed253fca2..efb4f34bf703 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2107,9 +2107,9 @@ int main(int argc, char **argv)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
+	close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
-	close(cg_fd);
 	return err;
 }
 
-- 
2.40.1


