Return-Path: <bpf+bounces-44592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271099C4DCD
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 05:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1CEB247FB
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E9208970;
	Tue, 12 Nov 2024 04:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bItI+Xjg"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDA208222;
	Tue, 12 Nov 2024 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386580; cv=fail; b=GvktGvb1Y7kW7OZLayXvp1lFau51gNlAJI9ZTuS5HCTkQ/0YgugJT+/1Bv8IT3nBzzg22weIu9dQbShMuSGpOkFc12oAtFytEt0QjiCPw1WeInK5h7AFJzrhghr0TSRzeZDJAHInaoS2Ir7uZFEuxW0NzbdGnnxg2C5XFWSx44w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386580; c=relaxed/simple;
	bh=gqvsadeLUGz2O4Wf9TKNa+JwXGV93mm5Xx95cG6cb6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwY0C+Sb+cVufn7/GlosM69gK10SH5mtHBCSw2O9BBeTo+AjTRky3nVeyTRF+ZsBAbLtrcwJ4c/bYl6Nh3Un/7TkdULDBiUeKWVR9d/PYgKGh8Uvd25oetHam339K/CRi/cgfYvhlV1WQB6ky3F1okzFm7a7fghoJPFIIMPxxWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bItI+Xjg; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tk7Leo+55x5vxYGzSLAigouihCJes4OfHkgpJQzZrwkUx+5eHOKm+PEOiuwUZXlo4rI2h4yRwhpL8RRHjs3sXk7KjgZZwEZ1R38x5t0fcTktWtQD2KLmvi9KeDUdcWMnz5nn5EtMwQmu94SR2AcvG2v9jNNG4c86vLj8pm1iXAGdRyfFQmA+BDi4PBJhU4FAVqT9v94+bA4ZooFkhslGPjtzXelFBCmpuJ+yr33Jgyvav1u0gw/jQW/a2UyLGl+TDI5ZoVmGFPcsqdt/aHsJN1HLYGzk41Ft6W3zjD2fM3aBuM+a1wddWtzR/II2sigE0Ip07CUWvVzjpcD7sN4dAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxgScA0dSg7YFy9knkmyTqFVeEcS5/8+2JpKM5QvG9A=;
 b=w97OzjE93//YnYlw1sr00gnaPFMD3cy+R5+CHV172jLx0H2hzDDqyzKOSKG/S3cPTDqzp051P1Bf6nZmv8HL7SkibEAWbugOiBubUS7tXs/zocQ2cH5rW5xkctCODaSWJrwqxHllU9qozdIllveNmHoy92dRFWo6U2tB8yjAl+KvNLGGBBKF1Km6aNgXZ9YRfw4kMcgG74IgxiPj+emrKWy9MJzSUQnmq7uRUyJsNI/I3V0LCiGBMH+8B/kvwvJWZGGUHz54dWLU6nlLD92pwbH+mN9PMEdT0QNLUXCnM5JR/YXzHBv+MIMk3LKBwAbe3wN66sXEEKUb4vcLxHXNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxgScA0dSg7YFy9knkmyTqFVeEcS5/8+2JpKM5QvG9A=;
 b=bItI+Xjg8Ag5dYErPjB4YV5ht5PYoxNvEn3mK3cb1oiEMF/bMrAiAjwVLWcb4ijw3GOvmRT6/MyVCgYIQuEQAHgtZ94GLwrjUFJ6FRWfAzAUqGsYvN7pUDpahRJIlx9VHPKR0hd60pfY0KSlU7TZFfKNduYKmeoQBYbjZANhQvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 04:42:52 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 04:42:52 +0000
Message-ID: <c48c9dca-fe07-4833-acaa-28c827e5a79e@amd.com>
Date: Tue, 12 Nov 2024 10:12:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 11/15] rcutorture: Add reader_flavor parameter for
 SRCU readers
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-11-paulmck@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241015161112.442758-11-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bdc729-ca33-4d53-0d37-08dd02d47798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnRVMzJGNkMrbVIxQlNtT05wVDNHMmxyQys5SDh2aWZaMXpKVk5VaEptT3ho?=
 =?utf-8?B?WkpNRkVpdHJCZnBkUjByUlVlN2ErcjMyRG9UMVBUN29sSWJJNUFLaHdOY1ds?=
 =?utf-8?B?eVNEcGtVWUx5TXd4c1JiMDJQckFIUEdtVTVMVTJXVk5DMldsM2lsZmZIU3Bq?=
 =?utf-8?B?eWdNaEEyelp2Nmh6bitaUmNWYVNFV1B5SXhPQ1JGSlVtVUo4RnFpY0NhOW1h?=
 =?utf-8?B?YlROUjltdDdONXpBTEtRaHJNcCtESGpuR2ZSUVdBM1hteXRJOHluNzVlOE9l?=
 =?utf-8?B?ZVpjS0pQNTNOWVgxZWtxQUtyNVJZQU1XdmtyeTFpZmVCalBvSXZ5Ukwvdllt?=
 =?utf-8?B?dUtKS2NuN2RHdVFyVzRBUHdNbi9INmZOWTU3MHdiODhMZ3c3aDJmTkI4bWVI?=
 =?utf-8?B?N0tRYytPWGtwT2IveWVrdjd2K25JbnN6a2RmbldWeFlsZ3ptQ3c4YlJvbWEr?=
 =?utf-8?B?SFd3MU8vTWIyYi8rMlpqTzc4MVRkUlMvNVhtZFg2eHJUT09RQy9SNnlFVFY4?=
 =?utf-8?B?UCtrNDY0ZkRlTGlkYS9uUDlmSEZobXkzSVpOQ21KOVhCbjdGSmVsQUY1OTZh?=
 =?utf-8?B?OFpYR3BMcUFVaXc5NW1hWTBzdmo1V3Brclp6UVRqeFhBUkRVaktkWXZCWVNR?=
 =?utf-8?B?VUpKdHVISXJqMCs4aHdDdzFvMmNUTStmM0FyRWFxNHVLU21QMVQ3b0kwVTJL?=
 =?utf-8?B?Y0xHKzFvRHgvVmpWY1JOSEpmeGJzb1oyV3A4WXpCcEZJU29hdXYyWFM4dmdR?=
 =?utf-8?B?RStESjNmWGR5S0lZU3dkbnkzem5TRjljeWpiUkY0T2thQ2NtWXVvY1FaV1FK?=
 =?utf-8?B?REJFWjRvdktQZjlNVGlZcmZTZmo5bWErYSswemxJVWhQZUIvdVIyZmFlZnY4?=
 =?utf-8?B?K3EyYjBYTjVOVHdVYW04S014dkkvQ3VRQ1VrSjJVMlVsNzdoVFZiSTNYaFRZ?=
 =?utf-8?B?MDVwVGpsc3FzeHVKTlM5QmZHbEg0SUVwKzBpVHh6QkZ5S1ViUWhaQkFibjZl?=
 =?utf-8?B?OXMyZnRuOC9Jb1JWUzA3bzc5NGtvbi9sVXFkMlRsRUlwd2hVT25VN21XWGJO?=
 =?utf-8?B?aXYyS1ZpUWVXanEvaGZRWUNTcGxDVG5lbTd3NDhoNGhWUUpmS0twcDJBTE9C?=
 =?utf-8?B?dUFiZktnaGYrQVhJalFMK1JvOUlBbTJjRjFNblk2TjREck1ITzBSSUQ0OE85?=
 =?utf-8?B?TmdWdUxjUjNYMy9ld3VtNmZHa3Z0K29OLzVpU2dyL3JiR3ZJR1ZONUVBWWVt?=
 =?utf-8?B?L3NNbnRBbkc2WDZkSFMrSDRyZ2Zady9yRS9oZzg2VkdIWmlua0VGdG9RT1cy?=
 =?utf-8?B?dmNmQ2NzeWROSkFDdE5WazRLWmJRNmo1dlM5T3R0M1Zlb3FKdkQ4QkI1d3Nm?=
 =?utf-8?B?TmZMcnp2SVI2d0xpNStUZDBBT2xBR3BEYzFVYmtOeS85SnNFL2R0RnhxNmZZ?=
 =?utf-8?B?QXVmdG11Zk5sR2UxZWFwamtFOVFhRE90N2paN1ZZRTdjZWpwcmJPQlMzN2JJ?=
 =?utf-8?B?WmtWK2xlSkpXbi9HNXIwZi95a1ZINThTdVhVT0VYcFhjTDdwREkydTNaTVNS?=
 =?utf-8?B?V3ZoejRkdlE5eUsvQmU3MEJDY00yWHo4dmpkZFlvYmRMWkVxZXNOTzNIRjlG?=
 =?utf-8?B?Sk8xOEROTDdtbm5HbldTUVArRGRhTVhleVRFZXVPS3FNZkNJbnk5dHVUNXFT?=
 =?utf-8?B?R0NDWHpTYnhhUU83dUkwaVFOVld5VDZKemJGb3ZiYVQxcHNLWFZRcVU3TUM3?=
 =?utf-8?Q?HmQ/zQ3HUsRq1zv9+KpJB7qpCwUIOZz95u5pD6z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0hyZ3NJNnpCRktVbkFtSXd6dk9UL1E3WS9CL3Z4aTdJNXNpZG41TkNQMU1W?=
 =?utf-8?B?RFpPZkk0K29jR0RyUE5FaDZqZDlLS2NCcmJIaEtQa2gwWm0rR21wODQyWGxv?=
 =?utf-8?B?OFRHZXdSU3R6RVovWGxpN0VpNUNVRzFlVEpVSzErRGxTNW4xWDZGUDNkWktY?=
 =?utf-8?B?VGp0czhZeDNFdFR6dEhsbisvRkl6UklzenhpRTB0V1FKS3V4YnJyL1JwWUdm?=
 =?utf-8?B?eHJjZ3luTkM0NkhVZStJOTJER0ZJMTFoRG9na1NUaE1kcUJaa1RPcVlZSHdr?=
 =?utf-8?B?cGE5UUxuR0Vkc1VXWCsxS2NYTXI5WjYyZERTSGZ3c240TTlJaVN2T2YzYzhv?=
 =?utf-8?B?Y2lZUjFGWlp1YTN0cVhTZXFncU1NWWdDM1ZuSFhMd0k0NmNPZ2NwQkdmVlR4?=
 =?utf-8?B?V3JTLytGZ1l4OEQyRS9xZlEzT3ZPZytnbGwyaS9jNWlUUnZIaVBoUkovY1Ex?=
 =?utf-8?B?LzVCalFXN3ExTzdmbVVDbm0xbUlHNmQyb08yelRVWmxJb04xMi84YkFBVTlz?=
 =?utf-8?B?YlJwSExLYU00d1NQL0ZETmh6S1BRVEJ0eDNTb2lQTWpldlBoUGlOTGtCRGY4?=
 =?utf-8?B?eUgzU05VYi92NUdqQmh3Rm1KUENOWUtNMU5ua2wyZnlSRHJya1Z3TXA3NjIv?=
 =?utf-8?B?RWY2dEdteW9yV3YzRldDYnBGenV4R3Y5MVUzc2w5Tm1HbDNhUEhVWHN3N0tK?=
 =?utf-8?B?VjA3RTNHZDdaMk9jTEpzd1MwYkZmamZobXdEVDFzMGFRTUVUVjBmUUo0UzNH?=
 =?utf-8?B?cmhkUFNzYkl1Y1pkWG1PYk1JM2FieG8wT1VjdFI3Y3FnalJhZ1l1SkJ4MWE1?=
 =?utf-8?B?cUZvY013UklacllsTW5jKzMyUUJ6NkgxS3lBYkxQTnR3V2VhRXBnSm1lVDN6?=
 =?utf-8?B?bjVjaWMvek9jZ0VCWTlzL3hJbUFMeE5ianEzUVcwanI0R2grQmsyMDRjOGFC?=
 =?utf-8?B?Q2dNRzZtWVB1Q015cnZ0N1BnUjdIa3IvN1FQSGczc0JBSWZ3WXVvZ0dZT2hL?=
 =?utf-8?B?QkRQWXJxZkZPMTNkNFNxck9iM0crcnlHNjB6dEZ6ai84RmQrVUpDUUJFdnpQ?=
 =?utf-8?B?U09JWjlUK0Y5N2NhOUhTdWw4RjZ0WG9ra2I4VXo1OUhNNDJRcjVuM0xmang5?=
 =?utf-8?B?dWZZMUprT2JZNFo0d2VqZUtzaTg0SWFTcDBwVU05Nlkydm5sRHA1ZU92MkJF?=
 =?utf-8?B?RDUyZFFPeTB6ZDN1Z2V6NkFldG9SR3RhYmdDd3M5VXpnRjVNUWVMdDJQRWl3?=
 =?utf-8?B?a3N4WDRhMU4yWWo5NTYxTDdwbmx5clhkU0k0UmdvUVMwbXVpWnp5UUs1MHN4?=
 =?utf-8?B?U2ZiMXl3c1hSU1FsdjJEUWkwOXhzck51OUdna2diRnZyTm9zc0duaFNCTXV6?=
 =?utf-8?B?ZHl3dkE3ZDJYZnNpbnRxRUhCcjZ5QU9wd2E1cGFkSUxwcGJrR1ZobTBHU3J6?=
 =?utf-8?B?RmxZWnhEUzlZb0h6RnBtZ0VkdEZXK01WS01oNnJGRlowNUdnZkJ3RTVnUUU2?=
 =?utf-8?B?WnhqWFd0Z1ppeC9xWG5HdHpzc3ZWbG1pTmY2S1hhVm1kYStXWUVjK1lYMjR2?=
 =?utf-8?B?TFd3bEEzclZKa2dUbzRXUk9PWlREaU1kcTUrT1lEc2t1VkdwN1RxVCtJU1J0?=
 =?utf-8?B?dmlpMzVoSXB5UkhDaldWSFd1SWFRUUM1cERIMnczYVU2V1p0Sm1RWGhJT1Bs?=
 =?utf-8?B?SVhrVWJtWnR1a3FFYUlzd2tXbFZDeDR5YkIyMFM1Z2hpNGhwTlBSaUxEbFlO?=
 =?utf-8?B?QnpHMHd0cjZNa291cnJhMjc3SVptUmZDaDZuNGlyZHlReWdnNDdyQUtnS0ZB?=
 =?utf-8?B?aU1nN1lrV0h0K1pJZC9hc3N0NllyWUFXZHRHWnN1SnY0MjRhS3hYeXBtdmlw?=
 =?utf-8?B?OGF4VmRnNDFET0MxbWYvV0Yyd2xSRVBTR1VOT3lySGM1SjhPQnpxbTdtNDJh?=
 =?utf-8?B?MWI5OUlxTDQ2R2VCYUQ5eHRZcUVYNVdERW9yS21YTHpaM1NxZmg3cVh2UXJG?=
 =?utf-8?B?UkVwWm1JZ0hKOWoySlhBbE45V01mL3MydUtIRzhvOXY0TmNRMXFEYTdzWVpx?=
 =?utf-8?B?b09tQTk5UXh3cEI2QXNEM0VLNTNPV2FiS1pPK0VtdklHdDFOUmp2QVFkcmt4?=
 =?utf-8?Q?lQZ2E5yMfDBtQvF7R5zo3zqfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bdc729-ca33-4d53-0d37-08dd02d47798
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 04:42:52.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLQqgFJv4QwT92t/fovJb2naHNXG/3tq/l0y6o7sCrp+vGxDpwLmD9fZH6IWFTEnxX0cBxQyRiY03T2gtbBodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879

On 10/15/2024 9:41 PM, Paul E. McKenney wrote:
> This commit adds an rcutorture.reader_flavor parameter whose bits
> correspond to reader flavors.  For example, SRCU's readers are 0x1 for
> normal and 0x2 for NMI-safe.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <bpf@vger.kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 +++++
>  kernel/rcu/rcutorture.c                       | 30 ++++++++++++++-----
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1518343bbe223..52922727006fc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5426,6 +5426,14 @@
>  			The delay, in seconds, between successive
>  			read-then-exit testing episodes.
>  
> +	rcutorture.reader_flavor= [KNL]
> +			A bit mask indicating which readers to use.
> +			If there is more than one bit set, the readers
> +			are entered from low-order bit up, and are
> +			exited in the opposite order.  For SRCU, the
> +			0x1 bit is normal readers and the 0x2 bit is
> +			for NMI-safe readers.
> +
>  	rcutorture.shuffle_interval= [KNL]
>  			Set task-shuffle interval (s).  Shuffling tasks
>  			allows some CPUs to go into dyntick-idle mode
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index f96ab98f8182f..405decec33677 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -111,6 +111,7 @@ torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disab
>  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
>  torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
>  torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
> +torture_param(int, reader_flavor, 0x1, "Reader flavors to use, one per bit.");
>  torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
>  torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
>  torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
> @@ -644,10 +645,20 @@ static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
>  
>  static int srcu_torture_read_lock(void)
>  {
> -	if (cur_ops == &srcud_ops)
> -		return srcu_read_lock_nmisafe(srcu_ctlp);
> -	else
> -		return srcu_read_lock(srcu_ctlp);
> +	int idx;
> +	int ret = 0;
> +
> +	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7)) {

Minor: Maybe use macros in place of 0x1, 0x2, 0x7 as a cleanup later.


- Neeraj

> +		idx = srcu_read_lock(srcu_ctlp);
> +		WARN_ON_ONCE(idx & ~0x1);
> +		ret += idx;
> +	}
> +	if (reader_flavor & 0x2) {
> +		idx = srcu_read_lock_nmisafe(srcu_ctlp);
> +		WARN_ON_ONCE(idx & ~0x1);
> +		ret += idx << 1;
> +	}
> +	return ret;
>  }
>  


