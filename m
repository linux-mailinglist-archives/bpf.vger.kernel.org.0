Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E0F4402F3
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 21:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhJ2TNX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 15:13:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230504AbhJ2TNS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 15:13:18 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19THwQcC023585;
        Fri, 29 Oct 2021 12:10:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ftu40Q2OkHu6197rUXtLArbH4EPxahdtzFHGKmox2nI=;
 b=mkFkRxKSpCYeX69wVGdc1wSNK/z90b8LD1Xqd6IWk1igEitZuhQ9Syr9whun4LW3YilY
 wfuQPciZC4H42xFhycnwMb4sf/HznNVhqBZmvXJtqDiH3T9Jqdl4NAwyE9uzCGhOUFv1
 Bs5FX7N1J+flX/MReC44oNUegDlVPONsSKc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0mdnhpnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Oct 2021 12:10:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 12:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA55Di1s5S5EcF68Agou71Pg+akYFGA+oHdjO9C1rZZT+wjv20+Uih51D1UFtOv8ONzvOUqq8oHd+4WWsLgdIrF/RW929NEegoj+1k2hZoBPuEvSeAccmqRHD8YujNVMMSUYuP8rkOPhL5Hkc9v5f/Uwta1R405USnO/k7Ml4uSL0DI2L+3QYRIx9xbtxepfWJ59B+RL8DgjB79X05NItA3uqHuS5o9jXvKa53iD/nlH4HVHy131s4cAjNea4cu8yDgVk1IQkfXXxSB7OeAVT/DneN1cVKbovE0OcxjrWbgtp7VpBWYAvbubxH0T3AQWRZEDr765JtsxRmmk2xKiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ftu40Q2OkHu6197rUXtLArbH4EPxahdtzFHGKmox2nI=;
 b=cKw9n/XzBXkhSoHH8UpY0R6n2a7kmslZJ8BJRqE5eyMIsIzaKetZPiiqcUDKqHMvS7ApVerVBdBjdLY6tMPOM1Bcfjuvc9bUF0jCGuPHBh3uXo10DUVUxDGcKGlxqiweNZqN8y35u0K0pD9bcnFu5S5kELduDb/h75ZuyLIms1TiAv5VtQJA41UTbtJj2oZ+o1RF6OTfdhTe2trlLaeQnLfSfT98iUzaR7Mmm4lbgTU9meH3OVIvopP4Gnst9UiBwgrZcb5rxO+03yiDI7wAx9p5fzKNhnwwGeE95vSRujPOWijQqhJEQyG2X8zlbDC+p/JuZ/g0DsGb2Q6Aut90uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2254.namprd15.prod.outlook.com (2603:10b6:805:22::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 19:07:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4628.023; Fri, 29 Oct 2021
 19:07:14 +0000
Message-ID: <11748ed0-8de0-1df8-ffac-6b3156a6406c@fb.com>
Date:   Fri, 29 Oct 2021 12:07:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next] selftests/bpf: fix strobemeta selftest
 regression
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211029182907.166910-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211029182907.166910-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21c1::17cb] (2620:10d:c090:400::5:47d6) by MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 19:07:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5a6a16-2a93-46c1-52bf-08d99b0f518a
X-MS-TrafficTypeDiagnostic: SN6PR15MB2254:
X-Microsoft-Antispam-PRVS: <SN6PR15MB225472129EC10D2915D8408AD3879@SN6PR15MB2254.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxglNz5hVcVJyB1dnINVl39ZIwAhWAL3QnG15/z6FLGtjZdfJxsIUvA12hpG31/Ur+JbskIhC2dlZFiylsA/Dg3kepkKqil5et9G5XRBObRzuSgx9N2MOsPlJrP3pDp+mVGZ5WEVXBXVis+jz69AslFoZNjlFo99htIDuewDe88+aOl5GSgdp5JJkUCAqeFn09OTFfZrzI8NtUx6kQUvQjlrG5z5JlwQQQZPV1PyZ7Pe1AHgNWSpKGcrcuE/wTmgsxKTZxuRV8HSV6eWpUZUhp/2Mda0bG5/F1a5vml01Vh702uf/0hiCU5JnSyGd/ryOF4+9Z9Nj3n48dWtHK4Wl3L1imP3QwfcZcr04emQSM4OGG1ORLzOy0b6rZpy9dePKA1IWfWpGtGk5kGT3M6m0l4znUZF9dztlJiURgq2FihPbrsea6PTpTrdOSBv+mqaT3GLA7XXvmsp6Bp2t7op1DcNJW/vs4WVabgWiIs9Gjc6LaAFImJNcmaKpOCL/hx5fr91g1+43LKPexQTL+Jj7Jr2Iw9JH+Fyu4IfEDH+pplzS7HJ+KwlGk2m0TB9NRfN9LIaCBfGrOgVN/KJ+G6NDvaftLSIwmFh1YFyQ6IuNzjkxKETqVbEbRqrgcprLq6uIG6nWfidgspDiArPA+OBW5U9ghV0IsVnHc8DdIskrjNFVOr0mWYPs4TciD6q0SG7OpghwJb+gkdTtU20lyVYNYml7p3/HGGfWP5MfICU5u6IJSl4eGKqAFrxIlCAbssx5b+cdxhZ5B7kQa6n3pQjhsiwnSm8+v7pHVf2kqqay6/svFi2mt117894OuSasroSpETEx4XEWXCttCNwe6TLRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(31696002)(38100700002)(186003)(53546011)(8676002)(508600001)(86362001)(36756003)(31686004)(2616005)(316002)(66556008)(66946007)(5660300002)(66476007)(6486002)(2906002)(8936002)(83380400001)(4326008)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFlrZ2phNmlJa2xkT3J5TWl1Y3RiYUJRdE1pWFFkd3FKN3huRXJmRmNrUGtS?=
 =?utf-8?B?SUhjVVRjNS9obDNhbERSKzZyMDlhZTNDZ2dXUnc3ZVVtZnpYRjJOdzlod1Ar?=
 =?utf-8?B?aWIvaCsrL21YVi9SNEd4eGR0YnJBMUdPNkdJWG5YL0hFZmxGNGh1cmQyd0RB?=
 =?utf-8?B?UlBHNDRwZ3l6ZzAvNW1EanR1U2xSSGpKb1RnZmhuMko1S3YxRU1YUG82dHNR?=
 =?utf-8?B?bkcxTEwybmZ1M1N1NllaZUREcy9LV1ROU0FRVWVoK2M3bVMwTFRRcXR2NUg4?=
 =?utf-8?B?NjVVZERka3J0MUNXTnhOKzgra1FxdDY4b01xMGNtT0RBNnZ6NTZobTViVS8w?=
 =?utf-8?B?bVlRcFYzOTZCWUFXWjhqbC9PUXl4Zm95ME1VWnAvenVOZGNyL1hrbWQySEdh?=
 =?utf-8?B?Zk9raXFPQUx3UFdTS05YS2JpbmtoLzBlRWRtcGd5NnYrMVR0MFpXOVgrNXdl?=
 =?utf-8?B?bUU0Z2IzeldjbmUyV3FFUk81bHhhcG9GQ2RzOUFObVVzTzhiNHZKd2NwaER5?=
 =?utf-8?B?enJrdHpKVDFoK0tCMFZpb1RZV2NORHc5SnEvU1lSVDkrVVYvWTNWeXZxSm1u?=
 =?utf-8?B?UjFJclYrTUVScVdxYUEvenBFSzYvS09mbzZvQ1o4VXliM24wZXR5dE9kaGdT?=
 =?utf-8?B?WFBTMzZzRSsxRzJzZDlHR2YzcFpERk9qVlordGJRM2g3OGZjZUU3WkxNMDgv?=
 =?utf-8?B?RFVrUktvQ3JlVS9qa1EvYzJEZ2lWTUhVeUdSLzJKMW5DWnFpWlU2dndjdlVv?=
 =?utf-8?B?K3NTeWdxaTBBZ1U0d2o3VnFLOG5yaVc0M2VJanYyTU1iUTNKMkUrQzdFNUZG?=
 =?utf-8?B?dEJWem0yV1VQM2pmSGpHa2ZJVWVyTTRVbVc0MnFqQlNON05NMmJ3dFJZY0JM?=
 =?utf-8?B?cUIrc050SUtpcWRIY2xnb3AzaDJzTmZNQ1lCVkdBMUJKU0UyU3h5cDRLak43?=
 =?utf-8?B?eFAxWmtGSlB5MnFWK29HN1BtUzNSZys1WkxlYjFYZ2ZmVEdZYTlMM2plL3F1?=
 =?utf-8?B?VXlSN3FUZnRhWlZWT0xzWjZ1Snc3NWRMVkk0NUJIWmNXdWllUnR4dzhGZ29h?=
 =?utf-8?B?bm1Tcm1xNmozSXAzUVMwb3MzZTFjN3dkVWRIVG42Qzc1bGxWNGRVOHZaS1ZP?=
 =?utf-8?B?V0l2Q1ZXaEJBUXBKN1U2KytOZys5OVZFNlhoczR1WWFzL201bUNjd3FhSkZz?=
 =?utf-8?B?YWFVVGlnQitOa0hFQ0V5Nzk4NkU1bklJVHNIakgvQlVPcHlzbDExRlZRZGls?=
 =?utf-8?B?Y3RWZDhTTzhqdTZ1YUI5cnRtWUdwRmg0VFZaa2NEdmE3aXlyVHE5eEQ0NUY5?=
 =?utf-8?B?VkoyV1dJWWk2aEdOeUFGMkZlYSs1ajZLOEphTzZEbXNtSXlGOU00YWpIZkU4?=
 =?utf-8?B?SW9oSDk5alhBQmF4WkVFZGVmRTczOXV0RndIVkV0Ti9PaDNwMWlOclEyVDlk?=
 =?utf-8?B?Y0kwVUp0VkRuR0JmSE5ndVpHRHhvT2R5Y1o1TlNKTitpWnV1MXlPY3k5NzZ3?=
 =?utf-8?B?REFYMkkxbGZQdk9VQlAxYUNQUGJHbEtlVUdvRnBxNFZ5N1BYMFJ2aDdpSlBt?=
 =?utf-8?B?UXYzcE1vckFtSXJscVZVeU5vcEh2VUZzVitSa2M2WWdmaTBoMmNLM2lkTTBk?=
 =?utf-8?B?Q0JVTFZ5SmZzakVZRGN0QkhkZGJVRngwNGg4NkFkWjdycmhnYXFmSGFhajhI?=
 =?utf-8?B?YWdsdnA4RnZJdSsxRHEwY09pZE0yZ0I0RGIvTWVNajlCZlZEZ1JpazhXaXQ1?=
 =?utf-8?B?eWptcjdqcjRDSDZ2NTNJN0tyTDVIdm9TVHQ3eXd6V2h6RDlhcVliYTRpeGd4?=
 =?utf-8?B?bHJneUtXdEpoOTNWSmNoVTZYUmREeStSSzh3dkF2Slg2WXlWa0dtYUQ4VDVr?=
 =?utf-8?B?NFUwbkpzUFZTWlhjb29sbVFPeWU1ZGpFVGNPdDhyNGpmWXg0clEvZ0xhRHky?=
 =?utf-8?B?bFJRUlpEM05QKzhVamIvM3JFZ3NnWXh6OWU0QWVGemN3ZnljYW9RbCtuczUv?=
 =?utf-8?B?WmxHZHJXSHJPc2pZN2pzUllqSmlLdmRSbCtJVWUxeHoya0hxdTI5MW9QTFNy?=
 =?utf-8?B?bHNZOVArYVY5eDI4cWhreUJTL2tXRWVWYzNLQ3l1MEdRakc1TklHTUVlWVNW?=
 =?utf-8?B?MlZzSEJZNGFVVUVvVHZVaWlPUWUrNUZZZ3BQL1VyMy9XemQveHhyODNTQkx4?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5a6a16-2a93-46c1-52bf-08d99b0f518a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 19:07:14.5489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RW/bUY8nWhD6T8n7ykvolpd8OmCjLD7KUiQthqnGFumRQrpJmhLweoxuNO0MSBhX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2254
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: NJqNCIGufPj9KmqitDQMLWEFghS8jM0V
X-Proofpoint-ORIG-GUID: NJqNCIGufPj9KmqitDQMLWEFghS8jM0V
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_04,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 mlxlogscore=823 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/29/21 11:29 AM, Andrii Nakryiko wrote:
> After most recent nightly Clang update strobemeta selftests started
> failing with the following error (relevant portion of assembly included):
> 
>    1624: (85) call bpf_probe_read_user_str#114
>    1625: (bf) r1 = r0
>    1626: (18) r2 = 0xfffffffe
>    1628: (5f) r1 &= r2
>    1629: (55) if r1 != 0x0 goto pc+7
>    1630: (07) r9 += 104
>    1631: (6b) *(u16 *)(r9 +0) = r0
>    1632: (67) r0 <<= 32
>    1633: (77) r0 >>= 32
>    1634: (79) r1 = *(u64 *)(r10 -456)
>    1635: (0f) r1 += r0
>    1636: (7b) *(u64 *)(r10 -456) = r1
>    1637: (79) r1 = *(u64 *)(r10 -368)
>    1638: (c5) if r1 s< 0x1 goto pc+778
>    1639: (bf) r6 = r8
>    1640: (0f) r6 += r7
>    1641: (b4) w1 = 0
>    1642: (6b) *(u16 *)(r6 +108) = r1
>    1643: (79) r3 = *(u64 *)(r10 -352)
>    1644: (79) r9 = *(u64 *)(r10 -456)
>    1645: (bf) r1 = r9
>    1646: (b4) w2 = 1
>    1647: (85) call bpf_probe_read_user_str#114
> 
>    R1 unbounded memory access, make sure to bounds check any such access
> 
> In the above code r0 and r1 are implicitly related. Clang knows that,
> but verifier isn't able to infer this relationship.
> 
> Yonghong Song narrowed down this "regression" in code generation to
> a recent Clang optimization change ([0]), which for BPF target generates
> code pattern that BPF verifier can't handle and loses track of register
> boundaries.
> 
> This patch works around the issue by adding an BPF assembly-based helper
> that helps to prove to the verifier that upper bound of the register is
> a given constant by controlling the exact share of generated BPF
> instruction sequence. This fixes the immediate issue for strobemeta
> selftest.
> 
>    [0] https://github.com/llvm/llvm-project/commit/acabad9ff6bf13e00305d9d8621ee8eafc1f8b08
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I am working on a llvm compiler solution which may take some time.
For the time being, the workaround looks good to me.

Acked-by: Yonghong Song <yhs@fb.com>
