Return-Path: <bpf+bounces-61506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D73AE7ECA
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA323B591C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C89C29E0FF;
	Wed, 25 Jun 2025 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5qIG90q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C8285C80;
	Wed, 25 Jun 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846237; cv=none; b=sbpVOermB6kD2Uae3Aw1X6E/LJSa4Vsz9APiMsl+neB3gbLn9xs0cTduEj+MlmCfuuOGL0za7ZrzluKhnr1voPNYd3DpNLdXQEPmnHhUkXssePAMOYkyCYUtXmnNMHrtysf5Zqs6DazRJoo8YQAxq/4AOeNbn8KdG+iKqWxZU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846237; c=relaxed/simple;
	bh=00vN17MHpukAqGT9q1puBVUMA1WKzhxea+DAWJezqv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4zlztp7cLQr7Oql+2iSpAKpM/nRGZ2R1Rm+I6BI2/mcjfWXci5YRSToXl1xIeEQv9AazNlRz27VNlz4+rutAOsurKjrFM52lb7Y5oUbY98hlYhexRi6UZiMgrrxcEQyjXkg6MK+dQ0I0OZLSGNWm+XGLY8GHq5lacNdmlp+enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5qIG90q; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1547752a12.3;
        Wed, 25 Jun 2025 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750846234; x=1751451034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZuj22sFy39fmnoO1sd2k+eniIEVqjeisgIsRg/TPT4=;
        b=j5qIG90qtXQVZMdN8q2aKC7ljwrGvlu5ylUq87fDQvgr8IoXRfVInaAqwx57BGFVsX
         rlandYKKVtRsYbFlLcOUBgXFZGhBWjCeBZwKsLW9QhxqHJyT0/dHXyNUJ2Mb6nubAN3I
         YR0Rn6bmfys31qfLZnKStrcpc6inj8yGY24x4xL2JS4hFCvQPPea5svbo1GFCZqqTbRL
         mNQVpwRyVQ8a5Q1CKQg+lGgd+aaJ/bsRqgj2ukAEUC20uJca+I7VP5oEpxFvpBHJlS+J
         79KynsYxEDPceqT97oIq2WOh5LXlq8UiDKQ3Pgdqk5FZ/PuLzuS6ZHj8r1p7Cu8ZwW9Q
         LCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846234; x=1751451034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZuj22sFy39fmnoO1sd2k+eniIEVqjeisgIsRg/TPT4=;
        b=Bg++dggn4VlnoIJuHQMAuu6ciplSyFranY4QECPIxlfpclC14Qd6ldPPKq/URtHuK7
         ByvKTNCnZCv4WYT0CFBmSSc/C1RrMqZCA13UVpscZq3tlKnR2gvVl3/2sL3IcP95sv6L
         55HEnLlkKl1plTbykWY/puPBBpCK29nU4/01vEdnW0rh5gpV31xumfroY0eMRSbaPZgI
         Kvw9s362sTXDVsIFJ27t0ayhlJR/dJXsm1fXELw/5j0TEbrK0+3aWJgxRvNY5FDHm0h3
         ws+pIdeiTwh0TdD4QlKa3bdyNicv5bGJTlRnpq5Capy13nZR5XQGYZEBXfCt9toQLbKU
         g9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJKBKTW3bI9c0Epj1sDsOBsbJvGk62CJ1sTKtoOXx1KSRE4EzQ7u/tqQV4yjCCRwgHqsg+8QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+Sy6ObXywzsU7pmWyl0OdKyN3rnox0vSX8e8/6o5IbrJxV9/
	EfO/VTxsIRWMg1vGyA8ijySsVvydDDPwwBACko4dwjcCbLH//t/C4550
X-Gm-Gg: ASbGncuq/fRnEbNr7IeBkpot9QcgtXaVtNUKNz9xHq9rWVGRxGuKTYVPdYhBI9WnLx9
	yWvjRvknViLlBLcDZiPoLKy2oxvM5WI+hkMJ+ecAAueYXb77OgDCa90jJjgXLew4AP3yC/uXfvt
	dBXiRNldHdTGjZXtWQYWDutNM6050Xf9X7pb6mLiUcARnbw6KF0OnxGVk6+5z6Gb1AARZdILila
	e5q/kNC7RWgbCa10yNATKChRIhGVfJY8zdeTI9WbkQghVrjMZ8n2SBtwo/hsgXdiie8VlutdW1b
	3PY6aNbkm36+2fnVosxQn74kHERFebHwLzF/NNxi5rCQVrVN3NfII7APwWlIcZQsalw2N3fXJyc
	Ak3OdM5WjzdAFJFt4F19D/+zAWMfNtr0NSjqBBUwhZ/1Z
X-Google-Smtp-Source: AGHT+IFnVTnnOnKjBUpp4b4eIBBRNfZdI45MeCLh7lVpFqKopiYTvd2DlD9tcr8gHNnFQ2DVmmeXkg==
X-Received: by 2002:a17:90b:2f88:b0:313:d6d9:8891 with SMTP id 98e67ed59e1d1-315f25d691emr3498583a91.3.1750846234084;
        Wed, 25 Jun 2025 03:10:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5437a0bsm1328838a91.35.2025.06.25.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:10:33 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/2] net: xsk: update tx queue consumer immediately after transmission
Date: Wed, 25 Jun 2025 18:10:13 +0800
Message-Id: <20250625101014.45066-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250625101014.45066-1-kerneljasonxing@gmail.com>
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For afxdp, the return value of sendto() syscall doesn't reflect how many
descs handled in the kernel. One of use cases is that when user-space
application tries to know the number of transmitted skbs and then decides
if it continues to send, say, is it stopped due to max tx budget?

The following formular can be used after sending to learn how many
skbs/descs the kernel takes care of:

  tx_queue.consumers_before - tx_queue.consumers_after

Prior to the current patch, in non-zc mode, the consumer of tx queue is
not immediately updated at the end of each sendto syscall when error
occurs, which leads to the consumer value out-of-dated from the perspective
of user space. So this patch requires store operation to pass the cached
value to the shared value to handle the problem.

More than those explicit errors appearing in the while() loop in
__xsk_generic_xmit(), there are a few possible error cases that might
be neglected in the following call trace:
__xsk_generic_xmit()
    xskq_cons_peek_desc()
        xskq_cons_read_desc()
	    xskq_cons_is_valid_desc()
It will also cause the premature exit in the while() loop even if not
all the descs are consumed.

Based on the above analysis, using 'cached_prod != cached_cons' could
cover all the possible cases because it represents there are remaining
descs that are not handled and cached_cons are not updated to the global
state of consumer at this time.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
Link: https://lore.kernel.org/all/20250623073129.23290-1-kerneljasonxing@gmail.com/
1. use xskq_has_descs helper.
2. add selftest

V2
Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
1. filter out those good cases because only those that return error need
updates.
Side note:
1. in non-batched zero copy mode, at the end of every caller of
xsk_tx_peek_desc(), there is always a xsk_tx_release() function that used
to update the local consumer to the global state of consumer. So for the
zero copy mode, no need to change at all.
2. Actually I have no strong preference between v1 (see the above link)
and v2 because smp_store_release() shouldn't cause side effect.
Considering the exactitude of writing code, v2 is a more preferable
one.
---
 net/xdp/xsk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5542675dffa9..ab6351b24ac8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -856,6 +856,9 @@ static int __xsk_generic_xmit(struct sock *sk)
 	}
 
 out:
+	if (xskq_has_descs(xs->tx))
+		__xskq_cons_release(xs->tx);
+
 	if (sent_frame)
 		if (xsk_tx_writeable(xs))
 			sk->sk_write_space(sk);
-- 
2.41.3


