Return-Path: <bpf+bounces-3956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAE746E2E
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D28280F79
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02E53B7;
	Tue,  4 Jul 2023 10:01:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79A4695;
	Tue,  4 Jul 2023 10:01:09 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2120.outbound.protection.outlook.com [40.107.22.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F9CE5;
	Tue,  4 Jul 2023 03:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGnDvnzKFhbpIuR2RxAucJ10GWWbN9m5Vl/IfVSiHFWoPDNTJ8eQF62NGYIsfL/lNkUvwNcCDe3yqhPEGtsTa/tqFvmvczsgnWtCbnnKrXJiKyP4gpBgSOEiPoFuZL/+sQV6Z4kmsFqxkr3r0WPDM0ErpbuCD4DK8rFayWq7n/SCZgZEAwYv1y6uLlMjpMhzfT/9Xf0N17gw4nIkO7nGYJ4v8ku0u/qrEzfQfRT85KZmBEhDZz7KTxgQE5wQN3fbgV92Kn1s3PQt9H208v/WWiHtg7StbPk7SNL6vVvbPS3qx8qP1Z4miA+e/aHkCVtk6xpejKwYNoLyWOtf9lYAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYwZMdPaWKzAkdnBL1SY8n4OunvZFxKu0r5poIt67d4=;
 b=NbiKbadkwio/2IbCu++PuAcuXJ6KEIvnw+IFbwPuCxofWjl512Gne1cOYpOW1tpCUzgNc2zaEcPMNmHegUSz5uClFbCpDmzJ9RtGI7kvSa0r7+acbYO15S8QkxkMJBIgYt65rDsFuwd5vnrw5qY/SrPmcINxahyKb6YX/V+GZJ7fSmj88r4mojtnrAKFL6fK4xZg439Ca0Vgl/TBooZMzlCjjYmUm2Np8/x1sDZDf7foIq/VF5VfVWPOHer8ycvtd9K8gjt2Dg3MACCbw8jAzVYR7UcYvPeTbTv97eDXoIdj+oLLpHqy+C6ZiizUjGnt8pgyZ3p7sXfE4T04FcccMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYwZMdPaWKzAkdnBL1SY8n4OunvZFxKu0r5poIt67d4=;
 b=Dmg7ZMUKh4gf8ADRwbmQaM6nAfJ5torB4I1gXcFTYRILZ9DlqEE2ChPQcMLRkWWVWpsl91O9y264g/ClwvAFUeyEYBKNiFcHJBsb+LlVLPZgt6mUrLE7N08VfHQcL9tuCFfCWoK8ZrgMcHCnPZwVswA9f655iXs8DuErk+aBGQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS8P189MB1541.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:01:02 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:01:02 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH 0/4] igb: Add support for AF_XDP zero-copy
Date: Tue,  4 Jul 2023 12:00:59 +0200
Message-Id: <20230704100059.10416-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS8P189MB1541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2811acd4-d089-479c-a878-08db7c759322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q+Nu/o9OWVXCRTXlTnCaiHTu0nddk4/he5eDF10ZDzYn1t43lp0lif2AG+48XaRRwfHLQiaPuKYJDBvpWSkTUq56Zq3CsYi3QzP4lKMh1O/F34F9f7MBes3GWnk5GlU9RDi5RoEow5iY8lG21N2UNc5j+pRbIgWkfqcfWd0IBUITom04oWLIJSjfIahqWQeGGkHdIglk/CJrkZXJ938P9s3N1yAMUHaORKHqtDrVj7gWwIrf4Q9ifD3Zf+LBMoIlu8tYeJUE+FrkCaNor7lOHBLQFpnPoMwMeK14UNkx6POv9IHBQLkgssl/B/jDqB7U6MzQwPTocrMuNPWpVMsELx6EM3v57B/4PnQnI5VB59ni5NYGXaAiYjrMGLj2S4o3S6FpqtUQv45VssTbHZ4+Wkf3B/C/L/R6zpC8KlNJApiyfMfR9DfaxvA/ltr0oxqLozcFlu7aJphX/YlFoD3Gr3QQcfyULMfZYSliowuTqG2lr1xg6204J/URj0G4qguUhzh5knVsmNszDtaoFGMiy7ulSwlv8nk6wQlLDCGevaSGYjZcUPEwCypqCI2xkfQIUnq6kG3hAL2E61al+8tyN4cQsJwgaplrr4ZAEeg79eR3LXHo7i6nyJyYC76/pC9vbH+jJxbUbD9FSCVhNUc1Dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(39840400004)(451199021)(109986019)(4744005)(2906002)(41300700001)(7416002)(5660300002)(44832011)(8676002)(8936002)(36756003)(86362001)(6512007)(6666004)(6486002)(478600001)(83380400001)(26005)(186003)(2616005)(4326008)(1076003)(66556008)(54906003)(66476007)(70586007)(6506007)(66946007)(316002)(38100700002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H7btzx1qrDeLyxOEQmgZja0/v2i17yl0H3BrcfLcpkbAlIJpJia4/FDdanet?=
 =?us-ascii?Q?RiIQvgwu8sne9zKpoghGs13nDfZ062Az2OtiDPS7otLbh9ke6YGwxLYMdc15?=
 =?us-ascii?Q?XkB4Jjhboc5IoXNJdMfcLWA7cDvsMsYQwlqXOgjjP5mWf6fC9F6LZGEjlPqn?=
 =?us-ascii?Q?yILFdumwfijpXDPloghHEsQLW6XIEAS0MGaEyGmrGbiet1p+DFVFBH+jq/ln?=
 =?us-ascii?Q?HJ5lcg4fj5xv+ZZSxfjyR86579F1MfbkvFYuF7ugnmmQR4YJsQxOvJozfaHn?=
 =?us-ascii?Q?K9zev3ZmkOA7m7DtuB/YI6zUvUyB2Y4M8cPffsR6aGljuBMqPpwHIfMnSVyv?=
 =?us-ascii?Q?DjekE7HGjtQMrhbpC0GVCmXh5kmG59QkjTfNrrexEOWgNxoJShdkzlMxEDIt?=
 =?us-ascii?Q?QUYahnTOHolRJR4IcmcaOl5laCrYTNEPj/9AEEeBEntPe0hbil2h2n3ZUlqF?=
 =?us-ascii?Q?L/oWe0VFQ4am8EK+3mKX+bHG6+IsRDdkDQjcgpBt43Dtka8a0nDhzhSOFquP?=
 =?us-ascii?Q?OMkY8IKW1YhGlpM/sGZqSTEVdmkSE2QAeASP7EfpwZamvrCPiUdmOR1+0Ikg?=
 =?us-ascii?Q?w5BTcWWFwB5hj4xmpbV2vnMpnQ+7kofKw/vGnaYctXBTlQ3JIrzjgavRa+sU?=
 =?us-ascii?Q?/A09YrvS59xvizP6h9jHiaz6R4CnAVcfZt+ndOj1v9ex9X6FUawIBOU9aGnZ?=
 =?us-ascii?Q?RwAugu6fFfYvGdzDhG6NBTH5SwYexn4lSLbY4oiqDfQ0lr/R2VGtKlfTlxwQ?=
 =?us-ascii?Q?S7GStDwkxFQMruCW1eWdRNS/VQi70ZWFgNvu45Hja8ysHiCpUe6xf/a/RRvm?=
 =?us-ascii?Q?5fpNEC/kBtB9Pmu9Ixxt1R24x4BcMr2pxEmwCjouZwPkx+BtxTq7vtgm7WEF?=
 =?us-ascii?Q?Qr3o9DeYOtinGv/+oooVU8qTs82/Z1Ir27nXiBcDlLw8MtxzRburnY200nCU?=
 =?us-ascii?Q?lJ+AS+dS6nBK53d6p5x6+HelAItyfEOUU3HQLQhq6f2SQA0cffBw1qVltQ7h?=
 =?us-ascii?Q?W4MD62FmOH6SmaDXcysNoP9+fqBEkFIUsLy/Wc3oZ43ByDqtWFfm4UNSNap9?=
 =?us-ascii?Q?5beO1B1jgEgd1e1XkMq1paYOxnh4Ucmvkn66pCt+bNulBGi97l9PG5rI7YO2?=
 =?us-ascii?Q?FHs5PeG2UXQiUDv9T8jS8/roKzlgHkLZhZfZ+9oA7J/ZPlJo5jgvr5Vlv/JZ?=
 =?us-ascii?Q?vf8E7L3nAwqNusG5BB4mMy1G2DV9AXIflp6v1CJoRxaYU/JdrRA1jRst/VEI?=
 =?us-ascii?Q?wATabH87UiHB7do060yoNg4h6D7ddeYWNaJfZfRkIenR2Coy89xVDCGM0EuZ?=
 =?us-ascii?Q?guCfFnW3uAjTqbL8HRTlApKs+oEu2kREDpDVluLaUG1AM+xeLnPuoVGS2mED?=
 =?us-ascii?Q?c3dvjNzhOu1JXPAnlGdWKbeLVDsDOqFzS0kj7ICzmEJNPfcMwCsgKOPzku8D?=
 =?us-ascii?Q?PyoNJakoZcCd43BSdY+qtMddfi6RAMuUMqYhhO/mHj1qGFl/66/DczCQ9d2w?=
 =?us-ascii?Q?Gv71DNXsCDxdyYGC72tKRpsPD8uK2Va0M7D5vLRCeCiUSv515ePR56WUi2lY?=
 =?us-ascii?Q?bnWnm/0xXXPmVW9iZJNExALCvP8iCu+3qZZ0mV5AFIfUMrJ2+ZkNKKlg5Uuu?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 2811acd4-d089-479c-a878-08db7c759322
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:01:02.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmZirt+2Mu4lhM0wh+rQTXgIryrjX9k21LmtR1trYtUgBtSQdbvHaK7Hj4IBNmCTUY/FBKIHZCihXk6Ituz0EsuVJ6gDBL0/i5Nfl+kZUxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1541
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Disclaimer: My first patches to Intel drivers, implemented AF_XDP
zero-copy feature which seemed to be missing for igb. Not sure if it was
a conscious choice to not spend time implementing this for older
devices, nevertheless I send them to the list for review.

The first couple of patches adds helper funcctions to prepare for AF_XDP
zero-copy support which comes in the last couple of patches, one each
for Rx and TX paths.

Sriram Yagnaraman (4):
  igb: prepare for AF_XDP zero-copy support
  igb: Introduce txrx ring enable/disable functions
  igb: add AF_XDP zero-copy Rx support
  igb: add AF_XDP zero-copy Tx support

 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  52 ++-
 drivers/net/ethernet/intel/igb/igb_main.c | 178 +++++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 434 ++++++++++++++++++++++
 4 files changed, 633 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c

-- 
2.34.1


