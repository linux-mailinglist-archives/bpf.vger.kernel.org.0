Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF631222D
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 08:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGHLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 02:11:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48178 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhBGHLr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Feb 2021 02:11:47 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 117747s5031553;
        Sat, 6 Feb 2021 23:10:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BDbFBCri4JWHjYftAxtLlHXGBczz0XbPTg4NAuVtQwA=;
 b=UzpOcVYFhCMqd5WYlc1pL3LhpmLdia15BbIYrLmwBerzxNPe/PPrf2lV2EUmkv+UTStt
 ebuOMK1+Pz9fTPyGoV8SUKGso53PEk5+QvtgZ3ZWB5c6d7NyRk7+fjICVReuwi4QpVT/
 ZQcB00AyDxqJydQE0SvVtK17nimRafnwo14= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36hsgtapbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Feb 2021 23:10:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Feb 2021 23:10:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbuJDE/5lRR7i0KZ9nFnSrH1LyFxoAkZ2hRJxTYmSutC86NHWdrhw/HhMIG97nyKTK+C/XRJLkbs04LDk4r/jUfHk3a5dISafg//R0St3uD5ayCWZP96n6Ntc+vOxs/1ysDLZHKyOk84pWE5AmM6QY5AI4hHt7RJ6loiaiLkXMkN48ddvzjB3y/vt5mCfU7r3BzakBefGyWD2CFTFkZBT+0f29QaqB8JHAAgjjMkk5VKtSVFFZV7tUEhH5W9GMslo0TPI+QJxlLK1Wz7KLebKAmgqmLXUqcApDScBRdh/wpmPBBuY5lQgEgg5C5UvCj9Kb0a/kB78mT1uONu4hRj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDbFBCri4JWHjYftAxtLlHXGBczz0XbPTg4NAuVtQwA=;
 b=SkRmfMPmA+9wZXZuIzKSvNxnO4s+j0KU2/YseFANArktlSgLoSsycMO5SlgZbEFqaJvHCJLT63WtcmDK0u2L1+TWSoPjPwSrKMoj+wU+iLVcLu7DwuZkhDQfLlLlsp+/cgxSl3BuDIVutRAza05nggiqlztaa3IAA77z/EzUHRvNXDjRcWdxB+u+oWy1kcUXIqHk5H2uvKtw0/kDkfgdeYaH6YqDxcp3PMTDxXVtpMRbakoSaxH0hR81kSL8Qqdium91jH65TpE0Yr7cXE2tXCTr7GKR81VOf9++R1IQi+2yx6oYFTRNr3+bkNmlCKvR4x75C9cwFQHREXZil/3E1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDbFBCri4JWHjYftAxtLlHXGBczz0XbPTg4NAuVtQwA=;
 b=cN6VzM2xYCuCI4iB8JmchLEAo79+g+PQ5unRwa/GXcEdOx10Pud1z+CVcCzaBjrFOspmifu1HvNC2JY/E/k/IfB35KKqwLO7O9LuY0UXWNydkfaNFx9Z3hxZnWHTK4xhJzm5LpZdm8Gdp5BzGs2SyltWJ7Fwj7pQOOmJfwaGSBI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB4290.namprd15.prod.outlook.com (2603:10b6:a03:1f9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Sun, 7 Feb
 2021 07:10:55 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3825.030; Sun, 7 Feb 2021
 07:10:54 +0000
Subject: Re: [PATCH dwarves] btf_encoder: sanitize non-regular int base type
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wielaard <mark@klomp.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210206191350.830616-1-yhs@fb.com>
 <CAEf4Bzb-Rqz=+pJYaVNzr8jEEAHQ-ZForsfRpNo4e=t84BRWKg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d92ba9c6-5493-065e-e66e-ce8324f20f15@fb.com>
Date:   Sat, 6 Feb 2021 23:10:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CAEf4Bzb-Rqz=+pJYaVNzr8jEEAHQ-ZForsfRpNo4e=t84BRWKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7a2]
X-ClientProxiedBy: MW4PR04CA0396.namprd04.prod.outlook.com
 (2603:10b6:303:80::11) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::103e] (2620:10d:c090:400::5:7a2) by MW4PR04CA0396.namprd04.prod.outlook.com (2603:10b6:303:80::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Sun, 7 Feb 2021 07:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8571e375-adac-487c-5c5c-08d8cb3781c9
X-MS-TrafficTypeDiagnostic: BY5PR15MB4290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB4290E0FD8258A22CF7356A4FD3B09@BY5PR15MB4290.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK9XA4wHmdIb5Pv5OdsCGlnxYDfBUttVj0n8Uy1wG7MK/dGesb7ut4cQ1UOF1oZjuVV/nLFDoiHlt/3/0XlmhHw62F0248XRlH7V78BIDgT9wRQkXx8ute2BgXSDgv9qaHYXKmsjIQkSuHvS0hxoyNdgrh/pCO3jPJXy7SOyCpDnrMbwW+mmzhYN45lY37cOcNCMV+Axur0iHSTDWFxjIJfMD9RGy+sp+wxPO2wLP3YzV/93qZVsZE+H2FHBs9bvOhKcyb/oQEyyWMD9wMj9liffcs1rynu/CHc5lJT9U2mer2k2GNKF0W316JqBuQdndtl7VL0mdo9E78s94ipw7fsgA22DPx02HFZqE7yxqnLM2c8kRzka1cvBkh1bAhLN7S2lBiw+VK0U0OBjw/bltnUU3uM0ycDdtY24vuPVsBjaMdTtVRglpWpuuf4OW2M+lVuoEkH/OpXbhgFdscNneFrNVjV4QWTPBJAzo13ndU/VjIECKto8O6BKWHRW2gvfdTZRcuo28eCY4yNEvspi9S8a7iHsxWTI4qF7iE6NLNS+PHj7TjGdxItenJwPus/gQnfhYXGoyasTRT0/MdiBAy3C9rBxJu1A7dX5fOLqno0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(66476007)(66946007)(66556008)(478600001)(6486002)(186003)(31696002)(31686004)(16526019)(8936002)(54906003)(316002)(52116002)(53546011)(2906002)(6916009)(86362001)(83380400001)(36756003)(4326008)(8676002)(2616005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dk8zZFQ1aTBmYzhDWWRkMy9UY2djdlB2VndPTEoza002ZUNUMDM4OGNvUkps?=
 =?utf-8?B?TmcyR2wvKzA0NVNsaWNSVEYycmlKRUdMY1JNM1ZXVndJSjh3Vk9nUDBNVXNK?=
 =?utf-8?B?TFhVM3JIME80Y1V3Znh3blZCYUtNK2tidVNvWlpxMXFPbXl2d0NDNUpIZSs2?=
 =?utf-8?B?V0s5amhyQUd3cExhd2tIaHJteVh5T2I3UFk0bXpUMERsdmE2QklrcWdJY2Jw?=
 =?utf-8?B?WHVVU2IzOEMxTW9KYXFrM3VNeGs1QUVUT2xGd1JHTjFZVmtmcW1WTzRzdmdk?=
 =?utf-8?B?Z3RZZE42YklIWncwTUZFY3NXNjdLdG5Dd1JGWStDTE9iM0xMcnlCeEdPdTFL?=
 =?utf-8?B?eEVZK1ZnS3h2VTJUNHNCbWZxbnJRM0lSMGpXdmtTRWRXTUFHZ3IxYzhMeVV0?=
 =?utf-8?B?YVJsVmZuRTVwOXpMTGJwa2FTMVZxY1psSStNaVJUWjJMUFFzMjJBRW5tVTZD?=
 =?utf-8?B?MHRkUFY0V2QwalJOTUNSejVxSUE5ZW9NaVA4OWpOcGRxTlRVMUxFMzVDbGVh?=
 =?utf-8?B?TmV2VmVyVWJUY3c0Y3hldnZmcWM1MzhScTF0aHQvNkpvbnJ0cnlScHU1YTdL?=
 =?utf-8?B?ZnYwSVZBQ2pEek1UYWZCdXZ3MCtNcUxRa3F5M1ZvRTlYTGd3ZVJUYjRsWWZD?=
 =?utf-8?B?eW1STExveU0rUlFhOXgxNlUwMU9maU4xUFc1ZzlXTkJ1cWhQb2RPQUFUdVF4?=
 =?utf-8?B?YjBqWDFuanQzcjF5bHpvTXVoMWdpRmRHY3RUUW5LOWh0dHhRUUhoVmFwTDBG?=
 =?utf-8?B?Qm5na3pnazB1UEt1ZnhTYmk0ODlnWEFPRFkwYldpNmFXQVI3VHRkSEdaWEVE?=
 =?utf-8?B?ekY0UHA2dzNHNys2SjRnZldCQUZ6SVZxYUdPdmhBMjJpbnRROE85OE1lTm9C?=
 =?utf-8?B?U2VpaVhDNzBlYVNKa0hOd3QyVFZUdHdrTHFOM3pCNWRjZ2N6MXdZSTQ2em1n?=
 =?utf-8?B?WGsrZS9QT1NFV0ZXSEFlN0UyVFFoUVF5VldCV1U4K0RhRXFSNGNuK1VJeW8z?=
 =?utf-8?B?S2VKdDNvZEhzVXI2bTY3WmRxTnhSZHUzVGRzbTljd1NlRm5ORm9IcHZqdFg0?=
 =?utf-8?B?VUplVW0xWFlKVFJGNXU2KzJXRlJhZklmeGhPSk9yOGhRK3pvRHJnQjh6dVlO?=
 =?utf-8?B?UmxOR0hpZlZCVm52SjRkWDF5RURucTNHdVQvZGtlMUpHTDQ4ZmVQTFFuTGtt?=
 =?utf-8?B?S3JQQ3k2RUliK1JsK3BuSUx2WHRzem1IQ1IwZXNDZnF4YWg5ajBUZ2pIM2JZ?=
 =?utf-8?B?QkFreVJrOVRHWXpzdmNmdWRCbThTWjdUdUp6UzAzYWY5YVZrOVlPRFZkRG9J?=
 =?utf-8?B?ZGVBUjRMZ0VKNWMveHVMZmJVS3dpMTBmQUNMdVpvQ3grZUJ2R1FrZlF3ZEpJ?=
 =?utf-8?B?eVJqZWt4eFRLSkQ5aVEwL0hDeW1nN0NManlnMU1MSHVkOXFnYmpuV1ViaGdD?=
 =?utf-8?B?bjVhRENmVCtIeEh3MFFGNEE1dWhkWStKcjRKWFVWYXMwMDQ2MTQ1MGxCemFX?=
 =?utf-8?B?RzdUMkRnOFBOaUs4TitPRU9nb042K0hZQkZBaHg1NVdlTHkwL0k1WkZYaGVU?=
 =?utf-8?B?M3kzSXRzbUgxZjFzQXNibnMxYTlEZUpqWGMraU9EV09LYzJkZ0twelk5Wkph?=
 =?utf-8?B?Q2pBODlOSWVqM05ESmZGNk5KSE9zMTJYUnZjUUo5WExBbjFGZi92ei85emJ5?=
 =?utf-8?B?bjRCY3pFL1didGxQT1YzL3NMaVk5M3ovYUVvR1pyd1RaZXAyM1crQUNsSlBx?=
 =?utf-8?B?ZzB2d0lianpjaEQvV1J3R1dWRkhFSzlNY2lMdEdCem0rV0NURnUzUVhCeDkv?=
 =?utf-8?Q?pA1Zs2eAif90Bj9eWqgXHEAhOA+sQGMLPhWA8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8571e375-adac-487c-5c5c-08d8cb3781c9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2021 07:10:54.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaTFmpLdwii3Y9nGoO0VOJCvIkHqB1Erj2UQtXxgcvmCER1unP0K3+noyXR3WJhI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4290
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-07_03:2021-02-05,2021-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102070051
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/6/21 10:36 PM, Andrii Nakryiko wrote:
> On Sat, Feb 6, 2021 at 11:21 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> clang with dwarf5 may generate non-regular int base type,
>> i.e., not a signed/unsigned char/short/int/longlong/__int128.
>> Such base types are often used to describe
>> how an actual parameter or variable is generated. For example,
>>
>> 0x000015cf:   DW_TAG_base_type
>>                  DW_AT_name      ("DW_ATE_unsigned_1")
>>                  DW_AT_encoding  (DW_ATE_unsigned)
>>                  DW_AT_byte_size (0x00)
>>
>> 0x00010ed9:         DW_TAG_formal_parameter
>>                        DW_AT_location    (DW_OP_lit0,
>>                                           DW_OP_not,
>>                                           DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
>>                                           DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
>>                                           DW_OP_stack_value)
>>                        DW_AT_abstract_origin     (0x00013984 "branch")
>>
>> What it does is with a literal "0", did a "not" operation, and the converted to
>> one-bit unsigned int and then 8-bit unsigned int.
>>
>> Another example,
>>
>> 0x000e97e4:   DW_TAG_base_type
>>                  DW_AT_name      ("DW_ATE_unsigned_24")
>>                  DW_AT_encoding  (DW_ATE_unsigned)
>>                  DW_AT_byte_size (0x03)
>>
>> 0x000f88f8:     DW_TAG_variable
>>                    DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
>>                       [0xffffffff82808812, 0xffffffff82808817):
>>                           DW_OP_breg0 RAX+0,
>>                           DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
>>                           DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
>>                           DW_OP_stack_value,
>>                           DW_OP_piece 0x1,
>>                           DW_OP_breg0 RAX+0,
>>                           DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
>>                           DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
>>                           DW_OP_lit8,
>>                           DW_OP_shr,
>>                           DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
>>                           DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
>>                           DW_OP_stack_value,
>>                           DW_OP_piece 0x3
>>                       ......
>>
>> At one point, a right shift by 8 happens and the result is converted to
>> 32-bit unsigned int and then to 24-bit unsigned int.
>>
>> BTF does not need any of these DW_OP_* information and such non-regular int
>> types will cause libbpf to emit errors.
>> Let us sanitize them to generate BTF acceptable to libbpf and kernel.
>>
>> Cc: Sedat Dilek <sedat.dilek@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   libbtf.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/libbtf.c b/libbtf.c
>> index 9f76283..93fe185 100644
>> --- a/libbtf.c
>> +++ b/libbtf.c
>> @@ -373,6 +373,7 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
>>          struct btf *btf = btfe->btf;
>>          const struct btf_type *t;
>>          uint8_t encoding = 0;
>> +       uint16_t byte_sz;
>>          int32_t id;
>>
>>          if (bt->is_signed) {
>> @@ -384,7 +385,43 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
>>                  return -1;
>>          }
>>
>> -       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encoding);
>> +       /* dwarf5 may emit DW_ATE_[un]signed_{num} base types where
>> +        * {num} is not power of 2 and may exceed 128. Such attributes
>> +        * are mostly used to record operation for an actual parameter
>> +        * or variable.
>> +        * For example,
>> +        *     DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
>> +        *         [0xffffffff82808812, 0xffffffff82808817):
>> +        *             DW_OP_breg0 RAX+0,
>> +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
>> +        *             DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
>> +        *             DW_OP_stack_value,
>> +        *             DW_OP_piece 0x1,
>> +        *             DW_OP_breg0 RAX+0,
>> +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
>> +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
>> +        *             DW_OP_lit8,
>> +        *             DW_OP_shr,
>> +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
>> +        *             DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
>> +        *             DW_OP_stack_value, DW_OP_piece 0x3
>> +        *     DW_AT_name    ("ebx")
>> +        *     DW_AT_decl_file       ("/linux/arch/x86/events/intel/core.c")
>> +        *
>> +        * In the above example, at some point, one unsigned_32 value
>> +        * is right shifted by 8 and the result is converted to unsigned_32
>> +        * and then unsigned_24.
>> +        *
>> +        * BTF does not need such DW_OP_* information so let us sanitize
>> +        * these non-regular int types to avoid libbpf/kernel complaints.
>> +        */
>> +       byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
>> +       if (!byte_sz || (byte_sz & (byte_sz - 1))) {
>> +               name = "sanitized_int";
> 
> DWARF never stops causing issues :( How about making this name stand
> out a bit more: __SANITIZED_FAKE_INT__ ? Similar in style to
> __ARRAY_INDEX_TYPE__?

Good idea. __SANITIZED_FAKE_INT__ can make it easy to understand
this is some kind of workaround.

Will send v2 soon.

> 
> Otherwise looks good to me, even though it's a bit sketchy to just
> "fix up" any integer that doesn't conform to our idea of "normal
> integer". But as I said, DWARF is DWARF...
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> +               byte_sz = 4;
>> +       }
>> +
>> +       id = btf__add_int(btf, name, byte_sz, encoding);
>>          if (id < 0) {
>>                  btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF type");
>>          } else {
>> --
>> 2.24.1
>>
