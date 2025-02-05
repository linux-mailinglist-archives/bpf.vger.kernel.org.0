Return-Path: <bpf+bounces-50556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1180A29A1D
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62253165C86
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7136202F83;
	Wed,  5 Feb 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IQoKUPAC"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2101.outbound.protection.outlook.com [40.92.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845431FECCE;
	Wed,  5 Feb 2025 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783948; cv=fail; b=eKXK8U4KMcfnZS5N9Gi/GfFNXmm5IOlaFYtJU5wQBfEvzEDn4S6adQcAllFpqoSkMxA/US6+jibmOSi2gG2GAe78LZ4o+uwPPFHBdqvnkppvKZ6joo7e4QQu/KU2TtQd64kp3WW93jD5seNQzIy5Rg3luLVAk8LOLM+IdjApErU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783948; c=relaxed/simple;
	bh=ZCw238UCCLw0WFQMWNcAwrh+jObNEhPgsJIBI6L7o6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2ZTEuVhO3REk6e3KiawHVUg4i752WMHj1s2pp+F6yAxVllp17OHcuLOgoDmcPJs2MMYIhwXP2uROB0klbjHFdFfcdULDEuRnrnX4Mlgf/y8ZShqfuZci7KsX3IUs6GVWUVsHhIxbdVrxPGW0aaoxkQUpd0WQokhRJFOhZpj2ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IQoKUPAC; arc=fail smtp.client-ip=40.92.58.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptqxn8gbHfTPTr+0q4m7BS+imWv0hJsHCX5D4pWpsgdllnywC7SVHvds4wwZTZhqZMhsxkXhOXqqAqUPhMy7QnmJq89P9llmrzjEFAggUTYgo3l1Frp/ZvGAgjeEOmyCt7lkRzJ5PfffnXOQG3jkb1g01KH+W39XGUYoauPKXZLW5PrwuJWZmthLFKRgEDz0CiGv7z0PLvY6N6LEQDsL5hHeor1PXDMIJIwW8W9FE/XCfumKzo4Tn7NOrjGCE+FeieIanW1/GTFuAeSgfjvuzQCbzkQIh5AJu7e0NJXTzkbG1eBAhEQLfbuo6na1WEVt0MlhTNPBbb56NMRsbmUjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhDPImV88+pzGKdVpUcImK8ykp0noMIIKR4vq09P7Pg=;
 b=VPChWSTZBzZwF79TQ50GHbuzGIpPWXyIZZ+WO9scsE/5/Q6kMEu6ppMnFgw4dVEuQbcMNGEyEVNs/Cac1HSVcqr3+fGVbEgBHKZYnSWnU94W/axfDiJLTTNYfEDXD6h/iunn2XzDHD7T3mJW5NHXFj2zOj5W/cTHJCpY6xRG4pC6EIzcqZA/xW6WVvevgEygrEh8lOgt5/Ez/wKsaq24yNuE2OAAZW3rjqL9pPA2Dr3B9m1jj14SRil9OVYsSW6CSsdeCTEvWn9LLQL02ab2TdmSSwDdfutWJDaOGXuGM7U5FZt2nsNiW2nrZkOE34Nl3OTeRPimeSgFOS64+thWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhDPImV88+pzGKdVpUcImK8ykp0noMIIKR4vq09P7Pg=;
 b=IQoKUPACz0iS/zhilz5a4Eq/1r73z6n03AShqE7vus3pIEqig1wbwRJjddYdiVCs45DrA/IK2EUtKlP5wpvGa3+9tl1XDtCoaeGypJrGNToevQCtp1XIqUFjAhm8vIRMgR7sqQYpn8hfQmzN9qqsCA8F6M6e65vUIIfuk9TK0UpZAzNzSdTTMyYKituMsC2pMasqnwZtM7HhhgLzpqLy0YcGTn8GvXGvuYPX2k3CvTNOl2k9deh/cAnpbR/wP+Svl0BVeK5AreOQEikFKV7QWN4K8xRO6nPbl4SOJK4pdvGzub3FnLYGRUJre7FiFUD5HTvptZnOvn1aTQ1UxbMGxg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GV2PR03MB9619.eurprd03.prod.outlook.com (2603:10a6:150:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 19:32:23 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:32:23 +0000
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
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 2/8] sched_ext: Add filter for scx_kfunc_ids_select_cpu
Date: Wed,  5 Feb 2025 19:30:14 +0000
Message-ID:
 <AM6PR03MB50805D6F4B8710EDB304CF5C99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205193020.184792-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GV2PR03MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b348d05-3dc4-4ca3-6c39-08dd461bd05b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|461199028|5072599009|8060799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpk2Yaie4e9m9cClaAKNgtXuEUKM4NCkAYd6X8h+QMCL81r7C+0wb2RYv/np?=
 =?us-ascii?Q?WR7plfEjV8QHxtNj9HhU88aFeoopvMT9wBqfuxjTvBbd3Jfdgk1U0MjCR4VZ?=
 =?us-ascii?Q?FLWNfd2yZYAYZUU7OGsjv/mWGYehEDXgaA5qe+uWcEMi5aJQ9I/NdM383rOU?=
 =?us-ascii?Q?cLgRMy6U0fOKkXOZ7PjA+yv7uvTR+5TTMlmOoklNmpxYTmDGNy4h6ye9lC70?=
 =?us-ascii?Q?mI2C53IA8wC8D/kYCdxYEbF4Hbm583tZJIP0if7oOC9uanqBt3sGOy0PgPUy?=
 =?us-ascii?Q?eC2f1tmfl8b9d/KfYBV0Ndpi701xau0gDEmi0WnvDNDqvXpHIYS3kkSleTdd?=
 =?us-ascii?Q?Ek0P/FH5Z4QOmJ0BMuUZiDZuSP6vP30orAe4o2ImA3HaXtP99WglbslE0QJA?=
 =?us-ascii?Q?MvKp3BfTelKmlVfT+oVOR38D23mhwpTKRT/BW6tpWVwEBba96uedgF9HXcA5?=
 =?us-ascii?Q?pHWjmcMQO85u8zp1IN6WVliUgEd+5M6yIEoOaePRPlV2LyYSsG5+x4algAEX?=
 =?us-ascii?Q?gQ1AXEjdgro4PFZPbR3LisoKfWWunsiJypcShUhJGMnoiA5gsBy6VHSPUjuN?=
 =?us-ascii?Q?7wymDFT2Z7E+L1JFu3GU4VKXhKVeunleEqAEoboPKhubxTY68NTE495/3wQv?=
 =?us-ascii?Q?2wqClOPnRti+bl6Aftp2Zpq7gkLqeRnyqiM1nz7ChDat4vGAO3taOqmqLjnp?=
 =?us-ascii?Q?EFs658KeF6PsEZ4gFJz5mRiCP8FOrLOeuZVkFuppuqoMiHRz5b0AGTpZNYRo?=
 =?us-ascii?Q?zMF8hnb2sOthV35ILXGaFSw5J0uPK0jQm90RGWn73EyZ+KqpYubQti+ax0Vy?=
 =?us-ascii?Q?c+AuXNidm4ZXv/y5aiOEvPiPrZS3caFh3BtosjXxHOMft1OX+wijIXVbt4z1?=
 =?us-ascii?Q?9zXQZwK9Ss3hEnwrP8T+NRKVj7YCZlJ7jJfDRR5F2IOcKUp/QLSR2oeuaifh?=
 =?us-ascii?Q?a/lHgSRHPDQflNbXvwtrcXgc9s+DZmFFASB6lT8P5yM3gvFciPijdoi+wa2c?=
 =?us-ascii?Q?f1Vwa2koNpwmv4ST4OQhNAsKhQ4rVEm5NdWuMfj/SxWuDums/GBxZiCVFm2u?=
 =?us-ascii?Q?DDbn3vFw3bUasTnEZj0wXypTqZMrCw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JrmXBiHufecFJZbD7+whIPfdlLlGrkSUZWJw0FputzCJBPFxrES2wkawOgbm?=
 =?us-ascii?Q?8lqE3L+n8pfdhEF0yUeJm5LuY3Xuu8iLQreeDCZUtbCdvB2l8xVWKsZ9EVYk?=
 =?us-ascii?Q?vbDExUn/GrmH7p4fIQADLKglYTaOXoAQX/yJaktePraq83fLLDAnHye3pG8U?=
 =?us-ascii?Q?Ay7kKv7JY9csc3YomesbPi0BHOUf1iGuMTbr64KzHWCcxYQDkJX6gnB2Gzj1?=
 =?us-ascii?Q?ISCNyknrxsOBvN6OMyRpYiyu9vYxGLjSwlt6zIN3BR0aR2Hy6qTiJFJSaNbg?=
 =?us-ascii?Q?b5z/kY8PL7RgI8RAeW3+CeqnWAbLUFfM+GQEnzbtEN8Jfgh0/oH9bXVKGvlk?=
 =?us-ascii?Q?vLDIfZ/nWdDa9HvFiAc4NnUt2K7V3npLNKB8/UWC9xFmlYKOwr2pnP/GnIu2?=
 =?us-ascii?Q?v7gXCgRCry6ED0RLD0DMLm0knPQwmLgag2wODl9/CgV6r+Km6gfB9ua4XB1H?=
 =?us-ascii?Q?6PYlszNtjwvmPC27nt3UarUQN+6+cBMWroMuGUiGJ8hHTMMVQk+CLsgu6QD5?=
 =?us-ascii?Q?rqjCDQeI8mFH4P/nenaTjGbGIbMu0miDPIxntt8OpW2CEzbAVHI9lh399vx6?=
 =?us-ascii?Q?XX5K49aeYKhXBelRECIb7axxvJAwKpVFoXxSzimAODQbs3/91CH9Jqnh/PC0?=
 =?us-ascii?Q?lz4l0cSbz5jCEpnwvFfw96M8t/OmYdnXEgb3NeT+siouLYY3k1Pq6JpqNepZ?=
 =?us-ascii?Q?QbppRe+k+TNsbRbd2IMv26JHozD0p0zn4/XqGk1b0D72SaOsyOle4PyZFPpn?=
 =?us-ascii?Q?O47f57k32vYyHCkjyrNynCTmzElPuYAWlif57NlQAqQule+cNg3CD/DbjDNB?=
 =?us-ascii?Q?nPYF2HFbkAdqfVXJ24D2cfCKuDEWTClr3H4vRs42a/yWID9v713ekaffMehz?=
 =?us-ascii?Q?f5JtODBne1jCl1NSFNESMsnEXfG5cevjm077u9yUKfdKUnNS0lzlF2tQ1yBW?=
 =?us-ascii?Q?KavJevp4Qy04Cbq6rt3+1SRsUpQO0ZXPRA9hAEorgPpVJOOoED4SyYrq84qH?=
 =?us-ascii?Q?bXV/ji+MhxbGpypYEvivgd9qIl2BzqEuUHYD132uSHOljbEGId2cxmlDSfrG?=
 =?us-ascii?Q?DATzq+VIwDe+B/ALbhwRyEVLaJVVkucexppJ31dos4n/gY4SFY2wYpbRur0o?=
 =?us-ascii?Q?ZqSwAwHGNIA3k2DczTBi8yAXNVV5WSKMmbDJFrYYmt84qwFsmDeMo4j9K4ux?=
 =?us-ascii?Q?gVE6CF2BsjlE7/ELqmvw1bSEgRNnQ1Rx7HQI7M8kBIMSsQnseNHisA96LkMg?=
 =?us-ascii?Q?b7sWPAU3dLzGlDEjV6qi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b348d05-3dc4-4ca3-6c39-08dd461bd05b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:32:23.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9619

This patch adds filter for scx_kfunc_ids_select_cpu.

The kfuncs in the scx_kfunc_ids_select_cpu set can be used in select_cpu
and other rq-locked operations.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8857c0709bdd..c92949aa23f6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6401,9 +6401,51 @@ BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
+static int scx_kfunc_ids_other_rqlocked_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff = prog->aux->attach_st_ops_member_off;
+
+	if (moff == offsetof(struct sched_ext_ops, runnable) ||
+	    moff == offsetof(struct sched_ext_ops, dequeue) ||
+	    moff == offsetof(struct sched_ext_ops, stopping) ||
+	    moff == offsetof(struct sched_ext_ops, quiescent) ||
+	    moff == offsetof(struct sched_ext_ops, yield) ||
+	    moff == offsetof(struct sched_ext_ops, cpu_acquire) ||
+	    moff == offsetof(struct sched_ext_ops, running) ||
+	    moff == offsetof(struct sched_ext_ops, core_sched_before) ||
+	    moff == offsetof(struct sched_ext_ops, set_cpumask) ||
+	    moff == offsetof(struct sched_ext_ops, update_idle) ||
+	    moff == offsetof(struct sched_ext_ops, tick) ||
+	    moff == offsetof(struct sched_ext_ops, enable) ||
+	    moff == offsetof(struct sched_ext_ops, set_weight) ||
+	    moff == offsetof(struct sched_ext_ops, disable) ||
+	    moff == offsetof(struct sched_ext_ops, exit_task) ||
+	    moff == offsetof(struct sched_ext_ops, dump_task) ||
+	    moff == offsetof(struct sched_ext_ops, dump_cpu))
+		return 0;
+
+	return -EACCES;
+}
+
+static int scx_kfunc_ids_select_cpu_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff;
+
+	if (!btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id) ||
+	    prog->aux->st_ops != &bpf_sched_ext_ops)
+		return 0;
+
+	moff = prog->aux->attach_st_ops_member_off;
+	if (moff == offsetof(struct sched_ext_ops, select_cpu))
+		return 0;
+
+	return scx_kfunc_ids_other_rqlocked_filter(prog, kfunc_id);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_select_cpu,
+	.filter			= scx_kfunc_ids_select_cpu_filter,
 };
 
 static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
-- 
2.39.5


