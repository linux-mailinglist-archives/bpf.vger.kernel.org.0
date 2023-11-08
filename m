Return-Path: <bpf+bounces-14464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4C07E5025
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38B3281570
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7932AC8D2;
	Wed,  8 Nov 2023 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tm3iYhoj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41152C8C4
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:47:13 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9A1705
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBJgpAu9TblZkZm0xmyfDPdhWwuWzn+2fvSMkeq5CawV4gfuvZe2Q+ox8o63cVcZfj7upR4jjHpEqnPOAdJDG0jDSxyJnsXgrO2YlawBIX0N7OsCNZ14A1X5QrKRt0KFPT/CWFmkfJmv1fqz6n5QPGJf08618HrvtPQ+agZZR2rKetuiyxUFQ54Dh3KBXme0POvr29iNnLnYDWOjLr/ADwbuWIprMeU8mAxRUCHUXlXVyeDY+/nFKIrkerY3ZXIEktpk4WKvsP+CjDuD8edDcWxRlNRHHsTWNMOCyZI/grVOVYp+ILra1+Pdp4dsEuX74vW1iBmSfJnGsIq43VNT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEKVkmo0HtSvymnUIurAsIDgeD6uS36PG7052MbNEiM=;
 b=C+afbIeffNTsHpniNdUT5vspuPXVjyU7RLs4MgpfVx9ahFHCYY2RRA++wWWjdwsOfEKLgb1F/3NvZ3+yAGinAWEG78qbqgTfHInuhUyzPfmKmu2jMmUIcKFEJfC7dM4QVS0OF2Z4aaZcz+iyPRucelqJgZQeIvpo2sTyO5E7slr6U3qyP6Hmtrvyn7CieC5eQ3Ujo4h07irZghf2fVAY4fv6ZnjWa40Usaen9PIFX3+VQKpCRD7z78dwb/7og3BklJwe38qMJkK0N78Kh3lKz1LPP7xUaP38wlaY3wCKG56WsaK8lyltTAmut2iNCaqkl1SPwfGix275T9PS4csDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEKVkmo0HtSvymnUIurAsIDgeD6uS36PG7052MbNEiM=;
 b=tm3iYhojjv5vlJZL/HkV7h3+6g9QPabA1vzb9JoxVI/WG0r1h1yR6WsewZoLxUBf310U+LXM7HQW5Ml/30lQ+JyRb1209LOST44nlHGnG6myseImuV4FrmXjr5jHeqdYP/9l5VR0eIOyvrlGgSMkbfnf8dekD+7YKOqU9ye/SdLxl4aDf0bx1CyBZ4nLGWojMtlXlxmuiLF9hsDlQ0LEVR4vNRdIGQ+SPUYqERiYxKvxAv22+5fCEjqDgLkOe5gecBHl5I8e+AwovipRtAPSzMuC7g131G9BKP8rMlWXEaQJ0sCXeGRaixn+GDGsQUG16nFJakmvSzlPJ66RNwaMcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB7816.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 05:47:10 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 05:47:10 +0000
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
Subject: [RFC bpf-next v0 6/7] Implement wrange32_mul()
Date: Wed,  8 Nov 2023 13:46:10 +0800
Message-ID: <20231108054611.19531-7-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108054611.19531-1-shung-hsi.yu@suse.com>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0328.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::17) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5c92c1-b7a6-4aac-47db-08dbe01e2643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q8ZXsG8w9uOyMU161dfkDmuV6MMqM9TkxT2JOH70j7424C0wuoEHmvCrIkJa65/sx/NNdHp8b+JDRnv+h78qZn78YoaZGxezcauC/Rkej8Ha5oBrMSovKgPjjnpK8SMj2V6KUVRM/8fC1YUesMDePGlxzpo61kjbc4aLnAQ/OOuSdZqXbm3/401GPfu1sbbueBApSDX9y5c7OCTA86ZEBHKpR0wvyGaU390CTnXjsPm4mnmq/Dz9/JUS1KpishJ/oCYK6NeOoZeXU31ajvYMJWGdSBKXSfRtrTlP0LyrRbNGi+xe+umH18XShyGQBq/1Fbpwsfc8vH1wvOuCiL43g7YOE37oceZ7ySEUsKE2BqQF9Sp7HW0arB1uexWYpzzri+/9wpmGje12F4WFaQby6Po8TRz0Xsn/vKEbmmJzXViRl30j+GxBgxY5p6rjPXm22F7UEuVT2Kn0i/zJChXS6e9qgnwWebHGKcs/b9pR2qvUOkWR7JfIk3l7xYR3WCyZdmuzoqAWmDkoRMvu/iGG18XAfX70Oit5NeHw4MZ8ICnxiWeRCFcE130ezRTqlU3m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(5660300002)(8936002)(6916009)(4326008)(8676002)(6486002)(6506007)(316002)(54906003)(66556008)(66476007)(36756003)(38100700002)(41300700001)(2906002)(86362001)(66946007)(66899024)(2616005)(1076003)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ySOzL4kTawpznIOVad7eoEHmZK6UZpAKbmXzzP1wz5o79UaDiKd9yvH+S/nm?=
 =?us-ascii?Q?eq2KT0nHQ/3FLaQzX12fYrZPzW7tmR+CQxrOcMQt0BB9QZ1jZcQOeXT/RJOd?=
 =?us-ascii?Q?46s9Xo2VV5phHMFB1Eo4eHSmwjWUUq6DRBNeZJWO8B1qSyRbD9i5Ly9mlxyb?=
 =?us-ascii?Q?4FWqn0ACrsSr5Ybc8MGQ88igp70tks5IanQ+gkYCLcG54Wj2Z2FFFh+OZff2?=
 =?us-ascii?Q?ZOw+y+vNp5yYb+HrROEf6C+0TBA4NHqgzA5bB2NNjQaOt016XTHQosLF1bvn?=
 =?us-ascii?Q?zf4Cq9d4mTsjDttZxGwKiXRrNyZ8UStajmEhzsvdqY30AzJHXYuC4Do3+Jam?=
 =?us-ascii?Q?wRkyVHvKI4G7ocZ1eEP4JvBHtoP/dMe6ECtwl1y3Ljt6u3m4oDRWezuWudMC?=
 =?us-ascii?Q?rMABw4NSNq8LANmXaoHAJNvk2pjy5y5RwPgMjjiecM/kkDLRaV26X+qD/xXx?=
 =?us-ascii?Q?KpmfVC00NXu+cyUlZ8fm5rdn1GWAHDlYynbbSjymRJGwojruLOEajI4lw+fB?=
 =?us-ascii?Q?jete26K1z0b9MdcwTmQV81qqggcj52PYwkI730wIN8BrfnJ8fFi9P/HzmQY8?=
 =?us-ascii?Q?5h7ymq0rZ8YGC3R///5Nzv9m8xA1dgK9XWrrOLNrUlEkTrQDoywAEMe9dKzq?=
 =?us-ascii?Q?o44fN1vWdC1BBG/lduQn60MIx+pMCXfOc4B9kSTLryP0UyMZkphyzwPb+vWi?=
 =?us-ascii?Q?cu/X6aJ0ovQRcFjrvfkNxhMQRuFmzTBmQi/wE2dFj7VZC3DgYScueGgzPdcS?=
 =?us-ascii?Q?uJjYibkqp/czdmut9pwYcYEFuQTQ4MFZ00Qvqr5O7MJdm4eeWwz900rmu2k6?=
 =?us-ascii?Q?ihHd4w6P9DEB3oc4INgbmyfM27KgqMJyZ7n+oD+JjfZhZNTgcoeADpUtdH4H?=
 =?us-ascii?Q?Ly8FO4kFIOAsdWxaEU822EE8UIRmN3UQJcDyUjOaensGVm5eknVbjKPpbRel?=
 =?us-ascii?Q?xZ7PNRGXGh5EFF7K0zxMgz3qiG3fFciljkTmMevMBrK2AcjiRv4xXGI4jI5T?=
 =?us-ascii?Q?7Ne/40jjP+SJpZBD2mScHD5hvc9dnNUxqppUsWDWnsddtoYAaFeFbPU23wCL?=
 =?us-ascii?Q?uFpcZhWyw8fYDv46t90w1d/c/0xUAwOnM2VIKcFLnJcZ36npmguPk636b1O8?=
 =?us-ascii?Q?gxCeq5Q/9NJpqJ90DBdsuisbVEgitHDPxyIfiyB3NpkdL7cgu9RJnrrOYX53?=
 =?us-ascii?Q?bCEDjdT3rN2OXR1tbT4aq7aAGLWtWfQGFmgF+EmnDR2vrBDsiIAaS3i/QdXy?=
 =?us-ascii?Q?Tdf7tiSlCtQplVvvaHYIgGK8OQQOo4V47A1GtdQHSjHc0ESXAk4xxjMmaOcH?=
 =?us-ascii?Q?WaO+QplMnqdEt30ABGVCO2MX45viApDZLb7txpGgi51w2nWp23JlJ9EsLt4d?=
 =?us-ascii?Q?9jcf+afoWEjZmLaFTt0Lsf5wS7jHJj93IH0F1aQlQllAYknZAKKie25fAKPQ?=
 =?us-ascii?Q?MzSrupOpdrGnqY38Tmy5gvNrZjG7uPXw7Zca47gL2jxD7j+2LzH3Pdkhx84X?=
 =?us-ascii?Q?fDOLgfwT/jR/UJi/wSK0pykAVcc1NOvz7Va9N2AnTQKv4gblQy9/OmaYl8QV?=
 =?us-ascii?Q?EAwlmdlmGDdQMjU/z/RidAcwNVRcfMIGGUV8PhadZgAyl3mnRaqL0tQ7J0Ue?=
 =?us-ascii?Q?oTvtRMUk7AsS8gyxlWvXwywutByN0qriuLB/0ecaPWJgaND5IPfxfsYsBD4g?=
 =?us-ascii?Q?1QHEdQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5c92c1-b7a6-4aac-47db-08dbe01e2643
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 05:47:10.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnygnIVuLGS1LiPKF1lLb6D4PWkyCLwtQUE5EOcZI4Pb4O7THUArNF2BDM5urjI0wauqb2aH+nM811VOC+Hsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7816

Implement wrange32_mul() that takes two wrange32 and compute a new
wrange32 that contains all possible combinations of product produced by
multiplying values in the two wrange32. This implementation is pretty
much the unsigned version of scalar32_min_max_mul(), and does not take
full advantage of unification. This can be further improved if needed.

Also add wrange_mul.py that models and check wrange32_mul(). However at
the time of writing this model checking for wrange32_mul is still
on-going.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/wrange.h                        |  1 +
 kernel/bpf/wrange.c                           | 15 ++++
 .../selftests/bpf/formal/wrange_mul.py        | 87 +++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/formal/wrange_mul.py

diff --git a/include/linux/wrange.h b/include/linux/wrange.h
index ef02f5b06705..45d3db3f518b 100644
--- a/include/linux/wrange.h
+++ b/include/linux/wrange.h
@@ -13,6 +13,7 @@ struct wrange32 {
 
 struct wrange32 wrange32_add(struct wrange32 a, struct wrange32 b);
 struct wrange32 wrange32_sub(struct wrange32 a, struct wrange32 b);
+struct wrange32 wrange32_mul(struct wrange32 a, struct wrange32 b);
 
 static inline bool wrange32_uwrapping(struct wrange32 a) {
 	return a.end < a.start;
diff --git a/kernel/bpf/wrange.c b/kernel/bpf/wrange.c
index 08bb7e129d7f..4ca253e55743 100644
--- a/kernel/bpf/wrange.c
+++ b/kernel/bpf/wrange.c
@@ -28,3 +28,18 @@ struct wrange32 wrange32_sub(struct wrange32 a, struct wrange32 b)
 	else
 		return WRANGE32(a.start - b.end, a.end - b.start);
 }
+
+/* Model checking is still on-going for wrange32_mul() */
+struct wrange32 wrange32_mul(struct wrange32 a, struct wrange32 b)
+{
+	/* Be lazy and don't deal with wrange that contains large value that
+	 * may overflow as well as wrange32 with negative number. This can be
+	 * improved if needed.
+	 */
+	if (a.end > U16_MAX || b.end > U16_MAX)
+		return WRANGE32(U32_MIN, U32_MAX);
+	else if (wrange32_smin(a) < 0 || wrange32_smin(b) < 0)
+		return WRANGE32(U32_MIN, U32_MAX);
+	else
+		return WRANGE32(a.start - b.end, a.end - b.start);
+}
diff --git a/tools/testing/selftests/bpf/formal/wrange_mul.py b/tools/testing/selftests/bpf/formal/wrange_mul.py
new file mode 100755
index 000000000000..bd95fc6367b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/formal/wrange_mul.py
@@ -0,0 +1,87 @@
+#!/usr/bin/env python3
+from z3 import *
+from wrange import *
+
+
+# This could be further improved if needed
+def wrange_mul(a: Wrange, b: Wrange):
+    wrange_class = type(a)
+    assert(a.SIZE == b.SIZE)
+
+    too_large = Or(UGT(a.end, BitVecVal(2**(a.SIZE/2)-1, bv=a.SIZE)), UGT(b.end, BitVecVal(2**(b.SIZE/2)-1, bv=b.SIZE)))
+    negative = Or(a.smin < 0, b.smin < 0)
+    giveup = Or(too_large, negative)
+    new_start = If(giveup, BitVecVal(0, a.SIZE), a.start * b.start)
+    new_end = If(giveup, BitVecVal(-1, a.SIZE), a.end * b.end)
+    return wrange_class(f'{a.name} * {b.name}', new_start, new_end)
+
+
+def main():
+    x = BitVec32('x')
+    w = wrange_mul(
+        # {1, 2, 3}
+        Wrange32('w1', start=BitVecVal32(1), end=BitVecVal32(3)),
+        # - {0}
+        Wrange32('w2', start=BitVecVal32(0), end=BitVecVal32(0)),
+    )   # = {0}
+    print('Checking {1, 2, 3} * {0} = {0}')
+    prove(               #x can only be 0
+        w.contains(x) == (x == BitVecVal32(0))
+    )
+
+    w = wrange_mul(
+        # {0xfff0..0xffff}
+        Wrange32('w1', start=BitVecVal32(0xff0), end=BitVecVal32(0xfff)),
+        # - {0xf0..0xff}
+        Wrange32('w2', start=BitVecVal32(0xf0), end=BitVecVal32(0xff)),
+    )   # = {0xeff100..0xfeff01}
+    print('Checking {0xff0..0xfff} * {0xf0..0xff} = {0xef100..0xfef01}')
+    prove(               # 0xef100 <= x <= 0xfef01
+        w.contains(x) == And(ULE(BitVecVal32(0xef100), x), ULE(x, BitVecVal32(0xfef01)))
+    )
+
+    # Multiplication is not implemented when there's negative number, but it
+    # could be made to work
+    w = wrange_mul(
+        # {-1}
+        Wrange32('w1', start=BitVecVal32(-1), end=BitVecVal32(-1)),
+        # * {0, 1, 2}
+        Wrange32('w2', start=BitVecVal32(0), end=BitVecVal32(2)),
+    )   # = {-2, -1, 0}
+    print('\nChecking {-1} * {0, 1, 2} = {S32_MIN..S32_MAX}')
+    prove(
+        w.contains(x) == BoolVal(True),
+    )
+
+    # A general check to make sure wrange_mul() is sound
+    w1 = Wrange32('w1')
+    w2 = Wrange32('w2')
+    w = wrange_mul(w1, w2)
+    x = BitVec32('x')
+    y = BitVec32('y')
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
+    # The product of w1 and w2 calculated from wrange32_mul(w1, w2), called w,
+    # should _always_ contains the product of x and y, no matter what.
+    print('\nChecking that if w1.contains(x) and w2.contains(y), then wrange32_mul(w1, w2).contains(x*y)')
+    print('(note: this takes a very, very, long time to run)')
+    prove(
+        Implies(
+            premise,
+            And(
+                w.contains(x * y),
+                w.wellformed(),
+            ),
+        )
+    )
+
+if __name__ == '__main__':
+    main()
-- 
2.42.0


