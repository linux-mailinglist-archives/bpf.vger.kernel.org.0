Return-Path: <bpf+bounces-60829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF173ADD9F9
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D91E407247
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBCF2FA648;
	Tue, 17 Jun 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xJV6QTYd"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40352FA626;
	Tue, 17 Jun 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179425; cv=fail; b=Tolp7W+DM5aKUWlhG3u0NPqBJNwT1/SQFos3DNTGiTOSzG18TEASX+Vf+KLulqYXyg1jdyhVwWh+EKZBSVXRcA7h9+ULYHTNie7pO0aXFoqlbik/ig0uRkmOSe6DqcImHKEMNJ6fmgAcRAnOWO30wKP5XPsQz+V9cl72hnyIH28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179425; c=relaxed/simple;
	bh=Kmq6t9AFCrRL8qzkMsymKCGt1Q1yFa8G9VpXfCnEFkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALKwRrVH87kN7MPEqj2f41FVh0hVtQAmoXjmE0DOH/6oQlB64rwlZapYDywGi3W3AY7eua1K4onAAfNNMtStf/p3f4p7o8eLHegFmVj/epA8L9aGhc7UACbuk60EYxyzVuyhbXBQaHvKoTeK5/e1B4Z1FQVIgYIjyB2HdDKY0iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xJV6QTYd; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRKT7Tc6B2Y7o0Bj8kCMNck1+X32jycuKzvMWc6/orm0CmFfaMrwvooAMI/2tx9GSCS8gsviVULNuU4cfWYmC7IOrw9ssCxYtGKdKbiPCkS/LSTNrhxnS45qlsz0YqhiTvNxdn19w5BR/ft6pIMMqfM8Y6f/BOtS5yHfzd20JPAwCRZWFq4KcjBO/8Op0hi+RuNcc+6oh94qt5hBl8J89xODUSkD/BXq2enZOfLJ22XeZhk4m0GmelBbqADTuDU+wAemGwvrpPACXSOY21jiqhm48BvpL6/6i7skV4HkwgfXfHJt9dJGKmxOLkMEw3drfjFui7/AeWsVd1+nLj7ibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS40hNbZWKObH2JGr4Svfzy0u7vkdgvxAzQaeFvfK7o=;
 b=icxvMLIx8VelS61AqzFrG55yo2kSnCx73PzdGF92jQ6IYY/m6cIu7yoIC2LpSTNJlFxoViU0nLh18APXG/mOxKRy1rE4j4GH0ydHbF++uMERJ50apo51SKN2vGjCkcTZ7K+rbdZx9XM6Ezrxnf0aSSJk8l7/fc4OjbAZcT05nDzefwscwNCJU4D4NEPHRxr9w4YroOpNnvmQEaEiXokJ/IJ+G7gcTcoKr/2os5hHl4zrqvXDWShtpwfD0K41CTyiuP/VJFB9Fpmaf/bYO+mHDuv3QYanHA/kLF5ElnYvr9Tu3IWpzcFd47QQNNYA1bZ+Eb9T3JNbd0IPodF/VlPG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS40hNbZWKObH2JGr4Svfzy0u7vkdgvxAzQaeFvfK7o=;
 b=xJV6QTYdEgVyRAm0Vdk+3jqAN5BiXStBxh2x6s1R1wkl5XXaj9NJtrMkDwUpvjxPVcgFER7pRshrmyTgRQhRB30nKLrfSzzPA5LTHZP4yrHLPMy6RiT8N0HHdx3z+qG7bbtEv5D5LDCMBqdowb95JbL7yL1/FU96aayx3zECgD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 16:57:01 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 16:57:00 +0000
Message-ID: <3b19f145-8318-4f92-aa92-3ab160667c79@amd.com>
Date: Tue, 17 Jun 2025 09:56:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethernet: ionic: Fix DMA mapping test in
 `ionic_xdp_post_frame()`
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250617091842.29732-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250617091842.29732-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::11) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7dbe99-9cb5-47e8-796f-08ddadbffa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEV6RmhkYUxrb09wSHQ1UVdCQUVnK291OHVWRERlamhSd29iMHY1SjJ6SkZT?=
 =?utf-8?B?ZjZTaDBIcmZLSGJ2WDJkbFA5NENnc3JOZlhBWHRzeFZpT2k3OU1sY0U4VEwy?=
 =?utf-8?B?MXdLRGRqZ29CQUNReEc2OW5lM2U0R2JKRm5MbFpaMHl2WkRvWFFvY1drRURM?=
 =?utf-8?B?cStHbUJGZkxqakswZEdtSUp5ZkxCTXo1cjhSRXJpYm9PZ2lEQzlUR1RGd0RJ?=
 =?utf-8?B?NVgxNzJscGx6ZDhnSzdZNHFWbkowUS92T1ZOTTRxeG10YWlHZlpldmI1QW16?=
 =?utf-8?B?VjVqS21sNEFwMnVLZTdrTmRVVnhWTExGL1hoZmxyMmVaalZ0Q1R0WFppSzlS?=
 =?utf-8?B?TFRleFN4bHc4R3FrZWk0MFlHY1lDQlJMbnkrY2J5NGFyTks3ZlE5WndkNnFK?=
 =?utf-8?B?ZE9XK2hKNTgvd3pkQzRxWnVYSVJTQUZORW5UOUU0MDlIVG9sMVI5aTNXeXJz?=
 =?utf-8?B?S2dIMnhWT3FMcXdvc0tiZWtPb0NsWmhJLzZqaG5mQWp6czlsVG1lUVhOczhJ?=
 =?utf-8?B?YzRrV2tOblRwNHhmUEhJQ2NHTHhVMFhXTGF4aloza2lmUTZ6R1F6RVJCV256?=
 =?utf-8?B?Ymg1VkZzUlM0ZWpybFdDQXJxaU5LSUZwcGh0bkFPbWRseVNTbStsOVpXbXpw?=
 =?utf-8?B?WktQWDhuMVdSWnVlQkd6R2dxbzVTVWh3NGpmYWdlYjRtR2t0TzlCbFgrUkpO?=
 =?utf-8?B?Z09qdjF1bldOdU9RNVdqYWt5aWlFdTUrTDZhRUw3bTVGdGR1S2EzUURRQ0Ns?=
 =?utf-8?B?UTJ3cEFsdHBJYzFqUVlzVFlVUzgrMXpoSmpvWlpiMXNGaTk2V0pmdW02SGhz?=
 =?utf-8?B?RjNvNTc2VXV1a0J2WTZpWlNHU29Oa3pRSkpIdGpacUkwOTQzblJpcm1Od0RD?=
 =?utf-8?B?eCtQMDBKM05ESWlwYm5TWGY4MW1EN3d1WCsreDMrVnN6dFdJV1p6ckpPSXBR?=
 =?utf-8?B?OGdpbWR6ME5yMXFYYXBHVTdJdGZrc2pLTCtDUHlmOTBKZnNTcEV0THZJT3Fp?=
 =?utf-8?B?d25HTWVQTkk0NnBad3dTWThBaUtQYkpoV1ZqQmJVY0loYjlNS1llOFB0Mk1l?=
 =?utf-8?B?RDY1dW5DOWtoYVZ6UVN0OUhBRGFZQnFMaEZpOVJpSGM3bU14TEgvMUhNMWpk?=
 =?utf-8?B?OXJpSjZZbTdwMCtYWW1vTWlRSW5CZjZEZ3cvVkw4OHpObDBoQmI1WmVsaGVs?=
 =?utf-8?B?UHNUaEFtNkV0cWExak5VUDkxTWIva1p5ZFNacTlCUjYwZURhMVZvQnZuRFhl?=
 =?utf-8?B?UkI5a1dja21LaUZkYjc1T0g5dGpHU3dGZzMxeCtxNElOYWxtY3Vhd1Q5RTlt?=
 =?utf-8?B?SExTT21HcXpzZWp2eDJaNi8xY0kxaURZcWVDWEU0VFpwdTVLUzdoZ0wwN29C?=
 =?utf-8?B?TXJ6aytLcGNzQlFoRU9iZzJZSzZGUDlFbDNsblJzR2lKWU1iWmF6VXlZRlZI?=
 =?utf-8?B?ZEZUVHdSdUVvODFXclBLazV6QTJQM0tzNFNIdEhZUjFPOEhPS0IrVWdyWTZk?=
 =?utf-8?B?aVZvM0VGcFRxclcxejM3UWRJQTdWb0Npb0FvdkhlZGZKcyszMFRyRHpsU1BL?=
 =?utf-8?B?ajhkYVFPaVZ5MnZSMkZ6aFB5TzFMNE1XR09uTkd6TW1KSldnN1Y4S2lsTVpK?=
 =?utf-8?B?TndzVnJmdXIvbjJpVzBHbVU3R0VEZmtVcXMzSVNwOGcwZkJnRTlhZE5FZDZD?=
 =?utf-8?B?cy9rM3FXbmNTTVNHc3hZQ1lJUlMzbHNXWDY2NGJjT3pzU0tmRHAvM1NmWEZt?=
 =?utf-8?B?NEFoVXR2Zzl0U0wrWDFhTDJEWnJGOU80OEtUSzN1TGlacHl0V0M4WWhQSEp3?=
 =?utf-8?B?NVJtRkF6V01QM3RvQlVxM21zMlMyakNFQ0J3R0IrUmdGMjBaandCNHJZK05r?=
 =?utf-8?B?R0Y4cDA2WVhmMlAwU29DK1F3NzUvK1FySWpzOGg5VnAranJrZzd6aUx3NFBo?=
 =?utf-8?Q?L9vTsxtoKkI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGsvZ01GV1FwUzExNURVYTFiUmtza1hmYlZQSE5iMU1HaERJZ01HSmhkUG1s?=
 =?utf-8?B?WnhUSUk2Ym5YM3lWd09CWUJ5bGtpQnhsWkhVVGFyWDh4WWIycnNOaVpFM3pU?=
 =?utf-8?B?cmRCaWRmNDdDZlY0VkgxNkJCckU1ZzJ5MFdqK0RTUW05dnpnY3pJblR4Zlk1?=
 =?utf-8?B?Q2lrUnoxbmxoeCtlTEllc1hCSWdONmpMUXVzdlNZZzVVVEVubDlSOHMzODlG?=
 =?utf-8?B?QncyelBsVVZId1BlYjV0YjBPS1U0NCt0Q2xNVXNjYXdsT3M0R2ZiQmpVNjdq?=
 =?utf-8?B?dlp4MjBNUzBhK0hOemV3SDN3U1ZGaHJXVkdzQTlYM0g5bUl4V1BnMDEwWHM5?=
 =?utf-8?B?eHlKTlpDbHpqY1kycm1FVUhxY0JIVXpFQU42Z2NIWmVGY1lCN0hQYmpvV091?=
 =?utf-8?B?dDFXY0tmSko1cVNSZTdQQk9EeXVUdWQwZTZpckNwTmdKcXB0ZFR0L215QXVu?=
 =?utf-8?B?NCt0Q2lsRzFCYmdjcjN4ZHJ1OHJsbHhHZVozQTlhZytlazRtendjbkZzZ0ZW?=
 =?utf-8?B?a2dDRGh2dk1sV2NVYnBld2RsaldlYUt4TVRIUHlQYzBkZGlMb0o3eWtzZ2Fm?=
 =?utf-8?B?Q2JibVJRNlpYUzVCRlI0a0FTWUZMRVliKzRXMDF4Z05UeHFTdHljcSttcHl5?=
 =?utf-8?B?KzRlczFMazNybTN1M2ZQa1R2VVFzYkJET0dHTlBBSjBkQkszZGxjbFk3TnZH?=
 =?utf-8?B?aVdOeUVMOUtkV3ZlNjhrMnV3ZDJTd2VBaW1Ld2NnV2lFNGZkOVZaUW4rS2s2?=
 =?utf-8?B?cnpKKzA1MW9OMElwbVlTNHZtTlFIOERYejNZTTZJN2VvRTdvbkdmcHdETnhO?=
 =?utf-8?B?dUhrV3ErRGQ3ZzB3OEF6bVBzdzRWYmF2bEZPajdWVGNON2VlOXpPSjJidWE2?=
 =?utf-8?B?MHNQTG1IZGltUnR4V29vNHRGM1FTa29WU0M4dm5BNmtnTk54QUYrTElyQ01E?=
 =?utf-8?B?cExwaWVaSjdTMnVTMURZQ055a3BiQk13N0N3T3hTNFVwNzA1NEJBb09JRXov?=
 =?utf-8?B?dzRuVkhzbDdPM1pDSGJYQitUVzUrQnZkWmptT2N4bUVBM1VKdk13ak9LVlpZ?=
 =?utf-8?B?YnpIdE0vRGpuSWVCUmFleUxCMmxISmk2d2JlWmhZS3R5cmpEQnlOT0VvYU5j?=
 =?utf-8?B?Z3NidU43ejllcVVnSzN5Y1g4TjRsenBDeVdVejlESDNjUk9EVWRnWnJFQU1y?=
 =?utf-8?B?SFZGTWhKQkhJeDduajlwTG9SRWRqSm5FeUg0aDYyK1pFZ3A0UzhUZkt3bnF5?=
 =?utf-8?B?NU9iNytpM05zS0Zvd3RhWnhlZUZkWjZVanpyY3pLR3FpRzY0dHlnOUptTjR6?=
 =?utf-8?B?aFZXSVd5V0FpSi96cEh3M0FQSGdQVktVWWVXVEx2c1hSNzhoVjkxWU1Tcy9K?=
 =?utf-8?B?Wm1sVjJ6WTJ5bzM0V21tUWpsaXBWZnNIWHNwUndsWU5RNUt5end6YmdWN0pZ?=
 =?utf-8?B?WTJqS1cvdXptUkFTYVJCYzJrVk14SEF0OGRDTmxrR0NwN0FBak8xbm5PbkZV?=
 =?utf-8?B?bHVZUk55aEN2bjd4ZnVXKzFOZUM4WnBlbktoaVdhWkZXWmdpNUdqVjJJYWRC?=
 =?utf-8?B?MnRtOFl2V1dtNGV2RkVWL3V2UDJwVGhmZVAvVWpWMnM0OUhlL2JHNXB0TG9L?=
 =?utf-8?B?NGo5VHhwQkF5WnhpUVUyUnhHaWlVaHBVUkVYbmJoK1pYOUNDQ2owM0t3WHVW?=
 =?utf-8?B?ZUs0a0hDakp4MjBHTkFQa211emhEZXBtQnRDamdNN3UxMkEzTiswOFVXMEtH?=
 =?utf-8?B?VXJGdjA1OHNLK0psWGpyeGJDTGZnUDFmVGVBYlpyQmExK2pVMzBpWUc4cFk4?=
 =?utf-8?B?U1ZNSjl2Q1JqSWxLV25hMnpieTh0ODd1cGdHNWlBM1h4cHQzSmxHYThISVVG?=
 =?utf-8?B?ZmFkMjRZTnRFY2oyaklrdmo3QmhSS2JUdXlWZ0RNR2puUEF1dlNUYVJWTDR6?=
 =?utf-8?B?dytOTWdyT0NSVnhBWlNSTysvQWRZZEJvVXQ2TldaMXNhV2gyUWw4YTQybktp?=
 =?utf-8?B?bzUvQ2UxLzhQQmJ4VkszeHE1UlB4K2hETzFhaTRpS0lDeFYwOGxyMTJ5Q0pJ?=
 =?utf-8?B?UGhJbzl6aW8zTjVnaVBubWFaUkRCTnJJUU1YZ0tpVmRZcEp2NjV5QW8vRDRV?=
 =?utf-8?Q?WV47+c5dXzHNnHGzbcSnb8Voj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7dbe99-9cb5-47e8-796f-08ddadbffa36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:57:00.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH8wNvJZJhJRpM034m+g4MsKFN3gUpWmYw67yWN8ZUHGOoUQt2eMvRZOCGX7He8ZizZ7jFKl1cURcKE690qL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712

On 6/17/2025 2:18 AM, Thomas Fourier wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The `ionic_tx_map_frag()` wrapper function is used which returns 0 or a
> valid DMA address.  Testing that pointer with `dma_mapping_error()`could
> be eroneous since the error value exptected by `dma_mapping_error()` is
> not 0 but `DMA_MAPPING_ERROR` which is often ~0.
> 
> Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 2ac59564ded1..beefdc43013e 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -357,7 +357,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>                          } else {
>                                  dma_addr = ionic_tx_map_frag(q, frag, 0,
>                                                               skb_frag_size(frag));
> -                               if (dma_mapping_error(q->dev, dma_addr)) {
> +                               if (!dma_addr) {

Thanks for the fix.

After looking at this and Olek's comment, I think it makes the most 
sense to return DMA_MAPPING_ERROR from ionic_tx_map_frag() and 
ionic_tx_map_single() instead of 0 on failures.

Then any callers would do the following check:

	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
		/* failure path */

Another option is always returning dma_addr regardless of 
success/failure from the ionic_tx_map* functions, but then I'd be 
inclined to use dma_mapping_error() again in the caller. This approach 
seems wrong to me, especially when CONFIG_DMA_API_DEBUG is enabled.

Thanks,

Brett



>                                          ionic_tx_desc_unmap_bufs(q, desc_info);
>                                          return -EIO;
>                                  }
> --
> 2.43.0
> 


