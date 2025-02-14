Return-Path: <bpf+bounces-51488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1C2A35305
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC28163B0E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80382523A;
	Fri, 14 Feb 2025 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F9Ht9mpk"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2017.outbound.protection.outlook.com [40.92.57.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9617E;
	Fri, 14 Feb 2025 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493479; cv=fail; b=cWxFaScwQK4Friwvp8RJEr3VC4rqWg5DPLBqitLceUJnANsscjBbDLkNtQJgt7vqlC4tlWko13BJIrPY9UkLITGHxV5N3pdLSWGIMnaea3aJXRd6FlgFWDL+6qpQJjnkRWrqxsrENglWhywz4xDfUKgVvkTps3CBcPZrpTtCosI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493479; c=relaxed/simple;
	bh=RzKnncb6qyeRbd/9x9Sv1jkkrveDQQJuzeVSJOcRla0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=frE4V9fRJamKMzHOy1z6lk3RsA2SHuiGNUDOMXuz/j1iMqJg3uC02lOZiFIUMA+nc+44X5iJ8p6/CTRYvf4G8knvklKrkqq0HvQPbzNIQmMJS2n8tfhQbhjEMVk96u4kKZUwLfH8GDb1rJQf6I5a5VCLm3pnprVhBriPoi+KNYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F9Ht9mpk; arc=fail smtp.client-ip=40.92.57.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM6jYcH21LvaxQFREvldIrQ8fCjyvAuOsrnyKeY0O9tEI9JENNsHAQQ/aNWSc6rf7h+APONEZrjQbo3kjPubDFtDoxmrWvH/PdItbxVzwlx/qi6cEal8NQ6rxdVwYBhrlPXi3MuMs7E3A1fJpOUOYRZqT56Cf9evvmIRtVihOBDrmtS9E0g1JY6Z9/3L37QniarjW6HZqj10xYrzPe3IjZMixqQrq1I5ceu0vojx2DXwZVOHilJXzL51axnwCzSYBOxp3vXoFwVuFaYMizcKJew8+2+mL1P0H3yY8ch/rvllOqBDlcshebw6dj/ZaqjlReJw1XJ3XgAbg6AoAesfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z+4j8OG9PFvEE0Ic8rWsgK5OpC2y2TVRkA2w88Csqw=;
 b=CNuAtTH1bhk0U0q8w3d49uuMGEKO2EcBPcfsNqtQCazhRaawJhGGRSXe72GAk7YoIwuivkiR/zEIkrq8QVFlVKTt5NzsychF5l/SeTu+6lLIl/9m0jd2Ab6O1BIBvCEjqEYPSHBa3rsIDod18jc4juovAdH7Z6ski9CmxbH/5ej/zJIPz7atRtZbgzC/TzW54RY+09TONqMZiiz/F5NHMLtR4JfPDR3seAXpxWM49VeQWpY6iezvwMkK3yHUIh3TU4auGMytuJp3AyakqUIM55NmPV9rYZkGvUtsYzhHSH/96telJaeiFI2Hl965bhN26ETtEaOLso5V0TZl/llHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z+4j8OG9PFvEE0Ic8rWsgK5OpC2y2TVRkA2w88Csqw=;
 b=F9Ht9mpks9v4pGhhaKDwLLsucECx0+5iYKlJU5zQm9nZeoC86LCoWQU4bOopLRuE5Z6YLLlvyEL1C6snSNyqWNdbIg9MYjsUEA+3i/rvzmvKCmPWGlicbI3HRO5hhiH7rBl37I8UfJHxLvc3M7rfiooHtK6bor0RWGZFbirebeoEmyHEMRuw12rA2wM1Hj7FF+qRKLjharGYFKIlg9Yj8T0kEYa2LFFjdWnnF3bQ5Ra33H1mKxEh/wuRGxO+mCLI4A8qnpiYBN08rut8n+v3p1COQ3oEWX1ICi0Dgz3nSXWrBYKWyt28wXbHe8VN5vm7IXNUad3NBrS3PSwRqf/PDQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB8869.eurprd03.prod.outlook.com (2603:10a6:10:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 00:37:54 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:37:54 +0000
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
Subject: [RFC PATCH bpf-next 5/6] bpf: Make BPF JIT support installation of bpf runtime hooks
Date: Fri, 14 Feb 2025 00:26:56 +0000
Message-ID:
 <AM6PR03MB5080E1C3EEE022BC61FAF3DA99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214002657.68279-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f4c91d-9958-4b8a-fd75-08dd4c8fd1b2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|41001999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DRW3hNX1VnJOLP+XgRyD/gyw29eQzoXgqhgnc7Bmozkxt5IT9qhdOahz6y41?=
 =?us-ascii?Q?XzyewsjoJNxg6GDCpDWsmOjVmWrP62X8fVLVgYB5dhPC6gJJcBBFDR+PiFKt?=
 =?us-ascii?Q?PWTEUnUJaXTkvrLxaV7punElkDA7FLvenMhbVzxSRzUQhDEwJU90Al5XnFZm?=
 =?us-ascii?Q?WcKXP7Cu3J4LPonp0cbZTxGgh3MCPYcnRKkoRiK3veMx9x8aWji5veWBJMon?=
 =?us-ascii?Q?eWrxlv87FjF7bj3b+8FTmITZsMOaraMBgc/n6KiBvS67iNqBhdAXZ2eHRy9i?=
 =?us-ascii?Q?pZ/qOhv5ZH3x3yTTK8FQAHBb/wh+LwCrGDHxAaDsY4oZVNmmSVcr0eWNQhfr?=
 =?us-ascii?Q?c68evbc7QWqnc8FmyiuDMvUBiWR0q3xlL59UJWI/yH+2fnHveyVyvjGZWt6B?=
 =?us-ascii?Q?yidpKDRqAcF8+twAwPxigg+o+V5XPc6c2KW6TyliiPmssA8dLjDAk+hIFRdn?=
 =?us-ascii?Q?o+Ddn5O0cZ8a+3oerxWcJnCHBeyN1PQ/tMy/nkvycHosmxqhO3rvfvQc3LIB?=
 =?us-ascii?Q?NxBerpWBUo5ioIrxx8zSQG6b2shtXQO5/yL7/1Ckhw1LlQ9RkZJuCqSZEigA?=
 =?us-ascii?Q?+Q9XLZYC1VKjTvjcT8gpfqdS+pDbePNZIWUuU319T/zGTWLSMH/C010Ghv+T?=
 =?us-ascii?Q?fI0YJLoiAmFT45fLfc+u/NnxXUwVpgGziJlshX6Tiu6+nQybRMmh/EIpl8PS?=
 =?us-ascii?Q?QBbhXtUynvI5CE8BpnDtw/Tk0FxfzF0BnpkRNEAhe7mMEmwChjbTB8Q4Opi4?=
 =?us-ascii?Q?VH70X5GIg3pStOMp/dz7dzwMYPVN01XuMLyQv01/iEz+jbBpaxzGg2ozEZnC?=
 =?us-ascii?Q?EjaNFIFC4jNLBBn1AwThdmpw3ESRX8IBkbb2uAc3tTZ+iM9Nybm1IHtldFaa?=
 =?us-ascii?Q?5nd/zxrS9wI94CSE89fPxJF21nlBFhqaPOgVPZ98nK61l5WO5OIKc++Fxvxg?=
 =?us-ascii?Q?fnI1CE3vP8lMD8+8s9HVoDcCyIo7d9rs21JGS2hRkLJJUmfnBGfSE5GBZdOM?=
 =?us-ascii?Q?Jvdc54ugKSJMHjsuEn+I2tEOk5gLCKZMAEQYOPk0/6/OY/g9x/mhBGNwG2e7?=
 =?us-ascii?Q?pZ3D6keG3Ij6q1OB/CF5l1Y0f4bL7w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZnAhxL2cE+ZydgYp4PME9/B+MA+PTZFfkAdqGyJY1ad7id1wTlWAx0QGVGNT?=
 =?us-ascii?Q?RYJS1q+SjgmmogB/VNIu+59movBR7+1mY6rVEfDyeqVTLTUTbOT+wUV39DQG?=
 =?us-ascii?Q?dKvpAQivIjiqdoLMYrHCmV6jE3rK6+tuhNRSUMCQ7wDjdMfb5FTu3VWy/cb6?=
 =?us-ascii?Q?aYVK0UBzBBu/jpBIrYUrk8xdQzQu6cFisLpUyU4Lpe/YFyN83hmr5h8Y/jaR?=
 =?us-ascii?Q?4WxDy/Z0NSQa8CF4hjdf4xJE/aB8tBKk4MNdYf1R8XabPgBvo2RkzhnVZLl0?=
 =?us-ascii?Q?fyK/TzrA0PE2t24yh0kvd4y6/o8zUOYlIMrLL0nts8LJfx5/tVAzndHOV7nV?=
 =?us-ascii?Q?C3BSNCh5jwHFasDxSuLuCLxLp6kBta4dNZtq/gCJWuBjb+jjVt3t/p6FYxUN?=
 =?us-ascii?Q?55qAovVHfjV12znMR2ycZPRJXlbs6u3d+oCW7VcAxlYk6W7+kL5RGB43xLbO?=
 =?us-ascii?Q?YhOb6RyWiDs8DH8TLE1qjYBWZsiOpApx2z8RUYOjWUjbmeQk6ESdNnLx3A6F?=
 =?us-ascii?Q?agy0301SCetbSWIoNQj1lvuIbs3zvcXHyVw1pYtj2W0BleTfD+TyVBKptjfN?=
 =?us-ascii?Q?bd9wcI45NAWxCiE9uGz51TLfGdcn/GQpZmIokE5miNh+s9xJa4OcscJBPVwM?=
 =?us-ascii?Q?lLS2yJIh3Q9ewalz0IIrMpOKlUpz70hs4bkLSc5M5gKxE+Aywvgz0L3jbl3L?=
 =?us-ascii?Q?Wly4XuuoyZi0pbrKAJb001B+uWZHrp6icRe0WjXWT8ydH4KllGrzbxHuA+dS?=
 =?us-ascii?Q?PhFDBKIZmdGv8nZEf51vJuhAQdVQaAXy6lkqaYjqHBCRsaKfNFeHahAq8jaf?=
 =?us-ascii?Q?qjS6v1GPzQj8fqq2hlUNyr3BUBTvuk35h6011QuoX0YGtqSA2GeS+FV0bEXS?=
 =?us-ascii?Q?VyqOqVxIvztdymCYzDbuPj4yZn7S0d7plZYjYZz7f5pij73Vj9dRycuSjkgG?=
 =?us-ascii?Q?DDHocuyY5FIvQMwWcNlEsIzNIlRzF/DFvbsCJbrAek4/j+AcxD+Rums05QfF?=
 =?us-ascii?Q?JOYGnoenQyRlz12NrhNZoTUvhdK+F6C/f+t74ncOY3CgzUyFC+JVztXoKISI?=
 =?us-ascii?Q?6Yv2AlQiwMlId6lvvwW1WFaujANQ4ar56jw/It1BGmFWCMmQ6kZU2XMYEpgQ?=
 =?us-ascii?Q?/4w6EOoJUjFYr9iznyinTR8x41jcnTLtTnPdvk1L60pfUNcrx8YzzB4MFqbq?=
 =?us-ascii?Q?A6NEvbEj/rclgWbJq0vk3mzYMVRdh/sJz2b2F9RRAmmmcgCdiyUM6xbAf1sq?=
 =?us-ascii?Q?gto7zU2Q98WoGzlKPpx5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f4c91d-9958-4b8a-fd75-08dd4c8fd1b2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:37:54.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8869

This patch makes BPF JIT support installation of bpf runtime hooks.

The principle of bpf runtime hook is simple, by replacing the memory
address of kfunc in the CALL instruction with the memory address of
the hook function, and inserting the memory address of kfunc as the
6th argument.

select_bpf_runtime_hook is used to select the runtime hook to be
installed, based on kfunc. If it is acquiring kfunc, install
bpf_runtime_acquire_hook, if it is releasing kfunc, install
bpf_runtime_release_hook. Maybe in the future we can use this
to install watchdog hooks.

In the hook function, we can read the arguments passed to the original
kfunc. Normally, we will call the original kfunc with the same arguments
in the hook function, and return the return value returned by the
original kfunc.

After the BPF JIT, the function calling convention of the bpf program
will be the same as the calling convention of the native architecture
(regardless of the architecture), so this approach will always work.

Since this is only for demonstration purposes, only support for the
x86_64 architecture is implemented.

This approach is easily portable to support other architectures,
the only thing we need to do is replace the call address and insert
a argument.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 arch/x86/net/bpf_jit_comp.c |  8 ++++++++
 include/linux/btf.h         |  1 +
 kernel/bpf/btf.c            | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a43fc5af973d..da579e835731 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2184,6 +2184,7 @@ st:			if (is_imm8(insn->off))
 			/* call */
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
+			void *runtime_hook;
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
@@ -2197,6 +2198,13 @@ st:			if (is_imm8(insn->off))
 				ip += 2;
 			}
 			ip += x86_call_depth_emit_accounting(&prog, func, ip);
+			runtime_hook = select_bpf_runtime_hook(func);
+			if (runtime_hook) {
+				emit_mov_imm64(&prog, X86_REG_R9, (long)func >> 32,
+					       (u32) (long)func);
+				ip += 6;
+				func = (u8 *)runtime_hook;
+			}
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
 			if (priv_frame_ptr)
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 39f12d101809..46681181e2bc 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -571,6 +571,7 @@ void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
 			       void *arg4, void *arg5, void *arg6);
 void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
 			      void *arg4, void *arg5, void *arg6);
+void *select_bpf_runtime_hook(void *kfunc);
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 93ca804d52e3..f99b9f746674 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9640,3 +9640,42 @@ void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
 
 	print_bpf_active_refs();
 }
+
+void *select_bpf_runtime_hook(void *kfunc)
+{
+	struct btf_struct_kfunc *struct_kfunc, dummy_key;
+	struct btf_struct_kfunc_tab *tab;
+	struct btf *btf;
+
+	btf = bpf_get_btf_vmlinux();
+	dummy_key.kfunc_addr = (unsigned long)kfunc;
+
+	tab = btf->acquire_kfunc_tab;
+	if (tab) {
+		struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt,
+				       sizeof(struct btf_struct_kfunc),
+				       btf_kfunc_addr_cmp_func);
+		if (struct_kfunc)
+			return bpf_runtime_acquire_hook;
+	}
+
+	tab = btf->release_kfunc_tab;
+	if (tab) {
+		struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt,
+				       sizeof(struct btf_struct_kfunc),
+				       btf_kfunc_addr_cmp_func);
+		if (struct_kfunc)
+			return bpf_runtime_release_hook;
+	}
+
+	/*
+	 * For watchdog we may need
+	 *
+	 * tab = btf->may_run_repeatedly_long_time_kfunc_tab
+	 * struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt, sizeof(struct btf_struct_kfunc),
+	 *		       btf_kfunc_addr_cmp_func);
+	 * if (struct_kfunc)
+	 *	return bpf_runtime_watchdog_hook;
+	 */
+	return NULL;
+}
-- 
2.39.5


