Return-Path: <bpf+bounces-47138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE49F5749
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 20:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7411E18812DE
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8421F76DF;
	Tue, 17 Dec 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uz8JpVkf"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1C1F9426;
	Tue, 17 Dec 2024 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465503; cv=fail; b=TzReEBq/ncfKrasT2OkI0xMohObb8LH/32IbPzODJNioRSLlv5B9Ne2cYPZSTgz5Fa3LVlbhai6+xmrdRsXHc0yJzNplXGPsOuMU4yGxmcz6s3tgmyZuhYrS8g/vYtqeMX4gGXaklZyC93DIQuuQlJ63+NAr8Vt+U9W8Ktr5TXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465503; c=relaxed/simple;
	bh=0izDew6ti5tPIlQv4ts6nGWZbxOC4weqK46vYeDqkds=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t8tVUg0Em3eLrUUOx7aRmA9lnaNNLwuBg3OlXHdcchJZskzSEcCi1wCVOHJ86/h4zn3jyLPy6euFv/7rnj/m3RLOr8EG5PJst49prvkML2iwz8CyM+EphzWTKqdMT+R2b077opF2hsOpZMs9qM18fCLozYf4YfNhoUkLB9h4TIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uz8JpVkf; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM5rUXdz/7U0TmaNilaA6PQD+fnzoOCqHRJE/4BSpvLqlKy0yAdbAOCfHZ553IHyU7RSywOluuA2Ysm7MJgbB2wryErDO4As6phl/CJSQ7bWjNBOqBprGYpaA7J13xH76PJWAEcClww5u+SXPYhNN2KDZVuWY1CIpPW29vPX3rSiYg94Csq1P6itR2xKxCWCgK5azvQ+lS8e2vfVcVbFwfsteO+4/txPEoc1lDLMiNcOXoUF2huUG2pylp/niEcjtP9CutxRdoyPPLo0jfxfgI4BkOq0ZycgCXR0PA1UDOYm9h4EIVBV0QYiIABcy28RLIAXW1XzC9AFbKnje0zArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7RhkGY6zX7SLEDl24TSzNjhSHcBnCQMKtXciqnEEE0=;
 b=xoZ6l8NhfjDHA8/X95g1ac0Y/uKUtkWEf1vvBENL36PzJm9saJAz/ffU86v040ZMF/HJJHH0ccnO3EGdTgGVNrHlREaYal5l6JZZtxtTF3DLqKydVrfwduWjQAzlI2vu4a3hv+SzwHKunV7h5acYHGacBOUZyRBxzy6pSh/ljTOv0rmcBGwIrLkQFqF1RigNKcrITgnbXwckCvWhr88kOiDUdCrv86Wo0OnsXD9UyN4ybN53a+MwGct3auT6f7e/MgxHkDUGzXvB+sEbN/u7b5+eM9cKFRQg1X7W1b/zZf/3KKm48s3Mjy868porGC8/Dw+z0X2ZuuUnB9GoNTsbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7RhkGY6zX7SLEDl24TSzNjhSHcBnCQMKtXciqnEEE0=;
 b=Uz8JpVkfuy2JyIUNlPO8rEMnviTBUYKj9zyRtVH9hzJEatIb9Y3sJ6KIv5704eVF30/41KKJhv9xIOmAh5ZP63ZKBD3Gz6ugEvQ2sITTGjz78Stb0bL4z8TvBnmS2isnWWlqNygnT2IlZqO1Qqru6CiSz4SAFWeROpSKu9FGLztwe7pSh9YzKVykLQWdQdB0t5bybqIM644utEDSUjsWp4wIBmx4P33E75iT61P9P207pmPESAda6iQqBUBs/gmyY3FvlT2n0TI2lZmg1Pph2MRY32V324Vo4j1DKYd9EVQo+TBzaiUAO2hF4NrQc2BO2CvQXOqXMlVlKKeztPDrWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 19:58:18 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 19:58:17 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH v2] bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP
Date: Tue, 17 Dec 2024 20:58:13 +0100
Message-ID: <20241217195813.622568-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: a50a3303-efad-407d-c1ab-08dd1ed52659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gterSP/pE7n14Zz6QxCQaegfTMYB3Bq/4rpVQEQYZ/if21NFknbAYwsFEsMT?=
 =?us-ascii?Q?jg5D/zXC4g7e0IeRQsCYsnEGYlLXLdHr+lxZ1ixZiMaOFaOGfFCGztbUeReG?=
 =?us-ascii?Q?jPLvIuEvIiZ79cfgKjKH4PDlb+Hbze1nHl9iyjZDdjCbz5x2B11ZtubZ5C2j?=
 =?us-ascii?Q?XKay3yyqqyiumjcZ6bBRRGI80su9U+w27oVvy0SZX1SIcoyxlhME4ThDcUSV?=
 =?us-ascii?Q?+xQdsllYOPOuqcJqY0VnOVEuP0NjUncu8HGUJ0K7g+zcHlAWJQjreThYIEL4?=
 =?us-ascii?Q?nC+XYScEywQcda8a4GSPwBa9VpPvNbFk6DlPgu7qP9ER0kPlGyuNmZDquSkX?=
 =?us-ascii?Q?eRPBaEO8wN/I0ehfSIAVW3z1D3Fro/kadGtRFzb76osCb65EcNuJi5NAfiw7?=
 =?us-ascii?Q?6cARvhaepvP7woT1t6La018pgFtsFUpo5SSbXtJR49EftJ/gjyEB94gKGyQl?=
 =?us-ascii?Q?s8ndyitSZqiM60yF48ShEWBYGIO7pKrO5uEQr0NWxo0FM20NuuJcMe5KZs7O?=
 =?us-ascii?Q?o3hVyQl4/T3yjSSjTrFC+OYeGiaTq+gIVe088R4+oYsgsP0Qcx3/24dIOgBf?=
 =?us-ascii?Q?LkSGwGw0oMMfovJndZM5AgytRlMPwXhhMMCBW3i/ko4X0zfe/n6ThCCkk8KV?=
 =?us-ascii?Q?EQIFC6UI0/RCSbu5ixUFLkcnAh4rJbUh0Jz9jdizRGSuwf3+XvwguZjzuXM9?=
 =?us-ascii?Q?tUilzX58rDII+WwirepwLuAvJ/569FQqre4sTe9AbCWYm5/OszCV3idZN1Am?=
 =?us-ascii?Q?kBj/yhB+wmaja9ZCTfDhzD/3YldKGfcFpaB1iKrxJbguQ45AiAdTmjhqCU1u?=
 =?us-ascii?Q?9CoxNiFJCjdP+TQhbP+GLShzO4tk/sHcjVUpBdF3zw2TbuVDRPdTYSUmS4/Z?=
 =?us-ascii?Q?Ld7r/qEYqU0RcOnDJuYXk5MISB+TR4xXXAVafHuVD/X4iH3EOBH4iU+/YAht?=
 =?us-ascii?Q?m0qNcfCXf6tH4WUXwn2VRGQk0hqL1e/s+RuQnu/uLxV6rTOa/78NHowyvz1W?=
 =?us-ascii?Q?eyP1SnNk4bdhHSLxYavABujLNREGLD2V5m7r4WS9lnBsx2CkvJJJXqubQfrN?=
 =?us-ascii?Q?S5q030nYIjNycIYO4MEu0HYKMbDTaYGXUwPWYhXPoG+eoA6l8gEVR71me7fZ?=
 =?us-ascii?Q?JDbAl5oUs7jV6fJ7ZlH1em8c93OZID9SLkIWXO8GuXlmnFLq0xISuwzgEJVd?=
 =?us-ascii?Q?iEyQpocDz7iXZNi2AMeL+0kcKPczt2Q/xecd6x2hWRSQY/VgU+68ZzIWgfyk?=
 =?us-ascii?Q?h0IgWggzBoQFj0yc/L956W7YyW4zrqOBqgB/x46kVCcQ850WQ6/IE1jcfSI1?=
 =?us-ascii?Q?UcIfRcMyoGuHktsHxH13i4Tp08eA/Etbg29Jj0Rd3Z8DO4P/ZWblZW3AF3RT?=
 =?us-ascii?Q?AdOWRWRmz8AOc7hySjXhf22NpP7K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bhwcvCGFAtqvbQzolzEzW72jLcNZj+7S7CTra2BRws2C34/qR8sijM6c63W?=
 =?us-ascii?Q?pF1yfaffaA3HemGXeemW3iDI28swuwElg94vGf0Mpvtx//EBjYceEoUWNcLl?=
 =?us-ascii?Q?+sHJ96VD5a4BQPDcPYa+2ZLx0+vv7ZkAdaaTh3TSZW009i4pXN+Zr+uAQNb0?=
 =?us-ascii?Q?tREcspZaCiAKU5sTSCBDa36l4WZ2XCCCYLImxZMOsAl2lQN8W56pRkf/9PlD?=
 =?us-ascii?Q?oZmgrM7FwCggzZhET42QWCqQfqbctSLpg/RKLEDSsl+opRS6BLfBsDABmUOG?=
 =?us-ascii?Q?g8qp9TqwLlDNLmP8jV1H2pFVL6IIJM+1A8P3XNA335HEIzxAKLnl6dDlDqfB?=
 =?us-ascii?Q?uPLhrZnQL5LsSe9IxM4uhCtIvX3lr4GOWwkB51J0tIccbMvMBReu+YGEPCJ6?=
 =?us-ascii?Q?T9ViLb/2/5b39A09j/cUmpxNmzVmCrJLweZ1UcvDR8Yrq2jzA0OZ3lUQYGZB?=
 =?us-ascii?Q?+6Rc4rgRUKKaQuKUNXkPrQDPFUDfkiCj6MiWbBREHxbu4VHqgw7lfgfUdy4F?=
 =?us-ascii?Q?YwC7xIZvnoI+FRPyXZJuBieJbARDwOsvVj3tpSe8sBl5M8E3BMBiwtHedd4r?=
 =?us-ascii?Q?3zuEijuiXhCL7NaJPZg6uGFhC3dW29pjVsFuw4VayosS/5tj4Gz9fZEa2N0+?=
 =?us-ascii?Q?g7b0Z79S5k0iar/rieWQXx6hwKr7PUGxIV/VaioNktYMRauTjh5hXFSF/08l?=
 =?us-ascii?Q?kU6c2+2UaPik9fkxj3kzD0MhqXu63Na/Sl0Do4Le5a5soKKwVCaWFRlbSTnY?=
 =?us-ascii?Q?yTaLJBmtVye6wQyLb2KR87uKsMvsFjZcuZk6WrL3CgT0jeHWDFlfhlm+LpGx?=
 =?us-ascii?Q?/NOLHDdF2Nw97PRBoG0R9dRBcgMnlc01Us3A+aRS8yEtcGBkFQc3Ugvs5aqG?=
 =?us-ascii?Q?7OD9k/0uLL1QKHXUyH2wTo1YDaq9MvezNmpUCXQwt8VbvL9Q7827f64SoUml?=
 =?us-ascii?Q?SiX6rZ0S1Wd5/wvGXB01B/bJkRaDGNPqvoWESxlsS1CRcmFf8MpHRB9KmVeu?=
 =?us-ascii?Q?4FlA5mDVqtRcCCRQp9Ocwt0TcTDyHp8ci8y1WPon9tGwGez+lU2SUhrg68QG?=
 =?us-ascii?Q?vHUhugNxp6LxTmkaIJXRHDv3eEE+EzUgDox5VRYlyeCglg1+F5Iyd4MAncYW?=
 =?us-ascii?Q?fGj1/3UpBD4R47r7iSeDCbhPkkQVg/2jqYyODoNJD4XoClBXoMJ2x0UkNBM3?=
 =?us-ascii?Q?6IOGRvmI6Rz6Viylbbwa4NwqqE99pKaNCabIO0yreaMTF5MiAUlsA2jL/dYV?=
 =?us-ascii?Q?m2Tr7kqrQKFLcwXRM33dBMaxgRNfPLId9gboAhxBQbdBC8I4p8zgZNmacxur?=
 =?us-ascii?Q?B5giS72yNsDmzeI9fWQG0bOzMa3eIB2AUJv0t5vSKwwfeaL6oPtB2tIKg/th?=
 =?us-ascii?Q?UMpPOBVwJucDyE15NhjnZ1K9KrmAw1hGjT52cKTs67e62cwPRQOdxE3kbMaK?=
 =?us-ascii?Q?NSzw4KIutT4oeZkHIWX3hpeU13e51+whRnWzVJYdImOtQ6JO2U3iWJZU/gaa?=
 =?us-ascii?Q?fAg+TioBVGc7A6HKM2QzvE/mWdlprz8sV+nuqn9GfLstg3GtBKKjZM6PoB1i?=
 =?us-ascii?Q?GnN+ZZtPluUcDRZzzAErz3LYyh5qIIqBd1mufh2I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50a3303-efad-407d-c1ab-08dd1ed52659
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 19:58:17.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YXu9f3PDSgiwKU51X9G45PJDW21CpsPG9zrGsR/U4e5ittwL/QyEe4xevkt91AMZZK+bet8cXhpdB8Yq9erzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

On x86-64 calling bpf_get_smp_processor_id() in a kernel with CONFIG_SMP
disabled can trigger the following bug, as pcpu_hot is unavailable:

 [    8.471774] BUG: unable to handle page fault for address: 00000000936a290c
 [    8.471849] #PF: supervisor read access in kernel mode
 [    8.471881] #PF: error_code(0x0000) - not-present page

Fix by inlining a return 0 in the !CONFIG_SMP case.

Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

ChangeLog v1 -> v2:
 - generate the proper inline code for the !CONFIG_SMP case (this time
   tested with the right .config)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f7f892a52a37..77f56674aaa9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21281,11 +21281,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 * changed in some incompatible and hard to support
 			 * way, it's fine to back out this inlining logic
 			 */
+#ifdef CONFIG_SMP
 			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
-
+#else
+			insn_buf[0] = BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0);
+			cnt = 1;
+#endif
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
-- 
2.47.1


