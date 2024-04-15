Return-Path: <bpf+bounces-26756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7D8A4999
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24AF1F22F3F
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A6381BE;
	Mon, 15 Apr 2024 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4qEGlA6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A58364CD
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167932; cv=none; b=AOA7S4xSQ5rKEuBB2TomKL5/Jyw+wZN+iIbzVufCVXwOgxmzMXrW+CvKIDFv7hb6rFcy47fe+ftV2ketbZBy0qLe5hsckiIhyYwLbOqvQ8CfDmMYNJsDLfpNntRw5NcsdbK7ECwILP3jRleC05SClt8d2YrEyMsobHI5Sli9dRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167932; c=relaxed/simple;
	bh=DkpORLakWw5z143JLN76w0dBh5hI4i2x8TQpiySZiJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jRYcgyDMNGDKejIFVfumzup0PoRo2IOtL6+2DXYqrZeM1jS60xyiAZWizJ+0u+rt0z9VqczwwNppUHgwdeKDP3TafZpc5c/O+NaBIkzp5D7SY4+hewsqFXfrsD+O2Oh2+WcWZJOBnhJA28PFM0whOenpQQXO80y/Bmsnvq2tb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4qEGlA6; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343bb240f70so2030569f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713167928; x=1713772728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nirUBk2IWA4nfF0nBoVFV5ytdr6rujdVL1Z+GvYP3xQ=;
        b=k4qEGlA6yPmLSRUWj3VhIDRGReCoCkra8/37M7U5wzOdaaDOGK7KtyjVh1URO70ByQ
         YK5CCqJ5/e2QQ87Hwdb9R4Lu3Fi+DKS3t7OFZRlS3b68GRtEHgTRYc03Vj+i8qwR1JgS
         8oIfVBALC8OCOnvQGoSmsyJ5v1/1GCsLk7rbG02aSjb6oO6TODqx6WI6FJ+nNSDotOhQ
         +cIieU2ZTrsYZpkz6ffTJLAS5YtDe7U+VgjO45A4h5ZtrBiBQOs5PjvBTr1+FSrAAz7D
         2Nj1ITgfvJZU+L8VwrE8Md5S6BXbDnlkDOWQZpXPuOQPyLfFJwY8S7OLxKqR3jDL9Zw2
         9zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713167928; x=1713772728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nirUBk2IWA4nfF0nBoVFV5ytdr6rujdVL1Z+GvYP3xQ=;
        b=O6eDShoazZ5tljHQyjxGG4kDofgP2SyZA5LreBUOAQQHhu+8oUmFxpXQAVX0pgeRfP
         HD9vDDap/Qzipwrjo9JYDik6rFTLCSv3kNBXdub0kcy5BM7ky/cZILnoh6GR7n7D9WNo
         5zmCVThIzdOcgr+mrF4aB3UfYGWQbI1jJfyIgyX2IbsKOotzGvgQRD47ci9qrUiGPk0U
         SceXMSD4w/OmWTF8Efp7ezGIP121YnFa0ULDAbO1iFc9MBPbA/2xcepROVRD36H0FejD
         ifshpwCPp6eljxGfIsMzRyKX+FPZZ0BzQC0MX5va6oouoWNtVKvYt1KtSUP8Cpw/keTL
         Eh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmK+yZn+QVMtLlKhkAq9JdN0VaB6OXTJdDJIXOF4cx3KNhtHtakQMSDyoNFCjBD7Ug/K03W9K2bO2cCqocZ16oEVwj
X-Gm-Message-State: AOJu0YwjqUzvKMcceiNudq9ItwflJTMEe5KLoisLr1c8alNNxSRYspJc
	SiZfLpXoUuUFQICOLFbft7LBv2fZW4KgSI6nYx20M3280Doz33hLTEGHPXXsNgUYI+idiQ==
X-Google-Smtp-Source: AGHT+IHzVTEcbzhRB0NY+AesRBH9T0OrQX3XqSzTwn93e3fEP/KlQT+PWFn3pPDq3hFeDtqmO+tmVi7S
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:f2ca:0:b0:343:668b:be05 with SMTP id
 d10-20020adff2ca000000b00343668bbe05mr21274wrp.3.1713167928341; Mon, 15 Apr
 2024 00:58:48 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:58:40 +0200
In-Reply-To: <20240415075837.2349766-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415075837.2349766-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=ardb@kernel.org;
 h=from:subject; bh=iEnd1kipFuUW1SJUvbH5tb3oJXutwpN4deu2O40wcts=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3mnv7dQ+w3umb8jUpXzD++6X70lFcO50+yRerp3Fu1w
 u7gZeuEjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRJ64Mf8XPzF71ff/fFSHP
 jscwXJcx+urf8D5r276S3g3vGGWPPznH8D+FlWu3ew9/xPHLtTaJmu9bXyRru679z7f1Z9muwK/ uMqwA
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415075837.2349766-7-ardb+git@google.com>
Subject: [PATCH v3 2/3] vmlinux: Avoid weak reference to notes section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak references are references that are permitted to remain unsatisfied
in the final link. This means they cannot be implemented using place
relative relocations, resulting in GOT entries when using position
independent code generation.

The notes section should always exist, so the weak annotations can be
omitted.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 kernel/ksysfs.c | 4 ++--
 lib/buildid.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 495b69a71a5d..07fb5987b42b 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -228,8 +228,8 @@ KERNEL_ATTR_RW(rcu_normal);
 /*
  * Make /sys/kernel/notes give the raw contents of our kernel .notes section.
  */
-extern const void __start_notes __weak;
-extern const void __stop_notes __weak;
+extern const void __start_notes;
+extern const void __stop_notes;
 #define	notes_size (&__stop_notes - &__start_notes)
 
 static ssize_t notes_read(struct file *filp, struct kobject *kobj,
diff --git a/lib/buildid.c b/lib/buildid.c
index 898301b49eb6..7954dd92e36c 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -182,8 +182,8 @@ unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
  */
 void __init init_vmlinux_build_id(void)
 {
-	extern const void __start_notes __weak;
-	extern const void __stop_notes __weak;
+	extern const void __start_notes;
+	extern const void __stop_notes;
 	unsigned int size = &__stop_notes - &__start_notes;
 
 	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
-- 
2.44.0.683.g7961c838ac-goog


