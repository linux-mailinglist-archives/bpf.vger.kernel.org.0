Return-Path: <bpf+bounces-34429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 786DA92D878
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFFCB23D13
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6E198A30;
	Wed, 10 Jul 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="A11IPz8r"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011023.outbound.protection.outlook.com [52.103.32.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0679195FEC;
	Wed, 10 Jul 2024 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636949; cv=fail; b=Uzep7RW3pV90tR1cmjutN2DbmtdVrhJ6sj7Mwe98BMXppnLRPpjJ6biBLmSlhDblPZdN4XSKrcQ4Twvnh7MqkhFH4Sgymv8gbCbefaHJODWmQXv8/P4VIusAu7Z3g/H/Sle8DdRKmtH13ryZ9Mra++zhdNwFfynRAtGD1cy6q2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636949; c=relaxed/simple;
	bh=68ZeJqTLuBJYkzmaoh0YN9JiKhSbyeUT2TEtHG/vdUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hd3u0FLty2AyR9yx4mh1rst8SBS2RBw+Yitg4qDyZNsgacEcB3t9+PuyXfPpCdW7k3xGLzugWoIpcGreoPHofBnKhCTXjFN1NBtCTLwJ60zLS3VZt47zxtB7jI7stpgJNgztJceBaOMEsW6Cr6BjPsxg4HaX3WS7fgUCVKPWC3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=A11IPz8r; arc=fail smtp.client-ip=52.103.32.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N21z5BLASZ216tw7BwUzTaNB980C2SN03rvnc3uVhgBLhZ8U0/v2xhLRyTBxYAdRhgMiWSa48wGDbQ6PXhAu2I9i8P5KC9LVsGhgevngtDCtcCwcG30J73tzb5AQyA/3mgbh9CgpCumjNudYlGVI4SHYU4F0z0mF3zMmZSFNeF9Jbd4dd6rrDAOu3/B2Jek2j5940j10MxMeLvGhyvizdc5wFMEkGx0DewzAcbjkTutE6gSxlzQxieXWlG3T61WMZhcOKbV4UtwYbSM6pDumzK/JVS78GgS9Xrvz5TxdiJrkiSts/D9SdkEEnOyUBWo8qg+Dh/c+22Rrk6c3wwopEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1gZgNFQyoMOGPcHOBcOcZNQdBZH7a55AdBJ79c033M=;
 b=dETI/SrEp/Af/0TtN/3JSA1Rz9AUifQfUsZNwGrWTDsfNawwWGSFd3PjRCVdLKMuDhfuU81NotcCceQ+uGDGKcuraqQcKfHFqcfUiWpLmBTW2HTyrgJC+nASaNfqxN16+9yWj+qOSzye+lt6Hk5/VCBuBDm3Gqz7KZjZ8qs9aLa4uFKDT9BOXX2Vi7CRYSYFaW73brweMw0z0o+iiXQRQMsR1bujtC5C3LF3pEBTnhwbNSJ33/MMDASQGhkA9zLQT4J2ueS2k5uXGaP2zobfJweo6B3f+vC/EQgWfTHwNNEQqq1W9qtoRrdW1Gtd42j8QmS/ZVocsXHDoW+rqpbBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1gZgNFQyoMOGPcHOBcOcZNQdBZH7a55AdBJ79c033M=;
 b=A11IPz8rjQn3r7/VUzfMBBkmgN7lgkwcmkcoS5FwvIreIUYMchQSsBy07gyXB1GCClIndS1dHVHenRrRrIRqKulK6GSp4P0iWlTPxdWwGO4le5OWLvL4Ycx8Iyuq1YHS1Z5jVcRe8q71h+gXMrRCtXZt3+QUceBxdg61p5I0QJP5wypG0QayiGJDka36lHGa+5BiTy3jFbXXP3k5Vwy2BSQXW9hXR6LqQ/Xc5upMSFyHPV140hyG7JXu5P/JaBz+0DDHUTxkiDh1kEC2YNvNSSt9J5XAIRAGlvcbCkp9OnRwWFTAXzcNtCF+bR39Bs7PANeqqJVHgD6t/8f5lYwXUQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:42:23 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:42:23 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/16] bpf: Improve bpf kfuncs pointer arguments chain of trust
Date: Wed, 10 Jul 2024 19:40:47 +0100
Message-ID:
 <AM6PR03MB5848041E79F59D597318810999A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fSDCC2H3DBWTKCHG/fa2Vl1QvsEmDSPf]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: e3de36e3-0e28-436d-2bb6-08dca11009a5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	BsdVF2tcuhSJwPGhl+Or9BK1KayexPcb47cahfvWIa/DMLxKAdk9AdsisBqpHvvaDy9W6iVu/mlOG98b0nHPAZBElMtdOIdXWgfJ8mCt+PeKWVsa3CsqehRI8E3VuRsmvV4dDG3Rp+6r0HZJb12VUqoBqPlA418OZPg/ZBASkrPj0A+aejoGPrnMIVikPtUm8Pq6n1KeZSuzPtiEfKFHGmBpwfs6HwYVSRw0BUeE9s3Q3Ycs4sM5+WIqjji9Hv7gghpAXsvNQemdTspUZuQ/JWUkIxjWQ09N+5ODmZQAIhOK1Sxdn8eJMx/hOuLcpJbMrVG7OIfGV/7g+hv75chfWz8GxCawg9CmA/C3Adsj/NflJTKiRDPL8tb6F33lGl327iDLw32dxWUioE/2XE/DlkaleYakCw+hzziRCsPfnCLS2CBRXImgjtUzQOb0YLEAmGbybg/4N3W/Kmbq9zgWwSLfAxus1Ru4t2QtV/fT2qphl9o1KlCYBXzZALp60sjOTjQAdfSZ5AohXC3/aU4CKchWv2wPKiczNB+2ghb/qdqEUtEA3pxh2RfHn5+NApUiYqMWF5UYqvUEQfDtHj9Kf+rnYGgR0uID1dw8EU3GmdTpx5zgE2Z5F2s/cpoCGlTByno2/C7Ez0y6nu430TLc3g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvGI7R/NMgQJIMNY+/9UKmndh2Fmm+JPwThFb0I539FiVfvuQDgvjDqPHne5?=
 =?us-ascii?Q?uEIBOArudwQkqQ6dKDWa8tWZ3aZ6P8TyS3yy6FRoyz8+WEjdU98vFYMSrQeL?=
 =?us-ascii?Q?kLtGMJkNeomL37cV6dVeVRMFbM4kwSrcLVX+TjkBUJoU5aMKKxbOiE8JfiYC?=
 =?us-ascii?Q?30HyNvwfwIzCxVYu6ZfM3wYWbNT7EVprJj9L5KKuCQ7rZBkLohOUDDjuJ66l?=
 =?us-ascii?Q?ZopQFSm/rG1660nfsaTwO9mz39EPFmDiwzMXG4KqN4fEboKJ0mHFe/sMSR+N?=
 =?us-ascii?Q?3cjViW51j4JajEMqwQ8rdNeHkCuV7kv+lDa0V7OU8gxKOGAbU1mIdV2lHwk9?=
 =?us-ascii?Q?Uyemyp6S1m+ICYOA/mKYilzl4vkmDC+YhpmUFJr49YOSRcn1KGpHzAufIvRY?=
 =?us-ascii?Q?iEvDnG+B+Xz3iY63SSlj0sb0IC0wLSKxLvSM1WPd2JDSVdbodsTeJ5UuhWGB?=
 =?us-ascii?Q?uwVHIYKZJ6EOhChfB5tQHrh9RpFYz6/FFAKyrcV3IOS7Kz3/qeyvM5D9DS/m?=
 =?us-ascii?Q?ks8K10z2o/mpg6jlQAcMQVJMy+k83RQLG5A+Y0XWQ+wEKzrvhJCwLhn0Vb4h?=
 =?us-ascii?Q?2DwBo93d5ctpW6eD5PuNNcrdUF+Xj8nYcOCbO23tX0CiexS3oGQIhx+/018q?=
 =?us-ascii?Q?P2iVE/Dmp207rE5nscFu1nGnksbhzGnYaAX+rFMOw0sltbC+8RW2oUqsDtFN?=
 =?us-ascii?Q?V6Z2/a12X+ObZ2SkYMfUK0ag/5FD83hd+p+RSsdTe5/C41qjKrKXsGkvPazA?=
 =?us-ascii?Q?MvQt0NgHF8SSU4jPqu3SDWCg3a1qhDZPtFk69MDViEq4xeDtI1xYSCPYTtSN?=
 =?us-ascii?Q?aVOdXU9/Vh5L3PRLZdwQgQFRGCf4B/PKg54VQgAfsbq+7B6xe6K3SQlU3WnA?=
 =?us-ascii?Q?xMvOoJgAnaM2f6QwoneO93TbVNyhYmn1qGJGryMTA2hW2B1baSHQAeMP6Jwi?=
 =?us-ascii?Q?wHGjGSu2mKR6NUQT4F8xVZHDALmnbSOvsv96blZqOpwWzQGlSlpXqFO3wYiS?=
 =?us-ascii?Q?tppxGNVDK/p4ui+aAcctaYQQMxXl104xpdsAvse0DSuezthw7ggwp7kfLxmb?=
 =?us-ascii?Q?7q/m5ipyQhGc9G2wbiAd9saTG5BM4Wg2DMvqXsQOkxyI9Lbn+5uuQRGywmyq?=
 =?us-ascii?Q?MmhlpT9GPnvdhQahQvZki4NkxBmuCvfnju4kYNh7e5MYGp7/LBbyg17A4bRq?=
 =?us-ascii?Q?8iDdC3fPq8vob1YioUFhvbaAx12SghpdFNftm5X1xwfxdax/c7aFxjI9l0Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3de36e3-0e28-436d-2bb6-08dca11009a5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:42:23.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

Currently we have only three ways to get valid pointers:

1. Pointers which are passed as tracepoint or struct_ops
callback arguments.

2. Pointers which were returned from a KF_ACQUIRE kfunc.

3. Guaranteed valid nested pointers (e.g. using the
BTF_TYPE_SAFE_TRUSTED macro)

But this does not cover all cases and we cannot get valid
pointers to some objects, causing the chain of trust to be
broken (we cannot get a valid object pointer from another
valid object pointer).

The following are some examples of cases that are not covered:

1. struct socket
There is no reference counting in a struct socket, the reference
counting is actually in the struct file, so it does not make sense
to use a combination of KF_ACQUIRE and KF_RELEASE to trick the
verifier to make the pointer to struct socket valid.

2. sk_write_queue in struct sock
sk_write_queue is a struct member in struct sock, not a pointer
member, so we cannot use the guaranteed valid nested pointer method
to get a valid pointer to sk_write_queue.

3. The pointer returned by iterator next method
Currently we cannot pass the pointer returned by the iterator next
method as argument to the KF_TRUSTED_ARGS kfuncs, because the pointer
returned by the iterator next method is not "valid".

This patch adds the KF_OBTAIN flag to solve examples 1 and 2, for cases
where a valid pointer can be obtained without manipulating the reference
count. For KF_OBTAIN kfuncs, the arguments must be valid pointers.
KF_OBTAIN kfuncs guarantees that if the passed pointer argument is valid,
then the pointer returned by KF_OBTAIN kfuncs is also valid.

For example, bpf_socket_from_file() is KF_OBTAIN, and if the struct file
pointer passed in is valid (KF_ACQUIRE), then the struct socket pointer
returned is also valid. Another example, bpf_receive_queue_from_sock() is
KF_OBTAIN, and if the struct sock pointer passed in is valid, then the
sk_receive_queue pointer returned is also valid.

In addition, this patch sets the pointer returned by the iterator next
method to be valid. This is based on the fact that if the iterator is
implemented correctly, then the pointer returned from the iterator next
method should be valid. This does not make the NULL pointer valid.
If the iterator next method has the KF_RET_NULL flag, then the verifier
will ask the ebpf program to check the NULL pointer.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 323a74489562..624f1e3d6287 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -77,6 +77,7 @@
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
 #define KF_ITER_GETTER   (1 << 12) /* kfunc implements BPF iter getter */
 #define KF_ITER_SETTER   (1 << 13) /* kfunc implements BPF iter setter */
+#define KF_OBTAIN        (1 << 14) /* kfunc is an obtain function */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51302a256c30..177c98448b05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10819,9 +10819,15 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
+static bool is_kfunc_obtain(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_OBTAIN;
+}
+
 static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta);
+	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta) ||
+		is_kfunc_obtain(meta);
 }
 
 static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
@@ -12682,6 +12688,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
+
+		if (is_kfunc_obtain(&meta) || is_iter_next_kfunc(&meta))
+			regs[BPF_REG_0].type |= PTR_TRUSTED;
+
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
 			int id = acquire_reference_state(env, insn_idx);
-- 
2.39.2


