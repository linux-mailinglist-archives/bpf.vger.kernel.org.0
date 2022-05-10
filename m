Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657CF52270B
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiEJWnv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiEJWnu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:43:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B515BAD6
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:43:49 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24AJEHo5007878;
        Tue, 10 May 2022 15:43:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+UKAovTxKILr1lXspnSl4DpTg8IGocWqps1mmzjChYE=;
 b=L4ewJsqdM41uHMS4jYaJYoOZA/KVVNlnOVTXQqfYVmcpwNhO8F/86ubxIwUG0rJET+s6
 ul8RnwcYSPWN4LEVPlU8oNDZy1GJgk9wXPKAZXNcKzoslqf2i5LzlraQ1uDaEMGDnpLn
 FpZtf8OpnkWdyW8Qvb1a8i2BjmuM80r5t8Q= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fyx1h1dhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTCZiurqcZv5q9E+56XJDTDgZMwBYiUHuZ/KW7Z8Lms5EHcAle6HOuE8aX/glC9ES0yAoFQ207LDGMEs1ku5EBqZyHjrLO45cHP5uMnePG3cbGK3HS89Gs3CN5zJPqFAZr0h5amHpoQ3/DNSxxcXF8Kkr37GaB8D/578G3ehL7ueCvm8PY5B9px9rODeXrZSKWKzr313jPtjg4859kb6xMHK+M0CLf7ar4962WlktWz7wUhpCeXFCGgKvcDPeG6lycps2+ewSqTmK+8yTiwEOCng+Remm6ZifKZ82xBZ1IMw+uM3UPhfwoErYfz4WFYpWCw0HJg6rOa6aCMhjtrUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UKAovTxKILr1lXspnSl4DpTg8IGocWqps1mmzjChYE=;
 b=bttUitrSCx/Oi4ieotedCrLODwSiIhGzSUpRXC9xMbmhW2dGvYc9UiCwUr1VX0uSAlZenuI9CMgW1d5/VDfAYQADJaOJpjt5TcM/WyPMWeD7Dzarg3G9nYm2MWlBuchN5YXajh7J4nGNK0HPYL1KrL8eU7lb0jw9VFGpUs7dOe062ViO8CapNV/GUDVhcOjL72x8tcTe6yVwkb8DUGn1QRvrGU4zc/14ZUquAfellC9iyWP+mtpBw3ZSaNf0rzezZQXe5EvMTYbIKB7ePUKD/PybOER1GNgu/8anDa3B2ARbhPG2CiVnBNNyhpwzJXpZechU//f/UzCF9OLJSvVUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2336.namprd15.prod.outlook.com (2603:10b6:805:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:43:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 22:43:33 +0000
Message-ID: <a4f05ee9-f192-c3b5-6961-0db80755d5fd@fb.com>
Date:   Tue, 10 May 2022 15:43:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 05/12] bpftool: Add btf enum64 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190028.2579037-1-yhs@fb.com>
 <CAEf4BzY51u6GW7Sj8vNBsvcu7Gt1h13v8bWz=qb2p6vsGcaqEQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzY51u6GW7Sj8vNBsvcu7Gt1h13v8bWz=qb2p6vsGcaqEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8920d9d0-d541-47f9-a1b9-08da32d6833e
X-MS-TrafficTypeDiagnostic: SN6PR15MB2336:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB23365037EF9A4D036B96EFDDD3C99@SN6PR15MB2336.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HY6zzyuF+8u21VqGjKuiVd87oboh/DJm2CssQONrbi1E8iZsUM5aCBYLY4JdMZYpetAX2/2mp7ha0FX+P65HzFVTXZTKcf8FQTEJrD8mqApPG7Bqq00buzH0HYn5NDofchWJcql0Y/GaiyQWq9IgD9OJTOM7Wq6TspohG731UobzBCTK5Q6rjjdbNNkuPCJHn77BdB1d8q9YN0xDgHLr7rszfYdtGQCEA9doKxQiA+yCD5MSAufG5HoAukUIEO6ezY5+E7/mrpNz/eY5lGIx468YMWMqtvhC610iq8Qo1Inl4n2O5Ae3hBx7WegjlYroY8Ujad5DWAI/fc2sykLTSyHxGmIha+g8ERRbEJsHplGdh9V6+TJA/Wo4dB2t4uMYWipzVIsnYZ8qmp55kcAMxnI3/99UEZ9VOnNC9cVBQ+V6G1N+VeR2UbDOUI6m7JQFae81aOOz8A5zp3hSwGpeKmSl2MhrkbJZuog8U0JcBLGJaTQVDUYZTqF8Gm8A7ZBou35vujgqeFsj3010YXx0wEueCC27FXHP0Sdiu7SFP3pZBcwrtzVMgdRjqLi279uTd43oD/JZNet0g/0Ma4LEbjprw0vnJchwilefUhVRpypcP/6OwoCytSwaRdVtYFQ/aQUVVon40QAn+G4alNq0yiYZmjnYivSmhTd7lRlgepLHkbQGND9wvrBXYHkxl2Z9cGDcnJ+DXenfD/++brH4MOFR26zKLiaBhkeClMd0f4xeNL6eMIgA06iEaxUCVgeS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(66946007)(66556008)(31696002)(8936002)(66476007)(6916009)(54906003)(2616005)(38100700002)(8676002)(4326008)(6486002)(53546011)(6512007)(6506007)(52116002)(508600001)(2906002)(36756003)(31686004)(83380400001)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElmaytIcVVSYVNyakdEN2R5bzRZTDZrbGVDdzJGYURGSVR4OU9KanZTc2x2?=
 =?utf-8?B?UnVROGFEQzRtRmFTejdiT1o0M2t3dUdMdmpCcnYwelZyM0hnWnkwQ2pUb2wy?=
 =?utf-8?B?Vi9qUFUrR21TSVBHSGRHTGZpRklIVkVMU0dPQStlcjNaRGdQRTZmeEN1TDNW?=
 =?utf-8?B?WE4zVVM5OStUbklsdEtyb0Nxd0Q2Y3RvY2RiUEdjT0JDc0FOVkRpQUFMaFl1?=
 =?utf-8?B?K3VXQ0c0SGJWVmxra2hIYWh3T3hXTUVhYm5CY2ZuV2o3TnhwcGdWbGU5V1la?=
 =?utf-8?B?dWNrN2FRbVFNR25mbnF5aG5GeTVkWXFPODRmNm9ITytZT0NiV3BMeEc1Qi9T?=
 =?utf-8?B?eVdpV1B5VVdVbFBaQkQ1T2pZZmdKaXNkRHRXcVlpamJ5eWVaVHd0UnArc0M5?=
 =?utf-8?B?VXpjdjQ3aVptaWRpVjdMdDNZb0JMTVpjV2Q2R2RIbldGcklsZkE0QldNRUNW?=
 =?utf-8?B?c1JHWlAwdmowYWw5NjRtckpqVGRDR1NpcUFaODh6ampoVXMrTkNYcXFKSzVQ?=
 =?utf-8?B?UzR4MUVQOE9WVXQ2c1RCeEc1cjFjMzVDZk02b1Z3aFAzVHhTbmt6WHBxTk1k?=
 =?utf-8?B?V3VIVTBVNmVEM0ZlejR1OTVCRU5mbzlsQUYxMDFmYVRDL3d4cERxYndIY1dQ?=
 =?utf-8?B?YVVTalFlVmFSZWVxZUkxY3prOUNQaURvNzhCdWt6K1dtdmxRdU4xSXpzWVcv?=
 =?utf-8?B?ZTJGVFpKK1VqMnNLeGtWKy9TUjhlVGZzMzRqTlp5aVFXa3JzNnowUmFibnpr?=
 =?utf-8?B?MGFOT0p2V0Jud1pxNUZTQUNhWmN4L0MyZVVBUzlXZWNHaGxUV0U2YlAwaGRL?=
 =?utf-8?B?MTMvSU9wc2UrTkt5QUUvUWtCTDhzMTFtcitPb2U4aVRJNEpINTdvZ0w1T1g4?=
 =?utf-8?B?VEYwQkxJMFZkYjJWZk1RbXU5VmlPQnBPOUZTYVNkYWVHUzBobFVIV2N1cElk?=
 =?utf-8?B?VGxGb3JxZUUzZ0pYcFBZeElwdWxRVGI2VXNvUk13L1c0UTBnRjhVWThUVnpl?=
 =?utf-8?B?Z2pDbGRSakJPSWNkT3R4blgxM20zLzlZUnRMWkQ1KzhKeGpjenJ2MFF0M2ZO?=
 =?utf-8?B?cTZDZVNvaFVRdy9UY2hPV3R1WVRqRzdnQ0l5cXFJSk1rSkxzWGNmdFduS1Yy?=
 =?utf-8?B?M2hGRnNxODlmTVBHVnJ4Mm5LejlNTG9zRE1KR3JIK0l3VzR3aDRIcDlLOGsy?=
 =?utf-8?B?MUYrY1V6UFNNWC9DK1V6ZUNDdWFpK0Zwa1p4U01zMW56Y0tzYVF2eWZZVjg4?=
 =?utf-8?B?eU1BM1BiRG5iQjd1bzZ3UjFGb2Q3ZUdYTTMraHdOeEpjTUN1d09aNVRYdnBP?=
 =?utf-8?B?bUZURzZqOUZLMFc3RzlIcnlIV1JZWnZIemVuUmRRQlp4VHYzdThSZ3VuTVM5?=
 =?utf-8?B?K3RJY0cycUZlKzU5bnhDZTdzdC9sS2QwQ2UzYjB6OTVTR1lIb0I5Qnc5THl1?=
 =?utf-8?B?bUEwK0ZJcDlsY0E3VFlONnczQnBKRG9UTyt4K3dRVldPa3hGUlpiM0NNajlO?=
 =?utf-8?B?cmwyUElOVFp2QVBqZzgrTnFIRFI2SEpJS2dkOUlwdkx5dnd5SEV1RlhDL0lU?=
 =?utf-8?B?T245SUR4QktWR3JSbVVVOFlFUmE5TWV1QVBUdlMwaXpwYlk4L3IyVXpsQWdY?=
 =?utf-8?B?ZWVWU0lndUR4bkQ5TUJiQjlXY0dPSzJXdWJSNXloL3ZTR1NqRlY4MzR0MlF4?=
 =?utf-8?B?SFZ2VjZTY3Zlb3NjeWRLS1k3SW5kZjhwc05qWFI5b2pUNE5lMlhhaFlZOVpn?=
 =?utf-8?B?NWppbDg5dXo2WnM3Qk12Wm1BNTArbmxxK29va0tMZkpDUlo4dndPT1pvekxO?=
 =?utf-8?B?TjhhQUJUY1hxOWFKSjBycTNPeVB3OGUxRlM0OW1pQkZFaGcxS0I1T25JQUUy?=
 =?utf-8?B?ZENsZllXNXgrWi8wbEZQMitRZTE2bkhycEFYUEwxWThRSStjR01Fc3ZmOWxo?=
 =?utf-8?B?ZjI3eU5FNVlPTlk1QmZRSnVGRkZ1SU12QVllSHRDS0syeTcrbE5ZK3hnS2dS?=
 =?utf-8?B?VHI4S2lRRlN5cHcxWjJ1YStpNmloVldSTUJDekxWUGFmWTBjT1hKbWFCVGJI?=
 =?utf-8?B?S2lyNDFpT3lDSUg1Vmg4cG1IdDBWSjd0bXROekxsRTVwNFErSkkxK0JOL3NR?=
 =?utf-8?B?QzNKVERsbjhzS0FoeGo5TE1DSTl6MVV0dllqckwzYW9tVEQrZU9OSzlHTGRR?=
 =?utf-8?B?cFNjZWVaRlRHeUJJUDJkaGhqWEZDNkdTeEJEMGxaNmNsb1BaM1h1dnkwaFVi?=
 =?utf-8?B?b2p5Mm1tUWI2UEdxTmlvLzJSV1UxN3VxL05QbDhwSStucGZGd3dRejd3SnEz?=
 =?utf-8?B?c28rM2J4Y1lzZUd4QWNkT0laUzFrYTQ3aERLNy8vY0NYU1BWeFNxQlVTejBl?=
 =?utf-8?Q?4aQLP4VbtyuJuhbI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8920d9d0-d541-47f9-a1b9-08da32d6833e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:43:33.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBd063Umj2Zzbnro+m434gK1CLlcrjJFOYH/jMfh2o8P4FpD2z+op3LLfRjD1YkY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2336
X-Proofpoint-GUID: LoHa0WcU8OGMXneCTldId7J-TaoTzOW3
X-Proofpoint-ORIG-GUID: LoHa0WcU8OGMXneCTldId7J-TaoTzOW3
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



On 5/9/22 4:31 PM, Andrii Nakryiko wrote:
> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add BTF_KIND_ENUM64 support.
>> For example, the following enum is defined in uapi bpf.h.
>>    $ cat core.c
>>    enum A {
>>          BPF_F_INDEX_MASK                = 0xffffffffULL,
>>          BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>>          BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>>    } g;
>> Compiled with
>>    clang -target bpf -O2 -g -c core.c
>> Using bpftool to dump types and generate format C file:
>>    $ bpftool btf dump file core.o
>>    ...
>>    [1] ENUM64 'A' size=8 vlen=3
>>          'BPF_F_INDEX_MASK' val=4294967295ULL
>>          'BPF_F_CURRENT_CPU' val=4294967295ULL
>>          'BPF_F_CTXLEN_MASK' val=4503595332403200ULL
>>    $ bpftool btf dump file core.o format c
>>    ...
>>    enum A {
>>          BPF_F_INDEX_MASK = 4294967295ULL,
>>          BPF_F_CURRENT_CPU = 4294967295ULL,
>>          BPF_F_CTXLEN_MASK = 4503595332403200ULL,
> 
> maybe we should have some heuristic that if the value is "big enough"
> (e.g., larger than 1-128 millions) and is unsigned we should emit it
> as hex?

I thought about this. But since you are also suggesting this, I will
do this (greater than 1 million).

> 
>>    };
>>    ...
>>
>> The 64bit value is represented properly in BTF and C dump.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> just minor nits, LGTM
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>   tools/bpf/bpftool/btf.c        | 47 ++++++++++++++++++++++++++++++++--
>>   tools/bpf/bpftool/btf_dumper.c | 32 +++++++++++++++++++++++
>>   tools/bpf/bpftool/gen.c        |  1 +
>>   3 files changed, 78 insertions(+), 2 deletions(-)
>>
> 
> [...]
>> +       case BTF_KIND_ENUM64: {
>> +               const struct btf_enum64 *v = (const void *)(t + 1);
> 
> can use btf_enum64() helper from libbpf?
> 
>> +               __u16 vlen = BTF_INFO_VLEN(t->info);
> 
> btf_vlen(t)

I copied the code from above BTF_KIND_ENUM. But I certainly can do this.

> 
>> +               int i;
>> +
>> +               if (json_output) {
>> +                       jsonw_uint_field(w, "size", t->size);
>> +                       jsonw_uint_field(w, "vlen", vlen);
>> +                       jsonw_name(w, "values");
>> +                       jsonw_start_array(w);
>> +               } else {
>> +                       printf(" size=%u vlen=%u", t->size, vlen);
>> +               }
>> +               for (i = 0; i < vlen; i++, v++) {
>> +                       const char *name = btf_str(btf, v->name_off);
>> +                       __u64 val = (__u64)v->hi32 << 32 | v->lo32;
> 
> () ?

okay.

> 
>> +
>> +                       if (json_output) {
>> +                               jsonw_start_object(w);
>> +                               jsonw_string_field(w, "name", name);
>> +                               if (btf_kflag(t))
>> +                                       jsonw_uint_field(w, "val", val);
>> +                               else
>> +                                       jsonw_int_field(w, "val", val);
>> +                               jsonw_end_object(w);
>> +                       } else {
>> +                               if (btf_kflag(t))
>> +                                       printf("\n\t'%s' val=%lluULL", name, val);
>> +                               else
>> +                                       printf("\n\t'%s' val=%lldLL", name, val);
>>                          }
>>                  }
>>                  if (json_output)
>> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
>> index f5dddf8ef404..f9f38384b9a6 100644
>> --- a/tools/bpf/bpftool/btf_dumper.c
>> +++ b/tools/bpf/bpftool/btf_dumper.c
>> @@ -182,6 +182,35 @@ static int btf_dumper_enum(const struct btf_dumper *d,
>>          return 0;
>>   }
>>
>> +static int btf_dumper_enum64(const struct btf_dumper *d,
>> +                            const struct btf_type *t,
>> +                            const void *data)
>> +{
>> +       const struct btf_enum64 *enums = btf_enum64(t);
>> +       __u32 hi32, lo32;
>> +       __u64 value;
>> +       __u16 i;
>> +
>> +       if (t->size != 8)
>> +               return -EINVAL;
> 
> no need

sure.

> 
>> +
>> +       value = *(__u64 *)data;
>> +       hi32 = value >> 32;
>> +       lo32 = (__u32)value;
>> +
> 
> [...]
