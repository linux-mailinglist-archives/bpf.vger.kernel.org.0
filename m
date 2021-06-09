Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8AC3A0C9C
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhFIGoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 02:44:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11180 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236858AbhFIGoB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 02:44:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1596dTGC010066;
        Tue, 8 Jun 2021 23:42:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=t6qdUO6kO6GqtAXGwKIDpHAub2+uhh1fYpgoLUWH4LQ=;
 b=DqpKSkEume3JGRb4zytkL/B0xZVinOhU0zQkjRwrML47Osqa1lrghjdOSCrtc3r256Y+
 jreim0ZdzhXkKqwdOuk0GBIf6pcHmZJ2dhbSrWac71+WahLXItdnKqdbeFswxdHNy3d9
 Y9LiH0OCebwpMwtEPRiEaG8zMXu+OhhuuC4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3925y2pg8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Jun 2021 23:42:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 23:42:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAjD2WWiapMRHSHB360wrMj9KyoNA2qWZbrJqvPxJaQgsBNkWmZRryzwrlV3G/XFfLhMf+5M/c5u1EnVEn4aTEBA2kL2YKMJIOt/Qr8Sk5naMvpRBB8v4CeEmf2s9/Ul69hLau1cknfeUa9JX7aTrIsZaan8a5PGrY3FOH/mtJppRtoqM4o7SWioBlzs0aIh53TpogaE2aQtDR0GTvHFDKMphLp64yq6bSjn2EFD9dGT01jJNKLFbnvyRJgm5egokbH4Pq+j6xSH4aQw008TOzTIFXi5UUVYYwg977r0ap7bu+jKtLi0a4B9UBVxRJr6Zf76qM0Vk7S30U7TYRCAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6qdUO6kO6GqtAXGwKIDpHAub2+uhh1fYpgoLUWH4LQ=;
 b=ZVsTlQabXEv6RWRGW1N/P+QlXTgCUgkwBrt2qwKz82XKFkEn47jfiP8DzmB0Z8c0sR8V6kgtjdG2XjiRNii21cQzO6+InXEmNIqRBm5Pf+ahOiBGqvE7QzaMSP/D8Aa1qpDR8SKjl2P/sXPjeSAYujN1guE5keElr0hZcYY49Ea7mvGvfn5ZUvehGWSkqOiTrtdIjL37rz62F8nE7iMCBnlFrhVXr7Qh46n1+wEhl5JEHJRTAM/ZiIvN17H7C0WdgRsHhkdNC5wUPCFHNato7Fia+9Rvb3W7BqI4kO4lUU6inVprJTLO9BIDMU5ofPbfVcBTjVPhns9nqXm/jDTrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4870.namprd15.prod.outlook.com (2603:10b6:806:1d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 06:42:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 06:42:01 +0000
Subject: Re: Headers for whitelisted kernel functions available to BPF
 programs
To:     Kenny Ho <y2kenny@gmail.com>
CC:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgense?= =?UTF-8?Q?n?= 
        <toke@redhat.com>
References: <CAOWid-drUQKifjPgzQ3MQiKUUrHp5eKOydgSToadW1fNkUME7g@mail.gmail.com>
 <20210604061303.v22is6a7qmlbvkmq@kafai-mbp>
 <f08f6a20-2cd6-7bf0-c680-52869917d0c7@fb.com>
 <CAOWid-f_UivcZ1zW5qjPJ=0wD1NM+s+S9qT6nZuvtpv0o+NMxw@mail.gmail.com>
 <CAOWid-eXi36N7-qPHT0Or9v5OBbhYx6J5rX3uVbVQWJs_90LOg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ad426c37-d810-1d1b-91d8-6d9922ba52f0@fb.com>
Date:   Tue, 8 Jun 2021 23:41:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAOWid-eXi36N7-qPHT0Or9v5OBbhYx6J5rX3uVbVQWJs_90LOg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:bb78]
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::11dd] (2620:10d:c090:400::5:bb78) by MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 06:42:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 202cb68d-e11a-4c7e-1660-08d92b11afc9
X-MS-TrafficTypeDiagnostic: SA1PR15MB4870:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4870AA5CBB528EF289A203A7D3369@SA1PR15MB4870.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYIJ9sTmUd4R29+nhOF87vvkNx74PSxqxJw365tPz4PQiPXAeU8/vmZlvk0qq9P3rUz4dkre/tJ6Az8rOttBwHicYiiU815mMv6kHxf7bPmiNdBNIayHNRxM/zIeJi+r4OM99txhqn3ePL8RQAt9ymfkWu0lfJUYOEh/YzFhA7NWBkWwI1oJcygfl6WcwTEWk8EFhTDhnGJRgiT8visRmROlByMHpPHDuEAl21kcSoz/iWBHlg4TMcE+olzT8gS4JcFeXanItJAAXXV5tiXrJxAKsr2/Y0FredvBTfmGUIjQIaOPkfOpCEUf2OtNxGA2gVinTHKPCZ5c8qXvOztFdGj98AnjmoIM7wEAt8Z7ZO3Nw15Hsn4WZSkJeBZaYETJJGExQf+Y6Ab8XizpWFb9KFrSOP59PLvGpLqAsAO4szVYJ4e3FUps0wwfJsnd+5MbrCra4EQlXbOO03Q79acaWiQJtVDUs/Wg3hklp7G08kCz5Mc07rx4tKQ+rGginCMtkG1Zr74bXu6Nu6VEKK8YunGtz88bpC2cLZu2LGlJQedAvQBMOhOsjq2IS4dzoYv9Y2pB9fj4aqqr1nmWekbMxJZBKtzlTTBjRO1QXEAcLEkilYRiRJzAfvjKFXFsdI2hyVs6e+eKPHxnBDkMfFM7gH//bUzd+f0YMMfFkJ3BrmuaspKUiX6F6oIrrJnRgjm9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(66946007)(8936002)(8676002)(83380400001)(53546011)(31686004)(66476007)(38100700002)(316002)(5660300002)(66556008)(36756003)(6486002)(52116002)(2906002)(54906003)(86362001)(2616005)(478600001)(31696002)(6916009)(16526019)(4326008)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhib0FNbGJHSEFYUkpqMWUxQlA2QjlaaGhGWkQvcHFTUjFuVE5QeTIzWW0y?=
 =?utf-8?B?K2RTdjN1M0plbE96UHBYL0QvTEpXbE0wSVNhN2N3eXkxNWNHdmxvYU1TM0ZF?=
 =?utf-8?B?ekhUTzRkeTVkMUlZRGpacFJvMGM2Zy84ZFRCOXlEOERvMGRnbDF3SWlTSGd1?=
 =?utf-8?B?SUtvWVdqMXBXYmtyYVNobXE0QjRSL1doa1lvQzc2dWt1LzBseksxU29sMGh0?=
 =?utf-8?B?ekFzWnU2RW1LNld3V2s1Tm1uVDNyS0lyZVNWMzI3ZDNIRDJJYmR4MWM1Wm9J?=
 =?utf-8?B?YTZtTWdWUnNUQVc3bG9vZ3BaRDlXRk51Rk1Oa1ZlQkpkQ3RpMm9SL1JjeGxX?=
 =?utf-8?B?bDNTRDFXQkdZdFp0dXNaSS82Ulg1RkphZW5tOUZrdm43RFZrZEw2OTlKZ25Y?=
 =?utf-8?B?NUU0VTNaVmg3S3R6UjNBRzh2clg0V0ZsOVZ1bDZ2MXNZNVFDT053ZWxBTGpM?=
 =?utf-8?B?T3lDMjVySmxad0RsMjM0YjNaQ2JNa0FacTl0aEtvTXVQMzJqZjF4R29YbTVD?=
 =?utf-8?B?THFORTVJaERnTENLRnhxNzdqZE92WE1vM09qYThveUljRWFVR2lRNHUzKzYr?=
 =?utf-8?B?WXBqYmVLNFV3SnJabStWeWFTNnZrUlU0UUtuVFFZVlhub1lwLzRobCtoTUtJ?=
 =?utf-8?B?c2M2L0FXMW4zdGhrMitORmZpQ0lIR1JWeStzUWNPdlZ6cVVVNm9LWTVLNERN?=
 =?utf-8?B?aEtKcHBCMXZjVDVjeGFMRGFML3Nwb0ZxWU9zWW5DamM3bUxVaXNOekFlK0FW?=
 =?utf-8?B?WTRCL25xVW83QlJkQ3RnOXpaYmJCaVBWbndCWUVZbEJiWm0xZUtLelRiVmtN?=
 =?utf-8?B?UVkxbytRVFNtb2V3dHlkb2k2bk4zeXBndkUxQ2pxekZJWEZaOHFneWd2aTRV?=
 =?utf-8?B?VEdtREg4WmVvRnM3TVU0cWEzemxja2ZMOElVYjAyYkJ2a0NZRmxsNTJHaS8y?=
 =?utf-8?B?NlV2Q2llOGNNMEY1UGp4Ni9aRTJPUGtnTnZuNzlWRTlzTXJKTWQzRUNtWGxh?=
 =?utf-8?B?eXRwVnR5WXRSdE5XL2toejVzQ3BmVmRNTm12YXYxdUlORmphQXlNdkxLam5r?=
 =?utf-8?B?NnpSNXNOVDdiOElpMlFINmJmUnVXeSt4cnB1QjZLTzZURUk5NmJ5Uk5rQ20y?=
 =?utf-8?B?cXhrRkFLNFFrUWNXY01pbndydGZnVlBhS2RrNXpabDh0M2MxTEZCUUVIaTJp?=
 =?utf-8?B?V0krYmZ1bkQrTmI4cEp6KzZBRVVsSnhJS04wZ1Rqb0c1Z1hXOXJVcjB0SkJl?=
 =?utf-8?B?UUNYbUh2UFp2Mm9ZS1RRN3lxSmxYc0ZIM3gyb25KUHFUVzhGRVgzWTljVWJZ?=
 =?utf-8?B?N2dqSU5XM3h0MTkrQzRZRk5hUVFQT2RtclhsOW4xbHU3SlZJZEZPVHZxVCtD?=
 =?utf-8?B?S2dtc2JLNnMzaW1QWWh6dFppMkpMUnNmTnNNS0hBYVlqM1J5ODJ4TkJQdGUy?=
 =?utf-8?B?TEJVcVpBSVBhRmFma1ZHRy8xSmQwdVdEVG5jc0VlK1I5YUJsbjd1ZDdwMmRs?=
 =?utf-8?B?Wk1qWDVPMElXaXNYclhqZlN2VnpKWXhMcmJZT1VJbWxJRmFNY0VJdUU1Tm9I?=
 =?utf-8?B?NUx1M3lmRjk0QmxPbFRFalI4Y0doZzVNWGxjMFc0amFPeVVHRXY5cEpMS2dm?=
 =?utf-8?B?ZGo0YXpaZUNiM3ozOTVzSy9YRVlxVVU1b1AxallxbEVaS244RktSQ3RudDZ5?=
 =?utf-8?B?b29ORkVFNllMa1NSa1ppWWR0czh6cE81Rml6MXFyUGozSjF1cUxwbzVqZFhq?=
 =?utf-8?B?OHQ2U0haM2JRMHpSenpCekdHbWR2M0ZqK3FEQ29TaWd2bUlEUXRHaENYVDd0?=
 =?utf-8?Q?Z9aR/8DcT8Kn19Sv2lSiCJbopowlU7seMMk4A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 202cb68d-e11a-4c7e-1660-08d92b11afc9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 06:42:01.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdDBOiw1yTUQBAPVolhFNniMVmPmIH4/SsPjdcrlBenpUQmBOAv1w8nC9d75OVcO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4870
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: bDV2ALQ3w5AI49AzOESV_KV7A60Tk1av
X-Proofpoint-ORIG-GUID: bDV2ALQ3w5AI49AzOESV_KV7A60Tk1av
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/8/21 12:51 PM, Kenny Ho wrote:
> On Fri, Jun 4, 2021 at 4:47 PM Kenny Ho <y2kenny@gmail.com> wrote:
>>
>> On Fri, Jun 4, 2021 at 12:11 PM Yonghong Song <yhs@fb.com> wrote:
>>> On 6/3/21 11:13 PM, Martin KaFai Lau wrote:
>>>>
>>>> Making the kfunc call whitelist more accessible is useful in general.
>>>> The bpf tcp-cc struct_ops is the only prog type supporting kfunc call.
>>>> What is your use case to introspect this whitelist?
>>>
>>> Agree. It would be good if you can share your use case.
>>
>> At the high level, I am trying to see if we can use bpf in the drm
>> subsystem and gpu drivers which are kernel modules.  My initial
>> motivation was to use bpf for dynamic/run-time reconfiguration of the
>> drm/gpu driver (for experimentation.)  But now that I learned more
>> about bpf, I think there are quite a few more things I can do with it.
>> (Debugging during GPU hw bring-ups, profiling driver performance in
>> live system, etc.)  I have been looking into bpf with kprobe and
>> struct_ops.
>>
>> In terms of kernel module support for bpf/btf, Andrii told me about it
>> last year and I see that his feature is in (I was able to do a btf
>> dump file for /sys/kernel/btf/amdgpu, /sys/kernel/btf/drm_ttm_helper,
>> for example.)  The next thing I thought about was having helper
>> functions from kernel modules and Toke pointed me to Martin's patch
>> around "unstable helpers"/calling whitelisted kernel functions and
>> this is where we are at.
> 
> Yonghong and Martin, does the use case make sense?  Or am I trying to
> do something stupid?

So your intention is to call functions in 
drivers/gpu/drm/drm_gem_ttm_helper.c, right? How do you get function
parameters? What kinds of programs you intend to call
this functions?

kprobe probably won't work as kernel does not capture
traced function types. fentry program might be a good
choice.

if you can *craft* a bpf program to show how
kernel function is used that will be great. We will
then see how verifier can help enforce safety.

> 
> Kenny
> 
