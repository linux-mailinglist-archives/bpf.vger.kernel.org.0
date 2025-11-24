Return-Path: <bpf+bounces-75355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0366AC818FE
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EC244E6835
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB22F318152;
	Mon, 24 Nov 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e5sKABNf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CD31691D
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001759; cv=none; b=jNl/kc/kCrkzyzi8d5obAIQrIV5pQSQXiEpBDIV4DwvXU0+xPXoXoGFTx42O1Rz48ApCqb27xiwmI83eBn75w1abidWvtw83EZGR+uKYI4uGIfPLVCwqTybx3PDbSSxWPnX4jiwVRPEo0cPoeqs+BTb98L7Nm3AV8LtpZ1PA6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001759; c=relaxed/simple;
	bh=gpO/s3IET6M0QBXoFLb578gA5Up+AO2D0gt4GSXzoj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzRGTIve+jixguOh1jmhrJQQhbucjd5Yuv2UndiSb7jYoSRJPDUxD+MiOiO4upG6Tx5irqHN8fNGTgFKAXb9ydyerHR2hst4iQQR3pj4nMcWrVSDRJTkF8TJS/hYsrgw7xFgYuTQ0Oa366Ei0jdP5YMNalxdNdD+B+WTKf5Fwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e5sKABNf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b72b495aa81so558842366b.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001756; x=1764606556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=e5sKABNf0S88pNRSyeygq5+P4mB0YUgz19NrtYGTKs2VPIT1LIqDbdJVXhkJhrRs6t
         yGlho8RliqEu9tUII5Jxuqw6Fr3ixWtnowN1qb5ilsiSaYpJ21FJfZfIG38U8YW/NP6E
         xjGOmjnGLlFQu8UqloLRp4HexgrNVifzvuJAGVeSoOQT9urrKTqKwmLV/jzpKcEdZBhs
         h7WrFSu9SZp573KiYl3ilZDq4S5QdBadncil7FkOpAVedkL15Sbx1bAUbjV9PeuIUt/p
         fYHHQV5WkpAtOABNYaanrhybJ9UIa854zDcQ7ZzX07Cv/X7nFVf0wuppIOrjMxLUUGhk
         Qbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001756; x=1764606556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=d/27d8R1f3bpbD4aPPNiQVmu+hJAgV1aEZYQEwNpq6RsrP8E4wdqeUtbUuFKf1l5N/
         bmccGGmPM2WEWEScHxJESaIQeEFJfMylZ7QYTdwKSal1EGKGPGdVJ17Hm+GBXt4xBqnt
         Ib+qnPqBu+XK4gWm56xGMEN94p4AMNX4f85ZGtmtlkZXDQr5VVU3ECcxmeFK83Howl9z
         YBAclGGgtM6QlMbzT9a2aU/ufsR597sA8Kl1Kf8iueFVKal3qEX5lZqBrfQpt8eSl+jc
         ZfrMdSoHU+/s6liI4OF5x0trAHb7Eim8VVm7pUuJyndD2W3rY5gADhwTXdH+ti1zJy9o
         r47w==
X-Gm-Message-State: AOJu0YxxGAbOVJfpKmb9UHHMtI4MyKl+quwvw/5jvuRMb14LSgPS2/9j
	OGiw/pBqywiHnTU9jt1bN5OBIT2JC70oUn1zgDpD5JPEpKqQMIUO+3UoszXCdQJJLu6sMMtG4IF
	tCaY3
X-Gm-Gg: ASbGnctTLZ9Gl4WHQ+Gyhqy3HcjyKX9zEifi5YCB4ogRiUf3MHQyWG2iTkjGahya+Z9
	nTF045vWsQw4P3I5B88OGlZdGIkZos7lsxC5PdOuJZcrW2Jh9NdB41oNk72Q7usADQ2cVLoAxJz
	9VC+o2jRm/LTJ6nc1t6M12aPXyl3md7AHhX+H0orRdwgFxQyDZ/pv6iVytR0CyWLG7iTf13nbs7
	zgLbYgS1tEGXTUvcroX8n8C5dEVQfyjred9UqjaMgODDBv0nA8XOzJCaQzwuRibDOB+eSAjpl0j
	47t1qHGg+dPsW/w2ho43jlx6Bp5tgwsfzC0GUKZWfnxcZBydzKpxw5XhPvSwoI49irM4u0ZVgB9
	U54j85jF+mOzlROkRR9YOYJOUAG36ptSV1uweBFQIimF9Tljpwjgv7tTqEMXNClGGlujxCcpudn
	rD0vqSlMx+3uri9aQeENnHDK3RhgORrWNnjj+5GsCSyz/3+VyMwQ7b3TB5
X-Google-Smtp-Source: AGHT+IEC/J2e50ch8ea6zamwDiGIqGrUIxtoQkbAYFNboIFPtK0B3MuUJXUm67l0//8J7UshJY8edw==
X-Received: by 2002:a17:906:f0d2:b0:b76:74b6:dbf6 with SMTP id a640c23a62f3a-b7674b6dd6fmr948776566b.38.1764001755975;
        Mon, 24 Nov 2025 08:29:15 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76550512d2sm1334713866b.67.2025.11.24.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:15 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:41 +0100
Subject: [PATCH RFC bpf-next 05/15] ixgbe: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-5-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7b941505a9d0..69104f432f8d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -228,8 +228,8 @@ static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


