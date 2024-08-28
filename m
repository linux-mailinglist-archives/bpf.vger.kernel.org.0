Return-Path: <bpf+bounces-38313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83D96314E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 21:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23DD1C236E9
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612C51ABED8;
	Wed, 28 Aug 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GS0kQ2Cj"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011034.outbound.protection.outlook.com [52.103.33.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C85189511;
	Wed, 28 Aug 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874722; cv=fail; b=OaELbaoqQ9A5C3xfiQTT58xQ7OuRP+Bs5x4Sj111TILQ2tLu9+IofPVGUWxPbQivQ4Us0wOREhofl+o3xbzRGSMosfv9Bz4xGwfonRcsldYNB0FJCevURHeILufghimaoBsUgwnwzmF5FXcLwzEy5+EJcRxmfj2NkZ74gXAoFOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874722; c=relaxed/simple;
	bh=I+PRF25M7jfBqRgW2Ga7WKjqfRzrL9d3hmcjmGC05ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxG/H0rd6kkVnYFmEYczmfyCuleQfqZlW3vo8/4XCYcecLKIHSYXadzOXyLTEVCFIMzz1aBlnniolBiiPstK/F6UnrEtgaenoXgGdUSyghzYDyr+s6aYLYx6nvpGsVPAJj0m84JRoYLNZjMHyV18pHRs36zBm3SD1tS+qoXUDmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GS0kQ2Cj; arc=fail smtp.client-ip=52.103.33.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMHTIxIG5Cla0Y9BsGAhrE02NBIooSNtWFU6qhu5zlujjs2DYUShluDGW6iwPpk0WnTovNLC0jxyfhiTdlvDT0xDZwNgtFAK8SJVrmQkMH9rxN9fiogcKW0OnJqin1Y3HsX8Y4s9FdTGiaTUAPmDHRMQDuW05YXIG/pzY19CMFguYqViTrP5jmvv/TXEnec8XI90xMfiKWgZ+G0cwoCNG0/ifhMoaelJfQfN5SeiczET8aHdNI13TtS5ssdGKuSTe8hanU0ffkOVRXvqVwT8cuzlnOVIMVcMj8j/fNycRV4kY7iRhYn/kRyLYnh5Gc1VoHI5kGZmTEINHLX0R9O5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRzYS+j2NqWHTDb4LpZDygrfOUTmSmzG8CChrzTWgHI=;
 b=JimFrS4FyAT6lkx5MG2bx5lz2ix4M5XW6x6BeLBSykSgcE05aDhFDxWtQ1SlSuj335mXrxJfBtDQ2F34o93vUs2nGMAJU9XIQgl0DgBeWN7Kz81DWo9LcOAq9XTWtZtPZ8u3nGQjPHM28JKa6h+Tfx5cPZTe0/cw4GwZua9pCxxW9SO+7ZqDwpPcBd66kcAVMiexnFSypyou7hnQFeKoKUcrESrdOcdC0scU79MHmtrgXu1s+7TlR3tC8PT61CevGkf8VxRCAUEbhvAaGgSVYvGN2L9Xn6wUSRcnvBZH7EbK/8x+x+ruJ/WIvSFbBhkZq9BXUd/FkZuLa+uQzOszZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRzYS+j2NqWHTDb4LpZDygrfOUTmSmzG8CChrzTWgHI=;
 b=GS0kQ2Cjuyn8sqnbc0eh3D8wzGxc7q7qrvbPxbHw2ArLcu6E9sfY8nPJzQ/GF/tAUtQFpkvuGrXD07vqaLRePAshWz8EVF3jdQu3C1E02LlA+mGYemW1anK3Y9eqXnGN0BHhRIc4mKttOnmpaUHZyzTxpM9EzRaObHkZ6EilGqF92O9VaNemeWfuuxxC51sWvVjMbqisaXOWYN559mVmDzEqzC7e3/7aYh1GEiCv6OW0M/udhyo4pa8hgimqqRJ3OBOWrekJzAnxltZChNCIruHMZFMIgDfNMnWay0zQFoX2xJ7srNjKuvU0XuHGUwTGKMIH5wtT38dsj4kVhBsp6A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PAWPR03MB9785.eurprd03.prod.outlook.com (2603:10a6:102:2e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 19:51:58 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 19:51:58 +0000
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
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for zero offset or non-zero offset pointers as KF_ACQUIRE kfuncs argument
Date: Wed, 28 Aug 2024 20:51:32 +0100
Message-ID:
 <AM6PR03MB5848CB6F0D4D9068669A905B99952@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB5848FD2BD89BF0B6B5AA3B4C99952@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848FD2BD89BF0B6B5AA3B4C99952@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0BW342BtYrawydNSq+Wc5V8bxSrN52Gb]
X-ClientProxiedBy: LO4P123CA0531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::15) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240828195132.50260-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PAWPR03MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: abc03ebf-59d0-4048-f9ff-08dcc79ae027
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|15080799006|5072599009|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	ElpsPg1MvCmqFkQJfgQyZvxgx5exuwIsUW08NEhNhq2DgRU4jaLiUDZOMC5JZneOawjXvrUocDPjzsko2ZLk2wLDLNBZeK3mqoHPSY0GWB1tEp5Nupr7IdBDKSQN/OnTyKPvmMsiv1JP5JC2NhYRILU1ocq/CJrfOAUsCELWhKQo7x1DU7HEGIQSJnVplVYcwY0u79VSJfnugVffOY4Gpy/4X0UxBaGkcV4wmPwU9gO+uEtqtglwVWSxRj/xEP11di/dJsyj+Rk3wwSKHiUY+X7/YTBgf2B0ij8x0AF58o/EN5EXBSz4HHbPx1GsPRcgT7G1Hd2/YtoG2V9gS/ObPfQf2xb+Krs3zRoTIP1OaitrxlMRIgKs2XUhXtnsyjVvReXAWGPVgaIqXGPo4yTmbpEFNyYvp2nzfX3+KkqvKKDI9bx0q35Pzoiv7kALiHUPE4WMxQcExFlFnKGi40S2ixn8H+arFW76q6gbqqB8hLggI2e9AF+CPClTS5eiQDu5SXHUnv1TfTvjAEPspTJyJFGiRVZ0WXvl5aicJLmo7+vbksbnW+TMRh/XYOeeQEFR05KannER+b4rjGbP8aMVy9msdg/XrZiNfhHW5RXV3BXzDL1Ovkx+VMJ3MOcl7rCNdGqTBOTluJKZW8ZferJ7+rYsNtDek/vXjuiV7VrBxvnAMtfYsBbnJ3LhH9SbWl9knAlJIYxxK1TB40K+4v+ckw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSqpcoqb3RYvSgvfjhIgOSCP5HWrquOyJIlZ8mAQbtOOfWeMkCWJ6Ce+n4Bf?=
 =?us-ascii?Q?JHmDS6HhB0C7bYgMWv9Lzf2xn4Ag0PJprGNOPr4LI8mGGWPfIQetr9s94KVX?=
 =?us-ascii?Q?Qk1CZCcjeh5TibROEdq3kxX3FVdpCx1rDvTWv+UAa+M/K6JxncAd8JNNQMfh?=
 =?us-ascii?Q?GJke3GyHrt8XBRrPgqhR2MOctWgo/fd4UrahiaXEIs6LCHj/RRpXYxtpz9eo?=
 =?us-ascii?Q?g4+iUMJq8RgqgFOduqYJJLc2AIN2BMWnZWUylws3oND3jocrAoyAIaeoTiFD?=
 =?us-ascii?Q?vafTf0NDf4XZF/z4v5OCgYTrtpdO5ym0qmwV4VAmNAK4mDPp5+sl7JNiyKWf?=
 =?us-ascii?Q?oH2dK2TH34OseBE7wuoYjEy6rYjTyF8llnQ2pB60wG+n3dcZJM8pZOVz/VO2?=
 =?us-ascii?Q?0QMstrUYGyNHL8q+/DHgGv5sMDWmt6j9eAKBL5gsGYpQ+0NRyhZCa3+3ffCr?=
 =?us-ascii?Q?U8IGbhbYBBlYA55RwY90SVsQn9twZ2RghjpSREP572xbLfEA6sf+ngmQw/jX?=
 =?us-ascii?Q?2pSL3XcvQvIXz2zkm1Z3Pntz5XsvO9VHs1Ex4/F+KFumXpXlYi8GVXeW2dka?=
 =?us-ascii?Q?HCUeY3aYsBd40ehIciZi8aDj05WME3+0Wdyj12nLCamevDNBlp9c4JRTzBxW?=
 =?us-ascii?Q?M1yJ+DlJ5ygdnlvZPTU1gWivfer4+xVEt8TcOmplVNy0uB4qRm22lyI0nflG?=
 =?us-ascii?Q?drEDHasdYftBD0r1ZaTJ7cS22CIFAob5TfCkiGUV/SoHJOJLWNQ86x5+/Fbk?=
 =?us-ascii?Q?JkJIXq5MbnV4eHpe9q0D151O46oTVyeuDU6U+oP8AjkfEaRiiYTL7LYWMazA?=
 =?us-ascii?Q?US0pM2vsIyddIqy+b0eU9EOlafnD2YE1UVi6wrFi41f+Imb1VUqISS+KzOYO?=
 =?us-ascii?Q?Ex+EO1uI8ZCuRe+sIRwEPmrwCUmiSGUfDrqkAmUHpLZLOFQr4GQsC9HdyuOR?=
 =?us-ascii?Q?0hmXlV0MKhv24bw9FoKgKOC/CIGyzzFzHti753oAjTQ//XDSJRaHVyZeoBFn?=
 =?us-ascii?Q?AnpMd7nZtazU9C3/8IC6n96vJMgBK7+sEj9tHuuhrW+R9qkUn8d9xCPTqRN6?=
 =?us-ascii?Q?pc8oxJ+wFAf5eTdmIR2CvUoXy8PQ4LRJFNFkzqhaGGeiYftvWC2xptEUMZ1t?=
 =?us-ascii?Q?98qHlsdQTZ1hwzL3DX9OZvN7riC7Qa0dKgajdQ/SEPu11r6j1J5ei77+iZ4w?=
 =?us-ascii?Q?5fvUdfRa7BYBAd+eXaMxPAxZxHcHC0ltg+Q/KhRk9mFdKtzoXz5LeA+Nysbx?=
 =?us-ascii?Q?lEuewT9S90dJpLA1qLND?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc03ebf-59d0-4048-f9ff-08dcc79ae027
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:51:58.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9785

This patch adds test cases for zero offset (implicit cast) or non-zero
offset pointer as KF_ACQUIRE kfuncs argument. Currently KF_ACQUIRE
kfuncs should support passing in pointers like &sk->sk_write_queue
(non-zero offset) or &sk->__sk_common (zero offset) and not be rejected
by the verifier.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 17 ++++++++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  4 +++
 .../selftests/bpf/prog_tests/nested_trust.c   |  4 +++
 .../selftests/bpf/progs/nested_acquire.c      | 33 +++++++++++++++++++
 4 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/nested_acquire.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index bbf9442f0722..e8b34aeef232 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -183,6 +183,20 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 {
 }
 
+__bpf_kfunc struct sk_buff *bpf_kfunc_nested_acquire_nonzero_offset_test(struct sk_buff_head *ptr)
+{
+	return NULL;
+}
+
+__bpf_kfunc struct sk_buff *bpf_kfunc_nested_acquire_zero_offset_test(struct sock_common *ptr)
+{
+	return NULL;
+}
+
+__bpf_kfunc void bpf_kfunc_nested_release_test(struct sk_buff *ptr)
+{
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -541,6 +555,9 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
+BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_kfunc_nested_release_test, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index e587a79f2239..c6c314965bb1 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -144,4 +144,8 @@ void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nulla
 struct bpf_testmod_ctx *bpf_testmod_ctx_create(int *err) __ksym;
 void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx) __ksym;
 
+struct sk_buff *bpf_kfunc_nested_acquire_nonzero_offset_test(struct sk_buff_head *ptr) __ksym;
+struct sk_buff *bpf_kfunc_nested_acquire_zero_offset_test(struct sock_common *ptr) __ksym;
+void bpf_kfunc_nested_release_test(struct sk_buff *ptr) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/nested_trust.c b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
index 39886f58924e..54a112ad5f9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/nested_trust.c
+++ b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
@@ -4,9 +4,13 @@
 #include <test_progs.h>
 #include "nested_trust_failure.skel.h"
 #include "nested_trust_success.skel.h"
+#include "nested_acquire.skel.h"
 
 void test_nested_trust(void)
 {
 	RUN_TESTS(nested_trust_success);
 	RUN_TESTS(nested_trust_failure);
+
+	if (env.has_testmod)
+		RUN_TESTS(nested_acquire);
 }
diff --git a/tools/testing/selftests/bpf/progs/nested_acquire.c b/tools/testing/selftests/bpf/progs/nested_acquire.c
new file mode 100644
index 000000000000..8e521a21d995
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/nested_acquire.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("tp_btf/tcp_probe")
+__success
+int BPF_PROG(test_nested_acquire_nonzero, struct sock *sk, struct sk_buff *skb)
+{
+	struct sk_buff *ptr;
+
+	ptr = bpf_kfunc_nested_acquire_nonzero_offset_test(&sk->sk_write_queue);
+
+	bpf_kfunc_nested_release_test(ptr);
+	return 0;
+}
+
+SEC("tp_btf/tcp_probe")
+__success
+int BPF_PROG(test_nested_acquire_zero, struct sock *sk, struct sk_buff *skb)
+{
+	struct sk_buff *ptr;
+
+	ptr = bpf_kfunc_nested_acquire_zero_offset_test(&sk->__sk_common);
+
+	bpf_kfunc_nested_release_test(ptr);
+	return 0;
+}
-- 
2.39.2


