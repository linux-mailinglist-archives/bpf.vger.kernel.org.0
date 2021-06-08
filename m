Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B024939EDB9
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 06:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFHEet (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 00:34:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhFHEes (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Jun 2021 00:34:48 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584SebU029736;
        Mon, 7 Jun 2021 21:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=p/A19Xr5ZidSPl32okyFdsBnF+X4Sit5/wMOrrYwKXg=;
 b=rJw8thlCdlu01lA00eyM+knaxAPqreCrJF5Y3QpwQMjvWg8JXY9K366Nt2RDCQhxE9oA
 lAP06RwRlKcsr7mGnBU/PlRdSL6H9iI5JiuLm++ljxFVOEh6S4lqRsQbJT7ZvS2GLth8
 3o93xChe04EzR5hnEIVMP7XcCOeeaVhwVqg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 391mx0mdw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Jun 2021 21:32:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 21:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHdtZmWjX1Amn5CQOUAE6mZg8MYLRlQCFHMQiiWpPJd4zd0t/M9PP6LTP4Y2c9rdj8xI3EMJIo27YsKToJEeK3wqvwVeRb4Iz3fLWOGtWgD4JyCGNqHhkak26n3hPfnhbFoN6PBs+OObQUg2tMM8Oex3QRSv/ub673/8iLyQeZ8qztCLhv9DMbSkxyYmKEmYRMLvu+BZDWraP54fBe/txXHzphU2Ln8VkNLch++n4GudBUFLrsfH8WxLVbT91pTzzoaGuOdNv7e0Gk562WmvMwSTSylawmbV9gbiQ5FZlvPcLAWHcgBnpQIMte5ENVfyM9u/6+jfGToYTynkPFd6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dnk5CpxP7o4XoYjLJ3NgRx+Ynk+GEZySW+pwdl/t94=;
 b=WNgljUqpm8rCqhmpSLcqBnCJ/PnmNQtB4LCffwPBubSOa4PenhSdShaCqXYL1M7rUkjwixCfXsLLQij7eNNp9qFiXXsX/OaMOKVq3os/kmWSo61DDkgDTyfNv7Rk90NwC4iR6CoLdgKDFeEuzqx1Z4iZsdk3598nCSd6F8aFqxnkvEptXSWlzyFCBP4I5wKvDLEdkWgdUhB0PuYXgs21kpce66INNwjWvPqocaaHlVUmjOMMxmr3LE6V0+kIvMhIHHx3SbBLgTDha2TaYyxgN3ytcCpf3h+HMgoB92A4ljmDj0xy2vudbwhHeKm6xCcilw4x5fq8dAelJ+t2QGHvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3917.namprd15.prod.outlook.com (2603:10b6:806:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 04:32:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:32:31 +0000
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
References: <20210525033314.3008878-1-yhs@fb.com>
 <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com>
 <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
 <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com>
 <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8abe01cb-da8f-514c-6b52-b92686a16662@fb.com>
Date:   Mon, 7 Jun 2021 21:32:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:b270]
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::108b] (2620:10d:c090:400::5:b270) by BYAPR07CA0030.namprd07.prod.outlook.com (2603:10b6:a02:bc::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 04:32:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81c39b9e-6a66-4a4b-aeff-08d92a366dc3
X-MS-TrafficTypeDiagnostic: SA0PR15MB3917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB391779A9F3E819A43D0EF9FAD3379@SA0PR15MB3917.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0QzJLZpbnfqIMr6o8yeajetZyvMi9OMu5Xl6c77UdyS3vjuqYPam+E8HAm9KdQGVyB9bhnYYJVg9nFkgtG0cZrKJi/U6k2BgBkKVf2285wjR9CGPSQesNn82ZldP/tl/RKKFjZiX/OYYmtOYCoqlhO3GtBSV8OzOWli86EoyrMV42ZFY4qUqY9wAJsE1W7XmSEyMoP9VKe+zHsfXE95mxA+58RJ+Jmdk1u420eCT6ow3kWaF2r+5TSX3lLMKvlekigunfYtdXHDRSOoXQFJLZWtehsFVHxoxOXbF4hU1UTtSRp599xLIS5swgzm5ywcTIaW4S7jBsFq91d9Jht/eJKJZTd0DbSEzJFq2fTSyBmoGDbUWXcaS6VSM5W5RE62FWiWoC1hMojuXAATuQU9B2KlhN958mTuw/4J4ceCKTGiKWltdd8Wnx5bZjLZ/WWG7Xj41nBX4JRALFWB+ubOyfrom+9O0BRNXciJBm0BXFSMR66PGxQTJkGuaMzSR4DrnIgjjJ4WVFlBRoR89Kc4Bu9mlydgTmLbzf6bYQxSxxsM3fK45HXWvN72SP4Z5J/m1+25YKC0M6QDzBPmrrdxvecwTzDe5WV3BMF0SzV1NTHHSe1e6p3BYiPqO0gCy020mrRcsqBRqUs+s65dQVsRMY+vdkBMkS0QIsQLRMxgyktsUaANnF5r4ElKiM0XhZBE00krqE0OhvD5ouWQHx7WitFpy4j9d6gZHL/GWUcBDmBO9ap5o2TnUn4ZDeUlvSSZKf55/l9yiwyZwpTy/kbgWjsHC9s09oVrB6/tMrO7w4Zehd4tB9GSpREJdqqljImPLhdrXY4ltwVV8T7CE1YGKZ/jtVuwNL89Ldq+Pdfh4ILpp5D3g2GYWgISoIvtHV81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(66574015)(52116002)(30864003)(31686004)(38100700002)(53546011)(186003)(966005)(478600001)(16526019)(83380400001)(4326008)(54906003)(66476007)(6916009)(86362001)(5660300002)(36756003)(2616005)(66556008)(66946007)(6486002)(8676002)(8936002)(31696002)(2906002)(316002)(45980500001)(43740500002)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pHR1FmZTFaZXovcUQ1eUJ1TDQwVWl2OGZlSE9hMTRWbCtNNHRFQlRRTEJv?=
 =?utf-8?B?K0doVG1tL05YQkZmWVAxdTBqaDdzSk5nWE9KbklNb3UzSUV5RGs2Tlpuek1Q?=
 =?utf-8?B?NnBTRGJ1dHROendOeUlseFRRVDlNUGJTL3gxdHJiU0dTNVJ0L1ozRWFtQUVm?=
 =?utf-8?B?M29oZGtoNXlha2EzdERWWDc1d3dvQnlhZnJRNktNcWhtY2h1L1lMQ1Era3pW?=
 =?utf-8?B?T1BZNmJzRXFWUTlzT0Zjd2dhWnJSNGN1ZllhaHF0dGRvSVRicTNVM05vUkh0?=
 =?utf-8?B?b1lzcmphMXh1SmYzSzJYemNVZkZtbDFwcDBwRm1IYUw5QU9pa1JVUVJsajU0?=
 =?utf-8?B?VSt1R2NMWGU4cUxTNGJWcjVGQUhGaWlQNlBGQWFDY1FWQUZRQi92U1dTTzli?=
 =?utf-8?B?VHpheGpTTVlSZXRielk2UjRWYVpBdmFRZEZPZnl6U1FaNTVUbE5oQ2EwVjha?=
 =?utf-8?B?OEhvZCtaS3NHUTRvRjBFUnJiSlIydHNCcStQdVU1ck4xcjhySGNaN1VWZkJP?=
 =?utf-8?B?aHY4N2xDUW5VbXZMOC9vUmRpYmRTRlBxMU0vZW0zbTdoREtQaFBHeEdTQlNT?=
 =?utf-8?B?aWV3bE5GRlpGeVFlSjNxL3ZYOUJncUlJcHZ5NUxMdG1lUVdsa0RwVWlZZ0R2?=
 =?utf-8?B?VVd6MCs4N2twZGZHemR4OVYzbEZVTUU4amgyMkFGVWZ5Vys5MnYwNlVuMDMr?=
 =?utf-8?B?YklhOVFkL25SWFYrbzNZQ3NoYUZxZC96SHd2TCt0c0JKaU9DRDBoQVgyaXJx?=
 =?utf-8?B?V1ZSdFJYSXRHWkhwQXFiMnIzN1VDcW16NGVIcFFSR3JDcHlVVUxoZno5Z3NB?=
 =?utf-8?B?MzdLbmNpQnBPNWFmd0taVUlqNFRPdVExQzdaUkV3REJrclZlOHBUdVdrWUNp?=
 =?utf-8?B?VUl6NDZtQzhXQkZZeWJuY3JiTDlYVnc5Z3VhM05TOWJkREhnTXJQNkF1dUJ5?=
 =?utf-8?B?dHEyNkxBSi9ZT1RCcXVxcXQwTms1MFpCS3BUaXBxOGNxdEU1Vkp3Zm85eXlS?=
 =?utf-8?B?MnhmbDBFUnAvR0I1Qm00dWQ0amJwRi9yTEZpRmlVWjdzYTNsVlNpVkptZEdw?=
 =?utf-8?B?Y1g3Y2xvaTZQd0FpK0NWM2hBMTlIYXZ0Q0hxa3RXeHorR2xTV3FUWXZldkRE?=
 =?utf-8?B?Q1RQaVdqbVRQZ2o0aG5DZmxUb2V4dGcwR3ZUREVVMWxDRWFjd0RIU1oyT3Nm?=
 =?utf-8?B?VUhDY3BNbjhvUmlpd3lRdlphZmswV3hZTE9uQ2RUY2ozNzZ1Y0VkQWRHK1F2?=
 =?utf-8?B?NmdXRDVpdmhlUXZTMk5mMnB6V2JtTzlWVmptZGtkOEFIV09CdEhwQXlMVFJ6?=
 =?utf-8?B?VEdEdWo5ZEZzZk9UUHZtUFNFNElES2FLUmRNTDE0cGJPdmxidnRkd3hod1Q4?=
 =?utf-8?B?K0ttbWYyV0kwWEpHQ3JwSEowWUwybnVoOVZkRjVDaG1LSXdBZ1pGNVNGR2dX?=
 =?utf-8?B?SVMzZC9idkVzblM0MnQrZ2FiS08xWDRpRlB5VGtueU1jVHd6anczaGgvUjI2?=
 =?utf-8?B?Z2ZnRDVHamFacVBFWFcxR2dHeWc1bWhFd1c2ZmdMSzRsRUhWVDZlZm41NThk?=
 =?utf-8?B?ZzQ3dCtzSnlnaHlNeHVxejRmUjRyUWt6VGQwVGJJQjd6OU1mZHUzT0tYUCtz?=
 =?utf-8?B?NWJ0QjdIelBSVnBRTlBEdkZtWlNQSEtDTmYxeFFZVTZ1MG8rT3lpNmhYNzZp?=
 =?utf-8?B?ZlV2T3ZqY1JNb1JLZlRWM3lZUzZHOTJGS2xZR0htMzdqWi9iZ1FGM0gwQVRi?=
 =?utf-8?B?ZGhPT3VHdHBPMWlybVFoenBxSWtRUFBQSTJpanBZM2tvc0FodDJQajFtZE1t?=
 =?utf-8?Q?WDbXb/h2aPRb4gbCCPXjARJgXMp1Ifwturkn8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c39b9e-6a66-4a4b-aeff-08d92a366dc3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:32:30.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f+dThjJYsTBvV4zPy9VcHjsiecB9O1/jsqnJPcSrWtX4bNnLNrnvFx1E5QZPMTo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3917
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ytqVhc9gp9Cg6jclvuRVoEdEUx7rtax-
X-Proofpoint-ORIG-GUID: ytqVhc9gp9Cg6jclvuRVoEdEUx7rtax-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/7/21 3:08 PM, Fāng-ruì Sòng wrote:
> On Mon, Jun 7, 2021 at 2:06 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 6/5/21 2:03 PM, Fāng-ruì Sòng wrote:
>>> On Tue, May 25, 2021 at 11:52 AM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 5/25/21 11:29 AM, Fangrui Song wrote:
>>>>> I have a review queue with a huge pile of LLVM patches and have only
>>>>> skimmed through this.
>>>>>
>>>>> First, if the size benefit of REL over RELA isn't deem that necessary,
>>>>> I will highly recommend RELA for simplicity and robustness.
>>>>> REL is error-prone.
>>>>
>>>> The worry is backward compatibility. Because of BPF ELF format
>>>> is so intervened with bpf eco system (loading, bpf map, etc.),
>>>> a lot of tools in the wild already implemented to parse REL...
>>>> It will be difficult to change...
>>>
>>> It seems that the design did not get enough initial scrutiny...
>>> (On https://reviews.llvm.org/D101336   , a reviewer who has apparently
>>> never contributed to lld/ELF clicked LGTM without actual reviewing the
>>> patch and that was why I have to click "Request Changes").
>>>
>>> I worry that keeping the current state as-is can cause much
>>> maintenance burden in the LLVM MC layer, linker, and other binary
>>> utilities.
>>> Some things can be improved without breaking backward compatibility.
>>>
>>>>>
>>>>> On 2021-05-24, Yonghong Song wrote:
>>>>>> LLVM upstream commit
>>>>>> https://reviews.llvm.org/D102712
>>>>>> made some changes to bpf relocations to make them
>>>>>> llvm linker lld friendly. The scope of
>>>>>> existing relocations R_BPF_64_{64,32} is narrowed
>>>>>> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
>>>>>> are introduced.
>>>>>>
>>>>>> Let us add some documentation about llvm bpf
>>>>>> relocations so people can understand how to resolve
>>>>>> them properly in their respective tools.
>>>>>>
>>>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>>>> Cc: Lorenz Bauer <lmb@cloudflare.com>
>>>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>>>> ---
>>>>>> Documentation/bpf/index.rst            |   1 +
>>>>>> Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++++++
>>>>>> tools/testing/selftests/bpf/README.rst |  19 ++
>>>>>> 3 files changed, 260 insertions(+)
>>>>>> create mode 100644 Documentation/bpf/llvm_reloc.rst
>>>>>>
>>>>>> Changelogs:
>>>>>>    v1 -> v2:
>>>>>>      - add an example to illustrate how relocations related to base
>>>>>>        section and symbol table and what is "Implicit Addend"
>>>>>>      - clarify why we use 32bit read/write for R_BPF_64_64 (ld_imm64)
>>>>>>        relocations.
>>>>>>
>>>>>> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
>>>>>> index a702f67dd45f..93e8cf12a6d4 100644
>>>>>> --- a/Documentation/bpf/index.rst
>>>>>> +++ b/Documentation/bpf/index.rst
>>>>>> @@ -84,6 +84,7 @@ Other
>>>>>>      :maxdepth: 1
>>>>>>
>>>>>>      ringbuf
>>>>>> +   llvm_reloc
>>>>>>
>>>>>> .. Links:
>>>>>> .. _networking-filter: ../networking/filter.rst
>>>>>> diff --git a/Documentation/bpf/llvm_reloc.rst
>>>>>> b/Documentation/bpf/llvm_reloc.rst
>>>>>> new file mode 100644
>>>>>> index 000000000000..5ade0244958f
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/bpf/llvm_reloc.rst
>>>>>> @@ -0,0 +1,240 @@
>>>>>> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>>>> +
>>>>>> +====================
>>>>>> +BPF LLVM Relocations
>>>>>> +====================
>>>>>> +
>>>>>> +This document describes LLVM BPF backend relocation types.
>>>>>> +
>>>>>> +Relocation Record
>>>>>> +=================
>>>>>> +
>>>>>> +LLVM BPF backend records each relocation with the following 16-byte
>>>>>> +ELF structure::
>>>>>> +
>>>>>> +  typedef struct
>>>>>> +  {
>>>>>> +    Elf64_Addr    r_offset;  // Offset from the beginning of section.
>>>>>> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
>>>>>> +  } Elf64_Rel;
>>>>>> +
>>>>>> +For example, for the following code::
>>>>>> +
>>>>>> +  int g1 __attribute__((section("sec")));
>>>>>> +  int g2 __attribute__((section("sec")));
>>>>>> +  static volatile int l1 __attribute__((section("sec")));
>>>>>> +  static volatile int l2 __attribute__((section("sec")));
>>>>>> +  int test() {
>>>>>> +    return g1 + g2 + l1 + l2;
>>>>>> +  }
>>>>>> +
>>>>>> +Compiled with ``clang -target bpf -O2 -c test.c``, the following is
>>>>>> +the code with ``llvm-objdump -dr test.o``::
>>>>>> +
>>>>>> +       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =
>>>>>> 0 ll
>>>>>> +                0000000000000000:  R_BPF_64_64  g1
>>>>>> +       2:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>>>>>> +       3:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =
>>>>>> 0 ll
>>>>>> +                0000000000000018:  R_BPF_64_64  g2
>>>>>> +       5:       61 20 00 00 00 00 00 00 r0 = *(u32 *)(r2 + 0)
>>>>>> +       6:       0f 10 00 00 00 00 00 00 r0 += r1
>>>>>> +       7:       18 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00 r1 =
>>>>>> 8 ll
>>>>>> +                0000000000000038:  R_BPF_64_64  sec
>>>>>> +       9:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>>>>>> +      10:       0f 10 00 00 00 00 00 00 r0 += r1
>>>>>> +      11:       18 01 00 00 0c 00 00 00 00 00 00 00 00 00 00 00 r1 =
>>>>>> 12 ll
>>>>>> +                0000000000000058:  R_BPF_64_64  sec
>>>>>> +      13:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>>>>>> +      14:       0f 10 00 00 00 00 00 00 r0 += r1
>>>>>> +      15:       95 00 00 00 00 00 00 00 exit
>>>>>> +
>>>>>> +There are four relations in the above for four ``LD_imm64``
>>>>>> instructions.
>>>>>> +The following ``llvm-readelf -r test.o`` shows the binary values of
>>>>>> the four
>>>>>> +relocations::
>>>>>> +
>>>>>> +  Relocation section '.rel.text' at offset 0x190 contains 4 entries:
>>>>>> +      Offset             Info             Type               Symbol's
>>>>>> Value  Symbol's Name
>>>>>> +  0000000000000000  0000000600000001 R_BPF_64_64
>>>>>> 0000000000000000 g1
>>>>>> +  0000000000000018  0000000700000001 R_BPF_64_64
>>>>>> 0000000000000004 g2
>>>>>> +  0000000000000038  0000000400000001 R_BPF_64_64
>>>>>> 0000000000000000 sec
>>>>>> +  0000000000000058  0000000400000001 R_BPF_64_64
>>>>>> 0000000000000000 sec
>>>>>> +
>>>>>> +Each relocation is represented by ``Offset`` (8 bytes) and ``Info``
>>>>>> (8 bytes).
>>>>>> +For example, the first relocation corresponds to the first instruction
>>>>>> +(Offset 0x0) and the corresponding ``Info`` indicates the relocation
>>>>>> type
>>>>>> +of ``R_BPF_64_64`` (type 1) and the entry in the symbol table (entry 6).
>>>>>> +The following is the symbol table with ``llvm-readelf -s test.o``::
>>>>>> +
>>>>>> +  Symbol table '.symtab' contains 8 entries:
>>>>>> +     Num:    Value          Size Type    Bind   Vis       Ndx Name
>>>>>> +       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
>>>>>> +       1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS test.c
>>>>>> +       2: 0000000000000008     4 OBJECT  LOCAL  DEFAULT     4 l1
>>>>>> +       3: 000000000000000c     4 OBJECT  LOCAL  DEFAULT     4 l2
>>>>>> +       4: 0000000000000000     0 SECTION LOCAL  DEFAULT     4 sec
>>>>>> +       5: 0000000000000000   128 FUNC    GLOBAL DEFAULT     2 test
>>>>>> +       6: 0000000000000000     4 OBJECT  GLOBAL DEFAULT     4 g1
>>>>>> +       7: 0000000000000004     4 OBJECT  GLOBAL DEFAULT     4 g2
>>>>>> +
>>>>>> +The 6th entry is global variable ``g1`` with value 0.
>>>>>> +
>>>>>> +Similarly, the second relocation is at ``.text`` offset ``0x18``,
>>>>>> instruction 3,
>>>>>> +for global variable ``g2`` which has a symbol value 4, the offset
>>>>>> +from the start of ``.data`` section.
>>>>>> +
>>>>>> +The third and fourth relocations refers to static variables ``l1``
>>>>>> +and ``l2``. From ``.rel.text`` section above, it is not clear
>>>>>> +which symbols they really refers to as they both refers to
>>>>>> +symbol table entry 4, symbol ``sec``, which has ``SECTION`` type
>>>>>
>>>>> STT_SECTION. `SECTION` is just an abbreviated form used by some binary
>>>>> tools.
>>>>
>>>> This is just to match llvm-readelf output. I can add a reference
>>>> to STT_SECTION for the right macro name.
>>>>
>>>>>
>>>>>> +and represents a section. So for static variable or function,
>>>>>> +the section offset is written to the original insn
>>>>>> +buffer, which is called ``IA`` (implicit addend). Looking at
>>>>>> +above insn ``7`` and ``11``, they have section offset ``8`` and ``12``.
>>>>>> +From symbol table, we can find that they correspond to entries ``2``
>>>>>> +and ``3`` for ``l1`` and ``l2``.
>>>>>
>>>>> The other REL based psABIs all use `A` for addend.
>>>>
>>>> I can use `A` as well. The reason I am using `IA` since it is not
>>>> shown in the relocation record and lld used API 'getImplicitAddend()`
>>>> get this value. But I can certainly use `A`.
>>>
>>> An ABI document should stick with standard terms.
>>> The variable names used in an implementation are just informative
>>> (plus I don't see any `IA` in lld's source code).
>>>
>>>>>
>>>>>> +In general, the ``IA`` is 0 for global variables and functions,
>>>>>> +and is the section offset or some computation result based on
>>>>>> +section offset for static variables/functions. The non-section-offset
>>>>>> +case refers to function calls. See below for more details.
>>>>>> +
>>>>>> +Different Relocation Types
>>>>>> +==========================
>>>>>> +
>>>>>> +Six relocation types are supported. The following is an overview and
>>>>>> +``S`` represents the value of the symbol in the symbol table::
>>>>>> +
>>>>>> +  Enum  ELF Reloc Type     Description      BitSize  Offset
>>>>>> Calculation
>>>>>> +  0     R_BPF_NONE         None
>>>>>> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S
>>>>>> + IA
>>>>>> +  2     R_BPF_64_ABS64     normal data      64       r_offset      S
>>>>>> + IA
>>>>>> +  3     R_BPF_64_ABS32     normal data      32       r_offset      S
>>>>>> + IA
>>>>>> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S
>>>>>> + IA
>>>>>> +  10    R_BPF_64_32        call insn        32       r_offset + 4  (S
>>>>>> + IA) / 8 - 1
>>>>>
>>>>> Shifting the offset by 4 looks weird. R_386_32 applies at r_offset.
>>>>> The call instruction  R_BPF_64_32 is strange. Such special calculation
>>>>> should not be named R_BPF_64_32.
>>>>
>>>> Again, we have a backward compatibility issue here. I would like to
>>>> provide an alias for it in llvm relocation header file, but I don't
>>>> know how to do it.
>>>
>>> It is very confusing that R_BPF_64_64 has a 32-bit value.
>>
>> If you like, we can make it as 64bit value.
>> R_BPF_64_64 is for ld_imm64 insn which is a 16byte insn.
>> The bytes 4-7 and 12-15 forms a 64bit value for the instruction.
>> We can do
>>        write32/read32 for bytes 4-7
>>        write32/read32 for bytes 12-15
>> for the relocation. Currently, we limit to bytes 4-7 since
>> in BPF it is really unlikely we have section offset > 4G.
>> But we could extend to full 64bit section offset.
> 
> Such semantics have precedents, e.g. R_AARCH64_ADD_ABS_LO12_NC.
> 
> For BPF, the name can be ABS_LO32: absolute, the low 32-bit value,
> with relocation overflow checking.
> There will be an out-of-range relocation if the value is outside
> [-2**31, 2**32).
> 
> If the value is byte aligned, it will be more natural if you shift r_offset
> so that the linker just relocates some bytes starting at r_offset, instead of
> r_offset+4 or r_offset+12.
> 
> ABS_LO32_NC (no-checking) + ABS_HI32 (absolute, the high 32-bit value) can be
> introduced in the fugure.
> 
>>> Since its computation is the same as R_BPF_64_ABS32, can R_BPF_64_64
>>> be deprecated in favor of R_BPF_64_ABS32?
>>
>> Its computation is the same but R_BPF_64_ABS32 starts from offset
>> and R_BPF_64_64 starts from offset + 4.
>>
>> For R_BPF_64_64, the relocation offset is the *start* of the instruction
>> hence +4 is needed to actually read/write addend.
>>
>> To deprecate R_BPF_64_64 to be the same as R_BPF_64_ABS32, we will
>> need to change relocation offset. This will break existing libbpf
>> and cilium and likely many other tools, so I would prefer not
>> to do this.
> 
> You can add a new relocation type. Backward compatibility is good.
> There can only be forward compatibility issues.
> 
> I see some relocation types which are deemed fundamental on other architectures
> are just being introduced. How could they work without these new relocation
> types anyway?
> 
>>>
>>> There is nothing preventing a relocation type from being used as data
>>> in some cases while code in other cases.
>>> R_BPF_64_64 can be renamed to indicate that it is deprecated.
>>> R_BPF_64_32 can be confused with R_BPF_64_ABS32. You may rename
>>> R_BPF_64_32 to say, R_BPF_64_CALL32.
>>>
>>> For compatibility, only the values matter, not the names.
>>> E.g. on x86, some unused GNU_PROPERTY values were renamed to
>>> GNU_PROPERTY_X86_COMPAT_ISA_1_USED ("COMPAT" for compatibility) while
>>> their values were kept.
>>> Two aarch64 relocation types have been renamed.
>>
>> Renaming sounds a more attractive choice. But a lot of other tools
>> have already used the name and it will be odd and not user friendly
>> to display a different name from llvm.
>>
>> For example elfutils, we have
>>     backends/bpf_symbol.c:    case R_BPF_64_64:
>>     libelf/elf.h:#define R_BPF_64_64
>>
>> My /usr/include/elf.h (from glibc-headers-2.28-149.el8.x86_64) has:
>>     /* BPF specific declarations.  */
>>
>>     #define R_BPF_NONE              0       /* No reloc */
>>     #define R_BPF_64_64             1
>>     #define R_BPF_64_32             10
>>
>> I agree the name is a little misleading, but renaming may cause
>> some confusion in bpf ecosystem. So we prefer to stay as is, but
>> with documentation to explain what each relocation intends to do.
> 
> There are only 3 relocation types. R_BPF_NONE is good.
> There is still time figuring out proper naming and fixing them today.
> Otherwise I foresee that the naming problem will cause continuous confusion to
> other toolchain folks.
> 
> Assuming R_BPF_64_ABS_LO32 convey the correct semantics, you can do
> 
>      #define R_BPF_64_ABS_LO32       1
>      #define R_BPF_64_64             1 /* deprecated alias */
> 
> Similarly, for BPF_64_32:
> 
>      #define R_BPF_64_CALL32         10
>      #define R_BPF_64_32             10 /* deprecated alias */

Do you mean in LLVM ELF relocations, we map both R_BPF_64_CALL32
and R_BPF_64_32 to 10?

--- a/llvm/include/llvm/BinaryFormat/ELFRelocs/BPF.def
+++ b/llvm/include/llvm/BinaryFormat/ELFRelocs/BPF.def
@@ -9,3 +9,4 @@ ELF_RELOC(R_BPF_64_ABS64,    2)
  ELF_RELOC(R_BPF_64_ABS32,    3)
  ELF_RELOC(R_BPF_64_NODYLD32, 4)
  ELF_RELOC(R_BPF_64_32,      10)
+ELF_RELOC(R_BPF_64_CALL32,  10)

This actually won't work because now we have
value 10 mapping to two names and some part of
llvm won't happy.

> 
>>>>>
>>>>>> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64``
>>>>>> instruction.
>>>>>> +The actual to-be-relocated data (0 or section offset)
>>>>>> +is stored at ``r_offset + 4`` and the read/write
>>>>>> +data bitsize is 32 (4 bytes). The relocation can be resolved with
>>>>>> +the symbol value plus implicit addend. Note that the ``BitSize`` is
>>>>>> 32 which
>>>>>> +means the section offset must be less than or equal to ``UINT32_MAX``
>>>>>> and this
>>>>>> +is enforced by LLVM BPF backend.
>>>>>> +
>>>>>> +In another case, ``R_BPF_64_ABS64`` relocation type is used for
>>>>>> normal 64-bit data.
>>>>>> +The actual to-be-relocated data is stored at ``r_offset`` and the
>>>>>> read/write data
>>>>>> +bitsize is 64 (8 bytes). The relocation can be resolved with
>>>>>> +the symbol value plus implicit addend.
>>>>>> +
>>>>>> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for
>>>>>> 32-bit data.
>>>>>> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in
>>>>>> ``.BTF`` and
>>>>>> +``.BTF.ext`` sections. For cases like bcc where llvm
>>>>>> ``ExecutionEngine RuntimeDyld``
>>>>>> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be
>>>>>> resolved
>>>>>> +to actual function/variable address. Otherwise, ``.BTF`` and
>>>>>> ``.BTF.ext``
>>>>>> +become unusable by bcc and kernel.
>>>>>
>>>>> Why cannot R_BPF_64_ABS32 cover the use cases of R_BPF_64_NODYLD32?
>>>>> I haven't seen any relocation type which hard coding knowledge on data
>>>>> sections.
>>>>
>>>> This is due to how .BTF relocation is done. Relocation is against
>>>> loadable symbols but it does not want dynamic linker to resolve them.
>>>> Instead it wants libbpf and kernel to resolve them in a different
>>>> way.
>>>
>>> How is R_BPF_64_NODYLD32 different?
>>> I don't see it is different on https://reviews.llvm.org/D101336   .
>>> I cannot find R_BPF_64_NODYLD32 in the kernel code as well.
>>
>> As I mentioned in the above this is to deal with a case related to
>> runtime dynamic linking relocation (DYLD), JIT style of compilation.
>> kernel won't use this paradigm so you won't find it in the kenrel.
>>
>>>
>>> There may be a misconception that different sections need different
>>> relocation types,
>>> even if the semantics are the same. Such understanding is incorrect.
>>
>> We know this and we don't have this perception such .BTF/.BTF.ext
>> relocation types must be different due to it is a different relocation.
>> It needs a different relocation because its relocation resolution
>> is different from ABS32.
>>
>> I guess I didn't give enough details on why we need this new relocation
>> kind and let me try again.
>>
>> First, the use case is for bcc/bpftrace style LLVM JIT (ExecutionEngine)
>> based compilation. The related bcc code is here:
>>
>> https://github.com/iovisor/bcc/blob/master/src/cc/bpf_module.cc#L453-L498
>> Basically, we will invoke clang CompilerInvocation to generate IR and
>> do a bpf target IR optimization and call
>>      ExecutionEngine->finalizeObject()
>> to generate code.
>>
>> In this particular setting, we set ExecutionEngine to process
>> all sections (including dwarf and BTF sections). And among others,
>> ExecutionEngine will try to *resolve* all relocations for dwarf and
>> BTF sections.
>>
>> The core loop for relocation resolution,
>>
>> void RuntimeDyldImpl::resolveLocalRelocations() {
>>     // Iterate over all outstanding relocations
>>     for (auto it = Relocations.begin(), e = Relocations.end(); it != e;
>> ++it) {
>>       // The Section here (Sections[i]) refers to the section in which the
>>       // symbol for the relocation is located.  The SectionID in the
>> relocation
>>       // entry provides the section to which the relocation will be applied.
>>       unsigned Idx = it->first;
>>       uint64_t Addr = getSectionLoadAddress(Idx);
>>       LLVM_DEBUG(dbgs() << "Resolving relocations Section #" << Idx << "\t"
>>                         << format("%p", (uintptr_t)Addr) << "\n");
>>       resolveRelocationList(it->second, Addr);
>>     }
>>     Relocations.clear();
>> }
>>
>> For example, for the following code,
>> $ cat t.c
>> int g;
>> int test() { return g; }
>> $ clang -target bpf -O2 -g -c t.c
>> $ llvm-readelf -r t.o
>> ...
>>
>> Relocation section '.rel.debug_info' at offset 0x3e0 contains 11
>> entries:
>>       Offset             Info             Type               Symbol's
>> Value  Symbol's Name
>> 0000000000000006  0000000300000003 R_BPF_64_ABS32
>> 0000000000000000 .debug_abbrev
>> 000000000000000c  0000000400000003 R_BPF_64_ABS32
>> 0000000000000000 .debug_str
>> 0000000000000012  0000000400000003 R_BPF_64_ABS32
>> 0000000000000000 .debug_str
>> 0000000000000016  0000000600000003 R_BPF_64_ABS32
>> 0000000000000000 .debug_line
>> 000000000000001a  0000000400000003 R_BPF_64_ABS32
>> 0000000000000000 .debug_str
>> 000000000000001e  0000000200000002 R_BPF_64_ABS64
>> 0000000000000000 .text
>> 000000000000002b  0000000400000003 R_BPF_64_ABS32
>> 0000000000000000 .debug_str
>> 0000000000000037  0000000800000002 R_BPF_64_ABS64         0000000000000000 g
>> 0000000000000040  0000000400000003 R_BPF_64_ABS32
>> 0000000000000000 .debug_str
>> 0000000000000047  0000000200000002 R_BPF_64_ABS64
>> 0000000000000000 .text
>> 0000000000000055  0000000400000003 R_BPF_64_ABS32
>> 0000000000000000 .debug_str
>>
>> Relocation section '.rel.BTF' at offset 0x490 contains 1 entries:
>>       Offset             Info             Type               Symbol's
>> Value  Symbol's Name
>> 0000000000000060  0000000800000004 R_BPF_64_NODYLD32      0000000000000000 g
>>
>> Relocation section '.rel.BTF.ext' at offset 0x4a0 contains 3 entries:
>>       Offset             Info             Type               Symbol's
>> Value  Symbol's Name
>> 000000000000002c  0000000200000004 R_BPF_64_NODYLD32
>> 0000000000000000 .text
>> 0000000000000040  0000000200000004 R_BPF_64_NODYLD32
>> 0000000000000000 .text
>> 0000000000000050  0000000200000004 R_BPF_64_NODYLD32
>> 0000000000000000 .text
>>
>> During JIT relocation resolution, it is OKAY to resolve 'g' to
>> be actual address and actually it is a good thing since tools
>> like bcc actually go through dwarf interface to dump instructions
>> interleaved with source codes.
>>
>> Note that dwarf won't be loaded into the kernel.
>>
>> But we don't want relocations in .BTF/.BTF.ext to be resolved with
>> actually addresses. They will be processed by bpf libraries and the
>> kernel. The reason not to have relocation resolution
>> is not due to their names, but due
>> to their functionality. If we intend to load dwarf to kernel, we
>> will issue R_BPF_64_NODYLD32 to dwarf as well.
> 
> Is the problem due to REL relocations not being idempotent?

No, it is not. This purely depends on how the data will be used
in what situations. BPF is kind of special here. For most JIT
program, after JIT, the program will be executed on host.
But for BPF programs and some other BPF related objects,
after JIT, the program actually will need
to do some other processing and executed in kernel.

> 
>> One can argue we should have fine control in RuntimeDyld so
>> that which section to have runtime relocation resolution
>> and which section does not. I don't know whether
>> ExecutionEngine/RuntimeDyld agree with that or not. But
>> BPF backend perspective, R_BPF_64_ABS32 and R_BPF_64_NODYLD32
>> are two different relocations, they may do something common
>> in some places like lld, but they may do different things
>> in other places like dyld.
> 
> If RELA is used, will the tool be happy if you just unconditionally
> apply relocations?

No. RELA will not fix the issue because the issue is not due to
REL or RELA.

> 
> You are introducing new relocation types anyway, so migrating to RELA may
> simplify a bunch of things. The issue is only about forward compatibility
> for some tools.

This R_BPF_64_NODYLD32 covers 32bit data relocation which we don't want
dynamic linker to change. The section data in object code contains
all the needed information for BPF programs to run and verify, so
R_BPF_64_NODYLD32 is not really used by outside tools. This is evident
because previously we actually have R_BPF_NONE, and we changed
to R_BPF_64_NODYLD32 to make it lld friendly to adjust when merging
multiple sections.

> 
>> Is the above reasonable or you have some further suggestions
>> on how to resolve this? I guess I do need to add some of above
>> discussion in the documentation so it will be clear why we added
>> this relocation.
> 
> Yes, the DYLD part needs clarification.

I explained above. DYLD is really a special use case for BPF
and JITed BPF codes cannot run on the host, it needs to be processed
by bpf loader and run on the kernel. So it puts some constraints on
what dynamic linker should do for the JITed code and sections.

> 
>>>
>>>>>
>>>>>> +Type ``R_BPF_64_32`` is used for call instruction. The call target
>>>>>> section
>>>>>> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
>>>>>> +``(S + IA) / 8 - 1``.
>>>>>
>>>>> In other ABIs, names like 32/ABS32/ABS64 refer to absolute relocation types
>>>>> without such complex operation.
>>>>
>>>> Again, this is a historical artifact to handle call instruction. I am
>>>> aware that this might be different from other architectures. But we have
>>>> to keep backward compatibility...
>>>>
>>>>>
>>>>>> +Examples
>>>>>> +========
>>>>>> +
>>>>>> +Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve
>>>>>> ``ld_imm64``
>>>>>> +and ``call`` instructions. For example::
>>>>>> +
>>>>>> +  __attribute__((noinline)) __attribute__((section("sec1")))
>>>>>> +  int gfunc(int a, int b) {
>>>>>> +    return a * b;
>>>>>> +  }
>>>>>> +  static __attribute__((noinline)) __attribute__((section("sec1")))
>>>>>> +  int lfunc(int a, int b) {
>>>>>> +    return a + b;
>>>>>> +  }
>>>>>> +  int global __attribute__((section("sec2")));
>>>>>> +  int test(int a, int b) {
>>>>>> +    return gfunc(a, b) +  lfunc(a, b) + global;
>>>>>> +  }
>>>>>> +
>>>> [...]
