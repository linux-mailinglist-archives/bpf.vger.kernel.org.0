Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6F2A50D7
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgKCU2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 15:28:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65122 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727688AbgKCU2L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 15:28:11 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A3K9ZFi002107;
        Tue, 3 Nov 2020 12:28:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Fj6TKt/tS1kq2TXgja6PVFuPRktCPdABVJU939sNYmY=;
 b=Y4VuKkiOOoEMOPOZgDjOfZL7FVfxU/TycFY90eHxJ/bkx5bAkx7x7R2f64Me27aNilrt
 bTGpSEKNLNqQLS3tOeKtWI4+gvrbsqOyQj7X3VckLqf12JKz/8cqzuLm1+u3D1yGQG11
 F+CN72rlGCJa1T+0pkv8gasH4qxbglB5cpE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34k9k3a7ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Nov 2020 12:28:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 12:28:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbwZ6z7nb8Q2ptvV3/sFMNjJN3nVgR7uU21daFncaXzYDnRscl/kzKPhJ+CMclBGZcU1TM85T/77RwRChAvPAvw8FOYhfYXgn1l7dspudcfegYJtKQ9xPViQw79w+CilsIDDxERwOfsYfM4T4Y/PIHvBMx+2utnKwIXdxuQ+0OpaHATpgPGYkfuhCG/TA+bIhtAjxoYiOhp+NA4umFVg2abN+KlIuHsXBNOuBpmL/c559FenL0xSRMHxGBhi6f9nnM1jWvL05pYdzLjYls0Te0RR8auN1eI1dmNOlTk6A+oPq1rQgEGloGrpDJBRzSo0FP0F345GGY3xRqtsDkw3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj6TKt/tS1kq2TXgja6PVFuPRktCPdABVJU939sNYmY=;
 b=ffUFTeyfdH+GFrgpbztTp+x3nCeCh3cSyoNGKTl09x8SwN5NzDsgmt+3PNfWk+rDexsHIrEzDywTdIloRPKJYoLuzUc5axs41bnnQKlkIe97iS8UU768WHt3vj3+tlgzt2Jlh2mllsaKpOSHmUSKMV1bH7qOo3NG+vDNZggKU3c24pcFsX23MMzbYN0F9ONliiYh5BRJBhQaV/ds6ccfB/sV0ME4QYivcAWrvXmVbb8Bl+yV2tHOIjKznqKZX9hsHCJqLaCTE0ywBOOaQ5685ztADdQMMow1ODSbmzTLaou9A45uz6BziDXp/Wg/XJvpew2izcfSg9pmGPHlIiFT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj6TKt/tS1kq2TXgja6PVFuPRktCPdABVJU939sNYmY=;
 b=hM87eWo/5KM1ujyiaZGLUdH1y8LXRBse8jfbQWyj2MBjK1BbKrJ4fGlHpBRJwb+WXHa7qGYyp7zLKpsB1WkRRdUbQTBqmc45s+fTHNGU6Bkp02OAv9kxz86vD51xPAHAdqVkS3uiHwTmykk6SzrJdV3kJ1msnTNeyAODnwdZC8Y=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2998.namprd15.prod.outlook.com (2603:10b6:a03:fc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 20:28:02 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 20:28:02 +0000
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken
 dwarf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
References: <20201031223131.3398153-1-jolsa@kernel.org>
 <20201031223131.3398153-3-jolsa@kernel.org> <20201102215908.GC3597846@krava>
 <20201102225658.GD3597846@krava>
 <CAEf4BzbdGwogFQiLE2eH9ER67hne7NgW4S8miYBM4CRb8NDPvg@mail.gmail.com>
 <20201103190559.GI3597846@krava>
 <CAEf4BzbMOzAdsyMT736idoGnJ1RuxRa5y9wf-egh+LKz406m1g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5bbb9838-d98a-c04d-ecba-878f2f934ae0@fb.com>
Date:   Tue, 3 Nov 2020 12:27:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <CAEf4BzbMOzAdsyMT736idoGnJ1RuxRa5y9wf-egh+LKz406m1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:37c5]
X-ClientProxiedBy: MWHPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:300:4b::34) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::13f2] (2620:10d:c090:400::5:37c5) by MWHPR02CA0024.namprd02.prod.outlook.com (2603:10b6:300:4b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 20:28:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32907c5c-fd28-4796-e140-08d88036f639
X-MS-TrafficTypeDiagnostic: BYAPR15MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB29984BFE61A7600D98F3D3E3D3110@BYAPR15MB2998.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbiJ/HXlx8oQlQ+GWdMQbE0gG+2PfBRIBtoTlIcIjFyZzzNRfwZsQo8wpQgX/eZzsmj7H/H/RmqnaTFVvVH01rRxNXa2SBiJ19X8vP2yPQkxDnBcRfnayBVRPH2vFxskUBPCj1MJS/JF7F3HO+7iOIQagqjGoFGX3t+xSKDZVXoZCURJMxkr0lQm+XHRianVUfUq0saL7Q+2gbUrqEPBYdaExiJUe/j3kbGjeoNDH0RTIyywbjQxJw2QVHbYiTCkleXb3Efv5wtVDcyKyGOi23aH7Qpx0Xy/KjkCDO2dgTh16G9D2KJDTTWFoFZBkil/j9BYmOTutX69qNfx9xis0Ot5vv96ToaMtP+UdEQ7MRvWPPbbgjfUB0IBeXCUVBvHaDlCmbhWVjgyeZp7z109zbqKCwECOcLlcm07FyFJiZB7jKjRouoYRQxZ0feD/2tyO8FqlgeGoBafqbtbxRE5Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(396003)(136003)(66946007)(66556008)(31686004)(31696002)(6666004)(2616005)(36756003)(66476007)(316002)(54906003)(8676002)(52116002)(86362001)(110136005)(2906002)(5660300002)(478600001)(53546011)(6486002)(8936002)(7416002)(186003)(16526019)(4326008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bGOBYGendnwyZPdxscT5FhjlDlexqu/dwDJsq4jDuH5p5OF2WVe1PxNGbF+WmaUizKMo6RG6/PEhStjHB5Ec3G2fDyhm/uNIzgFIcLW6i4GCSovelf9N5yO4bUj7cQb6lRtzvsgzR7YJrMGzlg9lLU2piFCm5fP1KEVvs9JtJO0fwWnWMu7LcKeZA8eeWTy5R6Yzbk1tlxAh6y8IG56XsqbtZ+5hEx5E68bI5X/WnKHtnT2FQXclIeSIWZp9fAPqB8dbDYXJV8KUIYsh5WOgJD8B6E1nfNtRTk6vGtiN6/T4XeirLDJJpE+iviV89whyap5cy/4gwwbKyJCpNmVhduUQxPxFE52clsDp/JuC4AKhKRBZqNSdgp8u5TaOd5tLiHGzUSlz+mbxX529LQ7yBrhn3tPP0VV3pzp90lFBV+LiqSOhMk0NXsPhFb4m6OrA9pL9MzdSSjlwNDl4+UvpRMU/axohztc+yy6BF0Xl0pQZ9Qum0iJm3R0tuzvmqCElD84R5VJ3dkm4vdu63NtYk/EtOWwwqdpTwhRvA1nELs7/fXknLDTBA4yK6ZyqkKNs8J6ezfegUowSbE7PaUKL1rZs1KmzflaEtiyQgnpciC0rPFYHLmtsxwdX31YVFlv82o0JOExjVLNWDbE3eb50mh3sRWcOeFEDHkHUBHu6mXZ4Hk4DdIjcAAUY3+d50Ok0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32907c5c-fd28-4796-e140-08d88036f639
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 20:28:02.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL1lc01gni17s3/8Y/hCvTIlLbDR3A2AqWp8esb0ZxsSKQuKIur3Eb00wmZcW6RS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2998
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_14:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/20 11:23 AM, Andrii Nakryiko wrote:
> On Tue, Nov 3, 2020 at 11:06 AM Jiri Olsa <jolsa@redhat.com> wrote:
>>
>> On Tue, Nov 03, 2020 at 10:58:58AM -0800, Andrii Nakryiko wrote:
>>> On Mon, Nov 2, 2020 at 2:57 PM Jiri Olsa <jolsa@redhat.com> wrote:
>>>>
>>>> On Mon, Nov 02, 2020 at 10:59:08PM +0100, Jiri Olsa wrote:
>>>>> On Sat, Oct 31, 2020 at 11:31:31PM +0100, Jiri Olsa wrote:
>>>>>> We need to generate just single BTF instance for the
>>>>>> function, while DWARF data contains multiple instances
>>>>>> of DW_TAG_subprogram tag.
>>>>>>
>>>>>> Unfortunately we can no longer rely on DW_AT_declaration
>>>>>> tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
>>>>>>
>>>>>> Instead we apply following checks:
>>>>>>    - argument names are defined for the function
>>>>>>    - there's symbol and address defined for the function
>>>>>>    - function is generated only once
>>>>>>
>>>>>> Also because we want to follow kernel's ftrace traceable
>>>>>> functions, this patchset is adding extra check that the
>>>>>> function is one of the ftrace's functions.
>>>>>>
>>>>>> All ftrace functions addresses are stored in vmlinux
>>>>>> binary within symbols:
>>>>>>    __start_mcount_loc
>>>>>>    __stop_mcount_loc
>>>>>
>>>>> hum, for some reason this does not pass through bpf internal
>>>>> functions like bpf_iter_bpf_map.. I learned it hard way ;-)
>>>
>>> what's the exact name of the function that was missing?
>>> bpf_iter_bpf_map doesn't exist. And if it's __init function, why does
>>> it matter, it's not going to be even available at runtime, right?
>>>
>>
>> bpf_map iter definition:
>>
>> DEFINE_BPF_ITER_FUNC(bpf_map, struct bpf_iter_meta *meta, struct bpf_map *map)
>>
>> goes to:
>>
>> #define DEFINE_BPF_ITER_FUNC(target, args...)                   \
>>          extern int bpf_iter_ ## target(args);                   \
>>          int __init bpf_iter_ ## target(args) { return 0; }
>>
>> that creates __init bpf_iter_bpf_map function that will make
>> it into BTF where it's expected when opening iterator, but the
>> code will be freed because it's __init function
> 
> hm... should we just drop __init there?
> 
> Yonghong, is __init strictly necessary, or was just an optimization to
> save a tiny bit of space?

It is an optimization to save some space. We only need function
signature, not function body, for bpf_iter.

The macro definition is in include/linux/bpf.h.

#define DEFINE_BPF_ITER_FUNC(target, args...)                   \
         extern int bpf_iter_ ## target(args);                   \
         int __init bpf_iter_ ## target(args) { return 0; }

Maybe you could have a section, e.g., called
   .init.bpf.preserve_type
which you can scan through to preserve the types.

Alternatively you can drop the above __init, the saving is
indeed tiny. But this adds overhead to ksymbol lookup and
may not be desirable.

> 
>>
>> there are few iteratos functions like that, and I was going to
>> check if there's more
>>
>>>
>>>>> will check
>>>>
>>>> so it gets filtered out because it's __init function
>>>> I'll check if the fix below catches all internal functions,
>>>> but I guess we should do something more robust
>>>>
>>>> jirka
>>>>
>>>>
>>>> ---
>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>> index 0a378aa92142..3cd94280c35b 100644
>>>> --- a/btf_encoder.c
>>>> +++ b/btf_encoder.c
>>>> @@ -143,7 +143,8 @@ static int filter_functions(struct btf_elf *btfe, struct mcount_symbols *ms)
>>>>                  /* Do not enable .init section functions. */
>>>>                  if (init_filter &&
>>>>                      func->addr >= ms->init_begin &&
>>>> -                   func->addr <  ms->init_end)
>>>> +                   func->addr <  ms->init_end &&
>>>> +                   strncmp("bpf_", func->name, 4))
>>>
>>> this looks like a very wrong way to do this? Can you please elaborate
>>> on what's missing and why it shouldn't be missing?
>>
>> yes, it's just a hack, we should do something more
>> robust as I mentioned above
>>
>> it just allowed me to use iterators finaly ;-)
> 
> sure, I get it, I was just trying to understand why there is such a
> problem in the first place. Turns out we need FUNCs not just for
> fentry/fexit and similar, but also for bpf_iter, which is an entirely
> different use case (similar to raw_tp, but raw_tp is using typedef ->
> func_proto approach).
> 
> So I don't know, we might as well just not do mcount checks?.. As an
> alternative, but it's not great as well.
> 
>>
>> jirka
>>
