Return-Path: <bpf+bounces-41953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D899DCB3
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F4F1C2161A
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4A16FF4E;
	Tue, 15 Oct 2024 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dJ6fSiCa"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C482BD19;
	Tue, 15 Oct 2024 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962761; cv=fail; b=tQELBbFRzAdB3SA0E7YB1iedY5v2MOjQP0FSDXqcKvEV8mYzGdO/KmfJ9Oi6pRaC4jkHRsydaNT78IwqaDiFByf/JopjlILlj9nklvbJkHtc5MyrbEbPXk7wi6XGUs61niskisQlY9O7A/ruUplUSPMXF3I2E/EDzKJitGuNipw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962761; c=relaxed/simple;
	bh=SwVPbpaJHRyv0DpRnG6X/Bl5mqB2O3tbGcK2Y9Wwvts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cbN0R0V28+lHXrlysKJBqXhmPn9zCvxj49/86WSSY+YUYSx6k3/ZJuADCue/usgU+frLnk9d4PANMbU1/exLcPATsuQiFPqiqTAMvaLHLTGr0n4c7lS8TGy4PfVPvYDDdV4fkxmAAbc3l8oLOgzEBBgZuUywC13A02tr6ghAIeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dJ6fSiCa; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfADRauKQbwMHPa7EcAPREsjzib88s2Al6ZLONjmHgC8msRJtqdpRtzzsOlm2Aq62lrnB/YAKaCS9y7YTe2jd0YpCJVGMo5M0/ZGY1G4xmYBLhMUWcPho7dSlHFWp5zVmdDLe1W97m8kF0RNCR95+iyU9iBSleDLhDJY7vcohqmtgOaEFaOVs8FoDi7Fu+7lPXn0BgsjyHOb1zz65NGUtrcejmuCAd8D5gBDU4CWh1TnBOuoI5Yny28vlh76mCzvSXuIK4RuL2hl21FpyVJhY/Lpxh7B4oGn9tOlRBqRuBwLbL6MqYDJmd7GzqSSla1fhnv9fID4XFZWxoeG/1hOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7o8IKUURrAtW7ATKpEDBVycOw3tZqygA4dtlwDHh6Q=;
 b=VgSU/wygnivKrP8cDQ2DPdDmMWAVJCWT3Bfm+qKf1tybk+2Da5MHe2y/NjjJJYTrrZ4cEVAYI0+ydJWy0fI7YnoVZ79YmdTMFjFEVdpM8V6Y0aM/9D5P4Go7Cb4pnNbWG019gj2gAB5aGZ25rCowobbBw3/Z/ndb4OidticZfGxbfbKAeHZ7Hgv5L3RRwjoQIZycc7gESuHCGdvFeowQtmM/7I6MTc9UWQyBpfOQPpWN6w5JirANILTuz50DKjjySC1rK8jYzgN6sJTOzaF5TLX21qZmxAcDKNGJKe20kT4prSwFUhOCM0ozXvE5Tyhh9VjS0n6TDlwVR0LxwFj3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7o8IKUURrAtW7ATKpEDBVycOw3tZqygA4dtlwDHh6Q=;
 b=dJ6fSiCasHW2BEFG2O2RxuB9MCz3fW+Uy3pVhuy3hVUMmKC9UUrwerqr8Da7F3cl3O1qpwhACp10FGincBSSej5biFiecf2aFp2YNf4FTB63QtYeXFFRa0LOWrkFTFhOcNPraAwupRVs1tEuzVAyj9iIRVp49XBCTA0h44bJI0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 15 Oct
 2024 03:25:56 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 03:25:56 +0000
Message-ID: <f623f471-e874-4271-8469-8754a87c154e@amd.com>
Date: Tue, 15 Oct 2024 08:55:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 03/12] srcu: Renaming in preparation for additional
 reader flavor
Content-Language: en-US
To: paulmck@kernel.org
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-3-paulmck@kernel.org>
 <6853d494-0262-4a6a-b538-338695677f57@amd.com>
 <36076d14-6732-4bbc-b96e-9bab1212c9dd@paulmck-laptop>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <36076d14-6732-4bbc-b96e-9bab1212c9dd@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::13) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bff13e-ea50-4059-b6ae-08dcecc914e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qks4SVl3NDczUGNwa28wR0NGT01PSWVrVEt6T0VxN0ZOb0t6djZOYlBwV0kw?=
 =?utf-8?B?WjBSeW56cFNaREpkUnp1OVh5K1N4NThlVGhuUjhoa1VsTHVLOTZBWFU3Y2xQ?=
 =?utf-8?B?Q3lkY21rUjh1aVdkNXdjWURQeWpnR2Exa0lBZlM3eGo5L254MTdJQXdMck80?=
 =?utf-8?B?ZEs2aEZrSlBuQTFVT1BFYlVnRG5kaXZlUmdsb2FQYVhaZ1hDOHdtdldSVUtG?=
 =?utf-8?B?cnZJU212elpQa2tsREtRVVVkWUsyaGxaRE10T2pmd1V6cTlUM2FpbjFqMnhU?=
 =?utf-8?B?eEFhUE9aUDVMZ0VINUg0ZG03aEdKS0EwWVN5MDNJdGRqZm44SzNSQktBY0Zj?=
 =?utf-8?B?ZUdRNlhEZFBNejVKWjREcXZnbHQrWXhLQklTUHB1TG9tcVE2Um1hekxRRTBn?=
 =?utf-8?B?MXZlekpDUS96Qytta2lDMEpWd3g1eVNpY0s0NFVoczRRcVA1VFNuT3NrVlFW?=
 =?utf-8?B?OHI5ckFDVFJBUWxoRnEyRkZ4U1NUdFFvUXpQNFVkcERMOS9uNnV1LzBMeXpt?=
 =?utf-8?B?eURjYk8reFo3NGhzWTdpWEkva09lZjNlTWs3akM5S3VYNnBWRk5yM1pPc2U0?=
 =?utf-8?B?VVRmRUQxemdJWlRXeEFYREtDdHFTUC9NTzR2bXBjRTdaYm1RZVppYUF6UFRt?=
 =?utf-8?B?RjNSMkdkOXAxRCtjT2k3STYxL0VrRGpjanZhZEMvOG9pRmdvdW5UTnRZTEJY?=
 =?utf-8?B?cElnZXlPci9hMm1NYTRDekZ5eTBQMW1rR1VHRFRiS3BFTnUrSHY0Rm00UERY?=
 =?utf-8?B?cm5mL29Cb0x6M1p6ZXhmWXhhNFpYdnVvblhVZzJZYU50OU5oOUZtVG96aGNl?=
 =?utf-8?B?WHhDc2dqN0pVTkpZYzFnTUdzTzkyN0ZJdVgzazBjK2N0ZC9ZY011UVdnMTVO?=
 =?utf-8?B?VW1CaXZlS2xhRVp4N1NyZFI4dXhnZ2xxZ2wrWjVhaWNmNXR1SjZQQUx2TVpx?=
 =?utf-8?B?ZXNac2UyS2k0YlhPWE1oaG5aVXFkZkpIb0dKZ0VIbVpUV2dZOEFsOURCbDZU?=
 =?utf-8?B?eUxJMjYyU3pvc00wbGl2QVVBUThsR04vVGRWaytuSlR1UThabVA0OHErbSt4?=
 =?utf-8?B?SmNRYnVEaGUyQkk2d3dld082ZEtJS2FMWUQ1Um5COW1LNVlIY2pyRy9ZSFl0?=
 =?utf-8?B?MFBUM1Q5QTNPV0kvRDlwZFNuSDdwcUtveVBiK2NpUXhtUS9GdW5OTmFjVjZW?=
 =?utf-8?B?NzFWRTYvSlEzUWdVVGRvbWowREhHV0xQOEpMWnZoRXBnZUJ1dGVFSGRzaTVn?=
 =?utf-8?B?cm1sMzlWTHZHMHVpMWJQaVJBblM1dHZBV3JRQnMySlBlSVdJYjNzcUJPRzZu?=
 =?utf-8?B?OStTZXV5NDEyRnUwTHJYQkJYVGNlSlkwRGFrZEozUllONDdjaCsvT1RWS3I3?=
 =?utf-8?B?WERBbzdGNWVsNkxQUmdRTG1UcmNxYjRYZjBPN0Z5dGpza2s5RU42bk5HbnlH?=
 =?utf-8?B?L1B4TmxGam11QWpHME5yb2pBV3czWjlxbFRMbC9pZVc4TVQzdnpENFZ0eGpx?=
 =?utf-8?B?aU1ZZk5sMUlFejNNbGdBTHloOGFoNE80enRHcmgvT2VIdTB2TzZNNU5LakRV?=
 =?utf-8?B?WGN0dVVUUnU3YWdNZzEyeTBFZDJSN0dMMkZYWW96bGxCMGp2Sm9XQTl4ZzBx?=
 =?utf-8?B?c3lyOS9IRkVUTjZYWTNRZ2pHa1RFOVJyQnhLMGZrMjkrVmhnbUFNNzhCY3N3?=
 =?utf-8?B?b3FhQVdxOUFNWnJONUdaZGJsWWhvUmFXU1czK0dqWm05eklLazBlL1dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0Vqa0N2TzVUUFBMQTFYbFlHc1gyaTNHVFpGRWk3bnQ5aGlWQzlxY2w0cVl3?=
 =?utf-8?B?cHBZMkJpczlOSkRVVnpwYnVHcGpsQTE2eGdjUkdlemxFM0NlOG5GZjJnclRx?=
 =?utf-8?B?SmxnNGVUVEQ3ZDZWOGgzeFNJZU95L2RmY1hrLzhZemJDcXMxL0ZXdlFQNUUw?=
 =?utf-8?B?YjN4MDBwT2VZdXVISzlFNWVMYXBUZjZKeDZUT0xRcDNhRUxvaklqRFliTFk0?=
 =?utf-8?B?bFJrVGRZcTFBZUNpcVdtMUV4Q3p5ZWxSUE9MUjlob001VGdSR0VDQWJsMEcz?=
 =?utf-8?B?MXZWMUR2dFZvZ1BZekNCRUpvSTJyeTB1MVVJeUFSbk93TkY5MGN2Z2tMbWRi?=
 =?utf-8?B?bUdwYU9aVUlsNnRFS2NwQ3pvUlZrSVlwMTRodjlUYXJPWmc5MmJUOVZyT21C?=
 =?utf-8?B?cEZiRlpQd2ZTWXByOUp1Vm9xRU1MVTdEVXArbDViMGJqSXVPcjRKVEt2NlRH?=
 =?utf-8?B?WE51eTFiNVU0NjdPYkkrVTY2VDdzbFI5N1RYYzhMOFV3WEVQcGJFNDZsMzI0?=
 =?utf-8?B?b1E3aytnMXVUSEE4c2hodnQ1VUgzVHpIVFV6UU9pYVVheWpxdndmdzcwMStN?=
 =?utf-8?B?Zi9GZlhncWdLVFdYaXdJRHhpQjY1d2JlVUJaRDgwNUFkanRZeHhYSWQwOGZt?=
 =?utf-8?B?dDNhdUJENWN1SFNFZ1g4dlpNSFg2eGtjS0d0dTB0Ym5UVFFobVZOYWh3clA1?=
 =?utf-8?B?WXhmM1hjSGFkeEZpMjV2Uk5seE5MN1BKSVVxTFIvVCtKL0VjQjJvUFEyaE1u?=
 =?utf-8?B?dVNXaVE0LzYxYitSUXE3dGU0WWtFOVVKSG95eVVmNHlxa3lOQmNMWE5OcGI1?=
 =?utf-8?B?biszeml4Q1MrYXRzdHFnRWdJOGVTd0kyMEg0bG1MbDFvL1g1cy82N2JGeWpH?=
 =?utf-8?B?NkNURS9RSDBDL0FwRm1VQkdINzBIWHNrKzA1eEphUE1XYUl2OVdXWEhUZUNS?=
 =?utf-8?B?RFU1OGRLNVErZDExWDRWYW5qcGRYR3dLbVBiVktRUjRTOUZnY0NRY2FlTndi?=
 =?utf-8?B?bitUTjQ2WUxUK2M2ODdTb3VaWU9zZURJOGtTMW5xTjdSTE1IMmcxVWZEVldX?=
 =?utf-8?B?VUtSc3lhemNKbmVSbkVMSlNmQjREc2JjRW9qaWwxaExLS24rNTkzUHB0VGhL?=
 =?utf-8?B?U1FJcDBFdE1DVGJjVkNUQXRjd2c5Zmpyd09UQlphVXhnenltYm1FcVkyNWJJ?=
 =?utf-8?B?UWRWNlpHREFGTDNLeUtmUjVETnR5NmxpeklFTFFWdFJzOXpzZkI3Z0xHWFc1?=
 =?utf-8?B?T1J1V3YrM0FaTThpSW1MMldiU0JBdXdWWktzVGwxSU1vVzd0cjFhV0gxZEth?=
 =?utf-8?B?SmNrMjIwYTRuQVF1Qzl1U1N4dEhRU0syNHBmSDdZekhuaHZhNzQ3TjNxRDBN?=
 =?utf-8?B?NTR3NldSTWR2bHF0WHh3Zi8wcHB3bGhndnMyckFDd1hCM1gxQWJ0ZXowZ0t3?=
 =?utf-8?B?eDFBZnhZK3FKd25jTmxkY1lWN1l2WVNSNlFjbU94UDdhc1NQeEdJVEFkYyt0?=
 =?utf-8?B?M29FNzhOOHU2cU4rMUIxVU1xbnBGNk1zUDlUREdDZmR1Z3RxWEJjM3VFenM4?=
 =?utf-8?B?TUhSdmlHYmJ2c1RQZm5TNFQ2d0RySkxWc1ArOHhKZFh4WHlDclpIbExvQnAx?=
 =?utf-8?B?NjhVN0J2dSs2a1Y5UHRzazhtOTY0aGpGOExIVDdBdVU2dGFuZGJaY1VqT3FZ?=
 =?utf-8?B?cjc5dldVQzB6Z2I2THJmWXJkWlMyMTNpKzBNQ28rRnhSQVh1aDJYWVJZNEJq?=
 =?utf-8?B?SGRrdDJydmpVaHFXM1FKaXVyTFVzb2crVjJDZXFXWnRJMGpjb1lNc3Z1WWs4?=
 =?utf-8?B?cUZkejVIV0lvaml1WitRemsvRDZHMTlHRDJWNXBBdXVVSVN5QnpqaHZicGsz?=
 =?utf-8?B?eUtSSDhvamxlRTlJeHBMRzd3NDZzK3djMVlzNVU0SFN5VXZyekZqSDZTdUE4?=
 =?utf-8?B?bGkvdHc2UGxmTVE3RmVnWHQ4RFd5aHlHVTQ2cllEQ25IVDNoUHdPM1RIYnVY?=
 =?utf-8?B?MXFnUWwvRENKTGl2dUxQWHRjRThYVml1STFxa2dXZjRxZmVMQUxqYWtrY21j?=
 =?utf-8?B?azhLVUE5TTEzeG84UkRrVXllR0xwYXlEazkySWhaN1JoTCtZQjBIOUtBM2sr?=
 =?utf-8?Q?1of0LQGDWMZD3BquFcAtyXyr8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bff13e-ea50-4059-b6ae-08dcecc914e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 03:25:56.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zve4MGdfb9TOyGSKkMjjlb4p8UMWvNj5iFIG+DLfIvQ8DLdGlLnHMK6XHvPez+qzsMC0UZ5rB+mW3wohut4ZgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009



On 10/14/2024 10:22 PM, Paul E. McKenney wrote:
> On Mon, Oct 14, 2024 at 02:40:35PM +0530, Neeraj Upadhyay wrote:
>> On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
>>> Currently, there are only two flavors of readers, normal and NMI-safe.
>>> A number of fields, functions, and types reflect this restriction.
>>> This renaming-only commit prepares for the addition of light-weight
>>> (as in memory-barrier-free) readers.  OK, OK, there is also a drive-by
>>> white-space fixeup!
>>>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Kent Overstreet <kent.overstreet@linux.dev>
>>> Cc: <bpf@vger.kernel.org>
>>> ---
>>>  include/linux/srcu.h     | 21 ++++++++++-----------
>>>  include/linux/srcutree.h |  2 +-
>>>  kernel/rcu/srcutree.c    | 22 +++++++++++-----------
>>>  3 files changed, 22 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
>>> index 835bbb2d1f88a..06728ef6f32a4 100644
>>> --- a/include/linux/srcu.h
>>> +++ b/include/linux/srcu.h
>>> @@ -181,10 +181,9 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
>>>  #define SRCU_NMI_SAFE		0x2
>>>  
>>>  #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
>>> -void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe);
>>> +void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
>>>  #else
>>> -static inline void srcu_check_nmi_safety(struct srcu_struct *ssp,
>>> -					 bool nmi_safe) { }
>>> +static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor) { }
>>>  #endif
>>>  
>>>  
>>> @@ -245,7 +244,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>>>  {
>>>  	int retval;
>>>  
>>> -	srcu_check_nmi_safety(ssp, false);
>>> +	srcu_check_read_flavor(ssp, false);
>>
>> As srcu_check_read_flavor() takes an "int" now, passing a macro for the type of reader would
>> be better here?
> 
> Agreed, and a later commit does introduce macros.
> 
>>>  	retval = __srcu_read_lock(ssp);
>>>  	srcu_lock_acquire(&ssp->dep_map);
>>>  	return retval;
>>> @@ -262,7 +261,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
>>>  {
>>>  	int retval;
>>>  
>>> -	srcu_check_nmi_safety(ssp, true);
>>> +	srcu_check_read_flavor(ssp, true);
>>>  	retval = __srcu_read_lock_nmisafe(ssp);
>>>  	rcu_try_lock_acquire(&ssp->dep_map);
>>>  	return retval;
>>> @@ -274,7 +273,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>>>  {
>>>  	int retval;
>>>  
>>> -	srcu_check_nmi_safety(ssp, false);
>>> +	srcu_check_read_flavor(ssp, false);
>>>  	retval = __srcu_read_lock(ssp);
>>>  	return retval;
>>>  }
>>> @@ -303,7 +302,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>>>  static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
>>>  {
>>>  	WARN_ON_ONCE(in_nmi());
>>> -	srcu_check_nmi_safety(ssp, false);
>>> +	srcu_check_read_flavor(ssp, false);
>>>  	return __srcu_read_lock(ssp);
>>>  }
>>>  
>>> @@ -318,7 +317,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
>>>  	__releases(ssp)
>>>  {
>>>  	WARN_ON_ONCE(idx & ~0x1);
>>> -	srcu_check_nmi_safety(ssp, false);
>>> +	srcu_check_read_flavor(ssp, false);
>>>  	srcu_lock_release(&ssp->dep_map);
>>>  	__srcu_read_unlock(ssp, idx);
>>>  }
>>> @@ -334,7 +333,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>>>  	__releases(ssp)
>>>  {
>>>  	WARN_ON_ONCE(idx & ~0x1);
>>> -	srcu_check_nmi_safety(ssp, true);
>>> +	srcu_check_read_flavor(ssp, true);
>>>  	rcu_lock_release(&ssp->dep_map);
>>>  	__srcu_read_unlock_nmisafe(ssp, idx);
>>>  }
>>> @@ -343,7 +342,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>>>  static inline notrace void
>>>  srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
>>>  {
>>> -	srcu_check_nmi_safety(ssp, false);
>>> +	srcu_check_read_flavor(ssp, false);
>>>  	__srcu_read_unlock(ssp, idx);
>>>  }
>>>  
>>> @@ -360,7 +359,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
>>>  {
>>>  	WARN_ON_ONCE(idx & ~0x1);
>>>  	WARN_ON_ONCE(in_nmi());
>>> -	srcu_check_nmi_safety(ssp, false);
>>> +	srcu_check_read_flavor(ssp, false);
>>>  	__srcu_read_unlock(ssp, idx);
>>>  }
>>>  
>>> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
>>> index ed57598394de3..ab7d8d215b84b 100644
>>> --- a/include/linux/srcutree.h
>>> +++ b/include/linux/srcutree.h
>>> @@ -25,7 +25,7 @@ struct srcu_data {
>>>  	/* Read-side state. */
>>>  	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
>>>  	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
>>> -	int srcu_nmi_safety;			/* NMI-safe srcu_struct structure? */
>>> +	int srcu_reader_flavor;			/* Reader flavor for srcu_struct structure? */
>>
>> This is a mask for the reader flavor, so s/srcu_reader_flavor/srcu_reader_flavor_mask ?
> 
> Yes, it is a mask, but one that should only ever have a single bit set.
> So calling it a mask might or might not be a service to the reader.
> 

Ok. The usage of reader_flavor as a shifted val here and without
shift as arg of srcu_check_read_flavor() was a bit confusing.


- Neeraj

...

>>>  
>>>  #ifdef CONFIG_PROVE_RCU
>>>  /*
>>> - * Check for consistent NMI safety.
>>> + * Check for consistent reader flavor.
>>>   */
>>> -void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
>>> +void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>>>  {
>>> -	int nmi_safe_mask = 1 << nmi_safe;
>>> -	int old_nmi_safe_mask;
>>> +	int reader_flavor_mask = 1 << read_flavor;
>>> +	int old_reader_flavor_mask;
>>>  	struct srcu_data *sdp;
>>>  
>>>  	/* NMI-unsafe use in NMI is a bad sign */
>>> -	WARN_ON_ONCE(!nmi_safe && in_nmi());
>>> +	WARN_ON_ONCE(!read_flavor && in_nmi());
>>>  	sdp = raw_cpu_ptr(ssp->sda);
>>> -	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
>>> -	if (!old_nmi_safe_mask) {
>>> -		WRITE_ONCE(sdp->srcu_nmi_safety, nmi_safe_mask);
>>> +	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
>>> +	if (!old_reader_flavor_mask) {
>>> +		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
>>>  		return;
>>>  	}
>>> -	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
>>> +	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
>>>  }
>>> -EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
>>> +EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
>>>  #endif /* CONFIG_PROVE_RCU */
>>>  
>>>  /*
>>

