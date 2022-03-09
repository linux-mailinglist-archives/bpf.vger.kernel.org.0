Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BD24D2944
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 08:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiCIHJQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 02:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiCIHJP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 02:09:15 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A67F6E0
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 23:08:17 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228IovUH017535;
        Tue, 8 Mar 2022 23:08:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bkCxgisnJastKRnw/LFEm/dFQU1V1glv+wjDi04uUDw=;
 b=MM2KAToE2CqOEZEoV5uqo3ti96lvQpq6uEU6PHFf48dtnwEYYddLLB4CvWaR7unOdjhd
 o4PKXHQub6Vn4ISYs0MUqBA0d3GQ95lpH4pI9UfPiPFAcpZhXh2oCHTfPce+rUEm96oS
 Q2RrqBlEJt1V3JBp+c/+ozrObMYzNJcAm+0= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ep52tqa4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 23:08:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaEQjO5/Bs+6Yaaue+GNpx+arhyMseGfjIMA4LqC5uEMnO7NasaP1EeB37pbi4TbjoZ/aQ9FDovVIoh8AtrmswyuIXCDGrTb5kmdRRveqsrhKRqDGbv2k/HLIBZTrJTpGSxdoW1qN0KhcbuAJNNxcM63dbYLn8rpIiRvRRV1ofmG4378hftVIwRvyvWakefWNfChx7/VCEzqvdARTt1zeWw2oub7jdgg+fmabs2hHdK0XK+55FxjU6n4K7xG63hmheHp85Q0FComblZJ5e88lPsz22565dSZqPcNYbUC+rr9tuF6B27igq/b7Qdnd/PWtm8Zzyt9tj5qbFw+WgUUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkCxgisnJastKRnw/LFEm/dFQU1V1glv+wjDi04uUDw=;
 b=AKSXV1II+dZDlJlAp0btR0aHfSEPwRM0bbB6QtO66jFAJKU4ogF3v2MfJF1VlxOlQBWpTwPT36TsODwGq4E3MaK/uGyU2tnVz441w+TiIrwzvoo3PGDz+v8wrZCbo9M0PqjvlAOXmcaW1gkLKDKvPmrEZoVtPMqaijaXanx44q6ZXk8j12HpucgjY0mJk8nTD8JZIc+GlhNM3hLkj1xVsaDirGtxZvBSyfC7+mmq4wtMDOhdWEc0kPP8qEAlW2ld/OGoBX39ma19rVxT/lCd+m/eJeX80H46p4x2pX/d/3sBtDXKqS7q2DFOF5rU5XsmaTMvjr3HJNvvGVZu7q4Kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2285.namprd15.prod.outlook.com (2603:10b6:805:19::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 07:07:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 07:07:58 +0000
Message-ID: <b83b2008-d186-84b0-7669-c0758bf15b9b@fb.com>
Date:   Tue, 8 Mar 2022 23:07:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH bpf-next v1 2/4] compiler_types: define __percpu as
 __attribute__((btf_type_tag("percpu")))
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
References: <20220304191657.981240-1-haoluo@google.com>
 <20220304191657.981240-3-haoluo@google.com>
 <CAEf4BzadmAQSUHSSDfSeiMvicvdbOKh_r7oCX2=OThbjOS-rMw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzadmAQSUHSSDfSeiMvicvdbOKh_r7oCX2=OThbjOS-rMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0050.namprd10.prod.outlook.com
 (2603:10b6:300:2c::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cccbfa7d-4ee4-4cfe-77fe-08da019b8a75
X-MS-TrafficTypeDiagnostic: SN6PR15MB2285:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2285D833C9040EBEF7D7BD6DD30A9@SN6PR15MB2285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJlAenhgLNfg3Id+l/MmfDxgwWFsTlWGkvRyJiw5igp4rxZFNVvn5Gj8vBf2552m46+27r3arEk4IJwvUe3a4Nl+8NCkPtrj7HCeq4jkCfWITUidhM899UTWql7i6+FxiSfkuS/HPRqSSZbHYGhcxLLzIFneOWqUrqK6iUzHwM01zcYzd/lj4flarGszZz6T/dBWuJTc2OXIO/iqxtfqPaVAHa9SUFRcCJbKG8G+4Bt1yvTAWpj6tU4W71L5ZBloFNQLMir6fxLRNgzdKtVb7NQ7TyEP3DIKfpiLwNv2h+RWed57rncpdwxSSCtpX/gIESGHPOlsTG4NMjRaMiF2xL7f8pAupeo+3R20akTlKH1H2heV74DSZf9mpYp+V4qNnBPxAraEs3NDulkieDf/saNhdgTfkrsWNxZoBtPEaVSFrTw0giGe1cST8R/Yc3nnlMaE/1tXKp3F9KAL39hePh7Fck3e8t1hdn0FLRumIgxub60YGPZROuoHPxwpt6MJpfHX739nljvMbDyeOzIUFdDsRgwBKDSEzp5iBcn3DzFFIutIXJOwQ7cVsRbLMosDI+eqb6Wbi4cgrMXoL17bBSvteYhL9btlbElKd5Z8ue2fBVyof+2zyItj130p1Q1V+eAeLms2GxFDZqHxc1DxntRqxk+wA+kDSBkO483Dm82nqgEsJCg+uz3a37yeIkK5gWjCI5EfBTajLzb8ENtuGrgTtVGFNe+zMxvT0A6fULU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6666004)(8936002)(6512007)(316002)(31686004)(52116002)(53546011)(5660300002)(54906003)(6506007)(36756003)(110136005)(508600001)(2616005)(86362001)(83380400001)(186003)(66476007)(8676002)(66556008)(31696002)(66946007)(4326008)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThrcGtnWGk4QzNQUTUyZTR6bGdNZGt6OGtJTVNvbCtvV0d6WlppOHRtVkJx?=
 =?utf-8?B?VmRXQW01dlU2ZC8zZ0w4VHZtNXFwRExHblZEMlFwRTRzTWxCbDhUOE1EeXFR?=
 =?utf-8?B?RjkxalRWSytobXc0Ykh2RWN4USs4R2h4LzFvMkVoL1J0OUJUNjJJNVFnNGFN?=
 =?utf-8?B?WkRyc1pNZEp3MHl3WGd4bXNaaDY5TXJMaFFRY0c2UVNpaEtwc2lQVm5YQkNa?=
 =?utf-8?B?TEJMVGdoeEVra1JUbUFNTWp3QTlIbDdUS3FBT0taa0R3Uys2ek03M2tjS3pv?=
 =?utf-8?B?VGgvR2YweDFSZUNBdDYyaWp6dXNYdTVXL0E4eThLeDdTQS9xZ2hwNHozbnli?=
 =?utf-8?B?TDR6Z2E1NDNxcnVhamNTcmJQMXJjSzY3cmF6S054TjVzVEJiWkUxSTZoTVFn?=
 =?utf-8?B?RWV1Nms4bFg2Z3YrNERhNm9qVkN6K0J1UU9ieTJTczlMU0x4cHJ1UXNxc09x?=
 =?utf-8?B?dG9tdENyTWRLaSsrTEIraFlQUEQ1MU5WaXZQY2NxZDZGYkFoQjMxcG8wcENP?=
 =?utf-8?B?YUtQRXZ3eSsrVWVtS1NzTFByb3VKem16cmRsbWZjQXFacDd6aVVXWlZ5Qmd4?=
 =?utf-8?B?cGFXZDRqRWRQM0dGM0g2dTQ0Tm92STY2YTdqQWZGUWIvVnFYRk4zemFXVFE3?=
 =?utf-8?B?YkExRDBhbVcxem5GZXpJRlZ5cG1vZkJMSndDQS9sdCtGV29vM2pxemQ2a0dh?=
 =?utf-8?B?Mjl2UHZYejN2eTJ5M2NJc05sdGp5TVBZTzRoenZPaTZmWWd1VFBDQXp4OS9R?=
 =?utf-8?B?UllPeXQ2ZWVsd1pSSUxpUjVBR1ZtTUg1ZTlhS3V0QW41alN5cGdLbGdGV3NM?=
 =?utf-8?B?WkJVTHBGQWQ1S0xydTRpY0VBbm44MDdENXBycDZRaUppdGpaVndPSjB5Nko5?=
 =?utf-8?B?TzVKaWZwSWxzSUhTNGRCOG1FWnc1NUFGazFzTzdVNGdJdnhYVHJGeWRpWkRL?=
 =?utf-8?B?aVdWNVd3bHhRT3IzM0ZXOUJvYzdyanowK0MxL0xHcWlCSUc4ZU1HNmQycGZz?=
 =?utf-8?B?dS9RVkRXQmp6Nk11Yks0czdRVHFoTldCaTREdGh4WUxWKzlXSlh0QnJrVjF4?=
 =?utf-8?B?b3A0SlFuOFVUVGVHajNlZzRLQTZubFNpRG4yRnN1TSs5b0JGTGtvWm1FQmxS?=
 =?utf-8?B?cWtlYVZvQlR5aDVTZ3FJMjdTU05ZOHRVMVhCeXhuak1LamxzR0s5ZEVTMVNk?=
 =?utf-8?B?SFhiUGtsaVorWG5EemdlR2IzZS9ralRDdXBEU2NScVN0WVlmMDlIdXRURUZP?=
 =?utf-8?B?WkpwM2lCbkNRdk9FZjVnTEgrU3ZmZkJkbnBrQnEzZmJwU1VBa2ZsTURlN0V2?=
 =?utf-8?B?OElEK1V0U0dKcldmbEl0Tlc1ejA0SGY1V1pTVGlMU3lyUENNcG1vaG9TaGhL?=
 =?utf-8?B?TEpPUzVIVnBKNUlYeXZodnZYWDloSmM5bW9sZG1xbml1V1EyN1JEaGR0WVh6?=
 =?utf-8?B?Vkg0Wjc2WC82cTZyWk9vd1Jhd1kyYWN2WnJydnpycWZQdGtkREtXTUhIUEVu?=
 =?utf-8?B?NFVSUzZ0NGxZTkFDWjhONFJRTVZRNWRCS2J4SCtuNFFqTXZKVXB5dTk1WlZN?=
 =?utf-8?B?TU95OHRPWWt6QzI1dnV0RGEwNTJFeDF4Nkl5bExnSUc1R3JscU5XRUpGNWtq?=
 =?utf-8?B?T3RnWlNJTXZEbDZFQXQ4VGVNVHhKK1RkNGUvUS9tRkhqcWpxTmpkYUdSb0U2?=
 =?utf-8?B?blVHcXhWUDNXQlRTekVTT0dMVXFzKzZwL0NNMUszR0NTNGt4WS90eE10Zkk1?=
 =?utf-8?B?UldIUDdtcmNWbEZEUXEwd1N2blhYT1FrNjQzUE1ZeU0xczZJN3FvcWVCWlZs?=
 =?utf-8?B?dkh2Y2R3OTY2QVQ2RndYTjJ5OGVtUzJYcjR4QzhZNkp2ZWxPamxIZVhMZktx?=
 =?utf-8?B?eSt1ZklNWnNWSllXL2FjRTNIOEx4Z3dUbzNERmE2OWNJZDk1VmJIS2psb2Y5?=
 =?utf-8?B?L25XOWVyaWJGRnZPWThpWTJ6dmtUQnVoWld1dEsrZVUzTjArdVdxalIwbjRF?=
 =?utf-8?B?K25YaDIwQzRqNmxlajV4Wm9henJHUWRrcklLYU9TZXc2VjlVSHlsQXh5QWMr?=
 =?utf-8?B?QWMweTNBREpRVERlTW5ldTROVDBWUGFKU0FOSXZ1YnhyWjFrMkUvSGtrQkw3?=
 =?utf-8?Q?cB3TyfaJ3hEKFLANLXOLEMrpg?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccbfa7d-4ee4-4cfe-77fe-08da019b8a75
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 07:07:58.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9ujjD8VLyKIehRb2hGbjHOeBs//Lq/650duYCdU+S15TG6RaMSXClbwQRDZyIqF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2285
X-Proofpoint-ORIG-GUID: PTE8kZIWvUxi_e9G5O8LX8tBoNJFzFsb
X-Proofpoint-GUID: PTE8kZIWvUxi_e9G5O8LX8tBoNJFzFsb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_02,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/7/22 5:44 PM, Andrii Nakryiko wrote:
> On Fri, Mar 4, 2022 at 11:17 AM Hao Luo <haoluo@google.com> wrote:
>>
>> This is similar to commit 7472d5a642c9 ("compiler_types: define __user as
>> __attribute__((btf_type_tag("user")))"), where a type tag "user" was
>> introduced to identify the pointers that point to user memory. With that
>> change, the newest compile toolchain can encode __user information into
>> vmlinux BTF, which can be used by the BPF verifier to enforce safe
>> program behaviors.
>>
>> Similarly, we have __percpu attribute, which is mainly used to indicate
>> memory is allocated in percpu region. The __percpu pointers in kernel
>> are supposed to be used together with functions like per_cpu_ptr() and
>> this_cpu_ptr(), which perform necessary calculation on the pointer's
>> base address. Without the btf_type_tag introduced in this patch,
>> __percpu pointers will be treated as regular memory pointers in vmlinux
>> BTF and BPF programs are allowed to directly dereference them, generating
>> incorrect behaviors. Now with "percpu" btf_type_tag, the BPF verifier is
>> able to differentiate __percpu pointers from regular pointers and forbids
>> unexpected behaviors like direct load.
>>
>> The following is an example similar to the one given in commit
>> 7472d5a642c9:
>>
>>    [$ ~] cat test.c
>>    #define __percpu __attribute__((btf_type_tag("percpu")))
>>    int foo(int __percpu *arg) {
>>          return *arg;
>>    }
>>    [$ ~] clang -O2 -g -c test.c
>>    [$ ~] pahole -JV test.o
>>    ...
>>    File test.o:
>>    [1] INT int size=4 nr_bits=32 encoding=SIGNED
>>    [2] TYPE_TAG percpu type_id=1
>>    [3] PTR (anon) type_id=2
>>    [4] FUNC_PROTO (anon) return=1 args=(3 arg)
>>    [5] FUNC foo type_id=4
>>    [$ ~]
>>
>> for the function argument "int __percpu *arg", its type is described as
>>          PTR -> TYPE_TAG(percpu) -> INT
>> The kernel can use this information for bpf verification or other
>> use cases.
>>
>> Like commit 7472d5a642c9, this feature requires clang (>= clang14) and
>> pahole (>= 1.23).
>>
>> Cc: Yonghong Song <yhs@fb.com>
>> Signed-off-by: Hao Luo <haoluo@google.com>
>> ---
>>   include/linux/compiler_types.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>> index 3f31ff400432..223abf43679a 100644
>> --- a/include/linux/compiler_types.h
>> +++ b/include/linux/compiler_types.h
>> @@ -38,7 +38,12 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>>   #  define __user
>>   # endif
>>   # define __iomem
>> -# define __percpu
>> +# if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
>> +       __has_attribute(btf_type_tag)
>> +#  define __percpu     __attribute__((btf_type_tag("percpu")))
> 
> 
> Maybe let's add
> 
> #if defined(CONFIG_DEBUG_INFO_BTF) &&
> defined(CONFIG_PAHOLE_HAS_BTF_TAG) && __has_attribute(btf_type_tag)
> #define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
> #else
> #define BTF_TYPE_TAG(value) /* nothing */
> #endif
> 
> and use BTF_TYPE_TAG() macro unconditionally everywhere?

Agree that the above suggestion is a good idea, esp. we may
convert others, e.g., __rcu, with btf_type_tag in the future,
and a common checking will simplify things a lot.

Hao, could you send a followup patch with Andrii's suggestion?

> 
>> +# else
>> +#  define __percpu
>> +# endif
>>   # define __rcu
>>   # define __chk_user_ptr(x)     (void)0
>>   # define __chk_io_ptr(x)       (void)0
>> --
>> 2.35.1.616.g0bdcbb4464-goog
>>
