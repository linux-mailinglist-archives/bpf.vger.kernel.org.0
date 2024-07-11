Return-Path: <bpf+bounces-34543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D6992E683
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D921F21543
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE261684A8;
	Thu, 11 Jul 2024 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KwP7v/T5"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011025.outbound.protection.outlook.com [52.103.33.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D667167DA4;
	Thu, 11 Jul 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696891; cv=fail; b=j/n056yJcM17VTe+MXDGX/BwbwrZdz9TM0uOAoVfLdM4GUnKnBCk3eMXjZLchzUJXrl+Nnz+5ji4yUTiyT7Mw3Axl9VlSVZyWkbWRvCTQ2MO1d1sxf8SStcsoVtfKx1Wkl0F0nfNlOPiW7vGzQ6h7maI6vskIbgc/TVUyRTLpoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696891; c=relaxed/simple;
	bh=68ZeJqTLuBJYkzmaoh0YN9JiKhSbyeUT2TEtHG/vdUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOoyKfbgSaOIP7htHYuTSDwHB+XTwCwQK10GxhnGWO8Igia7G6bl1u8G0S53/vQpTxf9DkX5sMgVqzsP7S147Htm4rE2B5bCmEUHd4nLY2H1FMaIWe0kocYX7PgQAqiPIrmadT0g66tB7flcMtbWQlG8taU7H7+jza8p2D+IhTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KwP7v/T5; arc=fail smtp.client-ip=52.103.33.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMxFkqRV7K1XiTwKX2IckRbNcqxUOdT6SUI9S2IsF8CTE2sYf3D4q5/4/BHN64qcF82I2K10D3he1W7Jw+0DLKwT3JQjxyj7TQjXIq56JbzwU/iNhSUNrYFhldHYdNgDIHvGm+TGSpWTX/OQWpifl5eTo7sjZl78/caNpMDchdPr6L+LH6+hKuq9MsBoopkUby60f2PP6WZZA9GA96e/g+OztHC1sMC8AOgt4TzHeLwCpTLX4wQsli2wjLzQC1cUreoAyqOT1CItEEuzDpYXjPVe1xIR7ric8yU/vgH+95uKnShC8Oo0oKAaKviTmqUZfclLlCz/rsthjdjkTPbIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1gZgNFQyoMOGPcHOBcOcZNQdBZH7a55AdBJ79c033M=;
 b=dt9fM41LSuDpFVcHDNBbCTbLnHnYQ6nODr5FChR8Q/NeoBcFlR9EEEPIlNm3RikmftPcN8Tj4g+Q1Jz8wU+Xw2giybCXjK/qF+AcjuZaSb8WuA4SteWy0sjZ3a2hrrmPu6WKBIFAa/VbK1c23CV7rZx6Nmy3BqW/3EqbO1v3yeGofb2q8ssQPFWfIqjDXwpwdwjYvA/pkCqJJjlvDVbSVxas4gGSiwp3KCQtspS0y/rHGOhxDrrCUkKDB+8NjdmFEs54EKA6fb7HiK0WxQJS/ncZFFq6cntVMym6Y6x7ld+xy5pr5M+DcF72qrBL0BrU1azkVfrkxqxVO4egTVTTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1gZgNFQyoMOGPcHOBcOcZNQdBZH7a55AdBJ79c033M=;
 b=KwP7v/T5kGic/2SRGkUQnIl1e3mQrGGp+0omDCacR0TVi3JmdfXruLnUOMDggnwhouHqQXek7sQCwS5GRfGCOakjgO0jxmO9dy87wtWwn6blNtT7JM2YaB5WazkOvFhVgqN4LN2QHZ7i+Q3FKF3zRxNiM0axxZhuiSzpz9XOHGiEy4mko34Y8dVy7u9IqqEFjlSa3Tg8LwQKnB02gcCOVb8tLPY7VUsd9ojBKAfbwRwOdceNqYPDiG3izsImcmWzj6Otw2xw5jOAqkL8oWxL67ELI9MaGmzefXTUtmXkko6aV26RVOpax+nNGIovLzvem2pNMozKqyL86Xg/YUN3Ag==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:21:26 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:21:26 +0000
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next RESEND 03/16] bpf: Improve bpf kfuncs pointer arguments chain of trust
Date: Thu, 11 Jul 2024 12:19:25 +0100
Message-ID:
 <AM6PR03MB58488FA2AC1D67328C26167399A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [pRr7CCEUX8+ZW7EgYAMRw0eoCz7JWQUa]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb0f654-729c-46d5-9593-08dca19b9a50
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	pvhBYfPuPoXPutHkeC9qCGOGmUc6bNjP3LgeNejck9rkOuntT1FcwvAtpPA3Q1rEJ0vtq0HGPr8GroDEwqX0QwJIFp40J2LK3nnuXMjnESgclbHCstbqrhjFC2Jaf6LgGYYttFv1zsAalmn6IqHNwUb/oNK2S4ioWCFQ3ZKzWTJ+gVXs/ipazF5sy9FHDF+dmbM0EhXPw3Geornseb85KpHhZmfvU5kIXNXeispY4DM7yPeHzMnxbB4AlhyPFWblFPiTOKxbhwz2lgx8dJhNIiEXFvmizrKef7Dlf5gW+DvV6Pml1+4XVGsUuCDU70w2jhATqroc3IiaQRvdlQjvGtf3cI0zDMEw7oYIVm21eHeRc8BVMNPkBu7+IpxMxkas9Op661JkYD6aDueoX0sSgd7s/4R0L3b66vgbfMlUncTtFmsqZ+X8nzhgCT29Af2ZICGZsfCzJqI40BgkDcuZzTk/+F7pZahufUQxjP840SzLsfDAuGD2FRGtVnpn/SdZQBQQ3l+ZfTkDAsC6Fa60+Vw9mlTbxl3WqpHkYDY6fgdlHKJnF5gaaK0VA5SFzdjA6wI1J53wqWTWAx4HBgb+2GOhr8nzzFLisbqJSk8f87o1PktNQS9tldDQ/Oy30H+F+/ybxXt7pAEIMmSTW6W12g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7nUFniG6IWVqoOTG/g/IeeFQX8CNuZ0ho008wsk5GwzlgFEI7/8giBtO+XG?=
 =?us-ascii?Q?AVzPGH9PJlxi5WybvpeyWPDa4nChgyhgeW3dVNzzt8E1H0rVZ9r5cRFro9EU?=
 =?us-ascii?Q?v3or/dUJfUxnNuarDpdiY5Ss8ioEiB5Fm1A0Ufs6FtNTU7UUk+pPh4yobF+y?=
 =?us-ascii?Q?k81CpMFFH6s+oMQ7/jDGlPeBsn29ssbSvEXbng01tn21O7IvmXtYyKoBgmie?=
 =?us-ascii?Q?Of5C0HAj9dCHe7UYRUlF3BTb3Lq/OHhhX4w9X8GpdH3/fsEkUyOpGLqCY3FK?=
 =?us-ascii?Q?Z5xOWkaezO+ZloRq6E2ZM5JF0lEa0oO+ZeAHBF+xOJViT97gFaa2qaYKDFDn?=
 =?us-ascii?Q?qTCNs2HwkKOr4uFlx5ztARldQOorsy18W+gt4wLUl3MbyuwjSdqtbc8ouPh5?=
 =?us-ascii?Q?S922dcRUOMNr+IOn3tL1Keruwxm2q99pLZ+3djjHIwjoc3+GuZK4NI9tAeSe?=
 =?us-ascii?Q?gGOw0QRBn78Ru14cpeLBPpRl4PkQnrEsdLg9MTt0HNsQiEbAvl5C3A4UWj9X?=
 =?us-ascii?Q?vaGmcOQjiNbUyWp+LSJOVLXRgmfpDa5bIwYFAZMddJSxYUH6JnjqjkoGAFLj?=
 =?us-ascii?Q?Jr32qOxVPXT86nDkhSydmwZ5YMblfzwG77OdFX883f7D2Ybsb5hgIixmZx3m?=
 =?us-ascii?Q?N852NFboreBgdyIxmTJxJbzgJsTh+MQMWYNgzvspgY+3tYEjxZFDzCK8Vtm+?=
 =?us-ascii?Q?pdSeKyIbe9PtGS3It/JFJc+lwDx+CIVh+Rx7xzd5lsyHrJsqgIIxuePd0l7U?=
 =?us-ascii?Q?YIVnQDr6JkOUSpGjGOIOsAK9giSM+g2IQbvEoxfxEM6vJ/+wiLRjy6tEhjyC?=
 =?us-ascii?Q?Fw69sxpUIFpN/9JtV4LIV8T+UwE7muF4QDBNxjl1pB4to0lJ/ZALeTEp+bLM?=
 =?us-ascii?Q?5o9PDsjnJAYP8XrGKQ1U7Vq73I8jZEhf7gWs2f+80e1EfGtrGEsIVG4wrei/?=
 =?us-ascii?Q?fOu5oKp3/TnHM+KfBKsqgJlNspQrTDvHaZQXGCYzkVlTjDrNZV4ET1CBbdLR?=
 =?us-ascii?Q?U+MD/s9Xvk7CZcTiDytJckvg9mkHf3OfQ8BSxYrPdN7Kb/UDW5wDZWbQm7p+?=
 =?us-ascii?Q?79VtEjKSf81JPz7lydV4n7dAH1KSZ2g/I8w/cNP/oh0wb6iRlWO8qrlqyc3A?=
 =?us-ascii?Q?k1M3lSZbNgNYTktLOWeUsPz2thQr4WvhAUEX9deDTjhWPCSCqgX+Spb/nxHh?=
 =?us-ascii?Q?4CxlN05HrDpznam5WwpsV9X4Rh2RLLKXS/l/vYWNp3JTdx/AFNXcAn1Xu7U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb0f654-729c-46d5-9593-08dca19b9a50
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:21:26.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

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


