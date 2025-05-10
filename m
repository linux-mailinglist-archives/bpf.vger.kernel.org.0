Return-Path: <bpf+bounces-57982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC7AB24E8
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 20:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71504A111B
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C51D7E52;
	Sat, 10 May 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX9ZS34V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A41552E0
	for <bpf@vger.kernel.org>; Sat, 10 May 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746900972; cv=none; b=jxYZGKp7kzfP0uT/EaY736euGRKnQDpzL5FT52UaMNLIB/Ovg8fdJvdMCxsK2lbsb/23hT3Ht3ZD+t7aYM8CIVPOp5AvLXIFUc1pjEa9IeGzd4roSzyb4k15zxTgH+5zp3LVxc5O4R5WEfdot5gPL0I/y9+8VQmB+TUt9hGrApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746900972; c=relaxed/simple;
	bh=T5XbU+6KWzC4M8jHVlT+TegcX1H7aOqQipzDrBsER+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NOyW4ycN/TBnyjUqe8RTE4XWbm1jfDQbFavfJEmK7L5XK1xjcWmNef2fNdB62fkJJ8MNymkx+jp6Xd5yN12WUNQ543vnd4LskBXhToe4/qMtg9OO730SLsGwYJFB7H2QZUCsEjKAjKHGCLEI8ZU5VZRMzGPK+pkLnDyHd3LE5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX9ZS34V; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad2216ef31cso268802866b.1
        for <bpf@vger.kernel.org>; Sat, 10 May 2025 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746900969; x=1747505769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sk+K6g3TP6Ovtzr5rVi68SwvUOVK4EZ5PhGpw0WK5QU=;
        b=gX9ZS34VAyGfWUg4zHNbyvu89NhS2RMCGUpmQgMuUwj8GN5SHKDUogFAF9/bDQ2FBT
         npxqu3II9YaZD5p6Dwr6ATl/lhJAucs3nwFvnapu/FWKU913pTsdiapKroz73yfjXbxd
         7uWopy7vV1K34Wdigs+q886LkXzrbLN/itNhX6wtdYKa1mHDHWh0ubUEqfwj67WWhI8k
         b0uCOCDCzJZbjX8d64c76Z5oQBV+75mOKwmMt7FchkLu9lJwAlo2VLJCjXVs01Yfb6CP
         s6xE0pKPYZRAqAyQTm/1gLWjxRHUnEpaS/IE/DqV3ugOiCBMzAWCYzSVSx3K07S3pXz1
         jYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746900969; x=1747505769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sk+K6g3TP6Ovtzr5rVi68SwvUOVK4EZ5PhGpw0WK5QU=;
        b=VBTdBtZgI+WQ+P0XfEjy/YmoZ1VlPWw7HXdCdvP32aOC8CkHdzG82GAwASaNN87ea0
         OJoI501CXFDiXWGG8twH7axlObxU5h+kSpfiEJSHPQQuVlEOiEa+GuNBuEwnwzVAhWJi
         Mm7+zWCGs0br0QZTYU4SjgDDgVha8qviUgKCJI5RI4w9HchlaDI+23H4X/bpe/rpDCbF
         BUVWZRz1XEQKZ9aHi1krqKMuFJQIo/cA7OHdrEWnGKHFMXaHverRLTcsis+yW+wqb3Gv
         JzndriOLpsRUuKmOy0w+wuFXMAg59zzaCZl07RMoK/eujK3oH2cqqP9a/JB+q6+s3t+q
         Krig==
X-Gm-Message-State: AOJu0Yxc2aeD3TbAb8dZ24+ZTDEFZKUwbOHkUZL0um5Wl8i7oz2LU3Na
	cFsEW9IkFZHbzPv0voqWVAe2XZdhp+2nGNqkJuht3kSw4oXaIyhTy77hrA==
X-Gm-Gg: ASbGncuKliTtNSlxoeWrzP11AF6AyrPRsTQ8UhsSs1CpXocWAUkr9W4afI5FhVk1ExB
	hQXPBt90GQqRUvjMsy3q1tqhdmskzosrCx5WPntHAQph1riDQ5IelG2dk5THXJlpPIQ6owFSOWE
	fADB3ePXxdUAcCav07xzCTC0lcXlQTQDmCgghHlNwpiAcjD9KPpSngtGSWL5vLrAr6zEAwHVfJQ
	LiL/Li20sL46PrI3XvGWHJLSSe4vbCXaG6PcjNtkc0rkrC5pMPk6tzhNwFpDBnxn2fWnssqh/It
	th43e+n8J/mZJlTvz7TpDbwvwOU2qxGVhgR2JvJT4VNzS6tBE4UROLY00HWWHoelmZWmNog=
X-Google-Smtp-Source: AGHT+IHCRdft6beLOMlCAfvE5UcHCPF13zWAnrwALM3RnPeSzjBy2m+KqPBPsBgs7sYxhX0xzXj1Kg==
X-Received: by 2002:a17:907:1b07:b0:ac7:e815:6e12 with SMTP id a640c23a62f3a-ad219106375mr717055966b.33.1746900968573;
        Sat, 10 May 2025 11:16:08 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad22fccc23esm190879866b.4.2025.05.10.11.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:16:08 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v1 bpf-next] libbpf: Use proper errno value in nlattr
Date: Sat, 10 May 2025 18:20:11 +0000
Message-Id: <20250510182011.2246631-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return value of the validate_nla() function can be propagated all the
way up to users of libbpf API. In case of error this libbpf version
of validate_nla returns -1 which will be seen as -EPERM from user's
point of view. Instead, return a more reasonable -EINVAL.

Fixes: bbf48c18ee0c ("libbpf: add error reporting in XDP")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/nlattr.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
index 975e265eab3b..0ba527d33ce4 100644
--- a/tools/lib/bpf/nlattr.c
+++ b/tools/lib/bpf/nlattr.c
@@ -63,16 +63,16 @@ static int validate_nla(struct nlattr *nla, int maxtype,
 		minlen = nla_attr_minlen[pt->type];
 
 	if (libbpf_nla_len(nla) < minlen)
-		return -1;
+		return -EINVAL;
 
 	if (pt->maxlen && libbpf_nla_len(nla) > pt->maxlen)
-		return -1;
+		return -EINVAL;
 
 	if (pt->type == LIBBPF_NLA_STRING) {
 		char *data = libbpf_nla_data(nla);
 
 		if (data[libbpf_nla_len(nla) - 1] != '\0')
-			return -1;
+			return -EINVAL;
 	}
 
 	return 0;
@@ -118,7 +118,7 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype, struct nlattr *head,
 		if (policy) {
 			err = validate_nla(nla, maxtype, policy);
 			if (err < 0)
-				goto errout;
+				return err;
 		}
 
 		if (tb[type])
@@ -128,9 +128,7 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype, struct nlattr *head,
 		tb[type] = nla;
 	}
 
-	err = 0;
-errout:
-	return err;
+	return 0;
 }
 
 /**
-- 
2.34.1


