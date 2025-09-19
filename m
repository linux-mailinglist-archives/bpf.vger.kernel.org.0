Return-Path: <bpf+bounces-68958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3BB8AE53
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDE17C135B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409972741B3;
	Fri, 19 Sep 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BohncbqK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748AB26657B
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306066; cv=none; b=LS2WFugVKVMY+HaipB5JXmCHOkeyTuTrFBw6V/pGBJipy77qqL5+EvQuX1sIRn342FIFWHjsg3lnRqXBJ2xKMtzBFNowmRHScBxwG4vOLQX7IXMDbxa0tQ+NJRa9Wjr9cNLCzxj2wk4+HzdAtmvORaOScJMbhF7Sfvh0hewr9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306066; c=relaxed/simple;
	bh=3HDpZfa6cLidcVKtUcfEQ4U0JwfEcLpjqyb8VLh/QJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbSom3Dk9q1oMjRUY2ReGOnEdJUSpsSg9zcjAwRPgxZy9pxY4G7g3cb/p6zhbYHYc+LGnpZmcFRKu8ekwd2V/clcfs4n105rrrpzzrX7uDXQXaUaR8DOK5iC38eYw+FBsxYUHNDuMoSLmrxXZ7vjjSwwIf2fvdiMVuAUBwpCTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BohncbqK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2698d47e776so16693975ad.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306063; x=1758910863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2e8lypOcSZ/tosAuDi2aHX78e+86CDJqxlNkTKPsXw=;
        b=BohncbqKpWfzAG8to+GffzB4+ltI/iP5DmnJmjwaZFaEaYkxc+NiWX/R63rNcETh64
         wSjH7g/+9aBOjgmuRvvE/1qOptPbBGGveKQdmHm6GZ9syBaNlqEryl5TjrMC9MVVtcFZ
         zGGZgWfTkvjWCOQnfuGWu+4lz553ZscrwQXjbJoLtAUwwrUz5ZsQwcOIU/S7KrLDjRd0
         4xxc7iJCVUVEXyU+JJBJA4FSanSoIbqdFAAsXYQO4oTXAs9F5CVP4/RUnmxBUf0rvHE4
         JKXx9hpCDl+2+cH9fPnOJTYdud5tsY3NaVUP6zZsjjdwl2H+2YKAh7b9kbVZe2BTodWq
         CF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306063; x=1758910863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2e8lypOcSZ/tosAuDi2aHX78e+86CDJqxlNkTKPsXw=;
        b=AaxrNnUCpRiRfjTqLLNmunZqLnJfqYS1VJAuLOZsCSB1o2ZX8d2UaCQFGMF8vVQwMY
         dlvYk/tedZRRE5nE+7zfv61u4St39tQt7SrznHJg+lNKxw8FQE84c7PrTfPlTVs9QptQ
         rJZNUThOILHVZAbOdLdTPdZd9PWR6GKu0loZ1GIbpaH8NcHEtMKpdu2vdfh9frpHDh9Y
         7KRp9lzT7c6aoRVYOceggO3rk7PI7wMnFUzhmPZJD3ZwxPqq9dDuihrxmGN99L44bPAU
         VzrM2fP6iHlir/U0PzTyCnU638d/h1My+hBRnxvO1ae2mNhxZTZ3J7E7Fpgj7NbrfIJF
         Bmmw==
X-Gm-Message-State: AOJu0Ywv9uY+QyPQggcGEjbZCrKADfYteWLhuuhu5l4lSuZZtPSylcSV
	s+ht7WZV+r52RUZYS4ldIMG8/b8r5AEwYSX/b+Pm/NkIYbJwMY0mj34gkqpFzA==
X-Gm-Gg: ASbGnct6FDsoBMsHMo+TbVmtQkCRJzedbm3hWfag5mytBvDBrbii3+IuaUBZCJwsU6K
	y/moKVKiiAuf5+HpjxJo4MjQM5YpZSlEGiUEW+lct4BpPZzUTI/em5JCB7EwnKmBdex24ywd+XO
	JtRuIOplhXDh7tR+9GsStgXcwgHJyCBpGUroci+w0KYP9/zbO8pxE1Jm0GUwVbsBRBhnDoZQic9
	/QEnle1cIRDT9UZlDr+QWXqC1p0qtL60zJe8wvMGIz83u8Uh4A7kBNjhmE0fkknnAA0vm2T5mBU
	99Alwgej5UH622V3e8mNyj1BqPy8DQgZtDW3Knah3C6hLrs+kql1J8MhSPYU0Hh0FIbrmhy8r14
	2JBp3YAR5VMRePA==
X-Google-Smtp-Source: AGHT+IGy/EkJdxIPYNdbwOXZ+16o0evU2VfnBnTkjMb6DO6e8o/GsmVabFsSllXEyPDXIHypmUXX+g==
X-Received: by 2002:a17:902:ecce:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-269ba4f01d5mr53304635ad.33.1758306063318;
        Fri, 19 Sep 2025 11:21:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802fe08bsm61478645ad.103.2025.09.19.11.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 2/7] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Fri, 19 Sep 2025 11:20:55 -0700
Message-ID: <20250919182100.1925352-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move skb_frag_t adjustment into bpf_xdp_shrink_data() and extend its
functionality to be able to shrink an xdp fragment from both head and
tail. In a later patch, bpf_xdp_pull_data() will reuse it to shrink an
xdp fragment from head.

Additionally, in bpf_xdp_frags_shrink_tail(), breaking the loop when
bpf_xdp_shrink_data() returns false (i.e., not releasing the current
fragment) is not necessary as the loop condition, offset > 0, has the
same effect. Remove the else branch to simplify the code.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/net/xdp_sock_drv.h | 21 ++++++++++++++++---
 net/core/filter.c          | 41 ++++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 513c8e9704f6..4f2d3268a676 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -160,13 +160,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
 	return ret;
 }
 
-static inline void xsk_buff_del_tail(struct xdp_buff *tail)
+static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
 {
-	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
+	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
 
 	list_del(&xskb->list_node);
 }
 
+static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
+{
+	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
+	struct xdp_buff_xsk *frag;
+
+	frag = list_first_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
+				list_node);
+	return &frag->xdp;
+}
+
 static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
 {
 	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
@@ -389,8 +399,13 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
 	return NULL;
 }
 
-static inline void xsk_buff_del_tail(struct xdp_buff *tail)
+static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
+{
+}
+
+static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
 {
+	return NULL;
 }
 
 static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
diff --git a/net/core/filter.c b/net/core/filter.c
index 5837534f4352..8cae575ad437 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4153,34 +4153,45 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	return 0;
 }
 
-static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
-				   enum xdp_mem_type mem_type, bool release)
+static struct xdp_buff *bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
+					       bool tail, bool release)
 {
-	struct xdp_buff *zc_frag = xsk_buff_get_tail(xdp);
+	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
+					  xsk_buff_get_head(xdp);
 
 	if (release) {
-		xsk_buff_del_tail(zc_frag);
-		__xdp_return(0, mem_type, false, zc_frag);
+		xsk_buff_del_frag(zc_frag);
 	} else {
-		zc_frag->data_end -= shrink;
+		if (tail)
+			zc_frag->data_end -= shrink;
+		else
+			zc_frag->data += shrink;
 	}
+
+	return zc_frag;
 }
 
 static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
-				int shrink)
+				int shrink, bool tail)
 {
 	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
 	bool release = skb_frag_size(frag) == shrink;
+	netmem_ref netmem = skb_frag_netmem(frag);
+	struct xdp_buff *zc_frag = NULL;
 
 	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
-		bpf_xdp_shrink_data_zc(xdp, shrink, mem_type, release);
-		goto out;
+		netmem = 0;
+		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
 	}
 
-	if (release)
-		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
+	if (release) {
+		__xdp_return(netmem, mem_type, false, zc_frag);
+	} else {
+		if (!tail)
+			skb_frag_off_add(frag, shrink);
+		skb_frag_size_sub(frag, shrink);
+	}
 
-out:
 	return release;
 }
 
@@ -4198,12 +4209,8 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
 		len_free += shrink;
 		offset -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink)) {
+		if (bpf_xdp_shrink_data(xdp, frag, shrink, true))
 			n_frags_free++;
-		} else {
-			skb_frag_size_sub(frag, shrink);
-			break;
-		}
 	}
 	sinfo->nr_frags -= n_frags_free;
 	sinfo->xdp_frags_size -= len_free;
-- 
2.47.3


