Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789703DAA5F
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhG2RgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 13:36:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53320 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhG2RgJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Jul 2021 13:36:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16THTSlO017620;
        Thu, 29 Jul 2021 10:35:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0NyEwOA8PnckxKvLjuJ1UztfPG8VNz0RDrkWgbTX3iU=;
 b=cLmM3RpWLBXysNLlQbAc7/7Cvn2Z+6LcYNizFugA9qlvFwUAxa5bhDNL+U+xkFq4vq7Y
 yCQwpekPccxdnqfhXSZoVoAHBFgXM+Bm/rhDXHwJjwmjJqSCd1BE634IINqNX34wp+lR
 3oyjFkKBJ4jml6RfakdPfLxeOO6WwKkJPUo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3a9r06pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 10:35:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch5LH2W6VP7Nz1LHAZ/ePW4a1ir3NcyNIAXBVB77H2hK2PNnR2Rn+1xhgwRzTnsqxOTk3QlFKi9Mc/h0+5RDi8YJ8+oFNcukRbCwQ/xTHoN/GQtxxlVXCtkyJBpRqcWDBmPBtSizS51zSoJsh/hlAV0hIEyKGrAT9G3yacvEmjLSX08uxV3MfaQXRovGWO+0PxHhmBVtxlLUMTk3GSsYz2rGSZ16LeVK2sx61j9kKcmTnr+SWSaN/3yNqVvII+5Ac4u8liVQC4VkAX82rxhKNQv5t7k1eowv/lZjjFdyXUqcwck9fe4xY0OkmpoG1Lc6wSznKE1wdUXcpmc1bB7+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NyEwOA8PnckxKvLjuJ1UztfPG8VNz0RDrkWgbTX3iU=;
 b=SsTtiDKC2vUsQUUci0VTV+6viwpJ/yN+TDSESQ/EgrJbabPXc3jACtHIkPyDA8EnMBJHEzSP2MlZXd5vWBjfmxajAHhKVghJ9WA+bpyG/X1FlV5Su02VLveKk/cV36pK//04pEpswA+i/UN8jzTKAW3iBstuSq9v1BmpWIwxKRIp9Xq+ivQtdI0ScC1r4XqwpBUm61SKpY8TwERX20532pxOclCWyUUgOrwF0LWlW3EqP1PX8V5Zn1aEAZcViH6Wb/Wh0EvA9IA4CONOKIKpwv//rjj0qMjssjFobLgfuYswqFs4k/2y/QbFHLpVuWWyPnnWb6xWzrjxs2SUZ7kJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 17:35:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 17:35:46 +0000
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-5-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6b61514f-3ab8-34bd-539f-e5ff8d769e77@fb.com>
Date:   Thu, 29 Jul 2021 10:35:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210726161211.925206-5-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11d1] (2620:10d:c090:400::5:81b5) by SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.9 via Frontend Transport; Thu, 29 Jul 2021 17:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e07f663-bc04-4ca3-e262-08d952b74c4f
X-MS-TrafficTypeDiagnostic: SA0PR15MB4062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB4062F95B175C12930061DAFBD3EB9@SA0PR15MB4062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIOTiXxK0B2KUbAYVrUdU0rMWUf6GSgGCo5lKWPNUpqujzdbcxhHiWyen88Kj7zVSI+NP9k75tW4mA9cxlkwgPJAUSyZckgl2O/0rgLBAwf9ym/UZH/aLaRkgIbTNGteVmqf3Hm88m4ZAGrqJs0sKJJeCk0dQuXch6j5y7d2HJwg+YwOL72PdQ4wFJphgxBUHXwCUSek7VT+lkm8AyxoZdCcgD1ERa87pXAaLmMaGDWPjNWXyChh3T60e7h5F7oNzoqSuPveZiXz7URNo9GQ99k8BGkOdXMxbdiJ/Ob3P9BpPvBOYEcoWMfyGRhFVi/RQKuOFUNCZDI9B6H2Sbah/SAtcYaTW6tIeJWtPiW1mWs7hHpxYYSxpgNpzHwX/4hoBT4QCB50abkxFZOklvkvHNZ9uNMRWuL9gYXzZ7fUeXVuqe4IHw7RR1q0HuGrYZjB51PNaumhwllHQR7DUbwX1sNgucQ0cA7k3ICGhWxhJI85Qzpv/l7RqUPXKwnb3wbc5RHMknI04f8kmxl/a4OHYzLN3CZDWDWXFcO9+uNUyEmBATyivQTLh/pQ3MI+qvjpNPztRaFMrgD0R2Ot3d9d9BzmuTu8asf2T9QFrnwVD/Z3ouav7rKpy2ug63KGiN5uiBoBirzTlYyKtTRhQeD6SBJuZCBxXwqCQt3aNGkmiXjD/xJNRZRPxCrKTwmRPIivSK1FtX2Xy13S/HkpcmhkirDkBMxb53TH6xqqg0lZtdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(186003)(86362001)(316002)(5660300002)(53546011)(6486002)(2906002)(83380400001)(31686004)(66946007)(66556008)(36756003)(8936002)(8676002)(2616005)(52116002)(31696002)(66476007)(478600001)(4326008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9jSzI3ZE9HQ056M1JoYWJkTmV1T0RQckIvUWlud2VvU0lTdkRrNGZXdWFH?=
 =?utf-8?B?ZlNqbXFhejdCK0NxNWJqWTJwQUMrRjhjUi9xaSs0TG5jTXFtRTlwazFKVk5Y?=
 =?utf-8?B?akRGbWpXYWs3b3F1ZitXY2U4bGtpNXI3QjJtWXRhY2FxYkEwRHBQeFFTb2U4?=
 =?utf-8?B?bXRiU3BzYTVHSi9uNWZUZUU5NjhHcldJZVVpZFJiVEFHVkUxZi9sdTJnenBn?=
 =?utf-8?B?R292TlUwR0Y3WTlaYWJjTWYrUURJSlhBczBIWHJxeUhxeFUveGxmejhPbDF4?=
 =?utf-8?B?UnhyMWdmdXEya1pDdVhYa2xOTU1adGcvQXQ1MEQvenZGNEx6eXpiRHBTcWdM?=
 =?utf-8?B?a2RCb1VsSEdOUmp5Rjc5RXJOeml5YTlhY1h6OVlxRnBjUEd5ZmRQUmNSZ1BR?=
 =?utf-8?B?M256RVZMWklPZkU3aXM2bGxmZ3FpRUhveWFldnlDVUNUYi9XYWZvQnI5ZXVO?=
 =?utf-8?B?cmJSL3pPdC9IenRYZ2NER0JtQjE2ZEd1YVpUUjMxQWxVWEFZc1BrcUE3bTRT?=
 =?utf-8?B?bEFMK2VGS21vbVhYaVhEcFpjbnl3cU5Ra3BSQzdJdXY1M00vWHFFbHZUN2NW?=
 =?utf-8?B?S3lkSWJud3NTU1NMM0dlWFZhRjdMSTdmUDM3WHF2YkpVY003K3ZTa3VSZEVI?=
 =?utf-8?B?VnJJUnl3b0dpd1NlenVLSG50TllEdW9KM3pZYXM2c1dZMlZMUEJmek9uREVp?=
 =?utf-8?B?Z1NTeTgzTTUyQ0FzenJldnF3dzBXRE4rbGxMWWhnV1hGWHlCYXd3ZFFGRTZq?=
 =?utf-8?B?M3lHcmY5VTBhNExSSDlIcXNsVUtIbGt0bm50di9MQlMxZUJzYXhEdm1TMzdS?=
 =?utf-8?B?TWhKbVEwS01XV1FQR0QrNVB2bmpnMnR3aWszZnJIUHlwUng1ck4xRTF3ZnVU?=
 =?utf-8?B?MnEvZnB5akJZUktwb0ZSVEhnU3VVeGZzTWd4Yy9qK2pLQ3RDaFNnTklkeksr?=
 =?utf-8?B?OE5QajZhUkpIY2t5QU82Y0FXWW9xRmh1RzNNZnhJSEhQK2htU1NNK1VYS0dK?=
 =?utf-8?B?N05QenZUOVpHQkZ0dVMzL2dNblJFNFBXQ0JzSnNDVHp0RncvTURscXc5alFB?=
 =?utf-8?B?TUJ0SjVwSlBQQWZmaDBZT3pEZHR1dENZUFp4OURKRnV4b2lNYjNrV3ZpdEVv?=
 =?utf-8?B?NGdNVTMrejBqQmVQOVlyVmhhT2dHcmQwRElJZ0N6ZmwvWTY2SVZHUVI5cjNL?=
 =?utf-8?B?QXk3eE9OOHdLZ1VTWWJTL1hYcnNjOFY1UWVzVGdEellLNlBJTmxFOTZoSGZE?=
 =?utf-8?B?Q0IycUxPUStmdWF4dGJNN3NZcldsT3RWMmVRcnJoRTg5WlUwdzk0bmdvUkE4?=
 =?utf-8?B?RWZCcVBoZ0lweVd6UUI0cGRuYjVoMENjWGlFUWNyMnFQTUdxaTJ2OVVWKzE4?=
 =?utf-8?B?YWs5SXB4RzNhWVFoNVhmY1RYdG1GRnp5dXNrTEl6Z3I0eS9RQ002NDFKKzZn?=
 =?utf-8?B?Um5wcEh2NGxacktUSmRjRkJTeG9hbFRCdU0xSnJDZnF6eGVVWUlTSnk0aDJB?=
 =?utf-8?B?SExYTkNRQVoyMFdEWnlxTk1hNnZRSkZiUUUwWG9CQmxWV1VveHJ2dTVRb2ph?=
 =?utf-8?B?R1RGMXNGVFlzYXVZUXQvbmFnZnJRV2ZlS0R1TTM1Q09xdlhOVUpLQVZYYVN2?=
 =?utf-8?B?WjEzYnA3NTFjN0R6NTVsWWhOTHd6bnBmZDcwcjBSMTQyRUNxbXlrTE42SzNp?=
 =?utf-8?B?ZnRlTUtYUDI2QUdkVmRRV0ZUS09qYitOVmpvYkk3OEVwdkQ0Q2hjS2Q0SHUw?=
 =?utf-8?B?enFQbGlSVm80Mk05dEo1SmNpdkNQSVhnMU1ZQ2dHdWJCTjRoNVJtcHFCVHd6?=
 =?utf-8?Q?dr4mYzxoqHBb6O1votmm4LeGGFr7KryaMf4/s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e07f663-bc04-4ca3-e262-08d952b74c4f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 17:35:46.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J/uoGEfOyMRXoI8hzUIyiWHVoH58blXQQHslIr2akkaDWi2dIo/XYb+OmvMbXSm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: lWb2OFyX7dhm4xml0qMB_PLt_H0IPZZt
X-Proofpoint-ORIG-GUID: lWb2OFyX7dhm4xml0qMB_PLt_H0IPZZt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_14:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
> Introduce a new type of BPF link - BPF perf link. This brings perf_event-based
> BPF program attachments (perf_event, tracepoints, kprobes, and uprobes) into
> the common BPF link infrastructure, allowing to list all active perf_event
> based attachments, auto-detaching BPF program from perf_event when link's FD
> is closed, get generic BPF link fdinfo/get_info functionality.
> 
> BPF_LINK_CREATE command expects perf_event's FD as target_fd. No extra flags
> are currently supported.
> 
> Force-detaching and atomic BPF program updates are not yet implemented, but
> with perf_event-based BPF links we now have common framework for this without
> the need to extend ioctl()-based perf_event interface.
> 
> One interesting consideration is a new value for bpf_attach_type, which
> BPF_LINK_CREATE command expects. Generally, it's either 1-to-1 mapping from
> bpf_attach_type to bpf_prog_type, or many-to-1 mapping from a subset of
> bpf_attach_types to one bpf_prog_type (e.g., see BPF_PROG_TYPE_SK_SKB or
> BPF_PROG_TYPE_CGROUP_SOCK). In this case, though, we have three different
> program types (KPROBE, TRACEPOINT, PERF_EVENT) using the same perf_event-based
> mechanism, so it's many bpf_prog_types to one bpf_attach_type. I chose to
> define a single BPF_PERF_EVENT attach type for all of them and adjust
> link_create()'s logic for checking correspondence between attach type and
> program type.
> 
> The alternative would be to define three new attach types (e.g., BPF_KPROBE,
> BPF_TRACEPOINT, and BPF_PERF_EVENT), but that seemed like unnecessary overkill
> and BPF_KPROBE will cause naming conflicts with BPF_KPROBE() macro, defined by
> libbpf. I chose to not do this to avoid unnecessary proliferation of
> bpf_attach_type enum values and not have to deal with naming conflicts.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   include/linux/bpf_types.h      |   3 +
>   include/linux/trace_events.h   |   3 +
>   include/uapi/linux/bpf.h       |   2 +
>   kernel/bpf/syscall.c           | 105 ++++++++++++++++++++++++++++++---
>   kernel/events/core.c           |  10 ++--
>   tools/include/uapi/linux/bpf.h |   2 +
>   6 files changed, 112 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index a9db1eae6796..0a1ada7f174d 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -135,3 +135,6 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
>   #ifdef CONFIG_NET
>   BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
>   #endif
> +#ifdef CONFIG_PERF_EVENTS
> +BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> +#endif
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index ad413b382a3c..8ac92560d3a3 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -803,6 +803,9 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
>   void perf_trace_buf_update(void *record, u16 type);
>   void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
>   
> +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> +void perf_event_free_bpf_prog(struct perf_event *event);
> +
>   void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
>   void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
>   void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2db6925e04f4..00b1267ab4f0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -993,6 +993,7 @@ enum bpf_attach_type {
>   	BPF_SK_SKB_VERDICT,
>   	BPF_SK_REUSEPORT_SELECT,
>   	BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
> +	BPF_PERF_EVENT,
>   	__MAX_BPF_ATTACH_TYPE
>   };
>   
> @@ -1006,6 +1007,7 @@ enum bpf_link_type {
>   	BPF_LINK_TYPE_ITER = 4,
>   	BPF_LINK_TYPE_NETNS = 5,
>   	BPF_LINK_TYPE_XDP = 6,
> +	BPF_LINK_TYPE_PERF_EVENT = 6,

As Jiri has pointed out, BPF_LINK_TYPE_PERF_EVENT = 7.

>   
>   	MAX_BPF_LINK_TYPE,
>   };
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9a2068e39d23..80c03bedd6e6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2906,6 +2906,79 @@ static const struct bpf_link_ops bpf_raw_tp_link_lops = {
>   	.fill_link_info = bpf_raw_tp_link_fill_link_info,
>   };
>   
> +#ifdef CONFIG_PERF_EVENTS
> +struct bpf_perf_link {
> +	struct bpf_link link;
> +	struct file *perf_file;
> +};
> +
> +static void bpf_perf_link_release(struct bpf_link *link)
> +{
> +	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> +	struct perf_event *event = perf_link->perf_file->private_data;
> +
> +	perf_event_free_bpf_prog(event);
> +	fput(perf_link->perf_file);
> +}
> +
> +static void bpf_perf_link_dealloc(struct bpf_link *link)
> +{
> +	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> +
> +	kfree(perf_link);
> +}
> +
> +static const struct bpf_link_ops bpf_perf_link_lops = {
> +	.release = bpf_perf_link_release,
> +	.dealloc = bpf_perf_link_dealloc,
> +};
> +
> +static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_link_primer link_primer;
> +	struct bpf_perf_link *link;
> +	struct perf_event *event;
> +	struct file *perf_file;
> +	int err;
> +
> +	if (attr->link_create.flags)
> +		return -EINVAL;
> +
> +	perf_file = perf_event_get(attr->link_create.target_fd);
> +	if (IS_ERR(perf_file))
> +		return PTR_ERR(perf_file);
> +
> +	link = kzalloc(sizeof(*link), GFP_USER);

add __GFP_NOWARN flag?

> +	if (!link) {
> +		err = -ENOMEM;
> +		goto out_put_file;
> +	}
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
> +	link->perf_file = perf_file;
> +
> +	err = bpf_link_prime(&link->link, &link_primer);
> +	if (err) {
> +		kfree(link);
> +		goto out_put_file;
> +	}
> +
> +	event = perf_file->private_data;
> +	err = perf_event_set_bpf_prog(event, prog);
> +	if (err) {
> +		bpf_link_cleanup(&link_primer);

Do you need kfree(link) here?

> +		goto out_put_file;
> +	}
> +	/* perf_event_set_bpf_prog() doesn't take its own refcnt on prog */
> +	bpf_prog_inc(prog);
> +
> +	return bpf_link_settle(&link_primer);
> +
> +out_put_file:
> +	fput(perf_file);
> +	return err;
> +}
> +#endif /* CONFIG_PERF_EVENTS */
> +
>   #define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
>   
[...]
