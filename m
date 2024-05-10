Return-Path: <bpf+bounces-29426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913468C1BEE
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51EC1C216D0
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45D13AA31;
	Fri, 10 May 2024 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsDphmXZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48613A886
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303603; cv=none; b=QtMk/R+uR9knzOSjrsxyreo44bQRnmwAtbVi1pveQs/TgFdR+fpXKk/dA51RjoNAIDywZ1M0AQKNYD9vt7a/a4KpA+8csjFlXxhqFJ9Y8imw7Gq88uinNUZPWgDF44q9O6oIiJ/WcFrinRo/JgfTvJCEuZFRxrPb3IXNnOlpaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303603; c=relaxed/simple;
	bh=oEBCIVoFTOPMvF4duIpfQ87/eC0OSXnLw+AR/43RUT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2GqFFeywoEBhdsc9RJpLXmrlw4Sps5GPVkOiQIQfoZFJ7t2+LSzTexSo1ehi1XzF2h11C+3BRseXHzzxWxQgMy+qE1pOKXMHDWknxqRy5bh2oIfMfo+/mw5qGZW8KfYSm7mJrzpvDYQbckvqj5oWAWd3vgkokmZO+vYe7p+frI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsDphmXZ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f054c567e2so931246a34.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303601; x=1715908401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHH9Xryb0FOuN83WbsuAD3l1qxS4FUWZMjvJox+s7Ww=;
        b=TsDphmXZtn1svsFkWTATewATzi+hZKcxL3AUTL8DhhGgUF3+mZyJ6XZQbhHtcILCbT
         Z0NUkT6AIbBRriR3C1XhMQ+YUaHt8PX3WJme7g440D1FunsTg5ygsU8v+5/dvTQflm0l
         n9zRLscOSqv+7VMZqfVe85g4VD8OBrimasLSk9UMN6boR69mB+xuUQvRnBVJtwaotY1w
         i0nTAu7BYHLLU1EdjlS42rz1b1toah2rWrTTBMPMIDAKDjBYKPbdNj5ERvHRGBIlexwi
         oaA0qN844qE4FZlDjIIHuSxj5o+S9lbjfbYSyvmSd+bisoKxKvdKUO6dZxSbN3H9h7K+
         MVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303601; x=1715908401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHH9Xryb0FOuN83WbsuAD3l1qxS4FUWZMjvJox+s7Ww=;
        b=rZxHnQYzI9vkJtfD9vKy4dC4D5PcuZ5Nmt0q7kOzmUGbF10LzuykdqQDgTdIZrygrM
         5r7jCm4jfiVY3CWcX3YJsTRrv7GXca2UnAQBxRuzsNKfYV0XJquf3lyScs3+YkoQxTqN
         T3pqhrpI2UXw/k7RelQT2DDj5wqLYlzw8n95HZsm2j92BOT2dy44d2noRvnJhSfP3MqQ
         gLQKW3bpWbY0qgonsv9A+LLMoavCsOC+CUHYWRMRVsvwpx+yoGky/7ArH4A75931sDHm
         iBoxw27I6SbJZf1uWsTEJ3WIVjwrIsrFoO+exJWlVP/InCe5q3dNjSkg+s9QhDvsBwaE
         kxhw==
X-Gm-Message-State: AOJu0Yxj+HWcCQXLYv189j/mP27gLGKxQl5kaFhQcqx7WwMsUXSDZg3e
	tt7cbuvGhkhaC/R/UhuP8g/kGdqaHsIJZzNhvtx0ewFvlGkdX8BH4tSS0g==
X-Google-Smtp-Source: AGHT+IE7tJ84BTWhhrxFkmKpf59sf5wSCzNIri+gQieDg1AzTxug4xeBu2mAzj4xfEONBA+Jgnox/Q==
X-Received: by 2002:a05:6870:2153:b0:23e:111:cf21 with SMTP id 586e51a60fabf-24172a7dd70mr1535957fac.13.1715303601148;
        Thu, 09 May 2024 18:13:21 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:20 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 6/9] bpf: limit the number of levels of a nested struct type.
Date: Thu,  9 May 2024 18:13:09 -0700
Message-Id: <20240510011312.1488046-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510011312.1488046-1-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Limit the number of levels looking into struct types to avoid running out
of stack space.

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


