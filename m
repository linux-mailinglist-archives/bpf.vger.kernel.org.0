Return-Path: <bpf+bounces-76979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670FCCBA34
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF91A311324A
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CCA31AA88;
	Thu, 18 Dec 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G60kUXrX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2CC28D8F1
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057506; cv=none; b=BelQ1y3Ey9t9nApZW6HQ7BX5qFL62WwDy2ivgyqDmUsXOBIRvBv4vnRyVp6pCQT0pwxnFhcrgnwrWga5DLP0gXtKHR0daaRLp12u9AYJ/HjX+AVvncnnxQnvqfJ4YC0v34p2P2j8YF7QBvsZZPTvzFWMno+9KdbtDMsOr7oCIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057506; c=relaxed/simple;
	bh=kR3XC690eMOuMmS4XzQCFJEtC3/vg9Jkc3VHJRTqe6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKiCXAzGJvERViNfxK7Z0oXMjO9yUEIXq1Sn7fcgNPmKOasrW7QYPcdeKKW/wkps19Vy3/mNlY4b2Y35EXkzq9caZz4Av/gmq6nTEvdedrZpTIArXP2ePKVtrBo61b6WgFHdlCN0i7ht07zsF3eARj50dp5028wSObVdDqtjHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G60kUXrX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c718c5481so510889a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057504; x=1766662304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yc18LXj38KHjY/6u3XKUquuVm27qsoM7d9pTeGO7lI=;
        b=G60kUXrXcmVipswR7w2fdJfda5pJZTc+Clvd/KoaVc+Zj2mVtjpEtKk10T9RHvDg5p
         JcS0r+OyhcWz567NRcqsbRJRgvJW84ZCLcFG95pMvE6VgxtOp5TwStB10u5w50+gt2j7
         h5XXmkGAZ7Losd995OQzeTKCWy6b4I70H9aMFt0jF/EQMlCCkhdvBbMojy8SEY2VJb6e
         YyWpOenq+2w/8KMBvMr5afWVvMefC1TFsF1J21j4LIE72Ic9vET4re35rfVF1aKXDxKH
         TCLg/pCFZSDDWExNCh/51t2X9mE6zfQrqx8/n+Zl8ic7AkvtvAI7r3HGKJVCVHD/5Bwe
         jRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057504; x=1766662304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yc18LXj38KHjY/6u3XKUquuVm27qsoM7d9pTeGO7lI=;
        b=O3DSa+XJHVFR4D1/ySAiyQIKwg8m0SLAYBe6RevrI26QKLGOXoeBWP4yVHxnWSSOBp
         a47CbhkjaNxZf4wH/gh05c/jHZgoxtGfnwjJZ8NHB+YVnGb07oZn0fF2oInHjYrN+WQS
         OSondMab1GJq5++vsAzQibC7VhkFHJE1Mm4NUNGRX64vc9IVo3bl5B501xc1+ZaJzHLA
         7K7HJV9tzNM70eJJjWtFJr1gyXvyP/UPw0OdoHJrgmP3vdHthEXXG3An6w/zbq9MZlzS
         66+HimzWFqDeq6U3WX4yjF1DxKm4JOFAfe6VK6G2YIu2/w+mR1qWsvkL84h4e2lZ3oc+
         1yKA==
X-Forwarded-Encrypted: i=1; AJvYcCVUeEt6UrRt5DpGcx/EpQ7s5dgpiRYZOkgg75rqqaICkh2n6IK99kiVKISk4pMMBSmU9do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8Az6I8bv2i56SPmiVoyrkF0lhDdlmLcwF1xSBWM6VUILivgp
	pUbU/BkR1xNrYi/LRlY36k0yzjNo2qKhj3ldt0R42139GxJTd3kSGotW
X-Gm-Gg: AY/fxX4TjmRCDG8ONyZkrewrM1o5qALNGQiwAeA/bXrf3r4mH7TODh6wQxAUZdVlwVb
	FlcP6oesnvFBhVx1cTO4ahMUvcyiaBRFSnEebd+7GchpYqFjTj3qY7G62s9mFvKg0jDSys7qXdd
	YTT6Pz3xII5svoo+2Cq5ta8J3iuthLJ6H+VfMNxbjOXgwoNhc0lETPjtnqWERnKDBkjt16h/VZ9
	dJtTfmQswx4F3bE2I7yW/9gkhy8js0MVzx0MrZm8cGliw9sU3mCSH8dTSVfIQFZLIPibzafn8FB
	j3YCUCVni13LkSkpAxL5vaJA4M7hvknBJPCk1MvNFqjT6QgX1fRSX5UPN437AFQeacHgt5Ph7Jk
	GAPaFTjgq/axqfBeF8I08+L/yfQ3XJSBjilPe9KKsy/js6LisRYVQh//RUZtF+BgP+FbprOuWNt
	c0OQcmBdYKLOi50h7FmBhIeQ5epjg=
X-Google-Smtp-Source: AGHT+IE+OfV+nTK8EffSxIOlsTNKb3YIEVrp51owobhDCMyYJ7ysroRbW6Lt6cR2ARHL8vPSGTW1CA==
X-Received: by 2002:a17:90b:2749:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-34abd6cc250mr16692648a91.2.1766057504184;
        Thu, 18 Dec 2025 03:31:44 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:41 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v10 09/13] bpf: Optimize the performance of find_bpffs_btf_enums
Date: Thu, 18 Dec 2025 19:30:47 +0800
Message-Id: <20251218113051.455293-10-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218113051.455293-1-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/inode.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9f866a010dad..050fde1cf211 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -600,10 +600,18 @@ struct bpffs_btf_enums {
 
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
 
@@ -615,30 +623,18 @@ static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
 
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


