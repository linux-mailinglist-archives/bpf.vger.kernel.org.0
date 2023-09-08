Return-Path: <bpf+bounces-9503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE3798834
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266631C20C66
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1469AF50D;
	Fri,  8 Sep 2023 13:58:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1FE563;
	Fri,  8 Sep 2023 13:58:00 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8994E1BF6;
	Fri,  8 Sep 2023 06:57:59 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694181478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEnWQjN8yKLvp2C1VP+XA3VBPqY8Xx7vebay2Q8ZdmA=;
	b=tGgfq7nSwBbr3kiGTCCnybDdL8XowQCXdBt1BIrT1rbZZSt7VKgfsXaRDQT5LNtpg3MIvI
	UMR8QsEs4kWYPgulqhj5Mqg2X897oaMo40vIf+VOsB2pWQuKOEPVvul7pQqIfJqCE5GDv5
	4L20LUBv/wz8Ut/SEFiB71GB++nsfZCf1qKlvIkjWdWT1e5ak01U3Bqqd7CKFyNGDBwtRo
	w3/mQ8qMTYZB2BoY8pzJeg4B80YtcMI0NlTGUok5kblCOY9NHL+jRFg+TntvgYjKmfZT2u
	ErbuiGruWgkj471Aum3SIoGhEgqnai9BBlwygXP/mWNxGGum3IoIsp+CCkoPog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694181478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEnWQjN8yKLvp2C1VP+XA3VBPqY8Xx7vebay2Q8ZdmA=;
	b=esKwYOdFMGQ+TG/I1j7x25XLVS7hRQc/KMWHmfxZZjgl8gZ4PDWfqmR7KRJljxa8s9W/mN
	m18XCy3dwO4YTdDg==
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
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net 2/4] bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
Date: Fri,  8 Sep 2023 15:57:46 +0200
Message-Id: <20230908135748.794163-3-bigeasy@linutronix.de>
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

bnxt_poll_nitroa0() invokes bnxt_rx_pkt() which can run a XDP program
which in turn can return XDP_REDIRECT. bnxt_rx_pkt() is also used by
__bnxt_poll_work() which flushes (xdp_do_flush()) the packets after each
round. bnxt_poll_nitroa0() lacks this feature.
xdp_do_flush() should be invoked before leaving the NAPI callback.

Invoke xdp_do_flush() after a redirect in bnxt_poll_nitroa0() NAPI.

Cc: Michael Chan <michael.chan@broadcom.com>
Fixes: f18c2b77b2e4e ("bnxt_en: optimized XDP_REDIRECT support")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethern=
et/broadcom/bnxt/bnxt.c
index 5cc0dbe121327..7551aa8068f8f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2614,6 +2614,7 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi=
, int budget)
 	struct rx_cmp_ext *rxcmp1;
 	u32 cp_cons, tmp_raw_cons;
 	u32 raw_cons =3D cpr->cp_raw_cons;
+	bool flush_xdp =3D false;
 	u32 rx_pkts =3D 0;
 	u8 event =3D 0;
=20
@@ -2648,6 +2649,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi=
, int budget)
 				rx_pkts++;
 			else if (rc =3D=3D -EBUSY)	/* partial completion */
 				break;
+			if (event & BNXT_REDIRECT_EVENT)
+				flush_xdp =3D true;
 		} else if (unlikely(TX_CMP_TYPE(txcmp) =3D=3D
 				    CMPL_BASE_TYPE_HWRM_DONE)) {
 			bnxt_hwrm_handler(bp, txcmp);
@@ -2667,6 +2670,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi=
, int budget)
=20
 	if (event & BNXT_AGG_EVENT)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
+	if (flush_xdp)
+		xdp_do_flush();
=20
 	if (!bnxt_has_work(bp, cpr) && rx_pkts < budget) {
 		napi_complete_done(napi, rx_pkts);
--=20
2.40.1


