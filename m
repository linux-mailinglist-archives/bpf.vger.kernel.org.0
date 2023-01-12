Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB15B666B8C
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjALHYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 02:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjALHYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 02:24:08 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097D186D8;
        Wed, 11 Jan 2023 23:24:06 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C5iAlk013545;
        Wed, 11 Jan 2023 23:23:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=VjR7h8IAyClrxhM4NfWWqOBSSxb4SJoHWwWm9xPXoCo=;
 b=Wz1em0gWx4z3w6zTkJzupZ4qYpJj06QGz6QtI5o8TN106SBcRku/dLeH47Lr7RBsn2le
 +1aaWf7p/FwiDK1/msljzug4d3JIqNg1mNRizCB0IURysGCFv2I2kIjNuYJEgebF+8Kz
 /cc4+VAM1mkhSPnffYukU5nqp7d4bQev/qkxcvFOZv+sn0uUuQuq6D19m1PbI95OhJjq
 +KHmuXokgEc0lbR+DhH6bxAqCMkiyaMIumiy5q+7NPRelD2frC27f60xD3H+9BLcyWEW
 ySd0nnE/0fcuv3RZ2WP1IrdbWDtz73wsKoBts9QZz7Fa0OiNMYvtMzmU/hwKGzqZf8g8 2Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n23bpt1fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 23:23:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDnpVmLBnvHEdfysCbqr1Nf4zKJqebNt90yh8HtzHpRQQQhX+1MsMGrMfkrIBExGpaJD4ZWd04mbSkZ3OHskOn6uE5tZXdccbraMoPUEGhmc/ocGZEfINHUBmufbNtxaib3+RAUJ7dW6OtUbn3lx11Z3j1PNtpG86M24yvFHxLI4UePjs5sNh50v4+Lf/6fWjsfWrNc4BEdN/fRYnPqo9WW4RY/vSSGHWGsjchYljcn4pAWy11EUqNg2zsdl8cNjz5ogNBITjKx5Y+q89CKWZeGlsSD+PBQAneLkYqSl+8k8tYTFLTCcwVXaN1SuG6wLO1c4hBzkq6IuEfSg/5KVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjR7h8IAyClrxhM4NfWWqOBSSxb4SJoHWwWm9xPXoCo=;
 b=n69633tQofvSJPylp/xZX0O+AIrMif5j5zuUaHadhAUZhlBFR37PJ91T+MTnpgHz+1IgsAjrPGAtmvOyQmBDgVZzagfeSrfGcDgQHagBFf27uJ2OoXUOHV0yK0xDL0bp1CurogsFrrjuxYLSZ/pyvl5j1GVVVSs0Lcpo0wBAXXgzUjTdbmdCaNAr+jKR+4pMh6nvyGPk+fi601dYs5xaY7G5JjWEK3EOO1uJKBFUYsIReEhZ43G/63M0dlNdMSZX0+coJE8TeJh5w03M7ocSrcuQj2wMDBXzRT+08G57TRSBByZc0AdAd48QTJF5cttQTwshNncSRTgZOyW/tZfPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4463.namprd15.prod.outlook.com (2603:10b6:510:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 07:23:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 07:23:19 +0000
Message-ID: <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
Date:   Wed, 11 Jan 2023 23:23:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for
 kprobe
Content-Language: en-US
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
 <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: acd213bd-490f-4f28-ab19-08daf46de0f3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGCjGJTpQhv1mCpyC6luOM539FG+w1NtYTvTgsPjliyiatR5/R2a/2WTA5eqwYPNDkckRHgylR/g03rtHwx3FOU0nBKM/sVlHIp8S9JFCcZU2tPLswUNmhP2kfsWamUhJqDCtyDDFh1dvJJmssZGaCDN4nwyJL4CVSunyk/5KV4jULPpp2rSSZYCmVlM96bEIeCgQk2UtJ93t55GRIr6qUpEFxX+DkLJy0WoCBwNqJnn/8uGeGr7s+F6L7GiOOCw26Mr6vJA4zi77vLBVoAPdXMqB9mDmiaF05/vBVsCWFgPUvdAIikGWdtshBM76EshPo1xP8AXh5M+h2oKIwGXnwikkPL+jHGJX370NBeIdOwJebe+UfGio5CkdeBEX40RfZhUHBDCwhJM2JltBnSVgukxGY7BiIUvSbxj2/Pvek/Dddmmk1KvXLRAWPjhMoSCp5CANwRroeCsflYurQLylLuorlDAbmyeyyWveC12bZvUIEs5z/qACXajdancV50JHVPCC91sSmw9fzOJXWhl2kXgRN3EmXk4fSfYN33ub5iaQ4GMiovu1UWhfXMGSYJCXBo6aDAUiOWaEjBs72eD7iV10HyZD5O22NHmmvICBtBva4gcXS92lMbyfV4prpf5XYAN+RJL9L/c1NuRVQMLga5jodKNYlXs810OIwho6pTRq9syPQNnzluIvBmeG0dK3QVrDoJUsWOJTqNETUJJQISGL2LAQXdAKwf6AGKu8eAYFuSSDcdzh1LObphH1OHJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(66946007)(66476007)(4326008)(66556008)(8676002)(6916009)(316002)(5660300002)(2906002)(8936002)(41300700001)(7416002)(53546011)(36756003)(31696002)(83380400001)(6486002)(478600001)(6666004)(6506007)(38100700002)(2616005)(6512007)(186003)(31686004)(86362001)(66899015)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNNQSs3QlZPLzBhR2VMaW9wMjF0NmRtUWUxVzF6cjdqZm1FenFkUi9uY3NG?=
 =?utf-8?B?YWt4ZmNzQnd3SDZjam9NaTNtYlRmZnJWQnJkQ1RWVHR5MHhwNTh2VjlrOXRo?=
 =?utf-8?B?OE5DYTVJbEloWHNlYS9lNXpLUW9FZTl3WmJTcG9jNXBPRHlJNXJ5Mm1abUJW?=
 =?utf-8?B?U2ZLWVdkeUMySFVJRk1pZDIybS9aelU4ZmFPdElWUXA3bE0vdVdvZ3pTTW41?=
 =?utf-8?B?dmtkOUY2eVVhWno3aWovQlNxL2UrTVpFL3BUT0RUSnZoSnRmOUhLc3ZrczBn?=
 =?utf-8?B?TUZmME9XY09sSTZEYW45VTZqY3RWeUVIQlBvOW56NXZzQU5JV2FDRHQzZ0VY?=
 =?utf-8?B?bzQvK2xHMWdXQnFTQ2dqdTNTSWNubkZaWFBhQStOT1Q3NStJenkyOXMxVG1H?=
 =?utf-8?B?a21meUpFMGxWOEs3U3lncFI4MkFCUkdPcE1nQXk4cG9OZTFKQkkzRWVuMlNl?=
 =?utf-8?B?OUh4MlY4empzYy9lZ1BKL1JLZVM5UGVZMCtXMUQ4M1lpUktydWZhOUYyYnAv?=
 =?utf-8?B?bVBBTkdqczFQY3NLNzVVTFd2YVcxcmtmS1VyN1V4YkhkQUtLZ1NQZTFrNDRM?=
 =?utf-8?B?aWt6ZS9pTzFvREEvZWRjWFhyQi8wRlRPUWtNT28zbTRMUnpBakt5UXI1enlR?=
 =?utf-8?B?Vm9NWkw3VG4zdlU0V2FsMTdDODh3SENINWF3SHJubUdjczkxTTI3c0FFb0sz?=
 =?utf-8?B?bVZNVml4QmR4eGdCOXhnZmlwYjhJYWx6aW5RbWU1NzlZQXo1VjJtTytBS1Zl?=
 =?utf-8?B?bkhqZzhIOU5Gc3ZXUlBNYkNscEg4d0gzeU91VXNuUlVNUmtWbUxScExZWk5p?=
 =?utf-8?B?cWdsZjFVei83dFVrSnBaekhFamNsTVNUeTJ5N0VQM1lOeGU1UGdtblhXTTdy?=
 =?utf-8?B?V29QeC9WbHVCMXJjZVNpazV5NXR6VWhPUHpZZ1NIQlB5d3dUbWcvYWh5aU90?=
 =?utf-8?B?OFhRK2ROOHJpWXRSWkpOVmoyQjVxU2syRm5SZWsrMVhoczVFYlYvZldDVk1G?=
 =?utf-8?B?dUMrc3VjL2xid3FwSmZ1eTFFM3hhKzFlSTlzYWE4bUhIT3pTU29TOC95NFFo?=
 =?utf-8?B?UElMS0UzMU8rQmlzalpXUXdiRnR5MmZiUDRNU0daUDZab3g1QUZqN3V1bkdK?=
 =?utf-8?B?U3NGamU0cWtLdjMyRkdLYWx0SVdaN09XUk5kR0lKMW5teDM3UUQ3ZEZWdGZZ?=
 =?utf-8?B?WFg2T0VrY0ZVSjB2TGhraW9Ta01RNXdpYjZFN1hnSGVxZXVKRkZiSFpmQjdY?=
 =?utf-8?B?TkpYTm1JemZUV1QycDZMV04yUHhlWFBMNlZUM2JmZnVjUnVtRFN5MHR2TjVI?=
 =?utf-8?B?WWE3YWczSTVJSEF2ZVMxZENyblJWYm9Dd3E5d2NWaDFOWGZTMzNKbU5zdW1L?=
 =?utf-8?B?SGdlSS9aWEhJUVJWL2NSb29PQUxlS0JtcERobzhEa2cvZ0V3VXlObkE3NWhM?=
 =?utf-8?B?dm1Dcml4VHRPMmVORTFLRk9KNmc5ZFlwWndBaGYrMnRNa1hQT21aUkFVeXc5?=
 =?utf-8?B?S1J5VVBDT3JxbU0zR0NiSWJRQU9rYTYxS0dPVUozb3RaUUtjbWloT1NJV0V3?=
 =?utf-8?B?b1ptRkhXbk1tSlptaG1VNTNhTVhNdkM1U20wYmExQ2NvTlk4bGx1NndiTEV4?=
 =?utf-8?B?Y1VnYkV3b0JlSHRDOUpiUm1Pd09Eb3lORjRNbWxzWExJNVc1UC8rQWhIWkoy?=
 =?utf-8?B?L09ScndlZXQ0RXpKMzlERVZyZzRmaDlBV3VoSFVQTkRCM0x3cTVZSStjdk5L?=
 =?utf-8?B?UDgyb0VqMXRKWXQvQTdrME9JTnMyVjZ5eFVGZFBLeTNEem11aWZyNXN6Q1NL?=
 =?utf-8?B?NTJxNGtPbm5kVmh4WjVlcFVROURZcC9qS0Q5bmcySlRPUk4vVDVQbU9odUZp?=
 =?utf-8?B?RFdMamlvYXhQTjBkMWhrYkxnQmExS3NrS2dHUzlrUDJVZGdUemxTQ1BSL3ky?=
 =?utf-8?B?N3oyTFJhTTFpNUwxUjg5YkI1aFhBdkx6cllTa2FuU0QvOWFZbE9JV0dzMnFw?=
 =?utf-8?B?L3JINSt0UWE0T0VRRjJEQ2V4TlhrUkhOZFZZQk5jSk9tTlo5MFBDaExQbkZE?=
 =?utf-8?B?YVl1NTFWSGNRWHVJVUhlR0RPQUZYdHJEaFVxTFd2WWJmcitQd0lyR29MbjhV?=
 =?utf-8?B?V1dBbHJTN3RkcjBBeVFDVXNNY0NBSVQyMExSdDRUK0FDbGpEYXp4cHl2c2lR?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd213bd-490f-4f28-ab19-08daf46de0f3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:23:19.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bBzN4+Rfp6BvU66c5emEez15USrxcL8hnV6edxWq8KlxbwT4ddLifEiMUWJmSdO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4463
X-Proofpoint-GUID: cFkHBeCz7bvi0o9ne_oHIWP12vP3x3Ja
X-Proofpoint-ORIG-GUID: cFkHBeCz7bvi0o9ne_oHIWP12vP3x3Ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_04,2023-01-11_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/9/23 7:11 PM, Menglong Dong wrote:
> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
>>> From: Menglong Dong <imagedong@tencent.com>
>>>
>>> The function name in kernel may be changed by the compiler. For example,
>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
>>>
>>> This kind optimization can happen in any kernel function. Therefor, we
>>> should conside this case.
>>>
>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
>>> kallsyms and check if there is a similar function end with '.xxx', and
>>> retry.
>>
>> This might produce incorrect result, so this approach won't work
>> for all .isra.0 cases. When a function name is changed from
>> <func> to <func>.isra.<num>, it is possible that compiler may have
>> make some changes to the arguments, e.g., removing one argument,
>> chaning a semantics of argument, etc. if bpf program still
>> uses the original function signature, the bpf program may
>> produce unexpected result.
> 
> Oops, I wasn't aware of this part. Can we make this function disabled
> by default and offer an option to users to enable it? Such as:
> 
>      bpf_object_adapt_sym(struct bpf_object *obj)
> 
> In my case, kernel function rename is common, and I have to
> check all functions and do such adaptation before attaching
> my kprobe programs, which makes me can't use auto-attach.
> 
> What's more, I haven't seen the arguments change so far, and
> maybe it's not a common case?

I don't have statistics, but it happens. In general, if you
want to attach to a function like <foo>, but it has a variant
<foo>.isra.<num>, you probably should check assembly code
to ensure the parameter semantics not changed, and then
you can attach to kprobe function <foo>.isra.<num>, which
I assume current libbpf infrastructure should support it.
After you investigate all these <foo>.isra.<num> functions
and confirm their argument semantics won't change, you
could use kprobe multi to do attachment.

> 
> (Please just ignore this reply if it doesn't work :/ )
> 
> Thanks!
> Menglong Dong
>>
>>>
>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
>>> ---
>>>    tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index a5c67a3c93c5..fdfb1ca34ced 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -10375,12 +10375,30 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>>        return libbpf_err_ptr(err);
>>>    }
>>>
>>> +struct kprobe_resolve {
>>> +     char pattern[128];
>>> +     char name[128];
>>> +};
>>> +
>>> +static int kprobe_kallsyms_cb(unsigned long long sym_addr, char sym_type,
>>> +                           const char *sym_name, void *ctx)
>>> +{
>>> +     struct kprobe_resolve *res = ctx;
>>> +
>>> +     if (!glob_match(sym_name, res->pattern))
>>> +             return 0;
>>> +     strcpy(res->name, sym_name);
>>> +     return 1;
>>> +}
>>> +
>>>    static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>>>    {
>>>        DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
>>> +     struct kprobe_resolve res = {};
>>>        unsigned long offset = 0;
>>>        const char *func_name;
>>>        char *func;
>>> +     int err;
>>>        int n;
>>>
>>>        *link = NULL;
>>> @@ -10408,8 +10426,25 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>>>
>>>        opts.offset = offset;
>>>        *link = bpf_program__attach_kprobe_opts(prog, func, &opts);
>>> +     err = libbpf_get_error(*link);
>>> +
>>> +     if (!err || err != -ENOENT)
>>> +             goto out;
>>> +
>>> +     sprintf(res.pattern, "%s.*", func);
>>> +     if (!libbpf_kallsyms_parse(kprobe_kallsyms_cb, &res))
>>> +             goto out;
>>> +
>>> +     pr_warn("prog '%s': trying to create %s '%s+0x%zx' perf event instead\n",
>>> +             prog->name, opts.retprobe ? "kretprobe" : "kprobe",
>>> +             res.name, offset);
>>> +
>>> +     *link = bpf_program__attach_kprobe_opts(prog, res.name, &opts);
>>> +     err = libbpf_get_error(*link);
>>> +
>>> +out:
>>>        free(func);
>>> -     return libbpf_get_error(*link);
>>> +     return err;
>>>    }
>>>
>>>    static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link)
