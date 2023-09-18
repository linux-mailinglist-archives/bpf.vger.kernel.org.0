Return-Path: <bpf+bounces-10289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E227A4CD9
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A81C2082D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2BE1F5FD;
	Mon, 18 Sep 2023 15:41:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4A1D6AF;
	Mon, 18 Sep 2023 15:41:49 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018E2722;
	Mon, 18 Sep 2023 08:40:22 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695051378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caRkeBcleE2vGm9+Tw42z34WPv/eNtNADjbS+meETfc=;
	b=E2yR630LOM2H6ub4VYl3yRsGl8uHXYbqAmyHKE8EOfJn5yBe0WP8IMVp7fFNnO/LeHnEm4
	21G39QAjsqfjlSMbEOMGX8gbOoSykcN5l0KOpwWhIjs8oAWJP2GIuHHGgfXLytITm5W3xy
	c04yzxlqbCs/cCk/13m/Njbgi0D5TxQdSaaKfWwR0oVGhqGuKZsv9hmMZ79R6DEiAm+TKr
	UfhP7WZIVNCydBSjK73G4q7m0PS3dG/T6YzijGxbxhwbpbY7H38eDZTm/kPVp1pMnl8S2g
	XMNYoYimVu8XsGuK6gEdv3rKpve8etq3ZpyI62z/UWNrqEv/4t3aS71MKBxyvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695051378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caRkeBcleE2vGm9+Tw42z34WPv/eNtNADjbS+meETfc=;
	b=fsprMuZxsQAoCgdXkEjuPh/9FNE2+704BaWnvGGjoPi3p4Me9zdB03uFDUTltePJVEAfwt
	QMzxrsFkWl2bATAA==
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
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH net v2 2/3] bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
Date: Mon, 18 Sep 2023 17:36:10 +0200
Message-Id: <20230918153611.165722-3-bigeasy@linutronix.de>
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

bnxt_poll_nitroa0() invokes bnxt_rx_pkt() which can run a XDP program
which in turn can return XDP_REDIRECT. bnxt_rx_pkt() is also used by
__bnxt_poll_work() which flushes (xdp_do_flush()) the packets after each
round. bnxt_poll_nitroa0() lacks this feature.
xdp_do_flush() should be invoked before leaving the NAPI callback.

Invoke xdp_do_flush() after a redirect in bnxt_poll_nitroa0() NAPI.

Cc: Michael Chan <michael.chan@broadcom.com>
Fixes: f18c2b77b2e4e ("bnxt_en: optimized XDP_REDIRECT support")
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
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


