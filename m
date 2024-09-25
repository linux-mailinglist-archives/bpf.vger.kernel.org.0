Return-Path: <bpf+bounces-40291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30A9856D4
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC3D1F25321
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330915884A;
	Wed, 25 Sep 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="ro1uDluX"
X-Original-To: bpf@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010059.outbound.protection.outlook.com [52.101.128.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6B13C9A4;
	Wed, 25 Sep 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258589; cv=fail; b=fcxTAAFMhFV+R6t9BG/AlPOOyb3hvTgzNwpkc71W4DMbbq29MpiS3Bdd3ZbHkanXtYcmw9QhXKuJAwnhwiNV9ikZCFKvmlxLiruDHcd0RE9rSI2PmvBQqVY/4aiLMuQ80mYMCc8YuWW4TpaBlp2Aqx6K/522mA3DyfhxtguD1lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258589; c=relaxed/simple;
	bh=m3gpm6Gi1n0kC7N4/xK69H8VbtgCTP4ukZaPY48lJ6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cbYh/qUPEybHZDh8JNQD5bXmbWaQaGiuFG7MQdZCGI+8ch36a4+o+dN8j0FxvxKgmyGevoThq0+rG0WD2w8PzKGntj4hw96e+4G6OOHzhHyGr7VQMTb9HadfUWP0lMAdJ6uq93/aDlEhTj5dqP8hwchoTPe57XVFs47QBm9Lzmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=ro1uDluX; arc=fail smtp.client-ip=52.101.128.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUfl6phAjlZwbdDXb49whczAUHFSgBgFmo+w6UxjPrKbYRaHO/M9EVgi60IJ9kGi1GmF5YnXZE+NwUG/kdz8DM1Phizyvdfj0beudTvbVFcZG+tL5CjXp1164ENTnUb+W0jIT49+Y4o3C0BxsjoclMS7SYYuEn7CfyhLjDkX2X9tQQhBNGX9nuggcbb0VQSkrHhA3lTYoLwbbEfKl7nms9gG8HNTB5D1Wj3eE6NxkeZVZKy8lKk7PnE0dePaJFAAFKqXVNbVZlfI4UQGq5NMYUd5shIhTsdEWQjm2KyQC/NT6X7N47w2SXSR0divNu+/5fWRAEY2qOCYnKopGEA43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPjx0vjLdCxhDxnF1Dyf/6cPSBT3GKjf8clIUQA+beU=;
 b=fUBmmT4n1X6ORRCdujAaXQy0yKbQFjVJl21I31zsFtr28+zJeLIVYuwQvhN3C3ZpmYLjesgrrqEXO6FYKv12ggoFVuBty6aHAn8MRR7fZKinfYeHX0aZPcjPznASuy4r/Oi4PzyxZICsPn8EatLjKrWOgwz5PlUWfVuTUg47Ox7FlRLiPoC4RNRyjo0ySnDA6vw7efmx0ZAczGW3OGrZGJgpf7DUgrV9iPaQ6Q46TcFHUnClP21InflysCvLluWIEn/2vyBEu/cTscLFBf0ikqxipHnalxVu87fgV7hBl4mpQqzTsRBci2iu/C+cpyQcCC4pELg76fP58BTJp8rVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPjx0vjLdCxhDxnF1Dyf/6cPSBT3GKjf8clIUQA+beU=;
 b=ro1uDluXz6o9IbDB0MvSpp8xc97gJ8goEZpxztrpR6W9YKgOwlw2BGHNJGsw/gvW0sVzkq8pKVt5GZA6DFiiqIy4QTAOmN9xOLJtO/hd2bpLd1NJMshdu1bpINfVZAgyxqqUBCrU58mdpxLaWg3vWx0sf497LC6/77cH9r9+wYc=
Received: from SG2PR02CA0001.apcprd02.prod.outlook.com (2603:1096:3:17::13) by
 JH0PR02MB6940.apcprd02.prod.outlook.com (2603:1096:990:44::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Wed, 25 Sep 2024 10:03:02 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:3:17:cafe::f8) by SG2PR02CA0001.outlook.office365.com
 (2603:1096:3:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28 via Frontend
 Transport; Wed, 25 Sep 2024 10:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 10:03:02 +0000
Received: from PC80318983.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 18:03:01 +0800
From: Eric Yan <eric.yan@oppo.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <yonghong.song@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <eric.yan@oppo.com>
Subject: [PATCH] Add BPF Kernel Function bpf_ptrace_vprintk
Date: Wed, 25 Sep 2024 18:02:54 +0800
Message-ID: <20240925100254.436-1-eric.yan@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|JH0PR02MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: a4353973-afc6-43de-eee3-08dcdd493e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?li3xsdwpex9cFP+rQmXSxg2IGb4ayat3HSkf45Xdlz8W9geMKhs8dFfmLSWD?=
 =?us-ascii?Q?Xa/p3hQP8sZZHt9mM3t6T5k8e5LG2OvZES8tRE2oLw5Dn7LtGywoqmx3aU34?=
 =?us-ascii?Q?Xl7dKvOujtaJHYm83aEc+T89aaiX/B+uqmXVCYFbk8D++j8YmRn9CHPo+YTX?=
 =?us-ascii?Q?d9ekq/2r43HgtHsmqOPmf+wxtzt++PtRsGlTOEZYDIjHG1osdREhiDhvYYdU?=
 =?us-ascii?Q?NpykgEprHNs7AcktGdD3y/7xKjjKzKczlGoxwPVI/Un1BonjROW2c2ROpL9o?=
 =?us-ascii?Q?pk3nh1Fc9qU1xisJP0z1k+BGaOZyFJa/5H3h5wqrGZmVhRHR3YzOO1lA1RRq?=
 =?us-ascii?Q?m6kBlkC+xpkAShyERjaoc/VSpvFpAdLm9QF42bb9C+tNZZReNGSc/QILCS12?=
 =?us-ascii?Q?Vr1SF/uaNkspvgFn+MEEWjoTf55d4JCk36V+sHL1pPgkciPG4O8jPaaGkNWl?=
 =?us-ascii?Q?fI3sBXHmldKE6VI4EXI/gG/fZhAwpNLacFiqSTx3AbDId5yEGE2HZrLjdR26?=
 =?us-ascii?Q?hQ7B5DljWbdPqXH+X60KCCODpiRY0RJNsQt02w2lQ6wrwLp4eO8vmNJkuMZL?=
 =?us-ascii?Q?PTaYgH5MCQQBn8h9ehpSpJURq0cGBcouwkj+U3EaqGTX+zUzl9Y9CpPwTuns?=
 =?us-ascii?Q?7IrQuWIH5IxhiQX+3BYkwJOzGSwfLPR+Y7vTh2Mm5j+wgxsbaePWOw9C9Afs?=
 =?us-ascii?Q?Wti8v4V7J3M2CezPbQfE3fnM2Zl9CnDZCQoBQ3wpwxpWc2dad25Djz+47NeQ?=
 =?us-ascii?Q?UWVwT2Lrt2u495GtX/BJgbqsvI2D99CFC5zASQueiks+vkQ0z3D2hCagBgTh?=
 =?us-ascii?Q?3LQioXM+Zl3VORlvV40OSWfKpuu8OWWjqbGKaqj69LaeSXTc+Odl3fQrUApF?=
 =?us-ascii?Q?T/lstRfSCbo5SOLF1ELBbsSr41nBwRJBblMthT5p7aknkYYczq4NqHYOQrSN?=
 =?us-ascii?Q?sHx+bowBIWbg1KrwUpuXxB/B3DnB+HlFIpN2vFoSYfa2MhxZ5FcPVa+CUpkr?=
 =?us-ascii?Q?8NGLuAEDh6f5nELfEUM68hfq5TtmuajawwYIRED+90W1rpwtjpltVWNWdylO?=
 =?us-ascii?Q?dYNO/fFYs2D5oxFtX3jrgYZ6lu5yh1uFR3pxsJCzfm6kjTJtvDVS/nGgCQno?=
 =?us-ascii?Q?98UYMGFr4X2blbv8ozwXQ1HKfaS4kZx4IIwyWOLUIffV8fObsxWsySYeVy+o?=
 =?us-ascii?Q?YsoDYEk5xEG/tnRc7rv4yNVu9R438O6eIareh0sMpRSBQCOMHwxDtUvvogHk?=
 =?us-ascii?Q?3Ll/BGdjEkewQ3e39oDDORwfpJQZbPWKl5kClI6WMveksNTjomuuytuRw20s?=
 =?us-ascii?Q?XrfZ0Yzc2Xl0cmciWhlsFoBWQf4SI0+ujjSSlUxdB9+WY1ncgypI/R85G4DN?=
 =?us-ascii?Q?Izihh0faW+EMdHvlFdWRkW8LoR9hRUkgtQ18PJ7hRBS9t1Zn9dICTAt0tGLp?=
 =?us-ascii?Q?513wEzJuBseExNkngvDpZRBF59USFTRqDY23JfJuFdfExSiWoSsO/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 10:03:02.5861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4353973-afc6-43de-eee3-08dcdd493e46
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6940

add a kfunc 'bpf_ptrace_vprintk' printing bpf msg with trace_marker
format requirement so that these msgs can be retrieved by android
perfetto by default and well represented in perfetto UI.

[testing prog]
const volatile bool ptrace_enabled = true;
extern int bpf_ptrace_vprintk(char *fmt, u32 fmt_size, const void *args, u32 args__sz) __ksym;

({                                    \
    if (!ptrace_enabled) { \
        bpf_printk(fmt, __VA_ARGS__);     \
    } else {                              \
        char __fmt[] = fmt;               \
        _Pragma("GCC diagnostic push")    \
        _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")  \
        u64 __params[] = { __VA_ARGS__ }; \
        _Pragma("GCC diagnostic pop")     \
        bpf_ptrace_vprintk(__fmt, sizeof(__fmt), __params, sizeof(__params)); \
    }                                  \
})

SEC("perf_event")
int do_sample(struct bpf_perf_event_data *ctx)
{
        u64 ip = PT_REGS_IP(&ctx->regs);
        u64 id = bpf_get_current_pid_tgid();
        s32 pid = id >> 32;
        s32 tid = id;
        debug_printk("N|%d|BPRF-%d|BPRF:%llx", pid, tid, ip);
        return 0;
}

[output]:
       app-3151    [000] d.h1.  6059.904239: tracing_mark_write: N|2491|BPRF-3151|BPRF:58750d0eec

Signed-off-by: Eric Yan <eric.yan@oppo.com>
---
 kernel/bpf/helpers.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..e3d17d3b17c5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2521,6 +2521,39 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 	return p;
 }
 
+static noinline void tracing_mark_write(char *buf)
+{
+	trace_printk(buf);
+}
+
+/**
+ * same as bpf_trace_vprintk, except for a trace_marker format requirement
+ */
+__bpf_kfunc int bpf_ptrace_vprintk(char *fmt, u32 fmt_size, const void *args, u32 args__sz)
+{
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+		.get_buf	= true,
+	};
+	int ret, num_args;
+
+	if (args__sz & 7 || args__sz > MAX_BPRINTF_VARARGS * 8 || (args__sz && !args))
+		return -EINVAL;
+	num_args = args__sz / 8;
+
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &data);
+	if (ret < 0)
+		return ret;
+
+	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
+
+	tracing_mark_write(data.buf);
+
+	bpf_bprintf_cleanup(&data);
+
+	return ret;
+}
+
 /**
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @p: The dynptr whose data slice to retrieve
@@ -3090,6 +3123,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ptrace_vprintk)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.34.1


