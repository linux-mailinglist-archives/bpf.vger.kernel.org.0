Return-Path: <bpf+bounces-34433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE892D881
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439BB1C21757
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12211990DA;
	Wed, 10 Jul 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="elpCludf"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8781990D2;
	Wed, 10 Jul 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636995; cv=fail; b=VbmS7ELqjJuM/hCSb1oJKoJuwhb15WAjsg0BHc9Azo8piE705JqORGnALeNAk0CxBGO2lAzTjqfHBkER53rveunpS1dT5XMqWq84oA/DjgE4BzuguEClt9B4eq3VVeSTU+Zjz0VsOOPf8zX982iPTlpOujKnQ2qMgOiIXNdDSlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636995; c=relaxed/simple;
	bh=cDuPnEMg04Uv1rTocjZFvg8Dxz5QqjYI4XdbER057dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFQyyKTp2BUo2hNUjc3yAcLEKzFkLMRgLYeXWFKwekS7zmM86WQqZhZAFtGZ7rWuSDd0QfF/DB8SFvJ/p4qVM6hyx9lN3hqaEkPGtt5fJZ1lh/VJeAz5NFzBQYLx7hHcyw5QxJ9llj8mGtkYiCSZqMBjRfiCo73GeTnj+Ep1OE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=elpCludf; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS2IzLwjoOSGjN4za+F67b8H5Cv0QXzdCU6S6Sc/tXSz+6G/Wn4YupYP4oWxwWAUXKloPqptL90v3adYMyRcKxIp11GknHB3cP7qdhMdge4WiXG+agdwVKahKiPueeEa0Y/tAVaLjhnJYRqa+Vzf0ASXfBjRiX988KXPH4bGCv3wMB0QOvhBk/uND1rZDY95exGIrvNqULIsY4+52X1+gI1U3wWspDAaFUMyUMwAHzmBsAiqt0Rv65Qds4mHgxNgCTgIAJu10p4lAXPlO1jiIdM+Um7YGtNshUe2sWoCyq/MU6xpHeY20OKSdaLGPe0XcgXYegW/cHjPSFQ8IMyNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epPvZUVJLFCfITLfmee8fBtxZMqqIsLm5Kg+Eba8emw=;
 b=keedbXYmDiSiksB60TrpcWukR5Gd2CDy2B2eSzzcB91l2JXV/cwibtyUflp8s010Esivroxjb7Besxnz6UNHmj4g2Ujb00HHS9KjYTkTlxijcufx8f44+sYqnCFu6aPUA+lXZ6BIcR7JFboP6OrTJnuHIVQE1OXgMrNLOBe4azVmH13oiFz4gBsDHff5LU+b6sduxd39JWFMPUH5cwmd5H5O/lSmMHfM2VXCi+vW+qQbzUmfA8xx8WWCqPejGr9y7lo+49qPfcMi/E0gqqyW5MlCCTXtm/kH30N1/DfT1iC1/ybnIFPTGwf78AIhMcjUevcEEa9W+HmFuSOcTYFh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epPvZUVJLFCfITLfmee8fBtxZMqqIsLm5Kg+Eba8emw=;
 b=elpCludf0Q4yvMtJBxv/tvM9niOVWvg0EFgpTq5Mx+KB0K19UWqd0fT5DC+7JdDNal5R40EfG0dfQ+dLU9Q0Y8rAGtEff70MSckSFm+D8O/UZhtjYDMdBDC6313HQO1X4rhT8nTa5TmduBwfHo25wCz7OVbi8V1nVljTCXI3ugFr1iSR8p/Pt2cHuHgvS6gv7sujDrUtFK7/S9h08ydiFAWCmvJBbWm45SIbqDpcLESF5RzQNf8Sp8LJgLrFzk/QgwP//t4zZFixbLZWJ04+P30sGxqfxhUFj3SdeUT7U9hILZzYL7Ga6yIw8wr+qwGpgp3BS2kNrn5nIl6lr1ENpw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:11 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:11 +0000
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
Subject: [RFC PATCH 07/16] bpf/crib: Add struct sock related CRIB kfuncs
Date: Wed, 10 Jul 2024 19:40:51 +0100
Message-ID:
 <AM6PR03MB584860262199DE62D7D5868D99A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fokEbX/i7rUmAYuzBTEOim+fURLUgbnE]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-8-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: c6192381-07fa-4324-fff8-08dca11025f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	Yh0385nkqz/GMZeEVpvXIMjiSiAFfyrZPtAPRXAZFsYEqtm2Gw2qTA092DQj5JiVDTjQ/Z8MWfbinKGYVeocvIHs+NOXdA6iMQt3/nO4ZbwUAiwB2hCQ2zmbTqamerjJF4ar0dt0pJFgVF+bkk7o+DlizwRuS8Tmen+1Y9Ia8IGkXVXeV1oUFN0uutgM9FvMSisl+5qTFpAXtH9pKt0yGHPiEJIer8IQIXU/t/HOeQZFDDmSeY7y6bzrLlvcuOKMBHAKQ8YAMJRwYBQteFqD4kpPGXMVLbanVxuwdDzQEzaa9MEfMmzFAlNJiWqI4msjNaujVyFklI+dc2Q0BzwvgYRlEWJYdGg79IvGDG//pkzaCydEl/pGfmQL2aj7OYAqKiahcsgqv/kCfj7PfijQzjnpreXMB0G+4kUCWXjc2o6FXQE8X7JdMJRtSVJFuzA2H6BAvNy9X+F5B6IhFQNr+j/tiXnIlwu0hq7++Tk/mdW9jVzBNyjfoQW/dHIqpU3LmzDWDcNav0n8Dx/xssCacY2UOejHatDZZtz4aRj5RBBW7ZuAoPDrNTEEc/yz13CttNGouyuXEhm9nDWALzu5SwxSRmCkLTO5bWMRaE0IDMKyPpYuU4nuV7Btqxjv1T5Ssjg6DmoLAImRSwZRQO1obg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PvifMMyrLj4O7hHc7gDebdyWBeaNKrpvRLFZNwmBThh7gZ1DnB/ytClv0Pr3?=
 =?us-ascii?Q?2oFQ0wHWxdEkFEumiElFkVrGEpNpIwQxi3ZCMpFN2wm3RxsS263j/OGbsjTq?=
 =?us-ascii?Q?+BRp5RC6zsvp/28wjU4l8LlzMis5K4Ow0xAOTpGjykF06QIsTsaOn+wr1kon?=
 =?us-ascii?Q?2bPl9+QPuyQdPcaUGK2D8YnhJ/z76Ty9MTyRwBGPpzWPj1+ngWIlYr4wCqZ7?=
 =?us-ascii?Q?y5filbuD+NbKMPc3M4YrKCUAXNHvzklSgrry5DATYveywNZeY8HxLk+FiAO5?=
 =?us-ascii?Q?Q6lPGUXRlh9IoD2hAOJAv1lF0OJpgs+CCer807o8vW0lr0iOg9Up9KG+z7t4?=
 =?us-ascii?Q?QXHQJgGM7uTg6UEXNYaMAXNev3sFbqI29H3cFNEBn0QBSH3tLLZJ7TnS49bt?=
 =?us-ascii?Q?odekDZXg/ldljq4ZuBnu76og+jER0yLqqUG9pKM+tAMGc88+IZ2MflzjXD07?=
 =?us-ascii?Q?FjernBa7mnDpeIfa28ylwi+ub1Hnedngs4bO9Fp0alLAs8PCU2VMhnCpGZUn?=
 =?us-ascii?Q?cZPsWQwyGzYe0VP0wRrEmLTYxu/ngE91t0LgF+VgDDaVoQJ0a+VORx168zjG?=
 =?us-ascii?Q?1c7fJHBYmSpyGp9+7HWld2AtF3cdA5f6PbC8/E8LfhNZ8vOoVV2sWEqDfuor?=
 =?us-ascii?Q?O65TfWEl5hadtU8tszpV+32Trv2rNywOnGn4OhCZ0ODz3VisPs6QoUEUNSAO?=
 =?us-ascii?Q?nt3HY17viBvjEfdUUKbZ2qUunpAwnItaAvzHhDQYghj0QomrzASw0jETnu17?=
 =?us-ascii?Q?IRCLf+2VMcpDeFhT+veRVECElUcGL3SmRr1R0/3siqiBnJh/fOoAt1BCTjCD?=
 =?us-ascii?Q?lpNWh1+EGf9MzivuBwgEUD+u6k0FcpPa0id3qQrzCUWAVB1tffk1D52Mowj4?=
 =?us-ascii?Q?n3neGIwqxidDt49HkTvlt3mKjzhTF4Yp4Q9+fm7mkXTaNI7Gz0YeHZ9/wkMX?=
 =?us-ascii?Q?I1x8t5vGS18U3DKVKh6a5h6eClkEyUNatHhn0YqhTngr++htTRAw3L5ZcRAy?=
 =?us-ascii?Q?UjY+wKUKWTASNBFDFx2sD4GeD7M+mIa8Fv57XiaNN4EI4wRd2IxVXOcH3457?=
 =?us-ascii?Q?gmtx2jVWaIV6+FMNzbeIM2H5AdqbULys8n9SCIIFBSocvhdo0mFIq2Ug3f3M?=
 =?us-ascii?Q?cdKnSW4ZF1gVyeFZYD8mljXXyYGfP6K+YUewQWUE6FcUGteIL4EBZ9uIqpBI?=
 =?us-ascii?Q?M6XY9D8Vdhm9y8FB4sHtOJaiVYjs8DuFJarL+aArMjnC/j2JKnNg4ZukV2c?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6192381-07fa-4324-fff8-08dca11025f3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:11.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

This patch adds struct sock related CRIB kfuncs.

bpf_sock_from_socket() is used to get struct sock from struct socket
and bpf_sock_from_task_fd() is used to get the struct sock corresponding
to the task file descriptor. Both kfuncs will acquires a reference to
struct sock.

bpf_sock_acquire()/bpf_sock_release() are used to acquire/release
reference on struct sock.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/bpf_crib.c | 82 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index b901d7d60290..d83e5f0e8bfc 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_crib.h>
 #include <linux/init.h>
 #include <linux/fdtable.h>
+#include <net/sock.h>
 
 __bpf_kfunc_start_defs();
 
@@ -45,6 +46,82 @@ __bpf_kfunc void bpf_file_release(struct file *file)
 	fput(file);
 }
 
+/**
+ * bpf_sock_acquire() - Acquire a reference to struct sock
+ *
+ * @sk: struct sock that needs to acquire a reference
+ *
+ * @returns struct sock that has acquired the reference
+ */
+__bpf_kfunc struct sock *bpf_sock_acquire(struct sock *sk)
+{
+	sock_hold(sk);
+	return sk;
+}
+
+/**
+ * bpf_sock_release() - Release the reference acquired on struct sock.
+ *
+ * @sk: struct sock that has acquired the reference
+ */
+__bpf_kfunc void bpf_sock_release(struct sock *sk)
+{
+	sock_put(sk);
+}
+
+/**
+ * bpf_sock_from_socket() - Get struct sock from struct socket, and acquire
+ * a reference to struct sock.
+ *
+ * Note that this function acquires a reference to struct sock.
+ *
+ * @sock: specified struct socket
+ *
+ * @returns a pointer to the struct sock
+ */
+__bpf_kfunc struct sock *bpf_sock_from_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	bpf_sock_acquire(sk);
+	return sk;
+}
+
+/**
+ * bpf_sock_from_task_fd() - Get a pointer to the struct sock
+ * corresponding to the task file descriptor.
+ *
+ * Note that this function acquires a reference to struct sock.
+ *
+ * @task: specified struct task_struct
+ * @fd: file descriptor
+ *
+ * @returns the corresponding struct sock pointer if found,
+ * otherwise returns NULL.
+ */
+__bpf_kfunc struct sock *bpf_sock_from_task_fd(struct task_struct *task, int fd)
+{
+	struct file *file;
+	struct socket *sock;
+	struct sock *sk;
+
+	file = bpf_file_from_task_fd(task, fd);
+	if (!file)
+		return NULL;
+
+	sock = sock_from_file(file);
+	if (!sock) {
+		bpf_file_release(file);
+		return NULL;
+	}
+
+	sk = sock->sk;
+
+	bpf_sock_acquire(sk);
+	bpf_file_release(file);
+	return sk;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_crib_kfuncs)
@@ -57,6 +134,11 @@ BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd, KF_ITER_GETTER)
 BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
 
+BTF_ID_FLAGS(func, bpf_sock_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_sock_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_sock_from_socket, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_sock_from_task_fd, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


