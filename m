Return-Path: <bpf+bounces-16819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99D8062B9
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4851F2171A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE49405FD;
	Tue,  5 Dec 2023 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no369g9U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536063FE53;
	Tue,  5 Dec 2023 23:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F89C433C8;
	Tue,  5 Dec 2023 23:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701817699;
	bh=GuZk+8yb8AElS3t3Q/uCR17YrzPiBlSQO/HZEa4zFX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=no369g9UpVF05egRSK46GbwFQk5GgXSCSrvBrxEJmZQpW/M4LBJyV3bw3NVsTU2Ns
	 m9vA4q4OzH4ompOSqBdhwgHaBURmM1qb91xUArCMR8cbtyEze5duCRkQjpCKd776sH
	 5cWgy/Fr+Aaoyqo0sMUf2v//SnDDj2XDqVMTbpWljFzejCRtCn3BbjOZal5oHuDPfn
	 6zskcwWr9Myv5D4HBKzoZtUuvHAemQMqUQZaTieB747z7gKBtH4q7PLfEd1Oul1sk2
	 29PVx+Fz7xScd2PEo2ug3dBh0XQSBHlLoyP7O+cIMTcK90dcOcMqhsJ1FfQk4ZBHtD
	 ehHc+r7vHH1Qg==
Date: Wed, 6 Dec 2023 00:08:15 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	lorenzo.bianconi@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
	toke@redhat.com, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZW-tX9EAnbw9a2lF@lore-desk>
References: <cover.1701437961.git.lorenzo@kernel.org>
 <c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
 <20231201194829.428a96da@kernel.org>
 <ZW3zvEbI6o4ydM_N@lore-desk>
 <20231204120153.0d51729a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mz348EoMyOjjS49B"
Content-Disposition: inline
In-Reply-To: <20231204120153.0d51729a@kernel.org>


--mz348EoMyOjjS49B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 4 Dec 2023 16:43:56 +0100 Lorenzo Bianconi wrote:
> > yes, I was thinking about it actually.
> > I run some preliminary tests to check if we are introducing any perform=
ance
> > penalties or so.
> > My setup relies on a couple of veth pairs and an eBPF program to perform
> > XDP_REDIRECT from one pair to another one. I am running the program in =
xdp
> > driver mode (not generic one).
> >=20
> > v00 (NS:ns0 - 192.168.0.1/24) <---> (NS:ns1 - 192.168.0.2/24) v01    v1=
0 (NS:ns1 - 192.168.1.1/24) <---> (NS:ns2 - 192.168.1.2/24) v11
> >=20
> > v00: iperf3 client
> > v11: iperf3 server
> >=20
> > I am run the test with different MTU valeus (1500B, 8KB, 64KB)
> >=20
> > net-next veth codebase:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - MTU  1500: iperf3 ~  4.37Gbps
> > - MTU  8000: iperf3 ~  9.75Gbps
> > - MTU 64000: iperf3 ~ 11.24Gbps
> >=20
> > net-next veth codebase + page_frag_cache instead of page_pool:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - MTU  1500: iperf3 ~  4.99Gbps (+14%)
> > - MTU  8000: iperf3 ~  8.5Gbps  (-12%)
> > - MTU 64000: iperf3 ~ 11.9Gbps  ( +6%)
> >=20
> > It seems there is no a clear win situation of using page_pool or
> > page_frag_cache. What do you think?
>=20
> Hm, interesting. Are the iperf processes running on different cores?
> May be worth pinning (both same and different) to make sure the cache
> effects are isolated.

Hi Jakub,

I carried out some more tests today based on your suggestion on both veth
driver and xdp_generic codebase (on a more powerful system).
Test setup:

v00 (NS:ns0 - 192.168.0.1/24) <---> (NS:ns1 - 192.168.0.2/24) v01 =3D=3D(XD=
P_REDIRECT)=3D=3D> v10 (NS:ns1 - 192.168.1.1/24) <---> (NS:ns2 - 192.168.1.=
2/24) v11

- v00: iperf3 client (pinned on core 0)
- v11: iperf3 server (pinned on core 7)

net-next veth codebase (page_pool APIs):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: ~ 5.42 Gbps
- MTU  8000: ~ 14.1 Gbps
- MTU 64000: ~ 18.4 Gbps

net-next veth codebase + page_frag_cahe APIs [0]:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: ~ 6.62 Gbps
- MTU  8000: ~ 14.7 Gbps
- MTU 64000: ~ 19.7 Gbps

xdp_generic codebase + page_frag_cahe APIs (current proposed patch):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: ~ 6.41 Gbps
- MTU  8000: ~ 14.2 Gbps
- MTU 64000: ~ 19.8 Gbps

xdp_generic codebase + page_frag_cahe APIs [1]:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: ~ 5.75 Gbps
- MTU  8000: ~ 15.3 Gbps
- MTU 64000: ~ 21.2 Gbps

It seems page_pool APIs are working better for xdp_generic codebase
(except MTU 1500 case) while page_frag_cache APIs are better for
veth driver. What do you think? Am I missing something?

Regards,
Lorenzo

[0] Here I have just used napi_alloc_frag() instead of
page_pool_dev_alloc_va()/page_pool_dev_alloc() in
veth_convert_skb_to_xdp_buff()

[1] I developed this PoC to use page_pool APIs for xdp_generic code:

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index cdcafb30d437..5115b61f38f1 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -21,6 +21,7 @@ struct netdev_rx_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
+	struct page_pool		*page_pool;
 } ____cacheline_aligned_in_smp;
=20
 /*
diff --git a/net/core/dev.c b/net/core/dev.c
index ed827b443d48..06fb568427c4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -153,6 +153,8 @@
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
 #include <net/netdev_rx_queue.h>
+#include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
=20
 #include "dev.h"
 #include "net-sysfs.h"
@@ -4964,6 +4966,7 @@ static int netif_skb_check_for_generic_xdp(struct sk_=
buff **pskb,
 	 */
 	if (skb_cloned(skb) || skb_shinfo(skb)->nr_frags ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
+		struct netdev_rx_queue *rxq =3D netif_get_rxqueue(skb);
 		u32 mac_len =3D skb->data - skb_mac_header(skb);
 		u32 size, truesize, len, max_head_size, off;
 		struct sk_buff *nskb;
@@ -4978,18 +4981,19 @@ static int netif_skb_check_for_generic_xdp(struct s=
k_buff **pskb,
=20
 		size =3D min_t(u32, skb->len, max_head_size);
 		truesize =3D SKB_HEAD_ALIGN(size) + XDP_PACKET_HEADROOM;
-		data =3D napi_alloc_frag(truesize);
+		data =3D page_pool_dev_alloc_va(rxq->page_pool, &truesize);
 		if (!data)
 			return -ENOMEM;
=20
 		nskb =3D napi_build_skb(data, truesize);
 		if (!nskb) {
-			skb_free_frag(data);
+			page_pool_free_va(rxq->page_pool, data, true);
 			return -ENOMEM;
 		}
=20
 		skb_reserve(nskb, XDP_PACKET_HEADROOM);
 		skb_copy_header(nskb, skb);
+		skb_mark_for_recycle(nskb);
=20
 		err =3D skb_copy_bits(skb, 0, nskb->data, size);
 		if (err) {
@@ -5005,18 +5009,21 @@ static int netif_skb_check_for_generic_xdp(struct s=
k_buff **pskb,
 		len =3D skb->len - off;
 		for (i =3D 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
 			struct page *page;
+			u32 page_off;
=20
 			size =3D min_t(u32, len, PAGE_SIZE);
-			data =3D napi_alloc_frag(size);
+			truesize =3D size;
+			page =3D page_pool_dev_alloc(rxq->page_pool, &page_off,
+						   &truesize);
 			if (!data) {
 				consume_skb(nskb);
 				return -ENOMEM;
 			}
=20
-			page =3D virt_to_head_page(data);
-			skb_add_rx_frag(nskb, i, page,
-					data - page_address(page), size, size);
-			err =3D skb_copy_bits(skb, off, data, size);
+			skb_add_rx_frag(nskb, i, page, page_off, size, truesize);
+			err =3D skb_copy_bits(skb, off,
+					    page_address(page) + page_off,
+					    size);
 			if (err) {
 				consume_skb(nskb);
 				return err;
@@ -10057,6 +10064,11 @@ EXPORT_SYMBOL(netif_stacked_transfer_operstate);
 static int netif_alloc_rx_queues(struct net_device *dev)
 {
 	unsigned int i, count =3D dev->num_rx_queues;
+	struct page_pool_params page_pool_params =3D {
+		.pool_size =3D 256,
+		.nid =3D NUMA_NO_NODE,
+		.dev =3D &dev->dev,
+	};
 	struct netdev_rx_queue *rx;
 	size_t sz =3D count * sizeof(*rx);
 	int err =3D 0;
@@ -10075,14 +10087,25 @@ static int netif_alloc_rx_queues(struct net_devic=
e *dev)
 		/* XDP RX-queue setup */
 		err =3D xdp_rxq_info_reg(&rx[i].xdp_rxq, dev, i, 0);
 		if (err < 0)
-			goto err_rxq_info;
+			goto err_rxq;
+
+		/* rx queue page pool allocator */
+		rx[i].page_pool =3D page_pool_create(&page_pool_params);
+		if (IS_ERR(rx[i].page_pool)) {
+			rx[i].page_pool =3D NULL;
+			goto err_rxq;
+		}
 	}
 	return 0;
=20
-err_rxq_info:
+err_rxq:
 	/* Rollback successful reg's and free other resources */
-	while (i--)
+	while (i--) {
 		xdp_rxq_info_unreg(&rx[i].xdp_rxq);
+		if (rx[i].page_pool)
+			page_pool_destroy(rx[i].page_pool);
+	}
+
 	kvfree(dev->_rx);
 	dev->_rx =3D NULL;
 	return err;
@@ -10096,8 +10119,11 @@ static void netif_free_rx_queues(struct net_device=
 *dev)
 	if (!dev->_rx)
 		return;
=20
-	for (i =3D 0; i < count; i++)
+	for (i =3D 0; i < count; i++) {
 		xdp_rxq_info_unreg(&dev->_rx[i].xdp_rxq);
+		if (dev->_rx[i].page_pool)
+			page_pool_destroy(dev->_rx[i].page_pool);
+	}
=20
 	kvfree(dev->_rx);
 }
--=20
2.43.0


--mz348EoMyOjjS49B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZW+tXwAKCRA6cBh0uS2t
rKIoAQDHw2sKW0IrTotlFed87v5sqQqdDPPw1nn1IshyRDUvVQEAt1VcKPFksjfC
t3CZOGF2fVR27/GYWo9cyltDkR5i2gs=
=LEaQ
-----END PGP SIGNATURE-----

--mz348EoMyOjjS49B--

