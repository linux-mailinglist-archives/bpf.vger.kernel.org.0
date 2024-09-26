Return-Path: <bpf+bounces-40339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD5986D93
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 09:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0441C21491
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F40E18CBF0;
	Thu, 26 Sep 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="KH0FSyqO"
X-Original-To: bpf@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2074.outbound.protection.outlook.com [40.107.255.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F44186298;
	Thu, 26 Sep 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335693; cv=fail; b=I4MaQ/iUy+/lnPyhYzWqLhRH6EyeNsxAyrU5LJ+i1nnTXaTdrxD069Snb8lykQ6eDdeggrTtWcgfcRK1Y66arUdAucRC9OJDUTbxYPZ4DhshW7PR9bw6JC+b1dvXEGF5x5JXLLqilTlJ+MyjcikEHB/YB3X25plGQDAPU4OXWdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335693; c=relaxed/simple;
	bh=2pU+oU4rRWZa6YE7k0PXpsK92aNggMi6O1dC0k6Pf6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMJqBC+G3a5c1oD941se1atqkoBdSR5AQpSx7tFlIKxt+QH1ho9Vz/+Do1K0iymjL2GmzRImPxoDprbIH0qZ8vOgmdV0IJTKIu9AcTp6k2mt4MdA+LCmES0rKMJscSCo0Z7ryc6ouGTKcS4/63lJe6G/w9L6QGrjgeCZtP2BHr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=KH0FSyqO; arc=fail smtp.client-ip=40.107.255.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSmrUsGKWSc+WQ05+DICy41ug+A6sPhYgHLFeVxvVamEkge33Q7czoh1sFvgAzj8vSDT+1Jqh8mBPwuMW6PML3ZIoTNLxqZEFDHOtbT5dr3s0rmbEK8x50e8mkE71k+qUWqHQpHDAQtWPIkI1Kq7wHm3xYXJogvHkcFNa+i+YYWDZJWiFXkwm1lk+J49T+bCqIlS3s/idtzmWEBQVYrNjEgcLCguNbA7Z/YQ/H6orBwUJ1hwF8mC96grVhrnrryI6xBC8wmTai6k39P0Pe/jPVkOYJQnH0laaouGnfB/f0UdG4cu6EULhaj58DqDzNGDpU1gTDg/uvDIxgr/JWZS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfyIKPHDgO9+FHsxIslguB7EYfRkQrogaZWRetDuCQw=;
 b=Uh+1WxjbyhUghnjr2N6BRE1YDJHm+VctzD4nMi+D2A7GYfAGAVwcXJ/cDGTc4Q3xuv4t8CHjT/KL6SIFFouy8oypJUo9iiTaqnyHqKKP9gkxZnBc4Vw38NwUx6O0veuq/594KYjFa6JBIRnWD68dbK51FcxEyYwnwx7HkJA7M5BbDszjb9pJFOKp6Y04VFGjUbT6j4mbQ9xsx/8dG1t3H7rVvjUWuxYDHmuzGsxfizAA2duUb6QLDsUYBV9z4ZLUdZ6e/5iC81dPEHPyCLGS12vu6rVhaZDw9p79O57UOwRYcctzmb31AWwlb0IhGhRaWey6qe6QD8BTfnymjgBbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=intel.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfyIKPHDgO9+FHsxIslguB7EYfRkQrogaZWRetDuCQw=;
 b=KH0FSyqOBklG8cK00z2DrEtFRaqJYHgUX8qGxbRhEBNzy26w2YGl5IA8mYDaW5WZ7pk+ryeUIc6NkGA1Xd+IE+XnAtCUTH/4PTfTGMuJQBA9wMccR3fFTmw1QfvWdFM85xV2Xt4XpIA2f5qJ56o5edx1juidByqcFgwMZUttK8o=
Received: from PS2PR02CA0043.apcprd02.prod.outlook.com (2603:1096:300:59::31)
 by JH0PR02MB7009.apcprd02.prod.outlook.com (2603:1096:990:4e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 07:28:04 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:59:cafe::7a) by PS2PR02CA0043.outlook.office365.com
 (2603:1096:300:59::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29 via Frontend
 Transport; Thu, 26 Sep 2024 07:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 26 Sep 2024 07:28:03 +0000
Received: from PC80318983.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 15:28:02 +0800
From: Eric Yan <eric.yan@oppo.com>
To: <lkp@intel.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <eric.yan@oppo.com>, <haoluo@google.com>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <martin.lau@linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <sdf@fomichev.me>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: [PATCH v2] Add BPF Kernel Function bpf_ptrace_vprintk
Date: Thu, 26 Sep 2024 15:27:55 +0800
Message-ID: <20240926072755.2007-1-eric.yan@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202409261116.risxWG3M-lkp@intel.com>
References: <202409261116.risxWG3M-lkp@intel.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|JH0PR02MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b9b1bf-dd9d-47f3-9598-08dcddfcc23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q6Bc/Gu4Pfca+dXdhPxt1cr6clNOF8/WrRY3pVSRxHTCLH+XvHuoIGHI9quu?=
 =?us-ascii?Q?rG6eqlVwmucUXK4hW8aooMFZB6xcHSZnV7vGps1KZ9NcYhciuVYpMX4hFfMd?=
 =?us-ascii?Q?sCvRBqtfwXGq87FujCgQOS4Rz/jSDb+TK5Uf8eBC6X76PJEIIxgdLKFgcYPT?=
 =?us-ascii?Q?Nmjp5fCnHpfmT1kPWIncnTeL4cVFVDCxsE2MkJsEm9nGM2/U692/W0/iPoOY?=
 =?us-ascii?Q?eBnuvWZSwBBhDgVocb/5hXzJzsZyc14D+wfI73EKtywAMBo9bYDm7od7vheS?=
 =?us-ascii?Q?/PPgkv7j74vRJkz28hQEBlzA64katn0U+QBx6OTcouKCL4oFJjH/Vay0orTy?=
 =?us-ascii?Q?Gf4+0/EYkv4gL1vhXY+R206a/7jR8KXTXGSb+/9RI8agZJlwLGcS1fcquv5y?=
 =?us-ascii?Q?sfcjviUOU8BX7N9lyYN0YPKv3dOzAzYfSDEV1sUJNCSeIqaA14k6W7hZs08U?=
 =?us-ascii?Q?QFiUvk7QJPi/6hPjlvmix2m6FxCXNEcQi6PDDwNnPHvu4n3dj54qMDxks1HT?=
 =?us-ascii?Q?bX97p8yMgyHoo3dWd5s0A8ClZGUUeTUSQa9axQNHz3psWy1NjPXYJ/dnJe5v?=
 =?us-ascii?Q?Y8OE0sNbEo6xGPUgIpYi0MY034PASQeqjNwkM5bVq3oPDHKOTuxumEGl1X2S?=
 =?us-ascii?Q?lgPWNL8b6yliEft6lqjT4CjEvbJXN4Pvi7UNZxD6rQmPzq8F8R2PnWpN/wFS?=
 =?us-ascii?Q?aQ4GuKJu3gNJ8x2XZ+ednx9CvDnf+MzSrAWsYk3Z6NJf+2zlXZ91ea7AIzg5?=
 =?us-ascii?Q?RrkMigrizfv1GnOtTEQAz7BH4gU7YMVydNV/B19NunVp3MGNq6D3syVlrxf+?=
 =?us-ascii?Q?9iZTuZgSZBtgWDgIuyQ5lhIIwooimfunlE7YT3YErZLBehjYkBvkItOeSfhN?=
 =?us-ascii?Q?lDaDel/JBrAznV3xZV/YQoSOppM6kus+cgxP/HFVbz+Dnzu7Re4geN+0QibQ?=
 =?us-ascii?Q?iWqMWU5ElknX9+FirCgIxfrUQePJRX4uDn95YDl8SKePjT56TVup51grhxl7?=
 =?us-ascii?Q?i0Z8wlGXgVlZ/eyyoXq9E+gHxC08q9b2arnAs04gZsznfWsPwKr0H9cZBtlh?=
 =?us-ascii?Q?uQ8WmskL9DPyTRydh2/k/efniEbmoKhPCo5PqQG/ytW6Vv9+JNddL6YKVL0E?=
 =?us-ascii?Q?zGZK56kBTw7GpEzTh1mVzLKRC49Hs5LWM9JDKYUduvXzLuYKr2sEKVAx7xv2?=
 =?us-ascii?Q?Gur3ds2lYRJ+YBfTK4+D4CMyUdeHvjsGlJBQYVD9Rw5XIddTYtSHeWmqW3wT?=
 =?us-ascii?Q?b+Q0iFeNtWmt/7o0Zd/wWyoZAl56cPpCtSvVPlE0IbGk7+ZfTZMAVh/iAJ6n?=
 =?us-ascii?Q?tAJfM5fNJO73J4cLZiVjYRefrFFtrx1DWERKoId/RayKzq7xP6jZoTzc29Kt?=
 =?us-ascii?Q?loE4bwGXJcGoi+EfqNT0N6IddLDJ?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 07:28:03.8452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b9b1bf-dd9d-47f3-9598-08dcddfcc23c
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7009

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
index 1a43d06eab28..1e37dae74ca6 100644
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
+/* same as bpf_trace_vprintk, only with a trace_marker format requirement
+ * @fmt: Format string, e.g. <B|E|C|N>|<%d:pid>|<%s:TAG>...
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


