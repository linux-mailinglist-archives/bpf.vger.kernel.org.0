Return-Path: <bpf+bounces-3942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37846746C06
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DC0280F77
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8822117;
	Tue,  4 Jul 2023 08:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BCED4;
	Tue,  4 Jul 2023 08:35:27 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07EE4F;
	Tue,  4 Jul 2023 01:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfmX3YnFEtYtrKU6LcoI4zMEziQbLvMkYT8CJ/MFMe0HsWfFri6RwUllGS1T9sK/eagh5/TPk0oNfd/Z/VmtyabbbEkftzSoM20gJW0ezqJI+ZZwNUyrna3XiVimL6zwC6/qAfPCK3P1m576gtU+IP/PZ/l1f0A0wlThy1GtIdlSyXjfv9AApZ+i10if4SD0NToGz6Chlu5BaZ/tV1D2gHMdpVH1cMYfG+Plw679LLS+WioeaaNJZHFq8Jpg+m2+s2kDTqnaeVE3ig5yYK1LLSLF7g2uH9Fb12kZXkM60mUOu/4p+sA1gHMq4YY09SVhGW8Vl/hSx/jDQMG31DT8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCBHKdu710CR/q8mYwxZfnyKISgmPC2KE2z1zrBeHiA=;
 b=GOeDM8E5YzaXFL+p7DnzhKo0NiHRW+mnh9cXN0Xks6kreLstGDSPYpALSzh36S2gbuKZVXl0V9ORc9NCjQOkjVXw+2KUoPkq3wLsPgD3SySIeUcB3HXj5ivxaf6yl9cNxca0ivH7soit9W73xPv2jAhCW9Tiibr8+LRGbRI27+j9qIXqhASYs6oX1B0xHZmCW9LLUCw8PELnpOGFjgg8/B7Wh5Jg7TQaVHHYqg0dRWzsjBYQE5rIIDD5QloLemODicz4Gzki5OsQv40by+aOa6wEftMmxn15U9QIAqvCTvvbCpWqKqG9pVidFtQI9G5OzFk4yo7lcSLne8ZxHh4I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCBHKdu710CR/q8mYwxZfnyKISgmPC2KE2z1zrBeHiA=;
 b=MeYJCCrcMIb/Ndl9vVCpNhh+4miloYx0Sw1BcYl5XDxaaW20MXhmHXWALyiiqJeMjuF1kyh7RCFFtcfnr1TDIqELcq874t46v1wvVPt1LYxlIJtG+8MwfyLjKmGMGhljmDGi69oyNJkqMtsht1fZPL7dJcEI+ad/8Yub9EBP5no=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:35:21 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:35:21 +0000
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
Subject: [PATCH net 0/3] net: fec: fix some issues of ndo_xdp_xmit()
Date: Tue,  4 Jul 2023 16:29:13 +0800
Message-Id: <20230704082916.2135501-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: e591f151-80d9-44bf-b73c-08db7c699ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zv2NgYJHm85at889wr3U04GNvxyl4ndjqU4mjgIxAb3sTBOO+NWGTboQgvNXMoi2SwAE2iOhgdj/p5mGwa6bxUZcqVA+xEVZ1PYppQ7xnENlDY4LFqDjzE2kkrzqOKrDGK1B++goZBi/1UvrpNFt7eP2sIqTQcicwQix+8+4o4u9zsMZrbWBeJ7aP4VDneg3M+HW5qutUdb8Z4RhPGdwEzMDwWDWO3dvNzuePRBWZ6pngVf9wgKLElcw0UeTWART2qBrmqxsdtw07WLno18qsXayPFciS29NRx/8hlVhk+2gDJwi73XeY+ii1OyXK4JEZp6zBCMyZQWLU6yeZxIThfN4JqUyxgGNHDK8I6JaNr4yrjv10uxSx7+4awvhq9uwUAPO2YedzO/DyEXVCDf4oBRkXVza3bB+bFUGakIm8KjmFnrQrBsBzzQhNqYH2/MDHv3tB8XQjgBZAV5EJo1AyG9PML1PuVgjY9RNhQmO6KNCwW+d7pbiKMitim8cCnF607aasYp9qfjweV3ym11qJ5AfpiFzLxJLMNaO9xU0ZXpaVoMzsDRxQHIKBF6gCKGGHB13CmieFsvBiMlMvFl5FNFwfvxfrfwegZPNnYK8U039FAqhp5AsFc5tci8aQDVFiuHkP1jjAZ0+E03+Qw8WJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(1076003)(921005)(6506007)(66556008)(66946007)(4326008)(66476007)(478600001)(41300700001)(38350700002)(38100700002)(316002)(2616005)(83380400001)(186003)(9686003)(6512007)(26005)(52116002)(2906002)(5660300002)(7416002)(6486002)(36756003)(86362001)(8936002)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yWl5jK3diojxdYvwXX0qQ1Cv5AZ1LW/3+xLcIld+XlIqI0ebLtFnxXT4V7nI?=
 =?us-ascii?Q?xv1SQp9hpBIjpcUcC88V5bWiwAEk6KqyC2L4uA9CZ/q3GfWcGBV4jIAdt8JX?=
 =?us-ascii?Q?A+ZZPDQjfrFCBMKSWFMh6DPJqEwToh0BOaxiM/04exs63VuqczRiLGmcJje4?=
 =?us-ascii?Q?Sq6tlM5LCrsbmsU6uXDNzcLcyf5W15yYltEAHqq1ruYsxF+vAGudKzSLaLXB?=
 =?us-ascii?Q?qLstTPQK/ThT0ErD0rZzrpc30GbKO8JhC+bNTwplSL+/vmwR8wLy2Q8dQnRR?=
 =?us-ascii?Q?nZYVICAXllD4tRFYlW9TNkg25FE7zOOrZ1gEM4zcgZkkBuGEDBBqZHytQFRV?=
 =?us-ascii?Q?Z1kDye8VNcYQNnq8gFtrn5bx8fZLLWfyrCJX19cr/M+xm4T9dLtuQawOMYA3?=
 =?us-ascii?Q?I3Cn2Kh7VOXwI413hZSYKsSHKUU/T1EBmvWwauDVlQydEOJ5MC2FGxFKqQRo?=
 =?us-ascii?Q?ceOSbA8XsCNxQsUcRhYIizqgDviYsgpJBFbqUi25oSFjtuZ+v2dvlLa+8vGm?=
 =?us-ascii?Q?gQ2uAgGhUNlcM4U3dLvLnWXRFgmIx5RwqYoBuSfUkvuybPGB8d+I8cZzYA8a?=
 =?us-ascii?Q?41LGurgA84TYWuaQYe8hLKpsrmsVsp8NRpT8Gpndx3q+QIVa0WPrs9iagJ5V?=
 =?us-ascii?Q?TtSicWoHpb4mkS4MuxYp4v7jkL/kcCLVu4iPzP7+em/QgAfpZcjFzWe3sVW0?=
 =?us-ascii?Q?+qA5g+wOwSB5Mfhv2//avLemJihROU5NXsnRp+4BxBD2cuGclTc5UAfSpHvK?=
 =?us-ascii?Q?xaQXJFeMRW392MdbnU1F/IJt/bh/eIoB3oYC/oTU/zxrtPzF5G054ILFBHm3?=
 =?us-ascii?Q?huDLEiIGWPsGMKPrxm2IrQRq2BmBLNIy+lrRRFqxW1bDe2BHwJpcSa/3Q3Pl?=
 =?us-ascii?Q?IXXD6SKL1n/5GAPOWNgmmUhLA/MpoXbWMthz/vbuLuh5154b0uOZZCj8fzrP?=
 =?us-ascii?Q?sfPqhxMfhDIpDZ4FEVwl6K9+7HNrby3jx1dh10kfl4Ccc0SDeqYFZOJvJx2p?=
 =?us-ascii?Q?jd4F3VnIQSAgqGlS9q3j+0mCOSBHePKepoS79PnNRODlph3YTwbcTzuIt07a?=
 =?us-ascii?Q?JmZCwJ8xX31bgjCPAucmBrEjxNyua5aQGlC7P9lNU7jTDr2SSCv+Q6V55mys?=
 =?us-ascii?Q?XGucuM3VM2xWWn2qHiwwF+t7/vxzWKSF7MgcWKxgq4csNakAAHEepI922Aq8?=
 =?us-ascii?Q?dAzSnr3lnBYGUzROYErROGIoJPnuuFy9GOd1IxSXH9vB8Qw4hiYt9fv0hUdD?=
 =?us-ascii?Q?e2PeBv47akr1yRog7VrtQs8IrxUOy4d0RYReX9Uxhaab95DGBvK5GcrP0Dbw?=
 =?us-ascii?Q?nxpR3LFpwPFmpMhqCFgL8mgI39CLinAs0YgXUJhQu8HDUfQGJ3YrX5s34BGE?=
 =?us-ascii?Q?weuiN+03rmcqdXp0goZD1ma1wc9TxlEzhObaiTXjyEt7b2HRNx8RBERcl0Xt?=
 =?us-ascii?Q?ydyMuKwZvjFX5vkUlh0P706H28ogZIBgCx09h4C8opySsif6whyy4d6HFhk8?=
 =?us-ascii?Q?+yDU/F8bQNB4bUBEdTKJJOA42NIZXmSKiHTDGRITuihdCS2iIX1ADLH7Fk1+?=
 =?us-ascii?Q?OO7DqY0pMSuNlFO5w3dntP+iA/RdLiOdIu559gxr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e591f151-80d9-44bf-b73c-08db7c699ae0
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 08:35:21.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epkGh5+i/voOiuPYUIXbOGQaIsoBqj+xcaqKJwfeyuSX9GNzsGNi5+aWt0sj3vrxrZ9ey8txR74NcdG4wJqtcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Wei Fang (3):
  net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
  net: fec: recycle pages for transmitted XDP frames
  net: fec: increase the size of tx ring and update thresholds of tx
    ring

 drivers/net/ethernet/freescale/fec.h      |  17 ++-
 drivers/net/ethernet/freescale/fec_main.c | 168 +++++++++++++++-------
 2 files changed, 128 insertions(+), 57 deletions(-)

-- 
2.25.1


