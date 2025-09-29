Return-Path: <bpf+bounces-69957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E818BA97F3
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE17D1C508C
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12573093A6;
	Mon, 29 Sep 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="X0/ene4x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A173090EF
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154972; cv=none; b=ZoJqB1RFLZwySJVpvu1fy8iYbvNkxjMj34PgCLNHkREbY4Ku7cAUYZaoiZns/6YgSIVO3OAyfsnZV7lYPKY0lQyAlKMsU/zpN7yC7ltOzhDT4eLDgoz/pfAP6/LfQhIOSFVXZYT/5kYpbK/Pd4NPcLFDto3eaoIkg9AZVMLz/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154972; c=relaxed/simple;
	bh=LnKIDmURCHrXO+bZl0REn8fNhnPuxeyT33DSF9nUmAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVB3i6Dyfn6Xz7RqBf4gLx5BN5yln6wC1eD2JsLG/9lnkwArK3ClQN5EtAXJLuSRuaeq7Dxyp1kV/PvqnGv+TcRWPETPcPUo2O8f72BgA1oixYQnlQLKoRTaK/tZ8SaNIvEo4bLZ5vZ6cNS4t9BGnOkTEzAo0W/FppVZi6aN1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=X0/ene4x; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e9d633b78so259772666b.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154969; x=1759759769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZ4DjAuKxb92rDpnIL1b/1L+IDNhOF6tFO3nnzSHV+Q=;
        b=X0/ene4x1h0NeMJ6H8t6SBzVhKf1gNqFiUOTEl++NXacq7tFBJkOoFKB4VakaJSo1S
         FsIeIdPOgnQp1hrkJJ0KxnUokZ69QhyIc+3+h95Les0pfn4qOnSPZ3NOMpiZZsBecYBl
         2zd2wfJi9a4jSb7ptjeyFvyEtkb2zdAGdiMEba6U2QJeV4wLoinSQVhiYr+yCX2XoUPt
         P+oUvaDBMrX99YAhWkMiVoaH/2JFd8b5e10AIFFOfkgYX3wXVpwpjQH/K4NF0UMU3lu8
         d+/uGb9gqYlcilJ+PEHN/TTE/3sphTytWjiNyHgCd0LqUKXv9uy9YhjR48b/96hXpNDb
         PvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154969; x=1759759769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZ4DjAuKxb92rDpnIL1b/1L+IDNhOF6tFO3nnzSHV+Q=;
        b=I9VNfT9IWER86VupabrsrsGJyRpc7fpq/P/9Zp7jtbwXa8tHVI4vhxrSm5IQyEcBkQ
         PBcQz18UJ1f5yAX0CqCfjdp5p0I2rNqrlmyvgGBsXfWmggXOgtrYMZj9xhJpcBW/Xc1U
         ZjutYh1n4EpQVMp0qDgA9JdT/OSgyx/4o5ZqO/9zKwux7m5KINN3QIXnIJAbyZkxUBUj
         2vfVuUjJCFe0Vky6N5MqqJlm5bX6f/QMJcfM7SVJXg5209pHtHgH4ZiRJFQwA0MKTgNl
         12296D7wu7UofsKaaWRabd8ZNTtdgpoCVxl08Mtdf3WaiO0aNMxhSvlyF6EUjqFRfeYP
         Pvsg==
X-Gm-Message-State: AOJu0YzKK32I4Y8B5Y3UeBM77stHr+EyZ7CGQsdAAjGAvwNYJTUxZU+f
	wXga63IamTu5gnjmaHtLmPfwrh/RnnJuD5ZHpmBNxj7TwPuyvO0eFmcxUX0L9vFu6AGqFpUY1ot
	DqYgx
X-Gm-Gg: ASbGncuC33gUP49w+Ny++T3/PZyhGbTnRXGtBbwX1SPtin84jvkjxIs1LGj2MJByC1Q
	LhDdXlskTGX5/yP5Zoq3EpiTXubSAFZhaaYDly2jVhZaEK0ocU3s1gZ9E5mC00j8k6lGCZkOBu3
	RF2QT4VSCqhh8nV7ddO0Uus0ngbWeLvIn8hrehfjdpLuoxpdw6XwLiXnJ/F6qFuRmE7TVwPiz+r
	Lf0ddltI3CGRT1fguQlzceVNMpiOSx2e3oVyRiLyBvdN+l3Zjz9TiKsUKMQm0Lq4k/zXPuof37g
	X1WYcPRyEgWyUjLSqyyAI3Ih+N2xsA1DfF1u5c9W6qkmh/GyYVj8xZebJtOaKtxe4ZIYkJvBpuu
	mOV94YcAa2e0NZgIvd0V+NBu0Wj0yZDVJ0ZQBlIWRs8ZrulJZe7sDpg7AHGPATzQDhrKgodI=
X-Google-Smtp-Source: AGHT+IHOfwLm8x/y8zlAEPKM9KqmIBGhakNXV8bSeJGJmKavuIGPkDmfd4zMqOYaSXYDjudEB+g3sQ==
X-Received: by 2002:a17:906:f58b:b0:b40:7305:b93d with SMTP id a640c23a62f3a-b4138e50d14mr75980266b.2.1759154968908;
        Mon, 29 Sep 2025 07:09:28 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f575aa347sm163293466b.57.2025.09.29.07.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:11 +0200
Subject: [PATCH RFC bpf-next 6/9] bpf: Make bpf_skb_adjust_room
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-6-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

bpf_skb_adjust_room() may push or pull bytes from skb->data. In both cases,
skb metadata must be moved accordingly to stay accessible.

Replace existing memmove() calls, which only move payload, with a helper
that also handles metadata. Reserve enough space for metadata to fit after
skb_push.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2af0a5f1d748..030349179b5a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3251,11 +3251,11 @@ static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
 
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
-	/* Caller already did skb_cow() with len as headroom,
+	/* Caller already did skb_cow() with meta_len+len as headroom,
 	 * so no need to do it here.
 	 */
 	skb_push(skb, len);
-	memmove(skb->data, skb->data + len, off);
+	skb_postpush_data_move(skb, len, off);
 	memset(skb->data + off, 0, len);
 
 	/* No skb_postpush_rcsum(skb, skb->data + off, len)
@@ -3279,7 +3279,7 @@ static int bpf_skb_generic_pop(struct sk_buff *skb, u32 off, u32 len)
 	old_data = skb->data;
 	__skb_pull(skb, len);
 	skb_postpull_rcsum(skb, old_data + off, len);
-	memmove(skb->data, old_data, off);
+	skb_postpull_data_move(skb, len, off);
 
 	return 0;
 }
@@ -3487,6 +3487,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	u8 inner_mac_len = flags >> BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
 	bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
 	u16 mac_len = 0, inner_net = 0, inner_trans = 0;
+	const u8 meta_len = skb_metadata_len(skb);
 	unsigned int gso_type = SKB_GSO_DODGY;
 	int ret;
 
@@ -3497,7 +3498,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
-	ret = skb_cow_head(skb, len_diff);
+	ret = skb_cow_head(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
 

-- 
2.43.0


