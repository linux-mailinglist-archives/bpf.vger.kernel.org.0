Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E5314915
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBIGsA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:48:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50290 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhBIGru (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 01:47:50 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1196en1o017364;
        Mon, 8 Feb 2021 22:46:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OLA+TORcl0lLYBldXUEwIMvW7wInxtz8EXaUnlYN9Ps=;
 b=bEnvrLwDCYt0FS5kGzuBXKaoP9+P1WN0JukH7JzoZ1VApymOWGD8bCuvyqk7gzVAPLNi
 QkL39H6DxCn4SLmo/qPpSyXxafMPr8emwUoezFMx+O4XY+7eqJn0vFoC7KGev8ePPogA
 +sdX3oHgcifi1QN6hf/Hv0j/xfpLWFruQPc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc8dsfk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 22:46:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 22:46:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2Xk31+q9/dBAWGNeV4aUmqs844H8JRomiOECf2KoCOH+QGdIC4ZKLX72G1nHwXpAjHGQkGYRD3mr8yicbzy+LOdiWlVw57y02gLisclwTvi1L+o4KjqGqr7c2RLG54shmV1+6GPYlNnosvJg7HMlQQf6lGhZaQeuJ73RMdp4J/CfTz1jvoOfcFthcw4tUQVKsTYoklHkAKt9zL4B8NSEwk57fWP/73ISKC+rFJz55hS2oyNbfGIXGPbgY/PJtoMkrzxhYJG5k/EYXX6w2asn8TLiF033ehORKE0gdWpa1lgVzpDlud9EuXj2sGQB9zu4LoBvsH27L3taRn3wtZNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLA+TORcl0lLYBldXUEwIMvW7wInxtz8EXaUnlYN9Ps=;
 b=c//jRRP7nsWm14jJm0GhWtyRv0Xve04v5ZdKqGxVWWw9DnuTsQ6vzeqKkoFRu9C5gfusAfDfN3PAnHAlecwq0DKLMYiVNK4sxrL3igKLci6e5mflQYjY+WHrP10smidEwM3sJDVVAMELE3rUHT33CG8+5yUr1iC5FB2KIhJsQcauz/sRCH593TNl7mEJ0vwWc0IEt3884bdfG2bGa/EPLhN2SAoniJE6hQUEDGei9h7llWgjsYX72nbGJt8OUR+y3wc9wXB0YHtWqO+Dly/alVlvjbll1s18qliKpX3wovprmkWavHj/BaiGZ33hLT/WRcn/0WOyRMgKK+ujKw7xwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLA+TORcl0lLYBldXUEwIMvW7wInxtz8EXaUnlYN9Ps=;
 b=eQEa7pwlbRpLLc2+F8Z/J/xNK2gnFzhenLQ3/FGRiJ6thOk/SNWQEwvse39o5nR2aYKbx1EJ/2ke0IIsd95UsjVtFnN/tgerwyBVOsUCTlXM3Hmuucx3Tk3kbEBw6AcaZ8qbUSSEMzmYsP0NS7RlV7sNBN9fgijecIurbTxLdv8=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2694.namprd15.prod.outlook.com (2603:10b6:a03:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 06:46:55 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 06:46:55 +0000
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: add hashmap test for
 bpf_for_each_map_elem() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234835.1629656-1-yhs@fb.com>
 <CAEf4BzbQBCEarNeB+0B_QmgnNsaeVRxjNt0EC2N5og4Qc-U=Eg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ce335d12-e81e-e7b9-e54d-804a5f103932@fb.com>
Date:   Mon, 8 Feb 2021 22:46:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzbQBCEarNeB+0B_QmgnNsaeVRxjNt0EC2N5og4Qc-U=Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e222]
X-ClientProxiedBy: BYAPR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:a03:117::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1610] (2620:10d:c090:400::5:e222) by BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 9 Feb 2021 06:46:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f18ca2f-c207-4e67-c849-08d8ccc67d28
X-MS-TrafficTypeDiagnostic: BYAPR15MB2694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2694B0C16F6DE523F385C07BD38E9@BYAPR15MB2694.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCHwVjQy2EwM7tYKGFqnn0YA50kCemOldvq/andweBBHfr6RgNgbUHII/Tw9rAppCOcINLZaBZBbA3N8pH0IC7YTZYWDAR34pguA5uKLEClwQ1qQwtnKfZscMeznv9kgnP51r+AsP0FKggfLyrkFITUIaltEt+TZJnYMn2hLpEbeeWIS1KbU7eXFoR83tNEG9SwTTMKmxfDiIeF1WYPxWCol7PAszgiYDGEw9r8EzRUpsAcV+rsRwz6Gd59rGvD/5UrDbE0Hr53hOu/Iq8YNQXiv0ozma4ZrkLfT5HkLK0KUqsBi3SQBcic7+au6FOMABYprjNkHjLTLjwl1hyN3pLtKBlbMfUmLMXXcAlVgP53zFx+BMEcuOooXe+oi+eNyP8OHsokTRgFhdrnJwWlUYQ3NOtwnFpM0am8p0I8Xq50Liw/FMeld3BBJyMIzWyxkJSR7sPAau8Ykd1scyHV24m8+2/cFR3yGPsD8hvhU+tC0RPJNJnoI3Ba6dq0+2ITyJgcQyU96c65GjO6sbBeBKId68XaAs4eu5tVrg2iZxWBzXmcDwNcg7NNHbp6G2wNjaPHyqgvKP5qsiRaZzvQwCItbyOndCegbWedalgl+Jta9MZ3W1Emlb9WRSpSYi1zz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(2906002)(2616005)(8936002)(6486002)(86362001)(66946007)(66476007)(66556008)(4326008)(53546011)(31686004)(186003)(6916009)(16526019)(478600001)(83380400001)(5660300002)(54906003)(316002)(8676002)(36756003)(52116002)(31696002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b2pQWHdvOFI2dDB1NEdUdjFzUDhkZWlCMU9kQ3U1ZHFVcC9lUnpjdzFEWHdN?=
 =?utf-8?B?V2ZNOVVHYlA2Nm5OYjVwZnNrUjczMlc5cUZhRk1MczkwVFRjRUF2cUxFbHNK?=
 =?utf-8?B?bnpTMjRISnpHZ3ZRNEpjN01FcnpkYUcxTWd6UWJrN0NocWN5Um95WGJKRVF3?=
 =?utf-8?B?S2NhRDRIMzVQZ0ZPZi8rbGIzVkpWeUZIaUNuUnpTNnNQdnNzOHc1eFVpZzZx?=
 =?utf-8?B?L3Q1aWdYcjRoRnVreEIwVzR5ZDdDZFFEZE5wL3k4aEljQWJqRXpjM1A3WmVx?=
 =?utf-8?B?bGVITk9BaXBMb0hJMGtKYVpiSG81U0lzMHp3Q1NNV3d6bzVuaFIyejZ5TVJ1?=
 =?utf-8?B?N0pQQURPZkhZSGtlWk9rOTJpUmV0UnluRXA4Z2IzbnlVWnE3WURTVDVQMXlW?=
 =?utf-8?B?S08xTXI5VVhxZ3E2VTA1emovcWY1dFhtYXdQMkVTNThmOXZmVGZnSFZDY0Jk?=
 =?utf-8?B?VkVwYXdsV0Njd1VRWFd5NWlQdERiY1JiMytzSGs5MnMvdmRZOU8xN29tRjJY?=
 =?utf-8?B?KzYrUk5Md3B0RFlRYnExZGVnelY1UHpDL2RLWWVEb04xKytseXExK1JudmY5?=
 =?utf-8?B?Z0ZNUnh3OVJYLzhzQzZiTmpqLzJ3ejBtYjdJcDZsaUFMUHViK0U5SlNjOGZw?=
 =?utf-8?B?aVEzWjdaOVlzSDUxR3dTbk1zemY4WDFDc3YvQkpxbHZTNmQ3SUFGd2g4L2Zs?=
 =?utf-8?B?MmdBOERYbDlmRzlZVHBRR2V1eVVRRENIV0VYK0ZtN3ZLVWlYNzdLMHl5MHdB?=
 =?utf-8?B?RnFJN3BSSUx4Vk9lOFRrdkFMVjVFZW90TWFUdkdJZXhqaUFLZzdVL3lxTWxZ?=
 =?utf-8?B?RFMyVmtBUEpod0J2aTUyZVV5VlFLaXZQREpGSWhXdVpVNmQ4SEplSlZXT1py?=
 =?utf-8?B?d1BRK1MzcGJadE5XSnRlK1lXZEVSK3ZpTzdoanZ0QzR0bEpDSzcvT0taMi9K?=
 =?utf-8?B?Q1JyaXVuSzBzdG1KOUVVZVFLaWxXaWVOS3YvMDh4aHFTY3V0TmxHRk5LMUl4?=
 =?utf-8?B?Lzd3ZlI4NmZiWXgyU1Q0RzFHOUF6Nk01ZnZ0c01LaU5DYnQxbTFFOWtyVEdL?=
 =?utf-8?B?Z3h1S0RZa2Jpa1hQMm44NlhRblB0L0xxWVQwcE42TCtTU2tCN20wOG94dDNV?=
 =?utf-8?B?VTY0UFJJZXJ2SU14bDB3aXRoY2pEaFkvUlQ5UUowdUMxejJ1bDcxYjVuWk5H?=
 =?utf-8?B?TUdaZWc5dW9rVmpPb2NhTW9aNWhaRDhBeEZLSXVxR0lONTJaaCtmVnU5Z3JI?=
 =?utf-8?B?SkdZRVBlQmc0OVF6bGsrUGVEdHFNbUFxeFdmQmZlWEY1d3F4SHhra1ducnd6?=
 =?utf-8?B?MEk3SWVJbzBzcTJ2VmFtRU1iRXVGR010ZlpCUUc2anA1SHZ3Yzk4U3JyY2U4?=
 =?utf-8?B?Z1hOWDRqR2VVS1Z6N242aGRIZ1RaeFN5QnF0MmVsUkRTSWFqbmptdVFpQXd6?=
 =?utf-8?B?Ym14dytZeitZWnRUOUpRSWxGeVdmTXJscnAwWFNxdkVYc2lqcWowTVEveFRz?=
 =?utf-8?B?QnlNRlBqT0JtYzlGZ1NpYzQ4RjEvNGFkNUpVSTBBdExMK1g1ZUUreVowQURo?=
 =?utf-8?B?d3o0U0pSNWxPUGNVQTNvR1BDN1hWQzBKaHJreFNDNm9tUXN0STRFS3hVZlo2?=
 =?utf-8?B?N093ZnE5d0RuNE14MU1WNVhZczhFazFKYTZQOWNmdnRGWXBMN25HNTl0Q3Ju?=
 =?utf-8?B?SUoxWkJScFlyVmRXbGJKa01QdC9ENlllRHV6RVpkak1La1Y4WTcxa2hxV05R?=
 =?utf-8?B?NzRSOUQwWkxpcTJhT2gvWEZnNkZKNWtyOGVTTjNRaFVEb1ZhV28xMXgwY1Nn?=
 =?utf-8?Q?IQi/SU3pYoQh9cvFa9VPXn3OD+I8YrflR3qVU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f18ca2f-c207-4e67-c849-08d8ccc67d28
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 06:46:54.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apfszn1pKxd/DE2WEAaXEhWLIhTP8s9o0neOh15frWW6zd9SMzDoHlhB7bFdPGeu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2694
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_02:2021-02-08,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/21 10:34 AM, Andrii Nakryiko wrote:
> On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> A test case is added for hashmap and percpu hashmap. The test
>> also exercises nested bpf_for_each_map_elem() calls like
>>      bpf_prog:
>>        bpf_for_each_map_elem(func1)
>>      func1:
>>        bpf_for_each_map_elem(func2)
>>      func2:
>>
>>    $ ./test_progs -n 44
>>    #44/1 hash_map:OK
>>    #44 for_each:OK
>>    Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/for_each.c       |  91 ++++++++++++++++
>>   .../bpf/progs/for_each_hash_map_elem.c        | 103 ++++++++++++++++++
>>   2 files changed, 194 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
>>
> 
> [...]
> 
>> +       num_cpus = bpf_num_possible_cpus();
>> +       percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);
>> +       percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
>> +       if (CHECK_FAIL(!percpu_valbuf))
>> +               goto out;
>> +
>> +       key = 1;
>> +       for (i = 0; i < num_cpus; i++)
>> +               percpu_valbuf[i] = i + 1;
>> +       err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
>> +       if (CHECK(err, "percpu_map_update", "map_update failed\n"))
>> +               goto out;
>> +
>> +       do_dummy_read(skel->progs.dump_task);
> 
> why use iter/task programs to trigger your test BPF code? This test
> doesn't seem to rely on anything iter-specific, so it's much simpler
> (and less code) to just use the typical sys_enter approach with
> usleep(1) as a trigger function, no?

I am aware of this. I did not change this in v1 mainly wanting to
get some comments on API and verifier change etc. for v1.
I will use bpf_prog_test_run() to call the program in v2.

> 
>> +
>> +       ASSERT_EQ(skel->bss->called, 1, "called");
>> +       ASSERT_EQ(skel->bss->hashmap_output, 4, "output_val");
>> +
>> +       key = 1;
>> +       err = bpf_map_lookup_elem(hashmap_fd, &key, &val);
>> +       ASSERT_ERR(err, "hashmap_lookup");
>> +
>> +       ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
>> +       CHECK_FAIL(skel->bss->cpu >= num_cpus);
> 
> please don't use CHECK_FAIL: use CHECK or one of ASSERT_xxx variants

We do not have ASSERT_GE, I may invent one.

> 
>> +       ASSERT_EQ(skel->bss->percpu_key, 1, "percpu_key");
>> +       ASSERT_EQ(skel->bss->percpu_val, skel->bss->cpu + 1, "percpu_val");
>> +       ASSERT_EQ(skel->bss->percpu_output, 100, "percpu_output");
>> +out:
>> +       free(percpu_valbuf);
>> +       for_each_hash_map_elem__destroy(skel);
>> +}
>> +
>> +void test_for_each(void)
>> +{
>> +       if (test__start_subtest("hash_map"))
>> +               test_hash_map();
>> +}
> 
> [...]
> 
>> +
>> +__u32 cpu = 0;
>> +__u32 percpu_called = 0;
>> +__u32 percpu_key = 0;
>> +__u64 percpu_val = 0;
>> +
>> +static __u64
>> +check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val,
>> +                 struct callback_ctx *data)
>> +{
>> +       percpu_called++;
>> +       cpu = bpf_get_smp_processor_id();
> 
> It's a bit counter-intuitive (at least I was confused initially) that
> for a per-cpu array for_each() will iterate only current CPU's
> elements. I think it's worthwhile to emphasize this in
> bpf_for_each_map_elem() documentation (at least), and call out in
> corresponding patches adding per-cpu array/hash iteration support.

Right. Will emphasize this in uapi bpf.h and also comments in the code.

> 
>> +       percpu_key = *key;
>> +       percpu_val = *val;
>> +
>> +       bpf_for_each_map_elem(&hashmap, check_hash_elem, data, 0);
>> +       return 0;
>> +}
>> +
> 
> [...]
> 
