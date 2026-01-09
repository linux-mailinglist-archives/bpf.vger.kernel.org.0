Return-Path: <bpf+bounces-78323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7248AD0A299
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C401303F4D8
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69C35EDA4;
	Fri,  9 Jan 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQza34Pt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837C35E555
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963638; cv=none; b=EgJnrSpIAvwN5ZDxSs1ZLmSefArUESyz0R802o9ulDnl7DKFFRelh4j2MflQwR8bJi4iJnMNpN1IPaX3nFlBSZN1n78XOgEiVU5RhuwpzViCt1PNrNhg6qOn2qpp0QjQPhbaP8682l207oz3VfS8XSL1l91iEGL4W8LxzNo0Obc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963638; c=relaxed/simple;
	bh=PP4UHGdg2aJ+7TetAPvJTrpVWwYUmJgFr04BIdkvHYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8FTtWRNbjY+TeOYeuV9QSg6dVkXUa5GzWMVAcFGNxW7HoB/HKuT3QWO33I2w8AC8T6o7T0tPF5EUrO2TfafUXKR6mtRR9B9pueGsthGI8uPzqOVUrLZUHT7Gz09RhRYwuXJbGJPmvowpkXF+0AfG3QSPbxRUCLuaxuostgBBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQza34Pt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso31965845ad.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963637; x=1768568437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezrrIGR+HhUrN/b6TeSbq07sIHXRwZZn0egYDAnCwYw=;
        b=dQza34Ptgfm2HLpHyY5vPCUu9swGH0zgrOktnkOxtIc6DeNfanpblZHb784Q9tERkx
         KVVbgGOff2DfFMli0Pq+vkLTFToUg8HG7iVueYjnIB7s/dcsdkA4nKSF4iJDQHjuueNT
         PY4nC2+B5Dpd5ueZtTKCysUJAaCYtsN24Cn7jSBhIlSDzM5EVCQXvSrzcnJG5lapMMdY
         Gj4eBWV6PJlcpSMn6XThIRXUiq907O/uhhUfdgYIEO/S9rE/DB9/v1005TwW1plsyBs/
         aaycURpzQSW7OZZf7mtoJZWjzbZyKkU3ekbULW2z/K2SBrJa0FXmygYSx4o09GWp0LmY
         hbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963637; x=1768568437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezrrIGR+HhUrN/b6TeSbq07sIHXRwZZn0egYDAnCwYw=;
        b=YK4kfYRrfohKNk1nPL8G64YJSrF2uTKP7VRf3vbmvhnWiVlz8UkpbqH2RIj7tYseer
         mHbsMg15iEW7ex7PJJ1ve8BVCQHJ/61BCDuaqVvt4G/orPmMTpCg34Cx5aFBnWOnxlxX
         sWZiQF+KnY+Xl09mncAySQZpPTDLw+YYFqr4odMBjz7o513H/qlZYYz1VVBa+IXZtWHs
         p0YStD8A01lNsQZWU3t4O39hAETItLpIbTbMhzU1c//7t5vh2Tfett7Rbes7HMaN5RAS
         UyyiHB9ycxD3lvDkzQaN0aU0ZVp8mkL8DgNswQ7QeiE1UqfvkGenvAuWVr0heTvWAHdw
         PeYg==
X-Forwarded-Encrypted: i=1; AJvYcCVffLEsPcB2VhygKaYxWYQkfu2DDcD2WYn8/JFEgYEmdT0Ee8lar/Dck7KSOaCn4DDZ7P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxncfs7npnYSCff1MYdGvQkB/izf5ktJliOw8XDgckq2NBaOeIk
	J76LHVju0Qoa245p9gFNnASNs9c8wIjgfqJqBkW0+4GrP94ckKJrrrba3rfDOl4CnxE=
X-Gm-Gg: AY/fxX52grHon0lhEK4ajI4TnN3i1Mf9oHViQCZ5AnpO+aMAKL51lp8jXJMqk83Th+l
	sILYFXDbBf33hY7w7k8wMQCZJJZk+Po1AKw5ldT2s5KU5Q9Ji8r4IbTuvjSFqIVHkcziFHYURLO
	U7DTxGy52jdNCdpGznVziiacZAIvYnWykPJl042T2jWCuU+TdtkdiwpQo4PBHXJe1v7nrtxYMFi
	rSazv5fwP29DBW1zlXlqiAIc0zLQYzQpYgK6r2i2p6CaErYE9OBeKz2YpvFOtR0hzEI56sFnfxu
	6OxHtN8v+1q/q1NpQru1IjgEIChv930g6ifWg2kc6fwuhYOFI9BKTuVURFE+HBCXtDcE3A0p4WB
	yZbWWP99kHjDYDe2esfGTUuqwuMewCTegHLc+3FhczLJvdBUGYHszpQu0wnIzyQXfPBFoObtgge
	6V298pC58dJ6PG0oaKk6JT1/9CRVI=
X-Google-Smtp-Source: AGHT+IHGtBK/QdskngOI5OKlKsTDyA39yJOP75NjonrZNih/ElHm8DB77Fgzhggt+tCVfNovhyx3wA==
X-Received: by 2002:a17:902:cf06:b0:2a0:d662:7285 with SMTP id d9443c01a7336-2a3ee33e1aamr97569295ad.0.1767963636166;
        Fri, 09 Jan 2026 05:00:36 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:35 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v12 09/11] bpf: Optimize the performance of find_bpffs_btf_enums
Date: Fri,  9 Jan 2026 21:00:01 +0800
Message-Id: <20260109130003.3313716-10-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

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
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/inode.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9f866a010dad..005ea3a2cda7 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -600,10 +600,17 @@ struct bpffs_btf_enums {
 
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
-	const struct btf_type *t;
-	const char *name;
-	int i, n;
+	int i, id;
 
 	memset(info, 0, sizeof(*info));
 
@@ -615,31 +622,16 @@ static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
 
 	info->btf = btf;
 
-	for (i = 1, n = btf_nr_types(btf); i < n; i++) {
-		t = btf_type_by_id(btf, i);
-		if (!btf_type_is_enum(t))
-			continue;
-
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
+	for (i = 0; i < ARRAY_SIZE(btf_enums); i++) {
+		id = btf_find_by_name_kind(btf, btf_enums[i].name,
+					   BTF_KIND_ENUM);
+		if (id < 0)
+			return -ESRCH;
 
-		if (info->cmd_t && info->map_t && info->prog_t && info->attach_t)
-			return 0;
+		*btf_enums[i].type = btf_type_by_id(btf, id);
 	}
 
-	return -ESRCH;
+	return 0;
 }
 
 static bool find_btf_enum_const(const struct btf *btf, const struct btf_type *enum_t,
-- 
2.34.1


