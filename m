Return-Path: <bpf+bounces-9174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4637913A1
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 10:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8665D280F3E
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBAB138A;
	Mon,  4 Sep 2023 08:39:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF507E
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 08:39:01 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC020128
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 01:38:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383LglcS018866;
	Mon, 4 Sep 2023 08:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FMto8EliPrcxkaa3NVh9L8cSZ8Lp4FGWW9J34P0o+4s=;
 b=QboXGj46aQQEIXUrf3k4UGk8lJqyVeYsS05a/FllxBYZPicnLG9sTS/NuHptGas5hA9b
 5giuk2jJ+w3N1GjZh+Rrg3xckDCS3zks5xJBuNL/3AhcWZjMnlIy7fqyBn65pNkO6l6O
 MWSE0gD7AdFUabHO1w4AuvLyHjRH+i3KYIJiUHxV5U3RVVyB4o3Nwpz4418F8UlokDEb
 U0pZojFcd63rxHTZDZ6mUbvzHkTHwuErjTEbzNqnD4He2wmKXia1IBE6PuxSOsQOXW2A
 LomDQ+U8j4tLXzrtrsmIYnEwqd25SCgErSQPt+eQp3q5wrgKnvztDhs9/wT4CgqgKKBO Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suuu3jtbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Sep 2023 08:38:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3846TAk4004830;
	Mon, 4 Sep 2023 08:38:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug9nqxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Sep 2023 08:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy6cZ11dx5JeWG424YkbWGn83Fc7TMn75wFib78peaPvVi4SYT2l1msmUaeIpn5+ozVO91oCnbr/LN7Cki+lQUcY3ltt9PDqgCtdzF7pUrl545yl06TDUsfwNxo61whdWgq3brgc4FSQ9hmd4lRzFRjtr8qKFcnHADp0yZC7YqtyI+xUqLKfLjA5ktFzEJyzA+BHNO/wK5smcvRiP/l0A1dxS+lQhv9j7Ct8P2ggoH+wL9NEzSoWWyGEnDM22s3VVbNAfcVBSPndKH3dtKEb3YQwge6saWkurq/0+ldnyhN2+mtB8w7NYRLXP7/lSmK4VeiJ964V+ZEWvCbHiUAw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMto8EliPrcxkaa3NVh9L8cSZ8Lp4FGWW9J34P0o+4s=;
 b=AwhD1PgudWxhxOJCMFUHTIR4ELSj2/N9roABJErSBRNB4+OFo2y6dSfOcChWDcGQsnmCBoqVzvs6Wk4kx+x+eSfNx300JXdBtQv9P6QsUQnMro/7WMLT9plbzxv9WeoxwFUNxzHy5pRcRlt2yu0T8Jd8qYKWHptVgBtNSIp+ttBzj/CM2Qt7k0Lv3vvk0e1fDBvuZtgWue9Zp8BdE7xjgmN68h9EYt4tcrWrWCwRj/p+fwgk2+ODpYBDoR903tiXpgU30AGMHLfDhASkqbaIYv4ZdEadXGrYIrKbapOovhYN8Kp96Z9rxjJtu4JgloWLxmYUaIJdh+pX5ERKUE5EYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMto8EliPrcxkaa3NVh9L8cSZ8Lp4FGWW9J34P0o+4s=;
 b=eq317vlaBOg/Wcifg7XZcjkFaDmC9ci5y6KNrf5oVWJZnyYnLoFxZ3u+JofaDLpo3xSBouu/rtEGWBAeEmO0zV7ljq/lnVW0aQLnD2PbV1eyQtOAPmAFCICwlmm/qUCXro5XSdFHmVze4egF00FYowlU6bfTJue7ZO2AF6mV7NE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6481.namprd10.prod.outlook.com (2603:10b6:510:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Mon, 4 Sep
 2023 08:38:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 08:38:22 +0000
Message-ID: <03f4fdf3-9ee9-7b33-f196-3d6d5c44effb@oracle.com>
Date: Mon, 4 Sep 2023 09:38:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next 0/2] libbpf: Support symbol versioning for uprobe
To: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20230904022444.1695820-1-hengqi.chen@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230904022444.1695820-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0013.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcbb0b1-204f-4015-2bb4-08dbad224c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3Lb8mjCDS3t06KT3tBZZvg96eCcujdM6NOFrW+JS7O2pGehRS/5E8jAHChnLI3bQGY1fNglnQH400Hl38FZ7XO0AUX9SPae7zQV/2T3FALsy0QCil3drzn6kKg/UmlLbNR8m8Zju6rja8xLYFZCMCEBoo7clKNv6EXVHMMw6A/d7Gvj//EbxFtUfi0Kk2IwW4Zu9NbZizAyvdsUdAuSZwCr0pg2b7XqKZ777zQm5e9w1ownq0O1zkTo0ojGp6oDTEUptENMD4V+zr4v5C4Zal4yQFE9/HBl2+kMafnEL0tAKYRoroTPFwmLk5UaNISCpa3Qxg3LDF0IdGXIkZHMTK5RQ6HRY9JILuQrbd+RJDBWOFM1JD1MlNAxwM7yJ5m7UZCjelP9zcGGZD5bDpN6bD0QJu2JbnCNrTsfvxXSYWJRLo3PFJSKkVV0W1ACQUUD1yQZ71Cgu71YAAA3kZFBBTKuUtu89ty3VjSui47sxWUNv3nZfW/qvBQ7tI5MOsKeQtH7ULlIG9hEwtHdKbFU1ArMEexHsrkten84EZHVNjJP63LNW76m1+kslTDS1yvhopKLAG87r+laU0s1VL3OjfLgfeDcxEqsZSo/CJdSEy/L3bH76xCkotDuKBIwA71zLO9aLFE27cEP5arXYkoHCkg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199024)(1800799009)(186009)(8936002)(2616005)(8676002)(4326008)(966005)(83380400001)(38100700002)(5660300002)(86362001)(31696002)(31686004)(44832011)(478600001)(6512007)(41300700001)(66476007)(2906002)(6486002)(6506007)(53546011)(66556008)(66946007)(316002)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wncvb2NBU3hlKy9oOGJGUGtxUGU5blB5WmpJZkY0cmsyVWYxMzdFV0NiWnBI?=
 =?utf-8?B?QitCanBtUkFyNkIxSStrYmdqMDIyMkdBQ0ZORVBqUU14bW5NVWVpT2FPWjJC?=
 =?utf-8?B?ODRhSTZOUEZCOUd3NXp4RWsyK1AyY0MzN0pRanliK2VxdVZZdy8xS25zYnhX?=
 =?utf-8?B?ZTUraldnN25Tb1lUR1Y0bGVlVlJuczllTmNtK1A1dmo2OGxUaTByZnFDVWhL?=
 =?utf-8?B?K3NhcU9xNkk1Q0l4SlRMRkNBN3A3Sm12enRxUXNMUEo0dzZKWlFSVE1PMVNq?=
 =?utf-8?B?THNmN3dqYUtTeUl6ZndMeklSendQZGNYdXlsMEdkVjJxUmF6WHRVcUFZYm16?=
 =?utf-8?B?ZWljZjZoM2hGelVKQll6Si9DdWRFMkZlUTdrUm45UkgyaGNqT1h2d001bFNv?=
 =?utf-8?B?UWoyZGtjb1pPTmpKSUx3ZkxEY1hrZ2ZoSGFpWkRWNFFGR1lVbzRsZ1Zyd2Iv?=
 =?utf-8?B?OU5pdUlybE9DbGNYZFFjYmJzb0dNVW8yUmdiS0R4VFQxMm1qSjlndG1ONkNs?=
 =?utf-8?B?dUg1elRxK2puTVF1MElETHFPQWNZMnNtT2pjZFRsNGtwZitySElSOFpESkpM?=
 =?utf-8?B?ZlNSOEFwWm1WVENzVjh2ZE9ET1Blc2E4WlNaRnpGRmUzcWd2R1I3UlVRK2dN?=
 =?utf-8?B?RTZaNnhCSmJmd3NuZWROemZLUzBkYWcwSHdHT1V5REpaeVorWEttL21Zcndt?=
 =?utf-8?B?N2t2c0NaZUh4blhyVmJVNTlSdVRGLzd3eWNjcldMNU04Y0p3TnNTeStGOW12?=
 =?utf-8?B?bGFGSm4rNXdya2JLK2JYejNOWHVtV2dFQ3lId29mU1VLTEFsSERLcitiRjhx?=
 =?utf-8?B?NGxZdlpuR0JVME1WcFBVZEowa0VZUGZieUpLSERwMTBZRU1JeDJWQk13NHVw?=
 =?utf-8?B?NERYbUlUdUtteGNVWU9EOWNiYUduelAwWG9sWDhwQ0lRQURGS0VnR3JPQ2tV?=
 =?utf-8?B?bnJlcy9VYXdmZERhYXdqWXZKVGR6YWlkMDVaNTRwa0c2SnM2VWo5aUMwSXVs?=
 =?utf-8?B?UHNCZncrRTNiWDhkZzZUcE9GMWJsYndwUGpMZm0xb2JTTmFxcS82TzA3cEYy?=
 =?utf-8?B?aWpDSFBvZDlwNkIwelYvT1o2ek5nMUtEZDMyaFgvbEtEOXlVakFpYmZvTnVX?=
 =?utf-8?B?S1ZwU2l4YldRbHhFaGl6WEI3VHV3Zk5CemFvN1N3REQ4eVRhd0h0d1pQM0xP?=
 =?utf-8?B?L2lqRndjMEZWL3B3djRVek4ralRzeHNtSHVpMXdWaTdPaHhwMDZJNWFEU2l6?=
 =?utf-8?B?Y0QxL0xFM2VydVRlaUJFRHI0MmYySlBRRzJYUFlMTWgwODJLMVllU0lYMkpB?=
 =?utf-8?B?Z1Y0SndtcnNxRUU4WlhXNVN6aU0xQ05WLzN0OHdtODYybjF2SVNpSi9RQUlz?=
 =?utf-8?B?WXpuanQ5VUd2Q1JHWnlCV1c4VGlhLzBldXdvRlowcFQ4L09EWDU3YTR0UlBj?=
 =?utf-8?B?THNBemFJODhEaDl5U1hHVzBqUlM2TTBoUUUvN21DNm1IdTV5ZmV0UWRFUVNG?=
 =?utf-8?B?T05TeXdrUmFDQXdFbjg2bEl5V0QrTmJXWW9XUWRDRk13eFFCcmh1cFNQS2dl?=
 =?utf-8?B?Y0d2enJ6Uk5jaE9oeGFaTnZGNWtiUGRDYnVhNjUxWFBFUlA5L3BEWG0vUVZu?=
 =?utf-8?B?cDY3c3gzcDBKQjRaK1NvdW9KVmxHT3pUaUZCbTR0MVQ4MHRJNTN1OEdzRWxi?=
 =?utf-8?B?UlE5WG1rSHJENzFkMXUvaVRoUTFzdVBMdDV5UTN2RmJPVmkxRHNEUGxzN3dw?=
 =?utf-8?B?dVZVK3ZheDkrQWVjK3p6UkJzdmxSM29TVHhaL3dBYXhKVzdiaVZKdnpma3dR?=
 =?utf-8?B?d0pKMTZFMjBMQVFkbzNlNThMeGZHVVZiOUVqWTlTelVZMkF4Q2wrbkZLMk5G?=
 =?utf-8?B?cDcxRG5UVVZZa1dUcnRaMTdHejVaWjk3dzl4cmhqTUduY0hBbkxUWkpFdFYy?=
 =?utf-8?B?WElzQTc1YldwTmdZci9lR0VFaVJzTUtBWnc0ZjR0WUVGS1ZKaTVzdStLa1Jp?=
 =?utf-8?B?VkZRTy83dFBORGZTNWVmNHRSbGpHSG5Sd25QZm93TE1WSENjQ2ZXbGpxK0xm?=
 =?utf-8?B?ODFLb2FuWm9SakZPV1J3WkJjZzRnS28xQTExYnBkTzRvK1FLWk1LTE8zSjhE?=
 =?utf-8?B?SkpPVmM4R213SWcvd3BUSFRvSWg2RUdvd3AzTmF0VEhaOE9EZGFqMUVlOXRK?=
 =?utf-8?Q?kW+/VX4/zSR/PFsTzskCkF0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5Hs8jC2hcxMXFYCsUuAMxFQ2q9IAKzhsy7ri5KJQjyHno15Yw2HLtL1q5eWQxVAJtWLaIDw6Z/lpQ0ZbWp2pgLzJAk08CD/0zbAuCOmcdY3M0sD5n2VtxbzjHPyFei5h1nUMtk+xZVDMidLi4DlXaX8oWTnONIJ8hJHrkXcHtRQUl3RL2qEOwELCKKyrd1o1DJq5RGfZkYl0xhrO0H8wxCaEgjUYUNcIth/D4ppu11/QCyH5Fa0JBPDl9alXHUzi34jdm1m7fY9e3QE7DRZwIjmNNew/SXU6y36yPXZCWxOoT5UzS+xGxPzKYHubke0H8b8GiV/eynSr4dylQNAPGCksA0LNyA/XAX1+UFt80SRr2Uayh/Pi2DdBtfbs5Jle/et6wwD+ethLZjJ7agM92gYV661u8qNquaqSDloZ+Uu2khLuQOCJVxQL0iLSeI6tmR7uKSvGUCjwPkJKrdDFDhrmHozGECxH8NF2QtZomLIYrd1H0yu01yPHc0nUu7qmRn3n4GNu29M1oOn241XVOGDFvAIVqaraOFiPg+hKLJx1/wve5vgfRhNTgVfYfmmRwccyu4OsW/nWKUjqrLK25nkAFQ5S++IQX/ncgokUXLUwQAGk/8P2O5ugCERKBrOnvlY7920pezHsrOs++akyib6nFySDo5ZTQAZC0Q/z5qR8r2K2JQHR6JX55+q4fZoj7ncrZkzM2nBeftNzfIkD00BbjdKtG5rh7BWBISh7HMItIlg6zS0JyBFW7IbnNTZIqaeme4A4Dxfu3fnWdJDghu97EgIxQcU0VDLmXABu9v837Luy7HWzh1bultcbyEl9y0qd70C3mmPjGyrxq1Xqtkoi6JI880PW96DqY9ZnXCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcbb0b1-204f-4015-2bb4-08dbad224c28
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 08:38:22.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWPYOMcYjZYee42b4JDIVdEZO9vaR+wQ4gqX3kgI+07KqDFoKPvesJlxJvEFBMU0FcAV3kEuxoHz3NZIx0fMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_06,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040078
X-Proofpoint-ORIG-GUID: zFxOsE19CR1CqUI6Px8yLmV-jT7UpUVU
X-Proofpoint-GUID: zFxOsE19CR1CqUI6Px8yLmV-jT7UpUVU
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/09/2023 03:24, Hengqi Chen wrote:
> Dynamic symbols in shared library may have the same name, for example:
> 
>     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
>     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
>     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> 
>     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>       706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
>       2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
>       2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5
> 
> There are two pthread_rwlock_wrlock symbols in .dynsym section of libc.
> The one with @@ is the default version, the other is hidden.
> Note that the version info is actually stored in .gnu.version and .gnu.version_d
> sections of libc and the two symbols are at the same offset.
> 
> Currently, specify `pthread_rwlock_wrlock`, `pthread_rwlock_wrlock@@GLIBC_2.34`
> or `pthread_rwlock_wrlock@GLIBC_2.2.5` in bpf_uprobe_opts::func_name won't work.
> Because there are two `pthread_rwlock_wrlock` in .dynsym sections without the
> version suffix and both are global bind.
> 
> This patchset adds symbol versioning ([0]) support for dynsym for uprobe,
> so that we can handle the above case.
>

So it looks like patch 1 handles the above case for an unqualified
uprobe where the addresses match; is there a reasonable approach to
take for the unqualified version case where the addresses for different
global symbol versions do not match (such as "use the most recent
version")? Thanks!

Alan

>   [0]: https://refspecs.linuxfoundation.org/LSB_3.0.0/LSB-PDA/LSB-PDA.junk/symversion.html
> 
> Hengqi Chen (2):
>   libbpf: Resolve ambiguous matches at the same offset for uprobe
>   libbpf: Support symbol versioning for uprobe
> 
>  tools/lib/bpf/elf.c | 103 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 94 insertions(+), 9 deletions(-)
> 
> --
> 2.39.3
> 

