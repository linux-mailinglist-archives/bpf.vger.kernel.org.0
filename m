Return-Path: <bpf+bounces-13908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444FF7DEC6A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32EC281B2B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27486442D;
	Thu,  2 Nov 2023 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rE2FGT6r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89097210F
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 05:40:59 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2074.outbound.protection.outlook.com [40.107.13.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79725130
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYm1/tOkH62MfYD+LgWbqbXPbuOFP07i3H8HuXZ3SXvjt/4eMEDGmcDYtU4+p+c9h3/6KU1BvKYOoBESd8T4agXxuw7M0EY8tQQgfXevpaFA3KfDY4dAn4bKS/YGl+ywAM6TmC97OjLnhfctS3WvyASh0ECunJbkkxKPTL71OHfEhArLZd53CzHMdNi8/r6A0shKVu+Ezvwd++5Z9fPBJOVg1TlrYX7PnGmaZ3ozvq473FJRxhQsoTBxfwRvSEz6+wGXQf6WIhlV99bef1iS+FKs9hSBkSx4eBBr5yNzOaoA5uC6NpjBTf9VF+YPc8u+Z4Nt6SLLfxp5c6xUwyD52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZA3MBZ/6HEhHqJ1sL7zr2+713NH/CAOJYbX38mTjKk=;
 b=Q0LyrW5k6eEKBIAOJZ4BO8cSIoAOYogRaSePCu9OYV0/LolpDC3yPJy+1aTyPViAbzz/VKkfipO6ngZvGbsV5wbPuYf6kcbrMv952ec8nHijNuRdHbqlff5J1jVynrmwv/f6OjUUEiekGDLyeRvOdNxmPYqGq7KgkOi9aeAHVOBzvu/7CApc1kenw7rpm1rRLUsRcKAj01BxLblxYSVpfpYXcisIV9WP1tSw9UuKAVS4mfxzp5GrDPBhcJTxmfg597R7GYufgdsUazOSYvOGuRLjt5yUTkUdhjUHylA7mxhEibn8+E21Mfvd/1A6drzw5tBGYmJEKafLKuMIgRnlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZA3MBZ/6HEhHqJ1sL7zr2+713NH/CAOJYbX38mTjKk=;
 b=rE2FGT6rnN7lXEX8XaPqAfk5exqsnRJ1fCIZMKqksyOmHE16THfLdBDCky9rD7b/pd1Myec6tahhDM7qzhvXj6nYBwmAZMSuTTiclUfHMoeWCYetSbr3WwlIPaDQdx0N9HC3mGByn9eqQTOnx9geYoHxg1/0POKGx/RcHvasE65bqRpgp0iO6lCqWy0uLYByT0h7L2LOKFKdPGNFTzG2TuyvbsIF+Y0KhJM84/vvcIdiUD+P9X8hzsDBoaOm6eHezU053z4UQzSEhmvTJhsEJrl0SLYPAOt5UgSWPuzCGbQWrFa/Q3mkdfyGQoRUmc03xrjIVbBWjFilL+160Z1JCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 2 Nov
 2023 05:40:49 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 05:40:49 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH bpf v1 2/2] selftests/bpf: precision tracking test for BPF_NEG and BPF_END
Date: Thu,  2 Nov 2023 13:39:05 +0800
Message-ID: <20231102053913.12004-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102053913.12004-1-shung-hsi.yu@suse.com>
References: <20231102053913.12004-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:405:1::20) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4b0707-c68e-46f0-77a1-08dbdb6644d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H0U8+3yiaHG16Rp4jV35UdesX3KoXSnqk7hyYFZetk+TtbvN+0KrNpej2YSXCIlGE8lNVrrOUz97QSpsobHgnQHTKBYFVLcuv/u2/P+9YAzi18+kZXIneuxpX8xtnnvh8rzPnRqfyXXs4WB2/QZmZINJ1V6vzamIZvhtMcLY2omf+a3GUqBP2wLjtBcGtYsn+qOJWQZDTmHAQ2h0/cvRgDa0ldojYL/9JEu7TlWDZgQz2asMMu+EamIQZyTUfdwnXKG4jwmSghBme4lsYM04XehfkYo2ud1nh1YNn8fTp1JSyAMvp3NNKXNzgLvKLe8G2nugqvyExb0pUlzZyIqWxr4jOych79ud2DAJabbZFk/8vllY3pDNTcAZQx9vrrU/El60N28baDyJLRCPakJsPXCLgwILuvImeQNj1KM0j9DHzx6Ol8n0guj7CZB+udMHSpnQICHENCC1LUPcIswGpTfFc+9fyX0vP/vOc0GCcGsETCVZ4nlPhzt+t0QBA0qhgaFoxFTLOLEUH9luwCPSmhuyukTIspDTiwqLiuFzu523N+V1Jq4vHF8IKcCJxlSF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(7416002)(41300700001)(54906003)(316002)(6916009)(66476007)(66946007)(2906002)(8676002)(6486002)(8936002)(5660300002)(4326008)(478600001)(38100700002)(6506007)(2616005)(6512007)(36756003)(83380400001)(66556008)(1076003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IHYquck6Ywnnc4PUD6ywf42IMGbfQZZeUH9xTY8FwDWnDqp0IVaUBJNnrArc?=
 =?us-ascii?Q?eXVBsFu0vI4pPUecmFXiEftssuHmzVQDYoEL4Kkdqh+WFYcxjYpnbk1QmQzr?=
 =?us-ascii?Q?Qbjq8SH03l1pV4lObncjBbR8N6pBy3h6TrCwTGaF2ZfvslFusuF9UB7vZ4eV?=
 =?us-ascii?Q?Epjl3K9S/PgPXS8Ro2qFwf3kN//0+0oHAc54E98Y1hMvUII8VDr9CfsN04kU?=
 =?us-ascii?Q?lRqcJmSK78dUspdidByh1KMPAlJmsD08EJwHKw8zzjCJLTW089Rb82a985dp?=
 =?us-ascii?Q?pu2bYtoUSDnRSFigyKtzq96VUDeI49LESWIJ+ixcTTOlfseLFDvoXMQkvjt2?=
 =?us-ascii?Q?wQq614IzKtXBEk6snNZo0kbVg/dpOeleMu6m0CXD9bRLTfa+bS+h+bHduj0E?=
 =?us-ascii?Q?dU+BxXmR0X2Kpoq2IELpQmpHKIVrFclwy47+NnzP4Hj4j+cbZucOb4lvEjY0?=
 =?us-ascii?Q?zCMHwTGZ3lqnAW++RwUmdQB1kDf3/LPWvuYUlKKkDe58Fnam0IyQaAfXXMc+?=
 =?us-ascii?Q?vTYWUb3lbswuii4TpMAVE5M0X9kxXJ7ghAwVzYDxu08Mk52FFKp552EM+18Z?=
 =?us-ascii?Q?89HXbBayf+tFxVOl1Vc9M7lH5d8fiwNXFLQeq7QNgnuEiBf+eJkMCzi0XFpL?=
 =?us-ascii?Q?etWfPOP5OG2yMgzi2ncVe5PAsxmEeczeiY7hI66SiG49KTjhlh0y05KNW0zH?=
 =?us-ascii?Q?iUpZez2qY73DFTWWyy3IYU+7tnTRw3xVoDAJxk2+upfzDGB8uTFkUFADsxZg?=
 =?us-ascii?Q?9HI+iWbkkPwSbvzfA/hgkKTKp51KbyxiUQHZ6KdkuZWh1aEDTNtLnSZmAigE?=
 =?us-ascii?Q?T9qSry8oK3IARvrrkW6gfUyz5ahhBlH3isKsHPC0LyWTn8Fr94SOtta9oUzG?=
 =?us-ascii?Q?GrF/CB+psYBZSbVK/te0Tk4guvJ5f1Nre9msrSl82DVLbVMqJ2vvOMRSj0xz?=
 =?us-ascii?Q?7toCGoWPMNZBBvO7DSs2DKSjC5x0q2hzNT/yjtShRMAFFHQyVJpyonD7JbFj?=
 =?us-ascii?Q?nzE3QIVzQ0gozro5gCH4fGzoLbJ04099ZzrmSW8eY0+RKZa68x9dnv4sjO3a?=
 =?us-ascii?Q?0f8Z/+7u3adJ8p/MND09Efcy0adBFUfF1cJ5fkH2gzdJSlKmrpplVXE+bXUk?=
 =?us-ascii?Q?n2dCl3chnZcgckLTy4fWDOP+jtZKb0+Nvs6qo+1SAlVxPT2Bc1Y2igqp4aPY?=
 =?us-ascii?Q?ip2SeJPfWQQXtOihoZFBSQ9q2O44YaotZfJqosvWADXvRG0tVC6YMybWX3Tp?=
 =?us-ascii?Q?pxGXiHzSqWVDtlgtZhwJS+Hk1e3FEeEfYq/cT36USiQs01TpkenZ3qU/zSf6?=
 =?us-ascii?Q?srTinpcVPrRrSk87I+BKD0AUboN+2RbTrdBYf/PaafZYTHKluSd8X+sClThi?=
 =?us-ascii?Q?f/Snhy7uTGr4BZLUC3kT8IhHZ9yyzZfvDNzX8qS9XL4UwucmdVUYMGzMRfAG?=
 =?us-ascii?Q?WTaEHQoGeKik4A5f1ToRwky0qmi7BL8CxUJH+aRfPBd7WEuyGy8kjhC7zBE5?=
 =?us-ascii?Q?uNUgt44O9BB/1AjeAkYvte5HP25cJE291BtDkEQOjFoexVkLVNiqIxyHOhfL?=
 =?us-ascii?Q?Jyjj7w0zmUWp+eQCUOCgEbotRM03rGe4N4amBOGZl/TywQZu+Czx4hb02snh?=
 =?us-ascii?Q?djnvZ++FZBg8I1HqLl+jkMf/EkfGr8Eg5F9bnGAatl5ZNDQplwTlIwm0PH8b?=
 =?us-ascii?Q?z0MGFw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4b0707-c68e-46f0-77a1-08dbdb6644d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 05:40:49.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etDGcEQnnj+o3F9B6wO/cvzNSw2w/RBHOPzX8Sf1b/My+OLjVRragWj1IVlJiIZO8tq31Xxwa9Hm0RnFptU+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687

As seen from previous commit that fix backtracking for BPF_ALU | BPF_TO_BE
| BPF_END, both BPF_NEG and BPF_END require special handling. Add tests
written with inline assembly to check that the verifier does not incorrecly
use the src_reg field of BPF_NEG and BPF_END (including bswap added in v4).

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_precision.c  | 93 +++++++++++++++++++
 2 files changed, 95 insertions(+)
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
index 000000000000..193c0f8272d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 SUSE LLC */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0xfffffff8 goto pc+2")
+__msg("mark_precise: frame0: regs=r2 stack= before 1: (87) r2 = -r2")
+__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 8")
+__naked int bpf_neg(void)
+{
+	asm volatile (
+		"r2 = 8;"
+		"r2 = -r2;"
+		"if r2 != -8 goto 1f;"
+		"r1 = r10;"
+		"r1 += r2;"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
+__msg("mark_precise: frame0: regs=r2 stack= before 1: (d4) r2 = le16 r2")
+__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__naked int bpf_end_to_le(void)
+{
+	asm volatile (
+		"r2 = 0;"
+		"r2 = le16 r2;"
+		"if r2 != 0 goto 1f;"
+		"r1 = r10;"
+		"r1 += r2;"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
+__msg("mark_precise: frame0: regs=r2 stack= before 1: (dc) r2 = be16 r2")
+__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__naked int bpf_end_to_be(void)
+{
+	asm volatile (
+		"r2 = 0;"
+		"r2 = be16 r2;"
+		"if r2 != 0 goto 1f;"
+		"r1 = r10;"
+		"r1 += r2;"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
+	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
+	__clang_major__ >= 18
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
+__msg("mark_precise: frame0: regs=r2 stack= before 1: (d7) r2 = bswap16 r2")
+__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__naked int bpf_end_bswap(void)
+{
+	asm volatile (
+		"r2 = 0;"
+		"r2 = bswap16 r2;"
+		"if r2 != 0 goto 1f;"
+		"r1 = r10;"
+		"r1 += r2;"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+#endif /* v4 instruction */
-- 
2.42.0


