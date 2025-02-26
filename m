Return-Path: <bpf+bounces-52678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4EAA469D3
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02861631CC
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8E2343B6;
	Wed, 26 Feb 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5owLp4V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DE224896
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594736; cv=none; b=FhUetRTnM7LGhvVJ57AaiiJgCoohV3+1GvWqA+OhHFxVpYFnL4fgp2Lg8dnBmUmbs25Ib4qGVmH2xhPE8L6nITMNudqoBDgMDHm2xF4UIfeB6xUTtjYMWCIsZnyUjv1Okr8FoOUUbs/TdHrOshqcgl0QcJFwQltYaAqxG/Q9gQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594736; c=relaxed/simple;
	bh=ed/GGbgXRmxe2+M2D6XTAuZ8n26/pWnO/d07WuuViZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBH2Dc5wo59Diq40qud/Mejf/RuMonyN29keeLB3mDL5w/y1W4qOOfu/erNa6fYTL6L2lx2+AJ7y794VubgzLWhUI/4KIma5ukeBrgNvzepjMZHyrsnv1q7EsQNwUTz7nULszo57wn5EZZgASrA0uGSjFq4WASd+goH6wk8Md3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5owLp4V; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f6287649eso32381f8f.3
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740594733; x=1741199533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn1BX9y76DZhXdWo5I/TVE3tCtue0TCmEwlwjM7p7HM=;
        b=S5owLp4VRej+Sn3g2kK/OWx1pyCCZnZtGXc9yjMXL297yRjVXooz2GVzX4nBn8rG/t
         nrLmwZgMReiOagSX/Q1eHFhRdIjvftPwvkn0EJramkyQEzRZGDsbUi2hOTpUYATc5T6N
         DOerBuvvF4C5M5XGH+tAHeQJuBMmMrh7f6yJJ4J+WzdR6W+m/6jtbP/px7ypiXBAaPMC
         BmMmd6CZL5UeqQsBmnU24hw/D4+WP0YsV7DEowm0ZSr+NU5Yk0IUd8g7tYBLvEBH+IQ2
         dV+hyL9qYHQcEnjZGoHLcFWFq24dShOXOOsfiNuQSzBxjh+EXbsEqlJMOhULWWQ69Ohe
         x8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594733; x=1741199533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn1BX9y76DZhXdWo5I/TVE3tCtue0TCmEwlwjM7p7HM=;
        b=Dy9VHJCUOa0A9SZxMLbsKJwQuJnloBLXUigtotJUh7CP9hXjfrRxMOtPE6wVvao3oK
         BBEnSHPrshpli0A38TNFn6m8Lvh0mr/bY6zsG1r9n6hO0dsdaDt+np9Q8Pom23h1gY1t
         3x74Xkfd802ukpI4r72Vq7HzFilakq0VuGuFmcTQZpk1KHOfgizn28aXGQjfavNUKu+J
         HdEJaav7ydGrKdNtoqkpHs3rN8jBblRqrsolBfg6nYg461XMBLs9WfY99tS8E3Y5Dy0T
         Ga8iTLs9GCwX3Akk5Mgx0/jFvujRqYc6OTV89KXe1/juwtobvDG0Xw/XHgkfnXwkw9O4
         4fBg==
X-Gm-Message-State: AOJu0Yyv9/jzG5jCfOZbCiHSSAx0p+vQYSutEPC54faz6/3Rk0xLNenf
	eBvlnUP6qYT/o9gqRQGnPQSZtbHp4CpcDVhDwGj2shvYeB/2aJpuBBy9aA==
X-Gm-Gg: ASbGncvaA5Nf1NoGlk3RN8Cdt/qPpUkjXejbHebf16m1+glNPZsnTV7pV5PWebExtF0
	fS0hDf8e4LNbZhQMNgZIpwv9sC8y2C94RJxtn/DhgoZZAymAAXeB9BMLSCgZpoubBMa7wrSRU6d
	WlkHdIBFQI4qPHCnrlCBKtUZ42b3NSVWQKF9XyjiTdLmJc+8hT+6iTJ4kFfHBwNr1/q5N1350Js
	klZVzo24Z/yV0EFzEiewgqYH+AJdZ2x8SeZzHG5sfLp8VxF8Ofcqt9i0c+/0WLfRZHn1aAjLxKz
	ndUnZOnsSGQ+X7JlvYdP/T+D010YLNwUfgzo88BTZACPfpiLG+XaY9k8I2Q7uiwA6pPAoCbo6fF
	4XKHy2T4Ek5i5qHgpKzGr5O1K0OOTA58=
X-Google-Smtp-Source: AGHT+IFbn/yEBgNc4AFyHQd+AqbqvEvbN7eWjvO5YEiMtPin5rURbVRggJOroj7rS5+e/QnbztyS2w==
X-Received: by 2002:a5d:6da5:0:b0:38d:cf33:31a1 with SMTP id ffacd0b85a97d-38f707afc79mr20708522f8f.23.1740594732578;
        Wed, 26 Feb 2025 10:32:12 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866afesm6520531f8f.18.2025.02.26.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:32:12 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/3] bpf/helpers: refactor bpf_dynptr_read and bpf_dynptr_write
Date: Wed, 26 Feb 2025 18:31:59 +0000
Message-ID: <20250226183201.332713-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
References: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor bpf_dynptr_read and bpf_dynptr_write helpers: extract code
into the static functions namely __bpf_dynptr_read and
__bpf_dynptr_write, this allows calling these without compiler warnings.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 183298fc11ba..6600aa4492ec 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1759,8 +1759,8 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
-BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
-	   u32, offset, u64, flags)
+static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *src,
+			     u32 offset, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1793,6 +1793,12 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
 	}
 }
 
+BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
+	   u32, offset, u64, flags)
+{
+	return __bpf_dynptr_read(dst, len, src, offset, flags);
+}
+
 static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.func		= bpf_dynptr_read,
 	.gpl_only	= false,
@@ -1804,8 +1810,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
-	   u32, len, u64, flags)
+static int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
+			      u32 len, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1843,6 +1849,12 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 	}
 }
 
+BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
+	   u32, len, u64, flags)
+{
+	return __bpf_dynptr_write(dst, offset, src, len, flags);
+}
+
 static const struct bpf_func_proto bpf_dynptr_write_proto = {
 	.func		= bpf_dynptr_write,
 	.gpl_only	= false,
-- 
2.48.1


