Return-Path: <bpf+bounces-75559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 558C6C88C3A
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFDDB4EC5B3
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC293233E3;
	Wed, 26 Nov 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W40X1mE1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE37322C9D
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147064; cv=none; b=j7pxwbBr3J6RqK+ideCzIcLV8MTIbm/h/zCCjyQcfnrONz2mYuDw/ZBxdL+ekhfv5Nv7wk1bkIJ0HHQYFw5zFQ4iM7rGxK95Huu5k3rfmPwnkfjPAZ6hJC0b0/a+iuhY1tkGT3WXIK048e+MQDHGNHxEbNdHe4IGFe/I+OMjNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147064; c=relaxed/simple;
	bh=n+zH9plFFMUYGIEcY3wzYO3Lyz+b74AkBCCdAEyYNdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXvW3bdC4dBOiGR81k2SR9KN/uxUnS+mbcxtt4vJIsagoN85k23euJxwEJXoAVpL7KxpMlSlU/hLP3QWS9ZVgvRTizHa3yexf1QLk3BWM4xXBc9JK5+2No4Wh1jHJ6186KvQLr5dli5/4so+7FOe6t1L/KpZj+qYv+zYk5OJX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W40X1mE1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo7648302b3a.2
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147062; x=1764751862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhW1CqQDAMm+jon2EpWEcUDvYwGJtYovETBfwMR4CKg=;
        b=W40X1mE1wHj00OK86wwq/JvcjMFvIb9GrNK94IItOm6DanbO/vl8X78KBNuGlgrkKv
         h2uGDVem9XuxbPtfuRY03Nsf08BLxdg/H+6CIIgNDLXSKW4aUGsKiXbwGJTPiPtj1KnU
         VfAZv6i2hECQTrPG8E/dY2Fi8mME1iFhIMWrQdV+lbEYYQQX/rtZKKW4whm2EYI7Pf3w
         4PgICSJz0wbijVy9SNOBIaiJVjpc//7Dxqmfa/XSatWj8QSvUygUcd5NeECbgKmf/nic
         7CAP+1ee+V0YiS4pKMFzztM+y02DK6XRV1K1NofzoGEZAVTBNHNZN7ldpBZgUIMgXNal
         TH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147062; x=1764751862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhW1CqQDAMm+jon2EpWEcUDvYwGJtYovETBfwMR4CKg=;
        b=WyCi7i6/NstHSteFaw6YjrLsp8MAqfOUP5Dyzvh2D90QwDhZNVy7kpM88Kp7kJTldl
         pXYUWfnqwNuZ93dC652c0oVwGX5FnkZdLQ+dQmJUCC5ICKvHzgw/yk/B+InZD+/zS/rq
         nZlk3PCQTQrK9Qh0QvR2HKmUB37kEqpanKkKkceUyGy89dlUiEst8rH6jJRBjHXSoWJv
         dgs32/CTU4irPSbEwwI1pHNHOXKvIDMsWibyDpo26sdCshB6qP4X0CMXhq1v0Fl+HPIg
         GE8Z1gmt1oj+VwO3oLElKNnXTFeKBB0G4qedcTbugDesVEEWYd8AljdXJ4IH0E9pgP1+
         dg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGxbeuoDa0eprpL8lUWUpfbpFXzcT4MlQyPqcgEcpP7vtmBTKJoHttPIhw87Wkx/8guV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lcZvWqfle5dQkBC8Fi3tQPA2JF96vtkRjM6jKpTKjyhhvK4K
	vxmZoF9EcyrYEeD05+Qs5MEhv6elntSukZm+ncKPueLZ464nI8+Ko/0Q
X-Gm-Gg: ASbGncs+wl4BBC+lrdhx1jMX4SXdNthxptQKSTGtFJxUsMYQLIuO0GuHqt4xTPMd0u6
	rC2+XL6x4HSlEcq8XWXmFcMYBBH5LeFA3UEIV65zTAph++1iVm9dYDhEbbL9R6pqf19czfcjw9M
	6yFpjtahhT86mik8Z8K4IJ/WeWYWFOfdVH8bVEvgf4oL4Qpr0RlG51laH5h6bICsxkyROI4Gim1
	vjR9Fafgi26XPOSBtaipFEMM9OBisPVXUtED1A6OBiZMVH3ceek5ZCy5OOJIw4pvbeBpAo0G3qX
	mI1BxRwAwUAbJdip5hhylcZw2Rzv9j2nJw8ORvTImL838hGeWQhSOdu1D3btqRGtJFsZsrAZ5Ml
	UJcnicYAiCKZdJwhZBFOsb61cqjUfVodmgVJ4rOi5UyhFvgNixrkYrizQLT/fHJaeYlyfmFSop+
	PS6gwv5KXSCf4YGkQGi9YzobebnwI=
X-Google-Smtp-Source: AGHT+IEgDYcBhYjre0eraoB995A3V+FOhafJa61gSS23jqt0ReQdbQw0qAwBnAgVbqm2O94A3uyrCA==
X-Received: by 2002:a05:6a00:1793:b0:7ab:78be:3212 with SMTP id d2e1a72fcca58-7c58e0170admr17529785b3a.19.1764147062054;
        Wed, 26 Nov 2025 00:51:02 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:51:01 -0800 (PST)
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
Subject: [RFC bpf-next v8 9/9] bpf: Optimize the performance of find_bpffs_btf_enums
Date: Wed, 26 Nov 2025 16:50:25 +0800
Message-Id: <20251126085025.784288-10-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126085025.784288-1-dolinux.peng@gmail.com>
References: <20251126085025.784288-1-dolinux.peng@gmail.com>
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


