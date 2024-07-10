Return-Path: <bpf+bounces-34441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7647F92D893
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6012B21D26
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971EB19A29E;
	Wed, 10 Jul 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SbL+B/Ma"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011077.outbound.protection.outlook.com [52.103.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62B198E75;
	Wed, 10 Jul 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637048; cv=fail; b=S0hfpruu3V0ji7QkVZciWG7wUSbXOIlOwYa5K1/mVfePpyrf9Vjv5tB2tPOgp2gaK1w5yiyrnzsCQxk5+EzznmlfmP1pAFK+5hStZ15kx2IoMdvsP3xHVgAYw7wDioi7+o5OOfmVuISE1Y7f1tvrkuSV1ftX2a8CV44xlhjW2z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637048; c=relaxed/simple;
	bh=5TW4kvWjzIu1SEuTl/snc51X+iT54VWLIrNbBmuVuqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DwEXn0JQ9dg82RvD7CvTqo5QosLCRR0LsIGNmmXmJ9U79MO1eHP79t/QfHSwLp7uQnPFpPcDdtwn7a/8oX7B25IZq47NFl5CcVBngoe153ARi+sHX7TwCZZcSNW9wbX/EighOTCGv1BoG/cvDGyjpE55BZDbOKP2mPdOvIcliFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SbL+B/Ma; arc=fail smtp.client-ip=52.103.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRgdA3dy25uNxeTxYxO03Hp0MGO8nzn7PR9gHga3kMRyx0iXNQpTyizRaV6WntohgHWTS6EITJpgBgaRHMc7kwTnxrUrf4c/8u5skWGjSLAOHwEJGYF0NfGWAtSoGFOK/fQZlurD39dXJ66FGCVvRwr33njfjHAIMQWxwv7eBUKonkz7ayVTF3802gQjDP3V4gyJ6muCHivTh9P9l+YVhaWzBZmVN/v2sKSBhVioGUBDhIbe8IcsXeZk3bnvS56aZBZ96hkP6eHbVMXdWWP9m16ZQPf4lff/mRsohDxw7dvQuazEfRrhVWaS4E80APYp1yaBwA0rYAHsvOKUREgYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lSfBlFkQvQHqEJMnh5buyMUegVuR9j0s9Qj5N1B+78=;
 b=SqtGWh5ItGcsYAGBLEaHb3G4HxKKyk6Eoj2/11LzE+E5pmCnj3vMrEWz8QPUQbywAUHryJcC2t+VDZmIXjBsYUh/ftdmPf7IuIjW7gxlKIe4jiDL6DLTYTmsvHp94eYCDxEnP+rBNqZ10FbBab9wyBS1YYTNePrSZNIZ+4CcBwdOLnF/y19wAKZFOGkIN3gBE0wQ9jGdZwIQ/PXWIuULfmx9KSPePwyVTh4kSY6IlEjKF2x6QX85RjOAtL8n21PNBzGF8gpTd4Ntd2RQShUd1thClrnp1sAl130N+Bjd4nLo6lWk6Rg+XjjXpd0P9fAYWF+Rd1bjAkkSGST/wW/hvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lSfBlFkQvQHqEJMnh5buyMUegVuR9j0s9Qj5N1B+78=;
 b=SbL+B/Ma24QR+MGSokU3O+QLLocNjWNhxtfD3I86Xv/21FZAMlDqrXXXgcAF2iO2iMvAjCY0eh6Pn6QcXad/7j2TCOvC/KIpxTsdiDRUPzednWBb+PERG91XwRotpsRRCiZ8lE0eZThlUkwBDDaZ+HQWaFhi7fOM9krTeHKwJ75mWQet29YXSDbP3cIMbb5Ie3odmkY8kANxXOAOxOT7K94HIT1I61jiXV3Nz+3nzPe3izvZjdtAuQFlP7Dv16eVBJd/nvz8JT5zu8oa1BBugrxusWb1pB9iz7KJEx0zcM2WToFY9/5W63fYt/BrUXse6sOcuIe4og7J0mJ8ObRrtg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:44:03 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:44:03 +0000
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
Subject: [RFC PATCH 15/16] selftests/crib: Add test for getting all socket information of the process
Date: Wed, 10 Jul 2024 19:40:59 +0100
Message-ID:
 <AM6PR03MB5848307206A0D9B4D78CA12799A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [44+gGIy6Dbi1B3jWJ2wUQBuYICrzCPVd]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-16-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: d461cb6c-df04-44f9-fc89-08dca11044d2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	y4Y73mDBRlC+9hETk9PHDxFXYqVKJethSUz9fNRShtiYVWcvb2K5fylMJ4e+ngUMVGjT+CfkUugv+OqKv7CRj3iJsMN9kv/RandyZlqMhaFlr5VvffU/XqQ8NCFnQpv+7Jfh2d80DnnUnxDYojiamllpBWacGxYWCT1USZQScwWVTG9bJp9Gi9H4iojirmvkO63olEt0ub7uZ3Qm+v3Ey0yIu/Zorb27/aeyT0gyjK0ECcnuJDPrfZ4DVSvRX33BKGhGaUvXYn3q6JfX+WcLdK5AjKKoKO8ZTJNzZ3dFrT+D//w7TcKTirPaKXL6nKYUX2ZzfmgbP2K2zkDtX3QmTk/28c2fvooUCyhnWO/5Mu2ufzXRLe53RfGe/BNSmOIDzo/qpkxB0OlvYxSxyfT3lsmatka7TZJje4ab5OycvI24Y5HmjrHNNTJzxSIvkIgMZn+yE5qrgChM2iUrj4oHyLYRc9VZwfWHMqiwnYLBHhtHmYDBaWDDUAB8a+0gc4him0bL+4WyeVJHuA/UERtHkUvIblK7BSM3FdUHRBVPIVWnkYY7rpVw+Cu0Yr0g5xHsQZ85jh2Sd5X+Fgv6MOPKDBa4QGH8V556c0p5YXIA+KirXOeKbj3BOwrcJtPb6u/0q6AjoxvtG8qfXpbZOsgOBg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JUMplXfp9PCj1xCZCYcOrPzVsJXlgF/ojTk23FrZduvIq++Eb0fit0CQNSVp?=
 =?us-ascii?Q?KMtOpcXelwiXRn1pdokNDd9cIzhVn2DRavj9PxzFYcITF99baxtAk3dga/vE?=
 =?us-ascii?Q?3itoUmjgMuTEG5M4y346YnW16JubItLObUDaDhbvsbkJ8k0bW6wDDnckigdQ?=
 =?us-ascii?Q?svRC9kPdZsWA7gJbnREMGksjx8P/DPuTdFR2HcaBBMx0GHSV8fDq5qDTzoSP?=
 =?us-ascii?Q?X5NuMPgVwvG7jGDROPLLKnN5zcdy76ry413wrH/N+dbQCoofQMJ03Q0BhtxV?=
 =?us-ascii?Q?eXcha7by395puVGghLyQR+goE+X4v/4tet9a2K5xO7phMQ9MDqT5ZQWhvA36?=
 =?us-ascii?Q?ZdeetL2ssO72kzRpGjGkQiJAVO2AWFgn8dhrfED74KugNQyKSvO7zUt7yAIo?=
 =?us-ascii?Q?POUvZg9Qmbtjxn+R3b5O5Vn33bcRdKqR2jnsmhGlWt53/819DyISNiZE7nQF?=
 =?us-ascii?Q?5hF5KwyVAREWnTRErlfBUBt/uFZB0vKwLJ8rvs8jV0fjwGsGL2b6tGrgrOYF?=
 =?us-ascii?Q?rxYWVys6sdSXy4YxD/Mua31D20IprCZ2S0GmgXDfWA3FP/Cg9eZL16DGMj9w?=
 =?us-ascii?Q?4/k/DEbhvoNKKgycTbcJ1V2lhfBsOgM+dbmhZMX2fXFdLN9g3BKbCXhjhcZH?=
 =?us-ascii?Q?L8LEioLrFITb16jlXW0EqTySuOJGLi4rpIYfThYz2pDL7YDyH58ouGVZTTNh?=
 =?us-ascii?Q?kreza/RwjJRuowLbQWAnorDG8h5FnWW+MDtrD1qmY9e2IQgXAmQ8dcwTTN6F?=
 =?us-ascii?Q?0zPNRrm4O2ktQiBv5OsBdBjns4S8SZrn5YT6HvRGUuhWEyussygrmwt29I9E?=
 =?us-ascii?Q?ZWTZEKxTlGf1mKVAGpbWSUyVzNQyW77piZduRNmdYSZUqujbdGu5o8I2iqyc?=
 =?us-ascii?Q?i7u9KG03Y3zw5NfrjXGzz79tTrZVFYJ8tpj2PEXqCkNDj4v9qIxpZygiBV7e?=
 =?us-ascii?Q?/3brd2xG/YxX980lqDSHO9DJ11R5JDpk1uzq3cU/S6ywrebSyO6kJFzgkNyg?=
 =?us-ascii?Q?L/dzQ8pfM8OzjH3BkaGsWrMALSrzxHkgrSMwM450V15+72npDf+FEBy4a4Zu?=
 =?us-ascii?Q?8G70pFegTbEgHZvRyJcuPA0EErUP6bsSb0/0mSceAg5uk9p1A+bDI/Ib1zQb?=
 =?us-ascii?Q?SI+uEIMonvGXPPrj6rumhOofVq+EA+OS6XqFqpz/vlfHPbfP/dOXU8aMznQc?=
 =?us-ascii?Q?VrtQUuxfFRJdLOUh2x4NMAFtQHEHn8vXvHUg1PIFJesdfSkkR66CVz/AfUY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d461cb6c-df04-44f9-fc89-08dca11044d2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:44:02.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

In this test, all socket information of the process is obtained through
CRIB, including socket type, socket protocol, destination/source address,
TCP underlying protocol information, etc.

The socket information obtained through CRIB will be compared with known
information and with information obtained through getsockopt to verify
the correctness of the information.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/crib/test_dump_all_socket.bpf.c | 252 ++++++++++++
 .../selftests/crib/test_dump_all_socket.c     | 375 ++++++++++++++++++
 .../selftests/crib/test_dump_all_socket.h     |  69 ++++
 3 files changed, 696 insertions(+)
 create mode 100644 tools/testing/selftests/crib/test_dump_all_socket.bpf.c
 create mode 100644 tools/testing/selftests/crib/test_dump_all_socket.c
 create mode 100644 tools/testing/selftests/crib/test_dump_all_socket.h

diff --git a/tools/testing/selftests/crib/test_dump_all_socket.bpf.c b/tools/testing/selftests/crib/test_dump_all_socket.bpf.c
new file mode 100644
index 000000000000..c124a0491ca3
--- /dev/null
+++ b/tools/testing/selftests/crib/test_dump_all_socket.bpf.c
@@ -0,0 +1,252 @@
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
+#include "test_dump_all_socket.h"
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 100000);
+} rb SEC(".maps");
+
+extern struct task_struct *bpf_task_from_vpid(pid_t vpid) __ksym;
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
+extern struct sock *bpf_sock_from_task_fd(struct task_struct *task, int fd) __ksym;
+extern struct sock *bpf_sock_from_socket(struct socket *sock) __ksym;
+extern void bpf_sock_release(struct sock *sk) __ksym;
+
+extern struct socket *bpf_socket_from_file(struct file *file) __ksym;
+extern struct sock_common *bpf_sock_common_from_sock(struct sock *sk) __ksym;
+extern struct tcp_sock *bpf_tcp_sock_from_sock(struct sock *sk) __ksym;
+extern struct udp_sock *bpf_udp_sock_from_sock(struct sock *sk) __ksym;
+
+extern int bpf_inet_src_addr_from_socket(struct socket *sock, struct sockaddr_in *addr) __ksym;
+extern int bpf_inet_dst_addr_from_socket(struct socket *sock, struct sockaddr_in *addr) __ksym;
+extern int bpf_inet6_src_addr_from_socket(struct socket *sock, struct sockaddr_in6 *addr) __ksym;
+extern int bpf_inet6_dst_addr_from_socket(struct socket *sock, struct sockaddr_in6 *addr) __ksym;
+
+extern int bpf_iter_task_file_new(struct bpf_iter_task_file *it, struct task_struct *task) __ksym;
+extern struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksym;
+extern int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it) __ksym;
+extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
+
+SEC("crib")
+int dump_udp_socket(struct prog_args *arg)
+{
+	int err = 0;
+
+	struct task_struct *task = bpf_task_from_vpid(arg->pid);
+	if (!task) {
+		err = -1;
+		goto error;
+	}
+
+	struct sock *sk = bpf_sock_from_task_fd(task, arg->sockfd);
+	if (!sk) {
+		err = -1;
+		goto error_sock;
+	}
+
+	struct event_udp *e_udp = bpf_ringbuf_reserve(&rb, sizeof(struct event_udp), 0);
+	if (!e_udp) {
+		err = -2;
+		goto error_buf;
+	}
+
+	struct udp_sock *up = bpf_udp_sock_from_sock(sk);
+
+	e_udp->hdr.type = EVENT_TYPE_UDP;
+	e_udp->hdr.sockfd = arg->sockfd;
+	e_udp->udp_flags = BPF_CORE_READ(up, udp_flags);
+	e_udp->len = BPF_CORE_READ(up, len);
+	e_udp->pending = BPF_CORE_READ(up, pending);
+
+	bpf_ringbuf_submit(e_udp, 0);
+
+error_buf:
+	bpf_sock_release(sk);
+error_sock:
+	bpf_task_release(task);
+error:
+	return err;
+}
+
+SEC("crib")
+int dump_tcp_socket(struct prog_args *arg)
+{
+	int err = 0;
+
+	struct task_struct *task = bpf_task_from_vpid(arg->pid);
+	if (!task) {
+		err = -1;
+		goto error;
+	}
+
+	struct sock *sk = bpf_sock_from_task_fd(task, arg->sockfd);
+	if (!sk) {
+		err = -1;
+		goto error_sock;
+	}
+
+	struct event_tcp *e_tcp = bpf_ringbuf_reserve(&rb, sizeof(struct event_tcp), 0);
+	if (!e_tcp) {
+		err = -2;
+		goto error_buf;
+	}
+
+	struct tcp_sock *tp = bpf_tcp_sock_from_sock(sk);
+
+	e_tcp->hdr.type = EVENT_TYPE_TCP;
+	e_tcp->hdr.sockfd = arg->sockfd;
+	e_tcp->snd_wl1 = BPF_CORE_READ(tp, snd_wl1);
+	e_tcp->snd_wnd = BPF_CORE_READ(tp, snd_wnd);
+	e_tcp->max_window = BPF_CORE_READ(tp, max_window);
+	e_tcp->rcv_wnd = BPF_CORE_READ(tp, rcv_wnd);
+	e_tcp->rcv_wup = BPF_CORE_READ(tp, rcv_wup);
+	e_tcp->write_seq = BPF_CORE_READ(tp, write_seq);
+	e_tcp->rcv_nxt = BPF_CORE_READ(tp, rcv_nxt);
+
+	bpf_ringbuf_submit(e_tcp, 0);
+
+error_buf:
+	bpf_sock_release(sk);
+error_sock:
+	bpf_task_release(task);
+error:
+	return err;
+}
+
+static int dump_inet_addr(struct socket *sock, int sockfd)
+{
+	struct event_inet_addr *e_src_addr = bpf_ringbuf_reserve(&rb, sizeof(struct event_inet_addr), 0);
+	if (!e_src_addr) {
+		return -2;
+	}
+
+	struct event_inet_addr *e_dst_addr = bpf_ringbuf_reserve(&rb, sizeof(struct event_inet_addr), 0);
+	if (!e_dst_addr) {
+		bpf_ringbuf_discard(e_src_addr, 0);
+		return -2;
+	}
+
+	e_src_addr->hdr.type = EVENT_TYPE_INET_ADDR;
+	e_src_addr->hdr.subtype = EVENT_SUBTYPE_ADDR_SRC;
+	e_src_addr->hdr.sockfd = sockfd;
+
+	e_dst_addr->hdr.type = EVENT_TYPE_INET_ADDR;
+	e_dst_addr->hdr.subtype = EVENT_SUBTYPE_ADDR_DST;
+	e_dst_addr->hdr.sockfd = sockfd;
+
+	bpf_inet_src_addr_from_socket(sock, &e_src_addr->addr);
+	bpf_inet_dst_addr_from_socket(sock, &e_dst_addr->addr);
+
+	bpf_ringbuf_submit(e_src_addr, 0);
+	bpf_ringbuf_submit(e_dst_addr, 0);
+
+	return 0;
+}
+
+static int dump_inet6_addr(struct socket *sock, int sockfd)
+{
+	struct event_inet6_addr *e_src_addr = bpf_ringbuf_reserve(&rb, sizeof(struct event_inet6_addr), 0);
+	if (!e_src_addr) {
+		return -2;
+	}
+
+	struct event_inet6_addr *e_dst_addr = bpf_ringbuf_reserve(&rb, sizeof(struct event_inet6_addr), 0);
+	if (!e_dst_addr) {
+		bpf_ringbuf_discard(e_src_addr, 0);
+		return -2;
+	}
+
+	e_src_addr->hdr.type = EVENT_TYPE_INET6_ADDR;
+	e_src_addr->hdr.subtype = EVENT_SUBTYPE_ADDR_SRC;
+	e_src_addr->hdr.sockfd = sockfd;
+
+	e_dst_addr->hdr.type = EVENT_TYPE_INET6_ADDR;
+	e_dst_addr->hdr.subtype = EVENT_SUBTYPE_ADDR_DST;
+	e_dst_addr->hdr.sockfd = sockfd;
+
+	bpf_inet6_src_addr_from_socket(sock, &e_src_addr->addr);
+	bpf_inet6_dst_addr_from_socket(sock, &e_dst_addr->addr);
+
+	bpf_ringbuf_submit(e_src_addr, 0);
+	bpf_ringbuf_submit(e_dst_addr, 0);
+
+	return 0;
+}
+
+SEC("crib")
+int dump_all_socket(struct prog_args *arg)
+{
+	int err = 0;
+
+	struct task_struct *task = bpf_task_from_vpid(arg->pid);
+	if (!task) {
+		err = -1;
+		goto error;
+	}
+
+	struct bpf_iter_task_file file_it;
+	struct file *cur_file;
+
+	bpf_iter_task_file_new(&file_it, task);
+	while ((cur_file = bpf_iter_task_file_next(&file_it))) {
+		struct socket *sock = bpf_socket_from_file(cur_file);
+		if (!sock) {
+			continue;
+		}
+
+		struct event_socket *e_socket = bpf_ringbuf_reserve(&rb, sizeof(struct event_socket), 0);
+		if (!e_socket) {
+			err = -2;
+			goto error_buf;
+		}
+
+		struct sock *sk = bpf_sock_from_socket(sock);
+		struct sock_common *sk_cm = bpf_sock_common_from_sock(sk);
+
+		int sock_family = BPF_CORE_READ(sk_cm, skc_family);
+		int sock_state = BPF_CORE_READ(sk_cm, skc_state);
+		int sock_type = BPF_CORE_READ(sk, sk_type);
+		int sock_protocol = BPF_CORE_READ(sk, sk_protocol);
+		int fd = bpf_iter_task_file_get_fd(&file_it);
+
+		bpf_sock_release(sk);
+
+		e_socket->hdr.type = EVENT_TYPE_SOCKET;
+		e_socket->hdr.sockfd = fd;
+		e_socket->family = sock_family;
+		e_socket->state = sock_state;
+		e_socket->type = sock_type;
+		e_socket->protocol = sock_protocol;
+
+		bpf_ringbuf_submit(e_socket, 0);
+
+		if (sock_family == PF_INET)
+			err = dump_inet_addr(sock, fd);
+		else if (sock_family == PF_INET6)
+			err = dump_inet6_addr(sock, fd);
+
+		if (err) {
+			goto error_buf;
+		}
+	}
+
+error_buf:
+	bpf_iter_task_file_destroy(&file_it);
+	bpf_task_release(task);
+error:
+	return err;
+}
diff --git a/tools/testing/selftests/crib/test_dump_all_socket.c b/tools/testing/selftests/crib/test_dump_all_socket.c
new file mode 100644
index 000000000000..15add7fbf4f4
--- /dev/null
+++ b/tools/testing/selftests/crib/test_dump_all_socket.c
@@ -0,0 +1,375 @@
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
+#include <arpa/inet.h>
+#include <unistd.h>
+#include <errno.h>
+#include <netdb.h>
+#include <linux/if_packet.h>
+#include <net/ethernet.h>
+#include <linux/netlink.h>
+#include <asm/types.h>
+#include <asm-generic/socket.h>
+#include <linux/tcp.h>
+
+#include "../kselftest_harness.h"
+
+#include "test_dump_all_socket.h"
+#include "test_dump_all_socket.bpf.skel.h"
+
+struct tcp_dump_info {
+	unsigned int snd_wl1;
+	unsigned int snd_wnd;
+	unsigned int max_window;
+	unsigned int rcv_wnd;
+	unsigned int rcv_wup;
+	unsigned int write_seq;
+	unsigned int rcv_nxt;
+};
+
+struct udp_dump_info {
+	int udp_flags;
+	int len;
+	int pending;
+};
+
+struct socket_dump_info {
+	int sockfd;
+	int family;
+	int type;
+	int protocol;
+	union {
+		struct sockaddr_in src_addr4;
+		struct sockaddr_in6 src_addr6;
+	};
+	union {
+		struct sockaddr_in dst_addr4;
+		struct sockaddr_in6 dst_addr6;
+	};
+	union {
+		struct tcp_dump_info tcp;
+		struct udp_dump_info udp;
+	};
+};
+
+static int dump_all_socket_fd;
+static int dump_tcp_socket_fd;
+static int dump_udp_socket_fd;
+
+static int tcp_client_fd;
+static int tcp_server_fd;
+static int tcp_accept_fd;
+static int udp_client_fd;
+
+static int socket_count;
+
+static struct socket_dump_info *find_dump_info_by_sockfd(struct socket_dump_info *all_info, int sockfd)
+{
+	struct socket_dump_info *info;
+	for (int i = 0; i < 4; i++) {
+		info = &all_info[i];
+		if (info->sockfd == sockfd)
+			return info;
+	}
+	return NULL;
+}
+
+static int handle_tcp_event(struct socket_dump_info *all_info, struct event_tcp *e_tcp)
+{
+	struct socket_dump_info *info = find_dump_info_by_sockfd(all_info, e_tcp->hdr.sockfd);
+	info->tcp.snd_wl1 = e_tcp->snd_wl1;
+	info->tcp.snd_wnd = e_tcp->snd_wnd;
+	info->tcp.max_window = e_tcp->max_window;
+	info->tcp.rcv_wnd = e_tcp->rcv_wnd;
+	info->tcp.rcv_wup = e_tcp->rcv_wup;
+	info->tcp.write_seq = e_tcp->write_seq;
+	info->tcp.rcv_nxt = e_tcp->rcv_nxt;
+	return 0;
+}
+
+static int handle_udp_event(struct socket_dump_info *all_info, struct event_udp *e_udp)
+{
+	struct socket_dump_info *info = find_dump_info_by_sockfd(all_info, e_udp->hdr.sockfd);
+	info->udp.udp_flags = e_udp->udp_flags;
+	info->udp.len = e_udp->len;
+	info->udp.pending = e_udp->pending;
+	return 0;
+}
+
+static int handle_inet_addr_event(struct socket_dump_info *all_info, struct event_inet_addr *e_inet_addr)
+{
+	struct socket_dump_info *info = &all_info[socket_count - 1];
+	if (e_inet_addr->hdr.subtype == EVENT_SUBTYPE_ADDR_SRC)
+		memcpy(&info->src_addr4, &e_inet_addr->addr, sizeof(struct sockaddr_in));
+	else if (e_inet_addr->hdr.subtype == EVENT_SUBTYPE_ADDR_DST)
+		memcpy(&info->dst_addr4, &e_inet_addr->addr, sizeof(struct sockaddr_in));
+	return 0;
+}
+
+static int handle_inet6_addr_event(struct socket_dump_info *all_info, struct event_inet6_addr *e_inet6_addr)
+{
+	struct socket_dump_info *info = &all_info[socket_count - 1];
+	if (e_inet6_addr->hdr.subtype == EVENT_SUBTYPE_ADDR_SRC)
+		memcpy(&info->src_addr6, &e_inet6_addr->addr, sizeof(struct sockaddr_in6));
+	else if (e_inet6_addr->hdr.subtype == EVENT_SUBTYPE_ADDR_DST)
+		memcpy(&info->dst_addr6, &e_inet6_addr->addr, sizeof(struct sockaddr_in6));
+	return 0;
+}
+
+static int handle_socket_event(struct socket_dump_info *all_info, struct event_socket *e_socket)
+{
+	struct prog_args arg = {
+		.pid = getpid(),
+		.sockfd = e_socket->hdr.sockfd
+	};
+
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
+		.ctx_in = &arg,
+		.ctx_size_in = sizeof(arg),
+	);
+
+	struct socket_dump_info *info = &all_info[socket_count];
+	info->sockfd = e_socket->hdr.sockfd;
+	info->family = e_socket->family;
+	info->type = e_socket->type;
+	info->protocol = e_socket->protocol;
+
+	int err = 0;
+	if (e_socket->protocol == IPPROTO_TCP)
+		err = bpf_prog_test_run_opts(dump_tcp_socket_fd, &tattrs);
+	else if (e_socket->protocol == IPPROTO_UDP)
+		err = bpf_prog_test_run_opts(dump_udp_socket_fd, &tattrs);
+
+	socket_count++;
+
+	return err;
+}
+
+static int handle_event(void *ctx, void *data, size_t data_sz)
+{
+	struct socket_dump_info *all_info = (struct socket_dump_info *)ctx;
+	const struct event_hdr *e_hdr = data;
+	int err = 0;
+
+	switch (e_hdr->type) {
+	case EVENT_TYPE_TCP:
+		handle_tcp_event(all_info, (struct event_tcp *)data);
+		break;
+	case EVENT_TYPE_UDP:
+		handle_udp_event(all_info, (struct event_udp *)data);
+		break;
+	case EVENT_TYPE_SOCKET:
+		handle_socket_event(all_info, (struct event_socket *)data);
+		break;
+	case EVENT_TYPE_INET_ADDR:
+		handle_inet_addr_event(all_info, (struct event_inet_addr *)data);
+		break;
+	case EVENT_TYPE_INET6_ADDR:
+		handle_inet6_addr_event(all_info, (struct event_inet6_addr *)data);
+		break;
+	default:
+		err = -1;
+		printf("Unknown event type!\n");
+		break;
+	}
+	return err;
+}
+
+static int check_tcp_dump_info_correctness(struct socket_dump_info *info)
+{
+	const int enable = 1;
+	if (info->family != AF_INET || info->type != SOCK_STREAM ||
+		info->protocol != IPPROTO_TCP)
+		return -1;
+
+	if (info->dst_addr4.sin_family != AF_INET || info->src_addr4.sin_family != AF_INET)
+		return -1;
+
+	if (info->sockfd == tcp_client_fd && (info->dst_addr4.sin_addr.s_addr != htonl(INADDR_LOOPBACK) ||
+		info->dst_addr4.sin_port != htons(5555)))
+		return -1;
+
+	if (info->sockfd == tcp_server_fd && (info->src_addr4.sin_addr.s_addr != htonl(INADDR_ANY) ||
+		info->src_addr4.sin_port != htons(5555)))
+		return -1;
+
+	if (info->sockfd == tcp_accept_fd && (info->src_addr4.sin_addr.s_addr != htonl(INADDR_LOOPBACK) ||
+		info->dst_addr4.sin_addr.s_addr != htonl(INADDR_LOOPBACK) ||
+		info->src_addr4.sin_port != htons(5555)))
+		return -1;
+
+	if (info->sockfd != tcp_server_fd) {
+		if (setsockopt(info->sockfd, IPPROTO_TCP, TCP_REPAIR, &enable, sizeof(enable)))
+			return -1;
+
+		struct tcp_repair_window opt;
+		socklen_t optlen = sizeof(opt);
+		if (getsockopt(info->sockfd, IPPROTO_TCP, TCP_REPAIR_WINDOW, &opt, &optlen))
+			return -1;
+
+		if (opt.snd_wl1 != info->tcp.snd_wl1 || opt.snd_wnd != info->tcp.snd_wnd ||
+			opt.max_window != info->tcp.max_window || opt.rcv_wnd != info->tcp.rcv_wnd ||
+			opt.rcv_wup != info->tcp.rcv_wup)
+			return -1;
+
+		int queue = TCP_SEND_QUEUE;
+		if (setsockopt(info->sockfd, IPPROTO_TCP, TCP_REPAIR_QUEUE, &queue, sizeof(queue)))
+			return -1;
+
+		unsigned int write_seq;
+		optlen = sizeof(write_seq);
+		if (getsockopt(info->sockfd, IPPROTO_TCP, TCP_QUEUE_SEQ, &write_seq, &optlen))
+			return -1;
+
+		if (write_seq != info->tcp.write_seq)
+			return -1;
+
+		queue = TCP_RECV_QUEUE;
+		if (setsockopt(info->sockfd, IPPROTO_TCP, TCP_REPAIR_QUEUE, &queue, sizeof(queue)))
+			return -1;
+
+		unsigned int rcv_nxt;
+		if (getsockopt(info->sockfd, IPPROTO_TCP, TCP_QUEUE_SEQ, &rcv_nxt, &optlen))
+			return -1;
+
+		if (rcv_nxt != info->tcp.rcv_nxt)
+			return -1;
+	}
+	return 0;
+}
+
+static int check_udp_dump_info_correctness(struct socket_dump_info *info)
+{
+	if (info->family != AF_INET6 || info->type != SOCK_DGRAM ||
+		info->protocol != IPPROTO_UDP)
+		return -1;
+
+	if (info->dst_addr6.sin6_family != AF_INET6 || info->dst_addr6.sin6_port != htons(7777) ||
+		memcmp(&info->dst_addr6.sin6_addr, &in6addr_loopback, sizeof(struct in6_addr)) != 0)
+		return -1;
+
+	return 0;
+}
+
+static int check_dump_info_correctness(struct socket_dump_info *all_info)
+{
+	struct socket_dump_info *info;
+	for (int i = 0; i < 4; i++) {
+		info = &all_info[i];
+
+		if (info->sockfd <= 0)
+			return -1;
+
+		if (info->sockfd == udp_client_fd) {
+			if (check_udp_dump_info_correctness(info) != 0)
+				return -1;
+		} else {
+			if (check_tcp_dump_info_correctness(info) != 0)
+				return -1;
+		}
+
+	}
+	return 0;
+}
+
+TEST(dump_all_socket)
+{
+	struct prog_args args = {
+		.pid = getpid(),
+	};
+	ASSERT_GT(args.pid, 0);
+
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = &args,
+		.ctx_size_in = sizeof(args),
+	);
+
+	tcp_client_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	ASSERT_GT(tcp_client_fd, 0);
+
+	tcp_server_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	ASSERT_GT(tcp_server_fd, 0);
+
+	udp_client_fd = socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
+	ASSERT_GT(udp_client_fd, 0);
+
+	const int enable = 1;
+	ASSERT_EQ(setsockopt(tcp_server_fd, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(enable)), 0);
+
+	struct sockaddr_in tcp_src_addr, tcp_dst_addr;
+	struct sockaddr_in6 udp_dst_addr;
+	memset(&tcp_src_addr, 0, sizeof(struct sockaddr_in));
+	memset(&tcp_dst_addr, 0, sizeof(struct sockaddr_in));
+	memset(&udp_dst_addr, 0, sizeof(struct sockaddr_in6));
+
+	tcp_src_addr.sin_family = AF_INET;
+	tcp_src_addr.sin_addr.s_addr = htonl(INADDR_ANY);
+	tcp_src_addr.sin_port = htons(5555);
+
+	tcp_dst_addr.sin_family = AF_INET;
+	tcp_dst_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	tcp_dst_addr.sin_port = htons(5555);
+
+	udp_dst_addr.sin6_family = AF_INET6;
+	udp_dst_addr.sin6_addr = in6addr_loopback;
+	udp_dst_addr.sin6_port = htons(7777);
+
+	ASSERT_EQ(bind(tcp_server_fd, (struct sockaddr *)&tcp_src_addr, sizeof(struct sockaddr_in)), 0);
+	ASSERT_EQ(listen(tcp_server_fd, 100), 0);
+
+	ASSERT_EQ(connect(tcp_client_fd, (struct sockaddr *)&tcp_dst_addr, sizeof(struct sockaddr_in)), 0);
+
+	tcp_accept_fd = accept(tcp_server_fd, NULL, NULL);
+	ASSERT_GT(tcp_accept_fd, 0);
+
+	char buf[20];
+	memset(buf, 'a', 20);
+	ASSERT_EQ(send(tcp_client_fd, buf, 20, 0), 20);
+
+	ASSERT_EQ(connect(udp_client_fd, (struct sockaddr *)&udp_dst_addr, sizeof(struct sockaddr_in6)), 0);
+
+	struct test_dump_all_socket_bpf *skel = test_dump_all_socket_bpf__open_and_load();
+	ASSERT_NE(skel, NULL);
+
+	dump_all_socket_fd = bpf_program__fd(skel->progs.dump_all_socket);
+	ASSERT_GT(dump_all_socket_fd, 0);
+
+	dump_tcp_socket_fd = bpf_program__fd(skel->progs.dump_tcp_socket);
+	ASSERT_GT(dump_tcp_socket_fd, 0);
+
+	dump_udp_socket_fd = bpf_program__fd(skel->progs.dump_udp_socket);
+	ASSERT_GT(dump_udp_socket_fd, 0);
+
+	struct socket_dump_info *all_info = (struct socket_dump_info *)malloc(sizeof(struct socket_dump_info) * 4);
+
+	struct ring_buffer *rb = ring_buffer__new(bpf_map__fd(skel->maps.rb), handle_event, all_info, NULL);
+	ASSERT_NE(rb, NULL);
+
+	ASSERT_EQ(bpf_prog_test_run_opts(dump_all_socket_fd, &opts), 0);
+
+	ASSERT_GT(ring_buffer__poll(rb, 100), 0);
+
+	ASSERT_EQ(check_dump_info_correctness(all_info), 0);
+
+	ASSERT_EQ(close(tcp_client_fd), 0);
+	ASSERT_EQ(close(tcp_accept_fd), 0);
+	ASSERT_EQ(close(tcp_server_fd), 0);
+	ASSERT_EQ(close(udp_client_fd), 0);
+	ring_buffer__free(rb);
+	test_dump_all_socket_bpf__destroy(skel);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/crib/test_dump_all_socket.h b/tools/testing/selftests/crib/test_dump_all_socket.h
new file mode 100644
index 000000000000..04453e650469
--- /dev/null
+++ b/tools/testing/selftests/crib/test_dump_all_socket.h
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#ifndef __TEST_DUMP_ALL_SOCKET_H
+#define __TEST_DUMP_ALL_SOCKET_H
+
+#define PF_INET		2
+#define PF_INET6	10
+
+#define EVENT_TYPE_TCP		0
+#define EVENT_TYPE_UDP		1
+#define EVENT_TYPE_SOCKET	2
+#define EVENT_TYPE_INET_ADDR	3
+#define EVENT_TYPE_INET6_ADDR	4
+
+#define EVENT_SUBTYPE_ADDR_SRC	0
+#define EVENT_SUBTYPE_ADDR_DST	1
+
+struct prog_args {
+	int pid;
+	int sockfd;
+};
+
+struct event_hdr {
+	int type;
+	int subtype;
+	int sockfd;
+};
+
+struct event_socket {
+	struct event_hdr hdr;
+	int family;
+	int state;
+	int type;
+	int protocol;
+};
+
+struct event_inet6_addr {
+	struct event_hdr hdr;
+	struct sockaddr_in6 addr;
+};
+
+struct event_inet_addr {
+	struct event_hdr hdr;
+	struct sockaddr_in addr;
+};
+
+struct event_tcp {
+	struct event_hdr hdr;
+	unsigned int snd_wl1;
+	unsigned int snd_wnd;
+	unsigned int max_window;
+	unsigned int rcv_wnd;
+	unsigned int rcv_wup;
+	unsigned int write_seq;
+	unsigned int rcv_nxt;
+};
+
+struct event_udp {
+	struct event_hdr hdr;
+	int udp_flags;
+	int len;
+	int pending;
+};
+
+#endif /* __TEST_DUMP_ALL_SOCKET_H */
-- 
2.39.2


