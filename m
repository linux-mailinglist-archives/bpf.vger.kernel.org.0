Return-Path: <bpf+bounces-7788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895C377C70D
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 07:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A6A281331
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 05:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E4440D;
	Tue, 15 Aug 2023 05:26:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095C23CE;
	Tue, 15 Aug 2023 05:26:28 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB841FD9;
	Mon, 14 Aug 2023 22:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXpFvZOkQLaMIC1nYtsc8MQSsuK0SuHVtDnzatMq/sahVoBv7xQmwWAxtW1ysvH8DwXjakh+3PRkqsRB2OB/oQLDGFkokl+x2oOkxVGp6V663Jj4UDQsPY3sRs79/1P/AJNEM6YlfQKR9B/q0UvdK0/8v3sZbVxXc6NkKACFzuLGcU7NuZulLq4Mi90mL0HLNc0Pgg0Te/ljPZR9hrhzi6ytBQmUp4JtsH1kl1LhdSgiu0XIQmx+97f3ScvBOnrj1cfoGnl8I+vTeZuzztNkgvk5PAU4wFXjzXk34uuUnLfCRiXdtZ3sJFsHkxzalmFq6a8nssp6nbcmgIbjwraypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spq8kFBMBVMMEMM9niuIQur1egVG9fQxPuQLKGO+keg=;
 b=l9z7/L1GwZJvi0eq4uGAbOe2nNh+EJTWym6BzI7jKhvAzVz6PTgfKhMCo0V7yyG+1fmvpafPY4wa7X18z/DcbKsfsAcEkcOef6AAXBFI0gcr2cxEge6Kxm/MwfFUujDM0GwL9hBqqLQy9ZNzJ8ToiGIDx173wAca/lUWZAcK8CVn8HE08wjwQ56I5RPvr/OKJPjT6/5qc1ZlasqetnEHekJ/PBCEmsYF72nGGKb+iI7rKWWLufvRa/UMZ+2/iSN4liLaB6woNb+R5YNepkNDbCue7JWFCJtwBbQELoEdVKA7qJQMxWQQ8XNreN87S6aRdDtoxgoGUqEwto8ZeZGOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spq8kFBMBVMMEMM9niuIQur1egVG9fQxPuQLKGO+keg=;
 b=E9pyvtBUuMoXjr+USKK3dLAQnp1TeeIGai81yabkKszLm2FTn/mUqNlvUCtLff3GiQI/rvNk3FbblgapK9hOR5bh5c7z8NM33T2ar+hOYd4AajW5I1BWobFfB/5sW/1kBDg+iEqMjKuau7nH8t7bxOmq5SYdil1UByiQUK8rHho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB8380.eurprd04.prod.outlook.com (2603:10a6:10:243::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 05:26:23 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:26:22 +0000
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
Subject: [PATCH V6 net-next 0/2] net: fec: add XDP_TX feature support
Date: Tue, 15 Aug 2023 13:19:53 +0800
Message-Id: <20230815051955.150298-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DB9PR04MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e56884f-98f3-483f-d5f9-08db9d5029b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ywAqR/WQOxjs+DzBpzTA7awdvqjz5h3OPn/02mrvP6wZxAYX+zl+0EkGtTOfqo9vCeWNARTrjOxdJtWKJWSQOg+NBH4aB7sgmSgpDA4749dI7cxFFN6ptSgAVzFXumzncX2hSPvy0WixuyWJsoJiVsHfpjhcM8pRQxDqhCuGA0whHywPzkztHBiMaT8qFnLIP82a+nmcSz0rGWtd8UhOlgX6/Q0GYEm9j71P4Ghd83qnvNlNGWujbvvde/Lg+hI4IetQmvIfhN2o4snTk6shUQKoE6t6c1/EP8rlvzujyxNskB3UEg9jMMblRoGDZ6NgDig8Wf0/wynAhVOsToHETsknKUWsT+LZrvtcy8Vu2jhMQTKRIyqfB36Kx1Toqcv71JLOvA+ayLgcedGqq9Rhz/wSMu2uy53AZ9P9PU8V+o/Hyq0ZugRrlFZD3HeHyjujFH0pNS1j7epjbIdZRTEQ49S0h/wlIyyC9ThwwiRUL10BjaD9mmMAluf+BD/Ls6A+D3zBRE5xDlJV+PcLBjOV6Upj35xHyT2o+ezkxHPAgNmtSYZgErs2SHKyScWpRPAxRmY4goOT5lXrhFMvl18LTPJOGpKhtAI8gesiAxyicuE+dIMJnTjbeDwxwvF20OC6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(186006)(1800799006)(26005)(6506007)(1076003)(6512007)(52116002)(6486002)(2616005)(6666004)(83380400001)(5660300002)(44832011)(7416002)(8676002)(8936002)(2906002)(4744005)(478600001)(316002)(41300700001)(66476007)(66556008)(66946007)(4326008)(86362001)(36756003)(38100700002)(38350700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WhdUutf0+HvOx60RX3DZbbTSq+5tHTizOJQ3mG+qkXMUFMAnfjWfEymdn3Xs?=
 =?us-ascii?Q?njjSpfknCep88d+FMNpUuT7JOsinl+kqj7z+EchIKxB1QW+LmgEW+X1in3C2?=
 =?us-ascii?Q?sAQGAL9c9WfgoFpWVjfNV4phDW7tqLOT89y/+CHH9RgLrdvFgzmigokO0I+o?=
 =?us-ascii?Q?QQKOuycfOAKEEyHKnrS4vqPmEtQ0dHgVvHWPt3gIWhUa1kY+0HSRDKiaFUMJ?=
 =?us-ascii?Q?ratZSdAK5PVr0lZjut87EoWetd4uMe/Oicz/mOZkMhKxbSYTRUF59mSsO1Ww?=
 =?us-ascii?Q?XPVm06syWqmRJcAqM+6tMuR7pvixPhVd0rIX9V7Gq5REDfgeY/31/gejdcCC?=
 =?us-ascii?Q?O1JyqbMXSvzRPE9c+JpCTOdiEUaDcTcpWEM/3VYDmct2bl5bVLfgBOR+AqAW?=
 =?us-ascii?Q?gOnyMLsRA7UNw4kchfoMD8aLbHEwjQ9C0T7ZLb7m/0reA9l+mL2OlQhyR/C+?=
 =?us-ascii?Q?lm+pMg08PFuztFoCYIV0BJRuTkVJC3kle4zm8QchTJJRNak2qzN2j3JifnyV?=
 =?us-ascii?Q?KZqHaKCsF8IvEY56C/2nFjul/7VtACSrzOBr3opIdspk80LhA+qFYcK6uYAh?=
 =?us-ascii?Q?WECq2IJVDZQxafYgqZapA0zig36JfY5yJ4VBA8JE0E7QNZLryJN3AjYYNm3a?=
 =?us-ascii?Q?6JB6pKgssqxbbyDfek7IP3qhQ4szXokvuD82wn7vphF9gOV+Olmb8uxcaT47?=
 =?us-ascii?Q?MBPq97s2xamF0adt2reSc3pqDQmkNvGJMq4pyi012+d2rzUvVfeMMB6aKogI?=
 =?us-ascii?Q?2ISmJx7ra5SteW8WpF8eI0ATASs9pD3tNMv3mNnP2ACxbxK8MAQJ7OnDZsVq?=
 =?us-ascii?Q?ZTXTQBPGkBRBvH0eXJU9EVlrAAAfr2OTGCTjFeR8rWn0mXhMWfhowoVPm4vY?=
 =?us-ascii?Q?TPkvq++bPztMO+OTLWqD9+tQfdjK+wsqaKaWx/vXQ2HuSF+dj1QWGtnOiVLA?=
 =?us-ascii?Q?EFETdLZh73voxthKJqmXSrtomk3vOGmCDUDM8fPVnM64Db/ITwIv4Ja0r9ql?=
 =?us-ascii?Q?RdY5VtxYPS/rHvq3b7QSkx1T5RirN1BKAqoUftfpJf3tsG6pBuWFfHEqCw7K?=
 =?us-ascii?Q?8h6FJdfkg5Jo2FK6tBva66z1d4LIO8EN3ZHRewywTTIEySk2YQM3jx0H0adN?=
 =?us-ascii?Q?JZZ8kuxjUxS/vMTc2vW499kibYZ5BRoiIJnwrRQip/9zLnTlnB56NsrGvwhz?=
 =?us-ascii?Q?7DXnrdLXumJzipA0uwWisP2GccG6oa72EbvgSUFtn21RjIvDMvZPSuV7q3Fe?=
 =?us-ascii?Q?l8Y5Ezg8MQI2/tqe53n5RwjCrgjv+GhomNEwqnNydFE3epbtiNh6kbmltcRC?=
 =?us-ascii?Q?kuUVuzMPzkXdZRpdq+MjjqZOjiOUmHFdtx7aKY2csh8RCWbpHoGxTS1tdEbU?=
 =?us-ascii?Q?hhYUGJV9C5xoMF3Hziuo3k8tIWvT1OzXu+sxskhWYUCCeOXGxSjmGsghhea+?=
 =?us-ascii?Q?BIoXPmV9ICz90Dr7Lvh3dFRtefWEKjRj3Lpztwpn4LKxLnl1E9+jcNPlbw58?=
 =?us-ascii?Q?I0uIiNl6F9knWU3c7Ln4Lk/7wvsC4k5maMS+cFXnpIk3Dm1h06x0KLpQZ9Sb?=
 =?us-ascii?Q?jSSS3LygFLHJBvvQlYnlUklYOomdKcwyVs9VGABv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e56884f-98f3-483f-d5f9-08db9d5029b8
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 05:26:22.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/l9Ic7FgN5rRrmST0nKroGctZzMyGA41aF3JZGZPP/XDg2GUeVi2wMqTfzFbx42dhFbHoEpwGobvAYB8IVTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
 drivers/net/ethernet/freescale/fec_main.c | 187 +++++++++++++++-------
 2 files changed, 132 insertions(+), 61 deletions(-)

-- 
2.25.1


