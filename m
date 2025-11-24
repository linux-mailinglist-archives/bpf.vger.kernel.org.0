Return-Path: <bpf+bounces-75352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D7C818EB
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEB93AA142
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7097C3164DB;
	Mon, 24 Nov 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UgOVioeD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A922315D31
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001756; cv=none; b=GbrmxXdzZaESo7HYSFgQGlh45TykKtPnSo4UUJMwnJrC/Bng4BOqtzVuf6jE6XUWkIYLHNfWIPvAKsQFOUADQaeZ9H8RqwanFj3PQg+Xzi9evGOXco6NyHHSqzBNDIA1M9P3Kwkchfq+9dwP7UIjX8bVV8ok4gtWiH9sYflDsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001756; c=relaxed/simple;
	bh=oMHmrv504DpK3sDJkcM25UNgfzziW6gjvBfOPGWboAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGj07DJSBlAnipH4PN5ZeYlqGgiHWoO93pUPRX+yzCqQsDnQLuPDEv1TH1SPKpd906eob35SKK3PnDP/ifC2iN93zS9N4Iabxpjw5rV/oP++z95MvYrIVfuGi4JdVR9fMJS4OdydS9lWuQWtfTKe+IpLpHM3l6JNo8mhyCw76Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UgOVioeD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b727f452fffso908589166b.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001752; x=1764606552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=UgOVioeDVjqo/nGzrhqvJLaZQZHIQphTNlw72KEdstHUjjuA/RPpZOp9+uBi9bquP0
         CflqAbVFhFBncpNJcY4yA9CNOsVS2HburkXu9ias35NuGYzRXdu685g93xVy/k9Jrp9Q
         EdMVaT0lisGzIIZzz/UtMEHEtpcoBl1Dg85O7AMJ+88tubHoZPYy1Jc9G1v9Mhggw4Yt
         0sxBay3cJJw1FdbpsdkwTffcNWZf4Y96iTz8TEKHhCg10kLuWneOTyxvRT0Ph34RQwDP
         XpAv2lEbHtlWCVzOBf/p+x3OpDyTFBBFpSZJUKiXmXrVqLz+8+Wkg+y/Eg02ghS4Rj9V
         XNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001752; x=1764606552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=vUn/wDakHZOeXb0yZKtsYkOsxLvEvlt7rlnQDjlBgdT70FcXqtrMUL/SUcDmsNrW4k
         pFxp16fy5sDCOmiuB092xnP/6zQlE3EkbHtQUW/sylKwy9KsLRj/4ntuWvtU2O2Up2Pi
         AerLA2o67IEMQhAlRdAekgA06SEIETEVoKnCwmaQ9admU0S8halB/EMAXk3hLazNHq52
         a88hBTag4rW9WkLeP9gk2D+2oUWMQBfdtiJYA7HhOTrgk/MqYQegCwxYKlg1ioBBkTHj
         ulEJF0PUNRohOJpfTW3WB2Q1UcfuOj8G9y4n4w9yorevT/BpDTuLOWJ2PSM1HBoQjjrf
         moqw==
X-Gm-Message-State: AOJu0YzXwoHW5qQi2K/odKf8zZwXvaRcAlNM5mk0bv6gghP6J6v+BRQH
	wIBstrZKQSX03U+KGPHU3i4Q1I+ADRp81u+lR+6E5DVFakPqUzLkSxUlebjzlv4b/wsp0n4IjeQ
	mkUUk
X-Gm-Gg: ASbGncug0wqc4X3SN3itZdQs1EdTZL1jrf6927C/gBEIcI4LGwcouZW4zpVrOZJAlOl
	phMIes38T/nbwtRuy8tMD3TcCZhaQyIDaoZko10YpWwqrw029ZjivhCTnRhkhIFhS+JrGPhx5gN
	T7tEbkvRRzxcdYDS2ohgdSWADLdXICDV2OaeojRetTes7jDdzOOkyOsZXuLLriliGhtw3FeFJz7
	BwPY0gBaboEhDtcpdYVbaknRNDE1atn5JrpPOQh4ggROGh0tCmq/kJ9rl4h9uerlTOKRYGQ4h4U
	pMnjct1M5N9TufPzQHFOi6gPaguJWnk+IygUtqyBzL7BOGnET3IzNfYxOqh/erGT+WU9B7aULA+
	SZvwLlStGTRu2A6Ve1R+G1kBjg2DIRrvHrmfw7d986o5EayDAcT5YEVUYLNVsbBdUtqaQl/wy53
	kfyDphWHJgYoKH5EcdHrfz6slhW33jgOH+QYO/U6ibhgq/M5/0iItT1+ax6L4ha2qMjAs=
X-Google-Smtp-Source: AGHT+IECGRVSsWRNXmYcKxV5LDYypMTtGC8QkxnmYHqpUHSkrZ3kzEj2PwsVnIA2MG6aZtx2uH5moA==
X-Received: by 2002:a17:907:6d1c:b0:b72:e158:8229 with SMTP id a640c23a62f3a-b766ef1d289mr1592228966b.15.1764001752217;
        Mon, 24 Nov 2025 08:29:12 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d3bf64sm1316680566b.16.2025.11.24.08.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:11 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:38 +0100
Subject: [PATCH RFC bpf-next 02/15] i40e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-2-8978f5054417@cloudflare.com>
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
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..11eff5bd840b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -310,8 +310,8 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (likely(!xdp_buff_has_frags(xdp)))

-- 
2.43.0


