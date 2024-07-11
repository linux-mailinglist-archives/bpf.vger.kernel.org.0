Return-Path: <bpf+bounces-34549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F2F92E699
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A471C21AC7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC6F16D9A8;
	Thu, 11 Jul 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L3KgH1UD"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013008.outbound.protection.outlook.com [52.103.32.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349A16D4C0;
	Thu, 11 Jul 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696995; cv=fail; b=PU5/h4nLWmQYYZzzvoi71nAIsnlT/oiW71j9DvQ9m055tQMMY2hKON9gYL/n8ayh4hl55q0SZNnkpLZLisnNqvXy0BjfWJF5Zdz5X32wQlkjo+WAzUK/7ievfgGAEyqzXCaX/ZMCtMHzwljbaoii3mhEFMGdvj0E81xn8/MlcBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696995; c=relaxed/simple;
	bh=BZ+ao6oDtD30qjRDcCY34g+/0uU9zp5HdwclRLhI7EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p902c9B2BK5ZQ8i77haYOhDuohv3xNCl0n967PyihsEe2BN1J61d5f/20REcH8CL9XOend/kZtaYvjwC/dNdvL6c+pGqHZ5F1slkMKXqOESTjKUZqexdhMdaFrYNSsLvBKY4uJpTYDE++FLFw9KHAqRHYyRCRoRfNPhr+SQYg7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L3KgH1UD; arc=fail smtp.client-ip=52.103.32.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDlp/bwom+gyLsqgHlp1STth3Cp3kiZ7loCsZd/Y7D7QGTDRjIURx2tFdXnfpT2/xotfmOIIh9fuJ9Y1hQR8qPrdIdFRaT6Hfv16JcQcd05xa3HCLI0Im9CeshUEuF/TCiJbiClT4NzExLOT8cn9Jyux+5aMiU+eFwN9XLLOJg6+71f/mK/Kjns1mk/NOxaMvi2Fg/jZvCsT1/KiWk5xNEvKcx4WqLSwzEvcTKK4YSozhYIIrzq6dn1RhAwYWPwrv6PjhGSnL8Ts/vTJl1KPIKQqPdw4R3s647p7SeiOjIqjW5ku2vYKoxT6NxcnKfdsIUaxsoydhf6Xs968jxIhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEUp/ew7Ko4H7jVboFNJcm9Y9hE5ozL9AGtg1Unr0io=;
 b=mdHRgfWPzJ8r2n6PiSazfpzJVZftHQNXgbbnKydWykb1m4mkRSqHRasfQ0BvM8Dyyl+MiJVVn4BxdxLDKfWIjrTJvAT76PCjc9+cnzbSg22E/DsuayyMaK214F82uXl0pj2KQj6t7Fa57EW/7r8XU3Ebn6RCH5oyF6dcfTMunc6+JuXGGAlxfNfD2qesJNIjiIp4D/ORN4r53l6GqVhXp3cP37XVZI49bkPdUKM5zbYvCwggEKol/+VE9DnIAPW9eVIEft2eJW+htBuNQmG8xz3Ules69QmBGZ1pRKmESPDGUqZFC+jQP7uGW4aya1swqXAfgxx4MsJ3z+wL3oyxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEUp/ew7Ko4H7jVboFNJcm9Y9hE5ozL9AGtg1Unr0io=;
 b=L3KgH1UDOavrqO50KDvkQYehLgJYOMbRgSMAAZONedxC8uFfriSkOPysT06CHJKwrxUWyuXAJXWOo5QrlxfaIsbQ6QzLAvW0jtPpO5QI8G5e37y0T8kSFdt7se7Z6sKxzGwTtR+s4ehN8D9tMACD3fbu5KgFsOlD16HMAffQdSNu0eVKLv+hUbwu2z8WJamdh5CYODghCP8uwNMkuGG5UgH2xRdov5zArCkBS5nIiCULz6FX+gKKLZK8meEQHxtXUZcd1b5NKtr79Xwlul5cqXfFuD3AhhSARZcVf1w1wPsz5Gt/HCXv/lIOb5Q6wkt3hfmVSaJLDufeooM2vw9k0Q==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:23:10 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:23:10 +0000
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
Subject: [RFC PATCH bpf-next RESEND 09/16] bpf/crib: Add CRIB kfuncs for getting socket source/destination addresses
Date: Thu, 11 Jul 2024 12:19:31 +0100
Message-ID:
 <AM6PR03MB58489084E35B41B63A5615A399A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [TF/lA0m9xKLIaWdT4UKxxh67SJ9jrjL0]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-9-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bdf5cf-7c4b-4cd4-8ee1-08dca19bd856
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	uxVrWgkPB4X3AayaT9WrmI9YgEKoRXRPT9CEoGOfW7Q/FHPLGsNnucwMG9Ngp517JS/jAD4FKt4eW4CMl8H+L0eF9iYFBtiHJZHlwaDSQsKLgvKsIzCKg8EP9sNvuaPHEF5PXYDoOPHPjzNPYnOebZN4d8H/6wpSIrXmY8w0iEwsy4GQqfk7EmNkFksrdt+XpHMt84K+UlHwsb1pVvMK2WMPvx9ry0yvPil3vCKAqaAUCO4AipRCxTVn+XHxBCHl9b9CAZhKJOvm+FxdVFLwn7Z1xzrjeAGelnAjbZqacHzUki/FuwNx1s0fbFx9EuzM/qIoWTcLaegQNiZDAh8X/NHhMl3wR/bv37KTIXmj0wAo9bBofNNP1G8mUfTxT/g4ma+GgaTUV0+xTgdr6t+C8YnQq5U3vsNhArRGvrrWnsvQ2cz9d8m3ccAyvMW3KGipzEbEVYQfkNsIsmjN15iuSNvWi8yXNKFnWWwoGOh53gTaTz2U5QK0C+B7hg+5awHq5cBZ6PVlLjyoQPpK00eygzRXXVgN0cWNVMKSJbG1pLRlRWLamh+tt2ZbO3BDph+JsNdtlE/Ij2Zo2iWFt9rpt0w5Lbnlj9lHWQyqw+2O+yAUC2z13RjZiwf17+Z6KzFLqB4vyCf3/NJxJVsXzRsKlw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5B3lHLF1s28g/+bjjyGl87MYx09QVW1Co9SwjG1pnrvqSRYM16Xpuk5XEH/z?=
 =?us-ascii?Q?vWX5yDu3fly42rhzOlKHB1jXYqJqbMJ5Xrcy4vWDkkzOwxUnsLBMXOUOa9Eo?=
 =?us-ascii?Q?D1+O+Ecz6naYPUohz9ExTQUOP8rlXbys1E9aCRMIJ4KVlbLvu5Y/KTZUhTSW?=
 =?us-ascii?Q?sQl0PvW78Jut2f0tEQo9GvOcrTzqtAOAs2JV4u7+KvFxZmWdODxf7YU4Xh7Q?=
 =?us-ascii?Q?IR6LMWHtYFZW8Xc76suGU+cYdvGjtdhh+xc0c97Ozn1zVZvhHNFB2fzhz9s5?=
 =?us-ascii?Q?iaYMF87/SupIN7vBzWHRmTI4AnvaETSu49GNo0rbp0ePxkrtk92vBFb18F8a?=
 =?us-ascii?Q?HYLsi1EzIYcdars7pbhh0FVCQbR/zcd89wd+gbpXwhb0wJIqP6+Mg1HUYjKF?=
 =?us-ascii?Q?6HmQvMw2vVVjoyCdikgFDXn/aInYS1D4fBdv6H31+cOGDE4f/KX0RD53UnWP?=
 =?us-ascii?Q?YTay53j4ImqexuED999YypAluZArFfHolXm4Xk8fnmyCX/ApgEW1wUG0IMRE?=
 =?us-ascii?Q?cpz4VNI08/cvlCPi77A55BmYF7815TgHniXV3aeHafmcHAdtk1EYnSKJRtCu?=
 =?us-ascii?Q?OT/gVLPROGQHBCUrpWwXra4gKaag2oyEYYZxlD+y/abl9L8A+rMS1s1+93QW?=
 =?us-ascii?Q?/yzTRcRnzstl2Zg8PDpu/M8+WHNw6tDLzE3lID3I2YRwQQ/ONDl+9BMEitpW?=
 =?us-ascii?Q?2uDLOWhN3J3pUWCTtORrZHf6gVTtxsl7tkjn6Ko3gIAYEoX4EcpZ7MIOMbb1?=
 =?us-ascii?Q?q7cGf/s/DuVvdy1n7ZzDIp4oYE5b1aiqoR960/5ZSOV0mrF6BTGtwykTn3qL?=
 =?us-ascii?Q?IQ317GFiPViPCSqYQ+IIkNGIkxxsZYXLLrzvTsm/2Ma0NAy9mhueemhtfvSw?=
 =?us-ascii?Q?2uH98/a8Gr2be4uAFbBDN6lJ+eIPO+yQ3bu9WzjxBKfF0kNi3cDjfUVrLxR4?=
 =?us-ascii?Q?fA7uCOLIIK8SljXDM++1s+ovunxek0eqccRBIUCMohQoNMiRowJuY5/ZiHnK?=
 =?us-ascii?Q?R2U2pLGIFyxCKbE+c35m7SRN7lTbJMdeTAwaN2g66zikoIlyssxJmloiuaJH?=
 =?us-ascii?Q?gS0QHOcloAZWo8ZeL7rSSYRDBGAAQM8uJhWPAg8IwHRh7E+qkXYJjzSeyJ22?=
 =?us-ascii?Q?B0oz6HlQpVetpbVzxwxgax0iQ1t1si9c8AI9gf0LrbRcnV9WTdrEz6Txz9JR?=
 =?us-ascii?Q?S6pMnx8kJb+pW1RFThsA7SrcGM/0MkA4xwlbcTfqeS9EjFViJ6y1ypXN6sk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bdf5cf-7c4b-4cd4-8ee1-08dca19bd856
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:23:10.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

This patch adds CRIB kfuncs for getting socket source/destination
addresses, which are wrappers for inet_getname() and inet6_getname().

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/bpf_checkpoint.c | 50 ++++++++++++++++++++++++++++++++
 kernel/bpf/crib/bpf_crib.c       |  5 ++++
 2 files changed, 55 insertions(+)

diff --git a/kernel/bpf/crib/bpf_checkpoint.c b/kernel/bpf/crib/bpf_checkpoint.c
index 28ad26986053..4d48f08324ef 100644
--- a/kernel/bpf/crib/bpf_checkpoint.c
+++ b/kernel/bpf/crib/bpf_checkpoint.c
@@ -8,6 +8,8 @@
 
 #include <linux/bpf_crib.h>
 #include <linux/fdtable.h>
+#include <net/inet_common.h>
+#include <net/ipv6.h>
 
 extern void bpf_file_release(struct file *file);
 
@@ -98,4 +100,52 @@ __bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
 		bpf_file_release(kit->file);
 }
 
+/**
+ * bpf_inet_src_addr_from_socket() - Wrap inet_getname to get the source
+ * IPv4 address and source port of the specified socket
+ *
+ * @sock: specified socket
+ * @addr: buffer
+ */
+__bpf_kfunc int bpf_inet_src_addr_from_socket(struct socket *sock, struct sockaddr_in *addr)
+{
+	return inet_getname(sock, (struct sockaddr *)addr, 0);
+}
+
+/**
+ * bpf_inet_dst_addr_from_socket() - Wrap inet_getname to get the destination
+ * IPv4 address and destination port of the specified socket
+ *
+ * @sock: specified socket
+ * @addr: buffer
+ */
+__bpf_kfunc int bpf_inet_dst_addr_from_socket(struct socket *sock, struct sockaddr_in *addr)
+{
+	return inet_getname(sock, (struct sockaddr *)addr, 1);
+}
+
+/**
+ * bpf_inet6_src_addr_from_socket() - Wrap inet6_getname to get the source
+ * IPv6 address and source port of the specified socket
+ *
+ * @sock: specified socket
+ * @addr: buffer
+ */
+__bpf_kfunc int bpf_inet6_src_addr_from_socket(struct socket *sock, struct sockaddr_in6 *addr)
+{
+	return inet6_getname(sock, (struct sockaddr *)addr, 0);
+}
+
+/**
+ * bpf_inet6_dst_addr_from_socket() - Wrap inet6_getname to get the destination
+ * IPv6 address and destination port of the specified socket
+ *
+ * @sock: specified socket
+ * @addr: buffer
+ */
+__bpf_kfunc int bpf_inet6_dst_addr_from_socket(struct socket *sock, struct sockaddr_in6 *addr)
+{
+	return inet6_getname(sock, (struct sockaddr *)addr, 1);
+}
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index da545f55b4eb..e33fa37f8f72 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -234,6 +234,11 @@ BTF_ID_FLAGS(func, bpf_receive_queue_from_sock, KF_OBTAIN)
 BTF_ID_FLAGS(func, bpf_write_queue_from_sock, KF_OBTAIN)
 BTF_ID_FLAGS(func, bpf_reader_queue_from_udp_sock, KF_OBTAIN)
 
+BTF_ID_FLAGS(func, bpf_inet_src_addr_from_socket, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_inet_dst_addr_from_socket, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_inet6_src_addr_from_socket, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_inet6_dst_addr_from_socket, KF_TRUSTED_ARGS)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


