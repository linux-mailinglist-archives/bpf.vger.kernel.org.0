Return-Path: <bpf+bounces-38113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F195FD79
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802BD2812FC
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFB31A08A0;
	Mon, 26 Aug 2024 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5nEttzd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9551A0733
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712518; cv=none; b=sVXi7oAeU03nMhdR9CBgaWoW7wWEssd3BhEh2fcXDCujHrfPtGC3mI6NO4imFVuwP6j4osEaIY+seLBatKO4lyQErUDedgeXgyDMen7mTY5TftLWxroH7Q+DRHdAWDy4MMZaeaCYxl3w4r7WZFgIroXzBWxC6TfxpBln99M3J4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712518; c=relaxed/simple;
	bh=Iqrm0uu6KgHxQSfngJdPV1SUojat8AD/k6UMo8sNDrk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8wHAtq5LF4VtoAQ6+PBBU4thjfaOD+AnjYhIyTi8M9RidAuKrB/QeiJ+405di+2aNZDIftBCLIH6zt1CoLYHROffVxe/8BGch1YBup1iYYQsH5Pt5IYHdaM9GEoz0ulQUVNSebQRt4IU5L4Y2MXDLdoueS/ovhLxlyd/4Gu9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5nEttzd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20203988f37so47513115ad.1
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724712516; x=1725317316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qId7JwIYlwho2rIeJggzJa9WHgpahzkOg7PIyR7JZmY=;
        b=f5nEttzdHj1o4X4HmpnKgOL/eu6A4vycHRzsLWuXM1zQOj0mKVYi5D1+UPpaKnrD7L
         O8Hy5n/AlRlMi/0XmlD7ZgPgzcdr+TUwkXO4NHGUGIZydsND6031OSfBiD9OBCYi/79w
         lSvwJIKR+FclTiKISz/8Otl3ybUzFxGoTAFSV9I43OX0lLJ+Q71uLHqtm/nt8KQApzui
         kK3r4d7IbxFi4GBCeGis8fs4+r5IB/E4ujEj/Fkf8GHO/JwGfd50jW3pkNpCL8yaCMUy
         A5JLPJ1XQP7wGX3JHuqL2UPE1xV4YIUoG/avp8812rlWtzshY9FODYgxoylwVwTdsfje
         vhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712516; x=1725317316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qId7JwIYlwho2rIeJggzJa9WHgpahzkOg7PIyR7JZmY=;
        b=T9orU8APMJm3lnAmusYT9f7zHc9ujtgL17TemlexnCcwJhE//p1/j5SLdoSlBCS2Fa
         fiQfzgSFvQp0q6wC0fPNCMue5QN6qux1+xFD0XJSUDoJtuAB8Gdyi1ymhyKaS1Z7ke1k
         YwOP+9xcW55NOwpg1/VbZ+rjZ3g2K7A/8VZJta8xdhoxqtnci+N2MG+Q36+jX+y4MMpM
         HsgJhwbjXOMIbFwTiaJ3q/BWbYLyfuP7eOd3YMjXzD+evJ5nAtnbazdams9RVVjEERBz
         Ld5CmgTkX+hqBtF3iMx6qVOJrY54+pyRnLFC8mrxLnSNvAJk6SWyU8I6N2ytXZG2U7ty
         97dg==
X-Forwarded-Encrypted: i=1; AJvYcCWilAzpyd8IrnrhafBMvxrGw1/UMJmk8raUy7RCRYcYHRBRXwxHAQXM/y5ymVco6dtqZRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5b/1OYC6fz45NSuS+wk6pB9/fzPU6VEi8x133245HRFih+VB
	3u/M+640O/qMNWk06JZoY3FznsfOAZ1mc1ofZt6Zp1YsqctmeH4F
X-Google-Smtp-Source: AGHT+IEW14S/RSs7h1O/58DQgnod0rahag3Bz/6jjUrLR+///LB1gSTjFgCEctX5g9oL4hAILKM3/A==
X-Received: by 2002:a17:903:32ca:b0:201:e7c2:bd03 with SMTP id d9443c01a7336-2039e544ebamr141514405ad.60.1724712516366;
        Mon, 26 Aug 2024 15:48:36 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855808a7sm72128895ad.72.2024.08.26.15.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:48:35 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] bpf/selftests: coverage for new program types using cpumask kfuncs
Date: Mon, 26 Aug 2024 15:48:14 -0700
Message-ID: <20240826224814.289034-4-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826224814.289034-1-inwardvessel@gmail.com>
References: <20240826224814.289034-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This coverage ensures that the cpumask family of kfuncs are allowed within
tracepoint, kprobe, and perf event programs.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 .../bpf/progs/verifier_kfunc_prog_types.c     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
index cb32b0cfc84b..ac1a64974187 100644
--- a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
@@ -120,3 +120,27 @@ int BPF_PROG(cpumask_kfunc_syscall)
 	cpumask_kfunc_load_test();
 	return 0;
 }
+
+SEC("tracepoint")
+__success
+int BPF_PROG(cpumask_kfunc_tracepoint)
+{
+	cpumask_kfunc_load_test();
+	return 0;
+}
+
+SEC("kprobe")
+__success
+int BPF_PROG(cpumask_kfunc_kprobe)
+{
+	cpumask_kfunc_load_test();
+	return 0;
+}
+
+SEC("perf_event")
+__success
+int BPF_PROG(cpumask_kfunc_perf_event)
+{
+	cpumask_kfunc_load_test();
+	return 0;
+}
-- 
2.46.0


