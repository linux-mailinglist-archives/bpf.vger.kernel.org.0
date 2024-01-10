Return-Path: <bpf+bounces-19345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2E882A3C2
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 23:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185AA289CD5
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 22:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAC04F8B6;
	Wed, 10 Jan 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw0GdBqk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4A4F8A9;
	Wed, 10 Jan 2024 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so24958215ad.2;
        Wed, 10 Jan 2024 14:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704924091; x=1705528891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC3pR/KIRfQXi1nRIJvFu9lmaRDGQEQ78eS65s+oXuA=;
        b=dw0GdBqksFqJ5UCQL8aVtPHCg1bsVT4OiMmDxZTupKnht8gtDUJ+afGATvzmLq0hOI
         ptDM5Vg4od6Q+CpFxMV3nCxWkA1xlSQKP5jv4novhNgmWnA7soSBVTIQy+PAYWJvmutX
         Mz90Hp1InfjLe6adFGzPg1rRYanKmRZjiYrdD41+7qnyhE0Qp0/vuJb5VkMKkOc6xQBr
         hyG2dvG49BO+y+TDOOBpiAL2YB143uI8FVr2JwckNDRN8XfsVOttCTgWt1ZyzZvbDJx1
         mlFKsxJh7lbh1oKl6umQdzxfK++P/ulnDIfeifyi/XraaUUDLHvhWWO/qtsAZkU26+dL
         wsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704924091; x=1705528891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC3pR/KIRfQXi1nRIJvFu9lmaRDGQEQ78eS65s+oXuA=;
        b=fR2PRu5FQfqKOvQnCj5jAn9LsrR9Tx7kd9FupzEFXSKYUmVtJ/x9xKL2kexE+CXiuU
         dYyclKodWM5OkET84Fye6CIlK59DCIxyyuHeGC++EdUBVKKPKTZhvUCBQbokoW27wXq3
         UFgWD7pJVfh65qugR/I43eKD+SBht5Rt/wJg1yyvaKsq35uRLj3g7w01vrdqhX94FSO3
         GQJr7VAjjBYs6ccvBRH1pUswiItzT9RkUi/RjqyFaqyNBi+VUekw8vvbzWN1TOoBrvNt
         G4HygNaEa0NLWs85Pol+4eJfq8rDa6mySHUKT/RLMpYAMzFXvMA1LesExqDcbxcUkjVp
         0I8w==
X-Gm-Message-State: AOJu0Yy209ctDdVc6poF2nThKyguIqcZ4JyJZUlFJ4BOcv8gmlDa1wVk
	sHX+9vAGQ8dnCMttj1U58zCTXQmMyCg=
X-Google-Smtp-Source: AGHT+IGCSwdnMOgqCPuwSTutJdJ7QqOAM5hKB8IWNWjE4U9O4qKJfeeW1X5yHr7ZFIg4E6ovRD8yYA==
X-Received: by 2002:a17:902:da84:b0:1d5:5af5:6fec with SMTP id j4-20020a170902da8400b001d55af56fecmr198604plx.81.1704924091114;
        Wed, 10 Jan 2024 14:01:31 -0800 (PST)
Received: from john.. ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id jk5-20020a170903330500b001d05433d402sm4130130plb.148.2024.01.10.14.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:01:30 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	eadavis@qq.com,
	kuba@kernel.org
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	borisp@nvidia.com
Subject: [PATCH net 2/2] net: tls, add test to capture error on large splice
Date: Wed, 10 Jan 2024 14:01:24 -0800
Message-Id: <20240110220124.452746-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240110220124.452746-1-john.fastabend@gmail.com>
References: <20240110220124.452746-1-john.fastabend@gmail.com>
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
 tools/testing/selftests/net/tls.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 464853a7f982..a53117cee841 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -707,6 +707,19 @@ TEST_F(tls, splice_from_pipe)
 	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
 }
 
+TEST_F(tls, splice_more)
+{
+	int send_len = TLS_PAYLOAD_MAX_LEN;
+	char mem_send[TLS_PAYLOAD_MAX_LEN];
+	int i, send_pipe = 1;
+	int p[2];
+
+	ASSERT_GE(pipe(p), 0);
+	EXPECT_GE(write(p[1], mem_send, send_len), 0);
+	for (i = 0; i < 32; i++)
+		EXPECT_EQ(splice(p[0], NULL, self->fd, NULL, send_pipe, 0xe), 1);
+}
+
 TEST_F(tls, splice_from_pipe2)
 {
 	int send_len = 16000;
-- 
2.33.0


