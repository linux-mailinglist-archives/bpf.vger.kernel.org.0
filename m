Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42740477F9D
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 22:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhLPVwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 16:52:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234629AbhLPVww (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 16:52:52 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGErJYZ015951;
        Thu, 16 Dec 2021 13:52:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xQy319Ug8jXqHSCsoayrD0bkuoo4FYRkPpUOhSb16gY=;
 b=a0TvrSYWK+dLiuHFsk+hOIsRa19k6AaOefTURML01v4VY4rC4L4pDiu2BDY4TK91l5Ni
 SXYaFRfnkkLWhmx5xhJ4eZLJEqDT+Rez//IleVikef27QYC64+R1NHduBlERZH3QimQX
 OYYVwvsCMTCOph2P00RvnQUdpYIKn0rePIA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d07kxu64k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 13:52:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 13:52:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j80TQ13DXbchlCCIUtQP6P2tUzQECT4mnuwZx28c33xXa/htJ7gDVwQ9ZWLgIci6gtRkh3SKGdOHVqDeqVAPZ+1pmMdJaLNss8eprIsn7F47n0qa5vuAQJ8Hp2cmsCuoVy+vzUhxT8kBTDqIP57FAZB6nUCm/zdWQ09yKm4rBJGjJ2YtIKuzbaBCGx2sRnGXt4lR2EMFTU0/jPweASdvDWwtMTD3ST3nXRDIEYOFeqoXzN2sSkoSK2W0DOiXcmpYRrXdU/8e9LDSFP5Bq90kraEHyaeuSK3nzQyWmEC6uvgeKvxm6H/OrJSNFHK7TUfyHRq5WFgsr7jo5O4d37/oRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+weCvqCtU9s8vCNfgt9DFY4FugJ8nRYMui52or77IE=;
 b=TyGsmKKJibwaZ5yDzQLI/TOmDP58ooaIrng63f/px5W2zBoZu98cNI9s0sEwfOth/q4jSRu3YsQX3F4kJs3lV3AHZpnv4ZXWOY0c3i2Sk8KYnJqPIzI3WD7KtWhYtg6cTofxcl3pT2+wcM4BvpQny+chRGsrxGDD+RalBU7Po1d4pSgn4qOFA2ZhmVnX+ZfrpFk/Tbq5AWUA+Uf/ppnV2P1GVuYj0WJqldOYu2V1UXHGsdOkEkN2hGhZCmHkYLgkjOeiqXmJIPSVQgewdVnXfZKuwgK4FS2SbCkyas/j3YBP+boxNYenij7w8Jvh0NbtDOEbqrZyfV7BN9U6HlRxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4159.namprd15.prod.outlook.com (2603:10b6:806:f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 21:52:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 21:52:29 +0000
Message-ID: <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com>
Date:   Thu, 16 Dec 2021 13:52:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
 <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com> <87sfy82zvd.fsf@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <87sfy82zvd.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR08CA0052.namprd08.prod.outlook.com
 (2603:10b6:300:c0::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 380ca8ee-909a-40e5-bc40-08d9c0de5ae7
X-MS-TrafficTypeDiagnostic: SN7PR15MB4159:EE_
X-Microsoft-Antispam-PRVS: <SN7PR15MB415925270CC1A46D0654C16CD3779@SN7PR15MB4159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkVhVSbSZS3J6PudZYB2hw9mjfCtUpucuHxRnTULiyThEhhUz6S7OKYDHLyKvewaUv/K7NvEDMdcPW5TvRaE0T2norEhPOTb9FHW2juoWTsIFw3K8qRrU8SpTKLLbuqa7HenqxgH1w0W3zGpelijaibQWQEoyHwa6dW6Km7c00NY2YOClV0cMmMKI54N74+pi+YbLTW2LgWcFPn5PoQ7vGcRzke9CsRGtWKWUbF8yFuWrtL/1FpPxtL2f9SpE3mBgDRNXD7oNW7U3gSYxfRN2cuT3ekBwvGUrprkWlstDZC3JKRhJNYtNNWrgao6fvKBugZ8HjIMyjeCJZbi9XLobABRXEdgldHmsXdM3NyES4JGE+RHxwtX2TzzeyD8knbbckR7Mu5O9rZOBNQAf8JxU/5sqm4Q+qG8Kp4/wiK9q5o+mlbPZ7O0gkmjhaBVkv4LbjuicGUFVY9+1KI5SVK2EZu/O0LCaIBerqDj46iuH+n+tZwd1vApJ6tTEJ9juRS4rxbYTikWBoALgOy+LBzZbCNwPxSw2QCI6JW3BW4qO+YNUYhbvy/h8hZtS6wUmawKTn8tMqIXRfBtTOGyxDeBhsYRLe2yfIqCGj6d3AHQXuVpyksEn2epefdzf+VzQp4KCv7AEofzQpXjdSJWS4zFfS6pFbl2YBUbvUhI4g9WA7yxAQgernr/4bV19surBVbJedmNKUufF0EqlrBWgPEKFbcZp0xi+diB6tK2VWPl9DJ2owIG305P/sfhvR9KT8u4D5jPPFdXIyQ2DsAWEp4pK/2w9S0t8Uj4WRbWTU4A4skKNVwKjCr3RhZXY1rLVn0A73Y5/XqpPLiXtunmDQV8T1k0wpHi2et/p2Xdlx5ZCAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(38100700002)(8936002)(186003)(508600001)(6916009)(54906003)(4326008)(83380400001)(86362001)(31686004)(66946007)(31696002)(6666004)(36756003)(966005)(316002)(52116002)(6486002)(5660300002)(66476007)(66556008)(2906002)(2616005)(8676002)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFPTHB0U2xiN1BuTDE2aUNJVlAzNGNic0lkTVd0eVJISGx6YVNQbDIzQ2lX?=
 =?utf-8?B?UFlYSW1nWk53cngyYjhmckVrTThhSW1KQXY4emNzWUo5T3c4MFp5dkVuZ09y?=
 =?utf-8?B?bXlHOS9YaWNFRzEyR0FtZS9WUUVjUFhaRVdVVlI2cWlHK0s1S2lkcnBNTXhw?=
 =?utf-8?B?ejdQZXRhekYyZ0dEOXlPU254cVo5NFdldmVSQW92NHV5MHliVGJibXVJTjlQ?=
 =?utf-8?B?WFplMUsxUGNCRE5FMFI3TDVSdlFyeU43aFNrMW81bGsxcHovMVlmNHkvb0dK?=
 =?utf-8?B?anprUkRLTW1vQUY0d0JZb1VmOTlUbHJTdStuazZmdGJueDFCek5WUVIreTdN?=
 =?utf-8?B?UE9DQWs1Zm1kVjM1SE90dUhRLy9hUW1WejV0NGZKa216eksrRk0rUXZpMGRB?=
 =?utf-8?B?Y0s5YTB4ZVlTL0twWDltdmZUQkkyS0RTWThIdkJJeXZOS3dKbHh1eGN1SC95?=
 =?utf-8?B?dWg0dCtpSmk5V3ZEQkhDMk1OcS9OUHRGM2lYQk1ZTStBV2RiSnZPTjBXbzNv?=
 =?utf-8?B?TGRrR294c3NRRitzMS9YVXdWNXBNbGlqd2pVVVBzUU1CZllFVHFIR1lHRjhL?=
 =?utf-8?B?RVJadUdzUzA1MGVGZkFQSDFwVnJiZWhGZVZ3N1RJalZ3NUdLeGlseW1lYUd0?=
 =?utf-8?B?NSt3Q3NFRmFuNzNLeXpMQWUybGZ0WmNBZFZ1RFk4aXVjTTJKR1Z5b2UzZFBP?=
 =?utf-8?B?eFRHUVFvbTNQalg2cjYwR2VxM2FhSmtPcmJDMkY5TGJxRElueEJ0bC9BTTlI?=
 =?utf-8?B?N0dxaGhLamNXUXZwaGZESXZNL3BkMEUxdkFoUXAwVW5HQ09jVDVLeEFZRDVX?=
 =?utf-8?B?VlZuQzhVSldycTFxVFFWbUFVWHN2NDRYaFZYYmRnRUl4VFBQbUMva1FIM3F6?=
 =?utf-8?B?eG5vZzlUWlAwcENCWjd2elZBZ0Q1dWRINXZjMlN1NmVnckRHK1dJSzJ2YmVu?=
 =?utf-8?B?T3JjU1N0KzJLWEVCUDUxRWVLSTJnZE5iTm1sTUtCazhaRkVPU3poZldtM2Ru?=
 =?utf-8?B?bXlxZmF6UTdCRmZDNWhCQTVLUWs3ZEc0NklvbTlnMWVHcXFrdWd1UldpMmlo?=
 =?utf-8?B?cmlrUUNxbHp5d1pwT3hDbCtnS3JmK25LN3NoT0FOWm5LY1VNdlNoTiszMTdz?=
 =?utf-8?B?RDZna0ZRRWpoZGlVWnZLaWptMlc3Y05CeXg4TVBUbldUcjQ5WXhMeDV0WWdL?=
 =?utf-8?B?RUxEWTUzQ2xLM2xGMkRqaW1RelkrT2pQYXpTUHNubTErNE5KVUhlSVk2RjUz?=
 =?utf-8?B?amppWXVIMXE5SWMvdG1sSGIxb016L2xPZkNCNFpSbnk2Y205WXZQUGZNSmd4?=
 =?utf-8?B?Z3QrYVRmc3gxMnl5cml5Q2pJaEh3MUhlekhtWktadGh2b09mZ2dtQUpxRmYy?=
 =?utf-8?B?clVYRC9XNTBSTVEybnkxSERMLzQ0OVJubUs5eDRXK3BGdDRXNGF3SDJjelFD?=
 =?utf-8?B?ZmlVYnRxUFM1czRGL3E4ZEJaOXBCN1U1Mk5xeXVBNnFMbW93TitUL3JPS3A2?=
 =?utf-8?B?dDRpTi9WRXJYMWZ2a1N3TGRSSDFGVmt2cjlzMHpuYzhibEg1c3pWWW4rZTR1?=
 =?utf-8?B?dStkOE0vTThFWnhuTHBIaExyQ0Y5cks0S0c5LzJpYUI0cWwvd3FVajkxMlhO?=
 =?utf-8?B?SGpFZi94QzgvYXgxS1lXeGVkdzUwTE0vNXdnejZMYU9yaWpXbmdTT1h2YnZa?=
 =?utf-8?B?NnhnNFhZMmpUdjJvY2p6ZlJwSUZ3ckJwRjFiNjRRa0pUMTcxRDVaQnZrMWRZ?=
 =?utf-8?B?Mmgxc3NkazhWbVdUSGpZQWwyZkVmTFpUc1RDcEJqVnhUbUpMeXVJU2htNytn?=
 =?utf-8?B?dWNSNmh4ZXlTbzZZV0pkM2VsVjlGM2E4Um5aNVFYajluZW1qL1l5SlpzOTJi?=
 =?utf-8?B?UUNKN1E0SmxHR0F5cUE2a0RRWU5meW9ZQ3F1MU1yUjZEUnE0M0dNaVNtUHNz?=
 =?utf-8?B?U2NleGs5cCtVRzYxbEp3UnZTVjBDT0FGK0hPZWkxSTZScWFDaXJrWlQ5S2Zl?=
 =?utf-8?B?Z01BcTUvLzdhcmFRU3J5QTB6YU0rcTZxVkZlQnFjL203SlJOK0N1QzdBUi9N?=
 =?utf-8?B?VlA1M1pqQVlXMUlwOTI5Y1pHSEZOalBMMUNUd2M2eTRuL2RUWTJ3NmtFcDdu?=
 =?utf-8?Q?4ghYHJfgXo4lM7hAxy5aNjj7A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 380ca8ee-909a-40e5-bc40-08d9c0de5ae7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 21:52:29.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnthdpo8OIcs3DeXcFmn+3aYcQbfHNghcwVmDc4oF+JuB5mWaQicRAWFCjQUi2BS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4159
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: HQV8H8BwFATzI6kRLOCdXYr4lmhhhzhU
X-Proofpoint-GUID: HQV8H8BwFATzI6kRLOCdXYr4lmhhhzhU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 4 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_09,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/13/21 9:40 AM, Jose E. Marchesi wrote:
> 
>> cc Jose E. Marchesi
>>
>> Hi, Jose, just let you know that the BTF format for BTF_KIND_TAG is
>> changed since v1 as the new format can simplify kernel/libbpf
>> implementation. Thanks!
> 
> Noted.  Thanks for the update.

Hi, Jose,

This is just another update on btf_tag development.
Now, btf_tag is divided into btf_decl_tag and btf_type_tag
for tagging declarations and types as clang compiler prefers
not to mix them with each other. All compiler works in llvm
has done and you can check upstream llvm-project "main" branch
for implementation.

The patch set below (under review)
    https://lore.kernel.org/bpf/20211209173537.1525283-1-yhs@fb.com/
actually tried to use btf_type_tag for linux kernel __user
annotation so bpf verifier can use it.

Another question from Omar (open source drgn maintainer)
 
https://developers.facebook.com/blog/post/2021/12/09/drgn-how-linux-kernel-team-meta-debugs-kernel-scale/
mentioned that btf_tag information will also help drgn since it
can then especially distinguish between __percpu pointer from
other pointers. Currently drgn is using dwarf, clang compiled
kernel puts btf_tag information in dwarf. Based on our earlier
discussion, gcc intends to generate btf tags for BTF only. Maybe
we could discuss to also generate for dwarf? Do we need a flag?

Please let me know if you have any questions.
Happy to help in whatever way to get gcc also implementing btf tag
support.

Thanks!

Yonghong

> 
>>
>> On 9/13/21 8:51 AM, Yonghong Song wrote:
>>> LLVM14 added support for a new C attribute ([1])
>>>     __attribute__((btf_tag("arbitrary_str")))
>>> This attribute will be emitted to dwarf ([2]) and pahole
>>> will convert it to BTF. Or for bpf target, this
>>> attribute will be emitted to BTF directly ([3], [4]).
>>> The attribute is intended to provide additional
>>> information for
>>>     - struct/union type or struct/union member
>>>     - static/global variables
>>>     - static/global function or function parameter.
>>> This new attribute can be used to add attributes
>>> to kernel codes, e.g., pre- or post- conditions,
>>> allow/deny info, or any other info in which only
>>> the kernel is interested. Such attributes will
>>> be processed by clang frontend and emitted to
>>> dwarf, converting to BTF by pahole. Ultimiately
>>> the verifier can use these information for
>>> verification purpose.
>>> The new attribute can also be used for bpf
>>> programs, e.g., tagging with __user attributes
>>> for function parameters, specifying global
>>> function preconditions, etc. Such information
>>> may help verifier to detect user program
>>> bugs.
>>> After this series, pahole dwarf->btf converter
>>> will be enhanced to support new llvm tag
>>> for btf_tag attribute. With pahole support,
>>> we will then try to add a few real use case,
>>> e.g., __user/__rcu tagging, allow/deny list,
>>> some kernel function precondition, etc,
>>> in the kernel.
>>> In the rest of the series, Patches 1-2 had
>>> kernel support. Patches 3-4 added
>>> libbpf support. Patch 5 added bpftool
>>> support. Patches 6-10 added various selftests.
>>> Patch 11 added documentation for the new kind.
>>>     [1] https://reviews.llvm.org/D106614
>>>     [2] https://reviews.llvm.org/D106621
>>>     [3] https://reviews.llvm.org/D106622
>>>     [4] https://reviews.llvm.org/D109560
>>> Changelog:
>>>     v1 -> v2:
>>>       - BTF ELF format changed in llvm ([4] above),
>>>         so cross-board change to use the new format.
>>>       - Clarified in commit message that BTF_KIND_TAG
>>>         is not emitted by bpftool btf dump format c.
>>>       - Fix various comments from Andrii.
>>> Yonghong Song (11):
>>>     btf: change BTF_KIND_* macros to enums
>>>     bpf: support for new btf kind BTF_KIND_TAG
>>>     libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
>>>     libbpf: add support for BTF_KIND_TAG
>>>     bpftool: add support for BTF_KIND_TAG
>>>     selftests/bpf: test libbpf API function btf__add_tag()
>>>     selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
>>>     selftests/bpf: add BTF_KIND_TAG unit tests
>>>     selftests/bpf: test BTF_KIND_TAG for deduplication
>>>     selftests/bpf: add a test with a bpf program with btf_tag attributes
>>>     docs/bpf: add documentation for BTF_KIND_TAG
>>>    Documentation/bpf/btf.rst                     |  27 +-
>>>    include/uapi/linux/btf.h                      |  52 +--
>>>    kernel/bpf/btf.c                              | 120 +++++++
>>>    tools/bpf/bpftool/btf.c                       |  12 +
>>>    tools/include/uapi/linux/btf.h                |  52 +--
>>>    tools/lib/bpf/btf.c                           |  85 ++++-
>>>    tools/lib/bpf/btf.h                           |  15 +
>>>    tools/lib/bpf/btf_dump.c                      |   3 +
>>>    tools/lib/bpf/libbpf.c                        |  31 +-
>>>    tools/lib/bpf/libbpf.map                      |   5 +
>>>    tools/lib/bpf/libbpf_internal.h               |   2 +
>>>    tools/testing/selftests/bpf/btf_helpers.c     |   7 +-
>>>    tools/testing/selftests/bpf/prog_tests/btf.c  | 318 ++++++++++++++++--
>>>    .../selftests/bpf/prog_tests/btf_tag.c        |  14 +
>>>    .../selftests/bpf/prog_tests/btf_write.c      |  21 ++
>>>    tools/testing/selftests/bpf/progs/tag.c       |  39 +++
>>>    tools/testing/selftests/bpf/test_btf.h        |   3 +
>>>    17 files changed, 736 insertions(+), 70 deletions(-)
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/tag.c
>>>
