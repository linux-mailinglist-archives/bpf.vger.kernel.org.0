Return-Path: <bpf+bounces-76781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FACCC5584
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EACD630198D6
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93304335565;
	Tue, 16 Dec 2025 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Xa0KJkPm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38629D291
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765924108; cv=none; b=uz89tuzPKPtj5NtVmVsdDj78QK3Kfz7SN4qI0pYAmdNkL2u3aixeo8E6KJ7aQeSYcwA5N/j1+9N4Lg9ldwGjDPLevzhygWhWxwUjpyu6po7xdWSEdRuzHItoQzGOeR8ASF+PWpriytd8WFO+ejLX3LkQ0s50TZ5ftm5tyko4mgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765924108; c=relaxed/simple;
	bh=pXrOHOgt50OtU9qNRYZGsGU1LGd+HjUOfSQ5U0wLfd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQS8qvjjkstcVKoV7RgBLjyrF3uF44d0MNCxkKLvV5UiC75Z/uH+E0nXrtfv6jFa4gKEP9nXSRDMAjd3JySjwgu2SocV/3wjDnF1sWCulzdOZuVUPFbgcB8UHPAb4evsJrIVZkisMyoEQMUHyBuCKMik9DuysA1vOSwk02bVosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Xa0KJkPm; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88888c41a13so61525406d6.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765924105; x=1766528905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PM494FkTGczi3XRc72rfsPlw3tI/lSe34eAnkBoSRW0=;
        b=Xa0KJkPm1HsT1WxXl0vmlcMfkL8FaFgYsb6TY9eZUVg7mhCEBmm+k9kCk3vhwNx+wn
         lLBEbeKYYXaP8iTIVDo5BAnJui9fByf/CIMtkBDWkZIH1q61vFhSIMJczk94DiOFc/Bl
         YBw7VvvwFMpwEF0fUAcBVmVUqfSxcvambNT/I/kKEglZEDpN6Z2Lbgc8hNgQyhfA8JTy
         SS/myLVA5T0Fw/i+iKKldyrhX28sUYPoTUvwe0/8E02WWLk/Lcm+6H7+f88mvT1tNuKO
         vDLAUQZugreCc/HO9k1UE61933TtgzHuDqVSUDn5BeowMpB+IOMl3D+WWoVNkVDIi7ZE
         NvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765924105; x=1766528905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM494FkTGczi3XRc72rfsPlw3tI/lSe34eAnkBoSRW0=;
        b=fDObqmWozAJ7u1WKhPK9ccXc/npG9yoOk8roKNR3pVkoEpoY5hHctVQdO15YzP1FrN
         QH8o0i4ko4PM1lFT91mTiG/t30s1jzC9bM3NQ+efri/FfoArHArRE3fRgEFKRQnOlHsP
         lXHuVdbwTlxRHZyscWSrRTfREHg59d6ARwkRFHY5foVHuurmq5rBpyBAPKM4oKGNHmKs
         Wil3auvSEWs1cRF9JrEcm8x63zo0q7Mp5XhWQJDdvYQocLhTga/CuEte6rEtXb9bGqHv
         0iaZdyYDfdSNxNjchbIHVyb05fsudslncFW4aJqwreIpj72JnYU+D/wMSIBJviwr6Ol6
         5zgQ==
X-Gm-Message-State: AOJu0Yxhp1x5M6KhsKMkwTKidBQl6XMUnsv/I1PY2UF7nSeV9VMAa7Cc
	pGdzLlQApjRKWEnwxEIUlzIy27lObe5LQrsadh7lVmQAS56+3f5M9Ay5Uuq/H49QWY19Sl5qby3
	lEFlkv1A=
X-Gm-Gg: AY/fxX4gfA7yiyDc3ObMQEKcMwN8x1x5nBpO1XSzHSGzUXvN8h59qF2h9YYgM2kw2wJ
	0PsIGsTXXbT/DKZuwy/zch+SpeEbRTjKeRII9TXcide2Fppvie+Q0ym/Fm3IzsJ8E6MlgYHP4bP
	pLmsmfKbLmb1M3tfEIrBIU1xmXmE2aWtE/a3DX6riGCffoKpy5ZURRmmyjsfk5Pg9fiylrfln8E
	2kohgiKnDZZajKNEa7c7v0Fp3TaLpA2Bzllk00HUNOAe/3cgm/f9ga6t82fLAMhwIuL5sSEEU+Q
	rmTiqRrsBhj+m6Ldr2WN2kds/wEE4tXuyHlTWihB4LCdipXGF7Kv08pIn2jOhIgCQzL60tHY1Lj
	w9VDZKxzdhMEdB2AhFA5feG0pspcc6wXu+oaf0NirX3V6uAo39Qb/1apUPuxN/x6bsLn5qmnmke
	0FabMhRWc4EA==
X-Google-Smtp-Source: AGHT+IGXSk+QXqHtwU5td6zPqf5h9J3iFtPGRlqe3Tml+y3KKWc/OsAOn7JFgbofhNRmV44qZN1KdA==
X-Received: by 2002:a05:6214:2c0f:b0:888:4930:4c8b with SMTP id 6a1803df08f44-8887e1a7408mr261078976d6.69.1765924104762;
        Tue, 16 Dec 2025 14:28:24 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31c75e91sm274179085a.47.2025.12.16.14.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:28:24 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH] libbpf: constify string pointers assigned to from str* functions
Date: Tue, 16 Dec 2025 17:27:43 -0500
Message-ID: <20251216222743.284378-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For recent LLVM versions (e.g,. 4ed494e7282c3b36a35b8e0930fd2e14b7038167)
compiling libbpf fails because it triggers -Werror=discarded-qualifiers.
Constify the stack char * variables used to store the pointers returned
from strstr() and strchr() to fix this.

No functional changes.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6fba879492a8..1a52d818a76c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8490,7 +8490,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct bpf_object *obj = ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	char *res;
+	const char *res;
 
 	res = strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
@@ -11824,7 +11824,8 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		 *
 		 *   [0] fb6a421fb615 ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
 		 */
-		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
+		char sym_trim[256], *psym_trim = sym_trim;
+		const char *sym_sfx;
 
 		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
 			return 0;
@@ -12407,7 +12408,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.49.0


