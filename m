Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C3557D057
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiGUPxl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 11:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiGUPxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 11:53:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B66474CC;
        Thu, 21 Jul 2022 08:53:38 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LCAGTC023612;
        Thu, 21 Jul 2022 08:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=S3dRuRQ1C/imn1Ijk3JIDKR/xiaHtGA9ZVnqq0Q+7wk=;
 b=LT+d1e94hjb+zgKrWI1uuwm8zv7iNB6CBX/SHXyDXdGPgr8pRwequZ67OGdIZRQ2jsLT
 QZvPw4wlzF6ET2UT7BpqMHbKfgn8NAac4U+JW2nwKuUvPWTpMuZW8+tWvuxjyhtuqdk0
 ETey1iAqvPKtZFXOGThPF/qEH7SIxq7sSAQ= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf6jjse6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 08:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hml/XnhkNqbl6NAZJJnAltLeK1Z79uwhSg2jpO1r/1PND6QVron9XBzica+Qpjqgl/zg6wc8i7SwiDVpaWjhk1Et2BfR7g7c+DjI2YLotEQDWPW5Zm0AkD4h5+uBb3e4/ABOSFhfNV4L2VIgdaKrCRT//+FA8tisAU0dvhPCzdE8XmUWh6fSrNwAfF7brZgggrr/JO1mHxkOiU/FZBkOTBAT6eZmpKsVLSeN5tfhrYLGf+5IwpmUobaXD0MgcGPGW9YBCPcEgj0dTQPPrrDJGguOogRH1bGKPjPscHgi1PFA6yLb6a2kPnBp3to6wiyoeix9Y9dRDkYlhujLw8XvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3dRuRQ1C/imn1Ijk3JIDKR/xiaHtGA9ZVnqq0Q+7wk=;
 b=df6zEiOhJ4rmrJH1mNRTDzfYFr1AJUt1U6lcQB2uimWmDWijY4ttz/OuQOQCUNsV67RLsYXcZm6Hd7KNoKyjynAQaLLPr+eloh/8gqzM3n3UVIu9R+wLmrETjR8C9UMWeoUBPvtHd1M1x6DdzZMZskZdP3JfZlZMO8YuXpGJCVgMbuIhIJ+ZO0J9DJFEXcwRDjxpbE9pn1s0PaFkCTM+OLq3siOYHhRq7wjOEiZtUwiQTMifKeUrf7YWboNvU7b/3egQ+ppqFRODV0yWhWXtuZ25wdQ8f19DrGq+W3a1Nu3svHLO1No1sfNNBuvkCd2QdOix6EwKq5URhHMi5UhMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4126.namprd15.prod.outlook.com (2603:10b6:805:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 15:53:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 15:53:13 +0000
Message-ID: <fbc98bb0-a2d6-a450-e6fc-878701e5906d@fb.com>
Date:   Thu, 21 Jul 2022 08:53:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
References: <20220721111430.416305-1-lee@kernel.org> <Ytk+/npvvDGg9pBP@krava>
 <Ytk/jT+zyNZpafgn@google.com> <YtlDPYQWDcORbP0o@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YtlDPYQWDcORbP0o@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac499a8-ae66-4c3f-4d75-08da6b311e09
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4126:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuXiXU75K+FfnaR/MKdnJc8D77kPDYM6agXqwUuhcvMmzQ/O8DVb/0KvDpKsMwfBLx1DHrTi2ZPZ+HqOh6I6tXJLiD7DvGLpe338FSZ98c+1SO3URfCMKqj5TdPgIairTylcw79NmkvrzOoAGR9N2Okhe3jOOLNyyoKw+83p5NIBqZXzuFBatQHYKN7yGK6X3G3bWX3g2/PEzrTOQXbD+Is6F7qYSezh6OAUpSljv6kOiT7He9vqslyyhtSDMnHfqPc3KdiSuOeyudDGwqLFFje3MsOuzhoeWw4ZHT6GQehPpJILYkI8hWDWAFNNzWymQZbyN3ot8n1ebLbrukMWBFoRiPzjvzrJ8ZRXhLG+napQfKjAwMAGuKqShzCrzFoLSQxhM3G8ZufeRR3VEyhtJOhOEinggl+8etMWrx3CIZ0ri0uIT/acg4LPWe//FZPRewZTn/ylGW/Ay2TquzOBJwEJRTZC8Zy07bRRkChiUu7x70jeG3XluZIDCs4GmLl8tdKdrfvWNWhGg4EZg2Be4f3QRTpznCStgaLXzuRV0wnGWJ3yjTR35B1TNN24b0dfOTb8T7c3YTzj5ifmCaP0QUL0swc/Lam9HqAeWsB3ucRs7PN8TY1OZELnETfhGvh1F6xARRPh/ipUbdMPtzk+Tb1L3nGtO+iQzvbuMszTafgSC8WT8+RNohD0wfCBLW5BYtexhIoAg/7h6oMVctH7cXxuFkAtApfpovgbVHS43Udx4tQZ1GTIai4zldfZHRe1BSxEWEHby05yjaD+H2Q8zzDMaaidiikuB4HavGBcNRoEx+xcLd7IKuTz3rtjcAG9CP/s0uWMCmHgEn5O7pTLbyAjqMxrrdsj+q1GY57EfpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(6506007)(6512007)(53546011)(186003)(2616005)(38100700002)(83380400001)(8936002)(7416002)(2906002)(5660300002)(110136005)(478600001)(966005)(6666004)(6486002)(41300700001)(66556008)(8676002)(66476007)(4326008)(316002)(54906003)(31696002)(36756003)(86362001)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1XOVJ3UGR6aGZBYnUvektXRFBXbXQvSUE2MGc3ZVcxdldUWlQrRWVFV2VT?=
 =?utf-8?B?VTFScGhIMkJkY3pncncxK2o3UVNNZ1VJeDJ2Qk5uZko3TXlkK21JUmdJNVR2?=
 =?utf-8?B?bkNWSHZsamZFN1Zac3lzc0lUcmFRcHd3K2h4bzlCbnJqdyszM0lSeGRuMC9I?=
 =?utf-8?B?cGpYVVhaWjY5eWZwcTdOdjM3MysrK2N4c05lSmlvV1BaNDlielpEaTQ0YUlq?=
 =?utf-8?B?bGhQTW8yYnNhVTZ6cUR4L0hPNVJKdkg0Z3JhTFUySTYwYXhaUzNkRlhLTEpZ?=
 =?utf-8?B?UXA1WUNwUmZ2dUdqWm5mWDNPK0xuM29rRFdMbWNmZjNibU1nZ2NGLzJka3o2?=
 =?utf-8?B?NWJob2hzaWdYR2ZzQWF3TUE5Vlc1ZnlsQytXOU9zVkhkSzZFaWcxVlNGa1JH?=
 =?utf-8?B?VmFEeVlySlBMVEZhOTZsaHdQN0VUeHpRbWJrYVRZTEYzd3AvWGJlcFNPVkE1?=
 =?utf-8?B?OC9ycjJuVjZSbVBGYXA3OHE2TVFTUEN5TTM0V1gyalVvRThwb20vMEVMT2lQ?=
 =?utf-8?B?RWsyL3hYUkFhVWd0U29kMmRXcVVqT3hIOWJHTkZPK29Jdm03cjFpdDFCSUJi?=
 =?utf-8?B?TTg0S3BlT0NMZWwwWjNnaTRXZVRvdWo1UFZNOXlEYzRhMjRoalNUMDRPR3F5?=
 =?utf-8?B?aUpqNkhjS3RqTDhISnNzSHZITGpqbFZzQ0R3dksxVkMvUDRoYnY0anAzckxp?=
 =?utf-8?B?WllML3llNmowMFdDcE5HNjRzdkFrdGtGb3FwOG5sVTR5WEMxeEdtaTl4U3Zr?=
 =?utf-8?B?NTU0MlRHaS9xb1lYa2pkMURROTBVU0svL2psYnNOZEdVZG1NQThHeU0xOEMr?=
 =?utf-8?B?NHh3MTJ3dk5CNE1jWG1xRDBtSXhvUnFkU1NOTnhOSVA3Q2JrMXpoS3U1VWZw?=
 =?utf-8?B?YTRRR1hPMVdpckExQ1ppY1Y0R2pBN25vaDlSUjNIN0Q5QUNDTFRDRU5oOUVL?=
 =?utf-8?B?ZCs3N0FUL2ZOaDV5TGNvMGdzS0p0UzVONVlETzFDNldXS2JaN1M2cE9OQUFq?=
 =?utf-8?B?c1B0ZFV6WSsyVjlQZWdZU043bjgya2JNY25oNmIwTTdkU1N0WElWZ1V3dnpV?=
 =?utf-8?B?UEF0dFFhWFpiV1lCL0h3dGZ4N3VHT2dLUjdCU053Mkc2Z2xoc2pKRGlsU3JH?=
 =?utf-8?B?dDdteE5jVzdzL1JyOXYxeXZzamd3dk1lY0J3TG1xRCtlbSsyYnM1cjNHbVFV?=
 =?utf-8?B?bFZqV0xOTk14emZrekpIU2x4TUFZUkdZYk91eHNQeTdHbUxPY2VaQkYzNEVF?=
 =?utf-8?B?ZWNMaVUva0hiV09QaWZVRDRDa3pjZURmQVdwOFErdzBNNHJPYXMzL1ZYWDhB?=
 =?utf-8?B?NHYwelc2ZTY5bnlRTDF1ekpVSDBhVVY2SnRNdE5DWUlhS3lPTDZXejFiUjRt?=
 =?utf-8?B?ZzJMYmt3OFFzcFo1SFl3b2xWWFQ5dm01Z1FibnFDYzBDVk0vSFlDRXRwbzlu?=
 =?utf-8?B?OXgxRGFoWWJnQ3hIcnE0S0VJU2MvS1Y4dTQwTzVvMjl3c0hhTVV4VDh3VVJK?=
 =?utf-8?B?L2ZRRFlrZGxORUc1QUpETVFDTlU1YWNKWWhzSjNqTHExcFYwVEFvSmQwUEZt?=
 =?utf-8?B?OGlIZlNCenduUHRDaHZpK2g5bENRZUlraWpBM2xWSDE5U0RnMjdKaEZ0Q3p4?=
 =?utf-8?B?VlkvL3JaZysrQnArK3dPWTVaOFh2aE1LMFZ0UHAxcWh4MHAwVnpsZVRmR0FR?=
 =?utf-8?B?TUdRNEk0MzROWHVRSlo1NTIwQ2ZjY1l5dHRuVDZNdldhTGVRMjZ4YyszRFY5?=
 =?utf-8?B?S3BCUkhjZGp3UmNZM0lMb2dhVjhWNVJvdEs0SHNySFFrRVl2eThYb2VqUzJQ?=
 =?utf-8?B?RzlLV2Q4U0F4QytERTNxR3pocGVweGM2MEpUWWYzVnhCOHBINkhnMFVDZkU0?=
 =?utf-8?B?bE9pUS91T0RhOWtQblRJcTVYUTVxQUptZ2JBR2k0bDlRUmFab2FqZjZ5UlZ1?=
 =?utf-8?B?Mmd0NzRkbmNsU3pmUE15amNPSWVQZnh5cWh6bWlpb3dZQm0wWmdlV0hZYm4v?=
 =?utf-8?B?VysrTEd3NmtTK3FLcitNaEZnS2txZTNnM2ZxdGJLQWYyMlNuUG14SHlNd2ta?=
 =?utf-8?B?ditsT1dvT2Z6dUxhSEY5MnAvV1Z3eVJaWXlBZU5GL2MrYWhOeitld0NwZm9O?=
 =?utf-8?Q?IDmSQ4T+ZaUiI7aEOWkARh5Oi?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac499a8-ae66-4c3f-4d75-08da6b311e09
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 15:53:12.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYrwzhBAUj7SheS6Q3KXEqgjWIla9+tnyq7i9BB9urRW1lHuuOnzp797bLBjlJul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4126
X-Proofpoint-GUID: nbHQ6H4D1oqpSEjqzrb3gaf7xkqNkeKV
X-Proofpoint-ORIG-GUID: nbHQ6H4D1oqpSEjqzrb3gaf7xkqNkeKV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_22,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/21/22 5:14 AM, Jiri Olsa wrote:
> On Thu, Jul 21, 2022 at 12:59:09PM +0100, Lee Jones wrote:
>> On Thu, 21 Jul 2022, Jiri Olsa wrote:
>>
>>> On Thu, Jul 21, 2022 at 12:14:30PM +0100, Lee Jones wrote:
>>>> The documentation for find_pid() clearly states:
> 
> typo find_vpid
> 
>>>>
>>>>    "Must be called with the tasklist_lock or rcu_read_lock() held."
>>>>
>>>> Presently we do neither.
> 
> just curious, did you see crash related to this or you just spot that
> 
>>>>
>>>> In an ideal world we would wrap the in-lined call to find_vpid() along
>>>> with get_pid_task() in the suggested rcu_read_lock() and have done.
>>>> However, looking at get_pid_task()'s internals, it already does that
>>>> independently, so this would lead to deadlock.
>>>
>>> hm, we can have nested rcu_read_lock calls, right?
>>
>> I assumed not, but that might be an oversight on my part.

 From kernel documentation, nested rcu_read_lock is allowed.
https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html

RCU's grace-period guarantee allows updaters to wait for the completion 
of all pre-existing RCU read-side critical sections. An RCU read-side 
critical section begins with the marker rcu_read_lock() and ends with 
the marker rcu_read_unlock(). These markers may be nested, and RCU 
treats a nested set as one big RCU read-side critical section. 
Production-quality implementations of rcu_read_lock() and 
rcu_read_unlock() are extremely lightweight, and in fact have exactly 
zero overhead in Linux kernels built for production use with 
CONFIG_PREEMPT=n.

>>
>> Would that be your preference?
> 
> seems simpler than calling get/put for ppid

The current implementation seems okay since we can hide
rcu_read_lock() inside find_get_pid(). We can also avoid
nested rcu_read_lock(), which is although allowed but
not pretty.

> 
> jirka
> 
>>
>>>> Instead, we'll use find_get_pid() which searches for the vpid, then
>>>> takes a reference to it preventing early free, all within the safety
>>>> of rcu_read_lock().  Once we have our reference we can safely make use
>>>> of it up until the point it is put.
>>>>
>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>>> Cc: Song Liu <song@kernel.org>
>>>> Cc: Yonghong Song <yhs@fb.com>
>>>> Cc: KP Singh <kpsingh@kernel.org>
>>>> Cc: Stanislav Fomichev <sdf@google.com>
>>>> Cc: Hao Luo <haoluo@google.com>
>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>> Cc: bpf@vger.kernel.org
>>>> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
>>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>>> ---
>>>>   kernel/bpf/syscall.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index 83c7136c5788d..c20cff30581c4 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>>>>   	const struct perf_event *event;
>>>>   	struct task_struct *task;
>>>>   	struct file *file;
>>>> +	struct pid *ppid;
>>>>   	int err;
>>>>   
>>>>   	if (CHECK_ATTR(BPF_TASK_FD_QUERY))
>>>> @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>>>>   	if (attr->task_fd_query.flags != 0)
>>>>   		return -EINVAL;
>>>>   
>>>> -	task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
>>>> +	ppid = find_get_pid(pid);
>>>> +	task = get_pid_task(ppid, PIDTYPE_PID);
>>>> +	put_pid(ppid);
>>>>   	if (!task)
>>>>   		return -ENOENT;
>>>>   
>>
>> -- 
>> Lee Jones [李琼斯]
