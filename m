Return-Path: <bpf+bounces-31626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC773900EF4
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 02:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0BC1C21431
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 00:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1379E5;
	Sat,  8 Jun 2024 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcnZVP8d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA636AA1
	for <bpf@vger.kernel.org>; Sat,  8 Jun 2024 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807497; cv=none; b=JkOUpGTbTBr9CM+vhti+qro02z/FUaVZjKmMAahweMeDQ6Tqb6oMd3WVEGMAcBhEVUdqDZwQK7VlTxYyBEJznxmqa/pI5KdZJry+pB2BsX7b7fLoYF3RV3O07Tr/76W3NGtIpCc1vMegoKRVwJyY0iOlsEt3fCh7vVmh0DChJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807497; c=relaxed/simple;
	bh=cWQp9cpnIT6yOcrplMnFHgtQrgk7m+NU3FJ2xhMV748=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEWiNM9DFlLIRNii/XAV1NlmKEuNdGvveUgdpzX1rO6xhSJUIgrZngA4YVM+BHPjZnseZH16Zv42lCG7OsZxvJc9hXvXMGnJZ6EdM3VqQMZuy/NAQJXZEGB3z3iPOgRSx7J1tOa4Ru9wEDHDpP5MyRcby0bxg/yMzqapYh2vQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcnZVP8d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6dfc17006so7926065ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 17:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807494; x=1718412294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVntBV37zIxUp8fMqU7jbR4MhrS6IWwAY/8pSVV5tCI=;
        b=RcnZVP8d96z522KeVfAOuvj8S2HsyB0N11r2JWUq9nwT5b4wWO3Aq4DxBeNmmgvtSo
         /it2W22MkHR+heZLO0Rsnry7PkA8Zyjo+VyGF1iC7pBkY12bTdJmgW5M0ER1CbXWcb0j
         JUdOy3dD1E74ikeG+5j/SS82w+X94Nzz6AYazl36jFBdukLQOf2HQDPC9uN2q+q4z3rm
         BDAWwPqxa6/TsjT+PHDRiD3pbVOdyk30Wd9P84fKa8+Py4vRad7pYDwmLCAY4iSg/Q3m
         vnPxx6csf5k0dYROvfrn+IhZNjYI0bOdmFvDkhIB+5JT5cBCjZEjzjhFVmbWkL8QPAwm
         wPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807494; x=1718412294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVntBV37zIxUp8fMqU7jbR4MhrS6IWwAY/8pSVV5tCI=;
        b=ekWLFk2A41gcOC7/WLklV7fEUexqxhK/E6WCys3h6kLcnATLn8a1pAoueO2IXdi4sQ
         VAe9DAfXAmCA4j2h/BTgiuYhU11T1PKc5dCjNF6KRFmm/5uTj/DWxL6pI85cmztzjHQZ
         k0gWvfcVX6V2ZfuJ9/gY5jop/cikpJXrlLTDi1aFkjixPpBPwBS5bvZ3KGdIxUjuUSHA
         StIMg5K4Op0zLex2gN+aIyf1rSwhrb/H5iz/9+OfgdC69uonPNJSOnFNL+HOIQpUj7rv
         wAA2810C82KdUERRXgVAmg+ARMwv70DUoox92vSAP/mlqb5rXqqyijoONYUT/S6Wnh+/
         a2yQ==
X-Gm-Message-State: AOJu0YwR/NZUYNlloxRr7TAus25dj2jqeyRbRDHq3xN26urvsrQkvNLV
	CRSu5c1FyiGD65TpA01K0vEznJuXTZt21CpDyEIIbdcbAveMUFi+iJrQ4A==
X-Google-Smtp-Source: AGHT+IF8OzFWDoMdgT/OU+rC1JkQCM9VZQpwPy9nFs3LryXgrOaRP4FDjSRAvXDvv5ftfQa9g8lSFQ==
X-Received: by 2002:a17:903:2307:b0:1f6:a662:f5f1 with SMTP id d9443c01a7336-1f6d039d38bmr45839345ad.55.1717807494277;
        Fri, 07 Jun 2024 17:44:54 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:81a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ec539sm40583165ad.238.2024.06.07.17.44.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jun 2024 17:44:53 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/4] bpf: Relax tuple len requirement for sk helpers.
Date: Fri,  7 Jun 2024 17:44:43 -0700
Message-Id: <20240608004446.54199-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
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


