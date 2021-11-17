Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF2454BF6
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 18:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhKQRc1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 12:32:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50154 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237770AbhKQRcZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 12:32:25 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AHGUfKf012922;
        Wed, 17 Nov 2021 09:29:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=z0cigRJ2io6I6NR6NReBrgh7GRcfBKauunrWYw0pRFI=;
 b=UC260PtohAnpVVD7BRS7RmHgtgFeBDW9FeVvlhQOnoOIPhfpytQHlMpToZCMySb2OU84
 WFi5+9mLbh1O5UBWYgLw+17/APfkMgrMHZ9kYqL7u89hM+3+tM95Q3f3wPVIOAxeSFka
 ROQIodWvQkb5oNSu+TyyFgDpBu+FcQELJaI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3cd3ahsf2w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Nov 2021 09:29:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 09:29:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQs6gXiWrTR150tPDPsH/YRJVo1FqTQ38bnF+cwmxHU9Flx5V9lR8CfABqj1FEOd5ZzdoII+FptCS6NgvHpzUI0iejGqhrU/Tb/Lw6C+74MFS2cMk3qpH2EOA1MU2X0sxD5nBs9Hvg46VXu0VzAd5ycHy0r3UvcypI5xmBOg97ATtijU0XiLTGV6jgVY9M7d/xqEbQawhfuez8x/kHJ/kNvqPAKx21vYaUyJ4y98KTc0IeVfUFpg/AlOZEtAHkIVIswEdQnW5F8HHTJnQawysCOyM4gNvH71KtBxojkfpf/VHNTZYZ91hoUulaAIvyeDyxorPre0nRmzPhX+dofMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0cigRJ2io6I6NR6NReBrgh7GRcfBKauunrWYw0pRFI=;
 b=RjnNanIdzJGr4+2c2MU0F82LrA1o3p+DUgqUzvW2r0rJcRckCUnRSdyZELc+oHQMt6A3aCvVJLmAWJAgLUHXjyfVbzsoN1VxXLKcBufYi/s4lbmNK1UVKhH8z45+ju1HXy8JxA4PmxIYjwrtQIYcEyFXlMgJo3ddjdsbnjbmAL/QJ0wauMaAql2hngTUzQHV/tKLAJ3Ocw7mNJ855q5nxvSooCOo7gcsaNoUF2qS9UrO1pSS5o3ioUi15Px/UIBnRFtJRGwiLQNQlbZpBvOKyQkk0bWp4mukquO4sdhQ1LKKpYPqhIGMU+iT2BaaZbXWqMRJ0w583hpBXaMB409Xww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by CO1PR15MB4907.namprd15.prod.outlook.com (2603:10b6:303:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 17:29:07 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6d87:d8f3:9863:9ceb]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6d87:d8f3:9863:9ceb%9]) with mapi id 15.20.4669.015; Wed, 17 Nov 2021
 17:29:07 +0000
Message-ID: <40eb380c-eb90-55b0-1d80-812043520cf8@fb.com>
Date:   Wed, 17 Nov 2021 09:29:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 00/12] bpf: CO-RE support in the kernel
Content-Language: en-US
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <CAFnufp20BUGADHQLPWsa2BDorS+_pDxT2Sn1GKkSHGBw1RgMFA@mail.gmail.com>
 <CAEf4BzbhzNU-ydvTYa8XG3jRxae+83d_w7EkHaOkySQVH1BHww@mail.gmail.com>
 <CAFnufp1f_==QV3L31z4iknZVvoWzH6yKJ3zttvVpMJEj+kOxEA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <CAFnufp1f_==QV3L31z4iknZVvoWzH6yKJ3zttvVpMJEj+kOxEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:5c) by MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Wed, 17 Nov 2021 17:29:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16efe0c7-fa26-4aa8-8669-08d9a9efc27a
X-MS-TrafficTypeDiagnostic: CO1PR15MB4907:
X-Microsoft-Antispam-PRVS: <CO1PR15MB4907BE0D09A7BC12FE54B5AFD79A9@CO1PR15MB4907.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwuFU8Bp77wE/A/XZHtmdCSPHq37uYiun+dR09bGuCPVgphXQ74EPM56aFHlBnir90I7SHDCkksnWJaCEFpRgV4M2O+Vc5FWChJ+5MOv+esLyjlCbbpNQxq0+pCI398WCi3q3uFS1nQLEB8MTTRSKSrC3UAkSiyxBMEWvZHrBx70xWwBeUtIYQDicVcvDzgPLVhw3TtLC+jwlgvQ28uZfWUivnJ+X9h0qSGeRnsR6GTr1BlJGTtCDWQ034gQpcbnPbhMcTwH+AmeYsO/fPnmS1hDDQTcjzotnYJ+9IeEz/8Fd2MmoFLjWnbKx5A3z8wyo2dSdj386jJZjH+se1BzWYCt0z1Bil0UlVvhUdcFEfv6txhgir/rNNtOtZkJmiV+vubk1qxxJ1RFwItbaYHGTX1LuV4sZxdl2kB3YFntQCoJyPKMtG/0GE7JWVm28NskBylHUNpBlL5cM464cpxyqGxFyY8OqCotaEYHGRteyu5N+1gow54j27PDPVFfBzC05isopM1O0aWsnvTbS7q2q0nXqWvCffOVVxIVv9g1G5adEWx6TgJbawPgOltc0C/8b0ogVltoubrpHssFKr+/EUl5qv0bpWoAZChwX2tS21HJ/bhPm1Oi/1RsSmOWb+OSD9/0S/MbrCDk4fljNt6XRnQ7ti1lntJGJtfada/Q3tHbFYx+/Frfet+0Z8YPw3Xit2hANm/aajgpzbw4f4jzP+MbiOd/3Iy6PaAA1YmNkWiIwDShyJBQOl0O3gvnNr1p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(38100700002)(66946007)(4326008)(31696002)(8936002)(36756003)(66476007)(66556008)(186003)(52116002)(2616005)(54906003)(86362001)(5660300002)(110136005)(6486002)(2906002)(53546011)(8676002)(83380400001)(316002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUR4OXF0ejZGZ1loQmQyS3RmY2o1b1QraWhQVTBkdUM4ckwrSVAzcjBwQURC?=
 =?utf-8?B?UEdhZVllUHRVV0s2VjgyRlRSQS9rME0wS0NVeHNvWm5pelNWcHBmUkIwUlJ1?=
 =?utf-8?B?WjlhL0NWUkE4Zll1UitMc1hCaVpaUWhwYTRKaklQeCs4NmVKMitvb3Rlemwv?=
 =?utf-8?B?dCtkandEeHZJLzZTak13emQzNXVnbGNxYUY2WllYUExvUVpGMENvU0ErMEgv?=
 =?utf-8?B?SDdlTG0xeW0yTk9RTG1SclFkd1k3MzQ1ajV3VS9nM09lS29DNitaemI0YXNm?=
 =?utf-8?B?ZjBSNjRWWExpd2xpREViRjA0Rkg2MDVKRFpFbXpsMFZ4Tkg1STJiWVF4NDF2?=
 =?utf-8?B?Q2VtaHlTYnY5MlJqMi95SnRyTWtGSndpZ2swaCtPMnAxMXJEZHloUXFlUm04?=
 =?utf-8?B?a3BEWDdPYmo0TzFhMk1IMFcrLytMSThiS3FpaWdSc3ZNT0NtM3FiOXRDa0t3?=
 =?utf-8?B?czhhMUhCb0VzTlhTQWlZQTZqcmp6SkJHU3pZdm9FNEFFU2tTeG9GbS95QStl?=
 =?utf-8?B?Q2JiVTU0K1ZWZXExSjZteFpXZ2dyNHhqSnMydGxneEZYM25tL2hZWjYwRUtH?=
 =?utf-8?B?bGhHVUZ1eGJWQVl3MXRML3V2K0xhb1gwdjl6a29WRjAybGtlREo3Rk8zNVJs?=
 =?utf-8?B?Z2ljQklmNUkzNTMyaWxwczdkbTBmWkU5VVNRK1NGWWEzVmNDcERnTVFjWS9G?=
 =?utf-8?B?dlFXMTY1UFpwYU1FRlRKUzBCY2k0RnVUUnBWSlZ4V1hVLzlNQ0gxYzYyUWph?=
 =?utf-8?B?VEJHL08yQTR2V0xDQUpBRnNZeW9GaVJkbWJzVTI2ZzZnbHpyeEt0WjJIMzg2?=
 =?utf-8?B?MWY5QitKek1IQzZZdEpRbk1HbDFjMnpoR1FKN3Y4SXBtWVByMWw1eTA1TTF2?=
 =?utf-8?B?bXFBUmptdnNKL1RhVHBOR0V6OElTb0ZEK05ma2JIRU52MmNDaFpQT05uRjRO?=
 =?utf-8?B?NmtsTzQ5SEowWXJYUHYyVUtJVW5zTGpmT3hteEQxQXN6aUZSTm81OEpPQVk0?=
 =?utf-8?B?aGVPV0RWSWJpZGtHM2RVNUFqNUVTby9FWExTZzNKTVlWRjVNYytlY0xDb1I0?=
 =?utf-8?B?MEZDc0RvdVZOOS9EdDZaR1lmdzFrODVlcDEwd1NsMzduWTAxWEwwWFdIQk80?=
 =?utf-8?B?bVFSbUR1Y1hsY3dZclR3SjExSjZ1b3Q2QTQ4dm8vZDhVdlRDTVVnKzlQYVQv?=
 =?utf-8?B?cUh4aVhvOFhNRllWMDRKbTFTcVRNZ1BxZHREeC9Hd1dPNldlaUppNGp5QkI3?=
 =?utf-8?B?ODllS2k0TTNGcFBSTGQ5c1hSSWFuM2RIdm83cnFHWkk3K3RxaUdheUVRRE5q?=
 =?utf-8?B?MUFKc0h5QzVSTGdTN1VmL3l1eVAzMHBzRUloWlVDOXNpWWJNTHIvUmlaamtk?=
 =?utf-8?B?L3pHMTIwa1FHc3ZVTE10OGFJdkpiaWFWQ0NBWTFhZUxKRXNMU2dyQUV6ZDkw?=
 =?utf-8?B?WTl4WGNHenR6UUZJQlVPbGZHUDV0RjJ0OThNTVp4Y0oreGx2TTNtdVFlUmZw?=
 =?utf-8?B?bzlNclFOM3FWbkx2dEJ4YURwcmR4ZDVxRTRvZHBRRDY3LzVzYkVGeStWNUVz?=
 =?utf-8?B?dHJZdEJXTFp5RUthMUJZRjAzazBlVUZUUEp6RExJSlgyTDZRbXVCazRyK2RT?=
 =?utf-8?B?Smt0U3FTQUVKUUF5L042NFlKSGpzWEpUMDIrTkRSYkFUVHh1Z3FzK3QyeDRh?=
 =?utf-8?B?ZFNBVHBJb216ZGVreFM3UTNVejdtUFNGMzdkZzBMV2hDYVRRNTMzYWNNOUlj?=
 =?utf-8?B?V2Q4d1BGMmM5dGt1NUJxejZJUUNUd2N6ZGtzMU1ZVmlncEpMM3VqNllscm42?=
 =?utf-8?B?MFcwN2loL1N0bGlDc0psMXN3YUFXVENndzZyby9ZYU9ldEtxeCtJbmtKcjly?=
 =?utf-8?B?cHZXdHF6YW5jM0x6MnhpV3dQOXFUNlJHcCtPUzhlMXlMVEtFWEtRTVJFWmhr?=
 =?utf-8?B?OTUvWXQ3amdTZzV5K1RuMW8rL0k2NFdsUnJtQ1lVUnN3aUVrUHZIcWtUTUEx?=
 =?utf-8?B?c2NJQkJsbmxxR3dPMzVOQ3dzdG5ITjB2Sm16STc0UUR5bFhBZ2J4NjNCN0tn?=
 =?utf-8?B?czVkTkZrZVc3ZXhDeVhCeHl0ek9LQlFUYjl1ajFPVmtQRGtITWphS1FxNnlr?=
 =?utf-8?Q?c/D3Msfk7+z+W9Aexul+WNl9p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16efe0c7-fa26-4aa8-8669-08d9a9efc27a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 17:29:07.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FpUhtzGVLED1GgmHjaXVKDMCRLKnqgK+2COzwl6KgTjNwukrkPJQ8UDALEtz2K7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4907
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: rJGxaleYHxJrdimGaDzOtRioagr7ARjE
X-Proofpoint-ORIG-GUID: rJGxaleYHxJrdimGaDzOtRioagr7ARjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_06,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170080
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/21 7:28 AM, Matteo Croce wrote:
> On Wed, Nov 17, 2021 at 5:34 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Nov 16, 2021 at 4:48 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>>>
>>> On Fri, Nov 12, 2021 at 6:02 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> From: Alexei Starovoitov <ast@kernel.org>
>>>>
>>>> v1->v2:
>>>> . Refactor uapi to pass 'struct bpf_core_relo' from LLVM into libbpf and further
>>>> into the kernel instead of bpf_core_apply_relo() bpf helper. Because of this
>>>> change the CO-RE algorithm has an ability to log error and debug events through
>>>> the standard bpf verifer log mechanism which was not possible with helper
>>>> approach.
>>>> . #define RELO_CORE macro was removed and replaced with btf_member_bit_offset() patch.
>>>>
>>>> This set introduces CO-RE support in the kernel.
>>>> There are several reasons to add such support:
>>>> 1. It's a step toward signed BPF programs.
>>>> 2. It allows golang like languages that struggle to adopt libbpf
>>>>     to take advantage of CO-RE powers.
>>>> 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
>>>>     by the verifier purely based on +10 offset. If R1 points to a union
>>>>     the verifier picks one of the fields at this offset.
>>>>     With CO-RE the kernel can disambiguate the field access.
>>>>
>>>
>>> Great, I tested the same code which was failing with the RFC series,
>>> now there isn't any error.
>>> This is the output with pr_debug() enabled:
>>>
>>> root@debian64:~/core# ./core
>>> [    5.690268] prog '(null)': relo #-2115894237: kind <(null)>
>>> (163299788), spec is
>>> [    5.690272] prog '(null)': relo #-2115894246: (null) candidate #-2115185528
>>> [    5.690392] prog '(null)': relo #2: patched insn #208 (LDX/ST/STX)
>>> off 208 -> 208
>>> [    5.691045] prog '(efault)': relo #-2115894237: kind <(null)>
>>> (163299788), spec is
>>> [    5.691047] prog '(efault)': relo #-2115894246: (null) candidate
>>> #-2115185528
>>> [    5.691148] prog '(efault)': relo #3: patched insn #208
>>> (LDX/ST/STX) off 208 -> 208
>>> [    5.692456] prog '(null)': relo #-2115894237: kind <(null)>
>>> (163302708), spec is
>>> [    5.692459] prog '(null)': relo #-2115894246: (null) candidate #-2115185668
>>> [    5.692564] prog '(null)': relo #2: patched insn #104 (LDX/ST/STX)
>>> off 104 -> 104
>>> [    5.693179] prog '(efault)': relo #-2115894237: kind <(null)>
>>> (163299788), spec is
>>> [    5.693181] prog '(efault)': relo #-2115894246: (null) candidate
>>> #-2115185528
>>> [    5.693258] prog '(efault)': relo #3: patched insn #208
>>> (LDX/ST/STX) off 208 -> 208
>>> [    5.696141] prog '(null)': relo #-2115894237: kind <(null)>
>>> (163302708), spec is
>>> [    5.696143] prog '(null)': relo #-2115894246: (null) candidate #-2115185668
>>> [    5.696255] prog '(null)': relo #2: patched insn #104 (LDX/ST/STX)
>>> off 104 -> 104
>>> [    5.696733] prog '(efault)': relo #-2115894237: kind <(null)>
>>> (163299788), spec is
>>> [    5.696734] prog '(efault)': relo #-2115894246: (null) candidate
>>> #-2115185528
>>> [    5.696833] prog '(efault)': relo #3: patched insn #208
>>> (LDX/ST/STX) off 208 -> 208
>>
>> All the logged values are completely wrong, some corruption somewhere.
>>
>> But I tried to see it for myself and I couldn't figure out how to get
>> these logs with lskel. How did you get the above?
>>
>> Alexei, any guidance on how to get those verifier logs back with
>> test_progs? ./test_progs -vvv didn't help, I also checked trace_pipe
>> output, it was empty. I thought that maybe verifier truncates logs on
>> success and simulated failed prog validation, but still nothing.
>>
>>>
>>> And the syscall returns success:
>>>
>>> bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0,
>>> data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0,
>>> ctx_size_in=68, ctx_size_out=0, ctx_in=0x5590b97dd2a0, ctx_out=NULL}},
>>> 160) = 0
>>>
>>> Regards,
>>> --
>>> per aspera ad upstream
> 
> Sorry, there was an off-by-one in the macro.
> I just aliased all the pr_* to printk, this is the correct output:

This hack is not necessary. The debug messages are going to the verifier
log and it's printed when prog fails to load.
To see successful log the hack to lskel's prog_load_and_run is needed.
I'll add -vvv support in the follow up, so it's easier.
Currently neither standard skel nor lskel support -v, unfortunately,
so a bit of plumbing is necessary (which is not related to "CO-RE in the 
kernel" work).
