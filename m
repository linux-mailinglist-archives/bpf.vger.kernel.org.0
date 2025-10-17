Return-Path: <bpf+bounces-71186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4157BE7C70
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4805235BED0
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0072DBF45;
	Fri, 17 Oct 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ITBRXm1m"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7A2D4B66;
	Fri, 17 Oct 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693603; cv=fail; b=J6Z5Q1y+Uy7LalzwnJxhpEXMkyFAz9dIn5/uFORgeahaAmkhLfd9uEch8NEUya1djv1f8U7ljk32aRAM+glvhT49siY7KPknd8qvJmFZ2lq4MD2fuxyPXA9sHwNaw8E2ec7Xi01GyEdv5RTw11yFspoJxcELEych4QUScs3D6tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693603; c=relaxed/simple;
	bh=1R4iGf07UY28o5AwuLGboKA/gHm+A5S+kC9hf6Wtwjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZVi68ICyhurdI8ASWsSYoczY0o0DK9YxFpkrOE8vn3eqPjItJo3dXjZJGxymGtGhd+XDxLkeuX8T4FNqu1Cgeywj6xns9Xe9oGLE121niz6MDJg12ZFItUeTggXMt9pOC3ffkchquzTXzAjqMFREbrQQ9QMi0hsiIEz9kis3Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ITBRXm1m; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2XnWjXBAwa4G0Vs3IaIuXWSbkrI0CG+/FtimX/jKa5faRmFgcoO3d/x8y69l+j3nZtw/O4Eq4gqD+P4OkTXIU8HNwbycfMqx0hCWqtW4pUv3OIuFwm5Zs325xDcUvtdqBJwDpK55aUhk/D9roCGXcO88Q3JX3T/pHpXdf+jUC+iOx8UW7UcTwRc/MwJKibnvZRlOv3OBt5H6nT64aONisw9fe9YBhrYbaMYdrn/9uc87qQ81Tb937rvBTS5YXDCchldUTpT/fC66ybAcp5fAnJ7zV4U92gvb1t9d8HMrCQdNUp3zG1pCXKjAsz1NvqV2e+lUmKAHYwropUqXmWDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/zgczI3OUt1O+p3aBHobUHK2EmLAzAkxJBjH2hDqfI=;
 b=Yd6kFWc84WiHhggxvMLfU4VZVeMYF58senshMd809ysxEweJ7O3PZ/fyjsuX6P4NZfed3unu8v3gY8OK9sAJLKakmlmfDpPryrzZvduy1lIcgfBgax+WWbKTEzR0YY+Ud0qigPBKLAez4fz6arkCoBnkH+MfBiYUln3yV1CXx9TioLck9HihTDVQa+BJJJCIgcRF6Xns5bqktkimSmb+O4FSuCpO/5rh7Em6oLUqN3A5Oe6/7Pu8VnVU4PkT4iwhP1YW0JjjzatTFCbPihMaf4jWmNDqlgxh7CfpaU1zc6yU/HVs5kBgooQshwNeuLgSIi+78L+badEcLo7cCrbUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/zgczI3OUt1O+p3aBHobUHK2EmLAzAkxJBjH2hDqfI=;
 b=ITBRXm1mIqybEm08zrI1FhTxrpNSwkkbQUULWpkFGuiKfReOmiXUtBty9GnIrn6MckpWW3U1+eBfRc+pr7gvG4Cwvq5qg/eMPuq+OYwwKwQX5PTU4ewTVHwUTUzrFCe84hEBy+VPT7hRK/JAtHKOen10ATZilEFRw3yTy7hNG0gFnDIb9gCGaQ5WAMApw+/Wq/sXZZM0BfAgVaE55akXQXZ/NdljN5r301j60ra58EMeBRSkWfunueEzOjzZ2nIk75Fvj39ilxbTCRmIxM+Sh5CpyIC37Hzrcaw2dT2tkJK0B2iDfvrLYfdvk649GSlUJima2HBzKf3/aHEigQZcAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 09:33:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:33:19 +0000
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
Subject: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Date: Fri, 17 Oct 2025 11:25:51 +0200
Message-ID: <20251017093214.70029-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0115.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 316ba8a8-a66f-47a2-1bec-08de0d603503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fMFj5K6StbgNxzr0oaFz4XpGXtvbF4mh6vHrgPvfixT173fVcoSdZimJb6QH?=
 =?us-ascii?Q?IK/tvmoShi8bxCpF+vuNGQHAr14a82bkhpqps/GwXF6GA8LA/X/wXbe4k2aS?=
 =?us-ascii?Q?kwtbC6hQIrpOrJX34ZBFbmJj8XABYQ9eoEbj0XK1jkVYdEfFB+oYfBcnY8g0?=
 =?us-ascii?Q?WrrWPFXahzuvuF82OHTDelFPlkCRN0lThlBgWVWh3IHKn9elwK1s8qqUYf4w?=
 =?us-ascii?Q?445Bq2DcMl/ub+mcGwDoUrJ6GND/Hl8ovvUzfdLmO6J699zCZteVZhnr3Fxq?=
 =?us-ascii?Q?yOYl9Kc4Y+0xd/X+iDC6Yge2jU27vh4eeZgWXwC7ZdTNFzZwy7Ez4OcJfmL2?=
 =?us-ascii?Q?D4EFhTpOGh9zhIkhuwNSj6JEV7tWFQoXM0dNQVFNgB+ZruOvFv1lLlfiLmyO?=
 =?us-ascii?Q?8wkXuKOir3MkXoJ46M7QCMpkKNkuVZJAUaNnKNBUwQKmTFPyQZ8hsNQMA8ov?=
 =?us-ascii?Q?0VxwKERnaAPR6rrgEZd92aTKKCvxuREAO/b+BCQcAB9JsVLD9qSYpAPtSESw?=
 =?us-ascii?Q?Cvj4xoV7NF4bh7bhELNzIm2pQmaYOYkAdKxTfSGzsrtJdOyz2VpVoNv8b0pI?=
 =?us-ascii?Q?IfZ2keRWOtwUzgSchg1oGZlQ5vlnYayoJ096MmYYcQsqLgRuh02DZH+Hh4/y?=
 =?us-ascii?Q?bwcc8YtZwqlcPcc5YHjgcr6PdiUtK4Q7m4nNB5oxfE0IISKLGS3c4TgwPAY7?=
 =?us-ascii?Q?Onq9CAX2wv2rviWG2G+PV4Ft57Pc3nMq0RI5QTwP7f4Ojqx7pTUXcwblwiU4?=
 =?us-ascii?Q?0vwGAHMXMWdN3zjhTWeLM0us1F7E4TJHyto3h9PO/PElqKP07rdoE63t+k4D?=
 =?us-ascii?Q?RRn78WrwAep2RCSPsj7iUB+d6VIFlvnmGSf6FtTbQS6wt8Q2zhcwlS16/KaK?=
 =?us-ascii?Q?8Fd77AIHuFxXrA46uTWwZeSkUcSSsIYksBvTFZ6Aw+CJYgRaI2g+J9raPjDd?=
 =?us-ascii?Q?nXxKs0wayUn9QxWH3m2XNXRhqX+FCk6aKlhuo6QlPIw28FG7eMqSTiFdhoMm?=
 =?us-ascii?Q?9tNWNkPSP/LaamrCRj8rBMHzCDcSQh21GEs1yvn5JyhEq7EW0hEeB/vveIpX?=
 =?us-ascii?Q?gQu2tgxB5v41UykWC93MUeTwk6FpGerd0Vp8jWgCtYloWOVqkJZF+4yOVogB?=
 =?us-ascii?Q?dt1KpgNzjTGl6zRsk0gO4ujd+ZBLWxjKWSHES/E5peGJBBohyxH1FbDSipxy?=
 =?us-ascii?Q?e6u38+qPsBze5D+tff22bP4BUBVll71jnxfPdRwjRdPmIL4b7CcDKi89Vc6y?=
 =?us-ascii?Q?7sv7O4GAkGmf4V/NfIN3prfMg8N4xG7q2NbTa3xvgzlsjo5h6+tvnSD1N9HN?=
 =?us-ascii?Q?DKBUQZywvPHtH89rhqULhQz2LqQxBYMVAYi2DeghzD0RfORD0qXEk+a5+j1K?=
 =?us-ascii?Q?yiUzRnYoz11LWs3QBZBSNEYShuy6Jkjsq7swewazBb6ULR/retZgtRIyFl4Y?=
 =?us-ascii?Q?/QqUB1lqFYp1GTmKXpjU2cZYhPIBaCK7XH6q+PH2qjXoHgo+5IoDId11cRa9?=
 =?us-ascii?Q?vAhVVhpcChd6ExA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ooYGg4ycu7KKiq3EW5c+Xy/i/dCNriHU+mbfB/I71N/ez/ja6Tx+q9lnXo6T?=
 =?us-ascii?Q?IR6yCaKgCRrcCKWVNDnzZs+dSc3XO7Ub/4BlpRZBdjIz73BRtSB/pkw6mvPy?=
 =?us-ascii?Q?HcmKetct1JueyxnmBL9Hgxv68KmT9DUC8nUxtoLOZ9qQxziFuN4+qCJajZm9?=
 =?us-ascii?Q?Xuiysx/u2LhPihSpxpnq3lWhumD8VBEhWcL1c4Zi3WQ3K5iKM4cXyQazMyqI?=
 =?us-ascii?Q?a0rgz6bcznkqdX3+4polsLRd7P8eMC3tkD4E/9sR/Mt88DSUEDG9vfP1RBI6?=
 =?us-ascii?Q?VWweI8QOWKZ9ZjeJH4wwoCcs5aWB+9F+je5NZlaGmyxcIog+gJ/olwLDZpPl?=
 =?us-ascii?Q?gSky82pmNWvLbtzgqLh4NHlL0q/qPT4DL9XoMhgkDfTh7WdearfYp+JcxRIS?=
 =?us-ascii?Q?iM5BMZA/yzbQPzRduteT0lGewkYbiUvAbJV0aS7Tcmrqzz8q6cplAESeXC6n?=
 =?us-ascii?Q?VR2P0a/LjK0b5hN1IfIoAkX+CzOWXiqbLjcV4cxIUSWLuY7VWPFMu5wBWout?=
 =?us-ascii?Q?6KP7m698ZrfsTJtKvJ6zmuQvApSYQvJUaRITRKfOoqu7JebJyS36AQpIK6v1?=
 =?us-ascii?Q?89uoB7RwdJgmjXIjVM3LY5kaKBl3tSkmyjSAZTXPkgSEMW9a/rV4KJOeRaRq?=
 =?us-ascii?Q?CYwgtVpxURm7LkRqPymOBuv8pQOljfHl4n+s9crL2abQug/5Oxoa9mB8ryr9?=
 =?us-ascii?Q?LmbABFdLJoHOpqZT6Mepqh39OB/qI9NPahOkkg3oG2MJVXOHGAlO0xnVDA+D?=
 =?us-ascii?Q?otpewejpeaKKPdkHhe7zJmHqJasOla6Mo8/9WjKT3BFE9uisI33pXMh5Z9V2?=
 =?us-ascii?Q?BFKFMDqeoHlqERwHCbMXHQ7puOiRhk0/cMANgFhviUG1TrGcTbJAXe1LlgC6?=
 =?us-ascii?Q?qcZh1nOwkOa05lDb1GifMFdJbW2VXzE+M1XvLq9Fw8BQNG2daBnJ99RZue3M?=
 =?us-ascii?Q?i4il4E5KqNMhkeUAXw7+JNYjtb+zPFUvAfzeiwEvKaI80voeLoB9A/NXj2tK?=
 =?us-ascii?Q?Ex50CLXZ0GHIdIFq1ARAkHSV5RqCbBTdyS6tSfyMTs5DHTtYXONllViIJZIY?=
 =?us-ascii?Q?KFAcH31nILDEt17/GZbpZ8afTYOk6iZgk6eNAYE9PUO9+Qjg2Fub31wTyKlW?=
 =?us-ascii?Q?UBCTWCj1ab/nXk6B18AmyHxCLbBkBO74fjjjd1LLlqVknrZVaFiwXCmCOeoO?=
 =?us-ascii?Q?TKDGjnzPP+LXaGsti7KbTVLh/XdmaQo+pH7ajvMyVOIKtdnXZgx3iBRlGfXd?=
 =?us-ascii?Q?arx9ziwnmGZLBJWaT1C4Uhroiiooc2pDYoF26LIK1ujb9QcVeDVrrynYGUFA?=
 =?us-ascii?Q?ugJdCk+xNCxOeJbMP8Zf7ehPBHBAqRmAmItes6325YJUekj8xhtuPwunZGcx?=
 =?us-ascii?Q?0z9+fG+vQYWcAjMPfVzcKg9WQB2wz0yPiwh4MpHmvTwRs0kzSChKZr5/vqUo?=
 =?us-ascii?Q?22kPmgRaqhz8uXwILaeLzbl0bJJfX9rFXpiq/OJZ06PFcVMtMSEHzOR4Izb1?=
 =?us-ascii?Q?lTwMNajePSQV60sSXWvuT6MucLSM43L7QBbWVOnOGCxFcKbwQhT8YTUKJ3HZ?=
 =?us-ascii?Q?Guf4TTHl+vLf50Jg8Wjx7R+yf1kbvkoVPH2sNER2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316ba8a8-a66f-47a2-1bec-08de0d603503
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:19.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpLtzyaiT43uuX3Jla8lr6HSBkcJ+37d15ygVlDc/AIcpm6/JMTL9Dr+iz/D1EQepNj0uB+kSNO5F2AJGCADTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836

From: Joel Fernandes <joelagnelf@nvidia.com>

Hotplugged CPUs coming online do an enqueue but are not a part of any
root domain containing cpu_active() CPUs. So in this case, don't mess
with accounting and we can retry later. Without this patch, we see
crashes with sched_ext selftest's hotplug test due to divide by zero.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4aefb34a1d38b..f2f5b1aea8e2b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	cpus = dl_bw_cpus(cpu);
 	cap = dl_bw_capacity(cpu);
 
-	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+	/*
+	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
+	 * root domain containing cpu_active() CPUs. So in this case, don't mess
+	 * with accounting and we can retry later.
+	 */
+	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
 		return -EBUSY;
 
 	if (init) {
-- 
2.51.0


