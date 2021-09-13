Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB64082E6
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 04:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhIMCok (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Sep 2021 22:44:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235364AbhIMCoj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 12 Sep 2021 22:44:39 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18CKEavA001803;
        Sun, 12 Sep 2021 19:43:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WrxWxKrOoWqiQLlJbIQ+DTW1Kk+wBVwbOt7N7+xPb5Q=;
 b=mQKtMWeinZhMpaa4Of5JpmB6/FAY3r6HsK6oB1UZlulxBcEzM29o0NJJwAszhCV2pYUd
 731SjyrH222cTMo5Z6iIRrZXAQo95LfifoXO9SaQeCw2xnhXvUO63MFsPnwb81vaNUbi
 fvxIctiLIld6JnSmvvbK6iM+aGCMMWnSc5Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1k9rj0ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 12 Sep 2021 19:43:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 12 Sep 2021 19:43:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9GzWXg20WiaRtP3aCtt1uRufV7S3kBxr/G7uEUhIyCZzXolgGkd8/HvFH7wAyaSH4Xqqf1j19Cme4IAUmBQK2hLD+9RkGsHgnppY/frBJQRJIfg48OVtSLL/cIK+1WsgXj/Q2X68k+WcTAjNylBAFjmV8LXF5uMTs4/bbOMATR1zzQDzVgjZT/l5rGarDREeFQDzswa7u3oqydAvyQdp6DVxg9yJVZ8Na6AAaIA5+CX5Okg/w5Je1W3gGM+whh4dmZZBO5CTsL0nIErNCdPAy/oRSuHpsY5P/riimJgf36JF912VgYc+5NyISfP/Hqaj6fbbKSJ5EJ7kEXucGgaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WrxWxKrOoWqiQLlJbIQ+DTW1Kk+wBVwbOt7N7+xPb5Q=;
 b=XkkzthQ71bNXE6N6OQ6tYjC0X9dRDSriaobFlPjUs5lzPuhiAXLQWeF003WriWbFp5oz9wpQWs7mGADiGUN14HlVARghjjnki+bjfdc6OEbeDFMyuLgdASMgrDv2RFDmzfoNSHZhtEq6L8ArooT2MVwS78SIatl3urWdtyuIEPrDi5InuOl4uXAGqZsZ8BBWCL/a2oefNpO4ml/BH6mcOrwiE10s11XrZJWpL6j3pFeqJay6Mv1epms+8uXRyRiaVPMxCSHIB7HSU1mgTJDBdU3dABE8qridcp/aiCeLk3GQS+NQmxsSE3p/N2HHihRlz4OAgsbFdTS+ROescOPdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2287.namprd15.prod.outlook.com (2603:10b6:805:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 02:43:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 02:43:19 +0000
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Add parallelism to test_progs
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
CC:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
References: <20210909193544.1829238-1-fallentree@fb.com>
 <40733168-d1b1-4d9e-63a5-e767bc9dc1ad@fb.com>
 <CAJygYd3NX3qi7sOHiQOmbiJju8zMy3ip0bmreOmRPtgp=S3YtA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <97fb8a21-70b5-39e6-6d6a-63cce9c17911@fb.com>
Date:   Sun, 12 Sep 2021 19:43:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAJygYd3NX3qi7sOHiQOmbiJju8zMy3ip0bmreOmRPtgp=S3YtA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: CO2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:100::31)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21d6::1021] (2620:10d:c090:400::5:941f) by CO2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:100::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 02:43:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef550544-7845-4005-64ec-08d976603f25
X-MS-TrafficTypeDiagnostic: SN6PR15MB2287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2287E34FE744D8DF19956CCDD3D99@SN6PR15MB2287.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIQW0s5QYO1mPwfuogKW4QYXBkMxWFecEQW649o0gK463F3RcZbmL1WLow6PhlSadoA9kg6RNMhuU+NpBphQ+ZZHGYhFNPP7rPtWAKHnuYGVZG6KCrWvUWkYhRqYR6AHtlBpYkptxIXWPs6D9iUtNgbKE6YN8EBgXJien9hN11UxXeT2JtHWTfAAdA/7BA6X4pY8xjSjYsPYJWn2Bi7GXjtkcFtygA3YfttoN7ufV5iub4CLr89w+jjNPyABIc6G3Z9W7sFk4U5SyZKObA2LsXhMA/audt+ZN2Xll5AtdIRSOuNriRQYjOZcWTA2a+Ouaih5NhylNf7V5EHxEEPs+6kNGdONU/LxgmvPN9jpmLOsTKdPLZ55n+ztVBJAEh8HDz47t5TYIOCmY09XdK/knRui0nMmLdKa1lLCSDqIzbObGM1RvqSpg4c4rCdrpwk0RAz/Yqlo7t01kCSXWv2aqNbDSCrx6tQ5S6jR2Ghx6X1sF8zQJVF88SUzmLI+a9lNyROlg6OjsB6Of8wllN4VBvMqnQmPHv+z9ozBGrv24rQX4zfWqkfOBuwZZYyYLhE1+21b1WQGt8rBM4OtEKIWDJvWIaoKHAtlVarLZabLjhljQfUMwMI9r+IgBvN2rMf4zYIKcGosKdAYbg4zuMHZ8hV9+toI9jl+x+lbc95ob3ckQIl8CKWSaM0FtZs0DMHTSNOZ+l2PgyqIZznMWVX6F5HpiPRPBaxQAptr+xnvS7imP2EqMQ/cJZi1tGeh765zIDsxjfNlLm43hnq63OhX87pvwA/2OwOmd5wqbFRmI9mByjtSRmqhfCLLQR88xuqj1z24TbLs8kmj+zgk8vfsmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(8676002)(2906002)(6666004)(4326008)(31696002)(86362001)(5660300002)(186003)(478600001)(66556008)(6486002)(54906003)(31686004)(8936002)(52116002)(66476007)(38100700002)(6916009)(2616005)(966005)(83380400001)(36756003)(66946007)(53546011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGgvYU9nTXp4VUE5N1Zaek4wakFkNTl5RkhzRk5pZXVJZFp0ck42dlBmY1dL?=
 =?utf-8?B?MW9HRUpTMnpaLzJKeWlNVWRsV20yUTBrbmdZMmMrN25YQXNOem1OM0Q5WHZ4?=
 =?utf-8?B?ODNCUmtGTmc4aTNNQ3hMQ0dQaVQzTU44MWJ1Z01qZ3QrZ1d0QTR2QStoLzZ2?=
 =?utf-8?B?ZUdicXp5UmxocXZkVXA4OVR6eHhnU2t0SWJTcG9MV3hGOVN4cnU0ejVTRXdC?=
 =?utf-8?B?WG5yRS9IRGpOVmNIdW0wSk8rdng5OVRSOXJvR3ZVNzZySTVnTE1VKzU4OElC?=
 =?utf-8?B?NUU2NS9URGpRQi9PcDVaaDRhVkNLMFZEUmpYMkZPY1Z5MVVOaXY3NU1JRzFv?=
 =?utf-8?B?ZWRKWG94WlllS2FiVjBSY2VzSDUwelRvcnZ6RkJIRmpMbnhlTTc5M0JuSGpI?=
 =?utf-8?B?U2FQMy9CNnBONUk1RUQ1MWw4aXBjNFpxaXhaMVhvRVNwSjNNdUVuNGVVYUVL?=
 =?utf-8?B?VFRBOVJCSHQxTE80SEVnT3lhRFVicGh5aGp6V2hlWGwrWmsvd2RRM0w4UUtY?=
 =?utf-8?B?LzlNclppV3JrRWxMTUtod1hDTTQwTGtDQzh6TlZxNXhVNXdtdzJncERDd2s4?=
 =?utf-8?B?T25tQWdxUWNGdFV0V2ZDaitzVFdxeWpSTmh2QUcrTXVQZlFKN2VadzRaMzF3?=
 =?utf-8?B?Z3dSY1dQdFNNSm9SM0g1VVoyWXVFdE04RlZ5MjlYU2xVd09CbktjbjJsSkgx?=
 =?utf-8?B?ZzQvS0JaTWJ5SERyUWJCVldoS1hkd0dMZmtMb1pKWU5xeEJzdEpFalFod2lV?=
 =?utf-8?B?OVlKQTgxNW1QR0YybUNsbUR4a08rY3N0SmMvV1JNZ21rUURSOS8rWWcrSldH?=
 =?utf-8?B?UEp0L1NlVngxekN6R2dlOGhrVkNCYWU2SWdPVWVudGd3VWhUYlowVUlOOGNa?=
 =?utf-8?B?Wk83ZzhaTnN2aUNXcmdXdktsS2gyQTFuTC9lTmJSN05LSDBZSG94cmd2cU5O?=
 =?utf-8?B?STlxNEJkMHNmdjBCRjZhUE12S1dxTHlYQ2ZuYWhNQkxiQStlMFNTVk4veVJp?=
 =?utf-8?B?R0V3NUJjOUF5SVVFa1Fibm53UWt0Q3BLQjFpQVFHOGxxRG1MVlk3ODRESFlo?=
 =?utf-8?B?dVcrYkJndVhvaWpSbDVqNE1wKzFqb0gyRFEvTEhwbXFIcmN5MjNmUkxoNW5X?=
 =?utf-8?B?bTJiK2Vxazh4ajRKZU5BcUJhMExrbnByT0RqZ1piMEtsZ0h2b0llbDlxRE12?=
 =?utf-8?B?ZEpFbGN0aW4ySCtocXZQU29nbTUvTFl4VmthUE1HZGNSWXZRMU1TNFIwSzE2?=
 =?utf-8?B?dXhQeDBiT2FLZzB6Y0k2SVpGYXFKUmdYb0JDa1N0U3JTbG52cGdEN1ZNSm93?=
 =?utf-8?B?UFlRaDcrUUp0QW5kTFIveUhzZnB2cStkMGlIOEJ2VXVWVFRqcnd6MHIxSHMw?=
 =?utf-8?B?eU9ReG9ISVZFWFRyNkh4dTNvUHJ4TGNIUGhQZGhZTjdDQUlqRXFTL29iZHAz?=
 =?utf-8?B?Ry9SbzhlUzRnWVpnUXlXRVNlYlJ3eFBrVGgxR2RWQ0JjNkJsbURlT28zSXQx?=
 =?utf-8?B?SUx5bVVJem9JZzBGRVFRL1dXQ0U0NHU1aklrcjlEc1dNV2Y2Yzl1RW9DK2FY?=
 =?utf-8?B?aTVsZFVRRjZnWXRlRjM0TG5JbTk4eUxOT3RxcHloRUdZMUZiRm9PTis4VHNS?=
 =?utf-8?B?aWFyS3hrT1Z4UjhsbnZvN1R5OTU1eGJaeVdOQjQ4STFSa0RTTmFENjJSaENX?=
 =?utf-8?B?MUFIc0pUUkthcGpwS08wTXV0VDdoa3gzRU5PS1VWS3VZeWV3STBieCtjUkRk?=
 =?utf-8?B?eXR3U0w0citid3FVMnArR0p5bUVLMW9CY0kwaC80VlJLVGkxazZzdzVaVzJP?=
 =?utf-8?Q?tploJr+QKMC6Wzs+rhEUgQwUfuHqYzOitEB/M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef550544-7845-4005-64ec-08d976603f25
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 02:43:19.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK6gkvue5jgZ5YMmyfDMAmSJtZgmgfjJld2ypg3u/Mz6Q0EKTOgcbCK0xQ6XLRUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2287
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ANyxXl2DHwROC6EfEISIy1X55WhtgZXu
X-Proofpoint-ORIG-GUID: ANyxXl2DHwROC6EfEISIy1X55WhtgZXu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_02,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/10/21 11:53 AM, sunyucong@gmail.com wrote:
> On Fri, Sep 10, 2021 at 2:28 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 9/9/21 12:35 PM, Yucong Sun wrote:
>>> From: Yucong Sun <sunyucong@gmail.com>
>>>
>>> This patch adds "-j" mode to test_progs, executing tests in multiple process.
>>> "-j" mode is optional, and works with all existing test selection mechanism, as
>>> well as "-v", "-l" etc.
>>>
>>> In "-j" mode, main process use UDS/DGRAM to communicate to each forked worker,
>>> commanding it to run tests and collect logs. After all tests are finished, a
>>> summary is printed. main process use multiple competing threads to dispatch
>>> work to worker, trying to keep them all busy.
>>>
>>> Example output:
>>>
>>>     > ./test_progs -n 15-20 -j
>>>     [    8.584709] bpf_testmod: loading out-of-tree module taints kernel.
>>>     Launching 2 workers.
>>>     [0]: Running test 15.
>>>     [1]: Running test 16.
>>>     [1]: Running test 17.
>>>     [1]: Running test 18.
>>>     [1]: Running test 19.
>>>     [1]: Running test 20.
>>>     [1]: worker exit.
>>>     [0]: worker exit.
>>>     #15 btf_dump:OK
>>>     #16 btf_endian:OK
>>>     #17 btf_map_in_map:OK
>>>     #18 btf_module:OK
>>>     #19 btf_skc_cls_ingress:OK
>>>     #20 btf_split:OK
>>>     Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED
>>
>> I tried the patch with latest bpf-next and
>>
>> https://lore.kernel.org/bpf/20210909215658.hgqkvxvtjrvdnrve@revolver/T/#u
>> to avoid kernel warning.
>>
>> My commandline is ./test_progs -j
>> my env is a 4 cpu qemu.
>> It seems the test is stuck and cannot finish:
>> ...
>> Still waiting for thread 0 (test 0).
>>
>>
>> Still waiting for thread 0 (test 0).
>>
>>
>> Still waiting for thread 0 (test 0).
>>
>>
>> Still waiting for thread 0 (test 0).
>>
>>
>> Still waiting for thread 0 (test 0).
>>
>>
>>
>>
>>
>> [1]+  Stopped                 ./test_progs -j
> 
> Sorry, It seems I forgot to test without "-n" param,  here is a
> trivial patch that will make it work.
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c
> b/tools/testing/selftests/bpf/test_progs.c
> index 74c6ea45502d..dd7bb2bec4d4 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -780,7 +780,7 @@ void crash_handler(int signum)
>          backtrace_symbols_fd(bt, sz, STDERR_FILENO);
>   }
> 
> -int current_test_idx = -1;
> +int current_test_idx = 0;
>   pthread_mutex_t current_test_lock;
> 
>   struct test_result {

Indeed. With this change the './test_progs -j' finished
although I saw some test failures which is also mentioned
in the patch itself.

> 
> 
> Cheers.
> 
