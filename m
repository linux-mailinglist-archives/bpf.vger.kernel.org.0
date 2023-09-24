Return-Path: <bpf+bounces-10702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026437AC621
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 03:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B26BFB209EB
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734C163F;
	Sun, 24 Sep 2023 01:33:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065F7EA;
	Sun, 24 Sep 2023 01:33:08 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F49192;
	Sat, 23 Sep 2023 18:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8Dr5eQHdNeVkz8A7/slJWQbSMuFhsbkAPvJVi38HuqUsH0YFa3VNP0YGRXyn8qxNwMYOzDRxoHPiJzvk+k0TkmBq1UkU9YZ1Gf3htt2hHmUgVEn8oxf5QLxqn0gZmoJXGEIQXrxw4km2zlJroPDIRUSbb4O76fcgEkYf8L1A11GLgrntRqQHyi/3/+agvq8JRsMP0NVOWbBMakpPL+5edSG1GEbcvtg5VoVP7VQh0DYSU347/AVMzC8fy0vp2Swo349V4plvrqtBM47UrgnA6TenCbmnJOaL4w3g8XmrxU/chESpuPpdboX4wmK+DE3wIY26JoFnUXdKgtaU5AcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE2PCYv+oUYCqjHEVmZ4YCeUOMeM3DeRepH9vdbt0XM=;
 b=eH/w7A49ge7nXb1fCGmSxIcC3jZAMWYOEvPBm6QhcHxItuya7KoBlsUBGJSXLhjFU9qGs9VEUprK+79mMdgfMn5OYNfaPCj6HAnF9oAMqFFCmZYXkIbGXidqx7RFg067ky/lgqyY95uGWqlnlpgE/0q6EwGa4X967zgdI7SKeL9DZqQDk571a4jnq+7otxP+Ysfnpe5TyeVYpe6wzgPMdlAMZuFGKc96/rs/5A4NXEwqkGooiShdoKMExqI4l3Dl7J8zAKeILIve5gHg0DkEgnvJoIhFa7FHVEJL32ZTpZqlouzmRx8GUhhfgwh7K+0b33ufGaZ0BuAriW92XkaMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE2PCYv+oUYCqjHEVmZ4YCeUOMeM3DeRepH9vdbt0XM=;
 b=OTzbTCSeBZm0iKEhjSI9uZSBK0mubVqPfIpMsekJeFjBzFLGdAR4Q6M7oBLnvTTh+qtPvqUv3M7jxkK0+mMBJ8YYANlsmZ6zYFChwW+sWFCIhzIw4C88GL5K7RtibtzT3L8OgwOVldXlG3ZgjFiVwnZMlG/Q5Vsde1Wh9POIkJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16)
 by SJ0PR21MB1323.namprd21.prod.outlook.com (2603:10b6:a03:3e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.14; Sun, 24 Sep
 2023 01:33:03 +0000
Received: from DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::827:4af:136a:236e]) by DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::827:4af:136a:236e%3]) with mapi id 15.20.6838.010; Sun, 24 Sep 2023
 01:33:03 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	sharmaajay@microsoft.com,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net, 1/3] net: mana: Fix TX CQE error handling
Date: Sat, 23 Sep 2023 18:31:45 -0700
Message-Id: <1695519107-24139-2-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To DM6PR21MB1451.namprd21.prod.outlook.com
 (2603:10b6:5:25c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1451:EE_|SJ0PR21MB1323:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afdb778-5fb3-424f-51d2-08dbbc9e31be
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 G4LrCQc1+jHX1ws0Nq/Chhiq+T9GWiDO1ogZhBc9lWuEnzGR7J80aABsr7cPok/FW9HHVly0NybBgWmjML4nmNT8AX3+gowFlruyGt7s0OhJfUfTFJs5R10jBagguuFD1jMbkuMKjc6TOoQ5s+mRFhWi54t6cF/xO4puwMxBSCYZcqsSo2Ej5FJSx99j0M4i0xoBBAWerZ8iywjh58qZqw0JYny+7/EXs8XBGUsoEdeHa20AoeGGZR4hbZEvopuy0FAijBI6Uh+ZiAjIoLcUhq/i7WVqpgsNwiZwkfywL3jPYlaOfXe8/UPJINCjxXKcL7Fbwwqz0lwN62I547WB5s1gLWTkXYXmlF3RtFEHu/HJKfhPXU+g5KSMQhB/ozucwaC1KL/eOoXmi4XetvStfSGJqJ6TJiSMyUdl6jZOq3FYbc2chgn8zjAXCE+1cJ+CkrlewsPc1Dy2qbFjX0ceXA+I1IVtn4O7PgbepF6NzptbO9bemdU9r0TWjPm7/ivyJ7NSopOl5bs/bf0Qeu6Jf2ba2sXiMiYgu7QWLvhrjaGMHTxlHRW9Vmm4GnJILmLnUUeJoaD8VRK1Q+aFlvoqgwY+qTu9+AGWWwP8a8Uv74SZjCCWiHACXdUwIxppVkSCfGU7Zpg2PdqmkW/AvdOvEIC5nty2Gvoj2LdYA070+Hk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1451.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(52116002)(10290500003)(6506007)(6486002)(6666004)(478600001)(83380400001)(6512007)(26005)(2616005)(7416002)(2906002)(41300700001)(66476007)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(5660300002)(36756003)(7846003)(82950400001)(82960400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?1s9sK1bd1/OaYeVXnn9jrdF3Ua1J5Kt5Z7riHo0jodHbwfoUKxz1siDTCG9A?=
 =?us-ascii?Q?1x2Nl8KBAWDhTuHgY0GxPhBSXOb4QMMso/xxblqjqNZEodcBklNEwJAu8anI?=
 =?us-ascii?Q?bSPNL/PWsC2BJCa0t47CqgDPC7jejO8LY1Sy1V87715ihBr8l/pzAv+KrtHP?=
 =?us-ascii?Q?rjCvjjju4QA6FWvWRKuLXSocDuivw6zR2vXZYjqQOGnwuU4z1z7/f5JpoMra?=
 =?us-ascii?Q?PwwePPIBSnpQZGq6K3GfmFRtpp0Ed6BpjigT9d09iA3gRdE3WzvDDutK2M5U?=
 =?us-ascii?Q?dRtyGgNDCQ9ZiMr1Lq8/MKxojawCFKpPAtYmZY6UlyMGKcjEeT4zqn47tI7o?=
 =?us-ascii?Q?s4X3e9CiELG22JWSnQ/kk9MA3E5QQCqU3mG98FoHfGy3s2WJ4xgMHV8y8GuP?=
 =?us-ascii?Q?2lGT2IaeHehIL24nSP1+IXOsinwvFErL0g8ehfra3My3m0sE8EriWTD3/9/8?=
 =?us-ascii?Q?N3RSkc2uVf1n5DdYchRFQHwvDB/VYQwbjFXXmX22CdDFoTOne/CQrtjVaxKN?=
 =?us-ascii?Q?DStmeeSm0PBMn/0IuMEatz4oCj5BG6Pqy/Uot+qmssmM5Y2xSpv10nVjzYHT?=
 =?us-ascii?Q?G9hMzIupUC9MNj+k6sZs7QyWMVsvbh9ksOAsBTdKZxt0q+gVHmQYW2bY7Z+Z?=
 =?us-ascii?Q?6J4Dwgnsaw8rpIENVoTTjjROevUUjWUKNlenn8aXm9pRYURKIlM3uaa3N4mw?=
 =?us-ascii?Q?bIT3MNxvEVWgkjPXLR4P66wsgDZ4BstS7UMjV/UcPzfS0sN+7TkgofTd3IUQ?=
 =?us-ascii?Q?HjIvDNEmX9KPdo/eGKmPxGwZGPZdlxMuoKiWXU3csYTqleDQbo3P07O0iYAs?=
 =?us-ascii?Q?gFVo1eViT9InksJn3GL08pyEa61Z/Ns5nu5raKe02TpoBUpyF3lG7zBsOzOE?=
 =?us-ascii?Q?hz6MP9BLIEzbmDdp0HWW5QnWqiIo6JybfIUJXipaLO+K+J0xSfCNldMQS0LQ?=
 =?us-ascii?Q?cLRZ5QbcHa0D+XyKiUb8VSTIeQY1U2YL3knbuq/nan6nOB7DRjm+NYtpBDj0?=
 =?us-ascii?Q?twOwC/V7H3GTgrgSu1Z8k1RrBdwFQpqalDPoxJWZpdXAEp2aKZmiMWIh2Mjx?=
 =?us-ascii?Q?oifF9F5xaSu/tekJDZWj3kCexDsJYKHSnsqsidvHSdxGSVEpp2/wdmEq5/EJ?=
 =?us-ascii?Q?yxIZJJJZCAaaQctdGvT1jg2btmd4k7B2trGAU7E3vCxWtMmz3Yq4mw2K+tSL?=
 =?us-ascii?Q?U074oEOqIQQoHw1t5kMkGxd0Tfd/xh5wTa+TG5XSf4xmHrbWU3C0P+Av2kTP?=
 =?us-ascii?Q?RmcEf86sKXt+kpO+gkTatrFX86bt/miZsb0rbcgQGVYh3ov5wqioFDwO8EUH?=
 =?us-ascii?Q?xU38s6GSFZ7SwVuO9AxnB0C16EO39qg6N9GBysblTUT6vnTO5wdTfGQEagvu?=
 =?us-ascii?Q?2+R3PG3mdF/VsK1xwdBl/gZjhsCS5T320PlrYDZryGDQDeZoRPXzy042q8BF?=
 =?us-ascii?Q?sBJiEA8UQiMsgK+1mYC2m3NO/9J/j7a1EFBMsCo+3oXBOCEeOgQJ89ewjCwT?=
 =?us-ascii?Q?Oe+qipXO1uGFeX7/TrDH+M0j3yZ+VxC5ztNLoN+o/9QRjJrTE47aXqSlFA0S?=
 =?us-ascii?Q?VAdMhrkH6rRhfyYhqO/8JVQWdKAdHTVB0zr2tdzL?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afdb778-5fb3-424f-51d2-08dbbc9e31be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1451.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 01:33:03.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2JyBHBIDiKS17O6Y2zRUoqFmwafT0VkwtmQNrpuiZ74Xvrj36n/wouI6y/SSFbG9g/vgfgUwRRObi7TiH3mLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For an unknown TX CQE error type (probably from a newer hardware),
still free the SKB, update the queue tail, etc., otherwise the
accounting will be wrong.

Also, TX errors can be triggered by injecting corrupted packets, so
replace the WARN_ONCE to ratelimited error logging, because we don't
need stack trace here.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4a16ebff3d1d..5cdcf7561b38 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1317,19 +1317,23 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
 		case CQE_TX_VPORT_IDX_OUT_OF_RANGE:
 		case CQE_TX_VPORT_DISABLED:
 		case CQE_TX_VLAN_TAGGING_VIOLATION:
-			WARN_ONCE(1, "TX: CQE error %d: ignored.\n",
-				  cqe_oob->cqe_hdr.cqe_type);
+			if (net_ratelimit())
+				netdev_err(ndev, "TX: CQE error %d\n",
+					   cqe_oob->cqe_hdr.cqe_type);
+
 			apc->eth_stats.tx_cqe_err++;
 			break;
 
 		default:
-			/* If the CQE type is unexpected, log an error, assert,
-			 * and go through the error path.
+			/* If the CQE type is unknown, log an error,
+			 * and still free the SKB, update tail, etc.
 			 */
-			WARN_ONCE(1, "TX: Unexpected CQE type %d: HW BUG?\n",
-				  cqe_oob->cqe_hdr.cqe_type);
+			if (net_ratelimit())
+				netdev_err(ndev, "TX: unknown CQE type %d\n",
+					   cqe_oob->cqe_hdr.cqe_type);
+
 			apc->eth_stats.tx_cqe_unknown_type++;
-			return;
+			break;
 		}
 
 		if (WARN_ON_ONCE(txq->gdma_txq_id != completions[i].wq_num))
-- 
2.25.1


