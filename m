Return-Path: <bpf+bounces-53505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A74A5561D
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 20:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F735173313
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EDC26D5B8;
	Thu,  6 Mar 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iKyloF7C"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C425A2B5;
	Thu,  6 Mar 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287773; cv=fail; b=Y5kU5nYoCoymCuNFLnk8elglXdGN3/oRR7Q0rAo3rDmmLCSfWbMMt80bcRKmKrRbV0SPnMZnCEdMmfxrWGv2+OIUz+df8s9QMlWqIH4Q5CScvqVJ5p5wbv8yRKY/U8xI8WSECrKiOTexaMkwcpjO9j/ceSB41csA+9tEuvN9NY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287773; c=relaxed/simple;
	bh=UeuAN+Y81cL3Xripj2bIM+ygCXhd2oZPLDWgYDkRyiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VhzJSe33soE7HKkeO9+Hqyt5WP4IVPeirC01SUYah+nYY7XB6Wvre9nBaPdfm/Eeb5zU0qs2/Buy9xWZV8YDxueoJ//KWDG4tNxSh36ZRIsA+8mL0DTi1Oej23HJLJ9Wsz6MxQBq8tVxXJsvIQBTS+tl2IRlhYchR6IYQxEZ4lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iKyloF7C; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCS/JdEUefzk6Gq0sYk2+WFKSMpUS8JCi7D6lCsCgONJK6P82to3VEriPp6N62E9z4ah0wGOejpRO5L4uFGxe8fqWIsNNbs/MIYikQBkt4GhW4GMtZccw28Y4yrKwF8m6fRcarprbmiHKRPOpIumjlj04unGCUhLzDkRrfTIB/8sJD2dr4eWdQmWo6WOEjoNJcE028NgjZFZxlni8SVIewuZ0gwO9wVXtzoDh2EoxivxdZmrRxDtAQjgAusf/gWdjwiAbzscK0P22Z5iNP/kxZ1MhqdCFcDIbpXR9R8sp6LknhUZpFxp9CZppmK7CxdVGe2sT/kdrN8g9f5APQIDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAmmjiIVxV/OJR8i98bg38egL670w50xbPxu9XDP9es=;
 b=JaDJbH1cKScRZySI11FLeFPQjmqZhv/LnCQmujZDob8dd6Ek7xBUiGtPRrr2jtPu5HRdMt+mpX5UgTcbsKr2fpkaFKkdiuFuyUTXWFRvlCd/luPSQzEJJCKm6BZurMgr/f/igE5r0T36lKd1JTbrXhX0yzH+g65ktsJMeaOWDpblDBQxBAcwWUyl4EBTcpOg0yU+JHkAzb6OxTcSJN0wf/IYAB+IQXHYqw/wHJNzI1y38gOFGgDaVxRzMxSzH5oT9YfC554o2cbspIE//JyrACacRL5CNpAcwo48yj7zIFz/8Ym48Mf+f1V2soIyEqiQDaQRhnfiwW4TW+yBgyVHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAmmjiIVxV/OJR8i98bg38egL670w50xbPxu9XDP9es=;
 b=iKyloF7CjFAZsIh63Y7OQ7lMDoYudSErbHr15R9EGsejwTGleJlhcb0gPbVki7AM5Hk7uGBbk9PkP1cUka20dq0IxBXU++UbLRyXBmYLYBRUV/UNAWZd9c4sY5Urrm//q+tFKGsubzVU7fwNErhtjGbuPlgC0kJ8nh8LypwoushUu312XCJsv0HTqlby6VJwTsONHv9B5WGvUtBJuLl8IG01VEix23VpNcdVT5TpXdHWWUV7DTsRBdgzo1IYQhjR34IrHnYqPmwj8f898oPUUBFqzVXDCuldLewMvsIGTY8jLT2/zbJXwVy6Z6JUbvklpFUJklwEUoawZ1xZtTVGyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 19:02:42 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:02:42 +0000
Date: Thu, 6 Mar 2025 20:02:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-6.15] sched_ext: Enhance built-in idle
 selection with preferred CPUs
Message-ID: <Z8nxSUEfREpQjRXo@gpd3>
References: <20250306182544.128649-1-arighi@nvidia.com>
 <Z8nqpyEQmmff9E8X@slm.duckdns.org>
 <Z8nvam-WarNqdLw9@gpd3>
 <Z8nwU3C-WiWN7eia@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nwU3C-WiWN7eia@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f070bbb-458e-49af-3706-08dd5ce178d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1Wks8DlAuMQWt1UgzJ+eeb5ROKCUDL62db/oV9SRxPk3rgO79mATeVIPalK?=
 =?us-ascii?Q?M5feYUqUxnMqdzyjNUMxKslPNG99giezIpRh611cyG3m3ce1Em2DsdhxfETB?=
 =?us-ascii?Q?0shBfvQE5ei4f7KaeeLLZqP6uk3qFBGcDNaVImrFs73A2ghgsEw5tl9ZuEd7?=
 =?us-ascii?Q?+2x/aHIv4NWV1wCO1gjcQuSQWZ22pXU2d+Ll7rXHZwh0iXwKnwalDfwQtug7?=
 =?us-ascii?Q?WZAlM528inGr2B/BsPfFob137MuQvjViiYMpIetAL5YRGeFtORbnKVY+u/WQ?=
 =?us-ascii?Q?64azRUOc+BoYk3qaG52AaITk/9y7CbuWCuT2WidmOO/ZZQrPp48XMmK6vuzj?=
 =?us-ascii?Q?jPco2yH65BxKdShNUIMlPSvH6/YDNOMuZDN9lcbf6XREpgZZWtps4rllGvi5?=
 =?us-ascii?Q?wgD/bFCmAVM8NO7guS9JCOXJDP9MqA5jr0uPfRCHbXgYHK+kv5ONj5L+T5La?=
 =?us-ascii?Q?jlva2Q4EENr0EzsC6ZXq6zWqO8VcUJmLbH9l7YYenAhskSzG61995/SfUyYE?=
 =?us-ascii?Q?SPSJvMUFqykarU0eYPUeZ351WRtd7KqvnlgI8/sjMK8uvBPNfjmTMZvNBFPL?=
 =?us-ascii?Q?6bynGFQ2SXyTuxrhCid2as97x55gLQguYY4RmCpiKxSRDx1fQuJfwFwrP2Tc?=
 =?us-ascii?Q?U50LbgDdGZ/sNI3kuSbq9lozi8UCinuZXm+TmxskvfJfeQ5c8XfuVLX2QFsH?=
 =?us-ascii?Q?dd9g7JxJn9IrXw6zxu6F0wYvOybjDL3WVyOgTa/xggmxW41ieosxtmH3I2Oo?=
 =?us-ascii?Q?PCUIfNJG7PVQ5wvBVwsLByxjT3fiAZZ2gvMHCYyV0FTcOEEIaXH+8Yctggdm?=
 =?us-ascii?Q?0nbMFKx09meVPRLeSmb2UUqeIjoOrvEC2l62Jxp0pXanb0hpa4HQGgpYkrKG?=
 =?us-ascii?Q?Vnndd6OJvVGR2w6118BY0LjYRquLJRYA6q5mBV9YnNF3zWTGrAfNOlkY/Jlg?=
 =?us-ascii?Q?1nEzmoapmdwZkjxNHBtegxRpTtBOPjfAGY9TTA1qdNJXCyVKPvQWQt3ksFzL?=
 =?us-ascii?Q?iBymBon1Ns360js9IHzVicYNkBG6Jfmr+c+qCHtDIcA9Sl0ImxlcbD7UdS2j?=
 =?us-ascii?Q?MHkY/suz9kgxfFPgoXzeMiN/EWgNuIaNiZ30ZJwR/I9jQvjyfcC0qG17sNyd?=
 =?us-ascii?Q?kFImYZ6koW1mZpPEizPeUR325BNSQFhyaWt1huRebbIzgFEOL3nb0RfcQDHR?=
 =?us-ascii?Q?Ukmq5byO1tiNYZUjUMtWaWcG+4isjHpUbDa5n/+joURlOOZktCB0dbDYvbxT?=
 =?us-ascii?Q?GEkahveH/nMuRyzyRV+rAmWZAe8arC7eU4NJBqIHtchwkXPGCDzdbArM3QCG?=
 =?us-ascii?Q?Kl/OBjKow3r1PxCUuifCOfhgUUU/bsyjev63mbbwM5AKRW0IexJ6IUkUPcev?=
 =?us-ascii?Q?6J6kQn669eZLYZxVvqsu+IntyLba?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eq6TtjPMGqeAKwxJ87emBl329b7QP7XRuBHWLzm4LVHb44mUf6qSfqVlru1G?=
 =?us-ascii?Q?bvl0GQitlV+66ANMoypb+U5HRBaPcPH1VELkAO0xbrzVm25EtXVYSBRVm1ns?=
 =?us-ascii?Q?mgoE6d/p1MmkRisOwbxFaeoz1o2E3D+kkg8Wo407S6bIWXja0XLYgQX8sB51?=
 =?us-ascii?Q?0r/2SC2DkSgsyOYU0YutGCdXId9cOQQ2gxOMOrTiiFpPtmoJU3g2lO+2heis?=
 =?us-ascii?Q?sYsOYZCeFTj02aRXkPyrvWZ9jFNagFS7ggYFwCRJsZMueggejglT4yXWIdHs?=
 =?us-ascii?Q?NjvsP9uePXEiyUIMGFXx/6TG7KzqfAauHj66VAWuxzDcjcgvQTR1B3jMUShM?=
 =?us-ascii?Q?ZTWg3t/C4mLmC2EBs/aLzTZzRmSqkAQdf4SQHkBBcN+/uq/9VZB2IXAMeFnk?=
 =?us-ascii?Q?m+6TIKGejExli0UqiB/DaJZ/q0x04W1B4PvRor2Pln5APN07qo/+AYgDooAM?=
 =?us-ascii?Q?tKUqjOgDlxoYyGYWLghB6DAo6lBiqM8U2rbqvTcBHER3qdB84wkapuWC0AeL?=
 =?us-ascii?Q?0OSlrGzrP5mmE2XSi9xnzRgl9QbTvaS5uce2TCtFRl0BTMSKc1IO3F1ugzac?=
 =?us-ascii?Q?1Epx14D7vBhxD/BrZTx4Xsobrv9CD7Up1RC5dnzst+fBaRTwn9hj9fN+Q7zP?=
 =?us-ascii?Q?U5vpV0xRPh6MUhV5jPdx/1Gg0LBSGg91aXR8NNIVUltfATz65DdskAZ3TxXs?=
 =?us-ascii?Q?WjNDxvMUmhQqKmvsI2N62kP/5Mle/e/dLtw0QXUpMSN2qycsfNe9KEY1G71a?=
 =?us-ascii?Q?+0okLwUy2wnZz2cIwqpOkgWyGXAtyTZx5zQIPIGbmBbN5tN5CkLLQXOelKbD?=
 =?us-ascii?Q?m+dhWIP2K4oF+9zkHojZj6hyds2rSZ46oehYbV3Fq+mvyAv6j4UedZK/t8Pf?=
 =?us-ascii?Q?wbfq2D/Npp/FsueqxZmXmf4hVrMEdf5N/0K0SLRuUfBa0A5pc1oITbTyOatx?=
 =?us-ascii?Q?gf/opQmka2RmBboFNpLvDxLZ5jO00ozX5ZlYRO/HfKKZ5BC9m4Phos0jhKzu?=
 =?us-ascii?Q?OK8xMePR+BBR+nLMq3FsPtH4LJ0/LcWRkxFRsSHK+xjM4h+g9wJlqlR2rfNr?=
 =?us-ascii?Q?uNctL2V81anGq956fPNB3+egmaafrKTtbDCQB0M2Eu7nj/5EQDpJIFHckdkS?=
 =?us-ascii?Q?KXBeEmxfqMMwBN+gdWXXxBz79sw0p4wPjc5aEc6+FJY2Th6BSQhinFQzoInF?=
 =?us-ascii?Q?Se40Rb7g0SssTVF6dmKY+pxcxTtERT/CWrMLIydRIFklYQHLIW2a9RJEsCOj?=
 =?us-ascii?Q?RUZO4bVMOBNysHJl8n4EEGa4coB53w+VdOaMn7GP8Qz66YspRXBfX+opZuLF?=
 =?us-ascii?Q?vrH4lRaAZwQ/gjzsqGXldi0eUmZn/YAgMT3wcNA/Dz5L0c5gFbdsi663NCQe?=
 =?us-ascii?Q?oioUHlXcW7G6smgijP8T0bFgQWV6GhmIeOlUgmPVMccObmUSMXrQzfFmUdjc?=
 =?us-ascii?Q?K06LzaTxWLI1WV2znek7oGoWR7w+281cBXVmREf2izOwdkAk8C1ZcBi/JwNx?=
 =?us-ascii?Q?2e4UFDZW8JHaaArJwWu7ijNHNKhiWQdsLk5339z1B9OKGPOC4a1lOMpUbAfL?=
 =?us-ascii?Q?/eLcaj2H9Ne3de6gF2E8RO7JU05/ZwRGFLuETSEO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f070bbb-458e-49af-3706-08dd5ce178d0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:02:42.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCy6qaEJxCfFav9MwLa+fs+G0aBe0uaC5rRWA7zviXUtM8B6DobdXUgtCoEpfaafx+MOcDGmPUlQHsdBbGUp7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

On Thu, Mar 06, 2025 at 08:58:27AM -1000, Tejun Heo wrote:
> On Thu, Mar 06, 2025 at 07:54:34PM +0100, Andrea Righi wrote:
> > Just to make sure I understand, you mean provide two separate kfuncs:
> > scx_bpf_select_cpu_and() and scx_bpf_select_cpu_pref(), instead of
> > introducing the flag?
> 
> Oh I meant just having scx_bpf_select_cpu_and(). The caller can just call it
> twice for _pref() behavior, right?

Oh I see, you call it for the pref CPUs first and then for all the CPUs to
get the same behavior (similar to what we do with the SMT idle cores).
Yeah, that can work. Good idea!

Thanks,
-Andrea

