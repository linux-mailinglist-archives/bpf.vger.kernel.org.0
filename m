Return-Path: <bpf+bounces-4960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CF175257B
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3067E281D92
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92349182D1;
	Thu, 13 Jul 2023 14:48:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB911C99;
	Thu, 13 Jul 2023 14:48:51 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C206C2707;
	Thu, 13 Jul 2023 07:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9/ugR/AU3bX0PJ2z+vSPKDsd1pIvKnXsPbXz2slRp83LdrkKhKvQpoJmXz/6dXtyYJq/pxSLazc1zBPJtrdcoPGsuqKtNx/0zFd/cHBJc5R55GVfPgIg5xZUukqPoOIgy8MuWEiAjX/9xKtlEiVDwIidzc3ol5U/W4EVuXBkgBO71k9SV+ZqSUVUAq0IbML6zqxcOu8LPXXYWO7880ehtSztncUuHmjtxDLNK85blFAzx4n89elnqp+Yq41DvU9uYrgkt3L11iTA/yQ/2Pp2uUYPRHS1QiNl90rXw3PK9U1TIk4mcNsMg3tQ2r/iMka1gP6jLSc9dXllSU87pw7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzkOrI9emLI3vBoFC3fba8bWg9WN6lL7vpvADbhV2O4=;
 b=gjhDkP6vkjQG4c4AOFhXXWx2Cc2srAt3PfRpfrlFnVgk78pWQOIdmp9mvKLyhidAQ/82Am4kXuPDfFdaTUT/+n4zRVifcNzUYAYpnUo//kIRQiKoOFbWQmc4hCJ7fIaWxXSYEs7K1kBPnaBgmeyiXBuGL/rt90ikn48pB4ujXklzFSAdzhtyUPtS6kW1KyJA9xGAMDxgvX6YHD80p+zSs13PfgHYrX4LFuBrhfrigA+e9zEBgsf4wJaVlQforIUAk5FOkmT5mvubpY3yX/Nm4+hx7ozbVg/M+L1WHF7qP6C2RD6KTBxmQebaLNLMb3FmzX78wzUCW99KVwTyCryhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzkOrI9emLI3vBoFC3fba8bWg9WN6lL7vpvADbhV2O4=;
 b=AJ8HYIjJPEZkQf4b6CLfEMY3WTeangd6Z9tGiRPzFsimWmq8p+Oh5o65Qv2R84g991X/WPPp7ofbU5yVx0rNpqCglOWOBdNnFcpK8cSyznHaMbp9H9jOWums2NTsWtkLZ6ERD+y93Qk+Zdn6VgiELNA0aUrbK6jIj8V2GeXglgk=
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DM6PR21MB1531.namprd21.prod.outlook.com (2603:10b6:5:25f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.12; Thu, 13 Jul
 2023 14:48:46 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::e42f:9692:e651:6707]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::e42f:9692:e651:6707%4]) with mapi id 15.20.6609.007; Thu, 13 Jul 2023
 14:48:46 +0000
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
Subject: [PATCH net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH net-next] net: mana: Add page pool for RX buffers
Thread-Index: Adm1mSA+i88N/DCwBUak7+uxb6tVIw==
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
Date: Thu, 13 Jul 2023 14:48:45 +0000
Message-ID: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-exchange-messagesentrepresentingtype: 2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1443:EE_|DM6PR21MB1531:EE_
x-ms-office365-filtering-correlation-id: fd5e86bf-46d8-46f5-85b9-08db83b042b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U3WXDiWp5f+bHmc9sshQnJ/o2IS2Sz4LBx888SBan5gzOM6Xgv32TVUgyXdzOueeo41MUh/bqmhLEuKF6f5u+c94JMl4+C53mVvaO5Ff2vwLaiYIMe2y5c5OZP5Q5ZQIJ+wMUSwEYN/i7xc+kIXApU5RQQxR20p5G5XIoOusfRKhZppbcjm01ufBrweM44vtFmOgxMX5Eq8gjmgzrf4EWlPF7UHmJ6AxpLo0aMGPD4WBz1WzKG1R33vK8v1b5KEDLGSSNRtmRjvS/6xh+WiiMqE1YoiOVuS5ILJfey5VY6X6VTowg4CMMvl0tX4vNrz2nhTnJwY3f8YvRxtPcXBrWx2bO4WI7SwOUb2cYjEX6Z/LAK/PzFnEtuHV5fkVbLUMGgPhDuFY8BZad1+lNHuXgnjTZPqIGLbNd72bgin3bylSBNN9J0d6QNo5NlocqDOcz2VbVVmMMNr0gXZNV7OuqsfdEBPWK7t360NicfLAscKXp+WRXNhNYw/7dnBMvoFRmkwUtf/7XFfVKkdg490ATKpAijfiYIW2/vWBgu+3/p7U9wcibPo/JLNbm4lAuhHXPkpWhCWEakug20W9sZ29W0DO66RG4k8BBH8EJSABipBKPBYtDXA87nudRKD82eSx31ABxUpn+CLArbHEiWkt8K3nN3/C1l9ZyrRhysDIXN0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(2616005)(6512007)(26005)(186003)(6506007)(7416002)(5660300002)(8936002)(41300700001)(8676002)(4326008)(110136005)(38350700002)(38100700002)(122000001)(54906003)(82960400001)(82950400001)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(7846003)(83380400001)(71200400001)(2906002)(52116002)(10290500003)(478600001)(6486002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hBP2tuiv5Ma+Amxa68K8EJDJ6WWGK3uq61XI6ThtF3+L+LL0NeGtX+aRlT?=
 =?iso-8859-1?Q?GBjecMuTB2NupRBBiJYxBMIc0WHOX1GNBa2tdXyGIoaaKngJpbXBy/l3Qc?=
 =?iso-8859-1?Q?5tt5Q2mHJ0Q8e7TT1LGiqgFAS2UAGIbFhrEP+3uIz22EXOO4vBQysc+L92?=
 =?iso-8859-1?Q?7OicpaOGcnAmieSt0XQATFupY/5tggBEVVIvFz+seXofXf5WJJT4g9X+31?=
 =?iso-8859-1?Q?WEwRxCBOyy5c3Hey5kX6qY7olXtVu9GgltLePYf6iYbwz28GaCV3xmYRmY?=
 =?iso-8859-1?Q?k3aZKEdbdPImH2NU3ix9ZNaDKXQiw8gD8hgj2LTmWDaxT+y/NJ1AfHMpAd?=
 =?iso-8859-1?Q?vOhASbQRjKUNq8/OCoW3fszD0iPnrTDtd7roNK1eZaI4IrZufpi+VfIUuq?=
 =?iso-8859-1?Q?U/72sylVCpMs8kxiKRr8Gjwr0b+pF+5bPa91hI4xKzUrISgu78jNmKUqqf?=
 =?iso-8859-1?Q?o46JVBFxt1svuJUFNu3YPOxCue+YAMol4HVvCHsD7TLXfhMa2O95wmx6hd?=
 =?iso-8859-1?Q?WAtV3BX20Sa8nja3IGRafYViA44TToP5oZ0WL1Dd3H9fgnxqFebswO3hnh?=
 =?iso-8859-1?Q?hsm0f3lCXUDJ7IrswBb4aQW4Y2AelGf13u/zIXRTC2455iBL7ruXIoXhbv?=
 =?iso-8859-1?Q?PmpjkoNnYpuwj5MR8bMQSCz+nXSwMeo6lV0BbCWnansIyjUPkqNybQQ4Fa?=
 =?iso-8859-1?Q?PFVcLseG//0vA+rY8JKm1VUl/aL5tmzgo9Y1xH2i/JsRlh+w/BvF/wNsVQ?=
 =?iso-8859-1?Q?36je6F60hiVQ5opHyusJn+ieqVeX1Hqry9hzFosDH1uSCDlOgcO0qyn2kJ?=
 =?iso-8859-1?Q?08Uooc01Xmt5gauG4nDrYiM8g6+SEBmGXAvZUzpiUi2ZwJ83rjysMLY/tD?=
 =?iso-8859-1?Q?BmNKHxpqFznGXVnV6wQBA+lc3nX4tzdR3Yzs8HX0G3t+zKRemhtJdP5ITi?=
 =?iso-8859-1?Q?EQSjMKAK4z7jVN9HGsBze7MPOGcYbr/v22wBnBVgxrNF5oj767OfgDWNaB?=
 =?iso-8859-1?Q?CsKc9MbZAFgmtFDWYhVWJwurAdt1LvOEN8imE0xHgGrlfQ9xeqFm0ayiBB?=
 =?iso-8859-1?Q?tp8QElg5154NSDX9eBOLA2TeVychPqYo4RVu8RDW8GuUJLWQ2XothIGzYe?=
 =?iso-8859-1?Q?AH3fS5fpbIfwMSNsPQAOFS9pwjjIhMHVMn5klDX2qhNTiRXvgHI1Kk84Lm?=
 =?iso-8859-1?Q?+eZIaU+nVIUEySmkzK+N/Oi9YjPLpEL4eCAdM2hHIxtF964oIiE4OgMKVY?=
 =?iso-8859-1?Q?gHsMaPUCcNq5rEFmiJX43ZbFNFuPBI/Aq64jHADwGkvUWMTbLrM69oxF6e?=
 =?iso-8859-1?Q?AimOJxa9R6ZRdeLPKc+Ey64DcpbER1gpMMxQCDbzVGSDTp04Dn+GSUSZjN?=
 =?iso-8859-1?Q?C2+gd7edQAs4izr0Ca1a+SnNyjqDYmIbcP6c1oM3YVgSBAev5L2cUs+40t?=
 =?iso-8859-1?Q?e3KMSx/Z7papeoP3dFFpd2/qfKlK9oqbE4mrVKjp1u3twTO6R89bUvag9Q?=
 =?iso-8859-1?Q?7FUI30QTPhbQJ+cnYiRroCgsM7hgkHWHZpZsWwgPSxjz4xHRlkxRj78kdI?=
 =?iso-8859-1?Q?QcPsmyeWx6+HtgwFn+9Mm0CLNniAINL7xMNlNuOISTvZs2i9yoDDDllRLQ?=
 =?iso-8859-1?Q?XNDCZ7uhSiMhSc7n4cgwd5CSS+OWVxe8V9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5e86bf-46d8-46f5-85b9-08db83b042b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 14:48:45.9912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90C9vvElG38vr3i8rxg/wqgUm2JBwd+UacRP/Xt4sewLMt+TyQv93Nta2BKsFuzklwLX3UfJhNSSXPExbzybNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1531
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add page pool for RX buffers for faster buffer cycle and reduce CPU
usage.

Get an extra ref count of a page after allocation, so after upper
layers put the page, it's still referenced by the pool. We can reuse
it as RX buffer without alloc a new page.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 73 ++++++++++++++++++-
 include/net/mana/mana.h                       |  5 ++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/et=
hernet/microsoft/mana/mana_en.c
index a499e460594b..6444a8e47852 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1507,6 +1507,34 @@ static void mana_rx_skb(void *buf_va, struct mana_rx=
comp_oob *cqe,
 	return;
 }
=20
+static struct page *mana_get_page_from_pool(struct mana_rxq *rxq)
+{
+	struct page *page;
+	int i;
+
+	i =3D rxq->pl_last + 1;
+	if (i >=3D MANA_POOL_SIZE)
+		i =3D 0;
+
+	rxq->pl_last =3D i;
+
+	page =3D rxq->pool[i];
+	if (page_ref_count(page) =3D=3D 1) {
+		get_page(page);
+		return page;
+	}
+
+	page =3D dev_alloc_page();
+	if (page) {
+		put_page(rxq->pool[i]);
+
+		get_page(page);
+		rxq->pool[i] =3D page;
+	}
+
+	return page;
+}
+
 static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 			     dma_addr_t *da, bool is_napi)
 {
@@ -1533,7 +1561,7 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, st=
ruct device *dev,
 			return NULL;
 		}
 	} else {
-		page =3D dev_alloc_page();
+		page =3D mana_get_page_from_pool(rxq);
 		if (!page)
 			return NULL;
=20
@@ -1873,6 +1901,21 @@ static int mana_create_txq(struct mana_port_context =
*apc,
 	return err;
 }
=20
+static void mana_release_rxq_pool(struct mana_rxq *rxq)
+{
+	struct page *page;
+	int i;
+
+	for (i =3D 0; i < MANA_POOL_SIZE; i++) {
+		page =3D rxq->pool[i];
+
+		if (page)
+			put_page(page);
+
+		rxq->pool[i] =3D NULL;
+	}
+}
+
 static void mana_destroy_rxq(struct mana_port_context *apc,
 			     struct mana_rxq *rxq, bool validate_state)
=20
@@ -1917,6 +1960,8 @@ static void mana_destroy_rxq(struct mana_port_context=
 *apc,
 		rx_oob->buf_va =3D NULL;
 	}
=20
+	mana_release_rxq_pool(rxq);
+
 	if (rxq->gdma_rq)
 		mana_gd_destroy_queue(gc, rxq->gdma_rq);
=20
@@ -2008,6 +2053,27 @@ static int mana_push_wqe(struct mana_rxq *rxq)
 	return 0;
 }
=20
+static int mana_alloc_rxq_pool(struct mana_rxq *rxq)
+{
+	struct page *page;
+	int i;
+
+	for (i =3D 0; i < MANA_POOL_SIZE; i++) {
+		page =3D dev_alloc_page();
+		if (!page)
+			goto err;
+
+		rxq->pool[i] =3D page;
+	}
+
+	return 0;
+
+err:
+	mana_release_rxq_pool(rxq);
+
+	return -ENOMEM;
+}
+
 static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 					u32 rxq_idx, struct mana_eq *eq,
 					struct net_device *ndev)
@@ -2029,6 +2095,11 @@ static struct mana_rxq *mana_create_rxq(struct mana_=
port_context *apc,
 	if (!rxq)
 		return NULL;
=20
+	if (mana_alloc_rxq_pool(rxq)) {
+		kfree(rxq);
+		return NULL;
+	}
+
 	rxq->ndev =3D ndev;
 	rxq->num_rx_buf =3D RX_BUFFERS_PER_QUEUE;
 	rxq->rxq_idx =3D rxq_idx;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 024ad8ddb27e..8f1f09f9e4ab 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -297,6 +297,8 @@ struct mana_recv_buf_oob {
=20
 #define MANA_XDP_MTU_MAX (PAGE_SIZE - MANA_RXBUF_PAD - XDP_PACKET_HEADROOM=
)
=20
+#define MANA_POOL_SIZE (RX_BUFFERS_PER_QUEUE * 2)
+
 struct mana_rxq {
 	struct gdma_queue *gdma_rq;
 	/* Cache the gdma receive queue id */
@@ -330,6 +332,9 @@ struct mana_rxq {
 	bool xdp_flush;
 	int xdp_rc; /* XDP redirect return code */
=20
+	struct page *pool[MANA_POOL_SIZE];
+	int pl_last;
+
 	/* MUST BE THE LAST MEMBER:
 	 * Each receive buffer has an associated mana_recv_buf_oob.
 	 */
--=20
2.25.1


