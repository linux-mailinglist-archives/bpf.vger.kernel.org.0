Return-Path: <bpf+bounces-78200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5DBD00D6B
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A63543007DA1
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ACF2874E3;
	Thu,  8 Jan 2026 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfoNNMsO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0729B78F
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842240; cv=none; b=OVPieiZY6NtpS6NTP2S8GcuFSIIPLwo+fuLwGbkM5hEKRc0ZchCm/r15T/W06V8E6L2FW7MjCFKsytZwtNu4kOdN52ELPovV7pm2MPH3C8NXplYXAyFRcE0/WmDJ/sgUFenrSBfw2hXlJLYfyP++1Ph28NB5Nq5x+k4KMdaaLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842240; c=relaxed/simple;
	bh=PP4UHGdg2aJ+7TetAPvJTrpVWwYUmJgFr04BIdkvHYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXa7noi4Av4Sdca5If4K/DsyU0VgsFF2v34alxfHu5LQGIFHtpex87x+86CvX8U2Xrm2IqsBp8a0XBAUDyYW1E9CzIBzI/LS8uhSObej0Funk48hdADrVwwmWQQbym3ijvwrukUGHFH1l0d4UbCNaCBjN1OUkMChcgF8rz4We6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfoNNMsO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81345800791so1599197b3a.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842238; x=1768447038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezrrIGR+HhUrN/b6TeSbq07sIHXRwZZn0egYDAnCwYw=;
        b=KfoNNMsOjUVXb8eTTTYd0BPk/4HMV6Fvo3SrstX2GXiq+FEpZu+KrG+ZpZm6Vdn1jR
         NR8S8P1wznI/0LhVXR4MIC959jczqr/FKO+r5b64+rumGZfMIeejUJIqYwJMYqe6nvwe
         TSueHq32sdVYE4F46LihYLJGwDiedODxyEYOfvyuFXPcwkw+1olAWjYhX05OYOjlaefd
         CE4AXOsByi2JLdgHUl14A9x9MOPLOQS/F2YNT4J45LemFANCPcsRkWcQU7mDhrN6e/u3
         nMXvpXOJwwAOzFDbvt6P1JQj0ByIhNZnGAFy+QI7mC60k3hhOJHA0eA5x4papnN4y2D1
         cmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842238; x=1768447038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezrrIGR+HhUrN/b6TeSbq07sIHXRwZZn0egYDAnCwYw=;
        b=G2jF/B/WPdEWWO1zStpeiLMq6Z/DBA+HYyfb+ojMUrYqXatlv5n/TbKPJRm9s795vy
         ymYCLImerdGY4keGt4iTZ3vyYW19MQ3WB+iA7bZpAHJzb/3KDarEtmAnG5bjG+9I4M/e
         3euMKl8Mx/R7BtsAsl0v1alLH55BTi+YjD3TjhzCmfuAMiuEf2A0fCCYaN+JMriXXpuN
         3Q9Hcs+B5XzmTL2OmHdD2TATLwK7BOMz/MnUc/fhWV+AF2h0wp88TtnV9ggcCI/vAJdr
         HggUssV0rJQ+JgQ5fXFGagfN42H30PlZwsa5CyFxQV0rLXZD8pLNe/+GndfTCI0x59CT
         D+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWMbvqePaBmm9qQl4PxxnhmCoh/orryyg2qh6OGyeY9G9Kk0wRyjJvL1BMSErnd+VYs72k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZduOfY6gV8FAka4XQChAG4kjx/R+cpuCQCS729xr2MlcwatD2
	jBVf32oKYxiRJB73KBRqyaFTqKyllSTr4hvRDBsSaeuexr0G9UKwxRa8
X-Gm-Gg: AY/fxX6fcfuu1/dnyVIASMeYDvKeNiEcEvCzGn/ONrhc/IPcbadsC8Xmzd3olZlwsO5
	6OV+clVkvVY66N3vixhKuAYRqYb1z7EvH/Pi4I9vi73oypLZQO72xeeWIPm3eaVmB1phOiHZw/Y
	Z9uwMFGcXcwPlL6jC9F13xXKgnq8WnJtUv6dOF88hjUvA+lmNpgnrnU5suWLodaa6uAMLFHh+Km
	HS/ug9a5Q/OEE0HPeHoPKY8BurAowvy2l65NYETkAWfJIpiZEuvcQjOd1Ot1ZxLgUHOjy4s6cJb
	kbA9S/otR5ksFxf2gn76r6tFW2Yi68DZct9uQR4XA3r0O/oS7xfJvjNG/plHcoun8gDSMBo9Flf
	wnmx6sAi7PIRWy/b8lRrQY+O20eGI6fCFIJ9bL0Ve4L5b7mrTMwC/MOUMQzbtR0hS05IClpGmmr
	v6mACETPmsyka6c6ubYfillEXDc8Y=
X-Google-Smtp-Source: AGHT+IGY0XC7Bq8fqaZyOgdzCEy410IYyQ5e1LkQWO+noXZVG+1d+kqt88x9yfkXPmR+LBtS4d3txQ==
X-Received: by 2002:a05:6a00:27a3:b0:77f:4c3e:c19d with SMTP id d2e1a72fcca58-81b7d262421mr4602120b3a.12.1767842238330;
        Wed, 07 Jan 2026 19:17:18 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:17 -0800 (PST)
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
Subject: [PATCH bpf-next v11 09/11] bpf: Optimize the performance of find_bpffs_btf_enums
Date: Thu,  8 Jan 2026 11:16:43 +0800
Message-Id: <20260108031645.1350069-10-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108031645.1350069-1-dolinux.peng@gmail.com>
References: <20260108031645.1350069-1-dolinux.peng@gmail.com>
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


