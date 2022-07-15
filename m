Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92985576A1C
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 00:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiGOWpQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 18:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiGOWow (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 18:44:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE851CB19
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 15:43:48 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKnC3N010888;
        Fri, 15 Jul 2022 15:43:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=O/mSYCmgzF0yjv0M6sVkE8UOQKtLNsDkchXQmUJM/8U=;
 b=K5PdtxMEO6aU/8+zBnYG1iOUNZrKT28KlmEGxCY6s8gvPZG3uHWj3QWZT2e7zsTZ5+S/
 ePbshnRsx4tqUuW0tb9fjTI9vA5ci7Mm3V/KmAuD/NH61c+OtCGEmgzD3KsSqgb/Og7T
 c27fws95w+CgxK8ELy4e/2kF16P8A2QBz+A= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hb8md3mxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 15:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZJPNATLLe0Kzs+rl0MTTClDE89ZTMJgVWlQirmHplCpfjrV7HcFaYMDrjxmifFsE4tfsP4YZHKyJBzIAx/Ni6Hjx9xmH7IVzSJrPZuSU1D0ZpmWw3lIy1v6+uCAhQlI7DFz4GcB30lb9gBE4AsSXMQAGsz7298i7n0yuFOXa7eWKraJFWsnUMU0ApWO18qWv+POsdN450yfKSeXw/4GIxfhRnLktfdLdKyfVqkJBgyuHUml4wV4DoPMSxnKxsrO4ne/EYor+bCeCp2fRKo5Lr/Q91UFHp+ahuGXqFDJyGOxDghJtpvCD0w9JiKeZZ5Sp87Cn8TdZf2SoBF4L730Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/mSYCmgzF0yjv0M6sVkE8UOQKtLNsDkchXQmUJM/8U=;
 b=be9Eh7MTSHfh0keK5a9ucg8rRaBB+sx19MuaFpHoZKPD72+K9ZXfxNFNLkpYSbgLQIMG7KrxQOtFjEh+2HkjIkvxnWZArQQvpsJfxBPu15cT+RbxEROnYpmsoGwyB9Y2DHORd5hn9dG4wNUiexBPBrBWAoWJIdIIMDf9R0jLDMLg62TkmUqUwnhUXg/9EYDBlKNS8aRb6mV6pxm/FRlTAfLGMrfcYSIn5YU9VuxLG/DDUhV7lspwlwOb1pg5d7Ky4L7YyI9hFh/jXjwQZVcxXf1e42EWfLpnCvtcZeqFifqAwsUcvC+r0BPL/zZ9ot+NwN/O4XWp4AZelaLLjC0dzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3223.namprd15.prod.outlook.com (2603:10b6:a03:110::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 15 Jul
 2022 22:43:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 22:43:31 +0000
Message-ID: <dceeb2c8-5676-34c0-4ee1-a67d9c230a8a@fb.com>
Date:   Fri, 15 Jul 2022 15:43:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next 1/2] libbpf: make RINGBUF map size adjustments
 more eagerly
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220715192456.1151015-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220715192456.1151015-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9af8b81-fe56-4e07-1b79-08da66b3715b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3223:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xikJq/OH15lmPxCmyl802bnXvoMhfeWHEgEJ3sNlJ3qcN+sn4zLtKaoKbN+om7gdijiAvkCZVCJrRgDBof9MUAcGDDHM6RunZXcUHdlgnmGNyzUuuX1L96Ipar9uNjqUV9GSd6EhO3q18okiAFqtfhGeD2ihbXa9UOgUv+q1DkuK3YGQvqdeP3ePsOKiSAotMKHBh+BfQIASA/6ZR3r1HUU/148+6EF3a2d+l1ZpOGCkho78x0Ecq1Ze4G82s95hCBMFB9qQtYmyI8bGBlMVkY2ZPJ7mlHZwH2n1JBab7nFC7sLk44FNYYxoAagPBX4JqTxb+YUwG88seK1zKIAA3r3DgaGaPEa9oxamVhaBVrIEF3aWvjzVLEYGDPq2xLn/avqNFMg+aEkwnb6Bn9R2ES9Dv9rAczB2WCtyCmfv3U5W19UrvoXa6FinoVF6ry1zMHouXcXdKMVsp0/tkli5whT6DfkCGRAeftVZnDCyK0N79NXY59wVE8i2QbBB7wMbpR+37k7Ai20789yuFZc8DLjQHj8nKRoM3J7hHnbNd7zumeScMujycomBqwWBVsMLQ6VlmmffAGu5bST2Oya/i7kPEIn9kfgXFtQGeR2gDtiMA3jSxvYfJQVG2vQO9VddAi1blUQnscthmfQbl2xJ2pBBBSxGXxyyX526r9lS0gwmjgNvMp+KMMdYr0Eob2p5zB3bs4TvSu9bCiJLdwtzi0rjcaUbAtWzFk8LYjuk8QRSBjNbskmqMC6bbk+hn18oealjAroQuExoaBOVDsWgJLt5GX3ZXVEVgEcuA5jF06XJRvx6Ai4R4QK13J2WbKkQEp5jv9hr9C7ejx5W/mtLPvo9Nv8DofOnpeBlKWsNKED50Qky2Lgyem0qIRMXfNb3xHHmpMpAlDkUpE1Iqt+gq1kWxHHnqkTSkG63g+Kpnq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(83380400001)(38100700002)(86362001)(186003)(31696002)(966005)(66476007)(66556008)(6486002)(66946007)(316002)(31686004)(36756003)(8676002)(4326008)(8936002)(478600001)(53546011)(6512007)(6506007)(2616005)(41300700001)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry95anRleUNxVzBLbHlaOXR1VVZLS0lQeDRvVTVXMFEwdlNKRndjK1RmZW5H?=
 =?utf-8?B?ZDB1NXZxWFB6aVpyZEYrL25sWXZldFYzWGM1S2hHU2JNdGh5N0kzMTRyU3pH?=
 =?utf-8?B?eUdhMjhlWnBKZXBWSWVjOVVDU2c5NU15azJNYW9DZGIzM3NVeXNXVk1ETUxD?=
 =?utf-8?B?amZRVFl1ajNjVkNCY0VzUGZQU2FuRkI0UHBYU3RQQWhUQUYwNDRJQ3poZ0pS?=
 =?utf-8?B?bmZJWERsY0dxbWxqYTZ1SmdKbDUyWktXUEM2QkFyRmlhUGtLYk5ybG16Tytj?=
 =?utf-8?B?eUdKckpoeEdKYmVHeVFhL0kzMVdFcitnNlI5YzBOMWlLRTYwbVZvU1crVkg4?=
 =?utf-8?B?cFIxUDl6NmhEU3lzWGpiQ3Q3TVRMNklpV0M1VjBCZXJYa0gvR0JLSmFoa1p2?=
 =?utf-8?B?cVRsd1M2ajNUZVh6WVo0Tlk0OTA5TEpQTmdJQVYxamlodHVHMnVCS3ZOT05u?=
 =?utf-8?B?L0ZVb3Z5bFQyRnRYSGV0Y24reDlZd0J4WTJBejZRYWVZMDdhczZxT21FMGEx?=
 =?utf-8?B?OGN2aDFqTW5yNHhPWllpVFRtcm0yNXlBZ2tWVDFBWlJUSnZjWHNDbUtHTytu?=
 =?utf-8?B?b1hTQlJwaGVQVk1Xa1EvUmNIekpaWWZSa2ZqU0FtMXJCc3dLWVQrRUJYbE1D?=
 =?utf-8?B?djROdVBWREhaMUg0N3V4MzdXcU52ZHRNOWIwb0FWRDdMNlRrZGtQekM0VEdF?=
 =?utf-8?B?VEFPWkxGMkdpeW03MzZSZmFKbzVpRjVrQkhld2Q2L0p3MmhSTGMxL2JzYXZU?=
 =?utf-8?B?NytGWGM3TWdGK1hoaTR6TFN6NU96SS9BeE4vd1h5aFE3eCs1WDlkSGc1VkhB?=
 =?utf-8?B?SnZOdTlleVQ5dDNnR3hVbFRQT3o2RXdteUVOd3ZCTkZ4REVkM2s1VXIzbGFp?=
 =?utf-8?B?dDNqNkFxUExLT2h2WjNkeGdUVlBiTkFjN0ZKWEMwZ0ZqcGx1d3pGTHJPSjRq?=
 =?utf-8?B?RW9idEZCL2J1V2Y3V0NDNjRZREdMOUVlOHJkb0FyYVd1VjI2OC9BZkVOUzQr?=
 =?utf-8?B?Z1FRT0J3OVFRSFdwMXEzVmFpVWs4TTNVYjJLZGhWUy9nQ0M1RE9yUEhBOUps?=
 =?utf-8?B?U1pIYzltbzhFNHRlMThVekU0Yk5BYU1hWmlDemRqNTZJcG5UM3orejVBN1R5?=
 =?utf-8?B?TzRjeVdZZmdsWndKRlQxcE91cDRrSEI4dzlGQWRYMGNhMm5teng0NWZqV0ph?=
 =?utf-8?B?aVJQaUhWYmxsNWVvVTY5OUV6T3QwVDI0YkJxL3R2aXB5RXFRUTVpTUtady81?=
 =?utf-8?B?Vld1WnVyR0FtSEZEUTVUcDFXQzhrckxnazByeW91UjFJR29aOG9ybkFpOFox?=
 =?utf-8?B?TVc4WGdabVh2b2VVc1p0QUZCWHZiQitTNnVEaWpBcXhRemNDdWoraCs3ZnBi?=
 =?utf-8?B?WkJVaUN4ZjNXd2QrK0s5WUtMcHliVUUwK0U0a09kbFU3UXU2VlVVZUJHa1Zj?=
 =?utf-8?B?M1MwTG4vN0xLMzJyWVFLdDArTkN6M2dkNVJjM0JrcElWM1FXbXFja0tLYVJs?=
 =?utf-8?B?cFZtZk5wYjJjUjhSeU5DVTFjdVhTbDFvWVdWUGh1T2FteDZqZ3p5eVkwMU96?=
 =?utf-8?B?aW1TV2hBRXNzNnpiQlI4K3dRYUFsL0svRU9NSG9mYkdZOC9ONVZJYTUycUJt?=
 =?utf-8?B?Y1JpZVkxcDVKRVJhaGZlL21KQmtqTUx2SUprWkExYUV1UmRqS29jYW1uYS9a?=
 =?utf-8?B?N0tEN3ZwT2pyektFSmxVUHdNRjlXOWFqays3U1lOVVZhYlN2dG1UOEc5QU5z?=
 =?utf-8?B?ankrQVhzbUNaU21hUHE4RFJtNnBrVnVlQUhvSnFnbjhPU3ZvSGkxS2pTeURz?=
 =?utf-8?B?V1RRbzJBZ2RBUmpKTlFHTVd0Sm5xSnc0UmZsMkR2NkY0YUU5QzgrZU9Ub3lR?=
 =?utf-8?B?NEUzbmxveGc4dWpJbUV5djNJd01iSTkxV1B3djdVK3I0cFRMQ1lLbzVCc1lQ?=
 =?utf-8?B?L0I1MkRLSmVSd1MrRHZkMnJxbWI1RXpiVVpoc2xvZnIwYlNsNlFFbGNwVExP?=
 =?utf-8?B?U0gvWGtZM2ZHNExVcVd5UXRVeHFNZDNBL0ZrL1BXMFFacHFwZDFIMytVODBa?=
 =?utf-8?B?VmlWUFhBQmtMeDgzRG5ucWthWEtCQ3dPazRaK1FPZzMrTzFRSjVoYkpGYUM1?=
 =?utf-8?Q?NbWFAY0u2FNSJcyeI8r3QCYHS?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9af8b81-fe56-4e07-1b79-08da66b3715b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 22:43:31.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpWZMlcifY5rCqAzN3YWzOB33uG3km9HChs13lpaYbi150y0BCyVN2bG0RTwRPXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3223
X-Proofpoint-ORIG-GUID: FRhBcRLewNX2uCkuKq9zmDb6akNviQUD
X-Proofpoint-GUID: FRhBcRLewNX2uCkuKq9zmDb6akNviQUD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_13,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/22 12:24 PM, Andrii Nakryiko wrote:
> Make libbpf adjust RINGBUF map size (rounding it up to closest power-of-2
> of page_size) more eagerly: during open phase when initializing the map
> and on explicit calls to bpf_map__set_max_entries().
> 
> Such approach allows user to check actual size of BPF ringbuf even
> before it's created in the kernel, but also it prevents various edge
> case scenarios where BPF ringbuf size can get out of sync with what it
> would be in kernel. One of them (reported in [0]) is during an attempt
> to pin/reuse BPF ringbuf.
> 
> Move adjust_ringbuf_sz() helper closer to its first actual use. The
> implementation of the helper is unchanged.
> 
>    [0] Closes: https://github.com/libbpf/libbpf/issue/530

The link is not accessible. https://github.com/libbpf/libbpf/pull/530
is accessible.

> 
> Fixes: 0087a681fa8c ("libbpf: Automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/lib/bpf/libbpf.c | 77 +++++++++++++++++++++++-------------------
>   1 file changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 68da1aca406c..2767d1897b4f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2320,6 +2320,37 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
>   	return 0;
>   }
>   
> +static size_t adjust_ringbuf_sz(size_t sz)
> +{
> +	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
> +	__u32 mul;
> +
> +	/* if user forgot to set any size, make sure they see error */
> +	if (sz == 0)
> +		return 0;
> +	/* Kernel expects BPF_MAP_TYPE_RINGBUF's max_entries to be
> +	 * a power-of-2 multiple of kernel's page size. If user diligently
> +	 * satisified these conditions, pass the size through.
> +	 */
> +	if ((sz % page_sz) == 0 && is_pow_of_2(sz / page_sz))
> +		return sz;
> +
> +	/* Otherwise find closest (page_sz * power_of_2) product bigger than
> +	 * user-set size to satisfy both user size request and kernel
> +	 * requirements and substitute correct max_entries for map creation.
> +	 */
> +	for (mul = 1; mul <= UINT_MAX / page_sz; mul <<= 1) {
> +		if (mul * page_sz > sz)
> +			return mul * page_sz;
> +	}
> +
> +	/* if it's impossible to satisfy the conditions (i.e., user size is
> +	 * very close to UINT_MAX but is not a power-of-2 multiple of
> +	 * page_size) then just return original size and let kernel reject it
> +	 */
> +	return sz;
> +}
> +
>   static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def)
>   {
>   	map->def.type = def->map_type;
> @@ -2333,6 +2364,10 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
>   	map->btf_key_type_id = def->key_type_id;
>   	map->btf_value_type_id = def->value_type_id;
>   
> +	/* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
> +	if (map->def.type == BPF_MAP_TYPE_RINGBUF)
> +		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
> +
>   	if (def->parts & MAP_DEF_MAP_TYPE)
>   		pr_debug("map '%s': found type = %u.\n", map->name, def->map_type);
>   
> @@ -4306,9 +4341,15 @@ struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
>   
>   int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
>   {
> -	if (map->fd >= 0)
> +	if (map->obj->loaded)
>   		return libbpf_err(-EBUSY);

This change is not explained in the commit message. Could you explain
why this change? In libbpf.c, there are multiple places using map->f >= 
0, not sure whether there are any potential issues for those cases or not.

> +
>   	map->def.max_entries = max_entries;
> +
> +	/* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
> +	if (map->def.type == BPF_MAP_TYPE_RINGBUF)
> +		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
> +
>   	return 0;
>   }
>   
[...]
