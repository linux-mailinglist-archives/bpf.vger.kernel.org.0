Return-Path: <bpf+bounces-4205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59325749762
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E2A1C20D0B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260E63C6;
	Thu,  6 Jul 2023 08:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF51FBF
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:20:33 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31261130
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5Mihk6AwsAXISsdAgO41osS+lsYa9MlZHYWPvE+QWKxNgXeoePO0wFP5dcXIR0rONTXg2QpOtEZNXfwN6rbYmfexLJAmNuRdw7dqWjOMzdxX4wDC1k3iCaU6P35bKLckjKGFW1ctsZoDBLddrEIlvIyU+UCDOYWI19LZyjdex5fR4FIhLDN7x8the4ctyBlmgTt+qstRFmovfldo3LGHoy/cIyQUs+mI9wbcaZ54ch1jBSwAuVtHugLtawsEmACakB6G1OdDm/obDfRR597QwwiuLOmdEHgHEnoNgMXSu/MQGxSiLpkGObLLRXlMThFTTMo/h5OfRmSxlqSr+HsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=NzID4LfvkVOcdRHC6j4qWFHPHTCZOQAdpNHzRFHPitr2xLviZz9Zsd2QTfEK0pTEgOGCil3rz/L1ba5GNA3hv4lJB8l2I/MWPd0Df0QtBRBQDn8fHJpaWGMR1wm1Nc5l6Q5C1v4u3REh+gQUwamDEGkF8E3up/O0kht+waOYq5H1NZXb8egwfN2sXoEN8wLVnUspSBxADgnxDBxODsc4zV4zoHca8KGsT0tILrGuaH187ftIv0rUzY7f3FUFWvEaIzEDp7bv6TYpQxq67F0NfUgpmFZ4TtLJWMDX/3p/9vxXgIR2fCLiePWDZtXXMbEOdivpVAPd7EwaniA8dvF0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=RyWoVuU48TCUzkW5Sk+OqedM3wi0ovR//XF7Kn8ECC1S/Lq54BrOwEITwBHmn4fh+1eXDazYoSexTm4FukuInYOdAc9V2dI/XkpTbQzpWiNUsYklcYe0J75CIG4ihbW9rwlqQzPS/A45XO17lowVF6kcaDRrGzU0esJ7EatSaRPJr1/+sw/RybiaUSBvmw47SuUSd96NJ6aEdrWEYNDFa3EEAcJ3hOxq4UrL2HcodRpK03r994hd21EOXbz098kNNhTWxaCLNIDrw/mgGoxroi+uLRiLFbj4HHQeXRdxyrPfJX210ZroIP0PEeZVNhI49ZzterBCQjBq9uDhm87O0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 08:20:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:20:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [RFC bpf-next v3 6/8] selftests/bpf: use random netns name for mptcp
Date: Thu,  6 Jul 2023 16:19:45 +0800
Message-Id: <c9376586772e23ae2bb4311225cc3e5c87402cf9.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 51594e7f-0d28-4cc3-dc55-08db7df9dae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xEsGdsMrLYQmWaLlWnaPAz7YKl5KklSTE1n/fOk/klw21rlvBRF+ntCUiDqZPaFtTibnMkWzoAYW7SCEk0IzIdWXilr5k+7oX7tNS0xonGzYP05LdJL7Br9Bo1aykj8ZxNrUadFurwilYpwqYtf/LEjp4FkCLNdrDLXN6ob7xbIQD+qB1Fdxc78ej/Zi1PnYg0ocFDyotCW20+lhR7qO+VMi/CbJ0ZyYKRkCXbjiK9yeRQbZLF5EQXMYQz+hEl0dKfMUOdSIrHQiTl89VSiLJmWCAvIYKNmSvzbKoTFjmmkMsDejoQ/TU8Jndf+JpBq245x7RLcCDcBS6j7ach7zNj1rQ42YW+zPjyVmyzPfWiuVmK8USmfyMN610PyjtA91L4pHXzE3ZWshbI19AyGYkvl4CXk+RB+8UNhLCFYq/hqiNMA1k3bH+Sm3JfE4Mqm4MXfij02JbD5I6yh7NjB3JvK2aYd+8BoMgGIV09DNN8UDqrm3dWaMlEXx43cwUn09CfCe2ef/x6edA/zmh89PojextbR6H4eW7a69kyOqrk8mYzklMS9ag+rquKGnB/JXZHOgv+ChfwpC3CDolgfXI7M7r4iGc+NooDv0cL0eaWKc8sh4EvSagzzC7Rl/2hKLjxQo4xX2zwygxgt7gaMOYayDwLKuPIHSWkI4p2eCc6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(7416002)(44832011)(8936002)(36756003)(8676002)(2616005)(186003)(6506007)(478600001)(5660300002)(26005)(6512007)(6666004)(86362001)(6486002)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(54906003)(83380400001)(921005)(110136005)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VkMukqPkW+hxXcxkNp6vYxBFY0D+8IlK+YMhhWdV43RYNEEgwo8W4C+zW6/s?=
 =?us-ascii?Q?yQIqPzfJoQxvRcqzIqPcjSjHwRUtxdxKtbfeZcxiRu9ltHkM0J5Z4TSEfEPx?=
 =?us-ascii?Q?Cp+pRjSQPcYPTVJPIvPcjBT1qHlbBzM49UEXNSjiW6baalt5NIWyjvfl+Rte?=
 =?us-ascii?Q?ZyNkPSx+skU5mRYF41v2Xk3LXgI3MJZAXnwQDpJ7qkvG2U/jklbHo6pDYJsI?=
 =?us-ascii?Q?Fpx+DhTUhQs/VnLsjVegimilbNUtsZxRd5mGNl5gr9kpI5KyIbxiHiB4FaKI?=
 =?us-ascii?Q?25DPJsmE5exD40pxX7dmNsUFcdlcVMlYYtBIUuqha5vthcIBFumOVrA8iVV7?=
 =?us-ascii?Q?anU2X9xUq8KAmZL7XVw3OxcZ2mH+Y5/EAvZFfa4RywRSrgOS3973YfZJld/C?=
 =?us-ascii?Q?s0tNHIXcueGqfrKotiln3GdTdciTI+OFQq4iHMPB5UV/jnSwhfjEzGxAqUjd?=
 =?us-ascii?Q?rOLx43ZZjQ6PUp9BVajLtd53NcxUOEpXQXRVhrJwC39nQm4SEd89CGDfS1gD?=
 =?us-ascii?Q?8MBVMbhS0Muode080yi88rK4Jd8xg6v00VIgPR6NAzK3qv1VQ4Ho0IFBEtdU?=
 =?us-ascii?Q?TvMn5z77t8YkaftCiDCnMWtldFfYKB5N6/mz2guF+0nKJst5ot+IihwMmfw/?=
 =?us-ascii?Q?GbGXkUMiUTA2Gt+Tz5j792geD/9pPH9aSpCiFtGAIAuBRmYhZKzx/+dnIx85?=
 =?us-ascii?Q?Le8xKZ2yAmTCIZABO4ZnuEHUKJVSCMuaF52QZEWzla7J5RAyjgxAh0JXILQb?=
 =?us-ascii?Q?IdliHvl8z0OvIiGCCdWsuOTO0HX88aJv1ojSKREqCqI/mQJGgTFpPCbRlwup?=
 =?us-ascii?Q?67+DNXBtU09R7hgLhzyQ2QdHgnAxIQBNis4ZXBsIF1F3iFJGNlrqQq43F96b?=
 =?us-ascii?Q?1UJQqm806Qko50OPtvqxEPn/sF9DL+VhYg9vlOFb3UQq497GHDy+7Kw2LH5h?=
 =?us-ascii?Q?SlvPGhsNHh18jokWpSSU69G9iv1DmRNVTIzgtWlLr2BDVUJ6MTyCVORCo8lJ?=
 =?us-ascii?Q?RnoQPCIXMEkbE6+ZAvl1un996KX5Q/XfwoXOtQ4f42OuJiyPPLqLrQTHW0wS?=
 =?us-ascii?Q?/IoHhETEsAh3UFOyulKEzVNonKOJeyA/7Uw+g8CoxQ9QfJ7O7skGiKgkqxko?=
 =?us-ascii?Q?0mRg98gol+CSfosmIxWCbIPL690GGUo1h94S3bxSdZVIsF1nuhqlvOM47z4S?=
 =?us-ascii?Q?iBXmgWEsl+A3dJViTkMqQlXOEiMcKUv058rL+konZLJ/Emx/7YbsCfBYTW72?=
 =?us-ascii?Q?jfccn8pG/FcsfQlIVjyDbes0Pq0Ql4Wx/Fbs5nai7HqVRy6i587jfEbmBUhN?=
 =?us-ascii?Q?VAeMlAasV0i2sRyAGt0qAYghViu1kaF7L/Qbr77ec8LFT2SgaFMCC+R5BDyd?=
 =?us-ascii?Q?wNiSdGv5ywXH1hM/hTLDv1hZfVX3hFE3ZdqR6RaoJ9D5KIhIgW/r7n0oXoYn?=
 =?us-ascii?Q?Bj9Pz5XRPifWxoImJhlWIo0/ITwxUkgMWWLRdPquNUFxEuQX9VVOysII3vO8?=
 =?us-ascii?Q?FGZ0lHQMWrl7ghbhAdsTPcQNnzZlb0UfQ21PsJlK9Tdk+2+wfp6kKnWkaXEm?=
 =?us-ascii?Q?AXqZKfBymin6J+fRsy0+c+DXg6kvfzIbP4AidBYa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51594e7f-0d28-4cc3-dc55-08db7df9dae2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:20:27.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sTPok3AC3m9O4Arp08ock2z2o3kJjMPARGuASfi4/sDx0IvhMHXSvGcY2R4iBHwLRNEpyVHDivM/OGP2dZxfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use rand() to generate a random netns name instead of using the fixed
name "mptcp_ns" for every test.

By doing that, we can re-launch the test even if there was an issue
removing the previous netns or if by accident, a netns with this generic
name already existed on the system.

Note that using a different name each will also help adding more
subtests in future commits.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..4ccca3d39a8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,7 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -147,6 +147,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
-- 
2.35.3


