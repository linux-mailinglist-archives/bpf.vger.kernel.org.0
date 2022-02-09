Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B464AE683
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiBICjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiBIAyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 19:54:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA667C061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 16:53:59 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 218L7V77028661;
        Tue, 8 Feb 2022 16:53:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GcCwObQI+gCmJJsKQQn4ujeaFGequuBaJNUMrBsWLgQ=;
 b=PfFfVzThgkDAyfBYyVvZfCHhznNQEbgiSTQ/WMXrTYesYrtGHl64q3IGN+ykfDvoAJ9l
 0yL7wrjNaBzgbC7h0CfcnwYzOSnxna1SLz+nif9IcjkSyjyFQSe7XCVtdx6wvMecTbP1
 RcWUx6rbIWMeMzHqWqkimTpCAPiRHX27gZo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e405cs8q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 16:53:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 16:53:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvfB7U6GPVj0Z94WFjisGEo6fqX4LGoHu3ERzOT7y+ywtW+/FjfhQUOT2YM9O+LRlTIUkzc4GrIYmJiXJc90H1CmSHQnWcE1fpLv7fmwgvuj4ETDgI1/35HCKNpnI5ZSEEHY6CgiSTKMvvuWAS9cxDOvf99O32bC59jwhAhUd75rSXLfqGL3ifcyFcwHq+Hox6jTb9HhDN7RPbzzI84soMmLW9mzriwZ5JB8pxvye3G4Z5F2Kx2rZmWvP2QJsSCsnnrGAAoMTYhqo+lvPUB/lQ6zyoge0XrJmnHJyN0Aeqqzicm5ooHgr3UiRCVicLZGXWuHLx7E2V9wypsuuAHQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcCwObQI+gCmJJsKQQn4ujeaFGequuBaJNUMrBsWLgQ=;
 b=SoltWglUkFT+9rnsJNGUbhjx7zC1S5U66ZVrI8ZzaGOGyavJ6mKE/sFDz1NRXyVJ8oCXej/zXdQh5mKa8/YyBq/dGum1vg0c+Kc7T87wxNTqiKiXUogVn4q+rLZQGvdg2kUOMMOCnc9QZiLnhUFAdUGhNYp4fnXPXVc3RYdFoN44JKoZpBU644dt6ZwEaUIKWqG41AhmWlQRdoLoABlk72fWH41uOTv4FtL95t0VSBnho2g33364ctI9AWc5g3Yszy0EAJjdRc7l0d5OH0Fp6a/YwJpSEz5REdO47b6dyAuGg0+g1lQU8cw8IeigNGqa/5YJMSiQy/AuGgiua0JuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4740.namprd15.prod.outlook.com (2603:10b6:806:19f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 00:53:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 00:53:41 +0000
Message-ID: <9ec1f118-4e71-f78b-20d4-a4c49904e2a8@fb.com>
Date:   Tue, 8 Feb 2022 16:53:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 bpf-next 5/5] bpf: Convert bpf_preload.ko to use light
 skeleton.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-6-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220208191306.6136-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53861526-d2f9-48dd-9044-08d9eb669de5
X-MS-TrafficTypeDiagnostic: SA1PR15MB4740:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB474038A8D5C3EB76CD05D797D32E9@SA1PR15MB4740.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSwwxLjQ1d6BVYnPH+KK0cPK4U/rHE5cxbB3NsfcIoXimqHtUDGZHOrIaAZnXqE5UAmwIYNj1ffsGO4NJ7vgpNny7IgW+YiVcYbOuJ8u0W6ddnDd36t+xYZx4RYDy5Vjhw257Ru3s3omgosw6a5hH2U0ByLo1DSnk4kM2oCPKs1K91RIxtp9GD+QgGKqKq+qvGjqipt2yXAhgWBQGQvG41QbwKEcHqO/M+24sXiu6Q9TJzZIUB1MhrXm93cbbCT1D3sPfu3lCGHVTSTzeU7YwF5tplxFfKt4qs4aD2gKSMa92CkYTHOBAmJyT2AlMdlgsjhfcrz0SG3AfBHVwNhZoO6Bjut2/cPnmwYiXtvdkv+SxyAol+8FYxxq9N+USXq1q2pydgedEJfnkdWSdOXI4E3AMD8MKiMBVd5wkEfKftXImBiAz2S4oDGFkiPDXYE87gug5d/SQ3oMiJnCOK/PFVdnneCpVCaWHTAn0aWTI3Ck/LQo3rvEpTDY/IZsWcnN8RPBfd54I7zqAuUUtez3NcUamF1hQER5eGlBExoEyuM3KIz9HS8VcRxLSyjK/BIFcqVrKI4fa+t2UpgyJXaibvdVCvPEyVGJIbbopmE8ZnRLvYSnDOYz6l41y+OZH046p8yKnzWg7hy2wy6TYM5bf2BQlBqdIJfoJbmMoKdK4cAis2MKA+iBfIGBKyTDQe0+PX3gjSDiyvPucxf9NNG6P2xaPCfvSAabNE4y4R7RLEFwBrm8MV8hziCXaa4qMxuL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(36756003)(316002)(2906002)(66946007)(2616005)(38100700002)(186003)(6666004)(6512007)(6506007)(6486002)(86362001)(31696002)(83380400001)(53546011)(52116002)(4326008)(8676002)(66476007)(31686004)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmhOMk44TTFrNlNzeG0rNXZDWmRRVkxLR1B2WUJDNlM4SVl6b3lIeVJ5eWU4?=
 =?utf-8?B?ZFQ5R3U3aEpHamZIMFN4MkdGYWl5MGRqclplZzR6c09pamozdE1TUmx3bVZZ?=
 =?utf-8?B?N1JubFYrdjFYN012dm5PQ0ZydXZQK28raVNxZE5FVys4ZVJVaGNCOTZFL3Rh?=
 =?utf-8?B?SEhNWWVVQ1JKdFo1Q252RkFJNWY2TWRtK2FuRDJIT2xFUHFLVVk1Ri9NM09O?=
 =?utf-8?B?OXE5cDcwMDI0UFRJcUdKM2Y2bzlQQlBXVWZQWHZPRHpGTVRydkh2N2h4YUZw?=
 =?utf-8?B?MTdFL2NZdG1JeUxhN0JheXJFTzFtTy9Qa2h6YnJPZ2Z0Z0ZTalVNdktMOXlM?=
 =?utf-8?B?QkR0anhUWk1YaFZ1aS9QSGFoRmVzdFBLYVMwV0RBV2V3cUsrYnNacVZ1VXdj?=
 =?utf-8?B?RlI0MlRnMVVxeXFUS1JkRTk3MFZBODRQSlIyQmFJT1laVlFiNVdxMGxZbDY5?=
 =?utf-8?B?eXU4VG1yeFlvaUJnY0hDZGg1MmxZN2FwWituUG9hdmdCUzBPUkc2MjZvL1Jm?=
 =?utf-8?B?Uml3ck1IQWFUUmVEaW5SS2hKMGRLRS9QbktQR3QySjNiNHI4cTZRYzRCUlBv?=
 =?utf-8?B?WWJyenBMTURuNzI1dlNIc2NwdlFFQkZGd1VDYnlWTFZoSUhNT0JyVGVzcS9X?=
 =?utf-8?B?dVAyOVRCQlhuc3BubHUyT2VmTnFFRnNZQTVDaEt2MTY2ZVpkYk5xMk54YVZV?=
 =?utf-8?B?TXdraEFna3piT0Z2Z2U1eXFSUjd5dkR6QnBhUVlqa1pRdFpUYUppNnI5NUxt?=
 =?utf-8?B?eDJlVG1TWENFdHV2RG41MTBzMlJPQzd5U1ZpQnZiRzFOQzF1VFFRVXhLY3k0?=
 =?utf-8?B?dGhFbmZYRU9ybUVMRkZZVUEweXJHREg0TlVUMi9kOTRwSy8xMERaVmMvT09D?=
 =?utf-8?B?UnR1Y3hlTENaeXpueTFuU20yN2pQK2pBOWR5MlljY2RPU2ZJRlM2ekFrYWFs?=
 =?utf-8?B?QjA4WHRQcGRTNGtBamJVbjhpcnNhVEd6U0E2dnJIejVpODUweSs1cTJXTTVu?=
 =?utf-8?B?bW0vZGdScC9iYVpCOWsvVlBZdWRPYkErcDI4NWpUWkhLRE5zTHBGTnRNVk13?=
 =?utf-8?B?Sm5GenJtY0l0NVNPVFJwaStpUVk4UkVZUGtSZDBES2FKS0pKeWVBWW5Eek9h?=
 =?utf-8?B?SzhEUGNsRmlDak1pZTlhNmxsdFFrSEkzWUtXaU9uT0lqUW1CQW81M3E3bkdj?=
 =?utf-8?B?SS9rQ1VubC9OTU9kc0RiQkpZZDZqZ09VNTQrcFNkT05BV2E3dUJNTndSenZz?=
 =?utf-8?B?TmN1dGJBbFg3VnE1eTZLZVpNMjdrcHNNK3IrZnJkMlJFaThHVHJ0bVZlbFZj?=
 =?utf-8?B?ZTdJQitOaVhwa01UV29xVEtwQ1NRTkZ2T1BEWFJMd09pSEQxWFhkcmZaejNs?=
 =?utf-8?B?U0tRSWJtQ2JVN0RORkVId0U5bk5LTTRsQ0FpMmNmODhwRFQwZEo3dWZlT3pS?=
 =?utf-8?B?dno0RjJyYXNnR1JxejE3R1JIcW1Db3crWmFwVjVveitrOWpyUlpUTFVydWtJ?=
 =?utf-8?B?WU8zTFJYNzdSTlBwUTFRT0NTdWFiTFBmekcrVHd2YjBDQ1luaC9RNGEyYWpp?=
 =?utf-8?B?OWRqbW9NL3p4REZQRDQ2c2o5UkFzcWtNeUk0V09VK3VScTNKRFltM2M1NjJt?=
 =?utf-8?B?QzRQU0JIclM5VTd5VVNNRndyQk5SSW5YZStkRGNPNVFyOXZMeVFlWmVBNzZ3?=
 =?utf-8?B?dzN0dkdpRUJVNHJOTDVRWUV1a2FDNlVVUHppQXhENzdXc2ZsRk9LNUcvcGkx?=
 =?utf-8?B?YkM3aGozc1RiZ2FDL0VNY0l6UlQ2VzZXWnpnRUtibjd6dlBMYlZteWxEek15?=
 =?utf-8?B?RGpqb3pqbGl1aWlsdVJUM3R0VkxMbTM3YlVpQzN6ak1nS2xnU2pQS3FUMDJV?=
 =?utf-8?B?eDlVWHo2K0NDQlRiek82Qm1KRG1DeThxaDEybVVFT2RCVkxGenZrRHRJRlVR?=
 =?utf-8?B?UWc5MENJU1Q1dlVNVFBwNmRhakN6QUUzeWVWUlRMdEVNK2EvNHZyR2xBTk9r?=
 =?utf-8?B?Y1RHUEJiK3UyazYvUks0ZFduS2Fhb1JWbUFkK3pWdXAvbEtZUXhhdzZVdGF6?=
 =?utf-8?B?KzFmVEpBYXRYTU9rRm9zK3pxUG1hSkJmZVhxZzlLRE8xVUFHamJBTGdHdGFE?=
 =?utf-8?B?TUY1MTJXNCtjbzJMYzVyY21TU2piK24weXZSTGF4Vm51VVpsM2pUbnNrSi9E?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53861526-d2f9-48dd-9044-08d9eb669de5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 00:53:41.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mljMM5AaHrtdYX8uU8Yh/kz40HSkJT5WJCFjIrVO4YXYRiodsi2qIyatJ9IOMXd7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4740
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Gbw-bAhuZXzdK7krBidOVwhMoaq2x3j6
X-Proofpoint-ORIG-GUID: Gbw-bAhuZXzdK7krBidOVwhMoaq2x3j6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090004
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
> The main change is a move of the single line
>    #include "iterators.lskel.h"
> from iterators/iterators.c to bpf_preload_kern.c.
> Which means that generated light skeleton can be used from user space or
> user mode driver like iterators.c or from the kernel module.
> The direct use of light skeleton from the kernel module simplifies the code,
> since UMD is no longer necessary. The libbpf.a required user space and UMD. The
> CO-RE in the kernel and generated "loader bpf program" used by the light
> skeleton are capable to perform complex loading operations traditionally
> provided by libbpf. In addition UMD approach was launching UMD process
> every time bpffs has to be mounted. With light skeleton in the kernel
> the bpf_preload kernel module loads bpf iterators once and pins them
> multiple times into different bpffs mounts.
> 
> Note the light skeleton cannot be used during early boot or out of kthread
> since light skeleton needs a valid mm. This limitation could be lifted in the
> future.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Indeed, this is much more simpler which uses the same set of lskel
API functions. One minor nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/inode.c                            |  39 ++----
>   kernel/bpf/preload/Kconfig                    |   9 +-
>   kernel/bpf/preload/Makefile                   |  14 +--
>   kernel/bpf/preload/bpf_preload.h              |   8 +-
>   kernel/bpf/preload/bpf_preload_kern.c         | 119 ++++++++----------
>   kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 --
>   .../preload/iterators/bpf_preload_common.h    |  13 --
>   kernel/bpf/preload/iterators/iterators.c      | 108 ----------------
>   kernel/bpf/syscall.c                          |   2 +
>   9 files changed, 72 insertions(+), 247 deletions(-)
>   delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
>   delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
>   delete mode 100644 kernel/bpf/preload/iterators/iterators.c
> 
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 5a8d9f7467bf..4f841e16779e 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -710,11 +710,10 @@ static DEFINE_MUTEX(bpf_preload_lock);
>   static int populate_bpffs(struct dentry *parent)
>   {
>   	struct bpf_preload_info objs[BPF_PRELOAD_LINKS] = {};
> -	struct bpf_link *links[BPF_PRELOAD_LINKS] = {};
>   	int err = 0, i;
>   
>   	/* grab the mutex to make sure the kernel interactions with bpf_preload
> -	 * UMD are serialized
> +	 * are serialized
>   	 */
>   	mutex_lock(&bpf_preload_lock);
>   
> @@ -722,40 +721,22 @@ static int populate_bpffs(struct dentry *parent)
>   	if (!bpf_preload_mod_get())
>   		goto out;
>   
> -	if (!bpf_preload_ops->info.tgid) {
> -		/* preload() will start UMD that will load BPF iterator programs */
> -		err = bpf_preload_ops->preload(objs);
> -		if (err)
> +	err = bpf_preload_ops->preload(objs);
> +	if (err)
> +		goto out_put;
> +	for (i = 0; i < BPF_PRELOAD_LINKS; i++) {
> +		bpf_link_inc(objs[i].link);
> +		err = bpf_iter_link_pin_kernel(parent,
> +					       objs[i].link_name, objs[i].link);
> +		if (err) {
> +			bpf_link_put(objs[i].link);
>   			goto out_put;
> -		for (i = 0; i < BPF_PRELOAD_LINKS; i++) {
> -			links[i] = bpf_link_by_id(objs[i].link_id);
> -			if (IS_ERR(links[i])) {
> -				err = PTR_ERR(links[i]);
> -				goto out_put;
> -			}
>   		}
> -		for (i = 0; i < BPF_PRELOAD_LINKS; i++) {
> -			err = bpf_iter_link_pin_kernel(parent,
> -						       objs[i].link_name, links[i]);
> -			if (err)
> -				goto out_put;
> -			/* do not unlink successfully pinned links even
> -			 * if later link fails to pin
> -			 */
> -			links[i] = NULL;
> -		}
> -		/* finish() will tell UMD process to exit */
> -		err = bpf_preload_ops->finish();
> -		if (err)
> -			goto out_put;
>   	}
>   out_put:
>   	bpf_preload_mod_put();
>   out:
>   	mutex_unlock(&bpf_preload_lock);
> -	for (i = 0; i < BPF_PRELOAD_LINKS && err; i++)
> -		if (!IS_ERR_OR_NULL(links[i]))
> -			bpf_link_put(links[i]);
>   	return err;
>   }
>   
> diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
> index 26bced262473..9de6cfa5dbb1 100644
> --- a/kernel/bpf/preload/Kconfig
> +++ b/kernel/bpf/preload/Kconfig
> @@ -18,10 +18,11 @@ menuconfig BPF_PRELOAD
>   
>   if BPF_PRELOAD
>   config BPF_PRELOAD_UMD
> -	tristate "bpf_preload kernel module with user mode driver"
> -	depends on CC_CAN_LINK
> -	depends on m || CC_CAN_LINK_STATIC
> +	tristate "bpf_preload kernel module"
> +	# light skeleton cannot run out of kthread without mm
> +	depends on m
>   	default m
>   	help
> -	  This builds bpf_preload kernel module with embedded user mode driver.
> +	  This builds bpf_preload kernel module with embedded BPF programs for
> +	  introspection in bpffs.
>   endif
> diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
> index baf47d9c7557..167534e3b0b4 100644
> --- a/kernel/bpf/preload/Makefile
> +++ b/kernel/bpf/preload/Makefile
> @@ -3,16 +3,6 @@
>   LIBBPF_SRCS = $(srctree)/tools/lib/bpf/
>   LIBBPF_INCLUDE = $(LIBBPF_SRCS)/..
>   
> -userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
> -	-I $(LIBBPF_INCLUDE) -Wno-unused-result
> -
> -userprogs := bpf_preload_umd
> -
> -bpf_preload_umd-objs := iterators/iterators.o
> -
> -$(obj)/bpf_preload_umd:
> -
> -$(obj)/bpf_preload_umd_blob.o: $(obj)/bpf_preload_umd
> -
>   obj-$(CONFIG_BPF_PRELOAD_UMD) += bpf_preload.o
> -bpf_preload-objs += bpf_preload_kern.o bpf_preload_umd_blob.o
> +CFLAGS_bpf_preload_kern.o += -I $(LIBBPF_INCLUDE)
> +bpf_preload-objs += bpf_preload_kern.o
> diff --git a/kernel/bpf/preload/bpf_preload.h b/kernel/bpf/preload/bpf_preload.h
> index 2f9932276f2e..f065c91213a0 100644
> --- a/kernel/bpf/preload/bpf_preload.h
> +++ b/kernel/bpf/preload/bpf_preload.h
> @@ -2,13 +2,13 @@
>   #ifndef _BPF_PRELOAD_H
>   #define _BPF_PRELOAD_H
>   
> -#include <linux/usermode_driver.h>
> -#include "iterators/bpf_preload_common.h"
> +struct bpf_preload_info {
> +	char link_name[16];
> +	struct bpf_link *link;
> +};
>   
>   struct bpf_preload_ops {
> -        struct umd_info info;
>   	int (*preload)(struct bpf_preload_info *);
> -	int (*finish)(void);
>   	struct module *owner;
>   };
>   extern struct bpf_preload_ops *bpf_preload_ops;
> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
> index 53736e52c1df..30207c048d36 100644
> --- a/kernel/bpf/preload/bpf_preload_kern.c
> +++ b/kernel/bpf/preload/bpf_preload_kern.c
> @@ -2,101 +2,80 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   #include <linux/init.h>
>   #include <linux/module.h>
> -#include <linux/pid.h>
> -#include <linux/fs.h>
> -#include <linux/sched/signal.h>
>   #include "bpf_preload.h"
> +#include "iterators/iterators.lskel.h"
>   
> -extern char bpf_preload_umd_start;
> -extern char bpf_preload_umd_end;
> +static struct bpf_link *maps_link, *progs_link;
> +static struct iterators_bpf *skel;
>   
> -static int preload(struct bpf_preload_info *obj);
> -static int finish(void);
> +static void free_links_and_skel(void)
> +{
> +	if (!IS_ERR_OR_NULL(maps_link))
> +		bpf_link_put(maps_link);
> +	if (!IS_ERR_OR_NULL(progs_link))
> +		bpf_link_put(progs_link);
> +	iterators_bpf__destroy(skel);
> +}
> +
> +static int preload(struct bpf_preload_info *obj)
> +{
> +	strlcpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
> +	obj[0].link = maps_link;
> +	strlcpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
> +	obj[1].link = progs_link;
> +	return 0;
> +}
>   
> -static struct bpf_preload_ops umd_ops = {
> -	.info.driver_name = "bpf_preload",
> +static struct bpf_preload_ops ops = {
>   	.preload = preload,
> -	.finish = finish,
>   	.owner = THIS_MODULE,
>   };
>   
> -static int preload(struct bpf_preload_info *obj)
> +static int load_skel(void)
>   {
> -	int magic = BPF_PRELOAD_START;
> -	loff_t pos = 0;
> -	int i, err;
> -	ssize_t n;
> +	int err;
>   
> -	err = fork_usermode_driver(&umd_ops.info);
> +	skel = iterators_bpf__open();
> +	if (!skel)
> +		return -ENOMEM;
> +	err = iterators_bpf__load(skel);
>   	if (err)

We can do iterators_bpf__open_and_load here, right?

> -		return err;
> -
> -	/* send the start magic to let UMD proceed with loading BPF progs */
> -	n = kernel_write(umd_ops.info.pipe_to_umh,
> -			 &magic, sizeof(magic), &pos);
> -	if (n != sizeof(magic))
> -		return -EPIPE;
> -
> -	/* receive bpf_link IDs and names from UMD */
> -	pos = 0;
> -	for (i = 0; i < BPF_PRELOAD_LINKS; i++) {
> -		n = kernel_read(umd_ops.info.pipe_from_umh,
> -				&obj[i], sizeof(*obj), &pos);
> -		if (n != sizeof(*obj))
> -			return -EPIPE;
> +		goto out;
> +	err = iterators_bpf__attach(skel);
> +	if (err)
> +		goto out;
> +	maps_link = bpf_link_get_from_fd(skel->links.dump_bpf_map_fd);
> +	if (IS_ERR(maps_link)) {
> +		err = PTR_ERR(maps_link);
> +		goto out;
>   	}
> -	return 0;
> -}
[...]
