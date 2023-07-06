Return-Path: <bpf+bounces-4190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996357496C3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C154281283
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5315C0;
	Thu,  6 Jul 2023 07:48:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C33415AA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:48:46 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A04A1BDB
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOeRNZIvDNZN8iY4B3l2paBT5UXDJ35TJKxDzcKly3yYvyYK/PKMlCKyr0mK0I+pN7oI7k2E5mpvCN2VwTg3sB2mtXmI4apfA0RrKXO0paVWOyTIGiWbtZ/LqVmG9os6n45DyoHPkBdoRDBTfabGL7/wn0WY4kfFrrep1ovttzdc6cbr3D/7ZKX7uQQ1H5qLMBMD0ycK5rH/AGmxOHhVmnnc/JuwDc5HOlRAEVZ1W66AU/rPQ4Ggi4+nIJieIaCWRlyK0tw3ML1MlOFGowWMYq/8ObwCGhKL5S8MREzVEBJSF3xDqYDcUU7O8QY3NwGp1dbjca/2TEQLBUdNwag07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=CMTZ+8OEoblQCyN4Bmb9lT70GZRjCJF3Y8GCGyn7DRN1tXj8cD2ujnUzNAb6L1/uJiH1MnmlfJ2HNpHrwYxWsKpF3X2o/kU+tiE8SUJLb1ymuGYrVBAfdvBZy6af//JZ/5S3y4/YfP9JkzAqdIlGH0pSxp7FTedBAcZLICeO8PWf6eVaL5pLgvULdtsEOmrXW/Rk6hoUf4tsLNTW7+EuqT0gLbCKaWkjkc2dSKHwPjqczcIyslltm/KEw5VEc5FnYJwRWFcbGZ5aiSDFwLQELR4J6M2XWMD4M8TzexrDyEICDP+PAgADi0mS+gWOtihSsw1ZKkFHVaHG8yNY4nUiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=ThvbJ6+1UCcPl9EwiRs24zAqZKL3vHqqH0G3piUIGDcbZF/KfsAHBZWxUDR0qkH3ttOC6hkgStUIHCp5aLmgxfbf3ZN2jtIjgLqWSMwuHRQa5cP/aWb51n139eoV3QaWFFLkpn0O62570xL7n9TsAy0ZgRhbVzUHmiGwm9D6KbOgBgFTORResZvOzAbtFRVyhfxY14NB/dakae12pUbuHdZXCiIIJYjquZGkUMcdO6Qp51QjocJTPueMm2JyJealZvpa5DylWfK1CA/W1Tq0DLLgftMHSKJVQNM5VMACF51WJAtQVbApZbROa0QSPwX/bLczNzP96sHJhY0nQjpSMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:48:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:48:42 +0000
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
Subject: [RFC bpf-next v2 6/8] selftests/bpf: use random netns name for mptcp
Date: Thu,  6 Jul 2023 15:47:30 +0800
Message-Id: <c9376586772e23ae2bb4311225cc3e5c87402cf9.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688629124.git.geliang.tang@suse.com>
References: <cover.1688629124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 646df88c-cbd8-4ffb-6697-08db7df56b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YA3nFS0FkZSl9OKOmH5rGTrjJjdMx+JLSgZcVaV8Tuxry8N6h0Hod7uG54dKAls2DqKFPqE/EU/AVcT9GlnMaHrQrGOkHhY1S73CkuIn8xmt9jaeA2+UiM6xhLu+ZJf3lHyQhvHvzCLgMnfU1bQN/E8tugW6Ggi5BN4Jtdy/5kqSRQHhDcR2QJmLTXfqIdHJzndJkADRQgZ2eigaAIKkJ4W5ny3zss3HxBiUZl/bMPUOvO2rSrEfuZZno8AAomJExO+fDk/Itlktho2GXhLeusFFWXp+T/ydHrVORzjVrHxR54faDS11G/V4CrT8hSWe7HGSxb+ZNo/tY3q9kJ9fox0tK+ClnKlybZIIabkVkVqU7icoQZaIyayUAUXDDI8kQHRgTQfWdrM7unyjtjUO62wSXWvi/d7zekmstW2x/xoYOh7nDp7AcHBwdVsJEfQj0dSEQsSe9NFlJRNdgoyZ4OPwuwQMWbwcguF7tcyl93VqU/5zC/v3T+TgcBhapH5Pw+vMkDQjieJnchjWElB/E2Ki//J6ChSJaORGG531McSERBCr+W94UUB3LcNqnQAJJc7gwWEecStElYnIBnL/Egc4cBONJ6mGnwYaZs987Q52iM+I/XWwRAJaff9nxKv0u520IBRYWSRuGktUjrWc0pOF9vj2MGfc/BWbXyUg9YM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(6666004)(41300700001)(7416002)(5660300002)(110136005)(36756003)(54906003)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(83380400001)(26005)(6506007)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oATVPp+2Ooiu5zwFXxra6XwPDnU3yqjmE5pmTmAUcvsgk+tfzfJac4n4eG6C?=
 =?us-ascii?Q?WrPOUfhFQvoVKUfd+IHSkjW/31f1fEuFrDK+83QlcXTyUTQhWjNu/wtvOJxK?=
 =?us-ascii?Q?6NXq4q2N5l5H50rlbS3Oe4MDAXWrZ7ERT3LuASYl69p5sK/lbIPMJO54ahUT?=
 =?us-ascii?Q?0lRYGQl+4fIttW66f4AQeCLGwnzWe5Pf2RW/lmkFfNYAmsCEaVbpeZT1LUPx?=
 =?us-ascii?Q?yFgSlzxaXMzYoPDGTQ4k26jZa1oEllRjL+aQ1NvBHcb8WAHXrdPyrTWVRcIY?=
 =?us-ascii?Q?cUe1Msr4yyt6uxFBq0r1W5+C2ufHun0HjsUvLVrrYZelb/ru6J0ZA5Cr45RH?=
 =?us-ascii?Q?QevyECsvJEu9zkYKqwy2OxOT1HNXA5gfvp5Sbace0AndWLsITeuCB2KztTOO?=
 =?us-ascii?Q?OyM6DQeaRWkCkE+Dn96IhYCgtONSqzqQmaonCAZjSsBlJfRy2N66QVZkCgdu?=
 =?us-ascii?Q?WT4mAf1LdgFJd+96T1BBdfojtS3xb6kEeQUx1fR/b3HOPbPXIgVo+CoBVrFW?=
 =?us-ascii?Q?OyHOJm3pIGMoE60td056LZ8n7/BL9cQ0QsM+SsFSKOMKpz623u9rgpDaLFMb?=
 =?us-ascii?Q?DRCUh54wY3tH5W66P+jJh5FMCL/DbFQcuL3nmKUWSLdLnMc2VPnPuYj64QNE?=
 =?us-ascii?Q?PesrKC38Fo0e2YxJL/jkBpDQVuSa8mRTWTGvC2pQrlkORlEVobIKMB6RCBuC?=
 =?us-ascii?Q?r2YxSF8Ls9IpgdtILFllG7Dj2dwLh3eOiizAbUL94eKULWiYz4bxlXx/bNsY?=
 =?us-ascii?Q?qCr7IHfX+735HVykH3KBQOXnvnAa+7UyqU3NiWh9TPXZZMG+zWJZDC3TFLGH?=
 =?us-ascii?Q?MBOM83YpREtSaXDrJoYxYI6NQ7u1vossFxtB83pDOU8XQZWTi6Xu+CdWr2XX?=
 =?us-ascii?Q?tLPvT5rDihdhYduN6Z+jz3x93vIbt+mZd/gMCqmrR+wewWEpnRlvWBe5XXlG?=
 =?us-ascii?Q?bWDto50Yjbxt1uoEnLhWLPmsBE+ezcNohBbwTlohdFP3Zm7zAKhULcZc50gw?=
 =?us-ascii?Q?iU8UJFquZRuDvjSx/tqlKggcmL9dNDsRfaI7NR/p8FLYeh7rQONR0Z0JD1gZ?=
 =?us-ascii?Q?8j0PsBlMWnoUWjcwrh8fUgEXu026fO2sfuJlhdQOucLQP4TskGCc8PJ3tOlU?=
 =?us-ascii?Q?MELnVMov5VVAfucCvLsm0CN2ORlK4yVBQgrVeJrGH+yXdQeDqoyg6+jNspNC?=
 =?us-ascii?Q?ayowTbQ5hLe6TslEDyqqyDE+MJMFjk9Z3faA3Ad2W5mxSwuui578mMpyt+oO?=
 =?us-ascii?Q?9fzMdFiOuhaHkUdFbG90+fT4/dsUBJ6CWP49yaycZkn7ZKJDah5pexMiSyrR?=
 =?us-ascii?Q?szesbo/XXn3sD7Sfx9tBzix8FmdJWFxbw5WWCuW+BsSVhOpMDOveHkFTM67V?=
 =?us-ascii?Q?qNDGY2UK7lZ5K3J4nccp7QvEBmyOMr5sglR0x+ZvKZSx+MvyVTsE97KosrM8?=
 =?us-ascii?Q?MZ222nbncdz43q1wd/awhTkpS3JIrsAociXs0l6HWostaJ0/m49y6D+ZCg70?=
 =?us-ascii?Q?1JUvTQ7TfmC6jWzVmtaVQXljy26xyfF1gomHkDI7c7uaKfv/FXBURfymBJDL?=
 =?us-ascii?Q?PLaPNqc0ccqjXMpCngp7xwkd7dcuidVgkdHnXidt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646df88c-cbd8-4ffb-6697-08db7df56b52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:48:42.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSgO6msrKJQvmhymPOnSyF2qw3SxDeNJ7qyEnu2e6r98/9rSNaq3SA7Un0z7xYsQM80rmw4O4+U03yi1jt2JoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
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


