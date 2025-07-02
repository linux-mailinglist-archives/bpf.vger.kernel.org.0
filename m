Return-Path: <bpf+bounces-62076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4CEAF0CB3
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6913ACCE3
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201D22FE0A;
	Wed,  2 Jul 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRNpeTEM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA85223DC1
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441792; cv=none; b=aUo+Pemp4x9FRO4QjhMby1HgjkKoXmXZT8Yea4M+FQEmdhU45jfSXGL6AUK8RqLnLqI1Cbu8wNEd4FWlumrwkQt6Wp3iwHnkja4DIGjIowW5xqLt2LnR6jFkKn6Zldl9cUJRcm9HuiJvrYu8jOPP/R3C//2j2fwSHm0JS5Zmb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441792; c=relaxed/simple;
	bh=Fwlj5mG6naih2Ma+h4TJHNoq/Hc9bQmXFJOLINzb5yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHHY+tE6sLQIKsqWfguSlnIQlD1qbxMIZrehK7aU+06l6P00wHm0fkrIoHvkVhBXh8jMhc5LqW0MKEiRY6A2ECr4sOQLbVBCG8ZGZqmqeK7cfCRdGznlyPe09bFomi0AZjWC8vSGfOcWGaRDiyy8qVHZjUmyeFra3Jyn3UEdj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRNpeTEM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2725610b3a.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751441790; x=1752046590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYqE8SEPTKUeDqlit+B7B9IDUfS1daO90I/i4qb5ZzI=;
        b=QRNpeTEMB2rTBO9e8akfs1O2qq/s4w7dy7t02l1AzY1/UFRStFlX4lbRGG2y9iKoem
         jFLZQDg5zko3mNr4MYqNgnIMVX1+8fGVTfgbpn9399Gopv7VUtbii1Lf21FkTLYu2IUG
         QsY8w9g+gULG6MkHH7H4qIBuPmXXbDCw0cJqZENzA25ixhx2fD3k3Pf+EWVj8fhku46w
         +yKLKs/u3EM9xaT0xkX57Cxh+gj7R2MeA2RVIidTzfIyk0g0I4hEC3+uPQpSlJ+Bs4yo
         zF5rI/ds6kHIesnl7X4yZVlXrycL1kYlW88rLq9fqjsvbWdWShBiYJ2WFPJKPflKLS9J
         1PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751441790; x=1752046590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYqE8SEPTKUeDqlit+B7B9IDUfS1daO90I/i4qb5ZzI=;
        b=XHOPmm2cHEKPfg6LYiBvFsfZqeoGsjOHYWqUHXEP/xJA/JVZnFEoHnViP7JVxEPbdq
         z8O7w5vGhqKyOnA7dzDPejSVoYSMEUr+HADo1NJPR2eLklHgzvhwG7LzQH2Ukz52xFE0
         snphnZBiPmilZx7Cc9OXMKp2l6RH5aWrq52m0bnqdazijeEeGQLs9Q6rtR0+CbZn7MUB
         zbse5uGongODLX7+STjoEkwAYJ5DBoCHIDXGpPZAc622bAsuoQzKd5uolZCSur8p/jds
         bBS1i7fljEmSe/FbR2+Rt1ebVetXf6L4O8ZryODdUmoqyqZwff5YUHEkS5bOGz8iDTXg
         e3ig==
X-Gm-Message-State: AOJu0Yywu1Qt/y12s+kwxlCbo5ZUFBzw7ydK+T2GWaTahaAH0akNrXdZ
	i6D6V02JfFBh9niqNnC/sR7RLPuIXLD/Q/xPrWVdd+ivya4hE9czs08C9sBaYw==
X-Gm-Gg: ASbGnct6KIV1PYmQ3u271blM3C2CjBnmVFjpmPhi+RJkyabNg31786QLnPSAc+3enC0
	D19m+4L64uOFlb7b9qKLsp7JwR99qsOvvJMefWZUk2LORRsyp5j//tb/Gx55iG1WH8r5qzml0od
	lYU5KmAAtYBhg9QYMO9xTI1HbG3ypk/MeEGNKjG2SGW+MTfhIudT6HEHFfMQBkKHQxk1QvAUPyP
	kXQb+qdzoIcri68BvTvYzL/odeUcA4cW3Cp+P7vmR2VycVk1U35B/bYkmnbpEBrPyX8E06ZEmwz
	0TTmcPc9Yl0/JF2cwhL6TmFtXSgo7xVrRuxb/8INrFdHLBLQW3muhjiSLLJoNJ78/MAr
X-Google-Smtp-Source: AGHT+IGDwYTpykNUHuDbFg4fN5ENKB+YvranIbPUnOGInqN7Ogo9cxNqoHAOIHQNftc5sIZrFBqkvQ==
X-Received: by 2002:a05:6300:6199:b0:220:a63a:7bb1 with SMTP id adf61e73a8af0-222d7f30a29mr4079619637.37.1751441789977;
        Wed, 02 Jul 2025 00:36:29 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57e1699sm13122736b3a.149.2025.07.02.00.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:36:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: null checks for rdonly_untrusted_mem should be preserved
Date: Wed,  2 Jul 2025 00:36:20 -0700
Message-ID: <20250702073620.897517-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702073620.897517-1-eddyz87@gmail.com>
References: <20250702073620.897517-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test case checking that verifier does not assume rdonly_untrusted_mem
values as not null.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/mem_rdonly_untrusted.c          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index b0486af36f55..8185130ede95 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -174,4 +174,25 @@ int misaligned_access(void *ctx)
 	return combine(bpf_rdonly_cast(&global, 0) + 1);
 }
 
+__weak int return_one(void)
+{
+	return 1;
+}
+
+SEC("socket")
+__success
+__retval(1)
+int null_check(void *ctx)
+{
+	int *p;
+
+	p = bpf_rdonly_cast(0, 0);
+	if (p == 0)
+		/* make this a function call to avoid compiler
+		 * moving r0 assignment before check.
+		 */
+		return return_one();
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


