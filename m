Return-Path: <bpf+bounces-5188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314C175877A
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB12228174B
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD61775D;
	Tue, 18 Jul 2023 21:48:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31E15ADC;
	Tue, 18 Jul 2023 21:48:07 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020015.outbound.protection.outlook.com [52.101.56.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC534198C;
	Tue, 18 Jul 2023 14:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7HCfzKOdcFxhiX10HkYj3GTcYx0zXP8mFCMhwJQMm8EUUsUl6LxJWm7l8KCs72cgSIWS4YAPkN50t7fwcJm87gxxHB5k3GVugiDAOegLOX9hUJtpWySrb32tD3g9AqU0OWUuIG+ZaiY5ZqEeINIT8xTIkfvGJxLzh9zD7KLrFt+YugdBJEd9XVkTnphXmukUlIXIU2ghk6QMlL4MzfrrIRGNlBHVn9rfc5IxaVJFl51zINdMOz5xhU9+gCjfg/FgeaKyLS2kYIPW0QZC45EFGi1KWwOWGcdwt1CGGVEjYQBiDxgUlGVgKfQWm/c/ufeeu0ZeZyK9IVeCmRQCzUfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRVllPSTZM+RXvB6JCVrCFiQIvH1G5cqF3j+/aQ+aFM=;
 b=cIYaR16/2Rb8d1qQBw0PqXAvqic0q/daPMHKM0o7J05FqZOXpg5JQEL+fApVgTGlgdEVGnvbJ99wGPjbIkmFO6C6JgLj+bwnTuS09xIZrmXDufZRGGNGY8BsUO34uEuJPZeYciszRI/3bSVlexKs7MtKQpgKVzkw/RtoMuwSt5yCdOhPkM3NsHSRbx/H1rsijE3EH5tIZ5qBkQRnnUC70LLVohDQIiY9vr02niutRJIgOK8M15AylXxasa/5T3XsXjuXy5u8IjRdLiffPM6ji6tZgbmt9VQwP4tVVPPB+LK2zLL+mKIffMk66Fcbid8MN16HbdRUElPjwJQSimVVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRVllPSTZM+RXvB6JCVrCFiQIvH1G5cqF3j+/aQ+aFM=;
 b=V5JDKzSjfQYdRBbPbUdQif/YTBhwNtY03oyXo8PBzapwn4XAcZTrfHVejc1G1eizEM6MZoxiCdpBsEX12tuf0Tt6CLrWXRVWQMu9ar8TIXzfdoXNcKbu3PDvECA/Nt/6vL9kWOUvDN1IL/QzW/BKThuUpQ4QqBMeFg/2CxYWFlQ=
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by MN0PR21MB3386.namprd21.prod.outlook.com (2603:10b6:208:382::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8; Tue, 18 Jul
 2023 21:48:01 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::9461:c35c:25c5:85cc]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::9461:c35c:25c5:85cc%3]) with mapi id 15.20.6631.005; Tue, 18 Jul 2023
 21:48:01 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2,net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH V2,net-next] net: mana: Add page pool for RX buffers
Thread-Index: Adm5wYXxv9h/LIMj1k64MaVoaiA9Dw==
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
Date: Tue, 18 Jul 2023 21:48:01 +0000
Message-ID: <1689716837-22859-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: MW4PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:303:6b::15) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-exchange-messagesentrepresentingtype: 2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1443:EE_|MN0PR21MB3386:EE_
x-ms-office365-filtering-correlation-id: 2f6cac47-96ae-414c-76fe-08db87d8a87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HcydyqoW5YwqAs8n9xsYq/697DYqB2TuRJFA63AuF9A8/rPelDKNNPZQWhbHrEALwZFmssyOocJRnAt6UFrOk13Pxz9QjYHG8odMKo7u2v3FeSaN0bmp3BmPzRTAVOkVQBTh4HjBY+bLT+4pksPpF9iypBHQ6giE6dt+K/lbzORx+I9i86ZnHDcFcMWkaQiYJZNxZ72Y4r8o9Kta1FOm6bE4afvmcdVY6jgDGR0scIOkMq0NA9cexr3czNuHc5F5EWzJAO6P2RFDjvXa9pSr2zzJ40+TrPfIDcFbqPodRLajYpgLCZ+m3CFoyP1dAFiY4TixJv9dW3nP0mUVF0XIJnJjeO2bkC4QNlEhGCQF81YpP4HlENICkCLrw/Ide3Q78Q8lUI8txegNoGVAA7uD9zEUFNGxtNTCWZ3jG86/MfoN7K6WIaP+fpOWjm8l5dCX41sGHJ2PqpZTR/ofmNcNKg4uS8UnYY7EwWsYIZbVg4SlmK+tdHDAG3qtKqF0XNyLD9aYUqAmeoUFEnznGYS3mqOGR5uvwUogOV54Op0UpipUn3gH3pABzA8GkEU3vz30NQvX+4AOkUBTSLjGIM91zvIHX8CGtszMNHG4nXbV9Mi3FzrDtMUpOXpbbm67b5Oa240PSMwigt1Yr/NHaAkE0cecE0mK6DhNEuqvNj1U7yo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(478600001)(10290500003)(41300700001)(36756003)(6512007)(7846003)(8676002)(8936002)(52116002)(66946007)(66476007)(64756008)(66446008)(316002)(66556008)(4326008)(186003)(26005)(5660300002)(6506007)(54906003)(71200400001)(110136005)(6486002)(7416002)(83380400001)(2906002)(2616005)(122000001)(82960400001)(38100700002)(38350700002)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Zbe82stM3Xaj0Iniq0iXfEfHfXcWe0WsS0AXlN9k/XULAbdY0cr9aNH2kZ?=
 =?iso-8859-1?Q?4Pzd09HGjTbH4eIjaWr4V4WA7wgRCxUYgTN07+NweGvTXEl7yBAIKqjKCm?=
 =?iso-8859-1?Q?tNeQAM1ptlVVZIe+79LJOunTciVyuqSwX5rvRaIQz4O5+XpPgIJxcmTJuy?=
 =?iso-8859-1?Q?NTM3unKrERUW+eP/5CK7xeb9X4yQQkBLILn1jGFUoiTmN5fJzIleHUXuJr?=
 =?iso-8859-1?Q?jzo4qyuKAafA/TjRLO6Pod3f7eDF8OdNzCTE+t8g6n6cV1eVhb4pZwNPa6?=
 =?iso-8859-1?Q?fhbhv2jNZM0aOwuRvrkpJVkxYR8gMs5wcKH7kN/46/4Yvf1ESPqxiBiBkE?=
 =?iso-8859-1?Q?wQPI/04sKooqFD8VSrORVm4yGmq8vfQYG4hjxbsENk9iC3uvK7P6dyLRgy?=
 =?iso-8859-1?Q?NcDZWehANmas0LLxYexecGR9Z+6I5deEZxpzVQFz93ryrxp3CR1fUnSSwS?=
 =?iso-8859-1?Q?f4tvcg+ij20t6QkH7dSx0B8lx9jvC/P3VaYTsDAzygkjsSBqnH3OAhSVRP?=
 =?iso-8859-1?Q?xWbmJJymZsYR0OLpihRANBbuLDPCDiHu7Llot0PO/X0tRg97tPhLSguRu0?=
 =?iso-8859-1?Q?KsU5s2mRWqmP/wtNjRHSXQWojCLBXWWXOBr+AmeDK/YF0qgdW4BfaWtehH?=
 =?iso-8859-1?Q?46/174Afamcx3rASoRHtkvf/iMlYj99+4m9541yE1QgZpj3uKST8V7Gy09?=
 =?iso-8859-1?Q?KUbNucU/Wtsa+TdAITf2kkn2f11xzvFSmH+AB05wCTiQnpcHcDNQT7MRk9?=
 =?iso-8859-1?Q?F94TrZDdYojaZCq+FlhkVTZ2SqvVQesVZwFn1t8KoLwCIhoiPElE6MSqfy?=
 =?iso-8859-1?Q?u1sL7ZQa0QKVk+7yKw6JQR+w/tMJO/vzHSBs3Qp+5RDWD9A1d+2kK/ZmWU?=
 =?iso-8859-1?Q?Cz7VTekaPsywR+nbPq5Z6YRClxPNCm0PMCaJbb4gv+JOo29mvTp2nCPist?=
 =?iso-8859-1?Q?8WSXVatJSZRICBeVtojVRzElGASy62gSShL7WiPdGee+jxlRyvUsZnc2uS?=
 =?iso-8859-1?Q?FhVQtNZhd90x5gbhEVlUCdqqVqG2omyeNk1OwlGskU5D+L/ctcTfqa3HY8?=
 =?iso-8859-1?Q?7r4ZK+Fzd4leXaXcmdB0v/U9cC/BkbNkTKXB5E7c0oKsdjUji5t8cfbPan?=
 =?iso-8859-1?Q?ujN6ecyeQqRHT0s7WnfSrBSkYXCS2goVnsCFlqVYgcLh5JtXJiIktKR0Mc?=
 =?iso-8859-1?Q?0GyPgmSjG9P4wv8hQJhzQyYcf103tD/a4QRoSFFdmx9B0P18XcgzzAHrLp?=
 =?iso-8859-1?Q?VxhRk397ypIrszOFRKWZyBC4ByCEN3+bF7b21I51iEas5pEEsf7ARFEnQU?=
 =?iso-8859-1?Q?PpgJ1M363fWQsosFE0lZdM9KTZWcEkdjcN47h2Vd0o8S3FG0Oe+r2DviCr?=
 =?iso-8859-1?Q?in40eq1aRP72QQPTyBmFbNd7PN2jETyoL5OeM7kOIPPr8HKQJyqOhDgA9i?=
 =?iso-8859-1?Q?Jl6PalVBXRuucROK9JMXgEYvTmV3Y1Y623LmOoPgCN6eIXO5RvlNMxUTCW?=
 =?iso-8859-1?Q?3DYepdxdP696SJ0n2LzN2IqJ7QH0CVM8ogH/WQBCPtuSOXO6Xera52+4vD?=
 =?iso-8859-1?Q?dr7Uwin+Wuv0iGu/1GC5QhyP6eonI8D8ds9f3c+rO89UkVhpUrv/B0s5o0?=
 =?iso-8859-1?Q?ltPxYG1uauuVB8rzIga2kVhUQnxJG20uD+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6cac47-96ae-414c-76fe-08db87d8a87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 21:48:01.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZUAeyaTV171cv9uZHO4FC1WaMxoqvPfW0E61uisCK1mOHr5wITQgbvEpHy/dOltd8wGEtm1dGixCvBuic7X1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add page pool for RX buffers for faster buffer cycle and reduce CPU
usage.

The standard page pool API is used.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
V2:
Use the standard page pool API as suggested by Jesper Dangaard Brouer

---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 101 +++++++++++++++---
 include/net/mana/mana.h                       |   3 +
 2 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/et=
hernet/microsoft/mana/mana_en.c
index a499e460594b..0b557b70cd45 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1414,8 +1414,8 @@ static struct sk_buff *mana_build_skb(struct mana_rxq=
 *rxq, void *buf_va,
 	return skb;
 }
=20
-static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
-			struct mana_rxq *rxq)
+static void mana_rx_skb(void *buf_va, bool from_pool,
+			struct mana_rxcomp_oob *cqe, struct mana_rxq *rxq)
 {
 	struct mana_stats_rx *rx_stats =3D &rxq->stats;
 	struct net_device *ndev =3D rxq->ndev;
@@ -1437,8 +1437,12 @@ static void mana_rx_skb(void *buf_va, struct mana_rx=
comp_oob *cqe,
=20
 	act =3D mana_run_xdp(ndev, rxq, &xdp, buf_va, pkt_len);
=20
-	if (act =3D=3D XDP_REDIRECT && !rxq->xdp_rc)
+	if (act =3D=3D XDP_REDIRECT && !rxq->xdp_rc) {
+		if (from_pool)
+			page_pool_release_page(rxq->page_pool,
+					       virt_to_head_page(buf_va));
 		return;
+	}
=20
 	if (act !=3D XDP_PASS && act !=3D XDP_TX)
 		goto drop_xdp;
@@ -1448,6 +1452,9 @@ static void mana_rx_skb(void *buf_va, struct mana_rxc=
omp_oob *cqe,
 	if (!skb)
 		goto drop;
=20
+	if (from_pool)
+		skb_mark_for_recycle(skb);
+
 	skb->dev =3D napi->dev;
=20
 	skb->protocol =3D eth_type_trans(skb, ndev);
@@ -1498,9 +1505,14 @@ static void mana_rx_skb(void *buf_va, struct mana_rx=
comp_oob *cqe,
 	u64_stats_update_end(&rx_stats->syncp);
=20
 drop:
-	WARN_ON_ONCE(rxq->xdp_save_va);
-	/* Save for reuse */
-	rxq->xdp_save_va =3D buf_va;
+	if (from_pool) {
+		page_pool_recycle_direct(rxq->page_pool,
+					 virt_to_head_page(buf_va));
+	} else {
+		WARN_ON_ONCE(rxq->xdp_save_va);
+		/* Save for reuse */
+		rxq->xdp_save_va =3D buf_va;
+	}
=20
 	++ndev->stats.rx_dropped;
=20
@@ -1508,11 +1520,13 @@ static void mana_rx_skb(void *buf_va, struct mana_r=
xcomp_oob *cqe,
 }
=20
 static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
-			     dma_addr_t *da, bool is_napi)
+			     dma_addr_t *da, bool *from_pool, bool is_napi)
 {
 	struct page *page;
 	void *va;
=20
+	*from_pool =3D false;
+
 	/* Reuse XDP dropped page if available */
 	if (rxq->xdp_save_va) {
 		va =3D rxq->xdp_save_va;
@@ -1533,7 +1547,13 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, s=
truct device *dev,
 			return NULL;
 		}
 	} else {
-		page =3D dev_alloc_page();
+		if (is_napi) {
+			page =3D page_pool_dev_alloc_pages(rxq->page_pool);
+			*from_pool =3D true;
+		} else {
+			page =3D dev_alloc_page();
+		}
+
 		if (!page)
 			return NULL;
=20
@@ -1543,7 +1563,11 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, s=
truct device *dev,
 	*da =3D dma_map_single(dev, va + rxq->headroom, rxq->datasize,
 			     DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, *da)) {
-		put_page(virt_to_head_page(va));
+		if (*from_pool)
+			page_pool_put_full_page(rxq->page_pool, page, true);
+		else
+			put_page(virt_to_head_page(va));
+
 		return NULL;
 	}
=20
@@ -1552,21 +1576,25 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, =
struct device *dev,
=20
 /* Allocate frag for rx buffer, and save the old buf */
 static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
-			       struct mana_recv_buf_oob *rxoob, void **old_buf)
+			       struct mana_recv_buf_oob *rxoob, void **old_buf,
+			       bool *old_fp)
 {
+	bool from_pool;
 	dma_addr_t da;
 	void *va;
=20
-	va =3D mana_get_rxfrag(rxq, dev, &da, true);
+	va =3D mana_get_rxfrag(rxq, dev, &da, &from_pool, true);
 	if (!va)
 		return;
=20
 	dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
 			 DMA_FROM_DEVICE);
 	*old_buf =3D rxoob->buf_va;
+	*old_fp =3D rxoob->from_pool;
=20
 	rxoob->buf_va =3D va;
 	rxoob->sgl[0].address =3D da;
+	rxoob->from_pool =3D from_pool;
 }
=20
 static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
@@ -1580,6 +1608,7 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq,=
 struct mana_cq *cq,
 	struct device *dev =3D gc->dev;
 	void *old_buf =3D NULL;
 	u32 curr, pktlen;
+	bool old_fp;
=20
 	apc =3D netdev_priv(ndev);
=20
@@ -1622,12 +1651,12 @@ static void mana_process_rx_cqe(struct mana_rxq *rx=
q, struct mana_cq *cq,
 	rxbuf_oob =3D &rxq->rx_oobs[curr];
 	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu !=3D 1);
=20
-	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf);
+	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
=20
 	/* Unsuccessful refill will have old_buf =3D=3D NULL.
 	 * In this case, mana_rx_skb() will drop the packet.
 	 */
-	mana_rx_skb(old_buf, oob, rxq);
+	mana_rx_skb(old_buf, old_fp, oob, rxq);
=20
 drop:
 	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
@@ -1659,6 +1688,8 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
=20
 	if (rxq->xdp_flush)
 		xdp_do_flush();
+
+	page_pool_nid_changed(rxq->page_pool, numa_mem_id());
 }
=20
 static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
@@ -1881,6 +1912,7 @@ static void mana_destroy_rxq(struct mana_port_context=
 *apc,
 	struct mana_recv_buf_oob *rx_oob;
 	struct device *dev =3D gc->dev;
 	struct napi_struct *napi;
+	struct page *page;
 	int i;
=20
 	if (!rxq)
@@ -1913,10 +1945,18 @@ static void mana_destroy_rxq(struct mana_port_conte=
xt *apc,
 		dma_unmap_single(dev, rx_oob->sgl[0].address,
 				 rx_oob->sgl[0].size, DMA_FROM_DEVICE);
=20
-		put_page(virt_to_head_page(rx_oob->buf_va));
+		page =3D virt_to_head_page(rx_oob->buf_va);
+
+		if (rx_oob->from_pool)
+			page_pool_put_full_page(rxq->page_pool, page, false);
+		else
+			put_page(page);
+
 		rx_oob->buf_va =3D NULL;
 	}
=20
+	page_pool_destroy(rxq->page_pool);
+
 	if (rxq->gdma_rq)
 		mana_gd_destroy_queue(gc, rxq->gdma_rq);
=20
@@ -1927,18 +1967,20 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oo=
b *rx_oob, u32 mem_key,
 			    struct mana_rxq *rxq, struct device *dev)
 {
 	struct mana_port_context *mpc =3D netdev_priv(rxq->ndev);
+	bool from_pool =3D false;
 	dma_addr_t da;
 	void *va;
=20
 	if (mpc->rxbufs_pre)
 		va =3D mana_get_rxbuf_pre(rxq, &da);
 	else
-		va =3D mana_get_rxfrag(rxq, dev, &da, false);
+		va =3D mana_get_rxfrag(rxq, dev, &da, &from_pool, false);
=20
 	if (!va)
 		return -ENOMEM;
=20
 	rx_oob->buf_va =3D va;
+	rx_oob->from_pool =3D from_pool;
=20
 	rx_oob->sgl[0].address =3D da;
 	rx_oob->sgl[0].size =3D rxq->datasize;
@@ -2008,6 +2050,28 @@ static int mana_push_wqe(struct mana_rxq *rxq)
 	return 0;
 }
=20
+static int mana_create_page_pool(struct gdma_context *gc, struct mana_cq *=
cq,
+				 struct mana_rxq *rxq)
+{
+	struct page_pool_params pprm =3D {};
+	int ret;
+
+	pprm.pool_size =3D RX_BUFFERS_PER_QUEUE;
+	pprm.napi =3D &cq->napi;
+	pprm.dev =3D gc->dev;
+	pprm.dma_dir =3D DMA_FROM_DEVICE;
+
+	rxq->page_pool =3D page_pool_create(&pprm);
+
+	if (IS_ERR(rxq->page_pool)) {
+		ret =3D PTR_ERR(rxq->page_pool);
+		rxq->page_pool =3D NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
 static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 					u32 rxq_idx, struct mana_eq *eq,
 					struct net_device *ndev)
@@ -2106,6 +2170,13 @@ static struct mana_rxq *mana_create_rxq(struct mana_=
port_context *apc,
=20
 	netif_napi_add_weight(ndev, &cq->napi, mana_poll, 1);
=20
+	/* Create page pool for RX queue */
+	err =3D mana_create_page_pool(gc, cq, rxq);
+	if (err) {
+		netdev_err(ndev, "Create page pool err:%d\n", err);
+		goto out;
+	}
+
 	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq_idx,
 				 cq->napi.napi_id));
 	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq,
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 024ad8ddb27e..b12859511839 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -280,6 +280,7 @@ struct mana_recv_buf_oob {
 	struct gdma_wqe_request wqe_req;
=20
 	void *buf_va;
+	bool from_pool; /* allocated from a page pool */
=20
 	/* SGL of the buffer going to be sent has part of the work request. */
 	u32 num_sge;
@@ -330,6 +331,8 @@ struct mana_rxq {
 	bool xdp_flush;
 	int xdp_rc; /* XDP redirect return code */
=20
+	struct page_pool *page_pool;
+
 	/* MUST BE THE LAST MEMBER:
 	 * Each receive buffer has an associated mana_recv_buf_oob.
 	 */
--=20
2.25.1


