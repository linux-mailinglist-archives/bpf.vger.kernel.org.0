Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000A945AB79
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhKWSuw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:50:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31436 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234139AbhKWSuv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 13:50:51 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ANIdfcI016306;
        Tue, 23 Nov 2021 10:47:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=61AdtZK5UrISWst4lIuRWVrRvWt5KKGUEBlr7yYFCS0=;
 b=hON/sSBHKj6e1zKk9Jll2xEJhZybFzRGkByilC8aH/A6P/HB/WZh9xub+eIyWK/+AxTi
 Ktkq0qrNyCu9tmk90f8/Gvr+ZZmnzpTsCg16xiqoIFN2B5hz8BvD6B47/pZGv7zTOCaZ
 gyjifuV2gX7LgVVwGXGPCSIgPJsc6lLz4eE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3ch3v512x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:47:08 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 23 Nov 2021 10:47:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0rbDN7ledxfS555NQ/P8aerkNxoz9nJUOVUSJUTHIIWoVL8DIBCgJo7erDJex4KK5qto9f/iqMMfiAcmtnkdhfL/ms9fq/cWSvCU+Jez101OJVkZ4oRIexYmOS91Wz2kkxWlfCar0BX161EkmPH7htkARWv14itDljKiab/GNTYsKv1CG3ZNkaC9Ca+QUTJ/1Lq53yIZI2abwdfSZZGyhOwFXbRRYbL7vkVrTE7L9HZHxtKc3TOyBjAzZ0Y01zVn+T0dbZiOwz7Tn0HJShpxDrsOhlawf8TPByQ5Ki4qLgNFmJ0rRoo2JxADIbq4VFQpTYNGBL7SLQuHm1iwHW+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61AdtZK5UrISWst4lIuRWVrRvWt5KKGUEBlr7yYFCS0=;
 b=jte3WlXU7WqzezY2vgx0cL20CbLRclLqXMDdncKvhxMKvCH1EJ8kE/TgpLkCieTN93iit1+z9gwnWq6Ysa+DIG+yF75i91bZlZkci+sfZArEu48powKwfvmPCs5Y1413SGuLSzankUCX3RqjolcfEISStUPiipj9g0f07H8I5+gFhe3kswZtDbBum/E98YN3zBNKDDuB4EWgYxlRWy7c4CD6rOfbjm/Lb5WHnqkKSbVplQmdlj9sZAh1+Mumh9n0IJPkclptEKdE4kTMpuf89xcgOzU3OoUEXX9b/zbsRagQdmT0NU4t8ubi570zRvPsAEUxKH6yukLojERnAefg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN7PR15MB4208.namprd15.prod.outlook.com (2603:10b6:806:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Tue, 23 Nov
 2021 18:47:07 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 18:47:07 +0000
Message-ID: <80cd38c9-37b5-6713-c634-15ffa4d88065@fb.com>
Date:   Tue, 23 Nov 2021 10:47:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 bpf-next 0/4] Add bpf_loop_helper
Content-Language: en-US
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <Kernel-team@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20211123183409.3599979-1-joannekoong@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0061.namprd21.prod.outlook.com
 (2603:10b6:300:db::23) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c083:1409:25:469d:91d7:d5f8] (2620:10d:c090:500::2:4d33) by MWHPR21CA0061.namprd21.prod.outlook.com (2603:10b6:300:db::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.5 via Frontend Transport; Tue, 23 Nov 2021 18:47:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db4f792-bf70-47c0-0fbb-08d9aeb1a616
X-MS-TrafficTypeDiagnostic: SN7PR15MB4208:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4208BC0F08468223909F1F3DD2609@SN7PR15MB4208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzG3SW9dJdcNNufOmlov4r/Ml4utjgsPnS7Xs6uoyjnN3eowZHu18miFUvNlfRRx/RXlswk65vaVmfjbBR+L64kv1KAC2tOU8BeYjDZNPkwcbv9EmrkHPVfp53UBHU44Zqf5u5b41QgdkqVmaLRViYFpvz8tEHglbsny5nt+s97e4qNR6Roeyxt8ag2sSKMDMllMgHgRsg04S5VgcN9IWjN8+uJqi84TKzyEXTeeieomni+XwodDj9wJXvtVsLahKzTVWTLRcX1Xu12/Sm7l18e91mDCbLyzJ+2gv2hoWdvmAO1DztsPoMgre0dpgBb5Woww9rrCyyiuSDfw7gZu6vSDUhEaMJdvFig9bE5R2Uc8ZWw4GmDJheRqoshWUX2ZHRrwcG03Ont0DfnEzTfXj+nPyIpZPD8VfqMXah+30rI/iWsUpi4JnA/ydqXWHqw3Gtvey2EJiiJMtF35P6Sxa3HTj2IeDJUdchxrV+VIlpvsrPt8w8RMuevSvIZV7e8V3kMFyuVFOWnYMgIJWiDCrjqeHcG3GI14w9m6ot9tjh1tkSTEqTNGOxrI+6x9Z9ft8v22qsU0Ht3pEXhOGYPUtz0vndT/2fRp0mr0kaKsGp1ZS0VVjcHr/orDOJwmhXE8Nn6lC42WhdJ1sk8VioMmpqoI93WUGmRt6GVqykpaVF8M0zSPWOksUlKAvzau7i5E2QFfWof75AqgxASxHkhBTtaRtd9jz0/FO2/91JnRFgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(186003)(6666004)(5660300002)(53546011)(38100700002)(86362001)(31686004)(6916009)(66476007)(8676002)(66556008)(83380400001)(8936002)(66946007)(4326008)(2616005)(36756003)(316002)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VktZV3pVVUpzd3c3MmR2NWVuRTdJUzFhQmppWGM2VzE1aEVIRDc3WHdIRHhk?=
 =?utf-8?B?MUFEQUM2d3g3VytVL3orZDMwRkdrVURERFc0L1lNYWpucHptRFNHQVpkUzRp?=
 =?utf-8?B?N2k0YzY5K2JFanA3RTIxMWF0bk45MWJJME04UExRRzBXbkVaVkIvcFZoTU5m?=
 =?utf-8?B?NWduMnVITllqUmYwalVvWk9sWkpLbmJNWWVBb2dPa01PR2dFYTJqSVJyYlZx?=
 =?utf-8?B?Z1EvZjN1b0MvOWVqS3hVWHRBRHFTVEtRb0diTmdHSzlrNkwxSTdrMnZuRFlG?=
 =?utf-8?B?QXRaazMzY1c4NjdYOHBTVVJZeFVZU3JhWlV3NFBXckdMem1MNW1zc1VFSEdi?=
 =?utf-8?B?Rk9RQlhIQ3pqVlo0cWZ4L2lQUlZ6RCt2d2d6RVBHSkp6QWwrSlNoOUNXUFE3?=
 =?utf-8?B?Ri9OTHhHcW5sOVU4blArWE5tbDh0ekpEQm5WeHhxU1JnM1NqMmdmSUk5U3ZN?=
 =?utf-8?B?dWtEb1Q5RmJHdGp3RkczTkpkSXJRc1pBaTVJNWZMRk9KNU9EZHZHSUFGb2dn?=
 =?utf-8?B?VzdVU0llOU5jcTZvNktPS3lOeVgwcWduekNiUmsxM3UwTmI1Rm9wMEh3c28r?=
 =?utf-8?B?NW0vdzlwZ1Z3MUNkMkR1ZXFJdG93MFlzZkJSK3pMdGdFSEpOay9ocXA3L2tl?=
 =?utf-8?B?T1k4eDVnQlNhQ1FhRzFHV3kydjZ2S1J3MWZzNUNocTdidEw3U1dNOEJJR0RB?=
 =?utf-8?B?a3hUN1B2Q3FSU3EvQTN0Z0NoWlkxYXRBZVo1Vzk5MjBoMUQ1ZzZLbWtKQnNl?=
 =?utf-8?B?L29qUllxcHRBTDhrdnI5YTViQTNCVEt0THg5NkFZUXVyb2ZET1R0M1c5cWpz?=
 =?utf-8?B?Q2JOR21MMEg4MHNNQ3NBMkJqaXRJeVpoSGZWYnJ5aHZTTUlMKzNudk5CSWVF?=
 =?utf-8?B?SUorSUtKRlJCaW1RZFQwYUdZdDlpUnZRV0VDYnc5NjhNTWhYTzRiV1FOT05h?=
 =?utf-8?B?VU1WbGxGQmZvTGRUVnE3YS9obnhPbGZuT1p0RUQvRG41bFZtOEJTMklDb281?=
 =?utf-8?B?N2NNQXUycDNzOEcrMjIyWXpaK2dCRVBUUWxFUFFQVW9TL1Bld0JrSjBiYjdI?=
 =?utf-8?B?cUduTG1KbVczWEpBRGNzWVFwcmFTWFdWN25EME1HQW55YmZrQlk3SlZSWFdu?=
 =?utf-8?B?bVNzdXFQQTUxcHkxWjl0NzByejgydUs2bHlkZ1lDWm9WLy94dDZBSjdGSUNL?=
 =?utf-8?B?QnZrczdsWWJWZmlpZGpwNFVSV1QwMmJ1TENJSjdYZW1JZXMrQmY1UGNxQnRv?=
 =?utf-8?B?eHBmZk1xZ0tUZ1VWejRIVDZnL3hRZlRiNjZnNU5jbm1xd0YvL1NRdWQzTDlj?=
 =?utf-8?B?N0Y1bnFxSzNtb0xuaUtneDlhbDNTVGpEejhOclc4U3ZpbUlTRkh6SEpYS1gr?=
 =?utf-8?B?UlZtYU9EbTFNelpsaHlQM1V2MDlrSUYxSTRGelRwVkFKdVZ5WVg1ME9NZEVl?=
 =?utf-8?B?akl1STYwMDYxME1pNXFySkhxSFIzZWFhTGJILzA0NnpWOENQSXN0YWp2bjVQ?=
 =?utf-8?B?cHRWZW8way9heDVFQ3B2cnBtdURobkVkb1NLdlZhVzFBY3IwWGs1dVhVdk9m?=
 =?utf-8?B?WDF2dUxMbWVIc1BLNkdyN2ZsZms5NGRtUXNYUGlqQ0NDV1VWSlM3V3RiSllN?=
 =?utf-8?B?S3R2QmpucEVneWxwVlg2Q3ZoalpJTnRjeFBraEs0R2NXZVFuNW94Rlp4Smx4?=
 =?utf-8?B?TS9xQW5TazU5VXR1eWhFQUJCeFFTNW9WUlVGcGF5Vk8xS3Y2dlMzc3BVajBS?=
 =?utf-8?B?Q2F6VjdDWjFqc1VQMmRGc3k4b21LT25BYW9VWXJyK2NKd293bUdHSDdJRi96?=
 =?utf-8?B?T1hCYkgydUtBUDJLTmdPa0pTVStXd21VWWZneG4rZzgyYVJCb0w5MERMdXZO?=
 =?utf-8?B?L01Uc0Nxa3ViWGpEc0N1Rlh6SWkwdTRaWlI2MDZXR1dWcHpjdTRuc09KRWtE?=
 =?utf-8?B?b29sNmlZcFFWdzBhNVFHYmMxeWpobHpFQzZKdmRNZTBjTlU2Tjh1aEh2T1VB?=
 =?utf-8?B?a09MRUFmbUF1SUpzUHM0d2NmcWE2cjBnUzVMa0pQK0J6a24zMmhsTE92TzZB?=
 =?utf-8?B?RmZCQ3A3M05aWnBLZFBNV0dWRGRHSndzc3JwZlhsYTF3SDJHMHNUcUZDd3h0?=
 =?utf-8?B?eGhTOTF0NXZMSUxkdGtLWmNsRllMeUhaamdTbTE0c3VSN2RZdWZoQ2FOM2R5?=
 =?utf-8?Q?+9aG1eYRInajitInXlN3tykUGgmjPHk1MsE3SPgejgBw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db4f792-bf70-47c0-0fbb-08d9aeb1a616
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 18:47:06.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbkJb5njD1OtceM4nf0mEWPeWPbFKJIXZLiZAQCJMKF4J6ZWQ+wrRp/zmur6jhJmU50l77muuUeHW5+uAX/cWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4208
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: shFecYPAWqG79RVgLo0E4BkgLA2az42E
X-Proofpoint-GUID: shFecYPAWqG79RVgLo0E4BkgLA2az42E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_06,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=842 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111230092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23/21 10:34 AM, Joanne Koong wrote:

> This patchset add a new helper, bpf_loop.
>
> One of the complexities of using for loops in bpf programs is that the verifier
> needs to ensure that in every possibility of the loop logic, the loop will always
> terminate. As such, there is a limit on how many iterations the loop can do.
>
> The bpf_loop helper moves the loop logic into the kernel and can thereby
> guarantee that the loop will always terminate. The bpf_loop helper simplifies
> a lot of the complexity the verifier needs to check, as well as removes the
> constraint on the number of loops able to be run.
>
>  From the test results, we see that using bpf_loop in place
> of the traditional for loop led to a decrease in verification time
> and number of bpf instructions by 100%. The benchmark results show
> that as the number of iterations increases, the overhead per iteration
> decreases.
I will change the wording here to "led to a decrease in verification 
time and number
of bpf instructions by approximately ~99%". I changed this in patch 3 
but forgot to update
this here as well.
> The high-level overview of the patches -
> Patch 1 - kernel-side + API changes for adding bpf_loop
> Patch 2 - tests
> Patch 3 - use bpf_loop in strobemeta + pyperf600 and measure verifier performance
> Patch 4 - benchmark for throughput + latency of bpf_loop call
>
> v1 -> v2:
> ~ Change helper name to bpf_loop (instead of bpf_for_each)
> ~ Set max nr_loops (~8 million loops) for bpf_loop call
> ~ Split tests + strobemeta/pyperf600 changes into two patches
> ~ Add new ops_report_final helper for outputting throughput and latency
>
>
> Joanne Koong (4):
>    bpf: Add bpf_loop helper
>    selftests/bpf: Add bpf_loop test
>    selftests/bpf: measure bpf_loop verifier performance
>    selftest/bpf/benchs: add bpf_loop benchmark
>
>   include/linux/bpf.h                           |   1 +
>   include/uapi/linux/bpf.h                      |  25 ++++
>   kernel/bpf/bpf_iter.c                         |  35 +++++
>   kernel/bpf/helpers.c                          |   2 +
>   kernel/bpf/verifier.c                         |  97 +++++++-----
>   tools/include/uapi/linux/bpf.h                |  25 ++++
>   tools/testing/selftests/bpf/Makefile          |   4 +-
>   tools/testing/selftests/bpf/bench.c           |  26 ++++
>   tools/testing/selftests/bpf/bench.h           |   1 +
>   .../selftests/bpf/benchs/bench_bpf_loop.c     | 105 +++++++++++++
>   .../bpf/benchs/run_bench_bpf_loop.sh          |  15 ++
>   .../selftests/bpf/benchs/run_common.sh        |  15 ++
>   .../selftests/bpf/prog_tests/bpf_loop.c       | 138 ++++++++++++++++++
>   .../bpf/prog_tests/bpf_verif_scale.c          |  12 ++
>   tools/testing/selftests/bpf/progs/bpf_loop.c  |  99 +++++++++++++
>   .../selftests/bpf/progs/bpf_loop_bench.c      |  26 ++++
>   tools/testing/selftests/bpf/progs/pyperf.h    |  71 ++++++++-
>   .../selftests/bpf/progs/pyperf600_bpf_loop.c  |   6 +
>   .../testing/selftests/bpf/progs/strobemeta.h  |  75 +++++++++-
>   .../selftests/bpf/progs/strobemeta_bpf_loop.c |   9 ++
>   20 files changed, 745 insertions(+), 42 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
>   create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_loop.sh
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_loop.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_loop.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_loop_bench.c
>   create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.c
>   create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_bpf_loop.c
>
