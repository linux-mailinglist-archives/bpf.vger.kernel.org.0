Return-Path: <bpf+bounces-75670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7313C90648
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 01:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014B14E3229
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 00:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812F1F8908;
	Fri, 28 Nov 2025 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWY91VvW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF31E3DDE
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764289336; cv=none; b=Uuu7kH0sXWVP6A1N76+lGGkmyaZgmgmR3nJwmvr/bnNtCjgMpa9V/+a/PHQMLTsUQLVzlCCnnGdLvSt5MKCfE8gRSfz4fEswQtPFEFyIQvv0GW9XzwGwGZooyrYcHx+N+Zu//9DNgT5uFOGHNQlHAjEci2t1kpYWQE9JWbzlvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764289336; c=relaxed/simple;
	bh=uqb/L/q3aY7qhk1wEM4sR3q7k+W+i/F66aMpMLso4Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9lSeYd08J1FLR1k5nQnhl2QX6Xpp8yfey4+FaV0JKZaITUNdZ/oExv5Zv+bzTSAEeQeSh1TEv8M31BPn9F8w6of87AwmIafaAMgsJXCia+/fNkH8zJL0XFCzrfcDFV6+WLn05NGjGRyrbtMt4eFLYy6kqjXKMnAEOVGAQjq4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWY91VvW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso12786481fa.0
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 16:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764289332; x=1764894132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf6N60/mMdoTovxxehc7oTOUR+OA9D6npRAoGA+CQCo=;
        b=OWY91VvWaATLp6ISzZv8k3zefRR7LM77xrzVMHk7k9G33mMLkceLm1snG/iK+m0iLD
         xknVfOZOLu/06YSgSB4Go8go5LZ7zPrzk5uE7eNHJevSFhPEerJL7L55Hz2ZeYUSXnB8
         D7CrhwlHRHeIztdBaAxaolpzN0DC8rS37MguRBIPyI4yTno+1+VkOm7mEhLG698vuPGB
         AgauAxdEMUJXFX8qAuwnt1aFD3vJaOxHltVsFMQrtq9ba/cpBnfzVjAtB3lgPx8KQCLs
         ZHZxJjFeeUeU2CMQEzj5ViG8ydLkNlcFsLN+9ZCjBOHuTFXmX5GR7eIaHDme5FMRHSNL
         pPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764289332; x=1764894132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf6N60/mMdoTovxxehc7oTOUR+OA9D6npRAoGA+CQCo=;
        b=ePlCfjN/uA2Mlp7nnNzpqgNOeHUX1G5A6B6K2eIV32fj86PU9CxgW7dyVD96akHdma
         abLWQp1A8WhNYGPWL3sWSG+6Hcu4IoqTFwTyYIXtBurKYKUKSXSfSS4JtyPKEEr1T19Y
         0Hvqbx3PicGntM51dVkFwFsaPTiOZHJ35W7g+MZMUbDYwOFmNfg4C/5n+l+q9oOmrK2P
         0us5DuSBST/K1y+KuBBW5Tkm0u/J8xOaTo31y1kVd1FwAcC+2sKL301F1l4zK6C7Fihj
         VOqWj8ZoNkAnTsej1yc8eg3pnB2YHRntqXVovejjmRru6BgNg1OUI3BE9pqYFbzx25HA
         e9Fw==
X-Gm-Message-State: AOJu0YysiQ+yrzsAYRelAsi6BBN8o3V5Or0Tqnl1Of8ZcRes004ES1F9
	lqG7CGAkLSMEJ9AWG4py2bOFLzwHtD0DMhUVTsFzj3l3fgd+7Ta+F47Y4Kz8hOLWsMZyqDA3
X-Gm-Gg: ASbGncsGyGxrGNEEFWytmwXxOOBLL6HsljHo9IifdRtwoIV5y/5RkawZuk64SRc0t/q
	WChR1lpdQeYAwRS0jT4cAjEDuLNZtKBp7ai+PfRHy97AWbg0B0XABvPe1bsQ0dyCDtsScuwAyKc
	gEO1EpkrCln+uIU8ri1Gmd+l+1WSwsHB8WTqeFUqD69+82cgPA7k6DBzqzqaqgD6yCjSoKQUDWV
	tFl/mx/fQ2F8ykDC7o47111NBIyHw5q4k+kFMeAjDH/mlHiRtr0FG6zruMqT06iBqrDRxgTj2zT
	CSbTuEEo8oE3iP+68zR17eRJLeawp0lYaY05bSC+gy/lbxMAawSyi0SyEV0zjIFvdAg1ZduVoIm
	GsQiGIQbofVXcLaIpt9IfJ6MR7FGVoOVCQbr/1gN2UXuDxC/3egENUHiZ3vOKRkyJtHprsUHocx
	xf4lTTSZNYIB1nrn1dsOyxWHEuZi00kXsg
X-Google-Smtp-Source: AGHT+IG5Lh6pz2F5iqFt6VoinpQe18k4/POJqvOw9W50U6/e5NJ8ro1yH+njl0Uf0CWi3in2pYmOoQ==
X-Received: by 2002:a05:651c:4394:20b0:37b:8bee:87f6 with SMTP id 38308e7fff4ca-37d07985d9amr30935611fa.38.1764289332296;
        Thu, 27 Nov 2025 16:22:12 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d236dd782sm5949731fa.15.2025.11.27.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:22:11 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	quentin@monnetweb.net,
	netdev@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
Date: Fri, 28 Nov 2025 05:22:05 +0500
Message-ID: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

glibc ≥ 2.42 (GCC 15) defaults to -std=gnu23, which promotes
-Wdiscarded-qualifiers to an error in the default hardening flags
of Fedora Rawhide, Arch Linux, openSUSE Tumbleweed, Gentoo, etc.

In C23, strstr() and strchr() return "const char *" in most cases,
making implicit casts from const to non-const invalid.

This breaks the build of tools/bpf/resolve_btfids on pristine
upstream kernel when using GCC 15 + glibc 2.42+.

Fix the three remaining instances with explicit casts.

No functional changes.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2417601
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..dd11feef3adf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8247,7 +8247,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct extern_desc *ext;
 	char *res;
 
-	res = strstr(sym_name, ".llvm.");
+	res = (char *)strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
 		ext = find_extern_by_name_with_len(obj, sym_name, res - sym_name);
 	else
@@ -11576,7 +11576,7 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		 */
 		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
 
-		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
+		if (!(sym_sfx = (char *)strstr(sym_name, ".llvm.")))
 			return 0;
 
 		/* psym_trim vs sym_trim dance is done to avoid pointer vs array
@@ -12164,7 +12164,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 
 			if (s[0] == ':')
 				s++;
-			next_path = strchr(s, ':');
+			next_path = (char *)strchr(s, ':');
 			seg_len = next_path ? next_path - s : strlen(s);
 			if (!seg_len)
 				continue;
-- 
2.52.0


