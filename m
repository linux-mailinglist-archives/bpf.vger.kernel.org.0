Return-Path: <bpf+bounces-77385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B6CDAC87
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 23:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F8DA3022AB8
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 22:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE08A288C2D;
	Tue, 23 Dec 2025 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Z+tp/TI2"
X-Original-To: bpf@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022082.outbound.protection.outlook.com [52.101.53.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B212262808;
	Tue, 23 Dec 2025 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766530762; cv=fail; b=Wmk09cS99TppLWnKhyeie/MwkxyR2CppTuMHZwLYovtOT8P69+e6+bPMI+HYkLeJ3VgR61fqGe1yq8jYcGNTxbT6rM0hsUd767b8QInbVny1HG0vjO3t3SxzPo4IZ7kfnloZ9DhwJrqg6HJN8hEDb+5uuFkdbPHzm4uwPK65DDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766530762; c=relaxed/simple;
	bh=iUketmhBkxCtiWDTCu0RnsJF2h+2wct5stQVeH30XBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TY3HwLRJYaPTqUx6o+8CzDumzYet3HT7aNeM3c6UnFtA7vM0eoIhmPwcsm/eVWce0b9cZlq+sZjBQT1PEWY3Y10CQqHUfuMJtlp8CRc8W7+UQtucY33wGOLwzOi7GyAFc/JEzVBFI8OISMGyubuPwnzrHI2oA7pMBDHZnYybdNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Z+tp/TI2; arc=fail smtp.client-ip=52.101.53.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4f/PaPquPdGHmiEOmqSnqBra9bXUvbD1ZQzpBiE4rJmF9XPj8QQZcaov/4RcuKTLyXiOeHt32R3YjdT4PcNJH0HrUhoeJtgaA73GVQqNY57m7N9G4Kp3O+UFGg/vcvtEL4tbWadCsK2rwi9b+yOF819eV44d5CUyxBwP/tGEPffcFOeiTdX+CVXJG18jEmsOFV7yLLGMDktcohXCwKLJrw/CcoFzKR+VJlwbDKd+iJ4yQ4aE3CB7QbhonpCcBkiie0UJZ/d8eCICZC9sNBvoKhU/xXDIHsMNVPVBdXR5ZOOrPW1iHmdQaiqsp2CABc4o2hARvkp86Bvm9wqZ47rCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6BjARq/2ftL2KHourjgvQlb4pQC+tu87JQxshCG4GA=;
 b=N1eG76Mb6G7rQXCqftLcH9UvRplwx7tV5O2M5yff1L8tdAZwn2W6Z+Qesq28skUz7IKn24SyyD2l0ZfGXqG7HeN/rSz8RUusuIxAs3Z3FXRkJwe7HE4GHXw55/J9YfdoUNJ3PzWnVRgEOjQlQX45KAxoYwVZx6SZ6DSRfxLZ0RXtP1uoq/td6Iyu9X9Bca4sDYpISuAZ6jQPbzlFS0vSfvz13jJYjE6YqgysazgmqUlpEjzDsKla/MKXx6g1CTPs6niB3b1WIhw8DCwFHgueCYB/E1gzk3u3kB+3Fqa+D/A3ZQAu86g/PpsgF3zTA5OnGV/QK5epqkwRMJvYvVtWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6BjARq/2ftL2KHourjgvQlb4pQC+tu87JQxshCG4GA=;
 b=Z+tp/TI2/u0L34UC1kDgpAXGsNeTGgnLSoPaVntGEHSXR7j4qyPvbJvigawEmLiz1sbLawV5Ns3WizI9/GGy4nYj10J/pjcLaydFh1y2hUw1fDlR5ouFaR/7cJMfoMSLHp67nZhhQslg9lG0MFm6KmRjgcABjVLPeD9yRwc+zyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.11; Tue, 23 Dec 2025 22:59:17 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 22:59:16 +0000
Message-ID: <93327680-7d7d-415e-958b-0d2a667dbb52@os.amperecomputing.com>
Date: Tue, 23 Dec 2025 14:59:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
To: Ryan Roberts <ryan.roberts@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, catalin.marinas@arm.com,
 will@kernel.org, kevin.brodsky@arm.com, dev.jain@arm.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com>
 <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com>
 <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0059.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::10) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV2PR01MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: df6c14cf-209b-403e-ab90-08de4276e618
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkxvNXFMbDBZVUJ0c25mSVhDcVVNN2orRSthN2RuUmxYNEJUY0ZUeGNGWTM0?=
 =?utf-8?B?Zko3bzloU0cySGc4QXMwbWQ2cG0vd0R0czEzNDlZazJCSmdkTm1xckl6MU9Z?=
 =?utf-8?B?RnRQZzV5eWJHS2s2YS90ZkwvcmZVR3Z3UXVBWFQ5SktoS01nVGpHUXUwMG1O?=
 =?utf-8?B?VWpWcmw0bjI2YnVBQ0lFSk1VZnhoNmtNV0JyNGVzV2haVEp0Qk9TQ1c3V3JO?=
 =?utf-8?B?TThiMVFKa1ViQlA2UWVGbUF6UHVVVGNZM0VHbjVWcm1uOXlXS2gyZHB0Rktu?=
 =?utf-8?B?ZkJUdVVVcmI3Qlh5SHY2T0tsZWdTTFd6b0E5ZzRReVlTSUt2QVhBZGtLT0di?=
 =?utf-8?B?N2xTQ1JIZU9FNVhBbHlDY2w3SlUvTFdIbm9DL29iQWJ0SS8xZ2V1MHBXZmx0?=
 =?utf-8?B?QUhLMGpTb1BINmdaZTFSZVdxMHFpL1p5SkFRZkRWYVlRbWZQOFlTaXhBNUlT?=
 =?utf-8?B?MFFQVE1vU09DMkxoS2c5QkJnRTFQZkg2THF5cHR1WXp4S205TnBvZUV1WVhO?=
 =?utf-8?B?d2p1bUhyYUUybCt2c1poZjdQcWUrMzhYbFlDTUN0ZHRucXFDcm1YL3RRWVg5?=
 =?utf-8?B?Y0ZiVmNmNjRORFJtM3I5WTdvdWFxaklES1lLUjBReWkwWVBvOFpWNUpwUzBG?=
 =?utf-8?B?RDNZOGNCYk9kalkvR0lPeFJJNXFJQnBIdXFiNUVrOW1WS0Z0TmNSNmFvczNi?=
 =?utf-8?B?SzEzRlFiRThXc1F4RVcrUmFHanRpWEJMeSszZW53cVFBSEIxZmJwcTNmWlU1?=
 =?utf-8?B?Tlhxa25OdWgweXVmaHdlZVVHTnhMdlJocHhsY1IyRnhOK0l3eGw0TG5pc2xn?=
 =?utf-8?B?UjlhcHlDUmxVRm5JeDFLWk9SZ0YwUnZIbmxMNGp4b0lvUlVSTWpsUWRFL0h0?=
 =?utf-8?B?NkdOdEVZbmlSTTJBaEpkbjF1TXl6aUlWcmgzMFlTVllKOHlIc3pJYTNMYVZW?=
 =?utf-8?B?bHFnaFQwOENNUmhmdXp3NUZ6YnNYeDBVQXpza1JlV2ZrNzZiTG5aVzBka2Q1?=
 =?utf-8?B?R2RZZmh6dFlQYkhzT0UyMkhuVmNpdzRkNEJBM3VRbHB6cTl0UE9QQ2RTUmRv?=
 =?utf-8?B?ZlFOU1VwTnVsSUFhZDNkdnNkWUM0ZzhHY1NMbnRBbFQweEZtYkVtSEJZNzM1?=
 =?utf-8?B?b0lmRW1sdTEwY0h3SnFTSTk4bmpwNG4yY3c4bll6UUJ6OWdZSmwrUlhQVXRG?=
 =?utf-8?B?WS9mUDllSUVQd2xuekZmOStnS00xM2VDRTlBMnpFN0h5RlNtUWtWRGk5M2xl?=
 =?utf-8?B?MlBmLzR6d1BQZWs2bEUxWVhUL2UwMmlNczB1aDY2RGYvaW1hTmhEckdDYTlB?=
 =?utf-8?B?YkVIZlhXR2FyRy9TWDlXNEwwWnZZL2RueWl0bVlRK3JlR1BHM0xXZXBCMXgw?=
 =?utf-8?B?K2xNeUkzdm5kODRJT1E5R2cxdmxEQkFISnVKN0tpcUVFSzVjclgzWkdFUk5X?=
 =?utf-8?B?d0dJbGlBTzBORW5mS1pHTzhCaGVKRUxrUmsyT2IvKzE2MWlPbWptS1RQM0Va?=
 =?utf-8?B?Um4vVUZ4OFlsSjJVSjNSZzhPRDFiZkJEOEhPUStOUFBzblVNcVVnL1BzMmRY?=
 =?utf-8?B?WjhkKzFKYmxkeFhxQXI0Uzhjc0x4THRJd0ZoL0ZmZy9SdUlGMXhqdFMyU2pC?=
 =?utf-8?B?VzNMbTNWZlZyNllWcnNXd1RsalEvbFErYmF6QnJjQVRTZWlKSTliK3BHQ2tD?=
 =?utf-8?B?aUpkNG9sZ21OdUFBbERtaGpHaWZ1UHdvMXJKN2pkczNnd3N5WVNnMVlnRHlz?=
 =?utf-8?B?QUhCQnFnL3RFUjlnUWxiOUs1L25IV0NBS2pGQUFEcG5oU1RUeUhmVjlNNDBp?=
 =?utf-8?B?NXpYQ1UrZDljK0JxcHBob2VzelhlUW9Jb1lQNUdPTTRqZHlHNHMvckgvWmJH?=
 =?utf-8?B?OFJZTVc3T21rZzB5MXFxenh2NTlwbTJiRzRWZmphQXZXVnQxeE9EM1NFK3F1?=
 =?utf-8?Q?2iuaRz9puFDc2hX5hVSKrmsnlAyeiB+1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azM0c3lHc0dXRjF0QlFLTmQ3d2NSNGlJTVFWbkliVGZZVG1Eck5Majg2RjR1?=
 =?utf-8?B?WXFqSEVIQkFWbm5QMFBuazhoelM3eFpablp1UDcwQnpNTFRNVk81c1NqaURU?=
 =?utf-8?B?cVZpUFcxc0tnWDNlZzZyYVBNaFgvRUVHQ0pRb3JScUlMcXJMMjBJZWxzQllQ?=
 =?utf-8?B?YUZUQkp5VGlaYWk3VHNZR3hpTmJDN3lNWnZzdXpucTJIelFNeDcvS1dBMmtt?=
 =?utf-8?B?b1NSTkxSRFByRUJxdzQvditrQU1HeGwvd3dQTkt1TEN5anV1SDFKK3dQV0Y2?=
 =?utf-8?B?NGRwVWY4TVJ1YXEvWmdFMkRZQkFDaWE4OFNhZ2xRSnUzMmRld0IzT29SSHV6?=
 =?utf-8?B?UEVvcTNscjhYRHRadWpFUEY3YkUzK21Sem1yWVYrTUVRTEdKdGtUVTZLcXFz?=
 =?utf-8?B?Y3R1Z0V1R2lmeC8ycWRPUTA0eWZ1bUtvOUV1NGhrYUVZNG1MbDFDSUdxc1cw?=
 =?utf-8?B?TTY1OTJicHh2SXFOZjJFTHhEcUt6STZWUUNxazZyY2NrNE5uUlBzQmYxQ3Jn?=
 =?utf-8?B?bkNHVzBGMkppeU5oeDNFd0RPcEI3a2FZUFpIS05Yb1ZkU0FsdGtDQ1VOYjNj?=
 =?utf-8?B?dlI0TDBoL3JOUnJscnlLOXdaaWhyU3cvWVVMWGpNZ3dVTmQzd1hxdmdLVFFX?=
 =?utf-8?B?QlM3TjBmM3hqbk1NSkNyU05BOUkvYnBhTnNMQmw5MnBFOFo3MUd6aFhMNXEy?=
 =?utf-8?B?OUZBdWduS2wyalNVTVJQYzRJWHBVVHJzRFJCUllFZGJLbkUwWlFjUk5UOHhx?=
 =?utf-8?B?VXpDWmkzUkRvMzc0L010b1ZBNURySE9ocmpCSE5aVVNWbGtOSXc1MERmVFhO?=
 =?utf-8?B?WERSSHRFZ2F4azdXbmpjZ3REMkw5TVhEN1FqVHF4R2EwZWpnUE84bFNpZURx?=
 =?utf-8?B?OVRaVVpscGFiK3Y0ZndnUTJiUy9QY3B3VHM4NWorNGE0b2RwVnJiNmtodkZz?=
 =?utf-8?B?MUc0S0xLODJqQVlCNHVNL1p1SW90LzRGdFg1c3ljU3VhK0JrM3NwMm5OQzlX?=
 =?utf-8?B?VTg1TWI5VXFTVCtpVnd0QUJweElHcStYNFlWVWY5anlqcm1IK0hGZ1hyeTFQ?=
 =?utf-8?B?MTRyNkhIb0lLbUFYN3k3bm9YYi9SL3lNSFVOVFhaSUVHRm5pMzJJNE9pYUt0?=
 =?utf-8?B?OUJjWi9nbHc4emdxanIvVVdBUk9wdCthNkNZMWgwaEJubXlaRVZKSW0vSXY4?=
 =?utf-8?B?SS8wdkpaeHVka3p3L0hic1NPejVEdG9VYWdMblE3YjRsZ0FEdnJYZFN1b3p6?=
 =?utf-8?B?dHFkUUlPcFZpUnVtM3RjMGpMbmRwMDNwV1lUSk1ENlNLNTkvQmJxTndaSXdm?=
 =?utf-8?B?UWRVMEpERjBGUEo2NWVtQXY4MENNZnBpVE1OMHVKT0VPSXJTMmI5Z25LVUxR?=
 =?utf-8?B?UHQyMDR6ZmxteGdTUTNid1NqTVovSk5oRmkxRkJOcjBISkpnZ3U4SDU0d2pR?=
 =?utf-8?B?alNld0N3T3M1MDc2Qjd5dHUzc2FBeUlVQ21KUHRFUUM2OXpYZEtXb092ZHRS?=
 =?utf-8?B?RTJHQmpqYndyTnpsTEFrNEhYRkp4Si8vc2k1cFlOM0xDdE1VSkdBeDZWRUlH?=
 =?utf-8?B?cENIYWhQZndSdS9qT295RmZldVFTV0JOVjRVdmV1YkRWQlJCd3JDeFJpVlR0?=
 =?utf-8?B?aDdQa004QUZQUjh4VktaaVUraVRYdkhoSEViVVpGWHBXL0RWVDU2NVl5ckxP?=
 =?utf-8?B?bGQwdGlrSURoaC9VNFV4ZTZVdUJCM3poYnRmbE1OZWNzYzNkYkcvbjhraC9r?=
 =?utf-8?B?WmJXM1VoWXhsemxOVzh4SkozK3BWaTM4TmI0NUhucHpKcU9xZ3Y2ZHM0ZWhK?=
 =?utf-8?B?Ymg2MFdJRmVLUDE4WUV4dUVMQ1hBVlAwUlVTc3YvMmRzdVpkcGJqZ3oxMk8y?=
 =?utf-8?B?VGtBYTBKa1N4bEsvdytPUnBqZHhhVXpQaVVpSUdYOXhtbE9Xa1VtRFBJWW9x?=
 =?utf-8?B?enc1S09zL2dPUWlzUjhqTDdtYkdQUXJWNWFldDFubWtsVlpZTVdZYmlkcHFa?=
 =?utf-8?B?aVhWTUlPQmxpOTd0aWt3KzQwVHhMSjQyQmk3c2FVMU1HdlA1WTkxekVYUng1?=
 =?utf-8?B?ZDRNSmpTdk50S3pMVzZtcVJPQlpNaDdWQUdUUFFIZ2V0SG4vWTRYTGdRazVj?=
 =?utf-8?B?Rk1TOG5MMkpWRnJEaDNwcXFFRjl5Y0pQSkNFd2lKMXowMXFPYkJBQjg0QnNx?=
 =?utf-8?B?SktPQ0dtV1RPWCtKN0kreVJkdUFBQzdpSklPZG50YlFmRzQ3US9vRkViWkJl?=
 =?utf-8?B?bW1paU9FdlhUYnN1aDgyNXVjbTEyV1huZjJsUk8zRXp1RFhrWVZLOTJrTENp?=
 =?utf-8?B?VC94Q2lockVEZ0didmxPdG9VdEFDQ2ExVFJUYUczcEhTL2JiL0FUd3FBL2Vq?=
 =?utf-8?Q?EDUtZBJ84kqU1fmY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6c14cf-209b-403e-ab90-08de4276e618
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 22:59:16.8631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvzIAsykWF/H826OP7e7zLpT3TBpxwEGK4AafcY1FQbKHLVBsk+mq6pPl1R6sq9Js3vz8zz3XBpk5zUJVwCJRgpe3nDDM9f7qX/7Vq9YFM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7792



On 12/17/25 9:04 PM, Ryan Roberts wrote:
> On 17/12/2025 10:48, Yeoreum Yun wrote:
>> Hi Ryan,
>>
>>> On 16/12/2025 16:52, Yeoreum Yun wrote:
>>>> Hi Ryan,
>>>>
>>>>> On 12/12/2025 16:18, Yeoreum Yun wrote:
>>>>>> Some architectures invoke pagetable_alloc() or __get_free_pages()
>>>>>> with preemption disabled.
>>>>>> For example, in arm64, linear_map_split_to_ptes() calls pagetable_alloc()
>>>>>> while spliting block entry to ptes and __kpti_install_ng_mappings()
>>>>>> calls __get_free_pages() to create kpti pagetable.
>>>>>>
>>>>>> Under PREEMPT_RT, calling pagetable_alloc() with
>>>>>> preemption disabled is not allowed, because it may acquire
>>>>>> a spin lock that becomes sleepable on RT, potentially
>>>>>> causing a sleep during page allocation.
>>>>>>
>>>>>> Since above two functions is called as callback of stop_machine()
>>>>>> where its callback is called in preemption disabled,
>>>>>> They could make a potential problem. (sleeping in preemption disabled).
>>>>>>
>>>>>> To address this, introduce pagetable_alloc_nolock() API.
>>>>> I don't really understand what the problem is that you're trying to fix. As I
>>>>> see it, there are 2 call sites in arm64 arch code that are calling into the page
>>>>> allocator from stop_machine() - one via via pagetable_alloc() and another via
>>>>> __get_free_pages(). But both of those calls are passing in GFP_ATOMIC. It was my
>>>>> understanding that the page allocator would ensure it never sleeps when
>>>>> GFP_ATOMIC is passed in, (even for PREEMPT_RT)?
>>>> Although GFP_ATOMIC is specify, it only affects of "water mark" of the
>>>> page with __GFP_HIGH. and to get a page, it must grab the lock --
>>>> zone->lock or pcp_lock in the rmqueue().
>>>>
>>>> This zone->lock and pcp_lock is spin_lock and it's a sleepable in
>>>> PREEMPT_RT that's why the memory allocation/free using general API
>>>> except nolock() version couldn't be called since
>>>> if "contention" happens they'll sleep while waiting to get the lock.
>>>>
>>>> The reason why "nolock()" can use, it always uses "trylock" with
>>>> ALLOC_TRYLOCK flags. otherwise GFP_ATOMIC also can be sleepable in
>>>> PREEMPT_RT.
>>>>
>>>>> What is the actual symptom you are seeing?
>>>> Since the place where called while smp_cpus_done() and there seems no
>>>> contention, there seems no problem. However as I mention in another
>>>> thread
>>>> (https://lore.kernel.org/all/aT%2FdrjN1BkvyAGoi@e129823.arm.com/),
>>>> This gives a the false impression --
>>>> GFP_ATOMIC are “safe to use in preemption disabled”
>>>> even though they are not in PREEMPT_RT case, I've changed it.
>>>>
>>>>> If the page allocator is somehow ignoring the GFP_ATOMIC request for PREEMPT_RT,
>>>>> then isn't that a bug in the page allocator? I'm not sure why you would change
>>>>> the callsites? Can't you just change the page allocator based on GFP_ATOMIC?
>>>> It doesn't ignore the GFP_ATOMIC feature:
>>>>    - __GFP_HIGH: use water mark till min reserved
>>>>    - __GFP_KSWAPD_RECLAIM: wake up kswapd if reclaim required.
>>>>
>>>> But, it's a restriction -- "page allocation / free" API cannot be called
>>>> in preempt-disabled context at PREEMPT_RT.
>>>>
>>>> That's why I think it's wrong usage not a page allocator bug.
>>> I've taken a look at this and I agree with your analysis. Thanks for explaining.
>>>
>>> Looking at other stop_machine() callbacks, there are some that call printk() and
>>> I would assume that spinlocks could be taken there which may present the same
>>> kind of issue or PREEMPT_RT? (I'm guessing). I don't see any others that attempt
>>> to allocate memory though.
>> IIRC, there was a problem related for printk while try to grab
>> pl011_console related lock (spin_lock) while holding
>> console_lock(raw_spin_lock) in v6.10.0-rc7 at rpi5:
>>
>>      [  230.381263] CPU: 2 PID: 5574 Comm: syz.4.1695 Not tainted 6.10.0-rc7-01903-g52828ea60dfd #3
>>      [  230.381479] Hardware name: linux,dummy-virt (DT)
>>      [  230.381565] Call trace:
>>      [  230.381607]  dump_backtrace+0x318/0x348
>>      [  230.381727]  show_stack+0x4c/0x80
>>      [  230.381875]  dump_stack_lvl+0x214/0x328
>>      [  230.382159]  dump_stack+0x3c/0x58
>>      [  230.382456]  __lock_acquire+0x4398/0x4720
>>      [  230.382683]  lock_acquire+0x648/0xb70
>>      [  230.382928]  _raw_spin_lock_irqsave+0x138/0x240
>>      [  230.383121]  pl011_console_write+0x240/0x8a0
>>      [  230.383356]  console_flush_all+0x708/0x1368
>>      [  230.383571]  console_unlock+0x180/0x440
>>      [  230.383742]  vprintk_emit+0x1f8/0x9d0
>>      [  230.383832]  vprintk_default+0x64/0x90
>>      [  230.383914]  vprintk+0x2d0/0x400
>>      [  230.383971]  _printk+0xdc/0x128
>>      [  230.384229]  hrtimer_interrupt+0x8f0/0x920
>>      [  230.384414]  arch_timer_handler_virt+0xc0/0x100
>>      [  230.384812]  handle_percpu_devid_irq+0x20c/0x4e0
>>      [  230.385053]  generic_handle_domain_irq+0xc0/0x120
>>      [  230.385367]  gic_handle_irq+0x88/0x360
>>      [  230.385559]  call_on_irq_stack+0x24/0x70
>>      [  230.385801]  do_interrupt_handler+0xf8/0x200
>>      [  230.386092]  el1_interrupt+0x68/0xc0
>>      [  230.386434]  el1h_64_irq_handler+0x18/0x28
>>      [  230.386716]  el1h_64_irq+0x64/0x68
>>      [  230.386853]  __sanitizer_cov_trace_const_cmp2+0x30/0x68
>>      [  230.387026]  alloc_pages_mpol_noprof+0x170/0x698
>>      [  230.387309]  vma_alloc_folio_noprof+0x128/0x2a8
>>      [  230.387610]  vma_alloc_zeroed_movable_folio+0xa0/0xe0
>>      [  230.387822]  folio_prealloc+0x5c/0x280
>>      [  230.388008]  do_wp_page+0xc30/0x3bc0
>>      [  230.388206]  __handle_mm_fault+0xdb8/0x2ba0
>>      [  230.388448]  handle_mm_fault+0x194/0x8a8
>>      [  230.388676]  do_page_fault+0x6bc/0x1030
>>      [  230.388924]  do_mem_abort+0x8c/0x240
>>      [  230.389056]  el0_da+0xf0/0x3f8
>>      [  230.389178]  el0t_64_sync_handler+0xb4/0x130
>>      [  230.389452]  el0t_64_sync+0x190/0x198
>>
>> But this problem is gone when I try with some of patches in rt-tree
>> related for printk which are merged in current tree
>> (https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-6.10.y-rt-rebase).
>>
>> So I think printk() wouldn't be a problem.
>>
>>> Anyway, to fix the 2 arm64 callsites, I see 2 possible approaches:
>>>
>>> - Call the nolock variant (as you are doing). But that would just convert a
>>> deadlock to a panic; if the lock is held when stop_machine() runs, without your
>>> change, we now have a deadlock due to waiting on the lock inside stop_machine().
>>> With your change, we notice the lock is already taken and panic. I guess it is
>>> marginally better, but not by much. Certainly I would just _always_ call the
>>> nolock variant regardless of PREEMPT_RT if we take this route; For !PREEMPT_RT,
>>> the lock is guarranteed to be free so nolock will always succeed.
>>>
>>> - Preallocate the memory before entering stop_machine(). I think this would be
>>> much more robust. For kpti_install_ng_mappings() I think you could hoist the
>>> allocation/free out of stop_machine() and pass the pointer in pretty easily. For
>>> linear_map_split_to_ptes() its a bit more complex; Perhaps, we need to walk the
>>> pgtable to figure out how much to preallocate, allocate it, then set it up as a
>>> special allocator, wrapped by an allocation function and modify the callchain to
>>> take a callback function instead of gfp flags.
>>>
>>> What do you think?
>> Definitely, second suggestoin is much better.
>> My question is whether *memory contention* really happen in the point
>> both functions are called.
> My guess would be that it's unlikely, but not impossible. The secondary CPUs are
> up, and presumably running their idle thread. I think various power management
> things can be plugged into the idle thread; if so, then I guess it's possible
> that the CPU could be running some hook as part of a power state transition, and
> that could be dynamically allocating memory? That's all just a guess though; I
> don't know the details of that part of the system.

Sorry for chiming in late. I was just done my travel, but still suffered 
from jet lag. I may be out of my mind...

I agree the sleeping lock is a problem for -rt kernel. But it is hard 
for me to understand how come the lock contention could happen. When the 
boot CPU is repainting the linear map, the secondary CPUs are running in 
a busy loop to wait for idmap_kpti_bbml2_flag is cleared by the boot CPU 
instead of idle thread. And the secondary CPUs running with idmap active 
and init_mm inactive. So the nolock variant seems good enough to me if I 
don't miss anything.

Thanks,
Yang

>
>> Above two functions are called as last step of "smp_init()" -- smp_cpus_done().
>> If we can be sure, I think we don't need to go to complex way and
>> I believe the reason why we couldn't find out this problem,
>> even using GFP_ATOMIC in PREEMPT_RT since there was *no contection*
>> in this time of both functions are called.
>>> That's why I first try with the "simple way".
>> What do you think?
> As far as linear_map_split_to_ptes() is concerned, it was implemented under the
> impression that doing allocation with GFP_ATOMIC was safe, even in
> stop_machine(). Given that's an incorrect assumption, I think we should fix it
> to pre-allocate outside of stop_machine() regardless of the likelihood of
> actually hitting the race.
>
> Thanks,
> Ryan
>
>> --
>> Sincerely,
>> Yeoreum Yun


