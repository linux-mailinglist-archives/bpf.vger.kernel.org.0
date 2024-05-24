Return-Path: <bpf+bounces-30487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6258CE619
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F14281C89
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4308663E;
	Fri, 24 May 2024 13:21:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8A126F14
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556878; cv=none; b=fN5oBo9THcgDPeJLYFQKxdXCdEtXTgTjZnYLtBd+5dxJSHQDeHolJqAt7eMWq53EtZMWvOKb6D2gRgKhQ4AJ4zptK5fPPdbeoC293EdwBX0ZOtgo/Edv/8ZbeMXLWNrlIn0SawqxgsmXwMY2lMw8Jfi2spQzWaQ4dHN6YgS+c94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556878; c=relaxed/simple;
	bh=d1UERISKr8wJEH+/PsJVt5NJLpL+vaX9jRNLPUMcLh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J15Vg4zlg/2Nyn9MJL/0nK+hGWMAAPMLAH0PmmpqKqVnKBzSFYmzSEUAkWcdzT1V69Y0i0Lo6ljhxyBF+CNSbwMqpY7SKNuvmd9pw5aQaOYjjDKYFFVqoWqpurG7nlhfJKgCZ4ge4+DPvZWJ5tAzgYzZ2JIaoSDgebyc1y+kOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6267778b3aso75241766b.3
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 06:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556875; x=1717161675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNV5pOrSGf3hB32x1ZE1WE/B9uWQ6cG2rQ3Vlz1BKM8=;
        b=dlo3Y3W2h7mr/PvCfJMD6c7ZcIgsyONRYOzCC+nHNysu4PrmvUzYVUoT62CRi7zdbG
         oKV8ek9zQl65Ez2xDrTAgxQV3CJbDIEmimngeeMLwjZ2Jn1jXqLmAklwsUBCVZBB80c+
         IdE9SwunSMqkuhJ+1J6XfVuWyt6gvN+QMrrj+xVdqbOn1hA5JSOJF8d2wtlPcbxJP/bW
         2nnqbsCDlkP+qlyWnxTKItsNthcP+hDsyqwxLkwKa2wXUvJBvFTZHgTBxNyF8ocSBo4V
         n3bQcCRGBVJwsvHigWnG4eQJ+p1MIuNQb5Esi20QmA/1FttvEb/xbYZK7ulDC8B+McvX
         TH8Q==
X-Gm-Message-State: AOJu0YztFwtEbSVtDQMs7H7Cl2Wf0qtWLuHTfQ9q+ru+POHL6AJ8LEuD
	/8GDmEAXDXr0eGArd+Q1LAIplwIZnx3KWF4SXz0Nsl5mCc5U9cEERJB/hg==
X-Google-Smtp-Source: AGHT+IEbzsHW7OSl8QRwPBzsELEDJHqflV0eGqoY74e9YZZtIeU2hFE+Ol99tLtfFm6O41+sPJTN1w==
X-Received: by 2002:a17:906:37c5:b0:a59:ce90:27ea with SMTP id a640c23a62f3a-a62642e9528mr144286766b.24.1716556875255;
        Fri, 24 May 2024 06:21:15 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:400::5:da48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c9377e5sm132017566b.77.2024.05.24.06.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:21:14 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] libbpf: configure log verbosity with env variable
Date: Fri, 24 May 2024 14:18:40 +0100
Message-ID: <20240524131840.114289-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Configure logging verbosity by setting LIBBPF_LOG_LEVEL environment
variable, which is applied only to default logger. Once user set their
custom logging callback, it is up to them to handle filtering.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 Documentation/bpf/libbpf/libbpf_overview.rst |  7 ++++++
 tools/lib/bpf/libbpf.c                       | 24 +++++++++++++++++++-
 tools/lib/bpf/libbpf.h                       |  5 +++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation/bpf/libbpf/libbpf_overview.rst
index f36a2d4ffea2..982dfd71a13d 100644
--- a/Documentation/bpf/libbpf/libbpf_overview.rst
+++ b/Documentation/bpf/libbpf/libbpf_overview.rst
@@ -219,6 +219,13 @@ compilation and skeleton generation. Using Libbpf-rs will make building user
 space part of the BPF application easier. Note that the BPF program themselves
 must still be written in plain C.
 
+libbpf logging
+==============
+
+By default, libbpf logs informational and warning messages to stderr. The verbosity of these
+messages can be controlled by setting the environment variable LIBBPF_LOG_LEVEL to either warn,
+info, or debug. A custom log callback can be set using ``libbpf_set_print()``.
+
 Additional Documentation
 ========================
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5401f2df463d..d0465ca74afc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -229,7 +229,29 @@ static const char * const prog_type_name[] = {
 static int __base_pr(enum libbpf_print_level level, const char *format,
 		     va_list args)
 {
-	if (level == LIBBPF_DEBUG)
+	static enum libbpf_print_level min_level = LIBBPF_INFO;
+	static const char *env_var = "LIBBPF_LOG_LEVEL";
+	static bool initialized;
+
+	if (!initialized) {
+		char *verbosity;
+
+		initialized = true;
+		verbosity = getenv(env_var);
+		if (verbosity) {
+			if (strcasecmp(verbosity, "warn") == 0)
+				min_level = LIBBPF_WARN;
+			else if (strcasecmp(verbosity, "debug") == 0)
+				min_level = LIBBPF_DEBUG;
+			else if (strcasecmp(verbosity, "info") == 0)
+				min_level = LIBBPF_INFO;
+			else
+				fprintf(stderr, "Unexpected value of %s env variable\n", env_var);
+		}
+	}
+
+	/* if too verbose, skip logging  */
+	if (level > min_level)
 		return 0;
 
 	return vfprintf(stderr, format, args);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c3f77d9260fe..26e4e35528c5 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -98,7 +98,10 @@ typedef int (*libbpf_print_fn_t)(enum libbpf_print_level level,
 
 /**
  * @brief **libbpf_set_print()** sets user-provided log callback function to
- * be used for libbpf warnings and informational messages.
+ * be used for libbpf warnings and informational messages. If the user callback
+ * is not set, messages are logged to stderr by default. The verbosity of these
+ * messages can be controlled by setting the environment variable
+ * LIBBPF_LOG_LEVEL to either warn, info, or debug.
  * @param fn The log print function. If NULL, libbpf won't print anything.
  * @return Pointer to old print function.
  *
-- 
2.45.0


