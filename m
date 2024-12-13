Return-Path: <bpf+bounces-46839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 394219F0CF9
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA087188B387
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F31E048C;
	Fri, 13 Dec 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="hHde/mGq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FE1DFE33
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095272; cv=none; b=fOmcTSI+o/X5o4rWLj+pl0nMHV6A8yW2rqg1BKYXbxSu/7qdNGEB3fciPFSvnHWBxVXDV3BLEaguT9F5hCGzGEEfcfxAmBZJWVWVnbD79h1/6krVYqFI3pTO6pT9134sgd6CcymuQDOjofgYS4Gfit4wTXEUyV7WDWVSvejxRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095272; c=relaxed/simple;
	bh=+/YV3LZEvdrLstTwIbRQH9IjxWegL++A18ur96ODaSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G40A4N8LVynADONiAlfzdwD2t8M/huKqeHtCoFe4T8/uY58DLdHRZ37+qluuN+Z3R4lifUYTKRw1C9kAPYXYEoSA4foI5y/N8DQQTyiKepjbvTv8LPQy3EZKM5K1VDG9MJs+had2X9x495t1vTbqTMzBAkYWCrEUF13Kuac2VyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=hHde/mGq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso3168633a12.2
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 05:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734095268; x=1734700068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUqgrNHY8InItfuxCjxyR3kyF+5UsTOJ6US2icmaWz0=;
        b=hHde/mGq0IJTMEBX0aLyE4qnh+0Wmax6ueQdsk6PkVFGU3f2kOVEHXchUO2Lc2zsBq
         nDaVm4zQIuhdtVoeVc4G3TTq9FYP2xuWqXFTYNZnt82kQEnTdPVOZRbDqnvJt7Qjr5R+
         KWpogWNdD0A8TLIM0UxP5Cuv7CJfeIv4I4dDnSdBC0MNS/iYI8kLUo/4RLjCl4X25OiU
         NpKsjT1tdwjncqILsezS9Sfh/idatwCFt8wTcW1X6Dw9QMSSpFn0vJlkTPLbzLUmj7Wj
         IAWe+LTniLvduzPiOvPaBLFQjUdeMgGugT5lePa4rAQl2zVl0tLdme32aSdRUe2lLkA1
         LNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095268; x=1734700068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUqgrNHY8InItfuxCjxyR3kyF+5UsTOJ6US2icmaWz0=;
        b=WIaR4Zx7KmGVy11ru0m90tDYMtS7liOQu9hpS2d9UY6QfoD6JtLRF+Te9nM12miKuP
         B/ck1TdQKJAIdF/XDgFgN5RcP9KRto1y2ZPg04+xYTamC8CSIIodUmVcpgdlBTNuQGIM
         hQznoIU2lk1PNuodmyrGM0WV/RoBa2Rohc6npH1/ig+fA16fOd71KST3zH7QQfylUsfc
         MjcU0QhhhqVHtM7TUWC4ZkqKmFqkkx6ySBdcyca+94ibT2eNDI4ix8EKmnVipOm1g9V7
         ZwTgxtm24ZH0XaiY3Wxs6PfvuB+n3O31QielS24yp85cesNUPM66pTcgvnnOq/Zbn2Om
         NTjg==
X-Gm-Message-State: AOJu0Yz7jkA6KLOXjfnWFtUGiA/8xh8UKDMc9znJcV16OZNHydIlddCX
	TFFFSxvbC3JhJLQg3TgwRgS0BVOZ+FLJ33AFhLkLQjaQzjK1qjHNEkpBKAtMV55OdG8MwTy7wTL
	I
X-Gm-Gg: ASbGncsvI19sVcbg5WZ2vGqYoWDBe83Ny2qFSRaV3tiiMvPBx68GX24aBNbUBmMCJiL
	juQvpXTYukai1eSMOb+aJqRZQVL1o/AAjQ7xFfB/W9U0LEcjekOqiNOi8PR2K/khO4owIGNG1WG
	SX+HvfR2yB9DUXdoHtx4wZPNGDxL9Q2Shm27p33HTPBo+oiVb2Edid8JIc0O/e84Trkjc8UqRdZ
	BDbKrHz76b8ylNFzZjWPVvR+d57TJWS5D/ATekAA3S5+TJCdHD/zmTEhoJK7UldgvBRxA==
X-Google-Smtp-Source: AGHT+IE/drIVHKdgezvfSjfDLlu0I1ttEHoyyibrptaqRXpGau4LCoViH9BrVD7Uusdy7OTYIcncXw==
X-Received: by 2002:a17:907:9816:b0:aa6:995d:9ee8 with SMTP id a640c23a62f3a-aab778c22dbmr283219766b.5.1734095268103;
        Fri, 13 Dec 2024 05:07:48 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa657abb2fbsm931248666b.128.2024.12.13.05.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:47 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 bpf-next 1/7] bpf: add a __btf_get_by_fd helper
Date: Fri, 13 Dec 2024 13:09:28 +0000
Message-Id: <20241213130934.1087929-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213130934.1087929-1-aspsk@isovalent.com>
References: <20241213130934.1087929-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper to get a pointer to a struct btf from a file
descriptor. This helper doesn't increase a refcnt. Add a comment
explaining this and pointing to a corresponding function which
does take a reference.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h | 17 +++++++++++++++++
 kernel/bpf/btf.c    | 11 +++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eaee2a819f4c..ac44b857b2f9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2301,6 +2301,14 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 
+/*
+ * The __bpf_map_get() and __btf_get_by_fd() functions parse a file
+ * descriptor and return a corresponding map or btf object.
+ * Their names are double underscored to emphasize the fact that they
+ * do not increase refcnt. To also increase refcnt use corresponding
+ * bpf_map_get() and btf_get_by_fd() functions.
+ */
+
 static inline struct bpf_map *__bpf_map_get(struct fd f)
 {
 	if (fd_empty(f))
@@ -2310,6 +2318,15 @@ static inline struct bpf_map *__bpf_map_get(struct fd f)
 	return fd_file(f)->private_data;
 }
 
+static inline struct btf *__btf_get_by_fd(struct fd f)
+{
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+	if (unlikely(fd_file(f)->f_op != &btf_fops))
+		return ERR_PTR(-EINVAL);
+	return fd_file(f)->private_data;
+}
+
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
 struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..2ef4fef71910 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7746,14 +7746,9 @@ struct btf *btf_get_by_fd(int fd)
 	struct btf *btf;
 	CLASS(fd, f)(fd);
 
-	if (fd_empty(f))
-		return ERR_PTR(-EBADF);
-
-	if (fd_file(f)->f_op != &btf_fops)
-		return ERR_PTR(-EINVAL);
-
-	btf = fd_file(f)->private_data;
-	refcount_inc(&btf->refcnt);
+	btf = __btf_get_by_fd(f);
+	if (!IS_ERR(btf))
+		refcount_inc(&btf->refcnt);
 
 	return btf;
 }
-- 
2.34.1


