Return-Path: <bpf+bounces-74819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D420C669A8
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8206B343F8A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4304B317709;
	Mon, 17 Nov 2025 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="x6zpH9Yn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2F30DD2E
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423828; cv=none; b=gq5GQXSVoaFYUkRs0ZMwBNCl7WCVLJfspjGAw3RGvAQ/pXhapTzuYsTDxPKct3g5jFv9lk4/8KLvLvCH9uRsGbYUbm0Y3KUdETw7HwJJEYOvnXETtDTXtmTE13KBnFmXxaCz33hESMN3kbOVzTo2hVdqYZBllQi3dLKwbZcmCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423828; c=relaxed/simple;
	bh=c1IyFbHOX2idMINBtXrX7GH+BKTeybjwVnG+q9GqabI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko2ADD15cHAa2pFlsObaiEh69V11DX/HAtThOjEAIN3ldmzmRKZi2XJsPmE+OTxm70YcbB+qF6YzKBp/FAq5XpUimLe/bVAKyGOFg+1mesXso1ftRM6uc8KCeDioLAchJ368VgIX/67lAw94qUabGoUAnSIgrEEifKo5IqT6z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=x6zpH9Yn; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8823d5127daso56503496d6.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 15:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763423824; x=1764028624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvtCJMihnDhsJMQjgOrRxxwn67jxIU81fxfJ5Bb1Nr4=;
        b=x6zpH9YnEMb5WDi7Gu5P39pHJ9gi0S6jNtfkkVQFr4ahFTwYNMsOGh36U5h92WYvEy
         8QmwwUbMwEgaKzI/ZZNEwK/stYXpx4FoC7lTUsJtxnOP3uC6kzLTy8RyMHxifRRUTkbV
         aVS/i+Clgsit7svTbX0teNd+0HcgBiJ4t209nlF5ugwrNr4CYHF+u5CrVSU0cJA7HmjV
         f3meoghp+FsZERN9H44u6gYCFwKAIX3b9zUjnJ8aZbAOSpYED4WVbssP6mKVHVpIGn55
         8Ifs59mtFbkkcGYx3jCHHBFzh8xLLFHasLrl0mGGdyU7u8OhYa26IUrIBr/oL1GP8zw1
         QT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763423824; x=1764028624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvtCJMihnDhsJMQjgOrRxxwn67jxIU81fxfJ5Bb1Nr4=;
        b=j0M1ONvfp2XHkIcDDm3I3E1x0FnI0EEa+5mesd4RURrOzpPKY9QDuBkWP0mj3CgdE+
         c74HFEQzep4oRFReg+szM29B1EpHD5XwccRmc3RQ0GKvTfNkYzV1ivfmNovuZz+5NTNG
         tFMN0LP7VxVYOJjusn83xVOAHY7TAbB13fgz3h6cjkUxQ2iwkhXgcp6byI06MZNVI31O
         xEHd0AXJ7YfJx1j9kDVuKCXlAimVvD6oUxO5Q5xlxreSkGhOjiFXNKvdTMDSnIEi6WCr
         bGcx7La5+YhpBmOzrbh3mHA7Ud4dLTWE2px5eItMwns0AegTGCVHViIctqQ7rfKGkm6z
         j93A==
X-Gm-Message-State: AOJu0YzCJdD4q1m7GK0sydTuGjD0c7dB/ulVG38cKxWDTqcrLW/sm7Ei
	MUqiPhTTkY2yAY8stYk+p9nUWy5qdLkC3I12YxK1p14DIMzr8Ynx9sNdrCHX93EVDaL3xdrLElX
	L7eF6qKs=
X-Gm-Gg: ASbGncsCFdceeAir5JC1S0waPfZApJU3ElZtNrIZpgmbNnNORwfF3qovK5VhfOigsjU
	glRAiDC7XAuBDMeXn5/mF8pPOcr7W2xO6h1vQLam5JS2/XFjrbnPIS5d3lZVA9eUqt7jKv02OQF
	LZpeMGd6Ebqox9Ioo2Af+im5hOdf+Avgdnpok3yFHF/f8g0ugzY2Tc/dSsf+KrmA0l4oBIlpd++
	FCmOARSeQnS2bPyW70CDsToFIUNb5EELN8TKmAJrNpsC0jMb3G37xMC3YZcv+mbATO7JM7o4xjy
	rFqF34IAhaJNRE9uyuTHcrjMbAF1h3RxaiBMwkHhfzYL/76q2n7SdSgtoFlj5v96pxJKVHOcng9
	JdvJ3j8X8pQFKWTMZgcSXC4KSzxYS8EJzt8ze3iTKsTgbCez9JvEMG1mrDfcJqmUZ8Q1duaL3pg
	w=
X-Google-Smtp-Source: AGHT+IHm0II1PXEgdL2duuIPv2kgxRpVVLpWevTZ2o+L1VLZGhdJsqqYUr8AFUSZYoJanHfqLqS5bg==
X-Received: by 2002:a05:6214:29cb:b0:72b:37ff:b877 with SMTP id 6a1803df08f44-8829267c1bbmr211022786d6.42.1763423824456;
        Mon, 17 Nov 2025 15:57:04 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862cf6d5sm103077516d6.11.2025.11.17.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 15:57:04 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 2/4] libbpf: add stub for offset-related skeleton padding
Date: Mon, 17 Nov 2025 18:56:34 -0500
Message-ID: <20251117235636.140259-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251117235636.140259-1-emil@etsalapatis.com>
References: <20251117235636.140259-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a stub function for reporting in which offset within a mapping
libbpf places the map's data. This will be used in a subsequent
patch to support offsetting arena variables within the mapped region.

Adjust skeleton generation to account for the new arena memory layout
by adding padding corresponding to the offset into the arena map. Add
a libbbpf API function to get the data offset within the map's mapping
during skeleton generation.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/bpf/bpftool/gen.c  | 23 +++++++++++++++++++++--
 tools/lib/bpf/libbpf.c   | 10 ++++++++++
 tools/lib/bpf/libbpf.h   |  9 +++++++++
 tools/lib/bpf/libbpf.map |  1 +
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 993c7d9484a4..6ed125b1b465 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -148,7 +148,8 @@ static int codegen_datasec_def(struct bpf_object *obj,
 			       struct btf *btf,
 			       struct btf_dump *d,
 			       const struct btf_type *sec,
-			       const char *obj_name)
+			       const char *obj_name,
+			       int var_off)
 {
 	const char *sec_name = btf__name_by_offset(btf, sec->name_off);
 	const struct btf_var_secinfo *sec_var = btf_var_secinfos(sec);
@@ -163,6 +164,17 @@ static int codegen_datasec_def(struct bpf_object *obj,
 		strip_mods = true;
 
 	printf("	struct %s__%s {\n", obj_name, sec_ident);
+
+	/*
+	 * Arena variables may be placed in an offset within the section.
+	 * Represent this in the skeleton using a padding struct.
+	 */
+	if (var_off > 0) {
+		printf("\t\tchar __pad%d[%d];\n",
+			pad_cnt, var_off);
+		pad_cnt++;
+	}
+
 	for (i = 0; i < vlen; i++, sec_var++) {
 		const struct btf_type *var = btf__type_by_id(btf, sec_var->type);
 		const char *var_name = btf__name_by_offset(btf, var->name_off);
@@ -279,6 +291,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 	struct bpf_map *map;
 	const struct btf_type *sec;
 	char map_ident[256];
+	int var_off;
 	int err = 0;
 
 	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
@@ -303,7 +316,13 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 			printf("	struct %s__%s {\n", obj_name, map_ident);
 			printf("	} *%s;\n", map_ident);
 		} else {
-			err = codegen_datasec_def(obj, btf, d, sec, obj_name);
+			var_off = bpf_map__data_offset(map);
+			if (var_off < 0)  {
+				p_err("bpf_map__data_offset called on unmapped map\n");
+				err = var_off;
+				goto out;
+			}
+			err = codegen_datasec_def(obj, btf, d, sec, obj_name, var_off);
 			if (err)
 				goto out;
 		}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 706e7481bdf6..32dac36ba8db 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10552,6 +10552,16 @@ const char *bpf_map__name(const struct bpf_map *map)
 	return map->name;
 }
 
+int bpf_map__data_offset(const struct bpf_map *map)
+{
+	if (!map->mmaped)
+		return -EINVAL;
+
+	/* No offsetting for now. */
+	return 0;
+}
+
+
 enum bpf_map_type bpf_map__type(const struct bpf_map *map)
 {
 	return map->def.type;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..549289dd9891 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1314,6 +1314,15 @@ LIBBPF_API int bpf_map__set_exclusive_program(struct bpf_map *map, struct bpf_pr
  */
 LIBBPF_API struct bpf_program *bpf_map__exclusive_program(struct bpf_map *map);
 
+/*
+ * @brief **bpf_map__data_offset** returns the offset of the map's data
+ * within the address mapping.
+ * @param BPF map whose variable offset we are looking into.
+ * @return the offset >= 0 of the map's contents within its mapping; negative
+ * error code, otherwise.
+ */
+LIBBPF_API int bpf_map__data_offset(const struct bpf_map *map);
+
 struct bpf_xdp_set_link_opts {
 	size_t sz;
 	int old_fd;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..ac932ee3a932 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_map__data_offset;
 } LIBBPF_1.6.0;
-- 
2.49.0


