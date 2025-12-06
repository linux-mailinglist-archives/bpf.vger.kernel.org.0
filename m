Return-Path: <bpf+bounces-76212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BEDCAA376
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 10:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD7530D47C8
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2EF2E9EA4;
	Sat,  6 Dec 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6FZsZ63"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC42E8B87
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765013344; cv=none; b=e9xwPzc5DLHjyxCt+NIu89GBRP+IgLK2vRd7d8u/ymUgIQhMqWeQcAGxjPbvswj77S93zvBUhwAr3OuxJ887yuT0Gix8ntTj/4YlVWsPZAukd2K6Ghw0kuN8V3qFa69a4puir1TpvvaJqxeX8wfBZHqgwNzdNIBX+AXWCpbiIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765013344; c=relaxed/simple;
	bh=tEI0oNpRyE6qcr0IBduItDjyoXIQ5mQ3MWZTJAf8Z0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccV90Uncc3hpW/CnIeMGawRD6NrZAHu3KMay/T4Uuj4chcg2072Uq3fNiOpI75iyWZBuUbNF7O1dSgBU3sVkG2vfCenMuxWbxFJqTqWjaj18NLSGFvFq77JDszvJLBAyVSzsi1ndMukkE6DaLKGxTGTyACB7eDWDexOBzmy4UXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6FZsZ63; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59445ee9738so2420825e87.3
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765013340; x=1765618140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mkL4mldJYKw7ojYdbxn9IiTrYaThkCUYNslYp30fxs=;
        b=K6FZsZ63Mp1kWU9hYYi+aMMZXnS+n1P0ROYimyRDuzjzaHlruiRAd/tETtEcYlZX+4
         vruBmYyT6O7pgqpNUMNTUWUQ7xk7ETF3RXCtfEd+fdEzHtDlGKeYXB1BWcHF6G2svt9x
         viAPQkC1N2gb7NDFTuDfYJ4FjhmWQ9xSluwfENhpfZNMBOJCU3YpCC79ZCZofUIqrzHa
         lMXrPB6V4BEqrBOqE3uD2IZz7gmFqNtCbsu2qndGIViGyDbW+u7UW5zk8w1x8qYagmbU
         Ml5uaiNqvWNAOtW5oX3jUkYIUr8PKV8XsZpilSdygEDPpiJclnmNFXE3krJ8qUyK6S+8
         T1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765013340; x=1765618140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mkL4mldJYKw7ojYdbxn9IiTrYaThkCUYNslYp30fxs=;
        b=Hngg6v2SHo1yzfIaHG7JbQnO6elcvsJH9kPYKEv8nV7Dm3n/YPXW3j1SSVF98JQz6L
         PVea6d7UDlJE0hxCJxJNON/9YL8r3Em0KEnUcUyocurDLCbXnwrcmPa8+2gWqeTwSfWu
         LngxJElVCy7AA2GzICsJaPx0lKeDsmflRYbpkf4/phkacl2MAdJJWO5v/dL17OQRQaTh
         Fgp0AivFCcbMuciqhZuM9GTWp3Zjy7JGccpnx8LZlIMtMVJVKae8WFp7TPXYQGqFEz6z
         yfXGtoSBboSr5UtKrIEpztfvpAIvfh3HorbxiDuwa8a9xEzt8hsCDgyUBIDVlPT/cs3I
         A4+g==
X-Gm-Message-State: AOJu0YxJhttU5RJj4whYT/bBQJZYy6SrLO7oP3+1SJ59S/Pqcg18b6Bw
	kRVu8gPZkjaI+dWDEWgWDcJ7R4tetV+cLaXEMH3hnA8W04FgDeXASGdsSMkubFPGgmiX3HuR
X-Gm-Gg: ASbGncuHZ3Ged/VesD6HhN8O9gxp1rhIPlQXWCp7ui+xAQB7FXfudrYXs4Rp5nCEm5D
	RFXKovXVhzPFn/5XWYDni6kWyCdrzDuLZ6i5LE0xl0qulS8BvIWDhjW+ww/0OixxQeiJQXMAdCe
	SMypK8TRyDA++7pWgH/rawLMBjEXtIx5/91DMqdfSr1SCuA38mZUw/pusKcJdXMhVqSROtpPCT8
	JPAKGe3pxdR7efLsEUcB0765vLFyd/t78RQeImBnfL+IHJ5a+vDsdWTad891kqxCCCJ2QcrJPE9
	IV53KPCQPYUJhVW5UbodfCa+fh0BdKIhwYS9MFWveow5QJAgjgdKbXnGj2qnALIXj8Lr74pfias
	wBMzJKKUmaUnQTNI1ev+NQWLWUP0R5g40kptls1d51g8KE7s4n0It/bmRuWYPsaIZgPr5bXzeCj
	RTnDlW8RD/HnaVwjXXoO2O/Q==
X-Google-Smtp-Source: AGHT+IFyOAyYsnU/+MuGqXG8LBM/n39WgfIL/eBystNfPUfaEn0B797BFJz5V0TDvy+Byv3w5CCKcg==
X-Received: by 2002:a05:6512:2342:b0:594:2870:9774 with SMTP id 2adb3069b0e04-598853caadcmr561368e87.38.1765013340232;
        Sat, 06 Dec 2025 01:29:00 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597dfc536e8sm662726e87.7.2025.12.06.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 01:28:59 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	fweimer@redhat.com,
	andrii.nakryiko@gmail.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
Date: Sat,  6 Dec 2025 14:28:25 +0500
Message-ID: <20251206092825.1471385-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAEf4BzYOhiddakWzVGe1CYt2GZ+a57kT4EyujhoiTQN6Mc6uLg@mail.gmail.com>
References: <CAEf4BzYOhiddakWzVGe1CYt2GZ+a57kT4EyujhoiTQN6Mc6uLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

glibc ≥ 2.42 (GCC 15) defaults to -std=gnu23, which promotes
-Wdiscarded-qualifiers to an error.

In C23, strstr() and strchr() return "const char *".

Change variable types to const char * where the pointers are never
modified (res, sym_sfx, next_path).

Suggested-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
v2: use const char * where possible
v3: split declaration of sym_sfx — it is only read, never written
---
 tools/lib/bpf/libbpf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3dc8a8078815..f4dfd23148a5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8484,7 +8484,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct bpf_object *obj = ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	char *res;
+	const char *res;
 
 	res = strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
@@ -11818,7 +11818,8 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		 *
 		 *   [0] fb6a421fb615 ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
 		 */
-		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
+		char sym_trim[256], *psym_trim = sym_trim;
+		const char *sym_sfx;
 
 		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
 			return 0;
@@ -12401,7 +12402,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.52.0


