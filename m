Return-Path: <bpf+bounces-30048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537F8CA36F
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4A11F21ECE
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F6139586;
	Mon, 20 May 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4FSCjJA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088413A244
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237633; cv=none; b=c4Z6I7ro9d3HRa82Zzhf8Uj0gfJMUsIlEasVLgwsFOGm6Jhkt2TvBrRDR2ts5hyDOWmXpu7n8fYsb398fm+oxCwxtGhgyjKX+1wHzw0nXyC/LoRZFRd9JQYz/Yrx44z1q8XqyeK0HERCAi8pi4prD9vjg14YNcMQO3XiZwm2ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237633; c=relaxed/simple;
	bh=07OA5mz2CKxyyTX9ZC3rbmToCVoTB2+Qp4mhwkQl0N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzcGn6uql0JVuJeLuhzhsMa7N+7/tQZX0GM5JsF0XkWuxOOKGJb+8n4C1f4robHaHI7KYldqEu1aPrZbnBMuWYT6fYJcME7ZAQA18goPai9OYC2iGdZyzdsnJZZ3+Gm6XzKsKFqUgjxdfbl579skgBfI8Fn7wwcgcPbLsw7+h0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4FSCjJA; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-620390308e5so28227497b3.3
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237629; x=1716842429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2loRtf+J0AsjQ+vogzU7bqnrDe3kMPAQWv4ggs8hcM=;
        b=J4FSCjJAKptY9K12Ac05giTs1HDl7ca/g02I/9/sBHoTjPs37iK8xsXGsQ7Hy/LqYv
         HMz2wq6I+aTCbCHOLfIjbFeX8W6qajX0ikiRyFi5sWQ9PSTMRpEno6lqEcM3uvddRQvk
         /pdmciWyozWfIxMGHuVfvMe6I/mHKB0EkhR/284YamSrR8eTLhMO4tBkRCFDTUjkNhMi
         XTo/6pSyda/RZqG6jlOkr2DY2F69vdVcX0vyZUW8FOOxS5BvVoZ6u8+449IZAIXGtpnm
         RxrMKITFDzcuX1HuCtABtU0wBK/qWZqi6xP6AJPeI7SjSPi1rLwZMyXmBKKKJPirqHkd
         P5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237629; x=1716842429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2loRtf+J0AsjQ+vogzU7bqnrDe3kMPAQWv4ggs8hcM=;
        b=U/PYURro9tzBa5ZDhbJf/ou1UWl3BazPrF84SkE4n0ExrAD/dkcXxfxoCNbfsklRzv
         ybZCYntJoG1/MgHh1diSYvywNlVe5H2ir9ZNgOPwfZ/XgZAwgPq2CBJUtKbvHtzfFEqU
         K6fWHCky+e5aJCPQJVY3JsD5nLk91SXKhBm0Lwki/6CyDdHCrnzLMkf2xRjlWi37uH2v
         ytlKMuD1fBLbmy/r7FHHPYE5AoaUe3pGnKxp7e5YuPZck8KHdwZtp0xLXTDK2od2bF0/
         3dCS1oINMNfMdMnPmrqfEPrSKFB0gBil9+CfOMYSgkuilu0EDtuT9R9Y+lRjYj7HU0qZ
         2/OA==
X-Gm-Message-State: AOJu0YzNXXoKRmszkNpqF57m0y4eGugQCJvyLgshAz7Yd+TTMO4x3pfa
	g3eT6HBBWHFKFzWbRE0quylboXLkMulzjbW3Me+OKvTu34q8oB4Up2Xuyw==
X-Google-Smtp-Source: AGHT+IGI42YZ3NyH+ihuUFd8YIvLTw3NJJ6BW3gA2vOWv9SNYSP8Bb9FDX1iQqgdftcVjFvJgSO6XA==
X-Received: by 2002:a81:e40c:0:b0:620:2cfb:7a0e with SMTP id 00721157ae682-622b001f352mr268324627b3.40.1716237629621;
        Mon, 20 May 2024 13:40:29 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:764d:6809:5ff0:b5b6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e381afdsm49684267b3.127.2024.05.20.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:40:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 6/9] bpf: limit the number of levels of a nested struct type.
Date: Mon, 20 May 2024 13:40:15 -0700
Message-Id: <20240520204018.884515-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520204018.884515-1-thinker.li@gmail.com>
References: <20240520204018.884515-1-thinker.li@gmail.com>
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
index e78e2e41467d..e122e30f8cf5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3534,7 +3534,8 @@ static int btf_repeat_fields(struct btf_field_info *info,
 
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
-				 struct btf_field_info *info, int info_cnt);
+				 struct btf_field_info *info, int info_cnt,
+				 u32 level);
 
 /* Find special fields in the struct type of a field.
  *
@@ -3545,11 +3546,15 @@ static int btf_find_struct_field(const struct btf *btf,
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
@@ -3577,7 +3582,8 @@ static int btf_find_field_one(const struct btf *btf,
 			      int var_idx,
 			      u32 off, u32 expected_size,
 			      u32 field_mask, u32 *seen_mask,
-			      struct btf_field_info *info, int info_cnt)
+			      struct btf_field_info *info, int info_cnt,
+			      u32 level)
 {
 	int ret, align, sz, field_type;
 	struct btf_field_info tmp;
@@ -3606,7 +3612,7 @@ static int btf_find_field_one(const struct btf *btf,
 		if (expected_size && expected_size != sz * nelems)
 			return 0;
 		ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
-					     &info[0], info_cnt);
+					     &info[0], info_cnt, level);
 		return ret;
 	}
 
@@ -3667,7 +3673,8 @@ static int btf_find_field_one(const struct btf *btf,
 
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
-				 struct btf_field_info *info, int info_cnt)
+				 struct btf_field_info *info, int info_cnt,
+				 u32 level)
 {
 	int ret, idx = 0;
 	const struct btf_member *member;
@@ -3686,7 +3693,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		ret = btf_find_field_one(btf, t, member_type, i,
 					 off, 0,
 					 field_mask, &seen_mask,
-					 &info[idx], info_cnt - idx);
+					 &info[idx], info_cnt - idx, level);
 		if (ret < 0)
 			return ret;
 		idx += ret;
@@ -3696,7 +3703,7 @@ static int btf_find_struct_field(const struct btf *btf,
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				u32 field_mask, struct btf_field_info *info,
-				int info_cnt)
+				int info_cnt, u32 level)
 {
 	int ret, idx = 0;
 	const struct btf_var_secinfo *vsi;
@@ -3709,7 +3716,8 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		off = vsi->offset;
 		ret = btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
 					 field_mask, &seen_mask,
-					 &info[idx], info_cnt - idx);
+					 &info[idx], info_cnt - idx,
+					 level);
 		if (ret < 0)
 			return ret;
 		idx += ret;
@@ -3722,9 +3730,9 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
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


