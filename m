Return-Path: <bpf+bounces-78322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A30D0A5F7
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06D3B32331FD
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60635C1B8;
	Fri,  9 Jan 2026 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SksYxhhm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F535BDC3
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963635; cv=none; b=ZzZOa8aK0LtbG78ItCCysqe1YMTsOKj71w2H6tpUTH/6r3GSRlJxAQf92m+B+9pHmGfHfvH76zgP9kxDgbeWnMZut4ELs6vYT0h02KRYG6U2c9CBt3Ny8mP8GOHbdikX9SQBML+I3ZmS1TiSmLxx/ON+flzX/8o/z9ua6d0yuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963635; c=relaxed/simple;
	bh=I7eY37GsTyoXAh2wI+oSWMcZ+lGsgT+0+h2fMUYmJ2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XVEQ/YZ+eXyzwX+OwZOdmLOXISIEmD4UxZ8+h3PIc62W1jiNM1MVYLu/R6DrauYyOCZ7jkx8LiIW2BWWC0FBgVdrTvf+t66FriMzopj1D4T1MM0xOYWErQnPUy4njZ2uKYAfCNG1t9ZYvFwbpM142rBd1aabGZSayhrS+1gEEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SksYxhhm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0c09bb78cso23496865ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963633; x=1768568433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mmxvmI6t4HDfgNI7x8o7q25F6wuDxougz7BYJ8lGNw=;
        b=SksYxhhmwwRk/L+yd7O3uO8/vCTdT/IHEd2MkMxAaxMCkC9VwByAdYKaCqsKMD5V3q
         wA5P6yv/Cg714ntI2a5x24zttVbDCcrm9Y7eLiVqGLjX1YSr7CM6FHq908htKXepEsvs
         C09Cdn1np8kLEQzLGHafs6Woy53hbN2KfUtCm2kTm7q0RKIa/9dw+zVB2HmbtWuuL9XY
         xpV2HzfVYJPdxXncS2th1cHOQb6nl8ArsmLHnHyefYwcLIta0fHLw5+YgyUuGY5QmcjL
         QV9kltw4rDfv+qO/DRb0M7xCoi2oUX0R5EXwtVDcR8vuoUhANVA4VriNmfVHvwbs22Qe
         PwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963633; x=1768568433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mmxvmI6t4HDfgNI7x8o7q25F6wuDxougz7BYJ8lGNw=;
        b=hKKihhSfPWZ7X+Nz5/wsK0B45mbBTSc8nVKPe/lxw44QRQeTaKmvrHBu1VbKa0tF+W
         0Jp+rlSODNgI2dNJdvNgPuA4xtNKWToOTRuA1PRlKJzPe5pt2kFAUfl73lL4VsXqLJgt
         nvSbopcnPhvkSC7JDT9+FVz7OE9b6XDHOGsMFmQWb9o2U+AKgIWu+MEMoFl/0VBElk1Q
         Sf7MUfU/P5UgFMKFbEoNjr/y2VGLkiyeJJiiCdWTqLHzFays9WsVw31l5UPdOGE0EV+K
         xA1Sjy5flMqEWNfHQ2HuhODYgJAjEFDohcap9rMGUYV9FxwHhdFE1o1sqQdpkVjCv70N
         rV+w==
X-Forwarded-Encrypted: i=1; AJvYcCWS9y8LYwzmBGJZ/1ZTYgZtDzdHoO9xyPS/SZ5GcuF9ceABwxO+q1qTCpaiddN0VPrKS5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdk8IyijgdWMtHcU+CVDE7jgEMiaOhZrsUoaAfhSI1CnA4h0DI
	ovT8xQcaTSzJiFXF6l2YwU/kF3GM6w/3MjF/MvVym9OIzDSj5uos7csA
X-Gm-Gg: AY/fxX77os5x8xg8zvf/piHTA77XtW7w1LtnyoT0ToIrCI6SBb93foUYfUVwSC88R+B
	qxxdBGf+1b8CCJdhonPmLvNJ3P+F6lJpWaWKS6OKN5PckGQ50LNkFwl0tokyehe/dQ2Tz018lex
	8YGnMeN3NGoWxZXbFZ9xGd6eQCK/VwCLOQFtjrrANfoADtUezlr/4tylP/6vRetuLEEnpmc/u4T
	QIvjSuYfGLw1c51z4anv/YS7EaokeKOgadWnVjjJCc5hFwY/UqD/9s7D5QblmjkuPAPCE8ymSsV
	e4u0T1vwD0/AQs12vyW647DFW9I75/byvn7yKhvfr1qtkyXjZPEz7AMvme46fJFHpuLb/R/d8Tm
	0knprfp0ylPdXUP8WSMjQ042LorpvLxUHypn5pgvK19YN4QGrQbECI0r7bNUwfu3mKujZwgULf1
	nWdv7oFZsTc/YzpddTIcbYMqLb078=
X-Google-Smtp-Source: AGHT+IFoDc8zaNyyFce5gCCCHC7gM3YATlAegS9bI1XtcQ7NPXKyJ161Oc8IFC3/EUDLdresQG1BLg==
X-Received: by 2002:a17:903:350d:b0:269:7840:de24 with SMTP id d9443c01a7336-2a3e39e5b74mr113131885ad.21.1767963633180;
        Fri, 09 Jan 2026 05:00:33 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:32 -0800 (PST)
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
Subject: [PATCH bpf-next v12 08/11] bpf: Skip anonymous types in type lookup for performance
Date: Fri,  9 Jan 2026 21:00:00 +0800
Message-Id: <20260109130003.3313716-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
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
index 53635ea2e41b..53aa8f503775 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20652,12 +20652,7 @@ static int find_btf_percpu_datasec(struct btf *btf)
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


