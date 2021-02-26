Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CEA326A08
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 23:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZWcr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 17:32:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48304 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229598AbhBZWcj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 17:32:39 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QMUkcv027903;
        Fri, 26 Feb 2021 14:31:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kHRj4Pn5kRFVffvKX39KzpjXt7rphAfmzrsna9hYrUU=;
 b=G1UCJSfLXOFkDn9YbOo9Ui2QH+IY6EMCBKZXn5uoq/XngDJ9w5xKlcuAtI5DTcGgnQg/
 J3MkOmnkQ3Kg3dSy7rO0l5wiG9j5YHzEaHr/cROH+KJbD7FbBvNUppJtJHvAXfkt8xe+
 ff17yI/HzqktEa7pLnN+0hs3+UxPQ30LbHM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36wvqdpae5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 14:31:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 14:31:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjhfyQhN7CEUmK+QomXkdEHfY3QpDRHVhgrwuG/IpX+jlLiiUDEkIJ3vWo1hAxibIeuGs+v2hEYZvbwrvQw6ZPVdEJXqHJGDvD70+Hhp22pm8lLb1fLwPGKFjY4kdRIxJaGNMiBllcZqkOj+5DxZxFZensiqcVL55sBKNAJhdpP4ppYhdgyHTCO788s61Y1/PICRsoZpKBtYR1Tx3w0FQ5+6HnifRSkjHpF09Y7wv5z+AxHsuglV1V8jRxHqZPhXeLpKJNGcAaGIxF7CLZtEUS7M1DrRnh7Nsi6EztkbbhzOTYuQfAdxx86SlAC6dFNOndB3VghryT2d74JF3LLuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO43/81NGAMXzt+/b2jBpo4kKxOnNvUu4wBd9WBATAI=;
 b=ItA3M4bKgTw2OGBDDYjvcOd7A14Ym66WMzryfxAOiYogg85XbvbUTOiEFa8V/OMi5ibMw0RNHQTY/kEJ5ONwUkVxwGtjoNOm9bJCNkHsKcyYvtWvMniKlUYYCoIJbrBz0cVdO2LLLjkp1vkSv5H4EnPFfaWTZO9KP3P+TGpW0iD2WAm4KgYWN4cmM0K36wM4JS9Llvhs7aFfFRvuVk5pnNGfOMI2WUf2X3VjLBcsCMYc8Hu406BzQH/YfF9UIW9kStmVZ2npNHy145t6pAPsqpq8DityZjmhOntkiB4w9GHB5fEHCB9TlP5wlWAuNVTgsTFdWMcgmllfKq3wjAlSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2368.namprd15.prod.outlook.com (2603:10b6:805:1c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Fri, 26 Feb
 2021 22:31:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:31:34 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: add a verifier scale test with
 unknown bounded loop
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        zhenwei pi <pizhenwei@bytedance.com>
References: <20210226174800.2928132-1-yhs@fb.com>
 <CAEf4BzaumK2DC_dREDffQGRsVrBinZmbyp4JAESqjP3-rN51NA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e06e5bd3-a5bb-0f60-07c2-3e435707b69e@fb.com>
Date:   Fri, 26 Feb 2021 14:31:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzaumK2DC_dREDffQGRsVrBinZmbyp4JAESqjP3-rN51NA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:e536]
X-ClientProxiedBy: MW2PR2101CA0015.namprd21.prod.outlook.com
 (2603:10b6:302:1::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::193f] (2620:10d:c090:400::5:e536) by MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.3 via Frontend Transport; Fri, 26 Feb 2021 22:31:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4901ca0e-eff7-484b-613d-08d8daa645fb
X-MS-TrafficTypeDiagnostic: SN6PR15MB2368:
X-MS-Exchange-MinimumUrlDomainAge: github.com#4889
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2368E62E74E16D09BD4DBB80D39D9@SN6PR15MB2368.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Y6gIrnjwo23SFFI9J6cyCod9tSj8bmrNiiUHrZbwkNRYUOgEs5wYGQkOVScdnHT4JFKqIe6nppk9h0jlKDW0ljyMMNNVRZ+/4WQNgW7tqU4zhWzDLEZ2bWHGeELsTnVFdyEh0gITSk/IxZ8p2HmndvyFVKQyKHyCQGDIvTZfSyYL2cOkn0h+SrQLu6pAT0RCOktkxq5q4aK8aL1QI0EHmOyB8F1WJhgQ18igD+k5czb8SpFssgZTZ2RnqvVbT9bCWOWyQhFXD8LUbMwa7puMpGU6WCO3NbR3jI+jj3eZ4Y0I0ildfUiv4h2ehuj/R8mAWKS0TAn/qG++Gsn2g9vmTV/+sxVjch9Ct39Y4OAwf6cBqtFZsDtNy8sjQI3P4JDSqy+xBR4hryjazVgMLU54r+4aRU0i+rfMBLspdMJvPN2UL1WlQuxytILHlGRtxX+jICkfG7ZwfmP7YNf6HRXPHC4OK9iusXCsLeMS+tpj514ytohMtNqsI5/3OZxUOPzgj3NpFYHrirohBt+pE2SOvN6zAEqGq22L0Gzg0/SuIV36lG/FiDoFFmJnAiB3w+QoJkNhV1WZm2uIchXSOSTMv5SiImFTCXR8HuzfhyBp4M32Kr/PyqebtBXR7whTJAH88L3YrbN3IS1bJjEG6FcNE75IVV0Btm+Q2yja7eUQRmNeE4zUDB6NZk48Rno3KlJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(366004)(346002)(376002)(2906002)(966005)(8676002)(66476007)(66556008)(5660300002)(66946007)(8936002)(6486002)(52116002)(2616005)(31696002)(54906003)(478600001)(31686004)(316002)(6916009)(186003)(16526019)(86362001)(53546011)(36756003)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VlhIbXVScG9FOUs5NGZhRWM1NDZGNm14djVtMy9zWjZHRkZNb0ZJaDF6aTUy?=
 =?utf-8?B?U3dPQVMwOXdUUVAydDllSk1YNGIxazdNR1UwTXRKSnU0VDJhQjNxcEVDQUg0?=
 =?utf-8?B?TnNSVThFaGNwSFVjckdkMFkvMUZUdkhyR21yMzBBWXg1VnlWVVM5emhhc2x2?=
 =?utf-8?B?eEE5ZVZVYkpXQW5vazlwS0k4YnJDUTVOaXpJWm5tT3psdGNiMmFIRmlNcjdD?=
 =?utf-8?B?NUdkU0ZDQkUxVU52eDdtcWRxS3JYcHgwLzBhRDdZd3ZjR0kxL091anMwN3lk?=
 =?utf-8?B?Skk2c254RGpLSnBtanNmRThTak5JQUI2MHA5cS9IT1Y0dUFhcDYrWG9yWmQx?=
 =?utf-8?B?UXg3THJXS0dPcHpaRkJYazh4S0FHS3JRTm55RkVwL01aaUE3cmp5cVhhRkhw?=
 =?utf-8?B?Q2xwVWppVmpmcjJMRzN2WUxRaUt1TVUzVWVuaHlpSEVPQWVaZnRxNUZIY2VQ?=
 =?utf-8?B?THhuNmpVUmhGMHZpOW83bDF4eUxqMTk4NlFQTjA2dVpnV2ZlMDhEODk0dXh1?=
 =?utf-8?B?aHJzVzE3MTVHdkJ1WTdmS1lYZURUMDFzMk5PaHFCZHQ3eTJCS09PNEZJOUQw?=
 =?utf-8?B?YmZiZnM5REdhZ0NSRDJULzVzWlBEck1XK3ZCR2VxUWhOcmhOelJ2R1hlRzVv?=
 =?utf-8?B?SXA4dWxGYUtNd3ltZEtxWitIbTF3ZXhsK0JNU1FtckRlWTFydE5GUTlGWVor?=
 =?utf-8?B?S1FIcGhHbWRqL3dFWlpQbXIyNVdwdGtEZ01PVy9IbzNtUDVlMGJ0MTJZbGR5?=
 =?utf-8?B?WWZuOU92TkZPZ1BWZUpldExTL21mMkZoeVo0dTkwbHp4eTduUTBLblBlNGFx?=
 =?utf-8?B?Z3RpVnRtTFZseThTemxaaUdBRGZvOUlTUnBtZmZnNml6SFBPYzRqTmg4dE92?=
 =?utf-8?B?eTVjQ0szcE9ab2dienNtSERGMC9vZjFSTHBuZE9NT0x2YThGblhTUlZYcmo1?=
 =?utf-8?B?WCtqeTdaWjJhVUJrT0pzQ3YzaWRvZy9lS1prbWZHd0hDTmIrMXZVbDJXUkFz?=
 =?utf-8?B?cUJuc21vQzNLQ3I1cjBwRi9rUkVtTngrSlRpWkRZZkovaGFXNlFKZ2R2blow?=
 =?utf-8?B?aTJSMVNYeHo3aE9sOU4xWmgvMDEyTTNJZW1aaUVJNW5jZksybmx0TGF0Rkdp?=
 =?utf-8?B?aDNHWi9qUGhaSzBzcTh1OVYreXJ0UU9WcWVtL1BpZ3o0MEtJSG9jOGpYQ3Mx?=
 =?utf-8?B?MTlhZWJRSFZPL0svTXB0L3U1ZWQraGNSREVFR2Q5cHNUQ01aVWxuYzdxcXRI?=
 =?utf-8?B?S1NkaDNobUZ0cXR6SEtSd3NaRkZwNzMvOXFIMmdOdXZTM1lHNVAwNWcyelJr?=
 =?utf-8?B?KzEyeEkvbkR2WU1WU2xtNWlCRXJDVmw2WmNpS21yVHhrREdkZmZoRGtvMmVq?=
 =?utf-8?B?a1NEaHl3KzFpUWFKd0VSMGwwSlZGOUhZckNQSlV6Rkw1b1BraGdiOTFjWkQ0?=
 =?utf-8?B?bHVueG1SdmpZU1JpL2c1cXFJVi9lWGxSVkdJcXJWblY5SGlpZ2l1UHpmL2lX?=
 =?utf-8?B?N3l6dDNHeDYvK2xCUFkzZ000V2xLcTZrZVhINHliR3Z3TUVOcm9yZi93elFB?=
 =?utf-8?B?dWp4TmZzZnBxd0NGVkR4MkxvSWtWTWsyZ0tlU0tkbkg2MDVYUlFHWWFRSTRr?=
 =?utf-8?B?dVJpdzBKUHpETHQ3Y0lpRloycytFS1U1cnUwTlVEdCtnRE1pTE9lYWNoc3FV?=
 =?utf-8?B?VjZnVXVQSkVWTVZhOWo2OFc2VjFTZ1l3d2w0R0JoSGM0bmtJZDRBemNvSmFx?=
 =?utf-8?B?UzJZUXUxOGl5SngxM1pWMzhiWGtjME9iM2UxbmVoRXdnbzg5L1hZSG1hdWx5?=
 =?utf-8?Q?WAyf9Pu0MYJp+G9obEVrWgi6P8D94YTX8zNTU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4901ca0e-eff7-484b-613d-08d8daa645fb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:31:34.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycazbhsJ0cc7RzsrQGP3dzJ991AYTVhaGGrw5+gkFPgTUu8uxiyMlfNoGqBNg48R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2368
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_12:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260166
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 1:08 PM, Andrii Nakryiko wrote:
> On Fri, Feb 26, 2021 at 9:50 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> The orignal bcc pull request
>>    https://github.com/iovisor/bcc/pull/3270
>> exposed a verifier failure with Clang 12/13 while
>> Clang 4 works fine. Further investigation exposed two issues.
>>    Issue 1: LLVM may generate code which uses less refined
>>       value. The issue is fixed in llvm patch
>>       https://reviews.llvm.org/D97479
>>    Issue 2: Spills with initial value 0 are marked as precise
>>       which makes later state pruning less effective.
>>       This is my rough initial analysis and further investigation
>>       is needed to find how to improve verifier pruning
>>       in such cases.
>>
>> With the above llvm patch, for the new loop6.c test, which has
>> smaller loop bound compared to original test, I got
>>    $ test_progs -s -n 10/16
>>    ...
>>    stack depth 64
>>    processed 405099 insns (limit 1000000) max_states_per_insn 92
>>        total_states 8866 peak_states 889 mark_read 6
>>    #10/16 loop6.o:OK
>>
>> Use the original loop bound, i.e., commenting out "#define WORKAROUND",
>> I got
>>    $ test_progs -s -n 10/16
>>    ...
>>    BPF program is too large. Processed 1000001 insn
>>    stack depth 64
>>    processed 1000001 insns (limit 1000000) max_states_per_insn 91
>>        total_states 23176 peak_states 5069 mark_read 6
>>    ...
>>    #10/16 loop6.o:FAIL
>>
>> The purpose of this patch is to provide a regression
>> test for the above llvm fix and also provide a test
>> case for further analyzing the verifier pruning issue.
>>
>> Cc: zhenwei pi <pizhenwei@bytedance.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/README.rst        |  39 +++++++
>>   .../bpf/prog_tests/bpf_verif_scale.c          |   1 +
>>   tools/testing/selftests/bpf/progs/loop6.c     | 101 ++++++++++++++++++
>>   3 files changed, 141 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/loop6.c
>>
>> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
>> index fd148b8410fa..dbc8f6cc5c67 100644
>> --- a/tools/testing/selftests/bpf/README.rst
>> +++ b/tools/testing/selftests/bpf/README.rst
>> @@ -111,6 +111,45 @@ available in 10.0.1. The patch is available in llvm 11.0.0 trunk.
>>
>>   __  https://reviews.llvm.org/D78466
>>
>> +bpf_verif_scale/loop6.o test failure with Clang 12
>> +==================================================
>> +
>> +With Clang 12, the following bpf_verif_scale test failed:
>> +  * ``bpf_verif_scale/loop6.o``
>> +
>> +The verifier output looks like
>> +
>> +.. code-block:: c
>> +
>> +  R1 type=ctx expected=fp
>> +  The sequence of 8193 jumps is too complex.
>> +
>> +The reason is compiler generating the following code
>> +
>> +.. code-block:: c
>> +
>> +  ;       for (i = 0; (i < VIRTIO_MAX_SGS) && (i < num); i++) {
>> +      14:       16 05 40 00 00 00 00 00 if w5 == 0 goto +64 <LBB0_6>
>> +      15:       bc 51 00 00 00 00 00 00 w1 = w5
>> +      16:       04 01 00 00 ff ff ff ff w1 += -1
>> +      17:       67 05 00 00 20 00 00 00 r5 <<= 32
>> +      18:       77 05 00 00 20 00 00 00 r5 >>= 32
>> +      19:       a6 01 01 00 05 00 00 00 if w1 < 5 goto +1 <LBB0_4>
>> +      20:       b7 05 00 00 06 00 00 00 r5 = 6
>> +  00000000000000a8 <LBB0_4>:
>> +      21:       b7 02 00 00 00 00 00 00 r2 = 0
>> +      22:       b7 01 00 00 00 00 00 00 r1 = 0
>> +  ;       for (i = 0; (i < VIRTIO_MAX_SGS) && (i < num); i++) {
>> +      23:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 32) = r1
>> +      24:       7b 5a c0 ff 00 00 00 00 *(u64 *)(r10 - 64) = r5
>> +
>> +Note that insn #15 has w1 = w5 and w1 is refined later but
>> +r5(w5) is eventually saved on stack at insn #24 for later use.
>> +This cause later verifier failure. The bug has been `fixed`__ in
>> +Clang 13.
>> +
>> +__  https://reviews.llvm.org/D97479
>> +
>>   BPF CO-RE-based tests and Clang version
>>   =======================================
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
>> index e698ee6bb6c2..3d002c245d2b 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
>> @@ -76,6 +76,7 @@ void test_bpf_verif_scale(void)
>>                  { "loop2.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
>>                  { "loop4.o", BPF_PROG_TYPE_SCHED_CLS },
>>                  { "loop5.o", BPF_PROG_TYPE_SCHED_CLS },
>> +               { "loop6.o", BPF_PROG_TYPE_KPROBE },
>>
>>                  /* partial unroll. 19k insn in a loop.
>>                   * Total program size 20.8k insn.
>> diff --git a/tools/testing/selftests/bpf/progs/loop6.c b/tools/testing/selftests/bpf/progs/loop6.c
>> new file mode 100644
>> index 000000000000..fe535922bed8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/loop6.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/ptrace.h>
>> +#include <stddef.h>
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +/* typically virtio scsi has max SGs of 6 */
>> +#define VIRTIO_MAX_SGS 6
>> +
>> +/* Verifier will fail with SG_MAX = 128. The failure can be
>> + * workarounded with a smaller SG_MAX, e.g. 10.
>> + */
>> +#define WORKAROUND
>> +#ifdef WORKAROUND
>> +#define SG_MAX         10
>> +#else
>> +/* typically virtio blk has max SEG of 128 */
>> +#define SG_MAX         128
>> +#endif
>> +
>> +#define SG_CHAIN       0x01UL
>> +#define SG_END         0x02UL
>> +
>> +struct scatterlist {
>> +       unsigned long   page_link;
>> +       unsigned int    offset;
>> +       unsigned int    length;
>> +};
>> +
>> +#define sg_is_chain(sg)                ((sg)->page_link & SG_CHAIN)
>> +#define sg_is_last(sg)         ((sg)->page_link & SG_END)
>> +#define sg_chain_ptr(sg)       \
>> +       ((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
>> +
>> +static inline struct scatterlist *__sg_next(struct scatterlist *sgp)
> 
> nit: here and below, it doesn't have to be inline, does it?

I will keep inline here. With __noinline, current loop6.c failed
at verifier:
   BPF program is too large. Processed 1000001 insn
This may be another issue we need to investigate later.

> 
>> +{
>> +       struct scatterlist sg;
>> +
>> +       bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
>> +       if (sg_is_last(&sg))
>> +               return NULL;
>> +
>> +       sgp++;
>> +
>> +       bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
>> +       if (sg_is_chain(&sg))
>> +               sgp = sg_chain_ptr(&sg);
>> +
>> +       return sgp;
>> +}
>> +
>> +static inline struct scatterlist *get_sgp(struct scatterlist **sgs, int i)
>> +{
>> +       struct scatterlist *sgp;
>> +
>> +       bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
>> +       return sgp;
>> +}
>> +
>> +int config = 0;
>> +int result = 0;
>> +
>> +SEC("kprobe/virtqueue_add_sgs")
>> +int nested_loops(volatile struct pt_regs* ctx)
> 
> libbpf provides BPF_KPROBE macro, similar to BPF_PROG for
> fentry/fexit. Can you please use that instead? You won't need
> PT_REGS_PARM macroses below, which will lead to nicer and shorter
> code.

Sure. Will use. Indeed better.

> 
>> +{
>> +       struct scatterlist **sgs = PT_REGS_PARM2(ctx);
>> +       unsigned int num1 = PT_REGS_PARM3(ctx);
>> +       unsigned int num2 = PT_REGS_PARM4(ctx);
>> +       struct scatterlist *sgp = NULL;
>> +       __u64 length1 = 0, length2 = 0;
>> +       unsigned int i, n, len;
>> +
>> +       if (config != 0)
>> +               return 0;
>> +
>> +       for (i = 0; (i < VIRTIO_MAX_SGS) && (i < num1); i++) {
>> +               for (n = 0, sgp = get_sgp(sgs, i); sgp && (n < SG_MAX);
>> +                    sgp = __sg_next(sgp)) {
>> +                       bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
>> +                       length1 += len;
>> +                       n++;
>> +               }
>> +       }
>> +
>> +       for (i = 0; (i < VIRTIO_MAX_SGS) && (i < num2); i++) {
>> +               for (n = 0, sgp = get_sgp(sgs, i); sgp && (n < SG_MAX);
>> +                    sgp = __sg_next(sgp)) {
>> +                       bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
>> +                       length2 += len;
>> +                       n++;
>> +               }
>> +       }
>> +
>> +       config = 1;
>> +       result = length2 - length1;
>> +       return 0;
>> +}
>> --
>> 2.24.1
>>
