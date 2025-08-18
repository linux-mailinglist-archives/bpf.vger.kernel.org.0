Return-Path: <bpf+bounces-65851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC75B29932
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 07:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C1318877E1
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA00270577;
	Mon, 18 Aug 2025 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey3kRUrg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7B26E161
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496553; cv=none; b=odHN5Z33UtMW3EGs85+P8PzdBNpE1FZYps62AzoGXQGQvwYu+IaKmPb3SJ8Ut0sGN7uxnbzf5qAIxs4veWQuJ/vZo3fzZ4ZThreATIzlfr+BJnHmjM1Gpo0Z77TjLOehUfML0a192dfPFlpnIkqXO18DFYF8uEZ8vQJa1PV6tUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496553; c=relaxed/simple;
	bh=rX8e9NsQYk4BL/Ik+7nAY1xej8+yPJZtHsuQYW2oEdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t94sojoqyVlDv+K9z8WYN9y/GZp1pDlGVvmBAYh6U7sByF8Gbj3Oa1NeJGlcpL13V7vQGJyXLm8v08sY4c4Y7utI4yxA7/5PXCYY/9t1pURbtLSDLZBTfBelxWiBBBLPg+Bl3NnHHEQR/NOH5WaYIK5Hix1PeoW6B/4/VTVuCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey3kRUrg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e71c31so3336498a91.3
        for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 22:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755496551; x=1756101351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFHLpr6FcX/Wx3J31OLqW186GX8K2s1j2kcuC3aNVeM=;
        b=ey3kRUrgL8XfXf/lSBKEciqUl9K5n8acEzR1G8JONZsdkMQV90GIF1Jz4pUoljtW5e
         Lk5YiSkVZ+INHMYeXyU+UgezC0+Td+JwWzQBeD/j+3VnnH7/THpwR5UV+2B+2vYNOt7g
         tfC7ECnCBygKQyWsq8rNHRma3SaFJXqoFtsctQ+pD32vFtnlOuPEh7z/Y3I++ABeAVlz
         i+mxdlBtEjcvNpxLK1O1b2mLMy+uhjwylxHsaQU1nXUZpsAHI4klhnRhZIxUcldqGsDx
         ZE6DO1LleMYq/J19KQv+wNRV8m6W694z316eZWyTx+41ddjMIOn7hzFLskOul7/jwOju
         cU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496551; x=1756101351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFHLpr6FcX/Wx3J31OLqW186GX8K2s1j2kcuC3aNVeM=;
        b=KsXeK2yXE0/bPxbj8wec0GZ3Zripx64oiRG6aFcE824fDlHp3ABDpt/NSlHC3nHtCQ
         wM4+ky4jAlYbKnH/+9XfZyiJBva6tKUQNOs2fyVBQvvW+BX00CG68ibCT3NkRRzWtMD0
         LnBlIRkzb0HPQbyCzBBlaXYexY+53sOTcOe8ZNn8TgxGe+zDoKoXKpmiK8SeHIGPAJA6
         Dc+A/bm0Ytt1d6kYsHDD1oo5b6TrRqrVBEtywfSVMMQYtTpQgQoRFJJlrQg5/B6dBpak
         jZWoIcYoZigBrcz4FstTJsc+dK/8hHvJ8vsF7odIuAFuRW/wgDZaSERUl7LlxXP604Sf
         fyFw==
X-Gm-Message-State: AOJu0YybR1gYCxVbCbNLNXgSlzJsd2P/hiGZVdHWDuXVq1kVBZbkQHe8
	cVLBJlZ4yGf6Le6Dzo4tkbTZjwdOMA/USB06Y95BDRou97RKb1nnz8OH
X-Gm-Gg: ASbGnctSrTQ0N+p3t/jX2+d0EiE1a1Hfnh/IkVgNDpSgWtSQUQLteDmTIw23hKEZpTb
	VVnRb/5fX3Xy9ylO8rKxcOlLJQjogkslRx8Wa118R2V9U8dwSPphIWleS0tX6hCZhdBE+CIP4hl
	VljcoU+vbhxgJu4MeJB5ulwglgLJip4Q3jAUfqDKJ+WKS6+buFgL72h19JEsP8jLrGbOKkSVN5z
	C7xuSS3d4I5PW++NG0Y1yYr9SwbU1f7NgjK+SKTHsSdSLQIxDZszC7ny9iHgZJF4fDpl/X0mIlK
	P5VoYBZ2IobUs38RtvbiLihq5mkRO1nP4naO/CPLofhxXyBLAqY1o7XgHXIBT8uVi02Fg47Wi5m
	iSg74ecfNpDGGvwSxttOwznJTMsk9zjHzTwam9Ts+onITsg==
X-Google-Smtp-Source: AGHT+IEJCPBS5iRXP4XM57Mk2ebvHxoxGY6WLtHS3LPJQ+Lh6u7Flwa0rSsbi14YcW+iQnoFzlmjLQ==
X-Received: by 2002:a17:90b:4d0b:b0:321:b7ed:75f2 with SMTP id 98e67ed59e1d1-3234dc62038mr8862243a91.32.1755496551296;
        Sun, 17 Aug 2025 22:55:51 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439961c9sm7003413a91.13.2025.08.17.22.55.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 Aug 2025 22:55:50 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v5 mm-new 4/5] bpf: mark vma->vm_mm as trusted
Date: Mon, 18 Aug 2025 13:55:09 +0800
Message-Id: <20250818055510.968-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250818055510.968-1-laoar.shao@gmail.com>
References: <20250818055510.968-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every VMA must have an associated mm_struct, and it is safe to access
outside of RCU. Thus, we can mark it as trusted. With this change, BPF
helpers can safely access vma->vm_mm to retrieve the associated task
from the VMA.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..984ffbca5cbe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7154,6 +7154,10 @@ BTF_TYPE_SAFE_TRUSTED(struct file) {
 	struct inode *f_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct) {
+	struct mm_struct *vm_mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
@@ -7193,6 +7197,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
-- 
2.47.3


