Return-Path: <bpf+bounces-34556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54E92E6B7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3013B1C20C4B
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7816E88D;
	Thu, 11 Jul 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oew9SeHb"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010004.outbound.protection.outlook.com [52.103.33.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF116E88F;
	Thu, 11 Jul 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697126; cv=fail; b=JD/PeN+bN0EIEFSGz1lkxlfnnG1TP4zwyZcZzIQDQ9KuF5dDCOuuy8v2IHrL822IXOQFHPrbkLT9a4zjqqYWXsddpEWX6lXAjgthn4bq1PUoPbndo99pxHqT4lMGFGGGhRUH3HaLNcPXBuO4iTPZf204EDsbZ59tewZdOooByeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697126; c=relaxed/simple;
	bh=M3SGqNnbVRg01VCLB+2RQpAxbl8Mi6TvFhviVlREHDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vA+riBewQDrFksxRYiJAzejOa47e/Ny3zDgv7/t9dWKH35x5nBJ30vpMoWsWJvg3Q5oNhpltKeTnTE6h5lSzG2qSq6je974Xd1eP82xZwqfT0Loe4Gravs54ttEG2umuRIp9t/+uasNuiypyua4c7QGO9SFPnffAwbQZjTLVg1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oew9SeHb; arc=fail smtp.client-ip=52.103.33.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNVXn05ElnHhfCYU+cYJm5SId8BjtAvqw6T1x2d54AXsjP1lcjZ8QPjrvGKFmtz028VOWB1YySlzHqNnB7RnUuuHlGcBwfmi7Gox0vEYQpKlArzCKYZ0k9+TkQTxtTAT1SWAwCDGoRc7rj/L79v+8iS8wLj0iDP0Unj5Gk6jG/BQfEUCJ6y+jAXo+AUcnE+39FFmedCczhylSYs88p7AHZo2bjLh5CqIHHC+euOjrOL1GPDhnKe/E99gx5BJJZFUspPNkSwzNrcRLNvSDMIDsZ7n15f2jZRyIqShfne8ZXeCNpgDTY2GvG+7dEJ8zIlKDkfrF9XX/CdDnbuAzytiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uioMZANDC1OC1BmOa403llfPM9kYL4OgGj/M2FJpCuY=;
 b=KoEcXzk9msRLB/h04EAa0Wpzx34C3qd6nuNUKca+8OJQx+eIoZ08dH/1ZyIT5HL0anMM24yZ7s68RdfgaFgzQi0qpDtTkEdL4H7kIVcxE/l/lbyRA9cEaI5J9JCkxjgy3okFoni2Y7WBULqMHN1FWC0pUVDhTIYk1Q8m0V+C5/HtNzcR6Tiv+GmTe7dZz/nB2B5XyRBGvOGOHY4Knqyt0X3hKSyUmnbiAIRTYeGke7Q23vxXYmPAaIUVm8JNFmAdyKw9+QkhmzC+POklDFHs1gY38Ket0/GfIdDFIPwqnIv7Gnk0Xo/5O96XRBVibWXpLddeHNVlVPu6e9A9P1CeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uioMZANDC1OC1BmOa403llfPM9kYL4OgGj/M2FJpCuY=;
 b=oew9SeHbv3CWaXgYEHtLTOOlrRmG7KPgXnVuyI9AgwZW/HZA4Ls0fM2hmnZyXNt06vAMAMRyUET/z+cA0BukSNV/P3aoV+f/IcsxuCOE1YJW/cvBJPoTiwCVWTPAsc6fuAUjSAtwNTuWsn3xvqmGxfUso2AgFHkFfQWCDxbN1jMnGhtBZiZxqVRUlSIRz4DAOwsfQVoAQnGVMqqMS+Nfx9WrTaZYFjNVX0kk1jgJezuESLCZxXn+K33Voh2QEs0LDzP+ERmKwfcy/cqrlEfPYQLKIlXuJA4kc5Vrj9Hmgl9fAoES/6tFxegozDlnx8puIjBgoBBUgd1DtisKZVidmw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM9PR03MB7330.eurprd03.prod.outlook.com (2603:10a6:20b:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Thu, 11 Jul
 2024 11:25:20 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:25:20 +0000
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
Subject: [RFC PATCH bpf-next RESEND 16/16] selftests/crib: Add test for dumping/restoring UDP socket packets
Date: Thu, 11 Jul 2024 12:19:38 +0100
Message-ID:
 <AM6PR03MB5848FD102CAF71CC35E175FD99A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/UiW23+/6gfpqI0cGAL4FnIMUeFZnk2y]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-16-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM9PR03MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 939c9d46-4c11-4989-8fd7-08dca19c25b9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	r2ZaEcEyNRwkLaXTTHD10l8YJfU0RzWi02UvnoKW4siK41sA5QrEKrS3u2UHTLI0yC4r3ngWIisZ/jBVmw9h5/6oN241sAuHdlPCr4kcs8F+YHd68MAyfJG53qR/9eEcVZg4ZYoj9T60TAObgOfnpZO1DjcHSDyV7T4SvA8bkJIf8X5IKb3Oo5TpHgQr1cXNCDSOfyJeLfivlk422Mk0fj4LP/uWyRfbzecUQtxcnbziczJQmANdyqu/NUxHTDo6nqxdKr5p69sBduPyufUojxexE+LwJx2NBr1SawNT50FR1stAc89Kwu1CJdl8Hh2Eq5o0ZIhuCVjB9UCWdP/S51EhvQbeX+NucE4ecHqpvXET7YAW+5O3BiyyqodKjM2yaMOupvGPFXmLQtJww/hk9gUUwlxxEtRPKodE8E94W1o1yFJ9DZKE1DfnEEH2yLbqwsHsHeiavfEVYVvYwS6jMsQVSrS2y3MxD4+m/n1H0gbhSLCgLxIQywqpGfFm6usq4FY6nDYi+k5aC5549ouNKL2+2UThYenBYYuseV5G0Gitz80HasCgXhvyl9hlQTGa+Pvy7yCfGaRC/kDaJGntFrnDgSGAXMpBSJ1h1tiEJS8JyZ5jrwL357iDY1x0iGrFZFVKkKkyfqNbUUb7q4T7Tg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eUknn9R8OA5qVDj9ehnGZysxp+3HtAHJVDiZGtozs64k+MqklvhaG8fo9j4C?=
 =?us-ascii?Q?VgCtyzg6F/KLILrYepDE8BpAft4Q+5spt7rwnwTAj2OjtUZRRzXLR1ecGH6M?=
 =?us-ascii?Q?Urr+iw8uomms/g/xxAguDqDbNL3TYCfTvJZI+dymAxbOM5NjQKQYxGzXecEa?=
 =?us-ascii?Q?qSnwPGsPQCvkjrKe/yJTx/iVAevKIV3FdmBtcT+RIoGsWYJa2Of7Q1cq7sBR?=
 =?us-ascii?Q?nQu6o6OjwQ+Not9hhITrrQTEX3M/YyNvg1Ge5LzWy6NzT/801WEQVD0h4bxX?=
 =?us-ascii?Q?4rnATa/KabirrfWOCDENMT80cvkFbAw1meYvN65oDoV/kd/yBo7/grdO5k9m?=
 =?us-ascii?Q?TU9sTlr9eX3swTnvtZf65d/jtrt5h6bQJXXCMIREOuYYTwVeZ3thLD134ffT?=
 =?us-ascii?Q?mLOSoSh4OmrEZiaB1kB1peyAdLl6HjqDUwiixAgOfE89sYWOR9ltyLwl0qQO?=
 =?us-ascii?Q?bvVYi9nomlDJJCEi9pISOOcEl84jPq0kD3itsp3VkR9nrgUlzZUySx7IoyoS?=
 =?us-ascii?Q?36i4pMSYRK3rKxumZ88xGXNDj9kD9TqJgn+9cFfOXbgTqZDhhs32UI2lhPaM?=
 =?us-ascii?Q?is4Vjl1fGCOT5GnhL1zdDAaXXFFoDhWJRlguafSgPAqjk+HOGu/pSoKuGXBv?=
 =?us-ascii?Q?4EdGuV71wfqTC89c4fBJxhDwBw/+3pR+6auNo8BwGEqLCNwT1esvJQbbKPhZ?=
 =?us-ascii?Q?57deIr8ZmnQm/nKnMUyZ3x8d+ko8Pyk+LyTMpS7yH3Z2Ap3+3y4ayQPP4Zsu?=
 =?us-ascii?Q?ZJDVSvKTMcrhw73E5uAhrjsxMR70L/3EF5tm4TCdke+VbO5B9kQh90vxY0Gd?=
 =?us-ascii?Q?tChBhlAbYzBbGjUkoJao2xUNI4TULISSbBYCmJB4TzQt5sxFxnvgjXMJceyb?=
 =?us-ascii?Q?T3BoaZl6d/mIugoAc5W+dhLjU66SvOS9JVtcbSMHRkJ806DiMHidsxgxbGEy?=
 =?us-ascii?Q?fz3B7yzaKTjVCoTEw93xb3g7pwgBNwE8sRhY738mtZOgll20N6S7emiY2W8d?=
 =?us-ascii?Q?4RKl3nvpr25mswMahvKIrK8ox3Tdamuc8MKq1DLPEUTnLoqN+hp4+FxUkM77?=
 =?us-ascii?Q?ZffdpffbKCKJVFsIuzqkns9kP6gt7S+r3L4k0XMgzEcibLSRQN5qC0jZp8Q/?=
 =?us-ascii?Q?HLmclZv8vxKOh+LmMAvJD0QoILhJKnbib3IPRA18ptp4z1J0AsI8dGL3albd?=
 =?us-ascii?Q?qtdyRYCRbz6HD8tPbPRODi+7uG9dwJxGNyJz8rH7SdMJYPyZRouvME5ewEc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939c9d46-4c11-4989-8fd7-08dca19c25b9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:25:20.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7330

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


