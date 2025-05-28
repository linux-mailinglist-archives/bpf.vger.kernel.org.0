Return-Path: <bpf+bounces-59111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95093AC6077
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7D3B0C87
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E562206B2;
	Wed, 28 May 2025 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7XJ3fwC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC01F5413;
	Wed, 28 May 2025 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404226; cv=none; b=jTKbQXEwTtAsx1DTD0L5AW+JHWzhBgWhDnvXd4VWrZcAYo2dlloHj8FSYnAfHOOVOCTk8sXEWTNNs1V4pBahObrilJk0sVxCYUht/R62vFkO76rVY9qlfSzeQtGggvtI+SNZR02LyHMnocjIDjA1molPzxlrWPXCV68NBs7mkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404226; c=relaxed/simple;
	bh=OvK/Q/DfXMU6KN25/kQRxR9LncmbU2X3WDmeadWtX7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1YaLm2HBhtyI8RcDxvXMIVJ1CvyIp4ME6Q5CMDrp9k4HIwNJiyiX6fcxhyJCbl+QxKZvfek2qFc14XFHes2kbxH/xDCBrbhbHhoDweDmKbpRtN0HTo+OzA/3J4Re2LzFjXfCaUPYB2GW9AFx4mHK/gCQT2aHZZ+mmnelv8CgTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7XJ3fwC; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-234ade5a819so11271675ad.1;
        Tue, 27 May 2025 20:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404224; x=1749009024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS7M6SZuFz0KIT+q3oUQfoKiK682acaipuzojcNU9pw=;
        b=f7XJ3fwC0imi8+XxddHxa6CiSMneohc2d7alfId8DXMVY0DpCAM2th9oEYTXHSwy4B
         MAU1eCVGK+2sFdMBozAl4TNO9Lwe/dUG4egr+hj+C1WSlNH6NCMS2HjD4b8quig9sUpB
         tsh1u7uji48lVfec2JfT2fq3RAeG164WW/JSjzWJ+DkuRBkbDsSgbIzypusx0s6DPRGa
         fnHmRtbhyGaUv2PozBePWA3m2wfN55T8fpYX4kOcL9MEQ9c28H7cSdUB5FnY6MpV3G0q
         u22NQ3Y8GpcusXxP88leLCxm9Vi3yuhXK42sE6HDpuTrvk9+yF1//1Gj611AqOMwJqLe
         U+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404224; x=1749009024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS7M6SZuFz0KIT+q3oUQfoKiK682acaipuzojcNU9pw=;
        b=CyM59Fx0ij5mknyZiCRt6yS7XRC3yfcakAneKfl1Wo9CjeU6k7dWNZtDpzBWkEeiUp
         iDYsbeazN+tYSVt5M1dxjobExnH4mUthXIRIacmOlPMM9Hc+0pc+3Xd2/6KWE4iJp6m8
         toka9oTZo20JzSkZYnjqmAAyPV8r0OhjQyDzsqat7ILjBsYiEOfmhCvDQ7k36Pd2JGX7
         OqWYrgi/Q863+kSPC3GgXR0XHau3kBpIlSeTDWHQhtoT9zme6qK6gxPL+1GCyJufbk8n
         hw6heo6FpzqLDVN560sSBa3BHDKzU84JT74NGa295XV7jP8WFa4nXu1SJCX2sYM+GfBQ
         lQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKtdVMTS/i/d5OypAaxufHxUKakusO8xuu6Zug1U6M9mYMSjvUo+2GJUOZeN9kopuowoiR9HQuFN7ldUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkExOWjlm5uAFYvsr44Pa+OO6vbKimZ535d3TEnFXuyrDIRqfa
	SzFez1sEkYff+ZmeSjffHbqWjSoVwa4AJ6JqCO+PVGYwF5uueJxsPBLF
X-Gm-Gg: ASbGncsDPZbyKEnffy4nhNCMIuEdzVaTS3uWv3OeABWKNITzL2k281YoB5QADnMxF20
	WgxRH0W9gxXNIitfp4r2LYlBJY0XceRBnBT18zFHmDqp0gsSj0th4lHlSpPCgzClizLf58nv8CQ
	iJQwZABm4i691PpxsWtsTtBv9uPL6YiT1FKKJsrfvUdoa/KyQKWX4N609Khc9eJew7H8V0SH1YB
	Og9qdPQpNj4cPnVMf6MHfFUqASowwfhoPQVBOuSSVJjHq5AVJCgYELllU2N1G1tC3R6UILog9xp
	2oyj5qk24GS4k8hrzhW4m7eU0po14MaNUmjzORJ5M5+jUwiBqT2no3lC15sMJ3wJOb3t2wtVSDH
	olzY=
X-Google-Smtp-Source: AGHT+IH0eSpGHXA08+6NiTdGlaPyUo6UXH/UGs2FC/ewWlNyd1asZxmq/TnGKqHq+2JIpPmABK5pvg==
X-Received: by 2002:a17:902:ec8a:b0:231:d461:5326 with SMTP id d9443c01a7336-23414fe6ffbmr208440535ad.50.1748404224137;
        Tue, 27 May 2025 20:50:24 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:23 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 22/25] selftests/bpf: use the glob_match() from libbpf in test_progs.c
Date: Wed, 28 May 2025 11:47:09 +0800
Message-Id: <20250528034712.138701-23-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The glob_match() in test_progs.c has almost the same logic with the
glob_match() in libbpf.c, so we replace it to make the code simple.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 309d9d4a8ace..e246fe4b7b70 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -17,6 +17,7 @@
 #include <sys/un.h>
 #include <bpf/btf.h>
 #include <time.h>
+#include "bpf/libbpf_internal.h"
 #include "json_writer.h"
 
 #include "network_helpers.h"
@@ -129,28 +130,6 @@ static int traffic_monitor_print_fn(const char *format, va_list args)
 	return 0;
 }
 
-/* Adapted from perf/util/string.c */
-static bool glob_match(const char *str, const char *pat)
-{
-	while (*str && *pat && *pat != '*') {
-		if (*str != *pat)
-			return false;
-		str++;
-		pat++;
-	}
-	/* Check wild card */
-	if (*pat == '*') {
-		while (*pat == '*')
-			pat++;
-		if (!*pat) /* Tail wild card matches all */
-			return true;
-		while (*str)
-			if (glob_match(str++, pat))
-				return true;
-	}
-	return !*str && !*pat;
-}
-
 #define EXIT_NO_TEST		2
 #define EXIT_ERR_SETUP_INFRA	3
 
-- 
2.39.5


