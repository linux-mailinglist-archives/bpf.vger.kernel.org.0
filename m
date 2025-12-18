Return-Path: <bpf+bounces-76981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A40CCBA04
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57D1A305042A
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AAE319873;
	Thu, 18 Dec 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em2YnYJ8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6D31D379
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057515; cv=none; b=DSfMIArhCQrCUFUalKCk/DeMzYSeXQ6oQKIfDU2bfoZ4wpOReTsXxbMlTIEcGoTNOQQKMzOLkTxtsDmfVBoSTtjSp9/o9kpCMWYl2Wa3LkT9VyKd/AmJVEtv8389+uII2OxUgSg0FEabBRE2dNo82QUNbPnAmUss/dQCeKRJ+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057515; c=relaxed/simple;
	bh=J4/QGROYYa7Djiw/eaQ3GNdqZT48kiErWfvGDV8/Tys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N66QoAuRwyHvgxbjqNzpGKu9SkWGgPmrYjY3TKMV/gAmwoPziQDqN59kQ2dy7dglbInS5CXdI84gkP/6TDxX/Jw5MB3n3G7hGGWnoCCrpJEO2knw0RFrm6ay8Z4NAk4O4VY9lA0dl5n222hvM/ZEcj/AVHt7Uddm0ZBtevYihkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em2YnYJ8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f102b013fso6851965ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057513; x=1766662313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRe1/jA95O9SPOHNbjC7U56aVV5DEJyjPqrggmgz7zU=;
        b=em2YnYJ8V3pZmmGPkkl4NzltyZJll8nv55OtLzfW1m/jKEAnr1p46GfnmvJsXOiQG7
         GGUSsHTGGq3uL8lDLUAmtHmiZUsQNYGKp0ljKyJpKrvUb0BdV3IcvM/IonAodzAey39h
         YEiArb2tTDWu0VIgKLaN4QC4WlgY7tcn9yz15b/AEQvuWt7kNSF3Z76CSedsZWRKGopt
         sKPtYXJQUU3KE3B/Yn8+uSf1X0xEscjR0+tTNSykFiARlgyT/bM5iz6K23z9yM7azCYB
         EUrePjjsRF1UG7QeLItalvSNScqpZ6uPjAJvgP/lzxm48L33jYFesqpnxZsGDpulAngR
         5i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057513; x=1766662313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pRe1/jA95O9SPOHNbjC7U56aVV5DEJyjPqrggmgz7zU=;
        b=uGNDwpGjzOeiSzuDeaEPc1n5pV2edVxl9lZacPvfKVEWwSp1T4uu4zik8I+Zhh3OPj
         ydlS/bwU1qHxdkqhIIGDYWVI84FB2hA8lT1u1NRbtggetHVk9ac2Lk+YChNg4mXS05kl
         3KDQ9UeDohjyFxZO3pnu62GGDN+CuFpM54EOMu9vDJtWuWy2F/G5S7DDQZpCJ32uYx/+
         Un+anOEA0xkXzm0moe+SHyEtRy+1c/21aW3X7NqPMOy08hqcML2VLcflHG36Pj+e958k
         /53br64gdx226bLzu5pRaW+MBeArONaVTsS+NtS+lfDqUTcJt/gdZuY+eN+CLqxsQKJg
         xfqA==
X-Forwarded-Encrypted: i=1; AJvYcCVP21ExHFAj21gv0gmYU+jZ96wInAR1Nr+vtAp1amKbyORXjhog129Y7nzJRy8XYAUSdek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49jJ/5ukE0ExCuJjraeqVD5uaqxa39/Fo4JqYeJ0AA7xJ34+m
	MDUrW8cj+HEufJMyIXJMXtHTgLK4TfmV3/iH+JGvermy/5All8blXN0B
X-Gm-Gg: AY/fxX5fuE2Tu02m56T4W/i1tnub2narhd+2Lppy4XWWPd3pT0J23Pv/+PYzUmjv9Y3
	nUHwrJUg0akpr8almkbNH6vgSmxwYF3iadhXukT+bvoHr1SvCohc3cfymQ1RRVfPMhTVHVGHxMw
	ujM5Fs1ov74VBpH2RWTvIV7Iyw4kxni5M1XQlSosFytsFY/msVB8ZfmoYuHvWwAl/on9uvtWozy
	heuumXqbhXIlN6pZoyDkqBwRKowNv7MNMCmTyte3FtzADC+JY4fhhkIc8rNqGJWPOKhG/xLlAs0
	5BJTMUC+WogUOFF3HDTxTj7ZOeTC/sknpT0uIWSUMiwy6vdLKF5dPWlWHjJSWuj00z1JqtpJIQN
	vY1c93lzs4DWYJFryvL0BhoX0U6CzbCyKpHXoaLikj1w9q4ZIUTkDP/aJPQNsBJUkMbgWppVMdA
	MF5AbGqWKblCHf+E6JOW5NXNmGMlQ=
X-Google-Smtp-Source: AGHT+IGkvlwioTi7DAg22F7nuqKXStAbmWJyhw8eWuCQ/KK9iLrazpre9epMzNPRQ+MW4qWMbDul4g==
X-Received: by 2002:a17:902:dac2:b0:2a0:be59:10cc with SMTP id d9443c01a7336-2a0be5919e2mr145918815ad.32.1766057512655;
        Thu, 18 Dec 2025 03:31:52 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:50 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v10 11/13] libbpf: Add btf_is_sorted and btf_sorted_start_id helpers to refactor the code
Date: Thu, 18 Dec 2025 19:30:49 +0800
Message-Id: <20251218113051.455293-12-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218113051.455293-1-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Introduce two new helper functions to clarify the code and no
functional changes are introduced.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c             | 14 ++++++++++++--
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b5b0898d033d..571b72bd90b5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -626,6 +626,16 @@ const struct btf *btf__base_btf(const struct btf *btf)
 	return btf->base_btf;
 }
 
+int btf_sorted_start_id(const struct btf *btf)
+{
+	return btf->sorted_start_id;
+}
+
+bool btf_is_sorted(const struct btf *btf)
+{
+	return btf->sorted_start_id > 0;
+}
+
 /* internal helper returning non-const pointer to a type */
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
 {
@@ -976,11 +986,11 @@ static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 	if (kind == BTF_KIND_UNKN || strcmp(type_name, "void") == 0)
 		return 0;
 
-	if (btf->sorted_start_id > 0 && type_name[0]) {
+	if (btf_is_sorted(btf) && type_name[0]) {
 		__s32 end_id = btf__type_cnt(btf) - 1;
 
 		/* skip anonymous types */
-		start_id = max(start_id, btf->sorted_start_id);
+		start_id = max(start_id, btf_sorted_start_id(btf));
 		idx = btf_find_by_name_bsearch(btf, type_name, start_id, end_id);
 		if (unlikely(idx < 0))
 			return libbpf_err(-ENOENT);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..95e6848396b4 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -250,6 +250,8 @@ const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, _
 const struct btf_header *btf_header(const struct btf *btf);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map);
+int btf_sorted_start_id(const struct btf *btf);
+bool btf_is_sorted(const struct btf *btf);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.34.1


