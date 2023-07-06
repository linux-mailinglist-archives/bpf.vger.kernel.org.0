Return-Path: <bpf+bounces-4189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72D7496C0
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F711C20CE6
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1288315BA;
	Thu,  6 Jul 2023 07:48:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CC15A1
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:48:36 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C51BE1
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWl5GcqjebLEpl1AHUiDXWVzCPglH166XVb3pK7ZXmQYGzwG1VkkZ877Dd1I21PwdxiDVgBI+2D8lEHw7/aaUlEPNuAKbDukDx7F5ERoHE97QKUw7eheRT6fUeIRZ5T119JkobpRyZlfw7zW3bPUqIFT/+jKi1YWRqfQhc/te1TgQ+gym0JyR0711ehrqQGpN2a69lYx8Zi6bp3uorYQOBOnQVKGphADJN6Kh3H36a5o3fJUvOJ6rw3hUDL+lEGFGJnTAr6KpiyTk5taP1DrM++PTZavWrh03HSFrhbEeREmU22b/ZeG2AQIWvZdsLiIX+y8x1YwjcoERdtf+86sdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPH4bwg8shk4a7dlucecBOgYz1Xs3eVluKKT5Ey3zWY=;
 b=lXTLg+xVK2CvuXbCIWLFC1ghXE0vasMzAJ31UTkhObEs0PwHrHANEMP5w8heSlIOITyZqK0bhKt7iu2cq6ZE3U0RsfjcCrRez6U2g6Rcpp/K9DUJ62l/Izbby9D5AAbrfYTCQIdQQO2TriCRJdxLIrmQfbs1iB4VPpQ1H9Yp6mbwOXSe7I0oBHsnqsSvYXM2HNm/L9jNVUIAfV3LmPBmFxUI4GJc1vd1abt78zJvhkXlPOMBeDbr6Cm/MKF1p5viyE9qB3vwdAMDy4fJqkcacmFG/atTNFEi3pjFJdmGCRmWriEC2tCOZTY/3/l0LN91da+fIu4Mz8VYUS03dHoI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPH4bwg8shk4a7dlucecBOgYz1Xs3eVluKKT5Ey3zWY=;
 b=CUmzXTOoAzuxnWUbgG/ITl4XdTZ9Nt6HReKjEzo4IcIHP/JipZxRqzWsTMIBZ+9d+0MH7nwnIYk34aZ/qKKjgpGDJD7l/QMzs+he5uuZCr8bOTUf6wjcRIXa7vQf58FRdPD+Oghdm3/TLHgQd6KEPMHeM505Za39b0G7EWR6LWdWtpRBkotaw2K2Iwckoy31grOXqMF/92FKdz4LBQVLUrY4TwYEXi5IM1zBhnvQbKwIEZ/VepKHqN8xDTbMv8y1lI8V71vZgxPh61AOXpzRILksygz20WAoTid3+rWPIevgtvX3fhG6FM6u38VPU+HUsUXWk7cxo0ZzF3akNJdopA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:48:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:48:31 +0000
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
Subject: [RFC bpf-next v2 5/8] selftests/bpf: Add mptcpify program
Date: Thu,  6 Jul 2023 15:47:29 +0800
Message-Id: <b603ea19dee78e03d19ef1ac619545f5e2a28daa.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688629124.git.geliang.tang@suse.com>
References: <cover.1688629124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e75ec1-b654-45eb-fce7-08db7df564b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kSnx9y49D5JV7Bkgfx/7XLyQXhoWeMeq+Nznpv18Z8wd1qwVFsFZh21pCw1GeCwgNPAstqLYsd0WoQ36agHbizdNzoUsFgUUrorHBkuXYnqF61OP5jjD1AurE4ZdE+g5KAA3UeeGCM6j2k00WMfLssUOMcf36KgbZ5qxXc7K8+2mE42UHypmgDdRWNpewIFAWgC1RPrF2JS8TqPl3+izapqQNlG3Y4wtzpgQW18b4+pi8bDKU7FkDv4ZxaLIkZqZ5osVaoTujrq/2QbafzFF5MOk66W7fyOmhSkJnv0s0Cv7iyYweNF9ZwkRKJ6dE287N/RGK2YtKevpbNpkS1d7H5PYGITiolJtmFfWCfXIW+N93jwBZlvdF2FZEhPUA7k1DrA6SgPKioA/QzSan39xWArua/R/Az5XxF4EwSU4E62u0q2a533KcAr34bxWXeLWePbO1nQxHDuGyRGAEkL4exh22s11n42qVvh6T/02PEFogBTQi0dax30S8RgUMHc3Z+esGdGfeGUSylqoE9/uc52a7nMrybNi1i8xkUP99tD2i4wFkDZYdauQmERRJbypWZLIB70C82K8P2GXy4Y1vZFEj2Wufn7zHrhN47tvV77KzwJUYgKzhy9LQubIuOia
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(41300700001)(7416002)(5660300002)(110136005)(36756003)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cnWJzIcvktJItQqKgImLOoRa1nPB5cuqmtR9cPbyPVsTsXSvoF4HIuG7EkXg?=
 =?us-ascii?Q?qQ+7PLemIlbGEFnk5wWUAdGTwic6v6WSrIBhEnnIVHMjQDvVl2j0uWxcYua3?=
 =?us-ascii?Q?PqOdxT0FXHcOx3y0QRyzlixsXIX020uGTMgCPBkb7VahZWB19t+WUkxlUWR+?=
 =?us-ascii?Q?D1YWcMPUQiUXOM5ZO5MlqqaZGjplklxLXt6wVJ13bJhoC68/yZIsi9nKlC82?=
 =?us-ascii?Q?qicpRnpWDTRE2Pd02ux7JqeYgGnE+MtPivcNajcqmeYhgv6WboB2yO6uhGWN?=
 =?us-ascii?Q?Q5/34n+ziK5MTK5p0T7gaT3AzndGJXkc3e4A3OMIH3RHd1kcXsTd0UxAXg1q?=
 =?us-ascii?Q?pC5xv61H0H6doI/3NNzsNY5iOd3f/GKUrrtPBAOXztqEDi/1Ww/S2Wo1L/7F?=
 =?us-ascii?Q?H28lksYKkaOQ7S0mjOG2/nWjM4R5Js3yUHDaY6kocvu0Swf1noBkexYPybyy?=
 =?us-ascii?Q?4YEohvlQlnXw3gI0VD3mC/UQb0KfE0zJK7lUbgIkV9ZyM+v3ZQLSBjo201oe?=
 =?us-ascii?Q?YY1OcazGteLSmyNNK3Oymmt2lGyEjAw8TsFDuDtQba4TNYfH4xj/3Ipw2P7D?=
 =?us-ascii?Q?RN2gCxkKbKN/cXuo4Q20XLIvZtN3qexPizKv+p0X6t/ehk+C0pGuuI7N+Wdc?=
 =?us-ascii?Q?LJxZFafYGhhvYY09K6A0hRjNtP6Yst0G5vKL9jwvlHZlnx43vZUX0PnoBl2M?=
 =?us-ascii?Q?7VdYvDSoo8hi8Db2gyZWzqMnHX+0lqJzycdskAhjrXczeWKqxvpDcY4lmHLI?=
 =?us-ascii?Q?xAVbGMXH+cXpXDmQC8Eel7Y7zPPI7t5Z92T6WNpW44+fEicCPxg9QOO/gEeY?=
 =?us-ascii?Q?hACnqvk4hVQt9OPhWiKUupPtVHLuwxQvQMuCFW/LFx7gs+WEuvhsi3wnm2vr?=
 =?us-ascii?Q?hkvK5dcFp3k9XCa1YV8pH1KMHtJrBuEW+Dz10khpOic+bPQXdLZq7Rw12lUz?=
 =?us-ascii?Q?yMTIe25rlzU9S/zpa4AVnflgsgYFUjz0TJPKp8e3yhFDb2nJc0K2q++SQka7?=
 =?us-ascii?Q?pD7DhslsQG1bUQSETf/HDK8Zg3zlSbTtj4Y87+wWj6RZoHA0M44Cp7gNJzqn?=
 =?us-ascii?Q?Iez7LgbAabc+iJYdIzJyLR4qCs9blo2glMY8Sf+gtU1ci/faVTJ2SxcLFiod?=
 =?us-ascii?Q?i2bwb1Um5P/2d2QCjpd2cManhbvu3Rdu35zcBRvOhXIxmmzHdKHprBvtgpHE?=
 =?us-ascii?Q?kNrjvNOipHtSZQzMAeos2YcLspYyDYmADkYn/a99hVVOIyx4fiROh8Id7vuU?=
 =?us-ascii?Q?1d9MeAqNqlXn8loU4cUD7Q/pgBt+yZYx/2XCuQIrjC9gJORHcuY34Ilv1uDM?=
 =?us-ascii?Q?s8PeRjgbVOZ0FmvHuiBYlqQo9VxwHDsmLjAxhC4V2JHXcxi/7kJGTGqa6KOq?=
 =?us-ascii?Q?RjrmOuZN3QrELgh/3ku8DZQm89rGrNzC4NtfhvMRFT2NFvonkICjGZtSgwld?=
 =?us-ascii?Q?NqKZCRBbaxBO2VDbLMDUifYpufVlglXqmuNJ7b6wmNhKjePXvO0NZZyIFQMP?=
 =?us-ascii?Q?W6eY+IM0WRmXUbv8t5kXa1xBmm+W9uifjNGD89KAFH8Akl9K1CNIOPZjoavd?=
 =?us-ascii?Q?72CuR5DfYXms3AReR6LYmJrpwa2A128YxJvADS5X?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e75ec1-b654-45eb-fce7-08db7df564b0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:48:31.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysMhd6K4Enu8RHv1L9wZ9UFx5IXpTYTbZTjbSt19hXLsuNk8cp1RLN97nAiZssJ2I6UR+KtuQfqU8KCSAIXKCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch implements a new test program mptcpify: if the family is
AF_INET or AF_INET6, the type is SOCK_STREAM, and the protocol ID is
0 or IPPROTO_TCP, set it to IPPROTO_MPTCP.

This is defined in a newly added 'sockinit' SEC, so it will be hooked
in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../bpf/cgroup_getset_retval_hooks.h          |  1 +
 .../selftests/bpf/prog_tests/section_names.c  |  5 ++++
 tools/testing/selftests/bpf/progs/mptcpify.c  | 26 +++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h b/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
index a525d3544fd7..0ba09e135df3 100644
--- a/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
+++ b/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
@@ -14,6 +14,7 @@ BPF_RETVAL_HOOK(post_bind6, "cgroup/post_bind6", bpf_sock_addr, 0)
 BPF_RETVAL_HOOK(sendmsg4, "cgroup/sendmsg4", bpf_sock_addr, 0)
 BPF_RETVAL_HOOK(sendmsg6, "cgroup/sendmsg6", bpf_sock_addr, 0)
 BPF_RETVAL_HOOK(sysctl, "cgroup/sysctl", bpf_sysctl, 0)
+BPF_RETVAL_HOOK(sockinit, "cgroup/sockinit", bpf_sockinit_ctx, 0)
 BPF_RETVAL_HOOK(recvmsg4, "cgroup/recvmsg4", bpf_sock_addr, -EINVAL)
 BPF_RETVAL_HOOK(recvmsg6, "cgroup/recvmsg6", bpf_sock_addr, -EINVAL)
 BPF_RETVAL_HOOK(getsockopt, "cgroup/getsockopt", bpf_sockopt, 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index 8b571890c57e..52319c45de57 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -158,6 +158,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
 		{0, BPF_CGROUP_SETSOCKOPT},
 	},
+	{
+		"cgroup/sockinit",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT},
+		{0, BPF_CGROUP_SOCKINIT},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..f751e6f65eca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define	AF_INET		2
+#define	AF_INET6	10
+#define	SOCK_STREAM	1
+#define	IPPROTO_TCP	6
+#define	IPPROTO_MPTCP	262
+
+SEC("cgroup/sockinit")
+int mptcpify(struct bpf_sockinit_ctx *ctx)
+{
+	if ((ctx->family == AF_INET || ctx->family == AF_INET6) &&
+	    ctx->type == SOCK_STREAM &&
+	    (!ctx->protocol || ctx->protocol == IPPROTO_TCP)) {
+		ctx->protocol = IPPROTO_MPTCP;
+	}
+
+	return 1;
+}
-- 
2.35.3


