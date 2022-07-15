Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E54576636
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGORky (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGORkx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 13:40:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106777AB3C
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 10:40:53 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGGuoD020206;
        Fri, 15 Jul 2022 10:40:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=je9qVao9BIvY/tax9a0gLLNRNr+x3a50WhtGzvXUKys=;
 b=MBCh+PxQVLB/5h5Z/zguhUVU0E5/X5RBDGzGPqv4W6RY/QTwbF65WB8rauchkGdbgXrm
 0omvJV9HPO3JYgsb1aXBE12CD9L+2inXpow4D1TcpORnZ7lM0cqca6WLC1H83o6FPQmk
 tfdTlak5chZn7nBfX0zdtXFtd538VO14TXk= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3havksmups-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 10:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbfJqDlDD+gOdkIriUmWf7sL/8OGBaOC2MqpgSgZucLFvPQqOIOWwULNw+JRmrxG0zA0YMS3FmdXm2VL0AEPxtmx9Me1xmlGnOUo4yJcJTBX+bRADdX3+IipybG9Vk0rPJ2v+GZVkNw0AIwteLt1XdbeKyiLX8JreLido1eCChsH57dopQEx7znNfvSCbmzNvP/kgUSt1sPdPRMMARgjIvxRmNKeFB5ty7tdV6hPtFXPv/OGyIww6kCNhZvLniEIjwRf3yD/6+b5nW+uzDFsj63OKC/qhF21iSk+4EzdZEtNY5R91zNRjHtTQ+yUMvi29ZbR0gKuQULBIQQmHGEEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je9qVao9BIvY/tax9a0gLLNRNr+x3a50WhtGzvXUKys=;
 b=RH5B2OOi/mLImbt3Ekp8G3wyjlFY8cuCWzvWK9GfNBhpl4MVOCfNKrT8K/baO+vxSFf08r0l9W+JgI4+Fq0hpwPiVK3VLywbw66DG2BkT6YqANm9PFfEE1IGI1X5K3m6IeSnSGXXOKvEMnnssdCDyeekv3/vtAWLY0DY+PZwTQ6ifksT+ESwZwc3T6j4oh2rvSCslwCvpLIMZqyHAmrGuOyuTMdmiUcN+3v6ZMQlWSUbMY6I68oQjC18CN2GUb4GG+VKJxyBaHLykLsDAH90LS5BtfwXeEup55yrwOOE36Qa6War7sGTXxiB7XBQAP7BfSCmPUjJFto23FhibRA6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5258.namprd15.prod.outlook.com (2603:10b6:806:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 17:40:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 17:40:36 +0000
Message-ID: <23ee86bc-c4f2-0a05-120b-555f7c1a02fa@fb.com>
Date:   Fri, 15 Jul 2022 10:40:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next v4] libbpf: perfbuf: Add API to get the ring
 buffer
Content-Language: en-US
To:     Jon Doron <arilou@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
References: <20220715171540.134813-1-arilou@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220715171540.134813-1-arilou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa5fb295-a257-48b7-e2b8-08da66891fe6
X-MS-TrafficTypeDiagnostic: SA1PR15MB5258:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UlPkgg+LRaqGVnRoMrojYgkz4Rj1ymONNvXDrObccQ1b4PoVgnNcsU1nImX5pdpnOOGz9+i2Yv1Y4Yn7N7NViLB6BIsBVn1VaD57cse9cUqgF1wDfjn4rbTP8eZxVCUPz9Zt0sMxpOJKYjgBAAWHYHGZV1ZeEL3Rjc9+fNd+oZEQ8O6pwWJlbY1U5vvcK0PQOUmbhEFon2QHTGU2biv1yQviGSYnpa+rOyThQi2U9l5ktCjehdSi+m+A1mF/Nbt3V4YUwaSCaQFDIVtjT7bZwMjR6swIT4vwmmOxE+0dLiNyHXYwZXk939TE7jIWGCuthj6QCrBbaMUF4YCWtsEY8pkyE/5EtxddlBPVf3Nh+ECOEW/Kyf0w3om6SxzYYWS4E1lqYDSD+wd1T/mpmrCmWEFAEh2tU9wvaIh/6FlhdPWnUWcat3XRsQOXKbOYBEx1CfQd3hBVbNbAtTpQzj/W2iBb5EgfL/vGVA6KS4TqO9EIEVBbGERwV2s/a30sQGkhZRCufkSLyPT2my3/tdv/Z+3Hy1ugQfNMsQZ/kvB4qrhvK2M/fB18w+rqvI/8Qst7N3lcOurftUS/OVixIcFwE8tXV9BmrCD3oYoT5B7qZ6Kc9UyEAjZl6trP9KmzxpwU/ShmdQHwjyFjn5W6xxk/xLZfjBvDxm45yYIB6VQ9pDQN01ewGmqbgaBchZUitAhKbFosAveBrfXuHqv6A5lgjp0+JFL/3KaDbypzvYuI2UYB9tn1zw0j7SQPnYbZXkaIa8a838rK9amhgYIr2+ftbzRtGj1TcKU6LuAmhvgX3O3XS3ZylGb9SZqRdPj5TeAjGusEQox4q2t8eLWD35UJU0pFq2tpBqa4hJLRlF+7WjCivhTHPeofQDygCaTzHkJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(5660300002)(478600001)(8676002)(8936002)(86362001)(316002)(6486002)(66946007)(66556008)(31696002)(66476007)(4326008)(53546011)(2616005)(6512007)(41300700001)(38100700002)(83380400001)(6666004)(2906002)(31686004)(6506007)(36756003)(186003)(15583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlNvVDBwWUFqaTJEUVFkNU1nQkxha2Myc3ZKakYySTZ5Rjcwc1ltOTdydEg2?=
 =?utf-8?B?UTVqQ25MV2xNUHV4OU5hSWxvTW5xSnlPTi8zM215bVNvVndFQmlXdFBWQlpq?=
 =?utf-8?B?QndaMzB6cVpHV2NGOUNYbGNoS1JRaWt2RnNvWW1XK0U5bFZNTUdaOW5MVmNa?=
 =?utf-8?B?YS9OTHNuNlhpYk45OHA4N3BEUUs5Rm10OHVFOWZ4dkthMDd3SE83QWdYYkVi?=
 =?utf-8?B?ck1kRTFoT1JEQnd2NkdFdEFHVHFxZ202Tno4NjRWL1dFK0V0K3lzVTQ2bVNq?=
 =?utf-8?B?RnBzNDhiM3JmVGNyVEFuVmJUVk4xd0N6U1JPdGhCV0M4NDFMYUVBVWlLeWwr?=
 =?utf-8?B?MnhndkhRQXhubkhHa2JlUGt2UEczMUo4aXZCODRMako5bHJTbjdYV2lvZUlD?=
 =?utf-8?B?bmZJWnNvRzllM21nb25oTmp0YlUzTkNtNDNlZEtOM29uQkxMY1U3ZnFmSTI3?=
 =?utf-8?B?Z3lpa0RDMFVJZE5nakRWUE0wTkVGM3BMUUJubGRBMXNYUTh4WWtWSWVNZG81?=
 =?utf-8?B?R2VGTldOYm1sZHNtL2pFT2h3NFBNT3Myc04yU1ZOZ0lYRWFibHZRUWxPQVJv?=
 =?utf-8?B?a2NZc2hOY29OZFpIUis5dU1kdTE0SjRHRmhxbFg1Tzc0K1UxQnErNTA3Um9P?=
 =?utf-8?B?eXFHVndBUyt3V0dCMUlPZytXWTcxSmEwR1AwQlB3VFJuWWtja2tMZi9acnNz?=
 =?utf-8?B?VU5IR0pxQUgrUDk4MVUwYkNJYVkvamV2VmFqZHg3OXRJNEtEV1lOVXh1ckNr?=
 =?utf-8?B?R1d4a3V2YXZ0WnhVeVNpeHI1R0E2RG5mT0JMOUxObnpPVk9LaWxHdTkwczg5?=
 =?utf-8?B?Q3ZVejd1TUJmME1YKzhxekxVekRieTBXK3h6U2owUnFDTVBPeXlmZkZVNC9p?=
 =?utf-8?B?V05YVEJHK3lIRUxWM0pBTE84OHpjUGZPVFN5cGR5VjRuSzE4Yk1jeFhxVWx4?=
 =?utf-8?B?MlE4bkRTUFY4SUhmdUdNbU5QeC9vUk5meWFLZTFqWjBvcGF5MFZ4YjdVTVB5?=
 =?utf-8?B?SVZSYUdnYXZGMDNCd2xyZmEweDI3OThFQndqZDBsZTh0bGloUlBzZUpQSjd5?=
 =?utf-8?B?eUgvY2NGNmhSVFBudHQ0Y0tiQkFhdWJHNGczUWpUcENaT1BIVXBseEUrb1Nw?=
 =?utf-8?B?V0YxMHZ5d1VnR2RGMlVDcEVIREpBeVc5ODRZVFExRGZaT1JmWndSUHJwVUF3?=
 =?utf-8?B?OThOcWZ3a3lGRUZaTlBCSEdhaHBNUVhEQUhYTDcvZ3FIOStiNTY0VkZaNExk?=
 =?utf-8?B?ZDRPd2JNRUhkdVNQaXdsamxYSzlPTURXM2p5dGcwcCtKZWVDdkpYb1Q3c2lF?=
 =?utf-8?B?RWpmZmJYQUpCWVhzNDE4UFhNUEFzUzJvRUdDOWJOWUx0MGJGRFd2bkErUWJY?=
 =?utf-8?B?ZU1WbUlUR0JzY2ZwYUJCejZCSXh5aDVjMmhsWU9kbDFyNWlhVFBsT3RTMkRh?=
 =?utf-8?B?Q3ArWDRORkZwdVZWdjNRek8rYnAvWEtwS053WEEyTENMU0JiZzBjdFJSL3lv?=
 =?utf-8?B?cEdXRXVxYUJ4YXFxNThBZzl6OFptdU01YUZpcnVJUFNsK1d3WnBJOXkrZEFP?=
 =?utf-8?B?SThxL0dWU3l2enhFYVF4UFQ5WlpLKzJjQnIybGJlcDFZSThTN1dQZlV2OUhn?=
 =?utf-8?B?OW9IdGdNZmFNVmkvRmlVSkRMakUvT05IWTRlK0JldUlTSFIvbnNvRmdkbFpa?=
 =?utf-8?B?NkRrUjRPREtYYTJLb1grenFlUFBWTTlkcmd3ejk2RnBEbnRTNUc3bU83bjNH?=
 =?utf-8?B?ZmM3dzRJT25NeVVXeWhyYVF2N2lJVnhrRzNvS051YTdKb2Ztc0VWRkZEalUy?=
 =?utf-8?B?QVFWVUZIMFU2WWY0SkVoUTJ6TllNT3ZzdC9OYjFMRjBMREZJWDhXNXJrQkJR?=
 =?utf-8?B?ZTVaRGtaR05RR0hsTDNWTk5kaXA1MHIzWWNaQlpWSVpHaW53NEFyY0dHRzBT?=
 =?utf-8?B?d2k0a1FETWkvcnpJQ2EzVmlTSkRLcTlwMGh5ck5HTlhUQmFhRjhQUFZoYTlE?=
 =?utf-8?B?TVZVSjk0TktLMmNsLzk1SEsyS3VIRU1qTVlWUnhvTy9HR1Z4V3ZRQ2FnNWsy?=
 =?utf-8?B?VGFUeC9DWGNGUkF0QUEzaFhHNExVZXlXQkRQb3pOOWFEbVk3eTliVkI1UjBH?=
 =?utf-8?B?dEVnSTZOdXpGaFRpQ21CWUZKbFRTM0xFbktUOWhJRi9KVGJLd0ZSSmxYMWtC?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5fb295-a257-48b7-e2b8-08da66891fe6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 17:40:35.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt2w/W5Xwzul3QtI7MbVGjqhe4gyIzZ5Y1NKtzXF1ocJjbYT+bA2OpRrAHsZJ+l3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5258
X-Proofpoint-ORIG-GUID: s8HmnGzAcZ0WTJX82c_pVc36XwfTNOMh
X-Proofpoint-GUID: s8HmnGzAcZ0WTJX82c_pVc36XwfTNOMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_09,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/22 10:15 AM, Jon Doron wrote:
> From: Jon Doron <jond@wiz.io>
> 
> Add support for writing a custom event reader, by exposing the ring
> buffer.
> 
> With the new API perf_buffer__buffer() you will get access to the
> raw mmaped()'ed per-cpu underlying memory of the ring buffer.
> 
> This region contains both the perf buffer data and header
> (struct perf_event_mmap_page), which manages the ring buffer
> state (head/tail positions, when accessing the head/tail position
> it's important to take into consideration SMP).
> With this type of low level access one can implement different types of
> consumers here are few simple examples where this API helps with:
> 
> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>     to handle the wrap-around in some other way.
> 2. Since perf buf is per-cpu then the order of the events is not
>     guarnteed, for example:
>     Given 3 events where each event has a timestamp t0 < t1 < t2,
>     and the events are spread on more than 1 CPU, then we can end
>     up with the following state in the ring buf:
>     CPU[0] => [t0, t2]
>     CPU[1] => [t1]
>     When you consume the events from CPU[0], you could know there is
>     a t1 missing, (assuming there are no drops, and your event data
>     contains a sequential index).
>     So now one can simply do the following, for CPU[0], you can store
>     the address of t0 and t2 in an array (without moving the tail, so
>     there data is not perished) then move on the CPU[1] and set the
>     address of t1 in the same array.
>     So you end up with something like:
>     void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>     and move the tails as you process in order.
> 3. Assuming there are multiple CPUs and we want to start draining the
>     messages from them, then we can "pick" with which one to start with
>     according to the remaining free space in the ring buffer.
> 
> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>   tools/lib/bpf/libbpf.c   | 16 ++++++++++++++++
>   tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
>   tools/lib/bpf/libbpf.map |  2 ++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e89cc9c885b3..c18bdb9b6e85 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12485,6 +12485,22 @@ int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx)
>   	return cpu_buf->fd;
>   }
>   
> +int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf, size_t *buf_size)
> +{
> +	struct perf_cpu_buf *cpu_buf;
> +
> +	if (buf_idx >= pb->cpu_cnt)
> +		return libbpf_err(-EINVAL);
> +
> +	cpu_buf = pb->cpu_bufs[buf_idx];
> +	if (!cpu_buf)
> +		return libbpf_err(-ENOENT);
> +
> +	*buf = cpu_buf->base;
> +	*buf_size = pb->mmap_size;
> +	return 0;
> +}
> +
>   /*
>    * Consume data from perf ring buffer corresponding to slot *buf_idx* in
>    * PERF_EVENT_ARRAY BPF map without waiting/polling. If there is no data to
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 9e9a3fd3edd8..9cd9fc1a16d2 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1381,6 +1381,22 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
>   LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
>   LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
>   LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
> +/**
> + * @brief **perf_buffer__buffer()** returns the per-cpu raw mmap()'ed underlying
> + * memory region of the ring buffer.
> + * This ring buffer can be used to implement a custom events consumer.
> + * The ring buffer starts with the *struct perf_event_mmap_page*, which
> + * holds the ring buffer managment fields, when accessing the header
> + * structure it's important to be SMP aware.
> + * You can refer to *perf_event_read_simple* for a simple example.
> + * @param pb the perf buffer structure
> + * @param buf_idx the buffer index to retreive
> + * @param buf (out) gets the base pointer of the mmap()'ed memory
> + * @param buf_size (out) gets the size of the mmap()'ed region
> + * @return 0 on success, negative error code for failure
> + */
> +LIBBPF_API int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
> +				   size_t *buf_size);
>   
>   typedef enum bpf_perf_event_ret
>   	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 52973cffc20c..75cf9d4c871b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -461,5 +461,7 @@ LIBBPF_0.8.0 {
>   } LIBBPF_0.7.0;
>   
>   LIBBPF_1.0.0 {
> +	global:
> +		perf_buffer__buffer;

You probably use a old version of bpf-next?
The latest bpf-next has

LIBBPF_1.0.0 {
         global:
                 bpf_prog_query_opts;
                 btf__add_enum64;
                 btf__add_enum64_value;
                 libbpf_bpf_attach_type_str;
                 libbpf_bpf_link_type_str;
                 libbpf_bpf_map_type_str;
                 libbpf_bpf_prog_type_str;
};

You need to add perf_buffer__buffer after libbpf_bpf_prog_type_str 
(alphabet order).

>   	local: *;
>   };
