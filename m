Return-Path: <bpf+bounces-29024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970DA8BF64A
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF3E1C21B86
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF922EF8;
	Wed,  8 May 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIo3tnVf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16C1E53F
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149953; cv=none; b=FsVY4cmwhv4EmREUwCjYC1fl3wL0y9JuOdOwLPiknqAUBdZeULAAAadcQvauIK3k5+wDfi1HAEHKh6aeYi+QoOPlyHAJezI/evegzTe465GAA03RJ6p0/gf93d9Hr7m+qASPmNHGAWVuCykCR0MV1Ome1EqSUPBp8hJ2rJsKBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149953; c=relaxed/simple;
	bh=LpM0WjX+tDainc6yVUwiMyxOVwf2I1EDoa4gC6TSX28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZiZRsmNRmkOmMLJ8lnkTwajUjVVfR2JmEKYXxYmDe4OQbN0+SSm2anPhCpekk53bHuVh/L7LIUBeRlRvXIBBkpjuBh9jhvD48CCw+miSfEAVLUi+y2kjhANX7UG+d0prfggPyiCSSg9KV7FuFjofYYiRTro1XQxEl59vn+MuAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIo3tnVf; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c963880aecso1535707b6e.3
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149950; x=1715754750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGCAxMWCfi60a3tw+PnorEYjKcG5uTIVemeKayT5RIo=;
        b=MIo3tnVfOlhrpefraBDN5MhD8H8xTTFBACHFrKxS0RZaXbLonciML5e5LU2o5OCSY3
         4lk+HzZnNHqCW+KH04rqJUd4ktH44i9M1qXixekITxcGAM/buQrcKviSp6G4sMujpHrm
         EQJybScQXfdf2l9uLXhbky21dFhPWWotWKbPtanRKVpicKTJQsUDs5DeZe3N/GrwTjzt
         dgQEKo1RVwSaeUl8hta8ws9TqRP9Rj2Dv6vQimlonT3Pe0eLfKeYLuc4S7asae/zwV9M
         6zMWOpSrXFhKLDKunJaeN/2Z42mRwMbAB/3rh8yf96VbqooYu9aBbHTGJb3py+kTavah
         WmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149950; x=1715754750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGCAxMWCfi60a3tw+PnorEYjKcG5uTIVemeKayT5RIo=;
        b=lnZZya1kJ+ZlKRr0JSGnJMrFKrbKdPHBO3952aRjVssh4gKommp3MUPYYVexZZou/t
         C+WIWaj61mBkvB3oXnYDVlzo6KQRKUF1o68ixuvy1iCc5iDgRjQVrofU3q2WxKYXuNwX
         r3YyZ/BvMFl+ADDn8yF7SmEenTpzxAQTbDPMPJQs6p+scMLaDmXBi4iUdVmwL6vuAUo9
         EVxOva95NTMJVYdWeNW9Y6Ky8qwq+SsfCldJSgIErAD5R9PjYeJaywUn3aU9Ki7lufEn
         CjfhvCUx3NcN3v0ehuDmh48rXQ77R7LQkprjSRA3wolYNRsNvGsthfvP71cAYKy5Cklp
         J+Ag==
X-Gm-Message-State: AOJu0YyPEvknaboWHxsY09NUqebLr161DZ7YbbK8hJ2x+3UYILKo6bNY
	rJ2zyEBhnzR9/1PQrlif8ftQMiiwnjdpWSmS5lAtIs7Jh4RS4seWXNRqtg==
X-Google-Smtp-Source: AGHT+IGBMZRWdnyXIaNGMMcC/AieXODTPoY91Wqfr8ro436ML/0njKraxI09E7LPCQJTXxdVT59gJA==
X-Received: by 2002:a05:6808:1a1c:b0:3c9:6ba0:e98c with SMTP id 5614622812f47-3c98532a51fmr2056412b6e.52.1715149950384;
        Tue, 07 May 2024 23:32:30 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 6/9] bpf: limit the number of levels of a nested struct type.
Date: Tue,  7 May 2024 23:32:15 -0700
Message-Id: <20240508063218.2806447-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508063218.2806447-1-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
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
index bbda24299be2..b4d6a6959b21 100644
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
@@ -3604,7 +3610,7 @@ static int btf_find_field_one(const struct btf *btf,
 		if (expected_size && expected_size != sz * nelems)
 			return 0;
 		ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
-					     &info[0], info_cnt);
+					     &info[0], info_cnt, level);
 		return ret;
 	}
 
@@ -3665,7 +3671,8 @@ static int btf_find_field_one(const struct btf *btf,
 
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
-				 struct btf_field_info *info, int info_cnt)
+				 struct btf_field_info *info, int info_cnt,
+				 u32 level)
 {
 	int ret, idx = 0;
 	const struct btf_member *member;
@@ -3684,7 +3691,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		ret = btf_find_field_one(btf, t, member_type, i,
 					 off, 0,
 					 field_mask, &seen_mask,
-					 &info[idx], info_cnt - idx);
+					 &info[idx], info_cnt - idx, level);
 		if (ret < 0)
 			return ret;
 		idx += ret;
@@ -3694,7 +3701,7 @@ static int btf_find_struct_field(const struct btf *btf,
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				u32 field_mask, struct btf_field_info *info,
-				int info_cnt)
+				int info_cnt, u32 level)
 {
 	int ret, idx = 0;
 	const struct btf_var_secinfo *vsi;
@@ -3707,7 +3714,8 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		off = vsi->offset;
 		ret = btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
 					 field_mask, &seen_mask,
-					 &info[idx], info_cnt - idx);
+					 &info[idx], info_cnt - idx,
+					 level);
 		if (ret < 0)
 			return ret;
 		idx += ret;
@@ -3720,9 +3728,9 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
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


