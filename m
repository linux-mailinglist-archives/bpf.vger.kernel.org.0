Return-Path: <bpf+bounces-4171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9474949A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16711C20C98
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D41117;
	Thu,  6 Jul 2023 04:09:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77C110E
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E9A1BC0
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYx/X2LnS12lPuuvDz2p2iRIgv00rauLhLaQ8qvrjqaINHmGOSS8PA5CJWQsSSKLmzM3Cutxc1dV1POF2ch6FJ5wwyfDp96bScUAtKOWZMfPW/l2EpmkIfdlwFMTmsV9s7/e23zljrgXnyNpOo7aLREufC53pVrQxbY8MR+oQ9mhj6SumCxA9+LWGZP+RUchoVocQdNQQYh1aHiOevvA8GPSsdiD0PtM09gvSntKQc87OS3GrKV4ZEUwcjlyzIXBGdtHfcNwRPCvsM4IRF+chC2x+9SfXjjRHEb/YF0WCENM3nYxVFhBnXTS4UFPUj6IxVVUWfln1MivxKCSkV+qfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=QvzA3KwHDvAcuP82OSZ5O3vhPHtVwan/UUbHKEI3Yeqm0qOLQ2bzJ92ekEDMuFw0t43AQMff8OmtwgSMuhmJpxLLHoBtEgUlexm5DcXbrXMFfbP+nAaUxsi8TNW5OXRdpc93MfYc1ciFg0dE8y90U/WCJ1pCG1Cf4XmIAajEkS9Yy67h01I1tKVLhsdr/6u+H77Bzs6prONeZZHNDtq2Nw3QLpz9S9whSaPiYKgRaRn9ll4TD0SR7xgAWfMSyISU+lEVs4Nmn4nB48ji8GPQSfS9WmnVoRhamdydkr0eI7HiodS91A5O7w3jeykJ8rUOVWBhVoumXUThUrLofpmX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=VIsmd9nH+8y5X7881Isj916d2FdGyfFGhKkKuhRJnGmi6Ysv04MEt+JXHh5svohXAXqfPvfdQL2BXBN+ydeub+FD66o46xq0cGpg95M9TcAntkGiW3CFfptCZeI7vorhofb5H2fciCYhG94+xgtMXtQerNHERkNjYKOrLcY2GkIC9fnjftSzDvzh6g3Gk2BfrNCH/wlAKiEwbB/9qKViFam4qGOmOvRaGQqexOATaKDNx1Yk+yU9SIxNKSFGey+HT2PnkuNco4qsRm31zz+Z+yU4cbkxaykIOXdoow832ZMrlT/Sc4ZoRdeM/R0YAOfKLBf3bnjylP4/8zLttWgpGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:09:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:09:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [RFC bpf-next 6/8] selftests/bpf: use random netns name for mptcp
Date: Thu,  6 Jul 2023 12:08:50 +0800
Message-Id: <c9376586772e23ae2bb4311225cc3e5c87402cf9.1688616142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688616142.git.geliang.tang@suse.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: e71a5b59-fcdd-4a48-5d7f-08db7dd6d13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wFG8gWdRYI8JS5TTN9xHIs3FsvYoMgafJzaorzToszSoaLrupNWL1CLOLP036LSQYdODnw+sT8sK95ghxakRTDxb2JbFQ9Mlf3pMFMmbMYIA0VO0h6Xin1Lo4IQ18+oxhisO8vZdYzmP5UlJdg8BBsyalNaHQHoPTupast1AEYs+mOrEDaAgPYhV0DS1SL0YKEj1cwT1x/vdqpDCPJA+rjuYGLKrD5rmH7Acy33Wwjs9SJ83edw5pymC2rd9PNjP70WXIcBNedAOL1t8UV3iVdmn1n+qIa/k1vKeo+TSU/Wm2bG4k9kcPJLIh9v+OUSoJxeFE6MKJ1O6jU/wY1LGph/K/G0QXhQmITz1MN1i2k+V7QwQlloxjWOGhMkMb8DmyHYuWQDFfS+bxtFNrtQ4g4Uz8nXZ9vlz9gFBEIYwveXvVzIbinxqAcjS2ozoQ6fKUzaV8E8FymSoKjfP84oh4/yi1zHqgLe/0LBEMEaJZD1fuKpXyLQU7DoGQU4qK2S+RteQOeIWZXjfTtEChhAkt8wh+52Ft3jNf4n8a9BXmlarFmENoqmCFtTGRZ9SyBYTE5ZJEPU/9V1bEuj5JE9g9X3bLLBW6Fvw6ogvRSqqoE2slonm+TkEiZXOpZKmjB2aaeESEVV7Ihme0U245l6OjU80VVOHpc3+u28u1ax0FaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(54906003)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(6666004)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(83380400001)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ggDc2/nP74jXq9XLtgu4IEy9YgnxAJCo0HKhDagYwsU/teUijc9kuLvMpr5Z?=
 =?us-ascii?Q?tB8UUyZGFxTHigu/ZG5rsejlz6SJc7n9Tg6ej4bPp7rSrAHX+yzJ/fLLK6+W?=
 =?us-ascii?Q?L84Zvbss1T8DGSjXS5WdfAabERIgf0TE/E2XklXgwNDZcE0rdImd+QL7fMJO?=
 =?us-ascii?Q?v8SC9CxaDqECigb+AWI86bpYagsv+cFGyXWNjw+nJPU+RXTFVr+UOX/49HsV?=
 =?us-ascii?Q?SFfaFbhQBspXgarT6Bpjxsri8liBLNZl9bti5qHx/IQ8jCpYxPl31JabT9Q7?=
 =?us-ascii?Q?kNHsTAxsm8f8/yf3JZpOkaQZH9imJ6p+wvjM4R0DfkyvN8QaJnLzmvOHVP51?=
 =?us-ascii?Q?H0978SVacOmSmKQKrr0tfyE7q9oQ9U4KkOU/Ps7UAySDoDlITIQm6wO0rBsB?=
 =?us-ascii?Q?Cf/mXyDQMXbwD7mZHL7zSLnc2NBK2Jf2iz8ENFTxuYi/xlGeG0q5oMChMAr4?=
 =?us-ascii?Q?zhTva9+eHKOXDIkRkH372kb//51UgMw0VCDc78BkH5CxL0T5qw2XbfSanupn?=
 =?us-ascii?Q?luG9/9svNwMFjchOAwDFH3ddvwf3+SADWpEK9tmczXMdXEjdsFSUmFfwJfXc?=
 =?us-ascii?Q?tJVbTU6DiPPrEX+GVhT3eR3IXzH67gv1y8AX70OicbtiGK/hFZGbzcla5wT9?=
 =?us-ascii?Q?rSYFBGpLf1rZSeg0Th7nXQbCejb7LwOv9/WfsfLKIIFI+EDGAEzjXnEp/eUI?=
 =?us-ascii?Q?1oIoZ2PYy2t+i1Kal14mIkgF7MTcxKXVcDJ4RSf1Thp97yHO+/05PELbjz2A?=
 =?us-ascii?Q?nl0wTlmzGy4iaKVCvTV3HfCOx3wo3YKHwW5JuyAEwPNHgfG5GcrI0t/0DlJc?=
 =?us-ascii?Q?JZtLuFL+uS3AHUAo1zmFj28j2O+rqucupfT9EWTFS7AUwNnv178ch8z0VljE?=
 =?us-ascii?Q?uNi38mCtSgKQ6XJobcEISsPooE5zrd8lXLgwTYTOCaUalRu3sadXBFA1UpSx?=
 =?us-ascii?Q?c0e0ps9/sOTD2c+3xYYq1pJYRWfv/0szOHQ0SUpLfEgoBoZOOnflP9uoJFiU?=
 =?us-ascii?Q?zNwgyvpI0g2Me2iVZg9jslT39YK1q4nW/rfS4vlGSG/+qmoynOB89109kV9G?=
 =?us-ascii?Q?daKDjPWpTPMBcVNcgB4GqtRjz8N8EPSM/rNfeEPTrT1GKhn9GkxkQSQSQG7J?=
 =?us-ascii?Q?SNCZ2E3KAUb2ymMRCrhx3IXP1fwkIKc0TPwXH5nXUT7TiJMlM4p30G9tco0q?=
 =?us-ascii?Q?/9hUqqHV5OqPcERy5WQAkby2Fo694zyS2OyswvnUbS9jJd00hYttfyqkk+mk?=
 =?us-ascii?Q?9YjSnLXktsvMX0BtReon1khJ/vAugDpX5npZCti9GQ8StNNRCEYsAJgDaeJX?=
 =?us-ascii?Q?Bn/ff1A0BPKrRxUYVRvZG8ZTjEP1wOaSxuaLN4/BEumzO92PBvOOG6Fjf8W2?=
 =?us-ascii?Q?nYm9eudpcRhUOR8PvAlxwupqDSg83l8Es7p/Ox+in31JN4F+MV/JHbtTEoLJ?=
 =?us-ascii?Q?XKMm59xBmjroGRSqrSl8h+PBjfOi1wp+7ggUnK5sFOxHc8tVW+glMJaa6ljn?=
 =?us-ascii?Q?8u+RNuI/gCBBspys3USWCwwa1tUuMj8vBSILsnxYr24cgD/YSoiyidGfTiCM?=
 =?us-ascii?Q?0hk4zIoXpkpQpWcsbLUjTdPKwNghczd/8amEFZEN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a5b59-fcdd-4a48-5d7f-08db7dd6d13c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:09:39.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoiT8Gz2qjaShftcLI8Seom7kqaxqR/obiYC/5hiQ5Fc1r5xDbSxBPjs0ir9Za3ve1vSEpqbQ0jfcWqdYtIY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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


