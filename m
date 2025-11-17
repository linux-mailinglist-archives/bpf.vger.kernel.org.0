Return-Path: <bpf+bounces-74740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB8C645BB
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D8114E8795
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE0335567;
	Mon, 17 Nov 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHsqQuDl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5DE335064
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386012; cv=none; b=aC70YhuNF93OXWM3BNRHz5bvbSjyi/jJe3hrsCZfmoJ6mMSmYTXws9kT0DTQopbet1psBNkTBxcuon1Zhhp2kduCl7KDSnd0buUp6RIcKDaT+2SULE+POAG8i+DX/IklSlduYGIUNvMvUbRa7hboRMZ7OCnoQk+T+eQyTTDgFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386012; c=relaxed/simple;
	bh=1JCm2gAw7szR6coFfKCMu4oP2N4ZVTGa8uyyO11FaJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIHlAtXfPoYxo4m7XHdYlHxyTrh2fLa0mCOvw/Ps/FRChWMWAXuiIpBz6jb4aMm/aC0dT3ZvQpNtXUGRG0CHv2lNQrFSPH9X6lzjOiKDjPl2GJpIoCSe/0OTAFSNDKrfif6XUmAeS2uXu/CUxuPxPju1+kX1VDihk+XAtuD8qkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHsqQuDl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aad4823079so3841937b3a.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 05:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763386010; x=1763990810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rljz3QHqavQzM2+LGEfUj2V9NIFH9chI7oYU2DEYmt8=;
        b=PHsqQuDlNwAY1elomuaDEy31MbeeCCU1SuzOYsSJQJffwr+CpisCQCp7+g2XWq+UZH
         laLnj9Rr0BZ0pkt2XUJHJfeAr1ewJyqdpGwydJx4SbEH9FPB2Y0YOrxUG3V4hYQg133o
         iAaqLwuDwJESm3nvzWg8UdvYarnBxN6JTxW4t1Qs/OodcnVwF386H67tWnKnBGfsLqOo
         AMrjsLpKqc6Dz78yx5a36y1/gqbzvtL4uidDTsvGUHP4/27fF7vOnCkihQzNIzb3P3T6
         t2sVKR83Dy+dtB0NyjU0YeU4lFjrEk7jTQf6ipF87S1WBglEOsksz+F7CjHtifQUiGhT
         eKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386010; x=1763990810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rljz3QHqavQzM2+LGEfUj2V9NIFH9chI7oYU2DEYmt8=;
        b=BwDjzigIs0GBM8V1ml8OVQABv6T9/OkmEHeRA5GK67zo64k4gNXyuaqAc4hUL+OqvJ
         6nJO3zIA1ehtCik0FnEb1ZWbLY8rWe2Gl9JapFT4gVHQOlZqeIW87yJVrwnKyHEhAsXb
         OUdRzyLT8a2x8Vl+7mDV4kYP5haASDn1irYJaaRUVW4lHOKiBowtsqayzwrjKSF5a2jH
         iHnddYQCy3jQnnqTfIbIdeFpdHRnWP04bAkSoLeM0s75YCWYchm5bMfhGqxfWLy66F0o
         zYe+sXlazDdFMHx892gwKGTBAZE6WCxWOPAml8hPEb4WCMQmxF46otveCrfizZec6ZkV
         bPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnDLqxXyHYT0vrR8mI+cLIVyDrcp+ZwuPHsspkoslbveqBHJL61gOPvOEKGtDeXRUEUL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXK4yp/XkdfnU65CSPv2WNDXnX7Igs1BdFD6bAIALuSRcBP/e
	5XpgBF3HieD+WwHV0SLe4+CKktnYsrIeViSiL8BgeRSiBqEGA6Aix+2c
X-Gm-Gg: ASbGncudhoeLUUOfRG/DPGbic1XY3ezTzlLYRkwtp0YPI7wcWYxnJ9WzacUkBfWPfjV
	PdHCD8B2eeSXdXASNi94G9ms26rUfaGxb785LcacfEma+LUX28X9GZA0x/8yTA6Vwz9LkugP6ai
	Y63JccJRkd05Uu4tn2nt7mIZd51Dhh3UwplROtluDbbL42r9cDAaP/hzkj1G2PYa5ZajDfirfpA
	wzZaWT3AcdThccOjQSvuYcds0+1zuqpjYLuct7Jc6vDhPPFKe1wqOHBfInIKEkah6d2hPVk4JNy
	R38RlWFU5ViUHYCZNRh/iH57j3Yt33Lv4Aev3CCf40pUtj+fVUQKcfZUPsn2bY8dlgaPQDXyKEl
	2mJDTA9j0WjgG5aRHro0TVYr38O5EepgkGUVmMCDT4YyMhdREQowTye+N9z3mEBn4KeALE/5s1/
	9twZ0McfN2ywxq3+EF05CQJqMAbdUjz58GIFvstg==
X-Google-Smtp-Source: AGHT+IGP4GB/9/Y0zdSNgB4qCkHmeHyFO+LhNquHKW9wAN7N3l8vdfqdun9eXlCf+F53CHCFa5G+Xw==
X-Received: by 2002:a05:6a20:6a05:b0:344:bf35:2bfa with SMTP id adf61e73a8af0-35ba22a50b8mr13339782637.33.1763386010418;
        Mon, 17 Nov 2025 05:26:50 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924cd89bcsm13220953b3a.15.2025.11.17.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:26:49 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v6 6/7] btf: Optimize type lookup with binary search
Date: Mon, 17 Nov 2025 21:26:22 +0800
Message-Id: <20251117132623.3807094-7-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117132623.3807094-1-dolinux.peng@gmail.com>
References: <20251117132623.3807094-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Improve btf_find_by_name_kind() performance by adding binary search
support for sorted types. Falls back to linear search for compatibility.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/bpf/btf.c | 83 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..5dd2c40d4874 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -259,6 +259,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 nr_sorted_types; /* exclude VOID for base BTF */
 	u32 types_size;
 	u32 data_size;
 	refcount_t refcnt;
@@ -494,6 +495,11 @@ static bool btf_type_is_modifier(const struct btf_type *t)
 	return false;
 }
 
+static int btf_start_id(const struct btf *btf)
+{
+	return btf->start_id + (btf->base_btf ? 0 : 1);
+}
+
 bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void;
@@ -544,24 +550,78 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+static s32 btf_find_by_name_kind_bsearch(const struct btf *btf, const char *name,
+						s32 start_id, s32 end_id)
+{
+	const struct btf_type *t;
+	const char *tname;
+	s32 l, r, m;
+
+	l = start_id;
+	r = end_id;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf_name_by_offset(btf, t->name_off);
+		if (strcmp(tname, name) >= 0) {
+			if (l == r)
+				return r;
+			r = m;
+		} else {
+			l = m + 1;
+		}
+	}
+
+	return btf_nr_types(btf);
+}
+
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
+	const struct btf *base_btf = btf_base_btf(btf);
 	const struct btf_type *t;
 	const char *tname;
-	u32 i, total;
+	int err = -ENOENT;
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	if (base_btf) {
+		err = btf_find_by_name_kind(base_btf, name, kind);
+		if (err > 0)
+			goto out;
+	}
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
+	if (btf->nr_sorted_types > 0) {
+		/* binary search */
+		s32 start_id, end_id;
+		u32 idx;
+
+		start_id = btf_start_id(btf);
+		end_id = start_id + btf->nr_sorted_types - 1;
+		idx = btf_find_by_name_kind_bsearch(btf, name, start_id, end_id);
+		for (; idx <= end_id; idx++) {
+			t = btf_type_by_id(btf, idx);
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(tname, name))
+				goto out;
+			if (BTF_INFO_KIND(t->info) == kind)
+				return idx;
+		}
+	} else {
+		/* linear search */
+		u32 i, total;
+
+		total = btf_nr_types(btf);
+		for (i = btf_start_id(btf); i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (BTF_INFO_KIND(t->info) != kind)
+				continue;
+
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (!strcmp(tname, name))
+				return i;
+		}
 	}
 
-	return -ENOENT;
+out:
+	return err;
 }
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
@@ -5791,6 +5851,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout;
 	}
 	env->btf = btf;
+	btf->nr_sorted_types = 0;
 
 	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
@@ -6210,6 +6271,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data = data;
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
@@ -6327,6 +6389,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_id = base_btf->nr_types;
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-- 
2.34.1


