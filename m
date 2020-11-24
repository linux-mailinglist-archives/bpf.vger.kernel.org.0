Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935212C3084
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 20:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390963AbgKXTJm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 14:09:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59800 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389340AbgKXTJl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 14:09:41 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AOJ8tA1028808;
        Tue, 24 Nov 2020 11:09:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bLyRaqWRllMiXam7wVdyWWPdRYb4rbN7TmwNigZ4UNA=;
 b=p+Q/jBTSw4WT9RifgTWcL9h4zoGjsCuKvQOykjPe9wmrO4yQLLq3/rOo/UWszDQOJBsr
 bNdFQ2rdOH6FQ4OgRKYgHgJSNKR9W+cZ7GFETPAvfKIYtJRv4b2bqE0X7hCJV2IoSeKH
 ElULVpGpJnG5f/HYHwqUjHM9tJwbRBZ8cZw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3516xbrb04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 11:09:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 11:09:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgkkx/Q47nbV6xxTip34dOOkmHHbFW+YEj67kne1mHwlOQnXJZh0gM89+R2g3sdYdTs0PWqvUAylUl/PoZTrZ/M7Cwl0cvVYOGE3y9RJWRawVQnUFZB1ZF+Aa8Z/nHoHAdtccIuscabo4JSPRwpvBFYm1o8mdDeThdEgdiJLELy3DaF+Tvv/DseRjLICgSSb3FBWR2Fl1nbCV292OzwRwlxeNVTyXe2hB/cZV0Rx9YKeNJ7OFptHmwKwpG59+b7i89JCbPVfvsID3lNYIGlDzd2vXBwz9T8uVMsDk8AHdSBo1TG5diJo+FO066nL8nEyr8vVBs4riB/tAcd2GoTS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM8faFPRge1Jl0aXKxZnzEkQL15ORIMx/gc/3Tncq9k=;
 b=FobCNSLROS9Ar/UnavPSsbdMH8J3SJ0907ar+Vj2hVv7xOQ7/xV5fw5MGB8ApW1RB7TkJHxQE/2r3P2BiqUDs7S9CJuzkZbYuSPfElV4Jd+4vDzosY6de7JRA66hID25hlPrnFncHl9uOFNe2nxrpDWEmdp9PtiKeYe097J/I1L8W3NJf6bqWs+Zd3EucP39h3K+h41+R5owMziTvIVYmpfBDw7aV9kDea51o14kz6YZs+nZQ+6P1exLZlqXUysOpZB1zosRLtN3CdDhtMzHaB/+WZUdXwrDI3ETghp7iPyc9r/wbPcTqVZUhLbvqHKvv7KLjB24VhQhTsGWCxSQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM8faFPRge1Jl0aXKxZnzEkQL15ORIMx/gc/3Tncq9k=;
 b=Bh4bQsI5GaPzYlAf4jJt1ADVVmsPsCob8qw0LZieBh8Zqt3uW/6zVHrYbRtpRlx5DI6sVoWWsVJDhLUPCZAwkUShic1CXpGpHTHt67s7lonAtM2GkmPSumlyk/Vw9WXAdfa2LuvMpKSiVSvDvTYhHMBcoH/sR89l1qqlKO1cqZU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3368.namprd15.prod.outlook.com (2603:10b6:a03:102::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 19:09:21 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Tue, 24 Nov 2020
 19:09:21 +0000
Subject: Re: [PATCH bpf-next 2/2] selftest/bpf: fix rst formatting in readme
To:     Andrei Matei <andreimatei1@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <20201122022205.57229-1-andreimatei1@gmail.com>
 <20201122022205.57229-2-andreimatei1@gmail.com>
 <dbb95d56-0700-c8b6-1f6b-d632144075bb@fb.com>
 <CABWLseujFiAtv5fWDwxjL__+6MSxrcYRp9ejkp6dC4=EM1mNQw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d334f58e-b153-8b31-5d6e-acb1fe694003@fb.com>
Date:   Tue, 24 Nov 2020 11:09:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <CABWLseujFiAtv5fWDwxjL__+6MSxrcYRp9ejkp6dC4=EM1mNQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:4987]
X-ClientProxiedBy: MWHPR2201CA0051.namprd22.prod.outlook.com
 (2603:10b6:301:16::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10b2] (2620:10d:c090:400::5:4987) by MWHPR2201CA0051.namprd22.prod.outlook.com (2603:10b6:301:16::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 19:09:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eddcda44-262a-4998-8875-08d890ac7312
X-MS-TrafficTypeDiagnostic: BYAPR15MB3368:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3368F69167CCFFFD2A6004A5D3FB0@BYAPR15MB3368.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svxAz6hXNAklq24bJzgGS3JmNiA82dpr1YB0z5sTHaZ/cQ02OhEHFa05lVxyT9XQw6ZLsjkGYjiZZhssOwDCfAoC4XROxclQ1X4m73TeBIe/isKwu4ORjPsCmseghpXWCYl37kCGRdRDcAXhFftovRn443s5aR9uquxFTykB4/XZdwt7pFbAAcJelCdE9S5zMB0sqno0q20VSHGEP8UrOup1bMMlKWE6+eSMnTveI5RW+tjraXNvKrgZMo8oFr/59Sk0/ztY8GXCoZgl5m8YX3To8dF2nGVscXYRziC4XYYcEVryTZDgyqy08tw1X5eQ8lM+qcHrTdTv395vyVG+mJ7QAlv++b9OlpFkUHBO7b/9ZFKtc38pRGJi7FpRZGF+vcUlH4+IPH7bzIQIAXHPyoqPRIbxqgnoKuWyaMLokq+0Y+hs6BpXQ9qS2010/3Uo0yBUbTHR3fLHHK/KvQ1KTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(376002)(39860400002)(136003)(66946007)(966005)(8676002)(8936002)(4326008)(16526019)(66574015)(186003)(31696002)(478600001)(2616005)(5660300002)(2906002)(83380400001)(53546011)(6486002)(36756003)(31686004)(316002)(86362001)(66476007)(66556008)(6916009)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WWgvN2EyZDdQUUR6R0ZQOGQvNmgyMkxVRzlPUVJneWpFOFV1MkhJb3lsdk5H?=
 =?utf-8?B?SW1aRytwalFhMm1EMUppdzgxVmpBMjRlV3pzemlmSEI4N1M4U1luWFR1UGp3?=
 =?utf-8?B?cm9KWEdsZzlNTWVQVnIxd3RRcVYyR0J4UXVnQUQ1SUNMaXFMNGptWlJLR3pI?=
 =?utf-8?B?bHlmVHpLUGlXazQ3ckxKeDBQSWNranRTUjB4WkdoblVNaWEweFEzYmY2TEhC?=
 =?utf-8?B?OHRXY21PMlFjd21BWWJLdmhDMGxlYmJKN0ZzWWZUOVFYL0xjbVpnRUZNMWQ4?=
 =?utf-8?B?UW9CQWthS2doTU1kWVhVbUlQNEpjeXB2QkhXaGJFYVA0M1ZkZlN3aWNhMlh1?=
 =?utf-8?B?S0VaSStIYkxmL0ZYNjdxVjEyR28xeHFRaXBDZkFKRTFKemlLL0RnQ2dZRGpY?=
 =?utf-8?B?OUNNR0R0bWdPcVVWd000Ny9RekFPUENnSllMRFRWNEx5QlZNTjhXR3VEZHd2?=
 =?utf-8?B?R0tjZ0RVRUVaN3Jtb1VFQzZFTnB6OEEvbHZCenZ6N2p4MlQ0ekVGcmRGdXJy?=
 =?utf-8?B?Vi9DWFVHM29tUDc0dENmY1lKcHl1YVlIZDJDRXIybjM0ZWluS1lqVzhHTC9H?=
 =?utf-8?B?V3FPRTdzZGQ0Vlc0YTBQRWhKdGdENjllTXg2K3AreTVoSUF3VVpQaFgwMERG?=
 =?utf-8?B?ektQVFppOE1NaUdVLzNJMGE1WjdvcEo4SDhSTStkcmE5dmVzNUhpcVQ0Z3lm?=
 =?utf-8?B?b1R4d1BGNGNxNmJuV0I0ckVieGhFTDNpUUEvdHJGcGY1OUY1TTZaTDdFbThn?=
 =?utf-8?B?d2xvaFNOWEN0NGhodXZCNzZRRmNDeFhrWFBnVjBXNmFNcmNyOTdHTVhFZ1ho?=
 =?utf-8?B?ZzNlbVZtaWpZdi9iOUtyZGhjekJLQk1XTU9NaE1OaU1mMkFmbVM3Ym1ZMUNJ?=
 =?utf-8?B?VVovSlU3b2tzcjNscjF0c0tBQ01GcS95RE5vbFBxb1JVN1Y5NXpZdW9sZnBF?=
 =?utf-8?B?dU44NDN3K2xTR2E1L1NMNWpKeWxYc2RLWUl3STFXWEtLWVg4T0x2MWQrb0px?=
 =?utf-8?B?d3B1cnhmODh2VGVFT2FUeXJoVGp6SVVScngrWnV4QmdJc0RSU05lVWxNOU1U?=
 =?utf-8?B?NUtla2o3dGZwTTcwazc3Zkt4WlpiSTBpZzVrYjlkRzZKRWEwamtrZ3RMOWtv?=
 =?utf-8?B?bFk3S0toYWdBeWh3UXRuZE01R25pQnNxS3dwSVRNYjdmRHFsY21Eb2VRTC9F?=
 =?utf-8?B?ZTN2aUdFN1RsNnJtZ1JWYmFIUlozU1U0Mks4WjlQWkE2S2Znd1ZFdTV1N3RY?=
 =?utf-8?B?dHVjMFhKaU5tamVkT3ArUUdFcFQ4NEZlOUQ5ZXRFL0taY3g3RUg3cmhnOW5E?=
 =?utf-8?B?TlllZ0hEZUtxejdTT1Fub2ZORE5kUGRaZnNUd2dXNTNxNWtkNjYwOVp2TTFi?=
 =?utf-8?B?QmhaSTVzOU5aMlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eddcda44-262a-4998-8875-08d890ac7312
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 19:09:21.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzFRXzuHLu0E3mgBVxlWPibHLv4iftr7H5DMxuBULTGExLNKlE6UwRrxFPpDCzDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3368
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 19 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_05:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/24/20 10:29 AM, Andrei Matei wrote:
> Hi Yonghong! Thanks for looking at my patch!
> This is my first patch to the Linux kernel / first time using an
> email-based patch workflow, so I don't know what I'm doing. I hope to
> contribute more to BPF in the future, though.

Thanks for making contributions to bpf ecosystem!

> 
> The patches apply fine to me on bpf-next master (am I supposed to be
> targeting a different branch?), and I've asked someone else to confirm
> too. I've tested with your exact git version. I have a theory about
> what might be going wrong for you, see below.
> 
> Here's what I'm doing:
> 
> # prove I'm on bpf-next master
> $ git show | head -n 5
> commit 91b2db27d3ff9ad29e8b3108dfbf1e2f49fe9bd3
> Author: Song Liu <songliubraving@fb.com>
> Date:   Thu Nov 19 16:28:33 2020 -0800
> 
>      bpf: Simplify task_file_seq_get_next()
> 
> # Download the patches - these are the "raw" links published by
> lore.kernel.org for each of the two emails.
> $ curl https://lore.kernel.org/bpf/20201122022205.57229-1-andreimatei1@gmail.com/raw
>> p1.patch
> $ curl https://lore.kernel.org/bpf/20201122022205.57229-2-andreimatei1@gmail.com/raw
>> p2.patch
> $ git am p1.patch
> Applying: selftest/bpf: fix link in readme
> $ git am p2.patch
> Applying: selftest/bpf: fix rst formatting in readme
> 
> So, it all "works for me". The patches were produced with `git
> format-patch` and sent with `git send-email`. Please let me know if I
> was supposed to do something else.
> 
> With the risk of continuing to not know what I'm talking about, I
> perhaps have a guess about why the patches don't apply for you: if you
> simply copy-pasted the email into your p2.txt, that might not apply
> because a space might be lost from the end of one of the one lines
> that I'm deleting. The patch has a line that reads: "-This is due to a
> llvm BPF backend bug. The fix ". Notice the space at the end of the
> line. At least Gmail doesn't render that space, so if I simply
> copy-paste the patch from my browser, I end up with a corrupted line
> and so it doesn't apply. Perhaps that's your situation?

My email client is mozilla thunderbird. I just right click and save the 
patch email to a file and then try to apply and it failed. I guess
this process may not be friendly to http/https links.

I tried your above curl method and it works. I will switch to your
approach if the patch involves http/https links in the future.
Thanks for the detailed procedure!

> 
> Thanks Yonghong, I appreciate your time!

You are welcome. I tested your patch with rst rendering. It
indeed fixed the formatting. I will ack separately.

> 
> - Andrei
> 
> On Mon, Nov 23, 2020 at 2:22 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 11/21/20 6:22 PM, Andrei Matei wrote:
>>> A couple of places in the readme had invalid rst formatting causing the
>>> rendering to be off. This patch fixes them with minimal edits.
>>>
>>> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
>>> ---
>>>    tools/testing/selftests/bpf/README.rst | 28 ++++++++++++++------------
>>>    1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> I cannot apply patch #2 with my current bpf-next branch.
>>
>> -bash-4.4$ git apply ~/p1.txt
>> -bash-4.4$ git apply ~/p2.txt
>> /home/yhs/p2.txt:34: trailing whitespace.
>> __
>> https://reviews.llvm.org/D85570
>>
>> /home/yhs/p2.txt:52: trailing whitespace.
>> __
>> https://reviews.llvm.org/D78466
>>
>> /home/yhs/p2.txt:70: trailing whitespace.
>> .. _0:
>> https://reviews.llvm.org/D74572
>>
>> /home/yhs/p2.txt:71: trailing whitespace.
>> .. _1:
>> https://reviews.llvm.org/D74668
>>
>> /home/yhs/p2.txt:72: trailing whitespace.
>> .. _2:
>> https://reviews.llvm.org/D85174
>>
>> error: patch failed: tools/testing/selftests/bpf/README.rst:33
>> error: tools/testing/selftests/bpf/README.rst: patch does not apply
>> -bash-4.4$ git --version
>> git version 2.24.1
>> -bash-4.4$
>>
>> Could you help check what is the issue? Maybe the links are presented
>> differently in the patch vs. in the README.rst?
>>
>>>
>>> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
>>> index 3b8d8885892d..ca064180d4d0 100644
>>> --- a/tools/testing/selftests/bpf/README.rst
>>> +++ b/tools/testing/selftests/bpf/README.rst
>>> @@ -33,11 +33,12 @@ The verifier will reject such code with above error.
>>>    At insn 18 the r7 is indeed unbounded. The later insn 19 checks the bounds and
>>>    the insn 20 undoes map_value addition. It is currently impossible for the
>>>    verifier to understand such speculative pointer arithmetic.
>>> -Hence
>>> -    https://reviews.llvm.org/D85570
>>> -addresses it on the compiler side. It was committed on llvm 12.
>>> +Hence `this patch`__ addresses it on the compiler side. It was committed on llvm 12.
>>> +
>>> +__ https://reviews.llvm.org/D85570
>>>
>>>    The corresponding C code
>>> +
>>>    .. code-block:: c
>>>
>>>      for (int i = 0; i < MAX_CGROUPS_PATH_DEPTH; i++) {
>>> @@ -80,10 +81,11 @@ The symptom for ``bpf_iter/netlink`` looks like
>>>      17: (7b) *(u64 *)(r7 +0) = r2
>>>      only read is supported
>>>
>>> -This is due to a llvm BPF backend bug. The fix
>>> -  https://reviews.llvm.org/D78466
>>> +This is due to a llvm BPF backend bug. `The fix`__
>>>    has been pushed to llvm 10.x release branch and will be
>>> -available in 10.0.1. The fix is available in llvm 11.0.0 trunk.
>>> +available in 10.0.1. The patch is available in llvm 11.0.0 trunk.
>>> +
>>> +__  https://reviews.llvm.org/D78466
>>>
>>>    BPF CO-RE-based tests and Clang version
>>>    =======================================
>>> @@ -97,11 +99,11 @@ them to Clang/LLVM. These sub-tests are going to be skipped if Clang is too
>>>    old to support them, they shouldn't cause build failures or runtime test
>>>    failures:
>>>
>>> -  - __builtin_btf_type_id() ([0], [1], [2]);
>>> -  - __builtin_preserve_type_info(), __builtin_preserve_enum_value() ([3], [4]).
>>> +- __builtin_btf_type_id() [0_, 1_, 2_];
>>> +- __builtin_preserve_type_info(), __builtin_preserve_enum_value() [3_, 4_].
>>>
>>> -  [0] https://reviews.llvm.org/D74572
>>> -  [1] https://reviews.llvm.org/D74668
>>> -  [2] https://reviews.llvm.org/D85174
>>> -  [3] https://reviews.llvm.org/D83878
>>> -  [4] https://reviews.llvm.org/D83242
>>> +.. _0: https://reviews.llvm.org/D74572
>>> +.. _1: https://reviews.llvm.org/D74668
>>> +.. _2: https://reviews.llvm.org/D85174
>>> +.. _3: https://reviews.llvm.org/D83878
>>> +.. _4: https://reviews.llvm.org/D83242
>>>
