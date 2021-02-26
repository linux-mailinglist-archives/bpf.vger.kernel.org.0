Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77B325BEC
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 04:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBZDZR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 22:25:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7770 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229460AbhBZDZQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 22:25:16 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q3OC4W022956;
        Thu, 25 Feb 2021 19:24:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SNSXxSf/r3heo+8+V2gMhuFzqLQlrZS9XOSD572l8bw=;
 b=oL1xsr39m+rEhT6vj2MixD5YJ7j2NnoABThRNlJN6ZwZmRDZFaEvUNQaIHeb2SdNK0DI
 b6LIuPe1e2twIgJVQ7bEHZ2p3+uK4JdN/Qed5nkYC3GTWPKMVH8J6w8rGLFD/ACdZSrt
 8cnEt6W20lV7AO6O8FKtGrVCJZs6r3xg1g4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36x96bwdn6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 19:24:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 19:24:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJ2OxP7OBCcUstsfx1o7SkRDYBjr+JrM03UjiniP1tgC4fYVybW3QH+iVSQVf+jPGBgZyuElyqJJDJCLLIxCEpPS7ra3cC+B1D+J3HIMuXAdA+KLywhIqfr0xf6chW26bTQDFalKcCKicNz9hqT2joaJgHyeT3lvfxGX9U5HEWwVnKlWh4ZYYEmiOcBcqyV3CsULnzm1nQDj77VZ7VuJTIPRn3d18WyHunywiIaGFyCyE1MIIXcCfXXg6UmufPj6+ydRSajTljbenNm7RR+a8FOYduDleWg5QgquaJ1AoM6mm5ohu9ZtBUr4sA99yNHArWc7LzNwPJmCPgk6haTY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNSXxSf/r3heo+8+V2gMhuFzqLQlrZS9XOSD572l8bw=;
 b=cr0whN0Gt5QqdJAYAM/0gHlvQ/D5HCFO+pdOcZK09tzH0k2xffYhsh5pFVvOfdxw1DGPcK7sCQ16fRtvFTfzxtU7Z86/NRb4D4h+AW2Jb1xViDrmv8hKJTZmezrP9n1rxS5v7Of9lVno18L17rOfkI2Hwkj11qeNhr/LNQ1fzy/ov149Wbhlknt3n3TZuBuq9N0QJu2ywjqTt2bFzjTwP8+hv2DKB5kh5qDkGXkSttiOrNZunj7sq9IC6CULTJ4GIvxmAMR6aN2NaXWKehNmdacqh/8dRjQPu4t1vdpvp+rlZvtlyURv/yCRSFHi/pbYTx7Sp90ZNTcpzACuQDyj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2477.namprd15.prod.outlook.com (2603:10b6:805:28::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 03:24:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 03:24:18 +0000
Subject: Re: [PATCH bpf-next v3 10/11] selftests/bpf: add hashmap test for
 bpf_for_each_map_elem() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
 <20210225073320.4121679-1-yhs@fb.com>
 <CAEf4BzY6ih+UKzjhqyTe9JtgO2wSFjt=kOFC6r1r1hYXdBTNtQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <75afef04-efaf-a39b-97ce-3cd8d334bfbb@fb.com>
Date:   Thu, 25 Feb 2021 19:24:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzY6ih+UKzjhqyTe9JtgO2wSFjt=kOFC6r1r1hYXdBTNtQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:1f06]
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:1f06) by BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.14 via Frontend Transport; Fri, 26 Feb 2021 03:24:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97ece835-8f5f-4025-a0ef-08d8da060075
X-MS-TrafficTypeDiagnostic: SN6PR15MB2477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2477A13F4D19CE748C83279CD39D9@SN6PR15MB2477.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5l0nh1SF8uhP3qlzJL65IrFAcfsJPtbCCMDlDPqCucNZ2jf8Kd6acwjkYa9pZMXI9FfbTup/aHAj9tdkpVWLxswgOlb5R5HZg1Uh5USoa1/D0PL1VnUhSFZ1YyZw0/NU3iAtVvH1TZkO3IqF+tkWVEGb9LQfn3dw/svaAgCQWdnvB2bPugKWpDPZNgjr4RSMZTVbAFMwkrgT8dv+Bt5nJ+euF0FsH7HDWm6b7hpaUZrzHLd6tWEjfxKOQ9UUspRaFijFIK2QOlDa+9psHOjgNU0oJ6+mJxR7thKoXeimNA7RndBOqvYxmI1JwG/jazeHGYChOx6yhlZn3rHNGVS8pTCt/xkNvPJSM25mjU66+hACmLLHcLQeLFM/JUazJJd3qYgggf0/81zGxzKvjZXQo72K50AlwXwL5h7pS6V7mnm4UnMXM5irQl3CsHtdSUmXY0NPWabVGol4vw5jV2hYtRa0yFgRYb4pulAj2k+sI8QXgj1KiH8lMwqRZFR1iKofNwcl5WHr53KkVwCduaRHBLlYP2zeLa7YgxAdbLrkJxndIiKdpvJXc4plhhoUP5Yy7/P7zKX9MlhhbmBDXGOlk06oRQKhZtFshJ+Xx8NzphfiBRRE7yMwHEs1f2gkFvZdyU7cBGp3aMVwfHnqO9l2KkzksH2Q68CCdI4UccRoeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(366004)(136003)(53546011)(8676002)(31686004)(6486002)(86362001)(186003)(54906003)(8936002)(4326008)(83380400001)(2616005)(36756003)(2906002)(66476007)(6916009)(31696002)(5660300002)(316002)(478600001)(52116002)(16526019)(66946007)(66556008)(333604002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RU84VUlTUW4yTlZjVEFwWk56RmNDWm4yOFNjNm5zcDcyNnR2a2JNQ2xxZytp?=
 =?utf-8?B?dkVsc2JKRTR5bE9OTTIxeTBONU1KbmVETUxGbTRyOFM3R0FHeUpKTjFkWkxp?=
 =?utf-8?B?allMMEpWQzJ2N0QvUEVMU1F5a2d0NXNXRnVvcWtsQTc3anQzUUJlZ2kxeE1x?=
 =?utf-8?B?UEpXUDQwZHRNU0xlQ25Nc2x1bzlRSGFYMWFYMlNLdWNxQ3pPOWhHdzlhZEg1?=
 =?utf-8?B?Vi83cGM1SHFsQmQ2ZkREMW1saEpvV0lFajVETGE5VFc4bWN3cmZQTm9pbWVz?=
 =?utf-8?B?cG8wVXBmTlRQUERZeDR6MlVsYTdxVWFxSnB4ZjI1K1hwN01OTWRXajhhSUt3?=
 =?utf-8?B?MVVzbEx6Z01BOUtGVWNxNXJzelVJVzhYS2lVV1JyWGVib2FHajZBdTVUSmRB?=
 =?utf-8?B?VkRubGFoM1dCTDArVGxDV3hQSHdTdTllSHluUFZ3Ynd4OTZScUt1WjROc2hJ?=
 =?utf-8?B?dS9DV25scGpidDQrR2ZZOENESFdsSSs2aXpVT2lWbGRyTUhaU3JJZWR1UE9G?=
 =?utf-8?B?c2ZXeHNQdU52UnhPK3dKQm4xWEpKTTdqTDQyTlgwZnFvR2RmWWZ2dGI4cURh?=
 =?utf-8?B?S0JoY2JpeHNuQ1g2NmNlNVZ4aCtFRWUyMDQ5VkdONHM3b0JkSlVXd0JGM081?=
 =?utf-8?B?UnFJTnErbnFSLzJmRFNUMUtnNmJzazFHbWpSOWtYQ0xYVXBkY3N5eEhzdDUw?=
 =?utf-8?B?UUVxeVd6TGtRcS95LzQyaVpMcTFRWGc0NXZjNUhDMmNRQ21HZUs4dzNyZDNk?=
 =?utf-8?B?MFI4OGxUQkV2dlRmUFMvQUxZdFV5TUNMaUdWME5UZE5iTlkzeEM2ak5Odytx?=
 =?utf-8?B?TGV1ZVBaR2lINGJsRmNkVFdmcUVNWjJqTGs0QjlQZlhDNnRSR3M4NGtqcW83?=
 =?utf-8?B?Z2dFZDF2MnI1d2dXM2YvL3UvMUZ4NDVtSFJrTmRrdGFETlY0TjlNaU4zdjVa?=
 =?utf-8?B?NHRpQTFnVWpJS2ZoS2pXNzBCMGx4UFZNQS9xVFowQXNnZkVGT0ZDTytsR3Zn?=
 =?utf-8?B?TmZHNXFHWlJ0QVFQcFFla2JKNWk3WFYwZjVVR2x0MFFoclZiWWI4alNxRHQv?=
 =?utf-8?B?TW1tS3BxV0EvYTJSMXlCbldJSzloMEpFTVJLZDVFRHVRYzkxQjdyWmdaYUNp?=
 =?utf-8?B?L1NRazkwYnVNdU5pSGxlZkVUUHIyS21vTElMVmROMlZ1QmVoa1YveWI4dDAz?=
 =?utf-8?B?WVMyaExRY3A5YTdOMDhuZm5qTVp4akVOK0NncFJWOHhSUW1wcVZaRlJscjZa?=
 =?utf-8?B?Z01URkhDakdPK2FHbmM2Y3VPdjI0cUwwTC9RdUdaY24wUk5KaEcrV25iOFQv?=
 =?utf-8?B?M2RrcXdsU1NLSGRQR3ZjRFVpSFdrcG4yeUpEVldjcWxFK2p5Y3UxbHlFT3lS?=
 =?utf-8?B?Sllka3o2dW9abDI0STVBdkVHeW04TlQvaFRSNzNJRzNURHE3aEl0OTBOYzdM?=
 =?utf-8?B?ZzJEZExXaDRKTXdnTzJEejlwTDNIdGN3SUlUSXlPbk1mczI2ZnRod2lrN3dI?=
 =?utf-8?B?RTFldEgzWm9PRTZmeFVsc0tmZDBxVVNKVWFmUnpUZkJVU2p2cm5FMGQ4RGt2?=
 =?utf-8?B?amVWUXRudFdLWUxEQVhSS25OaHpWUVBzenlwdkdONFhrSmN5bGFwanM5MnRO?=
 =?utf-8?B?d2o3VnE0ZEVXZWJxa1lqZ1M1MjdWc2RjSVd0d2JxYmxqSEdvSG13TW9DL0ND?=
 =?utf-8?B?SFl6S0w5VmJlQ1RIQ0VhZWt1a2dXd0xZc0NsaUJuR3BUd3luRUxVdDA4UzRO?=
 =?utf-8?B?a2NHUTE1TDlXT0oyZzBVai9IMWdDaTM5WVRGSElvMFRuVTNwd3d5czBwOS9V?=
 =?utf-8?Q?J9sJnq7x8fGaNJSrvxKqjUhvHSsrYs+PyQAfM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ece835-8f5f-4025-a0ef-08d8da060075
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 03:24:18.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPMPcfnJdfEFekJEHE2McVSz8EE6mbFDnIGDBzSoGL+6nlajZprq+U5S0vYsAOcr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2477
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_15:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102260025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 3:25 PM, Andrii Nakryiko wrote:
> On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> A test case is added for hashmap and percpu hashmap. The test
>> also exercises nested bpf_for_each_map_elem() calls like
>>      bpf_prog:
>>        bpf_for_each_map_elem(func1)
>>      func1:
>>        bpf_for_each_map_elem(func2)
>>      func2:
>>
>>    $ ./test_progs -n 45
>>    #45/1 hash_map:OK
>>    #45 for_each:OK
>>    Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> I think I'll just add all the variants of ASSERT_XXX and will enforce
> their use :)
> 
> For now:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>   .../selftests/bpf/prog_tests/for_each.c       | 74 +++++++++++++++
>>   .../bpf/progs/for_each_hash_map_elem.c        | 95 +++++++++++++++++++
>>   2 files changed, 169 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
>>
> 
> [...]
> 
>> +
>> +       ASSERT_EQ(skel->bss->hashmap_output, 4, "hashmap_output");
>> +       ASSERT_EQ(skel->bss->hashmap_elems, max_entries, "hashmap_elems");
>> +
>> +       key = 1;
>> +       err = bpf_map_lookup_elem(hashmap_fd, &key, &val);
>> +       ASSERT_ERR(err, "hashmap_lookup");
>> +
>> +       ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
>> +       ASSERT_EQ(skel->bss->cpu < num_cpus, 1, "num_cpus");
> 
> well, this is cheating (it will print something like "0 != 1" on
> error) :) why didn't you just add ASSERT_LT?
> 
>> +       ASSERT_EQ(skel->bss->percpu_map_elems, 1, "percpu_map_elems");
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
>> +int hashmap_output = 0;
>> +int hashmap_elems = 0;
>> +int percpu_map_elems = 0;
>> +
>> +SEC("classifier/")
> 
> nit: just "classifier" didn't work?

from libbpf.c, I think it should work. Will remove "/"
if it does work!

> 
>> +int test_pkt_access(struct __sk_buff *skb)
>> +{
>> +       struct callback_ctx data;
>> +
>> +       data.ctx = skb;
>> +       data.input = 10;
>> +       data.output = 0;
>> +       hashmap_elems = bpf_for_each_map_elem(&hashmap, check_hash_elem, &data, 0);
>> +       hashmap_output = data.output;
>> +
>> +       percpu_map_elems = bpf_for_each_map_elem(&percpu_map, check_percpu_elem,
>> +                                                (void *)0, 0);
>> +       return 0;
>> +}
>> --
>> 2.24.1
>>
