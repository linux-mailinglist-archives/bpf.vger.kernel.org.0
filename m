Return-Path: <bpf+bounces-75553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF6C88C0A
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34AD53462DD
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F131E11C;
	Wed, 26 Nov 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6KvvDyn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53EC31DDB8
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147044; cv=none; b=Ik2mRBRJ3SgWnfI5wGrqeMepMXZASVop03e7qT5tCAQnxsvQr9guvun8zYIHTaZ8Pm3XyY8gD8xlZqTTCbRt/9PWnAgpFSEUyTNsonYtDfnioBX9wfNkq7j3sYvdcA1yzbrew93cAgq1BgOPlpPgw68jS+6E1RppVAqvpsVblJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147044; c=relaxed/simple;
	bh=M/VgPIqfRWvPIYxFG70p0tBc3APY/ResOI4iwLeo1GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mk+Pf26pTXuXRcvZQdpvVLBa8gocWRVyFNjh578EtkwHCwjMXDK8hHZNzcSzFl4B7IWNTC5vA5W57KvhDn3zXT1PGv2cZYQGNXhGX0Eg6xoGVDV05QDTb5UuMPcyv2x5XPXSDBEjL/VXMR5a30SrO7U95mKLfld9S4JGH8gI1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6KvvDyn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2981f9ce15cso77935805ad.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147042; x=1764751842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIDDUYkGHJz7WnHdi/CS+AAzIaF6rwKCgn01mtFAMbA=;
        b=Q6KvvDynZ3Ig/iK9bEbb3g8Nd4jO+eedRGYggeG6oHDbnnUDMqFBZOlpaZkctxJKKx
         1Ybnw9TH5LBZEnBcd1zyGwJl1180DM+IhqEmiIGDvALgzefYRcWOV7kBjkeZJoU0Ztm9
         AYFBgD2AZVnCZfPQl3zKqOYXfGxyNaMKiDwGJC2A+MEOfqimMTyjI6Dt4sJNdaenzF99
         Jx2feDmgVrNVRq2PKXtbVV383p2a+atdS8xWKTQmzSznOPju/JgPQIn9jjz5cUW1Oqnp
         NxTPateei+EOEZ5X+CRAM6jtWXnvhDRQ6+ZjLOy+MWBgiFvGw9f3UC2M09zCyR7eZ212
         hI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147042; x=1764751842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIDDUYkGHJz7WnHdi/CS+AAzIaF6rwKCgn01mtFAMbA=;
        b=vng3MRcHzwwa4SNZxmCuHO//IrX8bCY1exqUW7qXLgph9GSz6kzc5ex6jbrT+vVS9o
         Jsk/UkVDqPgLNO6xOR++v3/MM0DNX/Tw9lRoKVCrkyIRr39iNmzUaEIZmdr8dhaXfM09
         Qoa5H0Xs0h0bCuVIITJrqYStucxpUuL5JEeRX4gsR9tbPdAbSCOu8Q5Ijuj692SISocn
         L6hTxqR+qpVcBn6FsiarVfpiMJC4Sh1OkJf8E/a0I6Zyw0AQVfJXexDd4AlHwnBYYRxO
         MfzFYdxra9xeU/Sf/nmcEjQAVs0s0rgRU3yTHhPzv73lTuIGrhXCGDTf7pBLLuP1B4NC
         ffJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe5L85SC7njBuko/foBx7qXB35biqh1Dv0yirR11MU65bZ3SWMqwqIlxr/EpQ+R79sEfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUeIEO6/xvSl7+2R65MiUj7jjc0FvcnywcIPnlqaOdXHmuR+x
	erUJa19Y3BpJWQBb/yhgoPgY9y51a1PcSU5hInwHf2fNAa2ZmIrFIVOl
X-Gm-Gg: ASbGncteD4XchOvDdQmzSJjxW/B+Zu8/tOdJ0PR/FaLwjshFemQySr0XmNNH/lh7GI3
	TLMnTl4S40F9tpNeHuBlkBjxjeKRbJSnqQCgYFUZ36MVa/MBVrVch+WtRTYr+KNcN0jDykdmgBJ
	O0jlzQK42dYS4xg5/Rhdt2IrJ/06m8EkDM32Qhh4N1wFU4Zg2HIFGv3gEF8f4DGW+PWoDWO0bDo
	zU2R5jAQwNMRW4NBKpD/wubVYLNMCkIBT0X0FroH6+5cut5N6Bqor811tP4lGO46J39CFQC94ch
	k+ZyP2WOCbWgKA5lEOKB/Y08/qOzs5SmEYA+cWhb6p9Aq3mU1HjgRe9oJDPDrfJaATZLMSNb63h
	7F+RmG1YkD9TG9OevR46/BMDszabZiTqWcyaohTg51x6Y+IJ18L1CNE0XEqCLu1nL+bkqcVQrEx
	Uf22cLJKNPcJkIRD0J8jpXtbWXBqI=
X-Google-Smtp-Source: AGHT+IHvlil1iO59w6L02UVKaswg4buo1LY0f0OcMcJNxORcAcKjg5GLGp3oWtBsyoFormU2mRxlpw==
X-Received: by 2002:a17:903:11cd:b0:298:68e:4057 with SMTP id d9443c01a7336-29b6bfadca0mr207376675ad.59.1764147042164;
        Wed, 26 Nov 2025 00:50:42 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:41 -0800 (PST)
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
Subject: [RFC bpf-next v8 3/9] tools/resolve_btfids: Support BTF sorting feature
Date: Wed, 26 Nov 2025 16:50:19 +0800
Message-Id: <20251126085025.784288-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126085025.784288-1-dolinux.peng@gmail.com>
References: <20251126085025.784288-1-dolinux.peng@gmail.com>
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
index 4faf16b1ba6b..1d2b08bbd8c2 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -857,6 +857,71 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
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
 static const char * const resolve_btfids_usage[] = {
 	"resolve_btfids [<options>] <ELF object>",
 	NULL
@@ -900,6 +965,9 @@ int main(int argc, const char **argv)
 	if (load_btf(&obj))
 		goto out;
 
+	if (btf2btf(&obj))
+		goto out;
+
 	if (elf_collect(&obj))
 		goto out;
 
-- 
2.34.1


