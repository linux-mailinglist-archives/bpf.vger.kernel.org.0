Return-Path: <bpf+bounces-76210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA75CAA2A0
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 09:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 439A2301562E
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 08:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92B2DEA70;
	Sat,  6 Dec 2025 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSGr7AMv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE11266581
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765008445; cv=none; b=GvBDJa1MwXkL/+2FWiakgOmqso6fqeWlobaXsRYGUq/z0UFuoNqsEty9+EU8KD3FxhjM+OFUpcvbhdvdtKkcio767jDkX0u85WVriblwX5nBLF0gjBY9757sdV3O2i3/J5/GQhQ/Pa3vsmjP97Nx0D+8CxS9qDg0jVORzfeQD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765008445; c=relaxed/simple;
	bh=EzK1xSEeoZYFgt+SN23f5jLrjvDUlqWbGJK8L3GexEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqLExzlYO7Ur4uN0YOIxYcf8HznP0XgI/E6oQuL9wcYj6K0KiUwj6o19ivbqcJISTa2hnssZyihhGM/mChyEw20mamR6sCNHfjLdth+3CCRGWdjQ35L6QQQLM9CngZZjsoH0X9p56UaSeRyQLG1pd+/YGTEpe7zo1DwVAVYcVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSGr7AMv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5945510fd7aso2322360e87.0
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765008441; x=1765613241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmjX+/74hwVvj05lgvnfrMHTKDHiJRLsWl0Oo8OJzdQ=;
        b=jSGr7AMvMz6TmwWqJQ+bsNeE/iuyqsv+DD6Fz/VIHdlMrVK8xhr3ca7e4ySVXzt7Rf
         ORhAEZEQf6UObgf9wI3hxS4GjIan8ha9aETJbghfX5vMVMcI52mzfULqsdCAI74VFkyr
         TEdSTSyHx8oJ5dnnjnp/oWh1IJDagbzLWx4QXgqoPCVhutmSbmOM4Ep9+y6SCyZpwiR8
         +uXNMMPZtCDaNMr+VLEHH33UqGreyKsRL0P5ufqrGJcZ1M4hvcmUYSiCjG4VoS375yP0
         1XNDloBrmxPg+nskF9jJnch75jBuLI1QU80/y6XsD4mhKE623uZe3sMV0I2BDUyBxaGJ
         JvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765008441; x=1765613241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TmjX+/74hwVvj05lgvnfrMHTKDHiJRLsWl0Oo8OJzdQ=;
        b=Gr7wBYMUbCpmYJ+GOFTW8ntqTKYAA0dtGcdh8U5cjMlsi0hh/3ZwxH+U9KKotDIaD1
         kZm0ptvnSjyNlBHFMzkSedidW6MjONKpXnTcmVT2rUuzM4jFv+4jQsqY2SfXn8U9YLqo
         JWQ49eTxyySE3sEUm4LiuuUunhbf2oGM5imG5QY7d5dJ336vaDs/zTRb6KVAsag7vyz7
         6VcMRiT9aeBA1XoQZ5tSVvHfGqcRVeb1Q81xtyYNn2VVknzTCi19dLucQ/2W+kIdDvc5
         Stnz/EhwYIUpowZ5FLTaJ86M/nsGgZsxgRLPFFhVcpUlMgkmt3Fc9RvCMB3naYFj8lpN
         AGMw==
X-Gm-Message-State: AOJu0Yzc0IssPUzKbsqCF7Uphyqo3Lwfsmh7nS3K6NEYNeNLv58BxJ8u
	ir8yKTzQATRydjUJEdQPfKc9cOsGpANgtAbJ4Uln9HphpzGbiPkhq9L1sgQGy5H8wsnlOdWt
X-Gm-Gg: ASbGncvGOmrgJttRGHyS8+Ieve8SyrbI71gULOrorNLk7095mCQrm5Ixl4fg7Mxja/+
	kW8iteu935p/WazsUD/ssvV+OLxYpbZ7LMtXClVoxqfnoj3VblAfTCYvawLnT5Zn8VUqYBtGnp0
	tt7UBjDzrzaX1Y6RqSHub1xZmoJAZNmA1js2VK7ov1sTP6GyExhO/YL36EfztaG2TaydR9y7yOI
	SYaNdUK5k2nnmFXXQ8EEnt9+6WyaDuiHAl0pXIad6gAzA29YJ2P56mnZHhuxr6vLP/7dJwL/0If
	hWqWGXuKE8wufpXVb/Wjbj1mZq4AgoeifqhRQXzOrkHykAnECIJ2bzoZ8OKYUmbAV00XsvFoIGK
	D+DjxLxQceAyj8BnH9qOwQMVo0Qd/C0/QUTqllt82X3XI5P0EtZPijBd6Fwiy0+i+jH3sH+WDJX
	Q1bVMQ4SBpYVsmJ0e64/AE2w==
X-Google-Smtp-Source: AGHT+IENZwxifIW25l19qn/rrWzvbs7Fu6MxW18X3oSB1XP/Q4gykgCunKuFotwxlBv0BPpftItjqw==
X-Received: by 2002:a05:6512:2351:b0:597:d7a1:aa97 with SMTP id 2adb3069b0e04-598853c2a06mr506880e87.33.1765008441126;
        Sat, 06 Dec 2025 00:07:21 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c1e2efsm2225848e87.56.2025.12.06.00.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 00:07:19 -0800 (PST)
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
Date: Sat,  6 Dec 2025 13:05:56 +0500
Message-ID: <20251206080556.685835-1-mikhail.v.gavrilov@gmail.com>
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

Declare `res` and `next_path` as const char * — they are never modified.
Keep `sym_sfx` as char * because it is advanced in a loop.

Suggested-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
v2: use const char * where possible (Florian, Andrii)
v3: declare res/next_path as const char * (never modified)
    keep cast for sym_sfx (advanced in loop)
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3dc8a8078815..81782471f1d0 100644
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
@@ -11820,7 +11820,7 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		 */
 		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
 
-		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
+		if (!(sym_sfx = (char *)strstr(sym_name, ".llvm.")))  /* needs mutation */
 			return 0;
 
 		/* psym_trim vs sym_trim dance is done to avoid pointer vs array
@@ -12401,7 +12401,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.52.0


