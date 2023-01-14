Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F766AA00
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 08:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjANHxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Jan 2023 02:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjANHxy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Jan 2023 02:53:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2080.outbound.protection.outlook.com [40.92.19.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBAC213B;
        Fri, 13 Jan 2023 23:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADWU69QdAeDNlUQaETkNg+DUT5Fxz92MfvEIWAEAD28l1MGO4ftNM0M9oMrI/KBvvJTgkQUPHMK0teJ57fkBFIpVhE50ty5QjLIko/xblMaSXVtlVtVX7TQ+BTouICwCnEd5IJVzB0kcV53VCXIL9ql8lE3lhD/R0whIgtMomsfDhRtDPXQKU1zpmqOjld16peRO86cAuqVAhkvx8eRudbz5hvIlYe3EGVC4CW+Q8jOufI1ijfquGXiA7RCihap/jDzeaQah5t5uwTaHEkxdOO4EWrJmzErdrCeNtF6OSdfWgSjOH1sWPcITEt/KQVa/cM4dbVuFg1NfC/zjyUK/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj2ENo8F8kL6MotI92Vf900c/svzw33inEe38pTykCE=;
 b=dtRVk9SGuI5wRbmU1d9q71qPsk0cQcGZYRAvQPgFpdd/mGYpU3JmrcHl0ej6vXfAeEteYSL/8VXHKIr8VTB9RZAMPXdGengcHieanDZWdNjSrnSSPtVq+IwfXHlnhcYxz1BDrtTtqpFqh78VqToh34/w/uX2w1th7Zwchg+065Wd2Rbop5V+Gj1pffoSD0tdX/0MIDsk4AguliXfKD6hLeACjfUXT5eYFSCg61r0eLMdUW+DSECLjXberjBMHeGaNjmPYKzbWtO1oScNTwvausuo7bvnLSTpwQQ7xCINru7TNn98Xj7blekYn2RKQM8zbdGnPWhfA7J3QixMF4eQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj2ENo8F8kL6MotI92Vf900c/svzw33inEe38pTykCE=;
 b=aVFYYL0pvgVD43Wr7x2K5gFXWb844hg7NRaX6wz34p0JxTdMJ7cwYFjWQmUfRItcU08gYNrwiL/fMpeWzKvmrxc4KBORBPceUaZmeEtMn7qTZKV+fZyncz/FClegzfkWcXQCE1G6B0D5ng00sFfUbOiHnLNPmuASmPNchTGENFERQvHRjDCndehUVWT442wdRO7m0ey4bgvMPaYCD0k7yFAP37XjX8zYywarL45e09wun9ZVFQe1QlkJZo8aMkgTBzdeaidQ34FJNlmdL7p0vOep7toX6h0/hk+HgM/V79styo5fbU5ujExbpdgd25WVcFxz+dn+l7K9Fn38wx7yRw==
Received: from SJ0PR04MB7248.namprd04.prod.outlook.com (2603:10b6:a03:290::20)
 by BL0PR04MB4995.namprd04.prod.outlook.com (2603:10b6:208:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sat, 14 Jan
 2023 07:53:50 +0000
Received: from SJ0PR04MB7248.namprd04.prod.outlook.com
 ([fe80::84db:8f7e:37cd:a8ef]) by SJ0PR04MB7248.namprd04.prod.outlook.com
 ([fe80::84db:8f7e:37cd:a8ef%6]) with mapi id 15.20.5986.019; Sat, 14 Jan 2023
 07:53:50 +0000
From:   Roland <kernel.pwn@outlook.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel.pwn@outlook.com
Subject: [PATCH] bpf: Add CONFIG_BPF_HELPER_STRICT
Date:   Sat, 14 Jan 2023 15:53:22 +0800
Message-ID: <SJ0PR04MB7248C599DE6F006F94997CF180C39@SJ0PR04MB7248.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Oofl0tVibNuUKUPxyOM7WOv9/rcHcIZq]
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To SJ0PR04MB7248.namprd04.prod.outlook.com
 (2603:10b6:a03:290::20)
X-Microsoft-Original-Message-ID: <20230114075322.597885-1-kernel.pwn@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7248:EE_|BL0PR04MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: 742f06cb-56cc-4bbe-496b-08daf60478e3
X-MS-Exchange-SLBlob-MailProps: mWtqiNqNgRvd804xhYZtYyMXAxYNzmSSmmkBZHUQAu9rY/cXK5u3/5oVreLaf3DvLnuTWhkjU3W/etMYk05+6g8USIko09630sxm5IXGxQtj6ljJSyi8bM1xqWO5hQcqZ3kRfWwsj0+D4kHUB715/dSe4BBYp+FbkagIC7aT1CFZlKsYYLJBm/woZVCMR1VXXKqiqSGPbrqANJiiQ4TuFbw33FkZ9qthpeuElH4oPi6tGRIkrgosYORiao2DnMHzcr49EXe7PsPH2VE+cfbgtUWl4ArjWEVssC6aAe4zRe5kLKl6PPDOBl4gYyhWH2NiBcaIk4v8EV7vcOBPbCN2yZONOwC3tqQ9ESdrn4RWdEfuPrGhiLd+86M9J/D2ct+WJAAODuGRriFz5zVz/8fRzywiHf7S89Z8zjSyosy0pGYp6YRV9NlQijy/9MAXX6f2L39s9yTu74IEndW4id0kFefXxy868KF5aJOefMrQpCRy/Yg2dmgx3Lf5EEBoSm/2fWZojXldWiTQG2j0+6uLSlXbAa2DRIQ3/ruTlIgZP174ia5ZsZZ8bYdp3vVb/8tUXMw820E79xqgRiDOm/10xwUefJJLiFzaSg20GztfGUkvJ/e2aculP0TZyZxYSFjogGNDAiFBNv47yvH6d2jdnoibsYLMFo3jD64UGAVkzNpOkw80RK6U/1zfYkpZ0xRSbuBbnzuUkcApzW+ixeSnUvwisRcqeyO3OWl+w5TwgblDVjjQuXRFPN//7DMFXJi7ep37oIYSfFCf4MTonaP7j2k+7SPUf4AS5etEyull6UY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFpXPnrRSOSpliC1/1Ariq3cWvenx/0mSwFBJix4MMLwxT64QtssrksB3foe0JGGFty2GMFJsukeKtb89+x8AqrYH3pTXgl9FhbDHx+Etg3ZNhoMDes4YRjhEMrP6wMH/OHnc1lveT4yq47U8wgyT7V+6jyVdzmKoHzCmQ23TjBGAfWyYUggcna6CiXg5dmahwNYfxHsTkHRpME6mbTxnmBJtN6GHQ9zZKmVQJtZeFW5Hs2WWRZInOtwJQb2fYHjhcvQzJO89/PqPSVXbdSYChsF9DCHmG8w+Bxn8x02Xlt+5NlvKywW1D4afk1x/B/n8FERvIkCP3EYe36ZbfuVa23P+zVy0yI6oDPLNLtOLkt8J17BX/5b6sQ+OJrnaiyYN2dRxpGjXLFtvXM/9CtzTrWWZqXtqOj3DnDj/cu1VJadixZNzvJ1dcdsZwPjC2O+IMh4fSIEGb1mGc7vduiO+A7WuonWxP8LgUY9svLhXCxChHz1nGePmRpw5ze7NAHYCypIrvTjUuDB9or5/W9deZLuS58w4ybO6sK7MR9a2qn7gl6Sfv8UOYBgrMWNwOfC/0B4AjjAnNiiEwnY2D816Far1/rMzle+fmDWJ96GOmU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xjNASnlgqVXXxyVYOS14D2gn+IopJwsN8eL8DEhXOqwrt5epOIqco6D8Cf9d?=
 =?us-ascii?Q?/1FkHTs8wGsjFNfYWmJRy0igAxNf+h+4mO0rWFSISDoflzAg+fAkkCtoVN1Y?=
 =?us-ascii?Q?CkXRHJzIiR6xZUyTE00hNn8LEnf6LJY5nJrU8WYEhsjQOHtnIY96Bdh++j2J?=
 =?us-ascii?Q?NMUCNcQYBabAcUGSRrmTDOi6IHUkWkKEAVdCxiGSClrIkqM2wJgllM2nDc1Y?=
 =?us-ascii?Q?t9hJj6Uj7tqirWhzS8yzxns6YAm+h19EnG1aA+PVxO0HdgKUvV1zBEqaOvgg?=
 =?us-ascii?Q?EOGleCfYbbHECWIaql8wIuQ3lgjkn6XgkNQmJyYbMKFDzOGQ7oBDhXnW4hfw?=
 =?us-ascii?Q?w3MJLRB8jJPlHys5MKDDfRKyOS+wPNSNOR/y2SUeCBJmMA3U/hrpbFKVn71b?=
 =?us-ascii?Q?AMlCOXhBZ9ifGPPfg9t8BWmjbuIW6rc95Hs6TKw0yKjPkuKrKILhimAa9eSq?=
 =?us-ascii?Q?Z2IATgaHHOFNSZbTq2Ja01W+tYb6rlBEALjKkn9GcA/8C0lgz7wxorKPe/O3?=
 =?us-ascii?Q?vuccOsC7Pe0nqOmeV5/IpSC3GBWeAlLcYeSduhSysy1StlzpZzYofZBc8ONO?=
 =?us-ascii?Q?VIDCdoSpj03lUcr/SUrQ6CBMiN/b9Z0acK80a8jYIrJAw8TZ/qDGMCvmIUSQ?=
 =?us-ascii?Q?3W9zHcoOxRB/dlCThFHN2D9ZyQksGocihecV+jPUe1dMy3Tdgtan3UUNpDSX?=
 =?us-ascii?Q?nJ5HBbU/hbe/a/8vSZwv8K9yIshjNt+xh0YyzEq4zY0QgJmsk+OaHmUoA60v?=
 =?us-ascii?Q?wFccuX2LfT48sx7osPwWK1+tcamazduTt66zb+YsczjttKFRbVLFhtyvd6HS?=
 =?us-ascii?Q?itJs8w+CPv8R7xmwKCsmGuBp+Xr7Wh2tO+NbeIaCWfPai80hyf8dDUrO9xJR?=
 =?us-ascii?Q?BryAMYqCwu5gLx9nC9WxsYp8gBgtsA6/YlQwRfri7PCXTZlxIRABxehVnf+S?=
 =?us-ascii?Q?62b4iRxDCrwuOtYtVbkCmly2rQG6d+tI1c711taXFAKEyIeP9UudaWG6HJ6r?=
 =?us-ascii?Q?0MAXxOc18Ddiayx4Wp+ajzE+q8HkqJGHffZQ9h0ucHj1KnHFvtOgPMdhb6oE?=
 =?us-ascii?Q?e2FUsukctIVpG01VW0RnIwSogxXKvv8eap68XcNiGbM42uFRwLGOp3zwXzA3?=
 =?us-ascii?Q?1+pvUmXEDmjX0ZOLpclv1PRMiD1HSkdlr46Fe5yr6dQFeY2vQf3znspSp4bu?=
 =?us-ascii?Q?Z+EmUA306vBLWY/o0FDeZSq8aoIr8oZb5buWArHa9T39LwiJ5vLy45WT+Sy8?=
 =?us-ascii?Q?lcuKbe7hyg9Vdj3fDA/CwmiLWjxf+7H7xSLu1Zx0Tg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742f06cb-56cc-4bbe-496b-08daf60478e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7248.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 07:53:49.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In container environment, ebpf helpers could be used maliciously to 
   leak information, DOS, even escape from containers. 
   CONFIG_BPF_HELPER_STRICT is as a mitigation of it. 
   Related Link: https://rolandorange.zone/report.html

Signed-off-by: Roland <kernel.pwn@outlook.com>
---
 include/linux/kernel.h     |  7 ++++++
 include/linux/sched.h      |  4 +++-
 include/uapi/linux/bpf.h   |  4 ++++
 include/uapi/linux/sched.h |  4 ++++
 kernel/bpf/Kconfig         |  6 +++++
 kernel/bpf/syscall.c       | 48 +++++++++++++++++++++++++++++++++++---
 kernel/fork.c              | 13 +++++++++++
 kernel/trace/bpf_trace.c   | 29 +++++++++++++++++++++--
 8 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index fe6efb24d..61f7fcbc9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -509,3 +509,10 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
 	 (perms))
 #endif
+
+#ifdef CONFIG_BPF_HELPER_STRICT
+# define BPF_PROBE_WRITE_BIT 1
+# define BPF_PROBE_READ_BIT  2
+# define BPF_SEND_SIGNAL_BIT 3
+# define BPF_OVERRIDE_RETURN_BIT 4
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55c..a3ec52056 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -760,7 +760,9 @@ struct task_struct {
 	/* Per task flags (PF_*), defined further below: */
 	unsigned int			flags;
 	unsigned int			ptrace;
-
+#ifdef CONFIG_BPF_HELPER_STRICT
+	unsigned int			bpf_helper_bitfield;
+#endif
 #ifdef CONFIG_SMP
 	int				on_cpu;
 	struct __call_single_node	wake_entry;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 51b9aa640..99a90d0f5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -900,6 +900,7 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_HELPER_BITS_SET,
 };
 
 enum bpf_map_type {
@@ -1326,6 +1327,9 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+#ifdef CONFIG_BPF_HELPER_STRICT
+		__u32 security_helper_bits;
+#endif
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ce..c2fd463be 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -43,6 +43,10 @@
  */
 #define CLONE_NEWTIME	0x00000080	/* New time namespace */
 
+#ifdef CONFIG_BPF_HELPER_STRICT
+#define CLONE_BITFIELD	0x00000040	/* set if bpf_helper_bitfield shared between processes */
+#endif
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 2dfe1079f..c2c2fcf76 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -99,4 +99,10 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_HELPER_STRICT
+        bool "Enable BPF HELPER Check bits"
+        depends on BPF_SYSCALL
+        help
+            Enable several check bits for bpf helpers' security improvements.
+
+	     BPF_HELPER_STRICT restricts the function of helpers.
+	     Currently it can be used for restrict override return,
+	     read, write, and send signal.
endmenu # "BPF subsystem"
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b373a5e8..2f05ea50f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -68,6 +68,45 @@ static const struct bpf_map_ops * const bpf_map_types[] = {
 #undef BPF_LINK_TYPE
 };
 
+#ifdef CONFIG_BPF_HELPER_STRICT
+static __always_inline int HelperWrite(unsigned int bits)
+{
+	return ((unsigned int)bits & BPF_PROBE_WRITE_BIT) != 0;
+}
+static __always_inline int HelperRead(unsigned int bits)
+{
+	return ((unsigned int)bits & BPF_PROBE_READ_BIT) != 0;
+}
+static __always_inline int HelperSendSignal(unsigned int bits)
+{
+	return ((unsigned int)bits & BPF_SEND_SIGNAL_BIT) != 0;
+}
+static __always_inline int HelperOverrideReturn(unsigned int bits)
+{
+	return ((unsigned int)bits & BPF_OVERRIDE_RETURN_BIT) != 0;
+}
+int bpf_set_security_helper_bits(union bpf_attr *attr)
+{
+	int res;
+	unsigned int bits_to_set;
+	unsigned int expected_bpf_helper_bitfield = 0;
+
+	bits_to_set = attr->security_helper_bits;
+
+	if (HelperWrite(bits_to_set))
+		expected_bpf_helper_bitfield |= 1 << BPF_PROBE_WRITE_BIT;
+	if (HelperRead(bits_to_set))
+		expected_bpf_helper_bitfield |= 1 << BPF_PROBE_READ_BIT;
+	if (HelperSendSignal(bits_to_set))
+		expected_bpf_helper_bitfield |= 1 << BPF_SEND_SIGNAL_BIT;
+	if (HelperOverrideReturn(bits_to_set))
+		expected_bpf_helper_bitfield |= 1 << BPF_OVERRIDE_RETURN_BIT;
+
+	current->bpf_helper_bitfield = expected_bpf_helper_bitfield;
+	res = 0;
+	return res;
+}
+#endif
 /*
  * If we're handed a bigger struct than we know of, ensure all the unknown bits
  * are 0 - i.e. new user-space does not rely on any kernel feature extensions
@@ -4913,7 +4952,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	union bpf_attr attr;
 	bool capable;
 	int err;
-
+
 	capable = bpf_capable() || !sysctl_unprivileged_bpf_disabled;
 
 	/* Intent here is for unprivileged_bpf_disabled to block key object
@@ -4925,7 +4964,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	 * and other operations.
 	 */
 	if (!capable &&
-	    (cmd == BPF_MAP_CREATE || cmd == BPF_PROG_LOAD))
+	    (cmd == BPF_MAP_CREATE || cmd == BPF_PROG_LOAD || cmd == BPF_HELPER_BITS_SET))
 		return -EPERM;
 
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
@@ -4938,7 +4977,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
-	err = security_bpf(cmd, &attr, size);
+	err = security_bpf(cmd, &attr, size);
 	if (err < 0)
 		return err;
 
@@ -5056,6 +5095,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_PROG_BIND_MAP:
 		err = bpf_prog_bind_map(&attr);
 		break;
+	case BPF_HELPER_BITS_SET:
+		err = bpf_set_security_helper_bits(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa..6168da0b8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1998,6 +1998,10 @@ static __latent_entropy struct task_struct *copy_process(
 	const u64 clone_flags = args->flags;
 	struct nsproxy *nsp = current->nsproxy;
 
+#ifdef CONFIG_BPF_HELPER_STRICT
+	unsigned int bitfield = current->bpf_helper_bitfield;
+#endif
+
 	/*
 	 * Don't allow sharing the root directory with processes in a different
 	 * namespace
@@ -2102,6 +2106,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? args->child_tid : NULL;
 
+
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
@@ -2490,6 +2495,14 @@ static __latent_entropy struct task_struct *copy_process(
 
 	copy_oom_score_adj(clone_flags, p);
 
+#ifdef CONFIG_BPF_HELPER_STRICT
+	/* Only if explicit set CLONE_BITFIELD or
+	 * the forked process has both CAP_BPF and CAP_SYS_ADMIN,
+	 * we will set the bitfield
+	 */
+	p->bpf_helper_bitfield = (clone_flags & CLONE_BITFIELD) ? bitfield : 0;
+	if (capable(CAP_BPF) && capable(CAP_SYS_ADMIN))
+		p->bpf_helper_bitfield = bitfield;
+#endif
 	return p;
 
 bad_fork_cancel_cgroup:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1ed08967f..5c4232d45 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -39,6 +39,16 @@
 #define bpf_event_rcu_dereference(p)					\
 	rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
 
+#ifdef CONFIG_BPF_HELPER_STRICT
+static bool check_bpf_bitfield(unsigned int flags)
+{
+	unsigned int bits = current->bpf_helper_bitfield;
+
+	if (!(bits & (1 << flags)))
+		return false;
+
+	return true;
+}
+#endif
+
 #ifdef CONFIG_MODULES
 struct bpf_trace_module {
 	struct module *module;
@@ -145,6 +155,10 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
 {
+#ifdef CONFIG_BPF_HELPER_STRICT
+	if (unlikely(!check_bpf_bitfield(BPF_OVERRIDE_RETURN_BIT)))
+		return -EPERM;
+#endif
 	regs_set_return_value(regs, rc);
 	override_function_with_return(regs);
 	return 0;
@@ -162,8 +176,8 @@ static const struct bpf_func_proto bpf_override_return_proto = {
 static __always_inline int
 bpf_probe_read_user_common(void *dst, u32 size, const void __user *unsafe_ptr)
 {
-	int ret;
 
+	int ret;
 	ret = copy_from_user_nofault(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
@@ -287,6 +301,10 @@ const struct bpf_func_proto bpf_probe_read_kernel_str_proto = {
 BPF_CALL_3(bpf_probe_read_compat, void *, dst, u32, size,
 	   const void *, unsafe_ptr)
 {
+#ifdef CONFIG_BPF_HELPER_STRICT
+	if (unlikely(!check_bpf_bitfield(BPF_PROBE_READ_BIT)))
+		return -EPERM;
+#endif
 	if ((unsigned long)unsafe_ptr < TASK_SIZE) {
 		return bpf_probe_read_user_common(dst, size,
 				(__force void __user *)unsafe_ptr);
@@ -338,7 +356,10 @@ BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
 	 * state, when the task or mm are switched. This is specifically
 	 * required to prevent the use of temporary mm.
 	 */
-
+#ifdef CONFIG_BPF_HELPER_STRICT
+	if (unlikely(!check_bpf_bitfield(BPF_PROBE_WRITE_BIT)))
+		return -EPERM;
+#endif
 	if (unlikely(in_interrupt() ||
 		     current->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
@@ -843,6 +864,10 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	 * permitted in order to send signal to the current
 	 * task.
 	 */
+#ifdef CONFIG_BPF_HELPER_STRICT
+	if (unlikely(!check_bpf_bitfield(BPF_SEND_SIGNAL_BIT)))
+		return -EPERM;
+#endif
 	if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
 	if (unlikely(!nmi_uaccess_okay()))
-- 
2.25.1

