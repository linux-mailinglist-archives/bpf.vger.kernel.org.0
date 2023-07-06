Return-Path: <bpf+bounces-4206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502B6749766
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8E280E75
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220846FDC;
	Thu,  6 Jul 2023 08:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5881FBF
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:20:37 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98729E6E
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkJFMY4H7IVCH/SBdF690gq7PFI9uOItLKR379euS/LgeeAWsHhCZSgpG/+o+stcI63gsypP8KR5o+AdmzUPym9L87W5zcoeddMbuHrvUOR8H29vRdTXWdDfsHeAEcur+/eFcpJyXBjhL/Lj3Cel9AC/5//rbADEqUlWlUlMcH4T7j2SdVcG00k2XT8JJPoPwPrBZej8eurQjNi+UY4CgCJdjzUEwd4pVOEPNKH+VlEE01orJtl9CeM2padDajDanCQDHT7sFerz3sbQPMjeZ6KZGVd9emwPJxoQzhmrbDgaDAV8zNYI+Bn/uKsdx0mW3qXpJjtm6EEXfxBHM8AcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoV861M//CggYMx/ntigXt1CYAXI6xhNp+GNJSoiv9M=;
 b=GUbEkMA5eI/KvkH0zYEnxgLijyGIJknNWEtsJxKa225YTzuT7L7grsxVVITkRt77bPgaM6cTiBw9H5XC+nEdnlOxlmR6x0mYJ0zOdhNIFzTcunoa26FmlifRmB406jlCQcdZcCkJZkQ4wLgLtUttWEVyi5oepEwuFl/yiSI5+oOIDQZo1FKpSqV4WeKq7PhTAU/mWcH+DHLsnlRACmsts23BCr+RkVmi7FGH8dbCw8mJWGHbd/Ng4UURM7Jo6PNLr/brp56pG3IYeZ0dQMpknd9yS4D2WodRf9q25iz2GhH4Lk04e+wJ+HwlKNzoV5N7uDxLQCS/Gw2UgyJZwQ6FZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoV861M//CggYMx/ntigXt1CYAXI6xhNp+GNJSoiv9M=;
 b=0JfEdGLmo15W190JuJtnLWk45MRxRQZFGm6Qih9rSHbdd0vawE9EInKoNdFTw1izhGgmWRcZcUm5yup7AZ7wiEccyOlsSLrh4TmIAYfBZKpOydoby7VfgQxBLJ4G78U23gYDnXRTLa8BqnL7URYWbiPPCcO3rgLZ+/sSRdcBG0BMEAk7F8RGzsoOcifaXbHxBdF8aF4af+tsSLfb6bKOFgrB0S1rK1k9HCNwErF6u3ehzRR+FGVM2BCKa87IZm2QzNVaT1te1Sr70o4zhqNYu+hV2zDy0KToiQAFebRtH5SfAc3mxylO/fLO6Oa7Hk382+8VUo+JAjxQzhxM+smiIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 08:20:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:20:33 +0000
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
Subject: [RFC bpf-next v3 7/8] selftests/bpf: add two mptcp netns helpers
Date: Thu,  6 Jul 2023 16:19:46 +0800
Message-Id: <284f75cccd4e848f17b54bec67b6889fbcde1a35.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdf3401-b54e-4b4c-7c57-08db7df9de3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KwYJLjlI7gKwj+39smJblv26K59qzSlHkhJW9ktKfDzhjSD5yYMQVfNkb2s/9k4R5EkGX6il4tGCy22R6ZVROB80h0WWipYvEaifaubRPmlWFxStg4jmFqNCKueyBrKqi+UbYZUiXAXrdXy4yO47e6aS90BNRsTGD7xKnEc6oq+5bl3jzCZm4FxEX6U0OTi0wv0E3QM53av5DtVPJMNF/LRxYneYTpfmrIG8hq2qEYw6ZX9oxzbpJLkL53SVuW2oDQW6vsMjnFT5uG6c81R9Ujv8f88B/AnpmT2eqNBaxLuSCPpCNetqeSMbSXwEnCImzCOwUPJpS2M2xI1xIpvUztHF8Culyj7L1EAxxtOu7XCtdKjYCePy8MDs9Nf5NwyX/33rY2s7Cbm0YVW1TdQI40fsv9oeD+lGo57z/UJCwD6gJXGD3NW03hHHVRbACvq9I1ZvCa0c4LeveqGYRgvN74e/0mHuii24F4/e/k2MBg5zftiNhSVowiXjx11eA0voHbI8/jCcBLrLrtrqURF+tY04hUFnEe+81vVaICe+1A6zTnHPXGtwbLuOX2bAJMlm7bzk/6l4BmBAJu+lRQUEVaz3NpF6fLn+uZFWFRIUMwFxDo5tsze2hAsS5nBiatIa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(7416002)(44832011)(8936002)(36756003)(8676002)(2616005)(186003)(6506007)(478600001)(5660300002)(26005)(6512007)(6666004)(86362001)(6486002)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(54906003)(83380400001)(921005)(110136005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9JMdtEeHiui+I24XlEIQ4eER9BzlTugYZDjtAhNfbKEn1j9qCA9GQSEeIM8?=
 =?us-ascii?Q?vIBX0OWBeP8ua0DKYJsXexwrLelYk9yR2ric29iT/b9FyliYOzSB0y2cnU+4?=
 =?us-ascii?Q?1nSzonXf/gNcATcxt4Gn9nZRclHrCCQ7llCgCOowFwV4S1XNMuXFWG+Hpu4K?=
 =?us-ascii?Q?OUmdhQh3GmTz/Ng/WqyejY0OlrUoxLDtltRAuJ+87qyE0BBO8mT03xJnKLuv?=
 =?us-ascii?Q?rqkwKdcTWupT3z7wat1UOTrqPxOEGZlIElXS5OAjRgcZmog9vXD1dbqYS0FG?=
 =?us-ascii?Q?uQvyW52yf8UUnb6ozaNqTfDFTUwU3Tx546Bh+BKy1oheHig3uUOGoogYToYO?=
 =?us-ascii?Q?zmKFTWDfFGWr7bjZKY5rpo78OV5zI28HnXfc8B4Pkij1twSrWAe58EzgB3wx?=
 =?us-ascii?Q?L/Gn/1/ITlXOMqr8YF5BizDjeT0bmNya+DjOnWtK7uiyk+3SlFrHQit9js90?=
 =?us-ascii?Q?A5KNAnDbi3qTh6AEG/kzE3APBuVKeCTXhr6f1sadYlRVS+1JAa18GMadE5aK?=
 =?us-ascii?Q?gcJ6s06vRhik4bto4g3MlaUPhUw1Jn6RhR/64lsaz6yNfQJPrxdsTS9cwkey?=
 =?us-ascii?Q?G2oFgf+lpB7hXgb+FvIG+oTrasy40VxNlxYVq8/MD2ZdSnZ//COC7S1zyOjw?=
 =?us-ascii?Q?Vn4spm6hjlyW1zbO1bw0+P+ROCG3d5O+SyRZhkA6NQXJg1JsJW+E4/8xLsjE?=
 =?us-ascii?Q?evwxJzIbngTtkxPhFb+ezyHkqVxoyiCZRe3/3fnk8hexs9tTuTEaubiHpuXb?=
 =?us-ascii?Q?xBZJLBNrkLhEvsDFz3r4RivaFXV55K4tNjpbvlkp2oqwAFfIeffZEy4PEKxi?=
 =?us-ascii?Q?EPjWOX91FJBPctiMLVuWqTHkxj9ymL7HhGxKrWvGJgMsG6rrOwuXZcrcXXlk?=
 =?us-ascii?Q?ZUPD9hzNPLW0GdaoOyA2e6m5nnS4fOIdtXm88Gz6QKqg5WBlNyyqEuO7go7x?=
 =?us-ascii?Q?89yK2uSK1F5J9mwUuDXOncRizTUyaRv5bJKvQGJCmTONvdE120ujfOOZiYDm?=
 =?us-ascii?Q?DqpbieZlrczp2QzgAHBBZJsBs3Uo/mch0b/YleugyyO606CDmJJZQ/01Ciga?=
 =?us-ascii?Q?k5TEEEZbc1c7SADULguPMtwGZ8rTcgGIISpoURlLNrlfmfLFW+FDTMO0HFnk?=
 =?us-ascii?Q?p9SUZBJTwOGcXiFhQv2qqQnVAoDiAoOvSzFL0809pojsy8VJgeGaDCFn+qrv?=
 =?us-ascii?Q?YSuF5liqBSzZD0+NgFPMLscwOL8BLIhYIr0Cn5JIP5tXoMunw7w12httgUxx?=
 =?us-ascii?Q?7tx8qkFVE6bCuENvH5G0yPXflSFwqhPnTDIgpsDDesBHb2HT8QnNxfqW6/s3?=
 =?us-ascii?Q?HuXA+ZtlZu/XTdgG3l7g0vZKqxbmEaMfLTJgKWMh67+uE8gLmI19an5cikLb?=
 =?us-ascii?Q?NupXTvq9dpORWZWRlWMt3nWJ8BpwftEgx+BD0bSuEk4rN6k5v07iUnLG1OGI?=
 =?us-ascii?Q?bW8QkzDwk7asOTQbmO4eNJ0bjRxX/brzil0mVhmnOe7QCfcvbWXi3ht5Jwlm?=
 =?us-ascii?Q?Pcv1RqfZkhGuFIzJbCs4S5fdsCnJI65uxkwW8OsPq/cqX/MrEKhD7ca9v14S?=
 =?us-ascii?Q?6B39rv4p5wovU8L/JlNmuaDZOkZB6KUUzUHZmD23?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdf3401-b54e-4b4c-7c57-08db7df9de3f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:20:33.3139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKlO69uUdPYqZFNoiy8iMXe4Oud7U7uk73x4YuPzM+1vomFAGzuXcGj+P2qDvpOeyrOYf4F7n1U3Yla2KuugwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

These new helpers will be re-used in the following commits introducing
new tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4ccca3d39a8f..b2a833a900c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -22,6 +22,26 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -147,13 +167,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	srand(time(NULL));
-	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -176,10 +191,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	cleanup_netns(nstoken);
 
 	close(cgroup_fd);
 }
-- 
2.35.3


