Return-Path: <bpf+bounces-14461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681767E5021
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B72B1C20D9C
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC24CA5F;
	Wed,  8 Nov 2023 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JQXkn5YU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C5C8D2
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:46:50 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2382170F
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:46:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilk5gYRszXv/w/BLKcK5aZVXadcMXrfoDPdQr3NmXS/BQKYqCvYFPNbul4lb6s0pXGfySCaTiZnmNe0thzH0NtxHM9ivsFCnl21k0jhwhwyREMD4VrNWvrYOGc+GYA7p0a4olKTvg8KIoEb+sgiagBYQksrgF7j8wR6Ae5Skzr8XtTJHIV8wIBdjQ6PYQ+oCt4DHwCYzfTiXV/L/oum61DdsYFviBuuJAbxAE8xYVzG6SyVsIuqf0zkl7+YF8+GERSrS3DIUdnrgfi9qlibgogJmKosFXaY3Z2xTQWKiiNaNh3reYZtfgGAT7G7tm4WU/so3iO+GIN2fLKOmndOLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIE0tNHu51H+i91nM9FbSd1pHFQxtReFDljXtYIpyDM=;
 b=gISfdkECCvMAFCzwSXkkrvgBc/w0aVf/Usqd+zaZUF75SDSU+2nG6UAHdxdvIgfwKclm9OfCROTM3sJ+AYP167SGeetik8jXyn2KJoYQ9RACsAv7J4B1jSzK7dJhH0RD7F7YwTU1cGO6uLTeQup0La3lbh85yU2Boj7DTyZHxvBBthI2Orp+0DEA7FB8D17jQjmFBUNs8WgmbgOv/Tssc728q3UsliE3Hd+Z6Sf2BxKg6rvY+X15CRTzct4jWWxDElxuUbcO2kEYBF1DkgfDJ1l3m+S/XbqKhmqzt51ywR/JKz4lGddbPn6g4OL/WsEBS5qbew0AGYYLfianR0ueoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIE0tNHu51H+i91nM9FbSd1pHFQxtReFDljXtYIpyDM=;
 b=JQXkn5YUQyYtO1SmqkKdW+Pcjf7iwludVQ+Ahk7kqmNbRJXcyXTK8FVdZQuJhb5yQhvDGpBhOxaXTZuBuwjCCuaSpJfXQs04fHIoDwsC/MHlkTieCW26XSNbHsOEed1u6ahDWsDJiDrzj0grQlMN56gktVDewuOyHR11lgVVJ7GSfVWdWIkoqZ96uVVJF5m8WS4ItEc03HVvX4jFdpFDpib/iK6dBMhnYYJPqBMOR9Ly1btUWcz5ubOpygG0x3lP5NPaXoFLGXE/HDlDj1jcP8RC7lu19mEqdhibZYiHTSB9wqukNwuP5MLL+rEsJ3s7qM0qkO2gbQxbYDA7Rtjzog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 05:46:47 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 05:46:47 +0000
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
Subject: [RFC bpf-next v0 3/7] Support tracking signed min/max
Date: Wed,  8 Nov 2023 13:46:07 +0800
Message-ID: <20231108054611.19531-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108054611.19531-1-shung-hsi.yu@suse.com>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0081.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::7) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1e875a-f0db-4153-8eb4-08dbe01e18a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pxNztqCaS3YxudSW6q1jPkihJEqQXRjB9QRIWYF0fMBfHRV3TfTlsmY4DFveDfTOfBmQwry/oAxjaUzZORkkLhNetz0RXUF0Zl0hF2oo98Jfijkp+fA3gh52WXmVZY/cy2SnO5RwM8x+NpX1p55+sbV73ZOdRcWyCKsF7F3muhwMfcK9fu/DgNSC++k1aTqQyvq8vK1TvBJ3k5z39fCDeQhUfsvxfuGanBVPnqgZ+S56vXV3UHOPlPESRm9l9JmqO50+aKBHinzpLXh8pqTk6+05TFfLM0yyWe4bSJQnNaDXKpyGWSxZh4TvcjYdiId53hCV2J8M6viAJz9nI5Y6jSwO7Fgs6Rcohdj4ZiZB60Y6u8JJv0fYmJhS3TbmTc9jJZptVZGQei46WknLgcm4nOk6m3eKtW/gXnr2OVLf8uh5MtgF01SlEJeUaubiUCFrLX3ThT5FV+y6taGjwJj935lGaTaE/yuUNe6qsrEq6zmpxYXyYelzxhkj4CbsqYsD5QN7MBNrPguIqynaCvp9luXZcOrvCyU/r4dWcOyU+zcUu9pbSK85YlugoOgbJpFe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6916009)(316002)(54906003)(66476007)(66946007)(66556008)(478600001)(6486002)(6666004)(86362001)(5660300002)(41300700001)(36756003)(2906002)(8936002)(4326008)(8676002)(2616005)(83380400001)(1076003)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/hbJ+zPUKlTkOzHUJ39nWsizK25u27c/NftYoJpamf5K4B7yx3yQNLJ4X4T+?=
 =?us-ascii?Q?jmh9XCpy7khkHpo3wXZWENxpbDRJsbvNxLfnWMpyyMm2Ic3En1S4A/H/5cLz?=
 =?us-ascii?Q?Y2HoB41vde9bJS9nKY1mkjlCeRDslYk4WOX+B25HprJEuo2p6itY+1IZ0GMB?=
 =?us-ascii?Q?u0PugDDSagj6GudKZZX9dzkGFKEksMOKkL0yPt6pXQYZ/IooJerrkPwHEyTj?=
 =?us-ascii?Q?oGcDCV9X8KLrjdxD3hCvW7NJWL9roVoHNX6qS+GBVBF5XP02qrCOwwzHgILX?=
 =?us-ascii?Q?iYQaN2Ea7Rs829EnYs85UsEZIrzrtIGG+OaWGo10XZcPXB/plNU2y2joJbfE?=
 =?us-ascii?Q?oVJ6SOwfJXMpmOtyH2uq/CWLPZQXdwOlAcvZEvojaSaRa7Wh9XEmHTqdlWy0?=
 =?us-ascii?Q?Iat3QxUm7bZ2+5SRU6/SOWI1OKNIkbgbt6oVGWuXoqnw+yA/r9Hu7fKY0QSv?=
 =?us-ascii?Q?9zSzs9eX/zK5bujd4qIwJbLdQug96GIYWO15K1pJamiiBaljTzeX73fs8G/4?=
 =?us-ascii?Q?/An8IAJy2dx6IkvWj2WIXiFC8e5lwS1INOiGsqrP9N7c57oKQ5FVPo+EDk6P?=
 =?us-ascii?Q?FKHYRlq40tUy7KCj7ammiVd48lok9eHezluP/gFAvZlQQ3H3Pq12hwcUtXAf?=
 =?us-ascii?Q?EHB+kAj589d8kkEJJDpjRSYNhw5y9WpSwarLjHt/s2uYXNDGYw2xasgO0r8d?=
 =?us-ascii?Q?iDi/OUPSf03Ap5X1p3NXE6WZvTGezSrEh4amsDTVRkQ8wazU0NQFJxR24qwX?=
 =?us-ascii?Q?HFKUvDuyPDT9UgUzCrndXXuOL6ukMXRwarR/YwEKHXv87GsocczrZw+dQySc?=
 =?us-ascii?Q?havNmT1xuDAs09RnRTY6QIaSMsRW4vO5QA9JajVmBH9RtMMvOUO/Ig8xDRxf?=
 =?us-ascii?Q?+KiKWxSTAHCLiDuXpJoG58+V+VxtAACRu61NDH/YPrzb4Afr9PlS5lhjpdqX?=
 =?us-ascii?Q?0nZPFr26Hes6Rc4O+3JohlqDwnZFXU7oe49shX+fwMEFgDaEYPaWUbx0rrg3?=
 =?us-ascii?Q?sZT5P4WYMnbOMQmCk43BvQbP1t4wHdIAegU5BviHpQ+925SOrWCqlarFpBSW?=
 =?us-ascii?Q?lQql5JljdbXoPfIf+CnUxqXhx5cZK2r1Xn0M34p2nlky7lpTJm1gzC4j1zTZ?=
 =?us-ascii?Q?ENuCBN1K0ALXC8XY+EvX5o+NOm11Lg6SmGyn9nJplCPLDVHwsdkia31vZGRN?=
 =?us-ascii?Q?2Q/ff6gPxZvZedy4Vz0ixqQaKq/il8N1OlDbLPVFTXRBhthfXkF785v1tiuJ?=
 =?us-ascii?Q?UQiqPNcam26sSXRUJ+A7MtT7VxO6o5lPfmsLzHFud/b/1AclETNKa5J9dTDW?=
 =?us-ascii?Q?7vYShmLeLpNqDSDGuNFIsB0Fwp0sCkgatQs8C03dFfWagYknY3Hqe3Urgogt?=
 =?us-ascii?Q?bxR5mAvYbfB947dI8+ouLBMjKMIojqsBR2Di11T+AJR5bVn4fU7ZVuzLaOaO?=
 =?us-ascii?Q?14w7uTShhT43YUSMKr5VvnRhT0t+btGPIyB4OJY0WYVhNpLDT6z5VdbbF/yW?=
 =?us-ascii?Q?nXCLhCB5TFwpJwADW8j+j2kQjblLrRq3iVf1sQB+OhN2Lv1Xg53/faLMb7gI?=
 =?us-ascii?Q?ajZ+/UXciwz210scF3M0gId3AYARiEAPppH5cL7rKAyIgMjxkyyxG80cxZ8t?=
 =?us-ascii?Q?vPacrbhBBG+NoaKnTR0IT9hm2Wx92dTkjP49sNm8X18UhFzcJZ0mng1RM0g2?=
 =?us-ascii?Q?NVzMGw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1e875a-f0db-4153-8eb4-08dbe01e18a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 05:46:47.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQWudJvukl695YmXWEtQbqMlQtpdSKvNHSpzGO6cG06Bme+g2mOrqPPNCZgu88AMVi5eGe7FchZg3uRpTZFe9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

With the start <= end restriction lifted, wrange32 gains the ability to
track the s32 range as well. The example provided in previous patch
shows that wrange32 can now track {0xffffffff, 0, 1}, which is in fact
just a plain s32 range {-1, 0, 1}. This patch add helpers to extract the
smin and smax from wrange32 along with wrange32_swrapping() helper that
checks whether this wrange32 wraps in the s32 range.

Additional z3Py checks are added to make sure that the smin/smax
reasoning is correct as well.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/wrange.h                       | 19 ++++++
 tools/testing/selftests/bpf/formal/wrange.py | 67 +++++++++++++++++++-
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/include/linux/wrange.h b/include/linux/wrange.h
index f51e674d1f18..876e260017fe 100644
--- a/include/linux/wrange.h
+++ b/include/linux/wrange.h
@@ -29,4 +29,23 @@ static inline u32 wrange32_umax(struct wrange32 a) {
 		return a.end;
 }
 
+static inline bool wrange32_swrapping(struct wrange32 a) {
+	return (s32)a.end < (s32)a.start;
+}
+
+/* Helper functions that will be required later */
+static inline s32 wrange32_smin(struct wrange32 a) {
+	if (wrange32_swrapping(a))
+		return S32_MIN;
+	else
+		return a.start;
+}
+
+static inline s32 wrange32_smax(struct wrange32 a) {
+	if (wrange32_swrapping(a))
+		return S32_MAX;
+	else
+		return a.end;
+}
+
 #endif /* _LINUX_WRANGE_H */
diff --git a/tools/testing/selftests/bpf/formal/wrange.py b/tools/testing/selftests/bpf/formal/wrange.py
index a2b1b083d291..825d79c6570f 100755
--- a/tools/testing/selftests/bpf/formal/wrange.py
+++ b/tools/testing/selftests/bpf/formal/wrange.py
@@ -37,6 +37,19 @@ class Wrange(abc.ABC):
     def umax(self):
         return If(self.uwrapping, BitVecVal(2**self.SIZE - 1, bv=self.SIZE), self.end)
 
+    @property
+    def swrapping(self):
+        # signed comparison, (s32)end < (s32)start
+        return self.end < self.start
+
+    @property
+    def smin(self):
+        return If(self.swrapping, BitVecVal(1 << (self.SIZE - 1), bv=self.SIZE), self.start)
+
+    @property
+    def smax(self):
+        return If(self.swrapping, BitVecVal((2**self.SIZE - 1) >> 1, bv=self.SIZE), self.end)
+
     # Not used in wrange.c, but helps with checking later
     def contains(self, val: BitVecRef):
         assert(val.size() == self.SIZE)
@@ -79,6 +92,14 @@ def main():
     prove(
         w1.umax == BitVecVal32(1),
     )
+    print('\nChecking w1.smin is 1')
+    prove(
+        w1.smin == BitVecVal32(1),
+    )
+    print('\nChecking w1.smax is 1')
+    prove(
+        w1.smax == BitVecVal32(1),
+    )
     print('\nChecking that w1 contains 1')
     prove(
         w1.contains(BitVecVal32(1)),
@@ -102,6 +123,14 @@ def main():
     prove(
         w2.umax == BitVecVal32(2**32 - 1),
     )
+    print('\nChecking w2.smin is -2147483648/0x80000000')
+    prove(
+        w2.smin == BitVecVal32(0x80000000),
+    )
+    print('\nChecking w2.smax is 2147483647/0x7fffffff')
+    prove(
+        w2.smax == BitVecVal32(0x7fffffff),
+    )
     print('\nChecking that w2 contains 2**32 - 1')
     prove(
         w2.contains(BitVecVal32(2**32 - 1)),
@@ -136,6 +165,14 @@ def main():
     prove(
         w3.umax == BitVecVal32(2**32 - 1),
     )
+    print('\nChecking w3.smin is -2147483648/0x80000000')
+    prove(
+        w3.smin == BitVecVal32(0x80000000),
+    )
+    print('\nChecking w3.smax is 2147483647/0x7fffffff')
+    prove(
+        w3.smax == BitVecVal32(0x7fffffff),
+    )
     print('\nChecking that w3 contains 0')
     prove(
         w3.contains(BitVecVal32(0)),
@@ -163,6 +200,14 @@ def main():
     prove(
         w4.umax == BitVecVal32(2**32 - 1),
     )
+    print('\nChecking w4.smin is -1')
+    prove(
+        w4.smin == BitVecVal32(-1),
+    )
+    print('\nChecking w4.smax is 1')
+    prove(
+        w4.smax == BitVecVal32(1),
+    )
     print('\nChecking that w4 contains 0')
     prove(
         w4.contains(BitVecVal32(0)),
@@ -176,7 +221,7 @@ def main():
         w4.contains(x) == Or(x == BitVecVal32(2**32-1), x == BitVecVal32(0), x == BitVecVal32(1)),
     )
 
-    # General checks for umin/umax
+    # General checks for umin/umax/smin/smax
     w = Wrange32('w') # Given a Wrange32 called w
     x = BitVec32('x') # And an 32-bit integer x (redeclared for clarity)
     print(f'\nGiven any possible Wrange32 called w, and any possible 32-bit integer called x')
@@ -200,6 +245,26 @@ def main():
             ULE(x, w.umax),
         )
     )
+    print('\nChecking if w.contains(x) == True, then w.smin <= (s32)x is also true')
+    prove(
+        Implies(
+            And(
+                w.wellformed(),
+                w.contains(x),
+            ),
+            w.smin <= x,
+        )
+    )
+    print('\nChecking if w.contains(x) == True, then (s32)x <= w.smax is also true')
+    prove(
+        Implies(
+            And(
+                w.wellformed(),
+                w.contains(x),
+            ),
+            x <= w.smax,
+        )
+    )
 
 if __name__ == '__main__':
     main()
-- 
2.42.0


