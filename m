Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA052274F
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 01:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiEJXDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 19:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiEJXDE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 19:03:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EBB1EAE1
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:03:03 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AMBPYc024947;
        Tue, 10 May 2022 16:02:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dRwl8FsJU9FhX1rFfskfcmYebVWc2qJYr6J9iA1Zvfo=;
 b=ZpUL9qLOgVbYxbmo/sKnVVRfmh3VWQHB2epeby+AHEuXp/4wo9mBPujcIlMPGugnd0qC
 SDxrkZ3soun0eNV2WNky1jV+9WC/lOVGZE9JN3p/SOW0OnrVLf98FCgkHL5X9iXEMI2r
 h67IQIz+vnGtzUSt+aYPS3B9e8iFcCu2TRM= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyn47wgf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 16:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYIsnDY8AkCZRstBNb+V/KemqkJDLogG/SPdbN7PXRTyxyqDhiVZX+x5rKPXukG/qZUVn219NxDvVVs1Xrec5WlCRMbdyRbbpe3RtFrbq0GuoRjt3LhSfYT6ypqtmcBuTlz9lardnFbXEZqpKPOnL+vj3PCCcOqITf71JZX668f4v77p1bLva0iRWOOAaOr4WRhxRkbcQv42a1NAq3TcOp2t42+o34SbWbynUCbUeCt7PSxaYgdaiDoGxqLHjLP/nZDdKR2tMiVPxHGpnrxAko/otVi3w/jLtxmpfF7OMtJ3suwwbOQ9Q5F4k6siRdSKXmREFnh7tTg0y8hT3LhTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRwl8FsJU9FhX1rFfskfcmYebVWc2qJYr6J9iA1Zvfo=;
 b=i4NmEdtITkQF4Hn0Cc+I0EUB1aAndRHKfF/RRXVz/YcslEdbiWRYMaTmtKdIbgdzoQl9a5iAkk3m98hm1gMN4S1PWMlllg+8GFXEBY4TLVBnxb6xQHaQ2FVTf1Q5t1Heqfci3KAOr7Rlj5HYcv5PgJR0wrY6fSdW48x6xUBD2Eedj1rzba9a0FTogZ7oL3jDy9+6yXSzIYdBdgE9Mf5OHeQM0zEuMrfblbVMHGJl65ukT+22yUD/hzZysRv4TqrW5V+5GmFMMZ+ldO3sgGklofSFk58E+x1boUi8XMnUVI1KCw72dhCNh14Chw2nLk+QVEPj0OqtxGwR4/b95QHkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2920.namprd15.prod.outlook.com (2603:10b6:a03:b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 23:02:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 23:02:46 +0000
Message-ID: <33fb48e5-ed62-cd2d-cedf-71860912143f@fb.com>
Date:   Tue, 10 May 2022 16:02:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190023.2578209-1-yhs@fb.com>
 <CAEf4BzbXuN4YOYqm_ojgTuJMo4a+J_M6WPF=MUX1B9BK8DdmMQ@mail.gmail.com>
 <f9fa3310-0f63-18af-5424-b82df11c4a70@fb.com>
In-Reply-To: <f9fa3310-0f63-18af-5424-b82df11c4a70@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:40::40) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0334bdad-d236-4145-0c6a-08da32d932af
X-MS-TrafficTypeDiagnostic: BYAPR15MB2920:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB2920C1275B6ABE37B0DE3322D3C99@BYAPR15MB2920.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVMiZs1TS8g0xSd9KoaUpVKXRSDbiuVLnMGZ7ehC90mooxgRRaXgM4S5aR5UyVSZnUsUUVARtDTouWz8YqA+R0icAHx6wheSpvVKD4kAOpTs66H1LyZjylnTa+rz9lU2GTGQR3cWNfENpFScIMlYaAT/tjR0lKdp4uyVNfriej06gG0wvOvUAMd8GZ5tOxNBNl6yZQSOSs0xqAOFtcay4RvAbH9vT4dz9cX+d3yFEgRygjXBC2mOOGdZwAbdNDyRyRWcqudl19e6EU69+yXXie0rn9nbLM638BXt84hrgiuhSp5fGZiGPbuQaVUD/YeczRFphhvoRLm9WopMgN0TzKWfN2qIQuLBTVAhSKVrcrOyZ7fKJA0cV/B0uszNc5HoLEpjOzPsW3iXLk8g3qxh3uiK3VwfyaHTvoM91pjN8LP7ejeMhM1qx7FU/FK0yGXgEkA4rEuJz6H5btcC8R+thMAZ5ptmE10/lviHaRRLEbgw8qSBTKamE6k9eX4zP9zOlPIA14hU56gL4YCWPhKB0hzpjNCMq4nMKdhC8UL1i3h1nYqOp2PruD9znRBnSpYCRoWv5QhuYj8C2Vvp7e5cnpHZMB9407x2h8bHThVQBdFgkVzRpa88xGEoZPUo8lVadkVO4n1ICFce6EqAk79q/Js4j6Tldd0CPPIq1aUlgMa2Hpqlm3BUodgDimHyoROU4shBJdKVmcEJIXkJRJ8+39bIh1kb06iWwWY/PikQCawovHdgQ7ma34cXkEQ9xgJk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(4326008)(54906003)(6916009)(86362001)(66946007)(8676002)(8936002)(2616005)(53546011)(31696002)(66556008)(6512007)(6506007)(52116002)(66476007)(508600001)(6486002)(2906002)(38100700002)(31686004)(83380400001)(5660300002)(186003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1pzRzUzRzFMdTJsbmJTcERObmg1TXVmVGxUd1VWaGE5d0JONVR2bjVDN3Qx?=
 =?utf-8?B?aUl4bUpFR29kOVJVMDEvV0RBNEllQXNLM2pXOXQ1WWVFQnFCaENzR1N0Z28v?=
 =?utf-8?B?eXhkTjYwemZ4YkRrV1MyUVFmUUp3OEx0RzJ1ZVhDMGJDWG9uSS9RVFZ2V2I5?=
 =?utf-8?B?eDlZbmNMa2xRUkxSa1FXck1uQ0ZhOVNzdHY2TkhQYjQrdWJySy80bUFLNGtJ?=
 =?utf-8?B?MVJJZ3ZkNE9Ja1JFbHRnQXI2Wm1sYnFVQmYydXhYek1TSWpVdHZwL2pmYjI5?=
 =?utf-8?B?ZUc4SzZrZGJPQUhKZUlCMDY4WWcxLzROZkJhbHlSWWNUWW1nS1dZNjBvd00w?=
 =?utf-8?B?dkdwbDlUUEtkNXIxVjkrNnlWaWlodEprN3dZK1pOM2FDNmR5RHR4bWZQSG4r?=
 =?utf-8?B?UWNQSEQvRnJSWk42TXhlTzkvcEVoajZJZ0tXMEF4NnBJdXl2aU9ZR05zZ09m?=
 =?utf-8?B?VFJPUTZtL3Y0K1dEYitUK005cHA3bVVmbHpsUU1haUlIQ3VjK3hwVDhxZkpL?=
 =?utf-8?B?QVV1ZEduWnVhS2RoQmZ1eDJsbmlHd0Fodit1UG82Y2hGOGk4QnFZWmZWNFJQ?=
 =?utf-8?B?L2Z2ekdURUtKVXFwczhCZnJwZHovY1lqa3YyaXI2SnFoUS9jcndUMEVxckYr?=
 =?utf-8?B?YXB3YUhuamY4N3BVbkR1V2FIbXkvT3RjTEt4bTZXNzh1M2tEVUNaTEE2M0VG?=
 =?utf-8?B?UzFDTTVhTHRYWUZUMUZuZlhYY2tlNjlLRGtRUlZJenpYQXB5T1MvWlFMVWNw?=
 =?utf-8?B?a08wNm5pbDFzOG55RzhkUTZwMHZDQ2k5K1htdld2a2kzalY2M2hGaWlsdnBz?=
 =?utf-8?B?VUVPcFFrcThLdURCTUE0VDR1QllmRTZzaERVQWl5WSt2UjVBWUFIc2w1RU5V?=
 =?utf-8?B?UWZRenhqRWdMczVJbWNUVTBzQTliUHJuNE41TGFtOUxrZTNkclJhMnU4cjQz?=
 =?utf-8?B?ZlJNZVFxZWhHNElsUndsZ2VSR2tkb1FVSFhYR0EvOXJlWVNZRWlpbU45OUdj?=
 =?utf-8?B?djRVNE11N0J3R1ZMaExMdmVkOXRpVDRwS0lwWWVDRU44Ym0vblkwSHdueUtk?=
 =?utf-8?B?ZXZwT3p1bmw1Tjcra3NkNDdUOC9ET1owOEY3c1ZqTEtpSUpJT2dubWc3QVA0?=
 =?utf-8?B?bDJlM2FCT2ZZSjVqU015cnBCOHBDSDFBVkRxUjg5VzZwQ1gwalQwNEFlU254?=
 =?utf-8?B?bFpkUTdlVTRIZHlMNHp4bzRCTzIweWp2ZVU4YnFFUXFtYUs1aEhBNndhVlZE?=
 =?utf-8?B?ZlI1MUNoN3JaajJhK1JJTkVoWSsvNFlvd1VYRkpsMkg5WjlXdUZ6ZE04VTZ1?=
 =?utf-8?B?bUFRQ1o2QlFlUTZOQjFKUHV3azNjblVlYnJjUzUyem41c0YwN09oQ2RmRUNp?=
 =?utf-8?B?YUJZQlNwdkc5UGlwdFpLSVp4UEEvN3o5Vk1RQWZyT1lUZ25lU1FCVjJBVi9F?=
 =?utf-8?B?WklybWlxZldxOW12VHZhNm1sQjl2SWJqL3ByV1dFV3BZakR0RTdjVTJWbDU3?=
 =?utf-8?B?N1paL25KZ0NRblIzZFdGb1RQc1FEZDk0Zld5Qi9wWjVCSXlqdHhqM2JwalRz?=
 =?utf-8?B?ZklpZTM4ZFovckdaQnhzckphQWhETHJwYzdBUWlmVzZWMi9qY2NUNHQ2YlEx?=
 =?utf-8?B?bWpKSy9teU1VUzRoeWd0M3llNFBrMzN0U1JyTTNYei82VjcxNitRTFozQ3Rq?=
 =?utf-8?B?cVRwR2pkaGk2dmE1R2x3cy9kNUxUVEFTaVh6SVVYaTJSVXhvejZUVFNqVkNF?=
 =?utf-8?B?WHQ2QzBjdU82eEE2bWRXZVFHYVFFSUJoM2N4aGorQ0V1UXgrak8zbDdaL3FP?=
 =?utf-8?B?MFpSdC8rNEZZY3NwL29Xd0VwTWovNXJwZDV6RFFpVmt4NDNDVWpQaVNYaU55?=
 =?utf-8?B?Yk9rSWxiUHgzSHhxaE5VQVg2cWFwUG9KQUFsTTZVUFNhczc0YjBCSmg3YTJ0?=
 =?utf-8?B?SHV6cXlQa0xMbWQ0OGJLNURWVTZCcGxYRStyNHdXUFVVWDVpZHhhRjVCNlR3?=
 =?utf-8?B?UXRDbHZsZUk0Tm15eEJscXB4VExxY2kydm1DTkRYSGdHMVc5R2pLN1VacnU3?=
 =?utf-8?B?TENkaDl4ZU02dGhZNURhdW1tY3R0eHhnNTRqSVpzSDlodEd0RHJLOUQzYmIw?=
 =?utf-8?B?anRyRGZ4YXR0ZFc3NFVWajlCMlpQWTdkTzJVd2tZZnVhcDVJOWpjQTR0SURn?=
 =?utf-8?B?dmIrU2JESW4yTzRXRlBlM01oZXZEMTA5dnNaZHRQUHdwRFhYaVNSajdsZU1T?=
 =?utf-8?B?bEU4SDRsV3daeGl4Yi9TMXFQQ3lzL2JVa1pkald1TGhqWXpjTDFaWWlHWlFE?=
 =?utf-8?B?WWkwS0lJZitnVmJBY1ovcUR3MXNzNWhyMktBbmVPWThwZGxvbHBjVHBaYzUx?=
 =?utf-8?Q?LmYQ1xN64/ezT8sw=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0334bdad-d236-4145-0c6a-08da32d932af
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 23:02:46.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXzFBdY7nkyMW5qvQ7mT+lSKHA69QHYstelLR8bFofBcngUFlnXc6iXiluiYppE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2920
X-Proofpoint-ORIG-GUID: LjifgQqwaNoRIumRREKrrC4hl_3oV7Iq
X-Proofpoint-GUID: LjifgQqwaNoRIumRREKrrC4hl_3oV7Iq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/10/22 3:40 PM, Yonghong Song wrote:
> 
> 
> On 5/9/22 4:25 PM, Andrii Nakryiko wrote:
>> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> Add BTF_KIND_ENUM64 support. Deprecated btf__add_enum() and
>>> btf__add_enum_value() and introduced the following new APIs
>>>    btf__add_enum32()
>>>    btf__add_enum32_value()
>>>    btf__add_enum64()
>>>    btf__add_enum64_value()
>>> due to new kind and introduction of kflag.
>>>
>>> To support old kernel with enum64, the sanitization is
>>> added to replace BTF_KIND_ENUM64 with a bunch of
>>> pointer-to-void types.
>>>
>>> The enum64 value relocation is also supported. The enum64
>>> forward resolution, with enum type as forward declaration
>>> and enum64 as the actual definition, is also supported.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
>>>   tools/lib/bpf/btf.h                           |  21 ++
>>>   tools/lib/bpf/btf_dump.c                      |  94 ++++++--
>>>   tools/lib/bpf/libbpf.c                        |  64 ++++-
>>>   tools/lib/bpf/libbpf.map                      |   4 +
>>>   tools/lib/bpf/libbpf_internal.h               |   2 +
>>>   tools/lib/bpf/linker.c                        |   2 +
>>>   tools/lib/bpf/relo_core.c                     |  93 ++++---
>>>   .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
>>>   .../selftests/bpf/prog_tests/btf_write.c      |   6 +-
>>>   10 files changed, 450 insertions(+), 72 deletions(-)
>>>
>>
[...]
>>
>>
>>> +       t->size = tsize;
>>> +
>>> +       return btf_commit_type(btf, sz);
>>> +}
>>> +
>>> +/*
>>> + * Append new BTF_KIND_ENUM type with:
>>> + *   - *name* - name of the enum, can be NULL or empty for anonymous 
>>> enums;
>>> + *   - *is_unsigned* - whether the enum values are unsigned or not;
>>> + *
>>> + * Enum initially has no enum values in it (and corresponds to enum 
>>> forward
>>> + * declaration). Enumerator values can be added by 
>>> btf__add_enum64_value()
>>> + * immediately after btf__add_enum() succeeds.
>>> + *
>>> + * Returns:
>>> + *   - >0, type ID of newly added BTF type;
>>> + *   - <0, on error.
>>> + */
>>> +int btf__add_enum32(struct btf *btf, const char *name, bool 
>>> is_unsigned)
>>
>> given it's still BTF_KIND_ENUM in UAPI, let's keep 32-bit ones as just
>> btf__add_enum()/btf__add_enum_value() and not deprecate anything.
>> ENUM64 can be thought about as more of a special case, so I think it's
>> ok.
> 
> The current btf__add_enum api:
> LIBBPF_API int btf__add_enum(struct btf *btf, const char *name, __u32 
> bytes_sz);
> 
> The issue is it doesn't have signedness parameter. if the user input
> is
>     enum { A = -1, B = 0, C = 1 };
> the actual printout btf format will be
>     enum { A 4294967295, B = 0, C = 1}
> does not match the original source.

I think I found a way to keep the current btf__add_enum() API.
Initially, the signedness will be unsigned. But during
btf__add_enum_value() api calls, if any negative value
is found, the signedness will change to signed. I think
this should work.

> 
>>
>>> +{
>>> +       return btf_add_enum_common(btf, name, is_unsigned, 
>>> BTF_KIND_ENUM, 4);
>>> +}
>>> +
>>
>> [...]
>>
[...]
