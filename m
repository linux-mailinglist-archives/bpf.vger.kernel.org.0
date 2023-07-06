Return-Path: <bpf+bounces-4192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E46E7496C5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1854328128D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412AD15C6;
	Thu,  6 Jul 2023 07:49:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F315B8
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:49:01 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9380E1BD9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6tOJkCTc/NJf0Jh5IpYpC7A04XObOh5MBaT93Xt3JR+SNbyamJDU6ne9N6hUlEKRaPUYqaI+ABhPaPspXD2GPFlwnBSL9SUUHI94XtYer0VC9FqXEmMmBacb8rHrR2wclpWe26ulwirpdxj0QKzw5v51vu6P9hkqxmd+brMwJ/QvIMsqca14d0tQs7gmvg9SRBNTHfurMMIpNzvPC9pSfSEOi90rO5O/0eoKPzolAFt9GlJEvxTtagEIogEqvWmVT+Q6SVynrEuw4HJ5BSwXLAgvRJ0A0+da8Akz3/DLQbIZQQ6Gdyl5WZOhvrx/+l/kfW3iz7k23tF6ESKXNHYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhTecHCpsKJn/gFD/6EQBh5NMIiNalawFHaXgjAzXvA=;
 b=iQZXTFoMx3J8+V34k/UxEq4YR5TWmooU4MPlqpzOiYMy7MPOm3HqIrd9CC0aIV7vLiC1E4in8gnsvs89DubZJDrbUdN2TI1ctOSA7Ijn3GsSJs1A2n3jmKU5vptElZRR5PImxOQJlpKNdanGKecuUrTKAgAe1y0fJvorDukSSmsmefqVeLtTGhfx31jdwPw6JMthjnMhvUl/kJtTphQBmlNMylJnNSArom90yvybj0Zx8dsheMCqLCHLiMYHnbX6fou5/hVRz2VqAsGX8/hIz9zM0wWIMsimFbT7rSks4n8mxlVooHfubDv63BfkTyJEtvWnEx1nAw7/NSL8L2AI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhTecHCpsKJn/gFD/6EQBh5NMIiNalawFHaXgjAzXvA=;
 b=nKh6lzVCcN75T5qqu0kEsCd0cVBBgItwrcs3rCOlgCsHI/tXNzqAbJFKlDxdkYH7POxkMQ2GFUnXwBztmkrcAjsBI13i7mOmgLdeBWQYCXxBs6kzH+ZDLXPb0z8p1uctFJsW87Tuy3DmmHIag0Uyv+H23N9vbY4Qwb561PNjVRZsG26mIFEnveMqFcR7MVwseusESypjMnSF0I/xJWgf7PYSuOlsktsXdMmaylCbNxm6HoSBDkphRpB3e0LZu9CCH2fUmLQ5lK9Vu5udO+OT3UkceBcY97oYoM4fUY9ZxF/b6TO01Gyah40LXu7oMx89waYnPUSN570bruakWqVhsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:48:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:48:57 +0000
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
	mptcp@lists.linux.dev
Subject: [RFC bpf-next v2 8/8] selftests/bpf: Add mptcpify selftest
Date: Thu,  6 Jul 2023 15:47:32 +0800
Message-Id: <5c88e528d4be098c2fa73ba49bc1b20615b77a53.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688629124.git.geliang.tang@suse.com>
References: <cover.1688629124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 657b821e-a167-404f-fbb0-08db7df57410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MI9fGyjVqZVhs3f8PREfr62bV/pbK0coU3p1TX6p3ZCOoIGksXPs3lRQ1MBEj/eVRehBFFfOpnVZ+cY1iGtr+mrlQDpgbmoaofIrI33QCVCjkInCpz2vmhO6cbYj9NvSVueB1+jmuY3Ndi4oHRdzcmo3KkOahtqE1G0jSsNnDfMU9IdWOOJ9PZgtlV8RgxLxqoHXOL5KFUh/SPoLbuPuE12F8/zljS7dpYuSlx9z3oT2S1sFpM1zVbbukYaw/DvryN6H4P6Jaj8hlduAcw9fp2QCaj3ZojTmoDkZGLTQfcr4373zIvgGYrJhTPMI1Cl0vcYSNh/TpXXzBwRMGIypM008Uh8bfa9xVXPuy2k4qW7fkt9kJbgWyJ810oWxNm3iCSreRh9hNEuxigbfCQLIACyxwHAr1Gble4BC4ZKOmvi7S4nIxdfkfDfwhaRpS8p2PXYe836ZgNdiwQgtVcx/ZWhD7psn9IdleseKCbM2jiN9i75qnHI+XOnPeYs7j2AYRRz9uc1RAkakGYW/D1w21w3veSOofaZGH+0iTEwkDn9KXz473TyTy+Wm36BrZ1CCqzzlUAhSUHOUiB9z82rLo9Y8PUfR1KVmXRUQZEoy1DWZ+38NMUIc0zOs+LXdynSr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(6666004)(41300700001)(7416002)(5660300002)(110136005)(36756003)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(83380400001)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ezdmpZ03wBjy0DZrPajY/ZZycKZkdy6TC0++MEdZhERQX1/sbmYJaH9oIppO?=
 =?us-ascii?Q?KpB+Z9WdpqRga6Py9v9b3ig5zx3g6Occh8s4mF319sd6S9qFc4jvqkDu0uOg?=
 =?us-ascii?Q?wHX0A/IbNLp8HkwZG7QGC9u841qLWos7LQucVp/mWGvazma7bUSj8aH2xig5?=
 =?us-ascii?Q?+oMQuxn9mAoxHgxnyY8nWLlPhN/v6LqqKwKzEkiuL7XgxFpEuKsF3FL/P/zS?=
 =?us-ascii?Q?1hYyHDW+qjUDOdqbtkrWvrFo/fTOEqOV3aV5WnfTARzx3klC1ctQKktSmf+D?=
 =?us-ascii?Q?jJr62JjzKPl6xVZo0Q9fZkw5qafhBEHaajaStaPqnMUbODCaQ1RV/AQ3yTRE?=
 =?us-ascii?Q?9TQsEJ8gN/mu/eiJ9MQxcF+Ln2RUH53dbaq/t2w6coVCcWNsIVUndYgD1GmK?=
 =?us-ascii?Q?mVZXULvSoa9mM+t+M1MgW7FdD0gs2v4P/az6CwS5KoQ/qxI567yySFx0vGVj?=
 =?us-ascii?Q?xmDaUQDPybpe35glqcnDlx7fheCq89HPWGyJhqXCvf/GOoOp00MovrQWmuQH?=
 =?us-ascii?Q?0SAhavIeOy/PWGoFBT7/rnKXYnWNbhxEHwj4xT+DMLWIrxonYlqt8mNSZf+x?=
 =?us-ascii?Q?iCf8EQaVDHMO2mqPJmuVEfcJW5B5NDTlimBjWSjyKqP8neWdkj0CLolyh+1n?=
 =?us-ascii?Q?TBdkyqh3JlhQwmAqlseunrmBzSJyJor2/hZBDNYVpgxkoRRVzNKblMTn/RU+?=
 =?us-ascii?Q?ehJ4gxABmhuJkDROMXBH8CsDRhQdgQXyk8DTmL2FwEDC1Wxvzykqa+Sw5wLo?=
 =?us-ascii?Q?cxdZKZUe/y0tjDepvIY8Ibng122RFAhsneyKbw0+ie/utcnmE6cIADXDQ8M8?=
 =?us-ascii?Q?F1D+nc6yqcOHQNxaBLRb8670vOKtrrMFWCj3aI/D3NQ2F+VgwWNDZC7q0u9l?=
 =?us-ascii?Q?3appB3JH4WR3utoDQ6Rz0sZLm/3/R6kaoCNEA35xFdjibmLa2DSZmXKJal+T?=
 =?us-ascii?Q?62y7/nva5BKGmIb4MnTsazIFy92kIBM6yG2wo7dnJ6l98esRbNBg4+kOG2XE?=
 =?us-ascii?Q?3uk5dKY/Qu0O9cW44f6ojMA2QbZdziSZStd4t7LYO0FdIGHBSf3KK4lSmviF?=
 =?us-ascii?Q?RNfdmufLxdiokQfI/1QZtZvzLz1ISrbaWbMW7mMegTWJRsEOteTdrknovAyl?=
 =?us-ascii?Q?S9KAEMlM/bMVCXYnUwe6U8ndzClWH2fa7Kh0IWPTwUbvc2Qd/HcUBdvGHJg5?=
 =?us-ascii?Q?5P3hG0BdrARHrUbdSW88DOLtUK8lDJ7RyXKhfiuGXsHEMfzK4ZM8m1kuFgcG?=
 =?us-ascii?Q?inzm1Q3zyeLNkI13hTwL05lRyP6X3yr6yQhdVZJuJqwGjc8zPN8BTpBWU9oO?=
 =?us-ascii?Q?/3r5h+96ayLe2Dl7V0/e3Opg4XQSpHkPY81afWxF2vLdy9X7k/eBDGOJcdB5?=
 =?us-ascii?Q?9tXz0tGE7YsNmjmU/hlIti7Rb0ZUAko1/gPQls5hGdeJmx6MKjcmS7H/qMMr?=
 =?us-ascii?Q?FDqealhsaBzYGCNKR6Sr6Cb1DDf9jYJDodiCfRUstIS/ALYwNsuzzXqBPyZw?=
 =?us-ascii?Q?smgPwJf1V72dZSkzJR07eOv2CHj40lW9CrACcWDT4jfVGZLLMPlrhu/WtqjK?=
 =?us-ascii?Q?qpc5U/YFMKbcnHPZlQv5wzAVHKA6ZZswVv2JnYgh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657b821e-a167-404f-fbb0-08db7df57410
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:48:57.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpvcaSk4rbwv24KBL/1yujjFGL+RhyRDjxtg05YfQ5rZCLxB82axW9qm3vZnwU2F9qMIq2jV7QjcRnVdzWOyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch extends the MPTCP test base, add a selftest test_mptcpify()
for the mptcpify case.

Open and load the mptcpify test prog to mptcpify the TCP sockets
dynamically, then use start_server() and connect_to_fd() to create a
TCP socket, but actually what's created is an MPTCP socket, which can
be verified through the output of 'ss' command.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index b2a833a900c2..de05140fe638 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
 char NS_TEST[32];
 
@@ -196,8 +197,98 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(void)
+{
+	char cmd[128];
+	int err = 0;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q '%s'",
+		 NS_TEST, "tcp-ulp-mptcp");
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
+		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
+		 "NR==1 {next} {print $2}", "1");
+	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
+		err++;
+
+	return err;
+}
+
+static int run_mptcpify(int cgroup_fd)
+{
+	int server_fd, client_fd, err = 0;
+	struct mptcpify *mptcpify_skel;
+
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "mptcpify__open_and_load"))
+		return -EIO;
+
+	mptcpify_skel->links.mptcpify =
+		bpf_program__attach_cgroup(mptcpify_skel->progs.mptcpify, cgroup_fd);
+	if (!ASSERT_OK_PTR(mptcpify_skel->links.mptcpify, "bpf_program__attach_cgroup")) {
+		err = -EIO;
+		goto out;
+	}
+
+	/* without MPTCP */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server")) {
+		err = -EIO;
+		goto out;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err = -EIO;
+		goto close_server;
+	}
+
+	send_byte(client_fd);
+	err += verify_mptcpify();
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+out:
+	mptcpify__destroy(mptcpify_skel);
+	return err;
+}
+
+static void test_mptcpify(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcpify");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+
+fail:
+	cleanup_netns(nstoken);
+	close(cgroup_fd);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 }
-- 
2.35.3


