Return-Path: <bpf+bounces-3164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEC173A627
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 18:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4502807F3
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C11F182;
	Thu, 22 Jun 2023 16:34:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48224E557
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:34:08 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E0A1FC0;
	Thu, 22 Jun 2023 09:34:04 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35MBoO5J022543;
	Thu, 22 Jun 2023 09:33:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=628f++TG59QTOfc6GmJSe8uaJvcukYTTZOE4wtUfn0A=;
 b=LP6zgj2K9DCLkVuN0o3h7v20Li3SOaYY566q0Fx0CotLhO+ZGgpaKZUXciYHA70JUKVx
 iiEXFwqMqFxub+W+/32xKbiijYvFP2ijnXCMK6c8knYbNoMwk+ivw8ClWOs7RtbX4RYK
 YcrUzK06Iw1x/38nkMdw8xI97LAOsOVmzV7gMX2ZOk1I5H2UB3gYTbC2/o+08UkIKVx/
 9t9vSKb+RoHdtSBoY2x0PZGGrfJesjXfqWzMrnFNz1UzYx3OY+XKr9xqTRjazHBWEcgG
 UPm8hyonLK9GnzGAHwkC8YV2597TmFoFp8S6LSwZCisRsJCssQlMU53E9dWc04tTmfA7 Xg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
	by m0089730.ppops.net (PPS) with ESMTPS id 3rbnmp8b04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 09:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHm308RP2pTtevhW/KI60d3t+xDaOW4K4pmTfcBANMckdWGxQ5BAzz4nuKSDT29Fh4i04S6bWSRBKOfR2raB5c/oYEOIgX/Jn7/W4O3F86/KNR1gZKmamZFFCapuJMYt4QzkGW4A4/FbzqkxyeUfiHMV7NGMIioG9eLLhFuLRgnDFz7URqkLG6r8bmMH2OcLkouzKfytiNKQWhmBJ2j31GTfM5GcRNnkFXspJTFUCd3wZuA+Uvmwoz+cWq8JunZTMwXH2WxR0O9dupvVxtsgu4eazP+2eMK12e96C6DVMb3Ot2cJ6nk7fk18qrKsi+jqyT0hDrYrYfJE4xWDIO66hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=628f++TG59QTOfc6GmJSe8uaJvcukYTTZOE4wtUfn0A=;
 b=bJWGyk2Ph8U8X2Mho27fCPl1tLSrtpCug6l42z97tkwjrBOQGqcvi+xWdQbrYY4J3oVwhfI0CDSXIZmXjY6vMU8LDnWGOi5YqvOCTu4o6kiuwfQe1P7k9NBRZH+0zyGsq73tN9ySiFmRKDtO+jw9Mo6Xjm8AGzjtRjg8I9mQPqhnt0XidOkytQ6Scw2W2pFxkw6+LAmUZ1xzgXP1g5K7UYZeUKAty53EKFtPOdfPIZIQqdXxCy9tkhyBcF5aPfpJdRGG5w7jYZh5Jy6tOGyZ8Ws1VPWS9FQMgsALQh10g/7pTT0JUjPR14cKKaFQZOcmq6qi5AJBRCVvFjpfvgnSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA3PR15MB6099.namprd15.prod.outlook.com (2603:10b6:806:302::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 16:33:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 16:33:42 +0000
Message-ID: <0529b858-b8aa-300b-99d9-54c158e71d0a@meta.com>
Date: Thu, 22 Jun 2023 09:33:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next] bpf, docs: BPF Iterator Document
Content-Language: en-US
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Vernet <void@manifault.com>,
        Sreevani Sreejith <psreep@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230622095407.1024053-1-aspsk@isovalent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230622095407.1024053-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA3PR15MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e6835b-d1ff-4e9f-ae29-08db733e70f0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mf9nsN1i4/+UDO0sanaomP6oCee4wybA/WIw5gVwk4K3F7tDJ1qmVy+PTix81tNcdVIUA52KFpmBZ46+jA/giizMDbjd5LmtH6ROr8dZxcAZVHDYUmI+lJRdkCfCgi4e+xSX0S3JHIXuNfj3VY9NdVQMkIuyzWWLQeCNpK4jb43jMJNp2txw42OvXt6BUOTnd8LAXfaNdpBPCT5u+rSIAfVGdJXsa5+ONW1vwYi+dSlvdDZrrKc95o37vrE1TgDiIoMD3rRfXv/RmYSdb3756ih2MtqcmEPYXy7wAuPIuSeokyQzI1iphYKk9V+PyxaFBa94EAX8WhDwjwfHfnG5MD/0PDkeWxOHVzunGHTOxSN79tMqCi/i+Db6HrVLgJVuUpoBtSyaufZcD+ma5u+ulOCLSxXa2PdhuDSKVIqV46z/RHt3m6JnRuD6giOPCEm3rUgDa4h8nLPsRGo8LlAjMvgjsU1Byc17EwPjf9K1cinH07jmPEIZcdvOqBIHxJutGTLESbw/WMLLpwHVkIOYKZrZm1S8ipJdm2JEgzyiXn6ni/wDZfR4cVZullkGT+B38ti/3zJ0NcG8/5okN+LUIQ/SlYvX4TYxYDgOT5/GjSAcd+tFHe6tNTpVKLrqs+3fU9xjjZbBILN+Pnx3mCLaeDD5YBpevmECtFZQCRHkL+o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(8676002)(8936002)(6506007)(6512007)(5660300002)(38100700002)(921005)(41300700001)(6666004)(31686004)(7416002)(186003)(53546011)(2906002)(4744005)(6486002)(66556008)(66476007)(36756003)(110136005)(478600001)(2616005)(66946007)(316002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTZ5d0J3S0svY2JOdks3cmV5ZmMycjlFRWpSY3hZeWM1dlFPNzFCZ3JjSXJj?=
 =?utf-8?B?U1NyNFZKdUw2aTZYcWF6UUFpd3F1SHNWdERaOUZzSDhxNjB1QVNBTWZYdzlO?=
 =?utf-8?B?MTN4dVZmU1I3Q29jc3Q1bGhLU29TYm9hRXgxR09GdEx5M0dCSDI4UWw5WE1r?=
 =?utf-8?B?UEhWY20xMTBra3FMTzB3RTFwZzc5MFM2aUpqWW11QVZpdnJza2lCNkVaMjJn?=
 =?utf-8?B?eGpUVnJjUW1jVk5sSEZNUlZVMG5xS1Z3STQrN3V3OFFwRmhUaDdGWEhITkZn?=
 =?utf-8?B?MHZyWitsR0FGeGxUMFJwTU14N25SRmZmY1VtUDNkVmVVN0w2NVhxTlV6cytk?=
 =?utf-8?B?WGJFb0oxWEpKSWdVaUVsTnlqejRzZXJ2M1BVRkZoQXhpZnFMbEM4NW9pd3JB?=
 =?utf-8?B?NlpzWnFKR0hPYlZ3SCsvb1pMOEplMnlGMnVWdjdSMmR5ZTV1MFIwQzRiUE5K?=
 =?utf-8?B?Y0dpY2h2MzFNNzBQVFZjaytUL2dBQ0dPamVIMG1VYWJ0aUtBT1J1T0RmdXF3?=
 =?utf-8?B?eTdoSkVOSG1HMkdOQ25oN1hHZ2ZoaVk3Uzd1c3U5L1FHdlVpL3JmSThGaTBC?=
 =?utf-8?B?Z2ZIR0ZPOVNFNUZBU2ZmU1IwaU84V0dWR3VoWS9BekVubzZObzlpOUl1VEov?=
 =?utf-8?B?cUNTY3NSUlZWYm0zajZPUWV2TUVaRkwxcDVzVkhSaW9ITFRJdTExVVRTNzBy?=
 =?utf-8?B?cG5qc2lwL28vTGVEdkxiZjB3RG90OXJ4T09UdDVwaHF5QVZteU82M3RnMmRI?=
 =?utf-8?B?aEVtVjlxZXFqVUsrWUNtUGRPYVZNR3pDWmJHM0NLaTAwdmlxOHdLdzlVcFpY?=
 =?utf-8?B?WURoQnNpeStNa3M0MXpNRUxWY081dm1Wd2wzOGExL2RtdHpYbVQ5SGx0WS9H?=
 =?utf-8?B?RTd6NG1XQVF5amt1ZWJYdFl3Y0RwcWNZR1NFOXhKcW50V0lLMTY3SXphanJK?=
 =?utf-8?B?VGhpeVl2YXFiVEJJbGhKVWNGUC9oVS82SGhVYXlMNlV1VzFadHBHNU1JK2Jz?=
 =?utf-8?B?TmxxU3doRGNjVWtpTjYrS0Rxb3VPYmNKaHl1VFFtQ0ZQaitBT3V5OS90WURE?=
 =?utf-8?B?RmRtVnlxZ2wrWXc2eDBtR24xb0ttRkxyWGdQUzhHK2U5UlBHUUJwdFdNS3lN?=
 =?utf-8?B?MU5XYy9CcFZBZHZ0Q210MHd1QU1hNGptOVErZncyOWllR0Y1RUhLNnJkc3FU?=
 =?utf-8?B?WkdKVS9RekZMUmtwZ2FoUlFvdko5ZTQrcXJWUlVMZnliWStUVWtQSzUwSUJ2?=
 =?utf-8?B?UVBpejRjd3V5T2lyM3ArYTBZMVl5aVpPZkdFSExEdjdBbnUrVGhsZ010dHlH?=
 =?utf-8?B?Uml1NVJsdjh2WkxpNEpoMXUwanl3VFdRTU43NklEMEFZdEJsS1RGRkJzQ0Qw?=
 =?utf-8?B?Qjk4aDVUTEROTjVZbXlUeDRZdHpXT2ZZMC9wUjA0bEZRV1luNHYxbkZBYmhP?=
 =?utf-8?B?Z1pwUXM2bmp1R3hxNVQ3aFRjbFRZaEEzL2dtdFQrcjZDalZIQ2M5Zlo0bHFh?=
 =?utf-8?B?M0Z1UXc3eW9ZNkVDT2c5b2RyaE90YUxpblFMM3BYbVJ1UHM1OXh2NnUvV1Y2?=
 =?utf-8?B?d3J3d1hRb0Y5WUdnWHJwMWdudHpNVlE3dGtMMG1oUnJObGgyejFzcWR1Zjgv?=
 =?utf-8?B?clRBN0VLZklJQm9XOWpJR3h5Rno3ZjgxNWlieU5idnhQZ21mcnVhcDBPdHF5?=
 =?utf-8?B?MVE5MTYwdHZmN3lFWkgya3cvK1grOW1DN2FtOXV2eWJTMHExUVZ1aHlrMEJH?=
 =?utf-8?B?ajA4bk94UUJMZjZXNDBnelVvRVpHVW9zaGQxMVRkNzY5bGRBYkRudEJQbGVV?=
 =?utf-8?B?M0lXc0Mva0tHTlNnOTlGZGt5c0ZrcC8xN0xJQ1hiNzRwRDRibjkrOHVleHg2?=
 =?utf-8?B?MWlMUHRKbnMrY1MzYjYvalZUZ05Ob3JkMlYxR3FBVkhDZ0oyWWxIRXBTWDhS?=
 =?utf-8?B?NXIwSkp0a3IxWHEzczZzcEVDWFoxc1RVbGp1aTlDQTErbGR4NFRzRG1RSm94?=
 =?utf-8?B?R0VXeTNpRGFmczV5YzBjdHI4cC9Ma3l3cDJuLysyMUMrN20xOHkybFVxWHVp?=
 =?utf-8?B?UWF0M1JrUG9LNVlLMGh1MWp4OTlWejBDMjYrWDd5K0tGRERJRVVkU0JPSFI2?=
 =?utf-8?B?YnV3dzBTdTEvMVVjZ3orK1owcEpXdmRNUjFsMUgzWU1WVWphcThBRlBSTVMw?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e6835b-d1ff-4e9f-ae29-08db733e70f0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 16:33:42.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWAQERs/I/Fmtztgl5n0qeBeRu2W0buU2twFRX63ngyodjMs88+b9UMx+NXx6Idy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6099
X-Proofpoint-GUID: C3XwDXm3qILeRcg6GNUMHGL8jkLEvV9-
X-Proofpoint-ORIG-GUID: C3XwDXm3qILeRcg6GNUMHGL8jkLEvV9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_11,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/22/23 2:54 AM, Anton Protopopov wrote:
> Fix the description of the seq_info field of the bpf_iter_reg structure which
> was wrong due to an accidental copy/paste of the previous field's description.
> 
> Fixes: 8972e18a439d ("bpf, docs: BPF Iterator Document")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Thanks for fixing the bpf_iter documentation!

Acked-by: Yonghong Song <yhs@fb.com>

