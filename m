Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742F0513A10
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349054AbiD1Qpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349900AbiD1Qpq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:45:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867416E8DF
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:42:30 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SG7lTH011738;
        Thu, 28 Apr 2022 09:42:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=q2dCX8/5ZSV11a85FUaTvyQ+/zEkWWZ5G1niHWETCwg=;
 b=JBdMSOXb94Iu4vCNfxBhDgFF01znaN0Ry2Zegu2oysH6vaM/opfX2CC+8otdyDFdVonf
 ewFFhdaoF6bsvdrMXT+xPUB6NZuqd2NBr4B7F4JXV+8Oxg9F8nTSAHy8nVIfw3VD4zJQ
 YttYGMG0QHm1R2kr2DoTVJzpSWHb1jyKf8Q= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqkncv4fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 09:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdEzK8oW3niVtonuI7xUJfRxVdcJDqrahnqlnlt+Rmz/S41S2IeftqcjrQg85Kuxe38vdd2lECUlUnkXpVDudOwKA3T5U+vUjTT7A+Uit5Do99Smo7iS00FVWg3sfRPCzYAuagiv+lh3eEZdqwKFjWX8e/X2YMUt3KhD0oD71rCN0QVKpYgO3YTsaOjeRkbz+FJzPwcCKRDLj1ud7iYMedelgcCs/JiJJdtwrYUPm2nPbuwBmNZ5189F1PLXS1wyZ6DhKTF1Q6Lq7er9tvH4FpKKmwz/iBZ6CxNIdhIow9yLsw68IKoLZXOVVYcW9HKUU9ThB3B4IRKZg8CxPoI8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2dCX8/5ZSV11a85FUaTvyQ+/zEkWWZ5G1niHWETCwg=;
 b=ODTOorN3pmAyWfIfbGpDqlvZDWdN9IZBhox1jzUDky7SFfVTGQ98EllV9/towdeNRI/nmqzLAiZNw1NH4YG/4qpxPHh7pYNUaKdjvjCBt8r3nG6pL/OOTgLboFmui6bVG5Ig9X2Fp3Xd289vOQm0d5y50zHOI/7Ch1sH9jfafgblJM60jmMlEUcT7TGxa+eplNJGAWtjoglAP1U+ioC4svWWDfF3cBqL9YNhza0bM94TlrjAUzY9nftzlGNaGcYLPdi+uLs/S4k6Q24k5m5AU2JQ19WNCWFKmRaGAfN5wTnmaPw/RLZwT48sSiLeB/YfbcUIxHBAuY1v9IldfJTDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2600.namprd15.prod.outlook.com (2603:10b6:a03:150::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 16:42:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 16:42:09 +0000
Message-ID: <088195e3-c94f-4f92-f627-f901c9a40eb0@fb.com>
Date:   Thu, 28 Apr 2022 09:42:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Add bpf link iter test
Content-Language: en-US
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com
References: <20220422182254.13693-1-9erthalion6@gmail.com>
 <20220422182254.13693-3-9erthalion6@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220422182254.13693-3-9erthalion6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1956f228-8fb2-4837-81aa-08da293609d9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2600:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB26000A3F5F4E1AAF1F32590AD3FD9@BYAPR15MB2600.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaasyCq9GdoMlthF65qCqiH2BCPhq8PJyhDrnkjaym4red3a0cMH7FGIVuIXX2D2ENGECcZWXZkzx2ZacRc0f5V7VfuAlrEmTV2hZIcnINOniUHhWsFabHZr1a7wATh7Y589MRdKo37s4E/dnbu52qlR5+9x/tzgCRINF0pZ+T7vz7Hirii0OeTf1gnQPFFV4o7kBuV1a48TZHqyXRQCfYcnqd4/CaSZZlCjMOKpcOf4/XeqsfHFUGb0cAva+0iyK+LGq/2e0MOivmdR6c0t8BCz0V1HRlOnTGy/dgRsoCrh5ggbNLi06BZXrVmixRcqSXfVw5f4wTG5Y88dTDwm13vif2bH/AhP55xsO+Q8Wn5CBYiJxjiNrFxxUHlOtv/iLC/QItwflgNiBFuv/aMQGhZTnGpWAGuM03hbEaeR9XtMaFfE0D+RwoN/bspjywlRaAzeMiFSJESgu7px5G+agR1IB5MReKhAI6Ch8+fWquX2jriClljuoRpXIrSRNvqrrYdl+vJd2DCr5j+iVD18DG5TaLOVLiTXeBPc2xRJbKcsHs09ujF/SCCJRwOIPx2hEc773JOeSIE2bLmXPSzPplqdEdl+XAgtS2Ide7jJa3aaWrMaZg46silvVpng2089FRBzwmFWbvk/PuOi3EHRaG/UtVGvJmZ9oW3yiYNicLpVPQD1MKTJLKfCdik36eeO55J6W6VL+ilXu2fX/LZJ6uREwV/FPXAe6lJpJrjCOKz6nqc1vbAEKsZmm9dNRUPE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(186003)(508600001)(31686004)(66946007)(66476007)(8676002)(31696002)(36756003)(66556008)(86362001)(2906002)(8936002)(5660300002)(2616005)(83380400001)(6636002)(316002)(52116002)(6512007)(6506007)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RxV3lERHB4V2NzK0h1RWJEaUhvMDQ2NkxFcDFqanhUNXhmMnRhb3RKeDB0?=
 =?utf-8?B?cjRKV3lXSDhLNTducisrbXdyZGtSV3lIbkJ5dndUOFhGNW5KNHFzS0ttY0cv?=
 =?utf-8?B?dVNRWWFjMUZ6TWtidVZDSzNjQlltT25YdmxRUktGRlRPOXlodEFHaEZTR0dK?=
 =?utf-8?B?aG8wYjFEcHI5NGFhWFZRSW1hMDU2blZEclkxMDloZjIwM2d1VitkbW9TM0VQ?=
 =?utf-8?B?QTEwdGIrdE5JWnl1Y0M5dGNWZmp6eXdySEVCWG8wZ1pzTzJuZ0g1dmhwWWpK?=
 =?utf-8?B?WkhDNFBzcDRXUlRBM3QxVXhZWlM0ODZ0UjAweXRldkp1WEx3ZDhDMDVRUjZT?=
 =?utf-8?B?V2NNaCtpUGc2eEJBNlh2SXRINWNUbW12NnZ1NkhKN21WMzIvazJHVHVMYXZa?=
 =?utf-8?B?MWUySHE4aytKeVFUcXM3S2dxbVVYNzJ0QzBBZ2NpUFEwK3p2UDVkVWZmRkZI?=
 =?utf-8?B?Q2NJd2U5MGZSd2FNeEIzSUlaVkFwMlh1clRBaUhPQndnc1N5cklQUStGOStl?=
 =?utf-8?B?YzdISTRRUDEwQzFDUi9Ecm9ZbytJdnFBVnFGUzRna2FxVHVZL2tQMWwrYkJI?=
 =?utf-8?B?VnQvL014TDRiaFR0UXF3K0RMS3h3Q0djby9jNklGZGkxVytCTnhxWXJhdy81?=
 =?utf-8?B?eG1WajAvcU50ZlR2VTNjNDQ4c00yRUhZWWxXZytzcHBsTzlra1A3RktPOVhI?=
 =?utf-8?B?dk5vMHVndXpZUWZLOElyWlJMRG9UMTRlYXJETnFNYytGYlpHZ05tcXBYaEJU?=
 =?utf-8?B?d3NNeGhPcmQ1akJSbUtSakYrNmpMUTc5Y0Q1TmR4dnd0RGdnakJCUXR2M3Q5?=
 =?utf-8?B?OW5yUU5EaFVmOVZxTEtwLytFT1ZhWlJPL3RGZStQeTFMUk83U3VVOHRNTnlx?=
 =?utf-8?B?bmVhQW11OFdSZHVtTGREOWtMZUlvSkFvS0pmbVF5cjFiT3E0S1I0VDFRdFow?=
 =?utf-8?B?ZElhVG1QVzV5ZWFNRTdSeCtqNUdyK3pSUXZhMGJFVkhQTFl6Tk9za1g4YnRj?=
 =?utf-8?B?MGpPdW5haU9OSHAxVDdrUTQrYlU0ZkNvcGQzcVk3dXdmM3djTVM1NlN3TWdx?=
 =?utf-8?B?M0ZUam1SZDJEajVPTk5RaUdpNGFpaVkrT0xlV0o5KzIyRE91OXVEUW0wcnBh?=
 =?utf-8?B?WkZUcjJQZ3BuWmpDYmFQaE9KdlpRa3BpVmNKN21tUXhmdW8rSzNta1pubFJ4?=
 =?utf-8?B?Um9EcCtzdXcwWGdKOEQ1RGU5VkMzU3M1Wk1Lc09ZT2RiSHFsc3dkWjVFZk9X?=
 =?utf-8?B?SUp0SE5kc0ZwZFdWaU5OMHVLeXErdzh1dWJHeGNkTGR2UVRLbTU0ZkFnN1lF?=
 =?utf-8?B?M1ZaNzhkM09nRUtTaVBXZTIxb2tJenlYeVkxMEh3cFN1bTN0VDN3Y0ZLems4?=
 =?utf-8?B?TEhaYlF0V05rREtFeHJpZjZmdGY4NVpOT1pWR0lkMExtMXN2aFVJMVFrSHhQ?=
 =?utf-8?B?cnBPOGVGNlJpTmF4andWMVk1V0hpM0Z2US9sdml1VFpxaHN0eGtPUUtjYUxt?=
 =?utf-8?B?SlVtbnErS3lFSHErc2U1VE0rY2ZPM3ZacTkrRUJza0tydmFOampSNDZ2MTVE?=
 =?utf-8?B?cUhoY09rOWVtMXZQNHFyc1FBcVNaSkJKRFNNZWdoMWRldjNnRlhOWEZUcndB?=
 =?utf-8?B?a2tud0wwVjJqd2tIbGxmNVZQaG51K2s4enpLMXFxeWlpQS9jMDNpZys1elZ6?=
 =?utf-8?B?RzBlN0pjNHAvdFExRldkaEhpenpaQTBTMkUwMEdCcWpDbGovclJTR1ZSbG9Z?=
 =?utf-8?B?WHJIcDJhczlPWmJVbTF4Vkh2UzZmclZTUldHRHltL25ER2M2MCs2SHkrK0M5?=
 =?utf-8?B?Um5DV29jeTNmUk5YZWtZTUV6eU5YcGZLR0ZuT2lEV3VGMFc4RzB2NzBoODVX?=
 =?utf-8?B?YXlaN3ZiM3VJU25Dc1NIQkY3T0tmZ2VsSWF6a3RJZTRnb1d6SDd2emkwU0sx?=
 =?utf-8?B?NXpuT2w5bkI5SGxKclRySjFXeUN5ZlVhRnZBZFVhYno3RGVWSlpzbkorckV4?=
 =?utf-8?B?aDVORENmb2NBOEVyVHhwUDgrV1BIWlE5aXM4YjRPdmloOW5EcXpIeE8xdkdO?=
 =?utf-8?B?N0p0MzcxdWlEWTZzK3hBR2k2K1B1SDdGZWlJcG9Td0orMzg0WmRzZXlid1Nl?=
 =?utf-8?B?Lzh4VDNLMk9wNHB4a0hsMXBoMVB4ek1yVndHc093OFk0NzZqOTF4SGRNcUFN?=
 =?utf-8?B?cXdieGpPbmZwNkxGN1d6QmViVklHZHlzTlhFVmNPY211dExEaUdmNFlDUHVO?=
 =?utf-8?B?QW9DK0pTcWFqVWQwb2gvcHBvSjJ4NFpXM2VaV3daZEdSVmQyOTJhajF3Titx?=
 =?utf-8?B?WDdBQkxpbzg3OXRYc2JwZXpDano4Vkt1aHpjRTZnYmlnQ0lPUWdFamNjOVVp?=
 =?utf-8?Q?DVMYyxhRVmmkWhjQ=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1956f228-8fb2-4837-81aa-08da293609d9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 16:42:09.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXrIz2vsMwx1EUKNc613HNokwMQQFoGVcGTSfVVgMy8qVs6ui1+2uyFu66erKWlc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2600
X-Proofpoint-ORIG-GUID: utHwZ627iDSsKfSVCDOYtoJKdWWsgmYr
X-Proofpoint-GUID: utHwZ627iDSsKfSVCDOYtoJKdWWsgmYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/22/22 11:22 AM, Dmitrii Dolgov wrote:
> Add a simple test for bpf link iterator
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c        | 15 +++++++++++++++
>   .../selftests/bpf/progs/bpf_iter_bpf_link.c    | 18 ++++++++++++++++++
>   2 files changed, 33 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 2c403ddc8076..e14a7a6d925c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -26,6 +26,7 @@
>   #include "bpf_iter_bpf_sk_storage_map.skel.h"
>   #include "bpf_iter_test_kern5.skel.h"
>   #include "bpf_iter_test_kern6.skel.h"
> +#include "bpf_iter_bpf_link.skel.h"
>   
>   static int duration;
>   
> @@ -1172,6 +1173,20 @@ static void test_buf_neg_offset(void)
>   		bpf_iter_test_kern6__destroy(skel);
>   }
>   
> +static void test_link_iter(void)

This function is used. Please add a proper subtest for this
in function test_bpf_iter().

> +{
> +	struct bpf_iter_bpf_link *skel;
> +
> +	skel = bpf_iter_bpf_link__open_and_load();
> +	if (CHECK(skel, "bpf_iter_bpf_link__open_and_load",
> +		  "skeleton open_and_load unexpected success\n"))
> +		return;

This is not correct. You should have CHECK(!skel, ...) to return
only if skel is NULL. The error message "skeleton open_and_load 
unexpected success\n" is not correct either. Probably a copy-paste
error.

Also, since you are working on this file, probably convert all
CHECK's in this file to ASSERT_*() macros as patch #2. Then
this patch itself can be patch #3 using ASSERT_*() as well.

> +
> +	do_dummy_read(skel->progs.dump_bpf_link);
> +
> +	bpf_iter_bpf_link__destroy(skel);
> +}
> +
>   #define CMP_BUFFER_SIZE 1024
>   static char task_vma_output[CMP_BUFFER_SIZE];
>   static char proc_maps_output[CMP_BUFFER_SIZE];
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
> new file mode 100644
> index 000000000000..a5041fa1cda9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Facebook */

copyright issue.

> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("iter/bpf_link")
> +int dump_bpf_link(struct bpf_iter__bpf_link *ctx)

Please put bpf_iter__bpf_link definition in bpf_iter.h so
the test can work with an old version of vmlinux.h.

> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +	struct bpf_link *link = ctx->link;
> +	int link_id;

The 'link' pointer could be NULL as in previous patch
we have:

+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__bpf_link, link),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},

So you need to add a check below.

	if (!link)
		return 0;

> +
> +	link_id = link->id;
> +	bpf_seq_write(seq, &link_id, sizeof(link_id));
> +	return 0;
> +}
