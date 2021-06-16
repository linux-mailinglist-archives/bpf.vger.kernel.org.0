Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC83AA147
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhFPQaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 12:30:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233625AbhFPQa3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 12:30:29 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GGFCqq018865;
        Wed, 16 Jun 2021 09:28:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OzjMufZpHgvciPJ3e/uNdfnNnJsJ9TLheIi4FQXY/Ew=;
 b=JDxOVxXkzn/AP/E1csY9sg/t+QSX7SiccZwTLJPyVFqHv2c/xOrxukyyunilXpxC7he2
 AmahiHuGv0E7jFQIqIsqcN6cWZdDDPebF0m3cbZtlGh6/1BZL3JpgESVorHRFvoQttp+
 o9eR7tRsW9vM6vWljhgAxOqAH+oDbrht88Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 397jq2966h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 09:28:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 09:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OweYcZymtG1Hqkrs3n6TqxYpbPzY6j5wpYuscdCby8MO8STScFcKYIwi9BXN8ccP7KqW5g9tlG/icoxjSr9g5bfNGFVm/EdZ7WmVBVKa/m+iUpJA8ZBtPbdc24bU2Vv3/BUitDPN0KIe97G4oZ7IOW5dLLcTerccZ6Ew94CWktlrZbTiCBnGSbvkIEswiiT5S/v4ZE/iiOzKtUHFo6sghPAs2f17nqP3FSpd7VEmBNGNXgooo+BxasH6F/ZhUNNDaKLNUEA8UbQBwE/6pBe+auUXlH9voky9JRyAv/jZxWBZwg7DdeL3oYr4MiQGhU53wUWkkz+yXSrRZyr0nzCKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRmIwG36GsZzKgreQuspZ9Ycu8hRUEL5MtuUhFAYe9I=;
 b=a/vO50bWmfMGiN/X8ckEo3Qacost4Zuk8i+4SGf/0ojF1I+PUzi/rKdmP7O2/N3UeCLCP47WmSZq6y4gbooY0LbLpWozuvW0Z5u+p/+kC9ULPxx2HCSZjTqy7x9/FtIvpI5Ghi2Cct0JbPYAJcU/gBmBM2XuWaLUX5FLu+GlGcTVfPT34ZRMGd6I3VChy4TmngNCJZrOcwVReOefzFRlI2iCO6Rn7d4vUayjrJBW3O5HTwni3gvy9zv7LjHY0pYa3uq9zMHUkH8lEITt+Y8lB3gzLQBiiXWEFqm00WqdJ70NwpFisq9Veuy7ZWW6Dc7j5PdcX0N5AUXn2WOTaYeSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2061.namprd15.prod.outlook.com (2603:10b6:805:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 16:28:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 16:28:16 +0000
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
 <ad426c37-d810-1d1b-91d8-6d9922ba52f0@fb.com>
 <CAOWid-evaph=7b2GW+oj=38Hv1cHgdwya9A8XqL2eS5n3oL6yw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3e3745c9-2724-dc67-6fb4-8f822c295dcb@fb.com>
Date:   Wed, 16 Jun 2021 09:28:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAOWid-evaph=7b2GW+oj=38Hv1cHgdwya9A8XqL2eS5n3oL6yw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:b5ff]
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::11da] (2620:10d:c090:400::5:b5ff) by SJ0PR13CA0080.namprd13.prod.outlook.com (2603:10b6:a03:2c4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 16:28:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 464becf0-31f3-4b31-711d-08d930e3be6d
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB206197D51DE6A94B945FAC2DD30F9@SN6PR1501MB2061.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qc7PtzrPLKBOZyAPcCj57ZgxES4NISXYIQsvYfF2XCL/KWgWbL1bGmGgdxPE4ZxdTaIw8Hu3iTmus8jelFo2wEyLNbPodHblIhHGXi8ADwTYNfjzh7JmLUrypw5Gyhl79NFvV+XX5QpA+cKFHcjj0ZWgGNZi3I+vjFSejubusGnxBsMLsIGgn74K6FTMX6HqsdFYkC3Ft0TcTGI3dkepcx+l+1BypOxwrniMj6mebvcxgWLkBR4d7+oQ/PpjDNZDtM2/xBN3Vo4plnYZB8Ef4Hqp2AmzIp/LqM2+VUHerA8m0mpqjIXQ+Aw1R88oIve0NepKMVOOghjESa8ibvq7XMwVMNTAJWvvfK8WPtIR1b+MWLRWumoR6o0U48nQgN9L+cUFg8pfEg1BggmCcsQxHq1KRaPTNsT3sBOgIvNMtap9vMxibh5cF5hiKJZcacnCMFSOyUa6gdiRz/JkojT+z02IY48fRljhLcgCwCZJIGicMJJHwNMWyStUuZx9lYkrKRwMxAnthJvIEvQiPxyRCLr58yLUlbYImCYBlUY7FSjR/fp96k6THoAdzE0//RpYmojNjXP4oDoGg3W1r0WE6EXh+RScdYZJ3e6qONKQvvqQuXGBC3VTp3JBcylwPYGp8QXlL2iPMT9Hb4nK+65L69qdlE2hf1IAwwvM9Y+xYwhZvh3f/26npNpZuiGSQwJQHFE/VmM8gnfk89LYIRPxfPchBgDY8gK31JlxkJg2swxoU2xjeFAl5CH8kl+NQCtq0xWU/XYcIbfR9Xlr6y5c0Eyu+r2X3GiNS8hUeYOnM7AQpMUjvv0063r5L62vx3oH2ZK4dj1Wf6+kDWCLRqdVhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(31686004)(2906002)(8936002)(6916009)(16526019)(83380400001)(316002)(31696002)(54906003)(5660300002)(52116002)(66946007)(478600001)(38100700002)(8676002)(2616005)(966005)(186003)(36756003)(4326008)(6486002)(53546011)(66556008)(66476007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTE0RFZaMWxldE5wSFk2amViTDl6cWFwSER1RkdldVJ1MmIxTmRxbUpLSU5B?=
 =?utf-8?B?VFpvWTJUaWk1Q1JPdU5MZkIwa3llYU85cEZUeXBna0NaOGtzbk1GOEY4RzQ1?=
 =?utf-8?B?eFcwQmJtL0tCM3dhQ0hGaVN2ZmxobmpPeHg2WUNQWnZNbUYrRnlPNFFSOEZo?=
 =?utf-8?B?eFN0QVlnQ0JkQ2JFRXBNMUd1N1dQeU1pOXBMbnE3SEVadDlHcmMvOUp2aGxh?=
 =?utf-8?B?cXNLbk1BS2NBT2V0S3hEZk5IakZxSHNqVEdRNytodTJZOG1WUFpKQU9xTEtE?=
 =?utf-8?B?a3U2cURnZkNMOVRJOEFhN2c1cWZLVEpqb01UeGpOcGZZREZuYTRUYk9QUXVQ?=
 =?utf-8?B?STZ0MjU1Z1IxNG1MUlZyc3F3cG9sMmpXSGJOd3lRZEp5cm50SG91djFMOUt1?=
 =?utf-8?B?cXJralpTS2oxTXo1dGYzNVdrNUtySzFabUZOcTJYRE9SR3NHZUdWWWxIcEFX?=
 =?utf-8?B?ZlpRZUdpRVhFeUdRNXYwRXpPTzdmRkJ1eVVOa1BuRTNUbkRuakcxcm1UMncz?=
 =?utf-8?B?MHhYaXJ5Ty9ta2d5dlNpUEwvNExtcXdxMWJ4azY0UVhWS1NtZG9zaFV0TmFW?=
 =?utf-8?B?ODRUZlFSYXpTZ3lKNjNKdGJvV0grcHhZOVpNKzBBc05LTkc4bGF6NVAvRjVp?=
 =?utf-8?B?SnVaYTc3SnZGa0dXQVI5bVZmenp2OC9HcFo0NC9Pb1UwbzdNa0tyMXJSSVd0?=
 =?utf-8?B?Y2xJVnBWWElUZW16eWlTaStGODBGOUZNamkwV0hhZ3Q1WTd5NXNHV2MyV05T?=
 =?utf-8?B?bDR0TDhDRmNoeWtmdEUrVmFRTlBoMGxKMzZsMnBDZHpSMmVPbndvQ1N1akZN?=
 =?utf-8?B?QTcrK3lnckFjWlNaMVN3dzF3NlM3Y3MvZ2IvMU9lQk0zZUZyTG9zWEdZNGtG?=
 =?utf-8?B?UG9ocGdGSEF5UTkyTTN2RmZCV0I4cVErSTU5bzJFclNNVXNDZmo5bjVOdlpJ?=
 =?utf-8?B?anFXdVlTcUx5aXl1dTFRM2txeFBudzRiR0xsdjZjV04xamc3THduVStvcys0?=
 =?utf-8?B?Qnl6dWw0TFZKWThIdHMwaVR5alpMWHg1UW1EYjU3MEFGWCswRzNYZy84UzZ4?=
 =?utf-8?B?Tmc4bW9GK2VjRk93UmFOYWhTbWIvdlQvMlJWRWtqemk5SGxOVkh2bVZDajRE?=
 =?utf-8?B?bGtCbDkrWE56aVVIL29hVm45WXZBd0U3a2k1Mk9FMElLbERXZGx4Z04yS0Na?=
 =?utf-8?B?MGwxbkxZRXMxQ2sxbEQyNEEvVXA5QVhSdHRhRllUYzVYblMxcUZYZlJQNlZz?=
 =?utf-8?B?Z3pwTWQzWGhmMGVDV09oWEw1ZkJaL1R2dEpoVDZ6aFZjNEJXVFF0NlU2ZWtF?=
 =?utf-8?B?aTFEaDMwZG9NeWwzYWdkMGh3RzVJYmNZcTNjU0h0SWpoZnZEbWJlSFBVS1pP?=
 =?utf-8?B?b0t4eGdZMkFUN2pKZlBIT2tPWkZuVFFRK1ovYjZnbDFYaW9iZXZOUjF4TDh2?=
 =?utf-8?B?d1lFdVZkUU9Md2t1bjdPbXNObU0wbHZ5UjRuTytWNU9hYU0waFVXN1MwZ3pl?=
 =?utf-8?B?Z2VJdzg5MGJiOUhpMll0dUFUQ20xMElnR0tycW5MU3dpaHh4ZmR0NTJvdmYz?=
 =?utf-8?B?ZjFoRDJsSWV5MVMxOG9XbmpiMVdENUFHWkJCalk1RFFwenRtSnN2emZCWjNH?=
 =?utf-8?B?bUttQUFmRUZpc1ZaanNmcTkyUWxET1JDUHBWZUIrem9jM0l2bVNjcDdERVFK?=
 =?utf-8?B?Z29Bc3d6a1laNThwOU52ZHNCZ2lIZmJhalpCWUI2bmcrNkZaNkVKQVBzekt0?=
 =?utf-8?B?OWo5U3lCRjBOUVZucmRYK3cwR3M0QlBVZnBlSFRKVTFhci81TSt1QlJtKzBs?=
 =?utf-8?B?TVpKbG5zdDRUby8vd0RqUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 464becf0-31f3-4b31-711d-08d930e3be6d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 16:28:16.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN2wRdlhIIJuiVD0hmhzdgBcjL46TUkd5jK6qPCXdSfsGEbQZ3SQ++NIArH7ou/r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2061
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 1DELWfj_amyXcojBYEZ5uXSy5Y1Nbxpi
X-Proofpoint-ORIG-GUID: 1DELWfj_amyXcojBYEZ5uXSy5Y1Nbxpi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 5 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-16_11:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/15/21 12:34 PM, Kenny Ho wrote:
> On Wed, Jun 9, 2021 at 2:42 AM Yonghong Song <yhs@fb.com> wrote:
>> So your intention is to call functions in
>> drivers/gpu/drm/drm_gem_ttm_helper.c, right? How do you get function
>> parameters? What kinds of programs you intend to call
>> this functions?
> ok... sounds like my use case was not concret enough.  Perhaps I can
> elaborate further with the following examples:
> 
> In the GPU scheduler, there's a trace point
> "trace_drm_run_job(sched_job, entity)":
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/scheduler/sched_main.c#L813
> 
> If I want to analyze the jobs being scheduled, I can potentially
> attach a bpf prog with this tracepoint.  Each driver has its own
> run_job and sched_job implementation so I was thinking the drivers can
> provide a bpf helper function to resolve this.  Alternatively, there
> could be tracepoint in the driver implementation that one can attach
> bpf to, but tracepoints are not universally put in place (have trace:
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L221 ;
> not have trace:
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/etnaviv/etnaviv_sched.c#L72
> .)  So in cases without tracepoint, I guess I would be using kprobe or
> fentry?

Yes, either kprobe or fentry should work.

> 
> Note that all of these are in kernel modules.  My understanding is
> that BTF will work but having helper functions from the kernel modules
> are not yet available?  So let say I want to whitelist and call "

We could you have some kernel helpers interacts with kernel subsystems.
For example, ipv6 could be a module, some kernel helpers actually works
fine with ipv6 module, you need have some configure time checking as 
well as some runtime checking.


> amdgpu_device_gpu_recover"
> (https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4521 )
> from inside a bpf prog, or whitelist and call
> "drm_sched_increase_karma"
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/scheduler/sched_main.c#L362 ,
> I wouldn't be able to do so?  Are there any criteria in terms of what
> kernel function should or should not be whitelisted (separate from the
> kernel module support question)?  For example, would
> amdgpu_device_gpu_recover be not "whitelist-able" because of the hw
> interaction or complexity or likelihood to crash the kernel while
> drm_sched_increase_karma is ok because it's more or less manipulation
> of some data structure?

To determine whether a function can be used in what context indeed a 
very tricky question. The function amdgpu_device_gpu_recover is very
complex and has a lot of side effect. Maybe it can still be used,
but need to tag the function with some conditions and unless these
conditions are verified by verifier, the function cannot be used
in bpf program.

> A quick side question, does container_of work inside a bpf prog?

Yes, the macro is defined in bpf_helpers.h.

> 
>> kprobe probably won't work as kernel does not capture
>> traced function types. fentry program might be a good
>> choice.
> Thanks for the pointer.  I am not familiar with fentry but I will look
> into it.  By function type, what do you mean by that?

Sorry, probably typing too fast. "function type" here I actually
mean "btf type". To call kernel function inside the bpf program,
we need btf type to verify kernel function signature, precondition
etc. kprobe uses pt_regs and all types are lost.

> 
