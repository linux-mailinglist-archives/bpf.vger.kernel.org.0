Return-Path: <bpf+bounces-4191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707827496C4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C6C1C20D0A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41821184C;
	Thu,  6 Jul 2023 07:48:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891A15BA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:48:53 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8621BD2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmn3pVvbX7XhkQiMTqEfz0tmHinIJFxvGAVD7JpssPZAGQH1zmpeYPSyj/eUQ0PW3zpeZD6ODdrtp7LRf+kQREAjhtTVV7MHO/u9IX8DdFD588SQMasnV53G2q/jAjLeDdhCSP4ue1ir3jzwNI5QNkwlEy4GL+144yzC0a0lfoiCV4jVCNkYOIE4pvMESUGCMsS9qhRODSA6Z/i59GM0/0Vets9tV6mOfp/DGAblCJGpMdooUM4PKyKH7BBtikz1wPr3+4tgVe4HVyYGy5BGluzDz89aASkux+ukrJq5R9wnk2dXun+fEHr4WMPU+S/30nmabbsywHItglhiNUtWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoV861M//CggYMx/ntigXt1CYAXI6xhNp+GNJSoiv9M=;
 b=VEdhO6ft78aA05rK0bfX9AQFg6VU4qJpd9Ppzk93jCNQXTM7WlYApFOP/WyUbnINxNZrR1LQItLS/Qy8eV/7tsHmIDNQutUnfx8pP52LIhlYKbJg2CvarWbzGPnm0E9NLlsKkoJ6U6KNuHYbqG5fIvxF3hQpl1EDa7Fauk+J2+PK1VHNLtUB0jdYKN0PWEfSqUcikCLszdKFbEXK6EhkiSC5ycU2K1Bjk0JDdqm2LHAZCCRl6S89bbuR0OFO9TSZG1MO50XNpgqRKuKUfGxPzYMND9yIivGwcUVaTK0LYE2d3RY05++qH0YVpXJuHE7Ug2N018egyEWCbZJkMtY+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoV861M//CggYMx/ntigXt1CYAXI6xhNp+GNJSoiv9M=;
 b=o6ZzjcLdFI6gAm4Ph9xF543geZ4zVUcks/JeXf45MtkmwujTX1UWUqPZSJWgvu2F6ZQ9rJElOUV8rbrROdUDfpMPgBYf4iPkEJNyQewifdc5Zcdji6vvVdTxawCad1w2j6NhMPVn1JO2d914PCqTO+DIzLK5zWT+JL7TNZsHz3QPz0/FI3bUn20iRPq39zADw2aRYqbKjnSRVVGvedP+uaGSXnMIt9/ey/6ZCREywVyBOOScyTt+hy9SPL5T0shAdZSZOP0UqIHSny9TST5/dyVYu3a29JxHGPPwwxYRAsqyJk47CkbY7ljIGrH/hLW2SGrmPc9wKZlZx1Di7Irwfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:48:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:48:50 +0000
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
Subject: [RFC bpf-next v2 7/8] selftests/bpf: add two mptcp netns helpers
Date: Thu,  6 Jul 2023 15:47:31 +0800
Message-Id: <284f75cccd4e848f17b54bec67b6889fbcde1a35.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688629124.git.geliang.tang@suse.com>
References: <cover.1688629124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb789f0-984c-4714-302c-08db7df56fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f9JtNWV/XipMqkpyfpDCkZgujtVzlBLdxCR5h7JCEqu2IJZdrNI+hotPr0HYc9rPC0Bf2Vx/uHWKKQtxQSCfOmsJ6ZKONbC8Ug8Z57DtAzB5y9x5fTKWvWFBcFSunlZUxhNbocZdp1LKMcewX/IJ0i/Vk8uaaChI5OaMojmHBFMBEOuG7qxj/AGMw6VJUVcehkRj4BYJBuYFnGZcfnIbCswgXmIPAEfpsbms6p4TTawp/cZqZoa0G3KSrs+NP7uEazBDGzjQlAm6UcIQEhw7JHl6JymFN09K+jjERzuUmRHTGJx4gZudB39Mlf3mIM27FAdY00vU804bcNn+g6L4Ila7W2XxJl/UkeAo3uCB7KNjWO1ZNCYcdWNo4SWlrm9NbVZrGLU8oPhJ5mTE817OaA7GbeKU9SU3bTuxaFd58cPLKi5MAGao2cCGz964c6Hit/37pq+xNazBK/okjKOcu28R4Ql+b8+u0FMr7VPvF7ckpRVFSxLgeyAKK2aJA08raqWWTMYQ7NZfLqdhqgJ+Ubqv63Ct2lf+ZlfPb3uQDmO4rCitfawUKfcu0DnvUIqA9gitfZFB+GHFW2TSjg0siEk2JgEGj780leeiio7PAAALiPPjOVbpcYYaIF7N7+eF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(6666004)(41300700001)(7416002)(5660300002)(110136005)(36756003)(54906003)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(83380400001)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+cVxcqFrTqkqqWZ1/VOtbUv6HSy0SGbCp3g4C2uA4cpRfVOOvTaOvPUK1acO?=
 =?us-ascii?Q?XUOukIZPxJgTTonH74HDUGka2zsf4Y+ufkyZORgzF4pMHpxxVIvIWh3lrx9d?=
 =?us-ascii?Q?buPIzPqcaNiCzEGzbXJQ1QUloqQZvjSz2MCwKigsNA14O3p+4PthThlGYsDj?=
 =?us-ascii?Q?KjsS7M7yPMFWjnVjMXn09s106qtEwgaSuT9Xqihx22Rdx/yzw6jW91Z6d8CT?=
 =?us-ascii?Q?MrWS27FjUfXGCO3PQ3gzz+acUNRvFpA39rOpyArLu7Hppn0mi40p7ZLVSl1M?=
 =?us-ascii?Q?roXmDNgvRnIvjGVJRTE1kHZ1iK779pxQJbj9aC2tgUPAXwfPxiQLT3kRpXhL?=
 =?us-ascii?Q?PXwNbyHk6bZORn+95AVozxYK1jyicZ5z94y1lGkYC3pshMYJLn6sCFvs5x2M?=
 =?us-ascii?Q?fMjf5gcnNf4D4E3DVP+NqB+Dl2fjvzjsVYN81gOCia8Fk+m1hOAJiC7OHnqT?=
 =?us-ascii?Q?kbTaP1yIOGa4txBPbc19lHaRZFIE+RG7jt4D/WO0dD9DhUYsZ6E2CbWWTeqx?=
 =?us-ascii?Q?+4ZUJ+f1asmTAO4Zg9RYrHgYiUd1+7atzQAIa+f4CPwq6Nb09u+sU6kaDN0t?=
 =?us-ascii?Q?pALBc2wdr2JOiwJYEM/7wTCYJK6AquWCheJ8EYZWEn3BCIqR+lzmtARS8Em1?=
 =?us-ascii?Q?I2aFin69n+Z6+3EY8PBU3RAdipcxS6hRyvpHGxN/z0yAcvnIiFdWy+f7qmQc?=
 =?us-ascii?Q?0hp4H751Q+zm2R2Qt3ODc0sw2Aa94rD8wWukd0p2AhBng67y4j4O5ZiTuVBN?=
 =?us-ascii?Q?BiVR1vTAOaIG6lf1u0eZvEDgKC371bSGOm8+yLP1FKvj06KNVBWf1/wNqv6M?=
 =?us-ascii?Q?sOrT+y5QG7tQ6iuiYIYuM9izcNtGQy0Ay8A+jEcx67EI4wqYLOZ8iFyBIkJp?=
 =?us-ascii?Q?MTM1ah7NmwNIk8ZhfV1sufyKvsrN3bHOtvYr2TIgAHYaeTBatB/zXg+H37VN?=
 =?us-ascii?Q?Lj0lnWmgeI3EPX9UbSpM/19TKVwVu4yOAnkqLhrdMj3afUUAjCLCGa6Ki8tu?=
 =?us-ascii?Q?2MRl+ilTXm3xmNpbn40FcVK+bfdKFJiFETjgLo5IPY9NmWJkC3V0PAy7L4kQ?=
 =?us-ascii?Q?3mmkUVGUZ40SeWNisXmFa1eVYs7VyuAwUwKJl6z16EAmQqJXh/ca3GYMJDm/?=
 =?us-ascii?Q?3aGLeqJ9cMPamtF1E2ZtXkXklHpIrAxYu49iGf2NNAMIBcNTsFt/saVz5wW2?=
 =?us-ascii?Q?75Hh7Wkh1P8QTvJVicy6/0j+SpkPsxXTdkFCwpwpYmUGwJDhm4sSuV7Uhbh6?=
 =?us-ascii?Q?jPpAM85iTWzF60+uSgMQw7kdzUP/DfogZ+ZVoGcsAtEdwlvCaKAZ8pZBCzb3?=
 =?us-ascii?Q?2ulJMS3K8EC3gilHiFMZmdqv9xwVNxTrMHkCEqpmDgKX1QG7Gm9EnUiAY4YE?=
 =?us-ascii?Q?YTR6uswy2MGD9gfaatu4gtvYNS0CK8m2ti0J05IZFv7IUvgkEjypuncp8HcW?=
 =?us-ascii?Q?fManvdssPzAaR8tCrQfTb/GHIR4G0VehcrFyh6aBI7QkjuJu/0z1CkRajdaV?=
 =?us-ascii?Q?syg0N9Vb2xsqOgzlDe3q3s99VjI0Bj1fJz+evHmVNkbyC++prBrIw6jLw9Yj?=
 =?us-ascii?Q?rY5Mr2ITteYbL0+ATG2BbStw5caYhEWRh3C0YaC+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb789f0-984c-4714-302c-08db7df56fc1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:48:49.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXdAAwtx/tMa7tW1CI8Ns7O6W4H8eHuNZ9lY13GJAjWB1rmdYdCdJ8BFmqO32AahpXAVsI/UQ47LHce2xFFFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
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


