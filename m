Return-Path: <bpf+bounces-75359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86CC81918
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0623ADD12
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1E31961D;
	Mon, 24 Nov 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ty0MqThK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169BC3195EC
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001764; cv=none; b=cwERt97zdUjMrM5AA48k/HKoFmu9CbzL6kCQY3xoKYern9w6ASa3K6jP0f4WgTs06kWbOBzRcRM5bI431ScIlv3mrcjucH67RZrlhQPvQRWCamGG+sud/NPKXUJL8pnGSs75Uru7IYLGwsLZaYgBkv2dqdEgTJmAMl/sgXLOwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001764; c=relaxed/simple;
	bh=siAN2lprPGM6krWgoAADuuRHXk+SkrIZe41bcexqBzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehrFIboiuE5VhE9ANW+5nE2BHECtFMAcd/WjlAUMeECeQweJlTJywwCuyH+v/XtrNxtBPltcV/OTajLHzqY0IAflZtsV5BE8SAeShKxQnOKkDNc27XE+Tb0+8/s5gk5Yw1nq+GznU1cdYnxIRI/Vvw4pznBKH/Y/tN14ONZLqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ty0MqThK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so7356793a12.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001761; x=1764606561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6N7Aw7VCdEi+8zUwkNv8471tkOa9T3A0JD4hDqceMBU=;
        b=Ty0MqThKqqFbIUKMy77LcvAZlOqZn9qNodfhAcMM7ypIcaM3+37AJ1rFbiX4c25aLe
         nV7GLl3sAP8CtyAJeZUW6PmxczAiDeKnLdnuwZeN7Z4n4/52jAj00ZZ9dcCqy1X+Owbb
         WXI72VlAEwldVdD3u0siy5+tuf2WejBcDO8xBfUyUWotsERy0e3WHrLn7AjidUz4QgWn
         gLFp1nRaTkyd/bCeWBubdjisbS4iKr2JhY44ZGSBpJGAPT7RRu6FxB5d/dafl7cO4YJq
         vm6yLbN3MgqOeqjUQBVxvqrREGYoHq2E7jSskwMP76qXv/WL/1HtxF3JJ8ZXqe4xGetu
         spwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001761; x=1764606561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6N7Aw7VCdEi+8zUwkNv8471tkOa9T3A0JD4hDqceMBU=;
        b=pDvpY17kxn2qufljRwebfOGTntz9F77ybYDq4O4kF1RtRRjJQwpyaIXaGa+VvPmuvN
         A5uXnaSRu5z1g5YaBStWBnGNTCk7Zc284whSnNMZAkrL4eYoNpRsUWCs3//ywlJLaP4n
         CZ0cPQoDKkSIkGft5VSgGR8wOQ7u+N0Kndq96xLOWcWPyh/xCAbymTJN3IsCoWW4Pj2L
         yj1xpch6zolJUvisMgF3GikdlHPCen+LNEiTzqhjCR2ZOoFFjIeUpmupqKpkeN46/oba
         UhTNowd/523E9X0WgpNxFQrZWRzxUit4aHZVql8SkXWGJhRJdISgq39TWiRD1XYKzEBa
         fkFg==
X-Gm-Message-State: AOJu0Yz+4IPARmmAVu7/Tv7T0AIOq7UWNdymg47tFttoVr4Wtti2CFyA
	ezwIzYW9XvEFDcPL+bCtqLmX9sSyfYomlhI51fhn25w3G7F1l5L76QYKG9Dx7/X/j6XbOO1ktpS
	CAfyr
X-Gm-Gg: ASbGncvjm88jwkdd0d616jI2FuivZwEn7UQR8TKFQPQ/5a1OCkqiyq9TT+T6ckh+Lhv
	8cGlyaVTy9FtXgUIycXOYXb/7vpEqmvHvDsUaN6ckgaZWssZDCNXatKU9wcqI/gR6ZfqHoRJdc2
	MO6WsbM0BUYudshlXVBDz5+VROgbOglYiRc8mTc8JHKq+/40wytxK/6Ow+0aZOvel7EunsRdaWd
	e4slfWqm56evyoKG/tHOeaqPmOTAIIfjnvtGr+2nCbf9eWpK0+X1z7Xq587AgRtvCfHdJHJ9nrj
	RlVUD6LdCXARFlNA83bDVQgjZOLlMAEkITZ7hWeip6/K/my4ZyTt8ue60iGBmM34U+CRNtVuIQa
	86tJZcn6e/wyJ5uU1zGr003w9ZZCi6hDXGZgiRvfkCqF+AXJrFeRTxnkNOozsAxU5CGqkIhJGv8
	OSvR7bEhkQ/+2gzLjvezuWD6IrOwypO0+r2PCxzoj1a5EY7qeIupGuyWLs
X-Google-Smtp-Source: AGHT+IHVoXb2rKmo9YLPEb6/FmaCqZgbpJAvVWTZlimX0ihtCH8UoPWxTPwxU/fkG9oCvS4Nl5p/1g==
X-Received: by 2002:a05:6402:4310:b0:63b:ef0e:dfa7 with SMTP id 4fb4d7f45d1cf-645543492b4mr11307240a12.6.1764001761119;
        Mon, 24 Nov 2025 08:29:21 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453645f2easm12373165a12.33.2025.11.24.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:20 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:45 +0100
Subject: [PATCH RFC bpf-next 09/15] xdp: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-9-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
points just past the metadata area.

Tweak XDP generic mode accordingly.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 69515edd17bc..70cf90d5c73c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5461,8 +5461,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		break;
 	case XDP_PASS:
 		metalen = xdp->data - xdp->data_meta;
-		if (metalen)
+		if (metalen) {
+			__skb_push(skb, mac_len);
 			skb_metadata_set(skb, metalen);
+			__skb_pull(skb, mac_len);
+		}
 		break;
 	}
 

-- 
2.43.0


