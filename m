Return-Path: <bpf+bounces-68446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB64B587C9
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CA316A115
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374622DAFAA;
	Mon, 15 Sep 2025 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSSauras"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E032286D60
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976485; cv=none; b=Gi4+u+Y6noUcMoyrN/DhSncLg5G9dPtLB34sB2Gl6M4bEOv5SagvmtW0JCYKKb+NVyEpKljaoTvg4z3cAo2xSPLO1CoDfeIcLRygdWiqEm+s+Neh+mi0V80GvXaD9JR9ZMRl9Dn617dmancCU2WcwxjW/zvc09T36i9OZ2Icv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976485; c=relaxed/simple;
	bh=WTNdrTeER0WJaRclyj5OzZBh9204Z1ralvE7oTUt2x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5wSoLfhIAPQSUG/cODyt2yMSFzGuEZNcefJonHfp8ydv/9+aOvxfiX1xgprUW++Vr1qWNUFsOZiWz+b9tzWhQiHv6Z1al3pgoeL7k6SE18QQPN2tGdXjMW4Jd/laDC1X5eL+HYKaNqMxUYxa4+rLPgnrVeTYjvW5Cc3QuArgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSSauras; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54b55c6eabso2748305a12.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976483; x=1758581283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVw2gOE1ByhmTgXzMOgdyUwD8Ziv6injdIDrMi3HecQ=;
        b=QSSauras0rCo7lPe9fQTfdA6nHDqsjTYKAjBc4dVecojcXbL2A8v5B7jNFscAloV3G
         VpTAdDeaq7LMR64P1lQEAP3PU3UgEr5MOw5EQF1Dp00LBsYGww4tLWAauQtxfqe/1/nC
         dHQBTK6W+0Ll7w7Yd0PzqApxclFomCmhtMUlp/gcHpDMvEY8Eb93JvVLHEjXTPVAiJDA
         WwJIXxbz2lOmX12GdA/iNlJQdA3/6PQg9M2SMLAu0QNoG/N5cvqOprPIkAnWGJBxvBUM
         4dBJuDzJfSvWwYPFEyqV3labCUba2dnsYfsTOS3Q1tsHeBSB3H1VUH16vm2eGpFS8agY
         BjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976483; x=1758581283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVw2gOE1ByhmTgXzMOgdyUwD8Ziv6injdIDrMi3HecQ=;
        b=m3MuBd62ilp0APqHcLiJ0D5GsYoVMSDUVeUCDb+/EAdrP9j6glPHLEwkhRxByrqlt3
         wwjeAUpTgQP94n2dcHPNHnbgS/zOTvEx/n1ZYMDJjPLZaCyxvTzZTyizOd3LU1+4HI8X
         lHu6576Rzhkg57Mm5ziO2S+kvqK4tM2PUR6EdJKI+NF4WlPAJSnAxisJkwujx8222K8L
         AsJhbR+gmgq8P/KuTjap3HPRO1eyGjh7QYb6uwKuYKI0ybytIezvHGsPJsm6GLTGW4OY
         E76J30gP4YlmxEmO6lwcsGA93AYeQXUAmTjJMrYhitiLWaevxjkwwgnPyDXKsKYdNqZc
         qWQw==
X-Gm-Message-State: AOJu0Yy8fweCNRQ5WA59DSSeFv1YM1C4rTqIpb2r+ADk9XpScWWw0hQR
	NdEgWQ7dgx50hteGnLEU9bj/cqk3/vS/KHz9KGQ3JYOwdl8U1xxhp4PPFK48ew==
X-Gm-Gg: ASbGncvNB/Hy/8ec91oX80VHoLTbp/8z6TCd2dPNEbgjsPddBGyPPIdoOt7SnuQ9JYd
	HgZp/yGJ8rQEo5L1Iu4WWhJHCoYtgfyAgshga4kh99ZqJC7JjLr1ZUoMIt0XbNTD7QoWg/ORMEE
	0Xf8uoGHYAkgVDqGaOTDN/S12Hh34sU/v4zHeF15eylXZey3vVYRgkj128WEQw/RNMGT+CCjm29
	w1DN1BOt72vx33nC/2G/3M709/ZWK57JaJg4coU2kVEKwFD56WyB97hAG1hibjeuybRf+gxWtOa
	flXpR5jcuoyG2NjkkR5H/fW0V8egFjorHg0YsAWVySUX5Q3uxurAhFu+jMxEb6b/wWW/Wy2KLZ+
	o/ZFM3f6QMALz
X-Google-Smtp-Source: AGHT+IETIKdf3Z0Wz0kb7vvhIxjJ631Bn65PotPJy2hLIItCFoFXZ+HNwxPPI+ERwknB7gN9vkOykQ==
X-Received: by 2002:a05:6a20:e293:b0:24c:1f78:1803 with SMTP id adf61e73a8af0-2602c04a6a1mr18465135637.38.1757976483403;
        Mon, 15 Sep 2025 15:48:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4746dsm14461047b3a.29.2025.09.15.15.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:48:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/6] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Mon, 15 Sep 2025 15:47:56 -0700
Message-ID: <20250915224801.2961360-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915224801.2961360-1-ameryhung@gmail.com>
References: <20250915224801.2961360-1-ameryhung@gmail.com>
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


