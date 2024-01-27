Return-Path: <bpf+bounces-20467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606C83EC95
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 11:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636E31C20CF3
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2C200BF;
	Sat, 27 Jan 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Fa5RXOh2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174CC7F
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706349846; cv=none; b=IzS9j4jheWGgNigYuyxNJbqkI/ME3w/odzTVmm5YU0GcZueb7gVnaeAyeaGkGGdopQrfVT9tOsZ+ETiHWSZxUe4chZnfMNOP0zLwAGifF/IMar2XDCNLP+DkZC18fWkj9HeduisDwj+kQ8hG8pTo0O1KtSleIYk6Vgt1rPUKgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706349846; c=relaxed/simple;
	bh=+yprMf7ZacjV/R+JRF0iro8VM8GuQtAb0EnB2wFcPN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWEu3tza+BYBpEVf3KzyTpt1A3ro8cbs/DUDOdrXhhUlDaKqh7L62nt0T5WmtmzKRgC3hp7SmL348PN8y6ECnEkQlSdM/3WwN45wk5TRcRoWSl9LKntLGtVaNcKlS4NylZSPXf+BX+HkBCH88WrJzTyKTEbRNapLbd1ey+6uKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Fa5RXOh2; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id TfWXr9E3GNw7gTfWXrfreX; Sat, 27 Jan 2024 11:02:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706349775;
	bh=W5ZdRbqiQEr7tMSGQwE5u2qB6Co/AJekgwmWqF5S0MI=;
	h=From:To:Cc:Subject:Date;
	b=Fa5RXOh2QciGQtywPwuFyt9wFfk52+M++2wuFbQ2TBBK2A/v/jLPTNsbmntNgmeHL
	 hPFN/EBZ4bFr4E5lOdK+7L+WetV9TSDSIQSoFho/WILCRjKG0h+naG1GfU+QbGvGJF
	 RUWe8eBxHAq8xCt5H7l6iBEVw12ilgdSonD0QRVVs110lXAWyzDHrDl+WnDcc515Hd
	 19/PHhp7yTWl3rgQ29sWVir+T4SjvG29n+SuujBFCUpq0Rf9izxNzSERDf8a7enTax
	 qAEu8mdg8jOsWXXWJYjenPae+gITxXcNyt3o8bOGWrXgJvZSKf+7ch8EabUetRJqjq
	 hqnFH+D10s84A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Jan 2024 11:02:55 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next RESEND] xdp: Remove usage of the deprecated ida_simple_xx() API
Date: Sat, 27 Jan 2024 11:02:48 +0100
Message-ID: <8e889d18a6c881b09db4650d4b30a62d76f4fe77.1705734073.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Resent because of 'net-next-closed' message on previous try.
See [1].

[1]: https://lore.kernel.org/all/20240120115342.GD110624@kernel.org/
---
 net/core/xdp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 4869c1c2d8f3..27b585f3fa81 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -75,7 +75,7 @@ static void __xdp_mem_allocator_rcu_free(struct rcu_head *rcu)
 	xa = container_of(rcu, struct xdp_mem_allocator, rcu);
 
 	/* Allow this ID to be reused */
-	ida_simple_remove(&mem_id_pool, xa->mem.id);
+	ida_free(&mem_id_pool, xa->mem.id);
 
 	kfree(xa);
 }
@@ -242,7 +242,7 @@ static int __mem_id_cyclic_get(gfp_t gfp)
 	int id;
 
 again:
-	id = ida_simple_get(&mem_id_pool, mem_id_next, MEM_ID_MAX, gfp);
+	id = ida_alloc_range(&mem_id_pool, mem_id_next, MEM_ID_MAX - 1, gfp);
 	if (id < 0) {
 		if (id == -ENOSPC) {
 			/* Cyclic allocator, reset next id */
@@ -317,7 +317,7 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
 	/* Insert allocator into ID lookup table */
 	ptr = rhashtable_insert_slow(mem_id_ht, &id, &xdp_alloc->node);
 	if (IS_ERR(ptr)) {
-		ida_simple_remove(&mem_id_pool, mem->id);
+		ida_free(&mem_id_pool, mem->id);
 		mem->id = 0;
 		errno = PTR_ERR(ptr);
 		goto err;
-- 
2.43.0


