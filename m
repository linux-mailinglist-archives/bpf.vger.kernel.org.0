Return-Path: <bpf+bounces-37497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C969568AC
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 12:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A131F22FB4
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B9161322;
	Mon, 19 Aug 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k+J/H9RY"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010002.outbound.protection.outlook.com [52.103.33.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B151552FA;
	Mon, 19 Aug 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064052; cv=fail; b=P3IYUwYYuIBEx+9hW2fjtVcpA/1We9p41ZwvmiWmupY06IpfLAUf4SAv25/E+0RAC/f5j9rpmlVP++VLxeUBGlasmRJNVR8rj2tSDidV4X/Nkt6fypwR8yKW0y5ZF95ik2FZZKdKkfmUqRQy2MJtXF3+I0Uc2cEOtdAjHT89XI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064052; c=relaxed/simple;
	bh=NAVS3scS8eKCsTZUFV29IKnnZ/JWDI2m59C2GsuYQUg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gFjyJQFfEvbUuv0UHIB3z+t4K1lENM8q9R+dEafwmdi2mkn3t89Hf2Xht33jBE2SPkDpjculP6wyjsn4qf/Jyo6MaH9uidlKqwslOcCNaM6v6p2W/w2ONK3DLZKv7kK8maad0EXbC/xUqfy62mXdwcUlCmTs0BBdkKTDXRPldl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k+J/H9RY; arc=fail smtp.client-ip=52.103.33.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYqHlQ1sVVJEgXx1O4Za5Ss7VZN/2kkli/Ro6TuberT2Ahz+T9y4pjDPUge4TgEB0d+QTYD2wA+zgvJQJDCyFBtj6/597OYI8EZRtc4ePXW5UUAkZ7kJ2fwZW7Sh3ZbEPMYxcUOsxXZYPKU1TtbjWe9X5PCeBXXZjkt4tHiYZ96dL0TLFbUH6kHjXj6mPHx7zBVHzPKQ/iOBG4bAoYoPiDjT3zuFF+VXXYozTduPndslOKp5VbblPlAuIZt4NutRWpla7quE9gYVpEMiQWTrv1z511ZTx329Fk3cxgSr9fPaCEACSy/KinZrPSeY3bCU6ODGOWQYKoajnw26tmFUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XkuaZVQFoDNxPfcFlKmF4QYyD4QmLNnHtT73a0nLoo=;
 b=M3roTjHqcDV19hySAKps1pl5shQ5XRR8C/9sJr/lqgS/ZX6iNDwNL23WRDzSbNQJENeW1BHWs0B0Q/f2NTpQ5oJ6ixzNmiWhYz7Q2QUn7ycchNHqrsI5i3XQqUAbN3oO3DVUWX39Lmhbe0sogDp2YoryrP2eAN38MKHI2FA3YJTK5Eg+t7ZJeJZCsDf8XuJDTq3jTGp2RBCLwnsZ9LHVDSaCs/390/LV0k1JikD1WA2IJqjJ/1HbDiRumPCsXXrmprasGiDeGkN7tMhkJ9Dzvb5Nl2Z2egss9dz7yOob0Dw3tkS7wP+pLb6e/CcbegbOPdTnwA3rpbt2SoB9WbgR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XkuaZVQFoDNxPfcFlKmF4QYyD4QmLNnHtT73a0nLoo=;
 b=k+J/H9RYTmoK94yFuQvWoRHL/9YNC3bflpedkdC7566UdE0dtbisV+A/YG+sa8WjOOxTtLujSST+8NzXl1+zupkpRDYiaf62CdNcXZNeBFdSkytStkP9Tv5wZHCUPzber/6cxE3l/amOqLPzkxMbOKghTaLHqwXYxxRjweejfBFexVvYQapakRUlpBtXW+ePqEfD52e67S5p9eYme1KWhLtK58imr+G8M9pYuAIMjDjCNXmmCQOuQPq4pUELFkRjlTfRcDonAbdkYPoPC63YLrzxoaLIt4maw/PZgzCxnG51cgVblKWYRKH41wFo0tgCZiE2fMng5dnCOiGxItMjFQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DU0PR03MB8195.eurprd03.prod.outlook.com (2603:10a6:10:321::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:40:47 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:40:47 +0000
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
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 1/2] bpf: Add KF_OBTAIN for obtaining objects without reference count
Date: Mon, 19 Aug 2024 11:39:15 +0100
Message-ID:
 <AM6PR03MB5848B74668D71BB307BE59BE998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [uozbihEIcUPRVREjyYpxifN9hy6PCEZ6]
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240819103915.66703-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DU0PR03MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 935e8052-c784-4308-b1b7-08dcc03b6295
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799003|19110799003|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	USioZi4P6A8NSLMm9bw9knUpsVMW4vH6RmzSEoTzU7UNXStz+dI1HDkJfE6z2xPzo7v0Agg67M4jkcqCBWlYnrQ5CcsNf2Kb8wjIXLB7QGet2F2ElaoseHR+ynkWrBUzu1CX6wLz/suFN7fjtZIbG33RMVb7fY2hL3xsPCQq/RkLkMUlzohy/BsscU07rPtLWJNqxzzhpDOjiDARA2qpt8kKMC8P5fAKn4GxSXuedwGvrUqpAJl6NvBBJb9D5dEv+eCpYxg1U3dobnVExv5dfPrcJpSHuOgdZdcwmyd6H8y0+5t1P70q45PgiNnh4w22zHrCeYiid+MJ7+twMY4eD98iZuJ/tZTXx8qPuUzQeRjLzAFgEpIg6w/aHVl7iRe4Y5dPgugkUN5b2shvFZ3rHr5jkeshi5y36U6U6UxiQttkYjDisxVDeRAN4OKSAKujChk6EQ/oVQr2BdYrTDEK2B/UxUGDTPuG+4TFaTPwG3TFddxTyNhqmX1ElM0o5WiSFGQGy3Gqz0zSLxQSP2xxCNqzH5NHMw0Ba2JDH3pd53GRYkzU2oXAxJQbTgRi1WZUEgi+NOy2kxAmFDDSGoe3DDqfET/4Kmzvaoh4j2CnsT0+l2YbzkDR9Tv17bQwhjFWicu27ZdCdoK1WI0oVvqbF4YsfILH6HyLF6aEy/emSVotLXnQHD0RIu9BHD26VgoUP6b+7eHALWomg2dkCO3+EQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ihxQ0hQw8l14c5/PHHvbuDLCJUdCA+dEFgTpc4kCGMvP72toJ5lgC7jWXzJL?=
 =?us-ascii?Q?O3NTCchaw7iHEoi9O5/4x2fAqN9vGTqSbHFpAh9JLggDuNAhHNvHdNe/m7sx?=
 =?us-ascii?Q?X6yqnPhuqT097BR+3xk1ElVVipA3BfQJX59Ds2mN70FC6dbSJjE5VLZtEPHm?=
 =?us-ascii?Q?Cs5Ggauq9nBbfN1WsBW/NdkL+OR7hyhoELFRSIPzlpU2ldoyILl63nYTSLKe?=
 =?us-ascii?Q?pkpGKN4iicpNbP56fvxY7NiLLy710egFZ/aU8PZikLT9lVPqQyCzDJR53XXA?=
 =?us-ascii?Q?l4q+uUvF817imvNLtjduwgzOCSxuHVZIHvjq3aZVtdkaiQ0J8QGW4r3LVOun?=
 =?us-ascii?Q?6TspvFcBug3G+97JqwnsMwZ2JyFUixGCl3ZUA0i6awXlrQlJCXBKHctvnx0K?=
 =?us-ascii?Q?lxF6j68F7tvl1ZJIX1xoBoM4EyyFmguuB8vUu6+AmXNVRsoo292xQ14luTmc?=
 =?us-ascii?Q?kS2CvFZMCLZka+FbdHTJ4igwkYzTmrQC0oW8N8OmaQwzB4ixyGFZ3+MT7R0k?=
 =?us-ascii?Q?sOw/sqO6GU4MJ/yzP5+geM1v5RYFdQEwsjTAQ8WxxDKE3OtDcg99ASBZDQcD?=
 =?us-ascii?Q?0J3mtEQ1qyfLtdGV/154aKk2jNxnaMchYbJuNjIcR2+J34wIr43lYBhfOf5s?=
 =?us-ascii?Q?tsuBIP/Yp0KxN4FOWDAV5jxR/Fxk2pudQ5/J2/bE41ZIrkBbicMqLMIZ0kvO?=
 =?us-ascii?Q?JzeX2ds8Oj74R0NKWzhldPq7CzC5AzzPqmLFqm8QgKr9RsWg7DwDQk9Yd8Bq?=
 =?us-ascii?Q?MCOlt18Y/HCdQtpPOqwxI2uK60DWiQ2vBQ9FJ+F6HBZSouWTHSNKk8u/tYOP?=
 =?us-ascii?Q?Fal1gGxfJP2+NE1ees6puds+q64MMYyaSOEjZipbc+hr8u1LHidCVzveG3mI?=
 =?us-ascii?Q?N2Ay0lNXe8IbfaGxZR3YNTIaX14nsoVSSN90FB02V51ENv/lbe6rbFsK4X54?=
 =?us-ascii?Q?qXu8hUb4/x/4wHOMCILOoIOXe5R2Sv70C6IdyiHKKQ7Bs0lvzpKpYGBZFzlq?=
 =?us-ascii?Q?lWgYN5Lh6RPepYt5+PopBEYJFh/dw7Qyu7lsLWd8vous8qvnSudW9FRHPQ5b?=
 =?us-ascii?Q?PtnzUDJqByXI/esz8g2kdS+CeZ1v3fiHx7ua3QT09IGL8+wsBTSSs8pAXqaw?=
 =?us-ascii?Q?sBCRxldSDMwXcmpQwv/+aAA67uXe3hhP9lfvzsgjCoArGZlZC4nP6cl5YsXJ?=
 =?us-ascii?Q?k1vOzherHnocyzmw3vLd5JJt0K9dUvX/CuPu/hjZ3Lvgvfb9/nqITBY7JeTd?=
 =?us-ascii?Q?Hw3mx7aFybnXACSPyf8m?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935e8052-c784-4308-b1b7-08dcc03b6295
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:40:47.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8195

Not all structures in the kernel contain reference count, such as
struct socket (its reference count is actually in struct file),
so it makes no sense to use a combination of KF_ACQUIRE and KF_RELEASE
to trick the verifier to make the pointer to struct socket valid.

This patch adds KF_OBTAIN flag for the cases where a valid pointer can
be obtained but there is no need to manipulate the reference count
(e.g. the structure itself has no reference count, the actual reference
count is in another structure).

For KF_OBTAIN kfuncs, the passed argument must be valid pointers.
KF_OBTAIN kfuncs guarantees that if the pointer passed in is valid,
then the pointer returned by KF_OBTAIN kfuncs is also valid.

For example, bpf_socket_from_file() is a KF_OBTAIN kfunc, and if the
struct file pointer passed in is valid, then the struct socket pointer
returned is also valid.

KF_OBTAIN kfuncs use ref_obj_id to ensure that the returned pointer has
the correct ownership and lifetime. For example, if we pass pointer A to
KF_OBTAIN kfunc and get returned pointer B, then once pointer A is
released, pointer B will become invalid.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index cffb43133c68..85e7bf9f4410 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -75,6 +75,7 @@
 #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
+#define KF_OBTAIN        (1 << 12) /* kfunc is an obtain function */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ebec74c28ae3..fc812d954188 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10972,9 +10972,15 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -12832,6 +12838,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
+
+		if (is_kfunc_obtain(&meta)) {
+			regs[BPF_REG_0].type |= PTR_TRUSTED;
+			regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+		}
+
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
 			int id = acquire_reference_state(env, insn_idx);
-- 
2.39.2


