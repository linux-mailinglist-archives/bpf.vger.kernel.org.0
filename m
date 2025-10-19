Return-Path: <bpf+bounces-71296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31107BEE53F
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B5C3A4E7A
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEBE2E8DE7;
	Sun, 19 Oct 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BlRzTJvX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECF2E8B76
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877945; cv=none; b=fXdHnX0e0gHZAy8ceAqZMkDW5n7ynX7Q8dO8DCnez7qoc4B7lD0yn995T8F5YhuFFcQ8HNFcXuGe+rdhI+Q/zLGynuA5J/TxAtUvIbXBQz3KvMERjt6BvZL3QoCDZzczzSMTBejQH06diKIMlhNJZZIr2sbsLLuWcU5MoyziA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877945; c=relaxed/simple;
	bh=4FM5pTwRyNDxGKVJYoT9oserXe9/LVm7gaunHIrA810=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y58UJDyXLx8vwBwiOafzgJZORmYEsuRJuoBAV3552hjwlfKuJfceRVolx686l1BhKQRV21tkyzEUu+cjxF87GPErlh8y8rRSYoUVKbGT03Gwz76TtoyiQlMHI3sWkaMhiVrm4Us3GEbmzswsnYB2q5CRvGVl+IG3z3PWuCyd774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BlRzTJvX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3d50882cc2so651752766b.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877942; x=1761482742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPijv+eQjDmgih+DpQJQJFNWzM+qXCvpQajzPenBLoM=;
        b=BlRzTJvXL4+2sQyoA0uQrSi5V2Ll8bZoVgqdKcRVDhv/FZdQIxzZWUpG+y4MmyydVX
         qhRN3wnnMawiYBQHhBE3CEJi/Wl9E9yA6lvDSKabU6+grqblLCw5qh2WIF+e4mzIV8US
         4NaH0asFF9mpW2/rXHtLZE5mf2pbPkSboYyxo3nBEz9C5sDb3efymr7W0xLl3ajIm1M9
         wr09AJySoTKTGnRqxSTbORihVeFPxJH8TVBgqi8/hZD1LV/E0oUrtqrdNh4PatSydrGn
         g2hIdEneGHbSyLSBddCi5zsbV1qUz4kDQn+gsshMkG1WUZ6HmC5ly9jzgEN7n/hhoQH3
         tgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877942; x=1761482742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPijv+eQjDmgih+DpQJQJFNWzM+qXCvpQajzPenBLoM=;
        b=Xiz1Q61UPTP31kxqIyBeReWLTtm4MCwIB3dI+bsMbEXqrXn+y9elS5r+1p34+xfpMJ
         ciq0BgitXZDJWTPP8EdhbbhiPXk6WEJ5xGH5fvzPgXCfsTeuqkKxrrCNj/OoOM/nucpN
         hPuGogqmzW9jnlehQ1glikw3AjQ+YjxflQo6sRzeBkEVuq9oYGdiQZwyX2gzEL9Ta010
         HopSpdaEsqlR4Js7giw0Sp172BoSFvmFU+LG5ggGE1PTYGeG+mE9YaHhrN0swIq1L5ou
         xrdqLiEdjHi3CVpcddfKCKu/qFTAHHYMkG/5ZJyEHI8K5/4dlnry2os3oeGpE+NYE2kw
         7RSA==
X-Gm-Message-State: AOJu0YzCwqof0VeQp1TUtQi2R8+AZhTyKRATK2n5bo0cuUdYmfRcghCz
	sbiQBhUYM6RQYmWL4suMLb2EXKeqzmzK4JVg+2mtKsLju0Hez0dxMcvEeIAYeetDBNg=
X-Gm-Gg: ASbGncsO3LLbduFPWjewAsUGl0BeFYiFFeuRnNG00gpBuaHEzsl94rlema/crXmw3qk
	eHMQx57RToVTlZpfVch2MtpSFFhVW8lU6jz+OJZ7x8sAvleHTdoQnM+kx1wU/eDldi3UJil3sD3
	Dpqdfrjk1JKIzfmwhpLKVI1VXFehPX/DpH8XATL41Jxo0rDRa3raIjcKIjFgHkRd2mHUMLEKB2p
	MFzZStQRFGLtj/zp4UAu5rV+3OsKD9C1ExIwUnhZ0zdrzBlgGc0E27nDWlCjgAsSzJWKnF+CFK1
	fn2Xa2BQgp0H9k5y/ZzfDGScESLttWIUERqPgd45ZpdNHy/Z7nUbm82CFG5mE9f2WyuUmNA/BQb
	P6r0vKWV5vRW7+a8qx2+vnUTQTBz2yBnMqpbP57MB8N9Gf6Wz8v0g9qoxFTu2C4CAUZJrpMz4/m
	wv7f00GRaMnikC9gNTUyNcQHTI0BnYd6/vgKkwfpysvY3OJnhR
X-Google-Smtp-Source: AGHT+IEBNRih2WL6eZLwqgUZiAfDtnFB6140e6RbS45QXX1oWPSZjQKAqFHJ3k16cAJboJyl7lPezA==
X-Received: by 2002:a17:907:6d25:b0:b45:cd43:8a93 with SMTP id a640c23a62f3a-b6474833449mr1160088266b.62.1760877941875;
        Sun, 19 Oct 2025 05:45:41 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914fasm492050666b.20.2025.10.19.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:26 +0200
Subject: [PATCH bpf-next v2 02/15] net: Helper to move packet data and
 metadata after skb_push/pull
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-2-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Lay groundwork for fixing BPF helpers available to TC(X) programs.

When skb_push() or skb_pull() is called in a TC(X) ingress BPF program, the
skb metadata must be kept in front of the MAC header. Otherwise, BPF
programs using the __sk_buff->data_meta pseudo-pointer lose access to it.

Introduce a helper that moves both metadata and a specified number of
packet data bytes together, suitable as a drop-in replacement for
memmove().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fb3fec9affaa..1a0c9fbbbb92 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4561,6 +4561,80 @@ static inline void skb_metadata_clear(struct sk_buff *skb)
 	skb_metadata_set(skb, 0);
 }
 
+/**
+ * skb_data_move - Move packet data and metadata after skb_push() or skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed or pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push/pull &sk_buff->data
+ *
+ * Moves both packet data (@n bytes) and metadata. Assumes metadata is located
+ * immediately before &sk_buff->data prior to the push/pull, and that sufficient
+ * headroom exists to hold it after an skb_push(). Otherwise, metadata is
+ * cleared and a one-time warning is issued.
+ *
+ * Use skb_postpull_data_move() or skb_postpush_data_move() instead of calling
+ * this helper directly.
+ */
+static inline void skb_data_move(struct sk_buff *skb, const int len,
+				 const unsigned int n)
+{
+	const u8 meta_len = skb_metadata_len(skb);
+	u8 *meta, *meta_end;
+
+	if (!len || (!n && !meta_len))
+		return;
+
+	if (!meta_len)
+		goto no_metadata;
+
+	meta_end = skb_metadata_end(skb);
+	meta = meta_end - meta_len;
+
+	if (WARN_ON_ONCE(meta_end + len != skb->data ||
+			 meta_len > skb_headroom(skb))) {
+		skb_metadata_clear(skb);
+		goto no_metadata;
+	}
+
+	memmove(meta + len, meta, meta_len + n);
+	return;
+
+no_metadata:
+	memmove(skb->data, skb->data - len, n);
+}
+
+/**
+ * skb_postpull_data_move - Move packet data and metadata after skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-pull &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpull_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, len, n);
+}
+
+/**
+ * skb_postpush_data_move - Move packet data and metadata after skb_push().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed onto &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpush_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, -len, n);
+}
+
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 
 #ifdef CONFIG_NETWORK_PHY_TIMESTAMPING

-- 
2.43.0


