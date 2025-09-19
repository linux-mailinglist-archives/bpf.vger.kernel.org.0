Return-Path: <bpf+bounces-69010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73FB8B9B5
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB2058627D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06FB2D7801;
	Fri, 19 Sep 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOQDGDqN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911A2C21E2
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323397; cv=none; b=fCwr51EDnz9W9t2JdzNJ9wPmP8jk9GDrVQ1RmfA7M20EkzWLAryMigA9zp26OcQ6eKlO+IzucrFUyWx2Z2yz5SshSjY4eQrnA+nk5KU7GtqxLdH3Ul4OZHz2Xf1aCAIu3/2UMA3DUoTvCPm6nhm18GmL2DD08vrvFuZougwvC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323397; c=relaxed/simple;
	bh=3HDpZfa6cLidcVKtUcfEQ4U0JwfEcLpjqyb8VLh/QJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7VUuc5db8iVfoX2Y4VdtF0AWgsI1uW/6v/0bJFR61nQA7hiA2l8hrtUlo2Yab2ZSsN4Wwy5QlUvh/aBRmfJmaZZeynu5zRZILlQM9b5TqcRqj7ojd24CQbP/eubr7HxlSiS+wonxSZiHOcXpELn5L4pcXtdzBdkvZhTU6Nn+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOQDGDqN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26c209802c0so10933055ad.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323395; x=1758928195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2e8lypOcSZ/tosAuDi2aHX78e+86CDJqxlNkTKPsXw=;
        b=hOQDGDqN0ABf3gv8wHMsgok6Xh6ir8vR48jet57jCTwIWyXrX2YlDJ1kUfAvdl8uzW
         QCUXBBnuCGyGfaY5kJP8mRa7CQ76bSUXoSZD1REWI8qTSr85KYWr5F5B8akRKMirglnX
         HJG2EFCyXlWKyxK5mXcH5dGIFMx5Wdoch4AvUD7bcWjR5tvg1pLaeUb/fyQ8+xszCDAj
         cJ4VWuVNGwBxc5iluDot9Iwbj9eDTacki69Xf4lb4FoYm8xIn9P2dAtxeHTwLLEhVh0F
         6mRPcc32YI4izDW40RuqH3p31hvWP3DfqOhRaZ28iby9MKpLheiBjUsYTRmU3qoT6mDf
         zJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323395; x=1758928195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2e8lypOcSZ/tosAuDi2aHX78e+86CDJqxlNkTKPsXw=;
        b=r7r8mWViz93+WJhX/+h4ibJR/rAgblxa93quwnXp329QzKnDMjrBhp0LuHz7DXao9x
         C3QaRoP8ntaWIoNktQRHZNvm06oFDyhLo28Xl4lTRmvV6F908bDlxIvj/FSJAChbTLA2
         Fr/Bebh3DNi98jsga55TMBmN9hs3ET8+G8ktNIdYrreHXVpH2H7V3H2EuIT4yFJg4vRk
         gVlv/4Gv1jZoIInAN6b56bQQqb4+zS28xzMtPxpm5GhxB3+S4UJ+cCubE6qmg7NU/6CK
         z0LzGObqVvbJ7W1GbHJsNjMhb9x/R/iAqB8mnA6/q4q2sijTDKbG8Ld1hLWSY7E/WJ3h
         xcnQ==
X-Gm-Message-State: AOJu0Yzcvwt+45m50cpgPoI8kM/HlHX0Nyokifg/hqhINy35BFV67Q/n
	Yau2bKy11/AesX2YITOMNHAdhkl+7oa6SvqVAteurS8yKz43CtWksUjpZejO7A==
X-Gm-Gg: ASbGncuUNVJ6M5AwwP+3w1DpZxXVk4gT2U8jqd2gMHTGoN000vakzkxz8S51wR3PEOf
	hsxt92o9Iyf2DnjGYBdHI24GG9AZXbH7beT3bQVzVMly47OFuU+r6ve1I2QAJvzeFuRIFOT1fqR
	rgr3yJQ0O6dGPojQjg8Qq4Vyq8JVB4TzSkWZtRbEdvnFrLs/YAzC5WGzFvssOrJUNejOU9uAoW0
	CWIZWyqvAFmU+X5uCXcPROQUlH83Zny9kRmok291If0MGpbBxBuylYsGqfnQfhd+pI5mE2yoEkg
	21ol8PkGXZi9qZO9M3RaSWEBiG90ZMgLmtMT+O4URSm6s5xebPEpFKRigmYlqmTa/vp3Cv3hjvn
	+LrmRX6vspB1/Pg==
X-Google-Smtp-Source: AGHT+IG4iqmHtx6f7yxbmQD85kcRzS5YjrRT2UlskoR4H9TSPKTTYkkinepxul2j775ME0nw/WURnQ==
X-Received: by 2002:a17:903:ac7:b0:25c:a9a0:ea4c with SMTP id d9443c01a7336-269ba5042f9mr54991215ad.34.1758323395047;
        Fri, 19 Sep 2025 16:09:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980336511sm65539545ad.124.2025.09.19.16.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/7] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Fri, 19 Sep 2025 16:09:47 -0700
Message-ID: <20250919230952.3628709-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
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


