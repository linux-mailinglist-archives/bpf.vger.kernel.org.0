Return-Path: <bpf+bounces-77817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B663CF37A8
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81C030B9BBF
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D9335562;
	Mon,  5 Jan 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QOS48JTI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855333509C
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615287; cv=none; b=pH2860T1+fsttYArPw0aJVhbMhEUy4GfhkSyTmrbVWhhHuDr/OEGjvJ81iWwzQ5IxfiYQ3LhpBTS8NNmVGh1vTeTkOi8Ard6j6/Zu2Pi0Yhvn7FWL9or0AiFAE0JIAQLsKHselIxj9UZi+Cp4H8B4y6ZX75u4VEdJrP4GMhM3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615287; c=relaxed/simple;
	bh=Jw4sZlwfvlCw9U70oFYHFDt2JUDMKantZkYZjOZFw6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOQF0anpWAQkuU57G4ZemBc7EtQdH3xBvlt0tc6Nd7pwqPYn5vnz5f0dj1W7VDJrle/89WBo9nr4RY0W98Xyra2mwk9U3ihyZH5TVMGVn4G/pCwHK2TY+XRwQmhEmbw9+r0mmi/EpYeWkyo5i6YPhiRnVKU05EtF7CXF5enW0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QOS48JTI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7277324054so2298598566b.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615284; x=1768220084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=QOS48JTI/P7Yyy5cuGUkCQBKfRGFS8iIXRxmpBOMMBE5xPmnLNsTM/BUb8OS0U7S4O
         /kiJsXTUA2OUyGzp989ukwfNKFL5YWg4cXPQ52juDmjEDPFH6yHysQ0njo9JqX4/mfrk
         huoIA/AL8Lmd/bFZXpK538rinuf0Y2YHqN0YJh9VV1Kg9CJFwe9JZnn4dV2I5tiBL4sV
         4ajx74/okN3SfncJ94c1fmHa2bEl7IwyEeMHyXo/IpHgK9+0DAM/ft9Sa0mTYk4VUl5d
         gFgM4xwXu6Hq9NfswoSZ3j6zTOtbFzLIrj3eml3vMZk9d/tEyx5t1avPcfb35CHFc6nn
         z1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615284; x=1768220084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=QkNU0WH/z1eqXnPpCPGPV+XdGEttzZkdkXN2WJrLowap3T0JpDp+b8kMXgCw9nFhCi
         2tHq8LE2n9iJxEybejnV+SGLu1/FrALgonobwzUNtg7X7lDDWdpfB3GODMAXbn0DJifX
         tkMbyXgYlEstQoDdE3qT9qn3VDqtPwOIa8xwLOkoeDmeNEskZhoOj5Za7N1GLZ6ArCLX
         6Mp4sYSMRG7X12+nJU7s+IvIdh37Tn5SLj6RbBay4GMdLjBTAy55kol1Gii2JOEF6iwu
         0D+Sq0tIiq4WbAJjRjb17VST3SscWagAW+ytBVBHsDGC0gYTG+HtWDJuyn66JITsbDGQ
         Yy8g==
X-Gm-Message-State: AOJu0YyGeunn/OA40OE5ILj7RU+tr1thkFf4cL79pole4dizg61xbCqZ
	jmT0w3U7RWrS0A2EHHBTH6SSRs7ucZfvQh0O1TLgkoqPgZK/AR7Ct/i6m13kfmx7oP6ASr+jdQl
	A/PLPQ5E=
X-Gm-Gg: AY/fxX4xz0rNoPKWoFKT8tNx5Oao6mYHwpX411zMwgXJziWjg6b9b/fioyWMSuY+Ira
	fT6fwTh+WArT7hK1ixJbYh8hWQHtUXoejRoxXApVbBj8eD6BAA1q4qFIltXShSxs4jWjPVMoHAn
	Gcz3BCRIb4eZFlYrT3YjaZFCaDXdwqXIDWjyf0UObNvj8NOjeNt0ylm72Cv4c5AvHe4nLSm09wL
	BGc+vFtKxHRuHvqR+e7TN4Z2r/1lqRdjIDNpcUSaJKPEjn2tvfrKIbZFtw1/gQkAXao2npWpAG6
	Rq00feAo/JTEyP0NXswSBSDkPtiTW4nnfLHqd2AH4lMvZf0z4sO6vY0c60e+izAjxn7/8dkDqBX
	5UiN4Q8CAg9bJCVXsHPdj8dLfqtdrmRN/0npMubu8i/397RcvMAU/bQ0vIIt5rpaCL6CMCVI/MD
	n2wPhPzypauOrBvD10Jy4PIf7PydMObT4bMq7cBmVOlBSpgBl5bZu0s5/nNuc=
X-Google-Smtp-Source: AGHT+IHnCZ5omgu7ZRNjq2O1BB6JNDBHj6Vw8V7C0m2iRJcZNjtbxb29+5EsB+UFZxxKS5F3ve2vqA==
X-Received: by 2002:a17:907:9722:b0:b83:13ac:a3c4 with SMTP id a640c23a62f3a-b8313aca9dcmr3790232666b.52.1767615283518;
        Mon, 05 Jan 2026 04:14:43 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0cea9sm5458801566b.50.2026.01.05.04.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:43 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:28 +0100
Subject: [PATCH bpf-next v2 03/16] igb: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-3-a21e679b5afa@cloudflare.com>
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
 drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..9202da66e32c 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -284,8 +284,8 @@ static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


