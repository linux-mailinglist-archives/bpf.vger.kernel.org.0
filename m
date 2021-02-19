Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A069331FBF3
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 16:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBSP1f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 10:27:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhBSP1d (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 10:27:33 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JFMqeF018422;
        Fri, 19 Feb 2021 07:26:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Uxub/SIvPfLLZiDNoxc0XuO9Rw3flXumCY26TdlND7U=;
 b=IXlqlRuGiEK9NO4tTqSxR8c+4w3EVSiFwcCZ/M4dRBxI6VJ5W6rFLjnYILX45dkb6o2I
 9Co0Ua1n0negINq5wOJHgenv1XL4ovX33rqpRBS1QPAMwXK51pD6x9Gwq84MX3rK5ZbY
 9++K4oWp6iZHMI5d6T9ihO0PWTedhNC8ecc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36s1jgpr28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Feb 2021 07:26:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Feb 2021 07:26:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMIGTxZd6DIT0bdISnb2hEo+NNQbyDz/cB8a9PMqXzZyxpmNfNhaw/Puh3tI6B5oxgidZxTUaBQlCu76Cg1n5ly/8TwdQJc8avkNL33vV/scseEVTdDbWuYdDUpF1F2KmqmpAZZzcqrbcMrQ/TovZnjhctuAbhGNJCd5B0AUgWMF7blIZAymLEg2LA9Cdtce2oNEdlSAhmeNg8WcdOvovHYq88pNRy7x4+GXna6nol7jvhDomXVQYvHZqcwA/WGprrUBmeUsRuLgF0jercqmAYseNT5mHTriWIPmbgAL8rIej5/uPYkIVuw8iogQDeH8OzSkE0uvg4BLNAl3+7sbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxub/SIvPfLLZiDNoxc0XuO9Rw3flXumCY26TdlND7U=;
 b=kM3Upa7k1xcNgjz4h9d31OX3eTilswrtH8xvZs9y5uYjJXAy1LJFzRqvt9P3PcUO/V0en64eFCi2nKiG9ZhXAHDYExmaU3Kv7xhP92YW/Rub0P4ElCRkDhuktsFY/zPw71ctI2Vly0AaDehn2b4rz0KQ20YGhCwVICUnGYM/kzVwtenism+289sPcs5WgvAPIS7HitR4+IdWNebX1L6fkOEJM+dv1uaWqXDvYVkO7tltgmtFxM6/KBiEyyHekLB509qAwO7Hq7B9yf/eTh/BEgsmZNNaN/6rY87f7phgJLEJwnN3uVylRpqzqHO61vCEO9RODsoBBwJn3DXSOdRnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4390.namprd15.prod.outlook.com (2603:10b6:a03:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 19 Feb
 2021 15:26:24 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 15:26:24 +0000
Subject: Re: [PATCH v2 bpf-next 6/6] bpf: Document BTF_KIND_FLOAT in btf.rst
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
 <20210219022543.20893-7-iii@linux.ibm.com>
 <8e1f764e-856d-4f20-96d5-49c83f692d72@fb.com>
 <7f133066832e8b925af191d4a5cd8cd8aa782024.camel@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f7e4e3e2-0cbc-4508-ffa3-311a15823178@fb.com>
Date:   Fri, 19 Feb 2021 07:26:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <7f133066832e8b925af191d4a5cd8cd8aa782024.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:ae11]
X-ClientProxiedBy: CO2PR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:104:3::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::110e] (2620:10d:c090:400::5:ae11) by CO2PR06CA0059.namprd06.prod.outlook.com (2603:10b6:104:3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 15:26:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efdd7d21-09ea-412b-bb6a-08d8d4eab7c1
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4390:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4390B244BCB3D9DD3DF413D3D3849@SJ0PR15MB4390.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gFhcRtcFPQk9mecudqWGimb6mf8Hb045oIzznQo9H3wVHmcMuUL5nVOmrYQENmILHIpTbQei+JuiBohS2TgfbvEZ+gwCNeQwEGtMPUzzBfW0YSK/QDyXVHXE/uX3Fl2RPbhsutlt1T1okO0obUTIdwkpWgy/v7goV6Vgj4S3hw8kZRarR0VPUjaJ0Mj1+BSrK1x70U9Ek5hdLKbCQtaeHRe7EkmH5xN1BAfumfuiGEXfeaZNTP/fqVNpn8DS/FhdTDbi879icr/C0BSLUK3eUOiBZjT7GWemc9bVB/SHbP5PaMGE60oFBy7CyY6kfMxaz1vbsGzYwCYn7m+bsao2ByqP8wxtbS+uWl7dBoBGVXjgfCleuhelsmA3Qfhtcn97s0bY163zHVWMl6gWkh+f+nNeYIAih8SoF3ZlRm5vsKkmu00Wo9iYfHR5q3VmMVYmQuzonDGZC7u8G2MR9s4eDHK4/zzIhir/0qrUvRB+K1Q5t4BWtPaJs8bIxIQfSLlkEiK5L98mBsGPRl4k4yoxbWO+uL3+yaws4F2j+W40hyLQ3emEN2/0gMdevyWC4ZnixA2rnFtP9eFBv9j9FF80XcpXprgGtkZgxD0Tqvbrc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(376002)(346002)(53546011)(31696002)(86362001)(66556008)(66476007)(66946007)(16526019)(5660300002)(36756003)(2616005)(54906003)(186003)(110136005)(316002)(8676002)(31686004)(8936002)(6486002)(52116002)(4326008)(478600001)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YXVBZjVSRW8vL0FQbkZJbmNEUHBIYjZxeHU3azM1c0RHR1FMYkQrZFA3T2gx?=
 =?utf-8?B?UU5SN3pWandCVlZRNnBJZnNuNFh2VENSTlRzY2ptbFc2UWU1MFN3YXFCcnBX?=
 =?utf-8?B?N0NxdVhKMHdSY0c4elpxUGlqVkVGVlJLTFJsVysrWDk0a0xoMUtXc0NXVzhz?=
 =?utf-8?B?aVkzZ0ZVREhmL1NJRWdMNUVxUWo4OXM3WTExQUk3ZlJ0b3lyd2p0eEFwT1p4?=
 =?utf-8?B?cDRTRGVNTGZyekJ6TnVqWXdvOGNsbjJiNXk3OWY3OVBFbEtsVXI2VGNwSFFa?=
 =?utf-8?B?UGh2MUkzdm9GelRkN0xmbDNaZEFCOWJ0a2FTQnNVK3UydUI4ajVJTjIzTk1L?=
 =?utf-8?B?UkxZWDNnWFpxY1I0Tlk2Q2h2ZzNMekRaWUFDTjFmOVJEejJvVFYyNXJmaHh1?=
 =?utf-8?B?Sk5WN3V2SXF0K0Ura2syQWU1ekJXMTRNeGpGNGZkaUNCSUpSc0hPK2RuWXZH?=
 =?utf-8?B?cnVyYTh3ZWZGWVBGQVg3Wi9iQ01RVHVPWFkyL280QnBGVC9QbURkMnE3TEhE?=
 =?utf-8?B?MEswSjNDbThsMlk2UDdZbEtRYkk4K1VzSXpWUTFUTnJuQXdJbVZHM09MWTBk?=
 =?utf-8?B?dzlMb1pDbmNDUHFoRzhrN2Y1aVM4eVpFK0cwMkZNY1VrOXlwUlZVUHZYNlFH?=
 =?utf-8?B?c1p5QkhncDBFS1d1MjhPdjhDL3pHNzYvaE51cTQ3YWQzcnhQemxjVUdLNVBk?=
 =?utf-8?B?amh6TTVvTG1naUVoeGc4aUdaaFAzOVNTUmJlZmFHR0IreDFScHlpWHJYS2Jv?=
 =?utf-8?B?b2RsSDkwTW43QUV4RkdNWjAwOTc5N0JhMmZMYk5tWmxSSTE1QmcxMjRDY3pt?=
 =?utf-8?B?bDdlRUVRTDBvdjlNa0pCYXYxMHdGVW1Zd3RGc1JFeXo2VThDOHduemRTWVNC?=
 =?utf-8?B?Sm1rbExiZEVkZks1RXRKcVhoWHdkUGxvQzhCSXRjQXlSZ1dnTmRCcXZXRzRp?=
 =?utf-8?B?ZnY2bld0azNxd05hMnpWd0tSR0xTY2VidzE0Ny9QNm5HY21aTFdvb0NNeUZq?=
 =?utf-8?B?K0hUY1VLd21zK0FPQ2VrazFqTUhibFlPUVh6S3I3TTB0Vkd6WXE5SldKWkx6?=
 =?utf-8?B?SlVPSG9ENGRuQnoxZC9rWlQ5cHBrSi93WDNHcHJDMksydzVTTUpZdGNZWnZJ?=
 =?utf-8?B?N1JRejIxM3hSakU3QTJqNURWK0d2dU9OaFY0NjZNUmpEb09VekltMCttWVBj?=
 =?utf-8?B?ZTZ3b3VHYzVDVnpsWi9FYWVhdEhUNnpuOFE3ME1zcHVoNThBOCtWTVZlQ1BQ?=
 =?utf-8?B?V3JWeGVPbE9kS3Z5RWpCem5RcmVVZ1YrUWE5emVNYUpORXRPNUhVUEdqeXFF?=
 =?utf-8?B?VlMzcm52M01yN1Ryc08yUmcydU8rRlh3VGNWNm5VNjVvY0E4Ti94c1N0Q2RC?=
 =?utf-8?B?L3EvVzNtRjJPcWhIcWJCMXRMWExkUDJEcDJuOEp6MW5nY0owK1pseFdMWFFB?=
 =?utf-8?B?Y3RuV1R1Kyt6b0FnK0hGTU1zOHBmYVFkdy9ZYXNoNGpzMlFTK3FWUDl2T2RL?=
 =?utf-8?B?eFRYaUtjemhIQ2R0bUtJK0dCbG95cmNNdnp6ZXlhZWRWTEdnUWhiY2VxM2h0?=
 =?utf-8?B?by85aktZUU5tVXphVmpRMlUzVWFrMlF3NlpEblFDN1Vqa1FLUzJiSDZaQlBs?=
 =?utf-8?B?OXNQcDUxVGlONWlDb1hNRi9JYlUwazFJQmZKTDB3TE9XWTJWemRlZ0FJZU00?=
 =?utf-8?B?Rnl0WmUxY1Q3aVoyd3lCdVQ1UG1JeElnYTArOFcxeTJ4RVNDT1BzN1IzZDN3?=
 =?utf-8?B?SCtnZkk1L2dBRW5mV1oxM1BKaW5GMmFDbm12cEhxVlgxOWw3TE5lRDJEdHEv?=
 =?utf-8?B?dEllWE5nM0RCRGhGR3prQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efdd7d21-09ea-412b-bb6a-08d8d4eab7c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 15:26:24.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VRldnKqhrUnCvuX/2bCWGBCgd90u2Z7cw7TR2T0ykSfxcsLNJEdAQffRoObas5T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_07:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/21 5:00 AM, Ilya Leoshkevich wrote:
> On Thu, 2021-02-18 at 21:41 -0800, Yonghong Song wrote:
>>
>>
>> On 2/18/21 6:25 PM, Ilya Leoshkevich wrote:
>>> Also document the expansion of the kind bitfield.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    Documentation/bpf/btf.rst | 17 +++++++++++++++--
>>>    1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
>>> index 44dc789de2b4..4f25c992d442 100644
>>> --- a/Documentation/bpf/btf.rst
>>> +++ b/Documentation/bpf/btf.rst
>>> @@ -84,6 +84,7 @@ sequentially and type id is assigned to each
>>> recognized type starting from id
>>>        #define BTF_KIND_FUNC_PROTO     13      /* Function
>>> Proto       */
>>>        #define BTF_KIND_VAR            14      /* Variable     */
>>>        #define BTF_KIND_DATASEC        15      /* Section      */
>>> +    #define BTF_KIND_FLOAT          16      /* Floating
>>> point       */
>>>    
>>>    Note that the type section encodes debug info, not just pure
>>> types.
>>>    ``BTF_KIND_FUNC`` is not a type, and it represents a defined
>>> subprogram.
>>> @@ -95,8 +96,8 @@ Each type contains the following common data::
>>>            /* "info" bits arrangement
>>>             * bits  0-15: vlen (e.g. # of struct's members)
>>>             * bits 16-23: unused
>>> -         * bits 24-27: kind (e.g. int, ptr, array...etc)
>>> -         * bits 28-30: unused
>>> +         * bits 24-28: kind (e.g. int, ptr, array...etc)
>>> +         * bits 29-30: unused
>>>             * bit     31: kind_flag, currently used by
>>>             *             struct, union and fwd
>>>             */
>>> @@ -452,6 +453,18 @@ map definition.
>>>      * ``offset``: the in-section offset of the variable
>>>      * ``size``: the size of the variable in bytes
>>>    
>>> +2.2.16 BTF_KIND_FLOAT
>>> +~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +``struct btf_type`` encoding requirement:
>>> + * ``name_off``: any valid offset
>>> + * ``info.kind_flag``: 0
>>> + * ``info.kind``: BTF_KIND_FLOAT
>>> + * ``info.vlen``: 0
>>> + * ``size``: the size of the float type in bytes.
>>
>> I would be good to specify the allowed size in bytes 2, multiple of
>> 4.
>> currently we do not have a maximum value, maybe 128. have a float
>> type
>> something like 2^10 seems strange.
> 
> I tried to write this all down and realized it's simpler to enumerate
> the allowed values: 2, 4, 8, 12 and 16. I don't think there are 32-byte
> floats on any of the architectures supported by the kernel.

This make senses. My above 128 means 128bits (sorry!), which is 16 
bytes, align with what you suggested.

> 
