Return-Path: <bpf+bounces-78196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55455D00D45
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EAA93002950
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927428980F;
	Thu,  8 Jan 2026 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnfeAN+G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8502287502
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842229; cv=none; b=J3Zx3t8RFkZRaGnFOGo35M5SUHTTd9Yw2oMMuFJm/9/EkpuTNwtzR7nmTpa3vqnZgzTr6ETQTdcey6TySfpK/SIZe0GSigkc7qX7+UmADHLOs5oD7hDExSkvQMpfco5OtekU0WwjEREZbXYwcU9wfr6ZFf5Qy/z1aJs+zUkWYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842229; c=relaxed/simple;
	bh=u1yosoqwlcymFoxHJmfX2OwDeaTdtE3Iyo0L6QN7j0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYF6J4Si6Nq6x4TEb5Igetoyb9Zy+d40gXIb1/XKjTTmKe+59NzC2WVbSPvx+fWoQMK9AzlTfhnASF6aKP7AmN33MEt7pImXWBW/AKW91d8bt39t06obTIUpH0i3/xeXa/xcOvwkHlIbe56QAFpcYysH5NDgDIzPqAfhsRh+VYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnfeAN+G; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-803474aaa8bso826674b3a.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842227; x=1768447027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kABC1LLrrQty1VIIHsvBVH3NPqN0utmzldvVjxZi68=;
        b=AnfeAN+GH1SRHmcTuYE6zQB+jgkXYVl2jWltXt/rMI38y4RwIb2NXDiVuFAo8B2iTe
         af4EIiB59l9d3R5dRRNhg47t+CBUuzmHfw/7pCCdn2u4PFWS4CMpTrYISCv5xkFyfWDl
         EJsnlUgkDml9pFEXo8rG3YyO9f+muV/Oh3kbJOS8q9G4iHRxWZFoMfY2CBN+QByk9nOJ
         /fM0pshL8SbZL1w308WSstb3gANVfEmxi3Yf4aEtMW3epPAwswsoh9fhhLRZEBtzQdY/
         3osTzigNu/WCbK8kisUlwwPPL4Xx2GbNSLH+aLu4z0GMkPrzfyrOoSpsA5GAc5NVq+g6
         Kjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842227; x=1768447027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4kABC1LLrrQty1VIIHsvBVH3NPqN0utmzldvVjxZi68=;
        b=W1i1V+FlXOHXScGUKwSvJh4ehKoFL3Dl/WUS0ec1BOwb851/y08Ld0H4oaYc1R43U2
         9fN2rQlWh2mS/DqQh2sD+9tgDuXldUraJe+2x5wIXgkNp4R8Q0af2HgKHM8Th50gTybx
         9KJISW7tt31SXGo+mz0ZVaPBLMJjmG2YnMQgZnA6Z8r67UkqS+71aeQFlbkx8csTrs1w
         YNrwTGktIJJeqS4Z5af95WU7U/c1+lZPqGAz0V3euonhArCWju+n+lzzJ312XsDry+27
         diQzpEnpQbXfhqZ9WCd8fj3XOEQHBTolgD9hNGBOu6ThumdwvY0VRyNHPd8ykjcw7VO0
         DzZw==
X-Forwarded-Encrypted: i=1; AJvYcCXLb4sEBIDuHDgX5up46y/NuVb97qKmRWdn6G9NXpY/UcFJ+VE2G+ZE+P+oiTpy9Jivg6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpNZc4Ye5RVVpnB/JNq5I1CvibdHsprtFs2TkV0V6s2PScj+r
	VkNk8QGedElBHp9pMZ0TBgTDIS9M4bbmXG5uH7T//vFtuC0fnsUpaNwV
X-Gm-Gg: AY/fxX5gNwjWYYF5XBFdquC1OXsSvSr8/NU+u0xfMg29GQsmklHQ5Wsv54fYla8VW1a
	qxMLgal9N25FC8slEJDA2dQXI6mycrGlptg+3G98+YHUImyt4DSd4SEL2y/dLISJALqx5czyFzH
	qUSQeZYWIDQqzUY/BYn9+7ebXNFGF2hN+7eL7bmJ8NXY4cz73RhoZEXUrZ7r9OJ74V95bAfShZj
	C38lV1v6vfMzLJL5f5fpJN3BOfKGuWR0Vo3Hl9oS7GwGvfmykG7JLcOqt/wYrA4rZP+Nk5/9CRb
	RE/mjD+hygdpg9AGmIftExTLI5TD7rcMgtS1zF0FJSJwctUVzG70eou9cCJQiWgnH2sNgxdODZ7
	GM86iSQBRtXmz61XDrh+q3ks7/53kNYBFuxbxoHuz7KFPfgjxgV6Yg4Vg4qXaWt1IRVrGez7nMn
	xAnObP645DU61fJZ+9OpVEwHPlYto=
X-Google-Smtp-Source: AGHT+IF5IP72Yw76UNPbKp3qcFOeQ6aRxn9rPrvIV8gootHoOjozaO2uZWqC24LWOtukGHVXMP68rw==
X-Received: by 2002:a05:6a00:2b5b:b0:81c:5bca:8104 with SMTP id d2e1a72fcca58-81c5bca823fmr1632563b3a.24.1767842227105;
        Wed, 07 Jan 2026 19:17:07 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:06 -0800 (PST)
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
Subject: [PATCH bpf-next v11 05/11] libbpf: Verify BTF sorting
Date: Thu,  8 Jan 2026 11:16:39 +0800
Message-Id: <20260108031645.1350069-6-dolinux.peng@gmail.com>
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

This patch checks whether the BTF is sorted by name in ascending
order. If sorted, binary search will be used when looking up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 60ff8eafea83..277df0077df6 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -899,6 +899,30 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+static void btf_check_sorted(struct btf *btf)
+{
+	__u32 i, n, named_start_id = 0;
+
+	n = btf__type_cnt(btf);
+	for (i = btf->start_id + 1; i < n; i++) {
+		struct btf_type *ta = btf_type_by_id(btf, i - 1);
+		struct btf_type *tb = btf_type_by_id(btf, i);
+		const char *na = btf__str_by_offset(btf, ta->name_off);
+		const char *nb = btf__str_by_offset(btf, tb->name_off);
+
+		if (strcmp(na, nb) > 0)
+			return;
+
+		if (named_start_id == 0 && na[0] != '\0')
+			named_start_id = i - 1;
+		if (named_start_id == 0 && nb[0] != '\0')
+			named_start_id = i;
+	}
+
+	if (named_start_id)
+		btf->named_start_id = named_start_id;
+}
+
 static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
 					   __s32 start_id)
 {
@@ -1132,6 +1156,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
+	btf_check_sorted(btf);
 
 done:
 	if (err) {
-- 
2.34.1


