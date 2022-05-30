Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E272F538845
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 22:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiE3UmQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 May 2022 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiE3UmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 16:42:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FC1D326
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 13:42:07 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UFj6dG008144;
        Mon, 30 May 2022 13:41:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gYdtqd3vqAu2ANKO97apfNGxAEE6ZlkNR6jWClGoDSc=;
 b=Mk5MJtXGbLOefFStINGuTEYC52ukErGiwmEWXPB/s/YXTpT8caHkO3TKXYsr/6+y07i5
 euZF/MYw1r71d3LXsMhHzCdbOCtqLa5TwxWZotQXBezgcbgLWPCzd1wLblsbm7mO/X5E
 8JS+/mwiOl3BLE/XWYf6qHCt23k2mgj3MNA= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbhjsa0qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 13:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9JbBpovljH/fc5GDLqiUOdau6WFTjdrpD7WESyKXMDUzw6l5MTKIxv7y9O3gi1mBn3BPVloyZNgGwen3P1UvHdLs/pjuOlnwge3JQDlASRZg40w+YD9O1J5Nd6TDsnIRykfDavPXZgi1wFOKY219P8zeJ6FkGHlOxExjCqp14uL0oWWBg0+aJYmNV1tSmN4noBmEcw936jFDbf1wFgj6UIKe79TZRfKGjAgEyzqpbT7vswHerVgJCc1iJQREYtymkMAQIyosI8duVjBnFRuKgdStkO3e13G4U3+4fUXSD61HYhIlkiFVUJMuixFfcqYobBFjRWBptX0zCr2GvXsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYdtqd3vqAu2ANKO97apfNGxAEE6ZlkNR6jWClGoDSc=;
 b=N8JmD3MZtgug5wfTqbgn3BQCRPouDR2TsOqn3v6Kgi+mNPH0jHCrfvMLDlJcuHKJ9yMG+drPYsCb9oeP3CVuFlGIOEOcNUheKbAa9uZKvml7NTIWDIVpOaI3E6fwcEN5JrLF0VolgI75sqSY7dp9Lm0Z/tPn6/4oetX9p4rEqxH7w0GhA2lrQ5o71Prwij2QaJufGYKnGBv5rDX3QgUqLoljV1GMUfChP0npWv1B64JVmW8ohHCZpgajfcXOqGzbfSxPjWl/LM5mDvICm2o63NI+xP5z1MLBZ2KSkn1HVuGyo8br03S+piY7r18Y2hHz6qRddZhZD0w8NiiaMO0yFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SN6PR15MB2270.namprd15.prod.outlook.com (2603:10b6:805:23::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 20:41:49 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%9]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 20:41:49 +0000
Message-ID: <e407cda9-f523-3b80-2e33-09337a71708d@fb.com>
Date:   Mon, 30 May 2022 16:41:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
References: <20220521045958.3405148-1-davemarchevsky@fb.com>
 <CAEf4BzYbA74HHkNC_tiaUtz3ut2uzBz6nNhJzDNGaVLi9zwFRA@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAEf4BzYbA74HHkNC_tiaUtz3ut2uzBz6nNhJzDNGaVLi9zwFRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:208:fc::21) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd75f384-07cd-41d0-4b8a-08da427cd23c
X-MS-TrafficTypeDiagnostic: SN6PR15MB2270:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2270A6AF89C42BE17A0714B3A0DD9@SN6PR15MB2270.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nu4NupxbEc/6cy9OfZT97jZPYkAFybupkFKwKWOhvegbkspjMQUSmWq97E2JwiEzb5qwAHf8OeBFOtZXXFXnDbSN4s1+HYXge3NPhRupy2OQ/sl7nPdlZ7kVBiNoGagB+Nt3QLm6lK4+L9jyWX81qsRerdF7o6REN1aohTnxRyYGLpH0n+OBpXI0cDTtG54UH1FWWznMAj1taz6R5OPsT7dOp1HyND8MaUDLW2aUYNCslsSK0lnPUhdK3ZArBDfej4f5GmKLmdSUhpXf5MAHCKMMJ5pUzZH1Y+vjUbwHD42MgRb0jWcrYnfP1Sh71BYk4pYZbLOWmbIddgsA1Kp4esscD9sgblrOJLIvjAdKvM1p13PpMfDtCOVqVh2w3ADAdu0KG5+PLq6lBz7DE24NI6tLfIwaPikMbP7uKNnINbHLMOHrnDOIk7u5I2LK0o5P99dGQF0i5ccHJA/2r2V2GnUZrcmPFm8W/QEcDiWwtSkSc5EHksAJ6/6H8YVCumB0Az7VQfPvM3qBy2hfS46e/GuqMWJcifM+UB01UNvwFHW/Ba+QkIeMS2a0nblk6sn5dW0ItTSSBH58PiWbBYIUucddfREttmP7cHQi6in7pOTNIboJy8oxV+WdQ4XqBOPBpt9TTtEX3dvygESBPEFOSTNAvEMCS9AD9oL4AkNPOp802NpSFjbYzOro7GBda8uMrxBJkcDIvqr24Pd1AkUwK8m0xAJ6SpwgVi+r2ZmUklstTY1mE+UDy5fFb0XtOPpFD+PRzVjhHZ3+IieMxS6uRABG9UBSlfepZxFulpS0M6sG9ZhpkttZvHfahnTmNFplzpzhsA6/HMQ90QClwSdK8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(2616005)(66556008)(316002)(4326008)(36756003)(6916009)(8676002)(66476007)(54906003)(83380400001)(31686004)(8936002)(6486002)(31696002)(6506007)(86362001)(508600001)(966005)(53546011)(30864003)(5660300002)(6512007)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emYyTlFVd0dMeS9pVHdiVzJPQy9XZkxnbkFleUtJTlFkMXdKQzBTelNpL3JD?=
 =?utf-8?B?elY3WUFOU1Q1SC9hT2lEMitvREpvd0plWUhBUU9NZWQwak1Sa2diUlJhQVlh?=
 =?utf-8?B?RGgvWFJnSnJGYWdJb1gwVjN2Uy9uVGxKRmxOVW1JdjZPTGxLYjNEQjlrT1Fw?=
 =?utf-8?B?QWhtYTdnaGpOMkw2KzJFaVduRkRjdEJ3U0hvUGFXMENkR2ROVU1PK2hMZURy?=
 =?utf-8?B?RG4zZVF2MW5ZaWVmUFFldUVtSnJqd0ZyM1dlSEY0b0JWNHExZnU4TU10eit1?=
 =?utf-8?B?WUhuVzJna3REc1lxUmNFUEZ0a3NqVUdZVitsL2VuNHpDQW9LU3VuRDVqTmRt?=
 =?utf-8?B?NmtKaVlaTzQyWFRaVTdsRlpKMXRrcVkrNmVUbWFJTzZ0cjlNbzMyYWo3RWYw?=
 =?utf-8?B?MVk2bWFmdnJ4YUZmSFNQdHhXY2tSNnc4bXpXblZVL3pub2dlK2I0THhDTjdp?=
 =?utf-8?B?TW1zejFwcXU3M3hYenFWSXhFdE81SXFLS09WRGtnaFYwMzB6ZGZRZmQzTG9n?=
 =?utf-8?B?clVrMDVZeFlPUVk3WXgzR0tvZ2FZRyt1NjM0ZFVJZG1RUko2RUdCbkVzRlVE?=
 =?utf-8?B?aW9odU04R2pDTjZzcnlVYjV4aGJVL1B2ZWNuYllZd0lrdGpEZzZXWHpsMDJa?=
 =?utf-8?B?aStiV1BwK0gxWkNJSzNxdWpqZDJXK2o2dXJuUlgydEUybnB0ODBtNzNkVEdP?=
 =?utf-8?B?bHAzU1J5ZVQyT0ZFY3QyMGVuc1RGeHBmcld3eFVFQTl4cithZ2JlVEdvbjlD?=
 =?utf-8?B?aEJIQWtId0k5MDR6MWxiY0JXd1NQeE54YUlyYm9rMzhPR0VNTUtyblZBRit5?=
 =?utf-8?B?T1Q5b21XUXZMY2dUT1R0UHNMb3NoQVZVOVRoWmIyM21tdjZ6NGRJMFNXSWNX?=
 =?utf-8?B?eUxrTXcxNFFPWjJ0R1hqTkQ5d1p0cDU3MEVDUHFaMWNHTnhMUk4zMlhLVlAz?=
 =?utf-8?B?ZEZralY1M3BqOUlRaFRYUXE0RzFyMm42WmpkUmtQZlJ1OFlpUHEyQ2tpdU81?=
 =?utf-8?B?bUV1aDZwYUcyMmVWTU9kdzcyNDRtMWZVSnlza2ZEWWV4L0hZdjlFNm5Xd0hL?=
 =?utf-8?B?WEx0MjM4TTdvWklROWxpNVZ0djVIODJrQzE5T3NicVV4TnlrelhMcUlHVGF5?=
 =?utf-8?B?WEMwQ09VZ09rdFNQTFZBaG1LRDhuQmNjVmg3NFZuOXJiOHQzR29KWVJHWWUz?=
 =?utf-8?B?VkYrVUFMRVc0cFFoK3R1QmNyWWNwTzkwMm4vYkw3OHp4OVJETnMyeWdsMFFG?=
 =?utf-8?B?Z1JoMWt4b1BKenFwRzA4cU1Cbzlla1FjQlk0SnRlTndldHJKNmJpQ2lKY29i?=
 =?utf-8?B?UG53cHoxZDNORzJnOHhzeTFwNkd5bTIxK2dmK0dXVTdacFB3eFNCUm12RWtr?=
 =?utf-8?B?ODMvZndvT3RUSDQrYVRSQld0b0xpQVc5WUdpbW1sUDd2SUFZcC92cnJaazBv?=
 =?utf-8?B?RTQ5aWpuVTNVNVNwQXNNTDBuYlNMWVp3SXF1aFdSRUxDeWxqVnp2L0VoS09I?=
 =?utf-8?B?WlpqZVVZYzFQUWFnckx6L1dxbkVadWZYSi9RNEIzRGM2eWlJWHg4RWpOYWVM?=
 =?utf-8?B?VjdWdGQyUi84bXI0UmN1ZzhSK1ZvUnVwcWtZY1FrVmFDSVFKSlUvZTFKYkNQ?=
 =?utf-8?B?Z2FIZ3FUbnEyUC9PeU9OL1daRStOc0JrOVZyV2xXTzRIM1V1SmEwQ1VTOU9k?=
 =?utf-8?B?c2tPdUtUV2MwcHdEdDE4TjBwRFoxU3dlcGtPcmVLaFF4VGt1RkdRY1h0SllS?=
 =?utf-8?B?SlFxTHJQQzRHaUFiYkFCbzdMRWVqVndmbXYweW4wS2JVZDFBd2h0UEhDN0ov?=
 =?utf-8?B?R0VlTENYRkJuTkxSWEhhZEJpa2paNXM2eHd2dEhONTMrcmtwME92NEpETm8z?=
 =?utf-8?B?WFR3ZlpOTUlHZlZkdkpkeHVMZnBxWDMyVXBoa2pVRHYycVJtTGNTL2FiNkh1?=
 =?utf-8?B?VDlobU9NT2FyTHNGMDluVXBtOUUzT24vQ3RhQTFoeVJwUmEzMXhJZ2pLYTdu?=
 =?utf-8?B?Z3U4L3lYRk9sMC80SGVldHI3eDdDajhJOW1jcjhlajdMSUxzVkkzTTloZVIz?=
 =?utf-8?B?aHVhNGNtdTlrbWh3bVJURzF0RGlQZk5jV090WWRGUmJBdXk3YitBV2FoOHJy?=
 =?utf-8?B?bzVqb0ZZeE8rendpdXhpbStUaUMxbEUrSEFLamFqOERValc4YjFSZHBBcFdP?=
 =?utf-8?B?VlgrUjl2NmUrbjhKaXZiNUhEM3BHS3YyR2hKV0VjckpzVmh0aG5HeGN0U1J1?=
 =?utf-8?B?SWdmZTBEUVNvbGo3UDVISTl0WTlkNkw2aGhXaitaYjVBNUY2aVpFbXhRWDl6?=
 =?utf-8?B?cHlxUDZaa2c5VDA1RW5hN2Q5L2sxbHc3em5JMWlyTlJqWGdjU3ZCRXdWM3Jt?=
 =?utf-8?Q?gVSGm4omgjjHK3njtgIj2PqFHn0KlLKaKrpSQ?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd75f384-07cd-41d0-4b8a-08da427cd23c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 20:41:49.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEICNYpxrbPSXoIr6qCIpJPLmP4APGqIMkU49w+IoIbE50PhfjRYRP3G+9XXkGnKF94hWD5SoBgqrjpLRgZ5yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2270
X-Proofpoint-ORIG-GUID: TUdTDjSY07jtW4YLTtPt6waHSzrBKodS
X-Proofpoint-GUID: TUdTDjSY07jtW4YLTtPt6waHSzrBKodS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-30_09,2022-05-30_03,2022-02-23_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/23/22 5:11 PM, Andrii Nakryiko wrote:   
> On Fri, May 20, 2022 at 10:00 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
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
>>         Hashmap Control w/ 500 maps
>> hashmap (control) sequential    get:  hits throughput: 69.649 ± 1.207 M ops/s, hits latency: 14.358 ns/op, important_hits throughput: 0.139 ± 0.002 M ops/s
>>
>>         num_maps: 1
>> local_storage cache sequential  get:  hits throughput: 3.849 ± 0.035 M ops/s, hits latency: 259.803 ns/op, important_hits throughput: 3.849 ± 0.035 M ops/s
>> local_storage cache interleaved get:  hits throughput: 6.881 ± 0.110 M ops/s, hits latency: 145.324 ns/op, important_hits throughput: 6.881 ± 0.110 M ops/s
> 
> this is huge drop in performance for num_maps is due to syscall and
> fentry overhead, is that right? How about making each syscall
> invocation do (roughly) the same amount of map/storage lookups per
> invocation to neutralize this overhead? Something like:
> 
> 
> const volatile int map_cnt;
> const volatile int iter_cnt;
> 
> ...
> 
> 
> for (i = 0; i < iter_cnt; i++) {
>     int map_idx = i % map_cnt;
> 
>     do_lookup(map_idx, task);
> 
> ...
> 
> }
> 
> User-space can calculate iter_cnt to be closest exact multiple of
> map_cnt or you can just hard-code iter_cnt to fixed number (something
> like 10000 or some high enough value) and just leave with slightly
> uneven pattern for last round of looping.
> 
> 
> But this way you make syscall/fentry overhead essentially fixed, which
> will avoid these counter-intuitive numbers.
> 

This worked! But had to use bpf_loop as verifier didn't like various attempts 
to loop 10k times. Overhead is much more consistent now (see v4 for numbers).

>>
>>         num_maps: 10
>> local_storage cache sequential  get:  hits throughput: 20.339 ± 0.442 M ops/s, hits latency: 49.167 ns/op, important_hits throughput: 2.034 ± 0.044 M ops/s
>> local_storage cache interleaved get:  hits throughput: 22.408 ± 0.606 M ops/s, hits latency: 44.627 ns/op, important_hits throughput: 8.003 ± 0.217 M ops/s
>>
>>         num_maps: 16
>> local_storage cache sequential  get:  hits throughput: 24.428 ± 1.120 M ops/s, hits latency: 40.937 ns/op, important_hits throughput: 1.527 ± 0.070 M ops/s
>> local_storage cache interleaved get:  hits throughput: 26.853 ± 0.825 M ops/s, hits latency: 37.240 ns/op, important_hits throughput: 8.544 ± 0.262 M ops/s
>>
>>         num_maps: 17
>> local_storage cache sequential  get:  hits throughput: 24.158 ± 0.222 M ops/s, hits latency: 41.394 ns/op, important_hits throughput: 1.421 ± 0.013 M ops/s
>> local_storage cache interleaved get:  hits throughput: 26.223 ± 0.201 M ops/s, hits latency: 38.134 ns/op, important_hits throughput: 7.981 ± 0.061 M ops/s
>>
>>         num_maps: 24
>> local_storage cache sequential  get:  hits throughput: 16.820 ± 0.294 M ops/s, hits latency: 59.451 ns/op, important_hits throughput: 0.701 ± 0.012 M ops/s
>> local_storage cache interleaved get:  hits throughput: 19.185 ± 0.212 M ops/s, hits latency: 52.125 ns/op, important_hits throughput: 5.396 ± 0.060 M ops/s
>>
>>         num_maps: 32
>> local_storage cache sequential  get:  hits throughput: 11.998 ± 0.310 M ops/s, hits latency: 83.347 ns/op, important_hits throughput: 0.375 ± 0.010 M ops/s
>> local_storage cache interleaved get:  hits throughput: 14.233 ± 0.265 M ops/s, hits latency: 70.259 ns/op, important_hits throughput: 3.972 ± 0.074 M ops/s
>>
>>         num_maps: 100
>> local_storage cache sequential  get:  hits throughput: 5.780 ± 0.250 M ops/s, hits latency: 173.003 ns/op, important_hits throughput: 0.058 ± 0.002 M ops/s
>> local_storage cache interleaved get:  hits throughput: 7.175 ± 0.312 M ops/s, hits latency: 139.381 ns/op, important_hits throughput: 1.874 ± 0.081 M ops/s
>>
>>         num_maps: 1000
>> local_storage cache sequential  get:  hits throughput: 0.456 ± 0.011 M ops/s, hits latency: 2192.982 ns/op, important_hits throughput: 0.000 ± 0.000 M ops/s
>> local_storage cache interleaved get:  hits throughput: 0.539 ± 0.005 M ops/s, hits latency: 1855.508 ns/op, important_hits throughput: 0.135 ± 0.001 M ops/s
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
>> As evidenced by the unintuitive-looking results for smaller num_maps
>> benchmark runs, overhead which is amortized across larger num_maps runs
>> dominates when there are fewer maps. To get a sense of the overhead, I
>> commented out bpf_task_storage_get/bpf_map_lookup_elem in
>> local_storage_bench.h and ran the benchmark on the same host as the
>> 'real' run. Results:
>>
>> Local Storage
>> =============
>>         Hashmap Control w/ 500 maps
>> hashmap (control) sequential    get:  hits throughput: 128.699 ± 1.267 M ops/s, hits latency: 7.770 ns/op, important_hits throughput: 0.257 ± 0.003 M ops/s
>>
> 
> [...]
> 
>>
>> Adjusting for overhead, latency numbers for "hashmap control" and "sequential get" are:
>>
>> hashmap_control:     ~6.6ns
>> sequential_get_1:    ~17.9ns
>> sequential_get_10:   ~18.9ns
>> sequential_get_16:   ~19.0ns
>> sequential_get_17:   ~20.2ns
>> sequential_get_24:   ~42.2ns
>> sequential_get_32:   ~68.7ns
>> sequential_get_100:  ~163.3ns
>> sequential_get_1000: ~2200ns
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
>> v2 -> v3:
>>   * Accessing 1k maps in ARRAY_OF_MAPS doesn't hit MAX_USED_MAPS limit,
>>           so just use 1 program (Alexei)
>>
>> v1 -> v2:
>>   * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
>>     configurable # of maps (Andrii)
>>   * Add hashmap benchmark (Alexei)
>>         * Add discussion of overhead
>>
>>  tools/testing/selftests/bpf/Makefile          |   6 +-
>>  tools/testing/selftests/bpf/bench.c           |  57 +++
>>  tools/testing/selftests/bpf/bench.h           |   5 +
>>  .../bpf/benchs/bench_local_storage.c          | 332 ++++++++++++++++++
>>  .../bpf/benchs/run_bench_local_storage.sh     |  21 ++
>>  .../selftests/bpf/benchs/run_common.sh        |  17 +
>>  .../selftests/bpf/progs/local_storage_bench.h |  63 ++++
>>  .../bpf/progs/local_storage_bench__get_int.c  |  12 +
>>  .../bpf/progs/local_storage_bench__get_seq.c  |  12 +
>>  .../bpf/progs/local_storage_bench__hashmap.c  |  13 +
>>  10 files changed, 537 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage.c
>>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_storage.sh
>>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench.h
>>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__get_int.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__get_seq.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__hashmap.c
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 4030dd6cbc34..6095f6af2ad1 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -560,6 +560,9 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
>>  $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
>>  $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
>>  $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
>> +$(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench__get_seq.skel.h \
>> +                                 $(OUTPUT)/local_storage_bench__get_int.skel.h \
>> +                                 $(OUTPUT)/local_storage_bench__hashmap.skel.h
> 
> You really don't need 3 skeletons for this, you can parameterize
> everything with 2-3 .rodata variables and have fixed code and single
> skeleton header. It will also simplify your setup code, you won't need
> need those callbacks that abstract specific skeleton away. Much
> cleaner and simpler, IMO.
> 
> Please, try to simplify this and make it easier to maintain.
> 
> 
>>  $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
>>  $(OUTPUT)/bench: LDLIBS += -lm
>>  $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>> @@ -571,7 +574,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>>                  $(OUTPUT)/bench_ringbufs.o \
>>                  $(OUTPUT)/bench_bloom_filter_map.o \
>>                  $(OUTPUT)/bench_bpf_loop.o \
>> -                $(OUTPUT)/bench_strncmp.o
>> +                $(OUTPUT)/bench_strncmp.o \
>> +                $(OUTPUT)/bench_local_storage.o
>>         $(call msg,BINARY,,$@)
>>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
>>
>> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
>> index f061cc20e776..71271062f68d 100644
>> --- a/tools/testing/selftests/bpf/bench.c
>> +++ b/tools/testing/selftests/bpf/bench.c
>> @@ -150,6 +150,53 @@ void ops_report_final(struct bench_res res[], int res_cnt)
>>         printf("latency %8.3lf ns/op\n", 1000.0 / hits_mean * env.producer_cnt);
>>  }
>>
>> +void local_storage_report_progress(int iter, struct bench_res *res,
>> +                                  long delta_ns)
>> +{
>> +       double important_hits_per_sec, hits_per_sec;
>> +       double delta_sec = delta_ns / 1000000000.0;
>> +
>> +       hits_per_sec = res->hits / 1000000.0 / delta_sec;
>> +       important_hits_per_sec = res->important_hits / 1000000.0 / delta_sec;
>> +
>> +       printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0);
>> +
>> +       printf("hits %8.3lfM/s ", hits_per_sec);
>> +       printf("important_hits %8.3lfM/s\n", important_hits_per_sec);
>> +}
>> +
>> +void local_storage_report_final(struct bench_res res[], int res_cnt)
>> +{
>> +       double important_hits_mean = 0.0, important_hits_stddev = 0.0;
>> +       double hits_mean = 0.0, hits_stddev = 0.0;
>> +       int i;
>> +
>> +       for (i = 0; i < res_cnt; i++) {
>> +               hits_mean += res[i].hits / 1000000.0 / (0.0 + res_cnt);
>> +               important_hits_mean += res[i].important_hits / 1000000.0 / (0.0 + res_cnt);
>> +       }
>> +
>> +       if (res_cnt > 1)  {
>> +               for (i = 0; i < res_cnt; i++) {
>> +                       hits_stddev += (hits_mean - res[i].hits / 1000000.0) *
>> +                                      (hits_mean - res[i].hits / 1000000.0) /
>> +                                      (res_cnt - 1.0);
>> +                       important_hits_stddev +=
>> +                                      (important_hits_mean - res[i].important_hits / 1000000.0) *
>> +                                      (important_hits_mean - res[i].important_hits / 1000000.0) /
>> +                                      (res_cnt - 1.0);
>> +               }
>> +
>> +               hits_stddev = sqrt(hits_stddev);
>> +               important_hits_stddev = sqrt(important_hits_stddev);
>> +       }
>> +       printf("Summary: hits throughput %8.3lf \u00B1 %5.3lf M ops/s, ",
>> +              hits_mean, hits_stddev);
>> +       printf("hits latency %8.3lf ns/op, ", 1000.0 / hits_mean);
>> +       printf("important_hits throughput %8.3lf \u00B1 %5.3lf M ops/s\n",
>> +              important_hits_mean, important_hits_stddev);
>> +}
>> +
> 
> We have hits_drops_report_progress/hits_drops_report_final which uses
> "hit" and "drop" terminology (admittedly confusing for this set of
> benchmarks), but if you ignore the "drop" part, it's exactly what you
> need - to track two independent values (in your case hit and important
> hit). You'll get rid of a good chunk of repetitive code with some
> statistics in it. You post-processing scripts will further hide this
> detail.
> 

I considered doing this when working on v1 of the patch, but decided against it
because 'drop' and 'hit' are independent while 'important_hit' and 'hit' are
not. Every important_hit is also a hit.

The repetitive mean / stddev calculations are annoying, though. Added a 2nd
commit to v4 which refactors them.

>>  const char *argp_program_version = "benchmark";
>>  const char *argp_program_bug_address = "<bpf@vger.kernel.org>";
>>  const char argp_program_doc[] =
>> @@ -188,12 +235,14 @@ static const struct argp_option opts[] = {
>>  extern struct argp bench_ringbufs_argp;
>>  extern struct argp bench_bloom_map_argp;
>>  extern struct argp bench_bpf_loop_argp;
>> +extern struct argp bench_local_storage_argp;
>>  extern struct argp bench_strncmp_argp;
>>
> 
> [...]
> 
>> +
>> +static int setup_inner_map_and_load(int inner_fd)
>> +{
>> +       int err, mim_fd;
>> +
>> +       err = bpf_map__set_inner_map_fd(ctx.array_of_maps, inner_fd);
>> +       if (err)
>> +               return -1;
>> +
>> +       err = ctx.load_skel(ctx.skel);
>> +       if (err)
>> +               return -1;
>> +
>> +       mim_fd = bpf_map__fd(ctx.array_of_maps);
>> +       if (mim_fd < 0)
>> +               return -1;
>> +
>> +       return mim_fd;
>> +}
>> +
>> +static int load_btf(void)
>> +{
>> +       static const char btf_str_sec[] = "\0";
>> +       __u32 btf_raw_types[] = {
>> +               /* int */
>> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +       };
>> +       struct btf_header btf_hdr = {
>> +               .magic = BTF_MAGIC,
>> +               .version = BTF_VERSION,
>> +               .hdr_len = sizeof(struct btf_header),
>> +               .type_len = sizeof(btf_raw_types),
>> +               .str_off = sizeof(btf_raw_types),
>> +               .str_len = sizeof(btf_str_sec),
>> +       };
>> +       __u8 raw_btf[sizeof(struct btf_header) + sizeof(btf_raw_types) +
>> +                               sizeof(btf_str_sec)];
>> +
>> +       memcpy(raw_btf, &btf_hdr, sizeof(btf_hdr));
>> +       memcpy(raw_btf + sizeof(btf_hdr), btf_raw_types, sizeof(btf_raw_types));
>> +       memcpy(raw_btf + sizeof(btf_hdr) + sizeof(btf_raw_types),
>> +              btf_str_sec, sizeof(btf_str_sec));
>> +
>> +       return bpf_btf_load(raw_btf, sizeof(raw_btf), NULL);
>> +}
>> +
> 
> please try using declarative map-in-map definition, hopefully it
> doesn't influence benchmark results. It will allow to avoid this
> low-level setup code completely.
> 

Forgot to call this out in v4 changelog, but made this change.

It was more frustrating than expected, though, as it was necessary to grab
btf_key_type_id / value_type_id from the inner map still, and the helpers would
only return valid type_id if called before prog load.

>> +static void __setup(struct bpf_program *prog, bool hashmap)
>> +{
>> +       int i, fd, mim_fd, err;
>> +       int btf_fd = 0;
>> +
>> +       LIBBPF_OPTS(bpf_map_create_opts, create_opts);
>> +
> 
> [...]
> 
>> +
>> +static void measure(struct bench_res *res)
>> +{
>> +       if (ctx.hits)
>> +               res->hits = atomic_swap(ctx.hits, 0);
>> +       if (ctx.important_hits)
> 
> why these ifs? just swap, measure is called once a second, there is no
> need to optimize this
> 
>> +               res->important_hits = atomic_swap(ctx.important_hits, 0);
>> +}
>> +
>> +static inline void trigger_bpf_program(void)
>> +{
>> +       syscall(__NR_getpgid);
>> +}
>> +
> 
> [...]
> 
>> +#ifdef LOOKUP_HASHMAP
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
> 
> shouldn't you use elem here as well to make it a bit more in line with
> bpf_task_storage_get()? This fixed zero is too optimistic and
> minimizes CPU cache usage, skewing results towards hashmap. It's
> cheaper to go access same location in hashmap over and over again, vs
> randomly jumping over N elements
> 

Both hashmap and local_storage benchmarks are always grabbing key 0 from the
map. v4 makes this more clear. Intent is to measure how long it takes to access
local_storage map, not random element within it.

Every other comment here that wasn't responded to was addressed in v4.

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
>> +#define TASK_STORAGE_GET_LOOP_PROG(interleave)                 \
>> +SEC("fentry/" SYS_PREFIX "sys_getpgid")                        \
>> +int get_local(void *ctx)                                       \
>> +{                                                              \
>> +       struct task_struct *task;                               \
>> +       unsigned int i;                                         \
>> +       void *map;                                              \
>> +                                                               \
>> +       task = bpf_get_current_task_btf();                      \
>> +       for (i = 0; i < 1000; i++) {                            \
>> +               if (do_lookup(i, task))                         \
>> +                       return 0;                               \
>> +               if (interleave && i % 3 == 0)                   \
>> +                       do_lookup(0, task);                     \
>> +       }                                                       \
>> +       return 0;                                               \
>> +}
> 
> I think
> 
> 
> const volatile use_local_storage; /* set from user-space */
> 
> 
> if (use_local_storage) {
>     do_lookup_storage()
> } else {
>     do_lookup_hashmap()
> }
> 
> is as clear (if not clearer) than having three separate skeletons
> built from single #include header parameterized by extra #defines.
> 
>> diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get_int.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get_int.c
>> new file mode 100644
> 
> [...]
