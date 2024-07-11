Return-Path: <bpf+bounces-34548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2292E696
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D7C1C20A73
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F2616D4D0;
	Thu, 11 Jul 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="R2UX01A8"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010012.outbound.protection.outlook.com [52.103.33.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBD216D4C0;
	Thu, 11 Jul 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696988; cv=fail; b=FSUkXeHt9YLZpNMLGO1Co0rgb/J5hpJOCJE9pt/+1JvbPRUNU+pOMhdPTyjel48GJI12F/C60t8FjRc2KLqM6L9R9PZOhIlI9B4x6XyN0nfnQDSzLaN5IBXArLFRuPaRwLwc6vUheIAd/rZQx3KQR9E/HcBNtQ9q9YkXxf1F3hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696988; c=relaxed/simple;
	bh=51Os35jl1lGplW66FjBCF6qvLrHvOXLZJlcfv3H8lEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cx1tyftnc2MsqWn7+9Z60DuLMbhvAv2vYAIxE9g1jSSs8RK38dZUkY1BVHeNhqB4Ae76yI8lICn3+O9VpW41YMYWASJWuo/WbklsSxDKqwIQyfMG9xkjVIPa8FBbzhPDuGn9bH629S1dMm9pHPwogE654LSB+vG5mfHKOZmqAAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=R2UX01A8; arc=fail smtp.client-ip=52.103.33.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHr9bUWdwnrGQUWZkDIvoC2gtpEDzlu8Igee8pl3NmDIRxuF7W1hGcRPdL6dsuuI43yRMc6rttNG5nenFqqVCLP5WArBiETn5fL1xgQL3mP6zDMZ6+nHZHhERrDRo5dQOYAs7eRNyl1o6zLcrb98pr05XVUOpHsfqSSBJSJPZdYrkiZWc0xDrb2EbrZzEH6pTlqlYy2S5b8RlaDrs+lFj7K23X/HlJurJGE4xiqD8x6k0JGfUjvMJnAlwvsN96990OfxnPjpi5zcEbWZZIsGavcm4fTkSBHCt/LhPxS600m4brdKMSJ0RiK93AvVo/0myx9fEzhY8nex+37zDQaisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThTiG67/N9QE6o18/tB8rU26NfvZheBdUxUgVRFGjfk=;
 b=eHdR0Wm2uHpSPgrnOobLEZpyGLTDFpo5HKcu7DjmycaI0jD/jTWoB/Ocpy4LVeq8aiSp7WgCCWk1OOHcsbjODDt7zNs4KqlSXVpETIenkau5Xe4cFHshCU0XJ5SFTfpoUm3O2pqpPReGGmUaSwe6b+R14aOK1ybXxkUVhPvcL5Xx+3ZdZFTq5HoQNgqfnc4ayIB+tVr/jHN8TcTo+OyFC2agE2stUJTuEjduPEmUNSkJWdMWjmuxuDYPiHjZGK9BTHZfex3KWTw/wveDvLoOWdM91xvZTwIEB5ZnvTH6jsftixALj2U97KM1IDKAg5JZse6AJkqHcLHgaDA9FhFO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThTiG67/N9QE6o18/tB8rU26NfvZheBdUxUgVRFGjfk=;
 b=R2UX01A8sF2wZDJFhMPP6gLaFZugWVFkqx/nI7OhxSTwwiN6MugAkXIgwVNPHbp500j/UXKjbzp7Ba/LHUyjo+ceDTfDFjrYmzk3qp7WADQoaHLIsa66ByZQHddbFTj5FvWGyG5zy4IqRndwDxaIwsCpfUHfVRxrozPV0yGkRphrwvl0B3mIXyCK4RCkmjk8+IYok4cX+88fOBpPaNwaEnzGBBfpt3tmOyqkfxxaX/VqnEjHVBL82yvaMlsG40OiYt53rGudKu6qKPfzya25Kq4J/hRAAjzBJZKDHtNrEwvdSfreFEl5ArgUiP2ZbbpFgwtuIDDLqwICITE7b4KmXQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:23:03 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:23:03 +0000
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
Subject: [RFC PATCH bpf-next RESEND 08/16] bpf/crib: Add CRIB kfuncs for getting pointer to often-used socket-related structures
Date: Thu, 11 Jul 2024 12:19:30 +0100
Message-ID:
 <AM6PR03MB5848EDC4DDC0CF0811DA937299A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Q1vToMV+lu++fH2ZtG5ecjeLEP4iARZS]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-8-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: cd85e690-fc86-473b-2281-08dca19bd427
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	S7ZcLnp3rWB1zBNzAcmXHZLBNdF4hdDkkAAUjDTPaJG1WjsDDTjoUAgR0nKzOLA9yt+jzzQvyKCspjBUelAS4DPp++UDlytrc9WefpySx1vZEKJLWNXsGLV8+mJ2JlCtPscV9eqpAtgeDJwcDB5dxhQbGcznXiNRtwUUMzf36H2AboM9kXErdOSNUOf+OoM5yiyOOmnGpHct8Vaat7vC5Zy5SC/IZff14PrZfTNqaxIOZrytI2rdAV3Y1MYHmR4rieGgze1Ur7csqT73zXcmVl0SmBiTlEvyE1oLyzq95LORwflwmLW2cSnrEf8+gwOzWxkjG9Ar3l7SA+XXHiY2t9iPRYLGItzK+DvR4mn/HthdKeK1RefqcxoijyOYl667gFikWZMBNtUf2bL+TUXr+Fc9477Y6foTnm6f/qgvwEeCQ9ZF/Xu9NHltSUEwjX2PwoorKNbZl0E8KGwUnLW3xZcR+0Ve5phMAYCeryIEaODsK9PLQHiGmX5HgblSm3Isu9lr36cKBqkQqRwTLmfnouNvUN3Yjjxn6FV4pUBHRvOnvE3zyqkughl/NhKA0hB2kOuEl5Mb172275/Y+qamDpLu4AFu6tJtP4dfxCn9d1SWvT28IdfqtZ9mgsbRj2CVXNPmTiZ87YMDyj7aNsJi+A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tYZyFBHm1Yi/9YFrcABm6+82imA4xOkUy2s74H/I1eU8HoRQF55Md5AWKDdZ?=
 =?us-ascii?Q?IM7wHlV02ZUL2kmqGQlkMm3FqMHfPjbF2n1eIeqyNGPgJx/1uzgQ8oFZZKWe?=
 =?us-ascii?Q?63zEcOI7z49/i5zuRwdjesxChQqYbEM0j2eCPNAhlGXVH22+L+liyVoTWLCa?=
 =?us-ascii?Q?6/0Gl4MLOE4MGah0NMirW9BhsQ2n84ws66bB6vhTm1D/GB3g68IJtPvyCAMg?=
 =?us-ascii?Q?Y0Jm+X6G555xENpdNQyTdbEcAD3oODc8Qy271jP1e7rUykIsXPWkpUVpA9DZ?=
 =?us-ascii?Q?/6SNzW/FVUip/3VxAKUFihMNiQEVT7xFZ32WS8KXdOtLP4bVTXIUPa0ugfjU?=
 =?us-ascii?Q?SPhyvkum82obRHwXm2V7nXPAHi/3GdvqyXVTOBTJ0VRW9cNfPNHl5nkc0C8f?=
 =?us-ascii?Q?bHm8GzT/zpfsFcxKDstP2UVhRYFXJiD5DIXs5A5DMikwEodoEu8YpeKrMorN?=
 =?us-ascii?Q?UzaiBtyzZeHYKtkXQHydDNVKDNuHH/KSXjnnMfRdJ2OGOgFm3tx3XH2oX6EX?=
 =?us-ascii?Q?X73wbH+rZNabJPSS3rh3CSxroWVhehRrAJ7s7cS7znm/XupTK6agcGuJNabP?=
 =?us-ascii?Q?IFbVARGBROWtFTmpraAzzbWM+6ET1ZWgjKKRD5vhylpCYBUjV700okuCaJ7M?=
 =?us-ascii?Q?HxNYNLsmPOXEI5eTqE0hqxnasUmL4uDCOk9r3/FuoZT7Xqs6+Vq2zPSLhFVA?=
 =?us-ascii?Q?KRvrgBWnol5LrXk27XkPiS1rWGjN5bIr00mFcgs76lRJHqglcGFs1bMU50Ko?=
 =?us-ascii?Q?JW4mZu9g5EeDKfwHbd2ihqjXV+y762+3h714EFrYGQnf0AT4YdQp3OlVuOOe?=
 =?us-ascii?Q?IZYRqq+vTOxIQC/3K5v2vkECNVebxLqgtTjNm9UDljhU8S7DVl7Fek+Lj9Ue?=
 =?us-ascii?Q?ZUiU4QWuZbM4VjiQhOGPt8FAdHswT/GhZTf5MNbnP/31gug/ExXa+XbpRkcX?=
 =?us-ascii?Q?GRXtF0PpyouhKCYiTEzB+KOIrPWmXnWP5cusZbk1SwtXxngx19RP8ZT3kEQA?=
 =?us-ascii?Q?9ep6wt8S1h5XIwCqCEhcwGDgPVRn79Tej+HEGdytj9YDrANt7KrUr4D9m7vM?=
 =?us-ascii?Q?fvkeNTkQnmU+pjxqI3UH3+wT9UQpbba94D41XujASx8E6uLQjRAKu+vLfhzG?=
 =?us-ascii?Q?yjWppIUfvuWbd0k2w2bum/HICzv5FKiNLJ24AQG6mmJTgZqrgQPAyhJ584PZ?=
 =?us-ascii?Q?emitEfwZ5M3pTfGWxsKGN2VJp//a8ba6ll2//hWqCUQbaKb4WC7lY1Pq3d0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd85e690-fc86-473b-2281-08dca19bd427
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:23:03.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

This patch adds CRIB kfuncs for getting pointers to often-used
socket-related structures, including struct socket, struct sock_common,
struct tcp_sock, struct udp_sock, sk_receive_queue, sk_write_queue,
reader_queue.

All kfuncs use KF_OBTAIN and do not need to handle references.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/bpf_crib.c | 95 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index d83e5f0e8bfc..da545f55b4eb 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -10,6 +10,9 @@
 #include <linux/init.h>
 #include <linux/fdtable.h>
 #include <net/sock.h>
+#include <linux/net.h>
+#include <linux/udp.h>
+#include <linux/tcp.h>
 
 __bpf_kfunc_start_defs();
 
@@ -122,6 +125,90 @@ __bpf_kfunc struct sock *bpf_sock_from_task_fd(struct task_struct *task, int fd)
 	return sk;
 }
 
+/**
+ * bpf_socket_from_file() - Get struct socket from struct file
+ *
+ * @file: specified struct file
+ *
+ * @returns struct socket from struct file
+ */
+__bpf_kfunc struct socket *bpf_socket_from_file(struct file *file)
+{
+	return sock_from_file(file);
+}
+
+/**
+ * bpf_sock_common_from_sock() - Get struct sock_common from struct sock
+ *
+ * @sk: specified struct sock
+ *
+ * @returns struct sock_common from struct sock
+ */
+__bpf_kfunc struct sock_common *bpf_sock_common_from_sock(struct sock *sk)
+{
+	return &sk->__sk_common;
+}
+
+/**
+ * bpf_tcp_sock_from_sock() - Get struct tcp_sock from struct sock
+ *
+ * @sk: specified struct sock
+ *
+ * @returns struct tcp_sock from struct sock
+ */
+__bpf_kfunc struct tcp_sock *bpf_tcp_sock_from_sock(struct sock *sk)
+{
+	return tcp_sk(sk);
+}
+
+/**
+ * bpf_udp_sock_from_sock() - Get struct udp_sock from struct sock
+ *
+ * @sk: specified struct sock
+ *
+ * @returns struct udp_sock from struct sock
+ */
+__bpf_kfunc struct udp_sock *bpf_udp_sock_from_sock(struct sock *sk)
+{
+	return udp_sk(sk);
+}
+
+/**
+ * bpf_receive_queue_from_sock() - Get receive queue in struct sock
+ *
+ * @sk: specified struct sock
+ *
+ * @returns receive queue in struct sock
+ */
+__bpf_kfunc struct sk_buff_head *bpf_receive_queue_from_sock(struct sock *sk)
+{
+	return &sk->sk_receive_queue;
+}
+
+/**
+ * bpf_write_queue_from_sock() - Get write queue in struct sock
+ *
+ * @sk: specified struct sock
+ *
+ * @returns write queue in struct sock
+ */
+__bpf_kfunc struct sk_buff_head *bpf_write_queue_from_sock(struct sock *sk)
+{
+	return &sk->sk_write_queue;
+}
+
+/**
+ * bpf_reader_queue_from_udp_sock() - Get reader queue in struct udp_sock
+ *
+ * @up: specified struct udp_sock
+ *
+ * @returns reader queue in struct udp_sock
+ */
+__bpf_kfunc struct sk_buff_head *bpf_reader_queue_from_udp_sock(struct udp_sock *up)
+{
+	return &up->reader_queue;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_crib_kfuncs)
@@ -139,6 +226,14 @@ BTF_ID_FLAGS(func, bpf_sock_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_sock_from_socket, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_sock_from_task_fd, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 
+BTF_ID_FLAGS(func, bpf_socket_from_file, KF_OBTAIN | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_sock_common_from_sock, KF_OBTAIN)
+BTF_ID_FLAGS(func, bpf_tcp_sock_from_sock, KF_OBTAIN)
+BTF_ID_FLAGS(func, bpf_udp_sock_from_sock, KF_OBTAIN)
+BTF_ID_FLAGS(func, bpf_receive_queue_from_sock, KF_OBTAIN)
+BTF_ID_FLAGS(func, bpf_write_queue_from_sock, KF_OBTAIN)
+BTF_ID_FLAGS(func, bpf_reader_queue_from_udp_sock, KF_OBTAIN)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


