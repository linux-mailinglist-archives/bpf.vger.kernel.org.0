Return-Path: <bpf+bounces-4194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A1E749738
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411F1280551
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3961C11;
	Thu,  6 Jul 2023 08:16:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD0185A;
	Thu,  6 Jul 2023 08:16:30 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF451726;
	Thu,  6 Jul 2023 01:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIC7NENFerZoKnIJNM3Rba6n2J9ZUxIMsqyJhpiwZy2oShsxG5bCIRIvzNdIwwPX/AH5iRwG8grzOV6YVlqrFACf4ZTdB7a/OJ+KZFsxtb9UCPXunE5eLgLFcC1gbiL6B0B1RPM0i1Ho1Z1IlaCznjv0bMb4F+ZwTkYyD+wwjZM2z/nX4kyiLSgG0W9kYuqE26hLz25dOyBG3jcTpIHqVXPdZX5Uhid0dWdVBglnvKDcnEDltUQSPAwL87MXmayQDpb+2I9gaB8gJNDtebeiAOxXmlROCEwkEkF+APk//Bt8hU69jgUS4wqMgEa+6yMy08pCHNhyAgvZWA50N2VcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zSwOI8EilsYcWwuSD/7xGF0BhUHdBbw2kXFWbaacBw=;
 b=Cm/GsO4qxIGyu0uOasPoh2rVUGlFoFe1PugpvXhRwfINedRLTKIAfw6ZHycSoZc5V1ANqrQ49atGem5aDXygdXiJhfniHzsFwKsWx4LN0+cAe0wQ6n8p40BV8sNaqhCUNGjd9g+E5DxhFiSZnOhQGJT6HdbjwmsvXc9WWXVxJ/9RcB8osQR0s8pOr/hdEl8+yCbD+suBJy4kAAxCUb4nqZtjOGgFxq313PO9JZraMNS7/3s6Kb35cFDl/PNI8gXXKd6vu9bYdrhleolKqCvgnPRC2jAjHqqYSX2JotoyPqpxe4DBTiCI+BLUE3IS+NVtAuCGEjJydDRdbQOoDtky7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zSwOI8EilsYcWwuSD/7xGF0BhUHdBbw2kXFWbaacBw=;
 b=lqPtTwThe3ZNXnW8pmPz3lcmwVIapQS+dww0SIEQl6YLy07s8KMT7EOGkHq6f8UcdKFGpxHp4aGiunazDvITtNjDrQ0ZwPhVpaDW0das4vJPdwGYipvaGGt6FZHf2vvuheblFaArl8tP54E4rU4qpL2BQm4RVkRJkT1IiIrJoTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:16:20 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 08:16:20 +0000
From: wei.fang@nxp.com
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
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH V2 net 0/4] net: fec: fix some issues of ndo_xdp_xmit()
Date: Thu,  6 Jul 2023 16:10:08 +0800
Message-Id: <20230706081012.2278063-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6e7787-cb27-4e9d-3250-08db7df94776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dyBOgHrGb7mli5o4pMDcuMjjr6k4FTHRvCEVaixqQhcdDJ0228tsPsdoGsUOwvN8vzzLmhx19Jt5trZeL7nPYsqRuwt3q/WoAYWexabXviOhf4moSZFniKODW0ko0OvA847iVBhTyRHdyL/saR/3gI3gu9D5SxReDWtkczA76tKJD36QGneiDzXmyvv6yTUIuY+T9n25SSkcpxeDS1M+O1lfuY7GV2VW8w28jDiRfm+PSfH0bPMmtkmHbFevVLc8UuV10FEPQXvId9V56/140R349NzgCeHir/uLeF64Q3do4E+hvRWZNh0G8KEj9bJj1tngPpeKUexHUIZqKJSKcSOA/OoLLl1ZNyEonfk0eBgOV8JpRiFxx0X44OjIy/vVDCEGU9OWg+vqbxIUxJQC1MqcSdjEbJyl0Fkpjjkzw6u5RCS1qvLLAsXdvQrp+LR/qUjA8hEHNT74/26JNoTiXR+vJ1ZF0ftEpt9sI4Y8DwtK4MefFDWcGVTaPXdENGMS0e0mWV1Vc62UDnglM0Xmr802Rfsa2EnUfBHycVSAnnWGsq98D7dU142rs+u+jX0Kfu5ZwJJvcfD2ZZ/q/5ZOe8a08LcfI/yZbKBCTg0a7RiCUtlc64gj4THD+EppwRGS44MkN77c6UpiyPBhAAbZpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(186003)(8676002)(8936002)(6506007)(26005)(2616005)(2906002)(66946007)(1076003)(5660300002)(7416002)(41300700001)(36756003)(921005)(6486002)(4326008)(316002)(66476007)(83380400001)(6666004)(66556008)(6512007)(478600001)(9686003)(52116002)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mqdk6IZBU0NdHLCPVpcBy5rCAEkuivdkyfiDbq1Bpqha9/bAGqjBGvL8fULY?=
 =?us-ascii?Q?Ian5bYYUnq4STHh9XOWDfSHKW5Ddgcxn0uFsWKbEo4t0WXEUS15LJiGkuMk4?=
 =?us-ascii?Q?sVUY7IK27bYaT4beTVwEit9Xb75ECgOGWQC7/bY7qgy9dTyF3vAuSzw3YuCP?=
 =?us-ascii?Q?h7FhFkIZsM/cLF/HzdrJyX9UYFb54Kb0eHgTYqeAOqduJQ0dwSPEJzu2iYuv?=
 =?us-ascii?Q?NpGcGYuRD/nejoZVBLjgo/3lKwXD9vuhfOZyEbUv/95h6/SQFM7lBRE3E24e?=
 =?us-ascii?Q?u0g1MsbuSRW/nDvE4QYVVZ8UYAEfJGMMfRAQ5j46wBXTfhLWvtXZhDIeq8Wr?=
 =?us-ascii?Q?z3XJyslN/wtZYSTmiE3G2HMLCIhfoFM4qQiNG2ZK7MxWDH8qsRIqVHemBb5t?=
 =?us-ascii?Q?oyCi23jfAr/Yt25a2ptOUpWiaDYjLUWRqnegYSJwYWbM6FeL9cmhOXov8qVJ?=
 =?us-ascii?Q?iy5kT23HOfoKBNLS5/MJdPrNd9owxdFqxmJc94UOC/w0L7s9j6OPlkPDPTt/?=
 =?us-ascii?Q?xfL2etqDbOGa7154Wmw+Ek7yzJwKSRqBcQSOopQblhIIIZ468OYZwXA8iob1?=
 =?us-ascii?Q?by+APxnVKkm5wrj1J6pIvm6SkLfRq8PXq2pdVhBuT5OZ27raeI5AgGRubhro?=
 =?us-ascii?Q?RhC8UOMqJN6REbTIn/OngAgVtrn2Va4Oj2sa8wpUQQdbusHwsOAzP00XlT5o?=
 =?us-ascii?Q?F0CyBjHq/Ort5l7a2OoZD3/jm34r2A8Okg6QJAfy6SkjpQSxOtELYbycWHS6?=
 =?us-ascii?Q?JKIcVeqrxKcikJW3lCl9lyxXJNNm0FUWgfY887HvkdxWeH4xQUivxILF69+P?=
 =?us-ascii?Q?I3Ez55C0S3BOJpbM3BRu/vrloH34uqNp8uDe9lR1zyhbt9e3CkeY0rCz9fGp?=
 =?us-ascii?Q?mzfEyLYhaAUnDhyRRualq3RExRRtOi+XMUU5NPLsThV0s4JYn1t2L1Pbm4kt?=
 =?us-ascii?Q?cauZVUfjDh+R9Dz7ezUeIfEyv7mnlnYjI86stmCBvjjhy8PIyeiC1Iw9z1LJ?=
 =?us-ascii?Q?PnAG4ky+Dhm8Fv7P4Fih/NCwDoC4ZzWZsTEh0R9f6xgG51W0NObkSWQiSLC5?=
 =?us-ascii?Q?q3147P4WCgkPu9ww0EydUUzVZDBFKwXtsU2u7GDb+C7ig0w1pgMqe/1I68wl?=
 =?us-ascii?Q?LLK3csyFyVdWrmtiOUPOzpm7l98cUmDH8F0xpTRlKDTRmklk/4ZC2aTh8NCf?=
 =?us-ascii?Q?08wBJADA+Px6H/MMz4sBitLc7+jasCZ4BGpaeF56BhyK95vONvJouCH1KSso?=
 =?us-ascii?Q?qyMYyc5ni7L5toiEdwndOPNzOfFbiZJCqGp5fsZCdPBBNRKOQvkUDi1ytiHU?=
 =?us-ascii?Q?rcIKbnKNY6636StM0VutFby3pFg14xbge0bArepHhdsh6za6BdfeQwXk1afx?=
 =?us-ascii?Q?Pwquj4FGqXPjKAWoX/C6cyskXvN6gnFfM3TiQ71y4WGNn6j0efTXzOjiA5lP?=
 =?us-ascii?Q?i2uG0jJUN2n9kGztS/bmqRN6QBLxD82lWwYsjJnZmz0p1yzoy+O7JpfqbvZX?=
 =?us-ascii?Q?IKRr6kIFqKVY+o+PsIRpPB7fRKmcKsLNT9CjluURaZzRjExlGJLxZ06tJysJ?=
 =?us-ascii?Q?Co2SUitIYXmD44ly2+Qbqhz1fhZ9xRxKNpwxcBID?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6e7787-cb27-4e9d-3250-08db7df94776
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:16:20.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ev8IBDVksl3ln+tq4HbyZq/vUZ9W62psWc2Ft/qhPzhPVvEm86ckwzlFujNamCECJ/iDCFzO3kh5h0KE+QRVPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>

We encountered some issues when testing the ndo_xdp_xmit() interface
of the fec driver on i.MX8MP and i.MX93 platforms. These issues are
easy to reproduce, and the specific reproduction steps are as follows.

step1: The ethernet port of a board (board A) is connected to the EQOS
port of i.MX8MP/i.MX93, and the FEC port of i.MX8MP/i.MX93 is connected
to another ethernet port, such as a switch port.

step2: Board A uses the pktgen_sample03_burst_single_flow.sh to generate
and send packets to i.MX8MP/i.MX93. The command is shown below.
./pktgen_sample03_burst_single_flow.sh -i eth0 -d 192.168.6.8 -m \
56:bf:0d:68:b0:9e -s 1500

step3: i.MX8MP/i.MX93 use the xdp_redirect bfp program to redirect the
XDP frames from EQOS port to FEC port. The command is shown below.
./xdp_redirect eth1 eth0

After a few moments, the warning or error logs will be printed in the
console, for more details, please refer to the commit message of each
patch.

Wei Fang (4):
  net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
  net: fec: recycle pages for transmitted XDP frames
  net: fec: increase the size of tx ring and update tx_wake_threshold
  net: fec: use netdev_err_once() instead of netdev_err()

 drivers/net/ethernet/freescale/fec.h      |  17 ++-
 drivers/net/ethernet/freescale/fec_main.c | 166 +++++++++++++++-------
 2 files changed, 127 insertions(+), 56 deletions(-)

-- 
2.25.1


