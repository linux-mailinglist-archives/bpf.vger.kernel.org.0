Return-Path: <bpf+bounces-12941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436867D22F5
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0498B20DEE
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568863B4;
	Sun, 22 Oct 2023 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF2axAcs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3323A8;
	Sun, 22 Oct 2023 11:40:42 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4089EB;
	Sun, 22 Oct 2023 04:40:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578b4997decso1723415a12.0;
        Sun, 22 Oct 2023 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697974840; x=1698579640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljaI8yne9hbUxqHM2K9k1jzFfYFrLBrIFmHWl9mQXzA=;
        b=IF2axAcs5O6tn01geX9QwfuHUN/2NM1DAptM3bwG8oNZY+M+/ZgDjF2U2qrSv6Smqu
         GVt3Zvgl1EX9f76L1Z/m3kBuA58k8Q/durr7dvnbsY6XSboieVRv9ek5aDMeBTdKcHFu
         LGZ3aNon/OD+Ugunf5UUJr05MjvGRVhFVcrVRZSkmydbxMRtavJw5FMjBnZY9Z1M8Nqt
         qQN+92oLU/FuHQ3nos9+YnCo7sxP8FmCIfZUy4Q4GJg3YXjeuciMhJZSI6LPl7gNAiSW
         jsIjo+Y/pbQfNCjrZv467Zmj+Iu2RhY9Hlp72R4Ni8R/pQ3BaRNLw1ZWCFgNUVFRjkBo
         +Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697974840; x=1698579640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljaI8yne9hbUxqHM2K9k1jzFfYFrLBrIFmHWl9mQXzA=;
        b=J93ZDv/qJIfyZOVZwbjBa+IOjLJ5P6lM1UQgLvqIULanyS8f64Ig60J3aHhasoJe7h
         86QfTTWG5xrenKUku/7ToQ6Q8GMVSLJ01huYXKzrcUrBdRGivhij2XdXSzvz2D1muwZV
         JUJV/70bboUelVtSdSH0cKxVQnc57DpXCtUyIIG9ZnBWvlajBZmT45liH5/Ltz32iq0O
         BBSfyXA05mWDxePY+g64/j1PP+BoTwQvOoc6N28M/Mo4yNVYzGkuyx5XUQlu48CZizqU
         IPY5mm2kwBJn0nx/QC64fOxtATsRS7T/voYgrBvzNUpb1adO7fKsEp6pCtFbvjcWRzA+
         DT/g==
X-Gm-Message-State: AOJu0Yz2KMgKtMWD2g0lNMqCwRhCfsJAvJ3Ef4O+BrHNJ11gZYkgaRar
	m6vqANuM63M1NmbxPHvN9pUWeNSq6zY/OQ==
X-Google-Smtp-Source: AGHT+IEUMOdRI5f0m/WLLxCApC2EsQ2VXCemwXQik4qn0vF4HdxcQf4GriQEDxoM5N8eFRRdkPvMoA==
X-Received: by 2002:a05:6a20:394a:b0:17b:2c56:70b8 with SMTP id r10-20020a056a20394a00b0017b2c5670b8mr7740804pzg.22.1697974839695;
        Sun, 22 Oct 2023 04:40:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:20a0:ad9f:f712:ea6f:f4b9:17c2])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79563000000b006bdd7cbcf98sm4441833pfq.182.2023.10.22.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 04:40:39 -0700 (PDT)
From: James Tirta Halim <tirtajames45@gmail.com>
To: linux-hardening@vger.kernel.org,
	bpf@vger.kernel.org
Cc: James Tirta Halim <tirtajames45@gmail.com>
Subject: [PATCH] strstarts: avoid calling strlen() if first char does not match
Date: Sun, 22 Oct 2023 18:35:47 +0700
Message-ID: <20231022113547.168081-1-tirtajames45@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 include/linux/string.h  | 9 ++++++---
 tools/bpf/bpftool/gen.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..1c51039604e7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -214,7 +214,7 @@ int ptr_to_hashval(const void *ptr, unsigned long *hashval_out);
  */
 static inline bool strstarts(const char *str, const char *prefix)
 {
-	return strncmp(str, prefix, strlen(prefix)) == 0;
+	return (*str == *prefix) ? strncmp(str, prefix, strlen(prefix)) == 0 : (*prefix == '\0');
 }
 
 size_t memweight(const void *ptr, size_t bytes);
@@ -356,8 +356,11 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  */
 static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
 {
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) == 0 ? len : 0;
+	if (*str == *prefix) {
+		size_t len = strlen(prefix);
+		return strncmp(str, prefix, len) == 0 ? len : 0;
+	}
+	return *prefix == '\0';
 }
 
 #endif /* _LINUX_STRING_H_ */
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2883660d6b67..5f8db7e517bc 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -36,7 +36,7 @@ static void sanitize_identifier(char *name)
 
 static bool str_has_prefix(const char *str, const char *prefix)
 {
-	return strncmp(str, prefix, strlen(prefix)) == 0;
+	return (*str == *prefix) ? strncmp(str, prefix, strlen(prefix)) == 0 : (*prefix == '\0');
 }
 
 static bool str_has_suffix(const char *str, const char *suffix)
-- 
2.42.0


