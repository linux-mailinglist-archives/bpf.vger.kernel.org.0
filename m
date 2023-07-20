Return-Path: <bpf+bounces-5545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75AA75B968
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 23:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF051C21387
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5218B18;
	Thu, 20 Jul 2023 21:16:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541A154B1
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 21:16:02 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9342E52
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 14:15:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KKUPgp025983;
	Thu, 20 Jul 2023 21:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uPiYtEcDloWodj90U24e3kVm8e4QJPrstKpPN49NCh0=;
 b=zTPqHEgadw+Hd0RMgv3XGufvw4NxKVHQ+H1zs8egiPjhUS+FQK+kPgKIKlDKKWnTv8at
 NMfyF/T48I2n6DVsuqCF74Pc08yzPCT9e1LcNhlz5CqnPrpXCOJni1acbd583Bl1DPof
 o9p4Sb/3dknBMzC+3tJt5odUkhTZy9XgSIXSgV/ze3XMfjRtT9u8u8gDhzHxLME9wPyf
 ugrUfNdjRWfvGNbK5zzz6eceVxB5Mgg8gjsD6Kxo4dcCD9+xEs0C0peKtNhVV1yVbb79
 E44Bt6DLUjpZ6TFYG4UwjPccgk8LOLSRnNNV/zpeCTsqOVwb2sAlmXcZXI85HQ8UUpOe Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run782r4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 21:15:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KJIu08000815;
	Thu, 20 Jul 2023 21:15:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw97rgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 21:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfEHG2iiu3+CJ/s29eyRsBBwwC3i8mJD5KG0K8TRjj9GsrpV0nuiHn1YJEuRxayPtpGlPTRQlBUHi/U4Iv+KRTJw14VbiJcsqpNfPm/QxdOnHs0bQauid0PLOGN0DQ17BRcD8TqxOMDRASB9YcRK2jBrhAgfJhJl/XHQ7V2Ai115RpNbs3SVQaDLVq+VEn+sJFIpJqT3/p8xQ/aNbuYGbZhe3ZMcK2OC4uoCYtwjv+a5tKY+rhPC7qwrkSnJNHtvoQ96NeEgxeIST2AsJ7UgNkXaNj4eXZiNLbNk8ZGLXik6pe871HcE+I6BmfHalHMIE44vuNwlfSaSvRMycK2pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPiYtEcDloWodj90U24e3kVm8e4QJPrstKpPN49NCh0=;
 b=TPsyN7YN+5MlcB5uPQbVhqjcuXRicRwsL3uydjQdGtbRUQK6aKMn34VP+PQKdPFzpUTeqE3Ns1ykmoxEpcVsud0Ll8ylQWaLkLjDKvJB0++K+y+1+0m4TL9KnwS8ekuzMJCS2wV8c9LkVfF1f+AaICEFXD0crsoJbEx/xOLKu53LcMWMwPURMdV6RcSgTXTJ6MdXRCKDa0ImzQnFuDJDq9LO+DvNj/KL6aj9dPifwyCNKH0aDFvj0WMdS9ph79UeW1fPQyOWFbaSObli/DsehjgpyH3mW9YYOP6VAJthMepLs8fccvkIVj2ouKUfMr+2wt05ntJ6UdhAlf641Ze1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPiYtEcDloWodj90U24e3kVm8e4QJPrstKpPN49NCh0=;
 b=B36eH67vEUfCk0w/OY8pVw2H/R2xVlVOQEu6+Dp5LI0sNccn15KqN0GZJEZEtPRc7i8lB2IeFoHWzI4dcYZyrzbN7xE59pzff8hZfIb1vm/TVJYZtX5btsoYZYiiLX4Aj+T+y3PUtYme1KyN4VM6pT5rEN/9uGmdFZyvh+DvX7c=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5786.namprd10.prod.outlook.com (2603:10b6:a03:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 21:15:32 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 21:15:32 +0000
Message-ID: <296128c1-cff4-ad40-93a8-97cff06c754b@oracle.com>
Date: Thu, 20 Jul 2023 22:15:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: CAP_SYS_ADMIN required for BTF in modules
Content-Language: en-GB
To: Yan Zhai <yan@cloudflare.com>
Cc: Ivan Babrou <ivan@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <CABWYdi3iyagrnN=2uMbq_K0c4FzporQ1pbUmkUZKsiQ22srP3A@mail.gmail.com>
 <c61496fc-9ed4-9e65-1844-10d4e862e07f@oracle.com>
 <CAO3-PbrZ5W0KOZ5Rydc=bmhQ1ngn5rjkOuCZ9BAMYp6WNbMmEg@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAO3-PbrZ5W0KOZ5Rydc=bmhQ1ngn5rjkOuCZ9BAMYp6WNbMmEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: dae4c3f5-12a2-47b2-934e-08db896673bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gfdvmEMUkxNgc3AW0Yt01WiZ86sPObsm4goIIyfh07y561wZ5XL+1NVuqllZ5gytn/MyomSd7N2ktAAp6ZBCRy+gY6yPfGqgsIaqlDqDJZ9yhL2eH15uK9/W4AH9L2KcmFWJcYrgQAGBTzBHSE6iriWIgo7hqR3N0HItq2UOITJQZH64InQWKARfhCFCzcnY9AnQ2FOiRbbgaA7ZUSpcOcvbFENYYCT11bvXk0E8MC6Q+xFL2/9Q30wzcidTaBxJ2IpD5gq/2GeXiTHJf76fmcriD4csWCSxhVJo42kW0o5QjaqzWgWofjPn92w24Ad/UgWv7eWLNUSgIgW9wa2ZF3XL1R2vpurnJzztsQ7ZFHBRq61G/Ad1KmKaNd5zEsOMV99K+HasEOfbUKt9Kf5xDjEIYG2i7nNpHUT97UX2NLPNX4d6MZs8vXjf7JnSnUqjS0WGGUpJn5JiamFxq/lmpSA1BtVdp2WjI/W71FCOIpRTs9hwjQ7PpT8yuMlcDallf/oiyuWbPHIdqkHxOeqtxr/OXhOU7yS5Wyj89ye4DEIh3y8xyU4k/O0cJzmz82sRaCIruzPUkeJZIKfu8vpHAqHwfdTg6u4JQkToIG0eNVOzsgDt4nDBbkWCW/LDhAbUpP2t4W/nLvwGJFF+p4BavQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(966005)(66946007)(6512007)(44832011)(66556008)(6666004)(66476007)(6486002)(2906002)(53546011)(6916009)(8676002)(7416002)(316002)(8936002)(4326008)(36756003)(5660300002)(6506007)(2616005)(38100700002)(186003)(41300700001)(83380400001)(86362001)(84970400001)(478600001)(31686004)(54906003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UndXWE9UQmpUd2lod2lsVWM4K2R3Ujk3Qm5EL0dCNE5reHd3OVZjUFVneFNX?=
 =?utf-8?B?OFR1R0RuOW5SalRKSXoxRWpLQktlQ01XdnkxVjhQd3lCTWRDbmRTZHlmUjRY?=
 =?utf-8?B?b04yYlljcVhtS1Z3OG9Bdmt4TEhBVHlxVVBSbjBIeXI2VTVoVTUzZCtCb3Vr?=
 =?utf-8?B?bDl5YzVPWmNLbExLQnNiakUwTUh0TEowVTZQcmtmSTNWeHVXMzZCMWM1Kzhs?=
 =?utf-8?B?SVRiU0pwVE0rMzBIKzB1K1JJcDlWVGExZjU3dmQxejhWRUpLb2VaUXJES29Y?=
 =?utf-8?B?Tlg2eEt3Q1orbUtLVWpmbUxleUlzTWxCc1FjNTJsQUovcEtMK0dvTGY2Szlq?=
 =?utf-8?B?eTFlMlRlekNQK2tlL0NUVEFKNTJZeDVsbGUwVXZZZzdYY01pdWp2UWRJV0cw?=
 =?utf-8?B?UG1JdmlsV3ZROXZ1WCsxU25qRGZ4TGVkTXlNMW1yVkUvaU4wMUZDUWFGNXFP?=
 =?utf-8?B?RS9mb0RrcEVkZVA5OVhxM1VkSUQ5K1VDYjBadTJHZGprMlRNekQ4eS9OZkkr?=
 =?utf-8?B?ZG9uQjFqRmhLMjNOVFlDWjBIRGpaeGo4eEIxVTdTcWpiL3JTQ0lTMWRmeVVl?=
 =?utf-8?B?azhXbHcwR1ZYNG1SRThGU1lrelZPakg4Z3k0c1lvWFNoa3hUd1BSOGM0NUkv?=
 =?utf-8?B?V3JjNllhaXlOZHkyM2dBcDBnTXdIb3R1VUYyR3cyVUtVdUc1Q3BPSFp2Ky9Z?=
 =?utf-8?B?V2Y0cE5pZnY0N1JUMnhvOXVrWkZwRElONU4ycjRYNUFDN29WalVIZmVJZHpF?=
 =?utf-8?B?YXdwTjQ1V1VMV1IwaTRkamZHY1p1QlkvSVNpUnBCaGR0aVFFekFxK1VDd016?=
 =?utf-8?B?WFgvYVFrU1pqTE5wOUVNenMzV25NSWltR0I2TGM4bkFtYlFRZSt4a2hqK290?=
 =?utf-8?B?VU1SaGI5SGsrU0duMFdqRm9NZmlLY044TzRxTkZjOGFlWkViNnVWNW90T2Qw?=
 =?utf-8?B?SGprU3FscURmckszRmYyNVJLb2JPSms0aEVLY0xOK2k0ZHlFY3BpWXRNNUh3?=
 =?utf-8?B?OHVVUEFOWFllenZ4TnFaTGJQWjJBQlhEQzNnSDc5bUhKSHEvUFd5cndWbUVC?=
 =?utf-8?B?YWY5TWxIRGVKR2g0eXZRR2M1cEgvaEs0TVkwb0FIbEZNazhwWTYybUpGMnk1?=
 =?utf-8?B?YlF5SUdFalpXUDBQS3FHRW1YTmJOQnV5SHFvSGJDOW5KSEYrVERYNXE2OFZJ?=
 =?utf-8?B?dTBTZ0pDN2x5cld5SGhQVXZLSmEyaXg3YjMxck5IYjd6TFFCRE1HMUVTMUVv?=
 =?utf-8?B?OVZ5aXdOQjdqYnlzcTRrL2o3UVFVa1VzTGlkZDVyd3EzR2VKTVc5OERpSGh0?=
 =?utf-8?B?VkZpSEE0UVRJVmhNNHpKSnduRk5XQUMzY2d1VTVFUkxjOUxwVDRPWTVaN0Rv?=
 =?utf-8?B?dWJCMi85ODNEMDQ5VHZhUzRBKzVwRkFmbUs1ZnlLTVdybFVtYWEyYkFCUUdo?=
 =?utf-8?B?eHAwUC9QVnBrT1ZRQ01UQmxORzZkcGpmaUhyMWk3RkU4Z0hlSkNRQjR2TmFl?=
 =?utf-8?B?MmMvRFAzcVpwRTRTRGFaUjV1ckRXUDJteXdabWhxN0pYVzBqc2VqNjFkbHNF?=
 =?utf-8?B?UGVQeE1KM0JOTy9IcklxYlB0TDloTkQ4aW96Uis5VFEwRUtoamRBaVoxTlU4?=
 =?utf-8?B?SGJzUUxKbDMvYW9kQ05uTW4vd3JwZVlSV1pBamZtdzVTbldOWUE1NHNUMU5l?=
 =?utf-8?B?cUJiT1d1N1VFa09SR0o5aW1ZWkFXcFh3Z1phcVJWZWk2N3V5UGx0RUlmNXNk?=
 =?utf-8?B?UHdDZFcwaDY1ZzYwcFAzWUdXVjNnMnA1cWw4bHQ1UUgxeFk3b0tHL1ptV1Rn?=
 =?utf-8?B?VTg0K0hraVZYYUFSQ3dJcUc4R2VyaDNNQ3ovbFduaVZGVVVxZzRzd1BwRUIz?=
 =?utf-8?B?ZjVyRS9RbkFSOHpkblNwQzdrTHUzWWVYMHovZ3NiZXR1ZmYyVU4zYjI3R0V3?=
 =?utf-8?B?RTg4YkJKWkoxK3hXMSs5c1dHTkZZYlE1a2NWTXRCS0tRY2xtekFZSitpZVpM?=
 =?utf-8?B?U3pWclJPWWNta0w1a3dlczlqdldmR25WOWJJZWh6T2NKd2RUVnBDNFZ5elky?=
 =?utf-8?B?QjVHLzRwRG5kN3N3YWxEWWpKQ3FlWE9JNGV4d255TXB1QWpNdjQ5ZTNWbDMv?=
 =?utf-8?B?dmJjMy9MRWRHb1F4VE9aNTBCYytGSEZ6UUdkSXZQeTVlQXpCdDArc3pSSmJI?=
 =?utf-8?Q?/OGH6XgJzQrJ7P/L12mMRCo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RzFaUTdVTmJUTUpsOE04LzE2VStXV1pteFNMbHdCZU5vWHFkK0ZFNFY3QmdN?=
 =?utf-8?B?Z2Yxck00L1FNcDNjZ1JsdzloKytzR0hSdXlPRXN4aWRybk1wWXZUdi9ieFZz?=
 =?utf-8?B?M1NCOHlVWmhzU0wzaExSVnFOZWZ0eFNPeFB3cVJuODllbmNxNmpSMGhzYlJv?=
 =?utf-8?B?SkpPamFkSSs3WXVHYzB1aDFhc1R0TXlYbWo2d2txVWpUVzJ5Ky9XSXZpck5U?=
 =?utf-8?B?bkRjMjNsaHA3OFlHdjVhdlF1YWFLYzZPZmczcjdkNk5Eb3pPbGZ0UkkzSG9t?=
 =?utf-8?B?QnluMUZBUGNoVHJ1Mk1LanV4Qjh5Ny9zSVZVcEdIU0hkaytmOUFwekRDUllV?=
 =?utf-8?B?TnR6dUF1b0ZrVFRjcnN2MzF2REpVSXJyTnFJbCtsR0VYUkwzM2lRaXQ3WlZC?=
 =?utf-8?B?ejhRcE9sb1VCbmE2dkFTVkliTUhEWVprVGh1TWJtRnc3SHR0YWpobGFRdDky?=
 =?utf-8?B?RjN2VEppTmZKVHJTSngwaHdNNzBidFJoOEQrWkZGaG9qVExNQmo2RXI4bHEv?=
 =?utf-8?B?SUlIa280ZXdCZldKTFB6NEgzZm1XaDFvNlRBQ0pFN2x2eTJlaisxTWtNV2Fk?=
 =?utf-8?B?RFpPVy9FY1o5WlZUVkpySHdQNk5kYUxmVjg0bDg4WVByalNueFlXUGdrc2lL?=
 =?utf-8?B?R1VlN0hYZzlqUlBna3Y4TkxEZ24wdUlJNXNIZ0ZaaE5Ob3dHWVJxNE14WC9W?=
 =?utf-8?B?cWd1b04vcWMyMldHV2syY0JzZ0hhZUJRQUdWUWpnanBzeGZxaHdxdnp3NkxY?=
 =?utf-8?B?eDVISmVlS2NiME1CTCtiNGxKdFFBSGlVMUxkckI4SEhOWGZBRW9ud1BURmxO?=
 =?utf-8?B?ZisvR2VncWx5NUVERTUva1pBL2RGZi9QaDJkWFpHb3BaSDJmTVZUSUhiQk5T?=
 =?utf-8?B?WVFveEtSTlozbDIxb2NCU2Y2eS92aDdtREo2Yk5uY1hBaEVabEl3NW5MVWJm?=
 =?utf-8?B?TWZYazVmK040UThaM3VDeWJNcW1VallZMEtiSElMcFUxRUVXalRLdzNkMTdX?=
 =?utf-8?B?K1pPeVBZVmFzdjQ3MEpFY3l2RWNnNHRubjdPL1J1Y251Z1pzN2lHbzhsOWwv?=
 =?utf-8?B?VVNJOTVQR1lqUUJyTHpidmZnQ1ZmRjkzdVFXanROWlBFU3Bnc2pBMUZ0VGpP?=
 =?utf-8?B?bXdsdGdFWk4zV3kyd0lXV2EvOU50KzJoYWpwRTcvb0RwZDFsa09pZGR1K2tm?=
 =?utf-8?B?TFkvNWYzTU5TY29jcG90NFB0bWdHZTFuSmZ1UWxhQ085WTl4M09NaStyN2p4?=
 =?utf-8?B?SDRudTZCeE93alIrR3VPcnFIRTJuWmNmMXdwbFM1QzdDOXFpdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae4c3f5-12a2-47b2-934e-08db896673bd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 21:15:32.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aHTr37SAdBAfeovmw/rlt37R5AQ7iqmlAHLPBKuz0EKOoOCy3iqR6HLDKBhrw7J2PlKWq9PNpNZSywq4D5J5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200181
X-Proofpoint-GUID: SzzVfIOtYRSSB5FOCZlUd6MNNbEaExbc
X-Proofpoint-ORIG-GUID: SzzVfIOtYRSSB5FOCZlUd6MNNbEaExbc
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/07/2023 22:08, Yan Zhai wrote:
> On Thu, Jul 20, 2023 at 12:59 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 20/07/2023 18:40, Ivan Babrou wrote:
>>> Hello,
>>>
>>> I noticed that CAP_SYS_ADMIN is required to attach BTF enabled probes
>>> for modules. Attaching them for compiled-in points works just fine
>>> without it.
>>>
>>> The reason is that libbpf calls into bpf_obj_get_next_id:
>>>
>>> #0  bpf_obj_get_next_id (start_id=start_id@entry=0,
>>> next_id=next_id@entry=0x7fffcbffe578, cmd=cmd@entry=23) at bpf.c:908
>>> #1  0x00000000008bc08a in bpf_btf_get_next_id
>>> (start_id=start_id@entry=0, next_id=next_id@entry=0x7fffcbffe578) at
>>> bpf.c:930
>>> #2  0x00000000008ca252 in load_module_btfs
>>> (obj=obj@entry=0x7fffc4004a40) at libbpf.c:5365
>>> #3  0x00000000008ca508 in find_kernel_btf_id
>>> (btf_type_id=0x7fffcbffe73c, btf_obj_fd=0x7fffcbffe738,
>>> attach_type=BPF_TRACE_FENTRY, attach_name=0xf8b647
>>> "nfnetlink_rcv_msg", obj=0x7fffc4004a40) at libbpf.c:9057
>>> #4  find_kernel_btf_id (obj=0x7fffc4004a40, attach_name=0xf8b647
>>> "nfnetlink_rcv_msg", attach_type=BPF_TRACE_FENTRY,
>>> btf_obj_fd=0x7fffcbffe738, btf_type_id=0x7fffcbffe73c) at
>>> libbpf.c:9042
>>> #5  0x00000000008ca755 in libbpf_find_attach_btf_id
>>> (btf_type_id=0x7fffcbffe73c, btf_obj_fd=0x7fffcbffe738,
>>> attach_name=0xf8b647 "nfnetlink_rcv_msg", prog=0x7fffc401d5b0) at
>>> libbpf.c:9109
>>> #6  libbpf_prepare_prog_load (prog=0x7fffc401d5b0,
>>> opts=0x7fffcbffe7c0, cookie=<optimized out>) at libbpf.c:6668
>>> #7  0x00000000008c3eb5 in bpf_object_load_prog
>>> (obj=obj@entry=0x7fffc4004a40, prog=prog@entry=0x7fffc401d5b0,
>>> insns=0x7fffc400ccc0, insns_cnt=87,
>>> license=license@entry=0x7fffc4004a50 "GPL",
>>>     kern_version=<optimized out>, prog_fd=0x7fffc401d628) at libbpf.c:6741
>>> #8  0x00000000008d0294 in bpf_object__load_progs (log_level=<optimized
>>> out>, obj=<optimized out>) at libbpf.c:7085
>>> #9  bpf_object_load (extra_log_level=0, target_btf_path=0x0,
>>> obj=<optimized out>) at libbpf.c:7656
>>> #10 bpf_object__load (obj=<optimized out>) at libbpf.c:7703
>>> #11 0x00000000008b90e7 in _cgo_58a414c63447_Cfunc_bpf_object__load
>>> (v=0xc000237bd8) at cgo-gcc-prolog:1232
>>> #12 0x000000000046c224 in runtime.asmcgocall () at
>>> /usr/local/go/src/runtime/asm_amd64.s:848
>>> #13 0x00007fffcbfff260 in ?? ()
>>> #14 0x000000000041020e in runtime.persistentalloc.func1 () at
>>> /usr/local/go/src/runtime/malloc.go:1393
>>> #15 0x000000000046a3a9 in runtime.systemstack () at
>>> /usr/local/go/src/runtime/asm_amd64.s:496
>>> #16 0x00007fffffffdf6f in ?? ()
>>> #17 0x0100000000000000 in ?? ()
>>> #18 0x0000000000800000 in
>>> github.com/golang/protobuf/ptypes/timestamp.file_github_com_golang_protobuf_ptypes_timestamp_timestamp_proto_init
>>> ()
>>>     at /home/builder/go/pkg/mod/github.com/golang/protobuf@v1.5.2/ptypes/timestamp/timestamp.pb.go:57
>>> #19 0x0000000000000000 in ?? ()
>>>
>>> Here it is in code, where it happens after vmlinux does not find the
>>> requested id:
>>>
>>> * https://github.com/libbpf/libbpf/blob/v1.2.0/src/libbpf.c#L9219
>>>
>>> And in turn bpf_obj_get_next_id requires CAP_SYS_ADMIN here:
>>>
>>> * https://elixir.bootlin.com/linux/v6.5-rc1/source/kernel/bpf/syscall.c#L3790
>>>
>>> The requirement comes from commit 34ad558 ("bpf: Add
>>> BPF_(PROG|MAP)_GET_NEXT_ID command") from v4.13:
>>>
>>> * https://github.com/torvalds/linux/commit/34ad558
>>>
>>> There's also this in the commit message: It is currently limited to
>>> CAP_SYS_ADMIN which we can consider to lift it in followup patches.
>>>
>>> Later in v5.4 commit 341dfcf ("btf: expose BTF info through sysfs")
>>> exposed BTF info via sysfs:
>>>
>>> * https://github.com/torvalds/linux/commit/341dfcf
>>>
>>> This info is world readable and it doesn't require any special capabilities:
>>>
>>> static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
>>>   .attr = { .name = "vmlinux", .mode = 0444, },
>>>   .read = btf_vmlinux_read,
>>> };
>>>
>>> $ ls -l /sys/kernel/btf/vmlinux
>>> -r--r--r-- 1 root root 4438336 Jul 13 06:33 /sys/kernel/btf/vmlinux
>>>
>>> My question is then: do we still need CAP_SYS_ADMIN? Should it be
>>> CAP_BPF / CAP_PERFMON (available since v5.8) or should we drop the
>>> requirement completely, since we expose vmlinux btf without any
>>> restrictions?
>>>
>>> I'm happy to submit a patch.
>>>
>>
>> I think it would be possible to gather module BTF data via
>> /sys/kernel/btf instead of via iterating through the BTF objects, which
>> is where lack of CAP_SYS_ADMIN trips up. The only problem is you won't
>> have the BTF id of the module (which you get from the object), but I
>> don't currently see that being used anywhere in libbpf. I might be
>> missing something though.
>>
> sysfs does not have BTF exported if required modules have not been
> loaded into the kernel. Loading modules would require SYS_ADMIN. Will
> that be a problem?
>

I'd presume the approach would match existing behaviour, which would
mean iterating over the set of loaded modules, just via /sys/kernel/btf
instead of via BTF object iteration. I don't think there should be a
need to load any modules.

Alan
> 
>> Alan
>>
> 
> 

