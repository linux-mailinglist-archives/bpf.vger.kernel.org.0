Return-Path: <bpf+bounces-4142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA6749337
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A1C281140
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B602AA40;
	Thu,  6 Jul 2023 01:39:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4327F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:39:36 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56838E5;
	Wed,  5 Jul 2023 18:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maRpSyMZBN1rfpllDVGOS1KArXpT9SuhZEMPtfxdFP+CeK/CkDS/mkqqaducQ6qUYN2YjrfulyeNgeT1AsnEhHOgMZm1Vu0BWmlgVOBKXhtzPfBv5FIW/WVSA6nV5pSUl4a6uPgFvlL2vTeU0c4vfrv7QpDRk0mR359YNFuot+6BlN/MExmwrIhrwfObd8VAwiviRIzu7aJhlmu7xszR+CXefzBBOCT4bu2WO10Wn5PKy5AA6mY+e1sZD9l28uoW7t/XV7d5lanHuujt5+7SomXYLelz8VNYzpZoq42NZV2H1T9bzzWQpgJFFieGyzkwVEYh7ErK1GY0Q34Lgeopnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzInImeQqadkBQP7CTGz7TToUrGVGj/Vc2P4pQTbwHo=;
 b=QZNI0DHPX4F7t1fOxpufsUU1ScYeHIQXUIDVYPEdNFX9Kfg1QU+vrVjhg1+Idz/7ugnptCT+v7urXSVC43VSj6Twgs0ri7EXkv1QVIqjAsamHShAS8t4clc45qs+uFCZZjpXqw7PZ27I38Jai/YT89pg2fDeQPca+jirjPkByPdyaDkVFb/cTYdsIPkvh2/FPrJGLLPhpw9Pl4q6pKf/i9O4M6CmqIvSJ+ZTOImTV/5dqOfvaD5NAW/IQ7w2L08Qpv+s9g4wLBZr6u8WYQoic5miYIrnAkLySsNNByj9NdyU2LIYfT8kOgUKH/UzqDeoR/CjpMnWb9Sdiw7NBG87lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzInImeQqadkBQP7CTGz7TToUrGVGj/Vc2P4pQTbwHo=;
 b=XczOfxN/bpcUP439vWNR+ReX0XnoK4usaJRBkFUVPE2/vb0Ulitz5nvghubkR2nQF6wCrdK5O6onSti2UXBr1tnWB0ixFCDQAZiylil2imCsNjQzhMySiMlRC/ZfxRc84R84ntRpa6Hd0cIFR53XF64qt2qTYYONJBVR/0rrxS1PzlfipWH1PMXAyexyRXI9Qr3BYyOOg1DlqlLIaWvO/ZTWbhW7aAiygwkgizcqwyup4gFlDzHr8dc8jWFgeGAIUQxHp6EN7RjuIWmog2s0NY6DmHMjN/2UzICClmWHSu+mvosNUfFgcw8Qt0XU9JHoeUYjKx1xPkRd0esaxhXsOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SI2PR06MB4010.apcprd06.prod.outlook.com (2603:1096:4:ff::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 01:39:29 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 01:39:28 +0000
From: Minjie Du <duminjie@vivo.com>
To: anton.ivanov@cambridgegreys.com,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC])
Cc: opensource.kernel@vivo.com,
	Minjie Du <duminjie@vivo.com>
Subject: [PATCH v4] um: vector: Fix exception handling in vector_eth_configure()
Date: Thu,  6 Jul 2023 09:39:10 +0800
Message-Id: <20230706013911.695-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SI2PR06MB4010:EE_
X-MS-Office365-Filtering-Correlation-Id: 8290e036-cf62-4104-cacd-08db7dc1d661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sNh33YfQ4OtNGRUEqMsLb9gahI0CUMosOf/aXtaTEh07G4y4y1ZjDo76yMyI10Ra4LE2g3DkR0DJyGr/Kcr+p8gtxE663TafvfQZSiqNIIoQZkFAlglKWmz13yeU3ZMlyj3JknA4S4/fwYFZKI77UiiJuKXgF8SmPFz8+RdCH6nTMWAUaOvo7ZW10z2WOF7BnLH/1KoMWh6SHUcK3CThC27HJf+x+poSKbp7dGCceZAnDDN94KCCtjnCJMn5IupZWJGRlY563pm3TCV5ZzGVqq0EuvC3l2Dry92o/mmsCv0lrP4gn2sEsA0cwqkNtNS89AfVMmUTmDrZOanGNT41CGA0Q+8phMKxz+Nj6rm5khoIx9p5U3d6IvyCIKaXeiZ0cMtOcKsDbv+HC+xA+Az5BmDJWN5PXmY9JoZSdhQXMIWG9o+F0q1vHNMvQjhuQdQ4N9oHHfp9rplSv2Fdyv6H6rsomcmecar0F/XroIpHIz2usCAZkf6rtBmPAmr4THr7Rylq1iOHXNNiVONTYH5JPsPPu8rbSH5Ea08e6Z5F6e12lN4RXwjDwb8RT06l+2Nx4igRcamyZU2umacrSrF03uuVxvy4QPJMOr/euuulx2cOPtBTtmG8uV21tZLI3zTX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(8676002)(8936002)(41300700001)(6486002)(36756003)(110136005)(2906002)(316002)(4744005)(5660300002)(66476007)(4326008)(66556008)(52116002)(38350700002)(6512007)(6666004)(478600001)(107886003)(38100700002)(86362001)(186003)(66946007)(2616005)(83380400001)(26005)(1076003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvIMbCl0zlLC6OTyEF0IOx5CACvOj6f5Iwpac8X0lybmUMthxJuyYHbCPa8H?=
 =?us-ascii?Q?hVbxGeivlR8wqPDbg8DInS1fIzNpf0jMoJkKBW1wN0IRa0mvpzRNRiKWJAxP?=
 =?us-ascii?Q?nDABWGoHztILW/UCUpJGyLQAJTyCenmZq+/KaxXP/IAAkkXinWEVq397Kv4Q?=
 =?us-ascii?Q?fstYIzSPhoVS1qATVHhEd4T0r1K0ltgNKRmOQP3NWtb7btXEphvjxAlZ79/t?=
 =?us-ascii?Q?NMzyd8XfUx2ijYMg4vNtFcp98rU3XN/7uVBI4NN+MyxsYEo+T6sV2WifMNcF?=
 =?us-ascii?Q?fey0ocf4ThfUqn/f0ZYc9QiJKC0n+waA3asOIExbTuHxnyogVatyBG6eEXl7?=
 =?us-ascii?Q?2dt3PFRDiKCM39Kks1qTTNDqjsF4uRhBhqlipLHeESVZZ4gR0j3U/vSgOdkj?=
 =?us-ascii?Q?n3H7zHPZS7J9YxvGtjhvONEdrqeMi8Dquk88Rn7KNphq1l0N3Knhlje86uLY?=
 =?us-ascii?Q?PnzBrVZPl4yny2VncSDZVgs+TVpm7HIO5a9XkxC8IUlk58ohGlBDPQBgpEHo?=
 =?us-ascii?Q?8pHo2Qor1ut4Md3RsPN2c+wjmicI6fG+VlRFfonIqPwNaZjKzMlHkQgrGZja?=
 =?us-ascii?Q?tMciYW5Fy5BhTUtwdoVCUAknINsRW4Efbyw/IdRtx5tf6IicAD4CM5r6l0h0?=
 =?us-ascii?Q?bBZjHyilU32HbW4Oz1Ctf5B+OGt4MohZFt0jUpEICbGSbhPFCw2BhzRW0Ni/?=
 =?us-ascii?Q?53rst9OC8LxPj8EsPRTPFBNtTkmHVTsODYpvEh6PqIVvkFn3jSM3RUGti5zi?=
 =?us-ascii?Q?DYOg2OdE9XwJKn3M3Q8STDF/179gwZ8A2tw6M0vLsr6F9mb4Dk7YUh5oTft8?=
 =?us-ascii?Q?W3+1RseycuSg/ZtHAMpVlwKti0N+FnhiAc4H09ByXbUKAOPLy5EuFpsmuKbU?=
 =?us-ascii?Q?WnROwjYbcQRjkfXKoc+CzouhRneTBMc8he8RdFC8sXUvfNxQeFqVbq3ppdrF?=
 =?us-ascii?Q?PGendAIeV1YEUYiEtJkl4lP5Um9xD8FIatHC2O7EEgJsrqaZbNPDQeYFCDYk?=
 =?us-ascii?Q?7uu893oofUM9W+O65rA+2BAr+Q93dCWw9yG/uFMRXCQfELfjDR7hPZwZ6VyI?=
 =?us-ascii?Q?6VTk+PMz96cfehlHMqyhSRlmWjRyDlGre2RtwKTQHiNweN3K7N11Bzeg5FxQ?=
 =?us-ascii?Q?QAIkTN21wgSYDtjq4VFFtWTzxljrRRCbHzuHt+A0QcoQqMbBoW8EJlJiOKeX?=
 =?us-ascii?Q?Sj4AM5oEk5XaCb4RWrl/NFJ/Z2pzf6VDc3UHpAWO3PCi4Qf8N7uzx64jmeYl?=
 =?us-ascii?Q?MHtpp1+DroSNCF1ueQaVadhAIF2gsOAcQEhnXNNuYccQLFqeKltVa6CdAY7G?=
 =?us-ascii?Q?6Wlj2aYejByALOeh1bs8L5Xpu1wpJXE5NEuJX5RAYVpVjmfX3+ja5FqUW2ck?=
 =?us-ascii?Q?h06ASilnk2NXe4FOS1W2ZAQMxg/sSqJdX8qjrVchF3JxuE1ClanOBb9p3i6n?=
 =?us-ascii?Q?tyzJDrMZt6zLRiVrGEsKCIvm59hbk82Tq6dNbtBDKRL9WzKeVmwgUReeXbm0?=
 =?us-ascii?Q?sD+qze3hzThqGMO0iL1E4ZL+ueOrrlh/DvO1UQ2IEwbwlVJx8DXyvO9dPPSg?=
 =?us-ascii?Q?Ajfx6pxjWEsZw2wkRDkgB57x2I5wIVpMfEhfIfR2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8290e036-cf62-4104-cacd-08db7dc1d661
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 01:39:28.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wG8LuwrvbK8nqKFHqJaiZKsTpKRWiKl2OTnLvXjqBzmh8avPxBFisYWUs0LXgNXgBhhxJxLqGkdTQB5P14AJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The resource cleanup was incomplete in the implementation 
of the function "vector_eth_configure".
Thus replace the jump target
"out_undo_user_init" by "out_free_netdev".
Delate the orphan function "out_undo_user_init"

PATCH v1-v3: Modify the patch format.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 arch/um/drivers/vector_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29..7ae6ab8df 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1646,7 +1646,7 @@ static void vector_eth_configure(
 	err = register_netdevice(dev);
 	rtnl_unlock();
 	if (err)
-		goto out_undo_user_init;
+		goto out_free_netdev;
 
 	spin_lock(&vector_devices_lock);
 	list_add(&device->list, &vector_devices);
@@ -1654,8 +1654,6 @@ static void vector_eth_configure(
 
 	return;
 
-out_undo_user_init:
-	return;
 out_free_netdev:
 	free_netdev(dev);
 out_free_device:
-- 
2.39.0


