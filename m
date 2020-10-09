Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07B228918D
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 21:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbgJITI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 15:08:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbgJITI1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 9 Oct 2020 15:08:27 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 099J3AaO013975;
        Fri, 9 Oct 2020 12:08:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=fice50gFdH38jxLHg0bgPjaYUmxjRrbykxBzyYQr0tE=;
 b=YEXwGhbLDp89bsw3g17TMe6Ti3/Yu1vwbiSV7PhqTBFA9dfKb6cBH+pYCsRA+jfM0can
 t+ffWcA/DvH1Ol7m9t9DrrJhgMpUgN9B9hc00xhIgA3S6j6ss5kkikKWMYF++HmH3KFU
 1my4nFzOubQ0IwE4DtY6Us6TCRh+eZx5pSw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3429jfdcyw-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Oct 2020 12:08:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 9 Oct 2020 12:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNiQZZ58UCLd72yIGH0ruqdv03T60/0jUmwxMihjSMKe6GT432MQPYGBqFZ9EuemhrNLTad1Hc41mtRZIPHAElgAVSt64j0m2+QRhnNq+dO2BJfHuBpGJAOs239URgP8T0Vy8Kk4AS0cubkWdS0CHfe/d1Uv5gI32/9M7pfg8N8nRMhKnmITKdX/NnbFV0LXtkjlZ6ZKB73Iqzlwofp+rKVjWm/BR2D/SAeZFpXQ+xQ8UI74VsZXvBogq4MEjvFKokN7hbQFYojWvF1jLlZ7mKOLU1dtBTKFKTyPwUHAyXaAKLQwshVxquuGJqq4/xig8/dzvxFMdZUQP2e3v+SVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fice50gFdH38jxLHg0bgPjaYUmxjRrbykxBzyYQr0tE=;
 b=GjpglT26Qxu6+8zlAi3/sPHzERKtA9acMOT3ZIAPVCpnXHBnxIOj19sKaodEluSvQwRdJiwM7+6vOBQAJQyjvOL8/k6yl/U9Yoc3+akNZ1LWSv1YNT124gDWQLRBQzWuAUQfnsNm8hOHtX9Tn8QCbm3uC8vx+AsAq7pJFprkrDMzft0H31J2H4dCIvRH4CzQwcuCnngWS3ZECFJwBsr7j7uyZ68277Z6nirTinXL6zKNrURfJK1JPnV56ieJUIQrptVvuKeZHNMYmqGZfCKpLdkHTccSWK5rzJZBIFKbq5QFW8BP36y33sLpGlKCCfcwz3HYUfaYghdCh83y+DcLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fice50gFdH38jxLHg0bgPjaYUmxjRrbykxBzyYQr0tE=;
 b=akqA37tc4kMrtb3bUtPi4EvLcOp9b7QGH3Emef2TRtXP0N08sJSzAlmb9Gro15ycfrgjC+3c/8S0BCivTaMS3nU5V0knLptEc2+d8lEHkAvRfZPqJB86Z4VjWVNEFgLHIoH6zAZjHCvIx8Th/NlrWMRT+IcW9vM9S1oQJFkRhl0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3617.namprd15.prod.outlook.com (2603:10b6:a03:1fc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Fri, 9 Oct
 2020 19:08:11 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3455.024; Fri, 9 Oct 2020
 19:08:11 +0000
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Yaniv Agman <yanivagman@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net>
 <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net>
 <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net>
 <CAEf4Bza4KFJ_j7vmg-x_Zinp0PUM-zmWYHMq_y+2zWmX485sBQ@mail.gmail.com>
 <ece9975d-717c-a868-be51-c97aeae8e011@iogearbox.net>
 <CAEf4BzawvpsYybaOXf=GvJguiavC16BmdDeJfO4kEAR5naOKug@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <231e3e6b-0118-f600-05c5-f4e2f2c76129@fb.com>
Date:   Fri, 9 Oct 2020 12:08:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <CAEf4BzawvpsYybaOXf=GvJguiavC16BmdDeJfO4kEAR5naOKug@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:544b]
X-ClientProxiedBy: MWHPR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:300:95::20) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1844] (2620:10d:c090:400::5:544b) by MWHPR13CA0034.namprd13.prod.outlook.com (2603:10b6:300:95::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.6 via Frontend Transport; Fri, 9 Oct 2020 19:08:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d78b12ec-061f-485b-5494-08d86c86aa53
X-MS-TrafficTypeDiagnostic: BY5PR15MB3617:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3617FD1948EF83107A2A65F5D3080@BY5PR15MB3617.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIhxogygKfNIMmTXAXyWjcWvGiBurQP67Lyw5ah9tEtJKI+bwe6Nwi4tt/xQGykPaoKLgZIZz53FBTcS7oFPIaivM80vdGCLs6llx1G/WNIJ7/aI+cbXLP/EGHkCxUO1OVEoFAVzApywuBMP81sBirfw1JD61oHZY+IDBUryn3ruMZhzTvzYzlKO5U2VN+ASqLBDKEchNveSYaQkXSeCPuOEGZJti7cvr2YGKyEDB+y1D5bwpjn3SMzppQLbu9uSaLq94lrXK1pcDzjNkhDkpmFAIseWDZ+M6/hGbt5k27czWvp1o/WlFXgc/hFYgPSEy/YoiPmjlYwq3azNbyFs9bI/X7fxo+Hc0YvjIwTMagNk71Kst57X6heNy7EZ9rev
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(136003)(39860400002)(66946007)(86362001)(186003)(16526019)(31696002)(8936002)(6486002)(36756003)(31686004)(8676002)(83380400001)(2616005)(53546011)(2906002)(66556008)(66476007)(316002)(478600001)(4326008)(54906003)(52116002)(110136005)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RazMuG5GfjNSKb+/8nzdJxZue+dc4LBkUky0Kgv2tjMcFgS5hx3wa4O4PfVcbbhF6OfLGCWfPDJXZSvGgdkBRQDdwBvuUDpg60jnilG7b14zthKBHkibY29WHgPFqBELL5W1nC7rIcAwSm1M6SWRUstqg1mUoiQ0RmYFWaYJW5vjZWmoCOzJ1vx4nXjPQnyMqwNHM1TMPYAwQMkpDVUlXdsY9ZW9e81jMlcIIQY8PWA5gBHneuDGw/zLLiJdGqaR7sH2839phOYl2+cjgoIH9+BhE7hZnV5l7+aaCGWb3ksStOVHt0t1l5IHSZYw5Y6wUpQkdsCMZVa8C0A18/jow1lmnoxQHKzFKYQFavDUx82Z1m5yKwDJUGdnW9cuP3nEn0l6BQfKBpj5vSgqlckJUbFhTVJx4W5MOsINizK2xtUERs5kEU3SdOTG5wjALHC5M+xVxKYqE5ldDDb7tRbw1yJAk3Cn1ZyhmNENkt3bnnyccns8V7Vl1DRi6weo0TWptgxiJO9nm0mFTrp24Vd8XL6VRiHeHzcjyks7EiDTuHkND2sPvHiMJw7WEv2RMpHNy+oWUQrv/QUcF5kE8Zk91JJ6RGg06R1UICOm5R3RyoMWkAIox3H/VhryzRFHR63E3xvA7SJBG7ei8mtX68iR4nXZ3gKBnYwc5q+sddX+7dg8NN29xUaWc0c9DAtpkYbc
X-MS-Exchange-CrossTenant-Network-Message-Id: d78b12ec-061f-485b-5494-08d86c86aa53
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 19:08:11.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MINZ+9Zc03tPTQjbXXJsHrE1M6vF/GAQpITRUz9n5ZDMSkO4lUkJCbl8Fm+sZRjS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3617
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_12:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/9/20 11:59 AM, Andrii Nakryiko wrote:
> On Fri, Oct 9, 2020 at 11:41 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 10/9/20 8:35 PM, Andrii Nakryiko wrote:
>>> On Fri, Oct 9, 2020 at 11:21 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> On 10/9/20 8:09 PM, Yaniv Agman wrote:
>>>>> ‫בתאריך יום ו׳, 9 באוק׳ 2020 ב-20:39 מאת ‪Daniel Borkmann‬‏
>>>>> <‪daniel@iogearbox.net‬‏>:‬
>>>>>>
>>>>>> On 10/9/20 6:56 PM, Yaniv Agman wrote:
>>>>>>> ‫בתאריך יום ו׳, 9 באוק׳ 2020 ב-19:27 מאת ‪Daniel Borkmann‬‏
>>>>>>> <‪daniel@iogearbox.net‬‏>:‬
>>>>>>>>
>>>>>>>> [ Cc +Yonghong ]
>>>>>>>>
>>>>>>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
>>>>>>>>> Pulling the latest changes of libbpf and compiling my application with it,
>>>>>>>>> I see the following error:
>>>>>>>>>
>>>>>>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
>>>>>>>>> unknown register name 'r0' in asm
>>>>>>>>>                           : "r0", "r1", "r2", "r3", "r4", "r5");
>>>>>>>>>
>>>>>>>>> The commit which introduced this change is:
>>>>>>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
>>>>>>>>>
>>>>>>>>> I'm not sure if I'm doing something wrong (missing include?), or this
>>>>>>>>> is a genuine error
>>>>>>>>
>>>>>>>> Seems like your clang/llvm version might be too old.
>>>>>>>
>>>>>>> I'm using clang 10.0.1
>>>>>>
>>>>>> Ah, okay, I see. Would this diff do the trick for you?
>>>>>
>>>>> Yes! Now it compiles without any problems!
>>>>
>>>> Great, thx, I'll cook proper fix and check with clang6 as Yonghong mentioned.
>>>
>>> Am I the only one confused here?... Yonghong said it should be
>>> supported as early as clang 6, Yaniv is using Clang 10 and is still
>>> getting this error. Let's figure out what's the problem before adding
>>> unnecessary checks.
>>>
>>> I think it's not the clang_major check that helped, rather __bpf__
>>> check. So please hold off on the fix, let's get to the bottom of this
>>> first.
>>
>> I don't see confusion here (maybe other than which minimal clang/llvm version
>> libbpf should support). If we do `#if __clang_major__ >= 6 && defined(__bpf__)`
>> for the final patch, then this means that user passed clang -target bpf and
>> the min supported version for inline assembly was there, otherwise we fall back
>> to bpf_tail_call. In Yaniv's case, he probably had native target with -emit-llvm
>> and then used llc invocation.
> 
> The "-emit-llvm" was the part that we were missing and had to figure
> it out, before we could discuss the fix.

Maybe Yaniv can confirm. I think the following properly happens.
    - clang10 -O2 -g -S -emit-llvm t.c  // This is native compilation 
becasue some header files. Maybe some thing is guarded with x86 specific 
config's which is not available to -target bpf. This is mostly for
tracing programs and Yanic mentions pt_regs which should be related
to tracing.
    - llc -march=bpf t.ll

So guarding the function with __bpf__ should be the one fixing this issue.

guard with clang version >=6 should not hurt and may prevent
compilation failures if people use < 6 llvm with clang -target bpf.
I think most people should already use newer llvm, but who knows.

> 
>>
>>>>>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>>>>>> index 2bdb7d6dbad2..31e356831fcf 100644
>>>>>> --- a/tools/lib/bpf/bpf_helpers.h
>>>>>> +++ b/tools/lib/bpf/bpf_helpers.h
>>>>>> @@ -72,6 +72,7 @@
>>>>>>      /*
>>>>>>       * Helper function to perform a tail call with a constant/immediate map slot.
>>>>>>       */
>>>>>> +#if __clang_major__ >= 10 && defined(__bpf__)
>>>>>>      static __always_inline void
>>>>>>      bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>>>>>      {
>>>>>> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>>>>>                         :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>>>>>>                         : "r0", "r1", "r2", "r3", "r4", "r5");
>>>>>>      }
>>>>>> +#else
>>>>>> +# define bpf_tail_call_static  bpf_tail_call
> 
> bpf_tail_call_static has very specific guarantees, so in cases where
> we can't use inline assembly to satisfy those guarantees, I think we
> should not just silently redefine bpf_tail_call_static as
> bpf_tail_call, rather make compilation fail if someone is attempting
> to use bpf_tail_call_static. _Static_assert could be used to provide a
> better error message here, probably.
> 
>>>>>> +#endif /* __clang_major__ >= 10 && __bpf__ */
>>>>>>
>>>>>>      /*
>>>>>>       * Helper structure used by eBPF C program
>>>>
>>
