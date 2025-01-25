Return-Path: <bpf+bounces-49762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C84A1C0F8
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 05:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229823A86B1
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 04:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3445206F31;
	Sat, 25 Jan 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oYwKszB8"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B6146A7A;
	Sat, 25 Jan 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737780877; cv=fail; b=nTI0wJSl7OXnhV+9wWW5Svc/HWdYfrGd+rJwavqCg+DbEvOgF7OtWN0xzVmlbSRvb04hRLn2ewXK1X7opKP6X8Pls1yrgJ+0PUenns3tQEulfGsyMJUbFfIO6LwAayyxnReB2fTZmlks5/UnWM1TJOo1EVgWvMMSxj3W6ERreEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737780877; c=relaxed/simple;
	bh=6MXNFkWlE+CqNVDZpc+FMxKXvQ//AjMR9QXM0LXw0uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eccImAFot648Io0q9w5ZMA8ktfvrSrZiywNbzh4Pa5lCUxCZcnQwYEYMtJj8A/uUspiN6H9IMYSuWNYLFXXgpniNp/kzH03gWvlKsm+WTqUFE+7fZ4VIpu5ey1fknZu6sQNJWVDRrVHROhxpCHzHGdu/jehKiVjY10bQNLzubPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oYwKszB8; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjKMzX1h/J6QqyDqlo2UnPGH1lQKvhHEvT79nCK0v130LVB/0hGpSYQT4cVJdz11AzCC4Dgq+MlyX/l3Af4CFrjCSFZOjquHafI/aldew9MA1rxocbHGUpcchV6ZB7h53nsLikR5Vkf9YUTqfjJGildbS4y5b+WtzdcgX13J5YcobovmgX5v7HA7JALG3lMvXTO//+qzLrH9cPMkLQfXOSa39+RBjf6do2lbM8xjP77LxcJqGJRHwtysT9T07Z5ABm64HRguPz3rHf3vbNWjiKG12GZ/06/aIeuK4hfgK44ogBfEwqzu6s1Nmx2lhi/o1SEXihtEvYLns58C/HdtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEjJDTfSfsrAjzPGqXBdmD5XZk46nQbBaartazm9X7A=;
 b=Dz6K9IX5PDv6S6qbzWJzbpmyfq6XROR/66VBHY4S1cUVRXkxpPxUXq+Rn6KkGkZHxgbQoBdBu3B+d+R6FIdiICM09i5xzHy+3dXGEr8XsV1MBUijevFH91fyqbB9KJsSvjTPahDxsx8dPBJ971moiNOOEHWEnxODm9JRYDCP2X6KBMSbK/mOGxWbc02bWsPnDhVxd0Opc5PpUDTfqEj25IFR22PeTrAjd0Vzv9X8yphaOMig7HWrkFRmREoLYQ4vtSdiOOZifI57JMnS3B3LmEZjPvxzHGKE2ZgwsfscpeufYFaOxdJDnVFXFqgqsQClQI0OXTezlc+VOO7L6xUCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEjJDTfSfsrAjzPGqXBdmD5XZk46nQbBaartazm9X7A=;
 b=oYwKszB89xPk2UuhoFgM/VOD4EA0iD9yw6+4B1ry08hbZG+db5ZCIMJX/MRn4of7smKqAG2qCqe8Rff89NIhAXY1e7KLne+Dj2BnfOtogQV7nGeiUmIawZThC0gKubKQWndyLwwB+vrQkf08bT3bgM9US0NqXQ2UKYo84ckMkDY4zzkoMzonU/lvzOoPnq7MWPncYIoacUdRJUZBB3GzLenHpFASTzYKp82kG4T9JrHOUWLpIIVO5I212lezmm8xPVfW9lRrUlh1EMl3OeV99trt/AdY6OoyLhw39kXntT31tZpeXlfyEw1yDBz/Jxk3gko9M/b1o/MXC2fmkMdMAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 04:54:32 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%3]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 04:54:31 +0000
Date: Sat, 25 Jan 2025 05:54:23 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.14-fixes] sched_ext:
 selftests/dsp_local_on: Fix sporadic failures
Message-ID: <Z5Ruf3o2f4sC0J5N@gpd3>
References: <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
 <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
 <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
 <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
 <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
 <Z5IOpOD9cs2fLaIg@gpd3>
 <Z5J1Ft2YwSRpedzx@slm.duckdns.org>
 <Z5KOLqwLq96HjkwH@gpd3>
 <Z5LCHVHZPl2fjPyc@gpd3>
 <Z5QNhsWw0P1iPd2q@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5QNhsWw0P1iPd2q@slm.duckdns.org>
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f506079-e05c-49f9-f12e-08dd3cfc5b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iMtnBzNuRXkhPEFDxIiIBhcoa9WHMTWl3BMLF2cPTiLr8eUILuCtuHvDHLv?=
 =?us-ascii?Q?Zc7YjDr4K3NWLQyX19WZnhO/pNk3srm+JjDVpW1s4I/g99kNNgxQZqmBYoHQ?=
 =?us-ascii?Q?EFTFHZRNCn8PNjS30kjyZB1s6ZM3I/2KQTQFphuvW4G2VruSopHZ8z821DML?=
 =?us-ascii?Q?KKEcQoMdt2Y4BjtCIJTb5Tj/qy/edArzTniwm15CNXgtRIlXAGVHZirHg0+P?=
 =?us-ascii?Q?vuyB6hqXPEs18H7wmIYzg8C/KwQJ56ogEgawgqFifXeOUO1duTr2atUGVYJ0?=
 =?us-ascii?Q?xyKQCJ96M60/1x46RNOSIRsORc27qa/rF8pGRuwy6ANYOe1rgSjQzg9OjbI2?=
 =?us-ascii?Q?AsyPVoZa5z4zNAIuW8n1Ds2ernxBPU2uCmjzOPTlhQGdpIYmzhUYyx5huXRg?=
 =?us-ascii?Q?RS7lQGyBkxvmyK4XbaDrik8Pb75gZjOz6p4IRfXccUCkcRncy7UTwopPCLwU?=
 =?us-ascii?Q?NgC//1bKdo5+Bwrus+W9zKYiIPCIcoV4l5FGOJvGDzjbAIVe+6t+546auKOB?=
 =?us-ascii?Q?0sPmf7i5usdvHR7TdFEPh0LTxOdCBEoQK5+B46EPT0fZ1ipAVTH1/k6MJm/k?=
 =?us-ascii?Q?TDAbHbYdeqKllypJwjWaw8q+gH8hWSo2PHqLObRcZSTyUr8eOSbWdDTgJaLB?=
 =?us-ascii?Q?6MChRJSJexho+L39wUTnuFA/K143m49wosmxls3/bgf2AjLFgGMAUgn5fMqv?=
 =?us-ascii?Q?gggu4CYt1TlCbpmqxrygCuNrVfScYKFxSuh5Ktb7WXvTcDdkVvEtEhgYJHCI?=
 =?us-ascii?Q?CrGoVgP4mkx++6RFOsLXZIy5SYcrKuE9ljCoKbzIurQztNl5CyMLNKVHJCcY?=
 =?us-ascii?Q?Oq8V/dTEIbE1e73oHJEYzHTo6r64qlIolRNe+npJAWDKYiuNetTcT1nFDuh2?=
 =?us-ascii?Q?FQ4Ywl5MhaUIuWrapBSV1pFREpndOtc0poDXfynQ/qpx0laULnmqJvd5c6Kt?=
 =?us-ascii?Q?ap+x4xpUwrub9scTKZfrjd6TD5/JPKbzrbprKXjaMAbnHkEx/n3lyNIJPGYG?=
 =?us-ascii?Q?Ie1NUPfjU4tZ32W8VJKwNPIAAQhdsOupYvltDYfG3smfAFcoiMsXiCu2N/h8?=
 =?us-ascii?Q?N7GWIa76Zo3rvF/EDHWKFZPfDne9b6yV6QTsF7YfYa63HbI8NWbvXcHFvOW3?=
 =?us-ascii?Q?ntRwVGsY38JZ035kaZWplzhgBM50QJ8rrPpSnqe6S5MBkntrsTwd8Ez4elSH?=
 =?us-ascii?Q?dKffYIboZbRr66/rVm/So6plHPUVL+5M42wk8pEwxzjEvF9yTbQb8VRHghhY?=
 =?us-ascii?Q?6iOtcoIW+qddtVLAh48wBdhZx3eCA/SahnfNY1u2/bR2afCE41MvRz6b9FLl?=
 =?us-ascii?Q?aGBUkDK1tBThrn81SjZxPY8byih/qBQ9FXWnv29iKoiYg4Gac+CFlJU2X8Vl?=
 =?us-ascii?Q?9VEFYM6UijttymXGOJ3PBjxSl4mW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ABi4UWTh3emL8qii+JiCF6TitPWecSyd5d5FREyrfifxjNSvrwuDAuF50PFt?=
 =?us-ascii?Q?0Hl8pcqJITN3gGbkgYx6VhGLhuU33+jJbhTLCb1ob2laV9HyHonk8kBKJsaZ?=
 =?us-ascii?Q?XG6f2EtWZJBNCuJg9twB3d31dOt6AKtzFm0GjmbS54+ASRn0G6TdT+eElKF3?=
 =?us-ascii?Q?2dTsa8vlGWoDilzRCst5bEiOZCTc6YGAKlRBXj72XJOY6Y1qJy25MEUqosvZ?=
 =?us-ascii?Q?DPpQOQjdpXp2T9IIpr9tEH3E28m41xCtk1jM99xJCK1G4DFkzW2KbXULaQBV?=
 =?us-ascii?Q?X5SLuy5Lq1LltIND/K+7pPo645jGYoHgIGX+LbPmLgsuJ0Ve9Orkiqu7oF1u?=
 =?us-ascii?Q?ffQlhT2BPdHl1EZhjuVN3CxEbk0hNHSV1WYQ79+GhiYVnBMp+C9Ho662/l+R?=
 =?us-ascii?Q?IaOycZMHP/gGsS398unxqPEC2BpjvON+VKo5izHOp9tsHU6YMvJnLqzf903I?=
 =?us-ascii?Q?LPLDBEZOCNT8+99+mCoZirjEIMkYhanbAQff4otG5ORd/coSIVI/M4ZD0w40?=
 =?us-ascii?Q?N42Hn70P32I2Vsuabb6rStAq/awqOdOmXNoYwAa/DmwASZIUrpEeYGh/3Dth?=
 =?us-ascii?Q?pmw35ZYl8EBT4tKjnSWdo7KhFP09+0DrV4FRyxWTKwfT+JKbqtmEnl3d64lN?=
 =?us-ascii?Q?AUe4CWCE1YXyyGM05OvV+w8hL4IaVSalerrLqCUzam7tEBTdHlAwmPfY3l3k?=
 =?us-ascii?Q?JpKWm14hITNCmNq6WDWlPO8bF+ILQNzHXyrsv0XShxmh6kaJR3gPbNKNMib1?=
 =?us-ascii?Q?llc3+cap21TSkjZL3jaUY/8QB3HklWB3LjTAtcCr0pf77sDAcY42YogqPXhL?=
 =?us-ascii?Q?8bSC5ZZCzQDXpHShL7DgRKvu6rscZhC8MAyHxzUtha06MKiWxtxds/rfXoaj?=
 =?us-ascii?Q?6DAxdTjF9LaonbDmK5Z/rQttuNSFweAOP4US4jboejVsgSt8VmMIBx2zhy9O?=
 =?us-ascii?Q?upLV7fq1YUQjknguDRyc3RJ0iYjwsnW4vSTjj2k75ueROgkbEjHHSE7uE7sK?=
 =?us-ascii?Q?48j1lueAzYrf8rCDY18RXGdPd5oWRwMXbFeLNRmuTbU5F+Q0I+fn2jDaCHt9?=
 =?us-ascii?Q?/IxMETgzwfZfF9vAOxQIoIPPsxEkokqfw0SKGdvJaiIy3imgk9Ol2NWDfb/X?=
 =?us-ascii?Q?dNNF5GwufoqGgHlKoG6BzU9IbcZOf6cUjm8a0j+QVu2JEzxja5QA2+UarsWK?=
 =?us-ascii?Q?lCdnM6ih3puDdiJ9xdnyoY3Bz7p+/NafDSVutyw7Z474RU3EOajCKvK/zlD+?=
 =?us-ascii?Q?Qo8Bvu9Ls/OXBvcvMumgxhczE0YS15fq0byfUJt2iEUMwL4IkGX/YX9YYzFi?=
 =?us-ascii?Q?baYkNKKVVn/CHb0MbxKLYngg0ufu87DVDNY2CPvvXTatI/QdL1mx6+K979Bs?=
 =?us-ascii?Q?2h2e9Y5Z1k2/3HWx89Sop1Lof5/vAxIy3jj9RKVlUcfBUiMYd2jIWZEw21qn?=
 =?us-ascii?Q?c/3+bFm2zeRCVyfE9/UI/FaASctJ9QV4bDuoY/JudJjIilvU+oI3njTxEoY2?=
 =?us-ascii?Q?nxOD30AwIdNb23nr4Hzgg3Z8pQ4h0Z7SHY5afMLxQ/9yVIiQtcX8/scBqQJJ?=
 =?us-ascii?Q?zZ8ecYuBLB6rsRABwiUM+gb35gtXQw/ZlqwqmZEY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f506079-e05c-49f9-f12e-08dd3cfc5b52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 04:54:31.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTrs+AzYmJIcRUujOpox1BK27XaTHH6w/cp1CyNljT0qb+48XEZM4tjKVDlyrmFcuEvTBjnh78o3gNUctvkdjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

On Fri, Jan 24, 2025 at 12:00:38PM -1000, Tejun Heo wrote:
> From e9fe182772dcb2630964724fd93e9c90b68ea0fd Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Fri, 24 Jan 2025 10:48:25 -1000
> 
> dsp_local_on has several incorrect assumptions, one of which is that
> p->nr_cpus_allowed always tracks p->cpus_ptr. This is not true when a task
> is scheduled out while migration is disabled - p->cpus_ptr is temporarily
> overridden to the previous CPU while p->nr_cpus_allowed remains unchanged.
> 
> This led to sporadic test faliures when dsp_local_on_dispatch() tries to put
> a migration disabled task to a different CPU. Fix it by keeping the previous
> CPU when migration is disabled.
> 
> There are SCX schedulers that make use of p->nr_cpus_allowed. They should
> also implement explicit handling for p->migration_disabled.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
> Cc: Andrea Righi <arighi@nvidia.com>
> Cc: Changwoo Min <changwoo@igalia.com>
> ---
> Applying to sched_ext/for-6.14-fixes. Thanks.
> 
>  tools/testing/selftests/sched_ext/dsp_local_on.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
> index fbda6bf54671..758b479bd1ee 100644
> --- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
> +++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
> @@ -43,7 +43,7 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
>  	if (!p)
>  		return;
>  
> -	if (p->nr_cpus_allowed == nr_cpus)
> +	if (p->nr_cpus_allowed == nr_cpus && !p->migration_disabled)

This doesn't work with !CONFIG_SMP, maybe we can introduce a helper like:

static bool is_migration_disabled(const struct task_struct *p)
{
	if (bpf_core_field_exists(p->migration_disabled))
		return p->migration_disabled;
	return false;
}

>  		target = bpf_get_prandom_u32() % nr_cpus;
>  	else
>  		target = scx_bpf_task_cpu(p);
> -- 
> 2.48.1
> 

Thanks,
-Andrea

