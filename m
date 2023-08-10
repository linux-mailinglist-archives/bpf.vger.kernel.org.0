Return-Path: <bpf+bounces-7427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7445F7770B9
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1D3281EC8
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F120F4;
	Thu, 10 Aug 2023 06:52:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6C366;
	Thu, 10 Aug 2023 06:52:27 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94092E69;
	Wed,  9 Aug 2023 23:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaisepM5pftXHdPiIdVlfnMFuT4LMN+DhXboYy/ZCUdL/gsr3tBrs0Xvol9mwTv0/3ON6i8asjlA8Xch/7Ej9yvf2kaFgYKs0o2i7iFdZkJrrF0r6s8xl06GdmKRYQA7Z6ru58KxhP3xhhrd2FUl+4Rz9IcOwBynH2D8n4Wet5Omsh5rL8aJROYY5vHjIp+TJ2XbnPwhP80N9Cvuau86wX3zb9piiQTtLPQFaYlU3wW1xRosn9ZG+hNgIuVRH7R58MaZGj0CgpAuyAijivTtzZGOXEkHupNBaA1lxzbFo6J1yvpZq9+Qtc8pSwv+0N/V2YjFK48U8D2idwcUyAwiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVMDJTUNkclaZdJKjRcMIpnLtVggIYl/ZFwnYclK0f8=;
 b=ZANNwyh+nHpewDosCGBNTgVb/eAr6nH9O1PeL05Oeay7UN2R6hvddCrndpz+G+XVl/zFijZS6HfPaszLOQ+xkuWpFf0+mMSYTLPuT97mA+9ewqHTnK0m4p44Lg06lywzbBRuN9HyCe3l8+fXkGegtAb0nhKyl4hRdLSv+sQsRMc+IpjdZ0v5aJZDfaf1q7E403402r7/qdWMrJbvT9a6QG5BTH63yQfKkFfBryquVhnRbFpXKoy7HO0DI19/XF5ETS8+zveqPizCM9X1M+MaQSiLcugZOwdpo7KftcrtcPutCFdGetFQiLpJsXqdgzvZXgKuTYyNM8Xe0YhWsfhaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVMDJTUNkclaZdJKjRcMIpnLtVggIYl/ZFwnYclK0f8=;
 b=LR0EK/+xA+drlwHrriD7okCJRjnfGK+Ywrs1ryAmtzGTJrFjGz47SdQLLn5cidKwLQKB/3LBfImUwcr5N5nNhQgnmXN4ZELD4yThLtyi/oI0qahkg/TlD8Ky+MDZx+Mq1gqVXDYJadVjEghfmaE8h+cRsOkvXMqfrcoTcXtapWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB6PR04MB3141.eurprd04.prod.outlook.com (2603:10a6:6:c::21) by
 VI1PR04MB9761.eurprd04.prod.outlook.com (2603:10a6:800:1df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Thu, 10 Aug
 2023 06:52:23 +0000
Received: from DB6PR04MB3141.eurprd04.prod.outlook.com
 ([fe80::3203:2dba:b6f5:9104]) by DB6PR04MB3141.eurprd04.prod.outlook.com
 ([fe80::3203:2dba:b6f5:9104%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 06:52:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	jbrouer@redhat.com,
	netdev@vger.kernel.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH V5 net-next 0/2] net: fec: add XDP_TX feature support
Date: Thu, 10 Aug 2023 14:45:12 +0800
Message-Id: <20230810064514.104470-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To DB6PR04MB3141.eurprd04.prod.outlook.com
 (2603:10a6:6:c::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR04MB3141:EE_|VI1PR04MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d5b2ea-07aa-409d-74f1-08db996e598c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bkXmA6M1DeJO56lYYzKqgl2SHC6dbV5EkWcvz12jMGlCZT0aq01XB1La7uwL7SiBohxRvK4NTnoSgr9Xp8wzG8YwGoBqMRyLpghqYk4L65LWvjVS9ux1JhdQkm/3rZaIqxISZ4qLo4IHxtxRli+pWsMmUU6qB5Wwe/sV08rlwjLl/Hpll3S9nCBSKWjWAqiouAJCLNRwZ3lHEhKq7p4ikrRY7hM5AWCyh6k27AWFZQHc9Gajt89A+4JDmYICYqHhEgpurWvnY4YOCDcEc9focCscbvAWSqo9iadBZq/cB2JIePIXEtB3Nes30YYXEGeiNPitwgnsaLJxOWVRNhOztSD5pwJGJQBGaBFQXfWWJdtbkX9JQxPXdZy4hQTcLtpursYA3zbrq2rMPG6jHJyDKseKAOPny3HenS/Mw83AQSyXBJJMX9Sv/OsWVBOsqsTuSy7qoUYTF78ImTWvV/3tzAy8kruA1f9Q75XmfM1BqLo++00HtM1HKtWhNZA6CAH8K8WVG6aRcJrvchclBFyXSr6EoZbsyNeh7ThLYiMKAv5Huvu47gsen4wLi3JR7V7zxWg50MDJ9lbT6yGRUaHPhwRFcykom2nlRK+uO7vKRZ2YSyvY2oxziyJZmGXkcQ4m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3141.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(186006)(1800799006)(86362001)(2906002)(36756003)(7416002)(4744005)(44832011)(478600001)(66476007)(83380400001)(2616005)(26005)(6506007)(1076003)(38350700002)(6666004)(52116002)(6512007)(38100700002)(6486002)(8936002)(8676002)(66946007)(4326008)(5660300002)(41300700001)(921005)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19vS72k/bVLy/pLkJ0/sS53L6Q6qJtterrA4dQl9twdzGm2pQd4DXM1DaL9h?=
 =?us-ascii?Q?SrqeXRVhsCSdqr6wLiVE+bApjddoWJgsAz+o1vLierL596LtoRoWFnkfcT9E?=
 =?us-ascii?Q?oAYwWthT49+IYTJNrpWQZYq+U5D2oJ2pLHmFMHlnmy0UrQBLhzwWBwrhj4FU?=
 =?us-ascii?Q?sKnt56aFOU5jcc76eh8BReNuBHyfzRNFB2cpk/sBDJA0Wpl0S6TKgzt4WYMQ?=
 =?us-ascii?Q?ZqV8p+fwSaYZOSOcMG7FKmNi4Jaylo3uCeZDrIc+FzFXH2du7Gj5nyOoYK/c?=
 =?us-ascii?Q?tUwoB23W5SXbVfLOWe76xr3cGbO9G0Z4Dr9Q1ae6YFWTKlLjtlwGQcqKO/3h?=
 =?us-ascii?Q?LO7Jg3H7YXSOejfdPI5uD92gZxURvsPLOmnQXWdR+90GkqwaEZ8J+pvZ+jrK?=
 =?us-ascii?Q?xY3Jzwobqncg8OmosHedfjMuB6z4Y0ZPTcAnKZLfY0efmbvvFz+cven/zH3K?=
 =?us-ascii?Q?wnHWOApV+CG73dXkuClTeiw3FrJVaP+QGIESSzDUB2FsVs7/nnGtdE1RyF48?=
 =?us-ascii?Q?Q3J3ero7gN3VscEQ6wxyEBOWqS3GAUwGoLxywYkE+47E7xpWolSX+FtRAslL?=
 =?us-ascii?Q?Kw+eUaLcw84sYhS/LzCPApwY48TFgraUqBEUcumJTd/zzjWne6La16Uo4WQZ?=
 =?us-ascii?Q?vjnELEojFjUSceLj+8VAGXQJsPfug1yha8n9zFMFYG99cCV5cU85yoRHxiKU?=
 =?us-ascii?Q?CTf6vshNySd13kNdQpSeg5mkm6nYMHpmXREy5zSJIBasclrQi5lspliAdJRL?=
 =?us-ascii?Q?/kbn7OQ9UwptHD+XaotzRsTfLG3xGyXeaM8dfBTr5vH5KhLpFT2YVeBwAcru?=
 =?us-ascii?Q?Ke9maWhtEnQ20NATRtRqj5tDF99NjZN3JszWbBIxMZQbdCAABr81+AZQ2QlQ?=
 =?us-ascii?Q?NRnuaK0GITroHBWHebJmZNrOvXBdpTovKEfU1flwtsxq/Bz72sILyFhzi53M?=
 =?us-ascii?Q?17kVqVvHINe5Qh0dgCi0r6q0qpWBBLwfFNG9mhpirFT/Y0L/GD8JaeOmaBUa?=
 =?us-ascii?Q?hxxvZhSNfu/QsewiBFgQ//DzZ6lqntW5Cv/qd1XS1Z90Z6LGL52ZCRw/ux1K?=
 =?us-ascii?Q?lKNmQ9dK5m+z5JngM1CXamvsIFlB/Gw4enhluMgU6QkoAGgrslwhe1rnmJc4?=
 =?us-ascii?Q?HXov6TZ2WjVvKQpuBxD6AQqizZFiM9BQ9HD3Lp8K3zO968+M2GiDeMyEeEb6?=
 =?us-ascii?Q?eHCbLdc4vhL6lVlQIkblZl/KEaPXzYnWiRPXpgLU2AxkFxMpf1/1C4OOR+EW?=
 =?us-ascii?Q?/q0SzlIvlYvGxLgEx6cfdUgtf5LujySn3MOmAJq2dvDPTU8ZtBGzc76pR9+f?=
 =?us-ascii?Q?rcT/dfxbVrU9EFvJQbPSygQ/NeV/IwE7Mw5lIV6wvHfSN29c034Y2s+i5+8Z?=
 =?us-ascii?Q?eDRDmswpiLTrCdXhRFKK962ZghmNlzwdpCht8vUOITHZCKA+19MOXdMfpIn4?=
 =?us-ascii?Q?64AATaOL5ikhkQK/nGgcT7smdyv1SIFfz7I5rV2IrPqQK+5EbovH9qsP1B3t?=
 =?us-ascii?Q?V6zxRppM57YEMg8QQHRgndbtbvQ4CsqH1lbRA4nf2Rs5CWqfeD1zH6qnxJj1?=
 =?us-ascii?Q?UxQL52c2BTafv2EWnj9ZRtaSqsSMBVKJMHIYjcEm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d5b2ea-07aa-409d-74f1-08db996e598c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3141.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 06:52:23.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVx1Jep5W3wRlh6hrVkr8EnBCEv7HU8kwCYwKOySiqAlWLqM5lcfvop1fZ3jb6wJMYiXeO76ZwbK8seSsuTpAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set is to support the XDP_TX feature of FEC driver, the first
patch is add initial XDP_TX support, and the second patch improves the
performance of XDP_TX by not using xdp_convert_buff_to_frame(). Please
refer to the commit message of each patch for more details.

Wei Fang (2):
  net: fec: add XDP_TX feature support
  net: fec: improve XDP_TX performance

 drivers/net/ethernet/freescale/fec.h      |   6 +-
 drivers/net/ethernet/freescale/fec_main.c | 184 +++++++++++++++-------
 2 files changed, 130 insertions(+), 60 deletions(-)

-- 
2.25.1


