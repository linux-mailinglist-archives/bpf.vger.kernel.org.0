Return-Path: <bpf+bounces-31472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2458FDBAC
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 02:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645062864EA
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 00:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1097DCA64;
	Thu,  6 Jun 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4LIxu6S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE9D528
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635271; cv=none; b=a6E+cUZ1B2txbUhAc9+iazrWODc3fcq1d1XDNBB3nNiKo6eqfwYNaueDfHio+o2auj9Krxcus+dkaDkoD3GAr6lzfKw1bTGS4jH/7ziiSkqCupcdtIHIkrY7l6vxxV5bMGWFytdhI+3F2HJoUPQAY5MmiTfiw7yLpxOHCqMutPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635271; c=relaxed/simple;
	bh=kwE54dGtjsJoX+ne76x1QIQcZfJEw7FTsXbdNFQJBmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UtxzSFXguxnz6XzeZ0IZtrOzweTl7MeSxYMailXhJKQXJoLkL4VBouKi9cOcZuytrDMGhMVjOcs/I1nYSpuMJxQbUSok8edj0qmxJhrIZ0CZH66D9G+ZtmB8cC+VUjTkc0TjuFqJ3zpIeDEnYribH5PieyrDXKkvJIeDyKJblB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4LIxu6S; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f60a502bb2so3513985ad.3
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 17:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717635269; x=1718240069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bh4+G+Q6Awu223otez2jElyYvN5CVLYYfor9pVW58Q=;
        b=E4LIxu6SPaLhIXn9yOd3IP0poPJIWa4zwp13rt0tHECENC6v+QM4MY3ELRzGVYbXHb
         r8yOvIqNKrimd/n/TTjVMe8UJq8GmKA/sJGm7dT0Z+h4/5K64I+/HcEsmeOjJG2WLBlq
         bmkUwKVxpgBocN25gbPXE8l/6Y1Ynzkek0aKYL9rwx2iQntxLBbDknMLO7FHRyhN75UU
         Tkaf3gWlRjlLm+b3oJ1s6h5wYh7leesF54aNuEUnhzfL3r9CUdeBpmzQ91wL2iIdcWZS
         4B8hOFsSEfLpe50LQVx93CoGtEnfcc9VS39VF/b9VV6CnvAgp2BamLfeij7bz+F275In
         VOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717635269; x=1718240069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bh4+G+Q6Awu223otez2jElyYvN5CVLYYfor9pVW58Q=;
        b=inmRYgzwGuzvQ35Io6aG/c4j032LVTRwf6hLlNowa/bnUsDnaVxCFLjL0wqZMY3bog
         BvCoAoO2Oh6c4oEk06O308LDb9uofWoBqy7S99WV1MqmUh4WHsKHTSOr+uXIxnnQMi0M
         BnQ6pILdLG7KqjVOlrRznhrNw1z9Zdvr93EUnpqD7X+Cs4vJO6Tp5DC0wxqlXHgORM6L
         ME6Pg0fi2qI4KYrkc0InnFQym3VzqhqDB+YjY6YWdK11gqVNG39VoA1BUzVG/Hg5VLKy
         Zf4zkAHYsfqcA3pQlZ1Nn1tLd8PnHT4KVj2kGuMqPdKBjhZIfEC44VOwT5SpOOE895PW
         uSsg==
X-Gm-Message-State: AOJu0YzPvBBi080GXA0rmr/3lk3cwQIPRwSgrEtRfA4RI0rSrXRvFv/v
	zoUS46OafgG0m+dA9ci2fNQeVX1SjH18GL/cEJYIkAwMnA4u+DB/+6w7Fw==
X-Google-Smtp-Source: AGHT+IFe0YsfNyLuuAgQfG3GS2EUSOvbFzi5HyeLvA7xZoUEriOp9zoaS9KVa40HRPGZTvsq+9F+yQ==
X-Received: by 2002:a17:902:f687:b0:1f6:5a50:93b3 with SMTP id d9443c01a7336-1f6a5a716edmr47893395ad.43.1717635269045;
        Wed, 05 Jun 2024 17:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:5ca2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccf0dsm1591415ad.120.2024.06.05.17.54.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jun 2024 17:54:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v5 bpf-next 1/3] bpf: Relax tuple len requirement for sk helpers.
Date: Wed,  5 Jun 2024 17:54:23 -0700
Message-Id: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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
This patch alone doesn't make observable verifier difference, but if next
patch is tweaked to apply scalar widening logic to normal loops
then test_cls_redirect may benefit:

File                     Insns (A)  Insns (B)  Insns        (DIFF)
-----------------------  ---------  ---------  -------------------
test_cls_redirect.bpf.o      35423      29883      -5540 (-15.64%)

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


