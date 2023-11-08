Return-Path: <bpf+bounces-14460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE37E501F
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8FB20F2A
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0BC8D2;
	Wed,  8 Nov 2023 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eh2Pfb0+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28948CA60
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:46:41 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD561705
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAurLDoUG3s7uaAcTtVZgfaKFEtwUSsR2IRSuSlD++7vjq32oqOcrygNPLT5NcdAfocmeDAX8dXxTv/dDtng0ZnAu84ypi3ASD0dFO6k7Je6o0VUDXVA0zqNDPBcNDvP49tmDfdrmEoWSYaYfG57geOd1cuPPlTycvr+/aW/rwuwSYKSi3MXwrRn95S68a98DzUHNpCunWC4rHw3G3/Nm//0IdrWA3gGjnxiWiLWxFvX5VP1D0s2zcmvRaj+Fvu/sAG6VUET7WlYkbV4FtrtV38GXfZEqAFzPl51UqyrWN4ugF0MZCS+8ESybifmDVLXeL/jKzJaBrWdOziF8Ub5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZcDmYTio3JzCp/LgxrHZ77IPmzXRlwzqLj39Rq+ISs=;
 b=gPPehk2rmSUqN1qsrjVEAVeBuykaGbNV9blnN8Fr03nbT0RsFNn+iOCCKF5pI9M99B8BCHNI1Cj0xe2xnTsk1iBFVVOJrKdomr7IXk6Lu8obhX+5zYOcPKrBxZQGy/kZhWVOdpQNAcekfRW4coO/aPWASG9B6EG4w02wSb7rrBlYsJwJmLnMadjAIvyxhLpSASPRqhOwLkvUSd4ea6haHr8xxvwJjY4ar4QA+W927wc36J43HAEYIYVty3dpClcyMXG2n+OZpKbi4Etay+f4ZmBRF9FJknNzKkLFzjQa6dsTdR9cpCrHrb0nOQOzhFW2CYkhxtg+/78oFAaV5O8vBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZcDmYTio3JzCp/LgxrHZ77IPmzXRlwzqLj39Rq+ISs=;
 b=eh2Pfb0+KpPYnQ5tJDw63k1tW5G+sWj/qtMVgT5nNOUcH8UjELOysEfqoiUO56fjik3T9sQCW4LErPHgDPxC8kIxbi49/HsYcxwskjwCgMve8tawUQnMvJ/5sntpcqJeWN6TMsy7GsaiSW3YT0ONY58dDVmtn6Ymm2/TUYetN5lWc8RohXYHICbIBzpoaRqamd1X08KqWi0JoU8aGROr4GsshRLGDnW0W1R9l6zR6BrnSFfiP5l0fAO/C2JduxnGCtfOPATCMl6ZdCVOMhXZUzOawdICy6d0D1ooSYbdqJGXzk9KAd3nP2es94f7APUg1cL8gDHL/45p5x5VQx99iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 05:46:38 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 05:46:38 +0000
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
Subject: [RFC bpf-next v0 2/7] Lift the contrain requiring start <= end
Date: Wed,  8 Nov 2023 13:46:06 +0800
Message-ID: <20231108054611.19531-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108054611.19531-1-shung-hsi.yu@suse.com>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0283.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::11) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ba97a5-9c08-4672-e1bd-08dbe01e12e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XRvyOZAyKn5jsFVHQuct1PhsEu5JWQV74n/V4UB9EnIlw7+0nv/0bqMU3DjmWzjuC8nT41fy/SV/WtWeLHCQLBrsi58Z8iqsmuYc1xQhKuwVFWTFMX6X9+rtNQHBhImdhWY+dbVJZY9MiKAUjZHd197pPx5MhNJe9ItXazAwDGLpWtaI1Ywf0+9PwkFUDTOa2Nv0fvps5+5EIz0rZkwmwRGeLpfdNvmO2R4n593BqEzbh2z2T04Lp4vklgOsndN8FnbY1dpzBzE/NfdERDc2nPkeR1ENuNXs2iJVFmHy1vt48NgpulKqwlWxXWGCOndW0dx1AuiQ/xM3F2XrQTyd+LSXvWs3RgvN0Uq+D8NFmcDzIu3kit7yOs1HYW8Ku+k8v6QTtzepvjoOHu812++NwVj79JRMHgBiJsgwUaROXUVKq4YWuwo28XOwIRw0negxrHUjE/oagP4TSN6lRRaAA50l6+29lQAH74vP9i4SpbJfnU4ibDMIhkfRmzWYBpBJ+JIipNzjVDJdJ+mcMmghyjxChQZJlWQ3BjHkrDclD+izDbisev/G6phbkikg3t8F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6916009)(316002)(54906003)(66476007)(66946007)(66556008)(478600001)(6486002)(6666004)(86362001)(5660300002)(41300700001)(36756003)(2906002)(8936002)(4326008)(8676002)(2616005)(83380400001)(1076003)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66twX95e//Hi8lLhaJzU5hsxNYFdcLS+m/14hZy2Q76Csa4T5SEoo1oWuVNA?=
 =?us-ascii?Q?Y3ayVOlePmFVCrXZOuSNG+s40EXWCB8HCUUtcmVJddKeBIa1nQRE+zjMGx5g?=
 =?us-ascii?Q?+/Midna5+izpLI+n26b5MjCxPEcZayF61Y5IbBd5ZjVXmeIHVy+x50x51APi?=
 =?us-ascii?Q?aACcDj7dqH8gvZgzwVyiHBt+dhFgO+eJlZyqxpa33K0UiMkRcvWEpLnFvvec?=
 =?us-ascii?Q?Huy8XFmyPNjY2atgthdQURW4g1LsgTuu2BgydVtMKmceDF3heF10TqyPO1MK?=
 =?us-ascii?Q?mvR2j0Hb98cc3cxkL6DV16Nb723zy/FjyS7PgOqqsMJvwWc92Rgb2tHYjJ0N?=
 =?us-ascii?Q?+v1/UJTrSD+iXOIwzzRBVBdAqQsTgbVsoI9nNv5JjVlny/mr5Sizr8D9Ilr6?=
 =?us-ascii?Q?Nk6FDcXdhgh/8V1HMCCJDfonjB/sjMchh5OLhF7lcxAH0Vnb15uYhkUOJT56?=
 =?us-ascii?Q?RDa64qQ+/XQYZ0kMQAmOLbDb7Y9dvmzqkSxk0tU5NhmrkO+IUjjGO9/Avrfr?=
 =?us-ascii?Q?sViS6zdbZ6zEbWUJfW5knIoxfAHxZYCaayMIakHPaqu0L6f95ubVwnlZEJGM?=
 =?us-ascii?Q?iyQaq2r14SXjl0HLFugAFr3s9aMlmxsAwevxIafYBZK7Zj2wHX71vA5U7v0u?=
 =?us-ascii?Q?9BB0F6eCDf5IzLE9oNoll/cMsR0UXcpQNa8pTNGvznCuymC2BeDk1Z+CquO2?=
 =?us-ascii?Q?FqxTNhddEoEZULLe/XGiTJWYQ5BLt/kMBU1uDvll7tojRHDiKmFCHvFnTK73?=
 =?us-ascii?Q?+4pg049h+Bf1HY9dL+PmnnExukIoYHoIFhtoq4hay9kVd3ZLJpULF9+W67Mo?=
 =?us-ascii?Q?khsmsRTgMJBqPDOHw/7cu1P82dagzyqQ1b/oVSglFFoXWuN0/QsVatkGPr9b?=
 =?us-ascii?Q?HARCkQwqdwIm0QBKXeJ5WBXfBY1bWxQlGa9wrgveUoRt4mDlvOwf9mTxT7fw?=
 =?us-ascii?Q?Ebx3DMqR6EDHPK9ohiKe6Bij2qGoIdYYkQATjO+qkolpKHYXGibeYrew0JfU?=
 =?us-ascii?Q?HAPrPyK84+VYk8E0RSsEkoy0YBouomJS2CUw24ZSQiEKEt2/Tmd8gEkZE+j9?=
 =?us-ascii?Q?6jJ541kxIF3BsjBcz4+RMYdicSVpHqM+AWqfH3ElX0Vsg2HJ6ATw22v8hicv?=
 =?us-ascii?Q?i4fsYxX+nATUKphiTqgahWuiaqO1G6ehL+JKkkjRBH1G0Rm6VFCDnLEB/mL6?=
 =?us-ascii?Q?Lc/3Ab18Ah1RTtDO1AJp/s0TquPPvj2V05SMEaCudFJ9W9BHvOuWrRuWoDKy?=
 =?us-ascii?Q?pX6Vk4IpAQqlFz4AMgxQOXIy5nZ+StnfzZ+6xfzqzqj2dAjBfDVZFAPrk2ZU?=
 =?us-ascii?Q?YIrE/FhUsN/ZWu/5uX74oEnw0lZ7aYiF/1g9nph4hDG7hsnsmtDl1RIxpJ1L?=
 =?us-ascii?Q?i4QiN7IKC/k8qmOPwjtQ4nwEEwrDBSYNXHauhgZ/a73orPgTtxz3PEuH/aXi?=
 =?us-ascii?Q?6vfjfuN+aojJhLBaNy64K4znnWqKsXX2FGalh0ogD2lxRRNWUHAgWopnq/uz?=
 =?us-ascii?Q?LO5vFI16OXvyIr90LyfxEj3QPai75hOkbUBOSTypaehs9asXQTcGKcy2D4IL?=
 =?us-ascii?Q?NGgjllXFrWYrXRJYhMp4PE1Ha3asTI/XRJsMUmAMDUWuID4T2BmAu/7WabyO?=
 =?us-ascii?Q?lOhQA4mDtQkd7qN1K7/CDWsOTeBea0OvUxJDH4f99WYP+wKDNjmlvNq0V6Q5?=
 =?us-ascii?Q?r9cmgQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ba97a5-9c08-4672-e1bd-08dbe01e12e8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 05:46:38.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CK9kpB2UsKgrMCwAEnQTZB/bb4Q3pmv2UHf+I7bVi9TPUBlmRDxxSBLuqSH+ZNMifIZE8a8snyGvROIFKnPyFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

Lifting the restriction that requires start/umin <= end/umax can allow
us to track range that wraps around in the u32 range, e.g.
{0xffffffff, 0, 1} can be tracked with start=0xffffffff and end=1.
This makes retrieving umin/umax slightly more complicated, and requires
checking whether wrapping occurs in the u32 range; wrange32_uwrapping()
helper is introduced to simplify the check.

Additional z3Py checks are added to make sure the new reasoning around
umin/umax for the u32 wrapping case is correct.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/wrange.h                       | 26 ++++---
 tools/testing/selftests/bpf/formal/wrange.py | 77 +++++++++++++++++---
 2 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/include/linux/wrange.h b/include/linux/wrange.h
index e2316c7bbb2d..f51e674d1f18 100644
--- a/include/linux/wrange.h
+++ b/include/linux/wrange.h
@@ -3,24 +3,30 @@
 #define _LINUX_WRANGE_H
 
 #include <linux/types.h>
+#include <linux/limits.h>
 
 struct wrange32 {
-	/* Start with a usual u32 min/max.
-	 *
-	 * Requiring umin/start <= umax/end, and cannot be use to track s32
-	 * range.
-	 */
-	u32 start; /* umin */
-	u32 end; /* umax */
+	/* Allow end < start */
+	u32 start;
+	u32 end;
 };
 
-/* Helper functions that will be required later */
+static inline bool wrange32_uwrapping(struct wrange32 a) {
+	return a.end < a.start;
+}
+
 static inline u32 wrange32_umin(struct wrange32 a) {
-	return a.start;
+	if (wrange32_uwrapping(a))
+		return U32_MIN;
+	else
+		return a.start;
 }
 
 static inline u32 wrange32_umax(struct wrange32 a) {
-	return a.end;
+	if (wrange32_uwrapping(a))
+		return U32_MAX;
+	else
+		return a.end;
 }
 
 #endif /* _LINUX_WRANGE_H */
diff --git a/tools/testing/selftests/bpf/formal/wrange.py b/tools/testing/selftests/bpf/formal/wrange.py
index 8836f4cbbedb..a2b1b083d291 100755
--- a/tools/testing/selftests/bpf/formal/wrange.py
+++ b/tools/testing/selftests/bpf/formal/wrange.py
@@ -21,22 +21,31 @@ class Wrange(abc.ABC):
         assert(self.end.size() == self.SIZE)
 
     def wellformed(self):
-        # start <= end
-        return ULE(self.start, self.end)
+        # allow end < start, so any start/end combination is valid
+        return BoolVal(True)
+
+    @property
+    def uwrapping(self):
+        # unsigned comparison, (u32)end < (u32)start
+        return ULT(self.end, self.start)
 
     @property
     def umin(self):
-        return self.start
+        return If(self.uwrapping, BitVecVal(0, bv=self.SIZE), self.start)
 
     @property
     def umax(self):
-        return self.end
+        return If(self.uwrapping, BitVecVal(2**self.SIZE - 1, bv=self.SIZE), self.end)
 
     # Not used in wrange.c, but helps with checking later
     def contains(self, val: BitVecRef):
         assert(val.size() == self.SIZE)
-        # umin <= val <= umax
-        return And(ULE(self.umin, val), ULE(val, self.umax))
+        # start <= val <= end
+        nonwrapping_cond = And(ULE(self.start, val), ULE(val, self.end))
+        # 0 <= val <= end or start <= val <= 2**32-1
+        # (omit checking 0 <= val and val <= 2**32-1 since they're always true)
+        wrapping_cond = Or(ULE(val, self.end), ULE(self.start, val))
+        return If(self.uwrapping, wrapping_cond, nonwrapping_cond)
 
 
 class Wrange32(Wrange):
@@ -115,13 +124,59 @@ def main():
     # Right now our semantic doesn't allow umax/end < umin/start
     w3 = Wrange32('w3', start=BitVecVal32(2), end=BitVecVal32(0))
     print(f'\nGiven w3 start={w3.start} end={w3.end}')
-    print('\nChecking w3 is NOT wellformed')
+    print('\nChecking w3 is also wellformed')
     prove(
-        Not(w3.wellformed()),
+        w3.wellformed(),
+    )
+    print('\nChecking w3.umin is 0')
+    prove(
+        w3.umin == BitVecVal32(0),
+    )
+    print('\nChecking w3.umax is 2**32-1')
+    prove(
+        w3.umax == BitVecVal32(2**32 - 1),
+    )
+    print('\nChecking that w3 contains 0')
+    prove(
+        w3.contains(BitVecVal32(0)),
+    )
+    print('\nChecking that w3 does NOT contain 1')
+    prove(
+        Not(w3.contains(BitVecVal32(1))),
+    )
+    print('\nChecking that w3 is a union set of ({0} U {2..2**32-1})')
+    prove(
+        w3.contains(x) == Or(x == BitVecVal32(0), And(ULE(2, x), ULE(x, 2**32-1))),
     )
 
-    # General checks that does not assum the value of start/end, except that it
-    # meets the requirement that start <= end.
+    w4 = Wrange32('w4', start=BitVecVal32(2**32 - 1), end=BitVecVal32(1))
+    print(f'\nGiven w4 start={w4.start} end={w4.end}')
+    print('\nChecking w4 is also wellformed')
+    prove(
+        w4.wellformed(),
+    )
+    print('\nChecking w4.umin is 0')
+    prove(
+        w4.umin == BitVecVal32(0),
+    )
+    print('\nChecking w4.umax is 2**32-1')
+    prove(
+        w4.umax == BitVecVal32(2**32 - 1),
+    )
+    print('\nChecking that w4 contains 0')
+    prove(
+        w4.contains(BitVecVal32(0)),
+    )
+    print('\nChecking that w4 does contain 2**32-1')
+    prove(
+        w4.contains(BitVecVal32(2**32-1)),
+    )
+    print('\nChecking that w4 is a union set of ({2**32-1} U {0..1})')
+    prove(
+        w4.contains(x) == Or(x == BitVecVal32(2**32-1), x == BitVecVal32(0), x == BitVecVal32(1)),
+    )
+
+    # General checks for umin/umax
     w = Wrange32('w') # Given a Wrange32 called w
     x = BitVec32('x') # And an 32-bit integer x (redeclared for clarity)
     print(f'\nGiven any possible Wrange32 called w, and any possible 32-bit integer called x')
@@ -129,7 +184,7 @@ def main():
     prove(
         Implies(
             And(
-                w.wellformed(),
+                w.wellformed(), # Always true, but keeping it for now
                 w.contains(x),
             ),
             ULE(w.umin, x),
-- 
2.42.0


