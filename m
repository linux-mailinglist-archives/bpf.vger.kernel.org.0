Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C552565CCD5
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 07:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjADGLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 01:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjADGLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 01:11:30 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79606183A7;
        Tue,  3 Jan 2023 22:11:29 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30439H41008817;
        Tue, 3 Jan 2023 22:10:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=f7simt8WRmTUyX8sHV1Qpa0eVT14IKBzyvi43ZJ1JvA=;
 b=iQzPR08aQugllCg5hK0gJ7AgakhLuF9IFuUxdphsCq7HurftSV5y32zQl/YFY/VbAovE
 +LpVsWWUMuhzUbL7nvEeH+ZkzNBPGrcCFK6+H+uWYmXm9N4He8ZZWcjm8Snmz0qd7KwX
 ptLtAQEsL2GkOLQh5SsBHDD97Og/RlG3CDl9h2VLs5VZ5UHth6MG9YaMFjc2heWXKWzc
 5IHQ+ZpavCDBJ2kq383TORxlUKKYiAj8BT6FsqsN555ngKnz6j6I4W+7jw+O8oBp7Aoj
 YIGCg2ZLFtcy2DWkGRNPgxyNahzZN8LLzYxLFcsc+thi8pDbWqUbQ5ai04v72/uPCUdQ 0g== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mvkt8f1vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 22:10:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx+2AZg+7UuvTjPNaMGWq0gNo0Q87UC4EWmW95o8m+C6RfV6UVJ7dOyLWC5fz4Z419MfXylgqSwILeEbT9CL2XSXuyHiwJ/ijW5X7L3yWUWDttO8ieehof1GmTMN9bK5OGGOtXD2b8RoLb9mIyRyP4crt9b7GXrUihav0PG763QpfgdfNrf2ArkywtffibqmpEsBkfp9IFyh6QKW4lcMpNKoPSdP08OtUC1AUCNLbJSvkDJhG4Nn6zvEnpg3lf7KeaORpd81mpiM9TBplQrWo4sJ7q2eGQlQFrGJYzoojFHLcZjMPhYqq+5J5GFizvaOPH8dKRkHAZroA7dpRPEcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7simt8WRmTUyX8sHV1Qpa0eVT14IKBzyvi43ZJ1JvA=;
 b=VjixqBQDPyj70+/LZynVvxaXWHgFh0f1/uXdOZhPKQ0PnN8mMJxqJOYCaE5suHLcKQY8ZtLOO6n6n8cWv+/fOFcLQq3uQwz12/G+2ZvRO3YPz/yXr7PuMoOt8rd+4k8yzx0p2wafPFhQYejaNMI85woS3QCtBWtlMzYRpXaHgvHMuIF4Ld4LWRN33j/fYcmgiSarEmR/fnsSFITyepB1LK3RsfLFMDxt/JJWFhcOmoAvGfSr59yQABp30k3zP9mRT/u72ninjzEdFc5Jo+BtgaFLpgrOWhowexo8K2stkWYkcyuAOaD/etHx8I67fbt+28ncjyJHmFtiZCJddRpZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4782.namprd15.prod.outlook.com (2603:10b6:510:8b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 06:10:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 06:10:38 +0000
Message-ID: <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
Date:   Tue, 3 Jan 2023 22:10:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a540cf6-105c-4798-c2ed-08daee1a6666
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wmb6FqpqRf4eDEsYLbMvMeFkP8XMHKpoZUFqwIfnMBwB3xmuMIRCAG9pqy4l8bsfBtlmaBMRxqkuY2CRr3NY7/kaxwGjqpnJE5KHLUt/owuVX2nhTa7UZZ8bN+Sxo3DffDCPVMdupSjdsdwOJi7sNUZLnTM2FdnIWvJA2qumjzHzXwgnuprPs+sDG9ZPVgzzFILjS3QbjRRuWE23vTmEAtuRO+4wvjdfmKhNPn38PGu8Ka5PaGp5afWj7vBEKyALEVuSvAUV9Qe4ISCIxWWFFRjImqG+tNQWMKzfGpasxnyBNRoiGGKHgBUzlgh1XBZ6RYPA/eKKks9i3bgQQkrCcdWPPluyAUskCsnL9mpGd5lDklIC5UTUGsMFR0EIsWuJ7yHFfLIA/Pt9LAdV18JRoOlTGcMsEbWMaP63WbJM5JIAu22OD/DI7EDrVVAX7rZufkpbYuDowAXRWsK4IZpeqnfk8GPse9qr+fSVR+NGjqtUiGiXDODpUe8SgecvuzRDpCuCaCV9bV7FLA7vepJsWZ+Nuvb+k0jWBk6OSG5SLYaXkb+PuvFZAWFir9IXfZ02pfLrHvp8VYjAxyJ45uijcOMkRmT+cPcqAnR59ETUh+WaWYovapiMIz7hVepHSMc1uWhPzW+TuWigKimh6eOtmC3dbMhPsmXwNdPWM68SmXMeoxns7XriqA5nvB/hkEOzNU5FrZStlnPM1udX2UdkOKZ0lRPgZZkrKbmJx6ZwhUbSxgBn1CEqRBs1h9gFbzo5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(83380400001)(6512007)(53546011)(2616005)(186003)(6666004)(6506007)(31696002)(86362001)(36756003)(38100700002)(478600001)(8676002)(4326008)(41300700001)(2906002)(7416002)(5660300002)(8936002)(966005)(66476007)(6486002)(31686004)(66946007)(316002)(110136005)(66556008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVhyQU5zS0NnOVdOcm9ZeHdMUFlpTGg1a3FyT2xSbDVHT1VIaFFEeHNzWUMw?=
 =?utf-8?B?RUJyamRUTHlGc0xkZFZRV0p2d09qaVgwem1QdGJWMSt0REV5dDVFMGIydFA2?=
 =?utf-8?B?MTBZcFZxa1RGWHBXUitXRDI5dEFvdWRiQ3MrL2pTaHN5RTgzMmErQ25QN2tH?=
 =?utf-8?B?VkFNZFpVdytic3VXNDZlOEh3Wm9IU1pwQmpMOXVCQ0ROaHh1N0MyTDQ0K0NI?=
 =?utf-8?B?MDY3dGExbDlJMmF1ZGNnK2F4TVFLRjRkenI0RmlCTFo3U0NRMGNLS3JrUGZx?=
 =?utf-8?B?RVQ5MjJ2YmtQOURuNjdtbVB5TXQvOVhYeElKdS9PMXovNHorVWpES1FRVzRX?=
 =?utf-8?B?Z0hub2ZNMzVZcDJQV0N0TGFmZy9kS25WVmw1Q3NmNFJtL3NKTVlhSWI1Qk9q?=
 =?utf-8?B?YW1TVmFiZzdRTmZ2WmVydEhTMlQ5RlBHdUFVbWF2VEFKejhoQVQ1NXpYTDNM?=
 =?utf-8?B?azcxd3JQYy90UU5RcHdwRmZ4bkRvNkNDT1RvWjBYWjg0UVZiM1pYOVViaS9C?=
 =?utf-8?B?TlFqaGZ1dE9UQUg0TUhXSld0M0Z3ZWhDN2ROM3hxcFFzRW9ZcUhLcHlIQWxa?=
 =?utf-8?B?RFlxTTNteWk2bDZzdk5zaERObU05R0p2elNESThaVUN5RGpUOVFWS3NOVjlU?=
 =?utf-8?B?Z3FHZWdhVlIxTUk3OU5kQnpDMGRTUTRuU2hvWSt3TkpwSnQ2WlFwZGU5WmpK?=
 =?utf-8?B?NVFLZGt3WjVQaWVYQnd3M1hhZHRTdGdQNk1OQ0MyUUg5R0U1NzRBbklzb3E0?=
 =?utf-8?B?TVZzdXZ0eW9wbTM2TkdGelVOMjAzWk9KM3cxZFY4aXZMY1pndDFUZ3IzZjRM?=
 =?utf-8?B?YWFhR3BnRVlHYmlSM1kyNjBjWFVkdzNsWHhzTmh1SFpUclNnNXQ0RllMeGZa?=
 =?utf-8?B?dVduWW02T2w1blJnRkorVWI2bVFQSTlUbDR6VGt2Qi8rWWVhWVVrOG1hQXhO?=
 =?utf-8?B?bWVyM1VlNTNsVk9PM1dpOHF3Z2NZVmJUSnBSRDdVd0JlcjZTYUZQVXBkSGdB?=
 =?utf-8?B?M1RPUCt1Vnc4Yzl3QndZZ0x1QldCVVNrMU41aHIyM2lZZDZibEJvR1ZqUEF4?=
 =?utf-8?B?dHRpZEY4elJsZ2tlUytNc0x6SHlvMkY3bHhLWmpVOU82UUJPTHNyazZlRFBn?=
 =?utf-8?B?VWZPaTVML2lBdWpZelZDeHhkYTI2SHVtN29DYWF2UnZ5QW1kQ0hONXRkeVRV?=
 =?utf-8?B?MTZ2UjZpa2xBeG5GUjRxRXVGeFFWZXpOdWdETkpwcHJhNzNJOW85eUdqeUxj?=
 =?utf-8?B?U3NvRVMxcFNHVmE5UlBOcWE4WlFKRTN6QjNoVzYzck1xWEQzSUhXVW0xNkla?=
 =?utf-8?B?SjJJUEVQcUVGMTNEcU13RDZLSTlHNGZld1NhQzZZTXZPd3BqdFQvaTYrN0hK?=
 =?utf-8?B?MjdlKzg2YW9vWEVVZmpOYy9BSFE2YVNnRjNoZ0hzNFZ5SzdZU0J1d0ZqV3Zi?=
 =?utf-8?B?eUZuSDZLQzRjZHg3aXJFSXE3Q3NENDQxclNFenRHQWd0dXk3OXhaSk9WUEt2?=
 =?utf-8?B?OEZCNytDaHNvUlhhbnk3VmhqRzVyVTdmTjYyZjgrQ0JPbTNqZ2puNUh6NFQr?=
 =?utf-8?B?dzlwVENrQVhadEtVcXhCY1c2TGV4Y0xPS3llWThRQ1N0c2NTSW8rZ1lzZVhZ?=
 =?utf-8?B?SVVqVjJyeXBRTmVaU2NuMmtibjAvNEQwcVg5UEIxUFpBWE9iWlhnZ2dJbjc2?=
 =?utf-8?B?NnR1OG14RTlqbEtXL3l3VFF2cGh2V2N2MmNDckdWaVJQUGxhNzNwdWgyRjFB?=
 =?utf-8?B?eGF4Qjd6NDc0cTlhVmhDdzV4RzVwSm04WUh5ZWNoR0ZOemtGZGcvVDY1QVpi?=
 =?utf-8?B?cFU0Y0k5Wnh0aGRQNjVkMEtYdDl2VWljclBIY0o2UDZjVlZBNDBCSUxqU2NY?=
 =?utf-8?B?STVBZVJTM1NrUVhwQk5qbGpHWFZSS2p4S0dlejBXRkNJM3BsNFBlaHFhN1FN?=
 =?utf-8?B?ZmZ4VmRVVzNtUm9pamMvUCt6UnpIcTBSM01ubGo3RnlVQk00bFMrbitncGJO?=
 =?utf-8?B?dWZiOTNsUnVENWpyNXBRVXY2N1BvOTQwZ29GRGF1UDB5TmtXUWVZbTlwN2xx?=
 =?utf-8?B?YWVvb1k1bGhPcEY4UU9ncnRES2pUMXBXeFR2bXM2NElCV0lTU0FzcW11M1Jo?=
 =?utf-8?B?TDJLVDlmWllXaFprVGcvdmVYa2p2a0VDVDBNSUYrZGJ4K2ROQUY1TStDeHhG?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a540cf6-105c-4798-c2ed-08daee1a6666
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 06:10:38.2167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM+ZyDsWluSHKJFRlwSZ9AwBuSVXdgZHIRTAtKVbfxmFfBml0a5KN2gkSoGl74lq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4782
X-Proofpoint-ORIG-GUID: 4Dq4U-fu1mf7ySlQWNun3wiLeCUE4Z-v
X-Proofpoint-GUID: 4Dq4U-fu1mf7ySlQWNun3wiLeCUE4Z-v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_02,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/3/23 5:47 AM, Hou Tao wrote:
> Hi,
> 
> On 1/2/2023 2:48 AM, Yonghong Song wrote:
>>
>>
>> On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
>>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Hi,
>>>>
>>>> The patchset tries to fix the problems found when checking how htab map
>>>> handles element reuse in bpf memory allocator. The immediate reuse of
>>>> freed elements may lead to two problems in htab map:
>>>>
>>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>>>>       htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>>>>       flag which acquires bpf-spin-lock during value copying. The
>>>>       corruption of bpf-spin-lock may result in hard lock-up.
>>>> (2) lookup procedure may get incorrect map value if the found element is
>>>>       freed and then reused.
>>>>
>>>> Because the type of htab map elements are the same, so problem #1 can be
>>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
>>>> these special fields in map element only when the map element is newly
>>>> allocated. If it is just a reused element, there will be no
>>>> reinitialization.
>>>
>>> Instead of adding the overhead of ctor callback let's just
>>> add __GFP_ZERO to flags in __alloc().
>>> That will address the issue 1 and will make bpf_mem_alloc behave just
>>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
>>> will behave the same way.
>>
>> Patch https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/
>> tried to address a similar issue for lru hash table.
>> Maybe we need to do similar things after bpf_mem_cache_alloc() for
>> hash table?
> IMO ctor or __GFP_ZERO will fix the issue. Did I miss something here ?

The following is my understanding:
in function alloc_htab_elem() (hashtab.c), we have

                 if (is_map_full(htab))
                         if (!old_elem)
                                 /* when map is full and update() is 
replacing
                                  * old element, it's ok to allocate, since
                                  * old element will be freed immediately.
                                  * Otherwise return an error
                                  */
                                 return ERR_PTR(-E2BIG);
                 inc_elem_count(htab);
                 l_new = bpf_mem_cache_alloc(&htab->ma);
                 if (!l_new) {
                         l_new = ERR_PTR(-ENOMEM);
                         goto dec_count;
                 }
                 check_and_init_map_value(&htab->map,
                                          l_new->key + 
round_up(key_size, 8));

In the above check_and_init_map_value() intends to do initializing
for an element from bpf_mem_cache_alloc (could be reused from the free 
list).

The check_and_init_map_value() looks like below (in include/linux/bpf.h)

static inline void bpf_obj_init(const struct btf_field_offs *foffs, void 
*obj)
{
         int i;

         if (!foffs)
                 return;
         for (i = 0; i < foffs->cnt; i++)
                 memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
}

static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
{
         bpf_obj_init(map->field_offs, dst);
}

IIUC, bpf_obj_init() will bzero those fields like spin_lock, timer,
list_head, list_node, etc.

This is the problem for above problem #1.
Maybe I missed something?

>>
>>
>>>
>>>> Problem #2 exists for both non-preallocated and preallocated htab map.
>>>> By adding seq in htab element, doing reuse check and retrying the
>>>> lookup procedure may be a feasible solution, but it will make the
>>>> lookup API being hard to use, because the user needs to check whether
>>>> the found element is reused or not and repeat the lookup procedure if it
>>>> is reused. A simpler solution would be just disabling freed elements
>>>> reuse and freeing these elements after lookup procedure ends.
>>>
>>> You've proposed this 'solution' twice already in qptrie thread and both
>>> times the answer was 'no, we cannot do this' with reasons explained.
>>> The 3rd time the answer is still the same.
>>> This 'issue 2' existed in hashmap since very beginning for many years.
>>> It's a known quirk. There is nothing to fix really.
>>>
>>> The graph apis (aka new gen data structs) with link list and rbtree are
>>> in active development. Soon bpf progs will be able to implement their own
>>> hash maps with explicit bpf_rcu_read_lock. At that time the progs will
>>> be making the trade off between performance and lookup/delete race.
>>> So please respin with just __GFP_ZERO and update the patch 6
>>> to check for lockup only.
> 
