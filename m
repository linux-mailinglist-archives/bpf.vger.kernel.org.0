Return-Path: <bpf+bounces-40757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E522F98D3E4
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 14:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7E1F2267B
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778721D040E;
	Wed,  2 Oct 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZEPMZtXt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2QtcYJm3"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403BF1D0156;
	Wed,  2 Oct 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873929; cv=none; b=TbXB5E7SpQdeyq/YbFMveFCaJrBtC3lU9UZUj02do965ofS+F2OarBijqmspUmdV6YXbcHerxo5TC4s2Dua4Rz18Bfev7l7R/aNBnuX0P9Qx1gcUTzTE4SGReTGDtcnkS+xb1WAGwjWW9bGg/jKm9wqaYimgJ0HIIEN35pBhslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873929; c=relaxed/simple;
	bh=nHr4+CXMgKCsv/jPZZk+7ma/OdfYqu9g7N1FNdkmHFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ldPJXJwWD6BSwfUwBHN+XApUvSJbvamP6aVFHA1+45ZbEQ8ypDPkli6PSnivedYbiVeeMjQ6mvADJcsWQJ/F16sQZ9GG0O5X6064F/0sBSuzmyCNPC4GFynVUVdCA8K1AowO3vDrC5gNYpbYlgT8FnZnkkU7rL6evKQi1icm/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZEPMZtXt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2QtcYJm3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Oct 2024 14:58:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727873919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bGrrLhBT5ooRUJbAGj9XtSYzVnXdrH+uhT5vdxP9kRs=;
	b=ZEPMZtXtpBsVEunD29d8jzH7IqhMCYZBBYLCS5G9cujTmg1RI4kOnIT2AeZSJGjWDHfpZ1
	O/szvMmEOl1xratCxTTxzZdbfvPTVl7GTo1/3IyQuBdqyeWXo3onQbKQqh0J48xMkDCXM9
	ZFgXymNUqHnsbytoxFLS0lorcC0W38YDQfvnwOnky6ceUqReL+eXLfuTpHUuoebfx2woTC
	XuRz3tzsklHZMv7nC2FmZgFnqujVXB9aB/QXziiil32rxHq6oLTAGW6FEQxjvAV0uS1eC2
	2QvVSOM3ItxysHdgY0geNUdfWTeA2sC6dVEJVxRV/EEZe2dZ6ym9ecnZlGqFqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727873919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bGrrLhBT5ooRUJbAGj9XtSYzVnXdrH+uhT5vdxP9kRs=;
	b=2QtcYJm3HAYDyWjjj7/Mqq5eeM9+rS8O7W5PSBSQgAWc1H946LOGH0MhnnWYWjvzYd8SNF
	xzOifKcPGg4rEXDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yury Vostrikov <mon@unformed.ru>
Subject: [PATCH net] sfc: Don't invoke xdp_do_flush() from netpoll.
Message-ID: <20241002125837.utOcRo6Y@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Yury reported a crash in the sfc driver originated from
netpoll_send_udp(). The netconsole sends a message and then netpoll
invokes the driver's NAPI function with a budget of zero. It is
dedicated to allow driver to free TX resources, that it may have used
while sending the packet.

In the netpoll case the driver invokes xdp_do_flush() unconditionally,
leading to crash because bpf_net_context was never assigned.

Invoke xdp_do_flush() only if budget is not zero.

Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Reported-by: Yury Vostrikov <mon@unformed.ru>
Closes: https://lore.kernel.org/5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/sfc/efx_channels.c       | 3 ++-
 drivers/net/ethernet/sfc/siena/efx_channels.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index c9e17a8208a90..f1723a6fb082b 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1260,7 +1260,8 @@ static int efx_poll(struct napi_struct *napi, int budget)
 
 	spent = efx_process_channel(channel, budget);
 
-	xdp_do_flush();
+	if (budget)
+		xdp_do_flush();
 
 	if (spent < budget) {
 		if (efx_channel_has_rx_queue(channel) &&
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index a7346e965bfe7..d120b3c83ac07 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1285,7 +1285,8 @@ static int efx_poll(struct napi_struct *napi, int budget)
 
 	spent = efx_process_channel(channel, budget);
 
-	xdp_do_flush();
+	if (budget)
+		xdp_do_flush();
 
 	if (spent < budget) {
 		if (efx_channel_has_rx_queue(channel) &&
-- 
2.45.2


