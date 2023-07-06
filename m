Return-Path: <bpf+bounces-4204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A641D749761
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B82E281284
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47995539A;
	Thu,  6 Jul 2023 08:20:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101091872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:20:23 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA45130
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffXqvlL9l2z1K+yPeY5s3JOS8sGIlDjCfW7UGw+xs8XUZZbzvrScfEBkBVbTAt8TsgOdLsHCeZZzmUd0ezELk+NLKHLwMNv6iptQ8ZXMS6cYmtttUL0J2nv5OqZdh38Z+A05Rw/T3D3ulqdFmbgheYZW8Q4BeSO6XLAWm+5ctyPdrfRTCl9e3hHR6TmMMWO+32k+nBjtCyeBfd/HX3A6yXRspFgpaC75rT7MD24hnlQ06cydUP47g+Am7ErtHWYYRJEjXaFeTkwPqt56ts4IDHGFPLhClm1XnUcOxCz9r659FI+D5swZ5dF2nwnIiPcAIsceUeu6fsicpHsDTi2D5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPH4bwg8shk4a7dlucecBOgYz1Xs3eVluKKT5Ey3zWY=;
 b=i9F3GCQPaJQTir0GbgHYoldCkPHTiSXHaZ78lYD+99wKGk14gDGB+e7pnGhYabbZiCTWY5WQwFnD15I5IeZsL+OBasU+hLZtvxeSYQOve+kYk3GxmZqB+zv29wmVGt7sjZp3GVaIyExgOprLbodEtPIgSBpughWFr/s9EIR8qDjphl2uiKGZ+DXeiW0UqDeUiszATphFWyJrmN/tAi1hkJtSnnfUOB1Wm2XPceTgPSX3fTbFJUzhArAHpnR85rfsHojfCEPyyVjyuM4fEogasD7C9OdvcqlGYyUtn8YbcDAAV/uwVWCTYlDnWpgT4mJpFxl0tE1aXgubzH54aCyGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPH4bwg8shk4a7dlucecBOgYz1Xs3eVluKKT5Ey3zWY=;
 b=UgorSuIFzH2JqApwQkMPLCghFpbV0igdfBn8OQIX9pZOvwJqi16UMG0hXZVv9FXT6cpHTDHnScAH6jhVQPqthCkxzQeEMsubQhzjGKuzZaC9GqWhlngMIFkiqM/w38Rem7+idXMCKzlc2xtiffToq/nxjCPRIaRbzADKpv1VCs/AptmAo+ov3acL9pOkWIXhLFEpQaqi+BcvsDjclOb+FYWa7Yc6NWIkCwiZu7gDDy/ieG4zrPJoBCu+MICyEgYRJoIjXyK7IUWl3XdGJc10K88r7ggWraqUD232t7tln25nishoDzXTK/P0nP676VTNutqX2LF00pnbkb8W8/5CtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 08:20:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:20:19 +0000
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
Subject: [RFC bpf-next v3 5/8] selftests/bpf: Add mptcpify program
Date: Thu,  6 Jul 2023 16:19:44 +0800
Message-Id: <b603ea19dee78e03d19ef1ac619545f5e2a28daa.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f7881e-565e-435a-7fd3-08db7df9d5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7JV9R2Kw/JX9AXWNtLM0Bpi5l/J20lJdvqqo5YWNk061Hw7QxGl/cLDYRYXd1J6+9A/02ex2zUJ6jtMWN5F4zsOT5wtiRWghfSZSTSaf//dNoIPoZP5BxRyAxukQsGAJpazAiHGHSSWUCWVFeAN5EBfzNWPEz5/io+oTNszLkZzyayQoi72v5rwdqEHeIzBgu+c0miuY3T5lgf0G1QvcnwS1GEkf8Y1QbhDpaD6i//hBbj20kpGCaEndMdKlMazSLDfrQ/GCI5KM4+HZeD5lTaF0tfnGoppyMY7U0L/v+mP95Z+6EX/h/ydh0QvwiLuFtvL6BZyOjiePhCwbGXMEEwC6e5XJfxF64bejZc0dZSZeGNbxzdEvDSBViMsT60kuDQZdjviVxJygeWJMTs2r7YCEaqdXjotkIFZKcVdyminIe9ME463bR34IPkwDbf7ACews0BPbSWwxIUAXblWEvQbeNDzYet6ZB8ipIYTfrN7fYWeTLmBRHiIOW8JU/YM67FBDZefPxu5a9B8X1eC9LKO8XowA015IQJkq625gVEb4fMoVhFWu/ABQ/5ugg9icLI4c2QPJRLaaLBmErPeuFHCzM4zuBqmyii9/v5aqcquKEo7Z6gY+JlxlraYyemM2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(7416002)(44832011)(8936002)(36756003)(8676002)(2616005)(186003)(6506007)(478600001)(5660300002)(26005)(6512007)(6666004)(86362001)(6486002)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(921005)(110136005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C1jrseHKuAe8SHrkvoKaPHBZqiGr65qgIGGrM+dKhpPZn0WwYGKtxVs/OOit?=
 =?us-ascii?Q?7DqwU4yN6Ta3f6lpASrinukmWWszAK0SpuXcqCGeIELf8KwX+gdQJqfX0Wob?=
 =?us-ascii?Q?KV/PBQZGuk4FkhMgoUocPuwJqeDW9nxMAB5Iy7+4X7GpBcYIiQCrPe75a8GU?=
 =?us-ascii?Q?97X7046AzipaIB3Ry4MrM6xb2qoHnhwoBzkJF7Edxnsjml1LXcl2xFgssvK4?=
 =?us-ascii?Q?K4jKBNkvmU8yMT/k2mpKyHYE5MuTU7xqOqoRgGxadcx3+ZLlCZ6vw2JxKiWw?=
 =?us-ascii?Q?xnhyA0npHOVuFstHkhRRFUvjuSfxSVSGNH0n+m2+lUANGD9AOUmGcavoAeUv?=
 =?us-ascii?Q?Wfcl5eUcoUDDigeYOC3N+sjISsAk6mBqFw7FvY78vRLh9nfWrR0vvgF/O2H+?=
 =?us-ascii?Q?KwnXzxpMwZUudCNI/B8flOZlrAZe8iG2Rk2PK01A3K0UMk4UZv/YGHulB0ur?=
 =?us-ascii?Q?1i0nMqQoWXec1tKQml4MC/JjvwC9zBHOH58sLvVnitI9nvLG8zg7r+h1oNxs?=
 =?us-ascii?Q?2h9WPtmBiT7HegvFVGujoz3h9LrUvNUkC91GUCFxLwyH5A9aR6zzzQL9vjrC?=
 =?us-ascii?Q?Tb6di5e/fR9HCd5ML8xutiTDdD23I0sailfmQSrOd4DnNxlwlIkcCPo1EoNj?=
 =?us-ascii?Q?vS3bE6Q16q0YOjuvsaGiZ51H3hfgvx6f2xv4mDQRecW1bpwALEvxPS8iCFdi?=
 =?us-ascii?Q?TmjeAz9NPs2gELqrwB0/RjOcAo7vHsS9MbZuWu4LGZJ8rWKs1IoPLZFmXKXI?=
 =?us-ascii?Q?MR/Z9WisjBjfFjBJ8W4zAAkOQWvYqq7NOaKBieeoVg1DDkOUW41dC17nkh9w?=
 =?us-ascii?Q?cLbnASjazgHoYBvp7jF06i0wXjUTfT4+/MqDND7BOpe6LdxrV8LLpc7MeoA6?=
 =?us-ascii?Q?rQ7gGcky5gMBL8uJqHJOC2izBj/9uv2NHmHVfWCUi/FFZ+m+SBiO7XK0JzI+?=
 =?us-ascii?Q?lX4xkiP3jSe2WcaivyNlf9oOmri/ad+ZHOJPKktd0oxpMSoRep03MSdPTUw5?=
 =?us-ascii?Q?S7l3MdwjW++r3rDDv0Iu1lBgBf7obvYFxdsC2lgf5YKWiQYaMKOoJ/XR2D3L?=
 =?us-ascii?Q?e+48MHI33mGSN+p1ZrSbsnWNszsAc/cPkK2GztQepULXJQoSlT5bRkAomTqs?=
 =?us-ascii?Q?M7EPZFGjkxpkUB0eVhSKpC9uBIbERjuMGNL9JGuUIq5spzMKAvfDa/N8nrui?=
 =?us-ascii?Q?/xWxoLY+o8ygIHxkvxoKAi9KBjYNFVUaemg6Yz5ECdo1lrGdLkzlMRIgKXkw?=
 =?us-ascii?Q?lGMcmlu/DPNBYjy0LE/y96zQMCGe3w0LCwI4HrnvUtO3eyeglFtx9Y6zg3+t?=
 =?us-ascii?Q?pIL4VMC+ppAelM9PPsUG1NOj7DJaQyGSfK2IGN7mPhp5MP6KEDgEr6Ik4a7S?=
 =?us-ascii?Q?g3vb2rxdQ1+V1GSgnqRq6vjDonrhfbugKggBe4vP2LqmmtblB0fQffvFxDGk?=
 =?us-ascii?Q?s2R26Pr0+ygAM13KM9cyhSLx1xt+zrDBQQTvMnHv3/iCsXqMXCtj4GFf55C+?=
 =?us-ascii?Q?62AdADdTC6uWtwKo4HVfnEZkDl/lJgNvmf6W0zCYFuokiQB5GPsSlK1WXU1r?=
 =?us-ascii?Q?s6MD0X4bUQDgfJX3j0MvDyMc3f4YN/VyDXRB4j3x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f7881e-565e-435a-7fd3-08db7df9d5db
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:20:19.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fwx62AUjP/4YPoOVZHltufHOaGtZ5abmS/cXsIyE58RE9Lbk6lobVDUcf8rkgHqlmda4xzg2TMb6TUcmFOzClQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066
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


