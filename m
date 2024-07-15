Return-Path: <bpf+bounces-34846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86860931BE9
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 22:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83C61C21D70
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F27813CFAD;
	Mon, 15 Jul 2024 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ECa9htMZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6713B58B
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075631; cv=none; b=HqR2cFrAh9ZFXsgzOxESappuf9eAyxqBKodn6kPD8gNSiV6GeEp1WSZEUWnYfTVyoPnLykq2UfqeAmPUuOtXwnGTWF4yjKG0GS7QrXyv2ZZAejucQKkWUU2mpclM8qKtjUH88hL9128f3L1nASY94CgJ7LSb4qwVdc/NIXrezHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075631; c=relaxed/simple;
	bh=zJomEKpkKYNnqzHoHfBCm5/jn6FvVrqd1kCQ8VySfoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2K2Mv/7KYOgbxojjE3CtekPWaRQ3mQlROeq8Ao5WFnpRNvUIMnvd4He2OpA446N8MChj4JjhRFvY/90GDF8QTwjRmgWtsDvQfRPkmd5pj686Hm1bUqFDDJdGO5qLHlQfsFghZWkFnGaFxCM/ekD8Y3+zNi6RkvhZ6+6v16Dy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ECa9htMZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b13791a5eso3899145b3a.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721075629; x=1721680429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmXJ/q72ZyRMCe7zWQfBgo3XyY9yIuyVP7WwwEY/t1k=;
        b=ECa9htMZTvPPFj4L7apDKo76OcnP6ZM6CeYeRnvvTZ7GuaGvb5/QWEddzyAPtITw3N
         K7QQpFX42SW3d+jphKeTdh2j24mTzsvokGrFK2/y6DblFOUOC2BCdXhODN9C1262OB70
         zHGIBHciaJT0a9NJHWlXRkDFT/uq2UTllvN/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721075629; x=1721680429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmXJ/q72ZyRMCe7zWQfBgo3XyY9yIuyVP7WwwEY/t1k=;
        b=w628JH180YbdlWQ0+Bc+croDZJKAscWWsOkScyY8qrDku/VcQIb4NT/6L0c7Wyxkt1
         KLq6in6A2dL+TDBE81+yF6pH8deIwSzJ/4EeXdPsmHbwoo3qIqgF0lsX3W47mJAFK8xj
         1Q0cAG/sHX86ejxSaKiZ+1YiOC78KC9G1mGSu7vwk6VlJb54eV36tokITd7JJiPrll+t
         RNQofGsdq4RFFA5RAKv1z5C2vn42w3M1Z9bJTMhCEAMvPvQIJ2YIQHb+r7JcKk4qp+0J
         ruU3MGUGQ6vREDVnDrFRliQODqIcoMn1c+N+MiQRlDd/SxLzy/l+5GfoHZ+pDHJEUYVN
         yhBw==
X-Forwarded-Encrypted: i=1; AJvYcCUXqwxtVRHQPL/PClV/z/R05IEnhFcFdU94l+81CkutKT+JjcXVFBdfcxExngGjdNCwlnMf9+dYUi9kEr4Dr3nFAIbW
X-Gm-Message-State: AOJu0YwTOmXGrF8TCjW9kdJr7jEBa8HUDTJj2Bvjr57iH2oXK7FMbtp4
	bpysAf6pLcGbNv0So8Rz+q1B/dbQ0Yyk0hQ20vj4CdFdIziuEDVBJlwdsXfWA/Tor6na6TR0igM
	=
X-Google-Smtp-Source: AGHT+IFnk6iBYgvYmylTEhHv/VyQX05gg9m3qIAc6Mgy9YKCKSrAY/jDDld7K1BC1I2BGqTw6voHaQ==
X-Received: by 2002:a05:6a21:9985:b0:1c0:dd3d:ef3a with SMTP id adf61e73a8af0-1c3f123ea4amr109721637.29.1721075629670;
        Mon, 15 Jul 2024 13:33:49 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9b77:1ea5:9de2:19a3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fc0bc4ff41sm44921725ad.272.2024.07.15.13.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:33:49 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 2/3] tools build: Avoid circular .fixdep-in.o.cmd issues
Date: Mon, 15 Jul 2024 13:32:43 -0700
Message-ID: <20240715203325.3832977-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240715203325.3832977-1-briannorris@chromium.org>
References: <20240715203325.3832977-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'fixdep' tool is used to post-process dependency files for various
reasons, and it runs after every object file generation command. This
even includes 'fixdep' itself.

In Kbuild, this isn't actually a problem, because it uses a single
command to generate fixdep (a compile-and-link command on fixdep.c), and
afterward runs the fixdep command on the accompanying .fixdep.cmd file.

In tools/ builds (which notably is maintained separately from Kbuild),
fixdep is generated in several phases:

 1. fixdep.c -> fixdep-in.o
 2. fixdep-in.o -> fixdep

Thus, fixdep is not available in the post-processing for step 1, and
instead, we generate .cmd files that look like:

  ## from tools/objtool/libsubcmd/.fixdep.o.cmd
  # cannot find fixdep (/path/to/linux/tools/objtool/libsubcmd//fixdep)
  [...]

These invalid .cmd files are benign in some respects, but cause problems
in others (such as the linked reports).

Because the tools/ build system is rather complicated in its own right
(and pointedly different than Kbuild), I choose to simply open-code the
rule for building fixdep, and avoid the recursive-make indirection that
produces the problem in the first place.

Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v3)

Changes in v3:
 - Drop unnecessary tools/build/Build

 tools/build/Build    |  3 ---
 tools/build/Makefile | 11 ++---------
 2 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 tools/build/Build

diff --git a/tools/build/Build b/tools/build/Build
deleted file mode 100644
index 76d1a4960973..000000000000
--- a/tools/build/Build
+++ /dev/null
@@ -1,3 +0,0 @@
-hostprogs := fixdep
-
-fixdep-y := fixdep.o
diff --git a/tools/build/Makefile b/tools/build/Makefile
index 17cdf01e29a0..fea3cf647f5b 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -43,12 +43,5 @@ ifneq ($(wildcard $(TMP_O)),)
 	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
 endif
 
-$(OUTPUT)fixdep-in.o: FORCE
-	$(Q)$(MAKE) $(build)=fixdep
-
-$(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
-	$(QUIET_LINK)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
-
-FORCE:
-
-.PHONY: FORCE
+$(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
+	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
-- 
2.45.2.993.g49e7a77208-goog


