Return-Path: <bpf+bounces-77816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC81CF37A5
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1D3830AB952
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDD33554F;
	Mon,  5 Jan 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JasSORni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A414335077
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615286; cv=none; b=WvK+zV1x/pvCt8OohicvQFwdcMsIIYiI5zBb6t5fzVZmlh5IO6wAHR2QBKsgTJemAlWL8j8SSuAl/DQOxl2EKSVAKHEI6u8PCtncx7IS51Ma3uomPxybtnvO5C2hFqoc9SwiCMxvO82f9pDs7/eX+ye5SDwHi0UX+/hJyoo6cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615286; c=relaxed/simple;
	bh=oMHmrv504DpK3sDJkcM25UNgfzziW6gjvBfOPGWboAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhnM3LDJ9IDb9leg+aFnd8xA3aj8JcMR8X2cuR3PYQT7LNxQBnl9n9dSQRhNikJMuJuzfkAdFNKPSVLNvFgWqsu+Dq8KP5CyMDZWjgjw2DSmoiZHNUteN4CW79Du+6hZaHGxvRqpY8SB020CI8gkzcwdqTuQSdebO7o5IMzt8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JasSORni; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7277324204so2013785466b.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615282; x=1768220082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=JasSORni3SGFg1SvuUvndtb6mBN10PVTTpaFqJK+k6WBa99alT+7Fv03U9o3k2nUdk
         CUgIPgmhhpigUcBMFZCuBH8uN0f15A2PqA6kv1g2dQ7U6tbLgY+GnGNaaPfI0os0y2PF
         cT6H3w72d74R253H2AEXWqFy9iXgz3F7ZCKPwPJ77Bb08AQebeane/A6T/+r6QFl/3UL
         uIoCixNribDxhlmwy62OZg6IWdMw3Rdu/3uAnhU+57Q1SqvLLW8Y75xVhU5vCO2RWP05
         R0QDbfn9FOwPY4yc+nGSP6RgM+o90jE97ty4PkyFLnylUOZ7nDt5gUgTdnH8IaHdkvl3
         8FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615282; x=1768220082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=dUaa2UaPpsgz/AAwwQ+M4I3NKO9V3CNrGSwbMkuVv+IFCt//wnuXjf3Y/xPjJIrRUd
         8Iv5rDigZgrNka2ubOnLt3UfDMqCeY8Z2ZHY+uZhR+mMc4+V1ZuOg84+i333DxyctUEM
         hT2Rq94+d/ZKQhEZaNk/rOHS0+Cj36HwQZTt/ZhhWSc/3J5vP7m2cp9n7YKgj1/R2GDJ
         p1Eb35PyUyyzDv45j2pvLJJQTWFN7BEcJdgUxFPAEUNwtulO2Agbjr9agiHOcVnZklUh
         OGAzzfmTpN5F3/mXzCPZ4Ba19GS87KI+GAVNVYzS0j3wnp77RFrVu1Oj3bkF01cuYEBQ
         FN0w==
X-Gm-Message-State: AOJu0Yxwb2yxWXOquTTKGl3Hk2CEji9EI9TR1ahSpHE4qNzKxmCoQ0eq
	Ecds5mn4KK0RqeeHXZwsN2A6ywtQeJR5ZClu45uTPCtpIyKUpZ3LhZXR7MuYv1JBmUQ=
X-Gm-Gg: AY/fxX5tzyga0fFOe6dtfwYaWUkftVClxN+zcVqHKwxP1OYrVi0X8jWWgsP3xgpBG2S
	XNNyGmxrzkfV8VZgbgDk1bSb/TKlXYibGctwqvVSRI3kaghqThRJnJ2sdM36r7g2OShluEL+eE7
	tbn8mKIJKNatDpW6/jUpMJY96n28z0Td45gYQbYdx70FIjuk8vh3cczGPTKt54ulcbQDZjxMViz
	mIQso2xTNTefsQHPmSmz6EKM4PJrQMCUwKqw0KcUbjp0x8TXsmp2EVnZme6+7qRpGKAh5JEgKHC
	2vpxM8PUcG2eU08gR7fWbgmAzjA67kRZ44IyjTCEMgOly5FGpLg7iNpCE9Rx+W4ri+1vJGBtdcI
	90boCdRELayBR0qyqLc27cFbCrSvZWZ3Moekg58Po6B7y2JPpcnIscs1KV9Dchrv/FIpyrjhC4z
	4DXBXNBmfblYUXkorDnCjeXYArntJMyCGjyQ8IVOPVhwm14aGkpEjIvKVjqww=
X-Google-Smtp-Source: AGHT+IEzR8UiPgOwvsgT+xP6okgmIV8TAjb8DBcV9yRJuXjUDaccDus6pJOrK4chKxcxEZN8ldHefA==
X-Received: by 2002:a17:907:9717:b0:b84:1fc8:2fb3 with SMTP id a640c23a62f3a-b841fc8efafmr95959766b.4.1767615282283;
        Mon, 05 Jan 2026 04:14:42 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b803d3cea32sm5367128266b.34.2026.01.05.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:41 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:27 +0100
Subject: [PATCH bpf-next v2 02/16] i40e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-2-a21e679b5afa@cloudflare.com>
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


