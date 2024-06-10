Return-Path: <bpf+bounces-31759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13794902C39
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAE428559B
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BA15216C;
	Mon, 10 Jun 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLYTfxyX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817CC1BC39
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060939; cv=none; b=JanImY7giBrZP/8w6wZNgcYhS8jMuRUmkh96Gur9z8AWzknsvC58tLeAITCNiDO+fTI9SDNqP1xAjh//51Yp3IKgQFL2WTqoPN7ANm2EtRkh6aGB6YPecbb/cz7njbneLOHVIPVdugftBKV/fCWRFnTgpB1WaYfYjGoxaS4Yo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060939; c=relaxed/simple;
	bh=cWQp9cpnIT6yOcrplMnFHgtQrgk7m+NU3FJ2xhMV748=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NINfVaWd634GASPfAvnW1zyTH+nU4HGLPyRgXOC+CBqneatZ3q6QpvXNRpU4L1iktJb4HA8BR2xFd0YstQhPRLSnmG6pfI6OKQrRCgOUaKQ25Z3/xpcZ3pOHxAMPmwpFyyphouZdki4YWmz3HyB2DIUo7nrD//a5lwurBm00V6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLYTfxyX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so1763904a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718060937; x=1718665737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVntBV37zIxUp8fMqU7jbR4MhrS6IWwAY/8pSVV5tCI=;
        b=NLYTfxyXvdi6lvs1gveEVqrOboOZuMDulcyjbP+xscI2CFwkJvUczxCrKqF5NDgh1r
         8o/H78ZZhJbWl9VIFhqwSrXxms7FFvLu+uskkzTEAOMTX1ZRtcdDc4b0AzoA3gE1PKQU
         XegwdjcPC9k5ZlAGLdwU4i7HH00EJUjcYdkLZDW5Cr97rKQOPqrOip+IfBy3xiyYD1G2
         o9BrwppXez6ZKXLDlSOrP5xDqfrQgdTitfj7d/wyDWuKPzchYcJjNxA4+tqrWO90PqlB
         9jQ18wXnxo7dvPNeVK+0Hvq1jkhPgFjmdCSXMiaeWT/LeB+dJKZ7f8PhvAAJs3SIg9I2
         plKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060937; x=1718665737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVntBV37zIxUp8fMqU7jbR4MhrS6IWwAY/8pSVV5tCI=;
        b=MLSvMWf8+xaM0FIsCjIfZucaGuW5PPvSWkFdbP81vpSiVUTK6Rx03F1A2wSpdBx8Fs
         zU8D4/+hLWx7+iE51euwW0y1IgX7OZzt+E6ol3BzG0oWSTbwACO0yo2Is3cqUm+t10Uj
         TLu51vUnpw1cmMecrnWaPOBj1dK6I4A6laweI2Vi9omhX/NNTt4AMCtWwTOw/qfXY2EC
         Sonra57sl2NTQj5/bZTZQ5qQa4jbOa3ANSS36pGmPeAnv7JEuq12OGq1sGDlmUWwcgLD
         KTLakSV3PCQn283QqPK9ULMnkOnDfKvUpGSYhZ6MVpvsm45oyPIFvQMWqb5X9vY+/VeA
         pX5A==
X-Gm-Message-State: AOJu0Yz2qAKhEXNnRg71zYXE38vwm7jEutPhtNS+Qsw/rNs+K7Eg/Lxd
	oBNZqizVSuP/zehNnLbGOgCest/u7OqRHs6vJdTrugR7vhPOB5bf+jS1qQ==
X-Google-Smtp-Source: AGHT+IHoXjDDg3lx16qrVwcoOBRnYD+gPwoXKVOgrdJit4z2gVOhEx9+CpFUJQKKj1Dcg7ifUgJyEw==
X-Received: by 2002:a17:902:fc50:b0:1f6:828e:8683 with SMTP id d9443c01a7336-1f6d0313772mr118894975ad.41.1718060936877;
        Mon, 10 Jun 2024 16:08:56 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:cfaa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm18447105ad.99.2024.06.10.16.08.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jun 2024 16:08:56 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 1/4] bpf: Relax tuple len requirement for sk helpers.
Date: Mon, 10 Jun 2024 16:08:46 -0700
Message-Id: <20240610230849.80820-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
References: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

__bpf_skc_lookup() safely handles incorrect values of tuple len,
hence we can allow zero to be passed as tuple len.
This patch alone doesn't make an observable verifier difference.
It's a trivial improvement that might simplify bpf programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7c46ecba3b01..cb133232a887 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6815,7 +6815,7 @@ static const struct bpf_func_proto bpf_skc_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -6834,7 +6834,7 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -6853,7 +6853,7 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -6877,7 +6877,7 @@ static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -6901,7 +6901,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -6925,7 +6925,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -6963,7 +6963,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type      = ARG_CONST_SIZE,
+	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -6987,7 +6987,7 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 	.ret_type       = RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type      = ARG_CONST_SIZE,
+	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -7011,7 +7011,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type      = ARG_CONST_SIZE,
+	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -7031,7 +7031,7 @@ static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7050,7 +7050,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7069,7 +7069,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
-- 
2.43.0


