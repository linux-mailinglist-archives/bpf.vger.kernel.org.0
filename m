Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9975A745D
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 05:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiHaDUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 23:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHaDTs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 23:19:48 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F41BB5E57;
        Tue, 30 Aug 2022 20:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STtJGVIR1xLHeUAxGQzi35NBk7a87kFzWVlXp5GWCqq/xuCOUncBwAOJp2pYoj51rOV//TM3g8TH0BKuui2HTLhNfkh3awt2L2aaAe19JZNP9267k5Ab07WyzG4p4liCQoEXiCnRTXJsBS2BBZ244j2inxbnViuY87kTwbkrLvtSwOZYAO93kmEDUg6EQ0SpvNFKDBzGUBwN33uoZp++CuGO5A6rRIUBOR23MFZbi5uD/gICE5c6Az0zh4LTLyeEH+win+lAO0iVbXukYSxl+L2U0tH8C5c9ib8ug2ZJEA0jvEOCb/1+g4K9cPStKkVN0Vy4RNzQ33mPgmzHReaX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOm0RDquLbflUmHQHR5CF8LlJjH3HMMpHcgKCE/9oVg=;
 b=VrWygwL85UkzaTOKXkU4iKUy+vJd5R+EdCYk4vZrvejeULcRWn46EpKaeJg9UQNlju4HflvOAaxH9+eJzw4y/GFwqecMOrBvR17E+M5yKX+y1kOFBWMR0jt/nbftmC2/JYaP0bL6DueVSYhUjZ5rZJLGubFV29S43ag/+jP5hJMDHNpmA6o6Iqb7R3Zy6S6TtqimLlTTO3EdjblmfGRU+ZcmiQyLss1yCUIGMlAkXnHAJlqR8PjVZ/YqmfG5odn90MDAxZhG0KLkxr8XMnIqfB1iAq6XbGyRsEt44WAlodrNO6emSsmQ0BMs2jozCTJnjN5/KccQElQvq3ar8FW2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOm0RDquLbflUmHQHR5CF8LlJjH3HMMpHcgKCE/9oVg=;
 b=xc1nqoyN+DO+svtmhmlQ7/vsaFWKzMgzPn23hZ8olPMG+3MIXtflzwVv67wQBvJYKVPId4QbeWZY/eAfbuMLAAjFo2DQc+hT4ZsY+PS3D2sItl8PNghoAOj/4UW/o2KEyyZIzSxrnkrv5qLrS8WoaPLy/H86WYzaxYoXHYzNP0bLR85RwzYfHrbI7JHjX2ewLSCO4eA2gX1fBh3a1DNlGQZmMx8Q/c29UlhNDOdZHM0+2gIFzlfy0bbG7X/Lm6Z5cRe2JFS9Jy2OV+yZm63hFLFQCEiLtB6YfdaqkDogks3+p0xoWRq6bXlaFUz9ckC5L9L4M+wPz9RZDV0sYdazGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM5PR04MB3009.eurprd04.prod.outlook.com (2603:10a6:206:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 03:19:40 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 03:19:40 +0000
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [RFC bpf-next 2/2] proof for the safe usage of tnum_in()
Date:   Wed, 31 Aug 2022 11:19:07 +0800
Message-Id: <20220831031907.16133-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831031907.16133-1-shung-hsi.yu@suse.com>
References: <20220831031907.16133-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e87b229-89f6-4ed7-6eac-08da8affa3d3
X-MS-TrafficTypeDiagnostic: AM5PR04MB3009:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqQAaUnDBP6H+ymi8nkljoDkTZ4bj7HQRYbAXA7VGLnLP65szbrqoV3j+5Cg6DSX+J90qP50pS0M/QPiBtQRLkVUHsGD2Yt41BVL9aCyA/glefi2ZFh+Fv4gMQyhyXxT9kU5sOcl7kBt3ACVwVNh0cJRppzggPiKKjw9Zn0UnHBgBxhKWWWhLSeZTZoeEzVhtRQJYeLgSmN3xxzocoOvOCij4eABLHWQM153Qy3sAZ5iY/yf9w5znPpQjsiTeG3Qd0EUF8z9l7UjKkCb9etypXcNNDAjOBdy5SduMypYcq4Nux3LGCv04AZZhEtM9w76i7MghjEcrx+fbbwIYo9sPVNQRBmJMCqPVE7Sjd0GH4y8zx6NTaeglxTdSgjQHJj9FIPUmbXdxa9gv2FUrlfpl8W6xWvz+XgK21zoP5lYFK7BMmAgaJbVVnZjySIdSvbsXWmYbdAv9dNL+7NywwPglrVMPZVUjBjM2LJ6wXv2HiYcgkUIqu5tOJusjL99PKT5Ntx0ENe9hvhwULXPNAZOqtRTX6YfVm42z+oUOKL4cqZjXKH0+OiTxx/dKmZ+uFQ+ZUK6BuweSncKKUe96OGC2/mrF3DPLj245Mr5Pt2fHYmnWhDAHFceuaabS+U1hHo1HPsrsN6Cf2cI1zTHL3ZEuxwEJZieFJ26wZguXofow0C0Q1Sk/kQ675AHPIrvqCBq/l9dGwsguyX2nUdA4GftlBkBe7mPfg2yd+WPUjJKQU3eefOyeoMstpN4EoMcI8VbW1oeA41uMNTjF1asY1wc++/8YAS7UU9l713NWiawR7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(366004)(136003)(38100700002)(26005)(6506007)(2906002)(107886003)(6666004)(2616005)(6512007)(186003)(6486002)(86362001)(8676002)(66946007)(316002)(66556008)(66476007)(54906003)(4326008)(36756003)(1076003)(8936002)(41300700001)(5660300002)(478600001)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kne0H212/9lpABBMtrVvbUb1WEwKyRthdI4PdperBVh/pLAtexcUwbiscAGY?=
 =?us-ascii?Q?w9E7viGdVAXPvJMH2a04OTX9jWnIzHxV5i49/vd3ZJitsZm2BBP9vu5K9Gtg?=
 =?us-ascii?Q?GG34UR+Sd51cE3l5aJG9iHWEoxutsph1CpHIkVQ6NhPAXYmWavvMe7dKza8n?=
 =?us-ascii?Q?cNQDkViYiSK03XGPyyj8TIMfBxxLFIpjUWJsxv1TfJA82QEv87i3drXBqPiu?=
 =?us-ascii?Q?rEIas7cVa3g+wdgmrxI4U3Hp/8jTTrFDougN1dDqKVSNhHBxZITnHdiR+5lK?=
 =?us-ascii?Q?JAqC81PWrmmDfZozXojzDXmrdEzhH3p+ik0qXyyVxZ7XUNkRyZ4oBdIHcVFo?=
 =?us-ascii?Q?RuNxD7HUL1f8Gtrk74odjLo3/UE3IpZE1lDS7OSjfhrY2V35iL4fSv3Q4fCx?=
 =?us-ascii?Q?miV0SxUH2S7VyT/Vr/wVuHR+N5xNLBx9o1PbaQjJdBIVsVVd2OQ6LaM6AujG?=
 =?us-ascii?Q?ZEQhZE5uxUp/yd52SZtaqCSxjHXZLOrlZUomx64uynNg0qwZJYTxXx13OOVu?=
 =?us-ascii?Q?ZOGB+nQisvZOptfJg8pzL9LWR03sJFfuYBUl8cGBw7/V6zAbSE46Yq3oYONw?=
 =?us-ascii?Q?HBD0MH9tsPcG0oHVsr00fImN8xl998V0sJ6qH9SZgyPph6oHCXRl7Afwtj5p?=
 =?us-ascii?Q?bxGGSyBv8G1IvWrTSyLq6OQqA6ArbUmglLkoU2RYG+ukfW3TuDzJvp26RZdy?=
 =?us-ascii?Q?o4leUQf2oonPnTLe76phS43N6UsY46oqqCTzFZiG4hiHlW61Hx7hcNqCVk7T?=
 =?us-ascii?Q?1CTWCJGlWFNUmRxWszbwdDYfA7EuVrxE9Pzyii04t0kHpIly5iv0zFUO2q/N?=
 =?us-ascii?Q?EHNgfFM3bhjzkbfWnUdkC4fNJIFTbtKvuC3bio9hrJdLdDj9SWaWqtk8ErJX?=
 =?us-ascii?Q?DEVBboyn4hP7gdFeSXVJxFW90W1k7Sy3tR5RK/ln1JOmZ4ShurLaxQEt2NWC?=
 =?us-ascii?Q?Wrvih/VhpPiaTKutfekSObuiKlo14k1FRMLGHLuMJhonbZEjozqkRq1hHyQ9?=
 =?us-ascii?Q?yT0CObM3hxHMKSTOJBw0IhWvIeK+HJbmL7ZcU++ovz0ctFTII/7nRRPoJVte?=
 =?us-ascii?Q?pLBgORc4GQR7NSVOlN9b7XWsv8V/5KxiPYz7ffe6Qts5D2DxuxM2tnqfLZSY?=
 =?us-ascii?Q?AHoIwKsQVJREimrn6LqqUPIJz0qLOeF5X0Bpne3QMi24NdfAQps1UvFnwr8p?=
 =?us-ascii?Q?tVAEHUEMIxv8OAsaidmxvAR0SlcOWS3kl6nrCMeKdMMZyiBsW7Kk/PIWrssn?=
 =?us-ascii?Q?bRQbDGVI83i1pBDWLof9k2sNK1A/QWuIkQ7be56cW6obP95X6g58kldPBBSN?=
 =?us-ascii?Q?MjRaiKclzWBZEAZeoJJtxqoOa/jLxMHv5JlwpUjRxIyX67gK8d0WAyANSmK0?=
 =?us-ascii?Q?1Lwb/OVwixIwsq7c4tTXEgcyAfmQPEf0M5K/IUnuWNzMeQbuAZ7wXg6xlNQH?=
 =?us-ascii?Q?tdxUNidMFur/2wIx47hivzMF9JOmYbMVIMwy+zu76EpshasVQ7xIV9QGN26l?=
 =?us-ascii?Q?Vu5KlZDkcAHveTWsf9Db06gwgCqPVP9RFdBPGH6EbTiqR9QsxEmmaOWh0pBR?=
 =?us-ascii?Q?NuUKYusjr13sovy0C4H3FfEXX8JoX0/PUtnQZ99P?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e87b229-89f6-4ed7-6eac-08da8affa3d3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 03:19:40.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CRjsrHSiobIxYf0amfklHH5gye45cecfSck2We3Ufx8L4enX5nUASmwwUvr/GoJaW2J4qgYuhCAFqK2urwgjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit is not meant to be merged, merely as a display of proof
about the claims in previous commit that tnum_in() can be trusted when
used in the following form:

- tnum_in(tnum_const(), ...)
- tnum_in(tnum_range(0, 2**n - 1), ...)
- tnum_in(tnum_range(2**n, 2**(n+1) - 1), ...)

Note that this only proves that tnum_in() can be trusted when it returns
true, and proof nothing about whether it's trustworthy or not when it
returns false; the latter is still being worked on.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tnum_in.py | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100755 tnum_in.py

diff --git a/tnum_in.py b/tnum_in.py
new file mode 100755
index 000000000000..e4567bda51c4
--- /dev/null
+++ b/tnum_in.py
@@ -0,0 +1,158 @@
+#!/usr/bin/env python3
+#
+# A proof on the property of tnum_in(tnum_range(a, b), ...) using the Z3
+# theorem prover
+#
+# Requires the z3 Python module (aka Z3Py), which can be installed with the
+# command `pip3 install z3-solver`
+#
+from uuid import uuid4
+from z3 import And, BitVec, BitVecs, BitVecVal, Extract, If, Implies, Or, ULE, UGT, ZeroExt, prove
+
+
+class Tnum:
+    """A model of tristate number use in Linux kernel's BPF verifier.
+
+    Largely based on the "Sound, Precise, and Fast Abstract Interpretation with
+    Tristate Numbers" paper <https://arxiv.org/abs/2105.05398>.
+    """
+    SIZE = 64
+    def __init__(self, val=None, mask=None):
+        uid = uuid4() # Ensure that the BitVec are uniq, required by the Z3 solver
+        self.val = BitVec(f'Tnum-val-{uid}', bv=Tnum.SIZE) if val is None else val
+        self.mask = BitVec(f'Tnum-mask-{uid}', bv=Tnum.SIZE) if mask is None else mask
+
+    def contains(self, bitvec):
+        # Mask out the unknown bits, if what left is that same as value, then
+        # this that integer is represented by this tnum
+        return (~self.mask & bitvec) == self.val
+
+    def wellformed(self):
+        # Bit cannot be set in both val and mask, such tnum is not valid
+        return self.val & self.mask == BitVecVal(0, bv=Tnum.SIZE)
+
+
+def is_power_of_2(n):
+    return And(n != 0, n & (n-1) == 0)
+
+
+def fls64(bv):
+    size = Tnum.SIZE
+    num = BitVecVal(0, bv=Tnum.SIZE)
+    while size > 1:
+        half_size = size // 2
+        h = Extract(size - 1, half_size, bv)
+        bv = If(
+            h != 0,
+            h,
+            Extract(half_size - 1, 0, bv),
+        )
+        num += If(h != 0, BitVecVal(half_size, bv=Tnum.SIZE), BitVecVal(0, bv=Tnum.SIZE))
+        size = half_size
+
+    assert(size == 1) # Size is now 1
+    num += If(bv != 0, BitVecVal(1, bv=Tnum.SIZE), BitVecVal(0, bv=Tnum.SIZE))
+    return num
+
+
+def tnum_range(min_, max_): # Don't shadow built-in min & max
+    """tnum_range() implementation modeling what's found in the Linux Kernel"""
+    chi = min_ ^ max_
+    bits = fls64(chi)
+    delta = (BitVecVal(1, bv=Tnum.SIZE) << bits) - 1
+    too_large = UGT(bits, BitVecVal(Tnum.SIZE - 1, bv=Tnum.SIZE))
+
+    val = If(
+        too_large,
+        BitVecVal(0, bv=Tnum.SIZE),
+        min_ & ~delta,
+    )
+    mask = If(
+        too_large,
+        BitVecVal(-1, bv=Tnum.SIZE),
+        delta,
+    )
+    return Tnum(val=val, mask=mask)
+
+
+def tnum_in(a, b):
+    """tnum_in() implementation modeling what's found in the Linux Kernel"""
+    return If(
+        (b.mask & ~a.mask) != 0,
+        False,
+        a.val == (b.val & ~a.mask),
+    )
+
+
+# a, b, and x are integers which could be of any value
+a, b, x = BitVecs('a b x', bv=Tnum.SIZE)
+assumptions = []
+
+t = tnum_range(a, b) # Any possible range we could get out of tnum_range()
+assumptions += [
+    ULE(a, b), # a <= b
+]
+
+st = Tnum() # The second argument can be any tnum
+assumptions += [
+    st.wellformed(), # As long as it is a valid one
+    st.contains(x), # And contains the number x (that could be any integers)
+]
+
+condition = [
+    # When tnum_in() returns true
+    tnum_in(t, st) == True,
+]
+
+print("""\
+Trying to proof that tnum_in(tnum_range(a,b), ...) can always be trusted when
+it returns true...
+""")
+prove(
+    Implies(
+        # When using tnum_in(tnum_range(a, b), ...)
+        And(assumptions + condition),
+        # Try to prove that we can always trust it when it returns true
+        # That is, all number that the second argument can represent (i.e. x) is
+        # inclusively between a and b
+        And(ULE(a, x), ULE(x, b)),
+    )
+)
+print("")
+
+# Additional constrains, namely that the first argument need to be in the form of either
+#   tnum_const()
+# or
+#   tnum_range(0, 2**n - 1)
+# or
+#   tnum_range(2**n, 2**(n+1) - 1)
+additional_assumptions = [
+    Or(
+        a == b, # since a == b, tnum_range(a, b) == tnum_const()
+        And(a == 0, is_power_of_2(b + 1)), # b is 2**n - 1
+        And(is_power_of_2(a), b == (a << 1) - 1) # a is 2**n and b is 2**(n+1) - 1
+    ),
+]
+
+print("""\
+Trying to proof that tnum_in(tnum_range(a,b), ...) can always be trusted when
+it returns true, again, but with constrains on a and b, namely the first
+argument of tnum_in() must be in one of the following forms:
+- tnum_in(tnum_const(), ...)
+- tnum_in(tnum_range(0, 2**n - 1), ...)
+- tnum_in(tnum_range(2**n, 2**(n+1) - 1), ...)
+""")
+prove(
+    Implies(
+        # When tnum_in() is used in the form of
+        #   tnum_in(tnum_const(), ...)
+        # or
+        #   tnum_in(tnum_range(0, 2**n - 1), ...)
+        # or
+        #   tnum_in(tnum_range(2**n, 2**(n+1) - 1), ...)
+        And(assumptions + additional_assumptions + condition),
+        # Try to prove that we can always trust it when it returns true when the additional
+        # contrains above is inplace
+        And(ULE(a, x), ULE(x, b)),
+    )
+)
-- 
2.37.2

