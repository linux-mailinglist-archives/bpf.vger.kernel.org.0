Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29E39E8DB
	for <lists+bpf@lfdr.de>; Mon,  7 Jun 2021 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFGVIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Jun 2021 17:08:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7978 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhFGVIz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Jun 2021 17:08:55 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157L4JrK023134;
        Mon, 7 Jun 2021 14:06:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=612/5224/Y2MeBUAsuXdstWhVWtbpCQN4rhfaGnhEA4=;
 b=rmpZEz5994AYo0NbY/PX+ZhxfucpbgRUwPDJkYX8Q4fJAs2mAjLdpppr3Qs1DggBXAmG
 gODgTfs7IndUAlXOml4Gm6AUvZ5f4FdsGwt/hNvrN1hIpBfXHqg6QcxLJRuTikVhu08M
 11F26ACJjVQaInFaKh7ZWJCgB4y40XT4ERE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 391mx0jn35-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Jun 2021 14:06:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 14:06:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI/0RBfwU9L3dmxseU+umVfFYCIKU3Ksqd7Xoc4ECGQ40iMw6gUnglDw12pXCGKiHHioOUre+QeBNI3Yvx1WXtw2skA4UGZRJODfO4R2JD1rrfgUIWuQBcp2yuLWhCR7DhTkSIL6AD9Lmc6xIXyXZbfE6oe9VUusWq+S8XXE9z1RMulA17CTKJX7lRWJWwvsXjxJz5auI4BRMQ/DfHSmgJ6XglZ64N4UAKw+qc/tXEy8BtpBLoYOSyvK7W/qHE41eaDoCKNPLsfgK1vm5IKgvzqan571LFx2BNmE6S7IzqRXge19Ruj2RLuqqvdcQLIcrXmq8Rc8O4vdu6iqz6iZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWPua02DmOq+kEzhGbM5satbIJ7I83m4SQEJ5GdSxkE=;
 b=f+7V4xFFO63IScX6xvqdgXCOUBG8WMP3QOZt4uA3iL7nJHnO8zgo/N/fLzMtDPdPRkblGij9mta9b6f74T/oOMwrpl1wRxKdqxa4vR0ASRnsDdsQItc6xgyeCnvGbjZHfXg6lJe+aDnfmHA1ohdWKk7SN84gwDGI77ljC6lWZapzKZdc0KlVnsJkQ8W6dacCiTh5JyBgy+dg3aylqCSC9H6ur1nFuBwoZI6gRVUGCNOC7DaLcKNcUDhR1oKnq2W7S+18hU+kDUUP8kNYS3nsGCFTGJbp2DOHgDPk7+oUxCZD7SSDWIZ+GXwPk1qXVCgS1hRbiZ5EJpDnCGa6sRd4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4808.namprd15.prod.outlook.com (2603:10b6:806:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 21:06:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 21:06:43 +0000
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com>
Date:   Mon, 7 Jun 2021 14:06:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:db22]
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1097] (2620:10d:c090:400::5:db22) by SJ0PR05CA0111.namprd05.prod.outlook.com (2603:10b6:a03:334::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Mon, 7 Jun 2021 21:06:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bc67995-9803-4a1c-48e2-08d929f826ee
X-MS-TrafficTypeDiagnostic: SA1PR15MB4808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB48080EAB7BF2600B40EDFB74D3389@SA1PR15MB4808.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hyNZ4ikxVx46eXXgx3P+Racw4N79DRCBQxcS2zzR4n8kG9TaeMwKE73dnYEQ/Y6GqYuK7zcI+JLFqbJM1uP9P/8W3Oae66MwEWfXY+rHMVMQt8k0eHb7IMw0XIx7Giv7a2yZQ1bE9xIrzb2vkJ5so7xHW6kZlE9O2B/5lzHA9CtILEd5AEdXvsOH32WnF82t6XIIN2A+oPVltji85yce1fsC6JleIiWtP5SRJpExPF5VbzzEK8DS4da2S4AVg27sDBLoAU37Mi/18GsESDplOQbN1aRt84K2pfPXyiYETsnHk6OwHy9BK5FXGAtMPOrtyYBNoguwe7+srfAIUkiHe3rQCzjjKOQBB/wlSYBlprUBkxO8jhE390WtMCAC8KZZ9mosWqMkg5jjduuJFdfAWBDtV4haToZQ9NACQYGOu91CcEBuyugGAru0/6TFcUd6Fj5bT0Do27vtthd+93fySYePGdi9B5kGGQv7+77V4Ao/oL50UKIWOjcwLa4wRqRVks/MZHe25eBQMOJwKw+RZfAb96GeXB+m/u7FM9LWCPH25WvWHkcJFDoBCU54YT2kc/wOL8qj4fpU2u0kxqITmu6DwAXCVGnghmuQXZknQNONwXcVDm99m0sm0p15Hlh6JEuw4sEkEKDassQegwd39glUpaKQK6uV0p63XaKVA5WwV5VoqjtKsvjy5mA6ygK5GxqdDLdQfxkol5roxcVM3SPQE3qnq0eXPfYDsf9nNrBvcpco4XvPr31Nbo5ABLAJWgnMNCudFmq5djnXejC0Rjpcyc3Uk8Ri/iWD5krGoI1K3mJx1Q1qOXmABOJDxBsyx3fCkstyHaPv/qiX8BfdROUmT87KhTBGkViq77cyW7bYem/IG6fWDOAYFDLR+Ls
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(8936002)(478600001)(30864003)(52116002)(66556008)(966005)(316002)(31696002)(38100700002)(53546011)(6916009)(186003)(16526019)(2906002)(36756003)(31686004)(4326008)(6486002)(66476007)(66946007)(5660300002)(86362001)(8676002)(2616005)(66574015)(83380400001)(54906003)(43740500002)(45980500001)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akNVMXBjZnJDZDhkdnRpZ2dnWThIc1hMMXFtWCtTTC94Ymk1Q3R2WTVnOTkw?=
 =?utf-8?B?QjBrcmZCWkkrdE92MjlHN2JCZXBqVkhkTkJIMlBvNElPU0VrQXRUYUd3WGVl?=
 =?utf-8?B?SmlEUkRqSFQweTJocXV1RjJkaXRia1VIaE1kZ0gwajVYSkw0MFBLbWNadWYx?=
 =?utf-8?B?K1p1blhrUCtxb1RKMXkvZHd2NWJacTExQnQ5b3cvOWZWSFFHZmFoRmk4Y1Vw?=
 =?utf-8?B?Z2ljZHJWK3JQaE5FNkszVnZWdDlaQStmVkJ2QUwrSEtNUTRzZWFOTUtiMGFV?=
 =?utf-8?B?TTRmK2paM08vYnhhRExLUnh3RjBsL1UzTE5oQi9GakRMQ2E2QUtRdFNKVEhn?=
 =?utf-8?B?SFo0ZC95R1ova3RxSTRpam00c29kbzJJOVRXZmNITVlGdVdxTjJQSnJCMlVr?=
 =?utf-8?B?cVNUamI1RFlmNDJQWFk4bU9wYzlsd0ZScHNBay9vOXBydVRoWm9iTEZEODQv?=
 =?utf-8?B?LzZBL1pTRjM2SnlXbjd4ZG14OGlUSC81UzBTbmlPNEpzVVFZMTVrdE0xT2Fv?=
 =?utf-8?B?a1dUOFRscDRIZFhLQXA0Wm91U0kzdU1PU2dTeWZNb1g4blN6QnU2OExJbFRl?=
 =?utf-8?B?b0IxMFBjMWRtV3ZybjJLemRYVDc3SW1wdzk5c3ZzUDdmMzRvVG1FaXVRSGtZ?=
 =?utf-8?B?QkVqaERweFpRd1BHVStHcDdTZXFKQS9xaTd1TDVoSzQ5b1l5OU1Oc0pPMVlk?=
 =?utf-8?B?QjBycDMybHRtT1RWUnNzUnBYQ3cvTnZYSjdNMXdpbm5vYytOMHpZTXNKd2Ew?=
 =?utf-8?B?ME1icmJWbSt3WHpDbE94YkxVazRRNHkrdjZ6TFUrR3d6MGV0amU3aU1YakRO?=
 =?utf-8?B?TTJWL01qMUp0enpwVDJKSmwvbWNMRHlkeXBTMHFpb2MvNU9UU0hzMUMyMlNN?=
 =?utf-8?B?MytzUDhzZFQ0NUNYb3A5aHhNTFNXR1lNRmlZNXVYN05XTUl1ZWVyZzh2dDMr?=
 =?utf-8?B?V2htUzBvblZMMHJMZVFDYU0xa2E0WnZxaXVMek9QYTlYY1pjTlRtN29WZFhp?=
 =?utf-8?B?NUFIRnlKOGtCMGhacVg1TVBDdFR1cHJLSFF6c2c2emJubHdpbDVXUzFHeVpa?=
 =?utf-8?B?R0c2QWNLR3FtN3dYN2ZDeEd4dE9hVlZna3VGazVkaFVsUjZVcDdMOUtEblUr?=
 =?utf-8?B?bm1UM1J1dXFRS2FSOTZLZFZQODlBQnQwbHUvVGVxS3F3WE5vL0RrSC9TZmZw?=
 =?utf-8?B?QWF5d1ZFc2lEdGNiS25veVZLNm1yTUVLVHE0M2NQblhrckJ3bmZsUFJYbXVj?=
 =?utf-8?B?ZHlUSVNBbmZqZVhqL1RuSHp1bENySktNN3BmNGRDbHJNMHNLRVBzS2ZSL3Ry?=
 =?utf-8?B?ME5TS2Q2M0dHckI5b2xpSXdXOEpnWjVORVdUUTFKR3lXVUtXcWFPQnlxSDhJ?=
 =?utf-8?B?ZmRPQUJVRFdJTjdBYzdpZVZwekt3ckErT0RqVEFzcThxcGdDRnloaXZwWU5R?=
 =?utf-8?B?OUN3U2hPelI5K0dydllHVjcxall0SGgzellTODRCNCtEUXEzbVdMTVA2T2hj?=
 =?utf-8?B?L2NadVdvODJLc0k0ajBlQ0QvREszb3BMT0NNVDJqcjQ1VG1MVkhIamt0YWN3?=
 =?utf-8?B?YUordDZqdFdyREZGM2xDSENTTitJbnVWUDRoa1NnWTBPK1ZScEJjOGUwQTVT?=
 =?utf-8?B?bFd0eXNXMlhsME9sQmpUMEk0blluNDNUZndoZWlYV2xHT3hNcjZFT3h1NnlE?=
 =?utf-8?B?N2h2dEMvaWFCVUV4VnFPZDRRUzlsUUNkbDBlQlBlRE02dm1zQ0ZJc3k3Q2E0?=
 =?utf-8?B?azZwc0sxLzFxWEFKT1ZHTDVoNkVsZFRXYWRiS0w4Y1pFVmJOd1hFeVh1Rmpt?=
 =?utf-8?Q?MZAM30R0L1LbRrzqbfx8bNicGxTWpOQrw48zM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc67995-9803-4a1c-48e2-08d929f826ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 21:06:43.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEyqwrHAIe/uUEZZ5lfoa6xxVkSMfYYWylPguc0gd52TTiMh4MkEEOwB/uIAAn6B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4808
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: L3-ompfl5AO36t-Kmsb7uOcf9YHehDD7
X-Proofpoint-ORIG-GUID: L3-ompfl5AO36t-Kmsb7uOcf9YHehDD7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_15:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106070142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/5/21 2:03 PM, Fāng-ruì Sòng wrote:
> On Tue, May 25, 2021 at 11:52 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 5/25/21 11:29 AM, Fangrui Song wrote:
>>> I have a review queue with a huge pile of LLVM patches and have only
>>> skimmed through this.
>>>
>>> First, if the size benefit of REL over RELA isn't deem that necessary,
>>> I will highly recommend RELA for simplicity and robustness.
>>> REL is error-prone.
>>
>> The worry is backward compatibility. Because of BPF ELF format
>> is so intervened with bpf eco system (loading, bpf map, etc.),
>> a lot of tools in the wild already implemented to parse REL...
>> It will be difficult to change...
> 
> It seems that the design did not get enough initial scrutiny...
> (On https://reviews.llvm.org/D101336  , a reviewer who has apparently
> never contributed to lld/ELF clicked LGTM without actual reviewing the
> patch and that was why I have to click "Request Changes").
> 
> I worry that keeping the current state as-is can cause much
> maintenance burden in the LLVM MC layer, linker, and other binary
> utilities.
> Some things can be improved without breaking backward compatibility.
> 
>>>
>>> On 2021-05-24, Yonghong Song wrote:
>>>> LLVM upstream commit
>>>> https://reviews.llvm.org/D102712
>>>> made some changes to bpf relocations to make them
>>>> llvm linker lld friendly. The scope of
>>>> existing relocations R_BPF_64_{64,32} is narrowed
>>>> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
>>>> are introduced.
>>>>
>>>> Let us add some documentation about llvm bpf
>>>> relocations so people can understand how to resolve
>>>> them properly in their respective tools.
>>>>
>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>> Cc: Lorenz Bauer <lmb@cloudflare.com>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>> Documentation/bpf/index.rst            |   1 +
>>>> Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++++++
>>>> tools/testing/selftests/bpf/README.rst |  19 ++
>>>> 3 files changed, 260 insertions(+)
>>>> create mode 100644 Documentation/bpf/llvm_reloc.rst
>>>>
>>>> Changelogs:
>>>>   v1 -> v2:
>>>>     - add an example to illustrate how relocations related to base
>>>>       section and symbol table and what is "Implicit Addend"
>>>>     - clarify why we use 32bit read/write for R_BPF_64_64 (ld_imm64)
>>>>       relocations.
>>>>
>>>> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
>>>> index a702f67dd45f..93e8cf12a6d4 100644
>>>> --- a/Documentation/bpf/index.rst
>>>> +++ b/Documentation/bpf/index.rst
>>>> @@ -84,6 +84,7 @@ Other
>>>>     :maxdepth: 1
>>>>
>>>>     ringbuf
>>>> +   llvm_reloc
>>>>
>>>> .. Links:
>>>> .. _networking-filter: ../networking/filter.rst
>>>> diff --git a/Documentation/bpf/llvm_reloc.rst
>>>> b/Documentation/bpf/llvm_reloc.rst
>>>> new file mode 100644
>>>> index 000000000000..5ade0244958f
>>>> --- /dev/null
>>>> +++ b/Documentation/bpf/llvm_reloc.rst
>>>> @@ -0,0 +1,240 @@
>>>> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>> +
>>>> +====================
>>>> +BPF LLVM Relocations
>>>> +====================
>>>> +
>>>> +This document describes LLVM BPF backend relocation types.
>>>> +
>>>> +Relocation Record
>>>> +=================
>>>> +
>>>> +LLVM BPF backend records each relocation with the following 16-byte
>>>> +ELF structure::
>>>> +
>>>> +  typedef struct
>>>> +  {
>>>> +    Elf64_Addr    r_offset;  // Offset from the beginning of section.
>>>> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
>>>> +  } Elf64_Rel;
>>>> +
>>>> +For example, for the following code::
>>>> +
>>>> +  int g1 __attribute__((section("sec")));
>>>> +  int g2 __attribute__((section("sec")));
>>>> +  static volatile int l1 __attribute__((section("sec")));
>>>> +  static volatile int l2 __attribute__((section("sec")));
>>>> +  int test() {
>>>> +    return g1 + g2 + l1 + l2;
>>>> +  }
>>>> +
>>>> +Compiled with ``clang -target bpf -O2 -c test.c``, the following is
>>>> +the code with ``llvm-objdump -dr test.o``::
>>>> +
>>>> +       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =
>>>> 0 ll
>>>> +                0000000000000000:  R_BPF_64_64  g1
>>>> +       2:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>>>> +       3:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =
>>>> 0 ll
>>>> +                0000000000000018:  R_BPF_64_64  g2
>>>> +       5:       61 20 00 00 00 00 00 00 r0 = *(u32 *)(r2 + 0)
>>>> +       6:       0f 10 00 00 00 00 00 00 r0 += r1
>>>> +       7:       18 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00 r1 =
>>>> 8 ll
>>>> +                0000000000000038:  R_BPF_64_64  sec
>>>> +       9:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>>>> +      10:       0f 10 00 00 00 00 00 00 r0 += r1
>>>> +      11:       18 01 00 00 0c 00 00 00 00 00 00 00 00 00 00 00 r1 =
>>>> 12 ll
>>>> +                0000000000000058:  R_BPF_64_64  sec
>>>> +      13:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>>>> +      14:       0f 10 00 00 00 00 00 00 r0 += r1
>>>> +      15:       95 00 00 00 00 00 00 00 exit
>>>> +
>>>> +There are four relations in the above for four ``LD_imm64``
>>>> instructions.
>>>> +The following ``llvm-readelf -r test.o`` shows the binary values of
>>>> the four
>>>> +relocations::
>>>> +
>>>> +  Relocation section '.rel.text' at offset 0x190 contains 4 entries:
>>>> +      Offset             Info             Type               Symbol's
>>>> Value  Symbol's Name
>>>> +  0000000000000000  0000000600000001 R_BPF_64_64
>>>> 0000000000000000 g1
>>>> +  0000000000000018  0000000700000001 R_BPF_64_64
>>>> 0000000000000004 g2
>>>> +  0000000000000038  0000000400000001 R_BPF_64_64
>>>> 0000000000000000 sec
>>>> +  0000000000000058  0000000400000001 R_BPF_64_64
>>>> 0000000000000000 sec
>>>> +
>>>> +Each relocation is represented by ``Offset`` (8 bytes) and ``Info``
>>>> (8 bytes).
>>>> +For example, the first relocation corresponds to the first instruction
>>>> +(Offset 0x0) and the corresponding ``Info`` indicates the relocation
>>>> type
>>>> +of ``R_BPF_64_64`` (type 1) and the entry in the symbol table (entry 6).
>>>> +The following is the symbol table with ``llvm-readelf -s test.o``::
>>>> +
>>>> +  Symbol table '.symtab' contains 8 entries:
>>>> +     Num:    Value          Size Type    Bind   Vis       Ndx Name
>>>> +       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
>>>> +       1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS test.c
>>>> +       2: 0000000000000008     4 OBJECT  LOCAL  DEFAULT     4 l1
>>>> +       3: 000000000000000c     4 OBJECT  LOCAL  DEFAULT     4 l2
>>>> +       4: 0000000000000000     0 SECTION LOCAL  DEFAULT     4 sec
>>>> +       5: 0000000000000000   128 FUNC    GLOBAL DEFAULT     2 test
>>>> +       6: 0000000000000000     4 OBJECT  GLOBAL DEFAULT     4 g1
>>>> +       7: 0000000000000004     4 OBJECT  GLOBAL DEFAULT     4 g2
>>>> +
>>>> +The 6th entry is global variable ``g1`` with value 0.
>>>> +
>>>> +Similarly, the second relocation is at ``.text`` offset ``0x18``,
>>>> instruction 3,
>>>> +for global variable ``g2`` which has a symbol value 4, the offset
>>>> +from the start of ``.data`` section.
>>>> +
>>>> +The third and fourth relocations refers to static variables ``l1``
>>>> +and ``l2``. From ``.rel.text`` section above, it is not clear
>>>> +which symbols they really refers to as they both refers to
>>>> +symbol table entry 4, symbol ``sec``, which has ``SECTION`` type
>>>
>>> STT_SECTION. `SECTION` is just an abbreviated form used by some binary
>>> tools.
>>
>> This is just to match llvm-readelf output. I can add a reference
>> to STT_SECTION for the right macro name.
>>
>>>
>>>> +and represents a section. So for static variable or function,
>>>> +the section offset is written to the original insn
>>>> +buffer, which is called ``IA`` (implicit addend). Looking at
>>>> +above insn ``7`` and ``11``, they have section offset ``8`` and ``12``.
>>>> +From symbol table, we can find that they correspond to entries ``2``
>>>> +and ``3`` for ``l1`` and ``l2``.
>>>
>>> The other REL based psABIs all use `A` for addend.
>>
>> I can use `A` as well. The reason I am using `IA` since it is not
>> shown in the relocation record and lld used API 'getImplicitAddend()`
>> get this value. But I can certainly use `A`.
> 
> An ABI document should stick with standard terms.
> The variable names used in an implementation are just informative
> (plus I don't see any `IA` in lld's source code).
> 
>>>
>>>> +In general, the ``IA`` is 0 for global variables and functions,
>>>> +and is the section offset or some computation result based on
>>>> +section offset for static variables/functions. The non-section-offset
>>>> +case refers to function calls. See below for more details.
>>>> +
>>>> +Different Relocation Types
>>>> +==========================
>>>> +
>>>> +Six relocation types are supported. The following is an overview and
>>>> +``S`` represents the value of the symbol in the symbol table::
>>>> +
>>>> +  Enum  ELF Reloc Type     Description      BitSize  Offset
>>>> Calculation
>>>> +  0     R_BPF_NONE         None
>>>> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S
>>>> + IA
>>>> +  2     R_BPF_64_ABS64     normal data      64       r_offset      S
>>>> + IA
>>>> +  3     R_BPF_64_ABS32     normal data      32       r_offset      S
>>>> + IA
>>>> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S
>>>> + IA
>>>> +  10    R_BPF_64_32        call insn        32       r_offset + 4  (S
>>>> + IA) / 8 - 1
>>>
>>> Shifting the offset by 4 looks weird. R_386_32 applies at r_offset.
>>> The call instruction  R_BPF_64_32 is strange. Such special calculation
>>> should not be named R_BPF_64_32.
>>
>> Again, we have a backward compatibility issue here. I would like to
>> provide an alias for it in llvm relocation header file, but I don't
>> know how to do it.
> 
> It is very confusing that R_BPF_64_64 has a 32-bit value.

If you like, we can make it as 64bit value.
R_BPF_64_64 is for ld_imm64 insn which is a 16byte insn.
The bytes 4-7 and 12-15 forms a 64bit value for the instruction.
We can do
      write32/read32 for bytes 4-7
      write32/read32 for bytes 12-15
for the relocation. Currently, we limit to bytes 4-7 since
in BPF it is really unlikely we have section offset > 4G.
But we could extend to full 64bit section offset.

> Since its computation is the same as R_BPF_64_ABS32, can R_BPF_64_64
> be deprecated in favor of R_BPF_64_ABS32?

Its computation is the same but R_BPF_64_ABS32 starts from offset
and R_BPF_64_64 starts from offset + 4.

For R_BPF_64_64, the relocation offset is the *start* of the instruction
hence +4 is needed to actually read/write addend.

To deprecate R_BPF_64_64 to be the same as R_BPF_64_ABS32, we will
need to change relocation offset. This will break existing libbpf
and cilium and likely many other tools, so I would prefer not
to do this.

> 
> There is nothing preventing a relocation type from being used as data
> in some cases while code in other cases.
> R_BPF_64_64 can be renamed to indicate that it is deprecated.
> R_BPF_64_32 can be confused with R_BPF_64_ABS32. You may rename
> R_BPF_64_32 to say, R_BPF_64_CALL32.
> 
> For compatibility, only the values matter, not the names.
> E.g. on x86, some unused GNU_PROPERTY values were renamed to
> GNU_PROPERTY_X86_COMPAT_ISA_1_USED ("COMPAT" for compatibility) while
> their values were kept.
> Two aarch64 relocation types have been renamed.

Renaming sounds a more attractive choice. But a lot of other tools
have already used the name and it will be odd and not user friendly
to display a different name from llvm.

For example elfutils, we have
   backends/bpf_symbol.c:    case R_BPF_64_64:
   libelf/elf.h:#define R_BPF_64_64

My /usr/include/elf.h (from glibc-headers-2.28-149.el8.x86_64) has:
   /* BPF specific declarations.  */

   #define R_BPF_NONE              0       /* No reloc */
   #define R_BPF_64_64             1
   #define R_BPF_64_32             10

I agree the name is a little misleading, but renaming may cause
some confusion in bpf ecosystem. So we prefer to stay as is, but
with documentation to explain what each relocation intends to do.

> 
>>>
>>>> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64``
>>>> instruction.
>>>> +The actual to-be-relocated data (0 or section offset)
>>>> +is stored at ``r_offset + 4`` and the read/write
>>>> +data bitsize is 32 (4 bytes). The relocation can be resolved with
>>>> +the symbol value plus implicit addend. Note that the ``BitSize`` is
>>>> 32 which
>>>> +means the section offset must be less than or equal to ``UINT32_MAX``
>>>> and this
>>>> +is enforced by LLVM BPF backend.
>>>> +
>>>> +In another case, ``R_BPF_64_ABS64`` relocation type is used for
>>>> normal 64-bit data.
>>>> +The actual to-be-relocated data is stored at ``r_offset`` and the
>>>> read/write data
>>>> +bitsize is 64 (8 bytes). The relocation can be resolved with
>>>> +the symbol value plus implicit addend.
>>>> +
>>>> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for
>>>> 32-bit data.
>>>> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in
>>>> ``.BTF`` and
>>>> +``.BTF.ext`` sections. For cases like bcc where llvm
>>>> ``ExecutionEngine RuntimeDyld``
>>>> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be
>>>> resolved
>>>> +to actual function/variable address. Otherwise, ``.BTF`` and
>>>> ``.BTF.ext``
>>>> +become unusable by bcc and kernel.
>>>
>>> Why cannot R_BPF_64_ABS32 cover the use cases of R_BPF_64_NODYLD32?
>>> I haven't seen any relocation type which hard coding knowledge on data
>>> sections.
>>
>> This is due to how .BTF relocation is done. Relocation is against
>> loadable symbols but it does not want dynamic linker to resolve them.
>> Instead it wants libbpf and kernel to resolve them in a different
>> way.
> 
> How is R_BPF_64_NODYLD32 different?
> I don't see it is different on https://reviews.llvm.org/D101336  .
> I cannot find R_BPF_64_NODYLD32 in the kernel code as well.

As I mentioned in the above this is to deal with a case related to 
runtime dynamic linking relocation (DYLD), JIT style of compilation.
kernel won't use this paradigm so you won't find it in the kenrel.

> 
> There may be a misconception that different sections need different
> relocation types,
> even if the semantics are the same. Such understanding is incorrect.

We know this and we don't have this perception such .BTF/.BTF.ext
relocation types must be different due to it is a different relocation.
It needs a different relocation because its relocation resolution
is different from ABS32.

I guess I didn't give enough details on why we need this new relocation
kind and let me try again.

First, the use case is for bcc/bpftrace style LLVM JIT (ExecutionEngine)
based compilation. The related bcc code is here:
 
https://github.com/iovisor/bcc/blob/master/src/cc/bpf_module.cc#L453-L498
Basically, we will invoke clang CompilerInvocation to generate IR and
do a bpf target IR optimization and call
    ExecutionEngine->finalizeObject()
to generate code.

In this particular setting, we set ExecutionEngine to process
all sections (including dwarf and BTF sections). And among others, 
ExecutionEngine will try to *resolve* all relocations for dwarf and
BTF sections.

The core loop for relocation resolution,

void RuntimeDyldImpl::resolveLocalRelocations() {
   // Iterate over all outstanding relocations
   for (auto it = Relocations.begin(), e = Relocations.end(); it != e; 
++it) {
     // The Section here (Sections[i]) refers to the section in which the
     // symbol for the relocation is located.  The SectionID in the 
relocation
     // entry provides the section to which the relocation will be applied.
     unsigned Idx = it->first;
     uint64_t Addr = getSectionLoadAddress(Idx);
     LLVM_DEBUG(dbgs() << "Resolving relocations Section #" << Idx << "\t"
                       << format("%p", (uintptr_t)Addr) << "\n");
     resolveRelocationList(it->second, Addr);
   }
   Relocations.clear();
}

For example, for the following code,
$ cat t.c
int g;
int test() { return g; }
$ clang -target bpf -O2 -g -c t.c
$ llvm-readelf -r t.o
...

Relocation section '.rel.debug_info' at offset 0x3e0 contains 11 
entries:
     Offset             Info             Type               Symbol's 
Value  Symbol's Name
0000000000000006  0000000300000003 R_BPF_64_ABS32 
0000000000000000 .debug_abbrev
000000000000000c  0000000400000003 R_BPF_64_ABS32 
0000000000000000 .debug_str
0000000000000012  0000000400000003 R_BPF_64_ABS32 
0000000000000000 .debug_str
0000000000000016  0000000600000003 R_BPF_64_ABS32 
0000000000000000 .debug_line
000000000000001a  0000000400000003 R_BPF_64_ABS32 
0000000000000000 .debug_str
000000000000001e  0000000200000002 R_BPF_64_ABS64 
0000000000000000 .text
000000000000002b  0000000400000003 R_BPF_64_ABS32 
0000000000000000 .debug_str
0000000000000037  0000000800000002 R_BPF_64_ABS64         0000000000000000 g
0000000000000040  0000000400000003 R_BPF_64_ABS32 
0000000000000000 .debug_str
0000000000000047  0000000200000002 R_BPF_64_ABS64 
0000000000000000 .text
0000000000000055  0000000400000003 R_BPF_64_ABS32 
0000000000000000 .debug_str

Relocation section '.rel.BTF' at offset 0x490 contains 1 entries:
     Offset             Info             Type               Symbol's 
Value  Symbol's Name
0000000000000060  0000000800000004 R_BPF_64_NODYLD32      0000000000000000 g

Relocation section '.rel.BTF.ext' at offset 0x4a0 contains 3 entries:
     Offset             Info             Type               Symbol's 
Value  Symbol's Name
000000000000002c  0000000200000004 R_BPF_64_NODYLD32 
0000000000000000 .text
0000000000000040  0000000200000004 R_BPF_64_NODYLD32 
0000000000000000 .text
0000000000000050  0000000200000004 R_BPF_64_NODYLD32 
0000000000000000 .text

During JIT relocation resolution, it is OKAY to resolve 'g' to
be actual address and actually it is a good thing since tools
like bcc actually go through dwarf interface to dump instructions
interleaved with source codes.

Note that dwarf won't be loaded into the kernel.

But we don't want relocations in .BTF/.BTF.ext to be resolved with
actually addresses. They will be processed by bpf libraries and the 
kernel. The reason not to have relocation resolution
is not due to their names, but due
to their functionality. If we intend to load dwarf to kernel, we
will issue R_BPF_64_NODYLD32 to dwarf as well.

One can argue we should have fine control in RuntimeDyld so
that which section to have runtime relocation resolution
and which section does not. I don't know whether 
ExecutionEngine/RuntimeDyld agree with that or not. But
BPF backend perspective, R_BPF_64_ABS32 and R_BPF_64_NODYLD32
are two different relocations, they may do something common
in some places like lld, but they may do different things
in other places like dyld.

Is the above reasonable or you have some further suggestions
on how to resolve this? I guess I do need to add some of above
discussion in the documentation so it will be clear why we added
this relocation.

> 
>>>
>>>> +Type ``R_BPF_64_32`` is used for call instruction. The call target
>>>> section
>>>> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
>>>> +``(S + IA) / 8 - 1``.
>>>
>>> In other ABIs, names like 32/ABS32/ABS64 refer to absolute relocation types
>>> without such complex operation.
>>
>> Again, this is a historical artifact to handle call instruction. I am
>> aware that this might be different from other architectures. But we have
>> to keep backward compatibility...
>>
>>>
>>>> +Examples
>>>> +========
>>>> +
>>>> +Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve
>>>> ``ld_imm64``
>>>> +and ``call`` instructions. For example::
>>>> +
>>>> +  __attribute__((noinline)) __attribute__((section("sec1")))
>>>> +  int gfunc(int a, int b) {
>>>> +    return a * b;
>>>> +  }
>>>> +  static __attribute__((noinline)) __attribute__((section("sec1")))
>>>> +  int lfunc(int a, int b) {
>>>> +    return a + b;
>>>> +  }
>>>> +  int global __attribute__((section("sec2")));
>>>> +  int test(int a, int b) {
>>>> +    return gfunc(a, b) +  lfunc(a, b) + global;
>>>> +  }
>>>> +
>> [...]
