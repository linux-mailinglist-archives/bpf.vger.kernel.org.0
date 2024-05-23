Return-Path: <bpf+bounces-30417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3C8CD944
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7020C28385F
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D77F481;
	Thu, 23 May 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knyrCRTa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB187F486
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486138; cv=none; b=lPEtf2Ejb4fOFtw5T8p1NHQpaVPUK/G9HSwaq4Cf43C9CSfNyS1vOrewAtngKiN6DgBuYYSUToTHSiI8393fPmEZKFx0Dbkj1zZxKTBOsbBbDG9x34kSF/9+qPPeWBQxh/Hg8c+yJEDknvvrVyD9oz684fV8mAZNGRP9R9zzbqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486138; c=relaxed/simple;
	bh=AfPVNo1WOUDkeqpBoOWizg53TqtuNzGhAMFb5lNqTho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=up58SyqkBCJOdBqh6aj+V+8LUIdi8J3A456OVzNFVNIVYysFNyJpymWbdlKL7XygPrl1noPQmhy/1DwzAaN5dvVcHKlvU2MvgMkRQlrMGrscJ4QTiFf6zqGYBzmG7mal3UHKN69hlD/zS7O5Q9XXCoBQ0NldncYKu4ESHhgJ0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knyrCRTa; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62a080a171dso6547b3.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486136; x=1717090936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtdQr/zEufaVdZNG//MSA6qPzIpwLHsz9vFprtP/cME=;
        b=knyrCRTaZJGZLB5Yh1LOXaOMxjYA1hNHUIk8ybchLH2RnXGHBMJ5AT83M9Qgo3ucY0
         2OQkWPnWYFMVRBYniDrVIQ7cxhrt1ziAtiDLQXJlcLbj8ohKAltEL+6BvIGaO2+J333T
         0HsiS/HDDQW57TabCgb8XoMHSiUZr7AUVDd7b9MVXIkRrn/5kBJZGUO/UKrC23/7BpC+
         u9a7EUjD/nLKkuxly6J4LczWAghxZGdtcNkhakQ51agWk1F4827zpGUomrtnPNFf1aLG
         8GXD7XfaSF7gdVaN6C18oTKRts3GSb1LJPBhIzShOQ8jzZ9Facm41cVoABO2i7AS2krW
         9b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486136; x=1717090936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtdQr/zEufaVdZNG//MSA6qPzIpwLHsz9vFprtP/cME=;
        b=d4/iBDDtdxIa0PXvJzBS32kfgU/zzyBuPrucgSubGMSAP7sS7eLchIY0/0G9O6LAbL
         o75vwJsvNkpafYyHcRWTnaMlc8LvbwO9z4M3u3QcW7OCnXFxXHqH3Vqfp8YuPOtBWlo2
         no4qxb5wf4A1rBwD1iu3mzdx3/BzwCVKPfaSrukNLofB13feFICkv0OJJMlz1EqNEzOp
         Mo4uZx3tygxEc6kem1lnd+/plWWm2VTOic8AH78qjvSc9S6+QOYOeG00Y7hJPIbHCT9x
         Rqxxaw+Fn2U6TUc4l4xsgVwFax3FaMICVF7mGHHy3HohJTcRJLeqWVzAApPvI1Gln/wN
         l2ng==
X-Gm-Message-State: AOJu0Yzg5YWl+M0jS9BL1pQ261GNl++HKiVJlHrhjTSC7yudwbxtI9Wn
	L105CP16lBl11LpINuODg0pMVaMGds9F7MQ+fenkS4wI5vwVYREQax0W2g==
X-Google-Smtp-Source: AGHT+IF06h4TqOrTWk9YihojP1RVpznBghkflUAsJCptmHVlEBPHzvZaH7qD2sV8rNh7E5s9+YXlbg==
X-Received: by 2002:a0d:c3c4:0:b0:61a:cea1:3c63 with SMTP id 00721157ae682-627e482ebe1mr57925677b3.47.1716486135853;
        Thu, 23 May 2024 10:42:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:14 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 6/9] bpf: limit the number of levels of a nested struct type.
Date: Thu, 23 May 2024 10:41:59 -0700
Message-Id: <20240523174202.461236-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523174202.461236-1-thinker.li@gmail.com>
References: <20240523174202.461236-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Limit the number of levels looking into struct types to avoid running out
of stack space.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5e2b231a9af4..7928d920056f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3536,7 +3536,8 @@ static int btf_repeat_fields(struct btf_field_info *info,
 
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
-				 struct btf_field_info *info, int info_cnt);
+				 struct btf_field_info *info, int info_cnt,
+				 u32 level);
 
 /* Find special fields in the struct type of a field.
  *
@@ -3547,11 +3548,15 @@ static int btf_find_struct_field(const struct btf *btf,
 static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *t,
 				  u32 off, u32 nelems,
 				  u32 field_mask, struct btf_field_info *info,
-				  int info_cnt)
+				  int info_cnt, u32 level)
 {
 	int ret, err, i;
 
-	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt);
+	level++;
+	if (level >= MAX_RESOLVE_DEPTH)
+		return -E2BIG;
+
+	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt, level);
 
 	if (ret <= 0)
 		return ret;
@@ -3579,7 +3584,8 @@ static int btf_find_field_one(const struct btf *btf,
 			      int var_idx,
 			      u32 off, u32 expected_size,
 			      u32 field_mask, u32 *seen_mask,
-			      struct btf_field_info *info, int info_cnt)
+			      struct btf_field_info *info, int info_cnt,
+			      u32 level)
 {
 	int ret, align, sz, field_type;
 	struct btf_field_info tmp;
@@ -3607,7 +3613,7 @@ static int btf_find_field_one(const struct btf *btf,
 		if (expected_size && expected_size != sz * nelems)
 			return 0;
 		ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
-					     &info[0], info_cnt);
+					     &info[0], info_cnt, level);
 		return ret;
 	}
 
@@ -3668,7 +3674,8 @@ static int btf_find_field_one(const struct btf *btf,
 
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
-				 struct btf_field_info *info, int info_cnt)
+				 struct btf_field_info *info, int info_cnt,
+				 u32 level)
 {
 	int ret, idx = 0;
 	const struct btf_member *member;
@@ -3687,7 +3694,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		ret = btf_find_field_one(btf, t, member_type, i,
 					 off, 0,
 					 field_mask, &seen_mask,
-					 &info[idx], info_cnt - idx);
+					 &info[idx], info_cnt - idx, level);
 		if (ret < 0)
 			return ret;
 		idx += ret;
@@ -3697,7 +3704,7 @@ static int btf_find_struct_field(const struct btf *btf,
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				u32 field_mask, struct btf_field_info *info,
-				int info_cnt)
+				int info_cnt, u32 level)
 {
 	int ret, idx = 0;
 	const struct btf_var_secinfo *vsi;
@@ -3710,7 +3717,8 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		off = vsi->offset;
 		ret = btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
 					 field_mask, &seen_mask,
-					 &info[idx], info_cnt - idx);
+					 &info[idx], info_cnt - idx,
+					 level);
 		if (ret < 0)
 			return ret;
 		idx += ret;
@@ -3723,9 +3731,9 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 			  int info_cnt)
 {
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, field_mask, info, info_cnt);
+		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt);
+		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt, 0);
 	return -EINVAL;
 }
 
-- 
2.34.1


