Return-Path: <bpf+bounces-14459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DB7E501D
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6B51C20D46
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF0CA58;
	Wed,  8 Nov 2023 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g3fSb1U5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0DCA53
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:46:36 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AE1705
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:46:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAecFQFqxqq5d5D4U5IMcWEN74UQd4Cea0ufDyrrVIQq+pqKymEY496WBomS5hdCH8pzNuhiN/vS7N1isZggd2YfVP+dIY8Asx8QOIxTrOtfnyeLF2Kqe6+/sLAyHTysFgkpsA9NAbz5SmiBDOXYHCX4yvE4YLz7s4sXE+Pm6UJF0dbrwh0FyQBEmnznqKosw2i0Jg4G/SvUHzuJECYYyZ8/uO2/V9VswYzjRmwWzW8cKFhym9zQNyVc2rDi5OxyvxWmncH1fOGaQ1kPd8rYpmqGfwuS+j9LvleBRPiEG+u+Zvo3Iu/8WRz4whrkHAjNzIfwIRXlgaUgwoVd3p0S9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgaCkVBn3tbc1sqI3PQQfarsGRTX0VDCdSUjPFEIu0A=;
 b=FIROwvQpgK/AG0JTVaACVZxxIKZNEeGfL2Qj1nYahfwbsKzj2Az6pea1qUM6Cx8zInl/VOKF+d1XU9ExsjuEA1vccDQAaWxtuhJfVscBb2cIFLL3UtIgGISxqBlo7CFlwQUoej3mk9ntIvkJWRmu/g5EkGSD+woE6eSPl9lfYFUQxRmrlGQzTJ+K9zHFXoOxkeokiYIFLuST68IR0wU5sWIMbxbXOhehWkqb/DbCew8ftkDHvPjdOC2HFWf8uRG1FQasLao38qPKzFg/DHQYVyM3QIzPHgYiH96RfgYMPc24N5vvTGPmWDlYyTwC++jDWsr3aK/P2PyZmVEszyRxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgaCkVBn3tbc1sqI3PQQfarsGRTX0VDCdSUjPFEIu0A=;
 b=g3fSb1U5658K30tW5fzONZ7D33K2iE1sfO1hO5JvdRX4/LfI/yqHl2vEmQIiT+FDfbZjkIqPsvQ7S/mBi7Ebdj0PTxyJ1OuPwZLdNVH++drdN4wApbi99Td8Ww40531unABQBjZnwabDms4pfEqBluLf9wu7v6NEWneKN8ZtShrAPnpNSa6KYrOoSTWXl/gbxQfBdp+9VF6NH+/pA4/CB8xgXHrPIJMXTvuRo3HuTe2gmAUo4dZD6ByC4A6liDo6IC8k2IGgUbHIAnvTsMpVd9d6bSyVeryPLg6FgYivYhpfM83o595oe0e7xfRKPkDqRD+pKpAv0EZmT8BsrjGWjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 05:46:32 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 05:46:30 +0000
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
Subject: [RFC bpf-next v0 1/7] Add inital wrange32 definition along with checks for umin/umax
Date: Wed,  8 Nov 2023 13:46:05 +0800
Message-ID: <20231108054611.19531-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108054611.19531-1-shung-hsi.yu@suse.com>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cba5e4-e019-4a88-3a1b-08dbe01e0e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eCVSR+aGd0hO6QUHngRxePgMNJPQ8QGJeuWBjGCwUqDwh/ye98Wae1KZnMvCPK6XSFraM+EZziUO2JiEw0/8UBimzMLtLK5hH7xuxJk0aFZryiX7FXKkvbi1uq+AW11wkchPdZzFu+yf04r5+hPKAbWcqrU0yyCFNlyIyLBgQbSKwt3M5sVpbQHvcTXlR8eR2pMKpBX9a0h4jnZfQS5SQf5+N64jnckon4yR1XLjoXmuYv+q03KJR7ilcJ8BXbE4AbzAxRfsOakS5j51Aj8Hofl/T3M7zTdocfqukBu4r7DZrKRd85gKqXJ6wEFamFEjQDsVNe1fwwLCRKLQYXWxHDTi4YevqGFI1jbczPaJvwFSvO4T9RzOTwCZeRj2hHpsa05WMwVtSOxe8RSKrlI+6JI2bz/BvItGIuvy+Dbt4Qn8A2Q6jOCJ2FmguitRQqpoy7zDXX78YlYLGPp42Otfz+GzVQ60e6YIZ7MFl/Z6uIrQo9EbEknL+oCfWqL8cQYiqFiYVZtUjPU8C/wHpw1zSMv32wueyCFzn4bepso4BrkPco0loqhLggYZX2gTZceB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6916009)(316002)(54906003)(66476007)(66946007)(66556008)(478600001)(6486002)(6666004)(86362001)(5660300002)(41300700001)(36756003)(2906002)(8936002)(4326008)(8676002)(2616005)(1076003)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Nkw+sSsIo9XUm34ZLSn2o2UJI/0JPCoL3cIvmgtxhya9tGzLc4psLA4EtGd?=
 =?us-ascii?Q?h5G1pt35Wc6hR+45/3OXixMCNJ8Wj/XKiJ0ZfOVq7aS5S0cUa1wXgC+X/gPS?=
 =?us-ascii?Q?CVYHS6Z3c2xBO6B8OXmXbFrF01afj85FbE7kg6nlsSJno2EU9jhbwxYL6aan?=
 =?us-ascii?Q?8ou1QR1CqXhcHb1HmQEwNjBEUsKJ9nj10mLobDPSXB0aNidaBf+/AB6PUE4N?=
 =?us-ascii?Q?2PANcLX625Q/X4hK66MYskINDoK+oaEI4G8ndZNrgFNonqlJiQ4BzHeVcIz5?=
 =?us-ascii?Q?a5z1l7Tx2vpUjHXqicZXA7VA5YLpIydJhqBuzMKi//xB0JUxMf5YQl0zt2Oq?=
 =?us-ascii?Q?P6OQzAVQHY+9CoXFyT3hFYRjJSBeSImtknEceumPvEuAvet0y9+7I3bjOyVP?=
 =?us-ascii?Q?g/L3T6OZoKvGougmuIjA7f1aWPvT0WznPfHi96EXZgIdbfJvf9roZfwyRKk4?=
 =?us-ascii?Q?Fx4CLV5HRryOQv40Jo/cEfLL2Fqo9GVtMrrHhcbO8wnLaRwXu6pWUr1vG8hS?=
 =?us-ascii?Q?z4MMxo5eOCf/MTdpvdHepwLoE9qlOerrSAQ2OFtOP3OR/rB+HpVXg+VviLAl?=
 =?us-ascii?Q?VNSkEMmEOZwuDj7XjAunnBGgU87sJ8xjWCPFoqexv862S4cv4OCBwWw1osVO?=
 =?us-ascii?Q?dMPbC07y1xEUOX/KLFritGoQEWKcgZ8sFDzBAOUWyarrp6q9y4L6LV+d+uKU?=
 =?us-ascii?Q?KdxUWRc10EMxSnVpsW2EduOdkFu7LmhhPCyl/YtCEXuspb2El4BKOT8FjOga?=
 =?us-ascii?Q?dMI7mo0gOC/bKajzDx/V/lm5RCS2zam6M1Suy5Vdv/0+rHeovJMESIie/+8N?=
 =?us-ascii?Q?ae1kvH6mkgsL/gJqSwuBTiCekKlT7GYlqMWvaUf0uLpxXLKj7ExeBjO4y2s3?=
 =?us-ascii?Q?5VKfC6rjAqTRQKHzU8wJbF9k7NBoCnyMZtfFsk4XfmIiNpFT9lity9WtQJ98?=
 =?us-ascii?Q?8PWEp55BIguOfwTvQXSDAwk2tYEsaKX6ge1dIzTbz4c8IKsH0sKn/hNzhteG?=
 =?us-ascii?Q?0nxLxsK7lmbmaEs+zEhVSlrwkuyBuNxHTM+HDCRSFuDAAmlVRo3Mp2lLLGYq?=
 =?us-ascii?Q?L+PvQbPVq8SoI2xIjBeDQ4NInN1I5O3DnxtXkjaX60iq9Ir1FPw1yHGZ3Ptl?=
 =?us-ascii?Q?+P0+Q/klJUzDIIyano/2C7L5QD8E9l8KGEqbBD/RW6QuPTmJicZWMv9WpgIS?=
 =?us-ascii?Q?xRFJ716xNHoVCIfTeFISrDB+XKhoyEHkjAxWmLDKgDtwgvhlo1shKvHOwKb4?=
 =?us-ascii?Q?4s/v3R6ZRGUc3wc4Zlm5+6sY/Tg14yx/e1Gir4O8gaUCZ4ZSy2KLvQY6F04G?=
 =?us-ascii?Q?TO6sgqcmO+z8wrtFKLMkjxesePwaIhuERJniJ6e4SBLRpuTdAIHL2FvkzJJr?=
 =?us-ascii?Q?dPH8Ku1A/s6lFUxH8X2O0UULwc5H1Bxef4OMpOxBShml0cR2a/G9TFx/2rpi?=
 =?us-ascii?Q?uGyVW3pWBELFWe0/b8BBHmZ/ef4gMrTlRtDrPDcE8dE4El6MeC9hE4gyHb3o?=
 =?us-ascii?Q?1ocpIoah7CmwUMYGxvMjtpS0S5m9nfpajTMpVdkMzfNRHvRY4xjAOUeuvLun?=
 =?us-ascii?Q?Sgptr1lJeathHgw+seMxwH/rvLceJ8BrYPpHf+ZYGDdMyJPBamP8s8Yyh02R?=
 =?us-ascii?Q?Q68inpi4UdgsU9kgVc3SfNUFKBLg5KROe08DgCx8zj99/1MNYfHjyBxI36gH?=
 =?us-ascii?Q?gk9diw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cba5e4-e019-4a88-3a1b-08dbe01e0e75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 05:46:30.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWxT4eecBsTK/s0ccXiu1eretsRk5cc1IW9D95xZgKqrEz/knai3UzdyiH3gtm6DvnEdB1kvg2AEIYwUWSAnjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

Add struct wrange32 (short for "32-bit wrapped range") and umin/umax
helpers, the latter simply return start/end at the moment. We call the
fields start and end instead of umin and umax, because later patch will
lift the umin <= umax requirement, so we can have cases where umax <
umin; and continuing to call them umin/umax would be confusing.

A struct wrange32 modeled with z3Py is also attached to show that wrange32 in
its current form work as intended.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/wrange.h                       |  26 ++++
 tools/testing/selftests/bpf/formal/wrange.py | 150 +++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 include/linux/wrange.h
 create mode 100755 tools/testing/selftests/bpf/formal/wrange.py

diff --git a/include/linux/wrange.h b/include/linux/wrange.h
new file mode 100644
index 000000000000..e2316c7bbb2d
--- /dev/null
+++ b/include/linux/wrange.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_WRANGE_H
+#define _LINUX_WRANGE_H
+
+#include <linux/types.h>
+
+struct wrange32 {
+	/* Start with a usual u32 min/max.
+	 *
+	 * Requiring umin/start <= umax/end, and cannot be use to track s32
+	 * range.
+	 */
+	u32 start; /* umin */
+	u32 end; /* umax */
+};
+
+/* Helper functions that will be required later */
+static inline u32 wrange32_umin(struct wrange32 a) {
+	return a.start;
+}
+
+static inline u32 wrange32_umax(struct wrange32 a) {
+	return a.end;
+}
+
+#endif /* _LINUX_WRANGE_H */
diff --git a/tools/testing/selftests/bpf/formal/wrange.py b/tools/testing/selftests/bpf/formal/wrange.py
new file mode 100755
index 000000000000..8836f4cbbedb
--- /dev/null
+++ b/tools/testing/selftests/bpf/formal/wrange.py
@@ -0,0 +1,150 @@
+#!/usr/bin/env python3
+import abc
+from z3 import *
+
+
+# Helpers
+BitVec32 = lambda n: BitVec(n, bv=32)
+BitVecVal32 = lambda v: BitVecVal(v, bv=32)
+
+class Wrange(abc.ABC):
+    SIZE = None # Bitwidth, this will be defined in the subclass
+    name: str
+    start: BitVecRef
+    end: BitVecRef
+
+    def __init__(self, name, start=None, end=None):
+        self.name = name
+        self.start = BitVec(f'Wrange32-{name}-start', bv=self.SIZE) if start is None else start
+        assert(self.start.size() == self.SIZE)
+        self.end = BitVec(f'Wrange32-{name}-end', bv=self.SIZE) if end is None else end
+        assert(self.end.size() == self.SIZE)
+
+    def wellformed(self):
+        # start <= end
+        return ULE(self.start, self.end)
+
+    @property
+    def umin(self):
+        return self.start
+
+    @property
+    def umax(self):
+        return self.end
+
+    # Not used in wrange.c, but helps with checking later
+    def contains(self, val: BitVecRef):
+        assert(val.size() == self.SIZE)
+        # umin <= val <= umax
+        return And(ULE(self.umin, val), ULE(val, self.umax))
+
+
+class Wrange32(Wrange):
+    SIZE = 32 # Working with 32-bit integers
+
+
+__all__ = [
+        'Wrange',
+        'Wrange32',
+        'BitVec32',
+        'BitVecVal32',
+]
+
+
+def main():
+    # A random 32-bit integer called x, that can be of any possible value
+    # unless constrained
+    x = BitVec32('x')
+
+    w1 = Wrange32('w1', start=BitVecVal32(1), end=BitVecVal32(1))
+    print(f'Given w1 start={w1.start} end={w1.end}')
+    print('\nChecking w1 is wellformed')
+    prove(
+        w1.wellformed(),
+    )
+    print('\nChecking w1.umin is 1')
+    prove(
+        w1.umin == BitVecVal32(1),
+    )
+    print('\nChecking w1.umax is 1')
+    prove(
+        w1.umax == BitVecVal32(1),
+    )
+    print('\nChecking that w1 contains 1')
+    prove(
+        w1.contains(BitVecVal32(1)),
+    )
+    print('\nChecking that w1 is a set of {1}, with only one element')
+    prove(
+        w1.contains(x) == (x == BitVecVal32(1)),
+    )
+
+    w2 = Wrange32('w2', start=BitVecVal32(2), end=BitVecVal32(2**32 - 1))
+    print(f'\nGiven w2 start={w2.start} end={w2.end}')
+    print('\nChecking w2 is wellformed')
+    prove(
+        w2.wellformed(),
+    )
+    print('\nChecking w2.umin is 2')
+    prove(
+        w2.umin == BitVecVal32(2),
+    )
+    print('\nChecking w2.umax is 2**32-1')
+    prove(
+        w2.umax == BitVecVal32(2**32 - 1),
+    )
+    print('\nChecking that w2 contains 2**32 - 1')
+    prove(
+        w2.contains(BitVecVal32(2**32 - 1)),
+    )
+    print('\nChecking that w2 does NOT contains 1')
+    prove(
+        Not(w2.contains(BitVecVal32(1))),
+    )
+    print('\nChecking that w2 is a set of {2..2**32-1}')
+    prove(
+        # Contrain x such that 2 <= x <= 2**32-1 and check that if x between 2
+        # and 2**32-1 (inclusive), then w2.contains(x) will return true.
+        #
+        # In addition to that, check that the reverse is also true. That is if
+        # x it _not_ a value between 2 and 2**32-1, then w2.contains(x) will
+        # return false.
+        w2.contains(x) == And(ULE(BitVecVal32(2), x), ULE(x, BitVecVal32(2**32-1))),
+    )
+
+    # Right now our semantic doesn't allow umax/end < umin/start
+    w3 = Wrange32('w3', start=BitVecVal32(2), end=BitVecVal32(0))
+    print(f'\nGiven w3 start={w3.start} end={w3.end}')
+    print('\nChecking w3 is NOT wellformed')
+    prove(
+        Not(w3.wellformed()),
+    )
+
+    # General checks that does not assum the value of start/end, except that it
+    # meets the requirement that start <= end.
+    w = Wrange32('w') # Given a Wrange32 called w
+    x = BitVec32('x') # And an 32-bit integer x (redeclared for clarity)
+    print(f'\nGiven any possible Wrange32 called w, and any possible 32-bit integer called x')
+    print('\nChecking if w.contains(x) == True, then w.umin <= (u32)x is also true')
+    prove(
+        Implies(
+            And(
+                w.wellformed(),
+                w.contains(x),
+            ),
+            ULE(w.umin, x),
+        )
+    )
+    print('\nChecking if w.contains(x) == True, then (u32)x <= w.umax is also true')
+    prove(
+        Implies(
+            And(
+                w.wellformed(),
+                w.contains(x),
+            ),
+            ULE(x, w.umax),
+        )
+    )
+
+if __name__ == '__main__':
+    main()
-- 
2.42.0


