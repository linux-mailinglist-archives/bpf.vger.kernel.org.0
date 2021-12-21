Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF347BA0C
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 07:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhLUGeU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 01:34:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20236 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230245AbhLUGeT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Dec 2021 01:34:19 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BL1putU007896;
        Mon, 20 Dec 2021 22:34:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BtmubMKHNIjTKAIo8U4oPh+JERRwVZHXMLAqvkULqvU=;
 b=fimdSp/tF+MwVr8bcFBnmeE+gErnN15QokoijIYcR2yBxvFOUUbXnxs73OewLtDvX/tw
 ZdEYrxY3qgKIHP3aF8L4EBQRMqUjU28zy3bLnrwL40N/KCRXs96gEn/gQMDLYCv3EzDt
 WES7ZDbWRtoPe/GwtrgIYajoX0q5hQzG5pY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d35mu17sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Dec 2021 22:34:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 22:34:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIIKB4VPAKtGC/6GWDPw4ackYP0oElpZVttL8M0fCXd/R2bJjws5di3ZsZwD5eJEfvNWKpG+5swWZhbF0scQkuBq3H6yUfQFI0Ml/UZhq5fY4NbIU5jLi9Oj2HIC4EZVby4YrxIHRB0uxnXVC0l6Em3MoOH2vzTMAw/l45M/dht2+33RUUfPJLXdvBHIqALbgfYHuDaujvDGSTha9pPb9kcdcLsF2C8mAbnqE5xTHSzDySjzNXNzrOkr6ri93yEayMqNzYtpdKJ6x5PAZ++lmnkV2c7b5Z5e54b77K3w2V5Sm0ljmXAcGmdO8QjWhPSspT2gvAX69w0JRTAwTLX3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtmubMKHNIjTKAIo8U4oPh+JERRwVZHXMLAqvkULqvU=;
 b=PDLDLdh/Siix86Nem8FoPFxHhRlQ4CqnVFTqVfHMayyxjM3I5MC0STJ6ym2XMsHdtMBfXacu20YpmIc0Xaw4X3LrrfeihQCipXIGlxR5g/SOGuJMO6VhuPFrBHv+WBDlZT4+Egu9xwQF6CUKY4zyZwFwZOwJCUQaY5/0WEgHZLvCWWlsO+DYgkT5cjP/gG8It94DMymGTSr/RCnFM24ts0vJKw2R2dudgzHwqspTHnct/AqLaxsgTI7j1V9jAT+NOeR1BBKGj4UxYGRimgKvf20EEMqAM3t58lltt4s9rIeV13RT3cJVhhOZ7IiT1OlLuusRU0WB+EDckxzweyzXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3822.namprd15.prod.outlook.com (2603:10b6:806:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 06:34:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 06:34:01 +0000
Message-ID: <177da568-8410-36d6-5f95-c5792ba47d62@fb.com>
Date:   Mon, 20 Dec 2021 22:33:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
Content-Language: en-US
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
 <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
 <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
 <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:303:b9::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71ae9772-c3ff-4735-05a3-08d9c44be084
X-MS-TrafficTypeDiagnostic: SA0PR15MB3822:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB38221471C84F2DEBDF435E60D37C9@SA0PR15MB3822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEREgcvU1gzxYVyiQjri2VoM2Y8pxqyaDy3LRYHPtOzSzF3z4X/KP618p8E6WEvRDHS+NsiPXl+curUZJ4aIxixIR0r+C4M6uDvPKeZljGOLUh8MdsB/bB0BDR5AxftPOwGS4ymyxWN+vGCLhNhuh+2+8ifEn1b+h/lokReK6qadUgQ54wgDVcsrUS9au+xP2lmCk+XWkoKMhikxYi0diwbjZt60xGU4TC1b9waTLt4J8RGXyJGt9MQ84kS/sy80Aqi2RmPD8E6HVBMXJkfLvMSLy3W9r1sqH++u9WfK+sSQkfG/aCDYfLjj80uuIzurzltRTSJJ9AqbbPlM2NGOFhYZeRGKx3bxVhsmSOjb65NH8a5/OyYOhz1jIcQfSxGZL5+H7rtaRrQ0XcpGiXKSXftDgOWANsXPW0uU7bsjbdCl2Gl6rRrxTFy/PHMBeAgbaOf+lJ4SzpJGBC1mzN4geXHlVNlNrkMt31ihFf1WxXWA5P5J89hktOfFjcQv5g2Y9rTFxGfF9syTrR4NlqcMVyHE+TrUrzIgsuxz0XcDm3JaQW8/2l7iL1KYAVoJvY+2P3AkpiXrp6Cmt4EbX6nDSthYUXfH73yMxneSYSWk1OVw66bBph5HG6+t7ZixsszcP7rTkuQNrHXfThMqGmoI6jym7TeUqPqAV9tgDw+8+9YVIZUVsgpquYhGEJVhg2LsXfKRtpAx+fz2keOmLwnnUCZByMKljfrP0cI6rngk8smjmKmwESuh8+1qlbtMyIQ0pgk6WjWARSbBTT2EwDaiwPIkwNxCkS8h85KeM4J2xHvt64kIXVYwWW4gaARAxy3MPxqoVVF9YxMmW0FkSp88qdVGR+mY2SjIIP0DqrLVRiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6512007)(38100700002)(53546011)(54906003)(110136005)(316002)(31696002)(186003)(6486002)(83380400001)(31686004)(36756003)(66476007)(5660300002)(966005)(52116002)(2616005)(2906002)(508600001)(8676002)(66946007)(4326008)(6506007)(8936002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlxYUxRYVd3dlAyTmJrdDMrZVQ2c3g4cXJ1Vkhkb2lTMjQ0clpSdlBWM09W?=
 =?utf-8?B?ano2WDFHWlkycVRpRWEvSDgyN1Z0dW4wQXZsV0NtT2NQeWQ0OGNyUXRuN2pU?=
 =?utf-8?B?ZlRpT1BmYlpwalV3L2lodk0rYVd4SGZzWUlOVXhBK29yZjk4VEovUUk2SFZ2?=
 =?utf-8?B?TGVoWGJOS1FNcWp1bDVrSkVKc2U4a212WHJwRHZaNldadEd6ekZiNXpyNXpj?=
 =?utf-8?B?UjdBWk5Ybi9Ea0RiY3F1SGhEUStmTCsyQTNPd3BzVHFxQ3FQZngrVnR2am16?=
 =?utf-8?B?THBVQmMzMzR3TXR5b0dxUEJZeCs5ZCtINWpCNEFjZ3N2Y3lZTXBoUTdxV3gv?=
 =?utf-8?B?aHFnb2Zqa0NRTTk2c3BKR0hNWFBjaFk1cG0ySW9HYzdyc2JvRXc3bjk4aEs4?=
 =?utf-8?B?dnlQUWhSZEo2cnR6Y1hZVTNQK3IrTC9zb1pXdk1JUnd4c29JOSsycFpzMHpP?=
 =?utf-8?B?ZnhTNE9WWHhZOHhnVTdkcGg3bHd6THpPSU10ZGhzOUhicVpGMGsrcEZQVFdE?=
 =?utf-8?B?VE1ranBkRjUxMFluOGVzMGFxVElZZHpRTWZOWXVIUXRnQTFsZEx6eGwwL21W?=
 =?utf-8?B?ODQ0K29HZ0hIbzhXazNPY3grckVadmc3WXJtOS9ZdVFZZXJiVUxpSTZqOUpl?=
 =?utf-8?B?NktwTUU0K2FaWUVTV3B6V1AxRWw0S1FOV3p1SmhDTHRaMkorM2tUS2FYcXN1?=
 =?utf-8?B?N0wzWlRzN1drNUJXM09EWDRsMnMrZHB6bUxoN3FtNVUxLy9ISXdVaVVmM2Jq?=
 =?utf-8?B?bkhkbUJEVTF5bkF4Vk5xa3NHMnNDdkQ5ZTVWUkNhaHdxZVFXRUQ1N0VTUGw4?=
 =?utf-8?B?a1RzdHRNVVBKbHorUENmMG1PRDhhMXk3OEdmU1JMMEtwWXNIRGxWQlh1Ujlz?=
 =?utf-8?B?VGdySVF2a3NFRk1oM3doYmRydSsyS1NFd1RWdjBHNXJocTgvT1AyLzdzNEYy?=
 =?utf-8?B?TW83RVppT1cxRVhNaVUwL2g4R0ZIN1hzZENaaEFMZGRJMG9xcmZaQ2QyeHRM?=
 =?utf-8?B?MXlyL2hiMWJKc0JNR0dPR3pYa3MrTGtjREtSNldQZ09UK3NIM0JuQmdTYlJa?=
 =?utf-8?B?dmt4TU4wQjBzUWR3dlo4NVdlQUIzY2l1c3NNaXcwQy9YY2dHbzl3YjFKQTR3?=
 =?utf-8?B?Z1p6Z3U1SlNQYnBVTFdFcW8yOGdmTGY5b1krQmw0ZkxWZDJSU04rMzNMY3lz?=
 =?utf-8?B?d2hCNXdaUkRDNStXMTlKM1JyMTIvSEZMU2FiZUFQZUFtdDN0SHdJMU1SQlkv?=
 =?utf-8?B?NVRnSU15NWVwSFFhSHJpbWo2aDFOR04xYkZCeEZjektwb2dLUHo3VnpKVzE5?=
 =?utf-8?B?MlVQK0xXZlJ5aUFOeHZMUDBxaVJwdHVyUkt0VTkrYWdLeXZHTE1UYzNGZjMz?=
 =?utf-8?B?NXRtTWNVaGRCZTRSSE9CbjMwRTEvZFB2S2pIeHhuRW5vZXQ3cUpFbnNybGNV?=
 =?utf-8?B?TnVHcmtRZ1F2NzRKcTNXWjlrcnVsMGVtQ0Q3eHNmYWhtMURVZ0hkWHJJYmdJ?=
 =?utf-8?B?dm9wb1V4a256Und6c3R5Q0NiK25abnptamZHTy9DSlAwRk5aSEtEVmtmVHFI?=
 =?utf-8?B?VWFHU2lmQk5BMTFMOEFMaDhEWUl1VlA5NW91R2k5R1Rjb0tmbVptQWFUSTd1?=
 =?utf-8?B?Q3cxQ0N3Rkw4ZW5CYUpZY1lYbHBla0RCSXpTWjliOTlkaWllVGI5UC80Snpv?=
 =?utf-8?B?RzQ5aFRyQ1pRZXVzZ1ZoRzk4NGhMUFh2WjJqMFc3UWQzR1VHdzBTV0lkbWxI?=
 =?utf-8?B?U1dueTRwV1BVcWN5bkxpZkdjMmovejNOYWduLy9pa0daT3hNd3EzTElXZmNB?=
 =?utf-8?B?ZDE5bWduUjZjSHJjR0x5M3hjVXVqWlh4RC96SzgrK1dQOW54Z3B4RkZHZ2pV?=
 =?utf-8?B?WWs5N1IwNEliSVhITzFlVktGWVJ0MGdWM1NKZVYwZnRrekphQXpNOHh0Umtt?=
 =?utf-8?B?eDVNaElTakIyYTlXcWFSYVVYZjZHcjZIR1VONG9ZcmJHOTYvenFScHZZU1hQ?=
 =?utf-8?B?K2p6WVpJU09jSk5nM0psYkpZN1ZlNGlrYmlpZ1pDWENyOW1TWDdMOVlnM2NB?=
 =?utf-8?B?NkhxNkNLNVBnSFVmVDNtRE1NL0Q5RnUxTkJHa2REc052a2VONXpKVS9GRncz?=
 =?utf-8?Q?XafZ3zmuRigfAuAWBQN82QKug?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ae9772-c3ff-4735-05a3-08d9c44be084
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 06:34:01.9069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9DJBHxW/yGPg83tyxqibYY1mqM3926L6lLOBDMYO2NnFPTdYvePMaSiv4rdDQfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3822
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: H7vSYQq7pLbsXHaTYJNEL2ZZtOcyWAlh
X-Proofpoint-ORIG-GUID: H7vSYQq7pLbsXHaTYJNEL2ZZtOcyWAlh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_02,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/17/21 11:31 AM, Matteo Croce wrote:
>   On Wed, Dec 15, 2021 at 7:21 PM Matteo Croce
> <mcroce@linux.microsoft.com> wrote:
>>
>> On Wed, Dec 15, 2021 at 6:29 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Wed, Dec 15, 2021 at 6:54 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>>>>>
>>>>> Maybe do a level check here?
>>>>> Since calling it and immediately returning doesn't conserve
>>>>> the stack.
>>>>> If it gets called it can finish fine, but
>>>>> calling it again would be too much.
>>>>> In other words checking the level here gives us
>>>>> room for one more frame.
>>>>>
>>>>
>>>> I thought that the compiler was smart enough to return before
>>>> allocating most of the frame.
>>>> I tried and this is true only with gcc, not with clang.
>>>
>>> Interesting. That's a surprise.
>>> Could you share the asm that gcc generates?
>>>
>>
>> Sure,
>>
>> This is the gcc x86_64 asm on a stripped down
>> bpf_core_types_are_compat() with a 1k struct on the stack:
>>
>> bpf_core_types_are_compat:
>> test esi, esi
>> jle .L69
>> push r15
>> push r14
>> push r13
>> push r12
>> push rbp
>> mov rbp, rdi
>> push rbx
>> mov ebx, esi
>> sub rsp, 9112
>> [...]
>> .L69:
>> or eax, -1
>> ret
>>
>> This latest clang:
>>
>> bpf_core_types_are_compat: # @bpf_core_types_are_compat
>> push rbp
>> push r15
>> push r14
>> push rbx
>> sub rsp, 1000
>> mov r14d, -1
>> test esi, esi
>> jle .LBB0_7
>> [...]
>> .LBB0_7:
>> mov eax, r14d
>> add rsp, 1000
>> pop rbx
>> pop r14
>> pop r15
>> pop rbp
>> ret
>>
>>>>>> +                       err = __bpf_core_types_are_compat(local_btf, local_id,
>>>>>> +                                                         targ_btf, targ_id,
>>>>>> +                                                         level - 1);
>>>>>> +                       if (err <= 0)
>>>>>> +                               return err;
>>>>>> +               }
>>>>>> +
>>>>>> +               /* tail recurse for return type check */
>>>>>> +               btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
>>>>>> +               btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
>>>>>> +               goto recur;
>>>>>> +       }
>>>>>> +       default:
>>>>>> +               pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
>>>>>> +                       btf_type_str(local_type), local_id, targ_id);
>>>>>
>>>>> That should be bpf_log() instead.
>>>>>
>>>>
>>>> To do that I need a struct bpf_verifier_log, which is not present
>>>> there, neither in bpf_core_spec_match() or bpf_core_apply_relo_insn().
>>>
>>> It is there. See:
>>>          err = bpf_core_apply_relo_insn((void *)ctx->log, insn, ...
>>>
>>>> Should we drop the message at all?
>>>
>>> Passing it into bpf_core_spec_match() and further into
>>> bpf_core_types_are_compat() is probably unnecessary.
>>> All callers have an error check with a log right after.
>>> So I think we won't lose anything if we drop this log.
>>>
>>
>> Nice.
>>
>>>>
>>>>>> +               return 0;
>>>>>> +       }
>>>>>> +}
>>>>>
>>>>> Please add tests that exercise this logic by enabling
>>>>> additional lskels and a new test that hits the recursion limit.
>>>>> I suspect we don't have such case in selftests.
>>>>>
>>>>> Thanks!
>>>>
>>>> Will do!
>>>
>>> Thanks!
>>
> 
> Hi,
> 
> I'm writing a test which exercise that function.
> I can succesfully trigger a call to __bpf_core_types_are_compat() with
> these  calls:
> 
> bpf_core_type_id_kernel(struct sk_buff);
> bpf_core_type_exists(struct sk_buff);
> bpf_core_type_size(struct sk_buff);
> 
> but the kind will obviously be BTF_KIND_STRUCT.
> I'm trying to do the same with kind BTF_KIND_FUNC_PROTO instead with:
> 
> void func_proto(int, unsigned int);
> bpf_core_type_id_kernel(func_proto);
> 
> but I get a clang crash[1], while just checking the existence with:
> 
> typedef int (*func_proto_typedef)(struct sk_buff *);
> bpf_core_type_exists(func_proto_typedef);
> 
> I don't reach even bpf_core_spec_match().
> 
> Which is a simple way to generate a BTF_KIND_FUNC_PROTO BTF field?
> 
> [1] https://github.com/llvm/llvm-project/issues/52779

Thanks for Matteo. The error message is improved in 
https://reviews.llvm.org/D116063 to make it easy to understand the 
problem. I also posted the explanation here so other people, if hitting
a similar issue, can be aware of what is going on.

The following is a simple reproducible test case:

$ cat bug.c 

extern int do_smth(int); 
 

int test() { 
 

   return __builtin_btf_type_id(*(typeof(do_smth) *)do_smth, 1); 
 

} 
 

$ clang -target bpf -O2 -g -c bug.c 

fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
...
Let us try to reproduce the IR to see what is really going on with command,

clang -target bpf -O2 -g bug.c -emit-llvm -S -Xclang -disable-llvm-passes
The IR,

define dso_local i32 @test() #0 !dbg !7 {
entry:
   %0 = call i64 @llvm.bpf.btf.type.id(i32 0, i64 1), !dbg !12, 
!llvm.preserve.access.index !13
   %conv = trunc i64 %0 to i32, !dbg !12
   ret i32 %conv, !dbg !15
}
...
!7 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 2, 
type: !8, scopeLine: 2, flags: DIFlagAllCallsDescribed, spFlags: 
DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !11)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{}
!12 = !DILocation(line: 3, column: 10, scope: !7)
!13 = !DISubroutineType(types: !14)
!14 = !{!10, !10}
In the above, we really try to relocate a 'subroutine' (func pointer) 
type with debuginfo id 13 which is actually "int ()(int)". There are no 
actually name for type 13 and libbpf is not able to relocate for a 
function "int ()(int)" as it could have many matches.

https://reviews.llvm.org/D116063 improved the error message as below
to make it a little bit more evident what is the problem:

$ clang -target bpf -O2 -g -c bug.c 

fatal error: error in backend: SubroutineType not supported for 
BTF_TYPE_ID_REMOTE reloc


> 
> Regards,
