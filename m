Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCBA4F1C9C
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 23:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379467AbiDDV2D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 17:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380397AbiDDUBB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 16:01:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5430576
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 12:59:02 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234Hk0ud030624;
        Mon, 4 Apr 2022 12:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=s4Li5XCGk5bj9SiO8xywkgSLlOQbDQWzWEcZTii52vg=;
 b=F0Mm9KuX0Rkw3KJtdjIWV5kzImaQp+Wo47t93dQrRoWbxcXVZpdALvOEz7GFamrFPeRq
 qg+El5W4cQmjpqC8JlFqo9cNVIYU33R/LwUb9xXltFEyWJ+sTEI4676ZjCSAELffTpIT
 2nu/PzgMQL+QbAeZ8prR+gEJQOIkZ7jpc/g= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f82702tc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 12:58:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK/3zx+9sV7IFxuUMSLWJNE3ZEQPYK39Z7weSenmJom49f9gMEDuL+fRNHnyVYKyR4xbkYQcb65tmLVQQh580cSSy82o9Kh7qrXyAH9A9K0MZaFaeBFEi/8Xc1rgLGE5Y/OSMp037sIkY/LC2CdFi2sQqG4yQyWynrZsKSBUbjw6Dcin4u1hS/dZBKZbD5yUr5YuUcGYRWBAQ73Peada1E2Slng1uyohwJpcJqaesfJPVFnarO7qW4nCKR7MUucEUjFCl/oujjtP4uWshPOLtSMrOhRI/uIYkO2kYFVl7Dyr+wKjWsNC7f5Dp0XJ+0eRRA7aqHgJ1jtNFIP2KskARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4Li5XCGk5bj9SiO8xywkgSLlOQbDQWzWEcZTii52vg=;
 b=gmrn4oFZA35+xd4leYU1RO+CVj/6UsjPDNqJTvt20gGQL02M0Kwc2ePs+IH+6WWik7Jw0Dh1RNt8Zl8FPSFLEVnS5YnspyjB83+vkOM1pUf9u5FkkKHmU34HTTh8hiWSG6ucACSGbhmiHfCOrkuhd/FhNdHsrkwKJkk6U6FIpBcRz0vy5U0KUNlOwVmjL6Z4MQbBPzir4hkK2FAv5Pwlr95xJhRjDvQONnPs4EZMXOaEVJsbs0a/0eTwvW5F7gI4WfNMFt4pIM2wku/MGV9uLojZOYHEmPRk+RUqXReyaGyzN+8pZMsGwTUTM/GzDNao2Y/6Mm+Y1yz9fC3t2tuuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB2989.namprd15.prod.outlook.com (2603:10b6:208:ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 19:58:42 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%8]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 19:58:42 +0000
Message-ID: <37157072-3350-65b0-e0d5-222ace84ba8c@fb.com>
Date:   Mon, 4 Apr 2022 15:58:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 bpf-next 4/7] libbpf: wire up spec management and other
 arch-independent USDT logic
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220402002944.382019-1-andrii@kernel.org>
 <20220402002944.382019-5-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220402002944.382019-5-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d99bcb42-a659-4c9f-17dc-08da167584c4
X-MS-TrafficTypeDiagnostic: MN2PR15MB2989:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2989536AD9395D89F2C9A646A0E59@MN2PR15MB2989.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qK82s3FnjKPCEHImkaa+uS4clld+G+COxmept1QGWwEJMaREPDJHVa+jdS8gOdVLUkuGBtbIEuq7hdwzHO6MCqcINNBG+OxfUsklW0cDDb0A05iRBBTR+8uJc+gPL8x2NtEs+77/hQnm3EYo6pJN86g+9U90RennxmAYLlhVcvuiYBUX13Dexa1tz3MtekCmhhUui1EsZbQxc3E2vG6gZBZ3PwiTz5cM9eT25AKVtT6t6J1ZZc58tXihmO4l8Vp9sG/SPJUIjIs7K1ASv04oYOGUR93kenJPCUd4No4OO0LMfn/OR0o5px0thFA9Dj+tivc8p+XO7e22q3SCWnmA0C+4m/zjFKfwKM/eOBFzYgbBKE41U2nKvthPOTdQo1Hc4M7eoMg+yWgdOe4arS652woNujC5w+mvLOsSDeZsAljb+SbM4ZIs/GqE6O2zt7esphQh94O/b8qlMrEiqIXnzaS1yv2LnN/EgnavmGQWeMPr/3dIvcaPlkYqnhrnJOhrUvgx1rx7EhRidEtYZErOloYhsWqGP9hvGZBXY/ztEZw5KSmkrU0UrW1gEuHo/c7Ot0N0C19+QBJZJqwkVYmaGzEw0zWz8tlNoHESxplPqjoUu59FT0/mi3cP+MmRpLB0rWKcA8Epz/msSyMvsx21e4FFFrDFHcPIuvnVExQelVyMMIEjLh+BujnE8OzUaWsPCdWrmxBqIL9aPzYdFxRP9vjnXC6W3exxDvkSsLmRU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(6486002)(6506007)(53546011)(8676002)(508600001)(83380400001)(66946007)(2616005)(5660300002)(6512007)(66556008)(2906002)(4326008)(36756003)(31686004)(86362001)(8936002)(316002)(186003)(54906003)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXVIdkE0UGNKbFpXZGVvek1sWlA4TW5wZzNkZHQxR0ZTaEtLS0RhVlF3TUw3?=
 =?utf-8?B?V3kzbmRJc2JZRSs3a0lHT2k2QXFCSkFreW1wa3VMbDM3L1dqSWpoY3RHd2Y1?=
 =?utf-8?B?aUxDU2VzdVhrQnJEbHE0VjcwRS8yT1NFUllmc2drV0pTemFxT2pnZkpPZTB6?=
 =?utf-8?B?aXdSWlc4b1NFWEkvVFl3WnR4dld3a2lBdm5tRkNmMGtCUzJ0dGdaNW9ZdlZ4?=
 =?utf-8?B?dmlTbkNXOCtOZHhhdXV6TmkzWVppSmtRUHBueXBmdkg3QTM5cjhjR29RMVJq?=
 =?utf-8?B?R2w4TGx2blZmTVh5di9qZHZ5amgycWgwT0lPVHFkenNNQ3JTdnNRMkl1M1VI?=
 =?utf-8?B?ZmtXYStuMWlta21JdEtaNXFTVllzN01yM29TQnZSZmZFOU1nTkxkZG5YeDkv?=
 =?utf-8?B?aUl5aVEzdUtiU3puajBGR2I5YmcyalcvcXF3eHRQbVlKaFMzaytHcnlZK3hi?=
 =?utf-8?B?aFd4WW92ZGp1UU1zZjJCS3ZDMURGUVp0UGIyamNwL2grM1hDUE9DYnRpQXZr?=
 =?utf-8?B?R1g5UVBVNUUxdkRpb1NPZG8rQU9MZGVjWjZRZ210Mk5VYlI2R1R0aWh5TEJR?=
 =?utf-8?B?czl0em9HZHdzcmFzblhlMTZmWFJhcEsxdmdDSnhFdzlIL2t1WDJDcXpwU0Nu?=
 =?utf-8?B?aXppbHdFcDZFWGwxdFpKRVV3VTFhdUFnMDNNVERWN2xmRTFJU0lOc2xHaW9y?=
 =?utf-8?B?cG5zQjd6NHpTeTFkdjgvN1FQQU1XS0RJMkI4NTZjRlFUVHJsM0NlSmZUczNa?=
 =?utf-8?B?Y0RvaHNZNDc0YnV2RGJBVkt1WENKT2pUL2M4UWphYnFnQ0xoVWlKZGxOc1Iv?=
 =?utf-8?B?TDFRajZCOXoxUHZJeWtKejVtdENzQklvSnYxV2E4NW42U2QzYU5DcEJSSm9J?=
 =?utf-8?B?NG1ydnpaVmVCbnNhVDNsZW1UV29OOTNoSWJOM2VQeXp5Z2lBc0tyOEt0Y2V5?=
 =?utf-8?B?OUc0VzdmZk15VEtVRStVd1B5SUpmeUF0MEJOQ1p1NE5SbG83ZzhSUGZRVnli?=
 =?utf-8?B?ZHFDK3V0aWtmL1NJNFV0NExRUXNHOVdFTWZDcHg4OFo0Wm9rNExQSStqZFJ6?=
 =?utf-8?B?U1prM245TURFK3FNNjNWY0xTNVZ6SlVIK0dJNFFTYW5SS2VKZW1kQ3h5U0Zm?=
 =?utf-8?B?bllmOHA1b2tsM1lOK3ZxZTZoYTVNeVhWYzMyK2tkTmdkYm44YU5NTEkvWHJ6?=
 =?utf-8?B?ZENVQUE5eE56SDZmQlhTdHhLOStMNGVPV2puUlE3a3JWcHQzTllJMkFTcU5y?=
 =?utf-8?B?L0NXWHRUcGdBWHZFa3VmWFBhc3NMNFBPc1NqWkk5WTh3b0tsQ0YzZ0tUU3dU?=
 =?utf-8?B?VlJCSlNUS2FLblM3cGUrdWhjTzA4U2M3Z2FBNjdvTFg4cVNNeVc1ejNVODVV?=
 =?utf-8?B?czA5SVAyUlhyUUVwWTJCTXVCSlkrVUtOY2I1YUpNZ2Y4ME5PRWpRRXRqSzUz?=
 =?utf-8?B?cUhFTXdCUjF4UjJuTUhUQXlBWUprT1BSdTRJSitwelFrVkZuSlRFUDhtd1Uz?=
 =?utf-8?B?Zk9EVlEyRFUycjNUb0FkdjdndVNlYUdHUDlhL1NiV09EU2lqc1o4RThCSU55?=
 =?utf-8?B?aUxRWERPZk9PdmRVdytNRk1vVC9GTVp4bG83a1UwdVU1a3RCeG9nQXVWeXdW?=
 =?utf-8?B?UXliTjNrc2grSjFqQlI2OC9ESGxJTTJwMXZQUDNvOUpseW9ZckNzcmNYc2lZ?=
 =?utf-8?B?MHpGY2h4WFVyRUo5d0ZtdjdjYXVUTkp6MDYyM01NVDBoWFZpdHJQUXUwc09n?=
 =?utf-8?B?bngyQ1BZR3NYcUpDZ1l1dk1iVGZqWjNXNUdLa3ZXNzMzeUc4UDgrTUJmdWJt?=
 =?utf-8?B?ZTZDeWVJZlVMTERhVE5tcGlWVWlycy82OEs5aThiUHVGeEttNFNVTnlHeEp2?=
 =?utf-8?B?S1Q5aFJqMS9XN3ZRR24wQ3pkVUZKcEJnNTgxK1F6YVdCMnlvZ09KWG1PbC9i?=
 =?utf-8?B?WFE0UTNPcmJ6ZWNkVkFVZ1lFQ09uZ3R4U3VVZngrVWpBRU43L1JDTUZobVor?=
 =?utf-8?B?NEVzVVlicXBxcUR1ZXYvRmJsNGxZNEN4K2p3U2d1Vk56NTRrUWFSc1lJcWRF?=
 =?utf-8?B?VDgwQ0FXVFk5MW95SHA1RE02ZUZpZUFnUWU1bVNsL1M5RUtlMXAvMldKbUcv?=
 =?utf-8?B?WVdEV3ZmZ2F4emNCT3IzMDJFajY2dXVURUgvV1YxWjZzUVJEOGZxUitldEZz?=
 =?utf-8?B?TjNWVXJYOFVMZTVpOFovSWtmU09SU0pTYWszSTNyS3RPdkJ1cU1obUdZcWlx?=
 =?utf-8?B?eUJXazBEa2poM1BaakhqQUozdHM4RHArdGNhTlhFYmlGei9waVRvamIwSFoy?=
 =?utf-8?B?WHNzZWV0QzJRY0h6WjVNM2dmTHZrZjVTcGVZYVlLS3lWQ3pCek1hU05OVm1i?=
 =?utf-8?Q?fJz2zmScizMfhDv1vTte5G/8SJp0kqLeAIjMB?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99bcb42-a659-4c9f-17dc-08da167584c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 19:58:42.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbcr44l9mToPVTq8l31x7T7JJrtSTwUzD2Sa5oeRMr89j3bweH03WqOdW6eDPI5Ib59Ffq7s45s1ukyLxs3Gnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2989
X-Proofpoint-ORIG-GUID: AR__OvvtagZPVdQ6Hp4YW_uEg20NcP5x
X-Proofpoint-GUID: AR__OvvtagZPVdQ6Hp4YW_uEg20NcP5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/1/22 8:29 PM, Andrii Nakryiko wrote:   
> Last part of architecture-agnostic user-space USDT handling logic is to
> set up BPF spec and, optionally, IP-to-ID maps from user-space.
> usdt_manager performs a compact spec ID allocation to utilize
> fixed-sized BPF maps as efficiently as possible. We also use hashmap to
> deduplicate USDT arg spec strings and map identical strings to single
> USDT spec, minimizing the necessary BPF map size. usdt_manager supports
> arbitrary sequences of attachment and detachment, both of the same USDT
> and multiple different USDTs and internally maintains a free list of
> unused spec IDs. bpf_link_usdt's logic is extended with proper setup and
> teardown of this spec ID free list and supporting BPF maps.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/usdt.c | 168 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 1 deletion(-)

[...]

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index c9eff690e291..afbae742c081 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c

[...]

> +static size_t specs_hash_fn(const void *key, void *ctx)
> +{
> +	const char *s = key;
> +
> +	return str_hash(s);
> +}
> +
> +static bool specs_equal_fn(const void *key1, const void *key2, void *ctx)
> +{
> +	const char *s1 = key1;
> +	const char *s2 = key2;
> +
> +	return strcmp(s1, s2) == 0;
> +}

IIUC, you're not worried about diabolical strings in strcmp and str_hash here
because of sanity checking in parse_usdt_note?

Anyways,

Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
