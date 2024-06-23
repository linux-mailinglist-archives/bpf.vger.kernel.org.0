Return-Path: <bpf+bounces-32836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA41913870
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 09:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594B2B22FEC
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6939847;
	Sun, 23 Jun 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QNt0Z568"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60372836A
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126225; cv=none; b=KvR4URV4cqgyGNnChB61/XjtiIJqrQbnEwhfJnjb5WVBNBX1M6GiETsvQT2E+0/LxkFYBb1qpx9MEmn1vz/05dmoXG1ttthQdJ5r5WhFkwmVKxvJR9WVU9WZvAWGlhUjYr3lbo0RoqR7nEV1MihPYMqqcoDHHygzdLS/SZCyxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126225; c=relaxed/simple;
	bh=FltYF78F9/MqhM5jam26l4dQVN9Cgl/mT9HnO8YjLOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c95kAbtJSIWh2H/1TWsPV5GuAR6OJ7pzh1aCivIq9+yG5EGaHKwUfP5Vdiq0NXYMQqbNuHX1FdUBIegIXhYNQIT/4GcxJjlvw2oBVSWAO3vSS1zcACIpAFZuc7OiLS0lQBCa4+KAS/Sj6bkoV5vt0s44hu8LJsqP9+JU436DUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QNt0Z568; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so45277531fa.2
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 00:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719126221; x=1719731021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWaF5C+XrGxbFWUh1Nu3tH1BQNMNQ6zxjDoDiAz9oz4=;
        b=QNt0Z568UxtxQMqPVqQRtemxXwCd69gWG9R/vKlt8qUmk8bdWRpcbuMfW+XqCgoLl2
         tv7qaSTnpotk29DACJ3fYSwZbJUPo1fnt4PoPgFEAIca6yLONtfq2v/KKHVjCJUQxZTz
         j1V/T3RTr9obaazkQCvi1F/QqaDwx6Pb1Flcm0UW3IFuRtLfkFJAO1llFt1xkweUNWuI
         g9af3GVHyFrdAq6NfKSbgjGoV5XX+/JhjJ8/uSFCrPX5smbP0z7WASBgiSLV4hUKbBc8
         LazUC7BdnlXnfAVjTdtAZCD2TS+ZqJELERE/6Xr10mmidXd9fn9OIOiA6oozIpn/soBi
         gWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126221; x=1719731021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWaF5C+XrGxbFWUh1Nu3tH1BQNMNQ6zxjDoDiAz9oz4=;
        b=hLmC/U0EkfnKIOswlmRAFt6Qo+MeW+bNBrjlliVXSZcIzjbuSzoT65kfSH/FAbBN9T
         NAg5/Xrt2QtET1lnsoLif4NQGcswCYiUBtu3TFkZivTaWPeElmI/by3garRaUFdM7xwH
         iIWNs/dT6b5mFiQgY85cehqJ4j73SR88WxDei7TErAuBXxXMQjujPicQXK2Kfi1HaxjE
         5ElOenDkDl6dWzjIB4a6B3PWWoYqRcjKLEGZ29CE3dJKw4DnaGURgMtPHAXIIU5v0dme
         VozerOKK8Mf7sTZDSXhfK0JXwE1GMOAjv+bWOSJ9pQMiB3yMx8bjtYy3I9mCOPltjWq4
         HMaw==
X-Gm-Message-State: AOJu0YwU3CIQLdgHDVjHXCiR9R2GDMSKz/61vE45nC3Q5Ff+qVQpJdnq
	pkH0j50QVdE7rSWU8egEvdQQ1TuZiYhCAxQw/qCom+O/wcf5oTqRIMFqY5FWfmcwsioaAj9cUdm
	r
X-Google-Smtp-Source: AGHT+IHekYT9VVXJsGQKNVB0w833IojZ5GTCRCcjZclZk14I6/3NpEqAM+2yuAUwGkJeEbcu4iIWcA==
X-Received: by 2002:a2e:3518:0:b0:2ec:57b4:1c6f with SMTP id 38308e7fff4ca-2ec5b31d1a2mr9942921fa.34.1719126221030;
        Sun, 23 Jun 2024 00:03:41 -0700 (PDT)
Received: from localhost ([2401:e180:8842:4fc6:d5d2:edb0:d14c:4782])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d51easm40610625ad.202.2024.06.23.00.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:03:40 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 2/2] bpf: verifier: use check_sub_overflow() to check for subtraction overflows
Date: Sun, 23 Jun 2024 15:03:20 +0800
Message-ID: <20240623070324.12634-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623070324.12634-1-shung-hsi.yu@suse.com>
References: <20240623070324.12634-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to previous patch that drops signed_add*_overflows() and uses
(compiler) builtin-based check_add_overflow(), do the same for
signed_sub*_overflows() and replace them with the generic
check_sub_overflow() to make future refactoring easier.

Unsigned overflow check for subtraction does not use helpers and are
simple enough already, so they're left untouched.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 46 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b1ad76c514f5..2c1657a26fdb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12720,26 +12720,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
-static bool signed_sub_overflows(s64 a, s64 b)
-{
-	/* Do the sub in u64, where overflow is well-defined */
-	s64 res = (s64)((u64)a - (u64)b);
-
-	if (b < 0)
-		return res < a;
-	return res > a;
-}
-
-static bool signed_sub32_overflows(s32 a, s32 b)
-{
-	/* Do the sub in u32, where overflow is well-defined */
-	s32 res = (s32)((u32)a - (u32)b);
-
-	if (b < 0)
-		return res < a;
-	return res > a;
-}
-
 static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  enum bpf_reg_type type)
@@ -13280,14 +13260,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		/* A new variable offset is created.  If the subtrahend is known
 		 * nonnegative, then any reg->range we had before is still good.
 		 */
-		if (signed_sub_overflows(smin_ptr, smax_val) ||
-		    signed_sub_overflows(smax_ptr, smin_val)) {
+		if (check_sub_overflow(smin_ptr, smax_val, &smin_cur) ||
+		    check_sub_overflow(smax_ptr, smin_val, &smax_cur)) {
 			/* Overflow possible, we know nothing */
 			dst_reg->smin_value = S64_MIN;
 			dst_reg->smax_value = S64_MAX;
 		} else {
-			dst_reg->smin_value = smin_ptr - smax_val;
-			dst_reg->smax_value = smax_ptr - smin_val;
+			dst_reg->smin_value = smin_cur;
+			dst_reg->smax_value = smax_cur;
 		}
 		if (umin_ptr < umax_val) {
 			/* Overflow possible, we know nothing */
@@ -13400,15 +13380,16 @@ static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
 	s32 smax_val = src_reg->s32_max_value;
 	u32 umin_val = src_reg->u32_min_value;
 	u32 umax_val = src_reg->u32_max_value;
+	s32 smin_cur, smax_cur;
 
-	if (signed_sub32_overflows(dst_reg->s32_min_value, smax_val) ||
-	    signed_sub32_overflows(dst_reg->s32_max_value, smin_val)) {
+	if (check_sub_overflow(dst_reg->s32_min_value, smax_val, &smin_cur) ||
+	    check_sub_overflow(dst_reg->s32_max_value, smin_val, &smax_cur)) {
 		/* Overflow possible, we know nothing */
 		dst_reg->s32_min_value = S32_MIN;
 		dst_reg->s32_max_value = S32_MAX;
 	} else {
-		dst_reg->s32_min_value -= smax_val;
-		dst_reg->s32_max_value -= smin_val;
+		dst_reg->s32_min_value = smin_cur;
+		dst_reg->s32_max_value = smax_cur;
 	}
 	if (dst_reg->u32_min_value < umax_val) {
 		/* Overflow possible, we know nothing */
@@ -13428,15 +13409,16 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
 	s64 smax_val = src_reg->smax_value;
 	u64 umin_val = src_reg->umin_value;
 	u64 umax_val = src_reg->umax_value;
+	s64 smin_cur, smax_cur;
 
-	if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
-	    signed_sub_overflows(dst_reg->smax_value, smin_val)) {
+	if (check_sub_overflow(dst_reg->smin_value, smax_val, &smin_cur) ||
+	    check_sub_overflow(dst_reg->smax_value, smin_val, &smax_cur)) {
 		/* Overflow possible, we know nothing */
 		dst_reg->smin_value = S64_MIN;
 		dst_reg->smax_value = S64_MAX;
 	} else {
-		dst_reg->smin_value -= smax_val;
-		dst_reg->smax_value -= smin_val;
+		dst_reg->smin_value = smin_cur;
+		dst_reg->smax_value = smax_cur;
 	}
 	if (dst_reg->umin_value < umax_val) {
 		/* Overflow possible, we know nothing */
-- 
2.45.2


