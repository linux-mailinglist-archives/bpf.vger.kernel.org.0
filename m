Return-Path: <bpf+bounces-70249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC511BB590A
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7334826E5
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A729A9FE;
	Thu,  2 Oct 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyTqPq2b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7696285CBF
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445642; cv=none; b=gkbrb63WPzzhk6jWpAgnlFKFWXoynOiRUvxtHuw82qM4gREtlkWt2WkqN0zKF/1mNcue4IrHHF8/Fa67WT8X3DAwl0s6Io9klBKBlDckVbMoAvKhLlJ9CiBHlwoKqk4smheI0RARQoVBxz1rwe+oxRlXMT35xTmtg1lf3Jra/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445642; c=relaxed/simple;
	bh=G2QcpmxqDCDXkybGDNrR360cSYN2iQPwQ938lcG3SmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcDjl+Z4aHo9BWXCesrd+PC/sgsbtJPOXvUry3bv3UTuPAGHt036l/3Pes0+m6u8rZSf2rOCNtauyKw6pbLMeSx1h12Jjhuuvgw7Ar52wGcq0s+QxHvi3h7NY42OM4WSVyvxE7IpJiqUnoeouhMm7alYEeEqEdOmIEmrynvPO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyTqPq2b; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-271067d66fbso14970265ad.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445640; x=1760050440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V9E7SD80kJggRF+j2tWwJz7G3htgdHzaj/Ci6PqOQs=;
        b=iyTqPq2b8DNVH26GN/TkJ3zqmREwSxj3OlDnh0SVR/t5nIrPhaarCy2TNSo8YrYsEi
         UTOo9dNlK+qQX48tyVQI0xDjOqcwhm8CE0ZmTCGnCDUZokXcsnYMjll4+6FC2yJ3T3Hk
         /z23vzIRxBknE9R+8CUyTh9+Sl8I2nxk4ZO375MM5vLPUKrSnIA59JnEbwRulGdl3kjN
         X7P1hRBZKgrguS9GaznqfT5eGZqhTFn5BCbBb+F1Jn43wadXwgploxAIT49x7VUjVu6i
         vMLLDzpqyheFSM+G8DalN37I32vNQrgepEc940iGh6k2opSqHoebZDZXpjqf03AmIE8E
         5yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445640; x=1760050440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V9E7SD80kJggRF+j2tWwJz7G3htgdHzaj/Ci6PqOQs=;
        b=QTm0eE1bziUviv1vRK58nhszbLWE453EdnO9BbKi3rQyrHkAKKCI6ZUINkTBGmEtSO
         GWJeW5h5cyHxWVHS1nG79ciiTZv2bxO3Sqmo11BpZjJRIBDThYNpuf4jXylLhk81EtlN
         lZeubcEhuUakSJnu9lekKd56Io9vopXotqisjFMFYHwofKZ76yscA1S62lN2Xl23WtNi
         zf2OjI0c76M4/ftoxQf3i5vuKAmvL1AgFzQ5I5JmPCrDAEIgr021aZoi2GiCAfggqL6O
         i6onjEpDNgVInXuHEHjnJypJOpobfLd3AOircx7OVmOBm3kjSIOiBKvJ9JnYA3lx5DsV
         z61w==
X-Gm-Message-State: AOJu0YxTM1pBDItF2X9FFNu7z4ZyzxVJjmtRRpHPTzi+iOTEyPL4hUHs
	2vWhEB6rKjdXrZw2S63liMR278DNpT2C4E8HVNMhMlsjsgEDFMAD0BVpcJ2xsg==
X-Gm-Gg: ASbGncsS7l5NyTTbff+D/VIkh1eM2vpxyu4exmPfdoP/JmBTxzHzCk7v9IVzYFBUkYm
	Zx9ZicQZKTibsiZzdop0z0dPkwV/XcZR7r0xh+aalcmjKyLY3TccdaohUmr11nsAxnj+3ExcgNf
	OnDMGi/xlT2b+tQz4dUO6Z1+Y9k1zblnyhN5+FMt9rRE/5HNeU9pWw4WRXhGsLPxE49zm1xalUp
	YP8cbsI1Oit8uvAyYt1CBqjsxUfw9EbyWYP5jkyOsScdud+snT2FE1QNH4TfmEsA1zBz5RJECgl
	41qQYPo5ONOXZ3OF9Sa1qNXi98sXwn+wqFViJ0gXrmTo4By/flyrlOk0WdXLdCz3p9ezyH0DDrf
	2YDIVe/V2L00oshT4V/18vnXZv1BLJu/VG+cbRQ==
X-Google-Smtp-Source: AGHT+IFwNoZUMyJCTB6XkQrfgv4pBBMwR39TdXDtxp4YuY4hqZSGiHx1D2uZQgy2MmxydL4wErfWiw==
X-Received: by 2002:a17:902:f650:b0:269:b30c:c9b8 with SMTP id d9443c01a7336-28e9a6e50afmr10459625ad.56.1759445639995;
        Thu, 02 Oct 2025 15:53:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111b32sm31446085ad.12.2025.10.02.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:53:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 03/12] bpf: Convert bpf_selem_link_map to failable
Date: Thu,  2 Oct 2025 15:53:42 -0700
Message-ID: <20251002225356.1505480-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_link_map() to failable. It still always succeeds and
returns 0 until the change happens. No functional change.

__must_check is added to the function declaration locally to make sure
all the callers are accounted for during the conversion.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 4 ++--
 kernel/bpf/bpf_local_storage.c    | 6 ++++--
 net/core/bpf_sk_storage.c         | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index ab7244d8108f..dc56fa459ac9 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -182,8 +182,8 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem);
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index cbccf6b77f10..682409fb22a2 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -438,8 +438,8 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
 		hlist_del_init_rcu(&selem->map_node);
 }
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem)
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map_bucket *b;
@@ -452,6 +452,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
 }
 
 static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 2e538399757f..fac5cf385785 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -194,7 +194,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, copy_selem);
+			ret = bpf_selem_link_map(smap, copy_selem);
+			if (ret)
+				goto out;
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3


