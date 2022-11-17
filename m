Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16662E95E
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiKQXOW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKQXOV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:14:21 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88A269DE2
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:14:20 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHMajUL032629;
        Thu, 17 Nov 2022 15:14:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kRuoHYbptYPbEUflJV83UhW1L3I7ZAbDnFj9wQzsbo8=;
 b=fRVmVdUu6rMN7cf7LQR33QMflIol+DjvbTmgk2VTYtTGB0WCuG2K6OyZ7owCwwU45+yI
 d6lDNN1v1J/XZgaHyBcQczjDwssM0j/7ZKH89UFlhUp0S5w4dPUXhNmCcYl/W13N0tK5
 sJYooUWu4osfMKLH0v8q/SPrvenDTaVz7E5waGsNf/dJ64bPbQZFuFggA8y/TAOAVk45
 90iACmxKuAFPozWMkDE0JeGl+pMtGxby//Q9Du9IBJdRASzpqyhAc8FUokUdhcsrTNtP
 vu2pbW6IXOkdx8fl/Lr3CfZkdVwq6MNqza0lBnj2lJ57KXE2jL6oAVY18ZieSY+xcZ8F kg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kwww9g83y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 15:14:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhZTNNEBHd90Z4G8wpd5m1ebzuL8jElsn00HnMGMKQFQZq7/J36zd7n27TGrk0/1N4Z4eGCKd8jvMJBF8uAXjbNVRifUsubP4taHjPt7k4wh8PZoPC7tGmiqhOi0FFcDxKJj3usuy4yMD1pbflz8xYOOT3pY0YhOfd4pCfxA3lR1CBES2A9Ex+Pb0ds7mssBEAjkLXgdeLqXyPKgmvChnRuniYI62JC7ebZfaaNl+QMayvI5ECRz0hZK0QcsdYd8Us6vbEudwROM8ux1QJaVc7cJswCdheGg7kXiQ7B2W+s7Yi3gm0RS0Vq/g/+rzRhosQOQEuacJjYQyj+xLMVxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRuoHYbptYPbEUflJV83UhW1L3I7ZAbDnFj9wQzsbo8=;
 b=UdudhkKS5J0fzuX80j5EUdLBxgTc2hRE5vCjxz2JVuEh4shQus0499DDF2Zy+85yl1qlhCHoI5RWT85TGoH4vcEj3D8Sq/+b/dgXtNvYw3zf/i3C5m2ECP3Le40+hatZB3v0Rg/ERIUPLvk7ZWlG1ljhNHkGBTKSSkMVVfSDwfsigvV+4k4xUxItBdzFhE4MsKpVIIqPtqOHm/V7tGPekHEE0U/TIGwuup9yUnMyaQQXjrW+M2CDKsUF39qVwL6zZfadyRhlyZ3pmOjQ6lj4lGTyeWB/XRGaSJF88Eceuii57IBS6svvaRQqZMdhi/7pqnk/FVmuoB8OG0NUrm5O3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3184.namprd15.prod.outlook.com (2603:10b6:208:3a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 23:14:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 23:14:00 +0000
Message-ID: <1e84bdbb-59ff-05d8-8407-dc9544270604@meta.com>
Date:   Thu, 17 Nov 2022 15:13:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf_get_kern_btf_id()
 kfunc
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221114162328.622665-1-yhs@fb.com>
 <20221114162339.625320-1-yhs@fb.com>
 <20221115194308.ej5lwd2jo6ulebut@MacBook-Pro-5.local.dhcp.thefacebook.com>
 <20221115200541.bm7xhdurhpxuv54u@apollo>
 <1f856abf-0161-c560-7941-423c9f8c472e@meta.com>
 <20221117182404.lgi3nq4jcomjlbvp@apollo>
 <94f9ec8d-8b54-2873-21d0-948c667e20d8@meta.com>
 <20221117230132.frdiksvf3ia6v2ym@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221117230132.frdiksvf3ia6v2ym@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:74::48) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3184:EE_
X-MS-Office365-Filtering-Correlation-Id: 74764458-546a-4fde-b13c-08dac8f1695e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+IiHniaEU7NtzJNfNEC7dHyXP5wZYrPhx/22R431lO95oLNaK6hvsRDkzX2GdhbFH9IimcDI2FsYZnjnX8ZC8Rqi+F+zBlrLjnTPB1By03BqMsxhVP2zAl0ncsDIrYnNK19UgsyYgGE0ptUrjX6xAiTjkSIsdwCVhdfxEbaGvnpH7x2TVxR+f3SVjna3k+pv0T9k4/OyhtsnbXxXr7ZZPU5POwDxwnfQwt5UUppWDWvaT7iT5z05DFgPAhNhWJPC4g3X8dI6yl7adZ+MH5ByCW8J52XLnj+o8Q/pJa3hALxQPTG0R1tcWgKBh+UkNneFsbDoEcYKXrx3XQHbAU4UdspnFKN/FHRFRwmisUS3IAYLvFmjyY/vC77J3edcDzUTAwFNWhBqeRtdU0AmEguQwQdi64GdcEdsxJpu612SR5gYxpeUSSIeTozyTBpz3IBuHFdvNHlo8DlWF9eImu8oKTEUyiIasT87KMeK2g/ZATJGvrApBFMgA47DSE8eG3h14beS323dIOB+d4AX0n801yiVJvKEDenY78r/wX08NA3vDba9nc4vNmpin4DN9Yq9ZHjS/iTx36B2BPVSWVRld2MOf1GZroYquuPMH2FJqa/SO0SMG8vlbd277YlUp46HTtRRm4nw0k/rxO7CAtsLDxHfceapGyr2g8VYMzDkiGQZvbgXgzMM/+wVtg/J1+tztbiPr7TH2IfbrxM9KHPXdZI//iK7ojKQjq3Ga8kS6Bp2FQtUV8q5YfK6aUd9ftNIRty4kq8Rk+Z8bNcWMQ9CFjD0o0ZzfeN1EY0tAWj8+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(8936002)(4326008)(5660300002)(316002)(6916009)(66556008)(41300700001)(66946007)(31686004)(8676002)(66476007)(54906003)(478600001)(6506007)(53546011)(186003)(2616005)(6512007)(966005)(6486002)(36756003)(2906002)(38100700002)(31696002)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFhGMTFBUHRUYUZyRFY0cHJPMDhieEZkODZnR1E5Y2JKSkZseTZzUUFJWmIy?=
 =?utf-8?B?ZTlqTHA2ZGhaYXlTaHZVd1cwTDZaaGEzVVdqbkxNUUFweDRTVitFeUhsdkdu?=
 =?utf-8?B?cTBQMXkrdTl2dWd3Rml4a1RYc1RkMVNzc29MQ2xRUEh3TXhvaVVEeTMzTlRT?=
 =?utf-8?B?UG5ETnZ2Vy9IWldKRDdDWVRJTTBYdVVLT2oxbzJWRmNwcXFJL01EK2JvZXVi?=
 =?utf-8?B?YjhJYUJUQlJKYkx6RjJrMFMya3I3ajkrZ01QbkNWRDVTc1N0RnFKK1FubW9q?=
 =?utf-8?B?N0I2ZEJhYUp1U0M0bEVndEpZMVVDOW5MeEVSRm54YXRXQ1lxdlFXVGxublhR?=
 =?utf-8?B?R2t2ZGQ4YVNXWjZLTFBaa2JuaFlnK0FpWXZTZysxMEthQks1NEgrdGl4OS9v?=
 =?utf-8?B?aVIxUnVYODFSZzRrTURyN213bzNucnVNc3lxYll5dEZDZG5EUk9aSDhyMEcy?=
 =?utf-8?B?ZjBOeWpCRGtIR1NveEVINlBPRFFYbUw1V0NGSkVOWTNwNk50cy85cEZvcktl?=
 =?utf-8?B?OWZYMmRHVEtDSEg5VUpNNE9Lby83Z2s0U2tuSGpWQ0JVNlVqeXZPOEdIZ3VJ?=
 =?utf-8?B?TjEzU2UxN1NvdVJaK1l0Y2N0bmF4V0VtaXJ4WDh1M0ZNell6bU9pbGF2TjAx?=
 =?utf-8?B?R0dCcXM0d1BVVm1wZ3RpNnAvZSsxTWdGQ05BOXc2blhpR0pFN2JYK1o4dVJD?=
 =?utf-8?B?MXQwQ2lZY1JaU3V6UDJibnlKb3Z6SHptVUZzWWxWZWVvdHlITEdYN3c4NHVE?=
 =?utf-8?B?Zm9mbXRjV1ZYTldRdWVrRTBmUjBMUG1OV1ZzMFRmUmIvQXRHZzlEZ0FBY2RM?=
 =?utf-8?B?cjkyTEFhenBLdUFEa1o2U0t2eUZ0blNzWUhBZWZVNW1JYktIaUkwaGVWeU5P?=
 =?utf-8?B?MDZVNk5QV0VLdVI0NmJHVjc3ZkpybHZnVFhHQnk5QmZZMG1KWGlpTWZ1Z3px?=
 =?utf-8?B?T1R0ZllENXo4RzV5b09mZlpHT2N4SDE3eG5GdHFYUWpsNmttYXZVMnNPbm10?=
 =?utf-8?B?clRwRlhMN2hERU9XeTNiWTE5RHE0am03c0EvVlV0TEtIMkxBTTMzaDRSVDh1?=
 =?utf-8?B?OTJ5SWRXQktQUXFheFhSTzJoY2ROdTl2VUdLQSswSU1tYys4YmpadzBGSFZG?=
 =?utf-8?B?WlphVjNBMGVFL0FvbDZRQmF3NlVFN3FpY1l2aXN5bTc1bXBQMXBzQUZGSm5y?=
 =?utf-8?B?eGl6VDJWWVgxSFJVK0VKZC9uNVByYkJaUWJwODJzRDdiSXdvSEtsMW1XL1pa?=
 =?utf-8?B?YjNrMlJsWEdHTmM2Qm9pT1lTL2hLNWFldDVaSzNWcFp5V2h0aEVuUkNNVG1u?=
 =?utf-8?B?MFFEU2dVWUVXWC91NkR5YnVjUHBUUVU1by9mSWJvVTFQSnFaaDEwbmsrWnpm?=
 =?utf-8?B?R2laU2d3RE5rZENyb2RQcTVsSDBJT0lmemZEeE9QaFZyS1dmVG9xU29oUFdw?=
 =?utf-8?B?Z3BFc1BkVnZjYTN0N2NaR09relVhdWpiNFJvdHZDRUFpUGp3UXRaM0hjaFNV?=
 =?utf-8?B?OHo5UFU2ZTFkWXhVck03Q3NHaHExUU5JYTBlOCt1K0NEUmd2YmZHWlArOXRp?=
 =?utf-8?B?SDhsWjBvdzEvaW5NZ252bjdSTWFJR3dVcTlnUE9DZE1MbVhJVXc0WE1pWGlq?=
 =?utf-8?B?d21KVGxxanZEbTJpbGdRUDBEek51ZlZvbWtrTTF4MUM0bnJrZzhhVk5lSmFY?=
 =?utf-8?B?N2pnU2R4RDJFazRFcnRLQ2dSa3d5bGZ3YXlLSmZmZUt1c05CNjlCWkZUZWQ0?=
 =?utf-8?B?WC9kTmZJcVpXd1RvejJYWUZOOVRCWWEzd1d0UGNKR2t3R0JsZjVIdG1zRTFK?=
 =?utf-8?B?Y0ZxTWU3cWxTVUVEQVhjaXVjQS81Z0dCRWQwRSt5UXRpdWJ6MXhOdnBWNW9Z?=
 =?utf-8?B?TExWQlZvV3ZtaHBkSUFSeW1LcDRVT3RSZXpWbUJkc1pvVXhNeGEwWEdHWk93?=
 =?utf-8?B?Vm9UK1BaZ0xFOFoxVjlpa1YwaDFjSWEvQThybHZjMnkvQm1oNjRiNnZLZFB3?=
 =?utf-8?B?Z2UwVTM5ZlhrN3ZsRVdpU1p4amJYbnZLNTFXVjN1OXN1cmY3UTlsTkkzblhO?=
 =?utf-8?B?dkl0bnZ6L3FyUTVNaGVLcTdENnRHaDR4RVY1UlBDenJBNFFtazAzWmVTa3JT?=
 =?utf-8?B?b040VDdHYStTVUlobDAyZGc5bnVQWW5salk2bUJXQTZrTTFqbDNlTitsTjdz?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74764458-546a-4fde-b13c-08dac8f1695e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 23:14:00.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQdgssZ3NOubLi7f1DfiLXarm8AWbMFVU4NzWZ9WhDXu8/5ioqdQJ/EIYs8mxUpf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3184
X-Proofpoint-GUID: qki7RkA21ukNsZpy7Cn7PcDg_7iqTOf1
X-Proofpoint-ORIG-GUID: qki7RkA21ukNsZpy7Cn7PcDg_7iqTOf1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/17/22 3:01 PM, Kumar Kartikeya Dwivedi wrote:
> On Fri, Nov 18, 2022 at 04:22:40AM IST, Yonghong Song wrote:
>>
>>
>> On 11/17/22 10:24 AM, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, Nov 16, 2022 at 01:56:14AM IST, Yonghong Song wrote:
>>>>
>>>>
>>>> On 11/15/22 12:05 PM, Kumar Kartikeya Dwivedi wrote:
>>>>> On Wed, Nov 16, 2022 at 01:13:08AM IST, Alexei Starovoitov wrote:
>>>>>> On Mon, Nov 14, 2022 at 08:23:39AM -0800, Yonghong Song wrote:
>>>>>>> The signature of bpf_get_kern_btf_id() function looks like
>>>>>>>      void *bpf_get_kern_btf_id(obj, expected_btf_id)
>>>>>>> The obj has a pointer type. The expected_btf_id is 0 or
>>>>>>> a btf id to be returned by the kfunc. The function
>>>>>>> currently supports two kinds of obj:
>>>>>>>      - obj: ptr_to_ctx, expected_btf_id: 0
>>>>>>>        return the expected kernel ctx btf id
>>>>>>>      - obj: ptr to char/unsigned char, expected_btf_id: a struct btf id
>>>>>>>        return expected_btf_id
>>>>>>> The second case looks like a type casting, e.g., in kernel we have
>>>>>>>      #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
>>>>>>> bpf program can get a skb_shared_info btf id ptr with bpf_get_kern_btf_id()
>>>>>>> kfunc.
>>>>>>
>>>>>> Kumar has proposed
>>>>>> bpf_rdonly_cast(any_64bit_value, btf_id) -> PTR_TO_BTF_ID | PTR_UNTRUSTED.
>>>>>> The idea of bpf_get_kern_btf_id(ctx) looks complementary.
>>>>>> The bpf_get_kern_btf_id name is too specific imo.
>>>>>> How about two kfuncs:
>>>>>>
>>>>>> bpf_cast_to_kern_ctx(ctx) -> ptr_to_btf_id | ptr_trusted
>>>>>> bpf_rdonly_cast(any_scalar, btf_id) -> ptr_to_btf_id | ptr_untrusted
>>>>
>>>> Sounds good. Two helpers can make sense as it is indeed true for
>>>> bpf_cast_to_kern_ctx(ctx), the btf_id is not needed.
>>>>
>>>>>>
>>>>>> ptr_trusted flag will have semantics as discsused with David and Kumar in:
>>>>>> https://lore.kernel.org/bpf/CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com/
>>>>>>
>>>>>> The verifier knows how to cast safe pointer 'ctx' to kernel 'mirror' structure.
>>>>>> No need for additional btf_id argument.
>>>>>> We can express it as ptr_to_btf_id | ptr_trusted and safely pass to kfuncs.
>>>>>> bpf_rdonly_cast() can accept any 64-bit value.
>>>>>> There is no need to limit it to 'char *' arg. Since it's ptr_to_btf_id | ptr_untrusted
>>>>>> it cannot be passed to kfuncs and only rdonly acccess is allowed.
>>>>>> Both kfuncs need to be cap_perfmon gated, of course.
>>>>>> Thoughts?
>>>>
>>>> Currently, we only have SCALAR_VALUE to represent 'void *', 'char *',
>>>> 'unsigned char *'. yes, some pointer might be long and cast to 'struct foo
>>>> *', so the generalization of bpf_rdonly_cast() to all scalar value
>>>> should be fine. Although it is possible the it might be abused and incuring
>>>> some exception handling, but guarding it with cap_perfmon
>>>> should be okay.
>>>>
>>>>>
>>>>> Here is the PoC I wrote when we discussed this:
>>>>> It still uses bpf_unsafe_cast naming, but that was before Alexei suggested the
>>>>> bpf_rdonly_cast name.
>>>>> https://github.com/kkdwivedi/linux/commits/unsafe-cast (see the 2 latest commits)
>>>>> The selftest showcases how it will be useful.
>>>>
>>>> Sounds good. I can redo may patch for bpf_cast_to_kern_ctx(), which should
>>>> cover some of existing cases. Kumar, since you are working on
>>>> bpf_rdonly_cast(), you could work on that later. If you want me to do it,
>>>> just let me know I can incorporate it in my patch set.
>>
>> I just prototyped a little bit with Alexei's suggested interface. It has
>> some differences. I will explain in my next revision.
>>
>> My prototype already added bpf_rdonly_cast(). As you suggested, it is
>> not too hard. I have not done with module btf yet. Will add it
>> as you suggested below.
>>
> 
> It's fine to also leave out types in module BTFs for now, atleast as long you
> return a reasonable error message from the verifier. Just relying on btf_vmlinux
> is enough for the FIXMEs in selftests.

Okay, will leave module support at this point then.

