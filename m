Return-Path: <bpf+bounces-19500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D438E82C869
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 01:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737411F27338
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 00:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB7812E64;
	Sat, 13 Jan 2024 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZIPOLVr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50510953;
	Sat, 13 Jan 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso5289174b3a.0;
        Fri, 12 Jan 2024 16:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105984; x=1705710784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nypTy6NkHYIvARCP+pxxumVbbKshlAVhi7kz7hPbnU=;
        b=FZIPOLVrCD807DMBx2mexN5j7U2yOqTTEq3hP25pSF81Pk2l6C+sPQL8tEWI4gioOL
         h/dIrjnEy30fxhvxc0EACAMkxupfgZG1TE0Rd6WjtH9PGrRhftH8brcSNh602z8e4h9h
         GoSih5CzyAG7iWddUwUuCLYc3RzVE4B/rnFAtADzuwk6ifqfDRhLnC9lNA2YAaYq52J1
         t0oe1uS7Yw62bBjyqnE0FH1aPcdZsbwseIvx6R424/FW1rTL6BryGvjJnjiEXyeFOF0V
         2WM0JZlXZhb1+zWHsexTzk8Vbfn3NzwdDgiyq3Ptdwuidsb/mJRbECgm43re1QD7+bXi
         8ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105984; x=1705710784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nypTy6NkHYIvARCP+pxxumVbbKshlAVhi7kz7hPbnU=;
        b=iDOIZ8JYYn4xuFbXe2gCoNz6WxNyWSQ/2HrV1F5cps+9Kp740xrBEVQ78UZoAw468e
         kIhByrUl7/YcgJtzGUNK5Yg4u/b+LCpRRXONkqg3W3J/Aw95aS9TmFjXKNGFYLKwmmTz
         AH7UxOEJJMU7alBMLqEWzAJDZmUnlfkEcBubkExDdLmGjndzkDfG+V5eQRPp2TzvCySG
         lOVLrrZr4K89EZw1jHuRFwkPsn0MlXhQS1eLEaMnaSPoZPHqIaAOlRHsJ8hJmWqllvPd
         9e/ae0cvRw+aRiMFVUf2v8QBe+bqGgrO7uCKGdIz17oyuHlP7I2lrVVTnBOzlKnZGvvr
         lBGw==
X-Gm-Message-State: AOJu0YyNSs1klely4/JbqG0opvYQQY+vMtD95n3VNHAd7KWruXRSrxEO
	kQuSHWguGKdhJDnh2YEclskWGrooBzE=
X-Google-Smtp-Source: AGHT+IEVbqZ3C4bnKqixDhyrowxeVrt8WlYMx5BOv4LGkra7Qy30ae2mBqhcCOu8PCEvsNjhi8y0mA==
X-Received: by 2002:a05:6a00:986:b0:6da:de0:9bf0 with SMTP id u6-20020a056a00098600b006da0de09bf0mr2635076pfg.26.1705105984275;
        Fri, 12 Jan 2024 16:33:04 -0800 (PST)
Received: from john.. ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79a48000000b006d9b35b2602sm3707914pfj.3.2024.01.12.16.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:33:02 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	eadavis@qq.com,
	kuba@kernel.org
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	borisp@nvidia.com
Subject: [PATCH net v2 2/2] net: tls, add test to capture error on large splice
Date: Fri, 12 Jan 2024 16:32:58 -0800
Message-Id: <20240113003258.67899-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240113003258.67899-1-john.fastabend@gmail.com>
References: <20240113003258.67899-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot found an error with how splice() is handled with a msg greater
than 32. This was fixed in previous patch, but lets add a test for
it to ensure it continues to work.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/net/tls.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 464853a7f982..7799e042a971 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -707,6 +707,20 @@ TEST_F(tls, splice_from_pipe)
 	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
 }
 
+TEST_F(tls, splice_more)
+{
+	unsigned int f = SPLICE_F_NONBLOCK | SPLICE_F_MORE | SPLICE_F_GIFT;
+	int send_len = TLS_PAYLOAD_MAX_LEN;
+	char mem_send[TLS_PAYLOAD_MAX_LEN];
+	int i, send_pipe = 1;
+	int p[2];
+
+	ASSERT_GE(pipe(p), 0);
+	EXPECT_GE(write(p[1], mem_send, send_len), 0);
+	for (i = 0; i < 32; i++)
+		EXPECT_EQ(splice(p[0], NULL, self->fd, NULL, send_pipe, f), 1);
+}
+
 TEST_F(tls, splice_from_pipe2)
 {
 	int send_len = 16000;
-- 
2.33.0


