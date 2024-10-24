Return-Path: <bpf+bounces-43085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D099AF35E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2038A1F2351B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE92141CB;
	Thu, 24 Oct 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LaJfBxZe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A522B642
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800804; cv=none; b=LcEkZO3bE5NSIU9+k8RB+AI3zTnCKigWctcR+4q/TfEh+SwYsvKSW1Wo/WeoLtetCLr1hivFQb+5emkvlKnz+Pbq9TNBcPcF7IQi0KUUHbezjfhBkqtx3fE7wRDIEwp50xU0fZHTSMAOYJ/+zkmP9LCN1b62vuQho3j0V4jvu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800804; c=relaxed/simple;
	bh=CuN2X17yctDLixboLYTLUEjwjVE+eww9uE4fmUoGdGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayGqg54bblTIDZ3U2GR9WF34SDoj8F4zQOP7O1XUlcbkuQ7wxHQuCVvh5xVkNSPTVQ+31s6Fbd6NaNPbaj1S43Hrb+Veika5aQVTWEvCzsucuzxtG5xik9mKIgVC09quLPcuTLMzBpgNoSQcjFrbNCOMlpDBd3tfOp4Hi/7/L1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LaJfBxZe; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b13fe8f4d0so90211085a.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729800801; x=1730405601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMbNSwQ9gBAb/wARsLAJ1QkVS6qPK5BqL+4VBJSggzQ=;
        b=LaJfBxZehJ8xWEN3Oovh2bP0QlcivMWlk4Y3gdu4/uo0kkI1kObckczCCuecxXCnhD
         E5ikN0lEWnR+MbQJmKWNEYOw5lqo0cb0j7o83R8jUtxfEW/TYykfYZReQYPpVzPj7x8W
         J2yDF7Cl5OPJCMpqZOBC/yvV7FwKAunXbv1nJVPRL4VCOuV4qEn5ApzXfiW6Tmf8zHSy
         +7ne/cVdwWTa0k8NWdn3Sla+Ci8nHeds67HYnqvow0+D2/dZrPmPf4I2BfLtxeXsXivw
         HtdtAHp/UKrTOsY6nrH8DyDDm8FQUls7LZhHbSd9RddCIvRwOXxPq4bthkWnEbTZVnMA
         QoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800801; x=1730405601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMbNSwQ9gBAb/wARsLAJ1QkVS6qPK5BqL+4VBJSggzQ=;
        b=XIhA4NF7XhkwHVL6Hw82MRTkW3ivMFKL5xx4jWOPjW5H9xXBj7SiDH0OS58dBGJZm5
         3uOAfT9cfQ5SPuMBo5tInZrAa3IYZTqv+RzAzmSX9HVpDHHQiTzFPVga9vwS3x+FQR4s
         xtDjDE5+IMxrHX7M4PUB/2FuZzgkb6ukMudBb5osKh6oqQFs6gGAU7cZ5HiuAe6lt/cb
         mHQoLVowce3RszTvDX+fM1APCbfrVC5ZTzwDqgawpP1M74FBQTQf55PaKBdCCxlntL7C
         XDgCdv8mJEvn1tjVAeA/d0hEj6IjWBRzue6vfdJYyZnwLwWYK8G6wW3KRM3cz9KJfxke
         9tvA==
X-Gm-Message-State: AOJu0Yzj5KzurtOaapsiOx5eE/Jx9xvMIEZsjIT0dkLqAxNjuidKp9LV
	XTOWJiOAdLReyRFzYeOzVyafUhmVVrmkZ/CONGXIjrQC642h/NqE9FZSH0Kzv8l+Rq6jWtb0Ye+
	p
X-Google-Smtp-Source: AGHT+IG7OIKBJoU+WQY2fIC49YOfoGaXouMdSYOlaG+5j0mI6Yn0vdeoMdIyzck7o/GlmW3EtYNDGQ==
X-Received: by 2002:a05:620a:1791:b0:7b1:517b:ac1e with SMTP id af79cd13be357-7b17e5bc60fmr970901485a.59.1729800801459;
        Thu, 24 Oct 2024 13:13:21 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm518952785a.60.2024.10.24.13.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:13:21 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next/net 2/8] selftests/bpf: Fix SENDPAGE data logic in test_sockmap
Date: Thu, 24 Oct 2024 20:13:00 +0000
Message-Id: <20241024201306.3429177-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024201306.3429177-1-zijianzhang@bytedance.com>
References: <20241024201306.3429177-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

In the SENDPAGE test, "opt->iov_length * cnt" size of data will be sent
cnt times by sendfile.
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


