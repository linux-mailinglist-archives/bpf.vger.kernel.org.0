Return-Path: <bpf+bounces-64659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F36B152BE
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109CE18A59FE
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7F245022;
	Tue, 29 Jul 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx3dkHDI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145D23B609;
	Tue, 29 Jul 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813556; cv=none; b=mF2xj1MOsOYH+H1AnzyHSO2ejE+UmP6MhjBMOQ0niXRqRfaVjxoKE0hDk/u07ku1z2Ix5yL1UPUv8mBBFwL1XrwvT5FfxfTt8IwFdAV3SHxLwO9tP+cIiK9+tG34XJ28+9jMUg7rpssNfhsEjS2teIbZnZQuUVZ6plIuPrNmQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813556; c=relaxed/simple;
	bh=e9+vawrOTjK7MCKhLZlkfdS8ZzrrRRjrSMuBu5QzQvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJqljC9Vftmg9ENvcsEPfDq2QqzRwG5aA/LPRbz+8NZyctOym7/TN6QHw3NacbwynrOWiJzDHI3jfDnbY9dFgbHNksG+2FJ6zWAaL/sb4VP45FE14d2iUv+eeKRvpmqZehVc1EZ711oLUwudEdbbLG99deHCJzZOMmfJU/UcNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx3dkHDI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74931666cbcso5291377b3a.0;
        Tue, 29 Jul 2025 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813554; x=1754418354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ1LjCcYyyNk4sZPRD5cpxZ574IueAtTEw72tttJ+SA=;
        b=Qx3dkHDIeJnRjT0Y2XP5KQwdY/0KCRj6FV41IZVSXNUHk2U5Kux9DQzQFA9kN1lQSW
         5gNq4klavlSLfm2JehTfPZcb3bDwa/bMGEo/BcxV2whNqfdGBbjtjDEYEmdur4C2bnT9
         0Oy4FsjVYzfWDYf9fjYvV9CnChAbly0aS7ZdHAfe13tpCUG1Ltn69sCbWqogKyY8WoNV
         doI1JzbYOBKeyWfDVToCjVJQ+daez8GOwMbacmtpgERQGcNtHaIdGXgSRthD5wT2dHrF
         F9Ie57Dnj1bAe1CXddzKO+0jIMtX1vnys1fe8+a+vlgUUdcMkAXZjsxKTA7IGnO3BMz9
         Fj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813554; x=1754418354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ1LjCcYyyNk4sZPRD5cpxZ574IueAtTEw72tttJ+SA=;
        b=FxFOt4Wdc396nabrA3D5tEosmK/mstiDIYmGuBISp1pes2mZapSqMacuVomWWSXoa5
         LOn2acE0lqw9py0ptxSUKN4tjTO3jC6+aaRmI8iJXZnzJ+roIEdGhaVCr3beqnulKWU7
         AIk2dF/Dd7VBFocU/YT5ZpAPet92Dzj7FSo0i489gOUSpGW0Sxb0+utZ15lJafjtPUwa
         3zt2YHWG8Hy/Ehg99t451uwuI6goOqWDRYH0n28W1JW45exxBqFXMJsCPTdDhhk2WfDy
         M3MIKydIjvO1ZdbxW4vPmP0AZHQGQit8JB90rXYdxV8SVlTPa8O++o0zT3c/kLR53QAd
         HYHg==
X-Gm-Message-State: AOJu0YwBmNx1FHCUHV39nBjPKDWMDOrMYoyFHSPEjXKgwlEWIupyvHrN
	7cM5y0QyIEz+mOP6gxwgd4e3Epv75WciinnG/Bq1bC2qBHYpHpR0fLFYyzECEQ==
X-Gm-Gg: ASbGncufdO/5EBiZDGaD/ECSrS+Yk6IjlLejOSO+R8AyPCmWHtLk6rkBsQxK3Bk3vWd
	BGy8T4VrPVSNClbLNr/WybyDjboINHzC+cGa7AGwx4EpVMLhIdCnbafGApB5uUW/8Fcb/+iiYob
	5JexOew7c7cxypnNpG3B8o7OHAnKFctSJeGLMRP+GYO7bbinKBzxGpkn0gOO7BeQJjP5mFQtuVT
	iliTyNwyJ75rvMxdWMFthJwGJfCk0rSp1xr93I7gZUO/nbjQcuFVQ33DdUQxKIQLWvmUyP2V9o6
	NjLQPLDfSEy8Ok9xjRhlwyObznNu1LaV3wSEtC6oqaFDcvEImvnGkOG/iHq2npf6Q7wj5hroRJr
	2RKQc8v8W/toB
X-Google-Smtp-Source: AGHT+IEDSCtHlZPh4RwGiuC1RVjRxYA/ebNNLFj0T1kwr8O0VG0jhg8W8vi3jUP2//sPOOjfFT2Crw==
X-Received: by 2002:a05:6a00:1387:b0:742:b3a6:db09 with SMTP id d2e1a72fcca58-76ab3082bb3mr788302b3a.16.1753813554150;
        Tue, 29 Jul 2025 11:25:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76a167c66d9sm1871448b3a.7.2025.07.29.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	kpsingh@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 02/11] bpf: Convert bpf_selem_link_map to failable
Date: Tue, 29 Jul 2025 11:25:40 -0700
Message-ID: <20250729182550.185356-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
References: <20250729182550.185356-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_link_map to failable. It still always succeeds and
returns 0 until the change happen. No functional change.

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
index 7e39b88ef795..95e2dcf919ac 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -435,8 +435,8 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
 		hlist_del_init_rcu(&selem->map_node);
 }
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem)
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 	unsigned long flags;
@@ -445,6 +445,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
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


