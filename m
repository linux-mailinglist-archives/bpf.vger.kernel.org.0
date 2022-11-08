Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B678562175A
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiKHOu4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiKHOuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:50:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB1FF16;
        Tue,  8 Nov 2022 06:50:53 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A8BCpMe005338;
        Tue, 8 Nov 2022 06:50:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9e5ut30CaEr9JaNpyc20uzFNMKLHpwGCUi3H3l0NAuQ=;
 b=cHRGPWgdOa1kxZjsdHOTkrra2l4G6DxJwdizhQWuMwsBEI/nvwcOdfVhJH48wv1SkaC3
 OQXiGHn7tRcHWtAZDp2Np42UlBdzT7unwRxsuIMMY8ez3i6b4JJaXvkWmM4grknRG0Li
 NoEH3a5IBMlmJ6kjh78X/+EZx7lAhU7jjIA06iuD6IDZk+C/WpYCC+4SDcLMr/thHAeH
 y5N7nyOD1SLSGusPsF+QWcP3GFyFZcvQtrPiGNF9nqqx9ostNKQiddsZwSlLPw2jHH3z
 JGUdCJsu0r8FVKbc9pMv8el+sCkCk2RI01omIodzVBrU37NG7Vfs2rnO1A7FcU2KbNTG Tw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kqp1mhk8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 06:50:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTq9Ja6WEmmWn916BxkyVVxtbMU0WMLz799Wktz+cuK0jF/HhuNh8q/UFHSkzSzWa38lS6nzEk+KrIIJCCXJZFLJdc2O+t6mteeBjT6blFaYW9opW5leqxmBBssH/sfSojYIXLE0pTnHzvdBp0aULd7X5GEq2xuLMJlpAj3CFpcOf8P2uxV4xhYePRnNjrQRncCpvtlWSpNepZAXYp8a+aQWyBS5swcsfPEIDpffmlsp4JFvGpP4fkjWtUBfIOxdu+8g/HoX1OT4nsOgp6kBlYPEXl2bBjQWPWFwWxsF6y0epaHAYEj9zQTJ2GuX9Rjj9dJtAVLUkZhAe/KCEBVMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9e5ut30CaEr9JaNpyc20uzFNMKLHpwGCUi3H3l0NAuQ=;
 b=JlCwp8tEgPPrM8FvnQTMCOjojC2zKf1catt+xXpRv/vtW7SYzmP2jrATBFuDHU99U3QRyNJcJIWvnK21uAo6mFHrND9lFKy9RA0Rt86rL6Ula0n4/SppXVQJN8bZv/Q0cwrWcEpHzpNwV9NtNGUicAIFSEXBEc4TT/tRG89yhVt+ji+/2HTuIZ+x6TBx1PE19Z+8AQeMins7TfJQai0Hv82Rv3V/ij8ABdcbUIrnj0vHh1RNOs4dygUlFsAUwrtfKyujULRNJjdw1sOlf00puvEJswTP91fUrEOmFHMw894oMA5XWASjaZn/tLckGEshJb2gsFDsIvDzTTYVugfUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4160.namprd15.prod.outlook.com (2603:10b6:806:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 14:50:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 14:50:32 +0000
Message-ID: <748785d7-e5ff-eb84-c44e-440339b9eb0b@meta.com>
Date:   Tue, 8 Nov 2022 06:50:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3] docs/bpf: Document BPF map types QUEUE and STACK
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221108093314.44851-1-donald.hunter@gmail.com>
 <Y2pSMo6zKm/JT1ok@debian.me>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y2pSMo6zKm/JT1ok@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN7PR15MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: d27d7f03-f654-4b7f-774f-08dac1989651
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpC2jZtgfO8Zvg+FHbMQvJ4EL84g/f68Jr7J7HtKGLpgivS7U02qRkAANLrsVz27bKy0wJhDms4SrUtybnpZmLAeKY84e6BPsggUJ+C2l5kwdIja1M9QmjuKzGaGxQiYIy3OezKMxrfB1+DzR00qzIhG0Tt0z7acpBraTpH/ntn9njvO7FiO2j18BO+CZuUxiJKNIUvFd8Mn+FnPx1KaZ9OqdSxzrayY2SQL+M6jo0lplZP2gjDAsRqpHfwpGFrp4uyKDz01oAW4MZd9olrYMR52CBO0U73+PAQHO8pnJKzDwztF5MJ+p9gGfmpgT0tAk9gvTMBH3sZ+GzUh5FjWU4jE+0ky6xPIboFU3jIMgGCeY1ONfW2UpslLT3dZKNxLYD9jupW1V7x0HzWI4OzwnzHdI7haIcEHXs4j+iig6NedIDFNLmabxqJyW7bUNNzMo+qSVfaQINgPyP3HRoR30Xg3dCGVO+wq0v7QMt8Hc9RfNpFhF8RaGzwQEJBa4CZf83hdGtXidZJ3+xjwZuEZPQrxtXglmUl4PPTPmju26MagjXh8dUgmQ8QmWlmTFM68iJnQ7MhZ5RKNDOP51cUJkWyzQty5Aj47D8xitf/YYLbDHR4Kb7qxNPTzrH6BNB5g3lGZoKr0EBRiwBOuD1FKHBGM15xg4fw412gS59jb8ijBRPYZ26ykilQXKFL4U34heKSY3hxHl+6ig9FgxCYt8EmPAggQzZY3R/SM409fA/KBjocn/VSUZM2PCXFkz/KfAvA/46+Q90QKYQqvXugGcq8rOkR++Bj48FLnFe3Z4DkH/uixEf0iFCvTCTVZ8Kib+89oE25ORq2Q+T/AUwFEAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(2616005)(6666004)(38100700002)(186003)(6512007)(53546011)(6506007)(83380400001)(2906002)(110136005)(316002)(478600001)(54906003)(6486002)(5660300002)(41300700001)(4326008)(966005)(8936002)(66946007)(66556008)(66476007)(8676002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZXemYwc0poeHlaK05hcVR6TUI5Mjl5dG82WlEwM2JkYi81RTFUbkJpVlpJ?=
 =?utf-8?B?eTBNeUpMSS9PNlBmRE5COE03akF6b0d1SVYvL3IxbU9lZWdJdEl3SHArV3dT?=
 =?utf-8?B?TVd5Nm92L2FYV1ROaytQQ1FSREtnUnpML1ltNGhaano1S2d5dVBOS21kQVF5?=
 =?utf-8?B?K1dxS1hLTEtXNjRZajJkSWQ2cVVydkVnQ0hFRnhzUktTd2l1VGdOMDJlR0M0?=
 =?utf-8?B?WFhZVTNXY2RDZ3h4MkZQTEtCYk1mZXpYR2FjLzRObHhwTDhEU0o1MVNFRFhC?=
 =?utf-8?B?SDBuNUwyZXBXNW1NQy9VMGdXbTE0ZmYzSkIxaDZKd0hxRVB4dW9udjBmUTVh?=
 =?utf-8?B?MU1aMDdaZ2VvYU5iQWs3TE5zUmVUdE5aZnJ6S0MzOHg2OWVHazZPcEFwWWt2?=
 =?utf-8?B?emJkMVZndU9mWkNoMjdpTkNJQVlPK0tmV2FqNE9QKzBTR292LzU4dHo2VXFp?=
 =?utf-8?B?djFXaU1GbDNZQlg5YWwxQkk3S0dmNGF4bjdkWUI1NVBieGVwZnpXNzBrTHcw?=
 =?utf-8?B?U1M4SXZBajdDZURJMDQwbmdacFFJb2QzQ2xIRkdndm9MUjQ5QXNTNGRqZUlz?=
 =?utf-8?B?VklNS1BQZHBSdjB3UjFGSUwzdkFONGFMYVcveVBkaE82a1d3YTB4ejFOSXZQ?=
 =?utf-8?B?ZFVxOGZHaWtZbURtajJpb3BsNThTZHFkaU01clMxMmZsNHlLNWQwSWYzVGFp?=
 =?utf-8?B?T1R4dGd4S0xTQXhuUytYdC85L3pZNkp3NWlxdElIUnJlODdsbjNuQ2xKdEkr?=
 =?utf-8?B?QjNVc0NDVStjamU5RWJ5TWhjRnpNVmd4Yy9CWkdlSExGWGxRbGszb0RqNEU2?=
 =?utf-8?B?UDVTbkVSUFZhSkVFWFVOREhFZ1NkM2JNeGdEWG9DRmx5MnpVK0pEK21QRXRI?=
 =?utf-8?B?Y3BvTWNYVk9MS2o2TlJRMENXMFNzcFdhNXVOdEZ1bTRPcG5TMDFqZ0ZUbnFw?=
 =?utf-8?B?NG1mNE5kRENNVEhlT0ttZDV5V3I2aWJpN25pZ0F4UFNXNjN6SWhwd20zbnds?=
 =?utf-8?B?cnJiMCtrWDFEYm5Pam1iVUdTTzYxamw1c0kwcFR5ZU1LSUpoVTRxU2pLSjNM?=
 =?utf-8?B?OVV4RWh2azNQZE9WdTlnWTZCMVZNM1pBWHhveDJucEU0cEgwanByeE43SEJ2?=
 =?utf-8?B?TkM1RXgzRjJkZXdYRHU3SGU2anFlUnp6RW1rWk8rc2hBSXBEdVpmOU1McWlO?=
 =?utf-8?B?SmRkU29DTlZEZzkyMGJEaUFudTJEM0FEQ3FWRVZZUWFMakFMYmZmTU9sQVdi?=
 =?utf-8?B?R0dtYzBtNWgrck9TT3RkVWwwUGx0N1ZTa0w2Z0VTTGZRYzRkY2xOYzIvaEZM?=
 =?utf-8?B?MFFMZWwzcUt1QTZ6QUl3d0duc2lyeVlXaE1GbWxQZklRY0NncVNKTnEzYUVG?=
 =?utf-8?B?aWJRRmV2Vlc1S1BZcVJvaFNQWTFJSFdSQ2tuN1kyN2tzUEJqUkdVRUxpWFoz?=
 =?utf-8?B?eWxDenJIZjBOeTYxTDQxV1hLSVNaWmMwTjhTZ2NGRkc0RG90WnNMc3ZSSzZq?=
 =?utf-8?B?ZEdZZkNEZGdjTUd0bkdSWDZyK21YYzBJWEFHbWNrU3I3dU1FZ0tBU2FTZ0tk?=
 =?utf-8?B?RFFrLzNUUFlvWTdCRTF1V0ZIblRmUEVNNWpPcjlkcFMrekVFSWhmYlBUSGp4?=
 =?utf-8?B?ejZoOERkQmRubUtiM2paMzdtU3JEL0JZWlVyUG91MGU2R3JiVld6OXEweHFz?=
 =?utf-8?B?ZkErRmFWbEsrTi9OdXc0SndTakNIMDhObXNGbzVwUFpsUy9iVVpyL2dvMy9a?=
 =?utf-8?B?dlRTS3VpZDFFZDNHZGlGcEFKcHQ4RHlOMjYyUG9NKzdiaGVJZHlNZzc4bmYy?=
 =?utf-8?B?bk1kODRrV0s2OStTekF0NzN1clkvdjE3Nk4rbFU0ZklpRVUySVdJTFNnVEpm?=
 =?utf-8?B?aUNiYTAxZXhacG5tTHBiY2lvSTdVclN6SUJBWTBPNUc1RThDcDkrbFcyczZr?=
 =?utf-8?B?amFhTU5ZOHlpdGJDai9DdVNPR1N3MnZwdm5UK2pqSlB2QzZUbXNETzdjUHRs?=
 =?utf-8?B?UjloQUxzZjFxOGtZcmNreVhXZzAzSVR2Qmk5QVpmbFk5aC90QjJVMVBIMnA0?=
 =?utf-8?B?Q3N0S1hIR0FQdzRUY3JqNEZzbkdwb25iczZOVE1YNTFMenZCV0JpVldiRjZ5?=
 =?utf-8?B?V255YzVTZ1dUM2lmUzVwdkREZnIvYUpKK3cwUlJEQm5XanJ2dWRMZEpydklh?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27d7f03-f654-4b7f-774f-08dac1989651
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 14:50:32.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGBk72laN1L2zC0b1isJLoTQlfzlifSRkNLnznw191SYy2oXmo+FumeFaW5P+V8X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4160
X-Proofpoint-GUID: Cqp86J21cIQu0BBA8T66lrSvjQyvZlZR
X-Proofpoint-ORIG-GUID: Cqp86J21cIQu0BBA8T66lrSvjQyvZlZR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 4:57 AM, Bagas Sanjaya wrote:
> On Tue, Nov 08, 2022 at 09:33:14AM +0000, Donald Hunter wrote:
>> diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/map_queue_stack.rst
>> new file mode 100644
>> index 000000000000..f20e31a647b9
>> --- /dev/null
>> +++ b/Documentation/bpf/map_queue_stack.rst
>> @@ -0,0 +1,122 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +.. Copyright (C) 2022 Red Hat, Inc.
>> +
>> +=========================================
>> +BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK
>> +=========================================
>> +
>> +.. note::
>> +   - ``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` were introduced
>> +     in kernel version 4.20
>> +
>> +``BPF_MAP_TYPE_QUEUE`` provides FIFO storage and ``BPF_MAP_TYPE_STACK``
>> +provides LIFO storage for BPF programs. These maps support peek, pop and
>> +push operations that are exposed to BPF programs through the respective
>> +helpers. These operations are exposed to userspace applications using
>> +the existing ``bpf`` syscall in the following way:
>> +
>> +- ``BPF_MAP_LOOKUP_ELEM`` -> peek
>> +- ``BPF_MAP_LOOKUP_AND_DELETE_ELEM`` -> pop
>> +- ``BPF_MAP_UPDATE_ELEM`` -> push
>> +
>> +``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` do not support
>> +``BPF_F_NO_PREALLOC``.
>> +
>> +Usage
>> +=====
>> +
>> +Kernel BPF
>> +----------
>> +
>> +.. c:function::
>> +   long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
>> +
>> +An element ``value`` can be added to a queue or stack using the
>> +``bpf_map_push_elem`` helper. The ``flags`` parameter must be set to
>> +``BPF_ANY`` or ``BPF_EXIST``. If ``flags`` is set to ``BPF_EXIST`` then,
>> +when the queue or stack is full, the oldest element will be removed to
>> +make room for ``value`` to be added. Returns ``0`` on success, or
>> +negative error in case of failure.
>> +
>> +.. c:function::
>> +   long bpf_map_peek_elem(struct bpf_map *map, void *value)
>> +
>> +This helper fetches an element ``value`` from a queue or stack without
>> +removing it. Returns ``0`` on success, or negative error in case of
>> +failure.
>> +
>> +.. c:function::
>> +   long bpf_map_pop_elem(struct bpf_map *map, void *value)
>> +
>> +This helper removes an element into ``value`` from a queue or
>> +stack. Returns ``0`` on success, or negative error in case of failure.
>> +
>> +
>> +Userspace
>> +---------
>> +
>> +.. c:function::
>> +   int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
>> +
>> +A userspace program can push ``value`` onto a queue or stack using libbpf's
>> +``bpf_map_update_elem`` function. The ``key`` parameter must be set to
>> +``NULL`` and ``flags`` must be set to ``BPF_ANY`` or ``BPF_EXIST``, with the
>> +same semantics as the ``bpf_map_push_elem`` kernel helper. Returns ``0`` on
>> +success, or negative error in case of failure.
>> +
>> +.. c:function::
>> +   int bpf_map_lookup_elem (int fd, const void *key, void *value)
>> +
>> +A userspace program can peek at the ``value`` at the head of a queue or stack
>> +using the libbpf ``bpf_map_lookup_elem`` function. The ``key`` parameter must be
>> +set to ``NULL``.  Returns ``0`` on success, or negative error in case of
>> +failure.
>> +
>> +.. c:function::
>> +   int bpf_map_lookup_and_delete_elem (int fd, const void *key, void *value)
>> +
>> +A userspace program can pop a ``value`` from the head of a queue or stack using
>> +the libbpf ``bpf_map_lookup_and_delete_elem`` function. The ``key`` parameter
>> +must be set to ``NULL``. Returns ``0`` on success, or negative error in case of
>> +failure.
>> +
>> +Examples
>> +========
>> +
>> +Kernel BPF
>> +----------
>> +
>> +This snippet shows how to declare a queue in a BPF program:
>> +
>> +.. code-block:: c
>> +
>> +    struct {
>> +            __uint(type, BPF_MAP_TYPE_QUEUE);
>> +            __type(value, __u32);
>> +            __uint(max_entries, 10);
>> +    } queue SEC(".maps");
>> +
>> +
>> +Userspace
>> +---------
>> +
>> +This snippet shows how to use libbpf's low-level API to create a queue from
>> +userspace:
>> +
>> +.. code-block:: c
>> +
>> +    int create_queue()
>> +    {
>> +            return bpf_map_create(BPF_MAP_TYPE_QUEUE,
>> +                                  "sample_queue", /* name */
>> +                                  0,              /* key size, must be zero */
>> +                                  sizeof(__u32),  /* value size */
>> +                                  10,             /* max entries */
>> +                                  NULL);          /* create options */
>> +    }
>> +
>> +
>> +References
>> +==========
>> +
>> +https://lwn.net/ml/netdev/153986858555.9127.14517764371945179514.stgit@kernel/
> 
> You forgot to add the documentation to BPF toctree:
> 
> ---- >8 ----
> 
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index 1b50de1983ee2c..113872fa0193d7 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -22,6 +22,7 @@ that goes into great technical depth about the BPF Architecture.
>      kfuncs
>      programs
>      maps
> +   map_queue_stack
>      bpf_prog_run
>      classic_vs_extended.rst
>      bpf_licensing

It will be automatically indexed in maps.rst:

...
Map Types
=========

.. toctree::
    :maxdepth: 1
    :glob:

    map_*

Usage Notes
===========
...

The visualized example:
   https://docs.kernel.org/bpf/maps.html

> 
> Thanks.
> 
