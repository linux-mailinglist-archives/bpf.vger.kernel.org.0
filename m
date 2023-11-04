Return-Path: <bpf+bounces-14196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C297E0D54
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 03:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4E282046
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 02:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F861C3D;
	Sat,  4 Nov 2023 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL0+3GQi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C953620
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 02:44:55 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73D2D44;
	Fri,  3 Nov 2023 19:44:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2b1af964dso1692614b6e.1;
        Fri, 03 Nov 2023 19:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699065894; x=1699670694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKGQz1joPLPha7R6fZ/AtC4HHorloARO2OZK7OLX04w=;
        b=VL0+3GQixLlL7MRLUACL+gKsfjyuKguKa5QbZfplDOHdswMTSzP/YTZUxy7ffZKNTE
         GGylS724BFTHYsWpx3mogAZOjwfew/bfJTjXGflawRnIAy+qrkYiggB8DAonbrN6J7ZN
         zDIdkIMIhDqrI2nAwonYVL7yUZKZkqs7uOOeZmlQXd997s53HOJ5nw3h6LW0onqRARu+
         nysfAScqQt6Os20TiT8SmeU145ep9TiwgatMhIS3vTA/QuEN9WjjtUc7aVwhO/T5+8jo
         g4t1UFCvODzRQuB2u90d3eqeTfZeI9x04VZ2OYq6Tx5amsWZA9YQLrFfiS04NYOSgEQh
         bIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699065894; x=1699670694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKGQz1joPLPha7R6fZ/AtC4HHorloARO2OZK7OLX04w=;
        b=ZH5vN4KCsG7SM6q770fe70jQUqE468sm0DGBGtbirLpAf9PAToVYctQUtnm6DVotRF
         AsRTBCTwkvK8wSaCGFKZnzlMGlg7+hhGn6uMn85w3rqw1PuNw4yOQ/m7aGE6cDeAcVnI
         OHufH2xqCO0PpJZkILfJHqBPfdP+IxjcUpHh8dcjsYYB9zylMb66zvIFz2748YNZOxPa
         Q9av89ggodUj2zpLOP0TLi1ilqw1YKj5K9IDTxb6fdPPafNOYWiiTZi9aOwlPxkjgxQ9
         +X+mWASFsGQyNgdI/+MzMY/MzjbKg11xcvldLoH+yuIlNLRyL6tUS6NFWyEGqxV7sjcw
         mirA==
X-Gm-Message-State: AOJu0Yz94tCEflEBy0xw/N5ibqL4jtsburo//xRHYZss7kwsfM7aFWHg
	PH35zSEbX8DknzMpG4o9Kqc=
X-Google-Smtp-Source: AGHT+IFD3iY1F2nxv95bN4MI4a5W1jNA8PhHNMDLlJAllZ1VhUXhVMAWTwyJ1l3pM8GZtT2Gs1Ql1g==
X-Received: by 2002:a54:4492:0:b0:3a7:c13:c8d1 with SMTP id v18-20020a544492000000b003a70c13c8d1mr23004058oiv.17.1699065894105;
        Fri, 03 Nov 2023 19:44:54 -0700 (PDT)
Received: from localhost ([183.247.1.252])
        by smtp.gmail.com with ESMTPSA id w19-20020aa78593000000b006b4ac8885b4sm2110862pfn.14.2023.11.03.19.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 19:44:53 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	haoluo@google.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH] bpf: Use E2BIG instead of ENOENT
Date: Sat,  4 Nov 2023 10:44:44 +0800
Message-Id: <20231104024444.385484-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use E2BIG instead of ENOENT when the key size beyond the buckets size,
it seems more meaningful.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 kernel/bpf/stackmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 458bb80b14d5..b78369bdec8d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -570,7 +570,7 @@ int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	u32 id = *(u32 *)key, trace_len;
 
 	if (unlikely(id >= smap->n_buckets))
-		return -ENOENT;
+		return -E2BIG;
 
 	bucket = xchg(&smap->buckets[id], NULL);
 	if (!bucket)
-- 
2.34.1


