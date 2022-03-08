Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E94D1FC4
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 19:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349421AbiCHSLd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 13:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349415AbiCHSLc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 13:11:32 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17A5676D
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 10:10:35 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228GmXoI013700;
        Tue, 8 Mar 2022 10:10:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6zCeemPHs7K5/Nfj870y6KtAkR7099KER8xKuDtbEdQ=;
 b=QzW1WGGDxuGBZOA/WTyvA9Hkgm/PsTC53KpzcPo3f+n+vNqoYzxYx0+qsY5IBT0FEO6k
 loVBaWIhSwnESyqnQTHMwLTRo2w9nCF7OUbsGkfUKaqrj1jmi6VSaybU9Q5Ax8UItYd0
 fuS+jplwLEnC82CmyMj8ja79p3q89Xw8Tjg= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3emr97rfxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:10:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRMgcF9buwZjRaPm8U5AbZGTWHsbp19s/kK+mJo8MP8mv+/LzGiHHoXWgul5AQhPH/HalwNwUcz2qWb+nu/VqNSwjpF1KrS/HnT72gH8RhKruD1xCZIxnJctZa2G09VgRHzU2s4YDBbtfft08BWz0m0toaAhA38xeupCBel6pLsKO6wqLYCXjlOr92U9WicBkoOTh43uHIoVeGWa4RyTYQcONbQLetg6q1tBEGg5dlq3QToeXg7bGFxQZL8QqTGzfN/1RhhUBU077WuQ0Wl2SqDrnBjwUow6PZ0JgVHpOhh8uOagx2+KLkzn9YB397z36lbcICefS/lqADVJnB641A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zCeemPHs7K5/Nfj870y6KtAkR7099KER8xKuDtbEdQ=;
 b=fJkn26qcqEHIBceZzEplPO/8c3BzJsSLROSkfFiQvrFKh752vC4FBejx0rpa0hH9hfOSkvJF1mp9EBLXEgYguEHGUneualdv5TmRFN042Gjsgvjh5In4o0TtiQ2GE91MigOYXZlBRPrm7mkl+6HK1Yl3i1dS0GEiDm0dOlu4xM7kFYzrxm/yx4V5kMo4z5AKOaOdIbZPKICGar9wPEPD2hNwZUR3IDpiL+0CwqJtlTAIs7VmnCvrQ5k4Fe12pmhVqqmBmwhIjmsTlRUSBclKeKl6bB0S5QZ2UoMt2A90vgYrPHSKsy7TKaiL5c8nHddAxEDyhFX4WTvJtHU19MqeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1343.namprd15.prod.outlook.com (2603:10b6:320:25::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 18:10:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 18:10:11 +0000
Message-ID: <dc5fb2b8-8fbd-1dde-62df-d992b41dab39@fb.com>
Date:   Tue, 8 Mar 2022 10:10:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Content-Language: en-US
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20220302212735.3412041-1-mykolal@fb.com>
 <8bb551bc-c687-04fe-d588-6beb1495f01d@iogearbox.net>
 <2DDD6C41-0584-44F5-8D85-4460EDFB2C40@fb.com>
 <e0f14903-9212-606c-bff2-29232b51ee1c@fb.com>
 <20935470-ECF3-4D64-A31C-7F02433D9FE1@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20935470-ECF3-4D64-A31C-7F02433D9FE1@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR08CA0052.namprd08.prod.outlook.com
 (2603:10b6:300:c0::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9864c3fe-5247-4444-3570-08da012ee30e
X-MS-TrafficTypeDiagnostic: MWHPR15MB1343:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB134368A9C845D3F7F563B6E6D3099@MWHPR15MB1343.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNQO0tDQwVPdlVkpKsTye0f8fMrRhwg7k7nu7NdhXymyKiI8pnQ/HQee4opwCEpfNi09zNt+LSdDQ4KnkcAKv0iO458iNrMNSUmtMofOicDZMRLnTXGDyzgybStWvY7vN5r66PLTtkmJMdu69sEta4+TV2PtdTUEwQJjt2ICxbNN5vGZaNKNSCpnWyIyizzRFLKa0yWyG1Jw+oOeuOwwczFyeDAP6RVvxbq+VrOLUXq/bQzFTe17YlnSB4++0/qoSoKE6FLVVxyVZCwn4O7JaKokRFh8N4v6EAR/TA2KjB2N4oHonQyQkoLUUtiTeQTMV4jg3R6elkFIkHsBrp20mdaGpqmVrfBkm3J63FTf04wZ9YU2d+jHUjk2JiZ3mN3owNnPvfkjKV7+JCS55+jUUFYXlPoV85f/OYtane543VCQ3mOXyEbIlmH6VnTm7avB4UZRFTkGOosOXAbni90DhqZPuaAdRkv5GE5sB6me9anKVz993EYEgW0gaC3sXA03lg+SPh1i+7qoJUl21j77oAQhzMT7aRbyfgptiumevJEsU6CD81QYuNIW7UQLnuwh6wVaH3Y1el5cGKpq7kBsMqvj4/ojJxewXrtQ2B1V+c3q8eFdrF5lYvzF/wZ+JF/1ycA4QNMkYYXzywaXKPq2IgShx1nLBBRgJVZnYHyZtwEkwXs24lPMZ19iIp7nsRWgbDEVOB0aSe3RYHzU+rs6/geCHiI18ZwOfxzw4yJ/fjzYK4zconwNf9qeRpnrKE8Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(31696002)(37006003)(54906003)(38100700002)(6486002)(2616005)(6666004)(508600001)(5660300002)(83380400001)(8676002)(6636002)(4326008)(6862004)(2906002)(186003)(86362001)(31686004)(66946007)(66556008)(316002)(36756003)(52116002)(53546011)(6506007)(6512007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXl2V09ORmFaZVBsQWRwZHBDZXEzYW5GVmpiTXRsMmtDbldZaUlGbFZiSTlU?=
 =?utf-8?B?Q3phZWJISVF5dlJVakE1SXNYLzd0YnB1c2w0S2wvWkxteHhGYzErNFQvdXlz?=
 =?utf-8?B?MnErUUg2aUtPTEM1OGJkVmprT3hqUTBML21yQjhRK0NzR0tBTEwrU1B6R25H?=
 =?utf-8?B?ZTU4UGMvTjRodUNSTmVmYzl2U2FzL1pyWDBXZlN2eXRZYTJRQXJoSko4ckE3?=
 =?utf-8?B?RG0yS2s1QVVUaFRyYUNDQlZ0ZC9tK3l2cmRYTVRDTGs1Mi85NHFGUWUyeHo2?=
 =?utf-8?B?YlA0K0M5ZmFLQXMwWXFKN1FjNmhEeGRvTUh0dkkrZFdoT3RqYU1lWi94bzc0?=
 =?utf-8?B?ZEV5d1dQVW1QVDE2ampjM1FNYld1VUFLUW5Ed2kyWDFHR1NxRXFWQ1JYZmZt?=
 =?utf-8?B?L3k3Nnp4ZEFUaXdUcDF6aFBqY0UzUHQrbFVkdkpUem9rUktidmJzOW9MS3J6?=
 =?utf-8?B?UHdFRVRRNmcwZFlvelpLWktuRFlwMWNodVViODdRM3lQamhEOG1LS0V1Tys1?=
 =?utf-8?B?K0YrOVhmTUs5QVBlcy8rNlZkVG5Da1liRkJGMkVGRnBqQjJkNk94ZGdNOTdL?=
 =?utf-8?B?bEFadm9uMDFBaU9tVGxJcEdqR2pkaE0wbVZIbzFWd3BMUjdmbkNydXVWZkZU?=
 =?utf-8?B?OUc2cHdUOSt6ZHdUZ1ArdU5EWkRhd01rSW04MjF3ZGVjQXNRT0pMWUdpOVp2?=
 =?utf-8?B?UUcrOEVRVWVlN0J3K2x5OVlTYVJkQkxxQzVJUEJnSnlKamdLbVZzN0d1WjUz?=
 =?utf-8?B?SHBDdEVZTVJGY2xRMDJuWUxPZDRyVEhhYTRSMmVaS0NIOWt1NlY4UDRBcEZE?=
 =?utf-8?B?M0EzSUtKVzB1TXJHYzBXZW1oUWloTUxhYWJIeXpsYlV2cmVZeEtWNUxYc1dR?=
 =?utf-8?B?LzhSQ2ZnTlhnUENKRjlKQUp0aVBVRDNGZ3lMZjZWRTNPa0JWSTdHTmRyWThP?=
 =?utf-8?B?TWs0NFBDZzd5R1JCRmduWDhGUExIK2ZvNEZCMDUwVk8vclVmTXo2R09sd0Iy?=
 =?utf-8?B?MUJCZTNIZk92bmZZbkZoa2x6WDA5azhLdWVkcU0rRGtBc3Ara0piSnUydUh6?=
 =?utf-8?B?cGhaU0hMU2VUdlJpbFhFcExGUEdodFl5NVJUZ1hjWmRnSzRkS1ZUck5uNERi?=
 =?utf-8?B?bVY5WUNRZFlvaFdHejEvRTdSUVFwWVUrc1JyYXJsK3NuLy9QckRGaGFVbWM5?=
 =?utf-8?B?ZFZ4VG56K2NtSHhZUXhSNE9OMitjcG5wVHE5SmllOTlRWVQzMWFMQTZGNExQ?=
 =?utf-8?B?ZElMZThsWkVoZStYanpVQkt6bGRLS1VSVEhPQWlyeEg2dm41bWg1b1VyOFNz?=
 =?utf-8?B?QWIrbVV1M1pkUzU2blNaSVV2QVE4OFBRMytEcEFJNE5RTW9QV3dONWljNjJZ?=
 =?utf-8?B?aXJjdEZUcHFxVWVTMW1Yb293ZTRJZEkzVlNHa1pNaWJVWGMxZU9ES1VPa1dy?=
 =?utf-8?B?N2pBdzZDWnFwYzJSVTFHNUNCV0V4WHVNOXNSSjdidDg2QTY5YXRlT0U2T1Yx?=
 =?utf-8?B?dTNCcTNNYjArV1JMaGd2Y1hqSEF5ZFdxUXNMRU9JL2NwUWhXaHRhcVd1Z0d1?=
 =?utf-8?B?cDB3ZDc2ditGSGZBMEQ4L0JsM3RrYmp6SlRxSCtXT2FrTmdMOWEwdVNzcG9K?=
 =?utf-8?B?aGhnTWZwekFBNXozWHJEVEVJY1ZhU3RKdG9nS0JmTm0yZDVIbE1nQ0JpSTVj?=
 =?utf-8?B?K3RUL0VKd29qZDdrRDVBSVRGUktPV1ZISGZoYlNxMVBhSVpOTzVSQThWNWQz?=
 =?utf-8?B?WW14VkRYaU9ER1VwUkEwOEJlcHZEZlo2Sm1tOXlPUG83Q29tUFE5Wld3eVYz?=
 =?utf-8?B?ME5BKzRYT0NhQ0kyQS9OTVE4N0FINi9qQmdCZDhCR1pKbU5waVQvVFpQdzN2?=
 =?utf-8?B?ZGkyOWkvSVFRaEhQMmZCRHNKOWFEMCthOFBlK2lEQXpLZFRhWjBvbThsZnRL?=
 =?utf-8?B?QXk2d0YydlZUMVI4ZHhsc2RUbnI5TEVqb1V4K25TTkxJRFdhUW5aU3F3Zm1a?=
 =?utf-8?B?T0hVN1BMV0sxTzgvV0twa3dPT3VxVkFZTXMzeVhkbnpvbFN0Vmh0TzNheFlC?=
 =?utf-8?B?ckhGM2F3aWNTQjNleXBxRDdxSlh6a0hlT253MDlyMDhkYXNtTGI4MTQxVTNq?=
 =?utf-8?B?YmxvdmZTMnhKZTA0NU56Y1dTcExPak9zSENzWVlSRklkRnd6M1QvbVZ6UDZv?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9864c3fe-5247-4444-3570-08da012ee30e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 18:10:11.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLr7phdvBqJrWRh7Ou/88TleEJlUSbW+2EEFY6PjozcXM/4sa7SwyMk3NEskrxuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1343
X-Proofpoint-ORIG-GUID: eTJex2N-L_zn_JhtQHpfmwMaeQy5ePqc
X-Proofpoint-GUID: eTJex2N-L_zn_JhtQHpfmwMaeQy5ePqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_07,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/8/22 9:29 AM, Mykola Lysenko wrote:
> Thanks Yonghong,
> 
> Sorry for the delay in here.
> 
> I have split commits into 3 as you asked. Will send it out shortly. Have few questions below re: find_vma test.
> 
>> On Mar 3, 2022, at 12:31 PM, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 3/3/22 9:29 AM, Mykola Lysenko wrote:
>>>> On Mar 3, 2022, at 7:36 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>
>>>> On 3/2/22 10:27 PM, Mykola Lysenko wrote:
>>>>> In send_signal, replace sleep with dummy cpu intensive computation
>>>>> to increase probability of child process being scheduled. Add few
>>>>> more asserts.
>>>>> In find_vma, reduce sample_freq as higher values may be rejected in
>>>>> some qemu setups, remove usleep and increase length of cpu intensive
>>>>> computation.
>>>>> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
>>>>> higher values may be rejected in some qemu setups
>>>>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>>> ---
>>>>>   .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
>>>>>   .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
>>>>>   .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
>>>>>   .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
>>>>>   .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
>>>>>   .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
>>>>>   6 files changed, 25 insertions(+), 15 deletions(-)
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>>> index cd10df6cd0fc..0612e79a9281 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>>> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>>>>>   	attr.type = PERF_TYPE_SOFTWARE;
>>>>>   	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>>>>   	attr.freq = 1;
>>>>> -	attr.sample_freq = 4000;
>>>>> +	attr.sample_freq = 1000;
>>>>>   	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>>>>   	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>>>>   		goto cleanup;
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>>> index b74b3c0c555a..7cf4feb6464c 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>>> @@ -30,12 +30,20 @@ static int open_pe(void)
>>>>>   	attr.type = PERF_TYPE_HARDWARE;
>>>>>   	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>>>>   	attr.freq = 1;
>>>>> -	attr.sample_freq = 4000;
>>>>> +	attr.sample_freq = 1000;
>>>>>   	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>>>>>     	return pfd >= 0 ? pfd : -errno;
>>>>>   }
>>>>>   +static bool find_vma_pe_condition(struct find_vma *skel)
>>>>> +{
>>>>> +	return skel->bss->found_vm_exec == 0 ||
>>>>> +		skel->data->find_addr_ret != 0 ||
>>>>
>>>> Should this not test for `skel->data->find_addr_ret == -1` ?
>>> It seems that find_addr_ret changes value few times until it gets to 0. I added print statements when value is changed:
>>> find_addr_ret -1 => initial value
>>> find_addr_ret -16 => -EBUSY
>>> find_addr_ret 0 => final value
>>> Hence, in this case I think it is better to wait for the final value. We do have time out in the loop anyways (when “i" reaches 1bn), so test would not get stuck.
>>
>> Thanks for the above information. I read the code again. I think it is more complicated than above. Let us look at the bpf program:
>>
>> SEC("perf_event")
>> int handle_pe(void)
>> {
>>         struct task_struct *task = bpf_get_current_task_btf();
>>         struct callback_ctx data = {};
>>
>>         if (task->pid != target_pid)
>>                 return 0;
>>
>>         find_addr_ret = bpf_find_vma(task, addr, check_vma, &data, 0);
>>
>>         /* In NMI, this should return -EBUSY, as the previous call is using
>>          * the irq_work.
>>          */
>>         find_zero_ret = bpf_find_vma(task, 0, check_vma, &data, 0);
>>         return 0;
>> }
>>
>> Assuming task->pid == target_pid,
>> the first bpf program call should have
>>     find_addr_ret = 0     /* lock irq_work */
>>     find_zero_ret = -EBUSY
>>
>> For the second bpf program call, there are two possibilities:
>>    . irq_work is unlocked, so the result will find_addr_ret = 0, find_zero_ret = -EBUSY
>>    . or irq_work is still locked, the result will be find_addr_ret = -EBUSY, find_zero_ret = -EBUSY
>>
>> the third bpf program call will be similar to the second bpf program run.
>>
>> So final validation check probably should check both 0 and -EBUSY
>> for find_addr_ret.
>>
> 
> Do you mean we need to add additional test in test_and_reset_skel function or in find_vma_pe_condition?

No. There is no need for an additional test.

> 
> Do we really need to do final check for skel->data->find_addr_ret in test_and_reset_skel if we already confirmed
> It became 0 previously?

Good point. Yes and no.
If we did hit find_vma_pe_condition(skel) is false, then we don't need 
to do subsequent checking.
But if we didn't, checking is still needed to ensure the error is 
printed out.
You could refactor the code such that only if 
find_vma_pe_condition(skel) is false and no subsequent checking, or
unconditionally subsequent checking.
Either way is fine with me.

> 
> 
>> Leaving some time to potentially unlock the irq_work as in the original
>> code is still needed to prevent potential problem for the subsequent tests.
> 
> By leaving some time, do you mean to revert removal of the next line in serial_test_find_vma function?
> usleep(100000); /* allow the irq_work to finish */

Yes.

> 
>>
>> I think this patch can be broke into three separate commits:
>>   - find_vma fix
>>   - send_signal fix
>>   - other
>> to make changes a little bit focused.
>>
>>> TL:DR change in the test that prints these values
>>> -       for (i = 0; i < 1000000000 && find_vma_pe_condition(skel); ++i)
>>> +       int find_addr_ret = -1;
>>> +       printf("find_addr_ret %d\n", skel->data->find_addr_ret);
>>> +
>>> +       for (i = 0; i < 1000000000 && find_vma_pe_condition(skel); ++i) {
>>> +               if (find_addr_ret != skel->data->find_addr_ret) {
>>> +                       find_addr_ret = skel->data->find_addr_ret;
>>> +                       printf("find_addr_ret %d\n", skel->data->find_addr_ret);
>>> +               }
>>>                  ++j;
>>> +       }
>>> +
>>> +       printf("find_addr_ret %d\n", skel->data->find_addr_ret);
>>>>
>>>>> +		skel->data->find_zero_ret == -1 ||
>>>>> +		strcmp(skel->bss->d_iname, "test_progs") != 0;
>>>>> +}
>>>>> +
>>>> Thanks,
>>>> Daniel
> 
