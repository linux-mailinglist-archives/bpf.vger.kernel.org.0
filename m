Return-Path: <bpf+bounces-54038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B45DA60DD5
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F896176F94
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DC1F4621;
	Fri, 14 Mar 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IIwL6oAa"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598401F236B;
	Fri, 14 Mar 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945779; cv=fail; b=VpKnalZCfyCGoXhyfqdhLh1iS8+pDsh6TwyplmWTVJH5uiG69Q3tt7V7Ft13Z6h38XiMMaEbeokI3AJ9LdoWuwfp8+ANPYEVksp5kK23MrWW1pBN2QWd2Z64Vi2kpb6yN4B9qdJpa6F+cEvDK1M+dclHslYKjtUp0NZZjEX3bWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945779; c=relaxed/simple;
	bh=bX0KGLg7VcArnhLDCA+9MB2g3vldI0RocwxNRE/VC50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBawMMCKBl7nmf52OrXWHPTnHVKShM50/xe1lccI0qOxN7Z2bopeBwTyYRKvsxPMur9Aab9OVhZ0UP/BrrDjaFIw0MLCmMYZfDUj2NKykLFZQpHB299rFYz3VbkAXWrd008XkEMkBKSG1vpRNNNA97tci4qE7VXhRoY0vgHYS1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIwL6oAa; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz+VrFbxTzQbrD6O0/3wKcnwfvCAtuYGL0zKq/5v+Ygf0ZD7vn2+WXPcHupniYxvVj7TGIENzpBiutxeU/Zc8mQx5yl2HJAmAkNL/N/182JvFn6A7V+sJJ6Z4uu5t7oJR/OpYrz5+LkaBX2skUKmpiXHT2vtJ3p0A0v/u7GXsxHKVpc5NGgLNW9aTdg8U4iS2G1kKlsQI8AD/EV+vBx7uBhts/zRLs/AFpXnU1LyqrHfixf1vg+VbwPsWTclV92G1hGJFhVqdqovZ6LtscjSKvLG9sYnvpyCFDJYOYSPqrrBwlgTA0awwOT70wIkOhhjsbZpNV86igE6B2+C/PwpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl70aBtHhZmGxOT2RbPGdbxZB5r1Gb8jki0+zEhKmdo=;
 b=toenK1F0gwCo3LLL0Wi4LHygOtapvARoo1e+0Zpih1pwkiJ6vC8hWiIBltq9RITe4XQb35hTeh4Ig8ApfD/5IQRlRrj9FpCGZzWN8slVDRUKc/MGL/W85dwGa1zM0nIljJe9YQj7usP587gSncrDB8ZKQc2KXAfUf9FvBw2gmstlre9Amsqqox8yqL8hslZo1BvAUz/Sf66ELCSdPT+5CjmOSegrYx1V6EEjLpz2o5zpLJrtP4DvSXR3eu0gmSNZYEGxrXE5HUyCh2uT46UGFEdGVgjwZ74vJJ+wyigw+l7aB+f/DTf/Dx6TucSQdG08R4PoOywHeOXOf0keKs4nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl70aBtHhZmGxOT2RbPGdbxZB5r1Gb8jki0+zEhKmdo=;
 b=IIwL6oAawe+8Fhe7gbEv/dvAL2RD2CTTaKziIMgu7koPCFHG5OiBe6F5D/hNtXTniY4nRB8LqZLpnkccC+k/0cU7x4U804GA2d3XRqqjCTgrdBu2WYzFXJeF9O65Gs+LSqwZu2aPDVL2ctKrGAnmM7E0chBkh0xxr0KN1hS6L03dNiR5kYkTMw91YCEP8rtN1QpqbEfSjRuoR9N+vztVumImMoVxP6vYFL2w87ML8ED2H3Q1ENus5q7eVjdOMzjPlqqZ2Z8oG6MxA+fa/ZwUfmPs2nK3R8JtOQKHLuBih4iMmvpaXyb/v6GO5e6nvsvB+QdsGkpCkeEV8rR09olB5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:49:34 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:49:34 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
Date: Fri, 14 Mar 2025 10:45:39 +0100
Message-ID: <20250314094827.167563-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314094827.167563-1-arighi@nvidia.com>
References: <20250314094827.167563-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0204.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: a9476414-04f9-435c-c545-08dd62dd86d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ssuKg9RTWakDLrDdthrOMKovk+rff2c/6GPyTg2rUJCkswbtvXbPKnf0SVta?=
 =?us-ascii?Q?qKQfuiTmvCbQwrL4SZ90YTpztKEL7k+eyVwQm3/W9Rf73hxLbrezIpVx22Vo?=
 =?us-ascii?Q?u8wyVEXZIg/ERCYDTz1eLp2hvN1iBemcvUFvtcq/YQjn8o15yO8wmZRxm6i2?=
 =?us-ascii?Q?K/G1AO2PAQYt9V4YiJtzD7ujmz62cXUyltLuAnthbmh9AFTZlqxSv5UjjCtq?=
 =?us-ascii?Q?KqusidATb7LWX6lFYV2HjMWGLsk3vmB+WR2Pyy+yNhWMkF6W992vx16+7lvU?=
 =?us-ascii?Q?ooYRbmWUXOcv85/pnkh29+icKtQq57cRizZBDDq55g9VM7poQAMest6XQfUJ?=
 =?us-ascii?Q?4eUGyDOVU0D/3Wojh5/hUasKQ3o1xanxDZYpAj61sk5D/CEqE33wmcbG3/v7?=
 =?us-ascii?Q?6n/hghnREVCHkOPfo1iDoBabJ/qPzb41xPjUYR1spnw+HU4HqZOCnpDPQe/U?=
 =?us-ascii?Q?c4j1dQN4hjv29j00rTryFHP3mLxYBdMAqaz9wInZ25rZFsz5Ut3avVBlU6JY?=
 =?us-ascii?Q?1vGqkP8Tl7nPdvxHQC2eKcZ86citPtajk/r3p0xkdZWjH5pWutCfCC29Vaav?=
 =?us-ascii?Q?Vg7GlEFfeP4TodkwbRsNdW5RxUmS11s45Zf+LPb5MMFl7ZG7o9SGx+KWFaHF?=
 =?us-ascii?Q?+y5cytUuGSfZVQneOcmbWl98hfJfT6agPby1HiFD8vJ9sMfCs254D1rTUsH+?=
 =?us-ascii?Q?VL+oGpRvTl44fzzzEnwBZBY/CoYB7hozXPRQSXMIDg7wdrWnrSnbJOYpgnxi?=
 =?us-ascii?Q?nxmLiSVmcv2YgupUplK0eH90MCZLKF/J7DsGK0HJhTxBS84tMeXKX0AZxcNj?=
 =?us-ascii?Q?i3mrSEZp9OksYsX2AEqRcbQtr5vkdtG+VAqMeI70i6w9WJtx13xm2ZQHHXQf?=
 =?us-ascii?Q?5XhrFq/MX2mvzl6c0gqRshbv8l7KZB8jO+JhZctp4XJ9WOmGpKllsHinlfgi?=
 =?us-ascii?Q?yQXJazU5DxTxjrJZbG6I+hjAUbR2ypR1Zvoaq+YBRea1Xf657ppUOpxmM1pk?=
 =?us-ascii?Q?29Vbh+SYWWtPWuMFK8QuXNmuf8AeQDkRQTlk04LcbgTCqShIZONlzGkmtxi3?=
 =?us-ascii?Q?y3b8zNy0h4/c8IP/X0qTqrCOE1vKxkN7uwlU0x7u+pSBnyGYHmeuaQrqiltZ?=
 =?us-ascii?Q?hoaaaU5qIM0ZPqCFVVkk240TW1ww/sInXEImsfmdGuz7l9DBFe1wisB4rf0u?=
 =?us-ascii?Q?0rh+cROawdVzG0IcUPSkfyl0xmXdtrrWAOWTAdP22monb69ejiMoU/IqHlTs?=
 =?us-ascii?Q?o8+y7f1anqZoRAHjXfFq6Iim/GuBdw5+ZsgV1ELyctIExyD5m4ms6GHVVDQN?=
 =?us-ascii?Q?8rTkvKvIA1LNKtENyV5nBi+wf7/ao+w6O/V63FsigG6xdvY1EafY00MDSOk8?=
 =?us-ascii?Q?Zj4S6FvaugE/mbUZi3voeSKyclVb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kwmLW4KsDrCzf+uLOiNzoYFTquBFwoB5/e+8m9hxwg2CYWj+yFj7bXt5D7A7?=
 =?us-ascii?Q?wN0tW2FraSt4irx76tPfJA2p5T5bYyfknxRqPFV1HyNqOBTP4cz8muwV+6wg?=
 =?us-ascii?Q?t9C4EGa8brHfygmd6vQZCLb0c2T7GF7vX2gS+Qnni49pEI46L2GDliEOqykx?=
 =?us-ascii?Q?hMbB6+alH5v2/xUhO8Cchh/itWP/NdAtUe5GegNR+lW8kFWQz+xcKIAlTyvR?=
 =?us-ascii?Q?1xZyxVWrgafFgXegcWQfI/D3DEU/xbK/muXx0ttItm8M39yQ2K2wWnzhDzfL?=
 =?us-ascii?Q?JVnndas2+OW4wcVBR90eruyo4cPI/S7uU/tXDnb0JvwptkCSw2Wg1JLytahj?=
 =?us-ascii?Q?TegqFRtsz0FzSZWoOX0r0K/pT1PLwxtCcX2sGy9jOUYWFVhYMVwhRmDwjp55?=
 =?us-ascii?Q?L8uqrv4gAkXMydmZ9bqInVRnXbKRmV/ZrFRvV0lIojUS7Gm4x8jUVbM/LvMw?=
 =?us-ascii?Q?paTb5dLRqIp0YDV/fJvYR9VJ4ezv6/f6BEMktPK2vYa4hY8xjdWEDR3Ou0F1?=
 =?us-ascii?Q?GVDziddjVvCClfHgW3Xe+UAkroWoFdqGzqtHl4yQaPCuToz8V9udiPdxkF0Y?=
 =?us-ascii?Q?GQJahfydCN5XyoQo2CAcfw3p+6QHVNEDoNg3C07V88nbgR3jIwtTp9Qu8Sjb?=
 =?us-ascii?Q?nNnyyX6wz8G9K/Hjoil7tNU9V3Nzydof3d4ah4Zu1uGiqPRAkS5wdlkPEJm8?=
 =?us-ascii?Q?iKOMIt3stpKVrLlHSkWIzxUVO9UVEKuLNx0paKcWZ8qRNCsl981Tk+vhsbmX?=
 =?us-ascii?Q?8Fpf7ee26QT/3w+gOucWlzukeHIFc/6wB18agyaTSMUwTBNii6rUrhMDrRAz?=
 =?us-ascii?Q?Rf5Xr7jyAgs9GKACJNbzQfhN33h/oa6FC4icxLY19z2P4gZ5oTyX+Ryt7dGw?=
 =?us-ascii?Q?1eIan3oNQViIzh8baqn56eSWy29FqJ93CMF1nfCQOo4G1+HfwGiCh+k5Hpr7?=
 =?us-ascii?Q?abN3vi5yIxcLaR9PGdt7mZfxHhHBCDM/H1DvHaozoJ9o6SY9foX/nPbN/tfq?=
 =?us-ascii?Q?BQixqvKmxnfsxD9XEYNHaOClZ2gO2o4Ob1m1wSBfeFEMhOM8OguP9SGFyF+6?=
 =?us-ascii?Q?J/Zhlez5ZMuYdqws86EyBMHMGHXgnPP5u5e6GPDX4sqC4FOONcDnEcZ6vkdN?=
 =?us-ascii?Q?jsrvcx7QRpoBKJlslyME+38fgQgJMB5cqeo1WlFJtDpNb6hoMhbRse0TkPfb?=
 =?us-ascii?Q?+QiTWEE7faHHn22X9WAY39qFqNmNxrxy7scUzoSTxQzDkHhrdSs21guCHA+F?=
 =?us-ascii?Q?kVyALFYcebGKjzu8/JTlzQD3Q1iLSnIahDSq0THRkobcPBmkG38fK/6o/Zxz?=
 =?us-ascii?Q?M1v6V82jPubxxnGaVVgWYl4pNIHwEfgspMUHDJ2HhMivPzhms1p1tqNAZjjC?=
 =?us-ascii?Q?4Uv/SqfJAwZWcVY9NL7xULjcpzP26iaq8PBt3YAUSOwGvwc3yZX4cEsj08qJ?=
 =?us-ascii?Q?Yw7Zwa2DGgZIsJzK80NzGF1j7OFWqWfEM6S4indvT4CvCE2IcOjnuhgkvX9h?=
 =?us-ascii?Q?WY+Q6rbvoeDwrFgTZSPKZNznHCLw1UYhF781RPvSX0bIhlG4pnfKZpDR3Ter?=
 =?us-ascii?Q?/3lZiWD7NsF418zY+GMr6O82w7tTctbivo1rpWGM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9476414-04f9-435c-c545-08dd62dd86d8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:49:34.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEApD1yTq0GFERuBQM5WaaaJf5uqVI5zVRSuUXJnilg42jk0LuQk6P9AVBE6usknxQBGVLI78HSFZ0O2huVPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

Add a selftest to validate the behavior of the built-in idle CPU
selection policy applied to a subset of allowed CPUs, using
scx_bpf_select_cpu_and().

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 91 +++++++++++++++++++
 .../selftests/sched_ext/allowed_cpus.c        | 57 ++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f4531327b8e76..e9d5bc575f806 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -173,6 +173,7 @@ auto-test-targets :=			\
 	maybe_null			\
 	minimal				\
 	numa				\
+	allowed_cpus			\
 	prog_run			\
 	reload_loop			\
 	select_cpu_dfl			\
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
new file mode 100644
index 0000000000000..0c9de334d4427
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates the behavior of scx_bpf_select_cpu_and() by
+ * selecting idle CPUs strictly within a subset of allowed CPUs.
+ *
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
+
+s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
+		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	const struct cpumask *allowed;
+	s32 cpu;
+
+	allowed = cast_mask(allowed_cpumask);
+	if (!allowed) {
+		scx_bpf_error("allowed domain not initialized");
+		return -EINVAL;
+	}
+
+	/*
+	 * Select an idle CPU strictly within the allowed domain.
+	 */
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
+	if (cpu >= 0) {
+		if (scx_bpf_test_and_clear_cpu_idle(cpu))
+			scx_bpf_error("CPU %d should be marked as busy", cpu);
+
+		if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
+		    !bpf_cpumask_test_cpu(cpu, allowed))
+			scx_bpf_error("CPU %d not in the allowed domain for %d (%s)",
+				      cpu, p->pid, p->comm);
+
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
+	}
+
+	return prev_cpu;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(allowed_cpus_init)
+{
+	struct bpf_cpumask *mask;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return -ENOMEM;
+
+	mask = bpf_kptr_xchg(&allowed_cpumask, mask);
+	if (mask)
+		bpf_cpumask_release(mask);
+
+	bpf_rcu_read_lock();
+
+	/*
+	 * Assign the first online CPU to the allowed domain.
+	 */
+	mask = allowed_cpumask;
+	if (mask) {
+		const struct cpumask *online = scx_bpf_get_online_cpumask();
+
+		bpf_cpumask_set_cpu(bpf_cpumask_first(online), mask);
+		scx_bpf_put_cpumask(online);
+	}
+
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(allowed_cpus_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops allowed_cpus_ops = {
+	.select_cpu		= (void *)allowed_cpus_select_cpu,
+	.init			= (void *)allowed_cpus_init,
+	.exit			= (void *)allowed_cpus_exit,
+	.name			= "allowed_cpus",
+};
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
new file mode 100644
index 0000000000000..a001a3a0e9f1f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "allowed_cpus.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct allowed_cpus *skel;
+
+	skel = allowed_cpus__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(allowed_cpus__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct allowed_cpus *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	/* Just sleeping is fine, plenty of scheduling events happening */
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct allowed_cpus *skel = ctx;
+
+	allowed_cpus__destroy(skel);
+}
+
+struct scx_test allowed_cpus = {
+	.name = "allowed_cpus",
+	.description = "Verify scx_bpf_select_cpu_and()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&allowed_cpus)
-- 
2.48.1


