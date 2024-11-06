Return-Path: <bpf+bounces-44169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 474AF9BF932
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4431B22B58
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C3520D500;
	Wed,  6 Nov 2024 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="COVwsM9o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12A20CCF2
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931974; cv=none; b=XcvJAU/AxWfYTnvbDHgYVumBUOh6Gt0iTJhN+SehiYkmhL/DxoTBGstx98H1VLNEzY1oR6KOHaJPG5cJf/y9ipqRHDxrLRzD9PSLxvsh2vnN3ZYbbXgg38OxBGNMhrGI9BruzwIK/myfZT/t1Aqqp1qL72qLVud4Idw7C2gxhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931974; c=relaxed/simple;
	bh=r+9pSyIfCGD+0Rut2av2phkfQwWLLxkVPTANyCLrKhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MKmIqlTbsRQvmIiw6UQxSHl7YhQbAC0jgrCXnsz0NtVaFUvAJa+BfqrVHp8dlDGOJImPSWyduFmLUpOsqIRZg9zgT7s4yFM28MeYYF7tSk7p49QBRKCSBpjWDYRSwsG+6f/gHw1YrJDjkouU6ACZFYfNfcft6EgJY3m8yU2ggU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=COVwsM9o; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b1507c42faso114017585a.0
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931971; x=1731536771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70hYqqh5KzkH+ztuwDpbbVCToZXmN+0tCwyB3ptILN4=;
        b=COVwsM9o5xq9hwIjaUmFUHR4wvmtJCWWyotlXYlK/kPTzFFBF7EUf2ywMcE90bgacf
         XkCTTsrigIBPlUTLMZjD0vdvObSoekJP2KzCdAF+FIvNMfu8xhu334dMZCoH6y1VATO+
         uWh4OcdHCdAmcRxfPTRrY4t1GXuabXj28SbBMqFeBEFYVDJRPJ5Al0kvqGV2PA5Vlj3E
         0WvdXdVKvqIza/vkllHIlMzLoVyPRNYdjYhgGLBiK00o67Yo5Q5tyUAKVVwwM41MskvH
         rZ1yDyeObFFG8RM65Q6KaKjxrliu+jcl3cQ6TrxYRA/+pqSO93STTaM1lELJSgBDugRz
         DOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931971; x=1731536771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70hYqqh5KzkH+ztuwDpbbVCToZXmN+0tCwyB3ptILN4=;
        b=wahDjSRgkyhsI6nr/UOVsXXCFm4JWsHWVZ0AOSDYtNU1dKIED9D/zobXGAIsbxj0Y6
         R5Ru7a8H7jwtc17cknWIHPG6lARNVjEdJhj/kMI6DOSXv3cd/2CtyyC/GAl7j381eB6v
         ZnHAsWxPdObAqdJoJXx5rMidyu65CotbhRYu80qQNv2ruHUenuwgrpfYTxyPa2fXqlxo
         SNxxjZ7afO0qEhZE6cs//BvfFQWIGDtaaFQnGRc7WQtw6ZCbMSAISVZlRvZFKFWEf7wm
         XRAxXzhUfHOhKYR2mWG8sP4aHg31+bpQ8YpwYg+q17VCUIvlDZRg0enhuEW5A+cAZkup
         J4Dg==
X-Gm-Message-State: AOJu0YwfYnhHPQI4nS9MVSJY1ypbQmlSr/tCn8SGaeTJBIX+11fECq83
	6JYQ3vH2rYXeIPiIRUKjq5cmernKR9mIF1uwW9zLMwvpVDgC8eQigYW/kJMKb/XkOlPD15hpbTe
	l
X-Google-Smtp-Source: AGHT+IEC+EchxIOeNYlx0elqDlv8gEvnhN6u/xf6pB8sK7ldXLtTOtnhDR3mQi4lbpdlHKLb944c0A==
X-Received: by 2002:a05:620a:8423:b0:7b1:ab32:b71e with SMTP id af79cd13be357-7b3276e1ce7mr128270285a.0.1730931971080;
        Wed, 06 Nov 2024 14:26:11 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:09 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 1/8] selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
Date: Wed,  6 Nov 2024 22:25:13 +0000
Message-Id: <20241106222520.527076-2-zijianzhang@bytedance.com>
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

Add txmsg_pass to test_txmsg_pull/push/pop. If txmsg_pass is missing,
tx_prog will be NULL, and no program will be attached to the sockmap.
As a result, pull/push/pop are never invoked.

Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 075c93ed143e..0f065273fde3 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1596,11 +1596,13 @@ static void test_txmsg_cork_hangs(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic start/end */
+	txmsg_pass = 1;
 	txmsg_start = 1;
 	txmsg_end = 2;
 	test_send(opt, cgrp);
 
 	/* Test >4k pull */
+	txmsg_pass = 1;
 	txmsg_start = 4096;
 	txmsg_end = 9182;
 	test_send_large(opt, cgrp);
@@ -1629,11 +1631,13 @@ static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic pop */
+	txmsg_pass = 1;
 	txmsg_start_pop = 1;
 	txmsg_pop = 2;
 	test_send_many(opt, cgrp);
 
 	/* Test pop with >4k */
+	txmsg_pass = 1;
 	txmsg_start_pop = 4096;
 	txmsg_pop = 4096;
 	test_send_large(opt, cgrp);
@@ -1662,11 +1666,13 @@ static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic push */
+	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 1;
 	test_send(opt, cgrp);
 
 	/* Test push 4kB >4k */
+	txmsg_pass = 1;
 	txmsg_start_push = 4096;
 	txmsg_end_push = 4096;
 	test_send_large(opt, cgrp);
@@ -1687,6 +1693,7 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
 {
+	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 10;
 	txmsg_start_pop = 5;
-- 
2.20.1


