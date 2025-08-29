Return-Path: <bpf+bounces-66977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5DB3B930
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DC5568016
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AE630FC06;
	Fri, 29 Aug 2025 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FiIuGgqK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dQIfCOKm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5830F540;
	Fri, 29 Aug 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464627; cv=fail; b=X8w7chmwTYfkMF5kCBsyqnasPF97MY3X/Kd8dHyjrYwh6P44xwgotjOrkAU7mz6nrwol4CjhkHhFXB6p96lWP5EWHxUb9PHb0hEFCHIp9LK+ZEB2FZz1wjXnDyHoZX/MLMZT0/lFE4EFfOZyxFDA8ZYKfJN7G6WfN4HYU4tKgKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464627; c=relaxed/simple;
	bh=ogl9cmJS/5aywTiPDzvSR+S9BVUTzdTB934Rd/ny/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gTDH+xbxpdn5762zUZx16/m4bcK63V4ASmiTB7D4tEm8aMpySqSudXzRsdFfzSyTuh6IZBQ/Tv5l9ABQQp5n7+NXkU9Lm96oqHgIC+smy30ReQstxkgB4o+kEhDm+5JoJISoPJ+eUDvmwjDcqA7MW9qqFX/LGOX6gVejJxBvJ78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FiIuGgqK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dQIfCOKm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TAYOgL019289;
	Fri, 29 Aug 2025 10:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PwZjRY0N7RbO5txug5BDvq4V7+17nVOXpgEIPd2IHGA=; b=
	FiIuGgqKuke+CgJAoMH6omBgZB1QjQPBeosk9RCWOdiJ3o3RhER+ON5ZKy87K9uE
	HMfm3GMfqfbBotugMepu4BLTJcTutF6EBKZPeRxrg5oVqCRZPqIoM9jcTzPfCoBC
	suhKoYxPFpzQjVGgxOIsf3hv7MGVKoIhD4FAZLBHaQfUiXs24zPP5Q1LrWLwy8QI
	H+T3uu3SheFSJapbKN96g2pfWE+8j1bpOcE/+F31g2lHtl4L7jN63Fjmk60Gnw7P
	O8hv8whE6XhX2eGwiLSbZxJ282xxsHVt+kq3DWKQdbkDVam2LtZXGnFd4CV1TQ0t
	6ynGWh3QZ5Nj2pdfzI5r4w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42ta430-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:49:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T9O5B1005007;
	Fri, 29 Aug 2025 10:49:48 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8d89uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kE2t7w1zbTHGz5VcW1RinHP6MkrCenea0KQcCmsGQICEPAuTnIMe08KOpg18kGA0Fitl64n5J7VpwyUGvrsqHA5GkMCYlzJcS2N0+yHY49Tk+ouT9NEgiAbpIMHofU/8TPV2HOy925VzcQ7E6gtM+UrCvfIbsy0RDxCAgEhAMDYAqA2WKPtOZs7r+o9Buh294j75yL9oA4FC+3yjN+NPnakoTAbud9gyalOyVAYNC4BBfOU6tfZ0VH72I9xTcIvKGHNl6bzQSOlMuMvW0U61s43K/vep/vH8tsdUZVPHW0iAl5P2ft9LrLf0H5DyqOh9IrYj112o/V9tpTnDwbsdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwZjRY0N7RbO5txug5BDvq4V7+17nVOXpgEIPd2IHGA=;
 b=ZvJtS1wxchDezuLCeL6Hsz1k8w7HERGGmdRA9PUvOGUrd8X/IKyc1bk7r5KH7+DiYKbF/kKsKkA3hz8yY4R2BzKpKcv0VmkvsTHRlJ5n0oq5V7wooMng7VvIuvPBgd/vZJNR+rP27fVc6+3bbGj5PgwvQDmSz7nh0079tJ0iUGLlmV8bhPapRGLX8HK0/+Fy/jGhwc+vqclQnImJoHwhpDnxQHE912//jVTALdb4HXBh8+MtII1EqkYzcrZ/kFgTviPfG8k9fUG2PWsZjexy2rlEsJklq6pIqNiOhQqpuuHntGTqnkxgHs8zBC5QLEOE1uq6GECR5VN4Z0R+VhX5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwZjRY0N7RbO5txug5BDvq4V7+17nVOXpgEIPd2IHGA=;
 b=dQIfCOKmIGe7bP1m0auX5O1DTrHcmjNvRNKSaaMDTO16acuC0zT2NV7vXvd4zGiSuv0VfSItPgCsiNHvBsXpaQUGUUNhvK753msCifVPcXh7tjo0i5Ek7QOPuUI1Paws7D7HnJfc6mBZzcu7rspbp6gX6F4jjfCgMLTutBjONdM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW6PR10MB7614.namprd10.prod.outlook.com (2603:10b6:303:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 10:49:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 10:49:44 +0000
Date: Fri, 29 Aug 2025 11:49:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 04/10] bpf: mark vma->vm_mm as trusted
Message-ID: <a4d0857f-1520-49a2-a717-3e74325f2d6f@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-5-laoar.shao@gmail.com>
 <bca7698c-7617-4584-afaa-4c3d2c971a79@lucifer.local>
 <CALOAHbDxxN8CsGwAWQU4XRkG8NvU-chbiDv=oKW0mADSf1vaiQ@mail.gmail.com>
 <b335afe9-be7a-46bb-bf92-37abf806d164@lucifer.local>
 <CALOAHbApv0Sj25La7EQZg7UBxfvkfMXpGPtNrYKABSYpNV6ORA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbApv0Sj25La7EQZg7UBxfvkfMXpGPtNrYKABSYpNV6ORA@mail.gmail.com>
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW6PR10MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e75f317-cbee-45dc-3105-08dde6e9c40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlZBOWcxVUtPS2ZxUTRIWVZ3SmJ5OUEyUXhtYTREWUxjWHlzSFRXUzJtTE43?=
 =?utf-8?B?bGRucXBLaFV6NXVmVytpNDhzNDhSb0FlWTdtZG9xMG83YU5WQWpqV3h3R1ky?=
 =?utf-8?B?RkdaWHJlVW5ZN1FNT3VuYXE4S1MyUXlqenllcmU5ZlZFWDB6NkpaRmY1UTJP?=
 =?utf-8?B?Z0R4SlBISXkyTnZLREZMRm5wVTF3d25mUWV0UDV5WjBCK3l2Q0M1RnYzV2sz?=
 =?utf-8?B?YUM3OE9iZzE4dktjRURtNCs0eGlKNUJGcjd3ZmpXSi9WeFk4RURiTEZ3RVNN?=
 =?utf-8?B?TW5jUU9aYS9uWEhSU2hsU0F6UzJGdkxYN0JJeEhHSENxU2YwRWs3bVFwMVJM?=
 =?utf-8?B?M3NBRDIrNStBZ2p5Ry9VRG0yUS9BaEM3ZUtqWG15Yk5sQlpwb3ZiRkRzbkdV?=
 =?utf-8?B?dVRXTm5rYitFd1QwaW9SRnZEaHhxdy9OSXRuYUpaODV6Z2RWN1pmY1A2Y3RH?=
 =?utf-8?B?M0plSWVPUm42TGhuQWxHTkFlaFo4YnNJYTdOeFZMS3hwT0hzM2pEMXluOFlR?=
 =?utf-8?B?ZUNUdmRjSUZWM2tXMUtpUk9neTFLRm9vRWRkVkI0SGZRajl4eWwzSm1kTFJI?=
 =?utf-8?B?MjdGeWMwR2xpejh2ZVgvcmZTWXdadzdqcWdNU0ZZVTUwaWFKRnRMVFNGZ0hO?=
 =?utf-8?B?QndDeHZNT1pXS21OeEdvb2xxRkpVNWxnWUdpYzBPQVlyRTYvRm1vWThKZTA4?=
 =?utf-8?B?Zlg0c2EzOXl4SjNJSzFzbmQweDVDYjk2QkhQbzJyaTBCa1VsRmI5YWd3SzlL?=
 =?utf-8?B?cjJVbitBVGNXbGFGWmh2MlBMMTVvZnRjcWxydHRPQ0o2c1FJT211cW9IWFIz?=
 =?utf-8?B?eXZVL1kzZGp1djRIVDViYTF5cmplS3B0SEx5WkxqMmt4RlFrc1hxUjZmOTZR?=
 =?utf-8?B?U3huT3FheFJvQmdBbm96NmR4bU9rVHBvL1RjR0k3NGJBSE9MbE5QRXBCc0wy?=
 =?utf-8?B?WlJmMGFkcy9YdFNUUGY2bWJQOGsydXVjMXphRVpGeHhxV1ZkWHh0QXZPVFR3?=
 =?utf-8?B?NnJLNWF5Ukl0L3doQUE0UUZ3bkhJVmczK0svUWgwMW4zY29YN1RBK2d0TjVP?=
 =?utf-8?B?MUMxWDhBTG44ODI0UzBBYUdSQk5Id0lMYmFoLzZUZUxGdjVrNGlOMXk3SXdS?=
 =?utf-8?B?Q2k1UTJ5RTB4RkJRZ1MrTFlMUFRWZmZOR21IcnJiWHRkaUVYbkpiZGJseENp?=
 =?utf-8?B?aEIxODRXNVNDT0MzajV1WFNQV3ZWNkJ2OERnQWJ6VWg4aVNHdGh1b1lyV0k4?=
 =?utf-8?B?ZHFSeGJFdjFjVmtSZnBUYm5oN0RrL05qWU1NUmhMQ1p3NHAwZHROd1ZSNUd2?=
 =?utf-8?B?L3RVVFk5bVpQWEwybm96L2dCZEJmTlpvQzg4am82UFFPOFFHMEVUYWZsSSth?=
 =?utf-8?B?ZFVIaGxTWENOSGFuUjFpM2V5QUpGVDhZa1QraXdqSll0aHNCRzVMVmdwTEl2?=
 =?utf-8?B?QkRMRVA1dld0R0YwR0tnSjNmalhGZ2RTenhNbHZsS1FHbnpNVVdKcU5XZkNs?=
 =?utf-8?B?a1ExNHFzc1o3aktXZjZUNDZoeVFPeFE1Qmo2Yy9LeFM3REJDeExCN01YVzhz?=
 =?utf-8?B?eUVXZlBWY1ZRZVdGWncrRDN3Z04zcDZhWU96T204VmhRM2F5UUhDRzZkVkI0?=
 =?utf-8?B?V3BUV3RIbzc4cXdLNWZlVkhpeis5a1VKbGVCYnhVcHpKT3hqZFFQNTRsL2s0?=
 =?utf-8?B?WEVQZ21XM0pzb0J4Kzl5WDVDMjNlRGFZaVcrT3VvTXAxS0RaMmdHaTZsNndR?=
 =?utf-8?B?L1lqV1FBYk5nN3RNZFlrNzJQbk9CcFllY2FCVGEvOWNKbnl4VGJ6Y2lEdnRE?=
 =?utf-8?B?dVJqbjNUbUhzSVoxSURpOS9ja3J2QyszZmM2SDNJVVRaZUZsUHZjZG5ua0pT?=
 =?utf-8?B?YlZKMndvRGdqc3E5ZXA3UVlkb3N0K3lNT2hJTFZmWGFMRG1GZ0J3c3p3My9n?=
 =?utf-8?Q?/sgRQD9GzvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2ZkM3JHMDlvOURHMjVaMDNBa3ZObU5wNEJWQ2dtUmZvbVVkVjV0U3V3YVZO?=
 =?utf-8?B?a0t0ZXBYLy9FWWdCTDVDN2k2TVZwV0ZhS2QwdE5zU3hTbUtZZkFXbGRpOXpl?=
 =?utf-8?B?bWVTelZycmFIRmtBbGVvK0FJcnA1WkxnOXhmeEpyM0hZZ3NSYXRUMmovcGU1?=
 =?utf-8?B?VTIxZE9BdFNYemp0WUppemlIbmt4K1hMSG9LUTk4ZFdNWDZSOThWMjZ2NG1J?=
 =?utf-8?B?dVZFd1l4UEtMcnE5SmhnVU9SN1lUeWhyczgzbG1tY1hGQk1ZNWdIaVpSS2NV?=
 =?utf-8?B?TVMvVnlDMmd3d05VVWhDdjRmMEd3RW5scFI5Z0ozMDlCMkRmNUp5TFVaTFE2?=
 =?utf-8?B?K05Vc08yOUNWdGhWQ2hmaTU1NWdvdDdIdTZtMkRaYWRCcXRXQzVoV0ovdTBv?=
 =?utf-8?B?OGJiRGVyaTkyWmtDMDVUQ09lZU1wQXRGUnhwUCt4ZzNaNjkxNllFbFFLYWxk?=
 =?utf-8?B?S05URGdyMFNwSHI1ZTlxajJlTHR4alpyVi9BL2t1VkxHclkyblFDTGxZWHQw?=
 =?utf-8?B?OHZlekdmRDlyTXFZODU5b2VuTnZoQThuRWdXSDkwbFZ3dFFiUEtMS2dPNndK?=
 =?utf-8?B?ZzEwMHlQeVdkbVJGbHB4NkcxcTErZ1VkQ3RmM01VQ0haaGZVeGJoeDg3Z21s?=
 =?utf-8?B?WkdDc3E5SVFyS1ZaQTdlUnlCbkdEMlVpRjg4YjdjbWwycnNZZ2hjNml3VmtY?=
 =?utf-8?B?eVVrcDNtM2NScXZOWDhaazJqZ0svZC96THNpNnV3am5xZi9kcm1UNS9WT3h1?=
 =?utf-8?B?U0FKM2pQNVNtYThIK2pCdDhhTG5CbVY5a00xMVEwS2g2dmo0Z1lISFFWOHB2?=
 =?utf-8?B?YzM5eFJlS3BrWFVUdHVOMmpreUhyOTVHTlVIelJhTGxEU1Vwc3M1S0lsUXly?=
 =?utf-8?B?UkJoN3lGMEtwZlE0anBEaHdFM1o4YTlEaEF2Y0V4L0lsRnhSWHNMb3BkNlRx?=
 =?utf-8?B?Mytua1hNeGQwd2tWNk45QnI4bHdZMEdMNE1TNkZ0Y1E3Nys0dkdFdzc3SXRq?=
 =?utf-8?B?a3RRMnFETFhmdDIyOXRKYkNHOVRRTlZyUkQwQXdjbzZuTmlBSzBnMnhUU1FZ?=
 =?utf-8?B?cko0WTJhbWJFTEtFcXRiR0VsWjF4MXFMdG41TXErdFoySHBJbjRubXpvbE5J?=
 =?utf-8?B?VWZUN1JRcXVqSkpVM0hpWCs1Y0ZhV1FOL1dFWWlWMVlMTWxRaVNmMHJsT25R?=
 =?utf-8?B?L1RCWmUxS0Z3RzBvb3Uya2ZQSURLT0VYU0Z2Q0pZMTlJZThTUmZjTlo4RU1i?=
 =?utf-8?B?Tjk3U1BlZE5TRXRKRjcxdWtNSFF1eXJpc1VISUhSZ0NCaUllaXZmRnBwRWdG?=
 =?utf-8?B?K0hBSVAvaElWMDdsa3ZGRHVibjkzTEw2dGhQSVFkckJicHN4UmZOT2VnaFpP?=
 =?utf-8?B?bStSSWp4N3dOVHJweHFOVWZzc0ZTS0FwWlA4Zkp0Y3lyejdFZ1dyaEFYRExv?=
 =?utf-8?B?bXAxekJoeTJxbVc2SWdFVDBRcUh3MS9iaVJEWFJkWmE3RnBMK3RFbVBsdElK?=
 =?utf-8?B?TVBkelEwZVRVc1ZPQ3F6N2dOK2MyNGVpVFYyRGlpMUd5UXJwcXFTRVFCTnVw?=
 =?utf-8?B?Q2ZBRFF2ZnNQVGFpWlFDU092b1ZaWkJoNEVzZURTUHh2ZndXZkxqMnpBdzRG?=
 =?utf-8?B?Q2xickFReCsyQzRvaTJoNzVPVXpLZ2M0Z3FCZmppRXdzZVBIamRmeXFsZDFB?=
 =?utf-8?B?TDVyNnZmZU1aYjJhL2NqUk10c2c3Wkg5cHNtKzN0U2UzbmZKODdGdmExSTdH?=
 =?utf-8?B?K05wUjRqVWN3WHBDL04wbjJWOTg4Tkl4MDFkRzgwQktTcTducXdxclJveEVI?=
 =?utf-8?B?SENVTDJxVUo1NzYzYmdiMzcwRUpkTXJHSnZMT2hVRjJURmpydkp5bFZmWFFl?=
 =?utf-8?B?dlZBcVg2THl3SVphKzBBb3c0dmFlNFJnMkxVV1k0U0p2UjhYZmpnelU4NHFn?=
 =?utf-8?B?SUQ0SXNoOEsvVnZBVFRyb2h6TDRuWTBIOTRCM0R4ZWR4VkxSMW1LdURUUlhj?=
 =?utf-8?B?UlFLVFdlQzZ5MmlkclF3TGNHQXRobjl4TStwVWdyOGVZWTcrVC9ZTjZDRzdY?=
 =?utf-8?B?U3c0bTBzS0hkbXVWblN2VTBwcHoxeURmRE5PeFo2bWdNaDhGbXJsdXRNY1lI?=
 =?utf-8?B?U1RTT2FhQ3RtNG5EZkJXN2kyYWZlRm1udnZ1NHNxQlVFelY1amxSSVZZeFo5?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7aQMVYVdXhv92NmX1yDID9Q4Mr1ObpwNJdjvORozGKguLfrFVOY3A1Geq9I8yX0EEYWKLtHVZZx8n1+QoXeZuqzSdbiyomm1XoAhCgBRRYkEi8/P3pGrGBPitu8cNJreJtv7CN6snWFZVXj3ob+OwWEltXnADCBK/+alLEw7Bi+sZsYstNutU9qBT7tztOXcjgoFO2h1kZygCld2UsFGaklK6DEO1KKkKwo2jzrDeYzVy18ngKeJ7iLL+qf0w8xxTpdrt9AOFW0pR9iHJEsONoFRl4KEzS7aySPi/pfl1MYB2Fb51CtSmZZkbgPvb0msc7LLW55fLOXY2aSUNPPYC/YvcetvjeXGIv0Mez4o3PMbuQ40VcCoFKiveJ3Go2RDI54gQAqTlcYeO2EvZegQiuMSYVomEKyQIfuPsZbVxKmYlie7qHelUR25L8ZnxkK/cLzYp3i++3pJLPvfQWyQUc8eLSF1V53l6dAm3pM98slzHPNsZQLUkvgTddTli/yydUGf8eb8XeHjzXzx6E1uwpSTo3O1jknRKbXgcWKXi3RkqcM/YTzVhEDi+VLoFzSwscMOZ4UYzeXajPHHb2GiCuCdXwG4yy3/wejV4mir7ZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e75f317-cbee-45dc-3105-08dde6e9c40d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:49:44.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TntVHJG8q3/c0mq/vWNX0BL2Hx1NbYz8yEOh3Y5o01qdtIpK83y4WEkLrgvR0sNWyF1HW0AnO89Iyqsour8gtysR9h4PX9OPRj9wzdoAkcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=755 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfXxLehhs/4g7Qd
 K+z6Nb1sgSiN4sgBH0vHWTTuWcU15E2Bj6nL7Ac44udsparUqV0NY6dXvI5QQAU4W4BYWp1bb28
 uLmW4lxNYgfAjnvbFJHm7iie76kquVamx9WvjarXnb8bB9fkFdbr8Vd3VLS3Ijrj/Cpuo/4OjEs
 2L6fKN0PXRSA0hsjoxzj2dWeaUIdnegNHGkWZp6s7qiDXJX80wE6+38bGfjMlIofU4iKRR6nWZG
 v2qfBmnMulgAvXkyPHyI6ZP4Hc2/1GGN2+R64Q7llwnAK+R1S/crD++61a5PJUTIXluUyLBlBf6
 LvFlyQIQi1ZspEcub6HOpvJmQTZ4riwjPqPO/jv/TSXMkFVvv3kO+qKEn6ZihAklu2T1+VoUSz2
 s9hnWIzKKFqeb02o/GnPItm0lDLQoQ==
X-Proofpoint-ORIG-GUID: MPgaWrDT48PKVOlGdkObjA9UCzDR8cnk
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b185cc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GV9Ca0mw7scKYeKYA2QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: MPgaWrDT48PKVOlGdkObjA9UCzDR8cnk

On Fri, Aug 29, 2025 at 11:05:01AM +0800, Yafang Shao wrote:
> On Thu, Aug 28, 2025 at 7:11 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Aug 28, 2025 at 02:12:12PM +0800, Yafang Shao wrote:
> > > On Wed, Aug 27, 2025 at 11:46 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Tue, Aug 26, 2025 at 03:19:42PM +0800, Yafang Shao wrote:
> > > > > Every VMA must have an associated mm_struct, and it is safe to access
> > > >
> > > > Err this isn't true? Pretty sure special VMAs don't have that set.
> > >
> > > I’m not aware of any VMA that doesn’t belong to an mm_struct. If there
> > > is such a case, it would be helpful if you could point it out. In any
> > > case, I’ll remove the VMA-related code in the next version since it’s
> > > unnecessary.
> >
> > If you lok at get_vma_name() in fs/proc/task_mmu.c you'll see:
> >
> >         if (!vma->vm_mm) {
> >                 *name = "[vdso]";
> >                 return;
> >         }
> >
> > So a VDSO will have this condition.
> >
> > I did a quick drgn()/printk() test and didn't see any, but maybe my system - but
> > in any case this appears to be a valid situation that can arise, presumably
> > because it's a VMA somehow shared with multiple mm's or something truly god
> > awful like that :)
>
> Thanks for clarifying that.

No problem! These weird edge cases are... weird and hugely confusing. I should
document some of this somewhere, as it's at the moment more 'oh yeah I
remember...' then having to dig through to figure it out.

The "/dev/zero file-backed but actually anon if MAP_PRIVATE'd" is another fun
unique case.

>
> --
> Regards
> Yafang

