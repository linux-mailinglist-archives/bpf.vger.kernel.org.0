Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED8E636B7E
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 21:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiKWUst (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 15:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbiKWUq4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 15:46:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47F11839
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 12:46:55 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHsL6l023826;
        Wed, 23 Nov 2022 12:46:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9n1C9XLOw3LGU51LFErDNnluTp38ah8ogFILqe8lGqE=;
 b=B3+lOyf3rlsXmApCnyoEfCHEw3tjKE25Iy/fDWq1XYLZSwxCY1safv4eXdLbVr9rQsIz
 +yABzDM95ELyK+HlceYO2kmerKcUlce/dKA0ThNCXk4HmkgEliUoOQMVMcmdtVa8Vrzp
 OUpfK8HaL3143h3A0UqSocQCIAP8zxn5Y5D2gENQpZfWM/Fn8uGLUSRcK30oUoY+yIz4
 otMRJ1d3ZtQSAlKwDHGfgA0R5zcH3dphfgrIzHfmKSXW+mVWn1Lm16W7Yv+ClbZMg4WQ
 FXs7bW1LvL5PtPWXdvfvd8REGlD6LXeX7gyC/hpBFYH87mzauKsU2dfQM/u6PJ7Viur1 oA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m17esfbbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 12:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSofFEQjS7XUkJ2TpVq7liRj4wPpwA6ybv/NgcY4IibICcs8xLCWJIVJqlTrJtCG02v3SpP87JVgRvl1dWB3RoKUUiXBXDg9P/eQm4sQehZ/bHcgmzFghQKKG8YxyvIGseIWz86JyVCcD6dBFx9JHhgdKg0DUfGvpqRLqIVFLFUoFGG71Ltuj8UoCxxkNjmDsXGP2MUTTEpOUPz/BZVHCdB/ZhKHmH+vO4Vy9du216GBbQcvMrN6brttm4mdsJIDHlZao0ZohLEwT8h+0CvrWe2orHuBIKr0WwRMxHxpxb0lq57/NWhlACP8VdhJo8qag4KrrsooHZYsaK8cK1gabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n1C9XLOw3LGU51LFErDNnluTp38ah8ogFILqe8lGqE=;
 b=N5O6fAS4UyV9yvpum2z3s4o3+qfB0LHh6elRU7xz3/hDa3iqgZbf8E9e/JsAAUa6Te8kN6s9uX+sZQaS7VLuWIs3vSUHdDz65BPI117r5JsGbCwrd4GJkrYpOh+QM3hknyoMjSXL3vWHLc5Fjsc7Y9+nSyHxIbVYWKJfc5Q8GYt8xrOxKpiHqitRIiJh5jl3idkGv7pprnK2JHF3Hqw4p/enNpEI7Bq1BYkyMfYgN9NUbQGIL2HFnCUaN0hdS7VyDMxISReQpBCRAhxQJk13ZAjHWkjVRd1tgf1zPWIBOkeQR7q5PmQGlJUopTcuOKW1c2a0voXFLnHIE/NoR0Ndmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by CY4PR15MB1590.namprd15.prod.outlook.com (2603:10b6:903:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 20:46:36 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::e89a:c6e:5ea1:a740]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::e89a:c6e:5ea1:a740%7]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 20:46:35 +0000
Message-ID: <13196687-fc16-f690-e2cb-f051aabae228@meta.com>
Date:   Wed, 23 Nov 2022 12:46:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, alan.maguire@oracle.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221120195421.3112414-1-yhs@fb.com>
 <637ade2851bc6_99c62086@john.notmuch>
 <2c4f8cac-6935-2c72-cc1b-34a34708e127@meta.com>
 <637c2a6c4b042_18ed92085f@john.notmuch>
 <e727f852-7484-b31f-fb5d-7a4f034fe48e@meta.com>
 <637d911914799_2b649208da@john.notmuch>
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <637d911914799_2b649208da@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|CY4PR15MB1590:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dc4863-1fb0-4630-2758-08dacd93cfe5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUNiOa1tjU1gsgWtxj+06O9NPdLJkryD4CceeINTjuCQtQoakwLocX6RD20WzI7FU9vkALrfOZwNMgXqKu4o2VQ70HoLGiuk6DZjC6u5cwPX3rg+Iw7FZ9FynkXXoauKsNdJWeZxWqC63M0eK70nIzPe/Kp8SR/lEhDLL2kGxM6G3GAtxv72CenUsxVsyQyCBlhJw8UxDiIPE4qbE8jcqr9YZpggQ9IFyq5LQVZoZt4cRmXCQ/ApK8f6EJKDvrItlSGBaaRq8YfU3UkYJ04e17A2ly3nF8OYa6Z+b8B/xfnZd7xLgNdIgCtHeeVKZ+Dg8Vtzxrly5RtOUHOQbgiKMzmJb137L0uu4hgwVFH9S4Y+XZYmPkUL/dLvN3Ah3tLZjV8p3e8SUQ4UAWbuqZornoDkk6CaX2J+rDte2wTjilGj93rEMOGtt7QvxrDINrloJMvQyC36776BIDMEtoNJFmGdH8z3VghhZ1rx3kvxxitlDmaXDZn0pGJuk2/EhX9IB4oufh9lBu6djbL5Rc1yKxBj283dndfQxK/AUdUrhgJg11nyC5Bvb02erghpcoKxaYPvbcdoa/12/T5vyiU29CmGEG+AfarP66RxrfedlqihBaJUtaM/iPdGMYsAEhg6UWYzb1QVe8wfZsmYz5rWcl0X+WepTY7cJB77ofpoNkgmgbTMBNkx4FqYhbme8XUWZ9TYasdp06HON2fEbAQKOqxNPDw5q8mi83m9V6iho0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199015)(38100700002)(54906003)(31686004)(6486002)(478600001)(31696002)(41300700001)(86362001)(6512007)(6506007)(110136005)(4326008)(66556008)(316002)(8676002)(66946007)(36756003)(2906002)(83380400001)(66476007)(5660300002)(53546011)(2616005)(8936002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vlp2Q3BDK3VaRHVvYTM5WDl0aUk5dFFjWmxtcTZNQlc0NnBVRnpQWldRNzh2?=
 =?utf-8?B?VnJSNGRQSHhLbkphNGZzUi8vZ3lFa2k1YXVlMGxQSVdFZjE5MTUyZHdOSE9W?=
 =?utf-8?B?a0NiTEZkN2NhMUlWMER6NzdMdk9XQURTbmR2V3JaR3QxZVlXMVJjVDRSZVIz?=
 =?utf-8?B?RjJpclhibnk0VVB1bm5JZnkxSVBUK0tUd2Y2c2VZMzVNUUpwd0NGdm1LaHpJ?=
 =?utf-8?B?NVBaY0JVQkkzT0RGT3d2RXdpUzh0M1EwQ1N5MHBHUDNWcXJrb0p6aVFuQzVI?=
 =?utf-8?B?a2wwdkZBQUZRbXhuVEZ1S3hJVC9STHRZdlJUcTN5by8wSy8yWWJUZVRzNzds?=
 =?utf-8?B?UXpDeTVENldPdXBGSzhFejhOZ2x3bitQR29MejVoYkNqVWVYeVRoSVcxRGtt?=
 =?utf-8?B?K1grL1NObnhzUTZyNXJMRVJBemx4TzR1STF1NTBodTN1elIvZDkybUwyUmk1?=
 =?utf-8?B?RFd0N2lENEVMcWEvOU9jczk5YmswVzlwN3JiU25qVjNUdzkyS1A1QzMyNHNO?=
 =?utf-8?B?K2hQKzl6M0xPeUpUZWNMMzhIcWxBSzVBTGRJNUdvOG1UZytRdGROMzlrTHRQ?=
 =?utf-8?B?UGxaclIvUTd4VXJYZVBzMXFld0gya0EvbUJRYTl6Y21KV0V0WGIzSmRialJ1?=
 =?utf-8?B?cjFXcDNaUExZMW9ncmNqMWVLVHJTZmZENE5DaVhmRVoyVXBiaGpxVlp1U1Ns?=
 =?utf-8?B?VzlPY1lTaGJJT1BvSExsT1crMThtK3lpN2RiekZYTk50MnExWllDY25MakdI?=
 =?utf-8?B?Q0liUFhqZGlDQUFwMm1FSUFvdkdhYVAwOFoxUGFlM0QzMmdIYjEybWp5ODlB?=
 =?utf-8?B?d1FyOWc1cFVLUjRzR1VNZGZRQmIvdXBsSzN4S2ZuVHAyRFFmV1k1SmdYa0RR?=
 =?utf-8?B?MzFER2lpV0hwVHpHdENoZmxMeFEwM2oxTFducXpENGl0eTJJTDNNVDJIMXRL?=
 =?utf-8?B?NkhycXRhbG5kWVphZFhacU1VL1g2Sys2Nm5LVU9INzFVbElwT1RpOWNFT0JE?=
 =?utf-8?B?NTJqUUZwNnFreXhIVzlFRlMwNk5IdGdsRGpaSlJLZStmczc0amE0ektZNDNT?=
 =?utf-8?B?RjFWRm52bmtBdUNJYW1oaDUzM1BhQVZNZFpSbGVBaXFOeXJaT3Z6eGJESW9X?=
 =?utf-8?B?eGVPQS94S1RPK1FJL2NsSE5vMmVibk94eHB4V0pwcGI3UWVTNlNKaGlBM2hM?=
 =?utf-8?B?aXhjbnQ4TkM2akl6WVJiak92WW1NcnArZHB2OCsxVDlEdkl3VjhoeVdHaEtk?=
 =?utf-8?B?d01PVU52OFJTclErU1F5SjRuRXljWitTYUYwQzhPMURHZUpoYy9jMnNXYnBH?=
 =?utf-8?B?dXhQa3JFbkxiQlp1ZGMxaGJiV1YwZlYzQmxXRHZnaHVKUEk5ODYzZGFxU284?=
 =?utf-8?B?QmE5QWE4NDVnRis1Qlc2bjlxaVdTVTlwNENiYTVvandVL0FpSzc0Y21mSC9X?=
 =?utf-8?B?ays2d2M1bzk2NUJLYWFoK1d6WDducTFFcloxK3hIanl5aGVlNWtoYUJ4eHpR?=
 =?utf-8?B?VUxJeTNSbWhya3phUiswUmZnUVh0NWhyWjZuZnJyYW1FZ0V1TjlhQk9ac0Ni?=
 =?utf-8?B?SEVLODFEZytoa2NFQnJhZ0tMVHRIZkgxNFV0Z3JWNGI2UHhCNks1WW5kOHVt?=
 =?utf-8?B?VkNTZlJhNmRESXZjNkxmZU1MclFTT3BFekt3bGNaSTdNRFRQRVpVbnMzOFVU?=
 =?utf-8?B?NU5raG1vd1lDK3BzdUJ5b2U1YW0vK0VabVU3aHh6RDJOUlVpVHZ4UXNacWg4?=
 =?utf-8?B?N0dHWDJGcFp0SThOWm1QOFFRRHJicXJJbXg5My8zdlM5a1psMFhYOTFjMTdK?=
 =?utf-8?B?c2dPLytDWHAxMG9zM2ZxWXA4YzRlYjNjTldEQ2FXd05tbEZxc3R1UCtSekNT?=
 =?utf-8?B?K0QxN3hBVWhOTDVidlRzM25mT3l6Nkx5anN4Qk0vcmNYNVRkOHgxQjg0QTRX?=
 =?utf-8?B?VWVPcUhtMjArTHpESElUcEhlT3B3WUR6WWlZbkVSWkxXZW95cGFKb2s3Q21Q?=
 =?utf-8?B?K2g3cG4vajhZSENvWjl6YkordVAwUnF0a0ZITTlRdUxvNnF4cHp0R2JtYUM2?=
 =?utf-8?B?L014bVFaMnZHeVFrVGFVekk5UHZBY3FsQ3QvWXdVRDd4dUh0Z09XZE5CVGs1?=
 =?utf-8?B?YkFiVHJvaTIvKzF5QXUrOUU0cXpJQmVQdS9DcThzM0o5bDNQbnlPSnk5U0sz?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc4863-1fb0-4630-2758-08dacd93cfe5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 20:46:35.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1As/5Z84AhnpKL3cbXUZWDdXZFM4BlP17hxAxqIhxiIGK/aSjPydG11eEHVjSegs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1590
X-Proofpoint-GUID: GlCNFZkD8Ham62QbaKLI-y9Gaf97gS4e
X-Proofpoint-ORIG-GUID: GlCNFZkD8Ham62QbaKLI-y9Gaf97gS4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_11,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/22/22 7:18 PM, John Fastabend wrote:
> Alexei Starovoitov wrote:
>> On 11/21/22 5:48 PM, John Fastabend wrote:
>>> Yonghong Song wrote:
>>>>
>>>>
>>>> On 11/20/22 6:10 PM, John Fastabend wrote:
>>>>> Yonghong Song wrote:
>>>>>> Currenty, a non-tracing bpf program typically has a single 'context' argument
>>>>>> with predefined uapi struct type. Following these uapi struct, user is able
>>>>>> to access other fields defined in uapi header. Inside the kernel, the
>>>>>> user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
>>>>>> in short) which can access more information than what uapi header provides.
>>>>>> To access other info not in uapi header, people typically do two things:
>>>>>>      (1). extend uapi to access more fields rooted from 'context'.
>>>>>>      (2). use bpf_probe_read_kernl() helper to read particular field based on
>>>>>>        kctx.
>>>
>>> [...]
>>>
>>>>>    From myside this allows us to pull in the dev info and from that get
>>>>> netns so fixes a gap we had to split into a kprobe + xdp.
>>>>>
>>>>> If we can get a pointer to the recv queue then with a few reads we
>>>>> get the hash, vlan, etc. (see timestapm thread)
>>>>
>>>> Thanks, John. Glad to see it is useful.
>>>>
>>>>>
>>>>> And then last bit is if we can get a ptr to the net ns list, plus
>>>>
>>>> Unfortunately, currently vmlinux btf does not have non-percpu global
>>>> variables, so net_namespace_list is not available to bpf programs.
>>>> But I think we could do the following with a little bit user space
>>>> initial involvement as a workaround.
>>>
>>> What would you think of another kfunc, bpf_get_global_var() to fetch
>>> the global reference and cast it with a type? I think even if you
>>> had it in BTF you would still need some sort of helper otherwise
>>> how would you know what scope of the var should be and get it
>>> correct in type checker as a TRUSTED arg? I think for my use case
>>> UNTRUSTED is find, seeing we do it with probe_reads already, but
>>> getting a TRUSTED arg seems nicer given it can be known correct
>>> from kernel side.
>>>
>>> I was thinking something like,
>>>
>>>     struct net *head = bpf_get_global_var(net_namespace_list,
>>> 				bpf_core_type_id_kernel(struct *net));
>>
>> We cannot do this as ptr_trusted, since it's an unknown cast.
> 
> I think you _could_ do it if the kfunc new to check the case type
> and knew that net_namespace_list should return that specific global.
> The verifier would special code that var and type.

Hard code it in the verifier just for one or two variables? Ouch.
Let's see whether all export_symbol_gpl can work.

>> The verifier cannot trust bpf prog to do the right thing.
>> But we can enable this buy adding export_symbol_gpl global vars to BTF.
>> Then they will be trusted and their types correct.
>> Pretty much like per-cpu variables.
>>
> 
> Yep this is the more generic way and sounds better to me. Anyone
> working on adding the global var to BTF now?

Alan Maguire looked at it. cc-ing.

