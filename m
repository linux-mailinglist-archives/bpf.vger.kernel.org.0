Return-Path: <bpf+bounces-13605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023C7DBA94
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BF728159B
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 13:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA3168A8;
	Mon, 30 Oct 2023 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="y+IUrpZ3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55A16402
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 13:23:11 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F41D9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 06:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W70oC3jii0J7WfkL+oqBp9TehjgB0BEmxBGleK/fRQ4/I6WRxLadf5X9k26Q8iC5puwQxi5z+M08ZuHa+zIqISVq5diSvQxmJDWE9JOkiuF9gUP1CKMnVVHBxiczNiZjaImJ14nYQ9PfMGFkT6wK3RWspqHdVR548YBBNXYXhDMg4lZkpnUu+VxjlMSHWzRzRHsOWq8nD7GH4C2U9KrTu55MAPBzOeAaD86xAxLGpzHwY7Z/lWBR4yRD7u5I8V310mnTMe8QH4TyQTLWEjVCc6dIoVwLTnbR4UbczxdImndfOTBuRAnFPAv6I7vCsMukCR3THY7yujpAt5dn2DfDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hi0Rsh9qyH8zNYgsWHIZ27yfIC90cJfTAtoM4vnEjY=;
 b=Wj0wN7zex7Hsthfg44CeIShmvPcTmy5qMsXpqbZZqnn0PgJyYE8l9yGyyROtfObvjR+Xnlo8zVTh4VX4GHE28CGguOUBQJ1IqePva6gRsq8zduqWtd5+nqkYQt+E5l6KMQhMUBBDRhUVAWrnnI7oIO3fgwq8bHf4F8UlSD2ncsvIZ4FuCsJM56XAAiAbFrcBqoC421Mik1cDsYSG6vpUuylrc5Ed21L6JArQ9jZunO9w8jCd6xaQF6VAdz+Ymjjx3/hXwjqDUOvorwX7XLAoEmr0LkwkMU2XK1Z1G4boCH6maSVaB7N7jYILQFi6rwCzaxnlCm/CfTsfILbvwW1NuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hi0Rsh9qyH8zNYgsWHIZ27yfIC90cJfTAtoM4vnEjY=;
 b=y+IUrpZ3j3xiiOtFT7SxGw42494S5/39rhW8Tr++qfrpYMot2ohTZtBfe/eWaHe8gMmg+Ee+XpwGLbyBJqB75JPCQstlYnXoK5yi3so2eawalbxpLar/zNkhyqMv/JT9RS1zHry4PdS42eg6YIXIaWvEuqw1a1xfMfxYQXf5mhUryy3SKBHPI+2JP0p3QRRtTjE8gPk05pf4PPnVeo3tOwp+vGj4i3uZBEHbtdosjSdXDsgP6XhgRHCBYnds9Fb6sd2st6wf9q/la9XrZU/2Jr02FNc0f+tn/k66Qu1zIP1B00WBtHXWPHR+4InfgxZJrrp3sxqI3U25n9m9eZBFuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 13:23:06 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 13:23:06 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andriin@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [RFC bpf 2/2] selftests/bpf: precision tracking test for BPF_ALU | BPF_TO_BE | BPF_END
Date: Mon, 30 Oct 2023 21:21:42 +0800
Message-ID: <20231030132145.20867-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030132145.20867-1-shung-hsi.yu@suse.com>
References: <20231030132145.20867-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: a5647df9-d534-47f7-9152-08dbd94b5a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TV7F8jKdmH9/NkvQeH5121x0vv9hNQqfkL5rou+SqEdu7pdaIEWgUBWLsER0i0q5Te0mv4EI90FxiEzX7WeU2r0EECYi32ZCtZ7ijPvdFhKj0OUthmIgvOTqq6frllrrNZXU6rfQM9Gws8vZPDZ60LmQj9w2XZbArp16NihT6VStJn/KNZnZJ87e74OgJ71rTMce1PcylDXZAhvjetqujkmInYj6lZPDAGi5M+an4JR95fuFVFrF3DXwiiAvU8Uu8NJumVf+bmKI03tuUI+p8eL4vJKkL8XwDm8Y/s/6zIPeVdDF6V+3CTDFlTCH74xW8+akHIuhN7XrTbuAFQ1i+Pgq+T0HiTqwioGgCXLUME5dfGp3Sf29/bb5NVhz9orqjELQ++fU7RZa7xytJ8uf0izDbdi+ZPOf67Va4HbqG8iJHocKwJBYbx9S28GAYvR85J5hmQHWrthEszVc8JrXdJC7KAI+5J+ru/DWz1ZJJJJfPWwUzAQhs4OHpgz18a2pg4c3EH8II4MOCa6DCG2IF3GWqURIA/vNdtElvCkBNug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2616005)(1076003)(6506007)(66899024)(6512007)(38100700002)(36756003)(86362001)(83380400001)(5660300002)(7416002)(54906003)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(6916009)(316002)(6666004)(6486002)(966005)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JNO+vLernUgtsf8FMfwfTonBcoszLUe/O8eeY2TZLm3NCa+POiKM51EMrorm?=
 =?us-ascii?Q?ubig/SO/DwEQaCNbEy+/ify6S5AvfkyZmJty3ZwHUwFe1qYdu6oaSI0YnCvu?=
 =?us-ascii?Q?+Aw4nwDQzRJcCGcOH/jQlRIXlmsYk+7W00JottMVJK4eoqn6jZ9LMhA+TVo4?=
 =?us-ascii?Q?piRTMSaqN0ZQqWmH3Qb0jQEpKDNROVplKVVX/zkoaJyw62avCfLAlidpF6Aj?=
 =?us-ascii?Q?YVPjXZXWoMFF/yOaW6qqVLD9dtvu9fL/uXl+UaxDAvtBhmQ9NsopRn2XoiLr?=
 =?us-ascii?Q?2m95BoMg/Ubx3UgTN5lh7VASXL4/eGI2kQsijWp1j5qnNrMvJ+558QC4Mek6?=
 =?us-ascii?Q?tAfYWGWtd5quMB9D2iVpHLb60E1hb/zJvdEBViN+hArk5D6K+8RpuQfldMhp?=
 =?us-ascii?Q?V/yYHuGqJE8qcev4vlSycC8jiP3N+BjPNO1SwEqP/Y+mmmExlOzCQXbgStOM?=
 =?us-ascii?Q?hoUWPWr4utTEk7vdei3ruqZOGQi+zIuR2iGmJJ/9lAj9Lg0dE8vj2XT9FLZ2?=
 =?us-ascii?Q?Lm0Y3BrBROWl5Bib1YvnNvFsRohRP5DDNjCboAal0Bohr03UtS0ORzWgW556?=
 =?us-ascii?Q?Ye9KdgM6YyLKoeup4Pvy9rLoRb3RJU5TWhYKV4nAsZ20lph93PcuyDTu3wo8?=
 =?us-ascii?Q?pjb1QUOmpV3ayxslZ42Q0XBbjH5AHZdDEOX1i+U6yF+yncCA3yE/vNVI/1to?=
 =?us-ascii?Q?SjSJeBQgGattSwEqrvs1B9yvHuWee9JF9/6SQolYzw9gpqhYOXitLIh164fg?=
 =?us-ascii?Q?nKawN+ur/4Ydt8Jbrspfl7khbwI3oBq2M62t+uZo/x3yUbhrK9upse2FM82W?=
 =?us-ascii?Q?e0kxHGcVGv8h40TJosyQw5vXhYlkbYNArpXzWXe0Z1XnorEVYzTH5WZAiHE9?=
 =?us-ascii?Q?CU7ABYawSl/kX/76YZ4/D61nSGp9UvWYFZiRgfQwNh9orJNinW527RBv6KQz?=
 =?us-ascii?Q?IyFR4jCayt/eTCy5zh3W6NRgUS99Kr1i1Gfh2TRn/wtJ1kpBsGSlNaKaJCuf?=
 =?us-ascii?Q?x4LPvuVkTBJdfsrimOOh7lueorbxJUA7yTSPZjTcLmDCPcaKSe1ZlkRN2r5b?=
 =?us-ascii?Q?S1efJ3qmuGYyQG+VsLq8XawUNLLNOCOvBm4318WfCUfbjmhld+yZ7RGzW5Nf?=
 =?us-ascii?Q?0r6lToJsQn1O/Ho9vJf8byObEJkBQ7FZ7dy2ShFsvBEZxRHnvnMzWS5C6ocz?=
 =?us-ascii?Q?hS2imowGw5UBUO9VrhEt23ITehqMmMuzpx/my7GkFF5c+3nNmdxM8CiGzlz4?=
 =?us-ascii?Q?MLsUqQOHqA6Zt6/UrZlGvP+2F+pNMfZIeMqSw2Wu1bJrA8NuPJEts/A6jtgY?=
 =?us-ascii?Q?9Rzx08JV65kkpqmjLADt62jrIVqdeX8Pbl21ubyT+Eq0gAigGOfxAqVZjZrR?=
 =?us-ascii?Q?fyJs2yVlFBIKBUAJBhDfk2nWZvphcxYzfUUakWzunxmVKtWF/kMkbRDSqbor?=
 =?us-ascii?Q?xsKfngyD2ERmMNw28+ehBkQBXx2DiXeHhu1lflRH00vOAfEWlXRBVLPiCNVL?=
 =?us-ascii?Q?CMdj+w1/qnShgaFFem1wRP/cjlnFKkVArU3hoEkkJqWGZWw1X9ZDhYu78P6M?=
 =?us-ascii?Q?fyt2c2SK/pPV3+rUZjysRt6ffxKJJQkmoDWvzMsTuFGjIhvYH+NeOvA4O8cS?=
 =?us-ascii?Q?1c3n+9G9oJWnvvqOwYowRgb+zt6/FvT2VK1pFl1CDx2Uo1w1Oo8Fp9/p2v2h?=
 =?us-ascii?Q?BvtT4g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5647df9-d534-47f7-9152-08dbd94b5a17
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 13:23:06.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToIvaKbboaX2BTkwtdzRyKB7Lf5ixiEF4mbLcp8bi+5m2cQHUenXjA/sAR4rVuJN56jMWkkNVkS/J+rlqN+q7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894

Add a test written with inline assembly to check that the verifier does
not incorrecly use the src_reg field of a BPF_ALU | BPF_TO_BE | BPF_END
instruction.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---

This is the first time I'm writing a selftest so there's a lot of
question I can't answer myself. Looking for suggestions regarding:

1. Whether BPF_NEG and other BPF_END cases should be tested as well
2. While the suggested way of writing BPF assembly is with inline
   assembly[0], as done here, maybe it is better to have this test case
   added in verifier/precise.c and written using macro instead?
   The rational is that ideally we want the selftest to be backport to
   the v5.3+ stable kernels alongside the fix, but __msg macro used here
   is only available since v6.2.

0: https://lore.kernel.org/bpf/CAADnVQJHAPid9HouwMEnfwDDKuy8BnGia269KSbby2gA030OBg@mail.gmail.com/

 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_precision.c  | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_precision.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e3e68c97b40c..e5c61aa6604a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -46,6 +46,7 @@
 #include "verifier_movsx.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
+#include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
@@ -153,6 +154,7 @@ void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
+void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
new file mode 100644
index 000000000000..9236994387bf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 SUSE LLC */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int vals[] SEC(".data.vals") = {1, 2, 3, 4};
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r2 stack= before 4: (57) r2 &= 3")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (dc) r2 = be16 r2")
+__msg("mark_precise: frame0: regs=r2 stack= before 2: (b7) r2 = 0")
+__naked int bpf_end(void)
+{
+	asm volatile (
+		"r2 = 0;"
+		"r2 = be16 r2;"
+		"r2 &= 0x3;"
+		"r1 = %[vals];"
+		"r1 += r2;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common);
+}
-- 
2.42.0


