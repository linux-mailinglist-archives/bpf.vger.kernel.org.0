Return-Path: <bpf+bounces-76266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5207DCAC2DA
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 07:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 418123086E89
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 06:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B7314A7D;
	Mon,  8 Dec 2025 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRq2ZUIy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FEB314A6D
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175073; cv=none; b=qmQU/pMqgUXG5ZTh6Q16QgdIUYC58KHUAppaQX/wwChxyD4hMK9PeaUkR9cLFDcfCPGtWRDtKZXzUbMbKFgc3aboyRAoP8ZAQ9GXIfxNeRSU5lv1v2rPge2P+0QZPnSu5N1NM3q6QrtvgPLNHR7Wx033gTEj6QHka6faZp1ziX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175073; c=relaxed/simple;
	bh=n+zH9plFFMUYGIEcY3wzYO3Lyz+b74AkBCCdAEyYNdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rO37sezWgquHQ2JPKNGIKl1cbTmh5JeaUO5RYwlJaYjP4zWq/2oZSXzxELc0kp10Wivwcmi+AB6HQ6Zs0qHNk3+1uC30pZmOT8TUAvqTkht6qOPP9UJwEMYTmNwk5Ykpn2w+mIN7jOZavHFpRwjeoUdWvmTtE0iFqm4yNwS+jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRq2ZUIy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2956d816c10so47927385ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175071; x=1765779871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhW1CqQDAMm+jon2EpWEcUDvYwGJtYovETBfwMR4CKg=;
        b=FRq2ZUIytvXvDl26mA7isN6ZU5/nswqMrx0c+aN/gElKSswZop6qpecrd32cwrL+Rr
         s5vcItJdZpbNzPPujX2nV6pbhRKNO0Sap+s+DfeUjb0PBEYLUlEzFhJfyhu4/dEgNGQU
         L6JHt2TA7rMjdHgw2aMCPDcCVrXEE7llRwMjXu11NeZeR/Fb7HUok4P/KvOFhLlirruC
         H3hor+9zJF8Oxi5NyVucW220Y4CN3+DxTYenBOdttrKCFCMYU03MmwXXbXfauIsPW8JS
         pzruoIMdN2pzCmnwnsj14OtDAMN9eFoqVTS7IRCbK1yEiSiplI8vcGGzKBPQjGxVphp6
         88yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175071; x=1765779871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhW1CqQDAMm+jon2EpWEcUDvYwGJtYovETBfwMR4CKg=;
        b=Q8sNYd3x+YSAvp5keZxcJAwvRwMWG+r0Bgc6yYjFc3yPamtMckA+fuaUwgNJGJt2V7
         PflnKNkdRSrLJU2TTKZ+NVYrCV+pVM4MfEZMGQqnA828IvPp5VIHX3I/OosEx++aivAz
         QbMcyl1dRRr6VRQ8UEcWnOTGuRcZ8PBqXMCqpS87H8/TzYEouN5Y0w8MhIB5oKid02GU
         CF8Wb21nbNug7uQOWIQkMy+dUWXzALAWvRcL+SfkpoWtLG5GAbJBuioTIyneMOdLeqKI
         F68L4jN7ksMN9OhXgOip+S2gnr1gr00Ftkx+/UG41NGBq6Ipbebfe3ee6VvgdUHD6SuO
         gh8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhWSFNkcDE7tgLGBw3O8RT1L8M/sF++2pXBBG7NLbWPFAx/m0qzHKWpoYL0erZ322yZAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57CjHqCTgcQv4OX7zTGOjW5D+SNtQ//jR/ZNAwX+qrRy3D9ol
	ufCJNdhwdPuWK5ZQ02uzu/vxrzFvrKusDrFeEwJpWAS90AUsft/IyoMr
X-Gm-Gg: ASbGncu8aOdvqa1fDsFEmyjQxdIMf7GrchMSi7p56vzH8mVLeiwmo5W1rPcAzHJiOEx
	J9QX8hL5CrydmPoP2W+kbRgw4I5Uqr5YnNp9SDU3W/RR3Lktg7tKXiUdTnbomzMhOHz7qBaBr1q
	/0TZVk749+W2Sl3Ch5eopETGDg17C/iz737/zkjVtiF0y40yvJ4AJ57d+IK1UKAlKc9fEzG8XTD
	2xXhu/lKolRQAmYvVzrS4A2Hs/ZUryDrNWF8YX+SM9+MobNjT9uvVcAlbshE6KtCEb7gRovKWHo
	5uEjJm/oN80VD3A7Oham+SzD3M5QOUJoytUlzJOpWd0hImZJhMvvl80p7GChxC+4UitV3h9gJS3
	kd6mK1Yehosj6bWlH/l7/9+PdsN4yn0jxPeO+M2VllC7ZMN4ZhRO3J6T9J159uBsS7X7m16MdPG
	kIwAXlHOKzkuXNZBAQoSbDK9yRjC/ag+8HJH5sOw==
X-Google-Smtp-Source: AGHT+IFsht3tx4iyxceDrOoGzxGYBI5zLO8cdj3CemmPxNI1cuQpObayIm/IsNw4CmeT4+GU/dZGgA==
X-Received: by 2002:a17:902:da8a:b0:295:2cb6:f4a8 with SMTP id d9443c01a7336-29df5e0f345mr46986745ad.51.1765175070919;
        Sun, 07 Dec 2025 22:24:30 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:29 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v9 09/10] bpf: Optimize the performance of find_bpffs_btf_enums
Date: Mon,  8 Dec 2025 14:23:52 +0800
Message-Id: <20251208062353.1702672-10-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208062353.1702672-1-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Currently, vmlinux BTF is unconditionally sorted during
the build phase. The function btf_find_by_name_kind
executes the binary search branch, so find_bpffs_btf_enums
can be optimized by using btf_find_by_name_kind.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/bpf/inode.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 81780bcf8d25..781c2c3181a4 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -605,10 +605,18 @@ struct bpffs_btf_enums {
 
 static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
 {
+	struct {
+		const struct btf_type **type;
+		const char *name;
+	} btf_enums[] = {
+		{&info->cmd_t,		"bpf_cmd"},
+		{&info->map_t,		"bpf_map_type"},
+		{&info->prog_t,		"bpf_prog_type"},
+		{&info->attach_t,	"bpf_attach_type"},
+	};
 	const struct btf *btf;
 	const struct btf_type *t;
-	const char *name;
-	int i, n;
+	int i, id;
 
 	memset(info, 0, sizeof(*info));
 
@@ -620,30 +628,18 @@ static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
 
 	info->btf = btf;
 
-	for (i = 1, n = btf_nr_types(btf); i < n; i++) {
-		t = btf_type_by_id(btf, i);
-		if (!btf_type_is_enum(t))
-			continue;
+	for (i = 0; i < ARRAY_SIZE(btf_enums); i++) {
+		id = btf_find_by_name_kind(btf, btf_enums[i].name,
+					   BTF_KIND_ENUM);
+		if (id < 0)
+			goto out;
 
-		name = btf_name_by_offset(btf, t->name_off);
-		if (!name)
-			continue;
-
-		if (strcmp(name, "bpf_cmd") == 0)
-			info->cmd_t = t;
-		else if (strcmp(name, "bpf_map_type") == 0)
-			info->map_t = t;
-		else if (strcmp(name, "bpf_prog_type") == 0)
-			info->prog_t = t;
-		else if (strcmp(name, "bpf_attach_type") == 0)
-			info->attach_t = t;
-		else
-			continue;
-
-		if (info->cmd_t && info->map_t && info->prog_t && info->attach_t)
-			return 0;
+		t = btf_type_by_id(btf, id);
+		*btf_enums[i].type = t;
 	}
 
+	return 0;
+out:
 	return -ESRCH;
 }
 
-- 
2.34.1


