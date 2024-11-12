Return-Path: <bpf+bounces-44583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478F9C4D28
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6647B24EEF
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 03:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932902076DF;
	Tue, 12 Nov 2024 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jn3/dx5y"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A319DF7A;
	Tue, 12 Nov 2024 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381334; cv=fail; b=ik6WSN4HSCiK5jb4y9oRsrchqZaBmfOl/4dk0xAYLyD12tNPpCPl81lzneiPZTPSabKJlLlzPDZIrwSM5f4+Q5oB1e8xKJ/Q+TdXgvlXBrQfOjDscIDCIbuzScijTQDeBI+su62svl3iFgYgdvbpRnUJXm5wvTRGDb3tPsP6loM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381334; c=relaxed/simple;
	bh=wOdSKt+Oo+67qkz1aXeKwNk4pqnahMzR0XcoT5+w/aM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XZwyt1K+bswTc1veS9A9XkHLl+t69G6FvCKrFiVB5qRGEVHqg0c0BECi0CJVvfZJCQK0lMC2gmKtAW5ccpISQjvQopyWRGuhg52YDikggu/W3f09HRFg4kFutCEteh/m2gVeujOUlJvvrxS97Nbae5lKK+87biB95fG3GeQOwNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jn3/dx5y; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYsgO8DiXMxBpJhTKtwriqAj5oSCrih4DFVS1Cbwn4eJl6tfWCgqVOfJrWuKWae18/SZjGf9W/qVr33+ylJ0ZNb3JfNJbX+pxQ3rI6gHwx9uZOhI/EuLw9KcmipuSsWi4Nmd4WYaV443BARg8utr2Me6CVwwc7Yxa18S97Yq2+MnHYIbbIv6L2MXAYJSX8PjRbAJstNTTSenJ717R5XCsj9SyOPIR/x/PNmcw5eo2kAnm2YssiJSe4Guau2NtY2MvrMh5079DGcVOY6RIDt5L6rrdWSwwFPhsD25VHEOHgAsepeMj5erxKx6yG4b1s2zmc7XdCHHcl3LwIYYEE9/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTIo8pSDaURXqwAAIobO29uPSqBEyoALu1yvkyoMXr8=;
 b=gNmQLzJOVUoUK4qYger/C4RHpT8KuvEk1Mnol6/xITJZrkL21m/nKiAGzo+7Rigk7xwyd92jp8irLNRQrBmL6L3K9jCqHRoXkAn4/NZRE5UvVs85mVoGYAxdTeJJD1BA8CflODD79tyl3jDkGd1VUFKAoHArVAH5LAw/80+OSatv7hr51pkyIVZdtqkFVGFHYORxJwzfdepPLQYU4emIPAxYo06b5iz0Iv6ePCWhOGqHG3OHsmNi+tJN83m+SQa6LyYKb/sJgI0XRtnqbOh2zg3KfbKKQzq9FiNVGrXGp5BDUlssNU2OHmYDCksU31ZKXCXpRuvAbNalbnH5QQsGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTIo8pSDaURXqwAAIobO29uPSqBEyoALu1yvkyoMXr8=;
 b=jn3/dx5y5c5oHhlnnCg8c/ROxt/5aWEc5YY/Vazud5AzL9wxOFGQb5vgCoyvX2Sqataxo2MEsEkvBeNNaGy7seCrYOBzFSLikn665CB3ogCMN0mUsldjV3uHncSPt2EcLtKtBMz0x6IVHL38cAMCBwZkPS1Bcm1rFpBu+oCODgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Tue, 12 Nov 2024 03:15:29 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 03:15:29 +0000
Message-ID: <84b6be23-edba-4bf1-8d9e-1ecb59eceaca@amd.com>
Date: Tue, 12 Nov 2024 08:45:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 06/12] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
To: paulmck@kernel.org
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, rostedt@goodmis.org,
 kernel test robot <oliver.sang@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-6-paulmck@kernel.org>
 <e46a4c37-47d3-4a02-a7a5-278d047dd7a2@amd.com>
 <71a72bcc-ba85-4f86-9d41-cccfd433fa09@paulmck-laptop>
 <c15d4a80-2f27-4588-af87-9cf7cf3ad79e@amd.com>
 <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb24199-8fbb-41a5-8434-08dd02c842bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm5YT3ZSditwUDlRTzNTSklLNTEzYXFJRXZkNXFKS3JYR0ZJSkNnSGdxSG5O?=
 =?utf-8?B?ZWUza2U3Nm9XVlkxZVY5RGpoOElrenhvc3RkdVlEQkJObnVRYnZkUWtmRVBi?=
 =?utf-8?B?bHNIeUNLNFZDUCtMZjZJVEJQNVVaZndCNUNoWHRIYXBCWVJ5Y05IbWNjUjBh?=
 =?utf-8?B?Yk1YRDlLMGVmdE5DTWc5MmZZK0FkaC9CWTRjVkt0dTE3MEtRQjJBMnJrcVd1?=
 =?utf-8?B?WUpDTC9UZ1BvMEV4M1d6bFpYNGZBb0hObXFnS294dTdYSnFpVnFzMHl5azZx?=
 =?utf-8?B?dTg4bkhqYnZQMkRxWVdOU014MWdGYUFkR2hkeGVGRUFnS2RYL0xTTWw0ZVV2?=
 =?utf-8?B?RDFvYjdOQnJUelhHZlRDLzJrbXpPTDcrQkx6UmtrdDVySE82SE8yK2V0ZFkx?=
 =?utf-8?B?SWYwWE5STEt1ZFVLQStob2dvWWErNXFFNnJ3TkVFRWwzYkh0ZmtLVEhyRkd0?=
 =?utf-8?B?YWt6NkxNMURXbDVDeW1mM05ESi9oUHdRSDVYSE9CcVBkS05WaUN2WlEyWXow?=
 =?utf-8?B?bkl3VlZVYVI3UnU1VmhOek8zWnZHS2w5OEtMMnVEZndOb3Q2Y3JhRVNDc0FN?=
 =?utf-8?B?YlJmZ2wxZ254eUJpaFRhYURJZmVYNG9Sd3pmbXZaWU8rMW5PcjNmZHA2Wm5k?=
 =?utf-8?B?R1ZTUzQ0RWtqY1hlTDBXVzhKb2MxZkZJSmR2R25GQk9tSVBmc2kvU0JnTlc3?=
 =?utf-8?B?eHVSVFRoNzNFKzF3cHE1Q2NHUFRRMStCb2J5cVJEdFRldnVDQWtxMWZaZzZr?=
 =?utf-8?B?VjMxUEhlMElPVkp1bHpDVzNmVW85MkxMbkwrUTNUWDhkWE8ydklEenBPZEor?=
 =?utf-8?B?Wmw2K1JkckJKNCtOZFBOQVhkVk5TamlOZjM0OWNOTm85dTQ3djRVc1FtTGN1?=
 =?utf-8?B?dGEwRUZSV2VxcXFKRmVMc2FqQ3Vuamlhc2tYN0NxNktUcGpsUjIxdG84TVVj?=
 =?utf-8?B?TWpIbktOY3M5WlJPWHRPWkhIYnh6YWdMekdITUF3MnpYTGhSM0NJOHJwV0xK?=
 =?utf-8?B?N2djTW9yWVlONVFmbWtWYjd0dDNCSllTQWdqMHZoQ3hrR2xnekhsVE5PZlF3?=
 =?utf-8?B?NE9La2VGdnhXaVY5blg5N0Q1NTd0ekNkOG9VaXpmeFlVVHkyNmdGbTduTkkz?=
 =?utf-8?B?WlBEWWFibXQ5cWJMUGRmVFdlTGFSclhiNGx5eWp0MXRvWXN5aUxPOFNnbk5N?=
 =?utf-8?B?b2p5N2lGM1RsMTBCZkw0cXZUY2RVUmppclUvMVVVeXlQa3J5UlZVbGFOd1Yr?=
 =?utf-8?B?SlVwcW84TUtYK29xaWt6bDJlTjV5Yk5QT25xYWlhbUNSaDlwcFdSMVlsTXBl?=
 =?utf-8?B?SHR0eDRTNUsxaHE5UTZlcmdlTm94bmZ0R2gza2R5U2ZIdjQ1OXEwSWtHRzAv?=
 =?utf-8?B?KzdwTkFKazQ3cjFDQjcxb3o3RWdldkZMbnlya2tMVWs4TkhVMWZMa29HNHJ6?=
 =?utf-8?B?UDdJQjlGT2E3akhDTzNmdXRQZGxXSEhRR3ZCaERSR0gyOU1sOGRCd3B3NDVL?=
 =?utf-8?B?c1h6QWtETWh2RktGWmJlWVZYdzNhSmRwVTN6OVJxbm1hM1JicVF6OE5hSWRG?=
 =?utf-8?B?QTRpZ1NQdTluTG5mNGtXSHVCRllVTEJnUlkwTm9DQmppbTdjNDQ5dm9JSU1s?=
 =?utf-8?B?NU53SzFhYWt2eFRxMGpnU2NLd00xSjdYMkhHME9kODE1eUt6Z0xtZGJ2ajhU?=
 =?utf-8?B?SWlITC9tWTFCdXR2MzlDWVFidWtQUHNtQkZMeUhXNUJTU3gxN2FFdlFhV1I2?=
 =?utf-8?Q?Y1Ap3mR8sm54c0ZIMcbNjBK9JgeefpdBxD/DHPh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmFPNVVXbnpCdnBqRlRjVW5qYmF5T1hZZS9HMTQvamVWeU1vWnptZEFEV05x?=
 =?utf-8?B?VElXUzhXWnY2U01xM0VUV01UQkRjRWl3Q0s3Rkkyck5sSHdnSE5QQjd4NDVO?=
 =?utf-8?B?OUV6ZkZNV3ZYcmFzTDkzQmVzQWFvSGdwVDVzblJOKzBab3pqY1J2d1ZyVVcw?=
 =?utf-8?B?REZlclRSZzdQNFROeVd2ZVBvSmNIcGx3emtWemdhcjlOdmljL05nbjVpbUhn?=
 =?utf-8?B?Qm0zM0dITUJGUThWdUs2Tm5HcGVvS3JFcTlaZUxuV25Ud3FsMUVvRFdaZG9Y?=
 =?utf-8?B?blllVitHajYwd2RiTXhDMVFHOGM2eE16RXh5QmJjaWV4VkxtNHZxRm52cG95?=
 =?utf-8?B?dmsyOURNSkhCTnlRTHRmMEhLNStMUlBvVjhKYW0rcEtJdC9BWVpwakJVNHU3?=
 =?utf-8?B?ZzdORGVjLzd2dW42dVhvQjVJZUp0Wi9IM3cwNU5LaHJaTTNJRGc5UlpaVUts?=
 =?utf-8?B?R3J2cUMvVGhoVG9INzZnSzlLOFkxaDV6SzV4aTVPUFRjL2NJLzJBRHB6c0Jj?=
 =?utf-8?B?aFlRZ2JKREJxQ3VFQnd5bW01V2tZU0xTdDhab1ZVQWMvRGRlYnRBZndSZ2t6?=
 =?utf-8?B?bkV4SU5JV3VHYWVLdEdjbmk1bnEvcmQ0L3hVNGR3VmxucjlpMW14U0w0dmtl?=
 =?utf-8?B?YWJ0VmpmOEF4aFRQTTBTY05saURlN1JxWXU3a0pMQUYyN1FaQzdFUVBaZHd6?=
 =?utf-8?B?blpkYlJBNkVpWEFNQzRVY1c5ZkVCQk4wajMvcWlhMlFBUXVOdDdDZ3RoZCt4?=
 =?utf-8?B?cjBtUGRFZ1ZyUUdHVVp1cVhwZWdITktxNTVSRGRYNUxKRlJGallCMVBrUURG?=
 =?utf-8?B?WlZEU3BZVVpHZUJpRWs0SU91S0poek96UEJpeXh2MVhhQ0hudzd5THB4RkxW?=
 =?utf-8?B?UGptS1ZIMUoyOXNvUHNXeGd6MmJ4eHVGU0ZJRW5rQiszYkYzN3YxYjVDRlN3?=
 =?utf-8?B?eXpxcHM4c243OVFJdzFSQ3J3Q0dvQjAvdWJqVlhSYzFEUGE4Q0NtRzA0R1ls?=
 =?utf-8?B?K3ppazNGTEtJQXVPaDAxMDNEcEtvOXU5UVRVSndMa2dSSnBKL0pVeTNmaDFw?=
 =?utf-8?B?Q3FwRGlEWmRvOWFiMzBEbmRndG1jcVF4WG5xWE9JTXkrYTRMQ0JzRlZ2S1hn?=
 =?utf-8?B?elZEcHJUYWNtWTU1andoSzZrcDF1SnZXYk9HMUdpemRqY0ZTaSt5bjNJY1Ay?=
 =?utf-8?B?c0xEL3k2QlpxUXdjT0I1YjRGcHNPZ0E4cmdzOEJxQVNEOGt3RThkbHR2ZXNW?=
 =?utf-8?B?anNSd003Y3RqTVB4VDN1dUFEaERXSk1tT3FNbE5QR05NekZSYW03b1ZXZFZu?=
 =?utf-8?B?OXlXVG1IL2JmYjRPQjlaN3BlM2JudDZRQnp6eFB2QVc5bUJERXlRaUlST085?=
 =?utf-8?B?R1pnRENHVHk5U094VVE1UERWVTBaVXFUV3FTUndQZTNDeWdTOVJVelJsZFp5?=
 =?utf-8?B?T2xKM08vZm53c0pyeGNwYnBCWHNKMTEyUE1mYUo5clp2d2hObjBlNTRrYm5m?=
 =?utf-8?B?dGo0c1dxRDNyRURQdHFDN09DOWptb3BKdGhlWVBldjd4L1F0MEFycFVtV2hP?=
 =?utf-8?B?OUkzeUs2SEVEbStGUVBYVkREdjczcHBwMUNFWjU0MVBvbGR0M2RQUWRsRUYw?=
 =?utf-8?B?cGFVaUU3RmNvNStBdUQwNUlNemRxQ0x5M3FtMHFoWWY0NnAwdVkvQWFDR0VM?=
 =?utf-8?B?eEc3WmtZeDNGYUZGZS9KZmFLd3ZZd2V4QzJkdHU2YjloUFV3ejFZYmMvOFdF?=
 =?utf-8?B?OHNzUmtxbGNQZDNUUVdrUjh2aDlZMHhhaHdmRTNmUE5DRFliUzhvekw1Rlg0?=
 =?utf-8?B?eTgrV0VaSUlMOFB2K3NFNlNxWG1PTmswd0xoNE5VWnVwNmdsMGxSS2JXWU1w?=
 =?utf-8?B?enF3RG5Ba1Z0UFFwWjViS3Q3RzYyWU1RZFI1R2dRemFNdlU5bmIrL29LVElM?=
 =?utf-8?B?SVRxVDJrUVFCbHhEQllpSFhuTmRNSjRoV2tUZWp6cXJ6LytuT20wWC9od1JK?=
 =?utf-8?B?YkJKaVBEeGFvV2F1bWQrbUdUK2lDWWcwQ2xqRGp4VTFFeDdFQmw4Z2NIa0VY?=
 =?utf-8?B?SVZpRlBnRVh3eTNyNmF5QjhjeVJ5UnM0eFVCWG9nK3J1THczZVlmRkl5MldO?=
 =?utf-8?Q?KE5lTYaasOZU66B5/4OFjISu/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb24199-8fbb-41a5-8434-08dd02c842bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 03:15:29.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6bZZn3h93F8d0Un3D+zl7XXOt7Rh3TWF4k8Q/5YTjwCSa/pRx+/z3yKcUIxLRWW6er9CcAjQXyuM1IInOnR9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340




>>>> I am trying to understand the (unlikely) case where synchronize_srcu() is done before any
>>>> srcu reader lock/unlock lite call is done. Can new SRCU readers fail to observe the
>>>> updates?
>>>
>>> If a SRCU reader fail to observe the index flip, then isn't it the case
>>> that the synchronize_rcu() invoked from srcu_readers_active_idx_check()
>>> must wait on it?
>>
>> Below is the sequence of operations I was thinking of, where at step 4 CPU2
>> reads old pointer
>>
>> ptr = old
>>
>>
>> CPU1                                         CPU2
>>
>> 1. Update ptr = new
>>
>> 2. synchronize_srcu()
>>
>> <Does not use synchronize_rcu()
>>  as SRCU_READ_FLAVOR_LITE is not
>>  set for any sdp as srcu_read_lock_lite()
>>  hasn't been called by any CPU>
>>
>>                                       3. srcu_read_lock_lite()
>>                                         <No smp_mb() ordering>
>>
>>                                       4.  Can read ptr == old ?
> 
> As long as the kernel was built with CONFIG_PROVE_RCU=y and given a fix
> to the wrong-CPU issue you quite rightly point out below, no it cannot.
> The CPU's first call to srcu_read_lock_lite() will use cmpxchg() to update
> ->srcu_reader_flavor, which will place full ordering between that update
> and the later read from "ptr".
> 
> So if the synchronize_srcu() is too early to see the SRCU_READ_FLAVOR_LITE
> bit, then the reader must see the new value of "ptr".  Similarly,
> if the reader can see the old value of "ptr", then synchronize_srcu()
> must see the reader's setting of the SRCU_READ_FLAVOR_LITE bit.
> 
> But both the CONFIG_PROVE_RCU=n and the wrong-CPU issue must be fixed
> for this to work.  Please see the upcoming patches to be posted as a
> reply to this email.
> 

Got it. It will be good to document how full ordering provided by cmpxchg()
helps here.


>>>>> +	if (mask & SRCU_READ_FLAVOR_LITE && !gp)
>>>>> +		return false;
>>>>
>>>> So, srcu_readers_active_idx_check() can potentially return false for very long
>>>> time, until the CPU executing srcu_readers_active_idx_check() does
>>>> at least one read lock/unlock lite call?
>>>
>>> That is correct.  The theory is that until after an srcu_read_lock_lite()
>>> has executed, there is no need to wait on it.  Does the practice match the
>>> theory in this case, or is there some sequence of events that I missed?
>>
>> Below sequence
>>
>> CPU1                     CPU2     
>>                        1. srcu_read_lock_lite()
>>                        
>>                        
>>                        2. srcu_read_unlock_lite()
>>
>> 3. synchronize_srcu()
>>
>> 3.1 srcu_readers_lock_idx() is
>> called with gp = false as
>> srcu_read_lock_lite() was never
>> called on this CPU for this
>> srcu_struct. So
>> ssp->sda->srcu_reader_flavor is not
>> set for CPU1's sda.
> 
> Good eyes!  Yes, the scan that sums the ->srcu_unlock_count[] counters
> must also OR together the ->srcu_reader_flavor fields.
> 

Agree

>> 3.2 Inside srcu_readers_lock_idx()
>> "mask" contains SRCU_READ_FLAVOR_LITE
>> as CPU2's sdp->srcu_reader_flavor has it.
>>
>> 3.3 CPU1 keeps returning false from
>> below check until CPU1 does at least
>> one srcu_read_lock_lite() call or
>> the thread migrates.
>>
>> if (mask & SRCU_READ_FLAVOR_LITE && !gp)
>>   return false;
> 
> This is also fixed by the OR of the ->srcu_reader_flavor fields, correct?
> 

Yes, agree.

> I guess I could claim that this bug prevents the wrong-CPU bug above
> from resulting in a too-short SRCU grace period, but it is of course
> better to just fix the bugs.  ;-)
> 
>>>>> +	return sum == unlocks;
>>>>>  }
>>>>>  
>>>>>  /*
>>>>> @@ -473,6 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>>>>>   */
>>>>>  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>>>>>  {
>>>>> +	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
>>>>
>>>> sda->srcu_reader_flavor is only set when CONFIG_PROVE_RCU is enabled. But we
>>>> need the reader flavor information for srcu lite variant to work. So, lite
>>>> variant does not work when CONFIG_PROVE_RCU is disabled. Am I missing something
>>>> obvious here?
>>>
>>> At first glance, it appears that I am the one who missed something obvious.
>>> Including in testing, which failed to uncover this issue.
>>>
>>> Thank you for the careful reviews!
>>
>> Sure thing, no problem!
> 
> And again, thank you!
> 

Again, no problem!


- Neeraj

