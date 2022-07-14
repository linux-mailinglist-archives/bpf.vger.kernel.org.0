Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5AF575416
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 19:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbiGNRd5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbiGNRd4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 13:33:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0212620F4C
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 10:33:52 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26EHVAZg002016;
        Thu, 14 Jul 2022 10:33:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ec1XCbAfYpa5e6C2CZSG5Va4u8rHISae8Z8WWhfXVec=;
 b=YUmdXKq29jh5myk0v9ZW0dsl8vnj1NidN6QiKDS4BvJjkA+oT/dsklhYZhAe649tsyvF
 F6J6iV4aKH672rZUhoe1nxBG97LK5+5T91/iQA4fzekHTilfQYltMxGmfSNo1OThV4+X
 wC9IgJa3ymoVuhAQcrUDO/GbjHvcgJqhLJQ= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hak1525ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 10:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1tlm+XYbEBU9i5Ov5vXkG1EKh8wWCuVlnf5feMJjs7TDT7e6qJFKSPmT0MIyunQJhFqQNopxQWnJAECpKxFYK3/oRh4CTTKsyLXS+/8uPJ2qjn9PG1lCYTUNM9B72vtG3m9bnF3rtqAl7M69CMpOZywiHP34aKpwLvZITJCJ9lUGFifo6CvYMjZjhz3NMm+/760C61/O2/P9u7DZEm8oE/FknTVFBqTJr/mdDjr3Z0OdCKd+gWRf45y9cHPumwc+nUERFyzWRQfznM9n8lGGDWNvrHxVfyiE545zx3XIOlZr0uY9ql3W7MwE6N72ruZ2Ki5kjFJ/AApLY9D/tu1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec1XCbAfYpa5e6C2CZSG5Va4u8rHISae8Z8WWhfXVec=;
 b=V3j/Rq8r7UCmAPkIeMt1qsAREw/aD92lJADjTSX5UldpbBx4SxfJ7cFTpxr9QcU+kdFIrP9eCVQ0vdDslN0KPSex37wayblMSG+Kfgji4Dm4rKeRyTBPdTJa3XWx48Emne3oku02PB88VoqrtTgAqwwFUKqpINDiaokLTyNRfNa3jvZtUV3UlNsXS6C9ngAeWmZW/0fJ761giZLNMvMrw2MRAiIfwT+I2aFi7+ZHWZmX7xyJfRGNWL/C10qFf71/cRDOl95BbpuM6SITBLr0LhKUPC6D7xGvUW657u1i6i5UssGB5AztDFMCtEfQhuvfBelqC0CQO57IckaIX1nczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BN6PR15MB1922.namprd15.prod.outlook.com (2603:10b6:405:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 17:33:36 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fd66:dd28:8a01:821d]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fd66:dd28:8a01:821d%6]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 17:33:36 +0000
Message-ID: <deb5310a-5ff5-0612-61f2-90d78a0bb147@fb.com>
Date:   Thu, 14 Jul 2022 13:33:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] bpf: Add kptr_xchg to may_be_acquire_function
 check
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, kafai@fb.com
References: <20220713234529.4154673-1-davemarchevsky@fb.com>
 <CAP01T74k86cwBk22M=YgY=Vao196_wDezvmHjk5u_Nry98A6hQ@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAP01T74k86cwBk22M=YgY=Vao196_wDezvmHjk5u_Nry98A6hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a0f63bf-af36-46e4-b1f8-08da65befb70
X-MS-TrafficTypeDiagnostic: BN6PR15MB1922:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4+yX7uw9bYD2FtWoLrSUzLwXJ5abk/9CvP/FOfHEysGc+kugfJNBpHXA9Z1S9QQ5m/Zz9y1mWsCkXVGkfP3ezGSgttJBFK60vnGul+0i4IfM0TARovBD7Xeduza93V6iVoYkd65ChRU2ZqARF06JRy6Lgdz5OtTKL9VtYHUB07ksuBV+uyuto2QgwHAtt5Yf7ysWBJg4/Nn0WDH8zFIqYBe93JLLfgPa/DAc7QR5yexBLzTTN4HZy5K76gjQ6jIVtRNttodnIcaMYXRJRcqojxEheIS+9OcJgcL//DvYo5GHZmj1DTWZUDdIAU8OdY4+8LKnwW+J6h6qvqvViIEDCV2gZ4xAPfSf2lzpi622JLRGq9XkMYaHfdZzBqF6GcDUItpCPpN/Q3aZOs7Mh8F86kiBNNvhVJCqYh0LlCdalUgCjeNWydAXZcSBt5coquKzqamHHKWs82jV+RtPTGpvKfH5bWGgRMeud+fScMBNCMZxszsLPBhdlxgz5hkyRViO87ImBL9ax9EmQ3QUQ7E6P9PfjQcnPUGbU9sR8qo8FzlZraLK/2XMM5aMWTaYNk6Hv+G5pRSYq+4/4B7IIqe6balwgIujwhnzjVbKJHu80BoNm+O0fa5KxUtzKpRVH0aVweOGbPUx2Md9BjUfG8RhvWtJPw/zyrTKfuPrvgopVR1h9X4T0ojYT6tcCKqN3d+XrU1OFNSziq9mPNmAHkz+Vu0eBBhqpb39HOmgMAXXQwhMtWeFGvN48CXVobXhjbB7IeW+V4/45JPiQbdeFEKd8H/gcSVvnBrLsOarGbZTJXpitTimWgC/hoEIRGGWgnYirNtqTIBCdS4RrbaDbBuBfQoA+lmYa5+oL94JKM9fOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(83380400001)(31696002)(36756003)(86362001)(31686004)(38100700002)(186003)(2616005)(66476007)(41300700001)(66946007)(66556008)(478600001)(53546011)(4326008)(6506007)(6486002)(6916009)(54906003)(316002)(2906002)(6512007)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGQrNHd2SkhHVWpqQlhWNXJISTlwQWJTclJ5aXZDZ1E0RUJzbkpkMG8vbG9M?=
 =?utf-8?B?bzJqcld5R0JXVTBPcWk3ek5yWDZTWCtEbFcxVU9TNUhXckVPaENEZjZ5czQ5?=
 =?utf-8?B?R0hXVmhjRGY2NVZPNTBUbnZaWU5UY1BQU2VrUFUzb3BFanN2MXlkTi90VFpu?=
 =?utf-8?B?UWlsYjdKL0w0VXY3UHNRY3YveDFNczBBWXoycGx0V2ZwMGNDRnVlNXZUS2RL?=
 =?utf-8?B?K0s1bVVyeEFMczY2UHlDa29HRGdCZGhsc3ZlYkhTc2hDbnd2V2txOXlva3l3?=
 =?utf-8?B?a0pXSFBIeVAxY0krRG5FTXA2NmNoSHcrTnNlckZtNEs0eEI2d09pRHFyZmhJ?=
 =?utf-8?B?Rms0blZBQzAzTWFkR3o5QlYxQWVZcXhJS2Q5M09hWkN1eGRHWGxTc1NEUGdj?=
 =?utf-8?B?Z2JkZDZwR0JqN09DOXVNdU5yaHdNV3RkVkJiRjR2QVFEU0xlV0NRNUlxVk1q?=
 =?utf-8?B?cEFZbEJPeDFhV3VYcEkzbVBXU0l1SXRWU0toQzFKb212S0NHU0tpMVJJRFFZ?=
 =?utf-8?B?RFN2eld6Znc5MmsrUGpOYTVQbmFCSE9teFdJd2Vxd1prMUtFQ2ZYSXF1TDg4?=
 =?utf-8?B?YWVWM2dKYUlIeWx4RXB4dWx6YkdHdU45c3FPT2xDOG1SZHJtTzFYeEcxdmVa?=
 =?utf-8?B?UW42V3oyTGxlZ2VJK2NIUjB6S0NGTWZpeU5KS2doY3FYaTB3TGRQMlBUQnhs?=
 =?utf-8?B?SnNaeWVtLzl3MXQxejJIZi9nM05JYS9NRVoyTzZ2WFRBZThPNTArenVKUjlY?=
 =?utf-8?B?R1JvV01YSXQ5Mm9GU1FrYnZ1bkF2RU5PUGxOaU9DbHNGWjhwRUxjTGhJdUdP?=
 =?utf-8?B?b3p3YTdkOUlIdmdIbW0ySlpCS1hBb0dLcTcxVFl4MnprTFNOQ1J0T3pEbHVS?=
 =?utf-8?B?Y2JLREYxSkpkSXJkaEp0dXBmZnBkSG1aa0ErcHM2VUJwVUY5OUIrR3RHRFNt?=
 =?utf-8?B?ZWdXQkh2SytwMTJPS2pUVldjandxenFPVnlaQU1vWHpmcWpSem1zV3ZSVExV?=
 =?utf-8?B?amhOdTkvUFd4SGM0Yzludk94R09RMENzQ09TckRORkw0anJpS3JjRUl0SzQ0?=
 =?utf-8?B?dzVFektqOHB6eElwbThhQ0ZvNkhqY3JYVVBPTUlKdGlJUlZhWm1MSHg3OWxi?=
 =?utf-8?B?endUakM4ZHp3b2JmK2JvZFgveGpFL1NFbE9xREdFVzQ4M1F0MXhudy95SXVx?=
 =?utf-8?B?RWYreVJLenoySFp3UlN0Zi81aXMrNEk4QlF1SnYvaHl5SjNYNGtBK2V0Z2hR?=
 =?utf-8?B?VFZtZG5uaDZTeUlYNzhMLzRnc3Byc09KQzlHQytCeHRvVkhYVFdPcmNMVjA5?=
 =?utf-8?B?dDhTWlB2MlB0U3U5VDRobnhrSmpwS0RmbCtvUEpQazNmR2lZMC9KVWxBYjdm?=
 =?utf-8?B?UUp6Wm5OVlB6TDROQjd5Q0hobldTNmJmelB1b3pwNTJMVFR2ck10a2hpWWow?=
 =?utf-8?B?NGlaUlhyU2Rma2ovczZsaDZBeWtHSXRQdUtqcWh5YlVkVm9PT1Y0UlpJWlJa?=
 =?utf-8?B?RVJLVVI2WTZEaFpYQXkzWTNLSEpCb0tnWUdycVhKeFhlZE1NcFBqTm5uNndn?=
 =?utf-8?B?SXFhYkdSMHVpenVYZ3FFYWFwQm9FRUJFVHl1a2hRYzZtVDkxWEJzRnhiclQx?=
 =?utf-8?B?Q1JscjFKU1N0d2x3SW82TkJMb0cwdnM1aFA1Ry9ieGx6a0RsRXRNblU4WUtK?=
 =?utf-8?B?TlpocFBWazZRVkFERDc1N09GQ21XUnpiZllQVG12MTRTR2Y4OG4wN01iMzFa?=
 =?utf-8?B?UEYwYWNBWHFaa211RCtoSDZtSzNOVjg1MllTOW5NcjZlYndJQ3RvdGtNalVN?=
 =?utf-8?B?dkhjUkM0U1hscWdiZkp6azJZNnhEUUlwbHZacHgwaXZtd3B0enVRQWwyOVlC?=
 =?utf-8?B?cG8vdGJwaWlGbW5udGlPaGlDOU5hWlFaSXd5NHFDeFk4SUR0bGQ4S1lDRzN4?=
 =?utf-8?B?QldCY1VmN3RYU3RLcFMrR21xcmwxWGFXWnBvSk1MbFppblg4TEZWMnVKeFJY?=
 =?utf-8?B?VzM1ZjF1bzdsOFFDL2NOd2hGLzFERmh1dExYMHRrcVR3MEluMTdob2xpMHEr?=
 =?utf-8?B?dlFPQXhCUXU0YnIwa2I1ckt4bys0Y01uR2kwUmRYUVJYSXIvVytVeFBlSUdI?=
 =?utf-8?B?Q1JEc3dINUNBZnpJWHRXM1hnZG85cE91RnJtTlNRT0ZPNkVMenREd0JjdURU?=
 =?utf-8?Q?BYyFGfpcEduTXa7iWbV6owg=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0f63bf-af36-46e4-b1f8-08da65befb70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 17:33:36.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDbD3veiNJOzUVbOvjDLKr+jhTu/0VpQkQ2IIGljJBkAc2eYN7iIrrRgaRVq5+51eLqDjgtEuMpIp749y4+YUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1922
X-Proofpoint-ORIG-GUID: zL4UPPOGNKoE56jmAHOzRyy-nY0tWsJv
X-Proofpoint-GUID: zL4UPPOGNKoE56jmAHOzRyy-nY0tWsJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_15,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/14/22 2:30 AM, Kumar Kartikeya Dwivedi wrote:   
> On Thu, 14 Jul 2022 at 01:46, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> The may_be_acquire_function check is a weaker version of
>> is_acquire_function that only uses bpf_func_id to determine whether a
>> func may be acquiring a reference. Most funcs which acquire a reference
>> do so regardless of their input, so bpf_func_id is all that's necessary
>> to make an accurate determination. However, map_lookup_elem only
>> acquires when operating on certain MAP_TYPEs, so commit 64d85290d79c
>> ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH") added the
>> may_be check.
>>
>> Any helper which always acquires a reference should pass both
>> may_be_acquire_function and is_acquire_function checks. Recently-added
>> kptr_xchg passes the latter but not the former. This patch resolves this
>> discrepancy and does some refactoring such that the list of functions
>> which always acquire is in one place so future updates are in sync.
>>
> 
> Thanks for the fix.
> I actually didn't add this on purpose, because the reason for using
> the may_be_acquire_function (in check_refcount_ok) doesn't apply to
> kptr_xchg, but maybe that was a poor choice on my part. I'm actually
> not sure of the need for may_be_acquire_function, and
> check_refcount_ok.
> 
> Can we revisit why iit is needed? It only prevents
> ARG_PTR_TO_SOCK_COMMON (which is not the only arg type that may be
> refcounted) from being argument type of acquire functions. What is the
> reason behind this? Should we rename arg_type_may_be_refcounted to a
> less confusing name? It probably only applies to socket lookup
> helpers.
>

I'm just starting to dive into this reference acquire/release stuff, so I was
also hoping someone could clarify the semantics here :).

Seems like the purpose of check_refcount_ok is to 1) limit helpers to one
refcounted arg - currently determined by ﻿arg_type_may_be_refcounted, which was
added as arg_type_is_refcounted in [0]; and 2) disallow helpers which acquire
a reference from taking refcounted args. The reasoning behind 2) isn't clear to
me but my best guess based on [1] is that there's some delineation between
"helpers which cast a refcounted thing but don't acquire" and helpers that
acquire. 

Maybe we can add similar type tags to OBJ_RELEASE, which you added in
[2], to tag args which are casted in this manner and avoid hardcoding
ARG_PTR_TO_SOCK_COMMON. Or at least rename ﻿arg_type_may_be_refcounted now that
other things may be refcounted but don't need similar casting treatment.

  [0]: fd978bf7fd31 ("bpf: Add reference tracking to verifier")
  [1]: 1b986589680a ("bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue related to bpf_sk_release")
  [2]: 8f14852e8911 ("bpf: Tag argument to be released in bpf_func_proto")

>> Fixes: c0a5a21c25f3 ("bpf: Allow storing referenced kptr in map")
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>
>> Sent to bpf-next instead of bpf as kptr_xchg not passing
>> may_be_acquire_function isn't currently breaking anything, just
>> logically inconsistent.
>>
>>  kernel/bpf/verifier.c | 33 +++++++++++++++++++++++----------
>>  1 file changed, 23 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 26e7e787c20a..df4b923e77de 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -477,13 +477,30 @@ static bool type_may_be_null(u32 type)
>>         return type & PTR_MAYBE_NULL;
>>  }
>>
>> +/* These functions acquire a resource that must be later released
>> + * regardless of their input
>> + */
>> +static bool __check_function_always_acquires(enum bpf_func_id func_id)
>> +{
>> +       switch (func_id) {
>> +       case BPF_FUNC_sk_lookup_tcp:
>> +       case BPF_FUNC_sk_lookup_udp:
>> +       case BPF_FUNC_skc_lookup_tcp:
>> +       case BPF_FUNC_ringbuf_reserve:
>> +       case BPF_FUNC_kptr_xchg:
>> +               return true;
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>>  static bool may_be_acquire_function(enum bpf_func_id func_id)
>>  {
>> -       return func_id == BPF_FUNC_sk_lookup_tcp ||
>> -               func_id == BPF_FUNC_sk_lookup_udp ||
>> -               func_id == BPF_FUNC_skc_lookup_tcp ||
>> -               func_id == BPF_FUNC_map_lookup_elem ||
>> -               func_id == BPF_FUNC_ringbuf_reserve;
>> +       /* See is_acquire_function for the conditions under which funcs
>> +        * not in __check_function_always_acquires acquire a resource
>> +        */
>> +       return __check_function_always_acquires(func_id) ||
>> +               func_id == BPF_FUNC_map_lookup_elem;
>>  }
>>
>>  static bool is_acquire_function(enum bpf_func_id func_id,
>> @@ -491,11 +508,7 @@ static bool is_acquire_function(enum bpf_func_id func_id,
>>  {
>>         enum bpf_map_type map_type = map ? map->map_type : BPF_MAP_TYPE_UNSPEC;
>>
>> -       if (func_id == BPF_FUNC_sk_lookup_tcp ||
>> -           func_id == BPF_FUNC_sk_lookup_udp ||
>> -           func_id == BPF_FUNC_skc_lookup_tcp ||
>> -           func_id == BPF_FUNC_ringbuf_reserve ||
>> -           func_id == BPF_FUNC_kptr_xchg)
>> +       if (__check_function_always_acquires(func_id))
>>                 return true;
>>
>>         if (func_id == BPF_FUNC_map_lookup_elem &&
>> --
>> 2.30.2
>>
