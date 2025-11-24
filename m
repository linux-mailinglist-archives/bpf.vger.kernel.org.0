Return-Path: <bpf+bounces-75360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF13DC8192A
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266523ABD7E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509631A549;
	Mon, 24 Nov 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TSiPbOA2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562C3191D7
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001766; cv=none; b=D4RVPUjY5pvnQ7ZTCN3N/pavveQsUgCdeoykjNCGFrHzx4Y+S4F3L14NzX14ae2hl/bI2Z+L+3KJtjFnxKvSvjE2K6RD/QND0zh2enJ666YaFCC03r/6Ni3JJh5JVMsKTRGTbkghZv874vx40plMGEgqKimGRi3TApJBPpzG8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001766; c=relaxed/simple;
	bh=Wyp2c7afjxG5aRTuOcbLGQJv2HFkqYrJUx3yuysNroE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQbRosrPzyEKtB+WKZit/VHozfpHpDpvliluUjcoU0Fya69iysRoocu3OevDwMvzSN2nWjouV7t9RaE/Y11zQ7wHgv8gt9eIQZEmMPGSj+t3CLqJcZbxTrGHfu25IwVyDwDo/ZWMvkumjarul0A7HUnUf0v90yifwnCjetHYtTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TSiPbOA2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so7264829a12.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001762; x=1764606562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2sSFInHlM/AK58dJylVSwye8HIxOazaFEZpX6BWWww=;
        b=TSiPbOA2D4pvC7IMekL4qmuBjPjVyKV/hZhUZhxZiVz7tAjwzqF/9uSHP0oB57Phmc
         DwfaVdu8NZGUHYe1L7DcQyxpHWB9RZI56CaAqgF554iEZC5pzfHtHn5rrnuqhI7hjGj/
         my5y17hrXhfrSWrxEAK/tkB2JuoDZp6Rne1CfBpg+0VB6WZBqCjzADU70hSFs7kaNcHg
         8w7ijnrbKKcJzfimSt5abQs5SD5aNx2Nznl8ul3kIPShMPKJmTFICsV20FdwNI12I9bQ
         dxbVx1pAMXo1/gPwoPK2oOw9SpyhLHy0Ays1WJr0ipEXBdeLY6ReaI7YtMg0m7CPEhjR
         WE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001762; x=1764606562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I2sSFInHlM/AK58dJylVSwye8HIxOazaFEZpX6BWWww=;
        b=L6aTR8fO4+cc44XSUCfmUddMWUXvLf00t0WGLzdAXqpC3LfhEgzn9JtbTqfzbvdK0J
         Wl3VcKoE3jzNPyqUFz1dYviby4deqG7X6UkjTiD6sGnK3Salwwq8tW+tJq0QMv4DeAyi
         xT+Z48okjfX5vMnrwz6upshaC11RztJcn3GG1STfpCokAbow5gXe2ds6FflnS5e1OqLd
         WgcYh6poMxW5Q5ccuxI8WPQpRFQzsWDOL4r0gYh7SRvHia1ao7IcPz9mlmheUCv73xpy
         pFjO+q8iPQlaMMzUzvrfoj/rQ6HLJHj+9rJT6JZsqZCh/r3GD3ho1x8cytFTBHjhQg7F
         3Eug==
X-Gm-Message-State: AOJu0YzWSMoRDmH2GjT4cTzMT6j2VMMafxx3URPFPFX2Xapl2A2txAJI
	RWw+POTXXJa9IRBgSpvc8x3RJXRRxxx4jXKTe1m1d2BgR5bCbykzSyEvOyldePb+oa+CQVsqre4
	+y+V0
X-Gm-Gg: ASbGnct2oKk//FPD9T75FgQ+3j6lEeFFhyeaHEqI7jw6nPrpEUq18jgKLtSOKbnSfYb
	4CsQhyzuXbCnnV7shtQX10vI/HYlPbycjf4EI7CgsyEqstqqHRknu2VoFu7Oy0xLyoNFdVytuXU
	EoRQ80y4Iq+V8gr/3VS/FmBPmC9ZlCA+aUcruyW+cN3Ofi4zzfUHaL5HBc7iD4R7+vLj3Rli/Vd
	1N1K1rs0ko63bh/oUeiF9Ig/TDqWptVf8Xt+9VXdKPEZQNnIAyJeKJdsZD/O3ZYz+hsRVl/JOF0
	wK6iJ1ALld2wKUvKoKK1p7u51J0liZL2Cc19eFkW3YtGc2QfFvdDp/BeshF6uSWHbLchjtt0lUI
	vkq+A1Sawk6qJU+B707ERkFbh+Ln3IXlghW+pC8eHpQwN2er+60MMdYRATnTTcROhDj3zgq+CMO
	ooN1OA+gG4fRiHVZIpHq39tuaYygVy/s0h2azWJrZXNijHacQdUAd9CchRF1XZ5aIt6ts=
X-Google-Smtp-Source: AGHT+IE7ZcnenAoJ8luw8qF0IF2vkCOG/KRUrnzomrLYF/000Yko9RSYdTSLc3bTXcV0GQAy8lbDXw==
X-Received: by 2002:a05:6402:2787:b0:641:2a61:7da2 with SMTP id 4fb4d7f45d1cf-64555be1db0mr10896236a12.17.1764001762368;
        Mon, 24 Nov 2025 08:29:22 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363aca03sm13481816a12.3.2025.11.24.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:22 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:46 +0100
Subject: [PATCH RFC bpf-next 10/15] net: Track skb metadata end separately
 from MAC offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-10-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
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
index ff90281ddf90..8868db976e1f 100644
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
index 4f4d7ab7057f..7142487644c3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2306,6 +2306,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 #endif
 	skb->tail	      += off;
 	skb_headers_offset_update(skb, nhead);
+	skb_shinfo(skb)->meta_end += nhead;
 	skb->cloned   = 0;
 	skb->hdr_len  = 0;
 	skb->nohdr    = 0;
@@ -6219,8 +6220,7 @@ EXPORT_SYMBOL_GPL(skb_scrub_packet);
 
 static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 {
-	int mac_len, meta_len;
-	void *meta;
+	int mac_len;
 
 	if (skb_cow(skb, skb_headroom(skb)) < 0) {
 		kfree_skb(skb);
@@ -6233,12 +6233,6 @@ static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
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


