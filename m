Return-Path: <bpf+bounces-48232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9185EA056CB
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C7E1625E8
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD41F2361;
	Wed,  8 Jan 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LHw19zZt"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35036198A06;
	Wed,  8 Jan 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736328412; cv=fail; b=cT9GLPO8u3t0rcqxcMrA1G42GKmrDx7GFjk2rmXU5MOkSd6zG/25JvXMFpHOxxqft8VmzGBzB9HILo+8jjhP248Fu/cltlBgBkl/vLLrKOKJihpIS2L/Zz6sUcLKgJ0ph4uUPHLBlLl9Su0NMfDRAqbITdyR0mxd1uPPg2ZRpX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736328412; c=relaxed/simple;
	bh=m5GEXclJpWpApP4t0HC1HowuDQdi3L+zezuoSIyuCGo=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZtZMrK8WxymWdpgXv2WO88Na2nDzyVtLxRUFMJlVpZUOQ7y5vgqMrk4mkmXgaaGc52d+dUvqZZUAbJJMCH/j1JlyDN1FWupDY4BCmffxUhvD5OfQcL8VTobVib9GvPQCjNbSpKb/OHU6PI8gUthKID6b2ADqCZSHOPAqXsw2gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LHw19zZt; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2h4GRefs1R9HQrQOD6tUB43WwVomD04cjfZS2dY1Ly6ozIcTPQtk8imtsx/zu09GkC90NpHcs04JgSUz78Ux+d0b2ou43IFc47v4TRv2PFLYG5/e3fTSt0p8pHJWliP/OxvOVUbykpE0OYVxUxsA29yJtpnhjrh++2c4f1mr/muz32cxgz3pVL7ulMTr3I7dVfbjL6o9XZ8NVX0Xl4hw3uGjyOzUleOI7zQvLL8CAVWqZA1K6VHMd7dg9ArV58/q4f40ZkCzkosg1B4CNWC0OAWdQfoLZAtmK+/t3Zv2H8HcuetoP4vZcsk6js8eEKd2bedAls7tP16BpSEb2L9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymBHpg7hqk/ltELJWvb5SZIBAe/p3gbvKltxSYBHr+s=;
 b=lgC4y2nnKh3HytQFpeQOh8iOgwg7VlUTz+YeYO3CG7+oKSAqhcqIwftAQHHMW77W9/sW4IZts6npV2HBkhzcSLaoks3ktyZVTMxkmyBXsqbzw5ut+tyeICMhfnlevTJT/d+hE1HKPI4i+rMMcd/3YbXFFCbX9P3eyadJ4JR381ABEFxalNpWu2ekN3h3I1TRRBlTJPb4IwO4DU1uDPGZ4FvW4g3oxQTieFmuc5zYSMZRWVM8yY0Zz+TUR8n7XPol87OX7pK38dug1d3KJEdBkZZKl78LHqMV0Oy4tSkeKWzGycRPFeviJehffn0HA+R58ichgw6tKSsKJX267braQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymBHpg7hqk/ltELJWvb5SZIBAe/p3gbvKltxSYBHr+s=;
 b=LHw19zZtmHekMGzceoW4nla0UIKWugXNPcjmWAkZQjKEtYGnh/3z89ItFoOBbU8TgwPKJRcxIpqctwEu3oYAVDmss6XIb09VjjuQH17sMTtI9nOOUGCLqSeJw9vlpAsx4oNnTZcoiDnX4/mzI6WqIsJPadZ+Mmkpa82LFb8GWp9eQms7MmpS7i+8z1A4tEB6GGSYI4YiDpLyBwdJXRLgM8E622C7G3Iex4DHWGdHF6ex1hOGyYNG/u/MRL4fXzY7jWNJFX56afZlMjmFwZo7qtSp7dniou1C1cAa+tfjjQONBz6MeKI/qa6gWRB8m3K4kyau9etdVMrWwBq87dZ2Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.20; Wed, 8 Jan
 2025 09:26:46 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 09:26:46 +0000
Message-ID: <733c15e7-2950-4dc7-93c0-11c4eff7ce0b@nvidia.com>
Date: Wed, 8 Jan 2025 11:26:39 +0200
User-Agent: Mozilla Thunderbird
From: Carolina Jubran <cjubran@nvidia.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: Samuel Dobron <sdobron@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
 "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>
Cc: "toke@redhat.com" <toke@redhat.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 Benjamin Poirier <bpoirier@redhat.com>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
 <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com>
 <03c24731-e56f-44b2-b0a3-6afd7f14f77b@redhat.com>
 <CA+h3auPydMVmWRKPKQJ75Gg5c8uhttVik4seCtmPXduQxQSjMQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+h3auPydMVmWRKPKQJ75Gg5c8uhttVik4seCtmPXduQxQSjMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f7e0bc-a75e-48e7-567d-08dd2fc6925e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UktrcFBITEkxaHprV01Sc3hHR1FhNWZobTI0THdjcVdXT1Fqd1U0VXEyc1Ax?=
 =?utf-8?B?OUxJNWxFQWo3Y3I5SmhPS0NMMG1KN244ZUx5MjVMZVJ6dU5HajVEa3d3dWxn?=
 =?utf-8?B?UTdDV2ZuMStYSkkzUjFwUEk0VnZKajB5SjFzd0JpMkRRd1ozc0NVMkRFVXVF?=
 =?utf-8?B?ZjJiOGloZkNmK0JPNUpjODJsL1dxei9wRmovYmVtdkJ4OUxRR0ZrSm1mdjJJ?=
 =?utf-8?B?YUhDWTh2ZGQrRXdxaGk2dnZPUS9NSDB5WDJaN0JwQk1rRHVOZ1JUR0llQ2JP?=
 =?utf-8?B?b2RPQUZWM29HUDFhR2RjSlA2aVZIYlVJb0ErRVljSUxHdElaSWR4c25POWJX?=
 =?utf-8?B?ZHJnTjN4ZUdSbUpFK3ZGVzBZelZoOUFRbG5ZaC8rMEdqcndCQllRYXZOKytl?=
 =?utf-8?B?Qy9zNFZ3QlFNcnFYQ1U2YXJ1NU9FbXRRUlFQVThseXZOLzJqLzEwWno3azdO?=
 =?utf-8?B?c3diczVqR1V3cW1UUVY4U01obzVKVkhldnhBWGlXWVBMV2NycG9PSjJjL1Rz?=
 =?utf-8?B?UTBPRFZkZ1VtWHNlMlBJVGE3cUZGYlFXV1ZaUmF6NXpOUU0vSEV3R3JIa3ZD?=
 =?utf-8?B?RmhNY1hVdXpRM2RYZDc1Y3ZmVTVwZHd2YVRjMWJBM1R1WnMzc0NSY2EwQWpy?=
 =?utf-8?B?MHBUT3M2cXh0WmhCL2RVcHlLYnRMMVhUVFJ6STAzTU91YmdKSWxvMnpzUDR3?=
 =?utf-8?B?WlB5bWljYU9xclc0RFdXWmNlY2tqdmlIQy9Cak5CY2JhZ1M2SmtZakVYMHNY?=
 =?utf-8?B?QWFxWkdIaWgvSUhPWXlycy96VFovL0FEeEdGUHFYb0dqUDVDZkMvN3AxY2xU?=
 =?utf-8?B?SitvcnBoQzNOSkZHMTJITDBxSTgvV3BXcHpnUjN3bi9UQk5CVEJpcEZkVmts?=
 =?utf-8?B?eHRMOFBPUUZlUHhKSEhaYkpLZXBYRzRtVnBvTXU2VzlRVmtzaHNEM1RhcTlm?=
 =?utf-8?B?SmhsK042K3NKY290c3JaTFBzbmUvcEd3Y2dMUDJsa09SQ09uMzFzMVdMU3pi?=
 =?utf-8?B?ejhldEFNZUd5eFB2QUpHZXhtaElWMWxMUml3T0k4NXlwOHBVcjEvblp5RlFl?=
 =?utf-8?B?RU5tc0tRck5xYWZmUGhhMkJvck9uNTNxc0dXMEtNYW5jRGc0aUhtRUJiUU1E?=
 =?utf-8?B?MS82MnRCaklnUlRUcDRPZXJiOFVSZ1VDTU9peS9LUW5HRTN6UDVvejF0S0lR?=
 =?utf-8?B?WDJmWWVlaHJvcmpxU0xNTUxrSVNsL2hKSzFpb1JuYlVpTFN3T0JzWnVCQUVL?=
 =?utf-8?B?QnB2UHc5WGVKSSszbzVMYjErYVFyaUNyV1BaUFdITXBvY3d6WS9pWUJNeWhq?=
 =?utf-8?B?T2JzVGxYQWI0VTJwVU1mL0pZVVQvQkFXK3oxTG9tSXVyYmRVb0RUVmpHUXpY?=
 =?utf-8?B?OGFpNUwxd3JHR041Z3FTbXZqVTl1RTJsc3VoVkFEUWR1dXZHNnQxNXlGOVRl?=
 =?utf-8?B?UzIxL0dLUlBHL3BINmVRL1lORkhtbXowQVhWTzFvMVE4V3M4YWV6c05VTHhN?=
 =?utf-8?B?dWpHS3J1Yks1TThRajBGTmJLTDFJQVdWK2Fqb3VuNWlyUmcrNWdId2RwSCti?=
 =?utf-8?B?YW5jQXAweXJRemFNRmp3N2RUamV5SXluM1Nmak9TNG1jUzRvNjRva1dCTGFk?=
 =?utf-8?B?SGhHRTdjekhxc0RQZGJaZUZKWE8vdXozWisrWXlrRmxDc3RjUWZiUU1HM2pH?=
 =?utf-8?B?WDJBalRocGI2T08xRDJadG55RHdhQWJ0eHNDdWtWVnVYK1hpd2ZBQ3U0R2xk?=
 =?utf-8?B?Znd1QmdKSUVJVkxMMlVYNytWV1pZc3VTUk9scllTeStJMWo2aXg3S2dpaDEz?=
 =?utf-8?B?emRLcmdFRmF0aUtHeml2N29yOVQwWUp5UTBXUU5aNno4Z2Jrdit2eGNOTG52?=
 =?utf-8?Q?vRKxoRB+yZY7r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXRSQU1LTEJwakc0dW93NXNnMm93OFFlbWk5ZW1yclc2Z3hFOXFHa3cwWXZu?=
 =?utf-8?B?Z3pjTW9tdkdNWnBRZzhLUUxQd2ZVNlNDS2x6NHpzRGtRUWV5dWlTZ0RpY0ZK?=
 =?utf-8?B?emxHMVMyL3hDSFBza080N2FBZjVrVzZUaURkaTVzbElYTzhydjdidHJpU2N0?=
 =?utf-8?B?ZW5WcFdrWXBVUVcxSnFHYmkyTEJvSmxQZUpKajBSMmx2bEQydHBNTzYrM21D?=
 =?utf-8?B?Z3Q5bHUrVGZMQXhqRUVlbm9TY2FPZjhtYzFQVnozTE9WM1d4WVhOd1pJczgz?=
 =?utf-8?B?VmZDNFpsTW0xTkYyd25neVdaMjA1YUxCYjlBdlNqblhnbXIyZ05tcjM5WmpK?=
 =?utf-8?B?SGMwVGZNMkRML2ZKekkzejFKS01uS0RaT1pzVm4xR0FFaVY2N1EybVpzZkpP?=
 =?utf-8?B?SkRra0RVRGRyT0VKSzBPOVcrS1Q1SzhHQzFZRkFpVFRCeUZ3ZXpxa2hVblhn?=
 =?utf-8?B?enhrc1FISURCbHlONkltQytaTEtwMWtXYUk4TDIvdGt1cEdTb2ZUVVZFOGdQ?=
 =?utf-8?B?TlpoajVVb2FnaHloNi9oQlZoTlhzcFpTaXgwQ2ZyWlN4TVorQVRQN2FhU3Zo?=
 =?utf-8?B?bUpTZEdQMW5TWDVscEZNTHZvZUpMZG56OFFpSlJTN0hENE5iSm15a0wzUlFV?=
 =?utf-8?B?NEV3TkxqaVNRYm9hTi96ZS9wWldEN1NhTkl1eDVGeC8rbU1Wb3VteUcwUlFI?=
 =?utf-8?B?ZU5ZcVgwZ1RHNmt4VXFhSFZjcU1IaUo0ZVdLenZMWnRHY3Ixc0V6SVZ3YU45?=
 =?utf-8?B?UmE2Z3hoWGRYcVpnMXk5L0I5b2JUT2JJbkRYd2FOai9pYTB5U3lrL0F1KzU0?=
 =?utf-8?B?cHpCcndIM3pja1RwUUk1QnhMTDc0aE1nNHkzeVFuU3VndGd2M0pSKzFYNTNy?=
 =?utf-8?B?TDlyS0dLZFRkN3YySy9UMUQwVDhvS1RLRXBjV2N5RHhycS9makRaSnprd2ZE?=
 =?utf-8?B?K3NMbjh5NG1LaVZUSjRRc3ZBK1pNcWoweTZsOUFKK0F2RXBWSUl5TFAyRDNR?=
 =?utf-8?B?WEtyelc2dE5GOHA1VTBGbzBxemUrall1dzNOV0c5dWUvZnpHM0IvN01SRkU2?=
 =?utf-8?B?eHhHUWlpN3lGUFFxYmI3V2VHSng0WGxIZWxjcFl4SGcxT0FpU1lBVFhLbS83?=
 =?utf-8?B?OGlMV0J2YlhxcVNIMENPZmMwZnR5S1FjQmdReDdtVW1GUEh4YjVrU1ZsTXBP?=
 =?utf-8?B?TGRWOURNamdDYzFsWjVxZlJyS053VUdNZ3dzMkV5VnBoeUF2UjMrRmdJU002?=
 =?utf-8?B?cmhMY2czeXNQTHRrcWFEUHM1eURnQ25qc1dNVjdkYTBDNEgrWExNQWNORDJK?=
 =?utf-8?B?bFgwZUJPK3BuWUFQZG9IcWIxT3hqMytiR0wxaTdHMHdObiswWHMrMG9OajJW?=
 =?utf-8?B?d0xuMHVsaTBlZi8wblQ5eU9ScHRtZHhUbWNWb2xpaXdGdy9tY204T01NQTQ0?=
 =?utf-8?B?NFJOUUdZMzZUcmxLWnQzM1hlU0QrVktEWFNFaGlMVm5ndjVkUnE0cFdaVFc3?=
 =?utf-8?B?WmFnZWFkN2Q2ekpuZmJwRHQyNGZPSldRMU1kRURhdWcvbjRVZXFGWFBtWXlH?=
 =?utf-8?B?U0J3MFNyUUd5M0FyZkJFS3FPUXhEWFd4a0YyQmkrTnhyYThyL2JIREJKL2hU?=
 =?utf-8?B?eDBrZzNidU04cmJnWTcrQXJwRXcyUUJrWU8ySEJ5VVpEcXR0ZmZRMzU4ajRs?=
 =?utf-8?B?MEVqekRabzVUcGRxbXo2NGNYZzRMa2N4N2ZyS2dtQndzS01vWXcybG55L3hy?=
 =?utf-8?B?NEFwbndBT0N5cFhJc0tFVkY2dWFJQ1c0QVJpd1lBNUI0Um5iSG0zYlVoNjFD?=
 =?utf-8?B?anhIbjNJbDJ2RkU1TEduL1ZsUU92bk82c2JWLzZITW9QZWVSV0VXUVprWkgw?=
 =?utf-8?B?R2FvSXMyYlZvZytmSWFmSTh1MFlDaHllZ0dKekZVWVcrbFRqbkpjQTJROXh5?=
 =?utf-8?B?d2orTXRIdEc1SmI4UGhFdm9jZFdielJnVGxaTWpyTDBBSllGczhTYWNiYmNu?=
 =?utf-8?B?V21jSUoyanhuMVB4clNXakFuWW1BQkRWck84cXkvNU9kSGdnbEJzYkpNblNO?=
 =?utf-8?B?bGlYM1lLTlp2THJqSnBYUldIbWQ0Z2ViOTZnOStRRjRPengvYkpjVFhZREp5?=
 =?utf-8?Q?Rkd6SmbA9f8xJot6I6cRUIRwn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f7e0bc-a75e-48e7-567d-08dd2fc6925e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 09:26:46.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLngLPjes86OYlRX6aKWvvJ+Z2GpDyvjusc+Cq94uvvaIhftMjt9B17kuIHqub75LxA3w+v3a4+PtpUmw30NNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

Hello,

Thank you Sam for the detailed information.

I have identified the specific kernel configuration change responsible 
for the degradation between kernel versions 
6.4.0-0.rc6.20230614gitb6dad5178cea.49.eln126 and 
6.4.0-0.rc6.20230616git40f71e7cd3c6.50.eln126. The introduction of the 
CONFIG_INIT_STACK_ALL_ZERO setting in the latter version has led to a 
noticeable performance impact.

I am currently investigating why this change specifically affects mlx5.

Thanks,

Carolina

On 11/12/2024 15:20, Samuel Dobron wrote:
> Hey all,
> 
> We recently enabled tests for XDP TX, so I was able to test
> xdp tx as well.
> 
> XDP_DROP performance regression is the same as I reported
> a while ago. There is about 20% regression in
> kernel-6.4.0-0.rc6.20230616git40f71e7cd3c6.50.eln126 (baseline)
> compared to previous kernel
> kernel-6.4.0-0.rc6.20230614gitb6dad5178cea.49.eln126 (broken).
> We don't see such regression for other drivers.
> 
> The regression was partially fixed somewhere between eln126 and
> kernel-6.10.0-0.rc2.20240606git2df0193e62cf.27.eln137 (partially
> fixed) and the performance since then is -7 to -15% compared to
> baseline. So, nothing new.
> 
> XDP_TX is however, more interesting.
> When comparing baseline with broken kernel there is 20 - 25%
> performance drop (cpu utilizations remains the same) on mlx driver.
> There is also 10% drop on other drivers as well. HOWEVER, it got
> fixed somewhere between broken and partially fixed kernel. On most
> recent kernels, we don't see that regressions on other drivers. But
> 2-10% (depends if using dpa/load-bytes) regression remains on mlx5.
> 
> The numbers look a bit similar to regression with enabled spectre/meltdown
> mitigations but based on my experiments, there is no difference with
> enabled/disabled mitigations.
> 
> Hope this will help,
> Sam.
> 
> On Tue, Jul 30, 2024 at 1:04 PM Samuel Dobron <sdobron@redhat.com> wrote:
>>
>>> Could you try adding the mentioned parameters to your kernel arguments
>>> and check if you still see the degradation?
>>
>> Hey,
>> So i tried multiple kernels around v5.15 as well as couple of previous
>> v6.xx and there is no difference with spectre v2 mitigations enabled
>> or disabled.
>>
>> No difference on other drivers as well.
>>
>>
>> Sam.
>>
> 


