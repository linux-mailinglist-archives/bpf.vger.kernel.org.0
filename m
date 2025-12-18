Return-Path: <bpf+bounces-76982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9625CCBA13
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D45B530502DB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD4431A7F2;
	Thu, 18 Dec 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY/Fe4mg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA331AF16
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057521; cv=none; b=mAiKEgtFtqei2zomh28eEq2sia0zyDaR322PP/ixywwlirr9QDP2Xs+VmAFmynMsnJRxd1+bggAIGfITSFmj7iyQ6fzNPUiEcxtx30r9ttZuKDrxE+EnJdxMzCGrX5+2hGTL0I4e38wwdoCFyWGOJGeq/dyaeif54RLTNpddH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057521; c=relaxed/simple;
	bh=Xz/BsCSSmQa5e7pDSsHdn/GiF1mTaug38aVPZfosH/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qL1IRKzXGq628CRSKEuEftzcy3tLcaqt7Yk+pJ2TLZQoX5a31EQ+bslbxyQN1jbkJDW0E6bb1bbsMaH69QSzCNj4jaIUqD4BDzk79uyb/59FItH4QySaeR8+yOfILG5DbzwwA1Wbiunjhd6eDRCA/+SAhSAtBVzxq6ZatuzGQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY/Fe4mg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c363eb612so538537a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057517; x=1766662317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNF+WOX4XvmwzIr3rrsrWRWd9nyzJm0XMyZcg2aIieE=;
        b=LY/Fe4mgCNoINE4wEpLj8biWs6Qx6RjgXsqLuVnpxAWSubFMW4fDirCITafLGIF1uG
         750kT5YWArhhRUXyAy6XXkRP3dyO1Q5AeTf7Us+XhgtgnMby8StJqUmZZrJHZLaJceV9
         HkEKUk2QWNiW1zzdvxwXqB6s5ETkPyymUJzgDMhOuyL6F/9+3SHmRpoqZli9ufMSvGPF
         5IKIvxzAm9ddFRFYfri7KxYdswLbthoxbRbJlKEYRWOZk7AhGl3rZALz14CcZFkI2TpK
         +kIZXj9RO+mia52YP2dIK5Dn82sJk4zArTbFQTJYg+dDTKY48t6XDiCLYwzs4SFpr1ZS
         DG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057517; x=1766662317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VNF+WOX4XvmwzIr3rrsrWRWd9nyzJm0XMyZcg2aIieE=;
        b=Hc/jXbYu95rWVqWcdSf6gDzbIZ8jMkS4A88QQDICoyWsif7QN7hGOJc6tuIUgYMUxM
         1KpwTuvOOhGBiKoJEmP62TxMW9NWwvI33RrTqx8e3isBow5dJxWJMcXmBSF4V1E+hmKl
         IB/6W0PuD4yUtZe5fVKxs+swHclrH4as7DSPp6pBrhM2kPto+TNg1jQ5tNwzotRPEl84
         ydMIvJOGtnQzqfKSnxu9CIW+y4QAKO8R8ulnpDhfnzg7fwXF1gBI6YUJvGN2blYoZ4Fu
         1g1rSyuj0rloGqBPgR8KTx2+r2kQ+0lwspUROVTx6Fwk9yh/w4w85YjE2ctzf8USa43d
         ZkmA==
X-Forwarded-Encrypted: i=1; AJvYcCWIaATmlnMW0wr545RGOyte/8EujH75+OwHXDnbMPIFPb6MbrNG7ceas/RYJbF4JcIcblw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3bHTCCmfDxeVeFHsdsR4P1zKx4NWjI967tnMSTuo1dBv0J6S8
	smk6XmyuTldSiTjpfthrliTk/rcBmXBqliKNX6TKJg64G1aCncMmB0Nn
X-Gm-Gg: AY/fxX6q78Id6ySgqZGR4ueUx2sLgIAC2Vb6Sde0ZYBglAdI1r86ZHr68cwkQpzkv48
	JQS1e3SraYQtNSOMBclwB5vEbEN4K357u3zJNlgKGfLpDtKVKes6fL/5LS+EQtOJea4Qm57qeP6
	P1x+PiVyRSpl9ixTmfXDDCNV0cO98X8nzQ87TAgW25+rzw2TQ9wnnl0AKcr2HnIEcCS25voJ/cH
	7hqKo4DmDbY0LDu+JTIMRC8yQilTmcdkeFblS6QAbYAiwLehrVKf4B0Dku0wGjxgXfZRFmyfy2W
	4InmgqanZXVxzZFyt6is0meRIWnkJYU/xByS8TXzq+4QZ437C294pqvp8oNPm/GhF78Q1BdXk0c
	YCOGGOwlK3fKKTmtrQo+3oAcKnffSmTDXR08ATp2dh2kb7wf/kafPOhP0JAr/sQpXsOVG8CC7pH
	bFcWtI72ZJb1sDFeDev/9ZaHwrUIg=
X-Google-Smtp-Source: AGHT+IHcDTMoUHNvfws/gUKjgPf5T3pYkIAfD1uJ/fbcBHxliu5JD6ybAq5O78KNN+/aLzQkupcwew==
X-Received: by 2002:a17:90b:270a:b0:340:b912:536 with SMTP id 98e67ed59e1d1-34abd77f7cbmr16497126a91.31.1766057517399;
        Thu, 18 Dec 2025 03:31:57 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:55 -0800 (PST)
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
Subject: [PATCH bpf-next v10 12/13] btf: Add btf_is_sorted to refactor the code
Date: Thu, 18 Dec 2025 19:30:50 +0800
Message-Id: <20251218113051.455293-13-dolinux.peng@gmail.com>
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

Introduce a new helper function to clarify the code and no
functional changes are introduced.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 include/linux/btf.h | 1 +
 kernel/bpf/btf.c    | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2d28f2b22ae5..947ed2abf632 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -221,6 +221,7 @@ bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
 u32 btf_sorted_start_id(const struct btf *btf);
+bool btf_is_sorted(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3aeb4f00cbfe..0f20887a6f02 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -555,6 +555,11 @@ u32 btf_sorted_start_id(const struct btf *btf)
 	return btf->sorted_start_id ?: (btf->start_id ?: 1);
 }
 
+bool btf_is_sorted(const struct btf *btf)
+{
+	return btf->sorted_start_id > 0;
+}
+
 /*
  * Assuming that types are sorted by name in ascending order.
  */
@@ -649,9 +654,9 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 			return idx;
 	}
 
-	if (btf->sorted_start_id > 0 && name[0]) {
+	if (btf_is_sorted(btf) && name[0]) {
 		/* skip anonymous types */
-		s32 start_id = btf->sorted_start_id;
+		s32 start_id = btf_sorted_start_id(btf);
 		s32 end_id = btf_nr_types(btf) - 1;
 
 		idx = btf_find_by_name_bsearch(btf, name, start_id, end_id);
-- 
2.34.1


