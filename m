Return-Path: <bpf+bounces-53448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE315A54175
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 04:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95DD3ADC27
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2719B3CB;
	Thu,  6 Mar 2025 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZrMYYL7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182619ABD8
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233282; cv=none; b=bNgB/o5ftNC7RWiptbmzCyaGlHvLd/drDwE7TnCJXgEr567giBZ1Uy0f2Ie1F2P7fGWwT7W9tvTgil7eoViD2vf8oCexfgrFc5Ipho+CMuwDytFRDAltbKi8qB3yZTIRzkBo8dnYToo5MzTBKcS8eDJpvpWbzxTe1tUA7Unu+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233282; c=relaxed/simple;
	bh=7wLAt7O8W74x95cBoOOBhxEA4GSGkeqLTG2jdVQE1ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbuwl2P6uHw6Ty2LK276RvMJFD+brPVUsUU6S2EulnoKUpYdyeYqSXWaNK4bvw8ERFMS0M5iz/y+ECFeyGK6kbtMl06Ow9y7oNF0eA7ywCHPPBSmT9wTwccTSeZsFZRr11Efu/G9VSSf8p1peRqDPVIFqf1vX8mD55Bawot+lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZrMYYL7; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-391211ea598so109111f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 19:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741233277; x=1741838077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpbEdVMPpfdOJ9ldOmfW/MnEw0rgThHsWUYVOYyHCYQ=;
        b=kZrMYYL7eY7b/TUOL55KkkZy5LysQgl7vkaI3uYwIGBYfXsW/m+Qh/rp41hzl0boN9
         lHoE4XIZ0PmZr11+Lp+xaOobGZDOtjPtTOTXixrzjURkAWw6wsoZDWHP7EvjzOqYFq57
         iM9eYraSNqMbdIF7hFgLMkK3XMspKX5MO2QmkeapSGSvDIcIG5gBk/gaHfjFYUFCmwJe
         3FpLAp3lvCnRG41o4UTbb3jB/XY9rIOe62A3Co4vqK1dWAzrB3SIijlnV79OCt9lAuyU
         vGepuDuSTWrH93Z8Ah3DVihGsXIFRVA8n82K7iHaqY8v5hfyiBSdgAZwQ/Mb6LFsabwV
         wyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741233277; x=1741838077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpbEdVMPpfdOJ9ldOmfW/MnEw0rgThHsWUYVOYyHCYQ=;
        b=Gb2ZIXDy6rBSDSDSxGeeAuVkZNkiACXYkZ+f+Ivx7mGkAyJqBVFXHItVg3VbB621C5
         TVflE4gAlNRwcQ8BxjRvYXIA4brcqHkkjQ01MZQx+FXRfWvvjMT+v9KPQkjfJk7NH+IG
         80K5DkV4+EPkwSUGIWcxS1FgOkD4M+YUEtZp6psPmZHkU85Ey8l/nIeGCi7zLDJIGB01
         CEJd/Guf8kSraGqm9wjTI0TNw2tkm+CZm19PdNYQ/+g0qK7wStjuvXM9JDjwVffEMNQA
         CBWCrsUsIuJHRacW7uuvNfPAwPhWXzrD7Dx8YqXFy/zmYcH8E7tseHhD4IdGQNcPstPP
         rmQA==
X-Gm-Message-State: AOJu0YyYcIAPGqtoYt/fLbUlzMJYAQYh3IlT7OUDqEAzuMv5qRpOLvW9
	uiZdl0CQoVo4TyX1L4orAeRB1WZm3eoopCX9LmaB6JzdPQqLU+4eXHWFhkxyDFE=
X-Gm-Gg: ASbGncvBUORsE3qt7vXQ3JDGCtdosQKw214bv5aO2+4Se70uGGwvRowwKjZblYJDU2x
	3KUh9lb8Oa3eUk7ugXB3rg4NvuZliSQpdJqfRCNQKmm0PeYGqwQU2v81rEuZKYbqUFF4TM9AWU7
	N90n5GCYk2yHFeQ7XNo25cWeXSH/nDayFuZpX2BdK8WxAG9DqfF+Zs4v5XqTQ/8Fhs5ZVfbXhdY
	qWNEMoQFzL1VCBSFqI4/xsNysa/g13UVqyhCo6GryHB2OAMc+trHW5CJ8E0YBloqVGR08xAK/FW
	zn8yvZDY4HcdIdHlpDHwtQZsokGp+o9ohw==
X-Google-Smtp-Source: AGHT+IG0S32iILhwYsBQPJk8aGT5deDiVR1wWuiDQrMmFAAT/poVDRPMTC0N7VUw6Jr1rLHhggXY2A==
X-Received: by 2002:a5d:6c62:0:b0:390:f1cb:286e with SMTP id ffacd0b85a97d-3911f76eeebmr4666534f8f.27.1741233277391;
        Wed, 05 Mar 2025 19:54:37 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79fbsm578626f8f.13.2025.03.05.19.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:54:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 1/3] selftests/bpf: Introduce cond_break_label
Date: Wed,  5 Mar 2025 19:54:29 -0800
Message-ID: <20250306035431.2186189-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306035431.2186189-1-memxor@gmail.com>
References: <20250306035431.2186189-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; h=from:subject; bh=7wLAt7O8W74x95cBoOOBhxEA4GSGkeqLTG2jdVQE1ls=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnyRK/vBTMFEOe3foCY/HEA3Xje5VIYhs2yIBBnE2Y Cyn6jTOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8kSvwAKCRBM4MiGSL8Ryt8PD/ 9peBbYGAajogMBnN+mpiMnuU2jnEsRI6t3VCYshinAgT9d2wq1tVmWkZjkh9bqUcBkz5VeVGpanfh4 pEmK/iovxb2HMtisyJtMaSaDukEFU1CDl4uB1UmIW41QI9CyzodgJqeqjQzSgIrOFITk0pAKP1Leyp Pz4wT9OAAuWgluKE0PUGgXwTKjKWRGB7GW3KBEexvfCedcG3VGXF0t5oBF3i1FfABsMCcba4JGR7q9 Ht+lHbfi9/PV6/RihEL9Ks2xvwGQYXyq28l5/kJLIKP9nGnkJMFdO9TOA8bAEo9xcqhdWsJcnZikR+ ZPOqOdEiJ62X1Q+EYfzvcn1nkJbpR2Ezuj7Ul/T0v7EdTal9jEznqg93PyZtksJfugnpwkG8zLI31I ojuDIHpewO24ZJf0ZaSOL4JFHsHfq3Bl97dBovHVLMRcU9Y7zc3MJkirW9p0Sii0khSn4haBcBgeYR oWIaA4dmVMX9NoxGB0PertFyETzYutRJ6lineR7EXKrzzn/Ane/HbE1ta7q2jCmbQUSRLxe7KPjJnl Uh+fAqrustErLetlvsMXvMJOtYUGCDcSmwz7Wg1yT9wO807jPZXZcRctov01GOItBNrgbAghAqex8e 5XnyEICjkMOMYkG4nqwRFReNPY/4EeeuIBT0CUbJNIW0YnOQrvK1VW2cDOgw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a new cond_break_label macro that jumps to the specified label when
the cond_break termination check fires, and allows us to better handle
the uncontrolled termination of the loop.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index cd8ecd39c3f3..6535c8ae3c46 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -368,12 +368,12 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("may_goto %l[l_break]"	\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #else
@@ -392,7 +392,7 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("1:.byte 0xe5;		\
 		      .byte 0;				\
@@ -400,7 +400,7 @@ l_true:												\
 		      .short 0"				\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #else
@@ -418,7 +418,7 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("1:.byte 0xe5;		\
 		      .byte 0;				\
@@ -426,12 +426,15 @@ l_true:												\
 		      .short 0"				\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #endif
 #endif
 
+#define cond_break __cond_break(break)
+#define cond_break_label(label) __cond_break(goto label)
+
 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
-- 
2.47.1


