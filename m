Return-Path: <bpf+bounces-69952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77610BA97C9
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850A31887FFB
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059663090FF;
	Mon, 29 Sep 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GrXl4TFx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC697304BD4
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154960; cv=none; b=es/sjJ5tfaouoUNL0fe9+pNPmSQt3F+DH9NzbxJgC31ygxprkRd5VVguwLxHm/hG2zxQvtpXv1NUA7OpzFjfcglYkkbFMFYJNIKN5y+DZlssE9cSaL9OjmKYOLsXCkSeDKermv0Jousaw//Wlwmwg95RhJ8YsR2uZ60P2/J+DdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154960; c=relaxed/simple;
	bh=cZPtm7mY9aZff/+Zp+0PNLXE0+5dqAo1/R/mB+FJx1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2xb3zbs5t2p36OPqX0OgGMJ3MzaQXHjTfg4nfHdJUUFv43zQ+lRnbcIMrblNfxy88P6HlJnxyC3fVbXDf4CgYLJfkLAVggV1r3B+BnZw68mOrWCNZzr0rl+Sp5W1IjMP+KwyEo+1Ynrd5Hzk3YFBeMm91tvIDuZddguJu42Ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GrXl4TFx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07d4d24d09so925881866b.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154957; x=1759759757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3T4hpqvjFYkRBESyoEKXynDUn9xooc0YNsSmvl0X2c=;
        b=GrXl4TFxL4mjvuc8f57b/0jafw6y2R0aoGgUFsR+BMiszd9iFXb7ONN7fxjQAYX3lo
         fDWh2m2wCkEd9yx8ofFG6h79ihyDb3bYIKErXyee4d/3BMCBrged/BavoI5mAAWtiB0x
         meqx+uNf7baGs8zV/AA3vaBwKvYZzWG1+j4gXftL9N8YM3+tlCw7nCLv9rBQGVhV7erN
         t7s5s/4ITgdEZzu/cgxdXhbEPqa+6zExnwzAe4Am7ch51QMykzz1NU99KM1u2HjgQMI3
         Zpj32m3BQYpcUstu4qd9eJQYfN2s4+jUYea9zZCo237wB+fqFMYqTHUpDUBuF4OTOtic
         oezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154957; x=1759759757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3T4hpqvjFYkRBESyoEKXynDUn9xooc0YNsSmvl0X2c=;
        b=N2Wh/6rEsSK42l1HTkMf5OqU3EGe+e/VNNLmzCHnlrRJ9h4xAZHi4H7PgyZ/gmMxJC
         jism/Qq6dBqsS+Z2Ey3r78K8HN/IZ5OQ9QYRHAqs1X9/qUg17H5S61O5oAK2Qp92mSSG
         l55ulgfsEY8Buu6E+U2EjOjvcH8VB2CrfF2apgDtEWLYJn9mP+uSp9CMEzpUf28NvHXF
         unJ7yCiochay61pzBbUtJpH9obBeCwgMS29hlbsKioCFHS5U1xK0RPkZRDDy5pE3KkOx
         ydz0FuQFhjxiX8V2B3RvB0TZIqNGcEzYSkVEHGTV9GDp4GPApCfd24AzlN+d9pybFsTl
         eu4g==
X-Gm-Message-State: AOJu0Yxac+UvgZeDonyekKYEoBSPKQHBwRAKSPNroZvf4Ff4LAzHWNbG
	/wS8D/VnsSDA/LhbXfVyfhPzeHdm4aOY/Xmaf6H1KFUKpL2wOoI40zalWJW3ej6SNVE=
X-Gm-Gg: ASbGncvl0PMGXDaybcuoB4XzKtrozgxOcxB14fr5UppqfpScz6XIR9AaYWaMNvmdjjG
	lqXZ+Z4jLg2n6mirPhpKHPhhn/oGAATZ26cPCFfy5pH9h8wfW4uatwyzpv5KQ4IPpt5P08DhWet
	gtFOiivcPdWeU7oTM4dsYf/WOoWla+KLcy6i9sT23Q8en3NfSt0qqpFw4BcOqKE7SWvKHdawgP0
	3tukVjD9GMd671BTxgRGHaTkUJlj2D7G8BpC4xvFkI4g7BHmVLhqUdcB0lPOfSSkFLLo4qVXImB
	XQOHX1dFXq7kHL0c0zvXrmRPkB84DWuxetKNMMru5NF+RVCh+7szZWZvKha3GvyokmXECk4l8C6
	puIYLbYtfKZnGXU4AXiXWYdx2zElu0KvAnkENSzPbd9W0UHyVgwkIID5Ab72kkvCojeF+fZXlRM
	doviB1kg==
X-Google-Smtp-Source: AGHT+IHAVetCopmVRBD3UVVjjLGWuUD5FTUpk7ipzkmk+RRp7+O5PaSuaJ3llTBZ+1qCcucGsSyStQ==
X-Received: by 2002:a17:907:d90:b0:b40:e400:a3f6 with SMTP id a640c23a62f3a-b40e400ac3dmr124370066b.35.1759154957241;
        Mon, 29 Sep 2025 07:09:17 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3cf69ffef7sm320057866b.62.2025.09.29.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:06 +0200
Subject: [PATCH RFC bpf-next 1/9] net: Preserve metadata on
 pskb_expand_head
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-1-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

pskb_expand_head() copies headroom (including skb metadata) into the newly
allocated head, but then clears the metadata. As a result, metadata is lost
when BPF helpers trigger a headroom reallocation.

Let the skb metadata be in the newly created copy of head.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..dd58cc9c997f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2288,8 +2288,6 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->nohdr    = 0;
 	atomic_set(&skb_shinfo(skb)->dataref, 1);
 
-	skb_metadata_clear(skb);
-
 	/* It is not generally safe to change skb->truesize.
 	 * For the moment, we really care of rx path, or
 	 * when skb is orphaned (not attached to a socket).

-- 
2.43.0


