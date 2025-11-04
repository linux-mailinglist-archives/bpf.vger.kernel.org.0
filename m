Return-Path: <bpf+bounces-73433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65369C31454
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0390D46235C
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0662F9D82;
	Tue,  4 Nov 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr/EG+Zl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88720328B6F
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263646; cv=none; b=WKkXQV6mjvnjmkYJUNSSlPLchVWaD+r4WrbA8F6ZqUBZ+459OvUFCL7BpPvXxuBjxzoINNSYT3sdyMN0PIN4z9ab8r+YZaHXTfCAVvJvkztFS7d2DJXUu+nqrwWg0p4fBiRK/ws0cN5g4gpjJ3HF4CaH+uvxtYabcyFk/mTkQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263646; c=relaxed/simple;
	bh=yaIxRRwhlcK1m3sPDUbZoQhLf3iKQm28n69U+/RZ+kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJ9DC4okc0zUJ4m6h9thR3EWFSN9ZrSeaIxCaLhFWa1J9WkZ4RDiP0bZiKiHxUpOQOvO+UNu2n+ZDvPFm+gFGHAklq2I6P+QJx5GyeuQkwWFZHiJVQTg9xS8HlHwBPK6eTLr0xlR1eBXwUMEtB2KyjBKl3KkyhhxxPpEdBHEUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr/EG+Zl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b593def09e3so4003896a12.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 05:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263644; x=1762868444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiW5mEEe27+Ap+irziIB4Nicw97Y/mZ8O72ZFc+O86E=;
        b=Tr/EG+Zlv10adgqOAUkicKEI7pFlTxOT1DUSBSuPOkCpdowrnFW1w9lSJ4R4TQUwpO
         VO2y6P2lSbNv21CVXHcUZdUBU1N/2GvhAz1zWqCN7Ey0kXcrNxf6npkuzml1tAh+G7CI
         EDoigCh9SX20jOKtCiIQqZq+8Gap2KMcWy7VUFxBZtd/xGMQKZhcgmkyuri79mFcnKxK
         NqWWHNWvbnL11oNLT9xjl7Ct+8NXkyA32XOo6ipoMSn8dlDXyAr1E9rvNwKkjObo3m3O
         oZCcbIotMGwpDsbCDOUIX3ZT+2ke51Gcn57pH807Om+zjG/P9qyd/n/lp77W8cDVvVR9
         u/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263644; x=1762868444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiW5mEEe27+Ap+irziIB4Nicw97Y/mZ8O72ZFc+O86E=;
        b=ZF5Gdg/9loYeqC//4ovEwjfB9GZmCFT+UdTLC+prTLBneKCJMVcWC+DIVHuAYpMIKW
         J619KnkS9b/84x31tDXNw6IemgvixYiYXOO2uwrNHvvoV/eW5Cd0purPTZAT8TNrOLPA
         I2mQC9oli/kXr+pNtc6vC6o4eUO/LOt5kCTAQLKfCAwwaXb68OmZ/uzoMoP03BKXNrI4
         JONn1B8fB6eBa+UnCwJO9MDdoTjUy8+NbnVb9Ay5F/MAPSn908maboB6+Y1r8iPOOtVZ
         qmem0ltaD2612NvxGh9ZiUOAoBu8Ey9PeY39efHe+rrPDnlX0hCjOpiKiKm/Q/InSP+t
         wP/g==
X-Forwarded-Encrypted: i=1; AJvYcCW9FiaryZltfcDeSN5yY84dJHmmI1zUHXIWEIZNISodDlYy235ALUxPUtkRbnDejUhGU6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNw+bpS/tUeeEhzQI45o4ziwoLal+Nf0CGsYChbfhAmNJoLE++
	tqJ9ebauuiwpFrocjgtJq4VibKhTS7G2D+P1g6jhv4t4nRrrkGg5gllt
X-Gm-Gg: ASbGncvPxDOdV6VbTdSgh2Xahz6SBr/qJYo9oGxnjQl8sJV3CIIXuq1DsMV9O6jPypl
	yJQxIrLUFvvU1eGCPmRnDm67YAjrlSrU6wkBXiZIRft9M+tb3SdfgrSMkJ11wLpbOn6/2hhDMY4
	y70G94g2ALvdTR16LD6/Ya3qcSOvfCtlrTHs4bc5rkktqQiWVuqejPrAiMo1dx8olyckidEJOaR
	KL38iFNep7v99Eht5IrIykoQc+xHEzw9WoMdmORLbunAADLvUjdOnwPVN/N/jUPfNjNRrDXZybI
	5Xj3ZLSVVKXuSLT1M+uJSpcPBmL2o6cnyFyLGSIRdkZ7V/3Kwz2AWhL9lFwxS+51MYuP/aCKADO
	2ivEY6dX1igaXrrJW3H6gwrb9OeS/B8ystQNP7n/Yt3T8d461EtDauPf6TC45E7dZgsk4ZBtVP0
	JOFD1wDmaVLDahzw0j
X-Google-Smtp-Source: AGHT+IGFdsk6TRqmdcrIGyaQa/1gESxA3BTC2WNMvzu/zlLVjYft6vWWfxs6+1Hput4xBW+Irt6MuA==
X-Received: by 2002:a05:6a20:7344:b0:311:99:7524 with SMTP id adf61e73a8af0-348ca351af3mr21520348637.18.1762263643767;
        Tue, 04 Nov 2025 05:40:43 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:40:42 -0800 (PST)
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
Subject: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic into helper function
Date: Tue,  4 Nov 2025 21:40:27 +0800
Message-Id: <20251104134033.344807-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104134033.344807-1-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Refactor btf_dedup_remap_types() by extracting its core logic into a new
btf_remap_types() helper function. This eliminates code duplication
and improves modularity while maintaining the same functionality.

The new function encapsulates iteration over BTF types and BTF ext
sections, accepting a callback for flexible type ID remapping. This
makes the type remapping logic more maintainable and reusable.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c             | 63 +++++++++++++++++----------------
 tools/lib/bpf/libbpf_internal.h |  1 +
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..5e1c09b5dce8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3400,6 +3400,37 @@ int btf_ext__set_endianness(struct btf_ext *btf_ext, enum btf_endianness endian)
 	return 0;
 }
 
+static int btf_remap_types(struct btf *btf, struct btf_ext *btf_ext,
+			   btf_remap_type_fn visit, void *ctx)
+{
+	int i, r;
+
+	for (i = 0; i < btf->nr_types; i++) {
+		struct btf_type *t = btf_type_by_id(btf, btf->start_id + i);
+		struct btf_field_iter it;
+		__u32 *type_id;
+
+		r = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
+		if (r)
+			return r;
+
+		while ((type_id = btf_field_iter_next(&it))) {
+			r = visit(type_id, ctx);
+			if (r)
+				return r;
+		}
+	}
+
+	if (!btf_ext)
+		return 0;
+
+	r = btf_ext_visit_type_ids(btf_ext, visit, ctx);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 struct btf_dedup;
 
 static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_opts *opts);
@@ -5320,37 +5351,7 @@ static int btf_dedup_remap_type_id(__u32 *type_id, void *ctx)
  */
 static int btf_dedup_remap_types(struct btf_dedup *d)
 {
-	int i, r;
-
-	for (i = 0; i < d->btf->nr_types; i++) {
-		struct btf_type *t = btf_type_by_id(d->btf, d->btf->start_id + i);
-		struct btf_field_iter it;
-		__u32 *type_id;
-
-		r = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
-		if (r)
-			return r;
-
-		while ((type_id = btf_field_iter_next(&it))) {
-			__u32 resolved_id, new_id;
-
-			resolved_id = resolve_type_id(d, *type_id);
-			new_id = d->hypot_map[resolved_id];
-			if (new_id > BTF_MAX_NR_TYPES)
-				return -EINVAL;
-
-			*type_id = new_id;
-		}
-	}
-
-	if (!d->btf_ext)
-		return 0;
-
-	r = btf_ext_visit_type_ids(d->btf_ext, btf_dedup_remap_type_id, d);
-	if (r)
-		return r;
-
-	return 0;
+	return btf_remap_types(d->btf, d->btf_ext, btf_dedup_remap_type_id, d);
 }
 
 /*
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 35b2527bedec..b09d6163f5c3 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -582,6 +582,7 @@ int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void
 int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void *ctx);
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind);
+typedef int (*btf_remap_type_fn)(__u32 *type_id, void *ctx);
 
 /* handle direct returned errors */
 static inline int libbpf_err(int ret)
-- 
2.34.1


