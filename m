Return-Path: <bpf+bounces-72941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A5C1DDA7
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E665D4E464D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2CE4315A;
	Thu, 30 Oct 2025 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJwUmwK7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7E524D1
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782821; cv=none; b=UomfUeQGIQ5ORKY82/RyB2nzdxAEzKFHMFySqdiGD7dYJACyCwaASwK3uFcXs84m9MWs/8PSpNieVFnrntj2u0xTgF8KBYx+mD5KCBnKK6cpowlOmgPlfl2gK3kYEnUuLJqY9zaeAATKkV+t69Wdr/fOgGZV8b15yBFS5mjzeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782821; c=relaxed/simple;
	bh=AYPjqNcwVUU3ApBqlupS9wezW4XvBqnQkHDFkW4K42c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mo88KvQUnzHNUmGVdj7zFs+Y17iOQcxYgdAmgmwGH5ewab6LrQaVPm4ST41yoIoIO044I1WAEi2kQm513k6b0ijtg3fdR8xrNwNxTxHdsKUCIFEyqMDQ+ZF/PJDVoN7uIi6fF6RLc9eJ/mHxLJVUQa7Qo2G3d1mQIno5tevQm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJwUmwK7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29476dc9860so4044355ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782819; x=1762387619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ihZUDqcy6spGWNnOmC2eoR8HcqnGXih2DjGhY/ZWgM=;
        b=nJwUmwK7d2umQcjr7AGsjZgSdm0ovSEPiH2V+7JfmMp1jugMbzwXDfMuusc362kg7v
         YHeoF4sliumqUET25RasvkyCrtiRAqsQaxDIHDyPOYnumtkDAAWYhMXFpHJlG89qOGfX
         jkt8JRGV1RHy6m0EsXC6KIt9fE1lpopvfkGkSbJT8wyyWP9FWBPsRwbk0wQGASudULhb
         Hg4QEdJqJ5/Nh4wgeev0NWg7NlqHiZwqvr0ZAnVPnnbcUjx4cMusPEbMsPqGZaJBzsKh
         oaqiSrf5FMIcxDVtZqEwSDythqNuKqntgQmdmWJxw42gUmyxFtCN/0ygfRAAr64zylAJ
         0bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782819; x=1762387619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ihZUDqcy6spGWNnOmC2eoR8HcqnGXih2DjGhY/ZWgM=;
        b=vxKQ9ID7n8A76fUjnz2jw9AU4nzkr0SwoD4efFju35bXVjtfGN9EHRGIDSLB7+avv9
         EWrQAT6El6ksOt0y+hSUF/DgaZFlhChH3686GfoTBhuQm24OizMp/fDMwGtEW15WfN75
         EvzP7+EPveYgEFd8AnEt0lCWjBofklFOerga83oP3ux3dtzYoB3ByYQci4REH9TW2neu
         Z0R8viv/XalvoysKrj/dclLNXGT5IVigoiohERdDg+oJ0LnMFuu2VcGNA+YmDwsv+VPc
         n+8y/Ej21kU3wzS4YwwXTKktI4RqkApHeRnKssEAZ0QdpOxzGgaoUymyX91COJ5of6YD
         scYA==
X-Gm-Message-State: AOJu0Yx049Dy6Vwl3SXfwKJtKAVqrIMk7k9r3p4UV93igIHbJiQksDKg
	f1uRW58DCkd8rcOAPZHXy2rk4a7nXvCzxz2pCISmPrB2+yJEIWjP1sNF
X-Gm-Gg: ASbGncun/L/WDRStLiI39xPVEaPZMo13CMrfosAX8X9yOXgOpAITqHgoqQcgxy1/aWv
	Sbb9tmm7zRZM5Lfh9SV8tybXnKppR20UoO8jaCxtue9G3v7XSeLl5OEVPulvfwSqK2l+aqRJjXx
	a9RnEvtoavb2ddELeq9IrU+R3BXdaPWDi3ZlJC5wLgf4R4qjDxCYUtwi3wwxWAdEMKpFwgecAO1
	x5NdT2v9rZBKJCLmus5HIZTE2bAOF35l+gQ5uUqbQxDFA0H+Ul6AClhhSostyr7vauaFmaBqIwx
	YS5B2vv2LogG3DMFaAKG1VksJhV4LAdsq7kN3Mo+6vUhlL0Lba4lu9ljwFL6HFTZJbbq6w1gIQq
	4THXlzWqpwnpL34mIMYahumsUgVID8VxjvV/3vB61iP2CYT8TPg0Wj5eLOXXoASyAsgU3WYulN0
	zCdgnayomFg/0LoOazJ2SLphGpEBodlx0WFxSd2g==
X-Google-Smtp-Source: AGHT+IHfzO51jU4FTr+0/WJvTJ8uZSRuqnOOvC0JMH8kyyo2rr+JY4nR0a1e58DqwIJXv6nb9orgVw==
X-Received: by 2002:a17:903:ac6:b0:290:b53b:745b with SMTP id d9443c01a7336-294deedabdfmr58912405ad.39.1761782818969;
        Wed, 29 Oct 2025 17:06:58 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4117esm162900155ad.93.2025.10.29.17.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:06:58 -0700 (PDT)
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/2] xsk: do not enable/disable irq when grabbing/releasing xsk_tx_list_lock
Date: Thu, 30 Oct 2025 08:06:45 +0800
Message-Id: <20251030000646.18859-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251030000646.18859-1-kerneljasonxing@gmail.com>
References: <20251030000646.18859-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The commit ac98d8aab61b ("xsk: wire upp Tx zero-copy functions")
originally introducing this lock put the deletion process in the
sk_destruct which can run in irq context obviously, so the
xxx_irqsave()/xxx_irqrestore() pair was used. But later another
commit 541d7fdd7694 ("xsk: proper AF_XDP socket teardown ordering")
moved the deletion into xsk_release() that only happens in process
context. It means that since this commit, it doesn't necessarily
need that pair.

Now, there are two places that use this xsk_tx_list_lock and only
run in the process context. So avoid manipulating the irq then.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_buff_pool.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index aa9788f20d0d..309075050b2a 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -12,26 +12,22 @@
 
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
-	unsigned long flags;
-
 	if (!xs->tx)
 		return;
 
-	spin_lock_irqsave(&pool->xsk_tx_list_lock, flags);
+	spin_lock(&pool->xsk_tx_list_lock);
 	list_add_rcu(&xs->tx_list, &pool->xsk_tx_list);
-	spin_unlock_irqrestore(&pool->xsk_tx_list_lock, flags);
+	spin_unlock(&pool->xsk_tx_list_lock);
 }
 
 void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
-	unsigned long flags;
-
 	if (!xs->tx)
 		return;
 
-	spin_lock_irqsave(&pool->xsk_tx_list_lock, flags);
+	spin_lock(&pool->xsk_tx_list_lock);
 	list_del_rcu(&xs->tx_list);
-	spin_unlock_irqrestore(&pool->xsk_tx_list_lock, flags);
+	spin_unlock(&pool->xsk_tx_list_lock);
 }
 
 void xp_destroy(struct xsk_buff_pool *pool)
-- 
2.41.3


