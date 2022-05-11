Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC4522888
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 02:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiEKAj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 20:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbiEKAj4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 20:39:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684FB1339D2
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 17:39:52 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B0afbS017827;
        Tue, 10 May 2022 17:39:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=klbhj2mvh8e+Fp48FiXhddo6Yq52085KGCt4ozVi6jI=;
 b=o2Ox5PQOFFsHfn9uyFN7Vl9lMJ3zpTLqkI6DXMJeBpJxIEEAUCrkov1GA1ePt2rFpE0n
 1J2l1KvNAXtzDhUDl0k0ucOBvxwjRdznyQy103iSVTCPSXGVMFkz2eqU0qO2+tjkmI+H
 u2pDmlw9AKQ0vIOBjM/4LrWGsUtAw2rRLhA= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyn47ww7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 17:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmpZIohUIyvbOFSt0suPi1VTXI0qGLf2FscAMgZJnDTI+3Gu6KvivzLN2ZojzHQ2wrGB6lilm0dDADPwjK9hoCbSfz0wlR8Z+f9HC1Ul6xR+uAL70Zwagr+QXih5qWu6JTd2okXBaVs7PNuAFN/OIRTw/0Lpej2o/6oQsN3c/DpkP5yI30TQcQ/CH+2crOpgEVTdC7iS9PB7rKgNmF740znUkZ3hjSr7txgT7b/r5hazQGjSQnAXfthkbSmfwQ8VuUK+s4cRYSxxM8S6prfrONY91qopSQ08kixw7uLRL9KQYF2s2Kk+vWKY8ffK9sxCxRA4/j8etQGjIIV9/xu07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klbhj2mvh8e+Fp48FiXhddo6Yq52085KGCt4ozVi6jI=;
 b=b+wnWQBywRGUwAcVVZ8tp1yZIn3J2yr9PXrNOJdtlGD6qK7fD/fV1+Nu9T2fEW/caYJfo/oQ8sWellbC/ybywe93+Y+MHHhR1o0mLuZuICN1Nc8aTjud2N6Zm6U7wsKFouzwRxfujsyihPKYEc3zjmCS0CBu9JHF/GCuW0y7OxSSk8/dN7IOIKeSr/oQADSNb9bnwkTHKpzVb+vdsH9LdpDeGwF/crGLezMmOwo9Vmfn3AZ2jZlCBf27VOZ5ceqFh+f+BkwZ/D5KnqK0Uf/Oc8GKIJRCKay0vqbQFSMtE3+8Ea60K08w9PEqIdJlN60rarPhyHOn2JI1Z22WoHiQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4406.namprd15.prod.outlook.com (2603:10b6:a03:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 00:39:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Wed, 11 May 2022
 00:39:33 +0000
Message-ID: <132622f3-71ec-61a0-924f-a112fd6f822c@fb.com>
Date:   Tue, 10 May 2022 17:39:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190023.2578209-1-yhs@fb.com>
 <CAEf4BzbXuN4YOYqm_ojgTuJMo4a+J_M6WPF=MUX1B9BK8DdmMQ@mail.gmail.com>
 <f9fa3310-0f63-18af-5424-b82df11c4a70@fb.com>
 <CAEf4BzZg2e5XvE-E7mz9Vss-YJfP8SbuqogpN0837UjshBg8EA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZg2e5XvE-E7mz9Vss-YJfP8SbuqogpN0837UjshBg8EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab73b6d-3db7-4bac-632f-08da32e6b7c6
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4406:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4406CCB43979F8059BF37BA2D3C89@SJ0PR15MB4406.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whqDgALIcvxNeIjnu9aO6Uks8nkJ47CLNx/yP6g0wIFAGu/5G2tyyLGD881BhmGCvaVP2l0ZlT3+MnvHAP/fugFsdqmfNPR1Gic4HICso1p87c8j6/V1zzh6XqaHFS79VPf6uWO4iR4AXHD839u+YTMWHz86AF48Gk2SAyangWXdCikaM4AaYB16vgQ9bsAfJc23AehsR8HvPOGDf4qZhNJz37939qznNH/W3VSyzTKw+u89q3hTWazTa+3hlmOqFcQQ1uaWEceRckeR5gjx+iXBPN0vQLJaB8wXKAbzTSJjBlZ9bFwvXh7Hqpd6EBqL1SBv3vH792haXOFqr6h2ANHDpZ1hH3PaWUKwFsF+ncKZLiRW9ekPpJupGnsSicoSNlyhAg2M7mx31/W2kUgB0zfA4Uu6S0QyxX9ABhs/SDUiJtco2q4brRH0640gBYoLwjOF8+TsERLvmf+ebu2lQuuONp1UUV8OJLpnxwd/Z1Ke8gzAJ6KvqQh0lNxY5JKicUJTrf2dlTsMm1/+QpjWB9ujnZ+mVEjdNqsBy0XTXgZ4dtOoXzIEbR3cB8lyprDUv2KBRfUQtQOP4Ht3bsEObpyyIP2s2aBWzRI1zkLVPb/8RQV4aQZTFmdJLgQxp+IKG9Y8f4Rn/5fDgT3TVIOBl+pXD+25Uf8PobgisVX+SmVscxcwy+F2X23oOzIWruKhUWbrHMyJ5BjIZNfv2bxyAme3Vq7DdabJE2LCrUm/P7zbkCGdEAhqTZdzKK9+hebq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(186003)(5660300002)(66946007)(8676002)(4326008)(6486002)(508600001)(83380400001)(8936002)(52116002)(66556008)(66476007)(2616005)(53546011)(36756003)(6512007)(38100700002)(86362001)(31696002)(316002)(6916009)(2906002)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWc4eitLSG9tbTdkdC9rdUlRZGt2VnJWMzV4bWcyUWRDc3hrRVdmelFhNlNq?=
 =?utf-8?B?YTd6bDQxeTdyVTkrSVVCWkY1RWtoWG1xaG1JSkw2WHNKQTJ6LzBMRnMxY000?=
 =?utf-8?B?c2ZibkxkUkhxaStZNXdpSWpYeGNrR1VBT2dKRURCWlNQLzZBbUg2VlRSazZR?=
 =?utf-8?B?VnRwNFgyS1dRQm1aRGN1RnUrL3NxTitGbW5na2oyMnd4UlBEUHIzbjk5WHkx?=
 =?utf-8?B?clVXMEhZM2NtRWsrV1paSVN1UmJTTUdLWjVMMFJJUEVNaDVOWDhVcmZkRDBy?=
 =?utf-8?B?WThJVXB2Yjc0ZDFaem1NZ0dyNWlSUjFHajk2Zm11UlJTWFpjWHFrYk1nVTJX?=
 =?utf-8?B?N0dlT0Y4RTh6ZHlLSG5tOWp4QUZucEx4R2FFbVp6K2FtcTFrdXdTbVpmSENa?=
 =?utf-8?B?R3lHOWpRMVY4c1VlMEFjQ2RyZWpsTjdLVDd4OWVhK2ovb1NxSjc2SnppUHdW?=
 =?utf-8?B?US9CQmVaLzNOY1VXZUhNNG9OY2ovcFY0TW5uMEdRQWtLaXRLVC9sUmRGdmtC?=
 =?utf-8?B?Ty9aZm9TaTNwMTN6VlA4d3JucUVoNDFNaVV5NGExcG1FUEVUMVFKS2V3aXpv?=
 =?utf-8?B?alIrZnN6ZExNSDJEUjNCSDdXNXJicEdTZ2VYQVhScThTRTRMOW1QV2ZVTFZ4?=
 =?utf-8?B?T2lRbkV5OHJMeWRHUU1BdDltSC9wSVVLUXhjL0RPS09BNktNb3R2Y3dxUXMw?=
 =?utf-8?B?aDdhem9yNGVIY0cwL3VKMldyOVpBbEliT09CdnBTVS9yeG1Ia0hnazV5MThN?=
 =?utf-8?B?bnM4ZnR0YWJ1QjFtT1k4T3orR1JhQlA4aktzaGhBWUZrQVdacERkMzFmcEt4?=
 =?utf-8?B?SXhkTitTU3BkNkh1a2hYVHJSV2FMV09Obi94NUlrUFdLM3RMSFQvOTNTRzVj?=
 =?utf-8?B?S09oUzZrejVjTUdVNU9TYWtVY1BsN3J1czAzdFhBdmJjRFk2cDAyOUJOTlB2?=
 =?utf-8?B?VjZoK1hnSm1aMW1kc1prRXdwd1BScGFCZUpmeUVJOUswSUF0bld4bnNuZ2lP?=
 =?utf-8?B?Yi9XUDF6Qms1b0FRdzY5b3pNZndPb05nTkswam1zYU9KZDUzNW9rdk04bklP?=
 =?utf-8?B?aVExR082NkNtd3RTMzZTdS9QUzlmWWwzYUlaeU5Gb2JoU1NkNzl2R1pLdnZP?=
 =?utf-8?B?Wi9NY3RNVlRZcUhFZWVZaXY1L2psRnFORWRXRGFuQWxjdFVFMkxTWXNjOFdm?=
 =?utf-8?B?cEZlWnF6VjkyenZNd2VQZS9hREFGaEFNclpQZk1pNDJoaFZsaVF1bHBRcnNU?=
 =?utf-8?B?NEppWCtGclFKM3dHOHdveGZpakFGNzNwYW0vTm03U1lYNVZQWFgrQ1NSOExr?=
 =?utf-8?B?U1ozdWZEWEhFTjZtaUV4NXFmRWt4cFpUTnFRcjhkYU9nckt2RHhBWG9XbUl1?=
 =?utf-8?B?eHE4WlRMaFdMMi9kazk1emxac0N2ZExTaXUvVGpKREZRQnhEckNQNnVoaEht?=
 =?utf-8?B?YTYxSStwOHlsWHdTWU9uZFlQcjZlV3MrQzBxM1FNZkNFZ0NFSDNDbWdWcG1q?=
 =?utf-8?B?SGRwbmZMK2tDek5UV0xqY1MvK0t6czh2eUF6SFlVWWZKY2VVOXZIVmpXRHg2?=
 =?utf-8?B?aXN1Z240WHpjTXkySDM3VjZTNzVmMy9wL0VIV2srMkljSDU2U28yTDhTQ0lx?=
 =?utf-8?B?SjBReENMSW90clJQRk9iVzZKQklrN2d2NnBjMmdaWVBWS05wZVBKcm1mMjly?=
 =?utf-8?B?RlNmSW9UNUVNaXowZDRPL3JEUVNlTUlZYUNHNVQxZ3FCYVpQODdVTXZxVUhO?=
 =?utf-8?B?WXZWNkZnWnhFWTc2OUJ6OU1BbVJ3YVlMMDFKalh4K2JlMFN2Z2JQckJiRk0r?=
 =?utf-8?B?Z0dxVVlWQjJCZjRiMjdjWFhCaDZUNnZ4NUNXdHJscVFNdGZXc1B2YmxWVVdF?=
 =?utf-8?B?VTZubGNlZlV6dW1pOVJGU2k5WmdKSFNxOThQdlFzelVRZVJKZy9hN0VFMXZz?=
 =?utf-8?B?QmoxbXM5bHNOd3lYa1NKK0V0TU5vdG5mRlExcWJ6TklxaTlsRnZVV3NicitW?=
 =?utf-8?B?NHBHNWg0Zm1taVV5cXB1S3NRRE1uWmFwK0lqZlZjSEZ3U3dVbmRLWDJhY1o4?=
 =?utf-8?B?UXYzbEt3WVlKeHA0Unc5TVFhQXhxWVJMcUdkNkNIMXJUV09IeEJoVW5qd0RT?=
 =?utf-8?B?dlJoTFRnVlcyRTY5OHllaDR2aFZFY1RFVDByb2xYZmRWbzJWOUtLYzVoR3F6?=
 =?utf-8?B?dzhTdUxtSWNmRUZMTURzS0dtTlUzRDlEUXZxd2xYTSswWWFBdE5RZTVCdVNX?=
 =?utf-8?B?UnhRdTNyUUplUEVmSlRkZDBZT09sYlFWSldua2ZtOFNLTGc3eDg5bVVxcVVD?=
 =?utf-8?B?dVNRZ1AyL0lHMHp4aUVlSU12aE5qT3p6V3hXQTgrQ3RQS3AvV09SamE0WUhl?=
 =?utf-8?Q?pXFWBbrD+oB1e9rY=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab73b6d-3db7-4bac-632f-08da32e6b7c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 00:39:33.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HU0l35iAZr1Utjs0Pa+PPTd8mPyOpcAkuCHHOnXF/30dxuchJHePFanG3j/YewS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4406
X-Proofpoint-ORIG-GUID: 2J7EcSqXhdnnT1EUQnKXQYGQ4FsD53o7
X-Proofpoint-GUID: 2J7EcSqXhdnnT1EUQnKXQYGQ4FsD53o7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/10/22 4:38 PM, Andrii Nakryiko wrote:
> On Tue, May 10, 2022 at 3:40 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 5/9/22 4:25 PM, Andrii Nakryiko wrote:
>>> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> Add BTF_KIND_ENUM64 support. Deprecated btf__add_enum() and
>>>> btf__add_enum_value() and introduced the following new APIs
>>>>     btf__add_enum32()
>>>>     btf__add_enum32_value()
>>>>     btf__add_enum64()
>>>>     btf__add_enum64_value()
>>>> due to new kind and introduction of kflag.
>>>>
>>>> To support old kernel with enum64, the sanitization is
>>>> added to replace BTF_KIND_ENUM64 with a bunch of
>>>> pointer-to-void types.
>>>>
>>>> The enum64 value relocation is also supported. The enum64
>>>> forward resolution, with enum type as forward declaration
>>>> and enum64 as the actual definition, is also supported.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
>>>>    tools/lib/bpf/btf.h                           |  21 ++
>>>>    tools/lib/bpf/btf_dump.c                      |  94 ++++++--
>>>>    tools/lib/bpf/libbpf.c                        |  64 ++++-
>>>>    tools/lib/bpf/libbpf.map                      |   4 +
>>>>    tools/lib/bpf/libbpf_internal.h               |   2 +
>>>>    tools/lib/bpf/linker.c                        |   2 +
>>>>    tools/lib/bpf/relo_core.c                     |  93 ++++---
>>>>    .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
>>>>    .../selftests/bpf/prog_tests/btf_write.c      |   6 +-
>>>>    10 files changed, 450 insertions(+), 72 deletions(-)
>>>>
>>>
> 
> [...]
> 
>>>
>>>
>>>> +       t->size = tsize;
>>>> +
>>>> +       return btf_commit_type(btf, sz);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Append new BTF_KIND_ENUM type with:
>>>> + *   - *name* - name of the enum, can be NULL or empty for anonymous enums;
>>>> + *   - *is_unsigned* - whether the enum values are unsigned or not;
>>>> + *
>>>> + * Enum initially has no enum values in it (and corresponds to enum forward
>>>> + * declaration). Enumerator values can be added by btf__add_enum64_value()
>>>> + * immediately after btf__add_enum() succeeds.
>>>> + *
>>>> + * Returns:
>>>> + *   - >0, type ID of newly added BTF type;
>>>> + *   - <0, on error.
>>>> + */
>>>> +int btf__add_enum32(struct btf *btf, const char *name, bool is_unsigned)
>>>
>>> given it's still BTF_KIND_ENUM in UAPI, let's keep 32-bit ones as just
>>> btf__add_enum()/btf__add_enum_value() and not deprecate anything.
>>> ENUM64 can be thought about as more of a special case, so I think it's
>>> ok.
>>
>> The current btf__add_enum api:
>> LIBBPF_API int btf__add_enum(struct btf *btf, const char *name, __u32
>> bytes_sz);
>>
>> The issue is it doesn't have signedness parameter. if the user input
>> is
>>      enum { A = -1, B = 0, C = 1 };
>> the actual printout btf format will be
>>      enum { A 4294967295, B = 0, C = 1}
>> does not match the original source.
> 
> Oh, I didn't realize that's the reason. I still like btf__add_enum()
> name much better, can you please do the same macro trick that I did
> for bpf_prog_load() based on the number of arguments? We'll be able to
> preserve good API name and add extra argument. Once this lands we'll
> need to update pahole to added signedness bit, but otherwise I don't
> think there are many other users of these APIs currently (I might be
> wrong, but macro magic gives us backwards compat anyway).
> 
>>
>>>
>>>> +{
>>>> +       return btf_add_enum_common(btf, name, is_unsigned, BTF_KIND_ENUM, 4);
>>>> +}
>>>> +
>>>
>>> [...]
>>>
>>>>    /*
> 
> [...]
> 
>>>> @@ -764,8 +792,13 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>>>>                   if (!spec)
>>>>                           return -EUCLEAN; /* request instruction poisoning */
>>>>                   t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
>>>> -               e = btf_enum(t) + spec->spec[0].idx;
>>>> -               *val = e->val;
>>>> +               if (btf_is_enum(t)) {
>>>> +                       e = btf_enum(t) + spec->spec[0].idx;
>>>> +                       *val = e->val;
>>>> +               } else {
>>>> +                       e64 = btf_enum64(t) + spec->spec[0].idx;
>>>> +                       *val = btf_enum64_value(e64);
>>>> +               }
>>>
>>> I think with sign bit we now have further complication: for 32-bit
>>> enums we need to sign extend 32-bit values to s64 and then cast as
>>> u64, no? Seems like a helper to abstract that is good to have here.
>>> Otherwise relocating enum ABC { D = -1 } will produce invalid ldimm64
>>> instruction, right?
>>
>> We should be fine here. For enum32, we have
>> struct btf_enum {
>>           __u32   name_off;
>>           __s32   val;
>> };
>> So above *val = e->val will first sign extend from __s32 to __s64
>> and then the __u64. Let me have a helper with additional comments
>> to make it clear.
>>
> 
> Ok, great! Let's just shorten this as I suggested below?

The
 >>> *val = btf_is_enum(t)
 >>>       ? btf_enum(t)[spec->spec[0].idx]
 >>>       : btf_enum64(t)[spec->spec[0].idx];
won't work, but the following should work:
    *val = btf_is_enum(t)
	? btf_enum(t)[spec->spec[0].idx].val
	: btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
> 
>>>
>>> Also keep in mind that you can use btf_enum()/btf_enum64() as an
>>> array, so above you can write just as
>>>
>>> *val = btf_is_enum(t)
>>>       ? btf_enum(t)[spec->spec[0].idx]
>>>       : btf_enum64(t)[spec->spec[0].idx];
>>>
>>> But we need sign check and extension, so better to have a separate helper.
>>>
>>>>                   break;
>>>>           default:
>>>>                   return -EOPNOTSUPP;
>>>> @@ -1034,7 +1067,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>>>                   }
>>>>
>>>>                   insn[0].imm = new_val;
>>>> -               insn[1].imm = 0; /* currently only 32-bit values are supported */
>>>> +               insn[1].imm = new_val >> 32;
>>>
>>> for 32-bit instructions (ALU/ALU32, etc) we need to make sure that
>>> new_val fits in 32 bits. And we need to be careful about
>>> signed/unsigned, because for signed case all-zero or all-one upper 32
>>> bits are ok (sign extension). Can we know the expected signed/unsigned
>>> operation from bpf_insn itself? We should be, right?
>>
>> The core relocation insn for constant is
>>     move r1, <32bit value>
>> or
>>     ldimm_64 r1, <64bit value>
>> and there are no signedness information.
>> So the 64bit value (except sign extension) can only from
>> ldimm_64. We should be okay here, but I can double check.
> 
> not sure how full 64-bit -1 should be loaded into register then. Does
> compiler generate extra sign-extending bit shifts or embedded constant
> is considered to be a signed constant always?

For ldimm64 r1, -1,
the first insn imm will be 0xffffffff, and the second insn will also be 
0xffffffff. The final value will be
   ((u64)(u32)0xffffffff << 32) | (u32)0xffffffff


> 
>>
>>>
>>>>                   pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
>>>>                            prog_name, relo_idx, insn_idx,
>>>>                            (unsigned long long)imm, new_val);
>>>> @@ -1056,6 +1089,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>>>     */
> 
> [...]
