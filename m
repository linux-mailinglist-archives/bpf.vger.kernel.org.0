Return-Path: <bpf+bounces-57051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6CDAA4F7D
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE6B9C000D
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BDD221F1F;
	Wed, 30 Apr 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NXHqMOi7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8281C84DE
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025258; cv=fail; b=aSGw6/BrhpeXIJ0I9AscBdNxBEnypbJxCgDRhrL3iqlDmTvlzPRX8XQlaUpQbumEin9lEF+MzKD021uESOUWgGRBSJtAlupqW0Tq0Se7rvoZ7Pi4ARuZQQsl2N0/kmociTcYuQqjdQ23Vjg0zlof6fepC1ZjMw8Mly6k1/FHfjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025258; c=relaxed/simple;
	bh=G4Blgfbw4SXSKKd96XXXgPP9sLCrGd3CsIZS5d4zCMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0d73J1JKVETW8pw4Xi6KynC3shdXP9VeYGk2lwAcOFE3VigIY9QXb5ZWEDGYQWEW7NAFHqDKLjvWSNieqhByCSmcH833w6EUW/U/6ub0GbRf949R6dn25zJcoq05ZNhYpwDEcG+2arrs+kPGXs3zaOZd/1fkB9f1uRRTGiM01o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NXHqMOi7; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wd80YgGUMFjh4NXwPb5gS9nW8yeUAombuFadS4cfgPwBVtjFFi/DB8QylKvWyRBkKBEorOmN08EAV9Mj2G8CJhw0KGcNsVK4OQECmNCQZR0lOcS5eWu8r/P5XIzThk662ZM2XaUoOlxzj7f0vCyPsl22rARDMobhBD1F0XbrC8sy89ayumahKoh9Ole44qZYD3GVc/85fWsqOn/Eb8OxtXV3iCi1/SHiZDWKhvmpwcJdTcPwFhuYuSbLzZxLDJfS4eKI3DNK0xl4INkgJe3+K8BPlQ2Nm966XNoL9G3iPoLe9mhBO1zeFptKzKyFSmkN53okZldvYRm1LSwBiMEQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDTrd1p7P6iapCIJ2s9A3EG8Ef5+c9706KlQDpnESk4=;
 b=QOzcN+jLaRFgl8bMmxKq9s5QZCn4/je/PCln9yA3CHTJdLI/1UNP4crjTqaAEZBvjUdwoKAFfVcX4Vor+ZCBZNIhYc1UXcN0y/Tx4p1jMkTMcaPASxN1F/VDfR+8LAPSAwgbbGNHS60hqCse+a+sVUnIr2OZ5FXb+LsIh4CnjjEStZ82Vw1IujO1KkIIDORNbGN5dzEcsYP80/beCzHzIooDLjfGOBBblof1snNgCeIrve7ZvtNV15vJT3UsoQcw88BBT+Gi5K5gTUOj6ko1ShBl/B0HxXMBYwmeL0316atT9FjK2JZckuVA10u//sdNJG2dm0hRC2stoLJuWsrCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDTrd1p7P6iapCIJ2s9A3EG8Ef5+c9706KlQDpnESk4=;
 b=NXHqMOi7uPsalS5hNmtby/OAD0fZBbMAULEng0zz4WWXVAVuC67fBc+1xNXjewAozTUthrHc4byxK5rwnl+ZWRfMheBT7bdp88rdSjfxY6QJD8Swuu8sM/2F8mC7iO1QluPIUgnv/jeo5r5hofbinxc7C08olKgq3WRpTSoGh/BW49UPED+8NajUUaoCILVspWeOUB3eM4rNcDGZUWQ96dzSltkmtm6SJkMRjVufU7dJ2jKkTPxNsKrHh6iiARCzZ3DBhaJygMdqq5lehPq5a+xocdNbQQ6dd4dJlGYcAjfaXvMSbCM6UyhwxS3+esttzRiiXjYK1aHYqAbQayLhkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 15:00:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 15:00:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 bpf@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Date: Wed, 30 Apr 2025 11:00:49 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
In-Reply-To: <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:408:f6::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: ec616a99-2116-4f35-4758-08dd87f7cc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVVuZW1XeHpXMmkwR0l4ekdheEs2RzRzeFRhSjhRREIzR0JJdmFmUXdCQ2I5?=
 =?utf-8?B?b1ZST2M3NFhyVm43NWtTdDJUa2llVm1uNWVpbFU4VHM5NlAvSkpncUlXWUZN?=
 =?utf-8?B?R0NRL2FQR2V3WXZKaklxMGxWc1RNOVdpVi9ySnlPbnNLYU5xU0tkeHVnWVow?=
 =?utf-8?B?Wjk2dkdIL24wbVdxNnZDdlJEUXhnUWMwVS9ML0xIb3VkRmljZk1Va3VaSlhC?=
 =?utf-8?B?ckk3SUt4MFRzRHU3bFJHRlYvbWlCVE5TaUNCNGJTZkJCMGJFdFVYbzM1RmVx?=
 =?utf-8?B?azIwbVNCVk9nSWNPeS9iNEhseGJPcWlxdGZIMHlHYzBjS0NDLzRBZUxGT0dr?=
 =?utf-8?B?cXd0amt5YmZVNEVybDVYRmNNSjZNQ0VuZTN4M2tma3VWaGQvUnErN0ZhNHo4?=
 =?utf-8?B?aXh1dWZTZFkzWDM5VHRUY1Q0dmVrWGMzUHNUN1dRYldZYzBrSWtXdWNSSTFl?=
 =?utf-8?B?V3JwK0Y2N0tqclU4T1hYaXZsc0U3RFc5SGZtOHhrV3dtaTREWWJMeGNJUWsr?=
 =?utf-8?B?WmNPK3UyMlE5N2toa3I0YU1uYWVVWXMwaVIvSUtZdzNkeDhLMitQdnJqZExE?=
 =?utf-8?B?ZEloZ01BZDgwSVY3MWloSmp2YUZ6ZjVRSHFDUnoxS3Vnb29ibTRaN3NqbUIz?=
 =?utf-8?B?L2p5R0Q0V0FyRHpSRDRlSk1LTHRlYUp5ZU93d0krQk93elgvWHJWVWlMaTFI?=
 =?utf-8?B?eEtTNUppNGs3WnhiVGtKR3RDMG1tQjdaSWlRNFRBcmthWjRNVzJkNk1CRUtD?=
 =?utf-8?B?Qjl6em1WV2JvSWFTbWhXRnFrQWw1UE1JVWNEeGhLQm1nZU1CWjhBd3lnM1Bx?=
 =?utf-8?B?YXorWHpEZC90QXN1WGpyMkpZaGlEbmtNcXNFOXY5SFpBOGZxWENMMW5iQXJU?=
 =?utf-8?B?S2pWYmNwUDlnb2pVMDlnK1lhRVJTZlBJTGFCdDZtd0NIOWkxcFpVSG9SZENy?=
 =?utf-8?B?Q2RJUjF1ZUM2Q1RqN3NzcWQwdDBlK01OT3ZUbHpkYlNvaFNBMUIvaHAzK3E2?=
 =?utf-8?B?cmtCdWJ0N1RxWUNzaTBPZlNScVowQUs0MkxTQlo5cjg1YVlCcEN6UkF3RmtL?=
 =?utf-8?B?dHFUSEpmUGhrVkZmejdGN0p0Rk9WaGZqcXhCOXJ4S1FlQmFMdHo3UEs0UDdJ?=
 =?utf-8?B?SWRyYk1udkJ4VmRzOEdVbFBBRFBpSWFNeFBCQnBobkdxN0RNWU9TLzVBbFdJ?=
 =?utf-8?B?aE1ydTZZSnhtNStjZE1LQnhnV2FMTDY1MUdBMmhxeDVHT0JPQUt1d215NjY4?=
 =?utf-8?B?VDhoMHhWK1pjUEI1aW5QSEhsd1lPUTFSeEhFK21MRUpmODJjeWhkcnF1N2VP?=
 =?utf-8?B?RTEyWEZSMVhob1k4d09lUjBUbGtsME1EeXNiSEhyV2M3Zmo3TUFOeDdSSjVs?=
 =?utf-8?B?N09Rb3NjUlBib0VJK25DVGtJdWZVek5NdlcrUzlNemRLSG9UR1FqYkI0WXZ1?=
 =?utf-8?B?dk5rU2FlSWhRMWcwWUFYaVo5djN1aTZhamlFdXpjZVBLY3hWMHJiWlBVVmIx?=
 =?utf-8?B?aHo2bkljcC9nelNBTTh6WXBzWGRqUDFjN1hkYlRNNHpFcDhHV0RtQVJ5M1RL?=
 =?utf-8?B?RTN5d1F0TUcyYkRkenk4b3pJajc5WWpWTVVHNUU3SzB1NEdtenF0WmdGN3Zw?=
 =?utf-8?B?TWU0bzRSMzZVLzU1NWRKaC9ORGc4Q0l6RDZuR0E4cCtTZ095VXp5TzNURXJD?=
 =?utf-8?B?ajA2U09qOGJ1THF3bk42bHBHMDZlOVQ1WGtnLzIwdkF4SWFWUlcxQzJMSkZO?=
 =?utf-8?B?WFdZRXJPUStvS2pJVnFmbW55OFM0NVdld1hQODVHZlM1YldmMXk4Ujc3Z2lB?=
 =?utf-8?B?WkZFQm1CQndSUGEyUExncTBiYlFibmJXQ1R3aU9KaWFMK2cyYWl2Mkl5Sks2?=
 =?utf-8?B?THZKc3FDVUp5M2xyUmRJV3o1b1pvWXJWNkdzenRNYTJhdHZETHdtd3R6bzRn?=
 =?utf-8?Q?x8hqkRVKSH4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YURiUE04dnpFTTZ6YzNObERTbXhxSUdJZE5La01zTk93N3Z2WVBKT2s3bVFU?=
 =?utf-8?B?SUROUXJHKytmVStpMTFkcjd4OXBSY1JPME5UVEQ1aTU4RW1vTExmOTludUZx?=
 =?utf-8?B?Nlh2M0NyZXBuN3lTWVcyQUtiNFFDYWVpYWN0VWpYWnNhZk9waFluQ3YzbUY0?=
 =?utf-8?B?b1NMQ2NxYkZ3WUhWS0lGMVBkN1FnM1RtZ3ViQllBZHJuNUR3bmpweWtzV0d3?=
 =?utf-8?B?U0NoeGk2bW5lTURwUjhJRkZiZWxxUXFJMEE3RVhxQ2dsNzdXY09heVNUVjJk?=
 =?utf-8?B?bDJKVG9xME5zMFhod2ZGZkprSVk1RTdxWC9nQXVoRm8wUi9idjRRd2k4Y25S?=
 =?utf-8?B?TVlLcm9ibE1wNXhYZG9sRXJyUHZOb1F1YVBmc1d4b1FsTlpzV1pjalBpUW8r?=
 =?utf-8?B?SFJnZ1VZR09BcEl2WjJFUmcrbDBpNTlPSWZiYW9Ca1dHZVc5U1pJL2Z0M29l?=
 =?utf-8?B?ZVdDUm9nV3FVNzNYb1FvNngyNHEyczI5Tjk3ZjEvNStCTHlEZUtPM3ZTTzV0?=
 =?utf-8?B?cTI2Y21LY1FYbnZFZkdLdkF4MzFGbWUwdk5GK2pVK0gxZjZEVGh3R3I4eWtk?=
 =?utf-8?B?TE82eTcvNU9vSFA2WWo1NVNOTkpsb3hOOXdUL29Jc25idWo4UzRNaDh3a2Jy?=
 =?utf-8?B?djFqUnlKcWczZ2xoZm5TcittMjBVaEJ2djdTVXh6VzBKeHNpeHVybkRkc0hl?=
 =?utf-8?B?aERvRW5BTnJzUlZQMEFhNzU3aHFMWWd5bXltc3pDMkx5a1lqVXEyd1hETDd3?=
 =?utf-8?B?U0RTZUpCNklLRWRVN3o2NTl5WkRDMFVPK3hwNm1tY010bjluYVBGQ0k2dlZ5?=
 =?utf-8?B?eW9yTy80WUc3T1ArZjZzSE9ycHpyRFdqSUNPbWtrMG1UdHY5UitoMG9yQWtK?=
 =?utf-8?B?V2dhWUR3VGtOQk45YVlNOTBzbUZvcFQxVlRsSmxYdHJzZW5OdTJxVGtNZDVZ?=
 =?utf-8?B?MDZGeVNENGJQZTJlQ0tEc2hzSWNrbW5oMjFzUUZrR0x1VElxeW41UVEwU2l2?=
 =?utf-8?B?ejNlOS92UW8zRUVubk1hb0xOYnNRSHEyYVRWSTloaUNLclNJUWo5MkxPa3JB?=
 =?utf-8?B?RFFNMVQ4Y1NwWGROOE94enlZSHZPRFJZZzZYNXp1Nkd2dThHODdBMHFTYWl2?=
 =?utf-8?B?NzNaOC9kbVNQaVZCRzMxRGluQmY4WVdZaDcvSThHM01QcFRDR1hBTTd4ZEtI?=
 =?utf-8?B?MGdZcVlIWldWNEtFeHdIZmN2QkZsY2lKSFdkc3BLNk1qVlRLQzZmZlhSRE9Q?=
 =?utf-8?B?bkVtaE1qTWh1NTd5NmQ2T01md2NFczM0NTdkWjU2RU5YSHY3TGx2ZEx3YWt3?=
 =?utf-8?B?UXVqNW1Jb01hdUh6ZjU5R3JTdlc0ZmhMenNrdk55YUVBTTNHYmQyM3VFNHRM?=
 =?utf-8?B?blFhY1daSDFmMW1Ga3dVU2p4cXZsN0xIOHk0WEtIZ21tRVhVRHV6RnU1Mmg3?=
 =?utf-8?B?Y1ZIVU5YM2NiNFNwMmdCS0RDSHRxV0VURHI0eFdnVTBvdzQxemZzV2h0amta?=
 =?utf-8?B?dzZlMmlobjlrYVI2L3E1c3ZRckR5Q1RQc21KeW52M0U1VmxIb3dRUDRkU3pR?=
 =?utf-8?B?dStlL2hHZUxjSFNlYnlCU3EvWFJhSXNwbTVaMGk5MTF6VThHM1pUcFgyMlox?=
 =?utf-8?B?MVdFYm8zaVpQVFgyUk1WQXJHUjMyRUVxSC9LTDBwWnVrMndONmFjTS9Ycm1X?=
 =?utf-8?B?MkxuTFFscjdXUHNnUDk4RkdEV2NsbENPcFFQYmJnN3Y1YXFIWnBlNThMS25G?=
 =?utf-8?B?dGpCTCtzQzVYcDZ0MjNqOW5NdVRNTmNLN05ENTBUL3B2YWpOaTdOZms0OUE5?=
 =?utf-8?B?U1hIblZxTmhVTzRDbERTOUhiQ0JqOVYydmg1bnhOTmM1RkJjbmxNSk9sdjZ1?=
 =?utf-8?B?cUo4cS91NUp2NUo3cDN5emN6QjNEL0J1b3BuVlptcWtRRHlLYVZ0ZXZvVVBl?=
 =?utf-8?B?TnppYTNlRmN2cDJtaHFGbTd5SlFiWHE5aTNYRHJoeHE3K2ZBNW1qK2lSeEhi?=
 =?utf-8?B?cEZUbEhoTnFlSzd4Yi9hcHRaMGJwbXJhMnRod013bzBsY2JpelFFbjVKMGFz?=
 =?utf-8?B?Z3QvWk1rMVVNOXlYRlh4UW1hWk9uRlFGNnJDL0ZKUG5EK09Ob21xQmdjeVdE?=
 =?utf-8?Q?PbbOFkZNl/OvZFMweg83ZMoVG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec616a99-2116-4f35-4758-08dd87f7cc6f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:00:51.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNNFTG27BEnkhu//LDvqfe86+tFPfRkqnUetJT8LFKdUMcMcuaJonGW8YyLtw6QK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

On 30 Apr 2025, at 10:38, Yafang Shao wrote:

> On Wed, Apr 30, 2025 at 9:19=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 29 Apr 2025, at 22:33, Yafang Shao wrote:
>>
>>> On Tue, Apr 29, 2025 at 11:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> Hi Yafang,
>>>>
>>>> We recently added a new THP entry in MAINTAINERS file[1], do you mind =
ccing
>>>> people there in your next version? (I added them here)
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/M=
AINTAINERS?h=3Dmm-everything#n15589
>>>
>>> Thanks for your reminder.
>>> I will add the maintainers and reviewers in the next version.
>>>
>>>>
>>>> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
>>>>> In our container environment, we aim to enable THP selectively=E2=80=
=94allowing
>>>>> specific services to use it while restricting others. This approach i=
s
>>>>> driven by the following considerations:
>>>>>
>>>>> 1. Memory Fragmentation
>>>>>    THP can lead to increased memory fragmentation, so we want to limi=
t its
>>>>>    use across services.
>>>>> 2. Performance Impact
>>>>>    Some services see no benefit from THP, making its usage unnecessar=
y.
>>>>> 3. Performance Gains
>>>>>    Certain workloads, such as machine learning services, experience
>>>>>    significant performance improvements with THP, so we enable it for=
 them
>>>>>    specifically.
>>>>>
>>>>> Since multiple services run on a single host in a containerized envir=
onment,
>>>>> enabling THP globally is not ideal. Previously, we set THP to madvise=
,
>>>>> allowing selected services to opt in via MADV_HUGEPAGE. However, this
>>>>> approach had limitation:
>>>>>
>>>>> - Some services inadvertently used madvise(MADV_HUGEPAGE) through
>>>>>   third-party libraries, bypassing our restrictions.
>>>>
>>>> Basically, you want more precise control of THP enablement and the
>>>> ability of overriding madvise() from userspace.
>>>>
>>>> In terms of overriding madvise(), do you have any concrete example of
>>>> these third-party libraries? madvise() users are supposed to know what
>>>> they are doing, so I wonder why they are causing trouble in your
>>>> environment.
>>>
>>> To my knowledge, jemalloc [0] supports THP.
>>> Applications using jemalloc typically rely on its default
>>> configurations rather than explicitly enabling or disabling THP. If
>>> the system is configured with THP=3Dmadvise, these applications may
>>> automatically leverage THP where appropriate
>>>
>>> [0]. https://github.com/jemalloc/jemalloc
>>
>> It sounds like a userspace issue. For jemalloc, if applications require
>> it, can't you replace the jemalloc with a one compiled with --disable-th=
p
>> to work around the issue?
>
> That=E2=80=99s not the issue this patchset is trying to address or work
> around. I believe we should focus on the actual problem it's meant to
> solve.
>
> By the way, you might not raise this question if you were managing a
> large fleet of servers. We're a platform provider, but we don=E2=80=99t
> maintain all the packages ourselves. Users make their own choices
> based on their specific requirements. It's not a feasible solution for
> us to develop and maintain every package.

Basically, user wants to use THP, but as a service provider, you think
differently, so want to override userspace choice. Am I getting it right?

>
>>
>>>
>>>>
>>>>>
>>>>> To address this issue, we initially hooked the __x64_sys_madvise() sy=
scall,
>>>>> which is error-injectable, to blacklist unwanted services. While this
>>>>> worked, it was error-prone and ineffective for services needing alway=
s mode,
>>>>> as modifying their code to use madvise was impractical.
>>>>>
>>>>> To achieve finer-grained control, we introduced an fmod_ret-based sol=
ution.
>>>>> Now, we dynamically adjust THP settings per service by hooking
>>>>> hugepage_global_{enabled,always}() via BPF. This allows us to set THP=
 to
>>>>> enable or disable on a per-service basis without global impact.
>>>>
>>>> hugepage_global_*() are whole system knobs. How did you use it to
>>>> achieve per-service control? In terms of per-service, does it mean
>>>> you need per-memcg group (I assume each service has its own memcg) THP
>>>> configuration?
>>>
>>> With this new BPF hook, we can manage THP behavior either per-service
>>> or per-memory.
>>> In our use case, we=E2=80=99ve chosen memcg-based control for finer-gra=
ined
>>> management. Below is a simplified example of our implementation:
>>>
>>> struct{
>>>         __uint(type, BPF_MAP_TYPE_HASH);
>>>         __uint(max_entries, 4096);      /* usually there won't too
>>> many cgroups */
>>>         __type(key, u64);
>>>         __type(value, u32);
>>>         __uint(map_flags, BPF_F_NO_PREALLOC);
>>> } thp_whitelist SEC(".maps");
>>>
>>> SEC("fmod_ret/mm_bpf_thp_vma_allowable")
>>> int BPF_PROG(thp_vma_allowable, struct vm_area_struct *vma)
>>> {
>>>         struct cgroup_subsys_state *css;
>>>         struct css_set *cgroups;
>>>         struct mm_struct *mm;
>>>         struct cgroup *cgroup;
>>>         struct cgroup *parent;
>>>         struct task_struct *p;
>>>         u64 cgrp_id;
>>>
>>>         if (!vma)
>>>                 return 0;
>>>
>>>         mm =3D vma->vm_mm;
>>>         if (!mm)
>>>                 return 0;
>>>
>>>         p =3D mm->owner;
>>>         cgroups =3D p->cgroups;
>>>         cgroup =3D cgroups->subsys[memory_cgrp_id]->cgroup;
>>>         cgrp_id =3D cgroup->kn->id;
>>>
>>>         /* Allow the tasks in the thp_whiltelist to use THP. */
>>>         if (bpf_map_lookup_elem(&thp_whitelist, &cgrp_id))
>>>             return 1;
>>>         return 0;
>>> }
>>>
>>> I chose not to include this in the self-tests to avoid the complexity
>>> of setting up cgroups for testing purposes. However, in patch #4 of
>>> this series, I've included a simpler example demonstrating task-level
>>> control.
>>
>> For task-level control, why not using prctl(PR_SET_THP_DISABLE)?
>
> You=E2=80=99ll need to modify the user-space code=E2=80=94and again, this=
 likely
> wouldn=E2=80=99t be a concern if you were managing a large fleet of serve=
rs.
>
>>
>>> For service-level control, we could potentially utilize BPF task local
>>> storage as an alternative approach.
>>
>> +cgroup people
>>
>> For service-level control, there was a proposal of adding cgroup based
>> THP control[1]. You might need a strong use case to convince people.
>>
>> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.a=
sier@huawei-partners.com/
>
> Thanks for the reference. I've reviewed the related discussion, and if
> I understand correctly, the proposal was rejected by the maintainers.

I wonder why your approach is better than the cgroup based THP control prop=
osal.

--
Best Regards,
Yan, Zi

