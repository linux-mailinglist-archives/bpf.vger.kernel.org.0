Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B262A347
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiKOUqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiKOUqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:46:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6C6442
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:46:08 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AFK9DAq012019;
        Tue, 15 Nov 2022 12:45:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=zMKnFO/bBgK3pMfmWXmdt7EUWf0Gu88oIpbFYT3fF1s=;
 b=RYL/IMAInIwcvPnwtjPJwQRYfvEdmidIR4dvO/5w7caV9sXapBGc0bqKEJjF60t+Pp9J
 ko30+b+q/FAxBPmVnif09ksnYlYZ2oc/nkXZAXd+h9PWOTYSZNsdwaLFQkLOZO/K9k3R
 eGVXNbw8pSY8lAj92ePqSytFEnH4XM7AQd7AD+6zt5iax37oaxw+tVgqETJ2BMfbO9/a
 SxPFdjVb901WnRtMuy9r2EC23zNvpT2RvN1sa0J7SMmAdB67gJlBpw8H7ztAuctJ5FjP
 U79QCEov1CzIusY5mJD3KmFK6p5jlaug+lwl9LFvf+vBiJm04AuWRnTYW75VfGKiRslt CQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kvhhsr8qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:45:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXSv1gqJYXiFNhRc8MmTwEwB9qQSZYMKG5IEiWhb473hUBehigK4gP576pIClxcaTWOuUFb5t/B4q0oMCUeOlGC9CLIss+MjWY6b4SavAf7niKPb4KGjoBvtoH2oEn7/QQjyq39B3WySTNeT1PpYJVrKMqqzxQAkjYT3dr1bNIOMCKsh+hmirY9YSlBcc88vKJvU59MY1cHXRWJQfhfs9RLU5Ar4auHbe6nKqS3F+Xh3J8hCSzsP3tGdlgN2ks820A8WOXlehFFdgQ+mtS2G0ej5VlKndlgsGpRJ4BHaItS1U2HlQa6XcC8uG4gvWuldoopoHSfScmovjWondx46zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMKnFO/bBgK3pMfmWXmdt7EUWf0Gu88oIpbFYT3fF1s=;
 b=N8MI45rTcPApkjRRWzeoZH4kxM4/KVm6uI7IXvfO83hiF3GByhyzX1YkUqY7CILSEII+EyUrElMY1/Qcon5ohbtzyG9DA+uURdDax7CgA8DdQhs6SVcBuYmI22k7uwXIzPXwRAzyHsiuyE0uqOsPzD8bpnD9gV9kAiQOyRZuK4eI3bV04dN2qL/sUJlrsOsfiK4xLtvdK2n/pn24j6pPG2nHVbn7oSWdvAdPWgbhvePwMHOk6LemLaS3tfoeYFaUr5KKvERD+0r3Wh1GISdcQxZ20t1/uc+5qyGePefNuWsrZ3nPR2+/m/vZvKrIxiMdm12E/ndr9FhGUmpsutvyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3877.namprd15.prod.outlook.com (2603:10b6:5:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 20:45:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 20:45:43 +0000
Message-ID: <f9ce1bd5-355c-0026-766f-59c3711a58c7@meta.com>
Date:   Tue, 15 Nov 2022 12:45:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v3 1/3] libbpf:
 __attribute__((btf_decl_tag("..."))) for btf dump in C format
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
References: <20221110144320.1075367-1-eddyz87@gmail.com>
 <20221110144320.1075367-2-eddyz87@gmail.com>
 <CAEf4Bzbnd2UOT9Mko+0Yf9Kgsn-sGsV43MKExYjEaYbWg0WgZg@mail.gmail.com>
 <3d638bd465fb604ef01c1dc5a5a92617b90482d8.camel@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <3d638bd465fb604ef01c1dc5a5a92617b90482d8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3877:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9004c3-6e40-4459-f3aa-08dac74a5d45
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdGKey/jsGG0NX4od8qygklfrovdh2ZbYCIIU8EBEjCbsM5DY5GfuJQOzYrRgpNvJbdlzzDyKFVqmABKx/UO3WySuA3Mr18alrns8bj+F0ATr2J12A0Iby/P2OUD7U5yRMqaqq7bT3Q4Y9gioTJhdsU8k8HPjHvdP2I/QMegZSqjoY6IGCjHMcvdGR9wmH64U3eP2IqDBvVWaktPMdfCdjmJOFdA22/ECEKxHoiexeNYx8W+F862yJEOiy1cO7n+VriGr2u2wTN+rV2tMSm7c66+0K670u4AVXe41mwB5j386krFHeZ3E1viYGegDrjbjLe7MEF8yJ6klhhKHsSOR/UPHM8nEPkGU8QtmBJzkvKv0M0XDmMiBCy+n1ZvcaueHVJUway7Ne3k3/RZtLq+Art50qUr8C1gU23Y/QcAL+jDY5tnwPfJqaLy+5lfeVzh0TGwBYSOLRzl2XanFxd/hEdfj6X5ZMgjQOg5XUg/DDvMTQqUWr8ccsc5vBe7sIhiczi6J6x5Fr/dx3ZTPxuWQxOYaOMlrUWwAcKkICGvPwa6788IkR1QxtNiTeW8PJFwZA81+UE5aTaNUcR+rew2Xruayutx/udEWUmdvp5z9tZBTv+/tkEWfFUp3TVCZxRy7zl403QRGpMQLrhc8+APUY08kdQVJuxaz2s8ixTJwWlfdL1nEaIDYICLY+JY8grUcMhjp+aNfJJRX833jzAHoKAG+xlkRfYz3MQnCIuSH4R0P6cYK9ktw7HMJ3ypjA941zNA3Z4uTsbb/Lz+4gCCFQuyjI16+PKE6VE55SCyYpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(2906002)(4001150100001)(31686004)(66946007)(2616005)(41300700001)(66476007)(66556008)(36756003)(86362001)(31696002)(8936002)(53546011)(38100700002)(110136005)(5660300002)(186003)(8676002)(4326008)(6486002)(6512007)(316002)(6506007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJoV21OS3pxY2hwTVFBRGVReVdUK1N6YlBJNWpPVGpER3QwM3J2ZTFmU0hB?=
 =?utf-8?B?cmRqRDdDMHg5WTQ3MGJIUlpVUElUWG1ja0hIL2p6ZEpJRDF6TGRjNVNMa0NP?=
 =?utf-8?B?RVJaZDFPVlFncmlBRjlYb1laWHdtcUFnM3l5UnFUZ3hIRllDRUhJd3dwc0xn?=
 =?utf-8?B?TGovK0Z4dFlpcVZjblVSb25VazRXZGU4NzdwT1VTckh4T1lYcTROYnZJT0lY?=
 =?utf-8?B?Uk5wNUVJdWhwZzlTdzB4bm9qU1FGTWE5NWxnOFVnNFhyM0tRU1pvWDRPREFo?=
 =?utf-8?B?SjczODd5dUdXOG84YzRmTXk4NUdBNW5aekhsRllXYVZXYUtyeS9vbS8rZjYr?=
 =?utf-8?B?eDZWRFR1aTBvc1NDWU5RbFFmMjhYNXZEd0FZQzJmYk4ybndYVDZ3ZVJ6U3pP?=
 =?utf-8?B?elo0TkpIWUpOY2hXY2NEcGk3YWVmS2ZwbHF2MUYzb29pTmZDUXZRWjFJbjg0?=
 =?utf-8?B?MHlMRWtxN0NRUTRnamFtSkpGM0F2cVMrRG5Nak9XV3VrNlYxTlMxeFpRWGsv?=
 =?utf-8?B?akVFVTJWVEw5NG1BRThvSXNtd0c4dlFTRk1vSkZ3WHhRTHovUEhFQ2xWTVFG?=
 =?utf-8?B?L0o2RExuTG1oQVIvL2s4aTRYcHZqRXhyRGVjaFozTlk4Mmppdlc5aGFwb0hE?=
 =?utf-8?B?eHdBbnJRZVlOSmx0SkZWWldMeFN0SGtrWldVL1dFTUkzR0xJR0QvSEdrUTdi?=
 =?utf-8?B?a2t1RjNFc3FwYi9WUG5nUld3S05KSXlDT2NSNGUveDMxUk1lZlo0TFpOVGhj?=
 =?utf-8?B?M1lmZU1rdk9HaXNUSzNuckw4MUVZOHRJcFdabDRGcGFXK0kvNng5Qy9mU3RX?=
 =?utf-8?B?TW40Y3ROc1VkZlRKbDZKSTd3VTFqV2VvbHM3bXE3Q0l4ZjM5MzNKVVd2czVM?=
 =?utf-8?B?VkVWSTVDNjFFMy9xanhNNFArdnFNbjVpSlh5MVZJaHlZZm9xUkZDc3VBa1Mw?=
 =?utf-8?B?RGx3R3B3QXZyeVpESDl4WDlqbHkyVkpQcjIzUVlGNG9qUG9TZDNxREppdmli?=
 =?utf-8?B?cGxBWVJMdVJueGNLTWtEUVBiY3Y3VS9vZW90UmFTK1AveGN1c013WGErYVNL?=
 =?utf-8?B?S3NydXJua01zS0VnOXVwRjIzRldJaWh5T0dkTU5FSGk2RHZJNi9zaHlCQkFK?=
 =?utf-8?B?NFZHSnl0WTBWL2kzRG85RWJkaUZtWWlMRXpmSXpDZHFlT3VtdHlxeEZ3MUpj?=
 =?utf-8?B?WnladlcxaWRSZGlkUXZOYVZWZWlNVEg2VFFzaHZqVCtNTUpwdklwMktISzV6?=
 =?utf-8?B?SFhMcE5RZGMrME5iSTdsK25ka0prZXdyRzRCbzNSVUVDTnN4akxpWGJML3hX?=
 =?utf-8?B?S0RhdmlhMWEyby9OWEpWOG16MWtxTk1KUndnKzNOQ0d0OUVTb293TmlzTnp0?=
 =?utf-8?B?L010NEVoNFFYekZGYVhEM3dZYk9lUlc4Sy9YbFk1cFZsQkY1UjFSR21FYW5l?=
 =?utf-8?B?T3J4a1FOYTNOam9NZWZDTVE3Y3YvMGZZcjR3VGdpNTU0S0lmMXltQm5QWC9K?=
 =?utf-8?B?QlFTcmh3TitPV0ZSTm5mTUo5ODIvTE04K0xFUXhQTkplYkdsSkFucWdzaGhT?=
 =?utf-8?B?SHpoQm8rWisxR3FuRU5GeW4rVlNNRnpoMUVCemlqQ0tWZTJicGdzcDllK1NO?=
 =?utf-8?B?RXo4bzcvMW5haGF2cVllZEZ6Q3JsSVhDMm9mUVNlTWZ4UllhWEwwcHFCZ0tM?=
 =?utf-8?B?Y3Bqell4NjNsMWZneVNDcTJYUTZVeXVZbmwrdHBYZWJtNGVXRE5lSjRCRVM3?=
 =?utf-8?B?Q2NrU1F5U3Jzbi9HVGMrOVJTNENMMXRpZjR3NVpTU1QzZzhyT2l5bHJ4dGVT?=
 =?utf-8?B?ekNVNnQ0SUlacmJtZmtjbGtOMzRQbTRZWlk3VlRFcXpMU1dFY1lmcER4WEJz?=
 =?utf-8?B?UnJnR1ArN3l2S3g4aSs0YTZCbFNDalJYOHlaZHNPODMrQ3pYTHNoMGFhcXU1?=
 =?utf-8?B?M09vdjZIOFVBSWN0bVd5VTJBTkVXeEkzZlpwbGp1Mnd4NGxTdzVrZFVSd2Rq?=
 =?utf-8?B?azhXQ2l2NHVtY3o3cFVkOHZqaE5vd3dMVWpKODZjc1Q0NkpyZEhjdndNS3Nh?=
 =?utf-8?B?VTZwZFlsWTZnNWxpZUt1dFQreDBBSTRBVlZyY3o5VW1VeTA5WHN2MVdQcm5C?=
 =?utf-8?B?ZWZmYjJCLzNYdWs2Y1orOGRPSFlqakVIYTNqeUczQmVvcFFycUE4eG90V1J5?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9004c3-6e40-4459-f3aa-08dac74a5d45
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:45:43.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A60+namJN71w4txyLXByxK4KbpTL0I4NdYTq05Z2krfurYUw3mhJQconuRqEtSLg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3877
X-Proofpoint-ORIG-GUID: UiQVqs5EcF73pX0R8pru1qtFJxy9lzYZ
X-Proofpoint-GUID: UiQVqs5EcF73pX0R8pru1qtFJxy9lzYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/11/22 1:30 PM, Eduard Zingerman wrote:
> On Fri, 2022-11-11 at 10:58 -0800, Andrii Nakryiko wrote:
>> On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>>
>> [...]
>>
>>>   static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
>>> @@ -1438,9 +1593,12 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>>>                  }
>>>                  case BTF_KIND_FUNC_PROTO: {
>>>                          const struct btf_param *p = btf_params(t);
>>> +                       struct decl_tag_array *decl_tags = NULL;
>>>                          __u16 vlen = btf_vlen(t);
>>>                          int i;
>>>
>>> +                       hashmap__find(d->decl_tags, id, &decl_tags);
>>> +
>>>                          /*
>>>                           * GCC emits extra volatile qualifier for
>>>                           * __attribute__((noreturn)) function pointers. Clang
>>
>> should there be btf_dump_emit_decl_tags(d, decl_tags, -1) somewhere
>> here to emit tags of FUNC_PROTO itself?
> 
> Actually, I have not found a way to attach decl tag to a FUNC_PROTO itself:
> 
>    typedef void (*fn)(void) __decl_tag("..."); // here tag is attached to typedef
>    struct foo {
>      void (*fn)(void) __decl_tag("..."); // here tag is attached to a foo.fn field
>    }
>    void foo(void (*fn)(void) __decl_tag("...")); // here tag is attached to FUNC foo
>                                                  // parameter but should probably
>                                                  // be attached to
>                                                  // FUNC_PROTO parameter instead.
> 
> Also, I think that Yonghong had reservations about decl tags attached to
> FUNC_PROTO parameters.
> Yonghong, could you please comment?

Currently, btf decl tag is not supported to attach FUNC_PROTO 
parameters. We could add support in clang, do we have an actual use case
for this? if there is a use case, we can add support for it.

> 
>>
>>> @@ -1481,6 +1639,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>>>
>>>                                  name = btf_name_of(d, p->name_off);
>>>                                  btf_dump_emit_type_decl(d, p->type, name, lvl);
>>> +                               btf_dump_emit_decl_tags(d, decl_tags, i);
>>>                          }
>>>
>>>                          btf_dump_printf(d, ")");
>>> @@ -1896,6 +2055,7 @@ static int btf_dump_var_data(struct btf_dump *d,
>>>                               const void *data)
>>>   {
>>>          enum btf_func_linkage linkage = btf_var(v)->linkage;
>>> +       struct decl_tag_array *decl_tags = NULL;
>>>          const struct btf_type *t;
>>>          const char *l;
>>>          __u32 type_id;
>>> @@ -1920,7 +2080,10 @@ static int btf_dump_var_data(struct btf_dump *d,
>>>          type_id = v->type;
>>>          t = btf__type_by_id(d->btf, type_id);
>>>          btf_dump_emit_type_cast(d, type_id, false);
>>> -       btf_dump_printf(d, " %s = ", btf_name_of(d, v->name_off));
>>> +       btf_dump_printf(d, " %s", btf_name_of(d, v->name_off));
>>> +       hashmap__find(d->decl_tags, id, &decl_tags);
>>> +       btf_dump_emit_decl_tags(d, decl_tags, -1);
>>> +       btf_dump_printf(d, " = ");
>>>          return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
>>>   }
>>>
>>> @@ -2421,6 +2584,8 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>>>          d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
>>>          d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
>>>
>>> +       btf_dump_assign_decl_tags(d);
>>> +
>>
>> I'm actually not sure we want those tags on binary data dump.
>> Generally data dump is not type definition dump, so this seems
>> unnecessary, it will just distract from data itself. Let's drop it for
>> now? If there would be a need we can add it easily later.
> 
> Well, this is the only place where VARs are processed, removing this code
> would make the second patch in a series useless.
> But I like my second patch in a series :) should I just drop it?
> I can extract it as a separate series and simplify some of the existing
> data dump tests.
> 
>>
>>>          ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
>>>
>>>          d->typed_dump = NULL;
>>> --
>>> 2.34.1
>>>
> 
