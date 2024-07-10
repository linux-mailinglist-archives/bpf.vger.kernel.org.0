Return-Path: <bpf+bounces-34442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBB92D895
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE211F246FC
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685119A2B7;
	Wed, 10 Jul 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bccn1Exu"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012026.outbound.protection.outlook.com [52.103.32.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904E19A2B4;
	Wed, 10 Jul 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637056; cv=fail; b=jrINf+Ls8Ivqj/mViSW0OFVnIFVedxXvXm5UThx34rqpgKrSyhkXMdMu0p8u/VlrSdsNyzTA2qYr7AVu4qLdGjIdjwW/+wRbJ1UnmZJlzVmaef9O1TPpVZInxc2J/Y/MBEqcI5Z32P3297MILi6brUKgOgUKy7pMad9TwyvkvKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637056; c=relaxed/simple;
	bh=M3SGqNnbVRg01VCLB+2RQpAxbl8Mi6TvFhviVlREHDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMqDE62CgZ8AjuqpelK5ecacBZmCAUbSzFiXedxaKufmomxobzFGRSTCiMwdCs/2fYnxkqeIYdXw0QLimsgovWQU4kHXCLu9sjZtlUqIZll8Cw30yxUVgM52waGOdyBockwFHYxOz7YlkjjTiu2umTp/jwAFsp6hx3dEyNCh2Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bccn1Exu; arc=fail smtp.client-ip=52.103.32.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwlGMkP3WuCRlqFXzAM4PmKDWPa38Jc+/RC9dj7wJryzNGjY/6uoD4skk3L4zSccbYbhPJbOkdS6wFR8q/42z1/mBGZaa7lzVoW8zXpYoEtmCdg9UUvVcs+RGkG8VBXnGxiWyk/LzMAnvCEFB0g3V5300tHpH0/g7OMUclxF4dJXhY1Ei1Ht3F11g8kHAvRhNIp3X4cXnmMPW3TBbTa/kbtrisco+8osqTR8sk/02f31nxhrtEV5/wlnz7qwPG0KEXAHrlK4YCqeNCmsOoFYLsuhT7niyG7JmLPL43a3QPyGrAkRDhjQhH78/IP8wnOAnTe5SkBuwGZ7vwJp4LvsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uioMZANDC1OC1BmOa403llfPM9kYL4OgGj/M2FJpCuY=;
 b=Z4o3A0bIpKwOy4QmI74MPRuQXYCGbjIxQVrPITCYs9Azyzj1Ez8eQ209Le90XajXVU5wbRrQt8ycIw5Q1mkQGlvpCTBUIC6GSIpt0AmMzRQNjM+kTTIXgT3jCBHxP2sBrrCEDzA1hixK7qCdu8lvL9n+7HqqBEHYKOvcv2gAYQLEsbeM2LEtbu34nGp1+PYwwH71J243x0h1EJ6J2x+78LdxC3aU8ogwK7VyEd9oPJw/nzg+uNIOMD1rHJr/Xr9/MxSDdXfiU5va8sV6kda2ilARcFccjNiIFnoxKWDEafc5G8qJSEvOM89N+le6GkxPzS+hRlcTPv48KEl6IbclcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uioMZANDC1OC1BmOa403llfPM9kYL4OgGj/M2FJpCuY=;
 b=bccn1Exuunrcah6BmETFkY2Gc8uqvOcchv7gPCCOMRpIpSI7HYv1JQZUWXbt6s3oFfTYPR71IpTzFF5sxu1esT0sZG+2FP3y4KlC5SRlZEKhNLpSctLFgnttIk06jh9fkaJo9KPX0odr8/su8pU7wwwH4xd3kcB0efHlxRuxk2CfNxOdRvLw/6bH+YCT/VfOTMNpUHZLrc9o25BWq/DcpA4TR65K2ETaY4EAIq5plmO5RuidY16nsJUsdP5ffT449fjoAo5jqvfUC5AgbfBj/MLEEg9DQVR8sM9dNi8YjgMY+yAHtv/uRwDBmlwV60rUiXlz/2yczJceLo3NvfUOdQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GVXPR03MB8308.eurprd03.prod.outlook.com (2603:10a6:150:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 18:44:09 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:44:09 +0000
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
Subject: [RFC PATCH 16/16] selftests/crib: Add test for dumping/restoring UDP socket packets
Date: Wed, 10 Jul 2024 19:41:00 +0100
Message-ID:
 <AM6PR03MB5848A12C78ADE93F04B4599199A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [OwUYHtp8hVmzwddwmdXmXOgPRCsKbPnG]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-17-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GVXPR03MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e4ae4b-2d1d-412b-c51b-08dca11048c0
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwV1Kpn5lySAyQJsGKcMyMICJxe2bSatuTGDkpijd4+ipyI9P/aobk6EOwJRTP00L8Z3dNYzyzJxTmrSvIpnXEG4sUgmTKuBw1ar4onOAbq3tdlAiJynImWB7erxwJ3QPKYQc/GduuQz79cp28oJBMAzGqJhABPHbV1zgLJRLe3qKZanges8upguqYVD1YNCdsRAEx/mmkO5fnR1Lj/JweVXzUq0JwEhEywYtDEor9fjJxAmuYyrPPiegX120gpw59iXw9VdDwbNQQfqzF723y/o/xoqKLHgLwkfDSfHGxIN/xzedymv7QS2alA4pYZWeG30Nmzsg/zR2UXtaKTL6vwTNACIDlR8bB3CLPGmjrRx91ZYKqqNJgmUqfE+Cj4sSNVk1606dHYvQwPMpsqplbBiakwy5at5o6uv2oWdYWnNdlY2Z2bH80W2LTaBe8XxXeCGbV03BbvgqcxgFFtU7hw35m6aGkR4PJNcLfA45iiB/87r6VL/X/8bTcGekB3zgBVZttd8fT0ecSUxUUPBFFbVV5KcU9jUwkcEf3ssA8CzlGNfEQ1KW2hUquhjztaocIMpzcEFoROaMqKCU4ZaW6wDDMgw2wYi3zfKXEXejndJP4tG6PLDjK+EGdq0YsBLn9onba8oZw5PpCwErXaL7cDfWP/QPU8G1QPyRFDNw1qGn7i7iW6FbUt07gS/bBVte4Yy8NnOpqdLbEDRuLg0Yfhf7C9aAb8DZqi1ID+12EdjxdpWT8ekIoaWFDw9TFXzqrQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	Snzi4mSnl5K8awbwfbdD8NfVNDNWmoG8OWkO4zm5zoYuyEmxf3uOi7Cuon1l0oHcpnoVv5igH1ml7MUcQxLlDor0U8++zI8TEjtuRz6L788TLyWleS+BZ/wGZiKTq2ZynCUkc4uZRNFFxZI4hjGAU/H7/wjNoCq8P022Il+/2cjlJC7JoUKqpqTE5BcFfiM+cKWLTGvOZSrWJJwRa7SORYxhM8HCruVNYbvFxvDzNkIvQ+QB6pUS+GZO+brjkEWY9hTc3QVfiym5TJcq832JCiEDDg/lI2r3WUxtfIzhb/O9xjFuAdGZd1wNYm888/RN3dRUjxM0dayidNHfcuJZleUJWozbGH9J08ZM7gJ9M69mQPsK9FVSu4PsjyjDyd2NikgAQQN+g272USZj9QZVa2mXfkwtE81DqtgDnlyzqw18wTo2LRpVXCpwqI+felfMar980HvXygW2yPrke2yszsIy4mlm2wy7LppHgRYB1P4gduogjoUku2l6GhNIV+VXei2kgOIS7jVtujpKmjsQnHjK2kQ4mG46YOtfhdpMqwbxIN0zRfLuBnTfcPjjKt/033kJu7f32+44enQ2Bpj2rkBVUOdIkqADrYe4EiHkc4HvKjOaCzzR++ZVNo5n0RVVTyZp5ZD4ipwjHONkvIWtkA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iXv7x73kqMX5xSvht8v2LJyHF2iMB4yeq5Tnj8F2wb2++L+edP2mtOcGgb4n?=
 =?us-ascii?Q?xG47dCizrXgdFWHN+eIFSnyAm2YDlSwNuvTZC+e+6BO0ozY3L0bz/I0TGfWh?=
 =?us-ascii?Q?63YukZl4OG1qmnV2uHS+xliI/4AV+i7B8PVrXhT1bjHPevizmZRia1kAorj6?=
 =?us-ascii?Q?Y+T7dlpfKxG/tIfaQyaeLq5GGOC6+VkxKpLHdnaXDrnXs9VbJBN5NIQ1WWle?=
 =?us-ascii?Q?KrC3FEplEcq7m5/EyVw5DsG7jiItwV/WifTDoU98EOwJ1+ZfUDDHCX6DOHDB?=
 =?us-ascii?Q?V8k7c0s0qF7u1oo8uWcvdXGZE3svMQJ/V6JZb07WorVCHg8bwY3KDM/Vrgfe?=
 =?us-ascii?Q?2krbfz8ST1DuCF84DzhGjCIExR2q6PcUdPKkfXAnzZ6tkaBdkrI5Cu5ZUm20?=
 =?us-ascii?Q?aFf/GeeJnElIsJ0lSAwojeUoaISKWU95Lln2L2mLNwWgWo+JTIYCCeoPMBfl?=
 =?us-ascii?Q?rKQdcFam/rQm4ySBinHPmvo53xoivzDdgvKYPbUJGe4u7ncmxyqv2aiY7F/r?=
 =?us-ascii?Q?5txQglxvAGrqKDc2x+nrLUPc63jja+zjW3GgL+pQk29iVWO1sQmLw64t9rJD?=
 =?us-ascii?Q?UAcVT0kQzJ9gr/ftveJexTjwrk5GHVCEwxz+ntb8lPTRJz8STG3iX9rsEL7O?=
 =?us-ascii?Q?Z4MhKyZ+aKlqmHmqQCR5x4ZNCfOyI+sCM0ZoHgXTuMLrrDaekApkZcydXQWi?=
 =?us-ascii?Q?tpdLhXXTgJdPpBWu/tmkhYtr2r4Ua+1jF/PPgYYVr5/B9gMPyUUcX0bdOmCG?=
 =?us-ascii?Q?xpktMXUpj7YU3Ck0lSEM+CQjodXSadOfMye0sMN9Mi5rnWFdy+wuOBnc16rb?=
 =?us-ascii?Q?4Sqo9CPF5EEHtf5jYGapD0w5fdzFfr8T2YSn0zqjEcC5EQqgisFHGBxAmpv1?=
 =?us-ascii?Q?lQKyF3cVu4HV+xU6fX3Xw6MVZFhAAtcQT7d/DaduilWSfLgkiDUH5BT7iA39?=
 =?us-ascii?Q?PF6ypPhXA4E0TdpUv5Xom2agkcTh2nFS+yUovRlNuqAhMp2waD4bAuMr0B6X?=
 =?us-ascii?Q?dBbnN0AOOc/oMv5joNsBvFu6KR7QyK0dwjmAr6VC01ZTwX7gawFIpG/8qPNQ?=
 =?us-ascii?Q?gPxZ9coZS3VUuxXIb3awM6BzZHfIUmwMhjwl9GNJ9Sk30bsy/8hU2qH7TUe2?=
 =?us-ascii?Q?+yGVYYIjScJkwAUw/NBsI1K3oBpCf1ak5CVoccVicykPES40kwj6G7ufbNuc?=
 =?us-ascii?Q?mJPeZc7CFtUvz5cZFRVnHro3Biu50y474kp0j8tNf2JvMQepu5H6WhQ5Eqo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e4ae4b-2d1d-412b-c51b-08dca11048c0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:44:09.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8308

In this test, UDP socket packets are dumped/restored through CRIB,
including write queue and receive queue (and reader queue).

A "checkpoint socket" and a "restore socket" are created,
the write/receive queue packets of the "checkpoint socket" are
dumped and restored to the "restore socket", and after that
the "restore socket" will be checked to see if it can normally
receive and send the packets that were restored to the queue.

Write queue packets are not restored through the CRIB ebpf program
in this test, because it is not wise to rewrite the entire UDP
send process. Using regular send() is a better choice.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../crib/test_restore_udp_socket.bpf.c        | 311 ++++++++++++++++
 .../selftests/crib/test_restore_udp_socket.c  | 333 ++++++++++++++++++
 .../selftests/crib/test_restore_udp_socket.h  |  51 +++
 3 files changed, 695 insertions(+)
 create mode 100644 tools/testing/selftests/crib/test_restore_udp_socket.bpf.c
 create mode 100644 tools/testing/selftests/crib/test_restore_udp_socket.c
 create mode 100644 tools/testing/selftests/crib/test_restore_udp_socket.h

diff --git a/tools/testing/selftests/crib/test_restore_udp_socket.bpf.c b/tools/testing/selftests/crib/test_restore_udp_socket.bpf.c
new file mode 100644
index 000000000000..527ee6d72256
--- /dev/null
+++ b/tools/testing/selftests/crib/test_restore_udp_socket.bpf.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#include "test_restore_udp_socket.h"
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 100000);
+} rb SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+	__uint(max_entries, 100000);
+} urb SEC(".maps");
+
+extern struct task_struct *bpf_task_from_vpid(pid_t vpid) __ksym;
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
+extern struct sock *bpf_sock_from_task_fd(struct task_struct *task, int fd) __ksym;
+extern void bpf_sock_release(struct sock *sk) __ksym;
+
+extern struct udp_sock *bpf_udp_sock_from_sock(struct sock *sk) __ksym;
+extern struct sk_buff_head *bpf_receive_queue_from_sock(struct sock *sk)  __ksym;
+extern struct sk_buff_head *bpf_write_queue_from_sock(struct sock *sk) __ksym;
+extern struct sk_buff_head *bpf_reader_queue_from_udp_sock(struct udp_sock *up) __ksym;
+
+extern int bpf_iter_skb_new(struct bpf_iter_skb *it, struct sk_buff_head *head) __ksym;
+extern struct sk_buff *bpf_iter_skb_next(struct bpf_iter_skb *it) __ksym;
+extern void bpf_iter_skb_destroy(struct bpf_iter_skb *it) __ksym;
+
+extern int bpf_iter_skb_data_new(struct bpf_iter_skb_data *it, struct sk_buff *skb, char *buf, int buflen) __ksym;
+extern char *bpf_iter_skb_data_next(struct bpf_iter_skb_data *it) __ksym;
+extern void bpf_iter_skb_data_set_buf(struct bpf_iter_skb_data *it, char *buf, int buflen) __ksym;
+extern int bpf_iter_skb_data_get_chunk_len(struct bpf_iter_skb_data *it) __ksym;
+extern int bpf_iter_skb_data_get_offset(struct bpf_iter_skb_data *it) __ksym;
+extern void bpf_iter_skb_data_destroy(struct bpf_iter_skb_data *it) __ksym;
+
+extern int bpf_cal_skb_size(struct sk_buff *skb) __ksym;
+extern struct sk_buff *bpf_skb_peek_tail(struct sk_buff_head *head) __ksym;
+extern void bpf_skb_release(struct sk_buff *skb) __ksym;
+
+extern struct sk_buff *bpf_restore_skb_rcv_queue(struct sk_buff_head *head, struct sock *sk,
+						 struct bpf_crib_skb_info *skb_info) __ksym;
+extern int bpf_restore_skb_data(struct sk_buff *skb, int offset, char *data, int len) __ksym;
+
+static int dump_skb_data(struct sk_buff *skb, int subtype, int skb_num)
+{
+	struct bpf_iter_skb_data skb_data_it;
+	int err = 0;
+
+	/*
+	 * Since bpf_iter_skb_data_next will dump the skb data into the buffer,
+	 * the buffer needs to be allocated in advance
+	 */
+	struct event_skb_data *e_skb_data;
+	e_skb_data = bpf_ringbuf_reserve(&rb, sizeof(struct event_skb_data), 0);
+	if (!e_skb_data) {
+		err = -2;
+		goto error_buf;
+	}
+
+	bpf_iter_skb_data_new(&skb_data_it, skb, e_skb_data->buf, sizeof(e_skb_data->buf));
+	while (bpf_iter_skb_data_next(&skb_data_it)) {
+		e_skb_data->hdr.type = EVENT_TYPE_SKB_DATA;
+		e_skb_data->hdr.subtype = subtype;
+		e_skb_data->skb_num = skb_num;
+		e_skb_data->chunk_length = bpf_iter_skb_data_get_chunk_len(&skb_data_it);
+		e_skb_data->offset = bpf_iter_skb_data_get_offset(&skb_data_it);
+		bpf_ringbuf_submit(e_skb_data, 0);
+
+		/*
+		 * For the same reason as above, the buffer used in
+		 * the next iteration needs to be allocated now
+		 */
+		e_skb_data = bpf_ringbuf_reserve(&rb, sizeof(struct event_skb_data), 0);
+		if (!e_skb_data) {
+			err = -2;
+			goto error_in_buf;
+		}
+
+		bpf_iter_skb_data_set_buf(&skb_data_it, e_skb_data->buf, sizeof(e_skb_data->buf));
+	}
+	/* Discard the pre-allocated buffer in the last iteration (it will not be used) */
+	bpf_ringbuf_discard(e_skb_data, 0);
+
+error_in_buf:
+	bpf_iter_skb_data_destroy(&skb_data_it);
+error_buf:
+	return err;
+}
+
+static int dump_all_queue_skb(struct sk_buff_head *head, int subtype)
+{
+	struct bpf_iter_skb skb_it;
+	struct sk_buff *cur_skb;
+	int skb_num = 0;
+	int err = 0;
+
+	bpf_iter_skb_new(&skb_it, head);
+	while ((cur_skb = bpf_iter_skb_next(&skb_it))) {
+		struct event_skb *e_skb = bpf_ringbuf_reserve(&rb, sizeof(struct event_skb), 0);
+		if (!e_skb) {
+			err = -2;
+			goto error;
+		}
+
+		e_skb->hdr.type = EVENT_TYPE_SKB;
+		e_skb->hdr.subtype = subtype;
+		e_skb->skb_num = skb_num;
+		e_skb->len = BPF_CORE_READ(cur_skb, len);
+		e_skb->tstamp = BPF_CORE_READ(cur_skb, tstamp);
+		e_skb->dev_scratch = BPF_CORE_READ(cur_skb, dev_scratch);
+		e_skb->protocol = BPF_CORE_READ(cur_skb, protocol);
+		e_skb->transport_header = BPF_CORE_READ(cur_skb, transport_header);
+		e_skb->network_header = BPF_CORE_READ(cur_skb, network_header);
+		e_skb->mac_header = BPF_CORE_READ(cur_skb, mac_header);
+		e_skb->csum = BPF_CORE_READ(cur_skb, csum);
+		e_skb->csum = BPF_CORE_READ(cur_skb, csum);
+		e_skb->size = bpf_cal_skb_size(cur_skb);
+
+		unsigned char *head = BPF_CORE_READ(cur_skb, head);
+		unsigned char *data = BPF_CORE_READ(cur_skb, data);
+		e_skb->headerlen = data - head; //skb_headroom
+
+		bpf_ringbuf_submit(e_skb, 0);
+
+		if (dump_skb_data(cur_skb, subtype, skb_num) != 0) {
+			err = -1;
+			goto error;
+		}
+
+		skb_num++;
+	}
+error:
+	bpf_iter_skb_destroy(&skb_it);
+	return err;
+}
+
+int dump_write_queue_skb(struct sock *sk)
+{
+	struct sk_buff_head *write_queue_head = bpf_write_queue_from_sock(sk);
+	return dump_all_queue_skb(write_queue_head, EVENT_SUBTYPE_WRITE_QUEUE);
+}
+
+int dump_receive_queue_skb(struct sock *sk)
+{
+	struct sk_buff_head *receive_queue_head = bpf_receive_queue_from_sock(sk);
+	return dump_all_queue_skb(receive_queue_head, EVENT_SUBTYPE_RECEIVE_QUEUE);
+}
+
+int dump_reader_queue_skb(struct sock *sk)
+{
+	struct udp_sock *up = bpf_udp_sock_from_sock(sk);
+	struct sk_buff_head *reader_queue_head = bpf_reader_queue_from_udp_sock(up);
+	return dump_all_queue_skb(reader_queue_head, EVENT_SUBTYPE_READER_QUEUE);
+}
+
+SEC("crib")
+int dump_socket_queue(struct prog_args *arg)
+{
+	int err = 0;
+
+	struct task_struct *task = bpf_task_from_vpid(arg->pid);
+	if (!task) {
+		err = -1;
+		goto error;
+	}
+
+	struct sock *sk = bpf_sock_from_task_fd(task, arg->fd);
+	if (!sk) {
+		err = -1;
+		goto error_sock;
+	}
+
+	dump_write_queue_skb(sk);
+	dump_receive_queue_skb(sk);
+	dump_reader_queue_skb(sk);
+
+	struct event_hdr *e_dump_end = bpf_ringbuf_reserve(&rb, sizeof(struct event_hdr), 0);
+	if (!e_dump_end) {
+		err = -2;
+		goto error_buf;
+	}
+
+	e_dump_end->type = EVENT_TYPE_END;
+	bpf_ringbuf_submit(e_dump_end, 0);
+
+error_buf:
+	bpf_sock_release(sk);
+error_sock:
+	bpf_task_release(task);
+error:
+	return err;
+}
+
+static int handle_restore_skb_data(struct event_skb_data *e_skb_data, struct sk_buff_head *head)
+{
+	struct sk_buff *skb = bpf_skb_peek_tail(head);
+	if (!skb)
+		return -1;
+
+	bpf_restore_skb_data(skb, e_skb_data->offset, e_skb_data->buf, e_skb_data->chunk_length);
+
+	bpf_skb_release(skb);
+	return 0;
+}
+
+static int handle_restore_skb(struct event_skb *e_skb, struct sk_buff_head *head, struct sock *sk)
+{
+	struct bpf_crib_skb_info skb_info;
+	skb_info.headerlen = e_skb->headerlen;
+	skb_info.len = e_skb->len;
+	skb_info.size = e_skb->size;
+	skb_info.tstamp = e_skb->tstamp;
+	skb_info.dev_scratch = e_skb->dev_scratch;
+	skb_info.protocol = e_skb->protocol;
+	skb_info.csum = e_skb->csum;
+	skb_info.transport_header = e_skb->transport_header;
+	skb_info.network_header = e_skb->network_header;
+	skb_info.mac_header = e_skb->mac_header;
+
+	struct sk_buff *skb = bpf_restore_skb_rcv_queue(head, sk, &skb_info);
+	if (!skb)
+		return -1;
+
+	bpf_skb_release(skb);
+	return 0;
+}
+
+static long handle_restore_event(struct bpf_dynptr *dynptr, void *context)
+{
+	struct prog_args *arg_context = (struct prog_args *)context;
+	int err = 0;
+
+	struct task_struct *task = bpf_task_from_vpid(arg_context->pid);
+	if (!task) {
+		err = 1;
+		goto error;
+	}
+
+	struct sock *sk = bpf_sock_from_task_fd(task, arg_context->fd);
+	if (!sk) {
+		err = 1;
+		goto error_sock;
+	}
+
+	struct udp_sock *up = bpf_udp_sock_from_sock(sk);
+
+	struct sk_buff_head *reader_queue = bpf_reader_queue_from_udp_sock(up);
+	struct sk_buff_head *receive_queue = bpf_receive_queue_from_sock(sk);
+
+	struct event_hdr *e_hdr = bpf_dynptr_data(dynptr, 0, sizeof(struct event_hdr));
+	if (!e_hdr) {
+		err = 1;
+		goto error_dynptr;
+	}
+
+	if (e_hdr->type == EVENT_TYPE_SKB) {
+		struct event_skb *e_skb = bpf_dynptr_data(dynptr, 0, sizeof(struct event_skb));
+		if (!e_skb) {
+			err = 1;
+			goto error_dynptr;
+		}
+
+		if (e_hdr->subtype == EVENT_SUBTYPE_RECEIVE_QUEUE)
+			handle_restore_skb(e_skb, receive_queue, sk);
+		else if (e_hdr->subtype == EVENT_SUBTYPE_READER_QUEUE)
+			handle_restore_skb(e_skb, reader_queue, sk);
+	} else if (e_hdr->type == EVENT_TYPE_SKB_DATA) {
+		struct event_skb_data *e_skb_data = bpf_dynptr_data(dynptr, 0, sizeof(struct event_skb_data));
+		if (!e_skb_data) {
+			err = 1;
+			goto error_dynptr;
+		}
+
+		if (e_hdr->subtype == EVENT_SUBTYPE_RECEIVE_QUEUE)
+			handle_restore_skb_data(e_skb_data, receive_queue);
+		else if (e_hdr->subtype == EVENT_SUBTYPE_READER_QUEUE)
+			handle_restore_skb_data(e_skb_data, reader_queue);
+	}
+
+error_dynptr:
+	bpf_sock_release(sk);
+error_sock:
+	bpf_task_release(task);
+error:
+	return err;
+}
+
+SEC("crib")
+int restore_socket_queue(struct prog_args *arg)
+{
+	struct prog_args arg_context = {
+		.fd = arg->fd,
+		.pid = arg->pid
+	};
+
+	bpf_user_ringbuf_drain(&urb, handle_restore_event, &arg_context, 0);
+	return 0;
+}
diff --git a/tools/testing/selftests/crib/test_restore_udp_socket.c b/tools/testing/selftests/crib/test_restore_udp_socket.c
new file mode 100644
index 000000000000..f986ff4dfc49
--- /dev/null
+++ b/tools/testing/selftests/crib/test_restore_udp_socket.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include <argp.h>
+#include <stdio.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <netinet/in.h>
+#include <netinet/udp.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <unistd.h>
+#include <errno.h>
+#include <netdb.h>
+#include <linux/if_packet.h>
+#include <net/ethernet.h>
+#include <linux/netlink.h>
+#include <asm/types.h>
+
+#include "../kselftest_harness.h"
+
+#include "test_restore_udp_socket.h"
+#include "test_restore_udp_socket.bpf.skel.h"
+
+static int sockfd_checkpoint;
+static int sockfd_restore;
+static int sockfd_client;
+static int sockfd_server;
+
+static int dump_socket_queue_fd;
+static int restore_socket_queue_fd;
+
+static struct ring_buffer *rb;
+static struct user_ring_buffer *urb;
+
+char buffer_send1[1000], buffer_send2[1000];
+char buffer_recv1[1000], buffer_recv2[1000];
+
+static int last_skb_num = -1;
+static int last_skb_transport_header;
+
+static int handle_dump_end_event(void)
+{
+	struct prog_args arg_restore = {
+		.pid = getpid(),
+		.fd = sockfd_restore
+	};
+
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = &arg_restore,
+		.ctx_size_in = sizeof(arg_restore),
+	);
+
+	int err = bpf_prog_test_run_opts(restore_socket_queue_fd, &opts);
+	return err;
+}
+
+static int handle_dump_skb_data_event(struct event_skb_data *e_skb_data)
+{
+	if (e_skb_data->hdr.subtype == EVENT_SUBTYPE_WRITE_QUEUE) {
+		if (last_skb_num != e_skb_data->skb_num) {
+			send(sockfd_restore, e_skb_data->buf + last_skb_transport_header + 8,
+				e_skb_data->chunk_length - last_skb_transport_header - 8, 0);
+			last_skb_num = e_skb_data->skb_num;
+		} else {
+			send(sockfd_restore, e_skb_data->buf, e_skb_data->chunk_length, 0);
+		}
+	} else {
+		struct event_skb_data *e_restore_skb_data = (struct event_skb_data *)user_ring_buffer__reserve(urb, sizeof(struct event_skb_data));
+		if (!e_restore_skb_data) {
+			printf("user_ring_buffer__reserve error\n");
+			return -2;
+		}
+
+		e_restore_skb_data->hdr.type = EVENT_TYPE_SKB_DATA;
+		e_restore_skb_data->hdr.subtype = e_skb_data->hdr.subtype;
+		e_restore_skb_data->skb_num = e_skb_data->skb_num;
+		e_restore_skb_data->chunk_length = e_skb_data->chunk_length;
+		e_restore_skb_data->offset = e_skb_data->offset;
+		memcpy(e_restore_skb_data->buf, e_skb_data->buf, e_skb_data->chunk_length);
+
+		user_ring_buffer__submit(urb, e_restore_skb_data);
+	}
+	return 0;
+}
+
+static int handle_dump_skb_event(struct event_skb *e_skb)
+{
+	if (e_skb->hdr.subtype == EVENT_SUBTYPE_WRITE_QUEUE) {
+		last_skb_transport_header = e_skb->transport_header;
+		return 0;
+	}
+
+	struct event_skb *e_restore_skb = (struct event_skb *)user_ring_buffer__reserve(urb, sizeof(struct event_skb));
+	if (!e_restore_skb) {
+		printf("user_ring_buffer__reserve error\n");
+		return -2;
+	}
+
+	e_restore_skb->hdr.type = EVENT_TYPE_SKB;
+	e_restore_skb->hdr.subtype = e_skb->hdr.subtype;
+	e_restore_skb->skb_num = e_skb->skb_num;
+	e_restore_skb->len = e_skb->len;
+	e_restore_skb->headerlen = e_skb->headerlen;
+	e_restore_skb->size = e_skb->size;
+	e_restore_skb->tstamp = e_skb->tstamp;
+	e_restore_skb->dev_scratch = e_skb->dev_scratch;
+	e_restore_skb->protocol = e_skb->protocol;
+	e_restore_skb->csum = e_skb->csum;
+	e_restore_skb->transport_header = e_skb->transport_header;
+	e_restore_skb->network_header = e_skb->network_header;
+	e_restore_skb->mac_header = e_skb->mac_header;
+
+	user_ring_buffer__submit(urb, e_restore_skb);
+	return 0;
+}
+
+static int handle_event(void *ctx, void *data, size_t data_sz)
+{
+	const struct event_hdr *e_hdr = data;
+	int err = 0;
+
+	switch (e_hdr->type) {
+	case EVENT_TYPE_SKB:
+		handle_dump_skb_event((struct event_skb *)data);
+		break;
+	case EVENT_TYPE_SKB_DATA:
+		handle_dump_skb_data_event((struct event_skb_data *)data);
+		break;
+	case EVENT_TYPE_END:
+		handle_dump_end_event();
+		break;
+	default:
+		err = -1;
+		printf("Unknown event type!\n");
+		break;
+	}
+	return err;
+}
+
+static int check_restore_data_correctness(void)
+{
+	const int disable = 0;
+	if (setsockopt(sockfd_restore, IPPROTO_UDP, UDP_CORK, &disable, sizeof(disable)))
+		return -1;
+
+	char buffer1[1000], buffer2[2000];
+	memset(buffer1, 0, sizeof(buffer1));
+	memset(buffer2, 0, sizeof(buffer2));
+
+	struct sockaddr_in src_addr, client_src_addr;
+	socklen_t sockaddr_len = sizeof(struct sockaddr_in);
+	memset(&src_addr, 0, sizeof(struct sockaddr_in));
+	memset(&client_src_addr, 0, sizeof(struct sockaddr_in));
+
+	if (getsockname(sockfd_client, (struct sockaddr *)&client_src_addr, &sockaddr_len))
+		return -1;
+
+	if (recvfrom(sockfd_restore, buffer1, sizeof(buffer1), 0, (struct sockaddr *)&src_addr, &sockaddr_len) <= 0)
+		return -1;
+
+	if (memcmp(buffer1, buffer_recv1, sizeof(buffer_recv1)) != 0)
+		return -1;
+
+	if (src_addr.sin_addr.s_addr != htonl(INADDR_LOOPBACK) || src_addr.sin_port != client_src_addr.sin_port)
+		return -1;
+
+	if (recvfrom(sockfd_restore, buffer1, sizeof(buffer1), 0, (struct sockaddr *)&src_addr, &sockaddr_len) <= 0)
+		return -1;
+
+	if (memcmp(buffer1, buffer_recv2, sizeof(buffer_recv2)) != 0)
+		return -1;
+
+	if (src_addr.sin_addr.s_addr != htonl(INADDR_LOOPBACK) || src_addr.sin_port != client_src_addr.sin_port)
+		return -1;
+
+	if (recvfrom(sockfd_server, buffer2, sizeof(buffer2), 0, (struct sockaddr *)&src_addr, &sockaddr_len) <= 0)
+		return -1;
+
+	if (memcmp(buffer2, buffer_send1, sizeof(buffer_send1)) != 0)
+		return -1;
+
+	if (memcmp(buffer2 + sizeof(buffer_send1), buffer_send2, sizeof(buffer_send2)) != 0)
+		return -1;
+
+	return 0;
+}
+
+static int check_restore_socket(void)
+{
+	/*
+	 * Check that the restore socket can continue to work properly
+	 * (the restore process did not damage the socket)
+	 */
+	char buffer[1000];
+	memset(buffer, 0, sizeof(buffer));
+
+	struct sockaddr_in src_addr, restore_src_addr;
+	socklen_t sockaddr_len = sizeof(struct sockaddr_in);
+	memset(&src_addr, 0, sizeof(struct sockaddr_in));
+	memset(&restore_src_addr, 0, sizeof(struct sockaddr_in));
+
+	if (getsockname(sockfd_restore, (struct sockaddr *)&restore_src_addr, &sockaddr_len))
+		return -1;
+
+	if (connect(sockfd_server, (struct sockaddr *)&restore_src_addr, sizeof(struct sockaddr_in)) < 0)
+		return -1;
+
+	if (send(sockfd_restore, buffer_send1, sizeof(buffer_send1), 0) <= 0)
+		return -1;
+
+	if (send(sockfd_server, buffer_send2, sizeof(buffer_send2), 0) <= 0)
+		return -1;
+
+	if (recvfrom(sockfd_server, buffer, sizeof(buffer), 0, (struct sockaddr *)&src_addr, &sockaddr_len) <= 0)
+		return -1;
+
+	if (memcmp(buffer, buffer_send1, sizeof(buffer_send1)) != 0)
+		return -1;
+
+	if (recvfrom(sockfd_restore, buffer, sizeof(buffer), 0, (struct sockaddr *)&src_addr, &sockaddr_len) <= 0)
+		return -1;
+
+	if (memcmp(buffer, buffer_send2, sizeof(buffer_send2)) != 0)
+		return -1;
+
+	if (src_addr.sin_addr.s_addr != htonl(INADDR_LOOPBACK) || src_addr.sin_port != htons(6003))
+		return -1;
+
+	return 0;
+}
+
+TEST(restore_udp_socket)
+{
+	sockfd_checkpoint = socket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, IPPROTO_UDP);
+	ASSERT_GT(sockfd_checkpoint, 0);
+
+	sockfd_restore = socket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, IPPROTO_UDP);
+	ASSERT_GT(sockfd_restore, 0);
+
+	sockfd_client = socket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, IPPROTO_UDP);
+	ASSERT_GT(sockfd_client, 0);
+
+	sockfd_server = socket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, IPPROTO_UDP);
+	ASSERT_GT(sockfd_server, 0);
+
+	struct sockaddr_in checkpoint_src_addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_ANY),
+		.sin_port = htons(6001)
+	};
+
+	struct sockaddr_in checkpoint_dst_addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = htons(6002)
+	};
+
+	struct sockaddr_in restore_dst_addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = htons(6003)
+	};
+
+	const int enable = 1;
+	ASSERT_EQ(setsockopt(sockfd_checkpoint, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(enable)), 0);
+	ASSERT_EQ(setsockopt(sockfd_server, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(enable)), 0);
+
+	ASSERT_EQ(setsockopt(sockfd_checkpoint, IPPROTO_UDP, UDP_CORK, &enable, sizeof(enable)), 0);
+	ASSERT_EQ(setsockopt(sockfd_restore, IPPROTO_UDP, UDP_CORK, &enable, sizeof(enable)), 0);
+
+	ASSERT_EQ(bind(sockfd_checkpoint, (struct sockaddr *)&checkpoint_src_addr, sizeof(struct sockaddr_in)), 0);
+	ASSERT_EQ(bind(sockfd_server, (struct sockaddr *)&restore_dst_addr, sizeof(struct sockaddr_in)), 0);
+
+	memset(buffer_send1, 'a', 1000);
+	memset(buffer_send2, 'b', 1000);
+	memset(buffer_recv1, 'c', 1000);
+	memset(buffer_recv2, 'd', 1000);
+
+	ASSERT_EQ(connect(sockfd_client, (struct sockaddr *)&checkpoint_src_addr, sizeof(struct sockaddr_in)), 0);
+	ASSERT_EQ(send(sockfd_client, buffer_recv1, sizeof(buffer_recv1), 0), sizeof(buffer_recv1));
+	ASSERT_EQ(send(sockfd_client, buffer_recv2, sizeof(buffer_recv2), 0), sizeof(buffer_recv2));
+
+	ASSERT_EQ(connect(sockfd_checkpoint, (struct sockaddr *)&checkpoint_dst_addr, sizeof(struct sockaddr_in)), 0);
+	ASSERT_EQ(connect(sockfd_restore, (struct sockaddr *)&restore_dst_addr, sizeof(struct sockaddr_in)), 0);
+
+	ASSERT_EQ(send(sockfd_checkpoint, buffer_send1, sizeof(buffer_send1), 0), sizeof(buffer_send1));
+	ASSERT_EQ(send(sockfd_checkpoint, buffer_send2, sizeof(buffer_send2), 0), sizeof(buffer_send2));
+
+	struct prog_args arg_checkpoint = {
+		.pid = getpid(),
+		.fd = sockfd_checkpoint
+	};
+
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = &arg_checkpoint,
+		.ctx_size_in = sizeof(arg_checkpoint),
+	);
+
+	struct test_restore_udp_socket_bpf *skel = test_restore_udp_socket_bpf__open_and_load();
+	dump_socket_queue_fd = bpf_program__fd(skel->progs.dump_socket_queue);
+	restore_socket_queue_fd = bpf_program__fd(skel->progs.restore_socket_queue);
+
+	rb = ring_buffer__new(bpf_map__fd(skel->maps.rb), handle_event, NULL, NULL);
+	ASSERT_NE(rb, NULL);
+
+	urb = user_ring_buffer__new(bpf_map__fd(skel->maps.urb), NULL);
+	ASSERT_NE(urb, NULL);
+
+	ASSERT_EQ(bpf_prog_test_run_opts(dump_socket_queue_fd, &opts), 0);
+
+	ASSERT_GT(ring_buffer__poll(rb, 100), 0);
+
+	ASSERT_EQ(check_restore_data_correctness(), 0);
+	ASSERT_EQ(check_restore_socket(), 0);
+
+	ASSERT_EQ(close(sockfd_checkpoint), 0);
+	ASSERT_EQ(close(sockfd_restore), 0);
+	ASSERT_EQ(close(sockfd_client), 0);
+	ASSERT_EQ(close(sockfd_server), 0);
+	ring_buffer__free(rb);
+	user_ring_buffer__free(urb);
+	test_restore_udp_socket_bpf__destroy(skel);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/crib/test_restore_udp_socket.h b/tools/testing/selftests/crib/test_restore_udp_socket.h
new file mode 100644
index 000000000000..0ea5d3cb1b81
--- /dev/null
+++ b/tools/testing/selftests/crib/test_restore_udp_socket.h
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#ifndef __TEST_RESTORE_UDP_SOCKET_H
+#define __TEST_RESTORE_UDP_SOCKET_H
+
+#define EVENT_TYPE_SKB 0
+#define EVENT_TYPE_SKB_DATA 1
+#define EVENT_TYPE_END 2
+
+#define EVENT_SUBTYPE_RECEIVE_QUEUE 0
+#define EVENT_SUBTYPE_WRITE_QUEUE 1
+#define EVENT_SUBTYPE_READER_QUEUE 2
+
+struct prog_args {
+	int pid;
+	int fd;
+};
+
+struct event_hdr {
+	int type;
+	int subtype;
+};
+
+struct event_skb {
+	struct event_hdr hdr;
+	int skb_num;
+	int headerlen;
+	int len;
+	int size;
+	int tstamp;
+	int dev_scratch;
+	int protocol;
+	int csum;
+	int transport_header;
+	int network_header;
+	int mac_header;
+};
+
+struct event_skb_data {
+	struct event_hdr hdr;
+	int skb_num;
+	int chunk_length;
+	int offset;
+	char buf[500];
+};
+
+#endif /* __TEST_RESTORE_UDP_SOCKET_H */
-- 
2.39.2


