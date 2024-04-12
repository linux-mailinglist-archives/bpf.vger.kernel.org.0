Return-Path: <bpf+bounces-26664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C718A37A6
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F7E1F2100A
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F094815532E;
	Fri, 12 Apr 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWdhvUUP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018C1514D1
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956107; cv=none; b=hV0Ou53O4gWieidjnDflP9pJiMlyNvRurtDAOxBxG+0VJHSsmkyBUh+SjfTjVWBp+5TgHif12lbkdLXgz+v/1ETJ1QYTMp2vxCZUwMcoi7Cj5lsgDKWe1kgaWF91ECjROiBFvLZX2ZzgTSUWOw8jfmHSGJ1nWctWu94gQEvY5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956107; c=relaxed/simple;
	bh=6XkZ/1FOu1LupX3nFqllD0vWnsEEY8AZzNuJu9Jpyno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRgf4tHDHKMvmwkBaxDyE5tnANCfEO1a6Pgk4q/kHaSPFY7fHBoUBUQNSOi/k+a6YvJ3tZu2S2jN8Derunph5YK5G4yghI5BX32mhJw8SKpvGvddpDd4KzLRsCMb8qWKdcUE17EoYKpbkSB7Wsjy17bmBnnBqDjuPc6Cw6rklj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWdhvUUP; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea26393116so1038873a34.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956105; x=1713560905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GqBNkXmzywsDFSvjJFp1U9/X7HRQVzzRiLFpr4/tl0=;
        b=KWdhvUUPYufJRZSshUv6DK4E+OsSsBmgTN+q4XRTa9mF83mzpN61hdlDiOs929w7iy
         Z3aom95xZag08NBGOlndw0szWNQG22n4Y6oevOfbVZVd48c5xy/w41f6bITXBrRudefF
         Lm5q7QFSHrYrsS2tU49Hp1vLCrwdh9SMYrgfbSBvazu3CpgNZ9diF2DzKepmdwuj+5iG
         luN9SVGiT9o4meT2SAeIB//bQiB6DpQo9wNd6nSAOblKum5SaVPXv9edQgCfHgBYQChz
         WdFE5j6xNDeJPvSUVk8aDNxEwbp5jW9KbW3Ynqx3vEg2toRA8qfRdPYvM/OThYfAOMQd
         O3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956105; x=1713560905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GqBNkXmzywsDFSvjJFp1U9/X7HRQVzzRiLFpr4/tl0=;
        b=l5fgri8vVmXpQ6xi+TFHajITE6O6CKtI+uKz07c90W5X2ZzWRfzw7MR6mKJEk6f1qs
         ekmyTxooUcEm5Z/IvOR3UqiF/CwMHRTocPJWQMIWM1G9b9W8194JqZpeyBof06/gujom
         eyiNFD6Pu1N01rWaDoIpQCi+OHnVfK2/aroxKkpM8yT+DkhMbmMwimzvjjVCCCiRqKai
         Yr8CyEJjbUeXqK3ALRrgx0xiWtrWeARijaH88OHmwneW0Zl+kmulfCgy6Ta0O4J47kk1
         tB/uAyHy9LKuSmLup/pGg+Q/mBhhiuLUD20Sc2nsVsvQfukKYtdQRhQRf39ToRPXfeMg
         TMbw==
X-Gm-Message-State: AOJu0YwYww9vaGHmMeHwZAzmiBZDWZdoGdUYPeVZRjdnLUemgGTsShHH
	sB0wCp725WIuIwV09o6B82SsDITsLzfS2w0cVd746mG9srTGwzPf3xUmCw==
X-Google-Smtp-Source: AGHT+IEhHLKC6KS7Hu6QXMbUMnzOptJZHkgr9CQu/gWT/lI95mCVYXv3I6ZLBDx2/7Vo18a2uqW2Xg==
X-Received: by 2002:a05:6871:799e:b0:22a:8e5:941 with SMTP id pb30-20020a056871799e00b0022a08e50941mr4003131oac.52.1712956105227;
        Fri, 12 Apr 2024 14:08:25 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 06/11] bpf: check_map_access() with the knowledge of arrays.
Date: Fri, 12 Apr 2024 14:08:09 -0700
Message-Id: <20240412210814.603377-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that accessing a map aligns with an element if the corresponding
btf_field, if there is, represents an array.

Without this change, an access would need to align with the beginning of an
array, otherwise it would be rejected.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 86adacc5f76c..302aad33a7f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5426,7 +5426,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 	rec = map->record;
 	for (i = 0; i < rec->cnt; i++) {
 		struct btf_field *field = &rec->fields[i];
-		u32 p = field->offset;
+		u32 p = field->offset, var_p, elem_size;
 
 		/* If any part of a field  can be touched by load/store, reject
 		 * this program. To check that [x1, x2) overlaps with [y1, y2),
@@ -5446,7 +5446,10 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 					verbose(env, "kptr access cannot have variable offset\n");
 					return -EACCES;
 				}
-				if (p != off + reg->var_off.value) {
+				var_p = off + reg->var_off.value;
+				elem_size = field->size / field->nelems;
+				if (var_p < p || var_p >= p + field->size ||
+				    (var_p - p) % elem_size) {
 					verbose(env, "kptr access misaligned expected=%u off=%llu\n",
 						p, off + reg->var_off.value);
 					return -EACCES;
-- 
2.34.1


