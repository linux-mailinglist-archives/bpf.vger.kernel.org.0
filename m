Return-Path: <bpf+bounces-34434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D96F92D884
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E0B244E8
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F661991CF;
	Wed, 10 Jul 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GxBQkwOV"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871B1990D2;
	Wed, 10 Jul 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637002; cv=fail; b=hKCrvg3JIEUpxECLlpLpMYg0LHrIKqihcMUmx30UHj6tLswWUShryyyhAZDoRq12syoQmDjK5o3EjtJphpQGYF+O/zorOSrN1p2we6Mwa3aySN2zf75ZkhlJ5sY0ZjjuEnU+vYH4KCAylsOzCKPIWIeyoZNrnVyautpPN9KFP48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637002; c=relaxed/simple;
	bh=51Os35jl1lGplW66FjBCF6qvLrHvOXLZJlcfv3H8lEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L3x82vetuwVZsD9o4BBhOI98SeHm8SylEYYpiisZ7KlH0NGrlCxr0xBcULtGRrvaaEo50NzFdLscy0b0sDuTlS/PGFkUqSaTxygk4r82V4yHaAuP8lrbdhAsK0vKrXWxsT51UKCqRIn62o09YqSwiiD+mTvU6BP8cxVZT0TnKdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GxBQkwOV; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWS/VKZV77GysHO4EUIrFJuwIMe3pHb0JybBz9G4zxJS9nA0agjEkKBye78r8SLmqAIhuB+tkaHG5eOsVCiZj75bMgOdH7ILx2rVhak8mjW17zJdUWjBUrComCruQS6TBlaEZoyClDQ4gd48wWs0tL8f+of7sCXvuqJVx/4GVPH9/9czVqUnOrFb1n6YGZkGhdCcQFe5xz6DfqXC4uVK2QPYA66bX2lRkZ5ilp1mwTvx9wJnACJU9bhK8Jv7O7u7QnGpyQBB2Jg8Mc15+s+4d2ARhpS3E1ne+Ee5M3ossRgCeTC/BACBdXeI76KR6y4D4nowLuLS28CZ/t/I2327YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThTiG67/N9QE6o18/tB8rU26NfvZheBdUxUgVRFGjfk=;
 b=eJ09tAKccXJeBtp0IVFfecGrJHqgi5NKmj9ESKhHNx5nS9unFWZaCfOxOClsL6zFSO1j6qCoOd3iwVW3T7pM2cZyFdcLFzlRubbfCrJw2svy1ZkYxHBiY+3Lo9xzy3fZ0VwOGMPnQxvPlcBAC2i5aqEe1BLmRSLsJ6mIYA/XRyU1Pj0K6UcQbIuNeWTnAnQ5ui/OJnDwYPOdsvG6GYhJcV3WmANkUccNYGAZ43uIstpO0YtacTrduNH0GtSe8cg18UuAXI2VQKpALM+QGxzigeEBDH7NxpLxdoQIyellNYah10gdYOv5ltjmzN43cLdLucvaIm58d3DSUHwoZSrp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThTiG67/N9QE6o18/tB8rU26NfvZheBdUxUgVRFGjfk=;
 b=GxBQkwOVK7PwgjH5fPCn8NCyAo3KDojLjkgFc4IKhJKdjwafvI6pHm1/DSJn4794la2rU8jZlXdoDux8d9lBAPj/fsR1bympaeStiZTDWtVf7kWotDWLYXkG15bfs0cQs66W2+5ze6ZfFUD2jlNPwIhJCWAUNLpglG6ZmYVT5KuPsJotGJwVp8IyPqIzgK0VfvI7lD3/RVe9wwKOy0sagO/C5r86mS2wXS/6zjZQ+dBdslHfEt2LdTVOCyZhfYLoVjsnWAViBUHwFVz5qcp54AVW03YlQAvMJMnc1TxRMCT3IPdQL2MDjRq4PRafXdogDFheORB/nI9Hw9E+uLz04g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:18 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:18 +0000
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
Subject: [RFC PATCH 08/16] bpf/crib: Add CRIB kfuncs for getting pointer to often-used socket-related structures
Date: Wed, 10 Jul 2024 19:40:52 +0100
Message-ID:
 <AM6PR03MB58487C95630F475032AB8ED399A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DB7+WKk8xi/xbrGwD9FfahlhoxKJoLpy]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-9-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb34e6f-ebce-4a1b-aff8-08dca1102a77
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	kSQrGsb82LGtZJvcXkRRaFpwO2vIFRtBLRtiTd6hX7SPSpmW/UiAhQ0g+klHSdbhfF32zlFh3wWTPmFNUmH78VQ35Kha77I/YIk9luSXoCV6cbxdWSCFKp7pUmQH1EnqYDo21AiaglMYSm9MXYU/MBXlBO92VNveesPC+safUnwrjeBhdMe5sgAUEXkfX+aJ9LfjkELpb2vHv+PSwj/9ahDpCD+afGzBFApm2myk/SPVzX5zRHpUL+sxj3BDoVhXHAqJImP3WpqPtgeJ3DNTluKd2D6BAMU2jQpoveCqauJLfg3oZECb3rrMNQpywoyk3DEYVkjNF+KeeMkZh39RWXuOrwLtrgXLYubEV//O3vTNgEGw1KqtCJOo7aFPqjO3HsNJKJphnG/F7sTaz07/K2SFgVh0VWoLzpRKpZ/9TTrOWHb/kro+tn4ymO4vGy9y6mRnMNPkF4nQIkg8HWJMjL+B2ZkazwZlHTpq9dmNe4Dim97XuEPfvF6Em3lrGXuquHLL52cLUxEEohCqM1PNGlhPe/ZowpPAAgVNIasIStjTUCVKDy4KI2Wk4gGSITyf+UnoXF1tZeHwwDoloIwHVG3asKeoD9y6tNd902LxLi9T9VmpoDzKj5EEvaYBtamjpf1MhMnI+x1rYnoIq5z1gQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zHG4EPq6Lv8f/yrLaT6+pTsf6LvHtT+ulshbFlE/RB0Aq9yUdTeguc70AMA?=
 =?us-ascii?Q?cVpJTQRF0n7oA9MM6q/3vnayM76yB104NC4yFfHZX0QoXOZgkzrZjpaZZuCJ?=
 =?us-ascii?Q?9ZWYTz61PDEQn6HCI4+g3Vr0I4fKCUhsnXVfaXvsY9cRxIiT3g1oc8RvrYMN?=
 =?us-ascii?Q?G342ZlRClsfY1z4AfkrBS61BREKndsw1zuyJ8xveXYa28B1jMUh856ixV8M7?=
 =?us-ascii?Q?8t+IGAJZ3jX8yhlAfJOUnLalTzWd+0NY5MSCg4vx2Ob4puDV38QNppuh19bi?=
 =?us-ascii?Q?jLLnuxH0s7U+62tTKWjyAlxM/UbwhNM/4rjus18O+ciQoEEzNyDWnQXHuzj+?=
 =?us-ascii?Q?DD3TLAm0N89ZPTLaIpNDU97RFgtvLPx/q9tfPNEMvjsYm6XT6dKQY6+/g7rU?=
 =?us-ascii?Q?sZ/U21d8gHycxdGN4cjOVZNnBo8FtTkaNbUIaWkw6rEpmWDw08PH9benHLYM?=
 =?us-ascii?Q?faKWWx7dcgfnmbIJTeDrZOvejNHRFS8LxPz3qZJQYSjWtWyIq00FN/6KXxKZ?=
 =?us-ascii?Q?r41oJPRi+Ev6lFxXTT8Mb8Poh0+JMWRsQfeuaEybY21au+nVWxkBcFZPN4Xp?=
 =?us-ascii?Q?ozwn16vdP693/Io07J8hetlm1UjY0TxE4g/nt834pl+p11q1rfvgqPoOf3JB?=
 =?us-ascii?Q?dl/WMyt0473xDhs3kU8eTQvjne3K0fnilQ63+bs3zrhJOnAsVUPxopn7HYIp?=
 =?us-ascii?Q?ATphoMRBjF/wFlfjrTUP6LrCJVIUO8daJ9WJeOzz3D1GkCUtcFJHOp/Mqkum?=
 =?us-ascii?Q?s0yK8Czl63Gwp297Ltv5KmkpSCGmbqHOO+ycwJ9P0svQ3M8uY6i1t1jbaIfz?=
 =?us-ascii?Q?fc9kvrVwsADK5EmbA7Z3o65oQaDGHk+oXNOawoMOjuX+YSS2lM9aaAunWZSE?=
 =?us-ascii?Q?9xtwAxQVLGGWh3ChnydypoTwJ263CjHqoLp+eUtwWICbL69kFoTcxVRt9xFz?=
 =?us-ascii?Q?kfeqZozLQK6CZ54WjLq+p5Ksy515nf6U89c6aP3M8Q2RgJ0mWuZ/9dBPI+y4?=
 =?us-ascii?Q?//ll38BvfyVC+jh83FcVVNtBnSDd4b/Cp/evVh1OshdJpHyH/k/dqrICbKrz?=
 =?us-ascii?Q?Z/d4JOm0lWgKflknZ6kT3LnVoUuWQ7XVLChahnLu8TZelnFoHOM4LX27W3hx?=
 =?us-ascii?Q?MXEZQImpyMfJcMxr9fDjF5O9oUahyXuTn6ukzOvb+Yu8gfxu/rz3k0b/hRl3?=
 =?us-ascii?Q?OFDfUvJdWjle1eaAugLRA86C0scT9DJaE5ewuoZYKtAzVLgTi2HygZOKOVM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb34e6f-ebce-4a1b-aff8-08dca1102a77
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:18.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

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


