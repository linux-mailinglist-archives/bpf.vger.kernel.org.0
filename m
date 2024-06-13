Return-Path: <bpf+bounces-32012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F6906129
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 03:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F903B22360
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096218028;
	Thu, 13 Jun 2024 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyYtSMUU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBAF168D0
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242706; cv=none; b=BaM4iOw2/fZEoMKsio0uLy5CpWSOeqb9rZi+qiHXljfm9D4Guqv5JLk2IFPIrp6mo2jCW59BCbWv7f9GB7bADmvdJmpnIpFsuW0iF0IZ2HZmStnw6QgN4axHZR7bgIzbp03D+PM5Cuu34uaqIDVoVGIKVGWPshZ9AvESbZctKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242706; c=relaxed/simple;
	bh=vTNhC6ujDjkHa+aMh1zTZRDke/yxsmbKQ9NSFXn4DTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kryP0cW8uCRQoYyAC/S0yobVhKhDRqLZJu8urrlXQim+veOzsd6tp4UlrYkH4OpFeeM/5EMeFSUxNO9dw21aF77NEVrk28VcVw3tovlku45JZOGPw4q5eaDIo0y+j/bzw2nquh+W+4LyVPJ/gct1rkKhJznMdRYu4njgZZ2tmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyYtSMUU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6f1677b26so3648815ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 18:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242704; x=1718847504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCw1jrs3zUrHyZp0xVHEyZoD6RGIp5bFSRxbPOgyZ/E=;
        b=MyYtSMUUrsKA5lBTfrprwVu6/uY0k6DXennbG2PRRH0A8J8gRHbe7Xb4l7KrluadLx
         4xRO74cavYU958VS2SyCQuK3piEUEvsy1ps66k7e6/5ZU4+tlrL6P+py3BGKbWlAPS5Q
         phRz0TFu801gtt02kLHpez1IH+gLFbnhXYE8kZaq8kWczHkAqLXxh68k3wBqgFfZs7zO
         AT9faN0ewTBAlh2e6tHquI6zW37PtcM2WEgr4LgIOmOFuy57ZQHbkKwUPAG1uq6aEGDP
         grTkUzF2VaRcJuQhL7YZyPmpKLh+n10p4NfNPmqpA1SmqckM6gGj9h2a3/4GppUNAOpS
         6dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242704; x=1718847504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCw1jrs3zUrHyZp0xVHEyZoD6RGIp5bFSRxbPOgyZ/E=;
        b=iYpYG0cTnm1JGxCkdrcTocZHsm/GpvsdhrpagaOZ6Gnf7G7mKfCWoNC58xpHrVvsI+
         DP4p+A36vR4irA9Hk3VTH5HpF/maJ6Hhp9P1wITn4jGmVeQ829L8PVnBLZbP7UjlP//r
         u4lKnlgL43LGDEEJAAOnXq4JUojVo/QkIR94hT2TLw63UCOW7SVDIJmjlB2FgQwA2CBj
         VHERo0Qbu8+vJprFGqeYPzkvh0h29fqp8MG/7juRHlgdhgNaFDZITxvwpRGKUiuXVS7W
         2mG3vXqmRn26Nj3bkRadI3GuFjvP68Xrq1YE4s3od+/PibI4pKF2wrt6e99YrA449xKd
         aseA==
X-Gm-Message-State: AOJu0YzaBIGLBjG/PJ8ekRisPrUdCsG3vZVtjSD5lWbZg4jjm5ZJ4Lme
	RK+EkRYFVZocAvAI9YGuFf8ivZuvrQELOslLip/Ij82/IaCWBc1jHqIB2w==
X-Google-Smtp-Source: AGHT+IHW/JmhnOa/zleQr5R3qNvjTkTmnWfEOJms97W+7DKP13j4EV5484Pog3iluf+O47AlVI3R0w==
X-Received: by 2002:a17:902:ccc4:b0:1f7:3a70:9e71 with SMTP id d9443c01a7336-1f84e2cb510mr20409345ad.13.1718242703608;
        Wed, 12 Jun 2024 18:38:23 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:b914])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f339fbsm1279905ad.262.2024.06.12.18.38.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Jun 2024 18:38:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 1/4] bpf: Relax tuple len requirement for sk helpers.
Date: Wed, 12 Jun 2024 18:38:12 -0700
Message-Id: <20240613013815.953-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240613013815.953-1-alexei.starovoitov@gmail.com>
References: <20240613013815.953-1-alexei.starovoitov@gmail.com>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


