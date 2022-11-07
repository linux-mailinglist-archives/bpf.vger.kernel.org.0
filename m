Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4761FBC6
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 18:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiKGRq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 12:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiKGRqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 12:46:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663AFBC1B;
        Mon,  7 Nov 2022 09:46:30 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7Glo3r026010;
        Mon, 7 Nov 2022 09:46:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fjLLQxmqCHEgqkfCMXUlufI6SFYiaIY687Gc0HEmYXI=;
 b=VJvhBSbKamgp8jEHhvdwflg2PZwVPJSckJsf1ETHw/YIUho+3CAPjGOOX2Q82ZH+UlbK
 6q1c381I/p0P6UJ/lmtiyGp0U3S1kZ3Ld/HzTMd7GzHyfkHV6YRRPyz7OznexGexiOtu
 dIYjkxdx2nxbFAK7K0nxzIprRx4Ng7W3yoEglwiUnAfQT/lE9AhCvI2S6SovB7CiGn6G
 GY2J3WK6eMKxfZ4vJ3ZYUhzTrApPkr0RCVdy2x7Mx+oQf5ylkaa7Em7eprGZZZka8E75
 KQ+7A501FL7tM9cFK96Pc0AKOpJ84KA11C9yVkD7hcKsPOicZzV137iEL7AoswvBft28 pw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knq54rehr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 09:46:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh/v3ydCHCt1sv3M/P1jTtJfSKCWtnDRaYfydc+kXOXxuyBgLOq2vFKZ7JYOTbPwfwqc6TVwnwjYl0kyg501d+mu1hhrmHJVsG2ePa/NB0WDszI3KIxeK9wFCD+DdJyhRzbyO+yMu5NMJ+T+2PrXZ80pwra+TRdIFpfuu/POiMrJOAXATBTBil7fSwxLU6RFV4N259nvV78UgtKuhmTzgKw7/qennDsiJMC+Pnk8GwgMJsVsxzBieS9tVgKD/ISFbiUDSDl+SWOgyRSssPdmYZQ/dPUgbCMU0cgu3AVHJ+wtxRr92PuI2uHo4Qylvi6DSvMwXzdizlxqv3NCmBxwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjLLQxmqCHEgqkfCMXUlufI6SFYiaIY687Gc0HEmYXI=;
 b=VOfaAoHBD5Ggq4whoPKI5UX4wKOcDZ0FlhMemNJeDljJgDkMG87u9flw6HQvGUAlb4tvQgyuJ4wD6QDVw6BH2asCkh9PxcO0iOUBG5l9pRHsfbc0DRmR8hZkxs5UxOvM/JJ1T4aRvFjjm7ZraUVeGniQ0hJJGeGHpbpo7/5+ZA1pDPgwdgq3K9XcqZbzFAFAa1EuFxLRzuLd6A7r4+WMlXY+lpewBSr3fg375GC6Vx9ZzEi+9QSsGpAJwAm+2i8HVhmvXci3/1qmMLZvRJtKtUcLW6EcyTigVrJXrWgW7Tp861hejZJXQNd0Hp8mEn//xAuJIBw1YGEtGzRntKuMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5085.namprd15.prod.outlook.com (2603:10b6:510:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Mon, 7 Nov
 2022 17:46:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:46:09 +0000
Message-ID: <1ef036ac-1499-ae14-0ceb-997fa03db509@meta.com>
Date:   Mon, 7 Nov 2022 09:46:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v3] docs/bpf: document BPF ARRAY_OF_MAPS and
 HASH_OF_MAPS
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maryam Tahhan <mtahhan@redhat.com>,
        kernel test robot <lkp@intel.com>
References: <20221107134840.92633-1-donald.hunter@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107134840.92633-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1e4f09-505c-4b00-f993-08dac0e7f444
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDfnjjbnZw2199qTTRM5d7uq3WKERSmybCkXqkqwEKmhgv+1vrPa331ZOVqI6N3Egy7JowmsDd6gSjfXa/gJSIDNkeG3awzDdAoGQzo+GmazYUEQuV8vD4avQD0CSxOk36Gr6UpguJY/LKx5XLQCPVgALL/VYuYUJVqkSrzQc7e0Zm8/j6h3qw+mBWinMSATZA8GGC6p3TD6+keIg9y1I8k/gEtCwDoiKTDNleNKWlgH3r0iciTHWsDvDsm9QjykKJMY4L4/GUeYjvGDrFEj5kt/oKi8P5ZQkhJ2Nv1ltL8mRY4KPLjAmRAvA3I5LVeJYYOoO5Tg3CwEGWRPn9JXfP694A05lUnFCAW9PXIlsCWAMsitgdlEL+L0De3pOp3tWq0Vaf480Vfay/TSsg5hi85bJdEM10su8/BbEJpo1+D2L8fjB/II9sNIEE8T9ngOzFmhDZM5sAR7O86XWrFfSaAUgw7eVpkMBYftjGXfwdBBybAJVqdlleyTmQEM044SVqtkXZ23WxpjLqF1c2kii7TRBObjuv10xh+KCsqTF23rY+CKBamHbu8RyATz4W4j0E3+YWSwwDsEV1BO5/pc5KLruMGBBIr471JgIrHleHCYGz1ikIyfoET93sj3PA7DfZO7n6/S7Qrz06OfJ25FyyLl7+LXJzD0FZsj0/2Ar/4vOGFrNCQLuw6eqwmadlIqgSkd9H99beUEkCPwTsbcAUdcq2hoCU2aKmfgnSdZLTMmcmqszZiMIJnxj7keKRhkTSjhzg45FFOb3Lrugtlj8oKVNd4np+f1nK0g8m6KZPxfzUXr+YafMaO9SFccDcYZm3Q72+U8TYQbeWK7tVmYjU4mSXq8kzxseQnt3kWlH3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(36756003)(31696002)(86362001)(38100700002)(6506007)(31686004)(316002)(66946007)(66556008)(53546011)(966005)(6486002)(6666004)(54906003)(478600001)(2616005)(5660300002)(66476007)(83380400001)(8936002)(6512007)(2906002)(186003)(4326008)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW9ReVFhMDZTWXphald3YmZMbS9hT1dsNTZEb3Y1c1MwbjI2TjZpZEpWa3ZD?=
 =?utf-8?B?V2JIdjU0dytXRnhYbVo1cmZVUnJEK0JLYS81cG9FQ1NhMnJsc3IvZHVRWmpO?=
 =?utf-8?B?S2NoWkdMUmZadWZteE11eVdlWFZGUHdqSVhwVk5EcFlDOWxFZ3Zua3ZrZ0Zz?=
 =?utf-8?B?WElpYUdKMTc5UGFEVGFVekFPSld0a3FKNnl1VzN0bGZ5QlJ3THBnbEZ6WlBO?=
 =?utf-8?B?Q2R6b1dSdGtsanRlSjErUDdNUjBlQnMwRFdSNWM0YjdNVlJaQkFWS0hjT2Ji?=
 =?utf-8?B?RDNwZmVnQStEZXFWUHN0d1hLb1NCRVJjYkovRWczek8wWXZraWdURUo4L1VP?=
 =?utf-8?B?aW9ERkEySkJ4RU0rOUhna0JrODVnWU1mUlh1V1lLTWJVWmY3RzZLdVBSZVBK?=
 =?utf-8?B?U05TclBNNzFqWTd2Y0g0ZDNNdkR1UHJxR2xaU0JLL1JIVHMvSmVFdmxsV0VN?=
 =?utf-8?B?bTBudTNFNkllY2g1WDlQRmd0eVRneWQwNk92Ly9rdlozMDIySEFvZGxTa1Fm?=
 =?utf-8?B?Q3NwamhYdHJQOFVzSzNLejMvaFlyUmpHV25tbmw5V25pTEN3UG45THMvYW1N?=
 =?utf-8?B?WHNOOEphRHhEYWJEVTltUUlLV3drbDFxQ1NBV2RmZ0dTRVRQT1RTYVhnOXVk?=
 =?utf-8?B?UTlnaTBzUys0VFpXVHVpSzlKZXRQNGdoYW4vb0xjMjdoMXVxM3pFRzJKQnZv?=
 =?utf-8?B?aHRjOEhVNXVlUmhhOUU2Y3ZZdVNSaSs1ZDNheWxwTlhoczRrdkE5VENDcnhi?=
 =?utf-8?B?TWNzTWYrSVhVVWpwK21DLzdsRlFJZzNlQnNhL0FTbzFRdHd5dVRPaERrcXBl?=
 =?utf-8?B?R1Q4eFcvanpkekVxYU8yRnZHVEY0ak9HVEhZc2xaVEU1bzJoOWJjQzNHczJu?=
 =?utf-8?B?Q0d6T0t3bHdGcS90WlF0NUFLbnBxR054L0RMZ1dSeDM5N1BOaXV4TGlxMEZ2?=
 =?utf-8?B?ckNRQUlXVW9rMnRSRURVTWVBbjlQVDFseHJNcGtJS05LNHhVQ1pmUzZVMTIx?=
 =?utf-8?B?b0c0VHN0NlZyM2JnM01vWG8yWVI0Umx3TGxPU3BvWFNaRGUwaVA4bVlxbkRB?=
 =?utf-8?B?c0x4NjZzWElTV09namlnaEc3WVh5QzdyMU5oMUNqZHYyZ21ZbkpXVlF4UnY4?=
 =?utf-8?B?clE0SStGS2NtdzNHdkE1ZWYrOVNtNGZ1dkxPcDNLYisvNU50KzlZOFpJZXl5?=
 =?utf-8?B?VGM1a1lWWWRmRlZBRFZnU1UwODQvUmN2OHF6Y2E5aHBCdEdKVFY4TzdnUFg1?=
 =?utf-8?B?aUdSN2VMQzNpb3BjbjN0cWxVMDBucHExZis4UDAyTkR1dm1Rc2wxYWQwSVIw?=
 =?utf-8?B?YzZ0U0lydTIveCtuQWF3TkRwQW85WDBxMUZURVoxaUdFSTZrdXVSL1U5NStm?=
 =?utf-8?B?RUxXeXRxbWhLZ2tyb3RDYlBmR2lPUnZrRzZid0RLc3B5MjhKdEI5czlVSmlq?=
 =?utf-8?B?L0lpNVdyK1NpbHJjU3ZmK21DTEQ1UVZJeWlOZ0FpWWM5S3VxVGxidmpyZHdJ?=
 =?utf-8?B?M2liYUwvbHpuWW0wZm1hY3R5NFoxVVAyVjZaeUZ1QVZraSsreTdVSitDaC9t?=
 =?utf-8?B?SERzS2JlUEx3YVdURVhNd1RUZkdMWGUwYnpXanRNTjgwZnA2clRTYUpLb2JG?=
 =?utf-8?B?MzJPYjQvODlEbFJXSzhUaVc4R3JPaHF3M0tVVmt2Q3VLUWNtc0h5VzIraDg0?=
 =?utf-8?B?UHpkUUZ2Z1RYcTlLZEhXUTdnRkZzZGtxNmR0MkJ4M3ZaOWNHb0ZGN0R6QkFB?=
 =?utf-8?B?MFlCZzVJV0NHcC9vY1A5T2g3eVNiTE9ZMVl2WlRWNkdxMFBUZWNiejNoMStk?=
 =?utf-8?B?dVphTDNCWjlVa1RPNnp5ZnBnaXh3UGs4elAzMXI1cldQRkFJR1ZWYjl1NmpH?=
 =?utf-8?B?RUhiNTBVTy9BSWVHeFowNFZsLzZMMlpnVkZkSFJ0T2VLbXFDc2JTeklPcVpN?=
 =?utf-8?B?WXJuRTNwSnJWUm5neVZVR01rNHBSZnk1Z2pnRW1PLys2N0pCUEtHay9FN1RM?=
 =?utf-8?B?TThDNjQvY2RjMTgvei9oV0Q3Sk94NmVOTlo1b2xhTmFZUEM5ZnJQTkFHeFNG?=
 =?utf-8?B?ck5BWW9IYXZQR0ZYb1JRSG9Za0xieitaQWlEdS8rckZRZnhaOGRSWXh1c2hM?=
 =?utf-8?B?Zit1UWhseWMvNmdoT0QwRkltK0FVVXRhMWIvNEhiY3ZibC83K2c1QS8vaGdq?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1e4f09-505c-4b00-f993-08dac0e7f444
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:46:09.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w/CmZWne1IE3O35p1Ns/FEo0Hl93UuXfp7bwkql5JhuScZDxrwHWZ+SXPuVUcY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5085
X-Proofpoint-ORIG-GUID: Ho6wBDzNsETQ8kS6DyxnbO4s6OPZc_tQ
X-Proofpoint-GUID: Ho6wBDzNsETQ8kS6DyxnbO4s6OPZc_tQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/7/22 5:48 AM, Donald Hunter wrote:
> Add documentation for the ARRAY_OF_MAPS and HASH_OF_MAPS map types,
> including usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> v2 -> v3:
> - Update BPF example to show declarative initialisation, as
>    suggested by Andrii Nakryiko
> - Use LIBBPF_OPTS inline initialisation, as suggested by
>    Andrii Nakryiko
> - Fix duplicate label warning,
> Reported-by: kernel test robot <lkp@intel.com>
> 
> v1 -> v2:
> - Fix formatting nits
> - Tidy up code snippets as suggested by Maryam Tahhan
> ---
>   Documentation/bpf/map_of_maps.rst | 126 ++++++++++++++++++++++++++++++
>   1 file changed, 126 insertions(+)
>   create mode 100644 Documentation/bpf/map_of_maps.rst
> 
> diff --git a/Documentation/bpf/map_of_maps.rst b/Documentation/bpf/map_of_maps.rst
> new file mode 100644
> index 000000000000..63e41b06a91d
> --- /dev/null
> +++ b/Documentation/bpf/map_of_maps.rst
> @@ -0,0 +1,126 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +========================================================
> +BPF_MAP_TYPE_ARRAY_OF_MAPS and BPF_MAP_TYPE_HASH_OF_MAPS
> +========================================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` were
> +     introduced in kernel version 4.12
> +
> +``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` provide general
> +purpose support for map in map storage. One level of nesting is supported, where
> +an outer map contains instances of a single type of inner map, for example
> +``array_of_maps->sock_map``.
> +
> +When creating an outer map, an inner map instance is used to initialize the
> +metadata that the outer map holds about its inner maps. This inner map has a
> +separate lifetime from the outer map and can be deleted after the outer map has
> +been created.
> +
> +The outer map supports element update and delete from user space using the
> +syscall API. A BPF program is only allowed to do element lookup in the outer
> +map.

The outer map supports element lookup, update and delete from user space 
using the syscall API.

A BPF program can do element delete for array/hash_of_maps. Please 
double check.

> +
> +.. note::
> +   - Multi-level nesting is not supported.
> +   - Any BPF map type can be used as an inner map, except for
> +     ``BPF_MAP_TYPE_PROG_ARRAY``.
> +   - A BPF program cannot update or delete outer map entries.

A BPF program cannot update outer map entries.

> +
> +For ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` the key is an unsigned 32-bit integer index
> +into the array. The array is a fixed size with ``max_entries`` elements that are
> +zero initialized when created.
> +
> +For ``BPF_MAP_TYPE_HASH_OF_MAPS`` the key type can be chosen when defining the
> +map. The kernel is responsible for allocating and freeing key/value pairs, up to
> +the max_entries limit that you specify. Hash maps use pre-allocation of hash
> +table elements by default. The ``BPF_F_NO_PREALLOC`` flag can be used to disable
> +pre-allocation when it is too memory expensive.
> +
> +Usage
> +=====
> +
> +Kernel BPF Helper
> +-----------------
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Inner maps can be retrieved using the ``bpf_map_lookup_elem()`` helper. This
> +helper returns a pointer to the inner map, or ``NULL`` if no entry was found.

bpf_map_delete_elem?

> +
> +Examples
> +========
> +
> +Kernel BPF Example
> +------------------
> +
> +This snippet shows how to create and initialise an array of devmaps in a BPF
> +program. Note that the outer array can only be modified from user space using
> +the syscall API.
> +
> +.. code-block:: c
> +
> +    struct inner_map {
> +            __uint(type, BPF_MAP_TYPE_DEVMAP);
> +            __uint(max_entries, 10);
> +            __type(key, __u32);
> +            __type(value, __u32);
> +    } inner_map1 SEC(".maps"), inner_map2 SEC(".maps");
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +            __uint(max_entries, 2);
> +            __type(key, __u32);
> +            __array(values, struct inner_map);
> +    } outer_map SEC(".maps") = {
> +            .values = { &inner_map1,
> +                        &inner_map2 }
> +    };
> +
> +See ``progs/test_bpf_map_in_map.c`` in ``tools/testing/selftests/bpf`` for more

The file name test_bpf_map_in_map.c` does not exist.

> +examples of declarative initialisation of outer maps.
> +
> +User Space
> +----------
> +
> +This snippet shows how to create an array based outer map:
> +
> +.. code-block:: c
> +
> +    int create_outer_array(int inner_fd) {
> +            int fd;
> +
> +            LIBBPF_OPTS(bpf_map_create_opts, opts, .inner_map_fd = inner_fd);

This is declaration. Please put it adjacent to 'int fd'.

> +            fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS,
> +                                "example_array",       /* name */
> +                                sizeof(__u32),         /* key size */
> +                                sizeof(__u32),         /* value size */
> +                                256,                   /* max entries */
> +                                &opts);                /* create opts */
> +            return fd;
> +    }
> +
> +
> +This snippet shows how to add an inner map to an outer map:
> +
> +.. code-block:: c
> +
> +    int add_devmap(int outer_fd, int index, const char *name) {
> +            int fd;
> +
> +            fd = bpf_map_create(BPF_MAP_TYPE_DEVMAP, name,
> +                                sizeof(__u32), sizeof(__u32), 256, NULL);
> +            if (fd < 0)
> +                    return fd;
> +
> +            return bpf_map_update_elem(outer_fd, &index, &fd, BPF_ANY);
> +    }
> +
> +References
> +==========
> +
> +- https://lore.kernel.org/netdev/20170322170035.923581-3-kafai@fb.com/
> +- https://lore.kernel.org/netdev/20170322170035.923581-4-kafai@fb.com/
