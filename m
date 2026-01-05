Return-Path: <bpf+bounces-77824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E3CF3772
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33F3930131E5
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B97337110;
	Mon,  5 Jan 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KoGknOQi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E8334C3C
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615295; cv=none; b=VAVAWlpv9lkUR5QlGV/Q9FX5Dg7i+qHrA2bcMFboNuMlwiNdYfxeNvrU3Z72cYGEgOzYos/OTa6a+jjfwnweM7EJNihiOrADxJtCzpOjrP92kCEgPwDVq4RQLN0X/OvQhwZUE6tRYsbkFYzqRvL3ZP2SbBzyQwK1E1OIJsucORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615295; c=relaxed/simple;
	bh=WT/cVrduuTUnevhi7OdGjx/0N6WuyL4V30i0R0DiyjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmfIB6Nuj9dHw4CPTbLTsrlCiTA5Ukrp3oC70FmsVn6Pyb4m+aKMYMztEs5OCcRz1NGAR1crlvkTgRD592//Bq1EWwOwlGVktZ6/bgMxREddUerF1+tIHGql2A3DV2GBqDfQJfgi9AiW1AxFWPhc4v0uXHu+Qx35uYbcDPaac0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KoGknOQi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so20553415a12.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615292; x=1768220092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l2Lii3KJnfBvilvcH77hhKV1TnL2JWP++fNz6VDxQ0=;
        b=KoGknOQi01G9iz9+JuLuuSQdaM5LJiKuK9s2Jo6ZIlj+oX2voQinU1MX7JBZhPVpS1
         m+U0qEnQAs148cJqGC0BDZ9S/GBU7dQygi3SE9GoK2kUsL44Jp2xDEML+WmqMNjjTIoc
         FwlmuXE0G9031qOcU+eDrvjHWNc2Y29ES40X5PSyNHKlIpsZz+wEW5jLmHBHfUQedD04
         i0XJSPqrsHj6PXbLr0hf2UOpy28rWEyC4+xUv2EMnUvzPmb3E19h8jI3yx7uIrOMGFYo
         HUn7IZFJhNASHJ8DYc6Rv8jg3XhiGdvRCscLFX9WoB1uUGgwx7QyV0ZFbQxKQtTcvcvu
         F9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615292; x=1768220092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2l2Lii3KJnfBvilvcH77hhKV1TnL2JWP++fNz6VDxQ0=;
        b=ElZvY3PTNVi11kHz15Wlh1UY3x6Bm5Qj1VdWZ67+36F0+yva4ql9zfVQ6OUx9KI7uM
         OHApwSKHolUjS8rpvhFyqoZ0ul4PzKJLZH6GZhNLzZ6pSGvADHiNfo4IRfQTVu0V4GxP
         Ejdd5U4D13LWkOI5uoOURMZAbDoa8waTCEDU+Q83D2OjObx/qash4UwZSZZOdOoRikVw
         /Ic1hmhSYcuJVStmgBgSMsQXCi+ctqPRR1pPXlIHFwPul3mn5MFOLN1NCMt0MhfCXJho
         3PFwWUk8NpRyUzmhVYZqeGSsVzkHBiIRkfD5zcvGI/UHA/M1EKmV+WeCkmk50geWA/Qj
         xDnA==
X-Gm-Message-State: AOJu0Yy1CY8nJIfc1A3b1cXMBC+wU5L3wOpWRUQUlhOHGM2LdOy2gmXp
	GNRSaoz0Ek+XQyi9/ygLfHeUL5+G/78Y7z45N+rZTGxCcISnqWzz4nH7P8poozww8vk=
X-Gm-Gg: AY/fxX4/4teQcNQyYDHjTUt5B0K+G/gHkXQ7L/uj99QfFOvSzxlZ7POKIuWuQTiTflL
	oXrPZvQBLXIoh74zaJ/sqfB/zLCMErY7/+pVRYz8osCpxBjA3VkaH8RuP7B+mwkPWtlsQJP7Zes
	0+lHp6l/EPp9Ahk+54o2ZK0DHldN+gF8gUONBoQRCoROzyhaYiB3ctsviNjTy7s4elWYgithdRn
	b5rGuoSXmh3p2ShEMYaGibueE5z7e15O+LXvCBSKXo1tM+EJRfuvd4ILCnaWyrlkbtylB+rZQ35
	P9PKTATgHfJAgoiTHsvWAmfHbm9Xqt9ot/F9syJzWwt+xnQh9qHl5kvDpyQT9P7kCLM3lkELYOU
	6yohw7Nlc4Fzig4ATlXaJAqolNUKrmzDZxI9Y/MpvafW8W0Y01T7MffVA4qnqFKsiDoBZEGZU2J
	HhLU223CF+I81p7GimEDB/5XowIW4hzc2VGnPNW25nr5VZcY1sKf2g5vEP9Uw=
X-Google-Smtp-Source: AGHT+IE6usG6dN1WjdekNLpeXX7TucAmbhaMtzlCTTFZzi++3OE5CBHzslaNH4XAYVabpuC6tCx86w==
X-Received: by 2002:a17:907:268c:b0:b76:49ae:6ee6 with SMTP id a640c23a62f3a-b8036f590d6mr5397903766b.15.1767615291730;
        Mon, 05 Jan 2026 04:14:51 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad1e6dsm5622781066b.21.2026.01.05.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:51 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:35 +0100
Subject: [PATCH bpf-next v2 10/16] net: Track skb metadata end separately
 from MAC offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-10-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Currently skb metadata location is derived from the MAC header offset.
This breaks when L2 tunnel/tagging devices (VLAN, GRE, etc.) reset the MAC
offset after pulling the encapsulation header, making the metadata
inaccessible.

A naive fix would be to move metadata on every skb_pull() path. However, we
can avoid a memmove on L2 decapsulation if we can locate metadata
independently of the MAC offset.

Introduce a meta_end field in skb_shared_info to track where metadata ends,
decoupling it from mac_header. The new field takes 2 bytes out of the
existing 4 byte hole, with structure size unchanged if we reorder the
gso_type field.

Update skb_metadata_set() to record meta_end at the time of the call, and
adjust skb_data_move() and pskb_expand_head() to keep meta_end in sync with
head buffer layout.

Remove the now-unneeded metadata adjustment in skb_reorder_vlan_header().

Note that this breaks BPF skb metadata access through skb->data_meta when
there is a gap between meta_end and skb->data. Following BPF verifier
changes address this.

Also, we still need to relocate the metadata on encapsulation on forward
path. VLAN and QinQ have already been patched when fixing TC BPF helpers
[1], but other tagging/tunnel code still requires similar changes. This
will be done as a follow up.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 14 ++++++++++++--
 net/core/skbuff.c      | 10 ++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d..6dd09f55a975 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -595,15 +595,16 @@ struct skb_shared_info {
 	__u8		meta_len;
 	__u8		nr_frags;
 	__u8		tx_flags;
+	u16		meta_end;
 	unsigned short	gso_size;
 	/* Warning: this field is not always filled in (UFO)! */
 	unsigned short	gso_segs;
+	unsigned int	gso_type;
 	struct sk_buff	*frag_list;
 	union {
 		struct skb_shared_hwtstamps hwtstamps;
 		struct xsk_tx_metadata_compl xsk_meta;
 	};
-	unsigned int	gso_type;
 	u32		tskey;
 
 	/*
@@ -4499,7 +4500,7 @@ static inline u8 skb_metadata_len(const struct sk_buff *skb)
 
 static inline void *skb_metadata_end(const struct sk_buff *skb)
 {
-	return skb_mac_header(skb);
+	return skb->head + skb_shinfo(skb)->meta_end;
 }
 
 static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
@@ -4554,8 +4555,16 @@ static inline bool skb_metadata_differs(const struct sk_buff *skb_a,
 	       true : __skb_metadata_differs(skb_a, skb_b, len_a);
 }
 
+/**
+ * skb_metadata_set - Record packet metadata length and location.
+ * @skb: packet carrying the metadata
+ * @meta_len: number of bytes of metadata preceding skb->data
+ *
+ * Must be called when skb->data already points past the metadata area.
+ */
 static inline void skb_metadata_set(struct sk_buff *skb, u8 meta_len)
 {
+	skb_shinfo(skb)->meta_end = skb_headroom(skb);
 	skb_shinfo(skb)->meta_len = meta_len;
 }
 
@@ -4601,6 +4610,7 @@ static inline void skb_data_move(struct sk_buff *skb, const int len,
 	}
 
 	memmove(meta + len, meta, meta_len + n);
+	skb_shinfo(skb)->meta_end += len;
 	return;
 
 no_metadata:
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a00808f7be6a..afff023e70b1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2325,6 +2325,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 #endif
 	skb->tail	      += off;
 	skb_headers_offset_update(skb, nhead);
+	skb_shinfo(skb)->meta_end += nhead;
 	skb->cloned   = 0;
 	skb->hdr_len  = 0;
 	skb->nohdr    = 0;
@@ -6238,8 +6239,7 @@ EXPORT_SYMBOL_GPL(skb_scrub_packet);
 
 static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 {
-	int mac_len, meta_len;
-	void *meta;
+	int mac_len;
 
 	if (skb_cow(skb, skb_headroom(skb)) < 0) {
 		kfree_skb(skb);
@@ -6252,12 +6252,6 @@ static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 			mac_len - VLAN_HLEN - ETH_TLEN);
 	}
 
-	meta_len = skb_metadata_len(skb);
-	if (meta_len) {
-		meta = skb_metadata_end(skb) - meta_len;
-		memmove(meta + VLAN_HLEN, meta, meta_len);
-	}
-
 	skb->mac_header += VLAN_HLEN;
 	return skb;
 }

-- 
2.43.0


