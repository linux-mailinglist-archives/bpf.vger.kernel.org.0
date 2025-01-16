Return-Path: <bpf+bounces-49089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C915FA1428E
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FDC16796D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4722DC2B;
	Thu, 16 Jan 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="URBON3jR"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2032.outbound.protection.outlook.com [40.92.58.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888831527B4;
	Thu, 16 Jan 2025 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056745; cv=fail; b=lRTjOdMOdBRXOoEi4TOMpu8BVzcHWdyU7q3yhSpqBZq45CLN6IpQ6Gxt0jYfe7pXNtIhyu3YqTqHnL4kd2WLCAT2EFxtsT7qkURGreNYb80t4WAxlsF0tVLdu5jkLdC3/XzzoO1cAbj8XIsR8/uDXjW7jzmsEO23gLvBPdJwBw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056745; c=relaxed/simple;
	bh=qYc0Mk+oq3SF5tEx3Oxl8JrWIBAg78j0UJctpFlVKOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLvIlDHwIRYoBtFn4KI8g0VnvRimmChVLwLXsyfdWthJuGHzWIllxWsgiO727du2Q0IpAIaHtRpvDb6r6DOeC4ZWWMI4TvpRk6ph9QTJGSru9ghGB3F6oTO+1WBC9yPITU1vw3Xxoy6NlLrmAHT7p5ySPzkqKuw3/J1I/E4YWg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=URBON3jR; arc=fail smtp.client-ip=40.92.58.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5RYbKvY2z7lR5rxoRRM7yLhqL38siMdiPLcoHHf4yGe3iOCnOlog2mHwT2aqta5K+WaTJpNJKzBJ+ZHubOw6HijrXfwZL1mPNkcBxeMukEQgYdvVHA+fj/5wKMryX24lRjaPR35llD7N35WmsUJRZrcH69+0zhAwg6ftmZGTbPlqk6jB/yocM399lqN8x52NERnntpPTEcyQoXTXBcIpXmZupA01fiW97jk4h0KjclZq+mKmmr4PZ2sNgbMhkRdOG5TizDzV5c88QO5F2MfhykwxIBh3X/0ovHZyXvYHE13jVw+7hHH0oHiHg7kcfWnv5JZRIhfzXtoSM1yglfh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ9YSceYPrJEUJzJz46nOW+u8zgXkOEFtS8jiMDdIro=;
 b=ycWWhJjjstq3xPHxxMzVlG8j+LAvqStuQ79Yi1WV4uJXB5AuWV2hZH145v9/Qm3jUTcgC1CamdhFw9WyfqYgeu6CjnGV4tCFagR8g6/eZc3v6CrqaWjrzswXSowoRgeV1997H9uiNXvFIbg6CY1sb5Fa+8TuGDD4QUAcHo/IMdjGWmaczZZvq3u1nOMNSjHpfDbAEyZyv90Xc3mI6LJRQ0wX15cIUIS0l+GdOj63iqEhHZKDFK5syrUQSesSuxpYiEqx2b9X19jCSvb6U1tHPTl9FPFeCUu3cEJ+M5018quzqdXuSI8YIdFkFgyH/ElhUPvt35eiEPLMrh+Jlmo18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ9YSceYPrJEUJzJz46nOW+u8zgXkOEFtS8jiMDdIro=;
 b=URBON3jRsF1g5ntykJHAFmBFUVtOpsRTTMYxKGzNcEynyUYajGCyV2DRt9aN4rWWLRwJonNrdv2MhCF+/py2RfjKKJMUi0gZwZ0XK1Bo4RBaNDQI4sC0vQMYBSJn5Cuog5ftgtSB7uqmcaXojtZsa6xhi4QMyr3mssWUL/MmkbZT1FbSl2euX44fFfebfxKQm1tx4aif0xoyXvnoWx2kEA5dVsGzqDJXY5hkV9sFINVXD2XG2yd26XO5mTxcNkESLA90uS+xyEt/O6ViEG4Wn8BXWjWuvdN1hbUpysoAbEgmdKiLCXXFdS71X4TPAkzckJ6Fum07ncc+o7V50uT9uA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7970.eurprd03.prod.outlook.com (2603:10a6:20b:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 19:45:41 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:45:41 +0000
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
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 4/7] bpf: Make the verifier support BPF capabilities
Date: Thu, 16 Jan 2025 19:41:09 +0000
Message-ID:
 <AM6PR03MB50800C4AB831C0983B756596991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250116194112.14824-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7547fd-5214-4a27-11c4-08dd36665b88
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQl3RqqletCEFdzMlpBSGXYP8fjZ5AYySPYTL5oCz2L4FhceluvsHVmhFXe3I2OznKbyKoEDa6/OrYjqGbYaDNqcxP0Zv/0l8xxPYs5QHukxpRD8n9ONTInkf4Q7WB/IFAmWtopuKKb/J7kGli+6up+Zn1fEElSEUnPhjH2McukRpa53Yl1E808V92CuY30rCmPCstIp97/J8mBSjRLyFQIY/F0W6ETuceDdI3VFsE/3G9vJyU5pztea20ZKbrfv+cS8t0wSDaBLbt7jjhkUsEcng71nN/QwhkgDJBCFMTscvnH9qTywNOtTsoIwXXxDB438vsqXHk547wxQ7xdN+by/XM2hJOZBngvLsaNBrgB+Lfp/d0fgCKvkd25ltshM5MlQvgqnV64aaG1CSJ5V+PbYp2+Y21AAGD+Cvf4dPQlBtOHIxbKNipNnvaqRd9Wbi24wksHTT/hpTlAKsHRTlyGEHoQi1WhDzmA+MnzO/GT7rBi6VAwCnKmG0c6otZUMhgdvEx4Is3Lf/x1O+trEsIjDtEURvwLTNkUDYypRwTqTMVIKHAegh0WhJdXRkCpoyQ3vGLSd41ObleSPqORU2nYasVWyzYxVoHlNe+2Jbs6TPJyup60eTKfQAzbpdQTkVj7LmWe7+HzjoA7zwVCx6KCQdHx248b7/ZlWcjdzaiKDrY1ZDtm9tUgEEhJZadGJfHgZOHc0YcEOJTDifRy/o6TcIn4VUjDkddk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|461199028|19110799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?77a3TJaYO8vym8xbDPuV+t+QvIUxAeMpWUalHZyA+snB3vbpzT/IRcSF55Nz?=
 =?us-ascii?Q?EG7GUhbobOSlqGwqTWCBGr2ow4uhf5HsgvGqrYwgHa2+zKCbYSRoeVFH48nY?=
 =?us-ascii?Q?Pm1niSexb+AM7A5AMnfa7POpxlYv2e66cA8p5ntNOVwhs4QWNR5mpAw+bhpy?=
 =?us-ascii?Q?nTAX01+B5dDNB7aHKFTVWG9NphMCiLxDK/RIDsTV1h85dIgi6xINxIBq425L?=
 =?us-ascii?Q?W6pv+O4onyIBAZcX6/wHEafy2R+7Mc8YmEz+k22xz2ONCAzXKyJ+vlPap9m9?=
 =?us-ascii?Q?AC4HIeBBTqteIA//TwN1i/7M1fLpHKB2O655lQLFbjt0SvyqN20ukwEjuUUv?=
 =?us-ascii?Q?9l3m8u9JFDwgI1rGpNeIlt19/ogyw/l+usLVLPbzd8Bm+bHz6QwYXMR0DAbH?=
 =?us-ascii?Q?ldA7L4Ks+kRnbiOpNuQq5gmm78hpdAq/g0uHCmSszyumSHZnhweXp/FGWwG4?=
 =?us-ascii?Q?/MD8gtS9Gmt5BHGR4GZlLvgTtQjHlFAi5NYg8O1Df9Od38+q0Pu3Ys+ppzyM?=
 =?us-ascii?Q?2Nq+VawA3Ilz4u6iybYdmdqOnA5Gy18usg4e3KgYeYjLgtoj/S/Rs+CEF4gq?=
 =?us-ascii?Q?M5UGFoiLmPpRhlb/nfI1OgWVurjo66SEaQFEmyTfvx6pho83EGX9JnK1YVJX?=
 =?us-ascii?Q?hq2vosej7xvQ0aM6x7GixS0ak938qsOWQPc3fWJG22GCpICsMs+o5RjzyAGU?=
 =?us-ascii?Q?ztU+aTjm9Tmjmh1WwM3aqPHQxqvphhtmzxn8jyiMgCdGOOdRdnDHdhmzzr/t?=
 =?us-ascii?Q?kBE56AbZJnu/+zcjQCLFr730GDn6M/JvnI3K39sOoUbdQAktq9kC3PMJyBTJ?=
 =?us-ascii?Q?BnIDiHmo3S0beo85zn8qbLxkxenWAVd6CZj9JlR/HV6fud91o9g+iXAnfyP3?=
 =?us-ascii?Q?EcKWpgK+QCyiT801ZJ7RtaZam9JPfuimLar+V9CImF803oa2T6sNSJn45X6S?=
 =?us-ascii?Q?Uk7wRVDCg4PPm1+ipVCfXbwZh43mJrIOzD4QB9+y1GHi0nVgcFvgR/dqcWC+?=
 =?us-ascii?Q?Sp+aJMiFmCv4iol0JtfDeHZx8KyQF8SqTSjM8QmFYyzy/Wzx9Y/Jr5eraJMJ?=
 =?us-ascii?Q?+Nqg8z3rCKijG7McGHGFdfIm1slUiA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?11F2Z5l3OJa46IKzeWwnMEvFaW7TdRNmyMlcqd9Cg+tJ07eBMbSWxL49OxJF?=
 =?us-ascii?Q?BJdelkTO+9jeLenSis72qV3jFEp8Iq9UObeEyo36nr4pWi5Gq74yFgkFztBF?=
 =?us-ascii?Q?MTyABRQEbt8+1wDmfcy8MXic+l03g2B9gv6qvZ3ecVWZzd9oyHzMipm3gHht?=
 =?us-ascii?Q?LHjks/jQCZEgSxTbyV0W1tvJTV4fAQVm8cYk8Lkhc52AV5fGiJoDIK8WE8ne?=
 =?us-ascii?Q?875SC2XfuHMMnvbFFlgM/oCVU4YHm4tciZNE+fXrK3AgjA4j5PKppetLlNfs?=
 =?us-ascii?Q?Ztu4hW3cK+HgfrTwEi9HCz8rUkcnoduTdQIes3dHTuoc/LD3QcGL97airI9i?=
 =?us-ascii?Q?v0y29sFhiUTdMnNBWSlDN99+4X7c//AULehxdw0xLirimBpy0TUwndXC0aXX?=
 =?us-ascii?Q?D31g3jjwZ3CMoRBy5MZ36FNnbJIhV1N3CeLm7T/buzo+fDJ9Fm6ELd/XnXvl?=
 =?us-ascii?Q?/8KyIHj80by3zVh3BWOp2wiPTfzytybvC9XOqL68aCBsghCZoY7Wto9/VDTT?=
 =?us-ascii?Q?WqoOKNiP3Gq6u7vcBT/qxcaEJ/jbsdv+X1Hg8zpSUJHGgdD0Vgf7eo1ImeNJ?=
 =?us-ascii?Q?3aw93hs7wnxlYxZ6GUrNydkYeiMXp/rugM3mqfqVDwobbewZPE35fNEnFLJM?=
 =?us-ascii?Q?PID1c6MIQVHBnGYKXbd/ntoBWhoAI4AKWoW0ARFhtRR7d8R1DETpoya7cJa2?=
 =?us-ascii?Q?49cKYspkBQROHr9W6Q3Tma4CMqPmj0iT+VGrZzGHvt7nB2/AcwYXgYo12Y+D?=
 =?us-ascii?Q?gmgYZHGV+H5AvcD6kVqKl8lVKkafXHppQd/lScDUv+ssd/Sk+HCUC7sT0zOn?=
 =?us-ascii?Q?cIyEORXlaQjVWJAsZ2hXJ2wk+K3YQy63g1zH9y/pQtY1hfPCWjezxkjGiLlq?=
 =?us-ascii?Q?4EvClroKEigxPwA5Rb/yjrHok9ibakf5lYPdNutS+uLC8Mv2fJ3P+zBbJFRj?=
 =?us-ascii?Q?WYP0xwg3DIdcpYCrDSsgHRy8fcCvBdRUeIu92y046WEXzn31mQkfyHzKLXaI?=
 =?us-ascii?Q?f2EENtXaq+e2MBOjrula0rX7/LLOiQx/nIQTGJIPjM9NXt1kdhDvzx069p7t?=
 =?us-ascii?Q?xJm5hJ0sZa2Ass0Lg5rRePNyiBhbSV25bFW7zmvuN38tqYtbiDuswJvZ1MG5?=
 =?us-ascii?Q?P6Ldiu3hraMCFpLhu0gvAfoNLGSEH82S07pTBXJHVgB/1q0zPf5EdySeXhzE?=
 =?us-ascii?Q?78G8oDG7juLhF+GMbbkt+lqj42NID2ryeBqMAC3lutVM5VtHdtL8SV0KFGAF?=
 =?us-ascii?Q?IEXJ13K3UxGuEEcbMdkJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7547fd-5214-4a27-11c4-08dd36665b88
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:45:40.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7970

This patch makes the verifier support BPF capabilities.

Add bpf_capabilities bitmap and context_info to
struct bpf_verifier_env.

Add bpf_capabilities_adjust callback function to
struct bpf_verifier_ops.

Add check for BPF capabilities in check_kfunc_call.

Add call to bpf_capabilities_adjust callback function in
do_check_common.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf.h          |  2 ++
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index feda0ce90f5a..73d2ff1003ac 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1021,6 +1021,8 @@ struct bpf_verifier_ops {
 	int (*btf_struct_access)(struct bpf_verifier_log *log,
 				 const struct bpf_reg_state *reg,
 				 int off, int size);
+	int (*bpf_capabilities_adjust)(unsigned long *bpf_capabilities,
+				       u32 context_info, bool enter);
 };
 
 struct bpf_prog_offload_ops {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 32c23f2a3086..6d0dad5f756d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -784,8 +784,14 @@ struct bpf_verifier_env {
 	char tmp_str_buf[TMP_STR_BUF_LEN];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
+	DECLARE_BITMAP(bpf_capabilities, __MAX_BPF_CAP);
+	u32 context_info;
 };
 
+#define ENABLE_BPF_CAPABILITY(caps, cap) __set_bit(cap, caps)
+#define DISABLE_BPF_CAPABILITY(caps, cap) __clear_bit(cap, caps)
+#define IS_BPF_CAPABILITY_ENABLED(caps, cap) test_bit(cap, caps)
+
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
 {
 	return &env->prog->aux->func_info_aux[subprog];
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b8ca227c78af..2a321a641b4a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -30,6 +30,7 @@
 #include <net/xdp.h>
 #include <linux/trace_events.h>
 #include <linux/kallsyms.h>
+#include <uapi/linux/bpf.h>
 
 #include "disasm.h"
 
@@ -12917,7 +12918,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn,
 			    struct bpf_kfunc_call_arg_meta *meta,
-			    const char **kfunc_name)
+			    const char **kfunc_name,
+			    u32 *capability)
 {
 	const struct btf_type *func, *func_proto;
 	u32 func_id, *kfunc_flags;
@@ -12941,7 +12943,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 		*kfunc_name = func_name;
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
-	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, func_id, env->prog);
+	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, func_id, env->prog, capability);
 	if (!kfunc_flags) {
 		return -EACCES;
 	}
@@ -12972,16 +12974,26 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_param *args;
 	const struct btf_type *ret_t;
 	struct btf *desc_btf;
+	u32 capability;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
 		return 0;
 
-	err = fetch_kfunc_meta(env, insn, &meta, &func_name);
+	err = fetch_kfunc_meta(env, insn, &meta, &func_name, &capability);
 	if (err == -EACCES && func_name)
 		verbose(env, "calling kernel function %s is not allowed\n", func_name);
 	if (err)
 		return err;
+
+	if (capability != BPF_CAP_NONE) {
+		if (!IS_BPF_CAPABILITY_ENABLED(env->bpf_capabilities, capability) && func_name) {
+			verbose(env, "The bpf program does not have the capability to call %s\n",
+				func_name);
+			return -EACCES;
+		}
+	}
+
 	desc_btf = meta.btf;
 	insn_aux = &env->insn_aux_data[insn_idx];
 
@@ -16824,7 +16836,7 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 		struct bpf_kfunc_call_arg_meta meta;
 		int err;
 
-		err = fetch_kfunc_meta(env, call, &meta, NULL);
+		err = fetch_kfunc_meta(env, call, &meta, NULL, NULL);
 		if (err < 0)
 			/* error would be reported later */
 			return;
@@ -16980,7 +16992,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
-			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
+			ret = fetch_kfunc_meta(env, insn, &meta, NULL, NULL);
 			if (ret == 0 && is_iter_next_kfunc(&meta)) {
 				mark_prune_point(env, t);
 				/* Checking and saving state checkpoints at iter_next() call
@@ -22093,6 +22105,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->first_insn_idx = env->subprog_info[subprog].start;
 	state->last_insn_idx = -1;
 
+	if (env->ops->bpf_capabilities_adjust)
+		env->ops->bpf_capabilities_adjust(env->bpf_capabilities, env->context_info, true);
+
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
 		const char *sub_name = subprog_name(env, subprog);
@@ -22176,6 +22191,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
+	if (env->ops->bpf_capabilities_adjust)
+		env->ops->bpf_capabilities_adjust(env->bpf_capabilities, env->context_info, false);
+
 	/* check for NULL is necessary, since cur_state can be freed inside
 	 * do_check() under memory pressure.
 	 */
@@ -22385,6 +22403,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
+	env->context_info = __btf_member_bit_offset(t, member) / 8; // moff
 
 	return 0;
 }
-- 
2.39.5


