Return-Path: <bpf+bounces-47033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17029F2E79
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 11:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356ED1881C1F
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B9203D60;
	Mon, 16 Dec 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mi0LGrOd"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A191FFC62;
	Mon, 16 Dec 2024 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345983; cv=fail; b=SeuBbiHcPEhi71BDWpXkZAwBImoJTN2D0b0tGhwWkPwTndkHWThRNwg4/0GkgRU7OZtp+xs6KFDLXPiT1U1vJWbaD9NeHhNv4lNOSwB6Qx8MGAxmmt6Jb5fqwntW89dm3uv6VeALOsOX+mCvWw1mhP7yyP4za7bhPkLxcxPwsEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345983; c=relaxed/simple;
	bh=WHwKmKPWiIQxaevYdcUsrHCdP5+zMprLV70Ru5Q7ObI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D9qooJL2hstO1CpJUdAbe+JTxonGs5EPUPv5KLoQs3oeJ8+MV20W0OA/yc+939JFiJz6otHDBVhxpvG4/O3UhK7OBXk4gb//1Up7d83YjkMZA8nXpkD+Juo+Jk4eQEz2LAzPOuBB3ZNYLuW4dprIT9NpMQX8gMSkoFZGyHOHojg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mi0LGrOd; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geLSmN2xPbymeQp1tcyLlFUssEacekmUuql/g5UYFWbGgfRgPlHNWhPkgvRk/R8r4aiSk9NLvWgK7IYy+A8AEiMGLVLH9H0DaaujHsjzVt3pQ1Ex/5N65IidKbyqaANcz3nNAYswP9p8TQo3tvu/50OhwP3/yKx8xkh8i5XYeHjKsTTAw9wCwWkBcRKKZ+hr56i3/g85zFwSC8eg2ivrBRba9Q5+m4CPH4pf3qIt/VazEL95wf0s1i1VPlNHosvAnbXtkWsCmptFU26zi+37Xb7use6Cxr9K5RBXh18RSxNQFxZNIPOkcgBJiiGS1P7h8QUQzkP+UPzb/W1a5R179Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWCSlO2AHYSlvXYTLF0G0Nn5XdQWlIcD13pZjkw42Ss=;
 b=Yf31k+UX9yyw7H2X+q27UU1dvzfxq8EACxLesCGbS6o0RRmfsxdb0EYiGk8/l/r6+lHUDg6qNwpN5+5tP50gDBTJ/7i7RSaazC2f+3GQBrrBla5j7EzS2feprlkO3r0odlYLPsDOw3WUFO6xNptwkkkXMbsL4GIthS5F0NuLU4hoQtMafGrSIm0X2ktMdpnj4k9YqZRHqR3VH2nGYXwyyhypDifKp1lUfwonfKfLWm9KC36apnfQWs/+h9bydWp/7xNbRN5LTziUwY9wgjD4wJM/k2kBYDAM+AJD81Ug6ZpPqu3hqI0Vz0R8xLC/lJt7nuA6tHQaiD8uKr9jI03Ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWCSlO2AHYSlvXYTLF0G0Nn5XdQWlIcD13pZjkw42Ss=;
 b=Mi0LGrOdxeXU3p2ZIV2HFaW09AnSZjnj0dzJj/EPGb4NRugZ75PwxWKBJ9hZHmmPTFoWdD3UuLp51iS6XdqMZvNQp5nsYPJrw6eeoU8MwI1W6KAygRyPWBD8fV5WkNZgunNCc8mxn+qqdTvCHi7XtUEnkrKY79zC8SXuCEdhIOMu7K7m0sbS6MxrlwUiu6WrzJMeyEQankeoeZo3fKcXF2DQV8cTskA7GakjiivkS5ZC+/rYOKzWrPLIGKHOlPODJeGAxMEDN3i/wr45MSqGfaVhp4iPMtJGDbJ1UniRxCbhQJoxSczTD6jV6mBf4UnLjiYvt0+uI7ZYayYCOtp1Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 10:46:19 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 10:46:19 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: do not inline bpf_get_smp_processor_id() with CONFIG_SMP disabled
Date: Mon, 16 Dec 2024 11:46:15 +0100
Message-ID: <20241216104615.503706-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 23aa97c6-1d65-4b0b-95fe-08dd1dbedfb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?137FLbWo+NQHpxRZjifEslzFKwEGT5qabmVo0wsDYCfI9qzOySZcsR8rLRwu?=
 =?us-ascii?Q?ACWpUXKBAPh3AOQ9cFx1m2ld6+YSDjZvJ6SDzBmoHCTghkY/0lPgXxvbkb3F?=
 =?us-ascii?Q?pNGeBW7vu0mZaAvP8DukrHBITR0edOkEnvO+5ahbupK56iMgJomE6p1cUgTw?=
 =?us-ascii?Q?gmJ3wkblh2iTXo3QppoMf+0MBPoYLPEYkLvRacQ8O/yJXhSY9wVSwCpWDvQD?=
 =?us-ascii?Q?T0JSYD98vYlBPf+xE73tAlSmA8/agGnfJjMhrVZf7i4Ja3e1b7BHJQSrTCtf?=
 =?us-ascii?Q?X0HPowS1cML7trRu55VpMlklzN1U0IeuTETMBg/RRu3lfuOfAui1YwR1ZXBm?=
 =?us-ascii?Q?BUoXTgfXxRNZe2qRMYhj2p+4s5aslpNvXlEmFudmrcFs7p0l+uJ7d2HLKoZ0?=
 =?us-ascii?Q?Q/rI+LIQEHjz6mpAX8dVt7o20CQ7J2ddKs9TTyVI5YKgzEJFi9NjWosIiJtm?=
 =?us-ascii?Q?nS+ASGR6vM6axE2gweS+Yll9XJGaqTU6X9pWQAvsTiWDG/+InxyWsDGoCnLW?=
 =?us-ascii?Q?cETnE4nbg1PKZqtwPbvbdpPvwFqHMvkBVmMn9zOjjdEP0xogYS06oh8LGVxs?=
 =?us-ascii?Q?7MYqNkaFJtnZegP2wa0M158iWyBoF28IC3ahni2LOsKhjZnQlsQVY+urPqHS?=
 =?us-ascii?Q?PqcX25EGVCgBz2LzKLa8ABpyd3G+PdA7k3ck1qKDVfwT2dhaGdpV958FDbnM?=
 =?us-ascii?Q?KU0yLVRQfcQ03JBsAQJ3uRgj03x/AUdBbyXZk3FeMjW+6cgD3rhvOgCrNUfN?=
 =?us-ascii?Q?w0TnmxxDZrYuHTqezkqgQ629r0OwL23MkTBIf04tsxvmXmTQ/+xch59MZyIe?=
 =?us-ascii?Q?agnmKelKsBm3o2UuHm2MMnZTxbMThAdfXkAgyjuO0c3UveInyPilIJwaq+J3?=
 =?us-ascii?Q?m5gB98SbQ/y6MjTStDfH4nE5KfRXNa7dQWWenhae+mZb5S4q+s5lQmhf0ZUi?=
 =?us-ascii?Q?+NZk087i+f5Oi2c0oFn7AZ8UA1ENyMqqqvOEzqOjAPkpE3TEwJDbji/j14WQ?=
 =?us-ascii?Q?fc5ZCEMq37on3aVpaXyu1V8gfjiXIlt90YH2cT2yiz5bteZtI2dwVS77Y/jP?=
 =?us-ascii?Q?m5+tcTQIfcpSISURGaMmbe/KlTs2xcdhrLGjIVNHF/+vU7llrG4MpJnX6syh?=
 =?us-ascii?Q?kWJSushaEJW4dBHiNELRr40FIvChX+u2hugOZR9j/8UD8Y9o1RuKa5QGze2v?=
 =?us-ascii?Q?ZMwoV0Mz28sAQ19lM+JY3UXJkDA0zN4yAqFJSTk90SLgIEqP1t57vys2350N?=
 =?us-ascii?Q?ovpyshePL1j2Xm+6NNxVKzbacXY8pSb+hr3hbmr+ZYBCKDVBYmT6OX3FBIJ1?=
 =?us-ascii?Q?JboN2HaLi5ap56wVZ2JH7qtFdIvxIIyWrGcgE8kGRsCSNGulE6TxBNAGv7nV?=
 =?us-ascii?Q?d6i9HqxpU7l4zQqRgBHO1VBg5LCQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z5rFq+AiUrSrKhH+rH9TtPzq+Y1BoGRfhaBSUN1v48oN1g4DTIOxOglh7fMS?=
 =?us-ascii?Q?WmWfE/iVVBLZYKQb8jfjpjGQ2IUVduBpCMKMQ6f1WosN0kWXPTKs1m+QgnEa?=
 =?us-ascii?Q?Gg4Mmh4dHx445RGRokYOAPd8AwuaMF6k0TPhOBDCCbysvNnQ5n459H6Grtq+?=
 =?us-ascii?Q?P25svhmz5JvAoAM0VIk+lygkYtj4lEUk5j4Zw4yc8vNyQAFPMJAPDHdClVvq?=
 =?us-ascii?Q?/SSabe5uIL8sHS5UGxR9OdE3WcEnnx8RMVDA3ZsWD2sXYGs9aDbcn27537wj?=
 =?us-ascii?Q?OaChfJhQOXeMde63uaxLTjxdCBt6zIB/2ARgEC1u4cI+vz5janyc/0erL/Yb?=
 =?us-ascii?Q?e/y+WPi6ILwZVBMPw0MLWpTd/U6J5A7CoNQlGWRp5NNs7ZJ6u9P1CbIhthx1?=
 =?us-ascii?Q?CeM7ZyDQcbROat1TejoGSJ7V+PjQNZ0cRtsJRWEaIEaGiXNl5BU/1lSaDxHp?=
 =?us-ascii?Q?AltJxbn/wDPtLmdYRqbqTl3WTiYv028XRVZYWazxv/614RsiAptv4Eam6Waf?=
 =?us-ascii?Q?gWmUaCH9kWCtUdLmhKcTGYi8jz57MnRvHIcFzzxvzmBbsrwBksiSEkBLcMtb?=
 =?us-ascii?Q?dY1SCE504W2vGsKo4XAv12Etx6dqH7H7qUyQheV/4OoGxyKrGU0CmnO71pf/?=
 =?us-ascii?Q?QHCeeNBBZtVylx9dh2xpsAPVUf/7yzHQ/o+7hMwTpTF5XRMthunaYNInfyXu?=
 =?us-ascii?Q?DE/msxLCbAZaXdENejk0FvE7ubMEZxTNnAxVbXGG0ZmIkV1Pb+jyYLR49W+M?=
 =?us-ascii?Q?fvYWblhiLF5B5nGGMe+6FAcEJNywBao0E+yNBNkvNbF48ePFyfgRjbhmdyfQ?=
 =?us-ascii?Q?h3U7Xly3FbM2yUZ2gveGnOS7peRRY1v94VzAsZhTUcACEvh52WEAjqqyMsA6?=
 =?us-ascii?Q?2EiJE4TVxbU3WfcGY2ylxwz0zsW6ohkzL5j3Bp8XShvupZcsL4Y1h+Jc0ZsF?=
 =?us-ascii?Q?LwJ9yUoQSUhmoOsjMtToihKBCzWKKSxXRHyNRGTO51M7OTXc5Gy+BKOGueE2?=
 =?us-ascii?Q?6vdJGHZl3YDLRzYf2I5B9yYi5v9wC+hi5wa9fEXRKcw6c4Ujk/TCO2v1Sq9z?=
 =?us-ascii?Q?cciNI0/10cCctp/RWD7HBhHbW1bsSRVLUmUroFP/l9UC67PBBtTITBCGLt+5?=
 =?us-ascii?Q?fSj1n3uI0anIz6S8jhwr1crdiP6pTP7NryXygz86WBw0tsCIOrQVFLoB9rGZ?=
 =?us-ascii?Q?CYCR5O3ys18ZmkHZhvZ2odIeS9eBwBMWmTWE21fwIyHD9bC0RZ/jWiylMv/u?=
 =?us-ascii?Q?v+uj3oEForWz59oJ6Xb1P2kHr7+EcXRqdadYRrsoljiW/KKrk/AhIttUMiUL?=
 =?us-ascii?Q?3DfmNgrGUV9DLgtKqAhbvQ6NjD3Xb9UIAF3Mr/62pcYEtygI9M7Rj0fN+ZxK?=
 =?us-ascii?Q?+34kxIo0cMpOw5E1zEjuEQ08JxhapkIqoE5+uQnScxYjm2CtqnI6AsnG5Exh?=
 =?us-ascii?Q?khyycH/wGMIKCSpPCtmkY26EM+iWV2AqO57UybvlZmTSlvsdB2cHg0f/0DM7?=
 =?us-ascii?Q?hM1L7DaMNn0ZQOiY9OowaI8eyMgea/4q3MZ7MysJn+1ax14f4I2uRk+MMXvp?=
 =?us-ascii?Q?NRCAX92DeaEpPsihBwQWm2OSksucRyun5aFgi6dd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23aa97c6-1d65-4b0b-95fe-08dd1dbedfb4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 10:46:19.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNZS6MmlCgTFIlQ/GMw0l4kHFwIaXInhZONdQMkEf+xDFWAci0jgXdVpjPXuEk1mHM7tVPjvDFhQlR58TXIZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013

Calling bpf_get_smp_processor_id() in a kernel with CONFIG_SMP disabled
can trigger the following bug, as pcpu_hot is unavailable:

[    8.471774] BUG: unable to handle page fault for address: 00000000936a290c
[    8.471849] #PF: supervisor read access in kernel mode
[    8.471881] #PF: error_code(0x0000) - not-present page

Fix by preventing the inlining of bpf_get_smp_processor_id() when
CONFIG_SMP disabled.

Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f7f892a52a37..d85413f1a784 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21272,7 +21272,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
 		    verifier_inlines_helper_call(env, insn->imm)) {
-- 
2.47.1


