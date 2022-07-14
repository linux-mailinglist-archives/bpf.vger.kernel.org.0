Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84A5575615
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 22:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiGNUB6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiGNUB5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 16:01:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5685760533
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 13:01:54 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EJqPrU021840;
        Thu, 14 Jul 2022 13:01:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wvzXMoEc/PVA3GY8ijregPB+9eVwsxqDwnGEqBZdYI8=;
 b=J76cAUobBjNhsYnRYhYzTk2m4erc2sdn+RlLH7b7gtVoK/8N1OkfbduxuRXWAUAYyKIp
 JgRj3jatabrQ22MvMeFYn/LBfcjYrVpn1/r8muWC6EWIiToM12viSIu0+Eaetv1heDik
 Jn7Uo8ymgzYpn7M59tsrtRqNMbAkRTB5rfs= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hak0eb5dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 13:01:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn8V4aQg4VdDIb8r1IgON1LI6vtkIwVMqH544yvOebYhQxXfxB/b8YeHB2fMYLr4z9XQzbSCrIh7pU4LaJCIjhTzuDiZhLe2uBqEcZ+SxWMNuajvYvOvRzKLt+WDPHBRWmnWCS2RypUGevbSfym4G8EBVsasZMpU2GJiUeDnNYNJ0Id9o4wZ8PMnsVm0iLmqP8JSbcjPZxwjMzWlWC3WwVZwDUEAjnhBufA0FpHOmOAvv3hntW51Zf9OEyu+7rkmGi0UPCDArBpWFFxr2e0rx0LsO4gsw4midvf3Vb6nZ9cbLhUewwcGEGnAnjCszRz5reDqJ8vZLf9DvKOPogyFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvzXMoEc/PVA3GY8ijregPB+9eVwsxqDwnGEqBZdYI8=;
 b=iYbT1SnNSSofVFl2wwDLAmn3dcHBJcLlqxGfk5uq62nr8pI37+IZAyW3zJm0uMZjjyMIx144yWTJ02WhCg2zXggvH6Ea/JMWU5sGUtJRBIyVl34fJftVcGnhRD0PqwWP3WHCisi9jd5QyYyWrd+jnSkIj/3uUKlF8yxOCGDM5t8R0IKk37ma7TuMXsy3RfzDMmYc8c/D0xsZgfTCes6Lofq3f15xTJi1txtdZpGmVMkpsuZ3L738gcqyqx1GDmt+X3FI3/WrE8Bvz1Nk5O80qEHqzW2u8JtEixwLYU6zavnB0A2wF9jBkDlieu0IwNQFH0XP2jpDCq4zmqCW5GDVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3927.namprd15.prod.outlook.com (2603:10b6:5:2b9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 20:01:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 20:01:33 +0000
Message-ID: <444b10eb-506a-583f-82f1-9c8ca4539542@fb.com>
Date:   Thu, 14 Jul 2022 13:01:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf] selftests/bpf: Do not attach kprobe_multi bench to
 bpf_dispatcher_xdp_func
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <20220714082316.479181-1-jolsa@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220714082316.479181-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::42) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 677663c4-f8e6-4082-6fe7-08da65d3a6ad
X-MS-TrafficTypeDiagnostic: DM6PR15MB3927:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2i9yxjfBTn5wdcmm/EPWTSFhzAz+GJED3pTbJeMeDzPeBZgTALRXV3jNW9yCHQcxH1FQRTw+ae9luJ4IUQvWQZp3kb7B9xSF0AvD3i2hB8fCLkp58zMJk9ExPX4A3/FhJVCOsdhaO3QEScjXiInEZQzJMFxZ1T4dIR6yMWGu/Mj+vbf9v0ym4i83UyYT8FfdZbuH2+Y6lyXXE89kYWbH8xFDg2UtkraK9B9hLz7fXO9WI8bCb4A54ivygt40pP9PUx4joI9rW5wD0vF+mvq+m1rjavDMSJCffaaH0RoMZj/d2jwLUo3d8lVK30lQfVI7uplUhSRK+zbG1TcwR7gsEJ0erygExGCp255LuOuxXyr1ndjhvamsnsU+YbBwkZGVYkrDsx4AGjCLuB+0/BkrJDclewAMU9PeHZWcelIeI3IP16OvePWTe6JdvIGKvRZ9IVXzvs/D5jl1eFueM4KLjJrJxGNo3OHuLK/YCFwG/3f3vIABmP8bBjUvDoh2+E9Uh9VzbfSiAMFt7GfNwECS1kg2xilBiWhmi2aLStvhWxtwj5OH8jVACQw+NS4L/itReebJdAOyLvpQXlug7dGZ/yo5jl+/WJn348RzFwCWYyvj+RE3CjySotgJGwn2jXQIUC7eDrqUHdA6NzBeUJM5Z6Qww8p0tomTce9fpwlALw2hLgapmEURZ+Kd/xFPT3HIU3gMiPK6hXMZPXum6+ePOJ83+Z4P1p0iF7l+8q/FrRMFlf1Tnu8wA//tXJljePMNuI47njR5rukpNwy7Z17h+NIYlHptKHNE9qlSydahZgA9pVWMsNyyJNXAHsFHoocrTthopIIVrYZ9V4ZaC141g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(8936002)(186003)(66946007)(83380400001)(5660300002)(31696002)(478600001)(6506007)(86362001)(38100700002)(53546011)(6486002)(66476007)(2616005)(66556008)(4326008)(31686004)(110136005)(6512007)(54906003)(8676002)(36756003)(41300700001)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFuNGVtdS9abXhtczdlS3cyTnRwVmt3ZzJoeFdvbkZNbTRGdk92bStsYkZx?=
 =?utf-8?B?TkRpbGpMZHU1NzZ6UTQ3OTZqeGJaRDhYZGdUaGFxRko0Q1loOUJ3RHFXWHhD?=
 =?utf-8?B?ZTlPclQrQ0dka1JWKzJ2QmJjOVdPNGpDTXhVMU4yZFVsU21yNHh1eWczVFF6?=
 =?utf-8?B?RXIvWTdEamxvSjQwanlKN29ZWGRENjViTmZwbGlXcFJzd3ZqR1lXMUtpaE5h?=
 =?utf-8?B?VGF4M2hOdS9QSVhVK0RXVnEvSmdENHd6b2l2b2JqSTRYdDRCMG51R3ZhVVNM?=
 =?utf-8?B?MmtHVTI4ZWUxYlJGM2FmczBZMVVKZEswbDFOYU80eTh4V1ZlUTY5cWFOYUNk?=
 =?utf-8?B?Z3pXYXZITEZjcFRqUnViRUZMTEV2Z2I5ZlpjV21pcGI3QmU3RHA2Z1VZbUVS?=
 =?utf-8?B?S3BDSkNWUmptWS91RGI4b0c1TVpBSFUxNEl6N1JKbE1VTUJTU001OHhNQnE0?=
 =?utf-8?B?UkVSUUNKMUlnZ1dtdk1mSTZlUW9lMUxEL0RzOVV6ZUpadHFFNExqdDlDUFJu?=
 =?utf-8?B?bWFON2Jad0hQN0hzdEFRSFN2THRZM3FBTkhDSGFabXFIOFhoS05mV2dveEpr?=
 =?utf-8?B?OW1wMEhMb3UrbFcwV0hJeTNpZHAwSE5mOURWY09FQTN1L21IdGd5SzB6aWdJ?=
 =?utf-8?B?cWFXK3BzeHRDWC93ZU95MnpjWTVqWlM1REhVNTloYVlLR0dQODlRcWhHSW5p?=
 =?utf-8?B?NEw3VWpjcmttM1NPS1EvWTJva0JHMUc0T21hMWJWRHVwVkJqRHVzS1k0Y3JO?=
 =?utf-8?B?cUYyMUtsMFRNblN3aGQ0N2lRUWkxNUovMnBqTDNkM1MyaEVsZTFqU1ZDdzZO?=
 =?utf-8?B?endycjlUWHNod2hQR3l5ZEZuT29CN0hoSjlHYUd6ZjVYOEZXa1NRZ0VjOWI5?=
 =?utf-8?B?N0lWNU5sMko2b1hFZVpmUVlkNlllcGk1Z0hXSGNLNUcySW1tUXNjZHUydThQ?=
 =?utf-8?B?WEhJRm9sc3czUDZPSGRjYzBCbEtDbEU4Rk8wSTRqRU9uOCtvSG9DYnQxWlhD?=
 =?utf-8?B?RllaL003aHpjVERvZ2Jja3lnTzZORnBzMGQwRGYwV3dVWUtLdHV1SGxDczhX?=
 =?utf-8?B?d29DVW1BN2NXRWZTcHNGaktXaG5rY3VHTDhsZ1BwV3ZDbFZCVmlWT0hVRkI4?=
 =?utf-8?B?TVhrazgxS2Qyam9zTVNDSk92a01qaVdRSjZQVnN2MHVkWmRZVzNHb0Q0ZCtl?=
 =?utf-8?B?bEJnOFBIYWNubEluekZqTSs2TGtaYkE2dEI2cXd6OEFONnc3bTcvOVNBaHdN?=
 =?utf-8?B?WnJJZHo3cWgxdWZ5R1oxM2pYZ1A5ZHR5MlIvVXlUc3l5TUxnZFlHZ1JpZkJM?=
 =?utf-8?B?ODJuQiswUit1NWl5QjBuQVpTYnRtUldtZWgyb1dEV0RJbDRyZ1hyTExLN0Zz?=
 =?utf-8?B?RnBhcmY0VVZ5cExoZVBvRHNCdURyWnJPdFpTeGxxTGsyYjRCMnJnUW1XNUM2?=
 =?utf-8?B?aFdwR0lITzlqYjlaN2hBWDNSN0F5WXZ6c3JuMFVLUlVHcGlBREN3YzRGTGI0?=
 =?utf-8?B?MVVRMkxzVXpnZzN1NHZqS2taaWRMRU5KVnU3YkFQeVlwU01qWHF3UERKM05a?=
 =?utf-8?B?UnVKSXdwY0ZtRm0reHRidUNBeWMxcmZ4QTNNRFc3TW16V3dYY3VUaGVIYzNE?=
 =?utf-8?B?WjF4VktZUk9iRWZzazgvSFlpdmlrRkNKL3Vwc2JwODEyT1F4QXM1UjdjakhW?=
 =?utf-8?B?WitZN25vUUlEZmJrc1V5d0Rpd2xVUmJzM3VkZVR1L211OHFicDVHeUtaRGlP?=
 =?utf-8?B?OHdrSHZROVk1M2xvQU4yVDN6OEw2WmxvenZhbDVodzlFb0tiS0U3RHFNZ1Ex?=
 =?utf-8?B?Q01OeCthT0JrRTJCSGNxdjVMN1l0MmNFK2RPakQ2eHBWSVFVNEEyQzFvR3ls?=
 =?utf-8?B?YzhwQnpTR2djQzkySFhoR3grVWpZTmoya1V2UHRBWFgyOHFldHRLSXdQV0xr?=
 =?utf-8?B?cU13MVhIZUtQMzhyWWZ0TTdKZHp5WmV5SnFFdVJ6KzJBNUlFb0NWYVgrMEVk?=
 =?utf-8?B?RlBNeFpWZ3cwZTBpc3RZYzluMUp6VnJpcEJTcHdTSW5rNTBSZDJ5QlRUSVdy?=
 =?utf-8?B?TnhlTnU3OGk3M0JPd3ZNUXZRT0hYRzBrdGxEV2hDVVYvUnM1TEM1QjdVVWJW?=
 =?utf-8?Q?X++hjMUD9d7M0Vei2wuYK6OSE?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677663c4-f8e6-4082-6fe7-08da65d3a6ad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:01:33.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsIDo0Af9M2FLCHlTK4s4qRopN1EYFhPObxwb09iYOJI6PUVmxl9Z5Va7BDPdU0+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3927
X-Proofpoint-GUID: 2YmtieVwwOH9jrUBtQyzsIa-69Cihl-y
X-Proofpoint-ORIG-GUID: 2YmtieVwwOH9jrUBtQyzsIa-69Cihl-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_17,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/14/22 1:23 AM, Jiri Olsa wrote:
> Alexei reported crash by running test_progs -j on system
> with 32 cpus.
> 
> It turned out the kprobe_multi bench test that attaches all
> ftrace-able functions will race with bpf_dispatcher_update,
> that calls bpf_arch_text_poke on bpf_dispatcher_xdp_func,
> which is ftrace-able function.
> 
> Ftrace is not aware of this update so this will cause
> ftrace_bug with:
> 
>    WARNING: CPU: 6 PID: 1985 at
>    arch/x86/kernel/ftrace.c:94 ftrace_verify_code+0x27/0x50
>    ...
>    ftrace_replace_code+0xa3/0x170
>    ftrace_modify_all_code+0xbd/0x150
>    ftrace_startup_enable+0x3f/0x50
>    ftrace_startup+0x98/0xf0
>    register_ftrace_function+0x20/0x60
>    register_fprobe_ips+0xbb/0xd0
>    bpf_kprobe_multi_link_attach+0x179/0x430
>    __sys_bpf+0x18a1/0x2440
>    ...
>    ------------[ ftrace bug ]------------
>    ftrace failed to modify
>    [<ffffffff818d9380>] bpf_dispatcher_xdp_func+0x0/0x10
>     actual:   ffffffe9:7b:ffffff9c:77:1e
>    Setting ftrace call site to call ftrace function
> 
> It looks like we need some way to way to hide some functions

need some way to hide some functions ...

> from ftrace, but meanwhile we workaround this by skipping
> bpf_dispatcher_xdp_func from kprobe_multi bench test.
> 
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

I tried with 32cpus on my local qemu/vm but cannot reproduce the crash.
But look at the code, your should seem okay as bpf_dispatcher_xdp_func
indeed could be poked and simplified. So with a few nits,

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 5b93d5d0bd93..8c442051f312 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -364,6 +364,8 @@ static int get_syms(char ***symsp, size_t *cntp)
>   			continue;
>   		if (!strncmp(name, "rcu_", 4))
>   			continue;
> +		if (!strncmp(name, "bpf_dispatcher_xdp_func", 23))

ffffffff81b17a90 T bpf_dispatcher_xdp_func

bpf_dispatcher_xdp_func is a full name, you can just use strcmp here.
Further,

linux/bpf.h:#define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func

Currently, bpf_dispatcher_xdp_func is the ONLY BPF_DISPATCHER_FUNC.
So comparing bpf_dispatcher_xdp_func is enough. It would be good
to add a comment to explain why not comparing to bpf_dispatcher_*_func.

> +			continue;
>   		if (!strncmp(name, "__ftrace_invalid_address__",
>   			     sizeof("__ftrace_invalid_address__") - 1))
>   			continue;
