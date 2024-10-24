Return-Path: <bpf+bounces-43094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD7D9AF3A5
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8FD1C21A0D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05353216A0C;
	Thu, 24 Oct 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IEzhJOkb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461316E89B
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801780; cv=none; b=F1dYLfZq7Tmyd9EQ2u3ltIlcwbUJj8foo3PPIh/plZlXLFgQ9YPz/QiMCtXNh9N9JPIo53mOIg3xqxwUZnmEAbWE7FEpRd9GKdIQEl7++sA0fNO5D3Lm+U7OeyDueVLOX6VdU5W4QZv7s1EtW8plmEmLLhw+IZ4wp9hJRdJd3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801780; c=relaxed/simple;
	bh=CuN2X17yctDLixboLYTLUEjwjVE+eww9uE4fmUoGdGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8zcTebopLySsQh4bXUb3OZikHmsB1KMUkGdD2n0P373Bh7d4G0h1s9jCqaxQuDkDNG+vJlyuZT4mq0hcw7d/ts/Tiyji2nIbO2aLzO2S/5sNln49L4kU2LJswcCSe23Ttm80zuOY+eMhn/cZuFhjZLNIrRGG0sDxJLkp5ne6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IEzhJOkb; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso1472986276.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729801777; x=1730406577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMbNSwQ9gBAb/wARsLAJ1QkVS6qPK5BqL+4VBJSggzQ=;
        b=IEzhJOkbmqN2Mc6adZveK26q6/B/WsomHZZR3FZ/29VHdkzZQU8JMMJlVXLJR4BP9V
         0OVkrHxMgKlM1I2gAfPEiF3CkaZvXDM9ymbVx5uHWjtIR1gEDFxjJFtA6u7habWT7r/V
         Sip7gKqFSAKJoInU+xNNMc+AFOUy8obuIdQV3O6KS+Ru/SsdTfWCyOH7dxG7SDRMxZ3y
         FpkAR1uhqkUgwcZ/1Gr+TsQMouxbP7kZ9mypF91aE1rEy54SyHQnlRqnx54YUCWwGNu3
         wd9nwFxMZdQVRjlwOjGrgjiUL22pg90n+tYowhGY/ledl/+x74Fn9J9QKMwvfDvc6jHw
         1j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801777; x=1730406577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMbNSwQ9gBAb/wARsLAJ1QkVS6qPK5BqL+4VBJSggzQ=;
        b=RelFW4xc1iL6ppOJRUUVLehmUgBAJBoaNOVSLmHZ4RgWjKRx1zv2yoVm3G8G/m4tgL
         3F76wVmZDc2MvVlRiQ1q2XfUJY41esFOlWBIEjpkP0A5jha0W3iYAdVPoZNEtzlx1YGa
         koeE3jogNJGwDb2Ux6j8qVJcxYVxircJdgIQlaSN5oh0UOOE4faf7duzDtJG3Gc/H5kv
         XIKOKy1XCIbp5AOMy6pnw+L1HvPeBsa1s//6rcO/qmrqX9yAq+ySmPbM27oRWdjaL9zb
         2jbyKyz6mxm4GL1jldmNsQuh6HpAc+dMkEr4S/JNq7oCM/v2s+fP0mirgwNfzO4U6BIt
         N9uA==
X-Gm-Message-State: AOJu0YzfPd7TSKDEWFoeKX2D6hJQq5CvPO5FE3xuzJy4EHNMBMiIIkjN
	Ag724U3j4+juFIQJzMLUX2VnkgTVld8nw2ux2AJOC3lDZTT7drP3T0lyfbbifPsGEQ3ywg4pYYJ
	X
X-Google-Smtp-Source: AGHT+IFK8BQNRgf6mzrAiN94ZmTef4IBlZaAaIuWhrl6mgUNCrNEzSc8Fj3DP40LW9XJvhCIaKrvsQ==
X-Received: by 2002:a05:6902:1b82:b0:e0b:5b37:d0c9 with SMTP id 3f1490d57ef6-e2e3a61991bmr7817689276.14.1729801777128;
        Thu, 24 Oct 2024 13:29:37 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm55486081cf.52.2024.10.24.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:29:36 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/8] selftests/bpf: Fix SENDPAGE data logic in test_sockmap
Date: Thu, 24 Oct 2024 20:29:11 +0000
Message-Id: <20241024202917.3443231-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024202917.3443231-1-zijianzhang@bytedance.com>
References: <20241024202917.3443231-1-zijianzhang@bytedance.com>
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


