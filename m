Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D85964E69E
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 05:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLPEL0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 23:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLPELY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 23:11:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16B56D41
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 20:11:23 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BG2ShvU025623;
        Thu, 15 Dec 2022 20:10:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=AQdTi1f1W4b2zpeI8HtqFwKnboCfAhhaG2Yp7ZbD4KQ=;
 b=MmP3uPKbp+ezI6nleM3scwpvM1UGS6W3PB7sXOStx1Q0vsHSwVYq/V1X6dqRYrxS3sTT
 hfRiufLjHOglIO5Pund7m/jsVLjZ7hSUZf7kd+HWYHNzjENnM75QhE5nhhLjMuMojY/D
 Nin7enWjETGeUDTERWJUO9icsPT5oxuOlgccAsod7h8Xn4LN6jHy5FJeQZySmCkQRF8X
 eksEXNzlIBonk/TaJhIdTBe9ZL71QQvOIBel7AzYG1w9syUtvTCgYx7KndPfJz4vfH9y
 LFtGpEi77JKQ7/HZkql3iWnPBbwUX0ACexqpdrEXIS3vOOwjJmrda5pNzgNpdOz3YWcI GQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mg3hmwum8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 20:10:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJbAO63owgAFXLqMmJ562WorQcjHnOjde5he9d4liA6xJpVBBBy9pm1qQduHbaaQ2tnU61dAsA1DCFdghDJhaBoz1QIQJgaxVI8mlcgpQ+aL8VT+zxkZJgBe2Jhmsnlj3cFC3SSwjyiJ8SYNRkcN1bd/KbC6i9ATIUV2yS0F1bkzxg9HkRmu8ItxBg9TcJJYKLTrUXAZBhizK324iYPEbSvVUj/eGtoc9c682DfM6ezd236gEiEDncbw06QinPRMhY6oYvaGlEGc1Tv7ijGE2a6uA87GD0wtomI54I2rYVo+g+WMHgPKJc2zEHSogliTR6ICpSMBw5XLmNQkfSwo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQdTi1f1W4b2zpeI8HtqFwKnboCfAhhaG2Yp7ZbD4KQ=;
 b=IgzQRvfgSGPp9fN8+0fQPtsKN9ll/8yLKK2fW/3o2q0J/vf97iETbOuNeznhroTt14JoeHWLGZO+A9I0B/OcwEb9AND9RgcEhM3Z40BlGtOH1LhNBPBsX1bQYk6W32aymktv2sZp2UMMR+PtRNF5DumbVVFEQZjY1qkbWmEgcKhG2LBOOYcKKcil454YUfA5xDZzGkJZ+I2oVXcCRWIYMMa7L/tGqwcuJHgqWD+5O8i6GA2drzzwhwL2CgXlM4ZVna3dLnVGE4IGnY4wvLzuglpFKQXDKW1merOKNBB3DQWbpUW6L8hE62KTWwi1GP3Kf+343HPGtCdfGPl0JNel0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1949.namprd15.prod.outlook.com (2603:10b6:320:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 04:10:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 04:10:55 +0000
Message-ID: <73b9ef21-de67-e421-378a-1814ffbc263f@meta.com>
Date:   Thu, 15 Dec 2022 20:10:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [bpf-next 2/2] selftests/bpf: add test cases for htab map
Content-Language: en-US
To:     xiangxia.m.yue@gmail.com, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
 <20221214103857.69082-2-xiangxia.m.yue@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221214103857.69082-2-xiangxia.m.yue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MWHPR15MB1949:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe4cd01-9484-47e1-5990-08dadf1b86fe
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFNn8RbrsE37EdJmRzlZ1X6QdpeV24ucPopLVXXIqcBxri3NzA2r/VTeFB8tspg8C9c/Dkg4ba67qrT14HClTDHjrB8ASWqLvM89EDV0Xr/rAfyvuBG1dZ4PJvmW/guw5gHHfzDnkYlmNp6EJJiKk0xBOkNuYcBPWvQt34i3kiAW0M1thzle8y1dGlrh9Tx9IF/qJTzE2KriYUHyHMyrgE9RV8PsBErIVY+Y1PMhLNi3Zc1cSiPSjE7NMkhzuGgj0n6mX0tXt3uhi9ahvduHXHV9rWJxjXI9Zuj9kM5yNTJal9kg5Go3N6DvpjVhHQpYBk9UtgwogA0+CWGDFrl8wtw2hsCOnIwnW7eQdVLoUHc/Z7wdv4yVu5QxIkp4gf8Pi3yAuW89jm8F7686ajWzjOq48qFmAceI1NMex8t37/3YazddTP2HO0wqkvik0MSgpX6qGCfFBxjIXDRvpUCNbDtK2WJFc6ikUjzyAOgePsg8GsvX/IQDL+3xHVABB3YD/eJRa6csFSHgvXo4R+kPxSTHqYB7NAIoXbTznv7r4esrs5sQ3eWXP0AyEYZCj8LeKGNVL3ROMRy073NUKUej3cJU+gP3KJd6GW/5lONX2gmk+EbTYq96KIWFvUZSkyodhiHKVHhosRjNcT7M3KyX+kMegm8ZlfkRrRFVXdoEzaG5giLA8ab8zWIZGUo/kz4gDSbGQBD7imOZZjBxyMiHnWZ5FunvKNtHJc05MBDDLnGCrU8S8QR5PwTcp0kSsWFzg/Qi3Tx0CX99C53FtIgixQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(31686004)(2906002)(7416002)(186003)(54906003)(316002)(36756003)(5660300002)(4326008)(8676002)(8936002)(66476007)(41300700001)(66946007)(66556008)(6666004)(478600001)(2616005)(31696002)(966005)(6512007)(86362001)(6506007)(6486002)(53546011)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJBTGtPVktSNFFFM29vNEZCNHYxNGNGS01CVWVLU004cktNWmd2RjNUalVa?=
 =?utf-8?B?MjY0cFVJS0h3ekpIRE1iVnB1N1M2alpQbWlpTWV2WDVqc0tmOHZHQk81YW4w?=
 =?utf-8?B?S2g0cEsrUWlQNXFSWFVoNnNqUVRETSsyNjd5WkVQdDJIYVh2Y2VBRUpZcUIr?=
 =?utf-8?B?ZEVpbEkzeWxGZVlMUzA1WVpwVHlmdzVtQkQ1S2M1NTB6Q052aGJ0NWNlWEF0?=
 =?utf-8?B?U1ZXUG51MnFCR2ZoTlp5T0FpcTAyb0FzNWwvbUhkVzRHZEN0cExLU21pdlBC?=
 =?utf-8?B?d0V4Y1o4US9yU3crK200RmVWQzhMQ3gwUm9QQW02RW9TckZMaTFtVEsrSEkr?=
 =?utf-8?B?WklzaWJnSFJDZy9sdC9EOFUvL3FoSE5YcjJockpacHVJUGF1MHBHajNZRWFj?=
 =?utf-8?B?MUZoT0RtaUVGS2huLzg2ckNsMG1wVG9yNTBSaHY3WnpSa1QzSFR2OGhwU3Jr?=
 =?utf-8?B?NXNuUWRaQVg2Y3NZMVZ6WkRxQy9sdzdmYlFFVVFwMW8rbjZSZHY1WXMyUHZr?=
 =?utf-8?B?bnY5YmV5aUxqWGpPekJBSHFDNWgzc21vZGRBSVlNZGoxbCtxZTZWZUJhUk5k?=
 =?utf-8?B?Y3U4WEpIQlE3MTFQTWtpcFUwbUtKSUZMOXJNNjVjS2ZwQzZPQktpbFMyMWZ1?=
 =?utf-8?B?WDZZcTM3OUJ5T3FYTmlhRm9yUmdqSVArelRLeGd4UFBBUVhQTzFYaHlCSDlh?=
 =?utf-8?B?anRMMnp4bU9VbnVGUXNzbzM0aVduakczMXY2eW9NSUxZcG9TWFF6VEdkT0Y3?=
 =?utf-8?B?MWpuSU5NT21WSEdibEFsa0FDRXZiWURGT1E4N2dycCt1dGNCblBKRkJqT3JI?=
 =?utf-8?B?NlJuVzIrYjNFdDFWdnltaWY2ZGpUNkwxdkd0M0RrZmlId2Z0MjVlTmJMMzdX?=
 =?utf-8?B?M29UZ3pNbXlieHpQdXhCWUh3RVo0dGVLSzU3UyszYmRzZU4wSkdRZFowZkhm?=
 =?utf-8?B?Yy9aMW1jMXkzODZyUzNUWC9oZTlGcE85ekNndSs5NUhZNFRKUlFyWmtXMVpJ?=
 =?utf-8?B?ZEs1bjJTMDBXR1ZuTmp4NEhlQWZicC9uUWRtT2U2d01hTWU0cHJYSEsvQ2F5?=
 =?utf-8?B?eDl5MVgxaEFQUTFUYmJ5REZBdFRvUHZGb1NlZm83STVBVStCTGRmTHF1MHdP?=
 =?utf-8?B?VDB1eGkxSmVwK0MzTm8rb2JJalRLU3RXQ2k1TTN4RzBrSE4vSU9tYkhIOFRn?=
 =?utf-8?B?SlE2WjU3U3VVMCsreG4vUFpMWFNFK0Y0d0gvdTdCMGxLbXNjVkpacDBEM0tn?=
 =?utf-8?B?eE44cS9HcWZOOVcydklSR3FQbVhXT2Q1cmw0c2pZbUcvYlFUZ1dvbHlKSVlM?=
 =?utf-8?B?MW1tQzFOSHRiclRsTzBEbXVtaEd6V0p3Vytub2VVNGtzcW5KMThYVmo1K3ly?=
 =?utf-8?B?c1hUMWIzNllQcldLNUk0WHRpZDZXSjJxYjdYcUJ6eDVWM1ZzK3Z3TzVKeHdC?=
 =?utf-8?B?aFhRMFZtcG1nVzlPMGtGbjJ6WnB0eTNHOWI5ZnQ3ejlSQURPUUFtc0tVK1pq?=
 =?utf-8?B?b1ptdXlobklvTXlxdE5TY0JvWVBDRjhpdWEvcU1vWlN3ai81QVhFR1liQVFW?=
 =?utf-8?B?VEE2Y0puQ3pPMGpSR3c4bjlyc241cFh4WUZDWHhuMUZ3VU9JVmhHeXhCTXRz?=
 =?utf-8?B?QmlGWThPMGRrOVhPMVlMNnNSTTRuV3BaUnp2M2RwY09UY0YvNENMZnJlWmlD?=
 =?utf-8?B?MVBuY1ZMbHFZVEFKSXRHaW9rQ3dyUGw4Y1BibU9yN3pSL3hxOFM4ODVhZWJM?=
 =?utf-8?B?SmVCaEFyU0pIeHgvbXhNTGduQ3VwVmtMY3R2Q3p3b3cvMUk3bEtueGpQdGRx?=
 =?utf-8?B?cFhQdnRCOE5VRG5rbDZFRHcvTWRTVHpYMmt3MFdyMitJdm5QeXFNa20xRndu?=
 =?utf-8?B?M09EblJzZTZJcFgzQXI3QjNyOHVrZ0hRdC9sanRwblJVekpqTlVVd1lqZ2Zw?=
 =?utf-8?B?TlEyUjZrNkhpdE5UVEZsM1J0M3lvbmx0RlZrQ3ZxOXFmUGJORS8wOU5lcEc0?=
 =?utf-8?B?YlVqaEx4QTNRdkxtaU5KamsvVDExcGo4eE0xN2w0dTA1MHhJTEthbzRHay9X?=
 =?utf-8?B?TUhrQ2xSL1B6Y2w5UFJjbnl3eEVWajFrK1MyazVGR1R6RjArdWIyVTlJaExI?=
 =?utf-8?B?cithODRpSjA1bER6NEhkcW1sSUlJRVZIclI1ZXh3aWF5cW55L3k2akJQRzRV?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe4cd01-9484-47e1-5990-08dadf1b86fe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 04:10:54.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMzAM+mlKX60onzVv1XOGfICMkxlOQI3sswI7ZTNFuQzUAdW3j9t1wSv9NrWtPem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1949
X-Proofpoint-GUID: WUvbyZS1lWyMUlAVyTBCrbcmBwvaosoY
X-Proofpoint-ORIG-GUID: WUvbyZS1lWyMUlAVyTBCrbcmBwvaosoY
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/14/22 2:38 AM, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> This testing show how to reproduce deadlock in special case.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>
> ---
>   .../selftests/bpf/prog_tests/htab_deadlock.c  | 74 +++++++++++++++++++
>   .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
>   2 files changed, 104 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>   create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> new file mode 100644
> index 000000000000..7dce4c2fe4f5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 DiDi Global Inc. */
> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include <sched.h>
> +#include <test_progs.h>
> +
> +#include "htab_deadlock.skel.h"
> +
> +static int perf_event_open(void)
> +{
> +	struct perf_event_attr attr = {0};
> +	int pfd;
> +
> +	/* create perf event */
> +	attr.size = sizeof(attr);
> +	attr.type = PERF_TYPE_HARDWARE;
> +	attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +	attr.freq = 1;
> +	attr.sample_freq = 1000;
> +	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> +
> +	return pfd >= 0 ? pfd : -errno;
> +}
> +
> +void test_htab_deadlock(void)
> +{
> +	unsigned int val = 0, key = 20;
> +	struct bpf_link *link = NULL;
> +	struct htab_deadlock *skel;
> +	cpu_set_t cpus;
> +	int err;
> +	int pfd;
> +	int i;

No need to have three lines for type 'int' variables. One line
is enough to hold all three variables.

> +
> +	skel = htab_deadlock__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	err = htab_deadlock__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto clean_skel;
> +
> +	/* NMI events. */
> +	pfd = perf_event_open();
> +	if (pfd < 0) {
> +		if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
> +			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
> +			test__skip();
> +			goto clean_skel;
> +		}
> +		if (!ASSERT_GE(pfd, 0, "perf_event_open"))
> +			goto clean_skel;
> +	}
> +
> +	link = bpf_program__attach_perf_event(skel->progs.bpf_perf_event, pfd);
> +	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> +		goto clean_pfd;
> +
> +	/* Pinned on CPU 0 */
> +	CPU_ZERO(&cpus);
> +	CPU_SET(0, &cpus);
> +	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
> +
> +	for (i = 0; i < 100000; i++)

Please add some comments in the above loop to mention the test
expects (hopefully) duriing one of bpf_map_update_elem(), one
perf event might kick to trigger prog bpf_nmi_handle run.

> +		bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
> +				    &key, &val, BPF_ANY);
> +
> +	bpf_link__destroy(link);
> +clean_pfd:
> +	close(pfd);
> +clean_skel:
> +	htab_deadlock__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> new file mode 100644
> index 000000000000..c4bd1567f882
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 DiDi Global Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 2);
> +	__uint(map_flags, BPF_F_ZERO_SEED);
> +	__uint(key_size, sizeof(unsigned int));
> +	__uint(value_size, sizeof(unsigned int));
> +} htab SEC(".maps");

You can use
	__type(key, unsigned int);
	__type(value, unsigned int);
This is more expressive.

> +
> +SEC("fentry/nmi_handle")
> +int bpf_nmi_handle(struct pt_regs *regs)

Do we need this fentry function? Can be just put
bpf_map_update_elem() into bpf_perf_event program?

Also s390x and aarch64 failed the test due to none/incomplete trampoline
support. See bpf ci https://github.com/kernel-patches/bpf/pull/4211.
You need to add them in their corresponding deny list if this fentry
bpf program is used.

> +{
> +	unsigned int val = 0, key = 4;
> +
> +	bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
> +	return 0;
> +}
> +
> +SEC("perf_event")
> +int bpf_perf_event(struct pt_regs *regs)
> +{
> +	return 0;
> +}
