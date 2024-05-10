Return-Path: <bpf+bounces-29444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D209A8C2174
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF9D282247
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABE816D309;
	Fri, 10 May 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xdMCXLkx"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196216C683;
	Fri, 10 May 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335105; cv=none; b=Wn5yPqQIeVItlZVusp+qbPPQ+DkUtpXzACC1uDPbBJzvwaqUHUiFUhS4mhDPKTtTOcZA1SpgwwruyNObSMJnoRv1J+RoFMmYW6tyWtxoUGDYDG2SniWs4mSfgGfiaCvxGEDAaoyTFBDNX1gP97wERhlQinVcIvzO1b+rv0LWvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335105; c=relaxed/simple;
	bh=L5CtxcTyFe4ed4Z4V5GzUmwGAj4pyd/5Gw6Sce0wkyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXvkHuYObMySZmvQq3Nz+xN0sXY2TH52OGiHTIMzYbZE7e/FuPz3ZgKkDm3dKDSdeYgWEB6ZWnRuN6qSmSmLlqW1w7k9XR6fy5xMwRvxVL2rQHtHDharQJ50zxX+gMzdpSfqgME8Fnkpr8tWUpZHYIxkN1CzyHxiCT8R/JOSp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xdMCXLkx; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715335102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1C/72k3CZqrqQ8uzPc/VTP/P/Rw9MPoSpFvH6FC94M=;
	b=xdMCXLkxAwQR7/Rdu0KQ0aeqzSuPHIOOG5MO2qG3rrkiN72687KX/wrY8xYgwC3U7ZKFuY
	y0ex++vSNlf6eryLU9R4t9tWEz3Stbhxuw8ZjCKMMKu4pOxjVLSlzPak0+D9AqYFkC1Ems
	TpeYjO8C7XU9a3P9vy4GAXD0XUvYofE=
From: kunwu.chan@linux.dev
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: Add some null pointer checks
Date: Fri, 10 May 2024 17:58:00 +0800
Message-Id: <20240510095803.472840-2-kunwu.chan@linux.dev>
In-Reply-To: <20240510095803.472840-1-kunwu.chan@linux.dev>
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

There is a 'malloc' call, which can be unsuccessful.
This patch will add the malloc failure checking
to avoid possible null dereference.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 89ff704e9dad..ecc3ddeceeeb 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -582,6 +582,11 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 
 	val_buf1 = malloc(stack_trace_len);
 	val_buf2 = malloc(stack_trace_len);
+	if (!val_buf1 || !val_buf2) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	cur_key_p = NULL;
 	next_key_p = &key;
 	while (bpf_map_get_next_key(smap_fd, cur_key_p, next_key_p) == 0) {
@@ -1197,6 +1202,8 @@ static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
 	int subtest_num = state->subtest_num;
 
 	state->subtest_states = malloc(subtest_num * sizeof(*subtest_state));
+	if (!state->subtest_states)
+		return -ENOMEM;
 
 	for (int i = 0; i < subtest_num; i++) {
 		subtest_state = &state->subtest_states[i];
-- 
2.40.1


