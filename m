Return-Path: <bpf+bounces-41848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF799C582
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103301C22AA5
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D615F3EF;
	Mon, 14 Oct 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tc7rJU4P"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2084.outbound.protection.outlook.com [40.92.90.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183D15B546;
	Mon, 14 Oct 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897730; cv=fail; b=YAlkcd5YqJWvpFX9E1hftx6piORJP2trfOQ914i052nddAF4xxJhmAbDXEKKKhmGS9Cr9V3aFZK8DHVyl/cTD4StxZGvWG0AUK7T76ORNzPo8FYPREE0MDOqfEJ0wY//ahdUPY4uQNt8F9pLW3/5lNbPdrnrGIMROAHUkbgIrZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897730; c=relaxed/simple;
	bh=9ulxQdit+rGXl48oOMSNU2e2NGLx2VdX5OtigzaV0Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rqFDsFSeO11mFQc9dn7uwrFHl9awu/iqQDeICq4iNjYHBmxKN8R8YhNjik+r9EZc3flxcc7FuNUVnb50TdFXv5ZxtYyG6HsSJqSgAGFyW0F1sC++lDAXsRjQTNPQaoqxDFCVDS0qmVOYZr9scjyudSwDR5p12VA1WRoBj4ZAFEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tc7rJU4P; arc=fail smtp.client-ip=40.92.90.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ok9Z69uEpvftni1IXcZ2o0CnAo+vP4eLJnfQ3E4Rw4w2BotgRBb/sEuSwyQ1Qes6TKEYHK68eSpYb3khWiz7O6toza2Imm5zuge+fgF3aEQa9GNwdQVNIizOVB3MroetcIDLiNHVS3sAQMs4/s1v4H9s+12vkEM5j4sX3TquGHLM1kVMIpSMWzyxSykNtK187U/dAEeAGxUFadhROnkFcki3D1nUebDIueGb0hVBMj+mvayKRpAOCbnm42bpVVQGJhEBUlfBvKMxL7VHNsPZggNC8vO+v8UJwxzDgm5ryRNd3cgBlKBgMxlWX1BeQVuOzrpeeiEIs4faHvcPBEjagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRSsGNcek8SbuhFMieVURqPmtndJRkbAiZjce3o2z6k=;
 b=cZwKF5Ozb6G2xAlXOaI2mNt6FfmZuiQCWt81f4yWSZZA659bQPeY88pPVkSMaXuSZIx4mnQrBUhy0FF4nszmx+wtuMa7YP7y5knsl532MhgDqxpLT3ucP8YAfQBiXY+Ql4Si0iHTKk8Y4OMlVZYSa92IJ4k9r1vJL+cDetmZi8pESls8lYF0ToilIUBzkFR2LNV4f6zusjTGOpUuNOTXs3Mpqnx+eZaLJdEUTQntuV9OMZ9+ab2wbVEebN5C2rEKBX/8WRp9sZ0eQCMsSWrq4z09OaM4hc9nWCmvoTwZ0R10i4AfG5+M3XtUfXd54Z5klG16EU1W+0I6rgg/9Rm1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRSsGNcek8SbuhFMieVURqPmtndJRkbAiZjce3o2z6k=;
 b=tc7rJU4PorVPW0vMxEbWK/WStZ8MQ5aL/grOC5KlcxCeU0XmrmXKyUOZ8axJMsZuCiRPQPVFlXixadokvO7IgrFX/oaelw2QX2Mr84mjV1lJtevZ+pPtQeRREic2ylRGQJ6gTqcDdyCdPG4Gg7rijOcPh461ulyo+4sggAzBsR1K8XkAevoY3UbevU91atStZEp55AberZVt+Vgl30Zpp6JZtch+1tX7YNEzxKXZqQZRHFrndQNGdGpFOAj2gt+FeTOeALhkzIVFgtC+6/STBkRout0Ss4Pw0sadANZQiTyIVEMOO7ou7ZIl4bC667A9GK6VHw7j0+n0jg7LVOpKOQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB6949.eurprd03.prod.outlook.com (2603:10a6:20b:293::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:22:05 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8048.017; Mon, 14 Oct 2024
 09:22:05 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_task_from_vpid() kfunc
Date: Mon, 14 Oct 2024 10:21:08 +0100
Message-ID:
 <AM6PR03MB5848E50DA58F79CDE65433C399442@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::13) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241014092108.15948-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c566bb-2a46-460e-1816-08dcec31ab15
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|461199028|5062599005|8060799006|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	5A17Ez9hyJfntIy5ItYzJHFVGM3OeQuH0atADF5ciEmL8xsTHm4f8um5kVt8dpztjzCTiKEnri+kUKx9kuBlm0HSHVNRepfvy0jORQRq8SxQaBothLMJUMZMYKtAgZw6/lKznoQR+TpxRyrRfuTjhKdpCD9KVCIktnGBXfVUxMdWbe0XAEdsTQKXX1gPYCy7mEJuu1rbhCVQ3XxV5LOht0x1o38unDPtsapxVHbRy1ZdCGms9bsZUMAq36u6H5yI2MpnR233ZvRAaaW52eF4WAq799FYjbSqvbdRTq0LyP6JzoHUVBgI+es813lfK3QVBElA2yXHp08tKq6Md/JZVFGNAc+ULAgS8KzxOnRwkvP4EC7VraNUsCkq4IcDBZXMBYZz/i4KqGDRiKledKF+plTA1dz3q7gTv4reOBEEm0f9osCe+v9UlBP8kjmEJ6dR/bNp371AU8G0rI2SV5qTNW6XoL1TRWd1fBuFNqyywZ87oM1AMNqiZNQP67lY5kBxJURLdAoNuotZvwHIMM96qDcDzajtgla+EGQ6HTlbbwlEWip1os9opWjXD+tN2GCBfcnEbUFNGOUXfQt5CP3NIluNPxmv6jwqTMjMmK5upFn2662+QGyQ41C6bBtGaFc+UbjIQuo5btV3CcHLf2b0u4vshttOm0wZBugDEYvvhE3pFoF+UuqD4ZQyQ1OkVGq98KNaHPHEBTvZ0zFm0YjZqsWSjmZBrsEclGNQAOa6y2U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hZSpOXfG+LkAyjUPMJ3vJgBYad5RJMdBqLaWilrCli2hetcaHRlzo4WLBC31?=
 =?us-ascii?Q?kfr0Jzmxx7s0ytju9/klSuUwz5W71JIRfy30Pe04pYCzyC4HRs3v3fZVIDSU?=
 =?us-ascii?Q?KYtDtJOdVIZPguFXP+/lYh/KbWoFJ7UHycBsYByVmloBwrfneP8FAlDYbJ2N?=
 =?us-ascii?Q?Pz45DKc8eUaVV6U1IA5T3BJN3hkrSGhxQqbfyNaB2idg4FHBnabfPQ2/XG1Q?=
 =?us-ascii?Q?91Yf8CbZgxQ9fIuRupd+HknDKcahp/QBHWyW/ArgXQzQrr/f4teNOUmycA6+?=
 =?us-ascii?Q?NcrSbx5i7WwI5+rdqz3TF1y1Q075iLSnnmM5z8rk1ALPpP+6kRw8DnhrFSCu?=
 =?us-ascii?Q?qBy1Cwuc3bsvGCjlJ1uKkA2omBiX1p8Sk+9O8aFWZysLuEoA6ygeyi5ryosO?=
 =?us-ascii?Q?KOG2tUOFORiFn+VK5OhSnZ4GxfuQopQxk7K3Gk+tWuTXp8A2U0whqcs4rGUb?=
 =?us-ascii?Q?h5QvZ2XZAA9gy6c7LtA6+k7bon85jkEsDu5wkOl9+Vl0c4e6C4Gb9NxBUD30?=
 =?us-ascii?Q?LS3JzdMKyJVy+NXLuXTFnL4WyJtf/YKZNniCasI6puVaWMFuLxCa0J4aCVqD?=
 =?us-ascii?Q?GbC4LGQGPSmxb3t2rXZoyZxncfiPhi0IDgLHR4q7exm/jAx1mq3mTMxJZQEo?=
 =?us-ascii?Q?b5ymFhcYOjOb3rWM4h/rLF7REo22uqekBG7gku5ZS59NqXSeq1C342ZEU8da?=
 =?us-ascii?Q?WDvgjBNog0kqbMcipq6xmaXcY+ML1Pc4WYHG6CR5p8j2IaPO3Pylvc3E65+h?=
 =?us-ascii?Q?voZokSJ5kSLiMJOkcX2i1kuoaIfs9nub77meyneAq07z3NX/F0hzcMtWVzSk?=
 =?us-ascii?Q?qhVeUf2U7MKaCkNrYIL4cCUuBVpbIbZxgeS9WArP88QjrNL3acMCMi6qmQf+?=
 =?us-ascii?Q?6abbHPamcJN48gyHfjW4lN9U8lK/DoOLBS6L96t7TmZ2Dqe/F6PiHM/eSxxT?=
 =?us-ascii?Q?uhQGmwoCNMeGJiyZfcXEiSLdS5aANf2UNUh6JolYERc/pRXleRygAX+OSJL3?=
 =?us-ascii?Q?8iKGLqH1Obl4Lrw0RxSjfiG2iHG8KrPkIPIQhxLReA0v87FaZPs6TGGHZKBR?=
 =?us-ascii?Q?JCEp+g9QzziiH9kc/Oif6tlljfeXeNpuntiWj3ON/PTNKoAZ+plT4CON+Ky0?=
 =?us-ascii?Q?GqLLaqKAvZkwS0VbegPVvs7aeGYf0vuqmZXmCcjlT12t+r7DtjGmyPMSuCsq?=
 =?us-ascii?Q?ihOl67r1dLTTZOvxFTT10jTsXItup1JKvHeQCoDdgco+j6GpW+K4c/pmeM8w?=
 =?us-ascii?Q?ykbeRO8iBD0Ui+BUioBl?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c566bb-2a46-460e-1816-08dcec31ab15
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:22:05.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6949

bpf_task_from_pid() that currently exists looks up the
struct task_struct corresponding to the pid in the root pid
namespace (init_pid_ns).

This patch adds bpf_task_from_vpid() which looks up the
struct task_struct corresponding to vpid in the pid namespace
of the current process.

This is useful for getting information about other processes
in the same pid namespace.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4053f279ed4c..e977c12d60e1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2521,6 +2521,25 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 	return p;
 }
 
+/**
+ * bpf_task_from_vpid - Find a struct task_struct from its vpid by looking it up
+ * in the pid namespace of the current task. If a task is returned, it must
+ * either be stored in a map, or released with bpf_task_release().
+ * @vpid: The vpid of the task being looked up.
+ */
+__bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
+{
+	struct task_struct *p;
+
+	rcu_read_lock();
+	p = find_task_by_vpid(vpid);
+	if (p)
+		p = bpf_task_acquire(p);
+	rcu_read_unlock();
+
+	return p;
+}
+
 /**
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @p: The dynptr whose data slice to retrieve
@@ -3034,6 +3053,7 @@ BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
 BTF_KFUNCS_END(generic_btf_ids)
 
-- 
2.39.5


