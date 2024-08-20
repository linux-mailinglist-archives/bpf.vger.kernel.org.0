Return-Path: <bpf+bounces-37566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C958A957B7F
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 04:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1AB284047
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 02:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52C3FE4A;
	Tue, 20 Aug 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a6tf3F3m"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD43C482
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121418; cv=none; b=nNMM3kEf3AgHrgnsyhGEES2U1SIpHxp1XmwTT/BcK/6w7XEIxV4xcc5UcCOBJAl3cYxhqlyr2nrG+UGJzJX+V2N6BFhiAsJ8SDau+RFgrs0uhTMjbZl2/zXqlaVRQStHZe5pXFyupkCHPmYV56sjDnrZfgpphunhw3fh4MSONYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121418; c=relaxed/simple;
	bh=3FA+zhY3J2aurdG8ymeG/8o1uucMCSTevRTGmf/g0j8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhJXGzhh4fm/9/JJhr46xbK9y35jNut65cmxxelloEHQxXUDIuMQn6cFlPbu2v0aHOYSmB9NqbnKRk2Yk2pm7dSQmtjl2WdepOSzTJxAd5pqX6PYy8p33ghKHt05j13jwOoJzLCV2xjObb5A7kzB2q01ABy+OzYC7UPN+LMx+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a6tf3F3m; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724121414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d3N4eAp1zNkGpAB397euBnf4ls1mgFuOdl80fVhDMCk=;
	b=a6tf3F3mlgNZ6Cy+zaSARXg3xUofT8k7li7y/8M1+kf68L/0TkMGV04WuMQyx8O3X5ru+Q
	8Xe5F7lKEVCm5mk7zUdSmjlAScdzep+fSj4uEipo4Yrg1MOZP3EnZoZveedYkbtkqbatC3
	crd41q0vYDFpxXGGLwpQqPGud/N2m78=
From: Hao Ge <hao.ge@linux.dev>
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
	mykolal@fb.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer checking
Date: Tue, 20 Aug 2024 10:36:22 +0800
Message-Id: <20240820023622.29190-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Smatch reported the following warning:
    ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
    warn: variable dereferenced before check 'buf' (see line 454)

It seems correct,so let's modify it based on it's suggestion.

Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
check in get_xlated_program()") fixed an issue in the test_verifier.c
once,but it was reverted this time.

Let's solve this issue with the minimal changes possible.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 tools/testing/selftests/bpf/testing_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d5379a0e6da8..34dfea295c8e 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -451,7 +451,7 @@ int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
 
 	*cnt = xlated_prog_len / buf_element_size;
 	*buf = calloc(*cnt, buf_element_size);
-	if (!buf) {
+	if (!*buf) {
 		perror("can't allocate xlated program buffer");
 		return -ENOMEM;
 	}
-- 
2.25.1


