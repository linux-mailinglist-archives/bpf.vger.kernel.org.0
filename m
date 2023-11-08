Return-Path: <bpf+bounces-14463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A47E5023
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57215281570
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9CC8FD;
	Wed,  8 Nov 2023 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OMKoHYEi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1FC8C4
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:47:05 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAF21706
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2B37/zN4W810wIeKSsKQbAMqMiaRkf6g+upv7DDIup+1PPg/zZz0cBlTwJsy1Ss3OKiCFOPJGkwgI+dSZ9N17KHGfTY9UIdTr/hGqStzwMoaMJmO7WmR9F1XCDW4TtALzcEl5R0QudP5R/hcKDNH8aNIr2UJrj/W9LDyCNBIu1lEN87N824HgcKDtN42C12LOM3687FBxPw3A+LaHswje+plLHzjfAWMMdz+3tHoGVmGT7VRxuh/8VM9WDr8ObzIKVytds3ex6sLydpxFFpKfQzkwcfCKecc+furCbs+TTQWcG6aIchG5yKPZdk/dsP+MGlbHfqk2ro43VL3L+Byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lsfco474x3kUiChppMI9jct3gpEcWVJg9mU/CsFJUCI=;
 b=IS+USkuZKh+x7QTERKrrxWxlahAYJkp+WB2WlzC394uViAiaNDvQ9gsOpzoJk4hB6U85PwLqgIdIl1kYduTQQPcItDaHJeHrjKAi9lgF+INM/FgD6br/AYiVOdqRnAYAz3xVL5nxJeZvcleBv90Xc9q4xMqc6YC8gH9j4gHyPzkvMt4QM7YibsvEeKC+ImUCf4TAu3nvzwqeRVKYqgxCzUTewjafGHzT9PGUA3xA8Lb+T/du9k3UOigaDSCx12Ov8mv1RyArX40xg49Ekri4Pcm5yHmuoPDImS6MKmk/cRVov+2ftHsQlF4pgGNUsOleghjzRk/+iKyk2ijir3wgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lsfco474x3kUiChppMI9jct3gpEcWVJg9mU/CsFJUCI=;
 b=OMKoHYEiQ/aGxtQUaX9VtUnAjxzAs905gnAuolD1LMeHTxs941bIeGu0MHg8BUlrZe43aLIU7YQWT47A7MZoqcS/wxGLUkbjXkEr01BdByvTfK6AAZmOcv/Xu0l16xDr6ErVwutmXVYtY2AHRHoUGCKBWTjTruTCiIj23+HhjmZqIWxtIAsTXBBTyWqGSc45kw/lB73sKtda67BFjlO9MRyVzpc+S7pruAGYDxAKuTgaXGf6SjlPI03yNQY0Xq9WRqTrkz+xwJxiOPCvaMx7blRE/y77x1fu8BzoxuUIFHZQ2ySj/Lj07CoWvVMLPz6jk6M486Or161ptw/97A+hFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB7816.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 05:47:02 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 05:47:01 +0000
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
Subject: [RFC bpf-next v0 5/7] Implement wrange32_sub()
Date: Wed,  8 Nov 2023 13:46:09 +0800
Message-ID: <20231108054611.19531-6-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108054611.19531-1-shung-hsi.yu@suse.com>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0326.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::10) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c9fdfd-0452-4d6a-e0f3-08dbe01e214e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h8D8MrxeaPpq0sWmmVYZ97Q0PYVqbQBnOpO9/K+8Nj/KHRCdQ5IF1zVKOB70az0Xy9d98sv+f1y86icC7UsO7LHpA8BurY6tuTFkHCiE3a+CIcRvPlWdxghbL9IBVpY/Gw66Py9DBGTI+RmWdLcBwv6e8htqWGKq9bOFfqYEztCsQDgNdjOXdooMNbD4xeC92+iZdQCz2aya0f/1ecmqTHDRVUYCw6j142Wx7KTS+3gv8B4rlKVtjOeHc1XBvmVcwVxqRQ9oXfeO0EGa/8bG8Ao5q71DFI9vepBPnrcqrgZUUcOw6mxH22Eg+Edu4oshkQcPLo8eKQPDNMWr2DDWAJFrJsxlVBBuUlcHEySmfWbNBqmkm6gVMXMCnRLdgFYxzZplHatf1zMHtKCLvkDlUxtTYPiM8zItIgH7wAVOQcBRi8ZTH3Uuf6nAgHIeXBAQBE3tPdfnEI2CqCi1walBdrbBh7bj8vMKaRVj3HIMDfixgca0qLhUHu7IvEB70p1ZQZmSlTzrnFjleJTqfBA5/b3hh6kiSYkMDsvdPdCRnUP4fWMEFIUGqyihhX/Ga1LT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(5660300002)(8936002)(6916009)(4326008)(8676002)(6486002)(6506007)(316002)(54906003)(66556008)(66476007)(36756003)(38100700002)(41300700001)(2906002)(86362001)(66946007)(2616005)(1076003)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XEYbaUTpU2H7gwBPrwDeY0R02xjZqOzN9KkZlYDFARjkUP9Wp90TaZoP8ia3?=
 =?us-ascii?Q?zWauKwci8z28CrYVyRI0Rlcsn/9mUPi1Xcx0wIXRuOc7LvmKuYlUnyt+tI/s?=
 =?us-ascii?Q?ixyv0tQZBYiv9ocqsLzSAEppTvpzuUrR2/w9fXCqaRPgbvyy8xgzLqFl7vrm?=
 =?us-ascii?Q?NBN0MTFPV+855R+LV+Ks8RkLkDqDKpJG5rDR858PYMdY6Aafsj75CwlQVPny?=
 =?us-ascii?Q?SPYO2TC6DzOU4rx9CkYMOcNsKAyvGYWpc+wlZw5b5MA8XX0soHwIrumiYhV6?=
 =?us-ascii?Q?QqVf/ye3Cu5GHGG+qtI1yuyZXbwUXfAN/7Zde3RrSrxdxj9bMmU/6DUbrvsM?=
 =?us-ascii?Q?J7q+JZoif0EZOmycoMKVumQFMjO5XNXEJMXcBp7gdIZlRw2Hpw1eQlY8vRY9?=
 =?us-ascii?Q?wr5cc5qFRI/JcItts1xSTRhJDz3dYqs30T/zzmfGkH/M9pTnyE6Qe4wt3Gj+?=
 =?us-ascii?Q?2mnIMmGVxlR8eUUlRmQgvh7fKoGbI6yeHFKhBBCuUfjCEeT3X1FiYaalN0Y1?=
 =?us-ascii?Q?bsm4Tmgd5Ozi+lWZhKvoL1o4QaVddLUFcsRy2wlWrYZc/zMu2CQrURWWhx36?=
 =?us-ascii?Q?k4LeYNqJVwp5euaUDB+W0pZz0666EZeBz9IUxw/e9yKl7HtwvBCZ2pwjQqK2?=
 =?us-ascii?Q?pe7fbtpWrucZoCH7+qNZ/eGE3CVpHskVHOcbMc98TxWR11GnwG+D45tKm0qP?=
 =?us-ascii?Q?/nX6Vseh4H88KBzWSVr8Ncm/v9Nwicaz5YeZlXP2Xt4V1crCdjaRlmIodV49?=
 =?us-ascii?Q?0sm9Ye3NBj40vv3MszWTYqlRDL4OELiuQl4BEKG/x20byWGFzVw9CbqEHtX5?=
 =?us-ascii?Q?wjbDMk/qAr0CdLl7+iSotw1tm2EtsYrYKFVoh0W20GIRyXhVh/7mKPzWr7eW?=
 =?us-ascii?Q?7Y4UMyzmfEmboniH8g5RkwCGe5ORfSilIJGaT3SfDLohIZ90SjpS+wVUIZRd?=
 =?us-ascii?Q?CaJgzQT+Hc+YJnmX0+a8Y5Qw8QliPOo2qzQOW/eq2sv5Tuqu+WLAzbx99q64?=
 =?us-ascii?Q?Tdsw5OmOzJ4/xQtt2EvlzfbEI22zPTj+kL6f/dcm5EVQSqHGO7ANLK60BuHg?=
 =?us-ascii?Q?7l4+PDUaFjjBbbEcpvx52mZB7BZbA68bj9u0Ww97Jk14i5kO6ewp1r4FJ5cN?=
 =?us-ascii?Q?xQqE3Uu9VF0pDiIuFCfbkR6/GrsNL5qmllO+7ckoQYzO5JUOm9uFIUJd1QG5?=
 =?us-ascii?Q?tgNzut7m3f0gcRhowKMJHt7xx16uKajDRdOsZJbSNVgnG81ENd8oaoQ3YLh7?=
 =?us-ascii?Q?Mlg9nbXG+4ZRCCM/IsRUflzF5O/VDoV6/39G20vNe6KVh7XjFtv9N15JnaQm?=
 =?us-ascii?Q?UnWH/RZ/hCnuQXJAWZE5cEPKJw3nPlnE5+Xe7WIE13rWOlE0RwpfxdRSZ4iB?=
 =?us-ascii?Q?s4oBs5lNT7s1MfascI3C8L21Z7dQDjB4dWYuZEMNSJodh1+3ypPg2jtf7QMx?=
 =?us-ascii?Q?tz6GxxFWyhNksvCn3/VD3UxrMly9jkcQxpXsP8R6oQifdYLzuqhHb1+8Kv1J?=
 =?us-ascii?Q?KU5jZ1dYZ93qCUXZ+INCTmTKJ2LndEGrNk2iK+vbJsmYYHMxBdAijdBBgd8y?=
 =?us-ascii?Q?dYYoS/p4Jf8QbvZFTjVZ6ALWtNU8xlT/1WZYoM9UsGvGHGRSCOst2aqbO3Kq?=
 =?us-ascii?Q?AXfyz1g8w8kcLZYWZD48He0p01lueQZ9j5ybe32oAjJyN0gw1kUqJanSDyjB?=
 =?us-ascii?Q?CClCTQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c9fdfd-0452-4d6a-e0f3-08dbe01e214e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 05:47:01.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mPa9wms9J41LG5XHCeAusvdjgLugQysjazxtGMFsgi5oqGNbQ72Mjp6nCtul9Y4KU+5h9KKz+IN54rBirJVXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7816

Implement wrange32_sub() that takes two wrange32 and compute a new
wrange32 that contains all possible combinations of difference produced
by subtracting values in the two wrange32. Simliar to wrange32_add(),
the implementation can work even when underflow occurs, but when the
resulting length is too large to track we again fallback to
start=U32_MIN and end=U32_MAX.

Also add wrange_sub.py that models and check wrange32_sub().

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/wrange.h                        |  1 +
 kernel/bpf/wrange.c                           | 13 ++++
 .../selftests/bpf/formal/wrange_sub.py        | 72 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/formal/wrange_sub.py

diff --git a/include/linux/wrange.h b/include/linux/wrange.h
index 0c4a8affd877..ef02f5b06705 100644
--- a/include/linux/wrange.h
+++ b/include/linux/wrange.h
@@ -12,6 +12,7 @@ struct wrange32 {
 };
 
 struct wrange32 wrange32_add(struct wrange32 a, struct wrange32 b);
+struct wrange32 wrange32_sub(struct wrange32 a, struct wrange32 b);
 
 static inline bool wrange32_uwrapping(struct wrange32 a) {
 	return a.end < a.start;
diff --git a/kernel/bpf/wrange.c b/kernel/bpf/wrange.c
index 8cdbc21a51f2..08bb7e129d7f 100644
--- a/kernel/bpf/wrange.c
+++ b/kernel/bpf/wrange.c
@@ -15,3 +15,16 @@ struct wrange32 wrange32_add(struct wrange32 a, struct wrange32 b)
 	else
 		return WRANGE32(a.start + b.start, a.end + b.end);
 }
+
+struct wrange32 wrange32_sub(struct wrange32 a, struct wrange32 b)
+{
+	u32 a_len = a.end - a.start;
+	u32 b_len = b.end - b.start;
+	u32 new_len = a_len + b_len;
+
+	/* the new start/end pair goes full circle, so any value is possible */
+	if (new_len < a_len || new_len < b_len)
+		return WRANGE32(U32_MIN, U32_MAX);
+	else
+		return WRANGE32(a.start - b.end, a.end - b.start);
+}
diff --git a/tools/testing/selftests/bpf/formal/wrange_sub.py b/tools/testing/selftests/bpf/formal/wrange_sub.py
new file mode 100755
index 000000000000..63abf4d2d978
--- /dev/null
+++ b/tools/testing/selftests/bpf/formal/wrange_sub.py
@@ -0,0 +1,72 @@
+#!/usr/bin/env python3
+from z3 import *
+from wrange import *
+
+
+def wrange_sub(a: Wrange, b: Wrange):
+    wrange_class = type(a)
+    assert(a.SIZE == b.SIZE)
+
+    new_length = a.length + b.length
+    too_wide = Or(ULT(new_length, a.length), ULT(new_length, b.length))
+    new_start = If(too_wide, BitVecVal(0, a.SIZE), a.start - b.end)
+    new_end = If(too_wide, BitVecVal(2**a.SIZE-1, a.SIZE), a.end - b.start)
+    return wrange_class(f'{a.name} - {b.name}', new_start, new_end)
+
+
+def main():
+    x = BitVec32('x')
+    w = wrange_sub(
+        # {1, 2, 3}
+        Wrange32('w1', start=BitVecVal32(1), end=BitVecVal32(3)),
+        # - {0}
+        Wrange32('w2', start=BitVecVal32(0), end=BitVecVal32(0)),
+    )   # = {1, 2, 3}
+    print('Checking {1, 2, 3} - {0} = {1, 2, 3}')
+    prove(               # 1 <= x <= 3
+        w.contains(x) == And(1 <= x, x <= 3)
+    )
+
+    w = wrange_sub(
+        # {-1}
+        Wrange32('w1', start=BitVecVal32(-1), end=BitVecVal32(-1)),
+        # - {0, 1, 2}
+        Wrange32('w2', start=BitVecVal32(0), end=BitVecVal32(2)),
+    )   # = {-3, -2, -1}
+    print('\nChecking {-1} - {0, 1, 2} = {-3, -2, -1}')
+    prove(               # -3 <= x <= -1
+        w.contains(x) == And(-3 <= x, x <= -1),
+    )
+
+    # A general check to make sure wrange_sub() is sound
+    w1 = Wrange32('w1')
+    w2 = Wrange32('w2')
+    w = wrange_sub(w1, w2)
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
+    # The difference of w1 and w2 calculated from wrange_sub(w1, w2), called w,
+    # should _always_ contains the difference of x and y, no matter what.
+    print('\nChecking that if w1.contains(x) and w2.contains(y), then wrange32_sub(w1, w2).contains(x-y)')
+    print('(note: this may take awhile)')
+    prove(
+        Implies(
+            premise,
+            And(
+                w.contains(x - y),
+                w.wellformed(),
+            ),
+        )
+    )
+
+if __name__ == '__main__':
+    main()
-- 
2.42.0


