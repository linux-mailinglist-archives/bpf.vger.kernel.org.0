Return-Path: <bpf+bounces-76260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC491CAC2A4
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 07:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 766553020175
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 06:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263A73128D5;
	Mon,  8 Dec 2025 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj7VFaED"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A9731283D
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175051; cv=none; b=LX++9c01wdCipJdP9RuwuJEi2hgyeoAgycpWC/RzbT/JmxVLHeisVj0DMxL4mnPx1mVBS4pEYqcEi7kJGhCw556m2E3Wfw9Jw94hh/a331gpgNJWRshIlXTaDpwQHVvvvTxB/J6ggicnADMLMUvUENeBPe19+qaAZubkHg62NxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175051; c=relaxed/simple;
	bh=3rLB0CW9qfHiGp6ErABQKSZNXCfm5echOS1kCj5vYuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPQiBIsFpfotiJSeCTNKyeslu9RFHhxUBqMblNBr/roSb98WJl73hILW7T+DUB6NCyNTrWph5gMEr2F3slkqG0VCj5uiNjN+98xAy7vaak+1uqMVSAkbF9tPrwK4vCrAFpk1kBgKYAZ4UWE5YmKexCD8UBcC2ZFR7RTIiLz+sxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj7VFaED; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3436a97f092so5183925a91.3
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175049; x=1765779849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY1TWHNFPcsVIc12Ea6xmmHpfxEDNasl0yTuoxu3Vmk=;
        b=fj7VFaEDprC/BgNDn2oPTo+YhqQNO3X60sVic1QNd//WmYPx/Dna4sSwphu6QaeQiJ
         KdK/fS63i4IeCrTusVXkFt+4ZVTaCOTGlseGu99rJjAVVwPWQLnJI/LsCj8VgIXH7Idd
         bE/5lJbwErc8t3NcsAaORlbVIzgo1cJG62P16hgTHfgjr/G4GeE3/4pGQ5d/g6A8ZFP0
         10ibizOq1nBBFyiLF+e+k+FCx+PRV/+BdBc/qhgTXNEsNMSgdbCzN6UfWRiT8nTL3sus
         eqiZRBtpr88tYr8TMUwT8co65FlcbR3GjnvwC82Qv3YHwbTbGeIkC6kJmMX47LuAKk/r
         12Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175049; x=1765779849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EY1TWHNFPcsVIc12Ea6xmmHpfxEDNasl0yTuoxu3Vmk=;
        b=nOXDMqOXKs50Rgs7ALpuP2mabcBgSUiRqcRONG6R1xS/N8ra6K0jHiTJYlaZXm5Rk5
         Z6qIFaRZaUesd/QkYzmWbdwHAwgowCLjZkz6nI/RwV5X3OkoMyUX1Irot301r4xd/EZ9
         Zv0B+A9ieZZqyMurxcS1iZoQF5sZ0mxN/0Kx+t0rBzxGtHRrxMnbwYueAAL2DCMV2Oiw
         XfhUWqwMe5zoR+HdpHZi1WB9LQnZrRwyl+4nqQD9ab2O3xsq3JMPbVEL0QdSdZEclrGn
         o8/zgqJXCHAlieUOVxSt8YrA4sTSbXlvFjT32Tp2l6uHfrKADfDp6IwB2c8fpC02zU0A
         1MlA==
X-Forwarded-Encrypted: i=1; AJvYcCVHaaY5gbPckJ4niNpDeSaEkDceMtYmNSO2XxyO3KApqJcYKweHfEkiYfx5oTAjPjUL4IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50ONVp/Muu7w9eDT8Omoz42QAWe5iY6GkNJ0JInwJpmL+Hlrn
	vewwSzr1yuk28oLuWOd3/uHNPVLR3XKNeDTlEYJSDHnZITn6VwZWJ6VS
X-Gm-Gg: ASbGncuRkOTpIXMKFRmNXqGcFwAWTAvpEJztOcitDzHVbkdKbJvfyrJ3IxB0GJnh4Kp
	x9bI+e3hQYcTOtFEuwEDnTttUh8d8vjSZQcdyLCbx3lhZfAd4u/7mcHEx6dN+44RDhAWwZFD5WW
	j9L1ycMn3DtL5dpdN3unaP1TfuI81K1QP0GXRARzyq4xX4h9gyY/qXfK2/M6yCiG07VP7M1KEHn
	AtBwUjzqu0SZhqdOxdsGQ0hhVMArdGMadsiGdxg1hMcS74GghyDtRJsCALX1AmZs9cwGQNX1nUI
	+iXEhC8/1nEZ3ryYbuki6M0y8pmT2k+IMMtL/25qQZsjEuJiiMVU+e1TNs7cB7iJiVjx2RLaL5t
	rSZ5ugquIgf8kxqxCDYMBtUd63yxCxU8qxzozz1DKvtzMXOZTM67gKlXg1rjLj+P0L8pJS8Nuaq
	0vvcccJJt00NLM0nQxId/Rv171Dcg=
X-Google-Smtp-Source: AGHT+IF9+KuXLJhhdEAvE3hYuv26uDkEHScuCmf/MnF4W8DJO/REbJbcGF8slRlk9j+3UTPcjBmJhw==
X-Received: by 2002:a17:90b:5144:b0:340:d81d:7874 with SMTP id 98e67ed59e1d1-349a262ddaemr5369756a91.26.1765175049325;
        Sun, 07 Dec 2025 22:24:09 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:08 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v9 03/10] tools/resolve_btfids: Support BTF sorting feature
Date: Mon,  8 Dec 2025 14:23:46 +0800
Message-Id: <20251208062353.1702672-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208062353.1702672-1-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This introduces a new BTF sorting phase that specifically sorts
BTF types by name in ascending order, so that the binary search
can be used to look up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/bpf/resolve_btfids/main.c | 68 +++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index e0e792017e77..b4ec3b556518 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -846,6 +846,71 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
 	return 0;
 }
 
+/*
+ * Sort types by name in ascending order resulting in all
+ * anonymous types being placed before named types.
+ */
+static int cmp_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	const struct btf_type *ta = btf__type_by_id(btf, *(__u32 *)a);
+	const struct btf_type *tb = btf__type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+static int sort_btf_by_name(struct btf *btf)
+{
+	__u32 *permute_ids = NULL, *id_map = NULL;
+	int nr_types, i, err = 0;
+	__u32 start_id = 1, id;
+
+	if (btf__base_btf(btf))
+		start_id = btf__type_cnt(btf__base_btf(btf));
+	nr_types = btf__type_cnt(btf) - start_id;
+	if (nr_types < 2)
+		goto out;
+
+	permute_ids = calloc(nr_types, sizeof(*permute_ids));
+	if (!permute_ids) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	id_map = calloc(nr_types, sizeof(*id_map));
+	if (!id_map) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0, id = start_id; i < nr_types; i++, id++)
+		permute_ids[i] = id;
+
+	qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_names, btf);
+
+	for (i = 0; i < nr_types; i++) {
+		id = permute_ids[i] - start_id;
+		id_map[id] = i + start_id;
+	}
+
+	err = btf__permute(btf, id_map, nr_types, NULL);
+	if (err)
+		pr_err("FAILED: btf permute: %s\n", strerror(-err));
+
+out:
+	free(permute_ids);
+	free(id_map);
+	return err;
+}
+
+static int btf2btf(struct object *obj)
+{
+	return sort_btf_by_name(obj->btf);
+}
+
 static inline int make_out_path(char *buf, const char *in_path, const char *suffix)
 {
 	int len = snprintf(buf, PATH_MAX, "%s%s", in_path, suffix);
@@ -904,6 +969,9 @@ int main(int argc, const char **argv)
 	if (load_btf(&obj))
 		goto out;
 
+	if (btf2btf(&obj))
+		goto out;
+
 	if (elf_collect(&obj))
 		goto out;
 
-- 
2.34.1


