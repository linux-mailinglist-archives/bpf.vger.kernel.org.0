Return-Path: <bpf+bounces-44173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9349BF93A
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901AA284666
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8820E319;
	Wed,  6 Nov 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MUF4N1Md"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2A20E038
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931983; cv=none; b=cwuAx6nC+nBr3KgllKNVvIHrSo92PxiSUd7CfsxQaQK4UScBXWcuDN+mN6SRLFHCyy4IGG3gZTfnVJr2Q/O2Dk/IPieCY2kv0nLVR+Bfp1qnMM0ZFncbFkGlm6kTnLd8crAI8y73C84DifoSIN3pBfP1CrEYOywC3DfMEuY6YRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931983; c=relaxed/simple;
	bh=0+lZiHUTqovga3VRLemzrJJ+m5v+hkB9S5f4p34gZO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXE46htxZ9aGeU+p4s9WAWFfgYyc+4oR5ZgxrS3wo7DfiQVJGmVHAYDNH6ZwwQ2rctP7DyfYMwUfQjBboA8VJ8rbE5SUTPdwWg4sPwdTKYvSE2iF1mW+8xb965jC6ClDBdB2DS8L98UsMS2HT7zSjQpdvDE86miJoFCpNIuQAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MUF4N1Md; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1434b00a2so19424685a.0
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931980; x=1731536780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSLUUA+3gK7LBKeIPsZWWeloCTFG/7YxTHddhbQVWX0=;
        b=MUF4N1MdOvGfWEzHeuD1TW2AiN7spLRkiZScHuga1pfUQ7L/ZWGSuZwmL5ijH1v62g
         f1P2p4PFsRKFK+RTDfWBCTVFHjShOiXCodvW7EzWnmHook8rOdUcd4EA4VBMqAS5iCug
         2GWYKm6ecnt1qGpx1W3bc4VYLNcvonVh2ddx6G2HlUbti+g2kpkszPc7C6kKDRYaX0An
         SU8SaYrv+BontyDb201vNgzhjnl+NxAGmMYovKkV3nUFs1PbmyKK0iIzixak6vi2KUNk
         tBjiKY95uPkorQ4KQ+TdnB2v6BHQLRNCeLv5NUmlhrQ1wHCxjJpngSyFPIDSbXUpIkLG
         GlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931980; x=1731536780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSLUUA+3gK7LBKeIPsZWWeloCTFG/7YxTHddhbQVWX0=;
        b=crNX1jz3t269Nyr/jH2gdMF537nfMVnFSISCd6ZF18UOdlcWDHFVAWW+fmQR4jQovH
         hVc6SwhwgCZmacM5bhvX4+1glayTd47XETLWK+lcmgxHuIt8ijyNu7Q1/g97OZR7gzCd
         1fVZiVVhjStEWZM/jw8kfAOhh4+slZIs1jfmWTX1rZ7dcWScsT9KMeRt2f/72B2cdGZe
         xexho+cZ8NBvLI//G3IG7zC7147OItRhURa/iji9ty2imSmuoIXZfyqhfmpGLwZs5zSQ
         yJws1ERxslY8KarXPZeZXAdnlKIGRhOwazXVJhePUYLg0bi4ISPmm5YohMRdU4V8k1O2
         bwKA==
X-Gm-Message-State: AOJu0Yy0rh7Kl4PPM9e3OJfzoxx/EaYu+hUmUX+adQAQo44YEcdNBCLL
	UpMoEuAwDW9SR91HpHrOcAh9g9tFAMZRghbPqyCnOjFCe04ADRQ4olP8tMflS6Lr/AoYJ71+Frj
	M
X-Google-Smtp-Source: AGHT+IEOl6BpqHaCHe/PLkd3sxGFfkdqT6aBkoY4ehGu479yy6aPii/3bK1D8LBwg94wnefW4PtR/A==
X-Received: by 2002:a05:620a:4443:b0:7b1:52a9:ae1a with SMTP id af79cd13be357-7b2fb94e3b8mr2945383785a.4.1730931980408;
        Wed, 06 Nov 2024 14:26:20 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:19 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
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
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf-next 5/8] selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
Date: Wed,  6 Nov 2024 22:25:17 +0000
Message-Id: <20241106222520.527076-6-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106222520.527076-1-zijianzhang@bytedance.com>
References: <20241106222520.527076-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Add more tests for test_txmsg_push_pop in test_sockmap for better coverage

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 61a747afcd05..e5c7ecbe57e3 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1795,12 +1795,49 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
 {
+	/* Test push/pop range overlapping */
 	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 10;
 	txmsg_start_pop = 5;
 	txmsg_pop = 4;
 	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 1;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 5;
+	txmsg_pop = 16;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 5;
+	txmsg_end_push = 4;
+	txmsg_start_pop = 1;
+	txmsg_pop = 10;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 5;
+	txmsg_end_push = 16;
+	txmsg_start_pop = 1;
+	txmsg_pop = 10;
+	test_send_large(opt, cgrp);
+
+	/* Test push/pop range non-overlapping */
+	txmsg_pass = 1;
+	txmsg_start_push = 1;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 16;
+	txmsg_pop = 4;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 16;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 5;
+	txmsg_pop = 4;
+	test_send_large(opt, cgrp);
 }
 
 static void test_txmsg_apply(int cgrp, struct sockmap_options *opt)
-- 
2.20.1


