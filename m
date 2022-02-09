Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DDB4AE5C9
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 01:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbiBIAN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 19:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbiBIANZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 19:13:25 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D7CC06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 16:13:24 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218NTOPd021740;
        Tue, 8 Feb 2022 16:13:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CQ8urS7rK1u6JFoMNWsiAa0AZVc67i9tVJxp3Eyosbc=;
 b=IvmBSkqr+F2Kt9HGCCdpt6j3JHHFtaNuCBzgC5m2NeSG5hUk42mkZ7HaeCtGwl0BtacX
 oUMd9KuoY9DBrsdI6haDCPwJM/jYErHABUWZxlhyX2zxSHAhq86pzPuQ+ubhYPbHwPyu
 +ESWuQwWrM2DfHON+hY9uvCPZTDn9ViVpV0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3tybbvuu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 16:13:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 16:13:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRcn7lwjPuJX/i//WPmWU7UruKQUyqT0olyEpp+semsmq/tF2ics0pwoxdfCQLR8rg/nFTb2iL5bDrGxB12R6ddEcZO+h34V5nPtakIdINcY+Fqex6AX+yCoC/JDC2Eag79X2IxDLbRC09HiA2tw52mmH8DWZRkCLju4MNv6ykDduPaEcaarPHJPyTlvKerakf1wB/SIoY24WTBuIk2aXTyB9XlKUoj+iv9ScS7Vq5jIJfcTTg58LhOB/7X74WJsMHdKDhjBRYaF/cUxBR/RgnujHokx8zvi784NI71nZXKNt6dIK+AKLTNsg9FA0QtH4ZTxpaTq6+xU4T/5VWrYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ8urS7rK1u6JFoMNWsiAa0AZVc67i9tVJxp3Eyosbc=;
 b=Hs/ivMyvw9w/b9glpVyPFc/nH5PcZAc1mjdXpJZRHgnYyeT74DHtApmcnjvLScGInIRokVxnxNIShViuK2FgLZzILE7smzPLHMIeT+XPwN1c//vF1gPlgURZFJvexQ4xCguP8cOIu8GnKvdqKME/mV6UuWBnEM3OK8RfrBt0AQz4TKcZG22HGBcC8hgYwIxJqoZvwwFlAQoMhuSEZF+JwLjO7IOHqF0RGhB5D3ecTTZoeAkn9O4l/h8X3vwSE/kpiiafPzbdv+Sqc7bJeg7M6d2jyfczZTTc8rBHvDfPLSOUFOH91OZ8CtPsUUpFNrVM5jzZufkKf2lvCqt36WRfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4657.namprd15.prod.outlook.com (2603:10b6:806:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 00:13:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 00:13:06 +0000
Message-ID: <e90685a5-dad0-4a4b-aa8b-275eaef79e60@fb.com>
Date:   Tue, 8 Feb 2022 16:13:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 bpf-next 2/5] libbpf: Prepare light skeleton for the
 kernel.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-3-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220208191306.6136-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:300:ee::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c785a50-5923-4116-9958-08d9eb60f1d8
X-MS-TrafficTypeDiagnostic: SA1PR15MB4657:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4657F0A9C393824F1DC87681D32E9@SA1PR15MB4657.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gO11e1Lg8HOq6YvcYRSJwJel1/SHEX0ZgjB1M7l0nt/ksT7hdK5s9DNoJ8vBUyLna0U2O3rCdaKHhMAXp+BNfeOgFvYRxvK21r+/iTASN4L0kumDhPP/RNcbWwndFtgZHzcSh1TBfvNlghIljjV9NEKmJPxzAsdWlA1jBimHiJ5SQsBNdNmr2dl4XJy6kUdt1UTDQbIGqq7vE+RoFkKEPqZOsz1CcrI6+tji/a5xvhBnIsAgcIVUAhhE016QoDBJ6r+7TosTN3KAAm18Aj92F3rlptjfaFb6XKWzKHqMbzju1jhcs3efK6tC5sXtAJSmFbr2s+9Q+HsaAG840jcA/b3D8GBfemsbWth7czNVEGfe2ZDL7VKS9O/Vu1Ruaxj5zWpx58t6KjSQXU1zeuQyjMTKhlS3R2laYfOmNiVH98Rfyg8b/5ix6L14dw4EIQJsyU/xy0UzLPXMxT0c4wAw3Z0/uYwN4TgTBMzdXjMZWApfamJGjy8rvCY+gYw7vmx/gkbVn3SnpZPGXxZmwmaUNvZLMw6saXCs8/p1FnYoAwvUxCC7EmJhcys46kK+ITidwMpgnt4e8V0fYKc446XYWO/1FcSljdI9kuUA/6PkBoxSOIQ2H245ByOuJakS4U4tb45f9kpLUh2+nQKDsi+PuCJMnibo7piVnc92Me8+uOr58PM3jdjDv+rIZKhQ3d2cfUE/Nisl+4O02Q1z55LXKVkNiOfqq17rgaebnNBCnYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(5660300002)(38100700002)(6506007)(6512007)(66946007)(53546011)(31696002)(36756003)(6666004)(316002)(86362001)(186003)(2906002)(66476007)(66556008)(2616005)(8936002)(4326008)(83380400001)(6486002)(508600001)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXFaNlY4cU8vblV5QnNUVVhvUjdRY1ZCd0NuQW5LWVZHMUx5NmNuaU5Vbjl3?=
 =?utf-8?B?Wk95NXRpcWxIVElDWEo0NU5vNVZCOFpsbnBCd3VCOUpueEExWEtrTFJieGVU?=
 =?utf-8?B?b0V1VjV5L0hiZEtna29OMEZyaGxBTS85aE5jb28xYzB3OGhjOW5ZbzJaakhk?=
 =?utf-8?B?d25uL29ubW8vc1dJZCs3Y3RsWlZXKy95eEEwZVkrQ2U2MndPNVZUM3VDbjMw?=
 =?utf-8?B?akdQTVcyZWR3MnJVc3RTUFhUYVhNOG1TZElObUR3bGh2ZUpOVGxuYURlUWkw?=
 =?utf-8?B?V3F2bk9USDRBMDJrQVgyVHYxOVRLakRtNjNYZlNwN1JEUWVjUVZid3lNTHNU?=
 =?utf-8?B?SGplTndjTHBUbmo3VUUyVTBiTWlvcmhWekNNd2liVU1VVGlRaUFxYldvUVYr?=
 =?utf-8?B?VzltSC9PZjJWYlNLdC9hemVXdGpHaFE0dFUza3NFNmNYTWlxTm5yUXNLRktu?=
 =?utf-8?B?alhvTFhvNmRheGdJcU5oS2NuUUhLblpnajFWT1dkUmxlb2pCQlZDc3BDcnNZ?=
 =?utf-8?B?dVFPTDZVdHNuaXZkUzFjK0lHOHg0SnZnL1hQcjluS0tYSk40UFRqR081ZHZC?=
 =?utf-8?B?MElKUWxXN1Q0SDRSMHd0OVZ1L2MyY3Z3RkU1VS93M0F4MDFKRkNCRU5jL2x1?=
 =?utf-8?B?Y1dEMzEySEFEZmZsL0I4VTh5STE4L05MbUR2SVg5ejVrYVNrY0YreVE5TUlN?=
 =?utf-8?B?MCtRMUFBM0t6US9yQU5IZmc1dVkxa0tjUVByMHp4b3dmN0J4dk9ONGZxN2xP?=
 =?utf-8?B?SFoxMjJOa2YzTytNTkpsakdmc0E4YktGRjIrVU1TWm9zRG8zZkdXWjM4UW83?=
 =?utf-8?B?RmFNWGlSdzVqcThuUTB6N2d6V3h3TjViQzFkRk1mWmRaYkNWNUY0c1AvVG55?=
 =?utf-8?B?eUZLMVU0MkMzeFlGUE0wU0dPUUdNYUJwbW5kSHM4WUlJcm90T21qL25iUW1O?=
 =?utf-8?B?OUJTWVdiVUVHUVRzREQ0K1lvWWI3dndHNHhxcTBMaFI2OTlzNURtMmwrOTdt?=
 =?utf-8?B?V3Y3TWhLcDJkOUpobEdZdUVrVkZsOC9Pd1BSRUdIYys2Z1cyR2FmYjl2R2NY?=
 =?utf-8?B?YURuMnNmakVsZHQyK3MwMm9FM1Jub1V5WnlHVzJzTkxQMTBydFVSUStpUzVq?=
 =?utf-8?B?dnd0a292bU43RHQwMXFOcWdQbGF2ZVRLODM4bzVyMGJySzRubDY2czRXNkRO?=
 =?utf-8?B?cnBJZCsvQXJoRy9sRllhQjM0clpZaHJMOTdvbFg5YUhjeCttY3Bsam5hY3pz?=
 =?utf-8?B?ZHBEWkxNc3pUUHlrTURobER6cUxlZmdUSFFjMGxsaU91S3JCaU1NUVFSRVFJ?=
 =?utf-8?B?Y2RWRmtYS0Z0Y1BtMXBlSWNtc3k2S29xaGxjMCtKKytWcEwvY3pUWVM5VU5O?=
 =?utf-8?B?NDRINFhrc1BFdFJQZ1hIWDI5c2NHSjRPOW92RkdMQlV3SlZiY0JTbXp2bkY5?=
 =?utf-8?B?YzB0aHB3UFBpL1pKNFhWQVV2Vm5GOENSYVByalkvMXZFNVRSVUkxcnJFMFJE?=
 =?utf-8?B?R2hWQ1lOSjJPOTdQVno2RVE2dFRTaEdRQkNBbjJBUlpDRlNoL0xkcmxhVkZT?=
 =?utf-8?B?YUZaemdlWnUwZ3JPTjlmSUhkMzdMQnEvMkJNaDdDeHVDM2tNVWZKVnBjTXBr?=
 =?utf-8?B?RGhzM0ZMUjdzVUZESUxkNklMalZPbG9qTjYzWVZEUGdBN2NiS1ZzaTdGdzRo?=
 =?utf-8?B?NSs3TFNZN0gwWVRnN1l2Mmk0NytPYlRuYjVrbXJQeWdpRTRkZEpidjZUN2pk?=
 =?utf-8?B?aHpTTmYzc3JYM1QwUzFmeTlmU2J2V2V0YysvVjBrMVRUQkl3cmVYc1AvMUp2?=
 =?utf-8?B?OE5Pek0wWTVXS0p3dW5OZFpzNmVIRXMwUjlxVVlnY1l4NVdIR2lwa3dkbzNE?=
 =?utf-8?B?UFErZXQ4VEFybGdnakpHWlJ3MnF5SkZDQnhGZTI5ZFFYM2JpMnN4Q2J6dmlO?=
 =?utf-8?B?SjdFTXFvWFJXZ1NyRjMrKzRTRFgzMHFXN25sTVZLcU5oQ0VIZHZUUDRxT2Jt?=
 =?utf-8?B?UHdyUjlrRHhUMklseWZaSGpzMktHcTJHbytBNVdDRnplSnl0TWk5MWRtNGNX?=
 =?utf-8?B?aU5zSEJDN0wweWh2bnNGN1Z2b1NaWi8vQUJ3THBFS3o4NGgxY0JVaDlZM1Fs?=
 =?utf-8?Q?XOsj1jDoCkpH/Jf2mSE2ndQRh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c785a50-5923-4116-9958-08d9eb60f1d8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 00:13:05.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUNzG0XghLZV8M8Y7qVvB55qhcWu9ywcLToVY3GCEvmKJKOVujzaIXYyd+c0bbtk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4657
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: os2SSOQIeA1Y2UHMvkCys5_PfJSRP3BF
X-Proofpoint-GUID: os2SSOQIeA1Y2UHMvkCys5_PfJSRP3BF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_07,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080137
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 11:13 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Prepare light skeleton to be used in the kernel module and in the user space.
> The look and feel of lskel.h is mostly the same with the difference that for
> user space the skel->rodata is the same pointer before and after skel_load
> operation, while in the kernel the skel->rodata after skel_open and the
> skel->rodata after skel_load are different pointers.
> Typical usage of skeleton remains the same for kernel and user space:
> skel = my_bpf__open();
> skel->rodata->my_global_var = init_val;
> err = my_bpf__load(skel);
> err = my_bpf__attach(skel);
> // access skel->rodata->my_global_var;
> // access skel->bss->another_var;
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   tools/lib/bpf/skel_internal.h | 193 +++++++++++++++++++++++++++++++---
>   1 file changed, 176 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index dcd3336512d4..d16544666341 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -3,9 +3,19 @@
>   #ifndef __SKEL_INTERNAL_H
>   #define __SKEL_INTERNAL_H
>   
> +#ifdef __KERNEL__
> +#include <linux/fdtable.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/slab.h>
> +#include <linux/bpf.h>
> +#else
>   #include <unistd.h>
>   #include <sys/syscall.h>
>   #include <sys/mman.h>
> +#include <stdlib.h>
> +#include "bpf.h"
> +#endif
>   
>   #ifndef __NR_bpf
>   # if defined(__mips__) && defined(_ABIO32)
> @@ -25,17 +35,11 @@
>    * requested during loader program generation.
>    */
>   struct bpf_map_desc {
> -	union {
> -		/* input for the loader prog */
> -		struct {
> -			__aligned_u64 initial_value;
> -			__u32 max_entries;
> -		};
> -		/* output of the loader prog */
> -		struct {
> -			int map_fd;
> -		};
> -	};
> +	/* output of the loader prog */
> +	int map_fd;
> +	/* input for the loader prog */
> +	__u32 max_entries;
> +	__aligned_u64 initial_value;
>   };
>   struct bpf_prog_desc {
>   	int prog_fd;
> @@ -57,12 +61,159 @@ struct bpf_load_and_run_opts {
>   	const char *errstr;
>   };
>   
> +long bpf_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
> +
>   static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>   			  unsigned int size)
>   {
> +#ifdef __KERNEL__
> +	return bpf_sys_bpf(cmd, attr, size);
> +#else
>   	return syscall(__NR_bpf, cmd, attr, size);
> +#endif
> +}
> +
> +#ifdef __KERNEL__
> +static inline int close(int fd)
> +{
> +	return close_fd(fd);
> +}
> +
> +static inline void *skel_alloc(size_t size)
> +{
> +	return kcalloc(1, size, GFP_KERNEL);
> +}
> +
> +static inline void skel_free(const void *p)
> +{
> +	kfree(p);
> +}
> +
> +/* skel->bss/rodata maps are populated in three steps.
> + *
> + * For kernel use:
> + * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
> + * skel_prep_init_value() allocates a region in user space process and copies
> + * potentially modified initial map value into it.
> + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
> + * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map and
> + * does maps.rodata.initial_value = ~0ULL to signal skel_free_map_data() that kvfree
> + * is not nessary.
> + *
> + * For user space:
> + * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
> + * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
> + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
> + * skel_finalize_map_data() remaps bpf array map value from the kernel memory into
> + * skel->rodata address.
> + *
> + * The "bpftool gen skeleton -L" command generates lskel.h that is suitable for
> + * both kernel and user space. The generated loader program does
> + * copy_from_user() from intial_value. Therefore the vm_mmap+copy_to_user step
> + * is need when lskel is used from the kernel module.
> + */
> +static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> +{
> +	if (addr && addr != ~0ULL)
> +		vm_munmap(addr, sz);
> +	if (addr != ~0ULL)
> +		kvfree(p);
> +	/* When addr == ~0ULL the 'p' points to
> +	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
> +	 */
> +}
> +
> +static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
> +{
> +	void *addr;
> +
> +	addr = kvmalloc(val_sz, GFP_KERNEL);
> +	if (!addr)
> +		return NULL;
> +	memcpy(addr, val, val_sz);
> +	return addr;
> +}
> +
> +static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
> +{
> +	__u64 ret = 0;
> +	void *uaddr;
> +
> +	uaddr = (void *) vm_mmap(NULL, 0, mmap_sz, PROT_READ | PROT_WRITE,
> +				 MAP_SHARED | MAP_ANONYMOUS, 0);
> +	if (IS_ERR(uaddr))
> +		goto out;
> +	if (copy_to_user(uaddr, *addr, val_sz)) {
> +		vm_munmap((long) uaddr, mmap_sz);
> +		goto out;
> +	}
> +	ret = (__u64) (long) uaddr;
> +out:
> +	kvfree(*addr);
> +	*addr = NULL;
> +	return ret;
>   }
>   
> +static inline void *skel_finalize_map_data(__u64 *addr, size_t mmap_sz, int flags, int fd)
> +{
> +	struct bpf_map *map;
> +	void *ptr = NULL;
> +
> +	vm_munmap(*addr, mmap_sz);
> +	*addr = ~0ULL;
> +
> +	map = bpf_map_get(fd);
> +	if (IS_ERR(map))
> +		return NULL;
> +	if (map->map_type != BPF_MAP_TYPE_ARRAY)
> +		goto out;

Should we do more map validation here, e.g., max_entries = 1
and also checking value_size?

> +	ptr = ((struct bpf_array *)map)->value;
> +	/* the ptr stays valid, since FD is not closed */
> +out:
> +	bpf_map_put(map);
> +	return ptr;
> +}
> +
[...]
