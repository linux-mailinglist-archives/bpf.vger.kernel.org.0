Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D945D17E
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 01:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbhKYAIP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 19:08:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63944 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345846AbhKYAIN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 19:08:13 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOJhCCI025926;
        Wed, 24 Nov 2021 16:04:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=omYrSJbZdetLU3T0B5gvtROWEJCBOVVWRn8UrOJ9YkA=;
 b=Rc8kPq903dl7TqAAAPeUj9zXH9uw/AxyxnJRCRcBCkDdbGnYZZDVXk9er8nuJdC3B2wT
 efThRvFyaDTZk2NyNy8Qgj5RzNTgjj1mvIGSbgxuYKboD5RJNnKNFrKmj6U/hVDYzJmS
 HhX/rs3Xtg9TNMcL0fL8JHGWeO9c7lhPmT8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3chje0d34k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Nov 2021 16:04:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 16:04:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi6+U31hYvv/Wn9uBUxsiBXcIyMTbCDAxY9HWi9LcDDcblHtjYdZBpzmBHxjQhC/BViPsiTyU2xFlH8pDecl15F2/o6uYMpztncUsX/h3VtkNdTHkBX4wkkIVQtp1a5JF7vcWgvsb/eZXd9Obcjp2Drd0wHE7gfn49LkwHgkMnmq9RLFU03glkHgi5txr+MOQJhr4KdNcnv0MgA92kTHqjXtJnUVfRZ+iUa3v1W6n981KoE1/VAc9BoYKSPVzAoGZqey9nYZU+699GhIzhw1zVUGMU/IuDuu2EvhJJjqW7jbzNl+QfmbB3Emawu/443pHcDLtldAFFhtq4WTaEZ+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omYrSJbZdetLU3T0B5gvtROWEJCBOVVWRn8UrOJ9YkA=;
 b=lM72znzpefr0dj6j95vl513mEHzXrJnlOsVLkVmsFQ5IPOrt/T8NahfTtcYvgPv3fV0nGNOAKuMs/hSyCgES58Zx4J2qtIHtHoJZVNvf/1RyL9RKSZkjZZZGhtNwnCH+8gDOIkjalRGd7f28fB7iJsNpSr+j1/haEfVxR58hVfgGcdZZKPLkWr7BOUsDySM8gcf1RuWVqL5RdUApBC4vGzOjuV0p055pkYxnjUn77lgY1vFscf/eLSNryefCtQhSLy092qpNUYS7+Zc5G0+9bp3nrgbIiSeL0ajWjr8+28FOa7Kkh2Ovpt1A4q1HKjIUoJqI90uf5zo6MMS/TvFrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2240.namprd15.prod.outlook.com (2603:10b6:805:22::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Thu, 25 Nov
 2021 00:04:45 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%9]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 00:04:45 +0000
Message-ID: <5d363ea7-16c6-b8e8-b6ee-11cbe9bf1cf2@fb.com>
Date:   Wed, 24 Nov 2021 16:04:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop
 benchmark
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
 <20211123183409.3599979-5-joannekoong@fb.com> <87y25ebry1.fsf@toke.dk>
 <3eaa1a93-c3f1-830a-b711-117b27102cc5@fb.com> <87r1b5btl0.fsf@toke.dk>
 <CAEf4BzbB6utDjOJLZzwbBEoAgdO774=PX8O9dWeZJRzM2kdxaQ@mail.gmail.com>
 <87lf1db4gh.fsf@toke.dk>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <87lf1db4gh.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0364.namprd04.prod.outlook.com
 (2603:10b6:303:81::9) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::13a1] (2620:10d:c090:400::5:f3e) by MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Thu, 25 Nov 2021 00:04:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b91fc11-ef57-4dd7-0b10-08d9afa73026
X-MS-TrafficTypeDiagnostic: SN6PR15MB2240:
X-Microsoft-Antispam-PRVS: <SN6PR15MB22404E0EA13A62E81C68ADB6D2629@SN6PR15MB2240.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lgRGaYQkQGAin8y8MGnzWg1tXRXHe0khjkVfVoSUPF/gsTOLTxR4Ld+BJjIjZ7zdXv6CdD6ZxoVWLnjBwT9eZTkDfMo50yvTFXxpQRweyzp+BDy9+mds363iRxpEjThak884gkdTWGIxN3yuARFs+r9kL/J/CLc9XE2Cn0wNgguoybiYdO6cHuL3SMjhaLiReGO0sQmaG/En61uv6pWXv9OAHXeNZPSp+DiCV+8mCVqZdFukKkp6Y5T5VE1dhmv7efmg82HhCZqyuSHUKrDDzAd+A0mjisZzDQ4hPZo0RXERkBRpOXBKrclofrD8CT2q6Mv2F2+N+DGkbKjl7J9mbE1lW0v6Z7rs4fegb6Q9YyCuc6YDWSrIV5ukqDVSy/mM1TCSGp3VKWomMoQ7q6I1YesNvbjFlVkNP3i9WyhkliTCZHBG2bfmIIh8iIaQnoGZH5IARPIvVCOK4HkY3n3DNn/JjfeVwFJMpFUntJV8xE7kurwMpgLKmEiXHvMH+dApnhjllcUcGFXOIbpIbzfmdmt6VPu4k0ZY8k/ZPk5hRSZZI7Yph3DxsrMTjcjYQ0X71moOohdrPdtv6GTzXfBpKvod0kGh1v4SEMIohhk1GTxKTFgEJzVRA1E154axRVSYixX4kCYR/rMp2lOAH2g8vYoNzo5DhxmhBPa2s1J43UK87mvl6kz0Clfk6eO8OS0o4fCyyeLNYCkmLZsL8TCs6hbdx+32aPKriBBHHImrja8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66574015)(31686004)(36756003)(53546011)(31696002)(2616005)(38100700002)(5660300002)(8676002)(66476007)(83380400001)(2906002)(110136005)(54906003)(66556008)(6486002)(86362001)(508600001)(316002)(4326008)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWVjR2czaWM3YWN0MVRjd1FNRUl2RWRCeEMzNCtRYkdGa0FKRGFPa0dzVkRW?=
 =?utf-8?B?OUZHUjcxd2JsMXpnR1lEZVdmRWZBZjJiRkt6L0s1MmN0QVhHTXRpSWIvd2VD?=
 =?utf-8?B?UW1OeVYwYjVuQ3lQamRIWjNmUWZ5SUJORTBsSnNHL01YU0cyUVVUdGVMdE8x?=
 =?utf-8?B?bzdxSDhnbWtLQ29vZnBMNXBJeFh5QkYrZ1BrNGdLNlVYaXdsSWFBOEFFWW1z?=
 =?utf-8?B?WEhmMmR1R2hlM0ZZTkJ4anlzai9Fc2ttSld0ZDFabGVma1pzYk4wVmd6Nncx?=
 =?utf-8?B?UDZxdks0Nk5YZFhjNDJEemZoMjYwU0VhSGJ1SWkxQ05zTVI3d0NPZFhpUFVX?=
 =?utf-8?B?ZE1qaXlVakp6SDlhK1l6T3RINnlDZXFoZmNuekVNcm53V01LTmoycGQ5RU9s?=
 =?utf-8?B?TGxtRDU0bDkyeFI3L3ZGMG5INEpHbjNVc0NMYnFSbVdtWDBhL2FxYUs4dDdF?=
 =?utf-8?B?U0J3amgzZDd3Zm5pUmNPNWFGMjlzY3kxMWZxQ2ZuSHVZQmJ0NkxkK0N4OEI0?=
 =?utf-8?B?bkt2REt3NEtSUVlFaGFEakFNQkZXTkx2enhKNGU5RHZsQU1vb2VkRXZVZEpD?=
 =?utf-8?B?YTZDNkNzZG1XVWVEWDZETXVRSzZiWVJDT3orSGlaa3dva1BzZC82TEZHaXhk?=
 =?utf-8?B?UWNnM1RoSWtiYm1TN1ovN2xXVER4eEVMdVE5RWR4VEhJRERld2NaZVhkbzN1?=
 =?utf-8?B?Wm9mRHk2YXd0aitFa0pGS3BvMEJnaTdSdkRud28xeEZJZkNudStWeFBmMUh4?=
 =?utf-8?B?RnEwcDU3dmFMYlBjakVKOGdKMnkvKytXMVl0cFdPOHJQOTdZRi9Ga3MydGRH?=
 =?utf-8?B?eEhsVlJCakJPMmVxSWpPSmlpUUxNc2d1U29lYmQySGltblZzcjFRa0xBK21U?=
 =?utf-8?B?NGJONUxkdWdmZ3dkUXl3TERoUldWSFBmQTZjejNZZHczaWhVR09qMXhvZkY0?=
 =?utf-8?B?SDNpWDdpTVBQNFFwTnJaaDl1ZVBhd1VDUWNoa1B5R0U4YnZPTHJrYjVyR2No?=
 =?utf-8?B?UXl1YW1zaWFxQm92R0tvb05mT0FjMkNIa0VYZlhpL2tWdjVJUkZGU3ZNODFY?=
 =?utf-8?B?MVF3Z0hJa2FkTzV1dXZpckdQQVRXSnNEdXo0aW9BVzY4dC83U3BKWGgxb1NT?=
 =?utf-8?B?eEF0YlF4NFpxVW5EMmI4dUx0Nzk5cHBOcDdKWUJYYUdhUnd4bmpLNlV2WjRP?=
 =?utf-8?B?ZmlCSFZtajNqWXZlZlhGY2JjZzNCN0IzSm5LQ3UwbkFMNCtkWjNXMWZvNVAz?=
 =?utf-8?B?Q3JVcEFhOXd6SDhWNytnYXpOVE1GS1dPTndQWCszSzBxKzY2MXNYSUhrNUdV?=
 =?utf-8?B?T0hEeWJjRkFVWFhLeEcrOEhhL2dIK1hhN2xtSW45TmdtNTU3bms1blVrK09j?=
 =?utf-8?B?a0x5Sm5YK2U0RUJoQ3BqeFdmZzU5WWYyN3JWZEZDMlFKdU15TmFNUndJRnJL?=
 =?utf-8?B?SmNKZDA3bXFvV1M1Ly82eTRIbEplTko0NWJSQTk2QTFhb3cxZWl6angxOXJ4?=
 =?utf-8?B?a00xeWRVYXBjU1dKR0NVSnNoVEJFTHMzVnA0RzZnWUJ4USs4VkpKbkVNUitu?=
 =?utf-8?B?ZktPUVpsdmRJd214KzQxckI4ODBLdlpHNXYrNVNlZW9HTlJFYUZmWE9KTkE2?=
 =?utf-8?B?OEZyQTQvQ21SWmdqTHlUa3BXUnE2Z1A3My9HSzl2RWk1Y3JMaG90MXFmVnZP?=
 =?utf-8?B?TnhkMlJvSEtZcXBXSDhtVFpYWGFMY2c1TTV0a211c2NQNGpVSGppOFBYY1ZU?=
 =?utf-8?B?Vlo4WmhiRFVuNERCUzlrdGtXVEQwNkFXUkRzcEwvRkNxb3R2bk9aZnBTMmFz?=
 =?utf-8?B?UWZtWXQrcEI3OVJKYzdkL2h4RzhiR2lwUXJYYkhvbzFoNkQ3QlVGLzJodGlB?=
 =?utf-8?B?NVRqZFg3QXpwNGlNdGZvUldVemduRXpmNXVuZDZuVEV6YVo4d0ZlMjFjNUls?=
 =?utf-8?B?Q2JMeWJITmx3dm9qUGRLbTRtZXkrK0UyZlN0WXVrVWxSZjIzbGMxR05JSmJo?=
 =?utf-8?B?L0ljcWg3SzBxRy9wa3dPRVpVY2xLRXRGL3VxeFg1MENQTHpXam9EWXhQalNi?=
 =?utf-8?B?dTNRbit3WjFLbXE5aVNMYWJuL1UwQnRIa1FHamQ2a2VPV0RpWVZVaEJNbzlX?=
 =?utf-8?B?WE1xVmc2cGFFT21WbTQrUE52WTVDcGEvL2tiakh6U1R2SkFDN1ptOHExRCtq?=
 =?utf-8?Q?tcqV/jCUpn/N/VpbM4a52nJ4hnNRIVjC2IFK0NF10qWL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b91fc11-ef57-4dd7-0b10-08d9afa73026
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 00:04:45.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCkr1PL0b92t8dHhYhb5GmdCcEHDGs64xjvqeh2KXxRul439+NV+dh35Iyume/+dJacc07V3oNa2oVEXZlqKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2240
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 5wMEbfVwaSFKupiB2NYmzV51jwdAUDdE
X-Proofpoint-GUID: 5wMEbfVwaSFKupiB2NYmzV51jwdAUDdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=946 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/24/21 1:59 PM, Toke Høiland-Jørgensen wrote:

> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
>> On Wed, Nov 24, 2021 at 4:56 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>> Joanne Koong <joannekoong@fb.com> writes:
>>>
>>>> On 11/23/21 11:19 AM, Toke Høiland-Jørgensen wrote:
>>>>
>>>>> Joanne Koong <joannekoong@fb.com> writes:
>>>>>
>>>>>> Add benchmark to measure the throughput and latency of the bpf_loop
>>>>>> call.
>>>>>>
>>>>>> Testing this on qemu on my dev machine on 1 thread, the data is
>>>>>> as follows:
>>>>>>
>>>>>>           nr_loops: 1
>>>>>> bpf_loop - throughput: 43.350 ± 0.864 M ops/s, latency: 23.068 ns/op
>>>>>>
>>>>>>           nr_loops: 10
>>>>>> bpf_loop - throughput: 69.586 ± 1.722 M ops/s, latency: 14.371 ns/op
>>>>>>
>>>>>>           nr_loops: 100
>>>>>> bpf_loop - throughput: 72.046 ± 1.352 M ops/s, latency: 13.880 ns/op
>>>>>>
>>>>>>           nr_loops: 500
>>>>>> bpf_loop - throughput: 71.677 ± 1.316 M ops/s, latency: 13.951 ns/op
>>>>>>
>>>>>>           nr_loops: 1000
>>>>>> bpf_loop - throughput: 69.435 ± 1.219 M ops/s, latency: 14.402 ns/op
>>>>>>
>>>>>>           nr_loops: 5000
>>>>>> bpf_loop - throughput: 72.624 ± 1.162 M ops/s, latency: 13.770 ns/op
>>>>>>
>>>>>>           nr_loops: 10000
>>>>>> bpf_loop - throughput: 75.417 ± 1.446 M ops/s, latency: 13.260 ns/op
>>>>>>
>>>>>>           nr_loops: 50000
>>>>>> bpf_loop - throughput: 77.400 ± 2.214 M ops/s, latency: 12.920 ns/op
>>>>>>
>>>>>>           nr_loops: 100000
>>>>>> bpf_loop - throughput: 78.636 ± 2.107 M ops/s, latency: 12.717 ns/op
>>>>>>
>>>>>>           nr_loops: 500000
>>>>>> bpf_loop - throughput: 76.909 ± 2.035 M ops/s, latency: 13.002 ns/op
>>>>>>
>>>>>>           nr_loops: 1000000
>>>>>> bpf_loop - throughput: 77.636 ± 1.748 M ops/s, latency: 12.881 ns/op
>>>>>>
>>>>>>   From this data, we can see that the latency per loop decreases as the
>>>>>> number of loops increases. On this particular machine, each loop had an
>>>>>> overhead of about ~13 ns, and we were able to run ~70 million loops
>>>>>> per second.
>>>>> The latency figures are great, thanks! I assume these numbers are with
>>>>> retpolines enabled? Otherwise 12ns seems a bit much... Or is this
>>>>> because of qemu?
>>>> I just tested it on a machine (without retpoline enabled) that runs on
>>>> actual
>>>> hardware and here is what I found:
>>>>
>>>>               nr_loops: 1
>>>>       bpf_loop - throughput: 46.780 ± 0.064 M ops/s, latency: 21.377 ns/op
>>>>
>>>>               nr_loops: 10
>>>>       bpf_loop - throughput: 198.519 ± 0.155 M ops/s, latency: 5.037 ns/op
>>>>
>>>>               nr_loops: 100
>>>>       bpf_loop - throughput: 247.448 ± 0.305 M ops/s, latency: 4.041 ns/op
>>>>
>>>>               nr_loops: 500
>>>>       bpf_loop - throughput: 260.839 ± 0.380 M ops/s, latency: 3.834 ns/op
>>>>
>>>>               nr_loops: 1000
>>>>       bpf_loop - throughput: 262.806 ± 0.629 M ops/s, latency: 3.805 ns/op
>>>>
>>>>               nr_loops: 5000
>>>>       bpf_loop - throughput: 264.211 ± 1.508 M ops/s, latency: 3.785 ns/op
>>>>
>>>>               nr_loops: 10000
>>>>       bpf_loop - throughput: 265.366 ± 3.054 M ops/s, latency: 3.768 ns/op
>>>>
>>>>               nr_loops: 50000
>>>>       bpf_loop - throughput: 235.986 ± 20.205 M ops/s, latency: 4.238 ns/op
>>>>
>>>>               nr_loops: 100000
>>>>       bpf_loop - throughput: 264.482 ± 0.279 M ops/s, latency: 3.781 ns/op
>>>>
>>>>               nr_loops: 500000
>>>>       bpf_loop - throughput: 309.773 ± 87.713 M ops/s, latency: 3.228 ns/op
>>>>
>>>>               nr_loops: 1000000
>>>>       bpf_loop - throughput: 262.818 ± 4.143 M ops/s, latency: 3.805 ns/op
>>>>
>>>> The latency is about ~4ns / loop.
>>>>
>>>> I will update the commit message in v3 with these new numbers as well.
>>> Right, awesome, thank you for the additional test. This is closer to
>>> what I would expect: on the hardware I'm usually testing on, a function
>>> call takes ~1.5ns, but the difference might just be the hardware, or
>>> because these are indirect calls.
>>>
>>> Another comparison just occurred to me (but it's totally OK if you don't
>>> want to add any more benchmarks):
>>>
>>> The difference between a program that does:
>>>
>>> bpf_loop(nr_loops, empty_callback, NULL, 0);
>>>
>>> and
>>>
>>> for (i = 0; i < nr_loops; i++)
>>>    empty_callback();
>> You are basically trying to measure the overhead of bpf_loop() helper
>> call itself, because other than that it should be identical.
> No, I'm trying to measure the difference between the indirect call in
> the helper, and the direct call from the BPF program. Should be minor
> without retpolines, and somewhat higher where they are enabled...
>
>> We can estimate that already from the numbers Joanne posted above:
>>
>>               nr_loops: 1
>>        bpf_loop - throughput: 46.780 ± 0.064 M ops/s, latency: 21.377 ns/op
>>               nr_loops: 1000
>>        bpf_loop - throughput: 262.806 ± 0.629 M ops/s, latency: 3.805 ns/op
>>
>> nr_loops:1 is bpf_loop() overhead and one static callback call.
>> bpf_loop()'s own overhead will be in the ballpark of 21.4 - 3.8 =
>> 17.6ns. I don't think we need yet another benchmark just for this.
> That seems really high, though? The helper is a pretty simple function,
> and the call to it should just be JIT'ed into a single regular function
> call, right? So why the order-of-magnitude difference?
I think the overhead of triggering the bpf program from the userspace
benchmarking program is also contributing to this. When nr_loops = 1, we
have to do the context switch between userspace + kernel per every 1000 
loops;
this overhead also contributes to the latency numbers above
> -Toke
>
