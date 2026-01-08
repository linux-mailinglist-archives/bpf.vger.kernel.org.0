Return-Path: <bpf+bounces-78199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48601D00D8F
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CFDF3052F6F
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A629AB07;
	Thu,  8 Jan 2026 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8z7S2Qu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B4A299A87
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842237; cv=none; b=QzSq/+9kLXJ6DvXy55vQdduf93+n0WDKsGsUz+1YlI7yUMjxTOIWPQ9vV/UxwPrn6H1Kz7wq/6qQh4/3ePbFDiIBdZoA1r2Zqj9+z85QxwA9T+lMMkP5UGdDqnRpi/Y7FffasMgUWeFSEjsGRERARvpvq8RfWt9+fMzEb1hbQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842237; c=relaxed/simple;
	bh=8smopcu78QnMs/YqVehnE5QN5ynjfgqRwGz8JYBm7fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzgZudctpLPBInVRmVPNCRGk8RnE6H30GG3UWHPTGke3wXMgOglHHeZ5LazYXV14KOwEDkfc5vSL0Ck7wwxz8/GBBD1+NEbqNejj5MTIWKpT7ZqIkOzSLMG90LcyDEbftI3iucRg/vPS3ncuhCFVGJIp94w8YXL03uY1beAFhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8z7S2Qu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so1815069b3a.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842235; x=1768447035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv4kvnWYDSS1VS7MLzlNTRoM1YeZxUX9gh+m3TBBfX8=;
        b=C8z7S2QuqlKPXvUgQJuUPqHE4kx9vmqY1qW/G288hLTMmdq5Fx3OAEVd5KUMrAm3tQ
         IOIXaSStX2rxaTdE6U+GunU87xgryKMUNpGYVJZi8AMxJsmGXMIwtfCvJOeaisz1DpD5
         QuIb4W4DYSy82qwJPxgDJDZ1+imFT1SSt1wMseXzrtDVvvFygVzDBnTDdTse/LDRSgyi
         wNJGanYFjdkryWrZ1C6Ujd/efANBHdpFBjzRo4ylf39638Trz9F7ock66ZB5q5h0Bvqh
         9vGlvkxCSsVCMf5uIEJZJzisqviqFrKVqdP2GXaZPf1zSIJ7tyQidjDpyKya2h5XJGAS
         RYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842235; x=1768447035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bv4kvnWYDSS1VS7MLzlNTRoM1YeZxUX9gh+m3TBBfX8=;
        b=YD9afA/EV0QxKhA9S6Q8lKK2njvhkPxiFDvaGyw1ubKegRXbpVkNUrxRIhtMjunhVf
         sMfGSUfCZW9iNsBHv3zzDccHpUhzZg39L0HHpBYVh/05ROCHAi8ndMLRXspErAhUfp2t
         Oig95XLieq/Yi6w5ObumIl/m5ekZnXsVM7oQ68vabR7kQyLzgfw6Bk3PYTsGSrv88zjx
         w1hHmkMH0j3garg4NA/3K+Z4wsk5eAywiZ5kCPfDyEa12JirzXF1abVgwwhIMab2SCgp
         ZbCjaWJaI7jIX0xq/H4lPVNGq70+3OKG+RZ7dMBbdL4/D9LyDtMnlUYjm9X/s/oU2DY4
         gjog==
X-Forwarded-Encrypted: i=1; AJvYcCVYy6cXpkEmZb/eySSIIBQMue3Nom4AgYp38zlMjkXE5PVGwHXW34bfxplumbuQKwuRUWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1utrPvnXGr+q+EzE9zx2rESWNOJ1B+kp2FiiG3vJTjBXdxWrV
	/grNdi6wxlgsgnJHLD1426aigHkVgjpgvftrQpGZtHa5b1I+2LOP5dg5
X-Gm-Gg: AY/fxX55qmJgl+ZKcCsoGOn1PzujzkEew5CAs7PnWgy+ptdCgQOK9uWWff2Fg7Bmgxp
	CMltElbsTF6tki+gi8iJzrQMZysHK+3tEMOlf6oz8CguOHZsIYxeMdqeixUdnPAoF+fWmLud4xQ
	FnsdmmAhXzKYCT2aFBFnWw/pOMhyH7RaHWCB3/n4oPhiHtr7xiJKSRkpk8DSP57sO0BOEefga99
	KUWfLfg1AJQKMCQvCVB6+8RDA59UteGkyRyMctmJvBZkbPL1TEBb6uehTcU497m+ya78S8p7Td4
	e7DnixCCoEIizBzeL2ULQ4IimLiUiMXfs4e1Zb3rJgBDrcuN9MHXeex2RmxpvKZQh8gVpaiMdEc
	okBUerZfMRM/2eqPcAsQXbT1BBjgxnUJRaPp2OdzlZCdo1IdT+0bT4xi4klXYMDMjFiZ3afzSfa
	vBdY6vuxmZRyNJ20vBiRZ1QL9sjm4=
X-Google-Smtp-Source: AGHT+IG2kVTh4tMqTzJLgEcx1fBS0i8ONWGZ1nAHkGySVtfYuQa6+ivUGQpjGgc7PQMd59Rq0Vri8w==
X-Received: by 2002:a05:6a00:1c83:b0:7e8:4587:e8cb with SMTP id d2e1a72fcca58-81b811a0929mr4193329b3a.62.1767842235546;
        Wed, 07 Jan 2026 19:17:15 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:15 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v11 08/11] bpf: Skip anonymous types in type lookup for performance
Date: Thu,  8 Jan 2026 11:16:42 +0800
Message-Id: <20260108031645.1350069-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108031645.1350069-1-dolinux.peng@gmail.com>
References: <20260108031645.1350069-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Currently, vmlinux and kernel module BTFs are unconditionally
sorted during the build phase, with named types placed at the
end. Thus, anonymous types should be skipped when starting the
search. In my vmlinux BTF, the number of anonymous types is
61,747, which means the loop count can be reduced by 61,747.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c      | 10 ++++++----
 kernel/bpf/verifier.c |  7 +------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 12eecf59d71f..686dbe18a97a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3534,7 +3534,8 @@ const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type
 	const struct btf_type *t;
 	int len, id;
 
-	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
+	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key,
+				    btf_named_start_id(btf, false) - 1);
 	if (id < 0)
 		return ERR_PTR(id);
 
@@ -7844,12 +7845,13 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			tname);
 		return -EINVAL;
 	}
+
 	/* Convert BTF function arguments into verifier types.
 	 * Only PTR_TO_CTX and SCALAR are supported atm.
 	 */
 	for (i = 0; i < nargs; i++) {
 		u32 tags = 0;
-		int id = 0;
+		int id = btf_named_start_id(btf, false) - 1;
 
 		/* 'arg:<tag>' decl_tag takes precedence over derivation of
 		 * register type from BTF type itself
@@ -9331,7 +9333,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 	}
 
 	/* Attempt to find target candidates in vmlinux BTF first */
-	cands = bpf_core_add_cands(cands, main_btf, 1);
+	cands = bpf_core_add_cands(cands, main_btf, btf_named_start_id(main_btf, true));
 	if (IS_ERR(cands))
 		return ERR_CAST(cands);
 
@@ -9363,7 +9365,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 		 */
 		btf_get(mod_btf);
 		spin_unlock_bh(&btf_idr_lock);
-		cands = bpf_core_add_cands(cands, mod_btf, btf_nr_types(main_btf));
+		cands = bpf_core_add_cands(cands, mod_btf, btf_named_start_id(mod_btf, true));
 		btf_put(mod_btf);
 		if (IS_ERR(cands))
 			return ERR_CAST(cands);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9394b0de2ef0..05fa2e9181f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20642,12 +20642,7 @@ static int find_btf_percpu_datasec(struct btf *btf)
 	 * types to look at only module's own BTF types.
 	 */
 	n = btf_nr_types(btf);
-	if (btf_is_module(btf))
-		i = btf_nr_types(btf_vmlinux);
-	else
-		i = 1;
-
-	for(; i < n; i++) {
+	for (i = btf_named_start_id(btf, true); i < n; i++) {
 		t = btf_type_by_id(btf, i);
 		if (BTF_INFO_KIND(t->info) != BTF_KIND_DATASEC)
 			continue;
-- 
2.34.1


