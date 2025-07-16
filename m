Return-Path: <bpf+bounces-63456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D2B07AFF
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DE11C41E34
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36152F546D;
	Wed, 16 Jul 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S9CPoMhQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82181C6FFD
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682682; cv=none; b=evQULGnzziY9EeF30w+dsi9j7RCA1BCxDC90PieaGXRuGu1pL36rVKpvJ01ql7DMdHDJ+BG+P5JzejVkjd2twxWc1MXd9cyKsIRBS2Uk+cDBc6TdtM+D3yz9kJjhnKkfcfnREdrNXxT6NnVS09g+09T6tZpgfwzNyB5RQkLBu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682682; c=relaxed/simple;
	bh=CQedXGrKmdykac4YaLnbhtq7CIicSiqLXbemvBbNX38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cs3CFrAhGlkhy/ye1ZEZ4CDmIUGAO3VCkK3vSN7gM4JlFfJRLrt/yBA1VbRWe/wOdXdOttyHeUUA5G5OPh/8wiFovJYcGtfw8KmxgaJRy2RojBNVKF2hMYezbyuB1j2T7I7Rp0k7Ng5m3m9UEQOquE2PpUCSeJP2yF+cDA1pdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S9CPoMhQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso78970e87.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682679; x=1753287479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjjRd86Ns6huvNWopmDP1xFYphcXclHQgd6I/bKNdbY=;
        b=S9CPoMhQxmTq07N3p37oZxmQ2EKlj8H0uOUR5A3a9yVmwmae5gHOPzIqbHOOWBCgL7
         GBNaABncJfKqV5HU5Yeklg64BDjAz+oGA74EqtC3K56SO7+G+eGzy82rTFNf0cK+uGdT
         AvxEyB+V0i9K6aK4wq1lwcms0bw8EalbIuFINyXQYMsFZ38iRm6oRKujXBDHOnY6lVgw
         ZlGJNWOx8x5P/S049X/w/KDj9TOb8zIoVc6rHa4v7qCakw/WfQkMB47SRXusKfraMFoQ
         vhad1hhtvDNQMSfF1NzHcHoyJhjKUIHTZdQ1vhLU7pnNGCxlWGy8IqM08rlZ+dYqgUlI
         snBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682679; x=1753287479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjjRd86Ns6huvNWopmDP1xFYphcXclHQgd6I/bKNdbY=;
        b=B0/WZiuWXQlNp0PTgEMAefDiAh/nQ6tjmxuttjnMf+LgN4nOe9OotnJgMQuzatvO3o
         xHWSd0rYL7OUsQ1zF3B5FcTKqevWlFYmFBsmO1Yj6qsN/u6DJFlKoBG7yYEtsWgRAaFD
         9QlcaCGK1MY4DQo+fvtCukMcbBCYC83TO9G8Dv1P9FSLg2u1pUGqAagtF8KAEz26kGmn
         duFGaGla1cOzC7rP5Nlms2yDWvyiSjLY/puIBkjraBkSd0Ekl/A5Iclu6lhMDrcnNPZM
         8DKrRXk3IOA312qZCTWJfftvSAvSPlLCplB9BO/jBpmKv8VEqMCGQkIfiBGpXVLiB1Rj
         FYqg==
X-Gm-Message-State: AOJu0YyaW5bLw2up5w5vcMD14BaQYQ9oWYj+QQ6zWyiNLaswGNd9DYMW
	otDXo3g32m8+rsXiG0p10rBqDSfWx6AOS6HCVbS7TacnTzp73MWduZvqs92SEvdJnXY=
X-Gm-Gg: ASbGncvSPZ3zvWg366bTcKgsy+uDNDoupZpjPq75hFIXpe62OnNZUG/G7iLTFSMMx65
	JKV4Ne7YSDvtfPRYMpfeR+07GC8zklqkY1rFTYBSCLedOmIdn79D/rq/i4f7a/Do4MdfUG6V378
	MFPiRp7AdSFjno332nhvCB5QK0zMEGzuMAm+qQoGcOTQrKv//qwWT/n6j/lb+CqJRZg8M5pa1R5
	J87VUoXEUD7sjuqsgsMN4ONb0NG3/KKqPyp/C2yP9NnyV65Y+3jLodaQlMEa5qgJKS32e+uvep0
	JaipEoyzV5lF9yh9nYK2PuqhlevKI+8QyoydMdakAepy0nI3jEN6nNeygE0oRV34NQFIFzXvTAs
	opat32zSM2Y7PBjL4sZnA4Ua5LyP+k8lCNerj7w+msZDnqLSrIuHPOJ8Mp8xirt4g8Su7
X-Google-Smtp-Source: AGHT+IGdcxv1ceGPPMhEy0Psqab8ZRjckA0GTvm7Tkat8bvYlhq6widYQMrGmfvHG2qrThAFUbnZjA==
X-Received: by 2002:a05:6512:3b87:b0:553:2fec:b139 with SMTP id 2adb3069b0e04-55a23f1c2c4mr1261927e87.24.1752682678715;
        Wed, 16 Jul 2025 09:17:58 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7eaafcsm2709698e87.72.2025.07.16.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:17:56 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:49 +0200
Subject: [PATCH bpf-next v2 05/13] net: Clear skb metadata on handover from
 device to protocol
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-5-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

With the introduction of bpf_dynptr_from_skb_meta, all BPF programs
authorized to call skb kfuncs (bpf_kfunc_set_skb) now have access to the
skb metadata area.

These programs can read up to skb_shinfo(skb)->meta_len bytes located just
before skb_mac_header(skb), regardless of what data is currently there.

However, as the network stack processes the skb, headers may be added or
removed. Hence, we cannot assume that skb_mac_header() always marks the end
of the metadata area.

To avoid potential pitfalls, reset the skb metadata length to zero before
passing the skb to the protocol layers. This is a temporary measure until
we can make metadata persist through protocol processing.

The change is backward compatible as today only TC BPF programs can access
skb metadata through the __sk_buff->data_meta pointer.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7969fddc94e3..6546ee7c3799 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5839,6 +5839,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 #endif
 	skb_reset_redirect(skb);
+	skb_metadata_clear(skb);
 skip_classify:
 	if (pfmemalloc && !skb_pfmemalloc_protocol(skb))
 		goto drop;

-- 
2.43.0


