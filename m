Return-Path: <bpf+bounces-71189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B643EBE7D3F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554AE400C32
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43A2D5C97;
	Fri, 17 Oct 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBUcX/6M"
X-Original-To: bpf@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C33090CE;
	Fri, 17 Oct 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693627; cv=fail; b=Uh6bdxCPwTlWAvGm9d5GTyJ3AWZRI14RoNU1so5yoSTcbBkgTxoUkTgTU0Pv4u7tpHGw7QNimquJAgFLjOcHPfLViMyzVtSF11WEU8FeUgM/1nV3Nwe7Jr7RA38Ml9HGYNk8Z3Ih9kqJyzvwdZFHycepRT86y6/UkfD4xcDTvB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693627; c=relaxed/simple;
	bh=tV3JsBIKtpy5s4327y18VGZzgB0OXrOyhm3Qgj4duaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrUR++fFj+CxoELcS7DsVwRszcWNVVG9QJLzEH8pGskK0aYWRf+63GadLNDWit2QHo9mbkB1SvGolbOE43kb9X8hXzrEn2OHRw4d/GVpOAMsPI8JwlQad98OfO1b8JNP5D+GUflMeogsjXuXnaBzXs6U6frAVhqtpsCG+Z8U5Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBUcX/6M; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyYXvmyvWe0rFc6M20yO3cIOS3cyhI9LxztIWHOK6Cn0mYcbyingmywiYArsAxj1fz/R3dLvy4H+skl+J3I4ydDzL/vZALrTVt3KDEeyRmZf5HLggt7xRalMQQzyoq6v2sD+IqGM6gidgFaZir6GtjDTMukvLrOTm0e11XoM0K5+sZBEQ8cn69tp+Xr83fJJzq0AixLwyGRunOyoT0JvsrXWsa370ELSeH53fzyUbjbcR224JsHXozlFg4sXasVAyGi/OokW5ESI2tONzswkq8dyks1SgQsZfKMehS604v34ORak5LQCJO58QM4qDZirsRLTLk8z9JiU1gkmfJfm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbEiaeMNYrjH0JBkdsB0ERyFg4MyLtj10cpn0M6fzPI=;
 b=PYOC2SU2BnUfeooQDNyzkqGBGKbnI/82TQmj++sb7G7NAM8r4lj/0QgFkhPJhUiBuvKHectYcl2wiJt3x4ZXQepr1wvwczRWjymcwMPNIIMCWjttdqSgsiAer6UVMpbTUy3lXV5+gexg/WP8NwphFQ+2UhsZA8/yWkTXj8schvPvqOkBsfG9p1wGCT+4Dq6X3o5CFR/EHqLz1SeZqSD/7UC9xggpfGHWP0XzfPrnYbaxXmXNGQqoEnW48/cGmuFZqKM3W+ReE8LcVUK7J6Fp91cQlQNfRE+biz/TlmZk8v1MTZoUYQUcnS69dCOk3NUe/Tyf0Mk9WXdBAhNQpFfW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbEiaeMNYrjH0JBkdsB0ERyFg4MyLtj10cpn0M6fzPI=;
 b=kBUcX/6M9LzrOFxkhTN+8215tg3o0zoFpVTt9l4gHi1W8ayIem7q4rV9f4ocXEgS50laxeFxzjKGntjSPAKgOLBRzRtBxEJtkgYAPWGwuRqOL/Rh++6XtdJkcjaW6g2+6Vt8i3gdk/BGPGGqxgeNaHVaLWLOzt5Z7x6UMy3mVR8w6z/vPQ+EX6WlokM69bzKvvFK9fiZQwu4nluGhdBgSjj2iPjwAEAJKdHUJwuFdsABH/0GlEE5kyVj3p1HAj1IrQH6PqLLqs90LTfFhBiFXHaZF9B4WXS9+ubIKYArp9ZrJN2xCWqO8CwSNQGOyaMZ4jUN6wTOwgwWY5Lx4sJONQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:33:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:33:41 +0000
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
Subject: [PATCH 07/14] sched/debug: Add support to change sched_ext server params
Date: Fri, 17 Oct 2025 11:25:54 +0200
Message-ID: <20251017093214.70029-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3981aeda-0c2a-44d2-7fa7-08de0d604252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WqA0JHzvBijMpJ44CobvJiPYNrZNMq4dps2FOoYO9EvIyNC099adfepNZDIZ?=
 =?us-ascii?Q?lP/WGeMhGYRWw+xIC88vNc1IgDIZGEJFUWXkOLuPYz4Hgx4Xa/JNXrzO928S?=
 =?us-ascii?Q?V5ApnWeSIL3lh7/8gQavPaN0x+bYrGseIjkiVXHQms5smwzB0EQ1slZKNB6q?=
 =?us-ascii?Q?JhFHxDr8lJIxilyjT8GRr+v8nWBgEhAfmSJA6BDU9K+xVLZQXOJCpIrMe69Y?=
 =?us-ascii?Q?j6M+XyaLrxiU/U7FDFrYwrAYYWk1o1/97PRXAKQiUive3JHjE2DKXfHgAY3W?=
 =?us-ascii?Q?0ORF2yImu3UkqoZ8hkHNQQQv9iEbxjCs4L433N+PNfkpqlEt0+e95rV1Dz9B?=
 =?us-ascii?Q?kQvZS2m04gl7ZUAdzTV3/+kEHEXki1bSghjtiCbhwSzG/mGKkFKrtzRmzJ6/?=
 =?us-ascii?Q?M/88NpWJ9ABJu5FNFLDfnQAsl2tJkIb3tPgJ7rXRCa53/RdYkfEA4bPrG2hS?=
 =?us-ascii?Q?ASALl/bgoGunDe/+3RBKgmfxfdJ0LaWOfmuHH9rvb6qCr/Xtie2xpz9C+/Oi?=
 =?us-ascii?Q?RTW3M/GwOUIGdB+ChC4ABa32mjfCClroIh04FsOMdPJH/rktua6lo2mawm6s?=
 =?us-ascii?Q?SiOmzGhrIqlgxHg0i82HIOkH76kk/YaOKZxoiln78cujn+dBcV1vet+FrKqN?=
 =?us-ascii?Q?nisr5m2XU5qhyOjIOhD5+R2XjBMQfTaxDQetNzu4g56V0oQBaNnLoig3Xbfn?=
 =?us-ascii?Q?zC6viSSMiyq+PKNTTSO0GPQBAaZ5ptSu178xsoIl8rFqXyp/ZA5FzHVAl5N2?=
 =?us-ascii?Q?0sHvD0NEX+GS2ikarlqeo/aCWxE7SHoZr7r2CL/FwKh7Fs06Fx4AnERPSrp+?=
 =?us-ascii?Q?0lnPRPOHZmSeiyBPiUURldEu+Phgsc87kvbsu+YFSE/uwfnKbDsHyIYwOyNq?=
 =?us-ascii?Q?M+ru5/mrCsO+N13Jwky8eTGhGWaFD8ZB0ryPt/LtVcERcbDMZAWNroY3GE1Y?=
 =?us-ascii?Q?6zw61XL9pOg0PhHYBrHvG/zmr0z52jrF7f8xAwzM57Wx6zBNFbGMWC3YaMa+?=
 =?us-ascii?Q?lP8kn7quDKvt1ZaZxunnNQ70PYTf8aYFwfkc5jmvGghsbf5HJ0R8exv0BqKn?=
 =?us-ascii?Q?lWNKOWBuyXLPC3SjoyDBpsKk/hMGWWIXMgEt7nKV84dUqhTxlfu+IzaFEhc5?=
 =?us-ascii?Q?liBq38MC+wWxhEOp2lEtim4cDcuXxnCBViAy5PLMkCHi+RUGoRDQIZdjRIqg?=
 =?us-ascii?Q?4pZ0f8bHzkAx7TKSx+ySkVulUdPu6xsDxeB7dDFvh/uUv7bDTv1RMZe1WWGw?=
 =?us-ascii?Q?YLl6sN19NFMbeg9TyziFLnnaiKQ0HP7N3gZgOw0v921q0wDshiGEK0y7FnGG?=
 =?us-ascii?Q?VDMV4RvAkAQyPQGfR/qrluW/hvWAM1zsAeVcGgfaY5joQXg1fjvmZeuFnr++?=
 =?us-ascii?Q?JsbI5fa2MbHZ2OvEJftfFiHZblWfE/fMOXHYDcHjP+yI7F5DIFXx8wsjQMyH?=
 =?us-ascii?Q?b612ex/yyf/yC+xp71vtsikM/oyz7ssb++nTrzKeF/jc07VY2i2ZXVxhKG+r?=
 =?us-ascii?Q?yqPo6qW029cc4sg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ev7PaOJ3cEocdtIOoxq8tSUXEmLdDd5i+0X9Au4Pdybxji6jmQ5TGrqjBptD?=
 =?us-ascii?Q?TII48K4zhoSuJYXwn+JJa8mugieQY9P++hRC2DgUOqMZwnzYJET/BSArXISt?=
 =?us-ascii?Q?zXtoa6f2dlc/rWclf1teoDlyb5mgTnb+jgJzDRwqf+a5FaUeU//A1/L2cGub?=
 =?us-ascii?Q?ftMnFaHGoOO739ocSWWUUnWG6mBe5im1eAy0iy9HFf+soSm7XOoWPjdKtCTc?=
 =?us-ascii?Q?KS4oYAh7w0C7MTiWtBR9QWRYfGp9GTqBV8gkebWIpu2WfiQBZ3mELErh/nyT?=
 =?us-ascii?Q?3LMvJQVBMU1XroRlA79jATrfk1emFUHd4ic1bYegzKvrbVSv6yioDYCgyDzq?=
 =?us-ascii?Q?S7LYNX6kFZsnHSwGoi5zQwNNLU8d3FYQf5ymUIbCRL42xP0uCCV0X5SyREi0?=
 =?us-ascii?Q?Q/tl6xRrpyzqW2zWTSm+rtpK+/8ipQt5iCEqdkcml1O3KS9IrZCMlzNDVIvX?=
 =?us-ascii?Q?mYP39lmzKSsflwCHfMCrojSq9bgzGY44mfz/D7W7TD+Rcte1ZEdNEMXqMjj2?=
 =?us-ascii?Q?79qOxoXX1EcSnYC1G6eCedFnc9pCpRitke86npr//g0FUJrFA63iP7vTVQcW?=
 =?us-ascii?Q?Q+sovXDtS66Bfx09LSkl1w+ZN/nvT3Ouc+vSjiPf2sRTMDeV+S2tv3UyVYYJ?=
 =?us-ascii?Q?WgU7qVtSDCn7/WWqqe/i6wE/QZ2TvMVOdB5FcyuwlIOHCMlp8GUwd02WCJPq?=
 =?us-ascii?Q?zULmcBYyfBRF59QzQ2rPYu6XxfVAHx9uJilA3ak8f8Cla9VAk6TrdlhKTuSr?=
 =?us-ascii?Q?XyN8mxIDV0YpHUthtnE1S3nnZtbWXPO/OwMRWwR3tzpWfQCPVY0CtZd5Ifk0?=
 =?us-ascii?Q?z3JJc8Xjk6lR5tTdU2HXPCGoCmGLDrZty0YCtwN9MIXUUnWtO7VgcLqjXafO?=
 =?us-ascii?Q?pc4CGyYayO6Sw0Qva+YV7QYObeEU4ga4G4nXQ4HB2cxZzs6D0zUlYbBpCsk9?=
 =?us-ascii?Q?xTZEUCAKf5JyR2RpzYNWgzifqsn8LzUejO+Q37muRPglfcHV8MH5F/WKfaRq?=
 =?us-ascii?Q?hf2/jrvQphYDYY0MH0Fg4hblBHlCfwCWZFr+WhfUv8fcWiJQHFNE9o3zpLpa?=
 =?us-ascii?Q?Da4Hgo9RkALaroEt43wYauP9psa14eTDi05G3uYtW2Qqg1SFVMDb0V5MOWUc?=
 =?us-ascii?Q?IahPshJlfoDz02YYcbej/VdqhlAsZw/y+YCnaX8e82u5HsTSGstIA1KnXEms?=
 =?us-ascii?Q?yT5+/Jw9E4dmXk9zbG/9XASAumxwDmGu+jXBARToxkTjWqYBNwHu72rfeMoE?=
 =?us-ascii?Q?rxnjbgSpuEBEUfu6TeX7KClFKrS6w9cBUjB5PMRLyETLy0mnKtTwhP31iKQ0?=
 =?us-ascii?Q?koG6KVXdLlaOMCuSZvy0kasKf2sPvB2Tk0s6pwhktdKKCmhoJWAfMRto6JB+?=
 =?us-ascii?Q?RVxcUug6aTydLikrbfFmeAto0zQrcDMC4CMYGDbKTo8IqUWMxm6u3LTc1mGz?=
 =?us-ascii?Q?kqEsjXbGBNsBCOa4no8HypA8qHRCPCE8fNpJkW0oUEJAXZd3x7LyjCiMeaPi?=
 =?us-ascii?Q?QY81APjhOQYPtGV8/XQd9cV4s7urfuVX2GeExi3vc6L0SqiWlcs2iCr2Rg71?=
 =?us-ascii?Q?sDgfWvEv5XT4ovKyVlRE/7DOrVABLhsPTeceBhcY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3981aeda-0c2a-44d2-7fa7-08de0d604252
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:41.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg1ospYBaxd5BkTJ9kbO49011jyHyBq6Cr197/E/+zt3UqSK4C6c/z9MQHzhSvZtc2BmOmnmOtPKX/0cjM0zzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

From: Joel Fernandes <joelagnelf@nvidia.com>

When a sched_ext server is loaded, tasks in CFS are converted to run in
sched_ext class. Add support to modify the ext server parameters similar
to how the fair server parameters are modified.

Re-use common code between ext and fair servers as needed.

[ arighi: Use dl_se->dl_server to determine if dl_se is a DL server, as
          suggested by PeterZ. ]

Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 149 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 125 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e71f6618c1a6a..00ad35b812f76 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -336,14 +336,16 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
-static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+static unsigned long dl_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long dl_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
-static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-				       size_t cnt, loff_t *ppos, enum dl_param param)
+static ssize_t sched_server_write_common(struct file *filp, const char __user *ubuf,
+					 size_t cnt, loff_t *ppos, enum dl_param param,
+					 void *server)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 runtime, period;
 	int retval = 0;
 	size_t err;
@@ -356,8 +358,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime  = rq->fair_server.dl_runtime;
-		period = rq->fair_server.dl_period;
+		runtime = dl_se->dl_runtime;
+		period = dl_se->dl_period;
 
 		switch (param) {
 		case DL_RUNTIME:
@@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
 
-		is_active = dl_server_active(&rq->fair_server);
+		is_active = dl_server_active(dl_se);
 		if (is_active) {
 			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
+			dl_server_stop(dl_se);
 		}
 
-		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
-					cpu_of(rq));
+			printk_deferred("%s server disabled on CPU %d, system may crash due to starvation.\n",
+					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
 
 		if (is_active)
-			dl_server_start(&rq->fair_server);
+			dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
@@ -401,36 +403,42 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	return cnt;
 }
 
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+static size_t sched_server_show_common(struct seq_file *m, void *v, enum dl_param param,
+				       void *server)
 {
-	unsigned long cpu = (unsigned long) m->private;
-	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 value;
 
 	switch (param) {
 	case DL_RUNTIME:
-		value = rq->fair_server.dl_runtime;
+		value = dl_se->dl_runtime;
 		break;
 	case DL_PERIOD:
-		value = rq->fair_server.dl_period;
+		value = dl_se->dl_period;
 		break;
 	}
 
 	seq_printf(m, "%llu\n", value);
 	return 0;
-
 }
 
 static ssize_t
 sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->fair_server);
 }
 
 static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
@@ -446,16 +454,55 @@ static const struct file_operations fair_server_runtime_fops = {
 	.release	= single_release,
 };
 
+static ssize_t
+sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->ext_server);
+}
+
+static int sched_ext_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_runtime_fops = {
+	.open		= sched_ext_server_runtime_open,
+	.write		= sched_ext_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static ssize_t
 sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
 
 static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
@@ -471,6 +518,38 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
+static ssize_t
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+}
+
+static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_period_fops = {
+	.open		= sched_ext_server_period_open,
+	.write		= sched_ext_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
@@ -494,6 +573,27 @@ static void debugfs_fair_server_init(void)
 	}
 }
 
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
+	}
+}
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -532,6 +632,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
+	debugfs_ext_server_init();
 
 	return 0;
 }
-- 
2.51.0


