Return-Path: <bpf+bounces-62202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C9FAF6586
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6081A1C45E93
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6289C2BE62B;
	Wed,  2 Jul 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPQxNpFs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109B2571BC
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496141; cv=none; b=j/DtVspab+LLwoVoyuUu1oEOpRvlYXI+6vRdnSZ7fnpU1l15bF56m9M5WrTJ3Ja2o/644C9br+5mFLSIKc25xwAORFQNyC00DxhOev0sCQkbmRM42fKP0N4+E6y1xG04Q3X9Rq+T1RL2ZkfMmgJPO/RhyOOB/H+HntzWJEU20t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496141; c=relaxed/simple;
	bh=avSUx8UlN147BvXenYn2Je2FwHI0Fk2YS8m/zwzrmUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUIEm5ZO/EzHoTgbmT1zATGHdfKXjylBzuchLgbh/bAkWA4yxzHWBW6nN3dIOzIEy4qDn8hoPtUu8IYLV+BQnKYhwUfLQB//vuOL+b0QISqRBYdpc/YvNMz2UESxZPdpmFetPWPtrffoS5jz9L3uYLkJlA++urxGOadLgIZyOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPQxNpFs; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e740a09eae0so6945116276.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496139; x=1752100939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKQ2XrSLoFAFcEly1mH85ry2pyFnJgKFWey2sH8IiYI=;
        b=DPQxNpFswWpyBJT1Nmzu+a8kS/bd1vwrDQxTCFrtN+gBxiYAl9/d3lZtqmXwdEBY1R
         VZJQ0YowUdFEhb32DEeLGLc3JaX+A0PoesEWi9CygOQCIpy8PlXtHa2/kgAv8P5HDwPB
         6a857fkscG9cEJlKeLQ6iKTzXX5vp2Whmyy3phGdosHqjczinjLyNl7egabME1wITPlE
         3FaGMP4XeC3SDILPJtcU4CBv7XtLrFT3TqolPRmbfjEcgZq1SLl5LaNER61Td7dxnGXD
         By3veCVkOpGQZPPtP3WoIYaiEQuHP8KRoTPXJG96gWLZKmLwqXDczprXqkNSFCMJOHBq
         4stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496139; x=1752100939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKQ2XrSLoFAFcEly1mH85ry2pyFnJgKFWey2sH8IiYI=;
        b=rJndvr8zIhreirYzvyF5zZsiZ4gYaQ2ZnMFLACSkMcUemBaR/bplqBmWW7vf7r4ZDI
         MiVnYECS6urHZj7R7b2j79bgEIktx0uU2slkBQ8Pgfzal/UTUmryVB5DidoD4y5x8h4W
         KVCgF8AMQCTeyl7mYKq39uIX5GjbOC7/FWhasKjusmyw+PqxgsR4v+JYIXgx8Y/chiSH
         SHjIH3krgY1RCwKc+rFduaoImk2dFzW7c79EAyej4ZN187YcezecLxVjVeMIJtM6FY0p
         08Te9ZxMELDk5Xl7ylRkTG2UCZx1bxmpQM2tRIn1HJPgw1IHyEB60XpVOY/PA1j8H1ta
         6sgQ==
X-Gm-Message-State: AOJu0YxvFCTW2mcMT8nhNoZQYemC70zUl0ghiM08rKKfuifAYpgZAWEN
	PtJc07dKiP6nsM0oRuc/lD5p7vQCN++RyQj///uZ3yA4k5yOb+P1swmjHAQwk2gH
X-Gm-Gg: ASbGncuwQOzMdYU6AKgdR2kQeTDw6XOtpCK6m4w18leYq5iKYBq55vHVJERgcXxtGQ9
	YVoK1j8DyX2pQfiDITB/2Zz2xQJuVFlFMh6uX0ktssZWZ8IIcf+Gp8IXT7fx9w9yXRH4hd0zBGH
	YSS4e4V2S24D49p66ub7cWLOdlikDwQbYp0WcIZyEbt3jqpbW29iZftk1mlciR9DzNZ5lGJ1pi1
	QUadvpPB88Dz7JkAaM31gzr4sDhqSRk+EpZdM9VO4QvI5rQCKSp9TsmDkrHsPd2n8qWfVv0wdy9
	IpZl53z1dTXbPC13rpxk8x87M+bnBNpB+JFpod7EploVP7sAWZgCsA==
X-Google-Smtp-Source: AGHT+IEGpEAyG5QVQd4976HiE8AQKzuH5HmvBcEjrg5Kd9/Ynvy10mKhMw3Ec/UYKxEEBee0SS0RKg==
X-Received: by 2002:a05:6902:490b:b0:e81:9a82:fcda with SMTP id 3f1490d57ef6-e897e3e6837mr5690968276.36.1751496139115;
        Wed, 02 Jul 2025 15:42:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6bd23bbsm3968300276.26.2025.07.02.15.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global function parameters
Date: Wed,  2 Jul 2025 15:42:05 -0700
Message-ID: <20250702224209.3300396-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702224209.3300396-1-eddyz87@gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PTR_TO_BTF_ID | PTR_UNTRUSTED global function
parameters. Anything is allowed to pass to such parameters, as these
are read-only and probe read instructions would protect against
invalid memory access.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c      | 29 ++++++++++++++++++++++++-----
 kernel/bpf/verifier.c |  7 +++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b3c8a95d38fb..28cb0a2a5402 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7646,11 +7646,12 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
 }
 
 enum btf_arg_tag {
-	ARG_TAG_CTX	 = BIT_ULL(0),
-	ARG_TAG_NONNULL  = BIT_ULL(1),
-	ARG_TAG_TRUSTED  = BIT_ULL(2),
-	ARG_TAG_NULLABLE = BIT_ULL(3),
-	ARG_TAG_ARENA	 = BIT_ULL(4),
+	ARG_TAG_CTX	  = BIT_ULL(0),
+	ARG_TAG_NONNULL   = BIT_ULL(1),
+	ARG_TAG_TRUSTED   = BIT_ULL(2),
+	ARG_TAG_UNTRUSTED = BIT_ULL(3),
+	ARG_TAG_NULLABLE  = BIT_ULL(4),
+	ARG_TAG_ARENA	  = BIT_ULL(5),
 };
 
 /* Process BTF of a function to produce high-level expectation of function
@@ -7758,6 +7759,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				tags |= ARG_TAG_CTX;
 			} else if (strcmp(tag, "trusted") == 0) {
 				tags |= ARG_TAG_TRUSTED;
+			} else if (strcmp(tag, "untrusted") == 0) {
+				tags |= ARG_TAG_UNTRUSTED;
 			} else if (strcmp(tag, "nonnull") == 0) {
 				tags |= ARG_TAG_NONNULL;
 			} else if (strcmp(tag, "nullable") == 0) {
@@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			sub->args[i].btf_id = kern_type_id;
 			continue;
 		}
+		if (tags & ARG_TAG_UNTRUSTED) {
+			int kern_type_id;
+
+			if (tags & ~ARG_TAG_UNTRUSTED) {
+				bpf_log(log, "arg#%d untrusted cannot be combined with any other tags\n", i);
+				return -EINVAL;
+			}
+
+			kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);
+			if (kern_type_id < 0)
+				return kern_type_id;
+
+			sub->args[i].arg_type = ARG_PTR_TO_BTF_ID | PTR_UNTRUSTED;
+			sub->args[i].btf_id = kern_type_id;
+			continue;
+		}
 		if (tags & ARG_TAG_ARENA) {
 			if (tags & ~ARG_TAG_ARENA) {
 				bpf_log(log, "arg#%d arena cannot be combined with any other tags\n", i);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd2344e50db8..dfb5a2f8e58f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10436,6 +10436,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				bpf_log(log, "R%d is not a scalar\n", regno);
 				return -EINVAL;
 			}
+		} else if (arg->arg_type & PTR_UNTRUSTED) {
+			/*
+			 * Anything is allowed for untrusted arguments, as these are
+			 * read-only and probe read instructions would protect against
+			 * invalid memory access.
+			 */
+			continue;
 		} else if (arg->arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
 			if (ret < 0)
-- 
2.47.1


