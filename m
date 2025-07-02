Return-Path: <bpf+bounces-62118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D66AF5B18
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C806A18946CE
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339A028B4EB;
	Wed,  2 Jul 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS/+GCw/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933970810
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466424; cv=none; b=EgSaTwpQaLkyGiBkAvEz+MP8uBAMw4zvfCClvOcNqt2r/g2znAlw8QNuh7XqGn5PaXJzuKvwm4GcR2xVU7ltipuOqRS+s//xkCa9nvasv2ML6d9HuZ8IiVbtJV0yG2IApQMV5IkxDDcIz+mO2wIFFUbCHTQNo0DjkWFGQJTQQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466424; c=relaxed/simple;
	bh=iIYaRnB/OxRIhXI7L/ZoDkW0RFAZPuo1QD5M9vIf2xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lEQHb6YKGQqkCvuOSSDfzBNaWuqqVz5EEMOjK1BCcn1yzhbdmiAMH13Y+YgUoISPnbqanQAPGhJsjvDLtLHK5jQQGeY4aRVHAlcikansATqhc2R2fLhdRLKY75TWogGNQqReDamRX2N+yOOV3nz8VAwcatz9PCk/Rk8+hFQKZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS/+GCw/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae36e88a5daso898942466b.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751466421; x=1752071221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JTbjOeLIXOAkb/sEAs4YAAs9+Yh9pUTdx6L5okUmXE8=;
        b=mS/+GCw/AtsDWLwTOslFamGP5wxIh8UKZjRIvW3/nF62GKIEDv/PaOxFPdeUcpnAEO
         47/9cDXtY2FZw7B+b2Ji4sSM5o3D/c6pFOLr+7DDwL7Dni+8XS0ZmqTeA7ece0UJjBk8
         Cv+ZvjMQJe7mbioMgBOM4zsDof8NjYCGfnFnCNrNS5uqRacPjd0VL4CT9x0tXEQyGMJc
         Tww+PSo8EBAXAkEt32QerGebIj8nnmE8xhyB+0pozmLb3xjBcC0gYo1RvbZeTh9UpnaX
         cfl1s9DYVbyYpDFvn2liaNd6IbvbdbdilOOiOj7GpulkCD+V+awIkZKgHhHEZn/JaPSI
         LIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751466421; x=1752071221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTbjOeLIXOAkb/sEAs4YAAs9+Yh9pUTdx6L5okUmXE8=;
        b=JdFJ5krg2wnjBlyK6WV/05sv0WGLsRaSpYeqRakl5HabXgkCN7uELCOkD+vCzBOn8E
         rMCJq01g8G+pXH8iPqBL5TVeMQ3XUr/bHeir7cRe3DWy6Ta5dYGEbiBG3yNjacO/+Zbt
         m4s9Upy0SCW76oBqMc2ihSzTQJrb9X8vKNGHrrgNrD+TBtVq9WqzV5QqiX59MOFmlQK3
         59m9c+VLz3G3G8YBPp+nlx3I440v6ZRGRXv+kUItktsZC76ROnbmaf4Q6e6EAn26rBEn
         vuRcoM4nITbMtzo/i+D4W+SHXhPbopbTpiUGLEXIz4BhjQAbJqLQRbP8DZ3NNykwpjrw
         nVsw==
X-Gm-Message-State: AOJu0YwhQlW/e93w26FHAaKRU7EwO7niVLrfNJqf4lQ8e1Vw4eQ1Y74+
	ck4Y46w/5qzZFxfTA26MYHAvw3BsdYVLm8VcUeKxShKpTXsIVITsR0KNP+Q5BG+M
X-Gm-Gg: ASbGncv8RQEcrIX/meHxXNglZV7/VGt6/DMiCrBSL2dvfm9JUaULHxrAFWqCn30WrLK
	IV7zHoWCBUyEsBxncmXZgzFMH1n2tVNeRMdvczpZsliNURREfUJthtagTf+VrhUIcXs4vDyjTdm
	VTs0rYIPYmfhI73AQVvQdIldr+rgbD/mK1vDSSTya8hTtnuiFz3NoPhUp+1EuAIIK9KNrKD2t1S
	0s6RmuYnu9+s1FdeMWWQHJo2ZoBt3xAHe5h7c3fgE3xkxR8lMBlROTjA+0M95DFSpH0PMxAMLTr
	pTnLbR4KeybV3GgicNvVcpxpNXkN92U0POVaAfaDVw==
X-Google-Smtp-Source: AGHT+IGUO9DdG0StUJ1clyKXvw9WNxxe7aofg+BgBt8eYAq9pNxi5Tq+Z4MRGz5dH3hdwJhjMec3tA==
X-Received: by 2002:a17:907:9702:b0:ae3:5e70:32fc with SMTP id a640c23a62f3a-ae3c2dc3533mr338780066b.29.1751466420988;
        Wed, 02 Jul 2025 07:27:00 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:ae73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b24fsm1084602266b.34.2025.07.02.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:27:00 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: allow veristat compile standalone
Date: Wed,  2 Jul 2025 15:26:21 +0100
Message-ID: <20250702142621.295207-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Veristat is synced into the standalone repo, where it compiles without
kernel private dependencies. This patch fixes compilation errors in
standalone veristat.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 09cfbd486f92..4b79f00b0a9c 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -23,6 +23,7 @@
 #include <float.h>
 #include <math.h>
 #include <limits.h>
+#include <assert.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
@@ -239,6 +240,14 @@ static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va
 
 #define log_errno(fmt, ...) log_errno_aux(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
 
+#ifndef __printf
+#define __printf(a, b)	__attribute__((format(printf, a, b)))
+#endif
+
+#ifndef __scanf
+#define __scanf(a, b)	__attribute__((format(scanf, a, b)))
+#endif
+
 __printf(3, 4)
 static int log_errno_aux(const char *file, int line, const char *fmt, ...)
 {
-- 
2.50.0


