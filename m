Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1778668B540
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 06:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBFFjy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 00:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjBFFjx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 00:39:53 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9910ABF
        for <bpf@vger.kernel.org>; Sun,  5 Feb 2023 21:39:52 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3163ITsB019705;
        Sun, 5 Feb 2023 21:39:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=BpaCeyv/61NF1mDO7yqK8Z7VC50LCJg73CWZqXb4nvk=;
 b=JKJN7z7LZ0XUTtdVcQta/XzX3psHvoaXhFQjgKnLjnrJd9Vx/+q6TkQabmMixbu4OG9D
 nRXuv/Y38aIO3FtaLyS4m5Mx7V7cJHWOtRR/YC3bbPYsGndkLhwCkxAKksYeS5mnyoyi
 n6qEotO9J3ah5ZwpAPCHo9heIVhFu7WK/r8vSkBvVgpRQH5qE6AQMo9AxwhfXbdk7c2T
 RC3LvhG9Kw6ccEH1+oyB+EYPfiFk3Ca1V4DlCY4C0oiNeQZGBaMIuAkfRhQX2o/tKolP
 emWG+4tOJzezpEi8HidEIt22i3Oa67UHUR8o94WJRi3qH3i2PG59csglt7q+1L8HhvjW 3w== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nhnc57u55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Feb 2023 21:39:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5leKn05C5/5nkXkzvAND0Ji+wrdbLrEfZ6iCvfglhit0u7Wi/zXqZiKFPE5wPVDevDyf4l5VYLTY/weVBtSvzkwU1S/prf+YLJhs49GALOqk7I5iLRUdeu+78RdHv6p5zvI1/AUpO/oUNZZRon0gvlwDbi7KpRrMqsr+ZnwyXcYBSAxb8m4VjcRw2MD+jvX62VeoQijg8P9zl/tYBpGNd1CPjU5EQPB7OfIZ+o2hIaV30IQQdP10ThV07KknAGVVkugjweJvzZOVnoOO4QxL3+5i+1vl0dNolOuZ+KEOWwwxHt9rnBoz+/91VHYZ1YQN6Vo8pp8IrfD4Caxlry2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpaCeyv/61NF1mDO7yqK8Z7VC50LCJg73CWZqXb4nvk=;
 b=fQk3/ZcYE/HCSH9IKhIqJ9SVefpQv40d4Ee/iFuLpQY+NVH4PHKgILt1+F0juAhcGIpfqAURNYxIpSomG64h4T5252TKpnRazmOVfToCHOfYUYdD8yl7ix1QzH1HeelLhCVFa+FqWKBLwt7pAx8F5ijIqBUdYD/4nAfKMKvwyPXyeCce5wnhIbybGR1WQngeJ3Y6HB0Vbg/MqtH1A+vqaS8MI78blsYgMdzd0DWHzjjdxQSgyoXXID1zYOcU5UROUp7RuAHsSh21S+6cxtblBF6azrVUKP1pF48N5emgykOcI3ymOrdT11heVrx137L+WFm6eCghB6qYOY+enJU9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL3PR15MB5457.namprd15.prod.outlook.com (2603:10b6:208:3b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 05:39:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 05:39:46 +0000
Message-ID: <8c9ba1d4-eef1-2050-db33-aa7e9e4e99da@meta.com>
Date:   Sun, 5 Feb 2023 21:39:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next v2] libbpf: Add wakeup_events to creation options
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jon Doron <arilou@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, Jon Doron <jond@wiz.io>
References: <20230202062549.632425-1-arilou@gmail.com>
 <479c7e94-9502-6f94-c465-ac051f99b2ae@meta.com>
 <CAEf4BzbGHucDcFEyjDxSeW1fJxKDAt2mt9WXFagn=y9B+pqBSg@mail.gmail.com>
 <e325b5c7-663f-89c8-8e4f-a5676c66f5e0@meta.com>
In-Reply-To: <e325b5c7-663f-89c8-8e4f-a5676c66f5e0@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BL3PR15MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 1220a121-ebf0-4adf-985a-08db08048e7b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3jCrNpY6uQhSXvOGk8LRmaVI6WE/TPV1P73RKMHC0p198mOMkTAQGMchp+l6lr0/+MWdbbYDUg0M8zkY1o97QAIInZWRwzdSpfjwiBhpp3vRfGny7Qp28YqKlnz5xEWfnUR1XTHNPw1LwI91CY64Fkykz2FSbYLw2svQt1CUrDcIkS6+jmZtEbZbY6Qt37BuUSx+r9k7aKk6oI1UOLO4K9QGdtD05rc94bAcuwwGlYYKttoHrW1CkS9Ua0EVcok1sO4lxSYgKe+X07q9uDrGF1MwzFTHmQf5g42j9gDaW/IY5tytZDGdiodEx+BkF3cgXodxE3nJ2JHxwiY0sOC2wq4aR+iCzd9BI/s5u+ef/jTnMFLmwVuI7rOJqzTCTDyStkPShRrJelK0FRmdb13YMFuUA9h2Tv/GUr3G0LNmLnIWAL9o4rv8iOZHWoPmEnn/Os7N7aaYzLdZWxf8NiQIydvoT1DR7Qg7aA6j7zlESGRH9e3OCbAy8LF3CS119sg06EWpC/HWy7Sj9mkXnrynuDKvxoouLlqJnzhkvr9XEbbEdhXRluKh4+hIzZYJKYH2iWsw09gM53ya3sLvh2sUxW877c2ZywikqfbOCYD4X06rRyV77lXcGMgJWshmiiPIEDE7DwsffKKV95+YHf/9Llc9Gzu8iadoN9NS0i0qPeGGFcJAI8fvYddgfNyBItwYy3/Vb4/03tYIY9KPPKScfoTJK/nHeCNKxHHd9Dgp58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(41300700001)(83380400001)(66946007)(66556008)(66476007)(6916009)(4326008)(31686004)(8676002)(316002)(54906003)(36756003)(6512007)(5660300002)(2906002)(6506007)(8936002)(86362001)(53546011)(478600001)(2616005)(6486002)(31696002)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmV6TFlGM1NmMUZUcW9KaXB3TDA2R0lZODgxS0drcHFqNnJod1pHSjI5c21T?=
 =?utf-8?B?bzVLZ1FONGVGRnpGSm5USWp1VGtBOE81NE9COTFCZnRtdU1KcDh0MTdvNG0r?=
 =?utf-8?B?NVZIM1NRUVVrU1JQN3dQcEp5dHlvbzhxaGRoQXBtWGpnM3RVRWRyTkNoWjZj?=
 =?utf-8?B?TDVBQmF4TWNHd0N6d2txbkVXQWtOM255ZnkwMkhrcDNrVmZ3eDkzUjNGWmc0?=
 =?utf-8?B?RU9WVjVYeWtMYW9IalZHQkdwTmo2UVUxVWxGRTdXYmdGNDBSTWRUNHd2ekt0?=
 =?utf-8?B?U0NWMHM5VURsQlFKaGNRK0lOd0hxSDdOa2w3b1RxSmM3U3E0aUlpeVRUQzll?=
 =?utf-8?B?L2pjaVk1bFpEamdvb2pPdUQ4eGI3Q09vd2hUVmM0dkF2QnlML0RFZG5KQ3Bz?=
 =?utf-8?B?K3FPSmx0MVdpeFBEdG4wdXljcGF4YjEzazJRL1RXcDhkUzRwY1RTN2Y3SUUy?=
 =?utf-8?B?L0s3NWxHRVJGZ21TN0F1WE5QbVhoc2lBczFndEFBUTRDbFBiZEt2VXJZWG5v?=
 =?utf-8?B?Qzh6N2ptbWxzYTM1cUpUQXpVTFZpbmtXV0MwR2sxa0RKbnJ0cm1DZjVsYng5?=
 =?utf-8?B?dmRkUGlpVGE3TFpUZ1FGem85K3pZZjdEZTlKVXZOdm5FMW9kZDVtTnFka3Fr?=
 =?utf-8?B?cUFvbldwcy9CcmRBZEJKN2tBa2hLVEZMRzBmOTQ5bnpIOEVoVE1rMnJSSzR0?=
 =?utf-8?B?ankwU1crT2RCS3IwV1pzSVRRYWxmVmNrbU1ub2dQblNWUEdyM1MvSkZwNFlD?=
 =?utf-8?B?Wkp5VmVLMldVZkVQQlVReFpES25Hck9obU1XeU1Pb0ozLzUrREJ5aE9seVpz?=
 =?utf-8?B?b0pjNDMyVGpRNkhlYUJONDFhWGdrYW8yUDFiWkFLcktZQmloM3dob2pUN2xK?=
 =?utf-8?B?L1NKdEVTQlEvcm0xVzFjdTNpTGhDZFVRY08xZFQ4azl5YzJHbERGaHhuU3NH?=
 =?utf-8?B?ZzY1U0xUVE40M1NnR3FmQTRoNHN4UjBBYXdQa2laTE1lZ2JGbGRtS29wbTJu?=
 =?utf-8?B?L3BYNHh6bk8yempDQTQ3RUxjcUNsTCtheWp4UUlvK3NIR0E5Rmh0d1JweVp3?=
 =?utf-8?B?WXk4WGN0aG8ydnJ6ZEJNcGZXVGthOUJXSXZSaC9OVTlObm9Jb09OVzNpaFhG?=
 =?utf-8?B?cTUwc3FQRFN0bVN1ZTl5UDU0MzlYMVlvVGo2T01VdEpzUUQxdjVQbXQ2Mk5p?=
 =?utf-8?B?aFVTTFlKUjNlZ2RnT1dxemVXSzY1ekdnWUxOeFc3Um1DeDNEbGRxRTBXR2Fs?=
 =?utf-8?B?UmVhdVl5WXhvVi9BejNOcEt5cEMwYnJVNHNjOXIyUmk4TG9ZeDlZL1Y0Y1Jk?=
 =?utf-8?B?SVFQbTEyUndSVnpDV1dWWm0rQ2dDK1dVTC8vaDA3MnpqTjhBTzBWVUFNWXg1?=
 =?utf-8?B?ZUYzczkrWVlHWmZVQXRNaE55WkxRS25VUTdRNzZPWjJvTEVyK3RDWWF6amFJ?=
 =?utf-8?B?K1pWZlJuVHNhZ1A1Zm5XbFBYajAvdElhM1RNdmlEcVd5VVExckkzNFFYTW5R?=
 =?utf-8?B?T3hZNTk1MXUxSVhBTmo4SXBGcnc1Q083S3RkOHJiSGR4UW0rclNaRlhrSmly?=
 =?utf-8?B?RHNMODVUNWRBYjRHTXdpamdudTl3Qk5KMkFoNHhiMzZhQ0VQcmtOdUZURnQr?=
 =?utf-8?B?SHUyZXdDTDEvbjlYRkdYVS9LUC90SXJIekhhSmg3ZVFOdDc1Uy8rc2JGbXhJ?=
 =?utf-8?B?TDR5TWs2K2VOOTRQOENjeS9EL3A5K2ZMVEEzZldiSzVkaVoySnRLRUphczV2?=
 =?utf-8?B?OExFNUNHWDVHMEtjM1g1NWRRMFNBL2szeGdhZXNyQnNzOXRGdVZua3lwaDJR?=
 =?utf-8?B?eWI2Qk9HUXJPMFpWRmlsTytvc2h2VEhnU2hzcjhRbjdkcG5xWTkxVFJvVzNC?=
 =?utf-8?B?RjBFcjE5WnU5VVo5SVVHM2FpL1ZiV3VxenN1aXI3SmdSN0IzejVJR0tzQkx2?=
 =?utf-8?B?Q2VQbW4zQmJMcnVFNkp6cHlheEc4cmZNYTlhbkN2elhZWURjc3RYaDhjZmRw?=
 =?utf-8?B?TllCUGpDZ2hlOW5GdzFISFNvS1R6K1dXd2hwZVdsNUZpUE50YnR6eC8zWm5k?=
 =?utf-8?B?MEJuOHVRYmYvVEZtbW1kaEMwa2svTkVwQnNoL0ZtbnNINkxvdWI3aTJ2bTBG?=
 =?utf-8?B?R1B4dmNtUUs1MlBXNG9EUlU2Z0NXTlkrTHFHSkVUdlRueUE1NVo0Vmc3YmRa?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1220a121-ebf0-4adf-985a-08db08048e7b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 05:39:46.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLlLoBmy0beGgKUahZhvpcMXrCrc7R6USnHGzdZv94XSCg2hhjaFak4hXlHBtcEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5457
X-Proofpoint-ORIG-GUID: _rTf8qQWTgdawVXqoRI0OYCI3Q_ITTx8
X-Proofpoint-GUID: _rTf8qQWTgdawVXqoRI0OYCI3Q_ITTx8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_02,2023-02-03_01,2022-06-22_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/3/23 3:11 PM, Yonghong Song wrote:
> 
> 
> On 2/3/23 1:42 PM, Andrii Nakryiko wrote:
>> On Fri, Feb 3, 2023 at 10:31 AM Yonghong Song <yhs@meta.com> wrote:
>>>
>>>
>>>
>>> On 2/1/23 10:25 PM, Jon Doron wrote:
>>>> From: Jon Doron <jond@wiz.io>
>>>>
>>>> Add option to set when the perf buffer should wake up, by default the
>>>> perf buffer becomes signaled for every event that is being pushed to 
>>>> it.
>>>>
>>>> In case of a high throughput of events it will be more efficient to 
>>>> wake
>>>> up only once you have X events ready to be read.
>>>>
>>>> So your application can wakeup once and drain the entire perf buffer.
>>>>
>>>> Signed-off-by: Jon Doron <jond@wiz.io>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c | 4 ++--
>>>>    tools/lib/bpf/libbpf.h | 3 ++-
>>>>    2 files changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index eed5cec6f510..6b30ff13922b 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int 
>>>> map_fd, size_t page_cnt,
>>>>        attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>>>>        attr.type = PERF_TYPE_SOFTWARE;
>>>>        attr.sample_type = PERF_SAMPLE_RAW;
>>>> -     attr.sample_period = 1;
>>>> -     attr.wakeup_events = 1;
>>>> +     attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
>>>> +     attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
>>>>
>>>>        p.attr = &attr;
>>>>        p.sample_cb = sample_cb;
>>>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>>> index 8777ff21ea1d..e83c0a915dc7 100644
>>>> --- a/tools/lib/bpf/libbpf.h
>>>> +++ b/tools/lib/bpf/libbpf.h
>>>> @@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, 
>>>> int cpu, __u64 cnt);
>>>>    /* common use perf buffer options */
>>>>    struct perf_buffer_opts {
>>>>        size_t sz;
>>>> +     __u32 wakeup_events;
>>>
>>> Since you are adding wakeup_events here, do you think it make sense
>>> to add sample_period to struct perf_buffer_opts as well? In some cases,
>>> users might want to have different values for sample_period and
>>> wakeup_events, e.g., smaller sample_period to accumulate data and
>>> larger wakeup_events to wakeup user space poll?
>>
>> It's not clear to me from reading perf_event_open manpage what
>> "sample_period" means for perf buffer. What will happen when we have
>> sample_period != wakeup_events?
> 
> The following is my understanding. Let us sample_period = 10,
> wakeup_events = 100.
> 
> Every 10 samples, kernel overflow handler is called and the the sample 
> data are written into ring buffer.
> Every 100 samples, the poll() syscall is waken up to give userspace
> a chance to read the data.
> 
> In this particular case, it is possible that user space may miss
> some samples at the end if no special handling (I forgot what it is).
> But if the user space doesn't really care, it might be okay with
> such a configuration.
> 
> It would be great if some perf expert can clarify whether my
> understanding is correct or not.

Think twice. I am okay with just one wakeup_events/sample_period
in the perf_buffer_opts since wakeup_events == sample_period
is the most common use case. The same as before wakeup_events =
sample_period = 1.

But it is apparent that sample_period is much easier to understand
than wakeup_events. Can we put sample_period in struct
perf_buffer_opts instead of wakeup_events?

> 
>>
>>>
>>>>    };
>>>> -#define perf_buffer_opts__last_field sz
>>>> +#define perf_buffer_opts__last_field wakeup_events
>>>>
>>>>    /**
>>>>     * @brief **perf_buffer__new()** creates BPF perfbuf manager for 
>>>> a specified
