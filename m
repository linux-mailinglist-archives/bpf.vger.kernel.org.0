Return-Path: <bpf+bounces-57038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F81AA4A8E
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 14:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210803B7DBB
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 12:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0E238142;
	Wed, 30 Apr 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkVd42jG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8A18641
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014625; cv=none; b=d7JH4xfY+gx/GVXPI5n8l07qy8Q4CpcjopA2RqCcW+HA4hbEQsPmloAdQlW+j3NywtkS66aZ4644ksq7GHNvk5l2jB69MkzMZiw4t5ARf3f79CDsOW8fpc1jGr4aEte/udYFRjSej8k1zwHVx+yHQ8JnDtJVAKsDL4tUY1v1II0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014625; c=relaxed/simple;
	bh=TWfkum55n1yb6gyV2lIRI1z2ThNT2jYrexUNh5mO/D0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sS6ZVxGPpjoAzsgZ+5N9/2WCCal8mH5nE3qRgabmM/XQJ15oHDupWNcXXwlE3inAs6VvSbvM4vNCdVTUaQqoPpjy52WU436Zjb/aTzVJM0CLUE7StpQMQLRxhwakMpV1lVDedvZxrTtst8GYC5scpqRwiCw3ESbEG/zKBjFKpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkVd42jG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ace94273f0dso10685366b.3
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746014622; x=1746619422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrfAVC7Aral4ED2A1WZ5cskOCgd/3CbI9D9Mwasw5HY=;
        b=WkVd42jGazWCAcW+2EgqAYXA6GMnhRB0pPeqV1aZtTsc6S5za35WSj4vEdAMWF4aGN
         XqoB4b986an8WtUWZQWX3ZN9QPKQ9QhBIvORlhD7edy8H7Fi5R2f7ZgyVKxQzHyiYE90
         inY5flDmDL2AmAwxpUqYfNw2JI6vGFU6dO2D5rtzVhysANsDWj8We+oDSPw+Nllp+L35
         J0KIz1cZuBFAriOu14R8ZqOLE13adFIdJP9Q3Qv89dDF6VCWUdg/bYYT3wvjVGuSiIX6
         NSIVAv6DF+QCQXiNQydpAGwWp3CzJs21eA1A5enZ1K5mTMooHAqkrQiF4j7ucknTvCGE
         kLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014622; x=1746619422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrfAVC7Aral4ED2A1WZ5cskOCgd/3CbI9D9Mwasw5HY=;
        b=mfoHdzOWIU2OL5pFmaR9kYgEtnKxhyX0awddwJ2oE7aWVVQXZ1JF8oKucRAE5RSzcn
         6Ym7Zpb7S6vgOSEG2G5mjWqzCroez/gMySWPIqaByG3lT/xI/+FBHOkvVZmIuv7OkuqO
         C95lIArzdBNMT6TrfdfkFZfAUjSLxCSII9oyV4qKBjrZ0NMHt6WJiZ5o77Xwlg9SFxtL
         BscdBW5l19ACW+86rnXY2tPeuB9tuxHAzTczQqw4HjnHvMY2+01i7kJaEZ6SEMUHJLG9
         6vuTgG+68lTQHBYCuPsUj1zk+3BVJ+QvqqMxlPVOMxZBzqNI/dBOe36vasXmJhIkvBf6
         Kgbg==
X-Gm-Message-State: AOJu0YxBpRNPgOtrJmNGiUUNL8cxV9aEGUewcjv5Suajtu6E3DmuP/2c
	t93eiTg0lyaVHkRP7WScNaKVdiOzVEYrp8bbsIoa7wA5ubNO0+2HYHICrg==
X-Gm-Gg: ASbGncsCQC9aUlUSvde9+hgUW+/3avsr7lkspprc347Pg5TXylnJlOmpYyirxSxtcZz
	eBgw0jkfRMgbjH0MkHIZyCKTKlU591TEpTPdo57ZxXe5Ff2FwMD5ZbPWHAd4AhgUebmxBYEkkRO
	i+sIJB3JIEL/fe5PVZIo3rsops+07mfUl/MbqrBomK/HNl3GpP5Mm/4Abpyyonok6uKvMlryB59
	mmrxlINXzEgTc7sXOjNebDPDEJ2m5mnS+7phSOGAPM0C+GVXF9vn1SEYODqRiuZAnjcyBlgLqNH
	ZtmMyjPNy5ewviqUCS7e3GX7iFPR4K8WEPlbFKQ/j7AVFIzgRKWMqRpbiT94bevulc6MoOs=
X-Google-Smtp-Source: AGHT+IFXznvTdLXVy5CCconwhzoFwH7YNsDVOa0JPaX3ysXJdkuR74mT7TmebEHjh8+DhEImm0kIOA==
X-Received: by 2002:a17:907:3d89:b0:ace:d442:e39f with SMTP id a640c23a62f3a-acedc658dd6mr311629166b.33.1746014621602;
        Wed, 30 Apr 2025 05:03:41 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7f81f4dc1sm3758316a12.5.2025.04.30.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:03:41 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v1 bpf] libbpf: use proper errno value in linker
Date: Wed, 30 Apr 2025 12:08:20 +0000
Message-Id: <20250430120820.2262053-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return values of the linker_append_sec_data() and the
linker_append_elf_relos() functions are propagated all the
way up to users of libbpf API. In some error cases these
functions return -1 which will be seen as -EPERM from user's
point of view. Instead, return a more reasonable -EINVAL.

Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/linker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 56f5068e2eba..a469e5d4fee7 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1376,7 +1376,7 @@ static int linker_append_sec_data(struct bpf_linker *linker, struct src_obj *obj
 		} else {
 			if (!secs_match(dst_sec, src_sec)) {
 				pr_warn("ELF sections %s are incompatible\n", src_sec->sec_name);
-				return -1;
+				return -EINVAL;
 			}
 
 			/* "license" and "version" sections are deduped */
@@ -2223,7 +2223,7 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 			}
 		} else if (!secs_match(dst_sec, src_sec)) {
 			pr_warn("sections %s are not compatible\n", src_sec->sec_name);
-			return -1;
+			return -EINVAL;
 		}
 
 		/* shdr->sh_link points to SYMTAB */
-- 
2.34.1


