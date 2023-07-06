Return-Path: <bpf+bounces-4173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABD74949C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0333A281269
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0BC15A1;
	Thu,  6 Jul 2023 04:09:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4070EC5
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:57 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9558F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGCQei9lJolNZ+VFGtr8wNGSRSlvrfsYR7jly3hqYrXKOmpIEW92queF7b1vJxGuqZ6ruiwL+w0BVExQG0u2+xNbVw7Cb+PI8F0WqNZTBuzF6OdBnxpNuwC3/0/c3ax8Z8pZmKS7RKnrXtZ60UdDuzWmysp5BcABHTP2myHrd7zxyI3jkTgnqASCywpOxGDsslfm4WdxE+wLME243fvgyGlUamMCaQLBU/3NQcY03GdIVXcXqusLwHOFglv6SI9E6OSsMlllNLRC/JZIKdm9su6LXwwHyAy4WFH+uUh3wHeutvIIUmoykEYijefsmcln/W7wEZ/2ysuWUA+GuFNSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAoLV0/ShaQD0lsodA0VEYtnk0wEI79EpLya41uQHjg=;
 b=jP4DgzavzVutvxBziG95CGUD5GrvnxyMpEyhxUNrvQ1Yqeof14+WdMLJz/C9k0Mv34QBbc9TRR3hRAKa5P89b9ZR+6zUZmG1WPpZ2G8XdHiNEl/AYLaM3B/apVIjcYDNW1l34P0maUeS81RBIVNAVDQzTEuPDLPyEO9SuhZbuFGDGpnVh5ZaXy6thsq16WWXpYhcstkfBH32QzlqrmhX4AHfH0hs/m9JaVsOV7s3dnXaUSwXCuqYAphAay5yIIw1xmALj66oDNNr2zuO97cSksXxD4DuDO8D11xlMi0u3orL8Zufii3FnZ5ADyHw1A7RBstp3KbVVlZAVRmAUBX4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAoLV0/ShaQD0lsodA0VEYtnk0wEI79EpLya41uQHjg=;
 b=L0zgq0DOBOkP7nfJJoDCbeOBCdYricW10fClySrIrWECw3vZ+MbDULFSfdqsv4rU0X0CULvJX3ekwgKDR2urIFxdrFKsbwVfMjA1VeiFGBdLun0V05a9rloD//kIyOCGkhJor4wXrumZ1odLttkkmXfENxlvHMYDjjZCPXlNGFFCmMzB/GnggnWc5yeyS5WjixN7bRg+g5cUFKykq/p+5NBqIyxJ5DuMnqx9EqC49d/8JPG/55rAvvgI8ZFilGPnIqt3I3r895v3DCSyUtPziphSrqaC5xAS/7BX4h21bgfHBcFpvTgB6UMt60apiUAsgz1YCYXKszmBXut5C5H0IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:09:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:09:53 +0000
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
	mptcp@lists.linux.dev
Subject: [RFC bpf-next 8/8] selftests/bpf: Add mptcpify selftest
Date: Thu,  6 Jul 2023 12:08:52 +0800
Message-Id: <dac320e2e5245b67c1e0347300977ffacab70235.1688616142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688616142.git.geliang.tang@suse.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f69cddb-10a2-4e1a-1edb-08db7dd6d9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tnAqPoJbplN53XYSDhrlBxT9fEeh1AmFPu7cUPiNMghkL4fKg7QWFoRaYS41IyjEGmKRnL+IeESlcU+EaFIf9+b5/vSW7fEPAAUPGp53WzIiKtTDT+hcIv2E2UlUL427JFzhABtueWaFLSq2X9aq160VKkkOCBDN5J35hvMD3Im8NULkLpXlub7XvzT8S8498eOtmpcMORjQ9+ebkS4ld/1iaN/XrXHRUfvR2kV2vSlAovvPfPYJPe6bYxOXZO/SAx0B5diRDdx2pE5fPZM00lFhSxUuP5Z54YkH7oWFrGic+bZHiUftOrxkynuHUyowZ3gEPCWeoBLAnF5IV8aCk4WWm50Q3hCEZJfo1UNn4XzLe00ZFE1TEYbJFbZvHYW92ScgTHya3ayRKK3CZ17UdKH79PGaqdz0lDIJm+aToiUqjGvk2DReLLcvQrgzN+rvclR4jQhRJJ8h34JeM99d2G4kdA3shDgeubZicXrQU1UPKApFNSpKoQKtGZChoX8S1GDh2i1bJ9vAuhtTXQ7E02F6Z2pWLhKACDdnsHfakaI/YkKTNa3FcSEoifrdMWHf9u5a1SUsUbjXPmRlW5A7cNzMB0UijYsTyRVcP/mVufIq2YXlVBq5fPiz/uUaL7vZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hf2TD/GDF3+VkGGEl49NGfS67B8HHJtko6c5lvDZ6tMNptQSDVnQuElGlpMH?=
 =?us-ascii?Q?zuwU3vso9BjoObJgoUXS2pBRAYnd8p4cLKteZNEGkb4g8+1WabZfwJ+9sqcQ?=
 =?us-ascii?Q?cT1P/Qaa2Ro2nVfK3fK61xsYHt7Ou2p7CRQbx/XJyEYnUsarDCNIS1Bxe+Ky?=
 =?us-ascii?Q?VJfQxm4CMhmlYtfw5qRam6DW5oNxLX1Vw72M/qlSXSDPDHJfoDaoE6+7aS9f?=
 =?us-ascii?Q?kTAETF8ltuGQat+AKgmazWtZ3hw+HOTZEmJgck4cEjWfOG1Tf1HwjMgTR2ZQ?=
 =?us-ascii?Q?a3Rwb+Yt7iYvga5xFHYjwHHCAZb51K0/45whEJV+UVdRkGNJEN4EHnpybTz1?=
 =?us-ascii?Q?J29L+K2NCydPJM4hhDgOQz7u+OiJMzWsXEBBEiemcm98hHd/hx57vAcSd0VM?=
 =?us-ascii?Q?75nm9d7q+xHzfIqXzVGF4S+LTzraadFVVqruqWkkG/zcwkokhC4GeHSEl9Qc?=
 =?us-ascii?Q?0PQ7xeHvhbaEpCrhDFBOwlDreweHWMHs3UI1T6sGNayQS1jTL3Nvuz3fKLYk?=
 =?us-ascii?Q?Lhg9vsXq25oA37/Lxx98cXxmM+sBUn6sfJudB6KRKiSIbxxJNb6ayUPvWS1A?=
 =?us-ascii?Q?XFWsv+8BQEzONBj2Vl29NpRHSnlDjryUljy0PzJ8AdIsuq7feMgbiie3RDlB?=
 =?us-ascii?Q?mOs4xoP8BSttwYz46beEUMt/L0/kI9Elya02pcAKVQHwEFdA0YgjNHWgx+Wo?=
 =?us-ascii?Q?9DvgadLz0fDBE3OtDuEPi2lZxSkAnPPyRPfggSB8Sebldqn7HdOfc6Jpb8kO?=
 =?us-ascii?Q?Eu10BNaJ40JPdQz8kdkaV8KTwG940KSL+Ll/shYbMlYbiKSiADhsIuWpsRbM?=
 =?us-ascii?Q?Y9ao4oBvVykFlo1tDI6j2JaJVRYPlREx0gjcCA1OnbzbXVzlAxWdi3e6s9rk?=
 =?us-ascii?Q?1KG8KjGavSVBVh2tK7TLculp6S3Nht8F7+Ezr6N1Bdxi4tKh2EMZUXnZd65x?=
 =?us-ascii?Q?Tm8krLfNSxJ8kNaP2/Zc2M5z660xHFSt+VneMaO3oe4lLawANhdycj6QNj2S?=
 =?us-ascii?Q?O7kHqhryQ2VNkj1JxNOxpFPpI6sKtrfxjCcVeYyE8R0+Ng66B132fEWRCzzP?=
 =?us-ascii?Q?jYvFjdRRZGxjhOSYaE1sS0mUDDqy3AC5gCb+0HHVEYAtwljpqkB6vKlpXVB4?=
 =?us-ascii?Q?cDZi6UuDXaH2cL3j3m5KOjfFK6d6LPqrgmJG6tgCdllMlobKLuxAeqvITNVw?=
 =?us-ascii?Q?IITfOf60DUD9jMYhCeCxreaGbh3rJ+mEJAEV41DZm3yEL7oEO8ViyKXl0rNR?=
 =?us-ascii?Q?k3vDzVgpPCc3oVM0oh7MnYIp33IBYCLh/1N84m9tqIr+j9+M+3ggdEJnHnFK?=
 =?us-ascii?Q?NrCdrC3lDpxDSb687edcy/agzW712KmawUdDbwoDFvplX8qxYDItXf9xpPBC?=
 =?us-ascii?Q?wOKpu0spAtZe/ru+ArcpldXCH16xDdRoB373AvPNoJslBAcmPiYf2/AjXpqZ?=
 =?us-ascii?Q?dWBog0j8DceKOijbc7rtc329qouGm0llKXBThNtPJbt/7TRodo5Y/CJNMs4q?=
 =?us-ascii?Q?z2ZA65F2mn+UpG85VmeEqITXUlA3zVUs/gC3OHiFZk+89OzbmlBoPnDaKatS?=
 =?us-ascii?Q?2pZbG12tLgfw0QZ9m4xkT9aVVPhAGrBWe5zAeiQ2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f69cddb-10a2-4e1a-1edb-08db7dd6d9c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:09:53.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfpzaOB/Nit8KzD4in7Rea3GffXqSmTyEGjWmJI/gafKfZePJhoHZtjsUwUN9LsjDqIEyyRVBTMPY5Ftkdon/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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
index b2a833a900c2..186270e058c7 100644
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
+		 "ip netns exec %s ss -tOni | grep -q tcp-ulp-mptcp",
+		 NS_TEST);
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s nstat -asz MPTcpExtMPCapableSYNACKRX | \
+		 awk 'NR==1 {next} {print $2}' | \
+		 grep -q 1", NS_TEST);
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


