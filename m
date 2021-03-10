Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB03334C7
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhCJFRI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 00:17:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229632AbhCJFQt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 00:16:49 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12A5DKVS026679;
        Tue, 9 Mar 2021 21:16:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0GjcDQCzouIVmyTB0zWcW+Q9g/Z+9ewH7MT7nqlBnUc=;
 b=j5qEtwW+d6Hd99C6QkvH6xfSQPJMVS/vjIgq/AD2zh/pb+oJx0RS1jHShLANM97e8pCp
 hHkaZrldbDAk/mYhJXULFpDrWcdmYYwLGJCzucIhWYlN+3yb9/4sjwk23+kyfngpoyU1
 KwxVXeyCPkUnXb1aA8DwcppFGKsqFKQPZLA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 376jvf17d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Mar 2021 21:16:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Mar 2021 21:16:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q43i3uohEsRTQDSeKYJVymxavUMGFgRqHCQz4Stmn4fo82LE1gXePRll9R2MjWdv1RZa4zwsmPnMi7bIBohk+m1f6jbSX2y6XwYOsopy8VM9DBhyf2Gb8GlloayoTUC1sPmE/Ud3a/+mIT8WMuFDej+brite1BnJyTNT73PN7s2OkG2aYQzG9A9i6EldfAICfGOY0j3GoB5grqhgFTvyzYJTOpWQZWHR0lc7bzM3q7NIggkaWy/+8XhNNMZPRkOOMiHLUz1OCGONTLo1jO5SoY0iiOAhohqEcXkYqyrgLRkoiLaEZiSeWEUT6OYRwyqPGQTQYlqveTnXiY11OzTPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GjcDQCzouIVmyTB0zWcW+Q9g/Z+9ewH7MT7nqlBnUc=;
 b=ALLaZLgICI29fypsipqzBNf5K72zLg2A91+vuOOn2d2R4MhhTbruWzSlrFGVvfLRLQn8+wzMLA9X0/abWWlB/V+jpL4lenRPBQvTAUQrjLIhQxlE/rDIDY9fXzzCDgvy+MUjVy0WbPQbc275BU7uZIhjxEv8/hxQKqzP0QLizi+MaJ+8ynPa1Pl4oOD2y0goIctDeRhmk0TGgiY3/5Tfe3l6ZsC+UJx57xEr8rgIsiOF6X3gBTR6TjBkvZvsYtx/sz2+nsuj46Hq5ItgGn+Hg9nTdHaNtwUMJ/jjEb/t5yAK+vgOFBPpYkVUBUTNf1pvSKhuCtunliA/U3afEtq1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4223.namprd15.prod.outlook.com (2603:10b6:806:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 05:16:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.039; Wed, 10 Mar 2021
 05:16:33 +0000
Subject: Re: [BUG] One-liner array initialization with two pointers in BPF
 results in NULLs
From:   Yonghong Song <yhs@fb.com>
To:     Florent Revest <revest@chromium.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kpsingh@kernel.org>, <jackmanb@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20210310015455.1095207-1-revest@chromium.org>
 <f5cfb3d0-fab4-ee07-70de-ad5589db1244@fb.com>
Message-ID: <eb0a8485-9624-1727-6913-e4520c9d8c04@fb.com>
Date:   Tue, 9 Mar 2021 21:16:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <f5cfb3d0-fab4-ee07-70de-ad5589db1244@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:3683]
X-ClientProxiedBy: CO2PR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:104:3::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1111] (2620:10d:c090:400::5:3683) by CO2PR06CA0055.namprd06.prod.outlook.com (2603:10b6:104:3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 05:16:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c8758b0-1e5a-4ac1-ae50-08d8e383abb9
X-MS-TrafficTypeDiagnostic: SN7PR15MB4223:
X-Microsoft-Antispam-PRVS: <SN7PR15MB42233B4906B83DDB847367A7D3919@SN7PR15MB4223.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+QwYN/C/amtA9WEzJCUaPPOOi7SO0VpKI2T7Ks/pknVUEAF4QOeKWdKSsCzw4d+z6BGiNaTm7h2A5lnphsGG0UReICc4TMiq16tdiFt52kSNKINWDDDqlxkR2bcuseuLNLw5L+KItO4yYfZ/PrBUPKkA13jRQNXXCCVJPNd6oWmPOHAsDSnJ2pGQHgbppTkN5AQPCwmOnnNwIXqFy8FwcqqPsBc1p0fBEArZFwub70t6OIhqHFxwadqVzypSV6NSWpQRA2n8RudkeuAZ13IzjPUmhYC9ZVN3bJAch7TPmVl3Af4vdRVH44ucGNib//h9utzReX/WoM0ad6rDc0PHPFgV4+nyHSrUShIeYa7+z3dV524vncgLiKln8rp7XYQ7fuhU/8Rz0vkGhjCkp6U+Iqg+d6TbzbdIPqw4hNGSK/N1fi/kVXcb3lNpwpNvzuw4Tzhx1IHxH1C5hEU/vh/z+jyXpz6qCxmWTBxn4svt5iKZhSpI4+j+tmX8Sf4z/FO4A+SmoIwreBg8VuHXyppp4GNV7epHP7i7tSflmZElvWMDdCMv2xvCbV0gPlJxAgxTxlJAhCO+LxS2tyRibqbiKEQKQ8Cjo7/FHeTAkYVdqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(376002)(39850400004)(316002)(8936002)(4326008)(6486002)(86362001)(36756003)(31696002)(66946007)(186003)(66556008)(16526019)(478600001)(53546011)(6666004)(66476007)(83380400001)(31686004)(8676002)(5660300002)(2616005)(2906002)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U3d0R21BNEFOZ3M5R3lBMGxOL2ROOUw4c3ZmcEQwRDM2TGZiN0M0SklkRGRI?=
 =?utf-8?B?U24zN1g0R1F3TUVxOWFqR2JJZ3ltRzJyWlRhOHMxN0x0S05NZTBJclBqVXNn?=
 =?utf-8?B?aU9wemMwWUc0SDNqdXZaaEhnMXpYYXVjZVYvNGVvNWplWFJOWHk2YUxtbFFh?=
 =?utf-8?B?am16bDl3SVZDN3ByeCt1L29mbkIzU043Z0YxemI2WVB5dEZQbGg4eWxlbTYy?=
 =?utf-8?B?WGRsd3JnSW84U1g5dHVuOVVSU0xQeVd6a0VReEVtMWJVQ3l5cGdKS0hwMXVM?=
 =?utf-8?B?K3UzOTE0SUJvTll0WDVaV01JN1Nobzl2VVBWSjFkTDYyOFgraHZLYkIyVzhX?=
 =?utf-8?B?MVA5THUwcnhobDJRbnJiUTdjYVNaSE9LRGN5WXBHdUc1d2thMUZyaEFDUnJF?=
 =?utf-8?B?bUE5cEo5WGJHeklvMFRNcWlOUXluQjVYYWVsaUQ4S2ROVU1GaEN1d0hNcWYz?=
 =?utf-8?B?S1FqaWVFdkY0MWJDZEJaTHVScGNNUlhCcXErS040UEUySlBzOGkvd2FoR0sz?=
 =?utf-8?B?UGtIRFQzOVYvSDF5VHlNTGRzN2tjSUZXREVhRzRSSGFJZitReTJZQUZVSERK?=
 =?utf-8?B?aCtCUHVZU3JsL3c0VUZDYlBKUHNSMTFCdVUyTjhJWC81Q0hIeVVrWEh2MHZY?=
 =?utf-8?B?S1B1TjhjOUZub1U0MHd4aGlqZWpkVks3c1RSV092WTk5TnpGUEZqbnh4MGZa?=
 =?utf-8?B?REc3Sy9ZTlZHamZJcW9wRVRTOHVyaSt0Zm9BMUx6elV0clFsWnBKTGo0Z2tt?=
 =?utf-8?B?eW12czdjdnJFVHg0U0pFSXhkZmJubDFQNjdmQkNqU1IxVjA3eFJybllobWdC?=
 =?utf-8?B?QkNIUW9UVTlzQzlDdnlad0gzV0k5b3FVblpoYWt4SUthSERNUHQ1blV3b0xy?=
 =?utf-8?B?RWhBdk1KbjJBZkRjRUtQU0VDNEswT1oweTJmdENEYkNjbXVZdUVGbUZINDBN?=
 =?utf-8?B?UGtpMVBLeEc4WFVETURJUXRabUVXWE9yQzg1L0xrVjFNMlQ4NkMwdmpjOS9a?=
 =?utf-8?B?VnNWVTlvVFhmUkRXeHNCK2tpMU9POW5Razk0aG5jdVhlbW5UY01ESTBsVzBW?=
 =?utf-8?B?V3ZEd0dRQ3ZndXVxVWUzdVJVT1NJaGR4ZjBEQjlwK2ZJY052blBNdTFzK3FD?=
 =?utf-8?B?K2wwYWxZbEtEekx3TVBSdWRNMUpQSGZGWlNBL0srS1pmdVFRL1hLd3ZJc0py?=
 =?utf-8?B?RWd5R3ZzUjZYZ2U1aGRWRGpMVEhaaDVjRmhXVGM2WE5DeXgzY0NLSG1vRWt2?=
 =?utf-8?B?VGFQblVZVEYyV1dWV2R4NnlWbmR3N0VnakNaWW1NMnUxWktZZlZJU05OM09x?=
 =?utf-8?B?cXlaSXFNRDNTK0RzV09WbXdTSzZoaDlJNFA4L3ZrRy96UGJESm85MmR1QWND?=
 =?utf-8?B?QzcrVWVKMThHM1RzMDVrWEpPdlBvN2VaYmo1aW82Q1FYdDB6VVBZZlppT1lI?=
 =?utf-8?B?aGNuYmRReGwrZEdrY3M2cnJZejhzT0pRdGlKYkxoeVlBM2h2OGdISE9Wd29m?=
 =?utf-8?B?TVFROGVqVVRTRUU4VHh0MFlmc0V2ak1lTUZ4aUpUSlVVdnBLMmtDd0sybkQz?=
 =?utf-8?B?aVFlZnE5cS82cmJqaENsVTlYYStSbUlmVGJxUHY4SUhtRElDYmk3WHg1a3dV?=
 =?utf-8?B?aTM2RlIzb2Fxa2dmZHBGTjJTYTFSQUNXMk9paVBvU3c2bGViczIxakszK1VU?=
 =?utf-8?B?djAyVWtPWG1OcFUvejJnaVQ5K2ZVdEZPcW1LN1JtOUlBbktYc1J5TEYrM2pl?=
 =?utf-8?B?ZkhzSkszTDFiUlVDdVJZRVBITm1paTZaQXhsbS81OHJvelpZMWkvVklPVVI4?=
 =?utf-8?Q?49CpJa4s6+2XOUsOAvry5W9751nPs+FJPu3XU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8758b0-1e5a-4ac1-ae50-08d8e383abb9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 05:16:33.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZpnB/5yp5rpFwPXePdDXeOylNBK67+inuNywGRa64mcx+UN/WRaHsX2dDKud7oB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4223
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_03:2021-03-09,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/9/21 7:43 PM, Yonghong Song wrote:
> 
> 
> On 3/9/21 5:54 PM, Florent Revest wrote:
>> I noticed that initializing an array of pointers using this syntax:
>> __u64 array[] = { (__u64)&var1, (__u64)&var2 };
>> (which is a fairly common operation with macros such as BPF_SEQ_PRINTF)
>> always results in array[0] and array[1] being NULL.
>>
>> Interestingly, if the array is only initialized with one pointer, ex:
>> __u64 array[] = { (__u64)&var1 };
>> Then array[0] will not be NULL.
>>
>> Or if the array is initialized field by field, ex:
>> __u64 array[2];
>> array[0] = (__u64)&var1;
>> array[1] = (__u64)&var2;
>> Then array[0] and array[1] will not be NULL either.
>>
>> I'm assuming that this should have something to do with relocations
>> and might be a bug in clang or in libbpf but because I don't know much
>> about these, I thought that reporting could be a good first step. :)
> 
> Thanks for reporting. What you guess is correct, this is due to 
> relocations :-(
> 
> The compiler notoriously tend to put complex initial values into
> rodata section. For example, for
>     __u64 array[] = { (__u64)&var1, (__u64)&var2 };
> the compiler will put
>     { (__u64)&var1, (__u64)&var2 }
> into rodata section.
> 
> But &var1 and &var2 themselves need relocation since they are
> address of static variables which will sit inside .data section.
> 
> So in the elf file, you will see the following relocations:
> 
> RELOCATION RECORDS FOR [.rodata]:
> OFFSET           TYPE                     VALUE
> 0000000000000018 R_BPF_64_64              .data
> 0000000000000020 R_BPF_64_64              .data
> 
> Currently, libbpf does not handle relocation inside .rodata
> section, so they content remains 0.
> 
> That is why you see the issue with pointer as NULL.
> 
> With array size of 1, compiler does not bother to put it into
> rodata section.
> 
> I *guess* that it works in the macro due to some kind of heuristics,
> e.g., nested blocks, etc, and llvm did not promote the array init value
> to rodata. I will double check whether llvm can complete prevent
> such transformation.
> 
> Maybe in the future libbpf is able to handle relocations for
> rodata section too. But for the time being, please just consider to use 
> either macro, or the explicit array assignment.

Digging into the compiler, the compiler tries to make *const* initial
value into rodata section if the initial value size > 64, so in
this case, macro does not work either. I think this is how you
discovered the issue. The llvm does not provide target hooks to 
influence this transformation.

So, there are two workarounds,
(1).    __u64 param_working[2];
         param_working[0] = (__u64)str1;
         param_working[1] = (__u64)str2;
(2). BPF_SEQ_PRINTF(seq, "%s ", str1);
      BPF_SEQ_PRINTF(seq, "%s", str2);

In practice, if you have at least one non-const format argument,
you should be fine. But if all format arguments are constant, then
none of them should be strings. Maybe we could change marco
    unsigned long long ___param[] = { args };
to declare an array explicitly and then have a loop to
assign each array element?

> 
> Thanks for the reproducer!
> 
>>
>> I attached below a repro with a dummy selftest that I expect should pass
>> but fails to pass with the latest clang and bpf-next. Hopefully, the
>> logic should be simple: I try to print two strings from pointers in an
>> array using bpf_seq_printf but depending on how the array is initialized
>> the helper either receives the string pointers or NULL pointers:
>>
>> test_bug:FAIL:read unexpected read: actual 'str1= str2= str1=STR1
>> str2=STR2 ' != expected 'str1=STR1 str2=STR2 str1=STR1 str2=STR2 '
>>
>> Signed-off-by: Florent Revest <revest@chromium.org>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/bug.c | 41 +++++++++++++++++++
>>   tools/testing/selftests/bpf/progs/test_bug.c | 43 ++++++++++++++++++++
>>   2 files changed, 84 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bug.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_bug.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bug.c 
>> b/tools/testing/selftests/bpf/prog_tests/bug.c
>> new file mode 100644
>> index 000000000000..4b0fafd936b7
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/bug.c
>> @@ -0,0 +1,41 @@
>> +#include <test_progs.h>
>> +#include "test_bug.skel.h"
>> +
>> +static int duration;
>> +
>> +void test_bug(void)
>> +{
>> +    struct test_bug *skel;
>> +    struct bpf_link *link;
>> +    char buf[64] = {};
>> +    int iter_fd, len;
>> +
>> +    skel = test_bug__open_and_load();
>> +    if (CHECK(!skel, "test_bug__open_and_load",
>> +          "skeleton open_and_load failed\n"))
>> +        goto destroy;
>> +
>> +    link = bpf_program__attach_iter(skel->progs.bug, NULL);
>> +    if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
>> +        goto destroy;
>> +
>> +    iter_fd = bpf_iter_create(bpf_link__fd(link));
>> +    if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
>> +        goto free_link;
>> +
>> +    len = read(iter_fd, buf, sizeof(buf));
>> +    CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
>> +    // BUG: We expect the strings to be printed in both cases but 
>> only the
>> +    // second case works.
>> +    // actual 'str1= str2= str1=STR1 str2=STR2 '
>> +    // != expected 'str1=STR1 str2=STR2 str1=STR1 str2=STR2 '
>> +    ASSERT_STREQ(buf, "str1=STR1 str2=STR2 str1=STR1 str2=STR2 ", 
>> "read");
>> +
>> +    close(iter_fd);
>> +
>> +free_link:
>> +    bpf_link__destroy(link);
>> +destroy:
>> +    test_bug__destroy(skel);
>> +}
>> +
>> diff --git a/tools/testing/selftests/bpf/progs/test_bug.c 
>> b/tools/testing/selftests/bpf/progs/test_bug.c
>> new file mode 100644
>> index 000000000000..c41e69483785
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_bug.c
>> @@ -0,0 +1,43 @@
>> +#include "bpf_iter.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +SEC("iter/task")
>> +int bug(struct bpf_iter__task *ctx)
>> +{
>> +    struct seq_file *seq = ctx->meta->seq;
>> +
>> +    /* We want to print two strings */
>> +    static const char fmt[] = "str1=%s str2=%s ";
>> +    static char str1[] = "STR1";
>> +    static char str2[] = "STR2";
>> +
>> +    /*
>> +     * Because bpf_seq_printf takes parameters to its format 
>> specifiers in
>> +     * an array, we need to stuff pointers to str1 and str2 in a u64 
>> array.
>> +     */
>> +
>> +    /* First, we try a one-liner array initialization. Note that this is
>> +     * what the BPF_SEQ_PRINTF macro does under the hood. */
>> +    __u64 param_not_working[] = { (__u64)str1, (__u64)str2 };
>> +    /* But we also try a field by field initialization of the array. We
>> +     * would expect the arrays and the behavior to be exactly the 
>> same. */
>> +    __u64 param_working[2];
>> +    param_working[0] = (__u64)str1;
>> +    param_working[1] = (__u64)str2;
>> +
>> +    /* For convenience, only print once */
>> +    if (ctx->meta->seq_num != 0)
>> +        return 0;
>> +
>> +    /* Using the one-liner array of params, it does not print the 
>> strings */
>> +    bpf_seq_printf(seq, fmt, sizeof(fmt),
>> +               param_not_working, sizeof(param_not_working));
>> +    /* Using the field-by-field array of params, it prints the 
>> strings */
>> +    bpf_seq_printf(seq, fmt, sizeof(fmt),
>> +               param_working, sizeof(param_working));
>> +
>> +    return 0;
>> +}
>>
