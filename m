Return-Path: <bpf+bounces-4170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B473E749499
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71D01C20D02
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E5EC9;
	Thu,  6 Jul 2023 04:09:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2F1109
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:36 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426EA8F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:09:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de5N3+K5+n0DrIdv+2jkg9irqmYWMYSnmYnSw1miUJLJd2Lpm/tXDVh14IgRtUizMQuyD6KQQgezv4k8i5DmMv9JdZ1mr6+MoVgUJD3cEqly6GCjaSqv5b7zA3LV2lLNUhxIoAh1rhlcHpgocz5YS8SqlEmfHcU8d0vyqLFaf1GUmcr1vXoN4IkEWKy0ESRKLdXZ18yJfQ2GV7n2GNGIeHG48Mpapo91b1I/CjpAWiCeV0QwuyI8CHCAPc+4Jf+W1F+oEOcTLi+7Qek7M0qCP3vJyv/WQlTYJm0E5+lS/a1tkVB4EwdWTpU3WaspQyN1np8OVblFAMTARk4xQmR1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPH4bwg8shk4a7dlucecBOgYz1Xs3eVluKKT5Ey3zWY=;
 b=FsHv5x71R11W6zUikeN8bQDfsg2t300OOrQI/wYzkKTBMG1OXaDfSpALjeEe6rQ2/nIJD7RV9lC3191bGUj7nMz3eG2bZ2VsFu/TiIoLS45BrZz1qBEXNAbAT/+1Bf9hy1HFfmanSDGYQuQbK59KPSWm0BHyD8IWwwBZpEvc3+QlhaVmLM3fpSDbi9rzD3LLkD1QGOKsGeKuECrgcSpWJMWexflc3Cyz2UB+hMpmVpuRYF89NJmEUsa0dNHLl3LjLC3e8gpl31RCyGfjV2mWj1ycdT2IDaZdz6DRl2AZ1B0o0vQtyE5Ycn34Y4//SYp4HitJ2GzOTl6QWtvUwV9/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPH4bwg8shk4a7dlucecBOgYz1Xs3eVluKKT5Ey3zWY=;
 b=k6kFYCwgi3Z/HiVA2yAJIegHAY4QDfd4R7wV9jHSJzwZTgn4mFntVkMOFvW5rsewt8yzyQopHtBJEtT/z28smKbGoh+PC4tf6AoT9tQVGBh4knt/Ut618OUOxHRLrNVeIfjp3XjGGlGetvI+uJYaPZssCQjxorMoIakYsdIl2dBa456pmF+pgDDDdf9cULcaKvf7bZJarckfD7x/2OF1bVIZQ+vSoNpWuHSGlCC5+g+Al2t0TQdTOZL7VIb1iTT3pU2tLAGoVA4V+b5Vq2SjxpsdoGyzNV9Fb1xNv7GsT8wyY8AFtqF/uuYalO6HS9hdQC9/JzR4LnzX2k8R8ngXDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:09:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:09:33 +0000
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
Subject: [RFC bpf-next 5/8] selftests/bpf: Add mptcpify program
Date: Thu,  6 Jul 2023 12:08:49 +0800
Message-Id: <b603ea19dee78e03d19ef1ac619545f5e2a28daa.1688616142.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab90c3d7-3ca1-4d30-3973-08db7dd6cd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7tSQDHZ10lYb9ZNY1dV9lckPBruQcVFzPXgJ9I39MxW7FotPShnlC4MOIRx3b2INXjd3hHx8616udGaO7HXuZLdJ+a6FiLeKwkOxdj/j+2PBnn6hXLz27rGPG5fu1WQemAYfhvZroqkaf8VnPeWLBbKRor8K/KIwNRKZitD4Hxynxyw2+sPsFJYgbvq9k+Vn8w1XSLXDCh/3y5oA+PQqeSHmKVy/trg7TwqtFjKBC8ciVBEtyUhyWJujBINigQu3zGKQ7GSjCS5h7hBeJ8BK3+FKL9UlSJ7fOSwsqZqtTi4Y5HQegpZLDJyQCM0wlxuQePFoOVtq+hSwsnn/lJfCbOqiAA0xZUPbm8CjMsrBKFmQ5zpvqr12MVI+uCK5LSiU/ul9vwdPo3ACgA6l7I8Dx2q+xiBt0RvpKwmzcNjMROJQHIzTjFbGr8vEkYRCOYsvlYQcuoIvpGETvRXwCDMq6EKsATnyUy+ve6sHcD0BsXAqlK7MBEnJRbA22eBKS+4HMHdwhZy4fgmWi56zRUzQyke+Wo+E4rxL8279ZG6f8ItQhK36lcvR0cZpPZ/KlpvfhGhPbIGdS4OCs+Xf+0sigZFHbm1N0vu7HjU4i3JoJzXFp3IFjmgk1N9dWcE3eJt8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(6666004)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q4RKLxcLU5PzFA1hGvH0p15qxqa7ae3W66HUwp841mOJIiS2iEpxHXIJclHR?=
 =?us-ascii?Q?LF5BZgrgAGWfuCci2OSl28X/yOGMF5OvRmqPwrtz+W7aZBbk6G7b39l81It9?=
 =?us-ascii?Q?Oo5MK+Jk0VYv0lmRtHsJBUCRhTjSR/MEt/FNUDCBZFBFH2RRF+k3w5VukJTS?=
 =?us-ascii?Q?eRTaxo5MrRxemKonoaF9tknf7+OmuBRtc5PAoff2MCBgy8GUtzvUmU0D4yKe?=
 =?us-ascii?Q?w/cfya1t1UBOLEDuTRqKWa5OvMltTKcxP0M92u82bgRqVfPtYbPRjCgmHZ8g?=
 =?us-ascii?Q?+x8zYj0ZrWGRnDmEQY3+ihK9zbOfVlJntjjvRcDHnbycvQffhalVs1j1/L17?=
 =?us-ascii?Q?KItnXM0EqEia/z7jtXoPy9YQJYDi2OG+3EIe52Rd7TVhX6/31McRXiFme0UC?=
 =?us-ascii?Q?+XPpHebOEb4FwcE1+UbJrnvyf/PB6Sc86DHL+LR1EU98FFacT/AI4+7B9tyY?=
 =?us-ascii?Q?Zr18bw63QSmBSQPVuCtFHO6zhhEddqPmPqrpEGeFqdGsnQWo3UZ9jafJjelL?=
 =?us-ascii?Q?RFo/E6+2y2OQVmLQlHcjDuhvQswNLPSXjgcFhNwqs4lSlQb2BgFOW/BhHpLE?=
 =?us-ascii?Q?wWDr7vnzFhyrWtioEU470ZH7xHcI7tBzecaRhEvrdHfCpvu0SgRLGslFuh+C?=
 =?us-ascii?Q?TDsv0G8BFfKVy7nw6FowD64i9UfhRXC+oSHwoxOfbPzbAgElujRHjO3S40hQ?=
 =?us-ascii?Q?uCj9z/ustRmQDQPZUGSwUs3Mu7sabORfZw4IT+PjiTfTMOH/3472W8LYLQIE?=
 =?us-ascii?Q?JHeSvtxqq/Q081Ypk9PaZAPYtFvGhG1nwi0bOoZz5PP79+bM1LfA4/CaHJZ+?=
 =?us-ascii?Q?wm7cRyQS/agmTMXCJDtx5PWNpB5kH1JHTWAAIQUKMpxgQkvTJo1P6aocLimv?=
 =?us-ascii?Q?NACkBf7Sr0R4tr3HHbLohH+QNeHlNrPIoznKn7xmwOhj8qUijMReAb6CCfHk?=
 =?us-ascii?Q?WhuZmnUD08WVBUdvNmLvXWtkfDGEkYWN4OBKCOufNUscF3DtPITZEVTEpFTl?=
 =?us-ascii?Q?WJcmEIiv3RmenJyne1GgGzPO4Y+ALGNFhQDFFUvQweERnE/4CAytWdHAlOlC?=
 =?us-ascii?Q?jOaFml+5JLTe2Ot9QFJ9xl52A+cmFAMMyEdtFtph9TVMfXWgeUyAGzk4aS+L?=
 =?us-ascii?Q?hruwpITiz/qMlI3fOO11fZtlyyTg2Y4rIOYIA5WhhGrmxfWA/MpSnJgdzuS6?=
 =?us-ascii?Q?nuCywPPKe8CffeC1CbpQHj/vwaHHxnDTOGGfNPot1YDx1ncdnj6NsMdAoU0P?=
 =?us-ascii?Q?935qe7KyleLHj6YFjyz9p58WP8i5R/f6oOUvGHpOncLtzgo8e57Jh4jksm8P?=
 =?us-ascii?Q?SWk/+mf96zjyKeArLmZOa785GgP+z6YJqPFWNzxCqJFqS2n14+YdWOxu/s5T?=
 =?us-ascii?Q?GqwlzUhoBas+Fn6zdRmBanz3CfGLgBYhi8BBXy8E5jYNFIRxemFKzHZPRIb3?=
 =?us-ascii?Q?4KhMKEGm9pV1WlO+lSG6hgC0IsMQWkenJPxQQg39M88aTdP7rflcMH6/POP8?=
 =?us-ascii?Q?/YfCw6IBI00DFbG9u8ubq53BiLzekFUNMNav1HW29PUpsWVGbdDUAgZMjsBw?=
 =?us-ascii?Q?o97oF9c8e944wzAKlJRxWX3TykS+4vc8GKdA0zm+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab90c3d7-3ca1-4d30-3973-08db7dd6cd79
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:09:32.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvaneF1eP+lKinLUa/h8HakN+4Edlb3Bir5T+yU7UwxqMjV9E072DyiJiPuvIQRmnr5++nzgsi2PVunywjDfwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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


