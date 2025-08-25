Return-Path: <bpf+bounces-66439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B0B34B02
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E595F1886C9A
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1A2836BE;
	Mon, 25 Aug 2025 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZyA4zjR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18848284B3C;
	Mon, 25 Aug 2025 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150765; cv=none; b=oSH8jCk2fVVUWDjmhjjrYMa3CD0gO4SmZ20HqaYLzidvj+PS7b7xeu9tzHz09Ylyx3FyskmPWKaU3469UsnVHlvQ6Va9T4xuS0xX+z1DT1i8CmTdXVJpxlgPdG1gs4gLG04P+Uq0CkQMRSOHESQXuHmiPvpJ1hehOkMQRdG0a/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150765; c=relaxed/simple;
	bh=TTpDlS1ZRYbPSTuC9ZqT8IQi34r8sgCAMkP96tT5zlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTK3B4W6B07whfg+syBJ0h1K2E/956Ys+GvRu6VDypiBIjH4k7lt0vktntkIvRX5iJ5+8N7lmCFKmTVu5TrB/kCUU6szY7SsSMdAi4Ny5dVRWXfCeBUG/32Miiwgx4aSkTqJyBFppf2giWvRqkQQdPgHUDR2zYMkWaxjpbTk+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZyA4zjR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7704f3c4708so2311464b3a.1;
        Mon, 25 Aug 2025 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150763; x=1756755563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNeNymeATke21xlhnLSoEPtrE1abxvuh4ER1WQ8iiqM=;
        b=aZyA4zjR4FLWmQnRj5oH5do3j3KPCqrZeF2wEIfXrW16iLsXAcutpcUj4qMTnrL1XS
         ANvo36hVIwNkPxsU+Kj9Oc1+1G278wIDT8kYN9HZswKkPHliSyu447eSfkkCu5O5npwp
         PKO2eDf4qcOLa5uL2C17RqI8Xzx6b1MXs9kD6Dv7jpoVSObCi54kbb0Dw1nW8YhrZmkf
         IoGzz4G5sit3j7/2VC7ZzwBkeMF2m3qiXdrRwPUXqvOsiHYOd0MN26+LGeoKXSpYkZRM
         NyXNK44ZxUIR0XwM/XzPKhnuLzi7GuEx76WZygiaV9UnXzr4TeU0HeVwVj5ZNOmlKImD
         8K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150763; x=1756755563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNeNymeATke21xlhnLSoEPtrE1abxvuh4ER1WQ8iiqM=;
        b=SCXkU0G2khqCuat1Fv7ArgnTOud3lCOV13Hg0kntJvFYY7AWYYubDOvYZUjX/HKazK
         0wn3rertMqD8ShHDzU82Q7wO425/bdQu5z3TMRWhY//ReMdalakW4WnZiZJ+gYs+xoD4
         zpnTIYK/pHOOcvTtsidW3kweW3eKdoRc6ARIvGCFnkwsSly+YEDsR9nypJ08jegnvfFQ
         R4enaUoMJT0l5+42Tg4Utr0kylNGkMi8tNqagQsGRVsAK6rb12Ok+Eahf+nIEzn473uX
         ni6EFS0gzkMdjQUYgOf3gBTKBQiCToMAsLYQfS5pVHgVBLjXzjGOMVffOYs3eTlIr2co
         A+YA==
X-Gm-Message-State: AOJu0YxWcYDn27jps9P/71FwsChdimke6urcrsK3OjK1eWWrwLHUQEim
	GOKXGg20Extf6MP1xRPhzBhhvR8VuAxGsPITmVLaJVFj1S/TaFg8nABUeuyU/g==
X-Gm-Gg: ASbGncusD8jVPEia15V9PWQ7n+nbU+JPe40WtZlTMuUiN9+ygXRVO6i93+6dgvZO1v7
	KUrwUgSojMLHj+ej4/gVpwh3G+Xi+7w2qcTZmBtIBTVUd+NFew66KN1m94OXI7JFPvQ91sTpeyH
	vVATFPIVQ4lNOj5eAymNCkFXladIp1vWKVgYy8jVTB5T697IOQmzcuWmZN39fNyj+gRzTUOp2Ld
	k8ivpG70SGDLON/UcxA09JZ5l3LX/uhgeZ2vp8OuiTR/4j0l8DvVaC2ADbcWACHMkq9Hht6kIDL
	6dmfxkCwZPvSqYS8L+QQNwmwdwP5jMu7b/NDAMv8oLG0St7jg1vjrvwj8DMgulyElNqnD9UCYIx
	sQf98vHOKaM5VTQ==
X-Google-Smtp-Source: AGHT+IF0FPW8o5Vw3VlfxMCwIsBMgMsT63WEtN87J0k+en+ROz/5P9/mbanlMcFxkFuenxwCIU4Gxg==
X-Received: by 2002:a05:6a00:148e:b0:771:f4d4:24fa with SMTP id d2e1a72fcca58-771f4d4290bmr1176331b3a.18.1756150763152;
        Mon, 25 Aug 2025 12:39:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770586b2f23sm4808906b3a.110.2025.08.25.12.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:39:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 2/7] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Mon, 25 Aug 2025 12:39:13 -0700
Message-ID: <20250825193918.3445531-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
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
 net/core/filter.c          | 29 +++++++++++++++++------------
 2 files changed, 35 insertions(+), 15 deletions(-)

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
index 63f3baee2daf..f0ee5aec7977 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4153,34 +4153,43 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
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
 
 	if (release)
 		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
-
 out:
+	if (!release) {
+		if (!tail)
+			skb_frag_off_add(frag, shrink);
+		skb_frag_size_sub(frag, shrink);
+	}
+
 	return release;
 }
 
@@ -4198,12 +4207,8 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
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


