Return-Path: <bpf+bounces-10701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAF07AC61D
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 03:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 1D4F01F23BE2
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 01:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8278763F;
	Sun, 24 Sep 2023 01:32:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4436D;
	Sun, 24 Sep 2023 01:32:54 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90FE113;
	Sat, 23 Sep 2023 18:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g17hGKn3iC3cdPvs4gCvPBYOOpRfvTuqM5lVWQe3SZeargqgc+rX8sjZpGVe4CRfLPY1xGK4SDjIwCZIhj/wmqx6QOSnh8ztQrzGxLWB2dCh3Njzm7r4uZj35NcIg7HK1WxGGzP1A1h4ObLUe5t0Q9Wi/Teo3N9fC/Qq1kDfh8iWy6bw5XiCbDTHaC5rrMGET/vWjRRnI36UckcGP4Bti0c3R2YxYxVMeqJle2qH/BSXpB3Itzp7u6FujKdjMEKxwP30ishEw4olRFUtfc9plvVWztvMMAV8MPlPV1LQ/RyV15qvNYD7/JPWGOfG4GJvHxEyAxBWaV9ar6gs/NkbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPuywyRqq8oz7RGlLDuebbtMZwM9CbilH7xM4WFGc+E=;
 b=hrdgIuyhPosvzztl6HCy6Y5i9eKZPZDpuzoGJL8sTpDDQYqF5P5BSNGUl7J6WRWLm+hxy2cp2+Y43RifwUIkMTUN5wDkGVpN3BPunjv/VyfBAgU/X1ysoegduCfBpgvNTCTK5pLWz5XlQgTjyv1yDAQQGaNOG9HKpO7sbg6jWCFkdSMJUs5FxeS57vs5gCZQGbrK79evbmmrEADzFYbAZVC9Y03oh0WclhKATILGLfdoOOHQVnIgEh4MG1v9GHItSZXvu3nfoQklpzdAvStkHnw6bCjpw39/aiT0bswIlCYEIucm/8SK8N4FCiMp+GGSiyRzdDA2gHyCdk5yVnWqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPuywyRqq8oz7RGlLDuebbtMZwM9CbilH7xM4WFGc+E=;
 b=IbQfLqJgOLqe1L9ZSWPz1EqUGUzYEgOSQeYgWd+fEwa196xQ7UfK+7MTHQbxn5rjSSRkq6sWLIG0sojAFm/hYoHKo9jrOX/pkDWFCIGrEBPzZ1dlrCY7Rl39HDr2gfy9YKQADi6+HnZMmHEZhQ6ngx4JB32m/xcfE+OJ44rG5jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16)
 by SJ0PR21MB1323.namprd21.prod.outlook.com (2603:10b6:a03:3e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.14; Sun, 24 Sep
 2023 01:32:49 +0000
Received: from DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::827:4af:136a:236e]) by DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::827:4af:136a:236e%3]) with mapi id 15.20.6838.010; Sun, 24 Sep 2023
 01:32:48 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net, 0/3] net: mana: Fix some TX processing bugs
Date: Sat, 23 Sep 2023 18:31:44 -0700
Message-Id: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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
X-MS-Office365-Filtering-Correlation-Id: f057f27f-bc2b-4725-04c7-08dbbc9e28a0
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 RBjN/G4UW3VojPkQfxrfIYzde4JNSIHc0OyFWaobwmAs20+bNfBjwCh8FBRbDZr1Mm47AtQh4f9ihg2lhc7JKt5JOzvdtvPelWG23IfWXaShyfi0EWoHaCiGxjVjCPeC0W0L6+6lSGrzRmbNXQ69nKffn0Bq4Pw8RjaGZNsGFB/QJWEPA3e05lXz812cGDBCdL+q07pZzEB9aF1jY599iHGokE9opRmaNuA7VRIJBC80+pXuVGOtnHCSEn+8s6SP/ny2XTfPwJ90LLWon6+BiFOC3ZiWyfVplc8EjDZKU35Hk3Z9QD3Ksrxl8L/EK7YFL4DrxfPob3di+m/Ow5Dq58g+l5GVc7JM5Xs3yaqfeT4rBhBGGfaqQGmhP0w8ol0nEtFAwAQ357xexcsFo7vnnhQtkGTSgIrjmecQHaM5MUunBBM8Le3i47ZerZFYxql/Ksa5z/9k/P4h06Zj1Icl2O6vK7WTymjpFa9bWpuF5SQPpZjbk0vpuvxrMwgKuUDUMQIdnTldTpfap0TvVBhwjuc3U2+bRpog4oDRJzTgmm89KoRZ7No0oqaLlmycZKGAR03yWDDD5ianG1yFGWT3ozQpuvrptCrxtBc9TE8hPzmId+GMlkHeT5LspjFPBxXX15MQaBdIY71xbL1BTDBTlV8orWEen79UefI9HuhKstY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1451.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(52116002)(10290500003)(6506007)(6486002)(6666004)(478600001)(83380400001)(6512007)(26005)(2616005)(7416002)(4744005)(2906002)(41300700001)(66476007)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(5660300002)(36756003)(7846003)(82950400001)(82960400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?uFIsjew/Ob9eeu3k+zbooSk7R5WNvH6g9OHD+P8qE+W5PY9+PQcAcnXJPZ4v?=
 =?us-ascii?Q?FfqPYI1j1zdq2LcrL8XYWhyoBVcKlWS1VJj/F3B5CHr2Oqk88aGllLJ1CxVP?=
 =?us-ascii?Q?ZKqeE1x6ELiyUjbb/CX5GBcq3FId1eOEuw1VhCFxL06K4tUBhq0v1WTvkRtr?=
 =?us-ascii?Q?vd3/m1DPyzMvHYn87yFEiwqpuUFWxpM86b61gy+qvXRlZ7X7bYjMmbEahRtg?=
 =?us-ascii?Q?DinyD6KcjMZj3AOlivDYU8NaF44cQEQ/RcGAvy304bUpAktZYmtQ0j5PTq+g?=
 =?us-ascii?Q?TWsOOqsimTxm+2peFWyMNblz+shSAe4MwdKLz/Q0dGIYRRvbmGEiGWVMX/RR?=
 =?us-ascii?Q?JwsjT4A9msbAlqM4xGeOKqECXBGG3lvD0ndLHBIDqbjecG3W6U14xhjiJWj4?=
 =?us-ascii?Q?HdxrjE2DfDmyylYXRNIgy1/NGR9H329nzI2Gbd//2mwSZ2V4YRO42N3CGeqs?=
 =?us-ascii?Q?NUwth8gUMmQTdsFDs36oWhknGYLSPGu5MnKSJJjdDSWWIhgf3CXNJ26vJcuK?=
 =?us-ascii?Q?gd2KHOVsGv7QOjMLC08QdN/vWvq1qncJv06gG5JfG4yRMw+91VJBMFgouue0?=
 =?us-ascii?Q?BR7Qh2UhJrspnHnNy/HgX6XVrd1uSa0EFpB1nU2kU/8A9d57rKZPCIJVLSuc?=
 =?us-ascii?Q?lm58K9Huj6lm0dYYWLsIspdFB8Sg3ttFjAHemhBUEdQdJsmlDZ34x+Y/yMw/?=
 =?us-ascii?Q?5Z7I/P6VKwr3n9/dPPMEfgqtW8mkowCORewtwZQNLSuZXhDT8Sbr3d3QOQCs?=
 =?us-ascii?Q?eIg6PS7H5+kLDU4by4Wh6fIOVB91GbbYKsGjcCBzOzN2PmCb6axYtemOsRMt?=
 =?us-ascii?Q?t3mwaG+QNe/+cKAmikoROieX8Df4qOjunFfqNs3l+EF6nutlTHPAl2GRHG34?=
 =?us-ascii?Q?v/xeeEUna2UPpdPTU4fOO1eTELV4U2xOVs5TCEuF4n252xYZ7322mSZFUn4l?=
 =?us-ascii?Q?fems/milK3l+gTev+ZO+x4HW+AL25ea0yZ+nIzt1ihTmCX5jL7K6BZsp5cjf?=
 =?us-ascii?Q?JY+++sfRz6QNmlTv/SY+NvahDYHRdCW2rLAwM8sTkLxOKMPJFHF6DZeO8lMR?=
 =?us-ascii?Q?jSDrKzFBebhKEVqV9hbykmGpFFxRV/LaRb0AnKIhRjT2aQbVtGVFAAIjGkZG?=
 =?us-ascii?Q?EFxYTn9/Gjftc2pGrrSeDDdkI4U2dythalev6ephFjv3YbHnWO5eZW7/yFQ8?=
 =?us-ascii?Q?rS6Wi4W33bBazN1hJmvn6+P99fF4PfiAp0e7Lun7wzxNClYYAsTbK7tToCjl?=
 =?us-ascii?Q?+sn+LXz0JeNS6YiK15wpwCJDdJTXWSZyzW7bV2fw3vOSRiERIzIJKz14zFHk?=
 =?us-ascii?Q?/DE08KAiuaeq5I7Ycm4C6Uh/m1f+48YPu1qp0X7JB07D2dSKwiOPl+WqHamo?=
 =?us-ascii?Q?lEM0V4vYayRrIA3HPeZwFlzETZbuwVtC78X4dSfSjmHg1EN7I+jQ1Np335yC?=
 =?us-ascii?Q?LFvnkhAEg56SrCBs5lNfw3ZwEDG0zqmNgdyy194Zy+UVwPeGgbBCzQgth3Uo?=
 =?us-ascii?Q?Hl2eRi8QxTcCuyR4NNMDP4aNujLcGuUqSWBRXF9H764mudXXlldEu0Yow4mB?=
 =?us-ascii?Q?hhAp4OZZHsK/lfjRcTHB0x8nx+3eU94fDPRNBFrn?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f057f27f-bc2b-4725-04c7-08dbbc9e28a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1451.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 01:32:47.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXV0D9mFu8eQAQWfCEuMsgVn7KpF5TRXl/KpcPwQGaz5ZPfiXdXf8oaHkVO6S0cvWTkfSPkxQHIheB1igunN6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix TX processing bugs on error handling, tso_bytes calculation,
and sge0 size.

Haiyang Zhang (3):
  net: mana: Fix TX CQE error handling
  net: mana: Fix the tso_bytes calculation
  net: mana: Fix oversized sge0 for GSO packets

 drivers/net/ethernet/microsoft/mana/mana_en.c | 206 ++++++++++++------
 include/net/mana/mana.h                       |   5 +-
 2 files changed, 145 insertions(+), 66 deletions(-)

-- 
2.25.1


