Return-Path: <bpf+bounces-69291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6DDB93977
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1972A1335
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5130C36F;
	Mon, 22 Sep 2025 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpDM9RQb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D392FBDF5
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584043; cv=none; b=eFIedaUWkn7UdOr+cyeo3ADNs6wm/OW1WbExQ+i3ZFTjjfLrSs+ZIFxx+23bj23QU5w/GvHmDYRNHX4x+7TQbOZX9w7gbyOgqgv3vfFmOsCf+3/KjjONQXwDqxI7XDO950YQZIOlIpwzz8EwrXH1a3jY4D12szYgF6Gr1TEcmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584043; c=relaxed/simple;
	bh=QT1OxvFzYMzM6OcwsqTEVAKPvIGo14cYjHyx6pUnodg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fv4KF6eLO3eF8vWe3RN15lLEllTfxgPOwxmr4lt3T+iMKmKEoSaEVy7vK2feo+iJYOm/As330IKVjEPv3eBbmIU3/hbHhb4KZ1cK1i5gkdE8sKzXJc5WQN57Wj+j2n6iG5y9uKifcuXmNSDOon5fCCBYpV9XzJMAiYOmqsuUv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpDM9RQb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so3912775a91.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584040; x=1759188840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBj+8VmMwExg8fdqUUrm8/QTD38AlKZkUFapbcBKrsI=;
        b=JpDM9RQbVdNdqiVfgow5+q2sHO9raXfPFqR1+muk2eoiH4qQcd/KTJR49sCYd4PRh6
         pvp/J2I0UVucg/1s3NNk0NLd9DrMdvFVkr36l6ybJaJLrQg5D/TAcx+wT37isJQV3TsE
         tUsOLNl5hluux0Ggt2KxomW+r3y550F02hjf3Lk5kN/++qSmA8VoHWo677Qz/fMK8OUh
         wN/gUlyQk17svedHhT5H7T5xvLdXCNoIMaCHCz4376nwBqKOy+wxb8DLgUljJ9EQyuRP
         rbV/5Na7UISjLsIyzXdyCCjzpt925JVQ9KzAgsN5YmKQm5CcK+8TrRRG0WqROY1KV0oe
         agSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584040; x=1759188840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBj+8VmMwExg8fdqUUrm8/QTD38AlKZkUFapbcBKrsI=;
        b=J8ATX7C/E5GI1zK1ILyJmv6WqRAkH6m0VSejKCSQ29e4t1MXGFyFfTSmUVXrbTvWGA
         jPOhw944Gd3KvtZFgbeOE8yAFCInrzNoZG5OAt1ssHyPrzsH7kQOErphEGBGrpKdFklx
         IGHU66phez0GxKN/eBsD2CJvO2wdIk3sRN1KY83vzYLOSmcXaTnX8bw+kA29rSSe3QTM
         1qY2n3ObBjKH2KGVIfCLxyUQJ1+W8wMSWreJojWLRWhhuMsV2gO+ehpjCondGsQxXbhC
         zEzcOfXQX8JVMD51uEkJG85jRoMlW1fIT2pTIonsyriJ1f7VT+ebn9G4/mAlMqSvdPhN
         pnpQ==
X-Gm-Message-State: AOJu0YymYp94WqFmddqRpEwk7i27hGBF45lmds/2HrFEBL5UGpme9I5D
	uRjwI/2xHNBfwRa66RSNdP4RNxsT7GPKWrENh5CtYhTjjjJOp4psdDdLMo/SGA==
X-Gm-Gg: ASbGncv7P9lGuuQsaYK/LKbwHA9KCU99SGoC3tdT6nB1KZ9hpeSETOXdC/2FIIl+8cL
	KkOeRugN170rwv/CVQ2LNsrh/XWN/wzdOnCzup08e34o7odUL7KmwJ4aCuHZ0zS6zCDIO1h4afR
	T3TJGP1x07KiaJc7wWwveGVI7MTj6/eenvTUPeWlBgZ+fAh/gWMWDOh5Kpjs7/xkorKJyLxlO/r
	B94mEPC0TZr4mLDqK+bY33Z24fjRJF+hGV2TOK/Oe4Rs/HwK6HZSZ1V1oN52IAmU1TylLkhITnt
	XbLA6vi4+VlJxyIcVBhs4PJWZ4NavF7GiCteapz8fwiJruxVNjFM9fuMtS5tUCTH/5UKXnQCt2R
	HSoOxireYbXJmsA==
X-Google-Smtp-Source: AGHT+IEeG1u70MWIN99s7lDb54fcmLQILv2BTIbWtuUQ2vqyR+1P6LuGkETyMKGFgriMkEsFYF3Myg==
X-Received: by 2002:a17:90b:1cc8:b0:327:83e1:5bf with SMTP id 98e67ed59e1d1-332a95b7a74mr616956a91.28.1758584039677;
        Mon, 22 Sep 2025 16:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4d204aa7sm1467595b3a.44.2025.09.22.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:33:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/8] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Mon, 22 Sep 2025 16:33:50 -0700
Message-ID: <20250922233356.3356453-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
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

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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


