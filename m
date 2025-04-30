Return-Path: <bpf+bounces-57078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6853FAA533C
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 20:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212971B64E93
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C426A1D9;
	Wed, 30 Apr 2025 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OiEFfXNX"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5326561C
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035628; cv=fail; b=KcGAxgI5PRm18OizJFYAJjcec745/njNUgaopKXuxl77eGSZGj8ZolrWY/+ZB4ESanbj2WlSQjmR13sU+HfyyHt0jzEYaWS3wGMn4dK1jNW2V2UaB3JTanq2X+e9NMpPWnBParb8ZLFlkur/X7zUwFYibN2gmUS2wzfzBwX7A5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035628; c=relaxed/simple;
	bh=DOTj24DhWT0o0TV7+37pIPM9a/+i0HagmGIya92i8/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIQSAuf/p06Vy/p4zsRWbNYzjU8tssSIgpBDOMBgOB67e9w1ccoAIjvxC7/s5sjVJm2Yki3TxkNSPF4GdKBe6Esso0sU8PDXL2YoLTgZVzMMNHFGAKDSDYroLjs+5SnlaAsTJrcBGvxQUkfXVdrTXbVXYuaMzgEkhHOPtTa9NSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OiEFfXNX; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWDCEWi859nYozxs5Oy7/gZpCAqSakZspRRWMpJrval7m5Zz07Bvsl2kL3jrhs677rWwVlX+RfXtzfxPDN5tsf06NYKL+VPpXLE6BLnmxDgtsEkxgyt8OY1mcfDtlLRKeabzmFERfOscTU/v2kv6Z4VYh+LRgR/DgoBjvsQn52CoxJRWrrQ2Andx8zMHvqcmaOF+JKTM+imkBojFZWy9A7+Gahb6PJmCJciQ3tPbzxyRB3ung8RL0PgyPybhH+iqVKZGlItEu99Nu3LN9bIDbRUpZ0obhNMWk6DUBOs9C1CDQU8eqmq2Rp2CfI2mqsxrIvGcTseBo2Cin8l4h9GAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEmaVRmGRZ07t9v4TlbxtWJv8L7rxlvX77thCqaP5mA=;
 b=JcPh7TN4TV0P016TbkWSNvWuv3hHmBWV2lDkbkUw0zgEzlJFLcud2kdzfI1zlm8hRHzrQQ6R6BLFdkNSloxgm6yGa8OZKJbECyM0iGw8WngkidzGNTWDuwQyiqCCt7Dp8S40EGF5OcsuIz2VqgI3dwIjLekvhmX8Nv56Ih9t8LWsbMHj+kFUaKezCGFdchmzRiCpQroWEI2qInp9pvUh+Lj919QGGW/+LhBievYKlpKFpy9nLYlF6tImYQIk9ENKk93ipGPRiGgPXTbzRnws7T9DcNW0li65gDDVXsR8eWCc9lrpMZgixX/6enF1j/TsriTBRC3ZEX7QWZ1ayvsYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEmaVRmGRZ07t9v4TlbxtWJv8L7rxlvX77thCqaP5mA=;
 b=OiEFfXNXx03GjAF7OzAU4jZEc2yl+H4h0y63t2u9cIlIwOZA4MgUxzU5bSzIcgaj872nDrgB3ELEPvR6dJAfPqI83I26TmNIItD6PPFQTpeVfk+M1A5Ig4uthHvc0icW420c8zlpY4AtED/f5+G8b85EaDiJ+CkmxaIIuvi6YIfGvLKY1f7Ma4SOYuTHl1M2SINUdcuOjF9xby4s0gN6WqMbBUaAoQVSi9KkoAoskYKRXC79aus87aaWCwiiKCpz98XMAjtIiBh7SxNeqe9isKYnTvWLzbyYtwsHlkDP2waD+Lku433UT3U5EO7ZaepKlZ6EGnIUP0j7yjHqjKzj+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 17:53:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 17:53:43 +0000
From: Zi Yan <ziy@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 bpf@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Date: Wed, 30 Apr 2025 13:53:41 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <84DE7C0C-DA49-4E4F-9F66-E07567665A53@nvidia.com>
In-Reply-To: <20250430174521.GC2020@cmpxchg.org>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
 <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
 <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
 <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
 <20250430174521.GC2020@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 43983393-8d91-4063-8c6d-08dd880ff2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1J4aXQyT1RTWlFiUU1OY2lzMWFmYU1MdTBFUzFoTStWTXFtMkFNSlc0SUJi?=
 =?utf-8?B?VGZHTEJYUjllTzFqam5sNzZTVkFHN0wyeHZySm5xOXFoTUwwekkzK3pWM0dx?=
 =?utf-8?B?alFzSkFoNGRxSHNGL05EeTFuQkp5Qk85dWZnNDh5WWx0VHh2M1kzdVV5bUZm?=
 =?utf-8?B?RHc3Nmp2dHcxbUErOTlXVXZpT1BvampXNSsxY0M0RGhUb3UwN3ZBVjVSQUZq?=
 =?utf-8?B?OEQrNHl6aWdDQ0p4QU1kOXR1NFVGSDZvZFNDYkFiQVo0L3pmT3NPK2tyZU5w?=
 =?utf-8?B?ZlZHVU9IbDVmVlpSd1grblRpcGNQVnBRRSsyTDJFMmxUTUxMdkhOZzF4YkZQ?=
 =?utf-8?B?ODNMcVRDZGhBYkVUb1MyMWhOVTBxS0pNODVOMFFVcHU5RHZ3L1NYVE1xM3Ra?=
 =?utf-8?B?aWJROHpKR2RUV3R5YlNSMWJHZEJ2ekdEcXZKaG1DdjU2RWNTQUJjYk9sNUxq?=
 =?utf-8?B?YjVxd0ZDSVVhU3dDcGNHaWNOZjVRN0c3T25hNWl4OXpoek9XN1N3L1JFOTZN?=
 =?utf-8?B?cEJjWnV4cVZHVmhSWjZCV1BHRjFjSTduRXJIZGhtVXNCZW1OeE55L1BkMEpk?=
 =?utf-8?B?eGhzTEdwMnc0RU55V3ZGL1FKS21iaWxuUVJuckFuSFExQndxdFN0UFlpUWV0?=
 =?utf-8?B?cmZ0VjBWVVBxN01jUDRGMVk3S0lRR1haL2gzK3QreitHR3RNSG85OEs0TzhG?=
 =?utf-8?B?NjBGbWNnT0lEYVZUM3NBWGUvYzhVbjBydTRIR0tYZlRuNmp2MVQ0RDNPVnBr?=
 =?utf-8?B?UU40Q2diRUVtamU0ZjNYV1ZvaUE5Vnk5ZjNrOTJjMUVtYnlVRUQwNGQ3VGxj?=
 =?utf-8?B?eStKRGV6WkQ2Q0puWEFtSTNuNmFZWStFSTZTSHRzK05CODJ5TWZrOXJ4SFcw?=
 =?utf-8?B?a0hPRjh1MWFQNGxPSy9xSnVZTU5zb1N5ZTEyQjVlbEZBRGJ2a0htOUlNMmIr?=
 =?utf-8?B?UE1kTEtmRmpHRiswcDdNa2tIbGhMK01VTGhvc2dKR3lqbDdZOUJSVnFmT2My?=
 =?utf-8?B?WUR4UmxqNUZ3V3RsU1FncFlEYjRxVVN5RkJpWnNYUUJYd3BVU21IZzJOQ1k4?=
 =?utf-8?B?K0V0TUpMLzU0MDAyVXVwbElQdDVqcFBzUE1LZGxtNUdWR2RQV1g1aGZrdUJC?=
 =?utf-8?B?VEpVM0w0eUhCd2ppenlhYVRmM1ZnQTYrSUJKNW1KTEpoc3I2Y0F3LzA3WlFD?=
 =?utf-8?B?M2JNYXpFbjliYU85YnRlZUlmZnIwRng5QkM4dlN4SjNINXVielkyS2gvWE1p?=
 =?utf-8?B?RVBwQVhpOVdMdlFpeWFEWGc5K05KamFpUHdKUXU1ZytqZ213bEtGTzZUREhQ?=
 =?utf-8?B?eUlXT0gySlQxMFNCVmppd2xabUplZHgyTEcvWHBVSWhqL3ZMTEdaazJYOHZx?=
 =?utf-8?B?a3IwVXVYMkc3Uk9wZjRvOThWb21sSzkvVVM3eXlidGVIb05ZTlJEejMzN2Yr?=
 =?utf-8?B?Kzl4UEh6UjFFYUdtczJtdXRHS0FFa0dOKzJkZVNNMHNrTGJ6WmZnbFdkOHcx?=
 =?utf-8?B?emd5MVRrbjlmYXh5SmIwM25ob3JFbTN1ZitVVnRUME54alpBUVZMeGJ6U2Fx?=
 =?utf-8?B?Z0ZMVU5lSTFwZ1Z1TFNUdVhDcU9GR0hoWlg5TTBhL3VEOC85WllkMmN0WUxj?=
 =?utf-8?B?Z3ZwQlVxUGlQWTluNHRVaTZ6bzFkU1JnL0gyWmVMMmRWWklvQ1dGVVVrMUlD?=
 =?utf-8?B?UUk1VXpicW9IQ0VoeDRTUXRxdFVWQUhMRjA5b2xIRHdzbHBDUkZzN0ViSnp0?=
 =?utf-8?B?MWRYbjNsK2xJVDlvbEgycStlaElIYjdrYlE2TWx2MjVnNnEzNy9OaS9FU2JS?=
 =?utf-8?B?b04xWUx0Ni9mSXh5aUNONHUrelMwaXl4NlFmTzF5bml3aE5XMFBHU29Yam5E?=
 =?utf-8?B?cUJlNW5ESHpyMlRqZ0M1eFNyZU5iMW9GcEhuYWFqTGxRRlg1ZDhsYWJmV1pT?=
 =?utf-8?Q?KiU3jXK6DQU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW94ZWVRRFpHRnNTMGM4RGllazNpSk5EUTZJdEc1SjFSR0c5Mk1sVm44WHJ4?=
 =?utf-8?B?V2V1bGt5cGNtOVphUE0rNFVtREk2K1AwR0xrUHJRKzFFOW5GOWYycm9QWHlK?=
 =?utf-8?B?SXVCbWJRMERid3V2SGJVS1g0Q2VoMWdBVXJrb0VzaW91VXpHRDdYZkZEYVNa?=
 =?utf-8?B?ZGxpWW1NaWc4cXJvOHVucjlxalJmOW53bG4wNmd0WW9pbVF2RUZaZzh0Mndk?=
 =?utf-8?B?S001a1lWM0Z4YmFyUzEvem96VEFwVnZZdTZ6OG1VT0tlMDdIZEE0YklCTkVu?=
 =?utf-8?B?U0gyTi9rSHRnWTBENzNVWmZiWnNTTm9ZOXV2VDBjWjRHZUNBVzBPVTczclZR?=
 =?utf-8?B?cDNIeHFkZEdmckV1ZnlkZFh0ODlJL21panVPNVdiaHorRlRvaDY5UmlLLzIw?=
 =?utf-8?B?Z1NiM1NyYktrbTM0V2Y3UDh5NjZZTkowWXFiWW5ONHBWZGVaQWlBUzdXdHJL?=
 =?utf-8?B?c294dmxjbnRZYm5mYmtnYitDK0ZqSmFBTFVpeHRIdEtIN2x4Y3lIU0FvNlc3?=
 =?utf-8?B?amVvb280eUdsYlM5N1JidWQ5WVEySHZHY3hvbTdpMEl3cTdSLy85eEZ2Sjkx?=
 =?utf-8?B?VHBHeWUwYVZzWGFXbm9RaUU5ZGxIZVVWa0Y0aW9Ydk81dWRWSkJGcE9qV1h1?=
 =?utf-8?B?VC92aFR2L2YyTU9nUnpNbXFTdkswWXYxb3pva3NJRlhJMUgrbXhuNzhTS2Jo?=
 =?utf-8?B?dE9LOWtibXlobTdZTmRTWEtGVjVpc0lQOTNMNHhqVUJNbTUySm5qdk9oc05E?=
 =?utf-8?B?THcwVVJjcXhsSURsQ3M3N1Bqd3lURVUzblJ2Q2w1cFBERXl5K2ZsNEovMXps?=
 =?utf-8?B?dU5HK1dTbWEvRmo5cTdmWFc5djUycTVEKzRjb1lCUWNRYmpzc25iM0trZzM5?=
 =?utf-8?B?MWpPcWh1NkR6TGp2TGo4V05KT0VVMDNETFFaNGlrTEs0cThtZHhJQzloTktZ?=
 =?utf-8?B?azhXWmM2WVBuZmlaeFVrUHVRUUZ5ZjUwVjZ6WFFCTktYQ0JqU1hIYnR2TExp?=
 =?utf-8?B?aWl3dllKYUtqakVtTzdnZWFvTE1MRVo3NEY4QnZ1NXo3ajhyVWZ6cVpPK3J2?=
 =?utf-8?B?djZaMTZBclc2eGxHVVl1WnVkZjgvTUY5enhqUUdXbElEVnZKdTJZNVVIRml3?=
 =?utf-8?B?MldaRHRpSEpPaUlPZWIxTzh0d1FmL1FEcVdtWmFpRWJwRnJ1M1cxUkNHNFVY?=
 =?utf-8?B?YnVFSUJYTVVOY0FvUi9oSnIrdjlmaStBRmZpWkk1RUMwc2xCT2t0VHlaK0V6?=
 =?utf-8?B?S3dxK2tkOCtPbkIyaEQ1T1RhSzlQZHg1MVhKRjZhVW9sMUx5NFNSN0tIZ2dz?=
 =?utf-8?B?bFRGZEtNb0Nab0hWSHNvMzZpcTI0NE96VTh0U3lBOWxuRDQ4aWoxZ3pVbWxh?=
 =?utf-8?B?cVM1WnZSTXhaek9FamhPTWQ0ZVlzR3lSODc5VWZnWmlINEdsQ0hralNGL3Ry?=
 =?utf-8?B?cGZIWWZXRjVyRGxBSmdJZ3ozYkhjQmRab2Z0K3lKOWhqU2E2Z3k1a3A4akdy?=
 =?utf-8?B?d3h2cHR5MUtRZmVxYytzaFdkcU1mV0xEdTNGMG54TjNwT1J0ZWg3RkNkQitY?=
 =?utf-8?B?WXBWVXpOMEZ1WnM2VWNEUml6YXlQOUdSUENqRVBjMmtES2xhZ25kd3VoUjg2?=
 =?utf-8?B?VE1ZLy8zVjdXckw3V0xjdnA5dTFzY1MxV3FsVEtUT1kwcnNvcVlwUERUT1dK?=
 =?utf-8?B?MnNnV21pTXg5eUgwczB0NlZlOVllSlNpWlFOeFk1TDRSSnFhNmZUVWpoUml5?=
 =?utf-8?B?SWVUWUpuRG1ST2FMUmxnUTl0U0JUb0hsZzFhNFNPU3F5QXQ2bm1ncFVJbnRp?=
 =?utf-8?B?UG1GbUhpZ0NiZ09Iam9DNEF0MEtEd1VxTy9KcnE0RU5wUjArMXVHZVNLMDRl?=
 =?utf-8?B?ZkFoekZyckRFVG5WS2xDSkZBT0NNMS8vY3RNajNkTGNHWTlCT3VHK3JzNW51?=
 =?utf-8?B?dkFCUTByQ0xzcUFDZE9uY0NYZmpRd1U2dERGQS90T25GZk1iL0QxdXNOeHcr?=
 =?utf-8?B?L0lkMDF1Myt6bTNZM1JtdXpVNmlGQXVXak5ld0d5Mmx5Q1RGekY1MEJnNDFr?=
 =?utf-8?B?YzQ2b3l5eFlyQVMvY2xiQVhYWENSb2tiNGN6UVQzeWVDbTBXVlJwRzdYOHY1?=
 =?utf-8?Q?DO/TI1Nk5JvY4FWcQVuHAUCMW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43983393-8d91-4063-8c6d-08dd880ff2b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 17:53:43.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AY6fvqpg24JGJryrMh7Cjz/ehV0P6rH/16dP8Ecxq5t51EDdqqs/NDMzPMgqoVi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

On 30 Apr 2025, at 13:45, Johannes Weiner wrote:

> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
>>>>> If it isn't, can you state why?
>>>>>
>>>>> The main difference is that you are saying it's in a container that y=
ou
>>>>> don't control.  Your plan is to violate the control the internal
>>>>> applications have over THP because you know better.  I'm not sure how
>>>>> people might feel about you messing with workloads,
>>>>
>>>> It=E2=80=99s not a mess. They have the option to deploy their services=
 on
>>>> dedicated servers, but they would need to pay more for that choice.
>>>> This is a two-way decision.
>>>
>>> This implies you want a container-level way of controlling the setting
>>> and not a system service-level?
>>
>> Right. We want to control the THP per container.
>
> This does strike me as a reasonable usecase.
>
> I think there is consensus that in the long-term we want this stuff to
> just work and truly be transparent to userspace.
>
> In the short-to-medium term, however, there are still quite a few
> caveats. thp=3Dalways can significantly increase the memory footprint of
> sparse virtual regions. Huge allocations are not as cheap and reliable
> as we would like them to be, which for real production systems means
> having to make workload-specifcic choices and tradeoffs.
>
> There is ongoing work in these areas, but we do have a bit of a
> chicken-and-egg problem: on the one hand, huge page adoption is slow
> due to limitations in how they can be deployed. For example, we can't
> do thp=3Dalways on a DC node that runs arbitary combinations of jobs
> from a wide array of services. Some might benefit, some might hurt.
>
> Yet, it's much easier to improve the kernel based on exactly such
> production experience and data from real-world usecases. We can't
> improve the THP shrinker if we can't run THP.
>
> So I don't see it as overriding whoever wrote the software running
> inside the container. They don't know, and they shouldn't have to care
> about page sizes. It's about letting admins and kernel teams get
> started on using and experimenting with this stuff, given the very
> real constraints right now, so we can get the feedback necessary to
> improve the situation.

Since you think it is reasonable to control THP at container-level,
namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
(Asier cc'd)

In this patchset, Yafang uses BPF to adjust THP global configs based
on VMA, which does not look a good approach to me. WDYT?


[1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asie=
r@huawei-partners.com/

--
Best Regards,
Yan, Zi

