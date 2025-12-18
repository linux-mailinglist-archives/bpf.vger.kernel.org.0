Return-Path: <bpf+bounces-76980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAFECCB9FB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B581F3051203
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D231CA4A;
	Thu, 18 Dec 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqmaXMaH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31031C567
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057511; cv=none; b=ZVmqh5YxbF6nVPavVMFjbKGGna6qolAMziy1euZZ9YgftchveESVFGDAZWHHnOVIdgIEuAa2b4XNma9uBegJuGYTZcdvjqdBH/9r8ESvocUjylmB4cIk+93miXigV45QbgnvnlGKW9UTSXF52QjZFmxI6MNaTZTBxZwStu9MuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057511; c=relaxed/simple;
	bh=DwgNPmg1syV4ccxDgDErKTfXFZCSlTEFvUEnf2vv7ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFPwALwgcDsCMgXm1vte4+4hIOTMaICIOP0I+Euk0Xtt9+CtjnGIPCAS22AUALp6X3oWQc3lRLjvCpkiEkCKz9zFG2qU3oYZCbd0hWUoGkn+0aQsSxabps9+uHYIOi1S9hWw8mY6x5AXAeRx1/bP5Kl5lsD2r8khiZp7HZqrNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqmaXMaH; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so876005b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057508; x=1766662308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5jDu9JTVmvSq4bzhcZPmH/8lJ37vJ5Z3Y7dPoVKyM4=;
        b=aqmaXMaHSswLZKLRsOVxIsf00iQ2z4CL6vjxYey3DL6BFsmTe+ivhb6+qJTWtzYIPg
         FttBzmG67QgtRnfD2aqSxWybdy3up1dyoeOmcJnWmPglG8jdMlo98SHbS/QAp3wlX2ZC
         uxs29Ka+ioZUUk8K6mVoDCSI2r6T9Ltjy5Y/KGaQPpuTKJ+oWcy1I7xCaKKRbsrfIMnY
         CgNtemW8DtZ+jGv0rLfgS6QfZ/lX/mBARlXfVd7GdQSTUoJa23JZWaBL8qihQmZKa8RD
         pt7zQ00apuAItOe3xCDCLXEOR2TqVoCmF1IhDcLI5PqP7ppibGQeVX7ZgeWFIYifha1q
         Bnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057508; x=1766662308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5jDu9JTVmvSq4bzhcZPmH/8lJ37vJ5Z3Y7dPoVKyM4=;
        b=RysDGABBbUPgdFX+dvBrh4Fq3RF6R2WNKrmvnDuzLfgWGPueGcn/u/HwXZt9MUNcs1
         gS+odQtZW3037I49fwNrrumUERQ/zyycJOcBSSgrcTevPojZT4NvdTyrOJxbXLd8JKNg
         94jEkYLOlOMfemYb+yfCJmOxEp1/4SY4Jq5IQc+Jss2cCrLdJQAf6Sf/ttQ86+MXaJzD
         XuxcO396WfHMbKnl69xPCrTvNxCFgZiDNHjRUZ0OyTUQK7Ca6ptM6A74W6pgp3R03j8l
         ZV4SgJrgEPOsn9wA+pPJ2SpfEoQEDM/3zNm+qKLnNpa3qmSzU7XA/5dFxlDm00yvHuAY
         qo8A==
X-Forwarded-Encrypted: i=1; AJvYcCWE2eT2VSgig8KruoCUc23qI4dbRsYokXxEDl2pcP3odGDdyJyr8TSywEdc5vWmcZtFKiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAKF57oMWUHMAOvlRl5mYH72xdQEYPrZ9irVRQTVs/H7RnKeML
	LcPtpnOzm5UWGSwkRmRafDHRLQJcBRBZ1zGXmoqUoi8eGXxrjMZjTZyc22jTuwjErKVj6A==
X-Gm-Gg: AY/fxX5kcBT32UNf7rlz6fIJi8ZdyguXYwT+EH7ab25qt9rTwMze228tS/EAjB0bcM6
	2VzCOKdc46TWUBEoi5698AjbpEmDgr6FeJw9kQfoJwcaVFJ9Kwr13W5FAq9kN6q0WF/qvamlG4R
	j8y9ebEO9DI+cL+drIzVPMCuibY3opOh4tt04ocExYxvZDDAvh6oYQpoKAyPbmBOlRxmj/+vZ7N
	zrRvSLduNI2CX01e6l4Meiunbl2OAzTuh7XMBfGKUgEQedKBzn0xuRAkbdB8iMTZoOtjMjUWW7G
	V+MfAupOc/M3DxHWvWoqe1IyHSRx7x2hRTzIjWWeaaOfmwU3T8tR1fM57j1TKNWX71RoMVYI2iV
	cbj4rvL+W2TEGHYn0q+T+4IiBiB0uVIcCH+zUamSM472VT7UHcqeU1UrcKMu6eJsaw6q1RkmAYI
	VRRwffv2Ga7NEXxxLSKQU9rNYqqzU=
X-Google-Smtp-Source: AGHT+IGih1pBcpxyYWbt8JB2iczqZCbsKJU3zx0Wg3zNFIeEbu8D+9YIAJPSqoKisqtyqihlEVUPVg==
X-Received: by 2002:a17:90b:2251:b0:343:6a63:85d5 with SMTP id 98e67ed59e1d1-34e71e0f8dbmr2312918a91.16.1766057508457;
        Thu, 18 Dec 2025 03:31:48 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:46 -0800 (PST)
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
Subject: [PATCH bpf-next v10 10/13] libbpf: Optimize the performance of determine_ptr_size
Date: Thu, 18 Dec 2025 19:30:48 +0800
Message-Id: <20251218113051.455293-11-dolinux.peng@gmail.com>
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
 tools/lib/bpf/btf.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c63d46b7d74b..b5b0898d033d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -659,29 +659,21 @@ static int determine_ptr_size(const struct btf *btf)
 		"int long unsigned",
 	};
 	const struct btf_type *t;
-	const char *name;
-	int i, j, n;
+	int i, id;
 
 	if (btf->base_btf && btf->base_btf->ptr_sz > 0)
 		return btf->base_btf->ptr_sz;
 
-	n = btf__type_cnt(btf);
-	for (i = 1; i < n; i++) {
-		t = btf__type_by_id(btf, i);
-		if (!btf_is_int(t))
+	for (i = 0; i < ARRAY_SIZE(long_aliases); i++) {
+		id = btf__find_by_name_kind(btf, long_aliases[i], BTF_KIND_INT);
+		if (id < 0)
 			continue;
 
+		t = btf__type_by_id(btf, id);
 		if (t->size != 4 && t->size != 8)
 			continue;
 
-		name = btf__name_by_offset(btf, t->name_off);
-		if (!name)
-			continue;
-
-		for (j = 0; j < ARRAY_SIZE(long_aliases); j++) {
-			if (strcmp(name, long_aliases[j]) == 0)
-				return t->size;
-		}
+		return t->size;
 	}
 
 	return -1;
-- 
2.34.1


