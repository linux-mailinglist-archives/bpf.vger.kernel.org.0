Return-Path: <bpf+bounces-21597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9FC84EF91
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA6528D45C
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8885240;
	Fri,  9 Feb 2024 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJNThMhJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0705227
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451630; cv=none; b=n0cBn7C2GSXn89qhMAV9KsuHYRN3QlS6/nAJva7BM0SCAiFBQwqHlKh/aBB5fakJAS/FKXXrLcAYneSII3KJf/hSZ4JEZtoUhiZtecbrxHSy3mkCo5YuRUNAug6QdzwNyHBIZDuhOzMIMq1s40WsBvpdtf0pXNh7oPBVLKxdTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451630; c=relaxed/simple;
	bh=fZ6Y58uW7ogEd7gM1JqcAJ0v8UlMwmoELq7rWQLCEXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cxs80Gvho+kaJ7pUnEvqN68jXWQt3T+zPQSHUDC/2DHqTKhYxxRD3pwEshiPzhFza1ymYZPmWt2FJ5QUMqIW6uLuusWkSQlUsbTtXH4zhDLnS7JmbItDEfYfganVVHxatewf0xPNxznWRyN1wqAaZhugU2W4e8Qs3vDaCzoWiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJNThMhJ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-598699c0f1eso317144eaf.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451628; x=1708056428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0RFXFHjgEipVAjjo7rYUK8PW9TKsuaRbrDEibnvW4k=;
        b=JJNThMhJdUZEC1apPjwJ9s5S+feCPTlTNOf4PSk9HQBE5aYhIJ7MGRqnkrciJtzyWa
         hS5p0jSZ3spk7EFoEe5JA6fIEP0M6mzT77S36aL16zzu8B8BozkFjUncJ/vdnf7Dd2E2
         Rz1wyLpcCRn3fjfn6pDGV0HdmX1h9YgBzUihwqAlm6f3t9PUfrfbqBdHo3Aebck9qX4v
         8pySTEzJLNsXpRYdxM4yUlt+fsTr05T7TfpbY1kYF9iIbiS3Z+X2FPVIt9U0e4PNneeb
         vTPsnSAAkJFkJ9F8MqsMjlC0xR+n60UAyt72QJ5XhB2bf0vlQIQDSoLIpaI8k2ut8Vvg
         kiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451628; x=1708056428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0RFXFHjgEipVAjjo7rYUK8PW9TKsuaRbrDEibnvW4k=;
        b=aJMfxVfBeLqDgqnhYjkLf9T+sf6IE9nRx/W8u7xI4GD8Aa1GAjMjOft1hOZ4D6HXqt
         QY5U6K624su6Q2gjwRjVBZduFxW045dVY82qIjF4UZ3SRCy51eS/pXw30WceXkgd3zFG
         OCZqEz++mNL7JRdA2dP7DXjOEKOj1e78vuKqwir1i8escnNfyGioHV18iamBLUvKtPDx
         fggkUsdX87TFI3G1yrOngm4F6aIrOHRq1Bqai9nWnAsb9EdJ18K1TYav/vOiI6RQbyWR
         40wd3l3AcnkDgmvqdGxAjOk/dIOqy66vvPR2gCVDCEa+7NPgGwX9zNIQFKaHWEMVkElZ
         ZYyg==
X-Gm-Message-State: AOJu0YzBpiH8LsuoYXRHL7Ltjs/3EwIv4ZxCjcxMxMZO2kfbpTNkqR6d
	sS6nZVsx69ikoz8S3YQFRjWp8g6OMrLFFpVJsBsM5VxirSCnLnoZAVOzcmSy
X-Google-Smtp-Source: AGHT+IH3ELoemyowyx9wDHV3307l0ycjd0Y77bmRJBAVEdimNMeIuNSIlIwPFXHELajuyUjjlQuC3w==
X-Received: by 2002:a05:6358:5923:b0:178:fcd3:c316 with SMTP id g35-20020a056358592300b00178fcd3c316mr369964rwf.19.1707451627656;
        Thu, 08 Feb 2024 20:07:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoqc11kvj74nhgP0ItrhTalUSnkiKOdLRkeNXEUDkXxEiRPRf5d4bYuosF+6cOhfxzAMXVsl+t9+QOFHt5NPTVLFeWfXCYrBD7zGBhDwyKkAg83xUqbq16d4W438iTv/u4iqXlrxEfu5sU2ANBjPMqsLutqvxFcyLN7iF8AmK5czq/wJC1HhSd5mJgCo/vuHecDmQai1BM7uVYVxdm2xvH48dSiZe88KkqjcoFFxkEbZdmbNwrubW/g03c508mJ+Ep58KUOUKGi+0TXrw5efj3tEt/fIfNkCt6kmNdiEVmolW+mb3CmnCkJvU+Vf3d6lOpC4xDzA8R75HxOgkWVg0SLXn4HSflWlWByPP9oqC5Q5ltk7QVRA==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id r15-20020aa7988f000000b006e02da3a158sm610623pfl.17.2024.02.08.20.07.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:07 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 13/20] libbpf: Allow specifying 64-bit integers in map BTF.
Date: Thu,  8 Feb 2024 20:06:01 -0800
Message-Id: <20240209040608.98927-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

__uint() macro that is used to specify map attributes like:
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __uint(map_flags, BPF_F_MMAPABLE);
is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of elements" field.

Introduce __ulong() macro that allows specifying values bigger than 32-bit.
In map definition "map_extra" is the only u64 field.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h |  5 +++++
 tools/lib/bpf/libbpf.c      | 44 ++++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9c777c21da28..0aeac8ea7af2 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -13,6 +13,11 @@
 #define __uint(name, val) int (*name)[val]
 #define __type(name, val) typeof(val) *name
 #define __array(name, val) typeof(val) *name[]
+#ifndef __PASTE
+#define ___PASTE(a,b) a##b
+#define __PASTE(a,b) ___PASTE(a,b)
+#endif
+#define __ulong(name, val) enum { __PASTE(__unique_value, __COUNTER__) = val } name
 
 /*
  * Helper macro to place programs, maps, license in
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4880d623098d..f8158e250327 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2243,6 +2243,39 @@ static bool get_map_field_int(const char *map_name, const struct btf *btf,
 	return true;
 }
 
+static bool get_map_field_long(const char *map_name, const struct btf *btf,
+			       const struct btf_member *m, __u64 *res)
+{
+	const struct btf_type *t = skip_mods_and_typedefs(btf, m->type, NULL);
+	const char *name = btf__name_by_offset(btf, m->name_off);
+
+	if (btf_is_ptr(t))
+		return false;
+
+	if (!btf_is_enum(t) && !btf_is_enum64(t)) {
+		pr_warn("map '%s': attr '%s': expected enum or enum64, got %s.\n",
+			map_name, name, btf_kind_str(t));
+		return false;
+	}
+
+	if (btf_vlen(t) != 1) {
+		pr_warn("map '%s': attr '%s': invalid __ulong\n",
+			map_name, name);
+		return false;
+	}
+
+	if (btf_is_enum(t)) {
+		const struct btf_enum *e = btf_enum(t);
+
+		*res = e->val;
+	} else {
+		const struct btf_enum64 *e = btf_enum64(t);
+
+		*res = btf_enum64_value(e);
+	}
+	return true;
+}
+
 static int pathname_concat(char *buf, size_t buf_sz, const char *path, const char *name)
 {
 	int len;
@@ -2476,10 +2509,15 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 			map_def->pinning = val;
 			map_def->parts |= MAP_DEF_PINNING;
 		} else if (strcmp(name, "map_extra") == 0) {
-			__u32 map_extra;
+			__u64 map_extra;
 
-			if (!get_map_field_int(map_name, btf, m, &map_extra))
-				return -EINVAL;
+			if (!get_map_field_long(map_name, btf, m, &map_extra)) {
+				__u32 map_extra_u32;
+
+				if (!get_map_field_int(map_name, btf, m, &map_extra_u32))
+					return -EINVAL;
+				map_extra = map_extra_u32;
+			}
 			map_def->map_extra = map_extra;
 			map_def->parts |= MAP_DEF_MAP_EXTRA;
 		} else {
-- 
2.34.1


