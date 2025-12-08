Return-Path: <bpf+bounces-76267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C43CAC2E6
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 07:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90AEE30900A7
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B2314B65;
	Mon,  8 Dec 2025 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFb+6lpe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A6314A9F
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175076; cv=none; b=BYmw8engb2z8m/FvAdztL1JAeyXMzJIdfhh8zjjwLH85JgJmIpIAdzwcBgsfSetVeAevhqMzZnbwmnwBdFPcxm+YqCgow+AgHx/trolkrDQyoAjroeBcjzRyo0BZlMAOl1n7w6XBrxleMdMD9nRT2StNnkRx/g/YiW/Y5+mbqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175076; c=relaxed/simple;
	bh=aZ4yetfrgeTYuAXSDNT9Lk9SPyXMTL1bFvrnSHmEhiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f53QaggjVMVxJ7sQ+nQgviO10LtLergNBcdT0DbaXyOCSBTOXvxKwN88iPud2x9YcguEDtd45vlyU2GKE7SOwMOFNcwimdNkT9CT/A0EN6nZ/Zq2RvNbLumiGoEO3Im8AaCf+7kiXPtKkjcTwDRYZV5G5PD+ytHOa+Or4RMzbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFb+6lpe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297ec50477aso15653335ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175074; x=1765779874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTMvg0fLdGjE7sVVu3PqfAO/yQP0TQsUYxQ40b0xGyw=;
        b=IFb+6lpeYsu3pPUeyxTsfWJ0uhrGInWoiL2BTyDDuQFeXQDARrFncY4sEMgawGWjyf
         DHfmJTdgcWWNbAJHViOfyL/HTv+cse/OF9tAwmPC4INTZSLtxMemBcRymZJpZWm+74lG
         /AQz6Bks8nQi7k5nk7PHM+r6UaOOsN2X6boOjTgIUaxJKn9WAFSlP11ol35+L+GBooS0
         JagThz7kCzpjeg9w6mo/2hfA71xtg6TColeKZZ1UZ0PcDlftBojgoRWTKjiyufeMxFNt
         MWK9/aL9dd3fxsUf9FexH0OqXl1nwLg0uWjKV0HPhAt1sCzxZTg6znazWv2MiM9PAX1D
         xyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175074; x=1765779874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTMvg0fLdGjE7sVVu3PqfAO/yQP0TQsUYxQ40b0xGyw=;
        b=Olyxki9sfgpQ7ccLqneehwSr4/gD6zoW7oIYSQqAZwGvNAdXlfB5FJfSZITB4DMVhU
         fLIeGx/tYO3IDo0SZ/lNXSudvs44UlcmPanqUyFcJL/7zswyPklDT7qzIX8qidVb6wH8
         VaC7/JS8IN9zi19niwaItOPNAqC8dD9EdfzLfhn9LsDtqXx3JWNE9CxvWTxb9tL+oP4t
         tR76tTlXuF0gxQJVRrYMh6FC5OgJ3vkcUs0wdSvCxMJ2COs80mYKQOc+rhspLqjtY3T4
         mFDgBebyl9zIPGUM+oCUXSnaNOL91eEahF363r0f72Jsk+Ke1FrgyislYdQdgkttmdOC
         LiIg==
X-Forwarded-Encrypted: i=1; AJvYcCXZhWwEwIjgbHJF4uHAkdRwg8k3XFQ5VBgX5yecZ1JWg3gca7TdoSoki3/8hLyOCUSosK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oE1HzqHD+yA3zzDspU5MdhF7m8zgW/TCl50IByJhZjyRFkX1
	JrEvWGw5EoFsyNjNN4w/MkLhZ7bGey/ObQrNCUhn1Pm4Kzu5ID9wOkWl
X-Gm-Gg: ASbGncsmcDbVVWkAVZqp9223/W9A/PR1lfPHEEf1xNKL9CISsz1ON89NPeRI7zRFJWU
	1Yn6aPW8y7FXhqpUYvsBoIME0T51t04IMX8CMDe6cHm1wCK6SxNLqwM77/7E78oK50qF0AzvgfH
	dzdOPkTeoDskc4wa5UzVETpTvUt21xY1KtF/BrVz0V7fNwJj6olFyNztm1CWzNzlCd3kXlfwOcu
	RNOYO7osh+NrQKbmwGzqmBJ1/2u+AcGv9icDfzgRAB2PMir1Hoodt7diVh2f3fbtpUpkrRqtCOA
	53q67YbZttRmuMkSqngLdNCsbWafRhGOGHGp3DBwWfvgv7u5pM5vNGE4VSvCbwouWiFUROvY/FQ
	ovUKO09y7hFSiymMD50Ety24qP+DY8rQO8LCgjYNlxc0g6APNd5BaTo6d4Mpp/IQAi4KPBfYM74
	atT3aCKQaUYyRcm1VYDGnBr7UWCJE=
X-Google-Smtp-Source: AGHT+IGGZHqqBgW/F+zVLF/26I23JIOf9IQ8quQP7sidM29+pxTZMtUSFKegS5r6qu6MW13OooRSew==
X-Received: by 2002:a17:903:3312:b0:29a:4a5:d688 with SMTP id d9443c01a7336-29d9ed0b507mr118197205ad.15.1765175074367;
        Sun, 07 Dec 2025 22:24:34 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:33 -0800 (PST)
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
Subject: [PATCH bpf-next v9 10/10] libbpf: Optimize the performance of determine_ptr_size
Date: Mon,  8 Dec 2025 14:23:53 +0800
Message-Id: <20251208062353.1702672-11-dolinux.peng@gmail.com>
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

Leverage the performance improvement of btf__find_by_name_kind() when
BTF is sorted. For sorted BTF, the function uses binary search with
O(log n) complexity instead of linear search, providing significant
performance benefits, especially for large BTF like vmlinux.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index a53d24704857..6de09a5c4334 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -660,27 +660,41 @@ static int determine_ptr_size(const struct btf *btf)
 	};
 	const struct btf_type *t;
 	const char *name;
-	int i, j, n;
+	int i, j, n, id;
 
 	if (btf->base_btf && btf->base_btf->ptr_sz > 0)
 		return btf->base_btf->ptr_sz;
 
-	n = btf__type_cnt(btf);
-	for (i = 1; i < n; i++) {
-		t = btf__type_by_id(btf, i);
-		if (!btf_is_int(t))
-			continue;
+	if (btf->sorted_start_id > 0) {
+		for (i = 0; i < ARRAY_SIZE(long_aliases); i++) {
+			id = btf__find_by_name_kind(btf, long_aliases[i], BTF_KIND_INT);
+			if (id < 0)
+				continue;
 
-		if (t->size != 4 && t->size != 8)
-			continue;
+			t = btf__type_by_id(btf, id);
+			if (t->size != 4 && t->size != 8)
+				continue;
 
-		name = btf__name_by_offset(btf, t->name_off);
-		if (!name)
-			continue;
+			return t->size;
+		}
+	} else {
+		n = btf__type_cnt(btf);
+		for (i = 1; i < n; i++) {
+			t = btf__type_by_id(btf, i);
+			if (!btf_is_int(t))
+				continue;
+
+			if (t->size != 4 && t->size != 8)
+				continue;
 
-		for (j = 0; j < ARRAY_SIZE(long_aliases); j++) {
-			if (strcmp(name, long_aliases[j]) == 0)
-				return t->size;
+			name = btf__name_by_offset(btf, t->name_off);
+			if (!name)
+				continue;
+
+			for (j = 0; j < ARRAY_SIZE(long_aliases); j++) {
+				if (strcmp(name, long_aliases[j]) == 0)
+					return t->size;
+			}
 		}
 	}
 
-- 
2.34.1


