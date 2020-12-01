Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAE2C9614
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 04:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgLADtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 22:49:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47812 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727746AbgLADtu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 22:49:50 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B13kxCU015831;
        Mon, 30 Nov 2020 19:48:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wiD3XVqq94sNjfjdyArJ1ChfnOUBFYzK4Id2Uhy3Y3Y=;
 b=bRERsoqP+zxlW90cIAVWoPZGIPINZNYkL++BPFiWReRIsnw9JN+iUcJiY7tKP4CcuWgQ
 HfPaVZfmftiBRjIuIkiQ75BJkgF4iqEoyqJfspT2k71/2e/TDlPlZk4/UZDh/BlqpGBV
 r7Yo/F10+EhI2p7IoYcKtcN5fZEgu/b+xJk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 354d4g8bx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 19:48:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 19:48:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYRKTDmp0+odZKv6ulaxVFSL0VxOWA7Mc3FA1KAz2QnozrEkPG4LpcyswXBkcpxQP5YbbWTthYYY7kU8tk6D9leAJgwrpphdWQlaE8dbbf0zBY1lylyJodPTSt1gVQWqmCXYQT6ocXcQH/6AvkeiN231KKQEBDIQ2xLwS66f74SP0aBJfBw4y4a2M37hAYFalc734LL1kb8hiW2HjjP2QvneuJyS33Ab141jFmK3X8axUgSg2wkCKh5yC5p0YMvu+1x3gJnZJ6E/R4d+kck+tkvX8Fn/C4P1RCWwjRI26w043BlqMnIJNHSQWjmYCSMtZAG6f/9XdkCySva/0GfHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wazCbnJD91SSxaIffDfMQw3gx1MkpB4GhoYOKxgSAKg=;
 b=TCxwRTZIpJzczY0Mmb1VBvMp8CQZlNw/GGQkJ2gdYwIIMNWCoFQvrVGLDnCRfs2NRUZtFV49UB5U9b3rdkULt/zlNdPUdTjRecaviOLo3Roz4vAHf2tX3tRmN8rl08qkDE+k/njEBe7UpLhJboINMoAUAm+6waX2+vOlo8joS9D+L0qGjHcF1VEn9aAo2rEi3YmplAK+D4Y+yKuxJMnsGr9DVRoKbKzwndrqWcLkNevl2adV2o5mtRS7Jq1SmunbTO1xWqITwEHjuZeVTmPmVz/KB2Se2OrCb8GHNlgsVOfD/HB4u996kXgd+lc8QjwH2Y/5lRwW+CGQr1X+Nlnoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wazCbnJD91SSxaIffDfMQw3gx1MkpB4GhoYOKxgSAKg=;
 b=Nm2KXrnbFInCEY90tj5U/f8EAqrOHGt74KnQ47sO2OJWzPcVSfQwVfELnCJt+P8hH3fBAaCVkgdc3URHomwRfQljYaQyGsyK3UEBBfDh4Z906MEaZrP8d2jehndbI1ohYbXiZ8xktx/KT1qYQeE1IPcf7rAiLBacDdrN9NxfEL4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4236.namprd15.prod.outlook.com (2603:10b6:a03:2cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 1 Dec
 2020 03:48:50 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 03:48:50 +0000
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
 <20201129014000.3z6eua5pcz3jxmtk@ast-mbp>
 <b3903adc-59c6-816f-6512-2225c28f47f5@fb.com>
Message-ID: <4fa9f8cf-aaf8-a63c-e0ca-7d4c83b01578@fb.com>
Date:   Mon, 30 Nov 2020 19:48:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <b3903adc-59c6-816f-6512-2225c28f47f5@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:d184]
X-ClientProxiedBy: CO2PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:104:7::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1841] (2620:10d:c090:400::5:d184) by CO2PR04CA0131.namprd04.prod.outlook.com (2603:10b6:104:7::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 1 Dec 2020 03:48:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63f5862b-f207-4113-ac8e-08d895ac0381
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4236:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB423672E2581B05C4F8AF46BED3F40@SJ0PR15MB4236.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBSyNxXzQft5Za5KAm3Ga1OgwIP9H9EgCSe5XsTc8hd4IhqSqQWmzwSkjKh5R41nz4LOiQafwmkwEYmt+vnfdJloKRw3rU1FwByL0rLYS63CKPG76UkHBcPa5LsRto9Dqsc9WzKeNDep6FY2Ko8zJJt01L3/rYNVMFjD9/OqlPIRuKRF8pu9PpuCKHsCXcQ20s6Om/g2CoDRF9jjG/nWIdfzrjyi8WYfoorTpV8N//qcZ/Qr2KvdwtbzZ2c84SnCEMO/cdYrKm1xdmsWD99JleUn+Um3DlWHJL85NAj3gQQGfOAbpsUyLbKdd79MStZoBziEtQEi7R0Zjy74D4BHt5Af+SAffzw5C6sK+LKintGDdiJHGVa+gwsutC4cnWlE6BScYOejnki+VpJLqNN/T0E2I9j3CA+eZzkzTa3qS0LrTctOLuIhnbJV7iL09KCo6CD6pQ9BZEvU4BeMbC9bJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(346002)(136003)(86362001)(53546011)(16526019)(316002)(8936002)(31686004)(8676002)(66946007)(54906003)(66476007)(66556008)(4326008)(6486002)(2906002)(6916009)(966005)(52116002)(2616005)(186003)(6666004)(36756003)(478600001)(5660300002)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3Y4Q29Ka3lDYUJldWJqdVFyUWhvZVViYTU2eFlydzJsd2xoTGJ1ME5KRllo?=
 =?utf-8?B?RmxUUTVmUUVEeFdOOThXOHovblMwazZWRHdqeXM4ak1raW8rbklOSzZBZ2Ns?=
 =?utf-8?B?QXpZdGlkUGpPdWtHYW4wK0Z2MnhSNWRKV2tWSndtMGlzUmM4MWxENXRyUWxz?=
 =?utf-8?B?NlpkNTB3WW9NS29uVG43L2UxbzhBd25kNDRZUVBsUmNOUWhGallKR3FUczRS?=
 =?utf-8?B?UWxoVk55RUhETFJxc0hocDhyZnpBV1ppV1Vmc0dBR3FLNGtTOHo5Um56blFt?=
 =?utf-8?B?eUJDbFpDYTYydjJad2xueC9oUFFTQng5c21xWnhGYnpPSWdKcHNablZheEhz?=
 =?utf-8?B?Nkh2c3VZTUl0UzhQeENTc2kzNHRYTTBBZWlPay9pZFMwMm96U0tJdTFsdHE0?=
 =?utf-8?B?SjBvb21UUkFxcWpzOWRNVnNHbkc1cjNMK25YaTBSTFpZMWtKMVFrNDYwM2VH?=
 =?utf-8?B?c3J2VjhITDJjQytCb3hEN0lDWUlJQjI0WG85bHVFVFpkaUw5U3pxVkdLZ1ly?=
 =?utf-8?B?SEFtdVNQRFdJYXNVMEZ3YTNlL3RVdFByOUYyc2k1QTB5TjFUVllYbm1mS0cy?=
 =?utf-8?B?Z0NyREMrSTNyYVZsem55aGg5NzNEM1lFdHNwQ2huODEwODExSk5aTkp3WTI3?=
 =?utf-8?B?NjdlUE9WSmlkWnNzUTN1Wko2dGFtTUZ4UW9PNGdTU1JFVzBjeWdKd0NVNUtk?=
 =?utf-8?B?Z3AwVWdYQ1RYNWY4d2Zoa3lRYWxOYVFWSTdNM0pwSHN5ZU4rWWg1bXhlQVRu?=
 =?utf-8?B?RTBBM3JSU1dvL0lrcDdtR2NhbnV3N2RPRWxpblZMeEd1SUJUNWwyK2Y5VkhJ?=
 =?utf-8?B?ZHloL1o0U0piVitrcTVSMkZvOEtua3gyNHFWS3B3Y0Vnb2tRcDZReHBXTXpn?=
 =?utf-8?B?WU5DNUhEZm8zTVl6TkttVDJVaXozYm1EdUIxaTVzMFZwUG9tN0tTRzdBQUpH?=
 =?utf-8?B?WFVkd0JkRTg1c2dGYmFmMEEvblN6S1hyenEwb1RwQkVRYzR3YUNiYTB6dklj?=
 =?utf-8?B?OTNPOUtzSVRIaFBXUVhDSzBpcU01dnhGQXRiclF0Q2lYemtTTzVDTTZzRkN2?=
 =?utf-8?B?UXZhc3NXYjJ4MFBUTUZLVVA4Z1lla0RnRnFnOEY0QmViYmZiNUtaYVgzbEJZ?=
 =?utf-8?B?WStNM0ZvemJtTW5UNTZLbHV6bkVJTVAyY0VwMWc3bnZ5dkwzelozYUh2bDZI?=
 =?utf-8?B?OTI5cy9OZ0NJckZUR2gzUHhpeVZIZmxJcGIzN3RSd3BQK3laMituNWMzYjIx?=
 =?utf-8?B?eEgweDJzR2JyYkwxdG1zSWVKZ0ZTVHJaVDZ1T2VXdHhvYmNvaW5HbVNjUG0w?=
 =?utf-8?B?R0YxMWNOTnNWVFdUYjd6YkhJV2M4T0NDQlg1WkJWQ0V3OC9pclVEZ3JMNXBI?=
 =?utf-8?B?dytZUXhPL1lPUVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f5862b-f207-4113-ac8e-08d895ac0381
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 03:48:50.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jXOul2bca5s/SpE/EBebJR0SVfmryIzkd3UYE62SDvx1yufs2NCdPapz2yxeC7k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4236
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/30/20 9:22 AM, Yonghong Song wrote:
> 
> 
> On 11/28/20 5:40 PM, Alexei Starovoitov wrote:
>> On Fri, Nov 27, 2020 at 09:53:05PM -0800, Yonghong Song wrote:
>>>
>>>
>>> On 11/27/20 9:57 AM, Brendan Jackman wrote:
>>>> Status of the patches
>>>> =====================
>>>>
>>>> Thanks for the reviews! Differences from v1->v2 [1]:
>>>>
>>>> * Fixed mistakes in the netronome driver
>>>>
>>>> * Addd sub, add, or, xor operations
>>>>
>>>> * The above led to some refactors to keep things readable. (Maybe I
>>>>     should have just waited until I'd implemented these before starting
>>>>     the review...)
>>>>
>>>> * Replaced BPF_[CMP]SET | BPF_FETCH with just BPF_[CMP]XCHG, which
>>>>     include the BPF_FETCH flag
>>>>
>>>> * Added a bit of documentation. Suggestions welcome for more places
>>>>     to dump this info...
>>>>
>>>> The prog_test that's added depends on Clang/LLVM features added by
>>>> Yonghong in 
>>>> https://reviews.llvm.org/D72184 
>>>>
>>>> This only includes a JIT implementation for x86_64 - I don't plan to
>>>> implement JIT support myself for other architectures.
>>>>
>>>> Operations
>>>> ==========
>>>>
>>>> This patchset adds atomic operations to the eBPF instruction set. The
>>>> use-case that motivated this work was a trivial and efficient way to
>>>> generate globally-unique cookies in BPF progs, but I think it's
>>>> obvious that these features are pretty widely applicable.  The
>>>> instructions that are added here can be summarised with this list of
>>>> kernel operations:
>>>>
>>>> * atomic[64]_[fetch_]add
>>>> * atomic[64]_[fetch_]sub
>>>> * atomic[64]_[fetch_]and
>>>> * atomic[64]_[fetch_]or
>>>
>>> * atomic[64]_[fetch_]xor
>>>
>>>> * atomic[64]_xchg
>>>> * atomic[64]_cmpxchg
>>>
>>> Thanks. Overall looks good to me but I did not check carefully
>>> on jit part as I am not an expert in x64 assembly...
>>>
>>> This patch also introduced atomic[64]_{sub,and,or,xor}, similar to
>>> xadd. I am not sure whether it is necessary. For one thing,
>>> users can just use atomic[64]_fetch_{sub,and,or,xor} to ignore
>>> return value and they will achieve the same result, right?
>>>  From llvm side, there is no ready-to-use gcc builtin matching
>>> atomic[64]_{sub,and,or,xor} which does not have return values.
>>> If we go this route, we will need to invent additional bpf
>>> specific builtins.
>>
>> I think bpf specific builtins are overkill.
>> As you said the users can use atomic_fetch_xor() and ignore
>> return value. I think llvm backend should be smart enough to use
>> BPF_ATOMIC | BPF_XOR insn without BPF_FETCH bit in such case.
>> But if it's too cumbersome to do at the moment we skip this
>> optimization for now.
> 
> We can initially all have BPF_FETCH bit as at that point we do not
> have def-use chain. Later on we can add a
> machine ssa IR phase and check whether the result of, say 
> atomic_fetch_or(), is used or not. If not, we can change the
> instruction to atomic_or.

Just implemented what we discussed above in llvm:
   https://reviews.llvm.org/D72184
main change:
   1. atomic_fetch_sub (and later atomic_sub) is gone. llvm will
      transparently transforms it to negation followed by
      atomic_fetch_add or atomic_add (xadd). Kernel can remove
      atomic_fetch_sub/atomic_sub insns.
   2. added new instructions for atomic_{and, or, xor}.
   3. for gcc builtin e.g., __sync_fetch_and_or(), if return
      value is used, atomic_fetch_or will be generated. Otherwise,
      atomic_or will be generated.
