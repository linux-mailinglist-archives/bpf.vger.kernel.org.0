Return-Path: <bpf+bounces-4207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A836749767
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26734281265
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE967473;
	Thu,  6 Jul 2023 08:20:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504852112
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:20:46 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52D91BE2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oazFhdQ/7E6893WWPLBAqeRy/71NaNpYrAwlBI0G5bOkwjrbEeRn36Ca4OrICwhqpCe9A1m3jZCNzifo9BkqhxfZe1Dxdu2eKdc1AyiSWHL49jyQ6jDU0vzEy94u1T2AUWR0QMwVrZVSG7vsi1YhnvlMmHTWN/d8v56/zPdFnOmnv4jFMHS2Bd7mMacTQuyGMsKlQ6Ez4moeV3fwgjTJ+OXggDBi6pPlhlzUX6ujJTe+jhf+87J58Z1p6AdRYC6MIB8uEo3cCiYKmEmQsFm/ztpgLgfb7oUB8qbCqHvJDMTocUn+cnexbEj2mxzYolWTCf1j3mWKoEpLFJ0A8hUP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsSYoVTG5aWN1RB+BtJakyrG0agQSne+82NpSdcxne8=;
 b=nSBCLZskjCSXZaGm9L7Otc8Kwu9Lt3cWfJxpZjVOllmn/8e7296w+p5Be+VdOiu0qMZvR42tSILGlfH8y/fet+W4icXNrM9stSC/pZQyqlM9Bqm7PA6Lz6OlyoCIFvoMIj2vO7RVCXmw4mG2CRxLJM9mzPi6M9KiwHRGNjTQ7Hfvsq2f+/OF/nPKPRTAy+Drc20i+XI0VjcFOpCTfdlVMVpcONCO1QJIr481m+KlLZQmdWlI5CU5k12r3othRx8qSKJcU0oQmse0vJ2W8Hjq3Tvgb5UC2G3z4utFeICLbI2eT7nrOC7n1brWk+0CMssQkGeSuBrzwI4PAr61lJgddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsSYoVTG5aWN1RB+BtJakyrG0agQSne+82NpSdcxne8=;
 b=WL9iE5hySud+NV2s0d1XTKBnvAzZnRhFyoglleaEKvjkuzwz4p/VewVJts6vegkfP97EB7MoiiPZw8WTKQkvYu2ICHDKb/7TIgiZ+6GCzs4iTLy90XkMJJTfy5TFgOK4GFUUAQXo/1cBzBUTPH0VnN3udN/X9JAlVEE24pKOIrjvG7pn47BoW67Pl5geDGVRkKIKu1WM1CBLaE/V4Hvt8nLPKORWgjDQYjKuUYT8YeMri/un9aDodZJkKMoyBTZ9hbwRXHXuj83l3ePgG6p/pFlT7C9WYCewpRFTSJGXJcpw4VA2bVDVTCblpC6P7t4IAdb000TUo/PbtkIjjOmJuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 08:20:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:20:41 +0000
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
Subject: [RFC bpf-next v3 8/8] selftests/bpf: Add mptcpify selftest
Date: Thu,  6 Jul 2023 16:19:47 +0800
Message-Id: <e17aadd8e403fd4357cc184d7ad151611acc908a.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6e60af-6176-4780-663f-08db7df9e312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HOClAb98E6znjQlJIVmxhP5BbheKM8klGHPAvVZ+7UFYQ5g9iTA2G4GgkO8KYU2J7vGn0p2WfkW2QPRq/bEU22A8n2CQOaxXYJGOM/lecldOEVBkO42wfy6xRXjKzkdEHFQ2JjsWNkoKIRFuymPbbTzmuQokYpRpK8IFH2rtUltlaElSQhnivne3djWmd+lGqKrIRPI5/6XckL06E/No7vmQuP0Rej0rAUOrfnZW3Br4s4inPfo3XLt62ZxAg6CEaPpxGJOj5supafr9xKNkt6F3fKJG5vAhp4ByzkRZcD0EqW47wXsxqMwI5Wd4Hy87OL2m62rgAFzW6s79nyr9DQmgDQqEwJtERsGiAnMRWu2OMPYTsFi10MSz70AxcZba8EaRoN5bqpJPtD5I1bSVoq9iaCZUvg6fWxX3oGeuydncOx5sHzHVTzcRmDfgPk9KNwKssG1srIL/Y0CZOy+6dD0+/kbdje9pv2oQj4ZTCbiHEHLWsVOxoBHpy2TJhBft7o/2LmeUfGdv+BsbMfqwzrsQkrPD7Fp83jqwwwdpYQwg1G1Yt8LxUGrlnq0sJNBIbs2tnQ/EgWeGEKlbl2CDqIifEfvARbSCTE4aQaeofpUji7YuiXKB0LUE2seeradn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(7416002)(44832011)(8936002)(36756003)(8676002)(2616005)(186003)(6506007)(478600001)(5660300002)(26005)(6512007)(86362001)(6486002)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(83380400001)(921005)(110136005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q8uVEOjvjJWiZU9zXTdDZnWHdV45Uh3ydqESdXU35U4mTEczQ2K9i3MAM1OD?=
 =?us-ascii?Q?AviNM1iqyWwLdiu5Fdc+KH3v1mgRZW6xWd70+cXzbXYjTodE/gX3M7RHzSqR?=
 =?us-ascii?Q?BVk7MgYuPtscBXcAAAokgis+j0txz15xjJVXgwSvoo0GoOXvFmzenFi+nDv/?=
 =?us-ascii?Q?oCpWNd4xu1N9FzpgocXcCYNcsz8BjdJUI0jmhfvCINPPJsgTHbXF/IXrscjT?=
 =?us-ascii?Q?N5JRQY7kQoURPSKXbJ4aLBL/cIK2O9FNr5xdBkl185xcAaz9TylUknwZ7Yyt?=
 =?us-ascii?Q?qPJemlOPy8krgFeZO+N+epD/Ic+lyNIro8G9atK2c6avrKLcgaur60mWFdCl?=
 =?us-ascii?Q?iyLu0khrxUCECk2zlftl5dNQXVm57QlYmqjXo3BVg1dxzEtwg4MY9Wm6ht2v?=
 =?us-ascii?Q?72S1/H23qrJhAw4gCXRarub4P1/l0v4ex9xuRUX4UzJQVR9/HpXBUGWV8cJj?=
 =?us-ascii?Q?qtfQY5RoUIAzfK2TWzIKmCegGKCZ6HMCorobJ1NfdnL0uLUzln5ieWJDaOb1?=
 =?us-ascii?Q?SnkRbNMHB/P3bVSJZutJuPxu3xvQJXhxp645SQQrCpqB4bZcvHbkp7yIMwcC?=
 =?us-ascii?Q?kXc2lY1LnSdjUIjWfguJdDvJGoNuSSWzs0SnuKQ6HL4AF37lfZrln9JySjRX?=
 =?us-ascii?Q?LrgzzFo1AhlYA9XtV6wTs//FtWZzwjkAJ948sPRcvlx8t9APH3Z+1TmI4EST?=
 =?us-ascii?Q?1l9HfPPEywjTe56lGcFWtvk6I8J0VDTww9rkc765k1BDpWIwIwUBRacbGXT3?=
 =?us-ascii?Q?9/oCOsFw7AGMhreOoBtN6Zu9lxQuhlYt4l2iQipeeMLGYg/eJ9k8bd6LfB27?=
 =?us-ascii?Q?ln1YqX5oX2AeyHwTpkFzGgPCTyzIRmBDemXKYAniaL1ZqDqzqRLblyW0yhPy?=
 =?us-ascii?Q?1acYTLvyWsenOZGK2hgSXbbKSyFA3DBmumEjd3/6DO1j0AeRVyA43aeQfb4s?=
 =?us-ascii?Q?UtNUiT5DNsL+jWzisTQWqbEsM8o8/IOzJxkHpq8KwSsqRE9Nr8v3Se1dQDde?=
 =?us-ascii?Q?8J4JcTRc1/h1sDHfSdIbJivVV9LR6qxBKsFFW7qrTWARYVeG6Hn85RwI3dWq?=
 =?us-ascii?Q?24MxWoUYlTzCn/ky6NVGmXdHNQc5IK94WF0AK6aSm/6JD73JEzLmqlw89eMj?=
 =?us-ascii?Q?Y1hVLnUEfF7qAzNjEAK2/RfiEAbH2vwNWsbggE7zb57TIq3P07MmJnue2BIR?=
 =?us-ascii?Q?K/oU0CZINuvrgMqaWkD6Ip4quZRmpPMzIJvR2leFDV2Fy7XMbSx44ajt8SFo?=
 =?us-ascii?Q?gjzTYe7Yvdc3fAwn9yFY5HTjyckQQKQOK9F5UiLG5tH24FyUuTwBKBIhIGSA?=
 =?us-ascii?Q?TfgpqilK+ACsZc8dvArGOiYlEDma13PXfD1mAdAugS5qdUGZszMUbfSlHICK?=
 =?us-ascii?Q?+9NN4jkKA3GjU+LoyiIqgtX3FRbdaqIQktlYBKiG+1oSDHZbRDgGCZY+5XdY?=
 =?us-ascii?Q?soWyBxmuGtFQ2U6nqxffnbB9XumRy/TpE73qljHO+tfRvyQdeHVfdNiZuxZc?=
 =?us-ascii?Q?Z0AHKOFxfKjGb6mBAeYqapjxlYGvDGS5NjexuvfI9zFCWd5VpYwe8dkBHRKy?=
 =?us-ascii?Q?/O5/BqLzev8NJpV9iHeGweDu+xKuEQzNxayP1gpc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6e60af-6176-4780-663f-08db7df9e312
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:20:41.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER6BeuBK0LK/Nbu4f/2EbK8wjYOsKCc/QAJj99FGCdracHjQSWECPWhDFwQdZv9EgHnWV2xIzX0VTBAyiKQLbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066
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
be verified through the outputs of 'ss' and 'nstat' commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index b2a833a900c2..39fef907cd3e 100644
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
+	char cmd[256];
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


