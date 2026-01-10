Return-Path: <bpf+bounces-78481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D28D0DDA6
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F04A3046F81
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9882C15BB;
	Sat, 10 Jan 2026 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z16p81V/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339882417FB
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079127; cv=none; b=Mi5S1uNuhscRoZE64f1A7tQt27hMZIFT6U2vBP8SrV7rIOc1pn71FycLXa+dkiqZjwO7sUAcs5cS9MkvW/WEZ06yEwda1JoVvkz8XIHZ/TTNSGnSmB0M4+b8q3AqODDao3Cl20SD5j0pRq5UoSPUfKImms/k53iNUBV5PUSwG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079127; c=relaxed/simple;
	bh=DMSsZ2zhnNcVEuEk+Z1c616os0TJB+bYQZ2XQZ+BLm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUEbf8z/jYpBcjryEQ/48S1SsoR07RR/jpYAU3Yh8kLUJFHQhlS0yiNuf6HPtdKqgXhnPCcN0hrF8YGgOge62WmZhzgpU9jr2nMZeyN7yi/lRlZojn/hRZ3yxbkqD7gpABHblt0Hr1+50WrySpH5GDJ8pyTRIbM26uDOt7mWJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z16p81V/; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b86ed375d37so107053266b.3
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079124; x=1768683924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFxPlhETqVxBcpvZwh1z12pLI/x9cH1wDoqM1WNT2G0=;
        b=Z16p81V/uj0Hh2Cwh7awmK+Cb4fgbwW5lhDV5ZBT+luVP5sOLJQckrIK/3Znw6cK5C
         Oe2aRtoqKGfLlsejajWhgOjXBL/ojWr0Yz8qw7UOeXPPUhzt3Ui94vrUJRmNLtNtjcn/
         rEqM3qAzvCBhHEt9GblEQTSA2VctKqB5uBh/ii0+hNi60mH/TxIXhkFRWsyCTu8SSepj
         C9eWjMhPQTEKDt3SbHk3vy+VjA4341if6qjeFXfpCEFAfVZwLXM3Qhz4c2CmNgixjUmt
         0QI/P9LdgqD88jKXlEIY9U2/Ap63zA31ddVCZDCG4XDzPliJQ6GEg3lnx7HduStIWg3U
         e9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079124; x=1768683924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gFxPlhETqVxBcpvZwh1z12pLI/x9cH1wDoqM1WNT2G0=;
        b=GymGNxT5OoYgTDJMX/fcqSxmvgRr5WstplZdO+2J9AciVgHklvyFDvEceCblS8q9Ty
         osxwPzyLZH9BLtVZgBiIaJao42jYBhDpA9eP68Ob+yTtKIuo3xpOrsm+ZhlgXm7P15uP
         ZBuFf1C6UW+000j2Uuct0T1G6MP0Dnpi+DUl8zZGa7DePZgaGQIQ1oQVxvKDRSCzrc55
         Dht1y5A3zirX55g9gQ6U7KanGiSCE0Jg0y3ZaV1hW4r/FYD5flHXSbd0+hNylXVhSKgZ
         8BhKFl+9dps+GBi/D6NmVLCVFU8KsT/Srb1Wo7NjwULiPLjr0Ba/Q8ff7gwjL15bvj72
         h04Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZPHTMr/kj0yjIvSqHeat566PLBIfOCmVIVbBTm65cLcWYWXa9Hh2OVjndxd8vTB/Xvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7hW9Gs39JY0lEXrYnNuEzYsT9jFww+/a6hmJg5OIfUFJDJ/c
	htrliIHVYVxBUQK5qVg0ce4IWjc7iJH1U2v5dN/P5SyHFZ4XOZ1ih+/PCd/3unu4hBDbt9WQqmV
	QxbKOq/0=
X-Gm-Gg: AY/fxX41WcE1GqhLH37bQWYui+GBxyhW8BgfzV7JqKRrY/MVjU9S+qN8AyhK7xgbraU
	usp9n4xc14zisl50XFC4FZErAxNL8wK00T/KP3nrmq8TmZK1ft1s1yrefw7WA4vVU0LxE07euV4
	gPgk+JDK9E8AXCsWJA8OPE5Cwyxp6udveT9jFk1eg2maX/cv3tNcX+IAihu8NOvtEyVBDgZY8sa
	qUUWY6rQhHjIYZizqQdKmgZSmmDoe9zYpqZnFvBbKICA24jsmimSVG+O8Ajapp5VIzJk6jK4MbB
	61UX5u9cqqprIPlBIham6JpkZiCjQ36rm1L63a/Apl1WNGBMXXAQtZYk/6LUhW8ZStjg1dX/Bk+
	cTTxryvpfoEChyqaukAKvcDgSmDsTAsMQMwra+FC0JfIvAQj+KSythDQIaOBLVfjzSSe68X+YFc
	AUaEbdfU+eKwM4Z/m6Ot4NdrPhGEy0CIBaWU0YkmRP3cS/DvOv7x3T8IpBES4=
X-Google-Smtp-Source: AGHT+IF5BxzWvfCoMccLbvoqPziS+aIevf0t2FWDvLU7znmlF7MWPVqlhN+PmXzLEX7ramlHVgZibw==
X-Received: by 2002:a17:907:6d10:b0:b72:6728:5bb1 with SMTP id a640c23a62f3a-b84454361f3mr1533060966b.56.1768079124355;
        Sat, 10 Jan 2026 13:05:24 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a23432dsm1467459766b.11.2026.01.10.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:24 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:15 +0100
Subject: [PATCH net-next 01/10] net: Document skb_metadata_set contract
 with the drivers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-1-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy XDP metadata into an skb extension chunk. To access the
metadata contents, we need to know where it is located. Document the
expectation - skb->data must point right past the metadata when
skb_metadata_set gets called.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d..df001283076f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4554,6 +4554,13 @@ static inline bool skb_metadata_differs(const struct sk_buff *skb_a,
 	       true : __skb_metadata_differs(skb_a, skb_b, len_a);
 }
 
+/**
+ * skb_metadata_set - Record packet metadata length.
+ * @skb: packet carrying the metadata
+ * @meta_len: number of bytes of metadata preceding skb->data
+ *
+ * Must be called when skb->data already points past the metadata area.
+ */
 static inline void skb_metadata_set(struct sk_buff *skb, u8 meta_len)
 {
 	skb_shinfo(skb)->meta_len = meta_len;

-- 
2.43.0


