Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC755601A87
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJQUo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJQUog (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 16:44:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6CF2FFF5
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:43:22 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJPXU2028217;
        Mon, 17 Oct 2022 13:29:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=1+NKoVsowIl1t4dzF1zqdXBxsvHYMl/SlWnW4XYhah0=;
 b=eAaqfMrPBIXobREQPAr7Vjt33eajz/fUM3eipOxLVKysVMWmep63wfw7hYMBHSY9N1Bn
 zRFwBBWyKXpcf3ZgM4z9fKRPDWmVCisH1IcO1YVth2UujU2oAOLm+RKxxn1bdZy4bpEW
 rRARhTy88tw74OSP9u8mJ4ZvvHiBRqSTU8pWoQ6oCKzcKeYL/lpxZfpjFN8DZ8+EDZKd
 4u9E+BaXM51Argq77fRWlq2/tH+SBZPRs3lqS4fLX++mKWq8F62hrez5g4jyBmJfSH/W
 nzxI8oY0A+NurjahQmAHp+CGptmhsAU25qLtQfuBEBz7mWX8KNLD6Js/Jg0BFjH4XgCC dw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k7r6mv6q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBKneTe3WN3RI68UpOSagJuh8aSV94jU8gSezbnkIxwYjT2jvU+pgxyGzTf+5wrFtFZ/7W/Czz7a2P3SbN5vg2jSS+XMb2ipijd5iMar6dlR5djkGPLLt8cWt9DbDwZ4EhsVvoYOA73Ez9D3y2uvdEICMJwxbIxPxojhS8IolO9MzzYSo0C0RDynu2D19oTLxZi683tOdq11rsuorqSNdtrxvZYyqcwHiZvv2W1eVGMPPd6oj2yC2f48cFEybGrjeT156YFrWqyCOmZOd0wy/DrORMgqFKp2huZl0Sa3zMBlfgrW5uHnLiNwYf5Pyu66MwZSpm/5sLdZz35UP9EWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+NKoVsowIl1t4dzF1zqdXBxsvHYMl/SlWnW4XYhah0=;
 b=gQmGysi5mOTn6FSB1tvB0XNsYgxyU4jgB1gXFanfBs1o8zE4Z8wTce38JRa61gE2sMos53198agh/jr2ZDnjSJWaemCCW/zMEiKjCVcylpEFAAqOkW85/CTJFZjlnVT55/TrATpgvhRbhqVNMJGiJ5GlUbcAdxVl0Rzil2lLeI+vYLnMph4Yn88sZb7nlFeKfY1KeAUPRIEX+Oc1TuM1t5tTHRkxyXqEyMzivY5CGEE+DVvN2i3qKn5/+ULqmwebwG4c63O4cM206CHsIGlYQcrnZnjj7WKOGntB2GrBlPyI74ptr4SxZVKXX4I5kAgA9PYk8F5DOcQs3yLwlLedlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3873.namprd15.prod.outlook.com (2603:10b6:208:254::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:29:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 20:29:05 +0000
Message-ID: <159c25b6-9c3a-4b59-3475-c29081d59914@meta.com>
Date:   Mon, 17 Oct 2022 13:29:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     sdf@google.com, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com> <Y02Yk8gUgVDuZR4Q@google.com>
 <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <09abf562-ac9a-f702-aec1-7e4eb9343882@meta.com>
 <CAJD7tka=j7NcOf+oekEF3gN7vg8h=15qG6WrHbiGjpX0rJNN_A@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAJD7tka=j7NcOf+oekEF3gN7vg8h=15qG6WrHbiGjpX0rJNN_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3873:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edd6a4d-198d-40bb-101c-08dab07e3cb6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrgNJvyNdTPEFb44afIPJUdVdYPNHa4xhVT8I3epjwElqjmwe63zNnGNQLoBi9oMG9VARCWG9eJPSBDfNpRbs6lrh+OHcWYEfep45u/BF2JIk+LBqLz65wlzSxuAT8MioR1t6+WTRgHCT0gE692bZ7B7WFkghb55X0cY74S7wsypWiM1gUZGUTe2P1IgBaOvJOlai1qCuQqUWBPCPTLpqTXDbFYes+0SLwG4sJzYDpLC/V5PULNvSQHA9YKvJV8IGpj9v1dOuqXMW0pyLmYiFVaUDWFJrRQcaU6BBDXccA8cHoOnyywOZ0RB/i2JdZlHXpHCDS/2yPWorJ426nPtwJp+bLKxoUEOANu9NUqc1dq+fCWWXgHVB3yXgki8o+c9B+o9YBs4CO3n3MJSWlNjB5N6bDfd4Kz6rtN5SOxGGHs8+3lVSBvrw9wYU6nzIAs31ZmiOTt4cv1zYbYfpVaIEbfZOhWb2wltVK9Ub16lcC7EpndZ9AJhCli/5gIazPFRvUY9nkxZdb7Td00IuHuKm5IOD+YTw+CEhtN8nWnf9gWUity4HKNvkh5GhXoq2DMON9eYO7rUY46GraQhxdrwqgDy0Q6VT1ksF9HiEtNooVQyvKSoyy3UmAun+9+lX8lFgIHuoBIwNny/2MVmpZhtBdGT84j17iJj5FK7OdTWr802sVZBzaDsDQ9JNMHU/RbMblDxtaRrqnJBQNw4f7VyAvuzrNy2GGAdErZT+fc+R3frBNw7UBhox7ThKjz8uGjKz8p4xf4eWRhMJj28eSRGoGUeCSNN6tTF/Owr0ITsWUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(66556008)(66946007)(6666004)(66476007)(5660300002)(4326008)(8676002)(186003)(54906003)(6506007)(53546011)(36756003)(41300700001)(31696002)(2906002)(2616005)(478600001)(316002)(6486002)(38100700002)(6916009)(31686004)(8936002)(83380400001)(6512007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZkdDZxQzFqZzRVVmtKTU9XR3dwN212VUlYTVZ3NmZEY3lLMXd0MXVlTlV0?=
 =?utf-8?B?N01XdVVXUmJuVjgvTTJYQ00xaFA2azJKd0orTFVCSEs0VDBtMjA2dTNZUW1X?=
 =?utf-8?B?RTNFaDJibW8zZmY5V3lLdlg2WFVJVVlrTEppay9BcE5CTUZUeUdpVjd5MFcv?=
 =?utf-8?B?YU52bHY1aVhOUXYrcFF0S0Zkc1p0TTNUMlllOG1DUGVWNlF5dmhHK0ZyYUJ2?=
 =?utf-8?B?eUpMblFVMUVNd3Y2OGYwa095ckRoYlVDZFlJSkJnRzA3RDFQSzk1UkRacW1z?=
 =?utf-8?B?VkZEaUNHMW5YNUU1RUV2Y09ZbFlUN1dVbG9KeTQwaEhtRm5aMVlad1JFSUpR?=
 =?utf-8?B?b2NGdmRXdldONlNpempQcEFNalpFRHFQbGhSSXptOGFVdVJJNlQzOHhTc01X?=
 =?utf-8?B?ZGFYejNLUmhlK0RoNzd3MUVLNmQwc00xakNaRlI1ZDlzZG1FTVgrM29Pc3Y4?=
 =?utf-8?B?YTZFNHpTakFaRHlHSVJmNjJqUEZCQUVlVnZkQ3pOZlVrZ0x3Y2ZVcmVwWGdz?=
 =?utf-8?B?YU5taE1PSTVYekt5WDM5ajMwMERjSWNFUDNyT3A2Ulk4Z1dvREpQbkZ2akhl?=
 =?utf-8?B?aWxEaCtDWVZNbzN1U3ZyQ0FyMFFwQndkektITHdJZmhwWmkrcjR3RXcvaVE3?=
 =?utf-8?B?a0RKUFNZaGF4RFd6YTFzUm9JQU96SUFiOFdXbTE5MmpVanJFU0pscEhSNGVB?=
 =?utf-8?B?NlROdmFndlFDeVBEYW16a1YxaHdPNm1Gd0NHWmkybStQN1RrVW9PdTdJM3hl?=
 =?utf-8?B?S0VBZzViM0pneVVnaE0yNXRmejNaVTdWd1ZoM0JQUHJyUDN3Vk9yam1lZDFY?=
 =?utf-8?B?VDJlbmZYMXFXK0dWanV1TkwxRTAvamh2ZTNzYVpPZHBVRk9xak1raW11QVRS?=
 =?utf-8?B?WE80YXBRdFBqNzNqYzl3THFDYWN6NVpCdE1Xck84TWRZanRMMzBWS0RUTEEx?=
 =?utf-8?B?QnRwclU0QjZPUDRBTnQxVlhOMkQ1aWxMeWNwTnVGTWVHOWRveEU2L3ZXWmdK?=
 =?utf-8?B?MWdFTW9GekZqcC9nYzNObXZiYklmVUY4YUIyUUI3aElIdmZGZ291NEVsNjFr?=
 =?utf-8?B?Y2JRdW1ES2UxSHkyVjJ3cklEZFB4VVhvZERyVmtqY0I4eG1FZ2ZGd0ZvMUVC?=
 =?utf-8?B?NzdwODBPQjk0b1dVS2hZTy9PNHBVMVczSGMzdjFPcTBuTVMwaktVRVBjZzY3?=
 =?utf-8?B?SWY4VG14amRkNEZJZTZOMnVxMTJvZTZCVkN6ZjlXblFiWjBjcS91VUdZSWxs?=
 =?utf-8?B?MkMzOHdocU8xLzhQZUJoclV0SmZNSEJSUU5CUjdWNkM1VnRraGgvVmpKbUFE?=
 =?utf-8?B?MmliTlprcTQzckdlVE9ZS2NLdkxPMVpNbStuK0w1dUxwRXBFcVVrRUJkOXdm?=
 =?utf-8?B?V0VJN2hZZm1RZE4xOVBZTlFaeEZXRVhzcWhKdGt1S1gwZmdtYkVINnZ4QzZC?=
 =?utf-8?B?U1pGKzc5eDlFSTNRbHJ6Q3YyOUJIQWI1L0JyRndNMGhKaG5GYzdJWUZKbWQ0?=
 =?utf-8?B?cHBGdkp1cEh1NUVlU1pyS3Y2M3U4ZnU5bHFaSTd2anVPbGcrazErZGlKM21F?=
 =?utf-8?B?Q0owUlZGZGRLTldMWXdwWkhNenQ4SnhacjUyMStiK0RqQzNZR1F5K1F4RmZR?=
 =?utf-8?B?bXlnWkdOcXNmN1piUXNWdzhhbVNSaGo2WjdXN1NUYlRacjRHdTNYdDNTbGtW?=
 =?utf-8?B?TUxJZEVHcW9UeTRvRlZCcXFQeFBCYmN1ZVR1R01HVkEwdkdGVHBjUzRkeEJJ?=
 =?utf-8?B?YmJmWUgwdWJzREtCbERiL2RDYWpFVlBQaUpFNTZnZWdUUGwxWENXRGZYbzFl?=
 =?utf-8?B?bGpOc0svK09Pd3VEdXh0NDF0VUxUNmgvS0UwUnVkazJocHp6SEpMTkp0aWxy?=
 =?utf-8?B?aldJOVNJRW9QRE1hdFlIVHBWZG9JM0Jwak1FWlVrbjVNRHFaMlBOeHU3Sjh6?=
 =?utf-8?B?MjZIdC9aWnZpZ2tSUG5sMnNoUDFwTDdiQk8rS2F4aEw0TWZSN3R1a25QZG1F?=
 =?utf-8?B?cnpiZmN4cEpMRm0yYlRYOGIrbHgwbjBuakNqL0ttcE1SZXpRUTBqUlhrN0VE?=
 =?utf-8?B?cExzamlrbTNxcjgzcFN1RCt5dFBOV0FVemYyRDJ5eW1pbnZDeHlWbkhCNFdq?=
 =?utf-8?B?NHJSUzBPUDdUSHgvNXQ4STd0Tk9uTW5VVG1jeVNvVk5GamI1eDBtQzN1ZkRt?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edd6a4d-198d-40bb-101c-08dab07e3cb6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:29:05.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcJSTRET+Uo7rN4HliFt0F3ZXy5f33x0CGrsG+vcxzdNbUE38x7x2rf1Q0nDDVBq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3873
X-Proofpoint-ORIG-GUID: eumn6_tqNy29WCffW93yLB1DfDznaTK5
X-Proofpoint-GUID: eumn6_tqNy29WCffW93yLB1DfDznaTK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/17/22 1:14 PM, Yosry Ahmed wrote:
> On Mon, Oct 17, 2022 at 1:10 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 10/17/22 11:25 AM, Yosry Ahmed wrote:
>>> On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
>>>>
>>>> On 10/13, Yonghong Song wrote:
>>>>> Similar to sk/inode/task storage, implement similar cgroup local storage.
>>>>
>>>>> There already exists a local storage implementation for cgroup-attached
>>>>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
>>>>> bpf_get_local_storage(). But there are use cases such that non-cgroup
>>>>> attached bpf progs wants to access cgroup local storage data. For example,
>>>>> tc egress prog has access to sk and cgroup. It is possible to use
>>>>> sk local storage to emulate cgroup local storage by storing data in
>>>>> socket.
>>>>> But this is a waste as it could be lots of sockets belonging to a
>>>>> particular
>>>>> cgroup. Alternatively, a separate map can be created with cgroup id as
>>>>> the key.
>>>>> But this will introduce additional overhead to manipulate the new map.
>>>>> A cgroup local storage, similar to existing sk/inode/task storage,
>>>>> should help for this use case.
>>>>
>>>>> The life-cycle of storage is managed with the life-cycle of the
>>>>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
>>>>> with a callback to the bpf_cgroup_storage_free when cgroup itself
>>>>> is deleted.
>>>>
>>>>> The userspace map operations can be done by using a cgroup fd as a key
>>>>> passed to the lookup, update and delete operations.
>>>>
>>>>
>>>> [..]
>>>>
>>>>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup
>>>>> local
>>>>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
>>>>> used
>>>>> for cgroup storage available to non-cgroup-attached bpf programs. The two
>>>>> helpers are named as bpf_cgroup_local_storage_get() and
>>>>> bpf_cgroup_local_storage_delete().
>>>>
>>>> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
>>>> cgroup storages shared between programs on the same cgroup") where
>>>> the map changes its behavior depending on the key size (see key_size checks
>>>> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
>>>> can be used so we can, in theory, reuse the name..
>>>>
>>>> Pros:
>>>> - no need for a new map name
>>>>
>>>> Cons:
>>>> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
>>>>      good idea to add more stuff to it?
>>>>
>>>> But, for the very least, should we also extend
>>>> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
>>>> tried to keep some of the important details in there..
>>>
>>> This might be a long shot, but is it possible to switch completely to
>>> this new generic cgroup storage, and for programs that attach to
>>> cgroups we can still do lookups/allocations during attachment like we
>>> do today? IOW, maintain the current API for cgroup progs but switch it
>>> to use this new map type instead.
>>
>> Right, cgroup attach/detach should not be impacted by this patch.
>>
>>>
>>> It feels like this map type is more generic and can be a superset of
>>> the existing cgroup storage, but I feel like I am missing something.
>>
>> One difference is old way cgroup local storage allocates the memory
>> at map creation time, and the new way allocates the memory at runtime
>> when get/update helper is called.
>>
> 
> IIUC the old cgroup local storage allocates memory when a program is
> attached. 

Ya, meta data memory is allocated in map creation time but real storage
is allocated at attach time.

 > We can have the same behavior with the new map type, right?
> When a program is attached to a cgroup, allocate the memory, otherwise
> it is allocated at run time. Does this make sense?

I would like to keep the new functionality flexible so that
even if a program attaching to a cgroup it can still access
other cgroup local storage.

> 
>>>
>>>>
>>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>>> ---
>>>>>     include/linux/bpf.h             |   3 +
>>>>>     include/linux/bpf_types.h       |   1 +
>>>>>     include/linux/cgroup-defs.h     |   4 +
>>>>>     include/uapi/linux/bpf.h        |  39 +++++
>>>>>     kernel/bpf/Makefile             |   2 +-
>>>>>     kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
>>>>>     kernel/bpf/helpers.c            |   6 +
>>>>>     kernel/bpf/syscall.c            |   3 +-
>>>>>     kernel/bpf/verifier.c           |  14 +-
>>>>>     kernel/cgroup/cgroup.c          |   4 +
>>>>>     kernel/trace/bpf_trace.c        |   4 +
>>>>>     scripts/bpf_doc.py              |   2 +
>>>>>     tools/include/uapi/linux/bpf.h  |  39 +++++
>>>>>     13 files changed, 398 insertions(+), 3 deletions(-)
>>>>>     create mode 100644 kernel/bpf/bpf_cgroup_storage.c
>>>>
[...]
