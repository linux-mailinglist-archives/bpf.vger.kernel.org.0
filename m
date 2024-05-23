Return-Path: <bpf+bounces-30434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70838CDBA3
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 22:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B492842AA
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 20:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C585284;
	Thu, 23 May 2024 20:53:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6984FB1
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497631; cv=none; b=NfW2Js54ArRo/2oxalS04xe6qRRN2bAjZitvwC51U/ZuBkRznrCD5rw34mRtyndFEjZZ+GhXPSa8Q49k+JywqnyWNmZSd3juobJnSkBpourgVv2+gdpTQHhIphPqm7sZXAKZGvhFt2Acnad57dIrG0/UnvSZ8+ZFqfOGG4zjSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497631; c=relaxed/simple;
	bh=ss3JtrMhosGvm+4ic1huq/MW0DeyeugcAZhDIMSSSRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSsH/cXyqXEt6GXfG+dQ092PaoxKcsV3xmxzVOFI2Ln58zScyaSE+EzpxS0xjtbsGQecRFhQacnNUWySLxGBj58uHM0A6bmTg/DebMw2x9sFaUZjoKPG1Dcr/6dylHQpjHlMHUk8ECMIkDqBo1L0GXfQUyHszgp32bEw3QhgcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e95a7622cfso1979951fa.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 13:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716497628; x=1717102428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YK3PrwXXixlX2DnsKKSaolamZJCENyZh6+9FehPXCc=;
        b=Dlwx1kthKnuGC6e46R4+2V9YJqcUHFbeA3Xt9/po757fpmwdull+vDl4FTGMLMWCx5
         lzdy7D0hZMmfFeO9Iu5LdqFrjo0sJYP6xchgAVIyNXuflODqMO4QCe46ImJDP9BPL4WK
         hhxgkDUbgBrOqdIWeo+eDQAaaasmLwHh27nLJpUwLSxMlTH2+Y/3D74fB8go+KSdgoeK
         jjZ17dZ7VOIQs1hHoq4iHSuHAgzTxqHeyDMe3RFRZPgGbh6ffKFP7t4uLb6zLK3oJjkF
         PyI9g1a/ypGw7XJHHPqFzrx3FSqdIRP/j4GV+r4W5JOyoe3GHD5iucj90jJQMWcRd952
         2qKw==
X-Gm-Message-State: AOJu0Ywz+Y4NqKOWw4VEyl3jFPp63GA2PfWOHY4QLKwpoKJ9/OdiNcqZ
	SM7qoskg8eEfToHN+r8QbMd0FstsjYgnZxwB9a8dWdHKiceczAP/GuEx+A==
X-Google-Smtp-Source: AGHT+IHQGQiOXSM3NeM9Zz0n8pZRTpuAZssQRGn5euTxjynLxwm5DEJ0TP2n4rfzQ+4APM3ZUBTzZw==
X-Received: by 2002:a2e:b003:0:b0:2e7:134d:f79a with SMTP id 38308e7fff4ca-2e95b03e0d8mr1735821fa.10.1716497627853;
        Thu, 23 May 2024 13:53:47 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::7:4857])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bb79esm180752a12.92.2024.05.23.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 13:53:47 -0700 (PDT)
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
Date: Thu, 23 May 2024 21:53:37 +0100
Message-ID: <20240523205337.951410-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Configure logging verbosity by setting LIBBPF_LOG environment
variable. Only applying to default logger. Once user set their custom
logging callback, it is up to them to filter.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5401f2df463d..8805607073da 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -229,7 +229,23 @@ static const char * const prog_type_name[] = {
 static int __base_pr(enum libbpf_print_level level, const char *format,
 		     va_list args)
 {
-	if (level == LIBBPF_DEBUG)
+	static enum libbpf_print_level env_level = LIBBPF_INFO;
+	static bool initialized;
+
+	if (!initialized) {
+		char *verbosity;
+
+		initialized = true;
+		verbosity = getenv("LIBBPF_LOG");
+		if (verbosity) {
+			if (strcmp(verbosity, "warn") == 0)
+				env_level = LIBBPF_WARN;
+			else if (strcmp(verbosity, "debug") == 0)
+				env_level = LIBBPF_DEBUG;
+		}
+	}
+
+	if (env_level < level)
 		return 0;
 
 	return vfprintf(stderr, format, args);
-- 
2.45.0


