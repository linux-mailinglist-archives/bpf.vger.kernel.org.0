Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2551397F
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349831AbiD1QS3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiD1QS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:18:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8351527B3F
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:15:10 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23SG7t2n011411;
        Thu, 28 Apr 2022 09:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zxd/JkwuZtK4SPbcuo04xhbaL8Cdi6L9ukgMVd5LAxg=;
 b=kafDiW+5+OQXsycscgsp7B1zuk+jDJywh6f4Hu/IDaDsEvzlB0Pw97mcRfu0qy7nT5OX
 Dzzgtd+DxR2QLAOYXUZuqBI80bYqf2qFASN0f+TfjSPA2HOaotAGaJm5+6YYSn3t+1GI
 DDTrq1/rwB/7iqbbbrrApBw499I0j0wuEvU= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fprsqdkfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 09:14:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaB3lfUmoiweOwDrBLoGKQCJA1ttOMjAzQO8dUmM7KYtLS6KPyS6i5WlEAZmalnE+bwBtPqKtHx737/hbCiffqA8vzjyrvGcG+9Nu2tijaqRSziHWZV6ZLILTTTHDZvUE6oghBqWu+Aeq4x1WXYA7peqRIhIBLyB3xRlPg8O8jjdfCiDugsz04OLg/ekmmN4nEhCPRBPz8KghY9uegus4Knq75F4jZR6dW94A+KcCRYLsNvGqu98g/Gri7loIhyKR6aqOxdW8ujJXTZmqPVRC6cgh7BGatwsEPpj0eux4nxt3WV2kYNZ26SvYqR7DPDyuRpSExNmBD3Fprdi5XSulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxd/JkwuZtK4SPbcuo04xhbaL8Cdi6L9ukgMVd5LAxg=;
 b=WM6GZhJEjqq8YuqHnwlI6Sf4+WyukSR0Gls9e2pKbp4jzQBFm9dRSywGxOEakdvOd1J37QH+y0PUpy4/yiNxhMSXYYFQwpYO6hdsE1Il/80JKAdd/TZWWyUaar2bpMklf/9/gYe9E4/TaThys3Qdlh4apBjiSO+UDftKyeM4cbh4lPljZwlcMbQsfB3qxcZplJLibyZiPxBKYNx7L5hfcdjdiu3ONU0NPJgbFjaNQG8HTbEWgX8icXVcuC14c3FqC6unQW3EC1IJvS/4dN/PJ+/01tbnS2dOQ49LYFkQfSdiDzu3QQp1h8A/1bbs8863BC9zj1VsRYrwTTo7GkCPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB2548.namprd15.prod.outlook.com (2603:10b6:408:c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 16:14:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 16:14:48 +0000
Message-ID: <5b2afbe0-12ff-f975-59b3-89dd5bb3e35e@fb.com>
Date:   Thu, 28 Apr 2022 09:14:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_link iterator
Content-Language: en-US
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com
References: <20220422182254.13693-1-9erthalion6@gmail.com>
 <20220422182254.13693-2-9erthalion6@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220422182254.13693-2-9erthalion6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00de1204-5c9a-47b3-4187-08da29323783
X-MS-TrafficTypeDiagnostic: BN8PR15MB2548:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB25481266773266BA7FB80ECDD3FD9@BN8PR15MB2548.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwYInShcYwbyM3UcT/nfilA+TtUDg9FsNoqdGz9WRc3YWnPNAdc/eGv2md0gUP74fciStLabZdRuH3AmV3HIcprkLFSGLp2vU/pVa9doNBX83rMtZHwNi6Vn7qRju2Yp5wAa2D3+bQvQ/ewheECri1ZATGpvoO1AONOKLDHA3v3a9iqIBKzI3zgL0KzJ5BgoIbYr4wYBM2ArDV3sPvZUVyXDjgakif+6hC95j/oW6uBfFzgK5K+t9Kxp/6NMSNFZJpQO4vGX2CiI7dzdugI8HppBFMddTpU+X0E2pjsUcX8Z1gv4oohUoqO76ftinWxl/s1+JwCdmVKFjTUnYeuoN4+Jo1e7OM34EI6Vfp9U80g5Zl4GVVtWX23XY+R7aQizRx9ByYj2ICNd47EJtaSpWl//L+dJLAD1rmbKnf6xsH6/aYHkXE3TRkfWUnNwlAgCJk/8cumXVZiKmlQogbttTVuG2eMuJFSyZ2SeFU1S8ap+DIfRzCcDGlXG+j70c/cr6AqOEIQVYQIjEleW6z/YipfWiILktOWvm3pO1tqgo4e+88gqW05eW/amoVC0yy2eZsn/bQCVLE/Va1HcGgke1YfNC5YjeSY2M801rWz0iMwz6eqfhWQEDD0L5KNwoybdOKyLMYoTIn3LFFQ8xasr8eNSlqoyEnHqB5MyqZgPpnyWr9MVew2ua+WJVmQ4+V2kRYz7xlLfOAZCUI53MUdd4XBHRv2gLuN6HWyhfIwlXwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6506007)(53546011)(52116002)(186003)(6486002)(8936002)(6512007)(31696002)(5660300002)(508600001)(2616005)(86362001)(36756003)(316002)(6636002)(66556008)(66476007)(8676002)(66946007)(38100700002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lXenRKTUd0TkJOY1FnZUlMMWNoUGZ5UG9CNHVWeGRTOHlQbDMwRjUrTytC?=
 =?utf-8?B?TWQzV3N6NmlsT3llU3d4WnZDRUJWaXdmTWRYbVhqQld3c1lab3B3SG55N3NN?=
 =?utf-8?B?a3g4SnVlUjdLUkZjKzJlVHBhaWEyRUh2cFpWdTlvNjg3K055UmpIeTdYM0lj?=
 =?utf-8?B?TFNvcUFEQVBjQkowSXpFcStDbnVsUGhXb3Q1bHdKeG84Vm0zdEJsUHNqdjBp?=
 =?utf-8?B?L2VwQmIwd2k3QTlINmZJRkRjV3h0bTJjQzNkbUhzSk1Ud2E3dVNvSzJCK05B?=
 =?utf-8?B?M3RhT2RWTktjMzZCNSt0WnhBMkUyL1g2Y2R1WDBlc3pmVFlwV0FnY2R5eFZW?=
 =?utf-8?B?ay80WnE3bTdIbDYxT3RGL0JzdEViMHN0bFF4R3NtKzdBVWFrdHRXbXBLNmVE?=
 =?utf-8?B?R0UzOEdUSTZlWnBJMDNjYnJyMlZBVzlHRGQvMHByaXFEbk52cll3TWJKUXly?=
 =?utf-8?B?WlN4b2dPcThQYkE3VHkrMjVEbm1aVXREb2s0UXhpRGRFbGV0aWZZN2EwS3FF?=
 =?utf-8?B?S0JpdU1yUHI4TWNReDVqeVh5emljNFJlYVlxcFlUYjl6UDl1ZThIc1luNU5i?=
 =?utf-8?B?ZUxwRnRUMm5nSjIzMHpqNWhGb01uLyttNEsyeWRzY2U0blJKanRxME1JWEtl?=
 =?utf-8?B?Tm9kaUJXZVppY2N3Y1EzYjVPYXMxd2k1amt1S3lDY2QwMkpRL3VOdnJZUWRK?=
 =?utf-8?B?eUNjdkFqWGhLYTFGM2paSTNhUmRWNlVpMlBZYm5DdUxGQmYwWU1lY3Fxai8w?=
 =?utf-8?B?RXpOU1dqMzYzS2t2dFhaaDdSRDhqaUFmK2VETVZNdHdpNGE3T0dlZ3dVSmho?=
 =?utf-8?B?b0tUMStGdFRMa0pva2JTaytFRXRWb3Z3OHhJc2FIUm9hV0hMKzhRT3A3VmpQ?=
 =?utf-8?B?cFA1K1BweWRXS3F1QWo0Rkh0T2RKRzAybGU4ZGdkTmNYM05PaGoyWm1lR3ZI?=
 =?utf-8?B?S2E5S2QrYzhVT2h6WTdjcjJkdTlsYnJmL1lOc3FoVkhaa2dnd2hpeExScVJi?=
 =?utf-8?B?WlZwcVp0R2tvRW1ybytNWmxZNm40aGRRU1pxVmcvdHFoa3RPUWVrOC92TGh6?=
 =?utf-8?B?UnpSMDU1TDZ2VGNPU0c5TnZQQms4S0VpcmpzVlN4WkVyelBPdzBxSXljNVk2?=
 =?utf-8?B?YkhnY0J0czlKdW5vb0YzVWxEenloVXluSlEyNUhGNzRJRDdzdXhVN3lUbEM2?=
 =?utf-8?B?YnViYjlGTDBIWmZvaEF2NHdjSWNKLzdUOGZtVnFPVk5pc0Vrd0ZtTnU2NWh1?=
 =?utf-8?B?MGZmN25yRFpzZW1NaHN5UEkzNno1U082S0dJditEeC8yMXIvcFpwN2c0ME1T?=
 =?utf-8?B?SU96NTlDZ3lkSkxOOGZRb2RRS204dU9WR2FzdU1FTlFTYVZSSk9seW5IWlJG?=
 =?utf-8?B?MFdsMXE1SUFEa0l3amprdG5aSGJVNGw1emxkNzcxTWkvaENtMG9CdjZXN284?=
 =?utf-8?B?VGJCakJxMzdpRFJ4YmJZMVRrVUd6cHNqVlcyNlhPcXRjdllQUUUxZ1g4Q1J4?=
 =?utf-8?B?aEs4dHZBRyt2SjRFblhyaHNxbHNCSGFKajRSQXlDU3kvZzhoK1NKZTZWSDBa?=
 =?utf-8?B?L0hsanUyNW9pbU9RY1pyMTNYdUpqdWEva3RpRndkZmtGdXB1cHRKbEFxUUlT?=
 =?utf-8?B?NnloZGNiZGF2dmh5UU4rcEFyTXBhN1dKZU5mRTR3ZXRhcFZQRWUyYitaWEYz?=
 =?utf-8?B?ZHBvV2tuZ2VBejl2VGltVkk0UXhOV1FrMnBXQm1TemJ3UzVaWkdGSC9CNjk4?=
 =?utf-8?B?WENNYmM5Vk1DQ3ljaEM3UVRsVHBKMnVEQ1dDR2hVMnMwSHpkNm1GMmZNV1ZX?=
 =?utf-8?B?VFUzZG1lLzFSa0IwaWw4Sm00bU0yRUdwalFKc3NGT0owRXNlVytWU2RZQVFW?=
 =?utf-8?B?ekY5aG8wOXU1MFR4RmpuQmd4b2IvdHRjdHFSTnlzRVVCZ0FSNGhkdUlYYzZR?=
 =?utf-8?B?RlQ5bFhSWE1oUExtcE84NDRSQURFM3hnWjZoNHNwSzhHR1kzVm02eFM2MFJS?=
 =?utf-8?B?eGM0bElCc3h5b1FaRCtSdENlekF2U0tISHowQkdJM2pDSDFpMGd6YTVPR2V6?=
 =?utf-8?B?TThPYk5kcXhTaHFqV1phSDN1VGg2a3p3MEhSNE5ZV2svcWM5Mm5MWXpsVHE4?=
 =?utf-8?B?bkpTRTQ0VW05bldNSEdvTTdNKzFONVAxQlpkUUQ4RGZjSWNQcEp0Rzl3U2Mr?=
 =?utf-8?B?Y3FOWnJMYXIxTm9TR1hKVnhCbnpuclhnRFRDaTBSdE9IVkFMNEsrLzJaQWhV?=
 =?utf-8?B?cGdZOXM3ZWV2ejVDaExtRlFla1FEVTluUU9FeDJOOGNvOGw0YndEQXU3UVRr?=
 =?utf-8?B?OHYvOEtxOE1zbjYvTUdob1dmS29hRmNLS1IxeldGUjlNenF5c29PRExLZEkz?=
 =?utf-8?Q?v3sZZYvlmfWCBkvs=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00de1204-5c9a-47b3-4187-08da29323783
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 16:14:48.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36IYrJqnd0Ta6jlA8IzUE23r4E3m0Y1rFxa2zJ72FsgZUQD42i593MuCdmsHa8si
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2548
X-Proofpoint-ORIG-GUID: cuKnVuxoZpAhRxTzn_cfz_mKzeDUhO2z
X-Proofpoint-GUID: cuKnVuxoZpAhRxTzn_cfz_mKzeDUhO2z
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
> Implement bpf_link iterator to traverse links via bpf_seq_file
> operations. The changeset is mostly shamelessly copied from
> commit a228a64fc1e4 ("bpf: Add bpf_prog iterator")

LGTM except one copyright issue mentioned by Andrii early.

Acked-by: Yonghong Song <yhs@fb.com>

> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>   include/linux/bpf.h    |   1 +
>   kernel/bpf/Makefile    |   2 +-
>   kernel/bpf/link_iter.c | 107 +++++++++++++++++++++++++++++++++++++++++
>   kernel/bpf/syscall.c   |  19 ++++++++
>   4 files changed, 128 insertions(+), 1 deletion(-)
>   create mode 100644 kernel/bpf/link_iter.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7bf441563ffc..330e88fcc50e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1489,6 +1489,7 @@ void bpf_link_put(struct bpf_link *link);
>   int bpf_link_new_fd(struct bpf_link *link);
>   struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>   struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> +struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>   
>   int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>   int bpf_obj_get_user(const char __user *pathname, int flags);
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index c1a9be6a4b9f..057ba8e01e70 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
>   endif
>   CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>   
> -obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
> +obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
>   obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>   obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>   obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
> diff --git a/kernel/bpf/link_iter.c b/kernel/bpf/link_iter.c
> new file mode 100644
> index 000000000000..fde41d09f26b
> --- /dev/null
> +++ b/kernel/bpf/link_iter.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2020 Facebook */

Change to your own copyright.

> +#include <linux/bpf.h>
> +#include <linux/fs.h>
> +#include <linux/filter.h>
> +#include <linux/kernel.h>
> +#include <linux/btf_ids.h>
> +
[...]
