Return-Path: <bpf+bounces-71185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB79BE7D70
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22ADE565892
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E22DAFCB;
	Fri, 17 Oct 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qaTXMDYP"
X-Original-To: bpf@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269B2DA749;
	Fri, 17 Oct 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693595; cv=fail; b=XmJa+u9l/8qLQiH5rPIhCZQht/TEAorFyeSYoLg59S373fnj8878pOd4WYv3aGnbGZTyC8bYgItO6kaap9XS8NA8sRuoMOH9EDg/f2bM3iO6tRrOALpHCMkfrM4XFcR0XPet5sT1pEZAxgWGUjLEnfrM9tJs7jTD23KJG35jMtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693595; c=relaxed/simple;
	bh=Ib2NXPv+GxrpCt5OWykxKJesmFI962w1M6qDJEgzNsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwOhS+VUo1xG3mJzHsr1PqUdzEScjhjSrws63sHLqvaTEaJKBZXgjNBFn5Ce/1m0rOB9STvb5w6pQY9hYCsq5rhvazA+DOuhUJAEJfwNRcjnrDJq2QqvKPMZQ7J0GY17FBf33w60GvrIAh7t87l56TRJGNa6TGFLi1WFxHLNyHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qaTXMDYP; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDzXPlH9n70HRQJapzQMGZH3sEepjO+PKPFaN4Dey3GREK5IqQeeXjXUo3U5tSoZ/930cVUklrkLSz8kAWmvLhWp8H1+maYU6PpXbsGSUleGoJ7xSFUdn/UBPrrw06hiUddbcHBhPkZOVDLj5Lxsh8HQeGw+H2Tr3bT5eYlh1lWyUNqJF6tXN/2yA8amCgx49ALE8BMGfS7WiOWh4z3oHGkQ0wIgcB7Vaq6/4yDbVoC49TU1kxBeM8NjTY0xJ5RJi8e1QA+5tPATAiRYUjaypUBN397seL2ihVyO1tFdWOr6wVXgQth3UQ+rOaIWYcdqDGjHxrbb6LYAwcQwp+WA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeZ5zbVA2RX78yMv1DylOYPYxTmJ2mOgoiS+D/dZvpA=;
 b=B4Oo3BbATnUfjPqHNlicw/SAjJGLpolYxd7fdesdy1MCXkeyJMfjwWZBFQmDPiWRWSOT/g7zDFpsy67O9FXjXumN5QZmoTuN4eycd5zNubyRRiEsV7PGNj2L8rN/uFSLxap+YLuzsdAlwMT471iaAIIJgMsSYAZ0EU7K99W4AmDNPEYkwcD52qWnbT8eEdONcQ+4aC653BcOdtlx7vWV4VyD0UvmkAs1g/b+BNh0ta0w2TLWA8VCFx+zSEqKKFnq92bqYXMkCBRsO/L08E1JbBK8h4XmI3MGXvia2w07nvo3hTi+/cXjc2IcYcXEOTnW2c9iykXkmJUWdIYRvcEhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeZ5zbVA2RX78yMv1DylOYPYxTmJ2mOgoiS+D/dZvpA=;
 b=qaTXMDYPhtNvCjgZdqlnu2IwMGbwJorlXvtTlBTDbJXlJmIZdDLEwXBh5cl1OBaz5sEym30QWXh016HXnmyzwOvwWexXoKlQCTgIZb93VeIOdN3P1HJG72L+LHwgvg2yyJsg27P/lzU5CMGJQvCFm5lN2o5l0ft5E3lgtTNBhT2RfjWicJOKU6+Gub4p6EHlh9CCMQPXp+J/HB9tPGv9ugHI5zIbL9l5D+H6Mq+aMvDDta8mC65mQkk7QKLuEGiMxaYzH9PSHOpFtm/arfnWBMqhmiM/Axw6XAWt/VW3RQ3j4Yd/sKkElS6UU1GkDaqcKoYy5hIoI+Kpn+SkbywGTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 17 Oct
 2025 09:33:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:33:10 +0000
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
Subject: [PATCH 03/14] sched/deadline: Clear the defer params
Date: Fri, 17 Oct 2025 11:25:50 +0200
Message-ID: <20251017093214.70029-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0b883c-4b46-4ec5-cf5f-08de0d602ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDAhfP3ed2VGSgZ1zKsBWsqdTNS08HcuE0dNJO0xTQmBnVdsna6zs3G+9T+r?=
 =?us-ascii?Q?xnrh6o2lYAQy/EV3B4pkMVygDNhf0vOBRQGw6/x/Df1lFegU7AR3OiSCYKY5?=
 =?us-ascii?Q?cpof9W6C+yN+K9hfvgdFj9zfghTEd3Rvl0CBQbNW8PqDddXmbtrRiZQKgdyM?=
 =?us-ascii?Q?ADcslW9M2Mhv9Ztr6W/jPHJYBi1dP3BP+CbOLrloGLF8BomL9JJS7JLsAUeq?=
 =?us-ascii?Q?SczvCAwwettHUx3LtiGOxKK6ZNd0KO0siBqp90vmBUib+4lZkyq1+e1/3qOO?=
 =?us-ascii?Q?VSrZFEjNhk9zYAtabVDJZdbbg/L7fZGJlp141muiGkWYEU6cwDPNC9XjrxmI?=
 =?us-ascii?Q?NtLRGRvhfNRGAy87eWNxo7RVRMRkMyOdwuf0F22Ib2hq4As4hbKPbu6XD+nj?=
 =?us-ascii?Q?z2KoaZAgE7vMCHv9FUjKPrfJi3LBmeQh9rurYHxNPgKH+VOmdfqnIwP+llMO?=
 =?us-ascii?Q?PoX+IKai0HAK99MPmJ71od4GJq7m2TUfomVFjjJj7aJHulWwvsgk8Putqusq?=
 =?us-ascii?Q?/7eJaNC+BFElE0SzrL7rNaaokxhVfN8ouRhA8qIZbNrxY4p+s2VUPfg2xWPC?=
 =?us-ascii?Q?bxBtbSKcqf3YHQuVSQx1CLGj+pY/YquTsRopWIRiSpVhiAAETOfaG4Q75m7L?=
 =?us-ascii?Q?dL+Dcd40OL2cNG3I2Icc853f9CKWd5OgMNpPbsEAEARpoPGeeiDvI/2SQVs7?=
 =?us-ascii?Q?/vFMTmcsk4vxCp+WBF7gWePvZfhNYzCcN6nUp7ZXb+KYa5R6su8jWR8BtyGd?=
 =?us-ascii?Q?ZQppPP/6rbO6/KO4MfBo+GO8hiLtOP3ZongF5g2vPjVbFxdF5AwFDmpB7qHL?=
 =?us-ascii?Q?SDDwUoGWixciV6r8V2BqdZGqOy1uGx2SgcvNKh7Zjpdh1Ll7HRO0CcmW90lA?=
 =?us-ascii?Q?6jQ02qoyKlxgmUBmfePPJ3noCdm8nUA2McRdcVV4vatTiuyzNWhlUftG/Ff/?=
 =?us-ascii?Q?NccGb7BrepzprgOIBq9Tx8uMtqxA6uLisD4pGR8m+38awXHKlbHsYuWJKT0t?=
 =?us-ascii?Q?bJWRH1nTwcLCUjpLoOmpTxpfeWZo6JRTFSlbJ/RM2d7RPA0tzl9Wo1LUw4Km?=
 =?us-ascii?Q?oHfpWGRGrefr50+X8WbvWcEx7MRpk/FKRMAkMeKsSMXgbbRd3fYZJkApZTAx?=
 =?us-ascii?Q?c/wY/iSj3NYKAWqIM+vT6ooGl7vIawRw0es8oKABUB2kulj6odWAm3le5jhO?=
 =?us-ascii?Q?spN/P2vnVnA1CbbcNVUDWaqe389NBcYcvCJ5dbjj7QbKmJ2CPPgVTBZhXPGI?=
 =?us-ascii?Q?YjBckBBI1bTP2vvh4v5nx6jbN3NnMNR0A00y8zsuV42WsZwDkw9cjZbhqCJr?=
 =?us-ascii?Q?a/8VKcf5dK/Ln9b2F/dH/JIRx3aHC2pLCxas8V5uvptVQby4Wj3TDSPSrRkW?=
 =?us-ascii?Q?7mZF+VrGoX5lDptuv30aRBXiQ9rXdDNxrtXwSfjnLapagZA+YtmC1w/MNEge?=
 =?us-ascii?Q?9ErBhF3vzExJLSpmOU9CT05jvLwdZ/r3dtDLvkW861hLingNWpE/Ip95BQje?=
 =?us-ascii?Q?oL5TwwZYTFQ6/eU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZYIXN05ALNdm5DsMTOGHaRSptmOs0wT4+7kRxgHK39dqBlA2GNBOdZ/kjnv3?=
 =?us-ascii?Q?Pr8ui9WsnlpQqYkIILfETwEH7frEZPIJz/QuLFN8tp+wq5kyeZWBFZGPvR/J?=
 =?us-ascii?Q?J6Ry5TkWVLrqZLRwz4D+BoBMQgDnr9lzknMPUa3NzePfeQG2oGm91IQjuDOr?=
 =?us-ascii?Q?BAbFFnDCO7kgbIXD6YBaBQXXWMXcw5jjNmlQUblu4WO+IlbND6nd53MCl+eL?=
 =?us-ascii?Q?gXgSQuWvV5DxbMi1Xt9cl3u0i4VV0RVwIaIaFZAdPZ20qKrJCfdJYAUkOVHc?=
 =?us-ascii?Q?VUnDhid0aV3KE/vPeDbHNVv4Q7+CVpRdrFxAKqKXFr/BQ3h3Hfj/rpdBq4dD?=
 =?us-ascii?Q?AMSJJfEAGEHxp+LQfoWs8K7SupxN5nWKqsYXE3Hewmtn0IqR7h5nhbf8phvQ?=
 =?us-ascii?Q?/5OWLK5ypfw6FSCzvyOB0dsljGn9GN3WL3U5BAPyYNXMxOFuJI7P39v8qwXv?=
 =?us-ascii?Q?oE5Acwd5x2+W5WnEmNqBfO9pAUHgB90MEbQPS8b0O/6piegS6ZMAfb+KBwX4?=
 =?us-ascii?Q?ePe6xmnCA/tIINClyWCeW52nqns496h0X9X1aIAaoRYcHkrDgyHrY1kLMnv5?=
 =?us-ascii?Q?CSiN1hJzEYajYAbEElNzGQhoGUzIMZJA8c0uRajvfkam0nGfiUtnWE4yvnMx?=
 =?us-ascii?Q?52pJ6xlsexzbSV2mz/Qm5NfDcLMKOiveMvnITwOZOshd+s13rt10v4p4fYIi?=
 =?us-ascii?Q?8r0pBXYLca+MpZ4wrSJc4TdMri2fYi5zXvm6vGz6dzTdtz75n4oqBz9OnnoW?=
 =?us-ascii?Q?a/NEN4lQ3LdmND14Q5G0txUkm5icw4vLX5zXabrwYoiJ2CneCNm/0KEyLPfk?=
 =?us-ascii?Q?jNgguZjME4YPJh3aq0jQGjb9AF74tLEFkS7O2lhDztZwSMxWsloR2xy+Lufo?=
 =?us-ascii?Q?h8VW6dL64YLch2QUUHSUN8KrNshyG3r+OflslPakM0BAnpRZ7HDfYcp4VytL?=
 =?us-ascii?Q?2t67vctj1uW7IJ6+QihO3k1UCnwrIg39x96OskVoUHGbLqGIicT9wCjiS4vg?=
 =?us-ascii?Q?DAGNvTpvhLMI1wCi6rCTNOIW+cdPQtqAv1TFS7ZBjFHWTJNvSnMDMBDvX+gb?=
 =?us-ascii?Q?vEx0y0Vgl/E+3p6kglWFVSgWghs0rzAKewhcI9GlExwb7HQB8flCd5liSEO/?=
 =?us-ascii?Q?yxUCT4aUYxThyXVVWPv0SroL0t1VAbt/qrg8/fQ2DqiNyq6aKFk3lOlgu7fC?=
 =?us-ascii?Q?9E2xBnaD6rMemkcHRol6/lNZTFJcOp1aViY+tnIMqsw40q1U6PmOQaWK84Im?=
 =?us-ascii?Q?SNdKE6s7mMyDA0wym4Qjc1X8TzpbQQLYL1kp8tcZ2vbSVG+cF1FY+H8tBiIt?=
 =?us-ascii?Q?2ieyqLCvEU67x3u/WRgh4lIMte84Q8jJ1crbAswk6JtnVgPDe8WEMlJxYMAV?=
 =?us-ascii?Q?/zFsBKWmw4VwA7gEGFyt759o5fGNWgCR6LRWt0I19l9U/oEO0/v8ozqeO4PO?=
 =?us-ascii?Q?IkHbKsWCgyMdW32VDoHNzFj+C23mw7VebcnaENp3QagRKZcuwfDYvQGttzTl?=
 =?us-ascii?Q?pSdt+eT9OMEEPCSOCB4W6OVz+xaYH36Z26c8H1m+fn6xZTPvKUtD97ipYfnY?=
 =?us-ascii?Q?1nPqL2SnMlMV7PGh4CaUjoqZ+WejRMndabQDFlK/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0b883c-4b46-4ec5-cf5f-08de0d602ffa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:10.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jseuv8FGKtUYr/bfw4WQUt9QjQWgbBLjGNsQO7mx5QJpKgE+f/9bGYOeC2HJV2VSSemP81cS0XMjXMxEsSgckA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

From: Joel Fernandes <joelagnelf@nvidia.com>

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 48357d4609bf9..4aefb34a1d38b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3387,6 +3387,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running		= 0;
+	dl_se->dl_defer_armed		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.51.0


