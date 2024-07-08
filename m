Return-Path: <bpf+bounces-34034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0CF929ADA
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 04:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711CD1C2091F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E233D69;
	Mon,  8 Jul 2024 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJR/pntR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B18816;
	Mon,  8 Jul 2024 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405857; cv=none; b=Y1McxEB+iV/CnM7bCphX1QlE07eFsy2aKM7SXlHGE2tTRblbA86JI1OXxE3XcrWL8LsrL3e8jYUu5atxKfePf3xIvd707zZVHpv6PdclwlU65iCDm3kTdSQ6n+naj/BqSRbNvc0lkxy5JgsTtPVSjL9L7Bgdtmtk8IzZcMwJxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405857; c=relaxed/simple;
	bh=fM+Fvp9zNJCCiGYWxrP8nEmg3zhc+E1Yb8AOlDJckXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prkV2wL/46J2vmBvbPKy6fY8YI/BqYjo8JfvdJE/dfzPt+ekQbJA4Z2tXf/sYR35WJkXT9hdCTeC3nQpdPyUxhAOWPgdJDse/ml5WZMnSB/2+9NKrLGzC8IpE2BeJNyMPb60DDf1EJ10o/7I4PIdcyQ0Umx9Rxlpz9mnj2iJQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJR/pntR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B769C4AF0C;
	Mon,  8 Jul 2024 02:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405857;
	bh=fM+Fvp9zNJCCiGYWxrP8nEmg3zhc+E1Yb8AOlDJckXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJR/pntRAE/jgxtlGUK7LaRkTtaiJrgbdc6l3cpoZmSMcSMaIClbePVBxajYpYMAV
	 GRt+H6ebCIkV4bwQYIEzIFJKRBxOc5VIv5L6lCvJAsevDR0SaKgCrG+thZZPiLCnkD
	 rOdPrHL87Ob1EZ53Ft9GLnJEeoIf7xFla+29VL7jZpdZFbDpWnrcBDX4ECjLVn89j6
	 KiGx26SmtlKpi6E6ni5GqtOV1XPdua2XFX8G7TA6uCdmvvzUSikJ3Q/7ojqtul2is7
	 inxUxh5Bkov2IRpX8rMvdLSDIv+FN9XXOq+FvwzEF17lTTSuY3lIUnSYM/P3gkP4WQ
	 N0MGtRCxrxOvw==
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v10 08/12] selftests/bpf: Close fd in error path in drop_on_reuseport
Date: Mon,  8 Jul 2024 10:29:46 +0800
Message-ID: <285c913620e67c2e8160ec056b5332c8c19d438b.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In the error path when update_lookup_map() fails in drop_on_reuseport in
prog_tests/sk_lookup.c, "server1", the fd of server 1, should be closed.
This patch fixes this by using "goto close_srv1" lable instead of "detach"
to close "server1" in this case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 597d0467a926..de2466547efe 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -994,7 +994,7 @@ static void drop_on_reuseport(const struct test *t)
 
 	err = update_lookup_map(t->sock_map, SERVER_A, server1);
 	if (err)
-		goto detach;
+		goto close_srv1;
 
 	/* second server on destination address we should never reach */
 	server2 = make_server(t->sotype, t->connect_to.ip, t->connect_to.port,
-- 
2.43.0


