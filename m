Return-Path: <bpf+bounces-67272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAB5B41AA7
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BCC6813E1
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150BF2F744A;
	Wed,  3 Sep 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M6BxsnRp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C52F5319;
	Wed,  3 Sep 2025 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893078; cv=fail; b=J6oGf+nFdKD7NvFIomSDqjaIrgwaiv1vYJG1HTjgJMGI0WSF/X1m6OGJICw2TSW2UUH/lLl3EavHa6oMc5kU/aFdrMrQ2Fdf5m6P8t/6bW0oNqkzkZlyZCRDCBrB7wmqUq125k64h2y6lcIbQCxkoN7oxtcKjzBMLlFpZxYLsno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893078; c=relaxed/simple;
	bh=EdmvPLyUp3HQAJpB6q6IzWkRqrrJJSzj6oqnKhnievc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hSYDPR9NfRwP2snALl25YUgwhjRfjX+PaWFSZH80ecbrvYBOkKyRTjTJuGQaZnq1DSGrMcMQ7R/P7qxBD20Npba9nUUEFFRpGhTgpvWCeyWoJhRP8nQIpBPL7Uk0BmY53sLNCQf88UK1COzPIqckJzTPG50J4eW/3JQAIfC43Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M6BxsnRp; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqV6wPzxR4TtTc8YDcP8mZOgfwQJZRDVCvwMm5XPLSs5iu5SbOoqobxTlSGxW3LS6I+ljhJTuHt0HL57pkjoyGJ6ROOvWb41losiNQk+x/nwJtKNKkFIsX3MB32IgmJ2mztqbyrIUVwBjqrWJz5QBlDSjwg+6Xlggg7SRZrra9xEQPRAiotPfQF4oe5GKIWXu9FnjZEH5sqaxnxw8veR0x5yqJPnj5lklUsQZG7BtmZN95Bd7byCbI7o4sAbvyMjXZkhLBVloQAGCaU44HJR3FmR67zoFQFGBRjFRkQ4rE7Bchn1abp7oKcg0westdEGRPZ/u/TfG/z5quZnd5YRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQCp0EB+oytBSpj7f3GR/a53ZmLtfBUE+ILZtvYMRjU=;
 b=B3mkZElh6MGuA+aj5epXy13cFhKjdtQRDX+Ui87g3ovN385fuIqivmCvsUrlPbG1Djtpx4P8O1QznbpspsaYdsN0xavkCRW/LPXyTVgOzZNDmn+25vBjeBN+DIqZfl06tUc3jcXD7dQ/HggssfeDmo2Bn7UZ42J4AIzL2GRwRoP29euVi71NO/02P25y85rw6OoistXpQAldmzfwStydw+V+sBFuDlcQ0IhIKun8y82TxgBQB1JKKtyzF+FImHk86Ku06xE3fXRfw0ODm/srCeDD2usto0me5AFDiXWVVcx9Cjjl1PQK+wweeOc6s4Q3k/9x5T9lsok3AjrNSyf2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQCp0EB+oytBSpj7f3GR/a53ZmLtfBUE+ILZtvYMRjU=;
 b=M6BxsnRp3nYKeosXvwsM2jkTRL1q+AXzPesm80Ko+0Ldue0khnWJUmg9WfDG6RFi2PgAfSS0TDTvx0LkTaFsCGsjTt8d7NBIRmtbBouYdJX2LN/hAwYzS26IC+U1DI3YhECwakQdfDxdeNELIIwKx7VTrpnfZZyAGvFSqwsRKv4tB/QPdET/NfOdEAIY2+u+3/qgg9TV3HGHnikaCkRGKNQAsStqm0OYtv2DfpBewHK765dfiSYXGpG4mQOfxwkyYLcsrjSGYWGNPZfGvph3i0s1bVR07KrQHPK7nvJEWTiZYGGZF80W/zPWP9cJUIvPUzpc8FHHFpuuKEHiCiig6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:51:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:51:13 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] selftests/sched_ext: Add test for sched_ext dl_server
Date: Wed,  3 Sep 2025 11:33:41 +0200
Message-ID: <20250903095008.162049-16-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e5ce56-d756-44a2-741a-08ddeacf6ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h52WZMqIwMcX8QvZlbLuvCpAerrFCyZJbuD7Dn2F+ykYtFEM04AFOq65AIKq?=
 =?us-ascii?Q?XCNNpfdRB6/9WMyHUFEkWTn/OWUPZyao1dHzUg79IUy54/2MuYTscQ6Ay2pC?=
 =?us-ascii?Q?hPU8KpjJAhFe0vgJ6/ZIpT6JQom4+AaDQt+AJzB4DJDsjNLxkqSPgENv/xAj?=
 =?us-ascii?Q?PNJCr3N4HBaMYVJ5IUbBqvAMAX4SLYavKFBxwep7gqqVMAkbuCeYrGeXjW0v?=
 =?us-ascii?Q?rud8AtUN9nJLQaFPsXaccW0e7akFV7imsjkGueMmj66Xs7KWkrBk+ZuryR9b?=
 =?us-ascii?Q?MLpckFWhWk6iDWiIQhBgKSx7YhdAepcUiXbv827r8GX/Wt3i0xtghfTRu6AT?=
 =?us-ascii?Q?JC2u7F+PvqtRmUpJZe5UBPJfsyibYBlqsPs+Ai1gKXdrBEMjxOP6TWIYZiT2?=
 =?us-ascii?Q?4QdIAJ2b7tIY+6G5ruECsnupWKsF4AyeliUCKXNdEzJ+gPnmbD2JN/aYg/SE?=
 =?us-ascii?Q?H2wnZdwfcAWh/wtzBoKPyFiG+GFunkmpiPzXVPlMqeZaOfSWaiZkIsmeC5vF?=
 =?us-ascii?Q?eeIUl5benUv5Dd741Yok6vMNsE/Q1vQ25/GHdinpnFhxk46x6XijB47PPwfv?=
 =?us-ascii?Q?McxIwc60J/5YLzjw1HsrkbLAvyFdGMffECRTY1z3kejx9yGl+6QVAGUUScoz?=
 =?us-ascii?Q?EChmpgQXN7PuWyYvgMSaZAF/WUvzCCK5hYyKEhhmeoM/J+P6Y9V4VTgwzAcA?=
 =?us-ascii?Q?iBip2O5+R7G7lg5TFfdLmJuLIcwpvDVrd+AJwMTbcpI21MITfgd0shsugsVP?=
 =?us-ascii?Q?NQPbrxDHgTsWCVo8w8kl7f6RbkpP+bBeW+PtJnreiOmiQpRp+5QQI5TF9cNm?=
 =?us-ascii?Q?WKRiphqU4byYm0+cd4xK07eHR4iW97+w8nvRlnW2vE+RgLdL3MJrT0ompYWL?=
 =?us-ascii?Q?hh+x5HNJ3mEvNmImWxGVpOlv0tZIpgCtVCaRCZLmPm8/8QOLo/iNUSBZDsLv?=
 =?us-ascii?Q?xmLaR+UHcP4R+3Tb3yfiZXOfgblpgTYzDy+l5l99oEluFcH1Bm9oRSLHR9Uc?=
 =?us-ascii?Q?/5G03Lcm/VuN7w6BzGGHs7wJaLRrn56+iln1a8feB3sPWpiG1F4Tz6R6cVNb?=
 =?us-ascii?Q?59jXRBhJL0JKU7pYiSpx/nEYwbu0e0Q6gVCJaNY3GWjcL4EphSBGASMfPkx1?=
 =?us-ascii?Q?N95n2Xir/zVNsILWpoES0NdKWEDjaA4nrU2Dv+rO566FCLggoEQweLAoAMmk?=
 =?us-ascii?Q?rNMVAxPNOR3OPeS2mAMMiQME11RY1UsB06Tn5OVcLBxgbjeadKSPeewO4TLC?=
 =?us-ascii?Q?BJBUO4t8xL024mQ66HWa0L8AvgmcWwqFczD+xYv5mZNUES1fXE6sqsWzkGiL?=
 =?us-ascii?Q?WM6eKHCQ+ks5yP21GGoT4J1MWJ0Hkej4sSK7hZKCILBGra37q2BdRAOEDV+C?=
 =?us-ascii?Q?O1vla7luxzYjABuvuJDXQGAv4F1ECXAkLbMMY6kb89qzW980KASMhyoepYTM?=
 =?us-ascii?Q?9DLiv0jRINUC4g/i/9OG3t+w6p7qFqrzC49JTgD2l3kboc+vor54wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WUYLu1Tuex0KdzlZK0BQttZC4xm3Et/skJ5Kmo6JgEjWMh+rJ5A8kkQKzB5a?=
 =?us-ascii?Q?90ghrcPj1rMIoXqUCiFKwwZo8zXV1KC2SS74YT6nqUyQHMnPGpVFjFxbdfZm?=
 =?us-ascii?Q?4pZEUU48P/B6vP4IYOnHxS93qKPcMP9WTgiTs/TLselVtFZl665k8+sX8SYd?=
 =?us-ascii?Q?PI/8X6asqk6sUzV+wi6gZLSWKjWu2pfyroVekinXhEcX+DA3dHi0i6wpgFAv?=
 =?us-ascii?Q?FkSVWpTzMtC/d0gc2Z1FNvvRp6hCzGW/aZ80TO+I2qDQJN467PfUM1M/Rs6a?=
 =?us-ascii?Q?oF/7Fsm4SB54ia5KV2AO+yz88eJ1T9fftTOeKSAsFDmL+bUkPZlOfmYv1IUK?=
 =?us-ascii?Q?kKG70T0aLpaEVy2QWqX9qlAaItHLD8AtybwyG+OULBFhl3sdL4c1UjK1RXFL?=
 =?us-ascii?Q?O4Gf5nY/TQCY+Wr9lYmM/aPJr9wRnicfP9Y08PM55YFUmXrEueDuJuw4t0W5?=
 =?us-ascii?Q?U76Tz1SvNiRjvYvRhFjWiTf7sowMM9bHYyniDyLWvrDSU1SIh550Vd18a/Kg?=
 =?us-ascii?Q?9tYOwBjbWXiqMU2UHxE1BCTxb4gIxENtsM6kDVAHtzYjNAGKtfzjO4vrH64g?=
 =?us-ascii?Q?yAyQ/ccdj8DjLT7S+CCtJ/PIv4YAZl9MlR8tBTtVxLRj2KE6YMIATQt6mNrs?=
 =?us-ascii?Q?6FdFYj9xCZeisOxWKv2FT50AuwMyCXdiaIu8zE8/lvEm7ix6OfVwI7WKxx9c?=
 =?us-ascii?Q?4oxEcZppslKOOir11FvjdSuj0DQ6Ctfh51FlDKZVgsc8/63pyNOZ1wLmRnNU?=
 =?us-ascii?Q?OVvjkM60929lyLAXLcrphg38Z6xL+4Kb2jBCYa3bEn2hbGTafpOBOGkf8e1q?=
 =?us-ascii?Q?Cy/3VZMxHrQAT3ceInREoNoqOyUrZ+8SXuXmhH7fX6tfr+sxN8hxDAXrtOlQ?=
 =?us-ascii?Q?1qRHhdqXuhBvloqJ1kut+432ZsNwqAdYmaRgvivI0U4nYWk1PvnPjLd3x1RL?=
 =?us-ascii?Q?FTJDqBoA9zel2wQt+M/uj898kNjO4irmI3iIa3bfHvKxjmvNrVJOwNV7oyFh?=
 =?us-ascii?Q?qzvKc6uxtE+7H3slkIFcuCvFrpmW0IG2Rr9U6BzsUCVrv4ycJzBJF+6lb+uE?=
 =?us-ascii?Q?XyZIZLzM5AzXnTd7BlnGEwrv+5i2sufcZs9uSxdCEu9M8NkCJ9M0uOr5BuEv?=
 =?us-ascii?Q?8pIn7JHM+vEABITmH4M7/RXGe8o3TyT0EN+W6itmSSf67fxUv5ZN3wxTGKKB?=
 =?us-ascii?Q?Kyej1iTzixLPzEuyJWoOry9+gfhTZyqpZ9QVTqxlcrsokqaUUAMwNnH1zMJP?=
 =?us-ascii?Q?ruvWC1DoGwN5MccZvZg6Cw6XMSXPY9FfBsJs821ZXZLxVP2RAahOT1C3+Hs+?=
 =?us-ascii?Q?Ylw/+aTUGIXBQlhd5B/UWktU6v2zP9opEB7+a455333M+KbhACV5+zYv/mrC?=
 =?us-ascii?Q?SsDLtaBlj+QusHYEj9dJ85/zYCsK52XwXu0zvBottJQOPpYTGCs8G9w23rpQ?=
 =?us-ascii?Q?Kzp4TqGNkLMAuyZiHb/sv81qgLd4ttDn1wJqmI7QcFG4cHenaKvIZx3Ed88b?=
 =?us-ascii?Q?QyPjnRwCX1eadTvLTlf9RWXeJb8MbFLYUF8LiEdlgXL2jUR+KfYHJIdqaqiv?=
 =?us-ascii?Q?5V+OuYfcK7UEHZ9gcEFPg0e4b6IhNvKWEGOAcvqC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e5ce56-d756-44a2-741a-08ddeacf6ad4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:51:12.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsjF6fDpVWHGMFWvjYEF33u6PNV67RHiI88GVuv3xo9VpVkoTNtf2ulzQiXAOyF4gQEqBP6YJoLX+7PuctTJyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

[ Joel: Replaced occurences of CFS in the test with EXT. ]

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 9d9d6b4c38b01..f0a8cba3a99f1 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -182,6 +182,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 0000000000000..80086779dd1eb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops = {
+	.exit			= (void *)rt_stall_exit,
+	.name			= "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
new file mode 100644
index 0000000000000..e9a0def9ee323
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i = 0; i < 10000000UL; i++)
+			;
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields = fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel = rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(void)
+{
+	float cfs_runtime, rt_runtime, actual_ratio;
+	int cfs_pid, rt_pid;
+	float expected_min_ratio = 0.04; /* 4% */
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	cfs_pid = fork();
+	if (cfs_pid == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (cfs_pid < 0) {
+		perror("fork for EXT task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid = fork();
+	if (rt_pid == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	cfs_runtime = get_process_runtime(cfs_pid);
+	if (cfs_runtime != -1)
+		ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n",
+			       cfs_pid, cfs_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", cfs_pid);
+
+	/* Get runtime for the RT task */
+	rt_runtime = get_process_runtime(rt_pid);
+	if (rt_runtime != -1)
+		ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+
+	/* Kill the processes */
+	kill(cfs_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(cfs_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	actual_ratio = cfs_runtime / (cfs_runtime + rt_runtime);
+	ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return true;
+	}
+	ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
+			      expected_min_ratio * 100);
+	return false;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link;
+	bool res;
+
+	link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	res = sched_stress_test();
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	if (!res)
+		ksft_exit_fail();
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall = {
+	.name = "rt_stall",
+	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)
-- 
2.51.0


