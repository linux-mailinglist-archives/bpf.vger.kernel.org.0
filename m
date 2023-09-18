Return-Path: <bpf+bounces-10293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5327A4D29
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B351C20356
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57C11F922;
	Mon, 18 Sep 2023 15:46:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C208171BF;
	Mon, 18 Sep 2023 15:46:16 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD019BD;
	Mon, 18 Sep 2023 08:45:11 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695051378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oxv1BgCX/PwGf84sb7NyYKUruLb3J69ciez1lO5rJM=;
	b=CSGR/fuU4O2gJGeO8+uh8huBwlhMEbFyvmuxtvRQD0zl6K7Ij0VK/qW0Eq7EebwS4TNKhM
	/Edgu2YSoIcijHOOuf/NnfikIdK0u+6GeuLc9LrgiysTj/KVEqm/YRmGjepfGQ3wi355Fz
	Wm8xUsmmNtYRJfZSUJL158PgEtyQhkhZ1oj4R0U9XPzFhQTlSSRK5MmhteCl8GYS4qdtRB
	CDHcuulPPNlic3veRMaN+pUWxenBYJHPK1MUyZXn3EGBCllf2Yi927WGNnm6yUt0oquRsV
	ObQnag2k9fR1R/ZLBI1gCTxZeRiM6p6a9xNnjBctnvt30a8kL7SphtnwurVOiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695051378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oxv1BgCX/PwGf84sb7NyYKUruLb3J69ciez1lO5rJM=;
	b=KuE1krbypCgqooKbfYdliSujdUWjORcYDOenUc6oq1f4c+4ytXNWXKo609H5/M9WqhXZl8
	ayE9kyqod5hLAyBg==
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
Subject: [PATCH net v2 1/3] net: ena: Flush XDP packets on error.
Date: Mon, 18 Sep 2023 17:36:09 +0200
Message-Id: <20230918153611.165722-2-bigeasy@linutronix.de>
In-Reply-To: <20230918153611.165722-1-bigeasy@linutronix.de>
References: <20230918153611.165722-1-bigeasy@linutronix.de>
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
Acked-by: Arthur Kiyanovski <akiyano@amazon.com>
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


