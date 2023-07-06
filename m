Return-Path: <bpf+bounces-4172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1309274949B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4513B1C20C8D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC187110E;
	Thu,  6 Jul 2023 04:09:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2CEC2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3838F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVm9mu7N8E6rr2GRU29IClc3xRHv5cANQyrNtNIHYa4VNRh9sWVThEVZeUA9AAJKO2649z9CV+J225iXGdD4huuvoY47ztB+mowMtGSLr0YuvING1ywP9f19qMeeGj2snxC1PwHNggag57FaC+iSKKXW53Wql9H9eL8aaWOublVOYlksQj3ScI2Elp2yBAqrriRUeiB9k9a/+9sMaVpS39Ui1DRf948VOsP30It/rHMG6nrdLbo5HObEoRcVgT94lYCv/R1Uu0VxzuaN0Lf3q96UjQtsqo+rjhjY2IkJXxp/Z2LQlv/sCw5DiXOa6CfZ2tm49nfFN2NEJkF9Le2BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoV861M//CggYMx/ntigXt1CYAXI6xhNp+GNJSoiv9M=;
 b=mCaakKo0/F3nqR1GQTPiLVuUWyUzWcH3OCwsPzTANBXG8An6nG1SOCnZ7SWEVRVjga/AwmAO22Qd7r9mP1tYi/BraLG0A5wRGOvCprU5DBJ+tCE2f8l+yuSsnF+R9YqVibmvo8vHKTYCdNfoV1EM8i/NPgR82XbQxVkPe0R4KQNA5LeCEZEpjukfwDtWlgUpNAFoKtUewJb9I1aDadvU0XPA7iKFkK6R9eHd2FI1ipIDgqNT0hDv89iUEYiBBIrQ1R0IpbyKyCIoKiMekP/+q0Lv+y/qaz0aNdWJdLaMPYPi9l0pqfdj+txh9wuwuJP1mz3ynF0i8uqBJwl0wxSZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoV861M//CggYMx/ntigXt1CYAXI6xhNp+GNJSoiv9M=;
 b=bsuy4OaldULSmlZ1yldhLzzul1g5YujY28j+X3SaIXrdnXlC7JhGucZmKHWrnUeN6xqU416aGrRzVGlgk7yO5DcHCGvvNY0BNWHgkOZSC3YKvmD8/mByvLcTLI3uXWTQRvM0DrCSBpizuD4afh86gVvp2j97P9dJZ6EfMmfLmH8pBJltrRRJwBQh5Q60tnQK/77vnUSTjqERSOkWSiC3kHTgN6gHnr8sEemcrvvzN+RxQeCH2GqmO+QvOwE3m5E3WP1lQi2LSLGGmOoJw07I4Rq8ACctWz+nBJlfOEfInwdYyu55hwSmDexScSJoxbXu2v7Lh/BxGFay7SbTIkMBgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:09:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:09:47 +0000
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
Subject: [RFC bpf-next 7/8] selftests/bpf: add two mptcp netns helpers
Date: Thu,  6 Jul 2023 12:08:51 +0800
Message-Id: <284f75cccd4e848f17b54bec67b6889fbcde1a35.1688616142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688616142.git.geliang.tang@suse.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d46d51a-f308-472e-0d39-08db7dd6d614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5lD3vnzcWz03PdIiDSmlp4hD7chRFUwmn0QMa5FsKYT66cMlAX8HWc9p1xyeI+sFVp3fAtG2MEwMMI/9NpFJptiC6vp3OtV0gbraNgryd7xLOXKOjX+SH9EaU9WK81+BcbmEf41xs3WScuHwMOpbUD0CIhkqu6Wu1bye/fYw8HwdxK+OXhgXqpKJuqadx376Jfves0vd11np56aELEMDd0yfUzLDTe1Rg7l8dJzvV/ocnlgK6mtA+z5ugjwsk/rzBh0tDV4IFUncGYZFTrhpsrgEMcaT+zkCJrlnM5mBgvP/aezcfNlgAQiyv6/xU8TuruLGjX9B6TQ3h/+kN3XOtXvY9zFnfNQlO30vT/IEp3ysS5m4ZCExicya4tU6z3wzXxoAb90DVCYXOHf8FabxLZylcN1M40TxDEBFuNyNgsEYxobxAzwzSAoj0/R8cw6HzTE+IUmshOAae5CjjpINMT0Hd46xrOu4cCAlFipbmnuvhS69q48hW5KDzW1JQQnHM6VMZtex6Lpv/DIklEtWIDg1vypBLjFBoU+Gpxa6Pu7OgYVVzGEPY7SMepi1gZhYn7JpwEWRjfJCEWvBhINuMw/8t55urgh60c8mCgu+EgM6mQpSkjnD0t/9juqMisXq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(54906003)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(6666004)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEHyKbw5dO/VTQckbSRqudHjx18KzFiwfRafcI1oMmADplo11pvdzTGyuf8t?=
 =?us-ascii?Q?uboYIu+WhO6Q2PJltWlC+dUVi5MBFv1YO+3A8I0KXUYd/m8y3cq9LMQoFrVM?=
 =?us-ascii?Q?mRsRPlBFyGzHtgu8475VSnv3dpUibdxPCa8uVx80j+SJeWDbUIWZAY9VnMrQ?=
 =?us-ascii?Q?LS89tM+TFSl8b5NWjodqKAXepvpm9s8yjihTYasbwy9KwBBVJC55pxoqQw9Y?=
 =?us-ascii?Q?gH4kQeE6KOFUXJ5L722EwpIfAk/2TzvSJhnCtBQkQrFHwUYyi8VEyGh1gnfs?=
 =?us-ascii?Q?JWTi55RHjkJMit2Rh8f9qDWIDQ4mgDmrnFzSjGg96KLRRbLkJYbZFtlWAHfk?=
 =?us-ascii?Q?3JnShoKw8xEn3B7IPdN4MIBmqSW6HlAWMhSIkxhPfehVlgPvUyqgHdjV8i3n?=
 =?us-ascii?Q?enlmWmzQclmfOpfpXPQy+dPdkkbKLhBqfNFD2G1k9Pavj37JFRgvdySaAqNf?=
 =?us-ascii?Q?Mjc7vJcob75XG4b3yo2uURipVDj1gLvvlOFhD66jYxv85iVX9LGbQxRMfE3n?=
 =?us-ascii?Q?J6HUdJXRWARumtdJX/KqHt1dwCZ7V7zmCma97oNdC65OcMFIzDU7G1zNiI5g?=
 =?us-ascii?Q?VN8Nbuw+jvW+3BcbuBH4MlLND141eJkp6PBES/yxC5Qxj5RE+Plh71Pe6oaz?=
 =?us-ascii?Q?pG7R06n0cLV1JH5G5lDK7PNCMKw34CdbZ7sYVSZ5QQ9scMVtUclXgOoYnXPs?=
 =?us-ascii?Q?w1L52kc+NXyWCM66M93Xl+ZqsYy4ljYsF0VFYpXAaYoPGJokrJ/ojzhoRdi2?=
 =?us-ascii?Q?AlWgt2RPRtQbSoqtn1FjwQc+kHA2cd6KQrTHGkua059TSq6RWdVvV0Caqs4E?=
 =?us-ascii?Q?HJ0uv2udV8j9Cbn9Rq0ocYO7n5n+LDQsJRc2ek/YPwSjbDKsRs61Y9PdjFhn?=
 =?us-ascii?Q?gMFqqS3ngPIi5EUSM2847jgmcd17njqhg6wOSCT9Fn76UXre+98+rXOVpG3G?=
 =?us-ascii?Q?f+U09Lqna+wwLxluN88zxeIs1yBOEqVE5xyhTW2ffanSWe62LIM9fdzwoDCE?=
 =?us-ascii?Q?53BqyDt8bCZj9oLhYWmj+OFFOPxU/OgIb5xrjRnlx9pTnVKb2wCg9IDMvihS?=
 =?us-ascii?Q?BPykPL4ZTmd2QSEo5MviwPCpYVVgZP8T+zEHxXUIShbIi4FQhPyKW4XtRpbm?=
 =?us-ascii?Q?MXDWXMGAYB13kLOIZlS6B3Vro2HFcaO4A/7zGZj3l2HHrXB5UWchwgy7EXtF?=
 =?us-ascii?Q?Jl1FHPSbQzNX5Ypd+5+HM/xBWCSX7f07GchrEke7DRkrwVNpuy2Rpiszj5uN?=
 =?us-ascii?Q?XmI5xpna0+mtHlh5fODaq/IBVmc+d1FZic8t5QOV+fZSOghROn+I58dYVqOZ?=
 =?us-ascii?Q?cPD5iwAhrgrIkU0eIYeYmf62wWbVLBCcdMYfUUtCPbgilTMw5nYMHZaT6RJU?=
 =?us-ascii?Q?uBDg52xG2EOAHlojI6yoDNlLAMD7xywsW4V1K7klQ/q3owq+F64U/GpIf7AO?=
 =?us-ascii?Q?ozd6Q7Z+xhE4RzVlNuuLPZZ6HAW7QgRHCCTh98GzNoGADg5QpBOxr2aoG+/4?=
 =?us-ascii?Q?iZjTj7QE+Bf9bNknrWdN/TFBc/vlH54/csXnf94N5GYEcgamkz0OvDpQ5lLd?=
 =?us-ascii?Q?6uEJEBfeMuQ7mwCkxuR0UtO6sP/0kqWI7onp6FvX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d46d51a-f308-472e-0d39-08db7dd6d614
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:09:47.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaDZWfWVFL2nz++/Dst7bxv7gxNDxKgT9yMQ+PpHcWgTRAcOVfZa47XjXhUrzfBsbX39ROqLKzjHDZmck4R5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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


