Return-Path: <bpf+bounces-60627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0CAD9429
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 20:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1F57B1560
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08622DFB5;
	Fri, 13 Jun 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Re1soZ6G"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CE226CF7;
	Fri, 13 Jun 2025 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837911; cv=fail; b=uB8S2QoqpzpvmT30kPB2UQvP2KMBPk/cFuIKXE8UqRtlHEEfCftsXxQft45w8koUMDdEpnGyn4pJpGtf+pQr0AR285Iu+uGzMIxXKuqkEWsp9r/fgVe9ZqlDefQb5fxTpM7HY519Yc+2LrJIkfaPxLIlkIqq/viJb1rikaa44gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837911; c=relaxed/simple;
	bh=9fDnbW97bm8DszFQkwLQbNMJvxfRO7pMuNm+6SUmSEc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OT/Blb/8KcCZtshOXvALCaUFINS/WVWov/uZ7AcxL2X+8sK1Btj0uIFgY5iz+OVd4SLpUkQETLT6YYv4dSyJQAiA+1zo3NH6J/LUDalL92xSs19wZIHmmn3rBDVBxk21K1nGtX9gQQEanj/Uw3PHjlMV/BAGnvueEZqNwRtunDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Re1soZ6G; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4796NF2GBLP4hDh8LLqVITBaHnX+Qs3M1nicJ8AhXGsDaBrcN9M/2f6B66jDZwDQ9YQrOIADnS4aPHe+QmRH3IA4d9QvWCMM3sN1zqmCIBcVI6IOw2APCtUvUFNcUDbJbXonKlEz0yudZdcr4yS7l1DwOY49Qqtl1tb+IPfNGtYAPp8CtWXOfij4zVerp1O2pgw5KRSKSeKdZSs/HyFUjcMEnW1nd+mVXUXXVP5ByuTTDP/6GNAyFB6ie3rlDeUj+EWdt4plKjvE27V3Cg8I34XvlTLJiiPGPTtYt/PrsuwVuliFmUXM9jiH69ufhU81uYfbejjmpE/vOeQustuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alKyr0sij+NIJkCFNaRcf16YM8my6zT6lKuwbEwHNSo=;
 b=FtjZvcaE8z0/hiAW1IdSC1jWbZyK2N5RjGbJO+jM3QDJNM1nzWqRRBiTjTIeiMdDBjvHVOkrDjK9MhSxGD0Ii3SnlbP7Isn2wh2Ck0rBz+rlE1gvho/aM5G1OSV6uz/jXVtmi2wo4WSb7nE7eXSV/LQbN9em0kaG6EPYs5FZB3pJ0tQsdhkj5hHIDPyqOD3IoZ2iTLH2vdIldDGQHy7Igzm5j8ZhcNjP2HOpU+ewFq/5KIda/RU6oeZHeNd6UULzdxIc0deaogH0YjzKfzayASzlyurOiC3GC02BlfmAJFA3VpxY0ZPO11L5R7JZpsaOAgO+RY1luoCvU5f7oAzBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alKyr0sij+NIJkCFNaRcf16YM8my6zT6lKuwbEwHNSo=;
 b=Re1soZ6GWlhmgsBxl/sa/LX+M+0nauofczhEW56bIasErUgU70Of77TNbtinTe9vrp8xuqr+rUa5DWMxMbIX5CubWeKqgjohZDFPFLuYeCm6SHUUdYjMNlr5O5uqtW22S6jMTRPYT4fFAbGGzgmcku8L/ECOnHPQ6v+oO7EcswtMCFj8SIc/qBbNdtjF2VOIyHJYbdhIx3w2KTd/QBpel6Xrhk5ByRDFg0isC3LMZxqvDV4khbT1SPx/vgIN4SIln+eveu+brr0fT5Ru2zmJjBjY70vuZeLJxvpMRRJiZVA+5YviRpNjc09CXqaboJy4Y1P2oh78xv5cWyeBoh/YvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 18:05:06 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 18:05:05 +0000
Message-ID: <b6754f5c-039c-4cae-8279-4a574fa055d1@nvidia.com>
Date: Fri, 13 Jun 2025 14:05:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add a deadline server for sched_ext tasks
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 bpf@vger.kernel.org
References: <20250613051734.4023260-1-joelagnelf@nvidia.com>
 <a8200977-689d-4041-936b-3a92eac1bbe9@nvidia.com>
Content-Language: en-US
In-Reply-To: <a8200977-689d-4041-936b-3a92eac1bbe9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:408:f7::32) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5606a825-987d-47c9-3357-08ddaaa4d38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjlYU2F0ME9waFRTekhscTBoUFJXbHhhZXFFNzFyT3JjS0dRZTcvMnArRFh1?=
 =?utf-8?B?dzU5NlI4blpacGR3RW85MGVldnc0eU5WSklZUTRaUVUrUEtBVHlJZ3J6dGVo?=
 =?utf-8?B?TmVFcHN6d3MxcHZyZ2xJOEdMeWRrbDN1SXMxNE93VHFPd1A4a2dVa2RpVXIv?=
 =?utf-8?B?QW1uZ2VTTnhtUTVMczFqTEFDTThUVEsxczV2MmlENSt5MzdwRVRuWjA1Z0JO?=
 =?utf-8?B?WVpiTitmbEYwS0E3QUJjbnlnZHZkMmgzWjJxN3J3TGVuZHA3bG9qaUtmakkw?=
 =?utf-8?B?NTN6MlNXZ3dtbFJ6MjhJVWYxb09wTnI0NmlmNVcwWG80MjgreDF0c0ZxMDJJ?=
 =?utf-8?B?RzUrenFNakR6dDlnOEp1UWVMQmZLSVR3Z3ZhK2JJOUNlQnQ1Z0Z3OTdOTmwx?=
 =?utf-8?B?bk9JSjhzNXFONlhtMUtES2pOanpCbGY5UUtGUml2SXlsRHQvOVBSK1hDK0Q0?=
 =?utf-8?B?SUc2WW1ocHhHUDBQajhpWU9Bc2dWUE05dGtScEIvMVViOTgyMjgwbXJUZGJW?=
 =?utf-8?B?eXI2VGxoYkZ1dlkrcVhHWjZmVEZkc3B1Nmx2enNkWmUrejQxdHpVN1RIS3lI?=
 =?utf-8?B?Nk00eFV2UXBITzJJK0FPdlBNdG4rczdPK1h5NUpIZTVCY1AxODVKRktzR0dC?=
 =?utf-8?B?ckdBS3dITXBqTURFZStpeFp2Mm1DL3k0WUY1K1MrcHNzWTArOFBSLzBiUjgr?=
 =?utf-8?B?RUJQVnIwci9JL3hwM0cxcklVUU9oQS9rY2Vjc1E1NmRhS1NVZk1VZ3VYeXVx?=
 =?utf-8?B?WDdlSXpxZzZRQkVDVlA3dkpIbGpPWFJvQ0NoeWlsMDVwd3A4VnJRTEZ2YmtG?=
 =?utf-8?B?b25CNEphSmVCRW1PNUtOOW1vaHFjbEJlL2VaOUxuYUZQUVNnaXlvanFLNldi?=
 =?utf-8?B?YW1ucWQ2b2ZkYXphTmp1R2RMUEQwZEtnWWg5RWV1RUVQWk1UQVM5NVRzdnNF?=
 =?utf-8?B?N2Fvbm1JYjhqbWJmdWMwQ1duUW5laks1cEtrUVVZRlN3SVpqdlhBaXJSYWV2?=
 =?utf-8?B?ZkYySGtHNHl4M2VqWHNDOUQ1cTZuV0hMNHZrZmNwc1V2bm1XRFYxcDBhVzRW?=
 =?utf-8?B?OFJCKzVPUkQrVDZPUTVtT2Z4MkdheFcrazdYUlZ1T2JmRGJCOHpzNFpqT1lj?=
 =?utf-8?B?MlVLeEE5TFU5ajJPb1d1d3dONEtYM1E5Snl4MDR0b0Z4SzNkeVZDTllnalpF?=
 =?utf-8?B?aVFhcW81dFhlTG5BTkR2UXcwd1QvU0RRVjR4Wk41T0hVN0hXdjZEenF3WUtH?=
 =?utf-8?B?UmFnYnZUdTFDWkYxMm5WMGJ3ODRKaVlYd3NnOXZuVXU0SzhpSEJIZGtIS2Fp?=
 =?utf-8?B?MzF6R0o4VzFuUjA4NCtjMGhlMjNJelR1Z1FIaEk3TU5IVzN5VDljUk04UFNj?=
 =?utf-8?B?QVNsWG5YOUZmMW0rSGt1ajcwL3FBZVlMR3RlekdEWkVHRFZpb2h4NEpSM0FR?=
 =?utf-8?B?QlZBRk8ycVJiVTA1eXYvTkpIbHJ3akJieS9kTk9PRFpCWDRZZnNRN1E4NCtq?=
 =?utf-8?B?UE1odkVVeTNhbE5UK3d4L29uVlVQQzdUUm9kZFdvbWpFY2ZzWGZha3ZFNHJW?=
 =?utf-8?B?bWNOVCt0N0NSZlRVb281S1dGWG55YXJYOWVtMllvdW9EMnovSVdVVlVJU0V3?=
 =?utf-8?B?UjR2Wm1OTU53TUlNdTJVRU1UaDRoUUkxRVh6YVRGam9XRWpmRGZtNW96Yld1?=
 =?utf-8?B?Tmg1SExER2dza0lMZGdMM3dVUUZmdm5RREVkd3Z3UlFRNE1RVW9KbCtrQUo3?=
 =?utf-8?B?eFUxeGZWVCs4L0x3R0s5Y08zRHA1SVB1Y1o0MFVNbHRwamh3SnpnNHhIWnNq?=
 =?utf-8?B?dUdLVCtaNTk5d0N0MER2M3hnZlA1dnUzQ1ZicmNjK2YxZy92eEV2aXk1VlN4?=
 =?utf-8?B?SnlPVWhtRFhob0lVc1pXa085bWFXZ1Z3dysyMm5hZGxYQURTaWVabnRtTGlJ?=
 =?utf-8?Q?VXfd9Ghf56Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d21ibkNFV1pqOXRkbnNocjltR21yZ3dXS3Z1MWVPLzhCQUFyZlAwYVY3U1k4?=
 =?utf-8?B?TEI4V1pwVSszai8rd3Jpdk9DVVNBOXdzUVVvMHFKMDFjTXQ5UWNtR1lWVTVC?=
 =?utf-8?B?dFRJZlc4RlNRMDdOUXVsUVZIQjBZd21vVUl6ZTN0aDVydkQrRVpwSmc3YVQv?=
 =?utf-8?B?RGd3Q3J1RnRqcFZOY0VNQmNlbW9TNHJGMWlWejNSZ29wSWhHMExOcDJFWDNV?=
 =?utf-8?B?UEdkYTZkOUxLT09YOGEyMkxjSGN2cVFzRlhHQlpxKzJTWktFa2F1VEFtTk9C?=
 =?utf-8?B?ZFFHdjZpWVg2ZXFHaC9rRjZXUElwOGVjcTExeW5SQmExNFJnTXV2STQ3ODQ1?=
 =?utf-8?B?cXpZSFJFMDB0d2NNYjVuSis1QkxObHlFYXVJcERQNE9OVFlKT2NoTEtIVS9l?=
 =?utf-8?B?Y1lnZ2x2dXZabGpuVDE3UXZDY0Rua2w2L2FZUFpuejRUb2hkWU9ZdXVHb1FY?=
 =?utf-8?B?VW9pRkpLRDZuNVpqME5zS2REdXl3RGlYdTZTMzVpd05PcjNLanFtblV4Tmh6?=
 =?utf-8?B?eFJORDRUbUdWd25WUlpNSDEyOGhSRTBtWjBTaU51cWh4aDZHYks3ZEsvRzBl?=
 =?utf-8?B?clBnSWdmT01ZbEJ3anRsOWhCbVhsZjdJdFBuTXl4OVVKeVFkQkZnQjFmcUM4?=
 =?utf-8?B?amwrQzRZaXVtZzdibDI4TmVJaEJ3TURLWExwdnh4cGF1Zk82eEFzV1l5bFU2?=
 =?utf-8?B?bFBzNExOZjV4NFk4eHpXN3hmbTk5VTVyTjdTeXBKN3VSa0p4T2xTS1ZFY29N?=
 =?utf-8?B?TXpqbkVXc2JOaGMwTUdpMUNMZndRUUJsVjZDWU5NcWFwMWw2NkIybzFSMlRt?=
 =?utf-8?B?V05YVzNyRit0TTBaejFqd2ZpZENBazBOaXNqWWhaN1FFeDRPazg1azJsNHVS?=
 =?utf-8?B?MFVqQmxadTB0VWc0SitnRy9vaW96YXEzS2pMbzFxbnFwaE9DbysvMlpDZVN5?=
 =?utf-8?B?bmNidkxoaElVUE00MFgrdUxaNWlRb3pFT0wyS3VxWDkvanh5aWlaQlpnM1lM?=
 =?utf-8?B?Q0VqMG5weXI1VmZZZldRblJuYUYrazE2RWJHNHJSMDRzdzBjYW9WTkZ2SGI0?=
 =?utf-8?B?RXg3Rm9CMFBkV1dJOFYyTlh1RnZhODdQVXhzK0NNSXovNE5yNmJMVlo3K05B?=
 =?utf-8?B?SHdJNVVqOGlmemFFVXhHei9PckVUK0VPTmJFQWovVTBnR0JNZ2dpZDlkc2pn?=
 =?utf-8?B?TENjYlV1SjRDdWtXYTN2VFIwRGw0MnFUVXJHSFhQWnJ0VU1mMnk2NTZkUHkr?=
 =?utf-8?B?cGdXVnZxZUVna0lQcWErejJaMHhHNy9YUDJLNUhtN2NRUktHRkNnUWtWVkZi?=
 =?utf-8?B?bm1IZVdreDZ1TXRPWXZTUDlFd2RINko2Y3czSTNrZ1d6NGwwbERPRnh5elBK?=
 =?utf-8?B?aUloTVNDYnU4L0ZMWDBmUUpxU0RiWGZBWDk2Q29KQTFwWVlTd1hCaEY0OGtD?=
 =?utf-8?B?WElIeGNBbCt1aVE2Q1RBRmpDTkpvaXNzaGg0K3k4aTVQT0JPVDlqYTdxZHd4?=
 =?utf-8?B?cXJoaWpjWEl2ejlmaDFTeFFNdVFnbVpMR1dsZHU4UnM2VDdlMkZOYUoxQ0I2?=
 =?utf-8?B?dzJISGdGR2txNVhmSW1udGtqY1ZrVnNpb1M5WVFMUXdrSkN1dGVVdEV5dThw?=
 =?utf-8?B?bmlTNUl2cTEwVWN0ejZLbjhQaEY4OHdGWmFaeEVlYkpwajBjN200SjdCNnE1?=
 =?utf-8?B?SXdxdnd0cG5UKzlIRHVrMGVpbFo0RFY4VGZQWHluc1A5SEVQRnJZRklpZzM1?=
 =?utf-8?B?Zk5zRmo2WVMwSC8wSkpwVTFjK3p1OFp3dldiaTNPQ1huUVQwLy9MNFAyYlR1?=
 =?utf-8?B?YkR6OStoOVZxKzZTaDF6VkliY3Ztalh5ZUVnaUFDQlpXL0RxZm1ZZ2FsMkdD?=
 =?utf-8?B?STh3UDE3K3FVdmZJdnFBTFRDbmVkMFNQUzlQSVpsRE1Mc21IdVc3bE5GRUcy?=
 =?utf-8?B?cEJZRk00RXJyMXRBaVRvWDVPNHo2Y3p5WFZNOG5BazhVY3RVUXV5N2FQWFBZ?=
 =?utf-8?B?OStWYTVVVXc2MzFEMlJHbXg5SmVXWGh3ZTljSmRhZE9HMStxMksvYitaSzJO?=
 =?utf-8?B?S2hST0VoMFhzRnRCdVRiU1FGbFlNTWFsdWs3Q2gybkN2Mm1LN1NoK29xdnV2?=
 =?utf-8?Q?Mq3t87QdIXe/dXToqZNhADuHl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5606a825-987d-47c9-3357-08ddaaa4d38f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 18:05:05.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwoGzif4oiXh+QmMbKB06DfVHuEwoXQOXBk9iU7pnQI4BpCdYmNXSsAN8cYQN67/v/i2AmDUMuKcUDlECGSOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737



On 6/13/2025 1:35 PM, Joel Fernandes wrote:
> 
> 
> On 6/13/2025 1:17 AM, Joel Fernandes wrote:
>> sched_ext tasks currently are starved by RT hoggers especially since RT
>> throttling was replaced by deadline servers to boost only CFS tasks. Several
>> users in the community have reported issues with RT stalling sched_ext tasks.
>> Add a sched_ext deadline server as well so that sched_ext tasks are also
>> boosted and do not suffer starvation.
>>
>> A kselftest is also provided to verify the starvation issues are now fixed.
>>
>> Btw, there is still something funky going on with CPU hotplug and the
>> relinquish patch. Sometimes the sched_ext's hotplug self-test locks up
>> (./runner -t hotplug). Reverting that patch fixes it, so I am suspecting
>> something is off in dl_server_remove_params() when it is being called on
>> offline CPUs.
> 
> I think I got somewhere here with this sched_ext hotplug test but still not
> there yet. Juri, Andrea, Tejun, can you take a look at the below when you get a
> chance?

The following patch makes the sched_ext hotplug test reliably pass for me now.
Thoughts?

From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] sched/deadline: Prevent setting server as started if params
 couldn't be applied

The following call trace fails to set dl_server_apply_params() as
dl_bw_cpus() is 0 during CPU onlining in the below path.

[   11.878356] ------------[ cut here ]------------
[   11.882592]  <TASK>
[   11.882685]  enqueue_task_scx+0x190/0x280
[   11.882802]  ttwu_do_activate+0xaa/0x2a0
[   11.882925]  try_to_wake_up+0x371/0x600
[   11.883047]  cpuhp_bringup_ap+0xd6/0x170

       [   11.883172]  cpuhp_invoke_callback+0x142/0x540

              [   11.883327]  _cpu_up+0x15b/0x270
[   11.883450]  cpu_up+0x52/0xb0
[   11.883576]  cpu_subsys_online+0x32/0x120
[   11.883704]  online_store+0x98/0x130
[   11.883824]  kernfs_fop_write_iter+0xeb/0x170
[   11.883972]  vfs_write+0x2c7/0x430

       [   11.884091]  ksys_write+0x70/0xe0
[   11.884209]  do_syscall_64+0xd6/0x250
[   11.884327]  ? clear_bhb_loop+0x40/0x90

       [   11.884443]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

It seems too early to start the server. Simply defer the starting of the
server to the next enqueue if dl_server_apply_params() returns an error.
In any case, we should not pretend like the server started and it does
seem to mess up with the sched_ext CPU hotplug test.

With this, the sched_ext hotplug test reliably passes.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f0cd1dbca4b8..8dd0c6d71489 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1657,8 +1657,8 @@ void dl_server_start(struct sched_dl_entity *dl_se)
                u64 runtime =  50 * NSEC_PER_MSEC;
                u64 period = 1000 * NSEC_PER_MSEC;

-               dl_server_apply_params(dl_se, runtime, period, 1);
-
+               if (dl_server_apply_params(dl_se, runtime, period, 1))
+                       return;
                dl_se->dl_server = 1;
                dl_se->dl_defer = 1;
                setup_new_dl_entity(dl_se);
@@ -1675,7 +1675,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)

 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
-       if (!dl_se->dl_runtime)
+       if (!dl_se->dl_runtime || !dl_se->dl_server_active)
                return;

        dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);

