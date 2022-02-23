Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227DB4C0B1F
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 05:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiBWEd0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 23:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiBWEdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 23:33:25 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4BB33E26
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 20:32:58 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21N2ZHSX022483;
        Tue, 22 Feb 2022 20:32:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4cn1+QF96x7DOtHsyo6WF22CMj1ZruxmLw+oDenK0Kk=;
 b=CcaZvRg0jFWqfHrsVsT0PvVxNvwuoanwIlCHZGkZw97uFEWQTVrmUO3jfDS8kO5k3bsM
 9pHPGVwsTRUG0vPqKsO21wDg9LFTekQJrwPIc4s6xpdj/GSnCLph5tnpv6A2LU/cNEsh
 iIj9NuZ8XvHX5mDhq4Tlo9/5yK6BNBmxHNY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ed7c7j982-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Feb 2022 20:32:39 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 20:32:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYZlmWENqZRgbM8dDIpzRv3DLJkfg1vYTwH5joBhDJhHNsiocufi0QPuCJ+eLhJnXfGdXpOa3tQXdhIWfGfUA7cA4IjskrX6sIrhTMAksr2zNXfcqmfd1jzRjl/hK70TB2uhGoRvg13k29W1UKgh99jF4HCybS+FoLDpBYiYEeAwYwV2oSU2RlAHCisDLBFDNHvqTxvsWZ9Ct/VmPlZ/uu3OXgZp5d6L15KMWmJNxHtUPzg8n1+3k/Bqm1PdPvwVWH18pNh6oB2O+IiX/WL1o2rzHoyzZsk0VPusl/Izw9LgQrDlglVDWcNPADM8ZYGfBR1ptpitid0HnyqB1mlxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cn1+QF96x7DOtHsyo6WF22CMj1ZruxmLw+oDenK0Kk=;
 b=dZVnNY2YsKYtN5PgQzjbAjRNiltiwTAgGaGdUp5yTdpoT+zRN6n2aSWlxs839GElpj0vVXyBUr0P4kOI0kXz7K5bamqA6TOwhxa6JgvR0AP7tE4s9fA1L+MgYhy5KCY5jLQuXhWewDWpTOr7y1Eu+MP8N7rULr+KlTd+llWfqiqVEq0BSEtDVVozTy50tV98il57a/sRs/CwJjNP7SFFPlN62iuo8UIXc2Q8OArvh4EeuB0wh6AM6+H0L80Rrwj2P3mGARYq9QQVQfG4L6YBbukaYHTH5ehCI9HUQXcwNOxAIfL+LdpB1mVSdlYQXkyt/oyn/I4Pyh8l/dHvzuC44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1717.namprd15.prod.outlook.com (2603:10b6:910:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 04:32:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 04:32:30 +0000
Message-ID: <a8f8a6f2-25c4-09c2-0b5a-0dab73f17f9e@fb.com>
Date:   Tue, 22 Feb 2022 20:32:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220219003004.1085072-1-mykolal@fb.com>
 <CAEf4BzahKEObA_quad2M5Rmn42yPCNFAvVUtPVthFi2jPYNpmg@mail.gmail.com>
 <22435EA9-9336-4978-819A-0F91EFDBEA9E@fb.com>
 <CAEf4BzaAr_khs682uyCZ0HhFuNJWwKYDcfqhNE12rWYmU20JOA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaAr_khs682uyCZ0HhFuNJWwKYDcfqhNE12rWYmU20JOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70812e1a-42cc-43c0-8c53-08d9f68580ea
X-MS-TrafficTypeDiagnostic: CY4PR15MB1717:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB171750BA18AAF0B8F57A928AD33C9@CY4PR15MB1717.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhUYyK5wakhuNy5RUvbU8Ilwx6Qa8VkqyOrYH94Li3K/cSjyVvSvXUVaSNMHn7JxkMshBxsUHlOCj20T0JPKwbbuqKlQFLaIY6rWS5suHkC6QG8M0LJ4ANy4lG871mp3onrOf6fKS/xCgqQsqiCGk7+E/YgURUOLlOobVcVYw17QxiCVJws1CJuU+Jjoe55CnLikUyqXY4x4JBcrhTzECon2I/RQWITm6ylilaxPCjbYbi6G8xPfareXDxesXFTc3uwWV7jWLrSHJdCA9LyP8Hfj4Mozq6+By/XZJw5JnZq1rKadmKztzVkOEsg9DwwhS8nHRdiO1OjbwuPQApwej3HdxbotAlNxv9TuPPoJ6cK0rOu4WDwxqdUErP/nogLLZzjuIqMpvGWjXtQA9q7/ls9rpl5kdx/oVTRrUThGWII8i8kCU1oGTFR9waeDsp7J3PfMAdntAt3Lh3meZYN9TNjbPFkp1mll+RPDdrnNIZAtnBDqQoK4WnunNjp6NUFO4Hgh4lro3POyAs93g9f+Sitcw6kaLisGloXOYbUe2Bun4o/mFOdZa8KQcqQrr1QVYg48DQYT/AeMWJVoa91AyM8FSOH+DIdz/3rh8hMic5Byi3c1culaxOyvXanm9+ylWle9YWgaGSJKMfb7r2yFx5fygN8bxaSaJB5LuMU7y6m8Jl79hH2mAri7o6VSIR4VVfW2y+hn712VBI/Ja6Mf5ykO6Dqnw2mv/FmL/eQe+LaF9Y69haRU1K15k7Wxxsav
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(52116002)(53546011)(2616005)(6512007)(508600001)(186003)(31696002)(86362001)(38100700002)(83380400001)(4326008)(316002)(31686004)(8936002)(6636002)(54906003)(110136005)(66556008)(66476007)(6486002)(66946007)(5660300002)(36756003)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0pBckNJV1pCdTliMFVmdVBSNWllaEZEZW9rdkhqcjdkM2tEU1VkbXIvSFgz?=
 =?utf-8?B?YkR1UWFReDViRmc4Ym1UQ3A5dGtqTGRHd2JMMWRoZnhwbWpSZy9WTGtQU3lj?=
 =?utf-8?B?RzVwTEVWUEszNDNMTy9oQ2RvOXVNNWRYNmVpcHBBbFlGc0o0Q2VTV3pDbXAv?=
 =?utf-8?B?d3FHU2FWb1NBQ0V5TEl5Zmp6bGxJeFZ1dDVSUnRVYm56OUYwS0VGUG1TcGJR?=
 =?utf-8?B?S3g0WnVRWmpMM3Q5MmJUZ2dTOUI3NWFBTmMxUS9ROEtIaE9vNGpyZ2dGc292?=
 =?utf-8?B?OFZpYnhBOUo1RVp0YnFLZEhVcDVSK2RTemhjbFhPVWhJM0ExYjc0cDNLUVNR?=
 =?utf-8?B?TWNxUG1rMGF6OUNibStUSXFjU0hyVDlFZlFkV3psTngxK3VaK0xMK2lPc2Vw?=
 =?utf-8?B?akMwTklwWHIyRFcxK3VIUlpTT29lMVNrQWc0Q0R5cXJvQUNHb0RlaFVTRThK?=
 =?utf-8?B?NXZmd2Vlc0hBVXcreTYyaTNrSXRaVWxaNVpJODVURld1WXVia0llQWNMUndp?=
 =?utf-8?B?Vm4zdTluVEJqNTRQNU9aeTNseVhCTVZodjRQVUZPSUdIVnQyck1HOWNCcjdR?=
 =?utf-8?B?L0lYeDVOQ3dvUkhWSEhIWHNDZFc0ZkdvQ1c5dUpSR2w4a0R0bzVEaHZYNXpW?=
 =?utf-8?B?S015VVRGQUo3V3MraEJ5ZlMvdGwzUnRzcGJVaFFkUHJmckVMVzhmYzR2b05D?=
 =?utf-8?B?cFN1bGNwWERicUlzUG41N1NVV1U2YU9ZRG82cWFFeG81U0dNRUhNdHUyQjc2?=
 =?utf-8?B?L3ZpNFpDTWRUeUh5VW1COTRORzJmZHc2U2VPZmlsNTV6T1lpN0hBNkljZ3po?=
 =?utf-8?B?VmJNUG9OWWdRY1N3dkphbnNxQ1M3Zmx4VHNDWlNIN01NYkwzd1UyeVFRMSs2?=
 =?utf-8?B?N1crZUdZWklrdXphM1g0bzRTM0ZQSUNUZ2RsK01tbEhyc0w3enF0NHQ2NDRw?=
 =?utf-8?B?eFMvRGRXTnkvMzVZTE1xdy9BS3BOaUpvL0FueURMeUxOejU3NC9lZjlwdUJr?=
 =?utf-8?B?d09iaGhPaVpFN2hZR3FRc0wySWlOM1dtTnE4b1Z1b1JIc2FVY3pvdmN0aE8z?=
 =?utf-8?B?MWRPYWxWL09YZDVmQWNWSkVZdEd4Z0dFVkpDOVFIMWh3R0ZxZzgwOHljWTZs?=
 =?utf-8?B?Wnl1bis1ajNGZnNkWXkvY3ZVTlZEcHNIS2lLMWtSZlFXemFmTmpqYzNRYS94?=
 =?utf-8?B?MWM1S08vQzI4VDhWVWdTSFVMTkJPaEtyKzd6elR3QnlEYWh6a0JCdjdrSjA1?=
 =?utf-8?B?WitTNEkwT3J2UGRuSlZFY2UvckgvVVNLbUJoc0hpL0FYenJTcENrd2NWNDNV?=
 =?utf-8?B?Q0lvSVVWTDVNRGpsbVQydWpNbjdZZE1USWtYTk9LYmVWYVhCWVBSYnVLbUt3?=
 =?utf-8?B?TGZoTjM2YkxOdFErNGZ2OUdQV2VZeXJlbjVyZW5aUkU4dkZmUi9TalU0MzZV?=
 =?utf-8?B?Y3ZtYmpZQnZwY0VHckxQSDhocVQwcFVqS20zQXR0QkZxajBhb0N5bHNKbk5S?=
 =?utf-8?B?bDNZSjFkWkZkZ1gvZ291VHFlbWJCNFB2ZVpsaW02MStVVk1nQkRzVzNPWlpv?=
 =?utf-8?B?eGEyYmRvREN4Y2k0ZitBb3piSWpleXBudHZEenM4bklwWkhJOVdnSkdHR1Ex?=
 =?utf-8?B?V1FodW1hS1I3UkJoUDNWSVdyTnBsZXhvUSs1aHg0c3pzNUNLZVg3cG5pcmdK?=
 =?utf-8?B?c1BrQXh2WlJKcHA4M09SR3JQZU0wTVhpOEVJcDU4bTQvQTExM25YeldNUEw4?=
 =?utf-8?B?MWxCQ0d5RXRLOG1IYUtJMjI2d2dmSjBuR1VDS2RFNmdGZUdZOXRDZVBod0lX?=
 =?utf-8?B?NG1TTWJXV0Y1SzBJU0xGV3o0VnpzUE1keVg5MnI2NDUwRTlkUk84REd3OVdX?=
 =?utf-8?B?L0FkUVJuTWNHNkpzZm4xNWdDVzNxWDhIRmQxeHdFb0QzM005UmdRckdEUjFl?=
 =?utf-8?B?a0RhUTRGWW1KRlFOSDZPTW8xOEN0K1lHb3c0Z2NINFhxNEUzcUdUZWY3Z3Er?=
 =?utf-8?B?WVdQUUhiZTc1N0NhU2EvOWU2VnJ4Q080RERqRktiVzhaK2srcmhIS1dYZVdu?=
 =?utf-8?B?enZISUl6L2dxN1VOUjdFME1KYVNkOXFoSGVZWUxEK3AwUUlQVzRTeHdTL2E5?=
 =?utf-8?B?Wm9MSTF3cFExS08zeWNnejVnVjNvNWVWcWpjbWs0c0QycEZtVzZuU2N5c0x0?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70812e1a-42cc-43c0-8c53-08d9f68580ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 04:32:30.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7dgFD+nhXhuaqNZgzCn6COswEM6HutwJtm2Zz27U6FyeB5O79sy/X46zgxIv88W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1717
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: HWgMdYfY1SAmk8UiydqVNBeOCpFakBju
X-Proofpoint-GUID: HWgMdYfY1SAmk8UiydqVNBeOCpFakBju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-23_01,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230022
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/22/22 7:13 PM, Andrii Nakryiko wrote:
> On Tue, Feb 22, 2022 at 12:35 PM Mykola Lysenko <mykolal@fb.com> wrote:
>>
>> Thanks for the review Andrii!
>>
>>> On Feb 19, 2022, at 8:39 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Fri, Feb 18, 2022 at 4:30 PM Mykola Lysenko <mykolal@fb.com> wrote:
>>>>
>>>> In send_signal, replace sleep with dummy cpu intensive computation
>>>> to increase probability of child process being scheduled. Add few
>>>> more asserts.
>>>>
>>>> In find_vma, reduce sample_freq as higher values may be rejected in
>>>> some qemu setups, remove usleep and increase length of cpu intensive
>>>> computation.
>>>>
>>>> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
>>>> higher values may be rejected in some qemu setups
>>>>
>>>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>>>> ---
>>>> .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  2 +-
>>>> tools/testing/selftests/bpf/prog_tests/find_vma.c  |  5 ++---
>>>> .../selftests/bpf/prog_tests/perf_branches.c       |  4 ++--
>>>> tools/testing/selftests/bpf/prog_tests/perf_link.c |  2 +-
>>>> .../testing/selftests/bpf/prog_tests/send_signal.c | 14 ++++++++++----
>>>> 5 files changed, 16 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>> index cd10df6cd0fc..0612e79a9281 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>>>>         attr.type = PERF_TYPE_SOFTWARE;
>>>>         attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>>>         attr.freq = 1;
>>>> -       attr.sample_freq = 4000;
>>>> +       attr.sample_freq = 1000;
>>>>         pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>>>         if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>>>                 goto cleanup;
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>> index b74b3c0c555a..acc41223a112 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>> @@ -30,7 +30,7 @@ static int open_pe(void)
>>>>         attr.type = PERF_TYPE_HARDWARE;
>>>>         attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>>>         attr.freq = 1;
>>>> -       attr.sample_freq = 4000;
>>>> +       attr.sample_freq = 1000;
>>>>         pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>>>>
>>>>         return pfd >= 0 ? pfd : -errno;
>>>> @@ -57,7 +57,7 @@ static void test_find_vma_pe(struct find_vma *skel)
>>>>         if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>>>>                 goto cleanup;
>>>>
>>>> -       for (i = 0; i < 1000000; ++i)
>>>> +       for (i = 0; i < 1000000000; ++i)
>>>
>>> 1bln seems excessive... maybe 10mln would be enough?
>>
>> See explanation for send_signal test case below
>>
>>>
>>>>                 ++j;
>>>>
>>>>         test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);
>>>
>>> [...]
>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>> index 776916b61c40..841217bd1df6 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>> @@ -4,11 +4,12 @@
>>>> #include <sys/resource.h>
>>>> #include "test_send_signal_kern.skel.h"
>>>>
>>>> -int sigusr1_received = 0;
>>>> +int sigusr1_received;
>>>> +volatile int volatile_variable;
>>>
>>> please make them static
>>
>> sure
>>
>>>
>>>>
>>>> static void sigusr1_handler(int signum)
>>>> {
>>>> -       sigusr1_received++;
>>>> +       sigusr1_received = 1;
>>>> }
>>>>
>>>> static void test_send_signal_common(struct perf_event_attr *attr,
>>>> @@ -42,7 +43,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>>>                 int old_prio;
>>>>
>>>>                 /* install signal handler and notify parent */
>>>> +               errno = 0;
>>>>                 signal(SIGUSR1, sigusr1_handler);
>>>> +               ASSERT_OK(errno, "signal");
>>>
>>> just ASSERT_OK(signal(...), "signal");
>>
>> I am fine to merge signal and ASSERT lines, but will substitute with condition "signal(SIGUSR1, sigusr1_handler) != SIG_ERR”, sounds good?
>>
> 
> Ah, signal is a bit special with return values. Yeah,
> ASSERT_NEQ(signal(...), SIG_ERR, "signal") sounds good.
> 
>>>
>>>>
>>>>                 close(pipe_c2p[0]); /* close read */
>>>>                 close(pipe_p2c[1]); /* close write */
>>>> @@ -63,9 +66,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>>>                 ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>>>>
>>>>                 /* wait a little for signal handler */
>>>> -               sleep(1);
>>>> +               for (int i = 0; i < 1000000000; i++)
>>>
>>> same about 1bln
>>
>> With 10mln and 100 test runs I got 86 failures
>> 100mln - 63 failures
>> 1bln - 0 failures on 100 runs
>>
>> Now, there is performance concern for this test. Running
>>
>> time sudo  ./test_progs -t send_signal/send_signal_nmi_thread
>>
>> With 1bln takes ~4s
>> 100mln - 1s.
>> Unchanged test with sleep(1); takes ~2s.
>>
>> On the other hand 300mln runs ~2s, and only fails 1 time per 100 runs. As 300mln does not regress performance comparing to the current “sleep(1)” implementation, I propose to go with it. What do you think?
> 
> 
> I think if we need to burn multiple seconds of CPU to make the test
> reliable, then we should either rework or disable/remove the test. In
> CI those billions of iterations will be much slower. And even waiting
> for 4 seconds for just one test is painful.
> 
> Yonghong, WDYT? Should we just drop thi test? It has caused us a bunch
> of flakiness and maintenance burden without actually catching any
> issues. Maybe it's better to just get rid of it?

Could we try to set affinity for the child process here?
See perf_branches.c:

...
         /* generate some branches on cpu 0 */
         CPU_ZERO(&cpu_set);
         CPU_SET(0, &cpu_set);
         err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), 
&cpu_set);
         if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
                 goto out_destroy;
         /* spin the loop for a while (random high number) */
         for (i = 0; i < 1000000; ++i)
                 ++j;
...

Binding the process (single thread) to a particular cpu can
prevent other non-binding processes from migrating to this
cpu and boost the chance for NMI triggered on this cpu.
This could be the reason perf_branches.c (and a few other tests)
does.

In send_signal case, the cpu affinity probably should
set to cpu 1 as cpu 0 has been pinned by previous tests for
the main process and I didn't see it 'unpinned'
(by setaffinity to ALL cpus).
This is inconvenient.

So the following is my suggestion:
1. abstract the above 'pthread_setaffinity_np to
    a helper to set affinity to a particular cpu as
    this function has been used in several cases.
2. create a new helper to undo setaffinity (set cpu
    mask to all available cpus) so we can pair it
    with pthread_setaffinity_np helper in prog_tests/...
    files.
3. clean up prog_tests/... files which have pthread_setaffinity_np.
4. use helpers 1/2 with loop bound 1000000 for send_signal test.
    The implementation here will be consistent with
    other NMI tests. Hopefully the test can consistent
    pass similar to other NMI tests.

WDYT?

> 
>>
>>>
>>>> +                       volatile_variable++;
>>>>
>>>>                 buf[0] = sigusr1_received ? '2' : '0';
>>>> +               ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
>>>> +
>>>>                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>>>>
>>>>                 /* wait for parent notification and exit */
>>>> @@ -110,9 +116,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>>>         ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
>>>>
>>>>         /* trigger the bpf send_signal */
>>>> +       skel->bss->signal_thread = signal_thread;
>>>>         skel->bss->pid = pid;
>>>>         skel->bss->sig = SIGUSR1;
>>>> -       skel->bss->signal_thread = signal_thread;
>>>>
>>>>         /* notify child that bpf program can send_signal now */
>>>>         ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
>>>> --
>>>> 2.30.2
>>
