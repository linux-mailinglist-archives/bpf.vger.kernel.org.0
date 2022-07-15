Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782C657666A
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiGORy5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiGORy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 13:54:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7823AE65
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 10:54:55 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGGtCP016334;
        Fri, 15 Jul 2022 10:54:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QYl/hXaXs0iuLYOZxplIH4n8PnWDf7IHSX8mLdHIUNQ=;
 b=PEJJizFMUKuDv/wDsBe9SyBiDZvWAVUWdbOIRRqZrH7toCvK8JFREeskjWzQG3xzb6ps
 nMooFxaWEOsP5fvmpSkLE6tm1aqtmSlpL/oENPABDGkeW6aUnjBcrq3Cf4Vh0nNZdqos
 0lqCnR88bPXRjRMqem5FUDYDsihwkS33QrA= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hb8md1xk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 10:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCORpDkMVszKVv303PCsFgjgDEF4oBVdcckOt0J91a5QmxckJRWsY0P9XSki0UATE1/StrWOtzQQ+9J4wvdqnVDmd0l7ilZIoWKn9N9tjNIMm9bPwhUKHyMA/1bXq4PzS5m3B61WSmP8uBov7UQ9jGzZFca+qRgAd3GRp/T6bCFBFtxIFlzdtwWDEbcJcHb0rPpb4n13u7wTPBkRpQCiiAVvoPyaq2UdKJNm0HwmKS0AACpVynbR3PIGiZTA3p7Sh518ZZyUrS9rCpjLoHfu5NJJofDPQhyWWY2w83sah9fcMBGi9ExTcMqo2JJ2y0LxdJI7GMZLohMmW8RFQLd9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYl/hXaXs0iuLYOZxplIH4n8PnWDf7IHSX8mLdHIUNQ=;
 b=OZaSCLs11tmZhY5zhRLNb9g6XkHhhd9dpTTC7Ak+8yZbjuy2ooot6Mo87FOIskVuSxlr2jenE6Bro+HYkNyXGTuIX8kjWJfyLteLs24qhS8XqioK0guQvcHE4uFxTfUhIP9tkaak0X3TAIX6Kl5zM3XHC9esZh1peUPXugCeUf+0bV0iU4YBf3u1J8DYm1aFg8Q1hmSGAkMSy+BltwwzPOKGIYKCdOHovj6/IjMubPo9Q3mVBXTHZofiSclA2EuxPgLMKt8nMouzr3YjkyKpDDanlCV84ZveyONX9v49jy00e523f9EhBeER2CrQJSbamb+AdNCuUd19iPuFbcHVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1686.namprd15.prod.outlook.com (2603:10b6:903:13c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 17:54:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 17:54:38 +0000
Message-ID: <0e829cc3-5539-b942-7e8e-4111d372b095@fb.com>
Date:   Fri, 15 Jul 2022 10:54:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next v4] libbpf: perfbuf: Add API to get the ring
 buffer
Content-Language: en-US
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, Jon Doron <jond@wiz.io>
References: <20220715171540.134813-1-arilou@gmail.com>
 <23ee86bc-c4f2-0a05-120b-555f7c1a02fa@fb.com> <YtGoJ8W8Vm19nzpz@jondnuc>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YtGoJ8W8Vm19nzpz@jondnuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76a7596-de4b-408d-f041-08da668b165a
X-MS-TrafficTypeDiagnostic: CY4PR15MB1686:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjX4ijg1QisQyrqXG4UfU3hlsk6YqFI6d/v9gCHlOw3ULLNXMFrUapdsEb+8BnCYlNA6cDPcorX+N+ckASNAOSYiqT+HyWbMnVUDJHV0I2N280/Y699z+OXPTOl42o1nmzsTRw7/7ZAqUlwbfeL53aEr48r41qBdiBfNFX6EM4ptY1pQRGt/qSgI8Qs46ifz71isM+OA2EVjvOl4iyZnXLN5Uzt64nGsnF/JzzmTB8XR2u27dwjGrfi83Dcv18ggBC9EPLxtM8KzrILZ5zlJRUfp68mMMaROtmNKn9dUv46euIGpfc9gX3UQgkZoAR4yDiQLhTAtijbI7asbSK2CkaK2MmC3dke2CbIdfY38TuwXnRXNzoYsRibxWSGTGlQD7bPD269P6ZlHnCa2AHXpjD74lbfxs2z0sN56HOXS5kF8rigVwHEEktZUiDxlhXmKy5OM0nsa2f6OfWdXEeV3C2dX/KKxQWAwqnAUzyW8l4Vt/YeBegHRRg3krGrAxnXEqWluKlR6w6dJkgwfTQF+ksaK9d65jE6y3oYy4di6L07jD9VCkw/J+S0arIvzgv5Nr6Iq7f+1OZl668cPLWFq2NEj+w8iZxSMaHiWw+kuY6/JILnXkVWW3HgMxFLJMT6s/qtvvzB5T+xFQppBqa8GfJFK2AXgFh3Fz9aEltnDWayyKDbiDDHmYKvqw7nK/CkBzTEVPupmWxj4A2E08qK6BffwrazK8RB1saVSGJOt3XGiz9GCpPU7r5piOnemdOU0DyQlrkA+ptQDiWUgpz8ilWxru3ef81lkwZqNO9+foRJco/S+6rf4p8oQ574DZqdYlRuaAZzzVXUZaSGUF59l8scsrCk5hyyEsOvBT07KZuwIKNRJdS2qhWizKmlPr9T+aIyoM9bWQBxOI1Z+AWxQ3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(6916009)(186003)(4326008)(8676002)(38100700002)(6506007)(31696002)(6486002)(86362001)(316002)(66476007)(31686004)(36756003)(478600001)(66556008)(966005)(53546011)(6512007)(66946007)(2616005)(41300700001)(83380400001)(8936002)(5660300002)(2906002)(15583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZkMEp6QnpYQXpXS3JsQ2pqMzV6ZFY0aEVwOXA3ZzZFbW1PUXZzTFNWT2R1?=
 =?utf-8?B?NVA4c0VpdWlJK25uejJ5Y2JLNm5iYVJNdnBzclNRVnlybVQ3MW5VZTB1QWJ2?=
 =?utf-8?B?d3hFaWIyQVVrQjJJdWlCNXR3UTMzSHpyZXcxWVRYY3M1Wk80SSttdW9rRFB2?=
 =?utf-8?B?cW5JQUdYMDI0a3Z1UndGVmN5QXpCNUlxMnZVUFBMUHpSWkExZTZOSms0VURu?=
 =?utf-8?B?VlZUTHV2U1BwYUpKRzliQjgzTWF3Smthb3JkaEtubmVCRXg5TUM2Q3JlM0NM?=
 =?utf-8?B?d0ptaGxVZU04c09PUEgrejZYRTY3T0VpT2ljNGMzelZyTWFrUXJsZ1BhZW01?=
 =?utf-8?B?ZXJwVnBST2dNMkllV0NNQURpTlB2SlFzT21oQXo3bDVvTm5OV0ZLR3JIQTNr?=
 =?utf-8?B?RGkyMjlXMnBYK1BYb29iWVBMZDgwY1U0M1F0aU1aSDVDeSt2ZzFRYlJoSkM3?=
 =?utf-8?B?dTJCQlFPV2lPMWUwY05KZXVxSC9weTZ0bysydlNod2hlaE9zci9KenEwSkhm?=
 =?utf-8?B?blZDcXJzcG9CbHRiYldyZThqVmdaUjBNYUdraU9sd3QxaGlSUFkyVlN0bEFa?=
 =?utf-8?B?QkN0R2M2ZE5YVmNOYngzVTZCV21DNktVckcxaksrUHVWYm5ncmxGNWI3dGdo?=
 =?utf-8?B?V1JoU1FJMERQdW02YVhyVXhNa3hURlJkS3g4WWg1OU5nUDdLeDF2VExBQy9t?=
 =?utf-8?B?Y0FxMW1CcVdEV3E5S0djV0JpSTVONnppbmpBUzBUUXAxS0dGVkF4VmtXSlp3?=
 =?utf-8?B?YTBWc0tSZ1FjemZoRmFQWnB3L3JkbytCaUQ3eEo3WjlGbVNEak5Jd1Zyd3g0?=
 =?utf-8?B?OFc4NlE0eFVXS0xlUS84ZXFWYjg1Y3h3emZkMSsza0lBYU5MYXFCQU44QXl2?=
 =?utf-8?B?L2YzcktkQ09OSWd3RjFEemJPbUtaR0NzR3cwV3l3VlZGaStleUtSS1IyYTVJ?=
 =?utf-8?B?aUE1NDV6SjRIYUh2Y2xOVnpTT3FaUmswdG1tUzNYVU5PdTI3Yzhvbi9zdm9X?=
 =?utf-8?B?OUd6blU5VG1Jd0loNGNmSDdZT3RqZ1ZXUGZpK1FRTzA0OGdXQUwxYmVuNThr?=
 =?utf-8?B?VWtheHpyckNWaTZDWUEvNElrVmI1RTMzMCtuR3QxRCtvcHU2RUpjRmlPZll1?=
 =?utf-8?B?UFgvbHRYMVBXOWN4S01IdTIyN2hveks3dTB2dDBMK1I4TGtTZHlpcEptS3Bs?=
 =?utf-8?B?MkE3VGtGbTlVR00xdHF1dUtObDYwQWFySXl3SnYyN2xNb2RzeUgvS3J5cVNK?=
 =?utf-8?B?ZlY1ZmwwVG9HQ1ptMmd2bnpWRWpWWDlJQ2JKYXRlM0JIbVRQclhGNG52ampj?=
 =?utf-8?B?THJUbnhGb0dPYmx5VGFmbVFJSW9yS3NwbXBjdHV3ejhKTnVFQWIwWDRwT2pz?=
 =?utf-8?B?cklRNlFwMTRQb3ZOczJHcFc3ckRFcm9tcmxZRFZpMTFSN2xMaDRpYlU3K01t?=
 =?utf-8?B?K0UvYzZ2M1A1ZUt2Z1RnMkhkU1FsbjhYb3FoK2tVQlRaVlQwN2M5dHlRbVM0?=
 =?utf-8?B?TW9pSVBEcGo5My9aUVBEd0E2c3JuQ1hiRDNmajVuemJzenpQTWp6QzVMaTND?=
 =?utf-8?B?NURXc0djeDZ1RlNiSzcwL1J3R2YxS2wvV0o4MnR1d3l0TGdTd0k1L1pFVE90?=
 =?utf-8?B?K3ZkL0sveElGaDlPZEUrWnh0SHU4b3FGczUycWpWY0xrbHNPdDFvcllUSlla?=
 =?utf-8?B?S2ZvdjF3cXZKb21sM1REcjltd1pOWlpsTkRGTjFpVVppKzRpZlZ5UXNqSVQ3?=
 =?utf-8?B?U1BkcjZ4TnE2UE9hcmZ2eVN3bVd5Ukh3MXovd0FzYUtER3FnNElHQkovOGV6?=
 =?utf-8?B?Tzc1Rm9BSWlCbzNWL1VEeU16L205VjhvUnBBZStBcDd6LzhLRS9DVTY3cG1E?=
 =?utf-8?B?Rk9oaGloTVNDVy9Kd0kxRXNmUUxEOUo3eEZjcnJoVm1jOGUvWjBjWmIvamFt?=
 =?utf-8?B?N0xPcERDTE84a3BieURpRW56dGFTQVlTQlQzaUp1dEt3NDdadXVRWUR4M1N4?=
 =?utf-8?B?d3NaMTN4dlljMWd1ZWc1dXNNdUJPbURtWFRvb3l1b2tQZnZDbzNUa3h5M3JK?=
 =?utf-8?B?TGlETnV2NjVXd0JRd3U4YmNFeCtMWHQvOTY3NGVxcWtTamN4dVVRNTJiUFBC?=
 =?utf-8?B?NVpicTRSYXRMRVR6WkhvNHB4YzNKVDNsLy9HTjV5eHNPdG11TUYvWTJpWWRT?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76a7596-de4b-408d-f041-08da668b165a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 17:54:38.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHFCHFRatNOa6MLXLG2d4TQxhlIW62t358JmSexWns2DhFzKLOx/Md0aX0JZVpBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1686
X-Proofpoint-ORIG-GUID: CB-UeJNDizueDTONJ0-8mMpEdjKhEkqu
X-Proofpoint-GUID: CB-UeJNDizueDTONJ0-8mMpEdjKhEkqu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_10,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/22 10:47 AM, Jon Doron wrote:
> On 15/07/2022, Yonghong Song wrote:
>>
>>
>> On 7/15/22 10:15 AM, Jon Doron wrote:
>>> From: Jon Doron <jond@wiz.io>
>>>
>>> Add support for writing a custom event reader, by exposing the ring
>>> buffer.
>>>
>>> With the new API perf_buffer__buffer() you will get access to the
>>> raw mmaped()'ed per-cpu underlying memory of the ring buffer.
>>>
>>> This region contains both the perf buffer data and header
>>> (struct perf_event_mmap_page), which manages the ring buffer
>>> state (head/tail positions, when accessing the head/tail position
>>> it's important to take into consideration SMP).
>>> With this type of low level access one can implement different types of
>>> consumers here are few simple examples where this API helps with:
>>>
>>> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>>>    to handle the wrap-around in some other way.
>>> 2. Since perf buf is per-cpu then the order of the events is not
>>>    guarnteed, for example:
>>>    Given 3 events where each event has a timestamp t0 < t1 < t2,
>>>    and the events are spread on more than 1 CPU, then we can end
>>>    up with the following state in the ring buf:
>>>    CPU[0] => [t0, t2]
>>>    CPU[1] => [t1]
>>>    When you consume the events from CPU[0], you could know there is
>>>    a t1 missing, (assuming there are no drops, and your event data
>>>    contains a sequential index).
>>>    So now one can simply do the following, for CPU[0], you can store
>>>    the address of t0 and t2 in an array (without moving the tail, so
>>>    there data is not perished) then move on the CPU[1] and set the
>>>    address of t1 in the same array.
>>>    So you end up with something like:
>>>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>>>    and move the tails as you process in order.
>>> 3. Assuming there are multiple CPUs and we want to start draining the
>>>    messages from them, then we can "pick" with which one to start with
>>>    according to the remaining free space in the ring buffer.
>>>
>>> Signed-off-by: Jon Doron <jond@wiz.io>
>>> ---
>>>  tools/lib/bpf/libbpf.c   | 16 ++++++++++++++++
>>>  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
>>>  tools/lib/bpf/libbpf.map |  2 ++
>>>  3 files changed, 34 insertions(+)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index e89cc9c885b3..c18bdb9b6e85 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -12485,6 +12485,22 @@ int perf_buffer__buffer_fd(const struct 
>>> perf_buffer *pb, size_t buf_idx)
>>>      return cpu_buf->fd;
>>>  }
>>> +int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void 
>>> **buf, size_t *buf_size)
>>> +{
>>> +    struct perf_cpu_buf *cpu_buf;
>>> +
>>> +    if (buf_idx >= pb->cpu_cnt)
>>> +        return libbpf_err(-EINVAL);
>>> +
>>> +    cpu_buf = pb->cpu_bufs[buf_idx];
>>> +    if (!cpu_buf)
>>> +        return libbpf_err(-ENOENT);
>>> +
>>> +    *buf = cpu_buf->base;
>>> +    *buf_size = pb->mmap_size;
>>> +    return 0;
>>> +}
>>> +
>>>  /*
>>>   * Consume data from perf ring buffer corresponding to slot 
>>> *buf_idx* in
>>>   * PERF_EVENT_ARRAY BPF map without waiting/polling. If there is no 
>>> data to
>>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>> index 9e9a3fd3edd8..9cd9fc1a16d2 100644
>>> --- a/tools/lib/bpf/libbpf.h
>>> +++ b/tools/lib/bpf/libbpf.h
>>> @@ -1381,6 +1381,22 @@ LIBBPF_API int perf_buffer__consume(struct 
>>> perf_buffer *pb);
>>>  LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, 
>>> size_t buf_idx);
>>>  LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer 
>>> *pb);
>>>  LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, 
>>> size_t buf_idx);
>>> +/**
>>> + * @brief **perf_buffer__buffer()** returns the per-cpu raw 
>>> mmap()'ed underlying
>>> + * memory region of the ring buffer.
>>> + * This ring buffer can be used to implement a custom events consumer.
>>> + * The ring buffer starts with the *struct perf_event_mmap_page*, which
>>> + * holds the ring buffer managment fields, when accessing the header
>>> + * structure it's important to be SMP aware.
>>> + * You can refer to *perf_event_read_simple* for a simple example.
>>> + * @param pb the perf buffer structure
>>> + * @param buf_idx the buffer index to retreive
>>> + * @param buf (out) gets the base pointer of the mmap()'ed memory
>>> + * @param buf_size (out) gets the size of the mmap()'ed region
>>> + * @return 0 on success, negative error code for failure
>>> + */
>>> +LIBBPF_API int perf_buffer__buffer(struct perf_buffer *pb, int 
>>> buf_idx, void **buf,
>>> +                   size_t *buf_size);
>>>  typedef enum bpf_perf_event_ret
>>>      (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>>> index 52973cffc20c..75cf9d4c871b 100644
>>> --- a/tools/lib/bpf/libbpf.map
>>> +++ b/tools/lib/bpf/libbpf.map
>>> @@ -461,5 +461,7 @@ LIBBPF_0.8.0 {
>>>  } LIBBPF_0.7.0;
>>>  LIBBPF_1.0.0 {
>>> +    global:
>>> +        perf_buffer__buffer;
>>
>> You probably use a old version of bpf-next?
>> The latest bpf-next has
>>
>> LIBBPF_1.0.0 {
>>        global:
>>                bpf_prog_query_opts;
>>                btf__add_enum64;
>>                btf__add_enum64_value;
>>                libbpf_bpf_attach_type_str;
>>                libbpf_bpf_link_type_str;
>>                libbpf_bpf_map_type_str;
>>                libbpf_bpf_prog_type_str;
>> };
>>
>> You need to add perf_buffer__buffer after libbpf_bpf_prog_type_str 
>> (alphabet order).
>>
> 
> I was working on top of origin/master in:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> The HEAD is:
> commit 9b59ec8d50a1f28747ceff9a4f39af5deba9540e (origin/master, 
> origin/HEAD)
> 
> Is there a different git I should rebase on?

Please work on 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Note the patch subject
   PATCH bpf-next v4] libbpf: perfbuf: Add API to get the ring buffer
So the patch is supposed to be against bpf-next tree.

> 
>>>      local: *;
>>>  };
