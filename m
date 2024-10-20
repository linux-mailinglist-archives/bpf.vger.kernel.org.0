Return-Path: <bpf+bounces-42522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5849A5398
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 13:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F5B282D63
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3018EFF8;
	Sun, 20 Oct 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="erTerPZ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793E18E356
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422262; cv=none; b=g/nXmUSQpFRZrzVIbNuZf5TtHrYw9EhbELnrHKl0WHZjJOFvhHnubyHEQhgFnE4rpPM4wF3N2zebaSOhw0df7blpRLrYlFXq8oGjM5Yn4ik2l+TTQePUT5vQI5jvzxzJSrgGMC11w9v/XL6ViJ/laMexa98Hyd21oVWSixYkfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422262; c=relaxed/simple;
	bh=oN+Sq3+CWyQl246OGQEH7dYYr3Jp3o0mxYocnm+sFwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQmSjUsp4EJfqPTyUgRK4eccvUCo0eHSz6AiVsUCoAEbkqAk/E22BEdAL2cl/cyfX/Mx+WdII8v10jh/5MUeqC3XhsNAawvRVrukuF7JNtDVKwlSjOPPlDDErpGktP1WQrNbo5rvLFjuHW723dDbpSjUcmPh+XPRet0Vu8mzb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=erTerPZ1; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so30232336d6.0
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729422258; x=1730027058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3WbXZvJz7yGm6Xfeyw+tck3A3XQyIYLN+0rsHfU348=;
        b=erTerPZ1pFRn+Y4I8ODKoEiC/uw7pCZYL6ANqAUYjthOOLo0OcyE0B82OSzmmqeZzw
         hk/1zULPT96xzA1eqFW41o9i9TyjIieHDqYWl9oKU0wgrbI967RqFZEwDMoEk0TtEoA0
         r9FtoIpimK7zYXSAq5ft836xW5aRLyHzX9x9YwhwZXPuq+wyBe/+KWQ+TQpyVdZZIBVU
         sXK5XNHnVWoZKd+/1FcQu65OlBNZaipdVtQ/66xQKp+y8BWEEiegno8MuiScwGAzn60O
         1buMNDUjZtHZYypcLGijReQmz95vplEAegR3j6FyEsjGSvHavUQyperWLwYYgiuJDF2f
         i90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422258; x=1730027058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3WbXZvJz7yGm6Xfeyw+tck3A3XQyIYLN+0rsHfU348=;
        b=CTZBlATV4JJMTqcIYdXeQK/fMgiFWKoxIdX2cZC8Gj6v6DMjLqXtgVeEIL4vu1szEI
         hWXYXscNQojEtimZGMDkruwYGP8nDa4+t3BTCg8lAWL7KhH+oKEfmnO6a2kyMRVCGmnZ
         tFuTn8MS4z0l3MYrGUIBfdHxrPZFIwxKOU9SUxoRE/d7+qXE466zjXowB8EdLVjvYFPM
         BZNaPw+hUf0o/7/xX4MfldzUTVLPz4UbO2dzRRG58u5v1ofi+BOjBDt5fk6gMyeB75hP
         6OaDVRgjqWE048KAlnCwEX2irdYZueG+mv8OpL96UQgSggLAbAufGqTDtErEKyd2Dc34
         lnyw==
X-Gm-Message-State: AOJu0YxpWf/uEL+HUxqwQWeV6FEP++cw1yhbA7aP+8M/keV+kt6ZeQHm
	NennHFVm+dcuqXSU+lqCPQezIelGlXVNvQn0HY0pimMIUoZcshffgifXZwUVK2UksrN1IGwtNVN
	j
X-Google-Smtp-Source: AGHT+IEM/hH/iNBn7snpBBiHewsnB3aIQ/2olVruLmr4+AuU0/NXj9I/KxHVPevCXguxLReiS/T6ng==
X-Received: by 2002:a05:6214:3f81:b0:6cb:fac2:82d with SMTP id 6a1803df08f44-6cde155e58emr131332836d6.30.1729422258132;
        Sun, 20 Oct 2024 04:04:18 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm6715216d6.0.2024.10.20.04.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:04:17 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	zijianzhang@bytedance.com,
	cong.wang@bytedance.com
Subject: [PATCH bpf 2/8] selftests/bpf: Fix SENDPAGE data logic in test_sockmap
Date: Sun, 20 Oct 2024 11:03:39 +0000
Message-Id: <20241020110345.1468595-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241020110345.1468595-1-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

In the SENDPAGE test, "opt->iov_length * cnt" size of data will be sent
in cnt times of sendfile.
1. In push/pop tests, they will be invoked cnt times, for the simplicity of
msg_verify_data, change chunk_sz to iov_length
2. Change iov_length in test_send_large from 1024 to 8192. We have pop test
where txmsg_start_pop is 4096. 4096 > 1024, an error will be returned.

Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 0f065273fde3..1d59bed90d80 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -420,16 +420,18 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 {
 	bool drop = opt->drop_expected;
 	unsigned char k = 0;
+	int i, j, fp;
 	FILE *file;
-	int i, fp;
 
 	file = tmpfile();
 	if (!file) {
 		perror("create file for sendpage");
 		return 1;
 	}
-	for (i = 0; i < iov_length * cnt; i++, k++)
-		fwrite(&k, sizeof(char), 1, file);
+	for (i = 0; i < cnt; i++, k = 0) {
+		for (j = 0; j < iov_length; j++, k++)
+			fwrite(&k, sizeof(char), 1, file);
+	}
 	fflush(file);
 	fseek(file, 0, SEEK_SET);
 
@@ -623,7 +625,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		 * This is really only useful for testing edge cases in code
 		 * paths.
 		 */
-		total_bytes = (float)iov_count * (float)iov_length * (float)cnt;
+		total_bytes = (float)iov_length * (float)cnt;
+		if (!opt->sendpage)
+			total_bytes *= (float)iov_count;
 		if (txmsg_apply)
 			txmsg_pop_total = txmsg_pop * (total_bytes / txmsg_apply);
 		else
@@ -701,7 +705,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 
 			if (data) {
 				int chunk_sz = opt->sendpage ?
-						iov_length * cnt :
+						iov_length :
 						iov_length * iov_count;
 
 				errno = msg_verify_data(&msg, recv, chunk_sz, &k, &bytes_cnt);
@@ -1466,8 +1470,8 @@ static void test_send_many(struct sockmap_options *opt, int cgrp)
 
 static void test_send_large(struct sockmap_options *opt, int cgrp)
 {
-	opt->iov_length = 256;
-	opt->iov_count = 1024;
+	opt->iov_length = 8192;
+	opt->iov_count = 32;
 	opt->rate = 2;
 	test_exec(cgrp, opt);
 }
-- 
2.20.1


