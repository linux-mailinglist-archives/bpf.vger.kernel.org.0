Return-Path: <bpf+bounces-71378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57135BF0457
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C3904F2F8E
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B662F7AC8;
	Mon, 20 Oct 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4aL8M+I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2A2F744F
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953194; cv=none; b=H2GPT5qaUPB1XRRn6yMCUOHTFBd0F2TuzrPTLn2zEoeo0FGEkJGfbrkJyy0MlvVsuq/FJwY6h0P/xNyUyMU+U377uo5g/96ZvOasmjkztk8QAGzqN/HX+RvGrXcmTEfeEJl5liS+rR94GaRnN7lputnXuK738/a48TFQyUg5K4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953194; c=relaxed/simple;
	bh=ugDn8c1lW1orwqdqhvNXZZRri40gpMmMmMcEemnXh6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgjeYT/7wRC60hXhoYkTWxGi0WfzNb301Daut0HkqAIwHMAaRgENjoOVih4Xco1oiDYvzfB/ufj4viU6GjOUIztgcOVB8NwLIM0vprJXh4Q9qVudIXhavdHeSqcEi9yXuX15sh14cuT0Y0Z6wKIVdzMyExKaYE5OegfzPbceGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4aL8M+I; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-791c287c10dso3193761b3a.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953192; x=1761557992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52FJ4sV7PeUmrKe+3MVtvr5aRK62gcaubO05HKMB1Gs=;
        b=j4aL8M+I7seDFaslC8lfK/X/ytzafCZqx9oyZh55DmhKKDex5Px24Hq+tBP9nVdG1w
         BcdlRMuQJ/EyQaY9jcJBkDahPjP7wIKxPDgeYjQ/0RleJh8KUqJ5Uw5h2F8iwbO42Urj
         qQcyaUVY6n/5NYlSjvvK3M2C7R0pdt2kz1o90JWLPZe+vbZpcqtgNSb+v5DvZgrUW7Yy
         oyWkN1Zn/54FhKNpxNMAzO9QjYQqjccW9+P5ELQLaMMg2qI1gnprkW5BYE2ed4woWIa3
         LEmlyIZcvuPO+M25ZefidjWaBT/390sP0A70UqUzJk9Q/QsCSpz7eeThJ0LQbFaxuyLc
         4Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953192; x=1761557992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52FJ4sV7PeUmrKe+3MVtvr5aRK62gcaubO05HKMB1Gs=;
        b=IUDnJ2rczE53vyI7/f0/CBQBd4T7QcwJ9tMH1nZ8Ws9HEVa+b2tCO2i8zUNb1Z9eBV
         R9LrgILSDgHvvnUXpNLkE3Q340J4cAamYGPh3fEikqw0cnJFBBKyVtDqKdaV7RfZn631
         Sa7D+/qljM8DGLtuXKzhj6WrabZYSkO8ombwtI+KrLgk+eEsJnKJWAh0OhivXFW2oOlm
         26UfWx9iFCid/qobXDH1DI8iH6c7QqZiTJe0nhSAtqaOnCOrkGZpW+H+SfwU9VG5fQr0
         NJSqhNQ2dsc7ylCNCNdsTVfnraH9NCF5PRCrF0tJG1S6uqEtYR6kCYTuOKRU0+2SNreH
         9WOA==
X-Forwarded-Encrypted: i=1; AJvYcCVlI5n8ObWJEJevbLVXEnzzuLGWb1o1EJEYankalvDBOWvSGWZvkwfLZx+cKEqXFRP2BLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDD+05trBF4mF+2NMlRRNtIifEdTvGngaVH2JEYsfaT3y2PPYb
	vAIM/07dyhZr7W4fE2TFO1/RpPPtqSBd1KvEiGckC2UDW75OQPQoEz0W
X-Gm-Gg: ASbGncvpjz9jz0yT+oi8UYXh9wYAbvPph8+pQeD4a0YK7odka02oGiX9K9d9pK/+V9B
	7CDo27xZSm0a1YTpGxrIxbOC8M+ghL+3HP3YcBs/8a8LQBo0LiwaeOfDyFTW3SFO/fYrQ4WsCZ4
	VrYGJ+OH9BvZdeQR86SrdjQEE0RUKlhal/QkCZiLEX7AnhKSXbq4bbshg6Al/RMa/GVu7fJ+jna
	X9w+NlAA+6rGo4qd8EwNhYUZSM2CU05IpbtFnQHhayYPlOCQKiMkJZgzqZbGTmBecLN/pxOCPVp
	oSc+Cw4rjIB4m7MdSmGVCYd+o/M/DWF4WOTzyaf9DfqZH2goqEOJZLV1oVCX3MjcPU4gO+qez1M
	U6239bmzphocTsXvn1eMaQOOTWkS7GgIM6sXmDolh429On1/8FjQYsgixjUvZZ03dyVHgUzdiJC
	Sk4gmz5JXp55HzY0FCmcWfiMbQ5y8=
X-Google-Smtp-Source: AGHT+IEchgGNOZqdezdEtqnT/rI36dWl4KIQU1k/DQ/xqsCVOOSCdlbhYXFAwti9fT8qv9KnNzaQvQ==
X-Received: by 2002:a17:90b:3dcb:b0:32e:b87e:a961 with SMTP id 98e67ed59e1d1-33bcf85b526mr14610819a91.5.1760953192310;
        Mon, 20 Oct 2025 02:39:52 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8091fsm7617200a91.19.2025.10.20.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:39:51 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
Date: Mon, 20 Oct 2025 17:39:37 +0800
Message-Id: <20251020093941.548058-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020093941.548058-1-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change btf_find_by_name_kind() to search the local BTF first,
then fall back to the base BTF. This can skip traversing the large
vmlinux BTF when the target type resides in a kernel module's BTF,
thereby significantly improving lookup performance.

In a test searching for the btf_type of function ext2_new_inode
located in the ext2 kernel module:

Before: 408631 ns
After:     499 ns

Performance improvement: ~819x faster

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 include/linux/btf.h |  1 +
 kernel/bpf/btf.c    | 27 ++++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..ddc53a7ac7cd 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -220,6 +220,7 @@ bool btf_is_module(const struct btf *btf);
 bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+u32 btf_type_cnt(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..c414cf37e1bd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -544,22 +544,31 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+u32 btf_type_cnt(const struct btf *btf)
+{
+	return btf->start_id + btf->nr_types;
+}
+
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
 	const struct btf_type *t;
 	const char *tname;
 	u32 i, total;
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	do {
+		total = btf_type_cnt(btf);
+		for (i = btf->start_id; i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (BTF_INFO_KIND(t->info) != kind)
+				continue;
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
-	}
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (!strcmp(tname, name))
+				return i;
+		}
+
+		btf = btf->base_btf;
+	} while (btf);
 
 	return -ENOENT;
 }
-- 
2.34.1


