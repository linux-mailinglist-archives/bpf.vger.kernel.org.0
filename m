Return-Path: <bpf+bounces-8227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EBF783A3E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 08:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D6C1C20A55
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6B96FAC;
	Tue, 22 Aug 2023 06:59:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85241EA8;
	Tue, 22 Aug 2023 06:59:40 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE4FB;
	Mon, 21 Aug 2023 23:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4H7RjfyKaux4OwL4ihI5JnxCNZ0A/yePEuCELTFFymw1S+PtsA5/LEqTPinJIe1R9kJ5JNNt96eg2T66sydOdMJfymjpjDIaifKU5FPVLmf9RyXXMOw9ZP7pZELXc3fkTY20CrGEET7WS8Ro5dtNUyx8D2E4uF+YLuqBafC9QH1ySA3ZcUahseoPCLH6od7aSIADyfiKAXqxb4s/picHiwR+bKN/MYks8hu1fRQ0PKejUK0XVh0QivNiQrj76Am11pJhW6jo8/xhcyQ8gebKDEouSmy4S5ea8GwC0P2FvW7ROpU4f80b12jWch7bsepzQ2eb1KIU8m9dGuAMZoyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRuG5l/zhL4RCt1bbDKhOij7D8TxoAagdBhXfGStpG4=;
 b=MBnU9YX+gdR1Fb+KdYLqoOzZhlafYLzVfMPwmkokFuGS6XE6StjEv4bM3U719tnKNgS3n6GFfwrZyUOob2DZnXhR510Kd1W1nYUmOEOItctlsUhzRNKhHRq94znsryUFS8nXHpCzX1r6LH7OiLBXA6gh+Y3hCtHqdHHBy6ZIi+HUYn+mxWgSGdXT/bfeD6g1Y5N9dkY5j5nQYKJo9NoN/i+j/c1Q3/ggpJC5llJB51KfO9OGGQsZMeJQ09wY0Xz8Fen/vp+DuVZz78VSv516mJ8oO1M7Gd75fzZblkgvKYCVbQlrenjirry6LW+rcJXTJrwxJ+8VTBBS9psd88imYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRuG5l/zhL4RCt1bbDKhOij7D8TxoAagdBhXfGStpG4=;
 b=B0SFC88drPwkpg06553iuy6jPQoteFhFLw6RidpoodFCmI2yHS134noB3OX87byCcjkxZCtV01THUKB2J/o+9vOszgKkPGQD8Fg+aFevKmM5BR2zBoNvePKJft3tgapkpDmcZC5fqaH/U+fqz99tg18Qa6XFO3+0KDfBFVAoB30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PA4PR04MB8046.eurprd04.prod.outlook.com (2603:10a6:102:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 06:59:36 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 06:59:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH net-next] net: fec: add exception tracing for XDP
Date: Tue, 22 Aug 2023 14:52:55 +0800
Message-Id: <20230822065255.606739-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|PA4PR04MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 66454c26-b517-4dda-d18c-08dba2dd5831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MSOAvzeHwIYOyvwfwKcfQuQ5h4TSSED8UZbDEUvLndu34y4alPPVdZyZbsKh8p4ngMlvzyMkpkY/ksBryId/RlCDkr7JKfy86Tqg0FzrfLehDuTbmp3EpakARZHrFPJ/tszwknOSkb+BAcy2uuS1+V8O7xLv05soaKJFbEuTv34IlXmytzu643KJe8Akl7TJMO0Ytv6t0wE7dSWpxUV++5sP1AmOaV/raGrnKxUMUco4UDJ7MgloIDeu7y5O/8FqS1GbUepKdHBYWkU451eA074SdNldIgZ9VLFptsrvi+vOyXttZTXMGx4Q0I5SFJhM2Tz+re5ckfJTb1DaN3ZbTWZl/KQ38Eoro8uWk9wDYekDr1/MbwqLRWeMj5EjdyG/AI/IfvDtfufL3rZF3y2N1bsXWw666w1wthqTDR+dNdWI2Z2fZYSNr6wdQBn93Xbg7CuVML7eVqKqhncWpUxWeIgYx8/yG22zFZrKgBD/ExNUnYmxiCJ1/qfgfAdpOutXFlABKvzIifQJIc6zcnSJEwf5AcC8PuV3mavbMsGMChoFd4Vnmy1cy72ym6ApH9GgbAgJsa4W5sFg3+1hX8xqq7wLn4+K43MHITp6pobOdqjaaNVwhogHW0Q3TMeugKq1YsdSPYZu5TCCBeCBvgejQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(26005)(6512007)(38350700002)(921005)(86362001)(38100700002)(36756003)(83380400001)(41300700001)(316002)(8936002)(8676002)(66946007)(66476007)(66556008)(2906002)(5660300002)(4326008)(44832011)(7416002)(6666004)(6486002)(6506007)(52116002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9zDI7ADpp4Fa3XY2jUy0jD9GtXPneZ8EEZpj9MTTqTCco83PAmYBU0vgvEjo?=
 =?us-ascii?Q?NKrNWeR3SVjzLCra/C/GABWGAK4DSGDmCJyR4oSxzPk2KKtzlsQy4nlWJCxT?=
 =?us-ascii?Q?ce2zC+GmkoSwOA06Vvf1NGfYPlRt5d89j3GED7hDQWwjn4jd256WJQJ9uEx6?=
 =?us-ascii?Q?uvp6OiecBO/5WoP+CiGB7MP5pWJnsF4Ax2vtHDKKWseSYWo6sTOMgmPNAFU5?=
 =?us-ascii?Q?eNcALB9awa7ZIz6wysaB6SXwtJ7pRYDRa354dhmuAQP+G8HlHmdjKP2CopiH?=
 =?us-ascii?Q?gH+7pCjfnKJAmMztU0cpPVttASeDXTRwiR3x+hTiK8obMtyFz1XcsMzHQMxe?=
 =?us-ascii?Q?MCuXUKjigYhTqhrFCxpObJL3v4u+FBdgPYfvGeCf0hR/ALQNo1nkK/bDCIVk?=
 =?us-ascii?Q?7csogfmIaOckMaW+8I9CIZFLgdUvXJ+EXm0VuqGTTIcNOnHTR76RfubD0UV1?=
 =?us-ascii?Q?aRHcWKq6gE3W5wqEgsEqwSD1T7tdw5BAzLSVt5ZtO73uGPN1nKlz3DpOoGWY?=
 =?us-ascii?Q?1RoRwPuLDk1rMAG8tPnOxVZrqSrpc8LaL00+YCcFTfNvkWJ3fHzeivR4v1Yj?=
 =?us-ascii?Q?0RdFksSRhcbVK2X6D7ouhfXOzaMMFCMtvF9E1zyF9edROPx7CKhYfKxgQwvM?=
 =?us-ascii?Q?lh85N9e33LE8oOxiCgiXRWvfFIBQywfy0uwOdYMjim65E8a+ygP50AvCJsOl?=
 =?us-ascii?Q?D+3GhnmyJyfqhPE6y2NJnD8b2bRqcx1FePiy7GLkmpzQydftPKcanDYu588l?=
 =?us-ascii?Q?gDk6Sq6evjOrWeMFmUZu9NZYfIzwTaQQ3tjd6G6IgX+E2hrHwafVWdnVakOc?=
 =?us-ascii?Q?WznfbslZoVbmzgXJLDudjriVXjYnv668mBfzlxU0GDV1GE4j8YnfZNNfrY1H?=
 =?us-ascii?Q?jqfsaWLHfS9JgYUUv7IZePlhORC8BytgnMK9Wprdf0WiIueospHE6CN2/LrX?=
 =?us-ascii?Q?lJRBsMh+nR8FJTtviEyh97IK2zwS7sR784gJRXWbI5zDcmEfoFLxs59AlwkI?=
 =?us-ascii?Q?TxuBgXS8HLU6gM0DbhcXOoE4OwiwLRMIifjdn+OTw4s3bU41k4/m+cX8zJA/?=
 =?us-ascii?Q?HmDO/A1C4AAuN7MmPVMW8N0BB1OMvNhjHFF1tBZ1NVs9C/rCO1EeJHH8HKeG?=
 =?us-ascii?Q?8KgzMW7cqIirAMWYf9qOnx+VqVSJOp+kB86O9p7sNsYL9kw2g26kZ+xLcp+1?=
 =?us-ascii?Q?ll9fT6M9C6qt6dyW+wTp54GaSP3jfzvdPVq1CK7SoqQI5lJm5HmdkkbQ6cQF?=
 =?us-ascii?Q?UYC9cPMHibTJmdZuDm2EKGsfKS9ZeFXOmpTidU1nQ/WFh3rB0QbyEc3iVcrX?=
 =?us-ascii?Q?5TWnC2NJ33OixVTIqZ/YbOZjKUIra9OFz9NRD1cytGP5nrvV15lTVpPNUSkI?=
 =?us-ascii?Q?VrYjGX0Njf8n3BeNlKPTimpXtI9svGuXbkvdOdSNugLE2FaUYLkk4JxMDUed?=
 =?us-ascii?Q?Nsw/B4QvgYkR2EI4rFjr2dY38o65WDqR1WgoujzJpD1jGMj7Htyq53mH+8XY?=
 =?us-ascii?Q?CM4P7zp+GgSZmi6RZ0t6dPudXUjifKdhhSnUFsTP/t2ZRcgBT77E6o/oJsu6?=
 =?us-ascii?Q?hKXZTPNIWIWC/Rf/tQGmjBhhp9ZsTUUpvloEYZOR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66454c26-b517-4dda-d18c-08dba2dd5831
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:59:35.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UYaZODOijlp7RFESgh9CEcRnT4qS9r9W9fF07PsTngUd1e4Yoe/UYmnEhqUxGrkJ3FKC9X0ZfFc2HQ1DJTkIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As we already added the exception tracing for XDP_TX, I think it is
necessary to add the exception tracing for other XDP actions, such
as XDP_REDIRECT, XDP_ABORTED and unknown error actions.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 26 ++++++++++-------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e23a55977183..8909899e9a31 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1583,25 +1583,18 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 	case XDP_REDIRECT:
 		rxq->stats[RX_XDP_REDIRECT]++;
 		err = xdp_do_redirect(fep->netdev, xdp, prog);
-		if (!err) {
-			ret = FEC_ENET_XDP_REDIR;
-		} else {
-			ret = FEC_ENET_XDP_CONSUMED;
-			page = virt_to_head_page(xdp->data);
-			page_pool_put_page(rxq->page_pool, page, sync, true);
-		}
+		if (unlikely(err))
+			goto xdp_err;
+
+		ret = FEC_ENET_XDP_REDIR;
 		break;
 
 	case XDP_TX:
 		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err)) {
-			ret = FEC_ENET_XDP_CONSUMED;
-			page = virt_to_head_page(xdp->data);
-			page_pool_put_page(rxq->page_pool, page, sync, true);
-			trace_xdp_exception(fep->netdev, prog, act);
-		} else {
-			ret = FEC_ENET_XDP_TX;
-		}
+		if (unlikely(err))
+			goto xdp_err;
+
+		ret = FEC_ENET_XDP_TX;
 		break;
 
 	default:
@@ -1613,9 +1606,12 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 
 	case XDP_DROP:
 		rxq->stats[RX_XDP_DROP]++;
+xdp_err:
 		ret = FEC_ENET_XDP_CONSUMED;
 		page = virt_to_head_page(xdp->data);
 		page_pool_put_page(rxq->page_pool, page, sync, true);
+		if (act != XDP_DROP)
+			trace_xdp_exception(fep->netdev, prog, act);
 		break;
 	}
 
-- 
2.25.1


