Return-Path: <bpf+bounces-9502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B779882E
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4A31C20CCC
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F626ADC;
	Fri,  8 Sep 2023 13:58:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776E63D3;
	Fri,  8 Sep 2023 13:58:00 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285EB1BF5;
	Fri,  8 Sep 2023 06:57:59 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694181477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqXfRFQG7Ol4PjIe25MGz86mhUAqsw77YCDv1lV1K9I=;
	b=Xj1mbrhpRee9s95uD+GI0GuBDkIg1dW1l44jPGqAvYn8DIfUDblh6PsiRGCndceYffMZVi
	KnQz/0YS86b8u6QixGCBJ8CNUYKMgYjhsgaO8aET7orocwaokw9HRORzFglBO69vroxQ/j
	gXx3oleMauA1H5sqx83je+AAoUodd89pwlWFUUOnonvoRZSyvkpdddG413G1AyjmugDdW+
	cMCWpSmQNJSly+pXqpa/rzHUn0oiXT5S5zUeqdcWbLuQqbUxslzRWvQkubVMqhlPEepQ31
	vzxDHdK5on+pqGCgtRb1QAXQHNzrhA41oqVqITRjeEt9EZWTmu4sAFQRJuiLLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694181477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqXfRFQG7Ol4PjIe25MGz86mhUAqsw77YCDv1lV1K9I=;
	b=ueM6BUs15VfaGtZfQAuWUtRS49vP6y5/g61jWw+TAbgXX2Jc82eoHAzTQNmbH3T4R+Gfug
	PeuzYFnJHhLHITAA==
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Shay Agroskin <shayagr@amazon.com>
Subject: [PATCH net 1/4] net: ena: Flush XDP packets on error.
Date: Fri,  8 Sep 2023 15:57:45 +0200
Message-Id: <20230908135748.794163-2-bigeasy@linutronix.de>
In-Reply-To: <20230908135748.794163-1-bigeasy@linutronix.de>
References: <20230908135748.794163-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xdp_do_flush() should be invoked before leaving the NAPI poll function
after a XDP-redirect. This is not the case if the driver leaves via
the error path (after having a redirect in one of its previous
iterations).

Invoke xdp_do_flush() also in the error path.

Cc: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Arinzon <darinzon@amazon.com>
Cc: Noam Dagan <ndagan@amazon.com>
Cc: Saeed Bishara <saeedb@amazon.com>
Cc: Shay Agroskin <shayagr@amazon.com>
Fixes: a318c70ad152b ("net: ena: introduce XDP redirect implementation")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index ad32ca81f7ef4..f955bde10cf90 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1833,6 +1833,9 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring,=
 struct napi_struct *napi,
 	return work_done;
=20
 error:
+	if (xdp_flags & ENA_XDP_REDIRECT)
+		xdp_do_flush();
+
 	adapter =3D netdev_priv(rx_ring->netdev);
=20
 	if (rc =3D=3D -ENOSPC) {
--=20
2.40.1


