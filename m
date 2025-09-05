Return-Path: <bpf+bounces-67591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBECB4603D
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3525D5C5DB0
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA57372897;
	Fri,  5 Sep 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbWNMiIY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E335CEA9;
	Fri,  5 Sep 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093637; cv=none; b=pnaVZqiupB8hZett5Eqat8nVLK3AIOP8kHofK5gp7FnApQNZu2p83YnL4Qi6F1jp+u7m7QJnFYNEiFQI7IkICx6l64qJ5TpFKE6pJjynVH4XcHcuiq/W3UCHn6p1Km+fjjq59ZiNiPpqBz5uzKOLyfISHRVtuwfTmF6i1+k//XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093637; c=relaxed/simple;
	bh=WTNdrTeER0WJaRclyj5OzZBh9204Z1ralvE7oTUt2x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHxtvfvprzL19SnC23k0rio3y++yZdrSZ8xtae3mEb7TmbT9G7aLbRkaBOqjBirjpXSYpnkzaa5duQnX1cRk33XWEwuM/M/VlWc/VYU9tgAaNy1TrTnpyVR5nPd+yVg613L7Si7sKn8u/oA/FY8da8yPzXlxTUexfVHoB86bTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbWNMiIY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso1427492a12.1;
        Fri, 05 Sep 2025 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093635; x=1757698435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVw2gOE1ByhmTgXzMOgdyUwD8Ziv6injdIDrMi3HecQ=;
        b=VbWNMiIYOqdj0YByoIOR/SbNl1C3zhLm1GCL0+gLIWIz/W3gCQpjI7Xg27jl6RaGrY
         VMqdtQXoN7NudEZUyI73wvI/LxGFpIaqteDioCt2DEdbpXmzDif/XYPHCXO1wyDLRDUu
         9Kkb3fGhWBIbn3EA0njSEF4FeYrkvPVw21rBAfFwJytrGkCgKhPNNHui2M+CBJTIjP2I
         SujTPxRDEY/DQZLCPHM/B8GcYQZIk/HHv5vZL0B8ynqzd7QEOwstThBxTZLiz8nsErB4
         1wYri/aYqo2oXl9X6RfZp2eL07h0WgRP2Z57WPoB95EPvIma0e6J8sQXXZsZNXUUtZMS
         NTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093635; x=1757698435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVw2gOE1ByhmTgXzMOgdyUwD8Ziv6injdIDrMi3HecQ=;
        b=TwfWUpqDFq+zqYJCBnVkSbF2JY8XNbo+M9kkSBgrMb1mNaJhl41jRXpSYw3BEQiUlp
         tFIbxC18pGV57LWFNPA3IIb15KUkDCEN6UFGOqeFEPDU++wJw8Xe8f92yI0uu858iSFc
         47CPz8KDWcihK9gneMIhhx0j2WeWl8LGY8obrG54Vmkp21M7n2aIOXwK7bMcEoc5dpdo
         Tk8Ot90Kw3HSY1TGSOsur+PpOjqK8R15zBo45re9PVDkVKP+RJRjFKxYnDtWAEPXIBXi
         obegByLdr/uyGeMKtufMjxQDV/kCuT11X9hr8HPWmLZojLhOk0UNmH0hRwnsNnyzLPDA
         N4xg==
X-Gm-Message-State: AOJu0Yz+kV362Fbey+Hn9+doI94E3TXgJBIL96XCA8mT7Wv88KAPscYH
	OH3PEUF8g+LA4kgTjiqBIrviC21Nf3yuUj/72j6lfY5mzy9uy9t8p5r2aEBn1Q==
X-Gm-Gg: ASbGncssRRI0ogu1chjNFglbeGqOzyKYeOw2uvt1FskdiRfp00jKm+Q8b5GV6MC20dt
	MB7n0VwhzOb4tx5TFXP6njkpaSo6jQ2KrYsgp63Wph95Sx1ZPyYF0ZjH6NOIRXLWFjYv5Wz2RVL
	Eo8tiqhN9F0hC3xEd9tlVeTs8a5CyTGGWMtxxWD6IKJE5ENwz2F83a7aj8c9RZiqzHONnPaf61U
	G9tycokt1NrhysQIqAHKCns0VV8YllqIXhLlf8PIaR88HzNEWOqcZk9q6bOh7/Ci2/6P08PrZeL
	9RskDdUhRzP5HJWFLYA8In9Zk9jWfMgcf3/BP6E2D/eH1weaPUTEWZwnrRSmme5aSjIZldsg7t0
	DSgyVDB4i85u10A==
X-Google-Smtp-Source: AGHT+IFf54DrTYdMPlYA0HM9H6xHHk8OsY/D0195avQjSFF3IKkQbUGcP5Ho1w+YQTAbpBtofoLXRg==
X-Received: by 2002:a17:902:c94a:b0:24a:d582:fbbb with SMTP id d9443c01a7336-24ad582fed8mr255438895ad.16.1757093635297;
        Fri, 05 Sep 2025 10:33:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc01352a0sm52125565ad.29.2025.09.05.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:33:54 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v2 2/7] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Fri,  5 Sep 2025 10:33:46 -0700
Message-ID: <20250905173352.3759457-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905173352.3759457-1-ameryhung@gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
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
 include/net/xdp_sock_drv.h | 21 ++++++++++++++++++---
 net/core/filter.c          | 28 +++++++++++++++++-----------
 2 files changed, 35 insertions(+), 14 deletions(-)

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
index 63f3baee2daf..0b82cb348ce0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4153,27 +4153,31 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	return 0;
 }
 
-static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
+static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink, bool tail,
 				   enum xdp_mem_type mem_type, bool release)
 {
-	struct xdp_buff *zc_frag = xsk_buff_get_tail(xdp);
+	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
+					  xsk_buff_get_head(xdp);
 
 	if (release) {
-		xsk_buff_del_tail(zc_frag);
+		xsk_buff_del_frag(zc_frag);
 		__xdp_return(0, mem_type, false, zc_frag);
 	} else {
-		zc_frag->data_end -= shrink;
+		if (tail)
+			zc_frag->data_end -= shrink;
+		else
+			zc_frag->data += shrink;
 	}
 }
 
 static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
-				int shrink)
+				int shrink, bool tail)
 {
 	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
 	bool release = skb_frag_size(frag) == shrink;
 
 	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
-		bpf_xdp_shrink_data_zc(xdp, shrink, mem_type, release);
+		bpf_xdp_shrink_data_zc(xdp, shrink, tail, mem_type, release);
 		goto out;
 	}
 
@@ -4181,6 +4185,12 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
 
 out:
+	if (!release) {
+		if (!tail)
+			skb_frag_off_add(frag, shrink);
+		skb_frag_size_sub(frag, shrink);
+	}
+
 	return release;
 }
 
@@ -4198,12 +4208,8 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
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


