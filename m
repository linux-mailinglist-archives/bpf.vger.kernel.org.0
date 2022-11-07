Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349DE61FED3
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 20:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiKGTle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 14:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiKGTld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 14:41:33 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E731002;
        Mon,  7 Nov 2022 11:41:32 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7JaVgt011943;
        Mon, 7 Nov 2022 11:41:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NypOF+9rh/Q91c4KA9+tOqiVriqY00KxfaxbHmllXGM=;
 b=f7wgRfRjHsEJfHXj1NgiZ1Luap02RSh10FBXfzrU82bnyqKmKtp/XqnPasOLitmZ+NFn
 ZhXDxo/hE+uDbIkHb6rqQCa33zNKHsbaIBDz4oO/5v6IUAHFivHwCY2JOu8SSy4PADzd
 ou5IFi4jRrRTBeLXvzD2AaSxXfT44x6Hv0xRm8eaz03grt4P2Se5uKFSPschBPctMOeV
 hMIPCvh6/L7HqJhTN2ooYEvMlUL+2g52KYpAa5JWEj2yP3SWIB+MSVPX8Bj7hkrjTPAp
 15Apos3YSxUtcFDoSp1jGefCwn7RU0CLlMFZNxiOK/c0nQfnVYZz75z/9cDYPWkJEPUw 8A== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knnhnsvmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 11:41:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+vF1d1FlgIALoG37xFpgzOmQoCxVF0Na4yd1aphH9LEAR56iDHA7l06hJWZAn29VsPnuaaVRnAVy7FOiAaZ33p0u8+kAvSKFyciFxbYOWuXDnMZs5elX3JJ2bkgK9wk0x9WJHZYqh0Dg08MYqSNXmUpukzFN+4Jb8B63ziL+MMZWFDM+CkvwAxbSVFJJ3amzR9zlffas+gnRivx1s4yWI5eyIPJWlED1MOOcUlJ5/ULiRyzgLh9OYroSGR2AAwnAyjrwKM3fvysB9RG0q1a4bo3dPhIUSQFy8SdMgylZmGiBP6hw2TtC9GAJypPQ7QB88km5roZCbK+YSCTdHPe6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NypOF+9rh/Q91c4KA9+tOqiVriqY00KxfaxbHmllXGM=;
 b=ZbXOJ568NCwjSH7OTFfY8qmYPy8TazyvzhTuV5EIpB+dyOBLrZvNDjV4E8hP3NuJI2Tj9keM4Z7FnN9AyYtMf2FZK7Nr5M/6QQjdRreB84ovFuDgbVi9zdb2DdJ5/tGL1uzrXXXzXWWUKKu9aUIlty5mmUpXfqmSQi9SNDEijpRFeyu6iLyUISRUVN3qxAOjmi8kJYtwQYnKMm6UGsrPSgeqBdZD1qC3M3W44KPmm0D88FsbXyUHzcmNbNBkDKlriiX58zKGMjzDsbe/i0qeIysUdgeviWD1DunULJg14tzqITmambYdGp0XaKdcVk5o0LYHdPhaOiWZjP995C1Kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3066.namprd15.prod.outlook.com (2603:10b6:5:140::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Mon, 7 Nov
 2022 19:41:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 19:41:11 +0000
Message-ID: <ad5e6435-30d6-afa3-ab4a-5cc6767a0f09@meta.com>
Date:   Mon, 7 Nov 2022 11:41:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v3] docs/bpf: document BPF ARRAY_OF_MAPS and
 HASH_OF_MAPS
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maryam Tahhan <mtahhan@redhat.com>,
        kernel test robot <lkp@intel.com>
References: <20221107134840.92633-1-donald.hunter@gmail.com>
 <1ef036ac-1499-ae14-0ceb-997fa03db509@meta.com>
In-Reply-To: <1ef036ac-1499-ae14-0ceb-997fa03db509@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3066:EE_
X-MS-Office365-Filtering-Correlation-Id: 479f31f4-8b7b-4e4d-bca2-08dac0f80633
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3Au9QKuNCQ+q3Y1CGE1xCzNs7iHSLPf7lfmtU98iGU/fYWZe6pTq7kf7JDx3entLt0eRnd6dT94AjjbbiLQhbj16GiWGkjnC3LNzXcTGiFzhL8T46rwIxAx0Bi5iKfPcTsfA5ILvZeLZTCSBqYYckYdPG+mh0tEp7/ap87z9+XHhScLOrHj/stUWuTwOGZheMGomVaPnYutUHlTJ1agHAjm34/N0+D27RbM3zWjP8tihrYVLZzGfz+2xbpda4ZmYMjTbI4SNZuTbrQ5L+aPXbzL7I6mw7+MbtbiKZ9yzBbMSgvWZQBKAtjqvFL6QeDmBYErX9JLIyqHx87hSIwpphAAOO7OgNGI3mZHxr0fBoPVieSBSNMrUEqmHHEPTqACtft44G9uLhFonZwBTuXt1i8cqHNRE/Czn0zKKp3aWVa6L4uAbZB7n8J03tzw3Ei0PQQtKlDDtRgWK2jQwDwj5NYhY9YUk4DBZ/t0tBYivi7B+QoF7cjWUZL2Nrt0lTtZ2G1D5d4Wjllx4SgPl/0TIZ+XWbwxPD3+RqXJKb0VoBQPvfLSmDph29c9eGmU+r8pGWVd4LMiPxAuDN+RBx8XmAirKKWt8vuTn3ic24WumSpby4QzUJb3gTzHcYXX4TotvavVKMZSjfvbbGz3iG/bHbLyaCsEZLdOtYozseyM9MeYPfnW8kPtiL84VGzGlq19418LlAykW4z9CHGzEqqsNLOiYd27fYHSrS0rP0NN1vWJ2pPu1ot0QBbgvj4GmfdEFvRdehzOL4TNcr74HjpAAmHcWAEf74QxxlGneti92I0HCjenmrrVfrWKWR7paAETmZaKIo7YCGgV0twk5MyP4F8psR20UbxBjDsNodoRlt9jva54DrrWQ9jj7vy2AG8f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(478600001)(2906002)(66946007)(316002)(8676002)(66476007)(4326008)(41300700001)(66556008)(5660300002)(6486002)(966005)(54906003)(8936002)(83380400001)(53546011)(38100700002)(6506007)(86362001)(31696002)(186003)(2616005)(6512007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckhrUGd3MzFFN2lFZUtqRzBic1NNMFhzblRtRldJU2NEemwvTnlmVG1GejBj?=
 =?utf-8?B?VW84NG9aalNraFhHcFA2a3RzcjJZSjV6cDk4NTJzK01zUkZ4S3F1SDJEMmMv?=
 =?utf-8?B?Mm5VK0pGa21wNEZLVmdiNkt4c1YxeWFmaWdmM3JiSmxEY0RuYi8wWTVmV3M4?=
 =?utf-8?B?L3lmUVZUT0I0TzJYQTRwSElvS2VFeHhxNWNuRGRSOU9pcDZCTjRCUmFYaHF6?=
 =?utf-8?B?R1JCbGYyaHFmYmk5TkJCRVlwZy90aHFWbVh6UlhLa09yL1kwa0pXbmJmbDYr?=
 =?utf-8?B?cnc5UFhnWWRuSVphZmF5V2wwY3ZhTnhieUJreG10UzUzVkJQYUJDalRVR1Mz?=
 =?utf-8?B?RGMwS0ozaFFvRnRvMkpId2RNNHJpMkZEZUQ5ZTBqQ0tmei8vN2orOGFDQUto?=
 =?utf-8?B?MlBXUm5xaU9rQTl1VFV1SFZwNkY4eGREOEM1MnZtS3NyMTNBVG5VSGUyd3JR?=
 =?utf-8?B?V04zdk9YSFlKUFdjWm5BUzArRjFvZk9BOGxoK1Bra0QzSGV1SEpScTREUDUz?=
 =?utf-8?B?UGdOY3ZkZ3Y2TmJNWVprNjN2TW52eTVCWFJWTFg4VXl2U2JEczF4ZnNJWSt0?=
 =?utf-8?B?c1hQUTNNYXg2bEtmaUQ4VlloQW1oVFZlUWNiQmhFYUlhMzRkYk1ySFZsaTJq?=
 =?utf-8?B?ejV6dVpscm1nU1Y3cUlRZjRTaHppejVRTkVJWkkyQmxRa3h2d05TdVcvTDVv?=
 =?utf-8?B?UEZqMGF1MkphZFBjazJwYm1LVm9ZVnRublFWUEJROVp1VFJNa1Y5c2I4QnZH?=
 =?utf-8?B?RmxDZmJFbDZqdm96OUpJWHdNem1HQlo5VTNHMXVENlN3cnp4aWVxVnpaUmQx?=
 =?utf-8?B?SStibXpDUzNNd3lOMWNJRHhCNzg5VDA1S0ZTSlNQT0pvWlhZbmxzSDB3NTVM?=
 =?utf-8?B?VlByV0wwMENhcjl6MDhWYm5XSGRCTU9LSk9ObmV6aGhEK25PdjkrTUNUL0hV?=
 =?utf-8?B?eVJqRysxMHlLQ1hwbEorbXZ3bDhnZ0s0SHFacERmM0JaRjJvUFRSNCtDRTQy?=
 =?utf-8?B?RVVjbDg0UmYwZStKcVB6UVNZdjIzYjhPSVg4cHIvenRIaGxoQTJqbHkxRUF3?=
 =?utf-8?B?VjZVdmRIKythUURkcm1mY01GT250N0FMY3RhTHRlWW8zNi9qYTFyeE1hZkFO?=
 =?utf-8?B?aTVEMGdpd0pZRlB4RUZQbmdkcXBabnA4T3l0L2o3OEdjbkxsRXMzWGo3TXRp?=
 =?utf-8?B?aDd1cXVDWjNud3BFQWpjenRXRGtVdko5dUtEL0hLbk5uM2FmbEtRSWEvbkdC?=
 =?utf-8?B?cTU2N2xtME9lQllnZ2ppQUM3R29FUXRHTmpDcDlqa0ttc0sydGtXMlMzOUZE?=
 =?utf-8?B?dEVRd0NobWpuU3dZb2YvVDJKZzZzdEJCR2JPb0VpbXM3VktYVUg1TkN3b0dE?=
 =?utf-8?B?QmFvdzhxeFhBMlUzT3ZVYVR1bjNjdkhNRzl2b2tNNmZ6SDlhL3R3YzN2Y1Y2?=
 =?utf-8?B?WjBpWkV1VWVGMDdTc3ZZaGVVTVZ6VzN0czhQamZueFArekNwUFEvcEdnSGpL?=
 =?utf-8?B?YWxMdzZjQ0tobENlWEhiVUFmdGVUZnFNdnBJb0tKK3p1ZHZ6RXhUSXhrOHNC?=
 =?utf-8?B?cDFYeFVaYTJhZzFsMXJBRWF2b3VhUlQ1NVR3RnFnZElVQ2pYNFZjVVB6RzdX?=
 =?utf-8?B?dkhDTTlSSVk1ZDNMaTVNcGhZOGVwaVZMcW5LSEFPb29SdXB6bll6eGZwOTVi?=
 =?utf-8?B?eFo1SS9YMUdaTGc3Qy9vUXk3RG4zTElMOVlHRVI0UmRaTTV5SG82RUlITUM0?=
 =?utf-8?B?aHNmUjNEUFY3RlJzTHU4amthWWJjK1BDUWFDVTl3RXdnUEZvVnNnNHNPZWl0?=
 =?utf-8?B?SUUxY1NCSWt4aVZKaUZNSlcrak1rVmFLbTVjbDErRWttY21OWmErTnRaU1lW?=
 =?utf-8?B?dTVra1M4R0ZycHdRcXRGYW45TnBONVhJekNQWStpY244NmJDV2VpZmpMTWRx?=
 =?utf-8?B?QVZabFdSYlFxa2dKVGJ4M2F4cm15Wm96WnZOeDhQNktMTmFJZ0hSN3MrK0hy?=
 =?utf-8?B?V2ZqT0RLWE9QbjQrdXBCMTFtN240ekdLb3kvZlU0dWlzNXdVM05tQjBqN09K?=
 =?utf-8?B?OHpTT0RRdllTSVB5ZkZpdVZVMk9FamdmQm5yaWtZenF1eFlNVlBwdTc1ZFph?=
 =?utf-8?B?NktaV0ZTaGREbG9MTXk3RWw5OWw5VUs4Wm1WYUhvNlRDMGkrblA5WkJvNWVm?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479f31f4-8b7b-4e4d-bca2-08dac0f80633
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 19:41:11.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAzb/8RcJ0SPQUVtty6i7Viy3Vmm9E5zXnYVOpV7qi9oTfyfEPgXLtVbmeQ443EA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3066
X-Proofpoint-GUID: eE9a6c9H8u8ZKCAqq_E99OhaBeS2Ydh_
X-Proofpoint-ORIG-GUID: eE9a6c9H8u8ZKCAqq_E99OhaBeS2Ydh_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/7/22 9:46 AM, Yonghong Song wrote:
> 
> 
> On 11/7/22 5:48 AM, Donald Hunter wrote:
>> Add documentation for the ARRAY_OF_MAPS and HASH_OF_MAPS map types,
>> including usage and examples.
>>
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> ---
>> v2 -> v3:
>> - Update BPF example to show declarative initialisation, as
>>    suggested by Andrii Nakryiko
>> - Use LIBBPF_OPTS inline initialisation, as suggested by
>>    Andrii Nakryiko
>> - Fix duplicate label warning,
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> v1 -> v2:
>> - Fix formatting nits
>> - Tidy up code snippets as suggested by Maryam Tahhan
>> ---
>>   Documentation/bpf/map_of_maps.rst | 126 ++++++++++++++++++++++++++++++
>>   1 file changed, 126 insertions(+)
>>   create mode 100644 Documentation/bpf/map_of_maps.rst
>>
>> diff --git a/Documentation/bpf/map_of_maps.rst 
>> b/Documentation/bpf/map_of_maps.rst
>> new file mode 100644
>> index 000000000000..63e41b06a91d
>> --- /dev/null
>> +++ b/Documentation/bpf/map_of_maps.rst
>> @@ -0,0 +1,126 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +.. Copyright (C) 2022 Red Hat, Inc.
>> +
>> +========================================================
>> +BPF_MAP_TYPE_ARRAY_OF_MAPS and BPF_MAP_TYPE_HASH_OF_MAPS
>> +========================================================
>> +
>> +.. note::
>> +   - ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` 
>> were
>> +     introduced in kernel version 4.12
>> +
>> +``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` 
>> provide general
>> +purpose support for map in map storage. One level of nesting is 
>> supported, where
>> +an outer map contains instances of a single type of inner map, for 
>> example
>> +``array_of_maps->sock_map``.
>> +
>> +When creating an outer map, an inner map instance is used to 
>> initialize the
>> +metadata that the outer map holds about its inner maps. This inner 
>> map has a
>> +separate lifetime from the outer map and can be deleted after the 
>> outer map has
>> +been created.
>> +
>> +The outer map supports element update and delete from user space 
>> using the
>> +syscall API. A BPF program is only allowed to do element lookup in 
>> the outer
>> +map.
> 
> The outer map supports element lookup, update and delete from user space 
> using the syscall API.
> 
> A BPF program can do element delete for array/hash_of_maps. Please 
> double check.

Okay, I double checked with verifier.c. You are right, only lookup
is supported for bpf programs.

> 
>> +
>> +.. note::
>> +   - Multi-level nesting is not supported.
>> +   - Any BPF map type can be used as an inner map, except for
>> +     ``BPF_MAP_TYPE_PROG_ARRAY``.
>> +   - A BPF program cannot update or delete outer map entries.
> 
> A BPF program cannot update outer map entries.

Yes, only lookup is allowed for bpf programs.

> 
>> +
>> +For ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` the key is an unsigned 32-bit 
>> integer index
>> +into the array. The array is a fixed size with ``max_entries`` 
>> elements that are
>> +zero initialized when created.
>> +
>> +For ``BPF_MAP_TYPE_HASH_OF_MAPS`` the key type can be chosen when 
>> defining the
>> +map. The kernel is responsible for allocating and freeing key/value 
>> pairs, up to
>> +the max_entries limit that you specify. Hash maps use pre-allocation 
>> of hash
>> +table elements by default. The ``BPF_F_NO_PREALLOC`` flag can be used 
>> to disable
>> +pre-allocation when it is too memory expensive.
>> +
>> +Usage
>> +=====
>> +
>> +Kernel BPF Helper
>> +-----------------
>> +
>> +.. c:function::
>> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
>> +
>> +Inner maps can be retrieved using the ``bpf_map_lookup_elem()`` 
>> helper. This
>> +helper returns a pointer to the inner map, or ``NULL`` if no entry 
>> was found.
> 
> bpf_map_delete_elem?

same here. bpf_map_delete_elem is not available for bpf programs.

> 
>> +
>> +Examples
>> +========
>> +
>> +Kernel BPF Example
>> +------------------
>> +
>> +This snippet shows how to create and initialise an array of devmaps 
>> in a BPF
>> +program. Note that the outer array can only be modified from user 
>> space using
>> +the syscall API.
>> +
>> +.. code-block:: c
>> +
>> +    struct inner_map {
>> +            __uint(type, BPF_MAP_TYPE_DEVMAP);
>> +            __uint(max_entries, 10);
>> +            __type(key, __u32);
>> +            __type(value, __u32);
>> +    } inner_map1 SEC(".maps"), inner_map2 SEC(".maps");
>> +
>> +    struct {
>> +            __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +            __uint(max_entries, 2);
>> +            __type(key, __u32);
>> +            __array(values, struct inner_map);
>> +    } outer_map SEC(".maps") = {
>> +            .values = { &inner_map1,
>> +                        &inner_map2 }
>> +    };
>> +
>> +See ``progs/test_bpf_map_in_map.c`` in 
>> ``tools/testing/selftests/bpf`` for more
> 
> The file name test_bpf_map_in_map.c` does not exist.
> 
>> +examples of declarative initialisation of outer maps.
>> +
>> +User Space
>> +----------
>> +
>> +This snippet shows how to create an array based outer map:
>> +
>> +.. code-block:: c
>> +
>> +    int create_outer_array(int inner_fd) {
>> +            int fd;
>> +
>> +            LIBBPF_OPTS(bpf_map_create_opts, opts, .inner_map_fd = 
>> inner_fd);
> 
> This is declaration. Please put it adjacent to 'int fd'.
> 
>> +            fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS,
>> +                                "example_array",       /* name */
>> +                                sizeof(__u32),         /* key size */
>> +                                sizeof(__u32),         /* value size */
>> +                                256,                   /* max entries */
>> +                                &opts);                /* create opts */
>> +            return fd;
>> +    }
>> +
>> +
>> +This snippet shows how to add an inner map to an outer map:
>> +
>> +.. code-block:: c
>> +
>> +    int add_devmap(int outer_fd, int index, const char *name) {
>> +            int fd;
>> +
>> +            fd = bpf_map_create(BPF_MAP_TYPE_DEVMAP, name,
>> +                                sizeof(__u32), sizeof(__u32), 256, 
>> NULL);
>> +            if (fd < 0)
>> +                    return fd;
>> +
>> +            return bpf_map_update_elem(outer_fd, &index, &fd, BPF_ANY);
>> +    }
>> +
>> +References
>> +==========
>> +
>> +- https://lore.kernel.org/netdev/20170322170035.923581-3-kafai@fb.com/
>> +- https://lore.kernel.org/netdev/20170322170035.923581-4-kafai@fb.com/
