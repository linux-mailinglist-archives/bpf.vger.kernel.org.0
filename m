Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3352F8E2
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 07:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiEUFWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 May 2022 01:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiEUFWp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 May 2022 01:22:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9846B37
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 22:22:44 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24L3Xoas019726;
        Fri, 20 May 2022 22:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QDlPpV09kqE4TpGEtWW2fA9MbwwhvPK/YHberaBQb+s=;
 b=ROTffXdnDCQfRt2pztzkbsgQlrniGiLUWeNsw9IteD6H7Ga6eey/TcAslLfTlwqoPiLi
 7HkUAXN4g8MgoNHjY4BtFUx7eA75DTnYv9TV1/R9E7pgHPJ5jVrXEagSNoc3qWHYhaDh
 FaWXm988E2r8rG/LFBotSUzmwxYpGyQpdXg= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g5xexgrf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 22:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuI7fNpTmL74yDcSFhR/c5NXjonq3BwtXqziXzCQYdmRKoBptAwy2f6YiCDJ1XdjQXkYH+y/0ezrlUKOJY+Aj44fXydgmZX6e3TbxrrHdjW/LzlFT2Z83Zvvuwus+7hNGyKrkFvNn1GkyFbbfaoyqwViz5mTE057Yh6n/gW61oVNTNU6fLK8oEzBts8vUZGSbNX+eIrlAMI4MsUazvlYf/DfdtVOhdNFfi34v+EQBuPnH7t0j5GT1PRhiZBTERHkKpZwoXu1A0L+ftD6cg4Wd8RXHs9ZBnQgwaNHaCqFsadDteY80NVzps760anRyR9eUdRlTg3i4Jbqm46CUca8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDlPpV09kqE4TpGEtWW2fA9MbwwhvPK/YHberaBQb+s=;
 b=chGAMZlwVU05COizLZmGA4Yt6j7KlYzW4lNmDWsnzEFNQPvxyc446kuwM1sSmG8nEzd8EeXvK7WQy5IFZvYOzG69l7e5pEgMQkn7ySBhPMVsm9Rgh3/EgJDiQ3ark7u0/LzuJd5BRm5ens2Mau5zMdBAhbrSqoZwxbh1Q5AqmmgERlplJovrJpr4ANx/0ZURaKoKVzp0IqTKPozKlWOze4f7SB5YJgVd2qDPMLx4tDVd+GJELPglaqEvkWlx0XSzHTIEHrDJJZHiVoZr+Ccw94LJgS1ztgdtSQwnaXQR1kgrvUfOJuuuHJ7crUErYh6cTowtAtvkxaOaf43drJXQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SJ0PR15MB5132.namprd15.prod.outlook.com (2603:10b6:a03:425::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Sat, 21 May
 2022 05:22:22 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%8]) with mapi id 15.20.5273.017; Sat, 21 May 2022
 05:22:22 +0000
Message-ID: <2daebb4f-eb00-b536-85d0-985079a5ee1c@fb.com>
Date:   Sat, 21 May 2022 01:22:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
References: <20220518035131.725193-1-davemarchevsky@fb.com>
 <CAEf4BzYw-wKk8Wu2KEMi=tiP6akxQa4cjHwCYCvWDipkwy2SWg@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAEf4BzYw-wKk8Wu2KEMi=tiP6akxQa4cjHwCYCvWDipkwy2SWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c96ec9b5-acf0-4f17-5f4a-08da3ae9e207
X-MS-TrafficTypeDiagnostic: SJ0PR15MB5132:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB5132DA6070DBD11613873239A0D29@SJ0PR15MB5132.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTlZa6TvcQhWymcpenyhv9NKNF6M+Vy2KAmXIw4NKcVgnVQHKLVsouCk2gg1niD7l4F6MjKNzkrq5JDc6idedT3E6pWNO1559RuVboy9MnmvJicaegWAfu2L0PiMZ8Oi057lbzZxJS2fSGFiW+Hm2QyW+szJPe95Egs3qFcvy2/N+hSL6raWk6UWiHj/LfWJt9cW9EH7NoRIzqt51YcG4LHPHudWx29lw8Xu62UffWgJ72eLK+q4uZg0IDXdKaqa4q+KgNS7hk79gLlIgiduZ+JBH4XEgx5R2Vcdt5Q8L/9ay3zwT1eYML2l8ULmrUn5gS92gkQGJFzednS6HZql5KRCQTFw909JBr0w/O8sY7SGIo+/GePZOebounSmbgKdDbc9lBNq6qSnatPz5Haz3W6VjsQ7U7TOk85pS10Cv4hLaeaf0PjSaTRswO/FcgXJrWh3O2336ToKtJMX9cQo8gITbNK41M8py/eJ47RGd4AHT+dvhzITTQ2iU5TrD9v8ccIa45FWjHDq+as02Ob9dzwC2h3TGIunG8XZuTmrNDzslKdSxsqJvRRo7KQv+p1IU0fxUCAHhxeenfRgAUnVhj8yzkLIliOppScZ0eG7cpNfdLWxxYECsAPHgZV7/KxSCMzAgMfzZXmrBhOq24LYuzCSXCMPuulJEfl1Icevu1LdKB0aQC+wFuqabv+HhXT0dRx8gsQMdm0KnVpSZv3nBu1J0fTRFY31iyoX3t/1bA+C3BS0gfWh8k19vkjguqbjNtUr8z0yxKnw0jakuR8ykUH0HxUQ3f0hpXWHl+0VsCHww52Z+a1L5lNvPyzdxjah
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6916009)(54906003)(36756003)(966005)(6486002)(66476007)(8676002)(66556008)(5660300002)(31686004)(31696002)(4326008)(66946007)(316002)(30864003)(508600001)(8936002)(6512007)(83380400001)(2906002)(53546011)(38100700002)(6506007)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3VJRHREcEFGdzJJQ0UwMVVsWDM5eXhCb05GaDRQZlhXeHZJblBWRXBpUERT?=
 =?utf-8?B?Y1RvVGpWa0x5ODRBbjkvRGcxZGwrS1cvMHJLYTFEdjRIc2xYdXZiVllXQ1FW?=
 =?utf-8?B?YVJoemhyaE85WXQzOElrWFdzamUwaVM2Y2tMUytMWmhuT2pOV3B6SXo3ZkpL?=
 =?utf-8?B?QVZibkdFbjkzdExGYlE1MXR6SysySTZMbERhSG44V3VwMk5UK21ybUFhMlNC?=
 =?utf-8?B?VjlDSjVyR1NKS0RDbFFhNXdyZzhRb2NPalQ2OUtqVHB4LzZ0OVVjNzlNSFRk?=
 =?utf-8?B?Mlp1UHEvdklTSXJKbGRUMFV6NkFWakl2dk42S3pMVndKRUI2OFlZNXVOSlhx?=
 =?utf-8?B?SDJ0dk1RcnpIMDF4MjVwRHZoNjNjdUQ3YldEbHVkUThTcUxvSW1ZYU1wVEFX?=
 =?utf-8?B?Y3lSUm93UVFURktwenhXTUZpM3dmeXFWdHB5MEpYME91Y1hueGhXd0tUUWJ3?=
 =?utf-8?B?TUdaMkVHVmFqRVh0VnE3Um1obWVKNitoUVU2T1prU24rUjV1Uk4vMUdrZjZF?=
 =?utf-8?B?bEJ6dUhyYmRscTJ0N09XdVFKRWhYbjlrcDhDc1hTb05TVmRkZkE1TS9STS9p?=
 =?utf-8?B?ZThYbWlTbEw3c3JDcE10YUY2ZUZackpwVFVuWGV6VFdreFdqakkwdUhhbnY0?=
 =?utf-8?B?RHJZUHlyQWlqN3RuNEpjcHJRMFFTUXM5Nloxa3ZiNFRLN055QUJMTHdibXBi?=
 =?utf-8?B?alhsV0dveHkySzcwbGkxeDZGOGFPbDRsWE14RFhoaXNXMlVXV3grNy9RNWp5?=
 =?utf-8?B?eHo5NmJyRHptajRWaGE5QnBRSUhLZm5hZTNSOEtKWHBYeVZ2N3hGSXRYT0l6?=
 =?utf-8?B?ZEF4RGxvcVdBTFIrL1lzVlpib2xnWE1ybzJzMU5OR2JkQnl0RTNpcTBlU1NK?=
 =?utf-8?B?RUtTWHFtM04zakhtbC9WM1h3c1JLMDdsWWg5NWZ0ZGxzOTRZdUNOTHZmUlZN?=
 =?utf-8?B?V3ZKWm5qSUI5UENoQ0NGZFUwbWxNK3Z0N3Y3RGtqNjJhdTRkbDlsUWFNTkp2?=
 =?utf-8?B?bTFBZElYaXYzSkpSRkpOeFM2OUlIeXpxUWk5eG5CUkhrS2wzNE16WTBOSE9H?=
 =?utf-8?B?cHp0ZFNmem5meDRsR3gxV0RlVlhkWXRTMGRhOG9YY0lNUWVLNGVFYjg5aExo?=
 =?utf-8?B?ZEpDWXNKZzgyZ2llbWE2ZlBmTnpQWE1FWWc1OG56TURmRDhsZEU3VUFmMDI4?=
 =?utf-8?B?eDBmcjZDUDUrb29CRUl1OGNZVXZRaVVQUUg0Q0Y2bDNEVGpFSzVpMlFyMUNX?=
 =?utf-8?B?c1pjOGtCcXdmNGZrRFhWc0VwSnlTcVJEb1JPUjIrMVlZTEwwUmcwMTVOZlpO?=
 =?utf-8?B?aGZDWGRyZzZvRVVFVnNqVGVoOFE4RWhHeVRsaDk0ZVIwWE85QndUaWNSdlIz?=
 =?utf-8?B?c2xOSWFhZzlnbGtYdkhBbVkvN25QMGprTnJDK2gzdTBNdUp6TDZQRERsQXJj?=
 =?utf-8?B?LzJhTFJaVkErWFpXbE5UN25ScitRRVZBcGRiOU8rTk1FcGNZUzJnNDFBRHNv?=
 =?utf-8?B?UTdXajV0dk11MWlmQmJqdWVzazdBU1pjRDdha24rSmlYdEQ1ODFwek90aUo0?=
 =?utf-8?B?dUcwY0FLYStZMmMxM3A4QzN2OFNiWStQc0YzUEFSR2txQ2pOWE1iRWFZdU0x?=
 =?utf-8?B?RlRpNk9pUG5SelBwRHhxR2lOa0FGLzd1YU5IYUMwV0QyemQ2WmQ1LytjK1l5?=
 =?utf-8?B?eXM4VllRb1R3ZU10SUZ1YjN4NGFtbkdTUzB5eDZ5NnlJN3pSK252WHpUR2xV?=
 =?utf-8?B?aVBsLzVBNXJQejdUM0tEbXRiZ3Jsd3VJdUxNYnEzbHMzUkRlSFNmWlZLNDJu?=
 =?utf-8?B?WWNwOW0renFDbGtaaVdRaEtBWmE2cytpalNuQW1wbS9rRWZyZXlVRjQ0UU9a?=
 =?utf-8?B?MXBMYXo5L1RCTkROY2lPbk1QcjBFZnFiSmJzYURmK0RNZHFnamwvUDdSMndk?=
 =?utf-8?B?V2NLRVUzMzQxYVBVSDhKNzg1VmVpTWJCUmp0WXJXUUN0czlpUHN6ZGcxV0Zx?=
 =?utf-8?B?c1lLUUo3Z2NQdlMvQVphbFhESmFydS9KWlppT2g1S2d1RmlabDZtcGZZSFZQ?=
 =?utf-8?B?d0Z4NDk0ckxMcExKZmQ0UzI0SGFIZ040emJMQ2RrTG5iTVl2NnIyTkJid002?=
 =?utf-8?B?TE82ZmpEZGFWNDFwZjRPUktTbExCa1pkekNrczdDajE3TFAvZHBVZ0YrSHRB?=
 =?utf-8?B?a0pZbUY4VERCbllIbWc1Y3A1eDRBYjJjWHNTUzlKSm5wUXBzSXdlc3pyQ2Jz?=
 =?utf-8?B?T1Q2WFMwYWl4LzhZS3R6TG1MTFNPM0h4QW5Qd0x6eWdOcGVuOFIwU1hYT08z?=
 =?utf-8?B?bWlHMC9EWWgwVk1Vd0ZWclY3NDd5MUJlOTJnK2x3TzJtd1BIYXB4Mk14a215?=
 =?utf-8?Q?j7iuFw9PShv7Z1UMPcjrlQsRNBPJA44BoM3Da?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96ec9b5-acf0-4f17-5f4a-08da3ae9e207
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 05:22:22.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyKjGsjUfeljzWDvwe1bRYLeSsQIpakr7gSfg2y7Z4TBE1sb3NFf/7Sz2NBxm1NL54WUp3ddoxmqwK34LErKGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5132
X-Proofpoint-ORIG-GUID: 4QVzy5HjJtSztrtfPAd48xJ1ttdq3nby
X-Proofpoint-GUID: 4QVzy5HjJtSztrtfPAd48xJ1ttdq3nby
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_08,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/20/22 8:41 PM, Andrii Nakryiko wrote:   
> On Tue, May 17, 2022 at 8:51 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> Add a benchmarks to demonstrate the performance cliff for local_storage
>> get as the number of local_storage maps increases beyond current
>> local_storage implementation's cache size.
>>
>> "sequential get" and "interleaved get" benchmarks are added, both of
>> which do many bpf_task_storage_get calls on sets of task local_storage
>> maps of various counts, while considering a single specific map to be
>> 'important' and counting task_storage_gets to the important map
>> separately in addition to normal 'hits' count of all gets. Goal here is
>> to mimic scenario where a particular program using one map - the
>> important one - is running on a system where many other local_storage
>> maps exist and are accessed often.
>>
>> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
>> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
>> bpf_task_storage_gets for the important map for every 10 map gets. This
>> is meant to highlight performance differences when important map is
>> accessed far more frequently than non-important maps.
>>
>> A "hashmap control" benchmark is also included for easy comparison of
>> standard bpf hashmap lookup vs local_storage get. The benchmark is
>> identical to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
>> instead of local storage.
>>
>> Addition of this benchmark is inspired by conversation with Alexei in a
>> previous patchset's thread [0], which highlighted the need for such a
>> benchmark to motivate and validate improvements to local_storage
>> implementation. My approach in that series focused on improving
>> performance for explicitly-marked 'important' maps and was rejected
>> with feedback to make more generally-applicable improvements while
>> avoiding explicitly marking maps as important. Thus the benchmark
>> reports both general and important-map-focused metrics, so effect of
>> future work on both is clear.
>>
>> Regarding the benchmark results. On a powerful system (Skylake, 20
>> cores, 256gb ram):
>>
>> Local Storage
>> =============
> 
> [...]
> 
>>
>> Looking at the "sequential get" results, it's clear that as the
>> number of task local_storage maps grows beyond the current cache size
>> (16), there's a significant reduction in hits throughput. Note that
>> current local_storage implementation assigns a cache_idx to maps as they
>> are created. Since "sequential get" is creating maps 0..n in order and
>> then doing bpf_task_storage_get calls in the same order, the benchmark
>> is effectively ensuring that a map will not be in cache when the program
>> tries to access it.
>>
>> For "interleaved get" results, important-map hits throughput is greatly
>> increased as the important map is more likely to be in cache by virtue
>> of being accessed far more frequently. Throughput still reduces as #
>> maps increases, though.
>>
>> Note that the test programs need to split task_storage_get calls across
>> multiple programs to work around the verifier's MAX_USED_MAPS
>> limitations. As evidenced by the unintuitive-looking results for smaller
>> num_maps benchmark runs, overhead which is amortized across larger
>> num_maps in other runs dominates when there are fewer maps. To get a
>> sense of the overhead, I commented out
>> bpf_task_storage_get/bpf_map_lookup_elem in local_storage_bench.h and
>> ran the benchmark on the same host as 'real' run. Results:
>>
>> Local Storage
>> =============
> 
> [...]
> 
>>
>> Adjusting for overhead, latency numbers for "hashmap control" and "sequential get" are:
>>
>> hashmap_control:     ~6.8ns
>> sequential_get_1:    ~15.5ns
>> sequential_get_10:   ~20ns
>> sequential_get_16:   ~17.8ns
>> sequential_get_17:   ~21.8ns
>> sequential_get_24:   ~45.2ns
>> sequential_get_32:   ~69.7ns
>> sequential_get_100:  ~153.3ns
>> sequential_get_1000: ~2300ns
>>
>> Clearly demonstrating a cliff.
>>
>> When running the benchmarks it may be necessary to bump 'open files'
>> ulimit for a successful run.
>>
>>   [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@fb.com
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>> Changelog:
>>
>> v1 -> v2:
>>   * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
>>     configurable # of maps (Andrii)
>>   * Add hashmap benchmark (Alexei)
>>         * Add discussion of overhead
>>
> 
> [...]
> 
>> +
>> +/* Keep in sync w/ array of maps in bpf */
>> +#define MAX_NR_MAPS 1000
>> +/* Keep in sync w/ number of progs in bpf app */
>> +#define MAX_NR_PROGS 20
>> +
>> +static struct {
>> +       void (*destroy_skel)(void *obj);
>> +       int (*load_skel)(void *obj);
>> +       long *important_hits;
>> +       long *hits;
>> +       void *progs;
>> +       void *skel;
>> +       struct bpf_map *array_of_maps;
>> +} ctx;
>> +
>> +int created_maps[MAX_NR_MAPS];
>> +struct bpf_link *attached_links[MAX_NR_PROGS];
>> +
> 
> static?

I sent v3 before seeing this email, but luckily most of your comments are
addressed already. 

attached_links is removed in v3, created_maps is moved to ctx

> 
> 
>> +static void teardown(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < MAX_NR_PROGS; i++) {
>> +               if (!attached_links[i])
>> +                       break;
>> +               bpf_link__detach(attached_links[i]);
>> +       }
>> +
>> +       if (ctx.destroy_skel && ctx.skel)
>> +               ctx.destroy_skel(ctx.skel);
>> +
>> +       for (i = 0; i < MAX_NR_MAPS; i++) {
>> +               if (!created_maps[i])
>> +                       break;
>> +               close(created_maps[i]);
>> +       }
>> +}
>> +
> 
> Wouldn't all this be cleaned up on bench exit anyway?.. We've been
> less strict about proper clean up for bench to keep code simpler.

It's important to explicitly clean up created_maps because local_storage maps
are assigned a cache slot when the map is created, and count of "how many maps
are assigned to this cache slot" is incr'd. On map free the count is decr'd.

So cache behavior of subsequently alloc'd maps can be affected if these are kept
around.

Not a big deal now since just 1 bench is run and process exits, but if that
changes in the future I don't want the benchmark to silently give odd results.

> 
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench.h b/tools/testing/selftests/bpf/progs/local_storage_bench.h
>> new file mode 100644
>> index 000000000000..b5e358dee245
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/local_storage_bench.h
>> @@ -0,0 +1,69 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +       __uint(max_entries, 1000);
>> +       __type(key, int);
>> +       __type(value, int);
>> +} array_of_maps SEC(".maps");
> 
> you don't need setup_inner_map_and_load and load_btf, you can just
> declaratively have two ARRAY_OF_MAPS, one using inner hashmap and
> another using inner task_local_storage. Grep for __array in selftests
> to see how to declaratively define inner map prototype, e.g., see
> test_ringbuf_multi.c. With the below suggestion one of do_lookup
> flavors will use array_of_hashes and another will use
> array_of_storages explicitly. From user-space you can create and setup
> as many inner maps as needed. If you need btf_id for value_type_id for
> inner map, see if bpf_map__inner_map() would be useful.
> 

Declaratively specifying an inner task_local_storage map will result in libbpf
creating such a map to pass as the inner_map_fd, no? This will have same
effect on cache_idx assignment as my previous comment. 

>> +
>> +long important_hits;
>> +long hits;
>> +
>> +#ifdef LOOKUP_HASHMAP
> 
> why #ifdef'ing if you can have do_lookup_hashmap and
> do_lookup_task_storage and choose which one to call using read-only
> variable:
> 
> const volatile bool use_hashmap;
> 
> just set it before load and verifier will know that one of do_lookup
> flavors is dead code

I want it to be obvious that the hashmap part of the benchmark is not a flavor
of local_storage, the distinct separation of do_lookups here makes this easier
to notice.

Can do a v4 addressing this if you feel strongly about it.

> 
>> +static int do_lookup(unsigned int elem, struct task_struct *task /* unused */)
>> +{
>> +       void *map;
>> +       int zero = 0;
>> +
>> +       map = bpf_map_lookup_elem(&array_of_maps, &elem);
>> +       if (!map)
>> +               return -1;
>> +
>> +       bpf_map_lookup_elem(map, &zero);
>> +       __sync_add_and_fetch(&hits, 1);
>> +       if (!elem)
>> +               __sync_add_and_fetch(&important_hits, 1);
>> +       return 0;
>> +}
>> +#else
>> +static int do_lookup(unsigned int elem, struct task_struct *task)
>> +{
>> +       void *map;
>> +
>> +       map = bpf_map_lookup_elem(&array_of_maps, &elem);
>> +       if (!map)
>> +               return -1;
>> +
>> +       bpf_task_storage_get(map, task, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +       __sync_add_and_fetch(&hits, 1);
>> +       if (!elem)
>> +               __sync_add_and_fetch(&important_hits, 1);
>> +       return 0;
>> +}
>> +#endif /* LOOKUP_HASHMAP */
>> +
>> +#define __TASK_STORAGE_GET_LOOP_PROG(array, start, interleave) \
>> +SEC("fentry/" SYS_PREFIX "sys_getpgid")                        \
>> +int get_local_ ## start(void *ctx)                             \
>> +{                                                              \
>> +       struct task_struct *task;                               \
>> +       unsigned int i, elem;                                   \
>> +       void *map;                                              \
>> +                                                               \
>> +       task = bpf_get_current_task_btf();                      \
>> +       for (i = 0; i < 50; i++) {                              \
> 
> I'm trying to understand why you didn't just do
> 
> 
> for (i = 0; i < 1000; i++) { ... }
> 
> and avoid all the macro stuff? what didn't work?
> 
> 
>> +               elem = start + i;                               \
>> +               if (do_lookup(elem, task))                      \
>> +                       return 0;                               \
>> +               if (interleave && i % 3 == 0)                   \
> 
> nit % 3 will be slow(-ish), why not pick some power of 2?

Few reasons:

1) This results in a ratio of "get important map" to "get any other map" closest
to v1 of this patchset, and similar interleaving pattern. Made it easy to
compare results after big refactor and be reasonably sure I didn't break the
benchmark.

2) The current local_storage cache has 16 entries and the current
cache slot assignment algorithm will always give the important map cache_idx
0 since it's created first. Second created map - idx 1 in the ARRAY_OF_MAPS -
will get cache_idx 1, etc, so for this benchmark
cache_idx = map_of_maps_idx % 16. (Assuming no other task_local_storage maps
have been created on the system).

We want to pick a small number because in 'important map' scenario the
important map is accessed significantly more often than other maps. So < 16.
Considering current implementation with fixed cache_idx, if we pick a power
of 2 that's < 16, there will always be the same 'gap' between important
map get and other map gets with same cache_idx. We care about these specifically
since they'll be knocking each other out of cache slot. 

If an odd number is used the gaps will vary, resulting in a benchmark more 
closely mimicing "bunch of unrelated progs accessing maps in arbitrary order,
with one important prog accessing its map very frequently".

Probably moving to bpf_get_prandom or some userspace nondeterminism to feed
list of indices to interleave gets of important map is the best solution,
but I'm hoping to keep things simple for now.

> 
>> +                       do_lookup(0, task);                     \
>> +       }                                                       \
>> +       return 0;                                               \
>> +}
>> +
>> +#define TASK_STORAGE_GET_LOOP_PROG_SEQ(array, start) \
>> +       __TASK_STORAGE_GET_LOOP_PROG(array, start, false)
>> +#define TASK_STORAGE_GET_LOOP_PROG_INT(array, start) \
>> +       __TASK_STORAGE_GET_LOOP_PROG(array, start, true)
> 
> [...]
> 
>> +
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 0);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 50);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 100);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 150);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 200);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 250);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 300);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 350);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 400);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 450);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 500);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 550);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 600);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 650);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 700);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 750);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 800);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 850);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 900);
>> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 950);
>> +
> 
> all these macro make me sad, I'd like to understand why it has to be
> done this way
> 

Macro and "why not i < 1000" are addressed in v3. v1 of this patch - before your
ARRAY_OF_MAPS suggestion - was hitting MAX_USED_MAPS limit and failing
verification when trying to access all 1k maps in a single program. I assumed
that accessing maps from within an ARRAY_OF_MAPS would trigger similar limit,
but this is not the case.

>> +char _license[] SEC("license") = "GPL";
>> --
>> 2.30.2
>>
