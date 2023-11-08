Return-Path: <bpf+bounces-14462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A2D7E5022
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C1D1C20B39
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57482CA58;
	Wed,  8 Nov 2023 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fObMEZ08"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0BC8D2
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:46:57 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084641707
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLOm2Et58SLocA2cDad4kysqVzCmoUQamz+YJhxKDycQARZ2cn2nbcPdA/8NxDeD1/ZEPPya3uHAs6aHExo4UrVeMwi9wHxpFIErYbeHQAa5E4dn15waRZpTlUGCX9CvSX4jqtXW1IZ6hSwzjQssG0ujcGNpmqJ8lrW0R7yMb48xur7Zpbp2HsEoyrmehX9trzfQ+2PwukAy6bf0rBY5HRwR03kOx1P38cXJoIfnPf3kOP27San343B3VoPwKHeBYdH+ltXSJD9M3goNKefUdkx219gxqoPuDei7AondkuF77enJ07whOwnAdWVmV+ngVjowbDcMJL24pUARhj5Wng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L7s4F+1u69iqXSVHKHqh3zPlevFxs9mQa312W8D2aE=;
 b=NnxyVttbWhiLHV5H77lmeqQr084vuxI2e3qE9aXkWE7WFMdtWz+Lun87HVCDDYgAwRiBYpKtDFoFdILC0xb/NCSaG+1lbikyQe3u7UwUB3O01n5zM7M+/mnkgmkazZYeHc+7JMccLjBmq6sOsZVYVKnI9oWJ04i9IAiFMU/M09/9ESvCuhyh5CKG8El7KjqYzFGegCGVN09LReJ8OZbxninTf+Fggjzfin1Hsc19JFLAM0i/VFMdgoyBCx2fhA7XRSgb+/crLZq0RURFllacY+FxYrsKOy2IBpVqE2ApnjzoC7QmE6+6I2XCJv2YPEKvxnZFdaRXJfZr9OMkyuY/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L7s4F+1u69iqXSVHKHqh3zPlevFxs9mQa312W8D2aE=;
 b=fObMEZ08LQysKxa4FLeT9GZEBB/aVSZCz91VqtDu4coG4bnCDHbp1RjWqcbaYxEOhmMPyrBWNVI4IiSsgPWTaqt5vycq5Hv6GVGcTe5k7m7iayc5SHC84/uC6qiTtHMHkjEsgZDEsRsxStpt1SDUHzYqOpU48c91l/htcuMXe1adpnGFh6fYTyaOF/mzTbZULPTsPmnG9foQSA8pckEACrK8YMnW7w0AFjuf47w7WMsOO/65zqMtO1iZiGsJuO6O8MQeg0A6DHwhrkeDPBjYBQixMjFa+7bTxsSV99q9d8HPyw1tA+2r26/nj4P38UsV+f0Muz9NqQcDiKXx6HueOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 05:46:54 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 05:46:54 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Paul Chaignon <paul@isovalent.com>
Subject: [RFC bpf-next v0 4/7] Implement wrange32_add()
Date: Wed,  8 Nov 2023 13:46:08 +0800
Message-ID: <20231108054611.19531-5-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108054611.19531-1-shung-hsi.yu@suse.com>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: ba96e02a-f7c6-4329-e81e-08dbe01e1d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kpn0yHc+fzN4+7oefdyvBdskcq0XZAgu6T5H/6+jCnwWHyDXvfuJMO7a6i1Lo08EJOMCpmnP6yG3I8N5VQadLH8AHatM7wRc27L1w1zBMUdYmkz3pm+RNTnm3I1TFkM/fztiPLLaRMVUmInI7WEdHhO/TkCSoVJ1Ugidj+hVq/5hm8Bn+tNXCtQAhwoG7vFMU2S5DKJygZN/24DhTCth2UlliyhrnR8gqRtYwwhajv3uhOGP9JKyUb5kkz8NS9Sk1MBio4eT0jXv0c5S3wmuwSDrLGCNmI6idCmDKQzRHU3EQESoGTCA1MlO1PK+9d8mmjVDtYGq0LnCpr2dR4uSGtGubt1ASI7rD6O6P+rAhjHb4V3JQLYnw98VPO4Ci5WcsCFFAxpg46L3yJh39g9FH9m0eDEA4BWRDpU8/aYnhZs6hqiM9lm9R0H5wPLvxsAH145HUyHC+/bm6IcALXGISq5B2pn9kOBnCxoW37Lv4MdMelmf/+ZkLkUooibo5RXpN/hWQ5TwBvYpYWJey/j+xv5GUgqJ4TUcUk+kEIlPTEjOWiw+NlmC5fUQPK6IeAbqKxLGEcFCelXDk0LnPcBBjQjVZaf+pw9XI90+NX6mvvsBt8My8f39iOAVHgZob0Tk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(6916009)(316002)(54906003)(66476007)(66946007)(66556008)(478600001)(6486002)(6666004)(86362001)(5660300002)(41300700001)(36756003)(2906002)(8936002)(4326008)(8676002)(2616005)(83380400001)(1076003)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fKFMyRKbjfEutOcj6Dz1uecPAzUv2hJzazElqucPwTietmNdtPgPp+bQIIn9?=
 =?us-ascii?Q?YKMa3TtKAnPY7lh8wkBUoHwpMHHOeRkvwh/gR/z9pkS+PyTekYrHYg/yz49d?=
 =?us-ascii?Q?TZ3e/DJ2GWOhAr/U8RO6GFe39AMRpwjASOBraxXLFrPKDA6oiq7t456vmqLb?=
 =?us-ascii?Q?6VDmXHCJGo72GtjRty7GwOB7grccqcA0kaNS1nXrtI9Ly7qXvOwBhorgB+FX?=
 =?us-ascii?Q?OfDJ8H8MkkB4D1EGQFm5g48pDSvZa+mAuWFqG+Mhyz9iyhJ2BV4VpbF5EsST?=
 =?us-ascii?Q?vd9AM0tQBYMmd9flWYrnf0aQ+E+b6t8F8hsx89Fq8OgODlsRaywza/Vr/H1X?=
 =?us-ascii?Q?QbNXFyj/EG5D/Dn5BEgV8OFB0qDdffg764NwfmCHO6HRhCVKbbie50g00j4z?=
 =?us-ascii?Q?dg1Uf4wltIqVRU3K+o/QP/5wsGT1/QtuVzojdV2slmBj4Jw3LkFMbpqgR74b?=
 =?us-ascii?Q?vkL9hQ85/i1ZHdF58lT7M6OLjQKgYKv1lvWyp09Bu0w0az3bYLfD4rDnp+71?=
 =?us-ascii?Q?sgVKM6OjTxdzx8sMKJoiOxvYkOd1NUivVaXZlskddnfGi0yjMjaq9LzehoPn?=
 =?us-ascii?Q?QppRufpnP43G9QjRrHKfF7y1I5Ytw6RvSL3eyNAHfW5bwjVbchlalf9gIKN2?=
 =?us-ascii?Q?lky1/dg6G+JijF+j2iq98vYATLC7cFwUzyWsoe8CJREbma3keNUjKQQ+6cb3?=
 =?us-ascii?Q?MAelAkFCkOZxCToea4uos0ddJgeZUNGO/kTAMG+Xy43nnHAwFPI+uE4OL9c7?=
 =?us-ascii?Q?Jx/IVTVEhqk4OqMVY6rkZ9cvCn5d19VRi9JnJcBzVF2hVIp/KyyPYqnPvfcT?=
 =?us-ascii?Q?h31rlgLzaN1Agn03MD7iRFHA8NTBa9aHoUyG94KJHiwdmNlOCf7ObeOfTgtk?=
 =?us-ascii?Q?qD899NYpSVyv9GADMiO2yuva9LxbSrCGkOq6JNeD8VwBTsXB0P4X2zuutSmq?=
 =?us-ascii?Q?iivAKfGQCGL8S+5XcFi4vDFiROqWRO1m7k6fzhZCLE5rzWjDkb4bq1grI10u?=
 =?us-ascii?Q?wt7O+XfeDWanyiRa2VOq4hGd3oRinXwb+6hZBkd68qOyvimP5ChWk6t5Rbkr?=
 =?us-ascii?Q?dtdlZ637V4Ut0VtEgQG6t3sPuYycky+oUda+Q2ooI5w1vQ2h9v1AT5seGUaA?=
 =?us-ascii?Q?t2uxkmqW62YQRA8Sah3c9llAXKHTJ9Y9dxxLT7NaAGPJv/vn5GjkFasu3gSu?=
 =?us-ascii?Q?psQbLc26Ok9dB67p8pfueYIVPe5zvjsEQDN8W68XkpJK8PxbAC19jFvNOPe8?=
 =?us-ascii?Q?CjGPR7B4uQM26jzFrkvnhJnY62QzjQDsFqp9JVYQLvbalXH9y25xFud/KCKh?=
 =?us-ascii?Q?/f7sdJjwG0wBcjLz0DfThbufo/ZnwAZ7sZD+7aX+fOrkmzua+qUKpwys0D+/?=
 =?us-ascii?Q?E0GrB9glCWMIgoCfREtBWaex3UszUyTHANPmGsifYz9sxKhsrW4InrRl3npa?=
 =?us-ascii?Q?ns+YRMB1opsTBsRReXG+Tc1QCvTmFZRGLqR/mDERPnwcxiJfvhqfAljuLt4d?=
 =?us-ascii?Q?MEXZhKS8EkYpIPjYwoIwHsn64h7ulMRz6pQvQdmGYIMbpeXsvziCLm0QBgqM?=
 =?us-ascii?Q?0Noj5jYSGzE9pFPn5+iBCGwgdngwE3BI32MSxMAhwlx1lz/yN3CvCVqISSWt?=
 =?us-ascii?Q?L3/+PpGkC5VYh480RTEAXrCWctzgX7o/dkf9bjxWt94MwJHRrglRTt4728at?=
 =?us-ascii?Q?omdQAA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba96e02a-f7c6-4329-e81e-08dbe01e1d0a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 05:46:54.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNxKOGn8cZ1Z34lSEGQFiN/5prC9zELpymteq2GqNwkd0AOaCYOCsuDUL4Asn28Ln4oiQEwTvwBLS4Xv+/6kMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

Implement wrange32_add() that takes two wrange32 and compute a new wrange32
that contains all possible combinations of sums produced by adding values in
the two wrange32.

This is done by adding start and end of both wrange32 for the majority of
cases, and works even when the addition overflows. However, there still exist
cases where the addition of two wrange32 result in a range that is too large to
track, this happens when the combined length is too large. When this happens we
fallback to start=U32_MIN and end=U32_MAX.
(Calling end-minus-start as "length" because one can visual wrange32 as
a number line, and thus end point minus starting point would naturally
be the length of such line)

Additionally, make sure wrange.c gets compilation checked, and add
wrange_add.py that models and check wrange32_add().

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/wrange.h                        |  2 +
 kernel/bpf/Makefile                           |  3 +-
 kernel/bpf/wrange.c                           | 17 +++++
 tools/testing/selftests/bpf/formal/wrange.py  |  4 +
 .../selftests/bpf/formal/wrange_add.py        | 73 +++++++++++++++++++
 5 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/wrange.c
 create mode 100755 tools/testing/selftests/bpf/formal/wrange_add.py

diff --git a/include/linux/wrange.h b/include/linux/wrange.h
index 876e260017fe..0c4a8affd877 100644
--- a/include/linux/wrange.h
+++ b/include/linux/wrange.h
@@ -11,6 +11,8 @@ struct wrange32 {
 	u32 end;
 };
 
+struct wrange32 wrange32_add(struct wrange32 a, struct wrange32 b);
+
 static inline bool wrange32_uwrapping(struct wrange32 a) {
 	return a.end < a.start;
 }
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..f0a4ce21e2ff 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,8 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
+# At least make sure wrange.c compiles
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o wrange.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
diff --git a/kernel/bpf/wrange.c b/kernel/bpf/wrange.c
new file mode 100644
index 000000000000..8cdbc21a51f2
--- /dev/null
+++ b/kernel/bpf/wrange.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/wrange.h>
+
+#define WRANGE32(_s, _e) ((struct wrange32) {.start = _s, .end = _e})
+
+struct wrange32 wrange32_add(struct wrange32 a, struct wrange32 b)
+{
+	u32 a_len = a.end - a.start;
+	u32 b_len = b.end - b.start;
+	u32 new_len = a_len + b_len;
+
+	/* the new start/end pair goes full circle, so any value is possible */
+	if (new_len < a_len || new_len < b_len)
+		return WRANGE32(U32_MIN, U32_MAX);
+	else
+		return WRANGE32(a.start + b.start, a.end + b.end);
+}
diff --git a/tools/testing/selftests/bpf/formal/wrange.py b/tools/testing/selftests/bpf/formal/wrange.py
index 825d79c6570f..c659cfd3a52c 100755
--- a/tools/testing/selftests/bpf/formal/wrange.py
+++ b/tools/testing/selftests/bpf/formal/wrange.py
@@ -24,6 +24,10 @@ class Wrange(abc.ABC):
         # allow end < start, so any start/end combination is valid
         return BoolVal(True)
 
+    @property
+    def length(self):
+        return self.end - self.start
+
     @property
     def uwrapping(self):
         # unsigned comparison, (u32)end < (u32)start
diff --git a/tools/testing/selftests/bpf/formal/wrange_add.py b/tools/testing/selftests/bpf/formal/wrange_add.py
new file mode 100755
index 000000000000..43d035383fe4
--- /dev/null
+++ b/tools/testing/selftests/bpf/formal/wrange_add.py
@@ -0,0 +1,73 @@
+#!/usr/bin/env python3
+from z3 import *
+from wrange import *
+
+
+def wrange_add(a: Wrange, b: Wrange):
+    wrange_class = type(a)
+    assert(a.SIZE == b.SIZE)
+
+    new_length = a.length + b.length
+    too_wide = Or(ULT(new_length, a.length), ULT(new_length, b.length))
+    new_start = If(too_wide, BitVecVal(0, a.SIZE), a.start + b.start)
+    new_end = If(too_wide, BitVecVal(2**a.SIZE-1, a.SIZE), a.end + b.end)
+    return wrange_class(f'{a.name} + {b.name}', new_start, new_end)
+
+
+def main():
+    x = BitVec32('x')
+    w = wrange_add(
+        # {1, 2, 3}
+        Wrange32('w1', start=BitVecVal32(1), end=BitVecVal32(3)),
+        # + {0}
+        Wrange32('w2', start=BitVecVal32(0), end=BitVecVal32(0)),
+    )   # = {1, 2, 3}
+    print('Checking {1, 2, 3} + {0} = {1, 2, 3}')
+    prove(               # 1 <= x <= 3
+        w.contains(x) == And(BitVecVal32(1) <= x, x <= BitVecVal32(3)),
+    )
+
+    w = wrange_add(
+        # {-1}
+        Wrange32('w1', start=BitVecVal32(-1), end=BitVecVal32(-1)),
+        # + {0, 1, 2}
+        Wrange32('w2', start=BitVecVal32(0), end=BitVecVal32(2)),
+    )   # = {-1, 0, 1}
+    print('\nChecking {-1} + {0, 1, 2} = {-1, 0, 1}')
+    prove(               # -1 <= x <= 1
+        w.contains(x) == And(BitVecVal32(-1) <= x, x <= BitVecVal32(1)),
+    )
+
+    # A general check to make sure wrange_add() is sound
+    x = BitVec32('x')
+    y = BitVec32('y')
+    w1 = Wrange32('w1')
+    w2 = Wrange32('w2')
+    w = wrange_add(w1, w2)
+    premise = And(
+        w1.wellformed(),
+        w2.wellformed(),
+        w1.contains(x),
+        w2.contains(y),
+    )
+    # Suppose we have a wrange32 called w1 that contains the 32-bit integer x
+    # (where x can be any possible value contained inside w1), and another
+    # wrange32 called w2 that similarly contains 32-bit integer y.
+    #
+    # The sum of w1 and w2 calculated from wrange_add(w1, w2), called w, should
+    # _always_ contains the sum of x and y, no matter what.
+    print('\nChecking that if w1.contains(x) and w2.contains(y), then wrange32_add(w1, w2).contains(x+y)')
+    print('(note: this may take awhile)')
+    prove(
+        Implies(
+            premise,
+            And(
+                w.contains(x + y),
+                w.wellformed(),
+            ),
+        )
+    )
+
+
+if __name__ == '__main__':
+    main()
-- 
2.42.0


