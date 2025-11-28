Return-Path: <bpf+bounces-75709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D369AC92206
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127DE3A4EE3
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C832D7FF;
	Fri, 28 Nov 2025 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiq+zvN7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4934328B7E
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336390; cv=none; b=XwaLxGgyAPsMrAacLVouBe0LTPmIs4Ghp1hxhp2XuLw95rqErvkjJRaaPvYmrKu/kovzbtVpI2G7v4CzEgGy0fCKDVXglXtaDbYjs+mbMTTX4N2u/5NTHBOzjDU012TfdLap/L0fuZ0sUVWoTrk0+pytVmvTUoMqoynZfX8qimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336390; c=relaxed/simple;
	bh=tGbtpwQZbYcsBGxCvCJU0NCRNlyFyYC8UngI8Df4fxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rr+nyX4vFnXjIZZJXl71XG0agEGkn6RHKC6IKKsmp+/WOFufFuLXW5JqI5McPktHDt0JMfOcaK4iT1+O3Hrk3UIbIKWAhOnb9rG/JFvGEatrx5HocxVPzQ9bX92DiW58Iw6U/9KVr7UdmWEVl0IrkBbD01d0QudWRcwcOamZwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiq+zvN7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5959da48139so1882204e87.1
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764336386; x=1764941186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdFQ1YYHWhhvBUzcmDRED6f3M4xLb6AiLGcDNwc9BAU=;
        b=jiq+zvN7MIlWlwBAg/yduSd7UtPY9Qg1JqJ3r1H1rELedVDkFMeknCKXAXB7gJBuMr
         B+guUmfSAFBN+Jwb9rez3j3l5uRXrX7KUxiHz2+ZHwNo1A87Tj2kCL8/4UsbMvsrZoa5
         r6oaLip3mQcjwLFhOmUCBH3g1E00qVH35RIkAMP0PjFheiQuYfUJ/3CjXQNTtv9EOWrk
         o3d6kSP/+O3LfIe43nSEKHpBUAFwmqIPwfw9wE6lP9M6a3LUXLR1ffBrMe62ExjKhEKo
         vrGckOhvbhkS/e85b+dn+beo29u07w2ZJcO8HMzPE1uLWW1pUpZW3lbKxWCgGgc320ry
         DiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764336386; x=1764941186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdFQ1YYHWhhvBUzcmDRED6f3M4xLb6AiLGcDNwc9BAU=;
        b=t+LzqFwuH0vm8vgTY3r3GbrId6cEdTjQH74s2VUewyuI5DIPfmCQlMJJcVuOx1PuGm
         z/mtCcogmpZw/Y/R0eEcvKqj2bcu1WgBq+kRwm574nZh/0Pb0i0sqdPnmZBqq4ugbCRD
         uN65JbE9muS1YgtswDft5RGJ4Fwi0A/wzW1kj/oITVHx9nzXJeq89wh9PbY91rtDSPZF
         0/gYen6UbBSzROwpcLY+y+zXeK45aT/kaiiC2UkzoavCxIslRROpVTQixD+3A/vTe4fV
         CBcBGqWOGyPUT6fGbk/hB5DAuSuXgxHpfC0jCejuYIBIc+NNlTbrQjBCZgWz+j7BtZzp
         GAOA==
X-Gm-Message-State: AOJu0YxvPMMGlQ7IgWcWbgsqF9hARtPGWZodyZ0bMTdWu8gvjHdbXihZ
	sL6AkGD5lZfmKAP23PDA7LlRHjLpWKSgm/D72gdgfY9L5sThxmvnr3qa64iQHNl4DAp6WZC5
X-Gm-Gg: ASbGncth5bNcuDvrL4iT4bA99NRn1cfaO0aU7iMggmF4uDzxSr1NfAqXDe6C3FyZohM
	4oVZLjDPjM1zNbpgM5HhUnFO/tqqnSNTCpmX7MuORvpR5cKiz7AXPqXX3K68AnUjggZ9P+YtTjY
	4iG2S4QQXHNNwvFG6DICaIgTqL96acJ5TULDggjNBD16zocy4nb2lguD2CgY+Aja6DCFFJhNjwZ
	2VHAYEAXQZAaNnKw9f6eQZlrZbIgJbG+Pp8k93WU1Q0suQyC+pUA3XjqDjRDOmpMEL9eYrX9LbM
	T8UB3nf/4K2tKV5TwlzKUSzYSQ8x3pjLBGmV+ICVtnZZB2fWbTNsW5WwBnj1gdzkwJ77ftuYdkb
	7MsOwOjd5w1WwGn0iJgcPI5a1J2yrxpobPwVTi5VOWXuEy6vVkDNsgYln8TU7jmah9WckUl6YPC
	rk0KlxvJBfLAwKAB7c7sbErw==
X-Google-Smtp-Source: AGHT+IH6iO7df/kBjndp92kih1rmCc6w3PJabzexvI/UfRtgczNpX0VZamDAdZh6FVm8s9haM8nMVg==
X-Received: by 2002:a05:6512:b86:b0:594:1c7c:7d31 with SMTP id 2adb3069b0e04-596b505816cmr5268664e87.12.1764336386240;
        Fri, 28 Nov 2025 05:26:26 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf85faeesm1223388e87.0.2025.11.28.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:26:24 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	fweimer@redhat.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 bpf-next] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
Date: Fri, 28 Nov 2025 18:26:19 +0500
Message-ID: <1531b195c4cb7af96304341e7cbcaf7aba78e4b3.1764334686.git.mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com>
References: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com>
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
making previous implicit casts invalid.

This breaks the build of tools/bpf/resolve_btfids on pristine
upstream kernel when using GCC 15 + glibc 2.42+.

Fix the three remaining instances with explicit casts.

No functional changes.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2417601
Suggested-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

---
v2:
- Use explicit casts instead of changing variable types to const char *,
  because the variables are already declared as char * earlier in the
  functions and used in contexts requiring mutability.
  This is common practice in the kernel when full const-correctness
  cannot be preserved without major refactoring.
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


