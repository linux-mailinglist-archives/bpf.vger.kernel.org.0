Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39D459A84
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 04:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhKWDgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 22:36:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229678AbhKWDgJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 22:36:09 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN2uKqI024288;
        Mon, 22 Nov 2021 19:32:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=O9V7KpvRxu8fn2OzBiaWGTqoMyaOstCOZidsd8RLPRQ=;
 b=KwpqHe67CU8KfPMoVlyGUJR0+x0KIgYrKJLZThW9DOEn8q+oFQ5Y5H1Uox8W49eEMqKb
 haNl77ctm8z8XEczz2wvYIxIN/c2jMIxUrTzJkVJN7PF21HBw1sfPOofp+TUqPEnxnkr
 ze67LRX6U1tnuSq2IxcU2aBUf5lhKV5ZCcI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgqxpr4kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 19:32:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 19:32:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ2QR5PKdU3cJgfznSgrC8jFoCQh+nNO51XC+fxh1aQyH3U4FI7jPAj0vglebZiqFELohyXfWqn6JUsCTD4RqQ7qHWcrFOIn4DqVAxFTB60NkZ7e4Gip+8A26BcFAvBKT2uJsoWVrbnDx1rPEQbLAwR3+fYrM9r7x2PomMKGO22iHESXIqquN1e7Z3U3buKNz4UPBNRAaz3dSyOwsvtZEWkuLhtL/FaYz2gooWUOfAMuYB3D1Ia5tB1dx58zl/S+fj/0ZgC3M4CA8ox/vsK1JaqyuqW9fMoHospsnCNg41Fr+KZp267HvtFuNqHPZ+HqDRpnKW5joXZGt3ujkIj8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9f1kyDGZpDM51Ho+J9fRg/myXJfEZu040aATVjYvNg=;
 b=nlpK9PEin9vfNDh7XDGoDeghiuSYB9z2YdUluQ7T6ckIvfdnFcHjQsEMVBguffMDVCYFPpRO22IO2D1cZqNw/LQJ73zrxYLOYrItxfQEWCznkduOUjBCD8OxHEmsMwx1aHJXcQ6OWBc/TW10KJlo/MN+VJtiOmSLjU8/mIfhkV+Opo5jqQZuh8th/qPAG6352F5aM7aWDK7D+Dkrs+o2BjnF/UMdufrxBsLkyZyoe4PZUz4J689nLI2+jYyNx8WWbOM+Q2Hj7EgFHlP8IvVqgHP5zMX9/gVNSUk0EvecGkSWEUOxC0ZMRJ80ZsoJ1eLZH4tpanAeO5lVZa4734JRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4901.namprd15.prod.outlook.com (2603:10b6:806:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 03:32:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 03:32:39 +0000
Message-ID: <139df0c0-4379-b6ef-00fc-140adac17da5@fb.com>
Date:   Mon, 22 Nov 2021 19:32:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH dwarves 3/4] dwarf_loader: support btf_type_tag attribute
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20211117202214.3268824-1-yhs@fb.com>
 <20211117202229.3270304-1-yhs@fb.com>
 <CAEf4Bzbcx0ExE+TsOL4G+56KZ3dLs5vJV_y1=9_Cpt=4Y=c5uA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4Bzbcx0ExE+TsOL4G+56KZ3dLs5vJV_y1=9_Cpt=4Y=c5uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR22CA0068.namprd22.prod.outlook.com
 (2603:10b6:300:12a::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21e1::14f6] (2620:10d:c090:400::5:b4f1) by MWHPR22CA0068.namprd22.prod.outlook.com (2603:10b6:300:12a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 03:32:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6ddba9d-24cb-4839-d122-08d9ae31e6b5
X-MS-TrafficTypeDiagnostic: SA1PR15MB4901:
X-Microsoft-Antispam-PRVS: <SA1PR15MB49012E2DB00A981D8850EC0FD3609@SA1PR15MB4901.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOlxUu7fsZYtQv0o+sSqeuD+z4+rGKdrMes4RBe0KT2Tm8rOamwHzprgi99N0T0RSJf+6oE41k25Qf04sip0raeALgurDxDM2zICRVVrKIxSKEKaUNHqihwwE00B+nJxxFoZLzdllADVGQhrhQ/OAyqV0kZtdOcMWeafvODJvZMA/I1bnbTac7ZDOG9o7wZ21Ua7DtBn2WuPqWl176OqBZQCKTUZJM1dlL7VP5PFZsfWFERCL5pUlTGkwY9IQuyUzXORD1ayBEooyBz/PH4qT30VrLTZClXcZCCpLMFuXn4Gn+a9l0tKGDrFurEo91ny8We+synZdudsSFTlq3K8mA8Ps4UbdFHHgsmtoZARafBqmjXK9ICQw1auOmjWQpUlSFGBh+MVCH6FVKc7ToJbl4YrjKToutvb7E0yYMDTBBwWyLBfPzIwjr+NeQWRJIBABX9VFK1vTE2Ip5HJSVSqZyp/i8LE6l/fSJnNLmtPm5CFd8EaQpxSTqKLm0QslERpQYzYPTDU1rX9g5C1v0NtRqc4XNVPawdGaJi/deG7JTro09391+4GAMkclGlc72KXsTS0/Td9OjaKIyFG/Qwcl08OL/iaXiYzOGoSgwtxfp0gG0Z+6Tq9EncFqTw4TvJJow3nqBH4H75FCDRR0aYRQcPOf3TSnEinqiKf+lLhwvJLCBRcS1DOiFeSINJIspmDyUQWBRvfJutREIPNBkU2AB2/lYGnVgf26sNDr/tE1mjMB1p2XwVraFRE13YdvaODmpr3wdc+VY2unYE2/HhVd3CNZdvOA/PlrrrGg/sYMs4ffPZbgyNjoiKSeXpE5navmn/zkVZKLts8Jqo7EM403OEnTzuAuIm0WZFVubhL0+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(316002)(54906003)(53546011)(508600001)(31696002)(52116002)(966005)(186003)(6486002)(5660300002)(6916009)(2616005)(8936002)(31686004)(36756003)(66556008)(8676002)(66946007)(66476007)(38100700002)(2906002)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZlUStQYkE0ZlFoL2h3MmJYQ0ZmSzl6cW8rcDZMOEpRUzJUOW1OWnUvMGlu?=
 =?utf-8?B?bXlGY25VSUdaZlFzU1BnYXBZTit0aDdiK1VGbC8zVU5JeFZXUjhvRVhBU1JQ?=
 =?utf-8?B?c2JLcnozZGhtZ3A0bmVBSXltWTVxbE4vaWpuYmxUWTBiTnEyaUZJbVBwMXRL?=
 =?utf-8?B?WTBmRU03bXp3SU5pZXR3MStINERnanl5Z2FNU1VsdUZ4L3hxQTFCYi83d2pV?=
 =?utf-8?B?VlJkQ3BUNzFFZ3lxU2x1eVQ2SlJZWTdkU1BiT3RScm5OejE5b0lkRkRLSnhU?=
 =?utf-8?B?K20zQUtsV0xXbDBYQStibjN5L3ZmRW9pZk85WGh1djZlOXNnT3ZUdTRIS3A1?=
 =?utf-8?B?NmdRMFVaVURYczFiV3o0Y3BaQTRNbUlhUXVoYlJlWENFVjc3Z25uM0doeXcw?=
 =?utf-8?B?bXl5NnNINWZXVENxZXV1bmtLZ05ueFUxdVpnMDUyeFJHZVF2dnhubXFjaXlL?=
 =?utf-8?B?bU4xeTRveEhuYXRaejBoNjZleEt0WUhCOGhXOTl2WUR6Skoza08yaWtzdU5w?=
 =?utf-8?B?MzJpKzVCV3RTY2FEZWF5eGxaelBsaVRqMTJ4S3FkbEc0bFlLTmdBZUdDbUZa?=
 =?utf-8?B?VEpjNlllNU5handvMXJpRnlxbG1ZdURCYXRiS2NRSytCS3IvOWRBOW1KeDBv?=
 =?utf-8?B?QUdzZklaSFdhb01pZHkwWHZaY3F1WnRRM2xHMDF2c0NjVkhITDZ6L1FuTkJT?=
 =?utf-8?B?c3B5TjgwM29Fb0VuOVVOSVJ2d29sck1URURuTU5HTzUwNTVXSW9xQ295QXho?=
 =?utf-8?B?WGJhL0VDSlJ5ZVFZdmtpcmRCeGt6ekZvYUVEOUI5aXhIUVg4K0JuNEFaU2J2?=
 =?utf-8?B?K2J4cG9UZVVGK1p4NFlDRWljSmFaalowRGxkdE1sS0FrYktPQ1JqV3N4VmRx?=
 =?utf-8?B?WCtHb28ycno4SHNSTFBuM05CbEkrRldhYTAvVlRSRjU4ZFI2UVJnRzFLenBv?=
 =?utf-8?B?NHJwbXFXY0ZuQmI5cnM3QVJJeWlTZkdXdnhSWUQxYzhwOE9rbklTU004ZDJp?=
 =?utf-8?B?Z2xqSmRKWU44UFl5b1VaY3NTT05ZbXhUUXd5d1dhN2pVQjZ4Uzk3ZmlETC9r?=
 =?utf-8?B?cDhNT3QvWUc0OHk0OGdZZitZOTFaQU91T2xiaUkwOGE2SEU5OXZONStyQkNE?=
 =?utf-8?B?WDNhRWRhSnhpa0phdFNJbEJzY21RSTcwMm9HSklVb3NDUFh2RzBKK08wZ3Vw?=
 =?utf-8?B?VTU5NXhhZzJLdUQzM0ZJRk5rSUtkdy9oV2dpOEtxWStuZkdGQ2kzNEpZSXFD?=
 =?utf-8?B?cU5nNjl6NTV6Ui9RUnhLWEFQajZBSGpOMTZVZFYxUS8vcTB2cWNSVG5wWUxs?=
 =?utf-8?B?czJMVlh1WUs0aHh4UWVLQ2hIZWphdGNPSjRycEZ1ZVdCUGNTQkFwS20wejgz?=
 =?utf-8?B?WGNSaVJraFJzUS8wTmkrMGRtVUFNWnV4WlZDWkFxc0J2K3BOelUxZk1vT3Vs?=
 =?utf-8?B?SmNuck9UdWhwVEVsdHRzYnY1SDNXNTk2bkloQ1RTbFEzQmswYTlPQTlHSTVH?=
 =?utf-8?B?K0g0RTVZcGNyRUNla2NncGd0dlN3aFd5QUJsMTV1SVoxZ0NvUm9zMFJOdzlB?=
 =?utf-8?B?TGRKcnMxSFF0YTdjc2pCRzFIVlZJbUNFc0p2UUpiYWlzeE1DVlI1dkNtR1J1?=
 =?utf-8?B?Mlk2TnVURkxTWVBFUUtKOFd5by9pa3RKZ0VVbHhNTDNFMDNZNzBrN0FGMS9r?=
 =?utf-8?B?a1lWNVp0NU5VaEdrL2tnOXJZVm1aVnRuQ2UwSzBYYm1meUJYdUc4eXJmVVNJ?=
 =?utf-8?B?SS91UU1LY2lTYVJJM3BoZGV0VVNUZlpEcTZ1b0NHWG9qeUJPbGVxYTRyblJr?=
 =?utf-8?B?M0NHNEU1NnNVbVNRcmJSUDdtbE1GYmYrTndseGtZekFUWTVZUEZqZ1Vpek12?=
 =?utf-8?B?MTRKbTIyblJna00wTUJXNFQ5N1JyVzkweDNsSVRkL3hWMUtLakQ0aUdHVTM3?=
 =?utf-8?B?bFN4dmJEejdIVEcrSWRqVVhtU1BueGRaK2ZBVEJCbUhXWTNrVlJpa3JDdmly?=
 =?utf-8?B?RVVNRTRRWG1iMXFlQ0ZOYmNXUE8wT0hweGYyQkVIZVpmQUJRc2ZpdWdzeTlx?=
 =?utf-8?B?bGlQS2xJRk9NbWRpOFR3WVl5dmNBWTROSnZ5OG9UY2V3NE5WeEFzN0Fjbllm?=
 =?utf-8?Q?JMuh3w/ygWnmZd4uM7Pw5nDMW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ddba9d-24cb-4839-d122-08d9ae31e6b5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 03:32:39.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oucd3omtUqaFqu2OHEnjnoIumcQldIeihRbahhU6ehPWWlPiGTVAt4gygG/kPBlS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4901
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: -gj16CvePOQoUkArbUfhszoEg4J7rSjL
X-Proofpoint-ORIG-GUID: -gj16CvePOQoUkArbUfhszoEg4J7rSjL
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111230015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/21 5:52 PM, Andrii Nakryiko wrote:
> On Wed, Nov 17, 2021 at 12:25 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
>> added support for btf_type_tag attributes. The following is
>> an example:
>>    [$ ~] cat t.c
>>    #define __tag1 __attribute__((btf_type_tag("tag1")))
>>    #define __tag2 __attribute__((btf_type_tag("tag2")))
>>    int __tag1 * __tag1 __tag2 *g __attribute__((section(".data..percpu")));
>>    [$ ~] clang -O2 -g -c t.c
>>    [$ ~] llvm-dwarfdump --debug-info t.o
>>    t.o:    file format elf64-x86-64
>>    ...
>>    0x0000001e:   DW_TAG_variable
>>                    DW_AT_name      ("g")
>>                    DW_AT_type      (0x00000033 "int **")
>>                    DW_AT_external  (true)
>>                    DW_AT_decl_file ("/home/yhs/t.c")
>>                    DW_AT_decl_line (3)
>>                    DW_AT_location  (DW_OP_addr 0x0)
>>    0x00000033:   DW_TAG_pointer_type
>>                    DW_AT_type      (0x0000004b "int *")
>>    0x00000038:     DW_TAG_LLVM_annotation
>>                      DW_AT_name    ("btf_type_tag")
>>                      DW_AT_const_value     ("tag1")
>>    0x00000041:     DW_TAG_LLVM_annotation
>>                      DW_AT_name    ("btf_type_tag")
>>                      DW_AT_const_value     ("tag2")
>>    0x0000004a:     NULL
>>    0x0000004b:   DW_TAG_pointer_type
>>                    DW_AT_type      (0x0000005a "int")
>>    0x00000050:     DW_TAG_LLVM_annotation
>>                      DW_AT_name    ("btf_type_tag")
>>                      DW_AT_const_value     ("tag1")
>>    0x00000059:     NULL
>>    0x0000005a:   DW_TAG_base_type
>>                    DW_AT_name      ("int")
>>                    DW_AT_encoding  (DW_ATE_signed)
>>                    DW_AT_byte_size (0x04)
>>    0x00000061:   NULL
>>
>>  From the above example, you can see that DW_TAG_pointer_type
>> may contain one or more DW_TAG_LLVM_annotation btf_type_tag tags.
>> If DW_TAG_LLVM_annotation tags are present inside
>> DW_TAG_pointer_type, for BTF encoding, pahole will need
>> to follow [3] to generate a type chain like
>>    var -> ptr -> tag2 -> tag1 -> ptr -> tag1 -> int
>>
>> This patch implemented dwarf_loader support. If a pointer type
>> contains DW_TAG_LLVM_annotation tags, a new type
>> btf_type_tag_ptr_type will be created which will store
>> the pointer tag itself and all DW_TAG_LLVM_annotation tags.
>> During recoding stage, the type chain will be formed properly
>> based on the above example.
>>
>> An option "--skip_encoding_btf_type_tag" is added to disable
>> this new functionality.
>>
>>    [1] https://reviews.llvm.org/D111199
>>    [2] https://reviews.llvm.org/D113222
>>    [3] https://reviews.llvm.org/D113496
>> ---
>>   dwarf_loader.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   dwarves.h      |  33 +++++++++++++-
>>   pahole.c       |   8 ++++
>>   3 files changed, 153 insertions(+), 4 deletions(-)
>>
> 
> [...]
> 
>> +
>> +static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>> +                                              struct conf_load *conf)
>> +{
>> +       struct btf_type_tag_ptr_type *tag = NULL;
>> +       struct btf_type_tag_type *annot;
>> +       Dwarf_Die *cdie, child;
>> +       const char *name;
>> +       uint32_t id;
>> +
>> +       /* If no child tags or skipping btf_type_tag encoding, just create a new tag
>> +        * and return
>> +        */
>> +       if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
>> +           conf->skip_encoding_btf_type_tag)
>> +               return tag__new(die, cu);
>> +
>> +       /* Otherwise, check DW_TAG_LLVM_annotation child tags */
>> +       cdie = &child;
>> +       do {
>> +               if (dwarf_tag(cdie) == DW_TAG_LLVM_annotation) {
> 
> nit: inverting the condition and doing continue would reduce nestedness level

good point. Will send another revision.

> 
>> +                       /* Only check btf_type_tag annotations */
>> +                       name = attr_string(cdie, DW_AT_name, conf);
>> +                       if (strcmp(name, "btf_type_tag") != 0)
>> +                               continue;
>> +
>> +                       if (tag == NULL) {
>> +                               /* Create a btf_type_tag_ptr type. */
>> +                               tag = die__create_new_btf_type_tag_ptr_type(die, cu);
>> +                               if (!tag)
>> +                                       return NULL;
>> +                       }
>> +
>> +                       /* Create a btf_type_tag type for this annotation. */
>> +                       annot = die__create_new_btf_type_tag_type(cdie, cu, conf);
>> +                       if (annot == NULL)
>> +                               return NULL;
>> +
>> +                       if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
>> +                               return NULL;
>> +
>> +                       struct dwarf_tag *dtag = annot->tag.priv;
>> +                       dtag->small_id = id;
>> +                       cu__hash(cu, &annot->tag);
>> +
>> +                       /* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
>> +                        * the tag->tags contains tag3 -> tag2 -> tag1.
>> +                        */
>> +                       list_add(&annot->node, &tag->tags);
>> +               }
>> +       } while (dwarf_siblingof(cdie, cdie) == 0);
>> +
>> +       return tag ? &tag->tag : tag__new(die, cu);
>> +}
>> +
>>   static struct tag *die__create_new_ptr_to_member_type(Dwarf_Die *die,
>>                                                        struct cu *cu)
>>   {
>> @@ -1903,12 +1985,13 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>>          case DW_TAG_const_type:
>>          case DW_TAG_imported_declaration:
>>          case DW_TAG_imported_module:
>> -       case DW_TAG_pointer_type:
>>          case DW_TAG_reference_type:
>>          case DW_TAG_restrict_type:
>>          case DW_TAG_unspecified_type:
>>          case DW_TAG_volatile_type:
>>                  tag = die__create_new_tag(die, cu);             break;
>> +       case DW_TAG_pointer_type:
>> +               tag = die__create_new_pointer_tag(die, cu, conf);       break;
>>          case DW_TAG_ptr_to_member_type:
>>                  tag = die__create_new_ptr_to_member_type(die, cu); break;
>>          case DW_TAG_enumeration_type:
>> @@ -2192,6 +2275,26 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
>>          }
>>   }
>>
>> +static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
>> +                                             uint32_t pointee_type)
>> +{
>> +       struct btf_type_tag_type *annot;
>> +       struct dwarf_tag *annot_dtag;
>> +       struct tag *prev_tag;
>> +
>> +       /* If tag->tags contains tag3 -> tag2 -> tag1, the final type chain
>> +        * looks like:
>> +        *   pointer -> tag3 -> tag2 -> tag1 -> pointee
>> +        */
> 
> is the comment accurate or the final one should have looked like
> pointer -> tag1 -> tag2 -> tag3 -> pointee? Basically, trying to
> understand if the final BTF represents the source-level order of tags
> or not?

The comment is accurate. Given source like
    int tag1 tag2 tag3 *p;
the final type chain is
    p -> tag3 -> tag2 -> tag1 -> int

basically it means
    - '*' applies to "int tag1 tag2 tag3"
    - tag3 applies to "int tag1 tag2"
    - tag2 applies to "int tag1"
    - tag1 applies to "int"

This also makes final source code (format c) easier as
we can do
    emit for "tag3 -> tag2 -> tag1 -> int"
    emit '*'

For 'tag3 -> tag2 -> tag1 -> int":
    emit for "tag2 -> tag1 -> int"
    emit tag3

Eventually we can get the source code like
    int tag1 tag2 tag3 *p
and this matches the user/kernel code.

> 
>> +       prev_tag = &tag->tag;
>> +       list_for_each_entry(annot, &tag->tags, node) {
>> +               annot_dtag = annot->tag.priv;
>> +               prev_tag->type = annot_dtag->small_id;
>> +               prev_tag = &annot->tag;
>> +       }
>> +       prev_tag->type = pointee_type;
>> +}
>> +
> 
> [...]
> 
