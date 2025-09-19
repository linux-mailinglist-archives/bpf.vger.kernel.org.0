Return-Path: <bpf+bounces-68949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E60B8ADDE
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C205165B91
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDC25FA2C;
	Fri, 19 Sep 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg3WsCro"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842B22A4CC
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305371; cv=none; b=qcyM4Kp5lpZa1/e8RXcGtLRZILt1Oqb0BJZ+xS4Roynyx6K0ca5F7h/wWCABJNq8Tu9MWuZ+j5SqTV9qk08lemB2Y4HOZ/Y5C62lnK2G6umcQSC0NjZyKqXjAB8VQCdyuKHHxDQ/ODZQdguWaUFIH5vkQ81eo6l4r28uqO6rZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305371; c=relaxed/simple;
	bh=WTNdrTeER0WJaRclyj5OzZBh9204Z1ralvE7oTUt2x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tElnB+s2Y1Q8FRrsH8buJL6smqqgibEaaLOj7cKfbh8GlM7czOfO9bdy1BXVZyIo4GFJjIJEFDR7Kmx8pLiOLEfP1+7hcsBw1TK7yCwL/NkF/RJPBKJm3pGy87fgmT/Qz/V64hXOQ0K0treOLUKlDEW/kiHrvaJt2PB2ZQq90LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg3WsCro; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7728815e639so1801798b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305369; x=1758910169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVw2gOE1ByhmTgXzMOgdyUwD8Ziv6injdIDrMi3HecQ=;
        b=Mg3WsCroVlo3u8UukQc2zRrorKB36PXHfKCruvhqHD6GJnE94BXhUKGCEcTxPnJ7HY
         EnBTQqSbr3FqajQWYIO80iyfN5Q16vHoKZ75c+SPTRQzYDfaIM8u33S0EKQrIcBJTcPl
         40F37BdyyIE2yKRtRMzn+v/Kw0DC76O2+GYHih4zDBm0EMj7YQ1SA5SGuoy7yv89SxHt
         57OcQFnp5PVuRl+yxpIP/krQlJygca892BEQucKm2diG0TINFfRrAv5w7+YjffsFB+TX
         Z46Ms0z6Cpf9AY6JS6apzLrCs1ohQR2lNI7CyD86f9KIj8I3a8rCYtZcIGkt5xJGoVKN
         q7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305369; x=1758910169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVw2gOE1ByhmTgXzMOgdyUwD8Ziv6injdIDrMi3HecQ=;
        b=IfLUEYtqbr8zvYE7GI0RNsD6H+azZcHo0r9KA16jkKhgywJLa8jyi3CTb4Am1ySgQ6
         qxtvfgQWlE2o060lZS8gUmXDGLzVwR2C3W8qmfrtWWh3EHQZ3p1LY1lZRw1uVHXeaou2
         EAvfynx1khj1KyUwSK5efni0s7S7iYigUW6i/kJ5Ro4TaRz/x/6e02jLkN3A0mk5GuBe
         xlUvWWQ2vzOU2h+IgkG92sQ5qzk6WxkH8jkG3L5uAw04f2uSreAojHBj5PTtjceEGjy0
         SEh4pQ4Udogt0aPSDbQNKChlq+vTDeWcQ74qEgnpTc0p5+A/aYQhl4dd6YcFI0fLFPEZ
         76rw==
X-Gm-Message-State: AOJu0Yw4TeGUjFDcxTEqiWXchRuwA7IrVL1Xu1WmVasFVJjKj+fPspMF
	O58NYqsiA2vdh66JDAS8Y9rijraR/OOHGJYC/d7z4mxjm3T8d0PwhaTIlj8JHg==
X-Gm-Gg: ASbGncvqADvvZQBQp/UuerlTCNNbjlRgu8TLYGRhx+1TqXdRfzx/ubC69J5UlAWpvFh
	AQxx210ZK8zrGdkQOCU1XaQ6lBhUMHaQrxD+ASD2CNk3+0DTIRxmofuqNrcg2EPZvb3wk9NxcEa
	XjmtxmBl39oOh0XlgoVj08C6EqOvy5PhjpQ63PjsvbF77paN0Sv9pLgHPdllmvQ+SacHvQdFx80
	mXNblOPsz93jsoFALFmRyhybfm5yzkaUOzDi9JMueyyeAf/b61qPc4WSVFNtqR4GQjECYm20kFH
	kxZXp0Dqft+GaZufMr1T/lVskXnxfDdJroumayfTooPhnM8s6bwT5XVsVI9qvLqu2wq5q1jGNns
	bsa7WDceZCm9qkg==
X-Google-Smtp-Source: AGHT+IELmn3TFP/Yzf2RTn2O32GfLERHz8fxHqsb0cfwXcJ8ZoSx3HUvrU8K6gmhb5GPYdh99EQg/Q==
X-Received: by 2002:a05:6a00:330f:b0:77e:74d8:c6e5 with SMTP id d2e1a72fcca58-77e74d8dda0mr4398062b3a.15.1758305368503;
        Fri, 19 Sep 2025 11:09:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc726041sm5828275b3a.40.2025.09.19.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/6] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Fri, 19 Sep 2025 11:09:21 -0700
Message-ID: <20250919180926.1760403-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
References: <20250919180926.1760403-1-ameryhung@gmail.com>
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


