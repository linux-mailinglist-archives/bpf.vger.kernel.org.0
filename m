Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85233486109
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 08:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiAFHbQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 02:31:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235610AbiAFHbQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 02:31:16 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 205NANEF027292;
        Wed, 5 Jan 2022 23:31:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eCPl0OvZ8iBNiU5eL1Qi/rB4lbe2PX/jwCEzB69w8pA=;
 b=pxUB+59709ocbxgPRjKJijuwWOsEzXwUDbOHv/MGhI7fHHO9kV54N4Iaeyna0EfU9DN7
 Q9H4UVnFNsvrAuFYNWP359FG84/0yrnd8AHph91RZfa+GXZQbdN+wBfFjhM53BaxZrxC
 1j19U9SJWNzd7SiKa/VBfvlY5kdL666qC10= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ddmrssuyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jan 2022 23:31:12 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 23:31:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+SjImP7zrDAczdWeIPl0OcTJsixPZb22Hzf9V+dBCpUuz76/cWCn0woUbSOkGrZk43JmeU01GhXMGb0X9rg1Be5IvRCgLbzvKCGa5MtWDVPxQ5mkAFK4Go6mADyidJdJAVJ+lXFk2gF2YYsy7mDByM0jpHb3XLYbJkfGA7HfYG5cGWhREOIFAW2T69/88juhtH7FzSvIAD0L/FAV3OAvlrSSZk1JSotYej/OOyRApLDchmEIZ3DiIDabt5hAp4jXoLIo/OQ5AQryHXB6xl4EpAalg6e1KfkfcY/lkMZhDYS8BKUI1/d0Q9na8Yv1spemUrstYmrRpSXy3+IMWZeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCPl0OvZ8iBNiU5eL1Qi/rB4lbe2PX/jwCEzB69w8pA=;
 b=kuafm7EqEdhm5r2usuzpXY9rUvPz/tHJXGhknBDkI+BmrPfxhdwGo9v52BAye1Lz5y1BHirLPRcxN5K+TrjrWv5zf3mBCxdbZRrr6yS+VLl95h6eIZgSUxc3xYRTG2RHMrNyUTbJvHZM/m6MaIyhOBWvI5qrdUFSudTt4SQRxR8Kob2r3uqpCf3WsI/fzxms93cbLRIBkNULIqEqMZHcOafHlxqUskwwlEWPbPeMTYj16kVc7ORLGyeyAGQuIPqEmmXyKtCESfHobZ9zAuEAN2eCJhxY3lIeiRGnJvUkZfoaXZsJDblby02Fp3UKDi6megciUbYO5kAmx9nOptVj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4641.namprd15.prod.outlook.com (2603:10b6:806:19c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 07:31:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 07:31:09 +0000
Message-ID: <1d736358-bedb-ad4e-cda3-73953d37189e@fb.com>
Date:   Wed, 5 Jan 2022 23:31:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next v2] libbpf: Add documentation for bpf_map batch
 operations
Content-Language: en-US
To:     grantseltzer <grantseltzer@gmail.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>
References: <20211225203717.35718-1-grantseltzer@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211225203717.35718-1-grantseltzer@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d196138-8da0-459c-8f1f-08d9d0e68236
X-MS-TrafficTypeDiagnostic: SA1PR15MB4641:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB464173E4845DB5119C0187E0D34C9@SA1PR15MB4641.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RT0lZ8a1GEdNHkMakfaWP9efpTCI03G/a2104p5NhzARP4F4yejh6T9i6y3dRXMFhAMJEZyBt9g90i0NM0a0lEYvZ7BL674zGr9RId091OlU955EqVZHRuNUR4vM2DeeY0hYwFJCwd7grq8Hx/vi8mD9mTnxdn0dFlPJA3pDMo6uxuhfEnumhV0UWOwiIEVo1MghHV+8ve6Bd2yOqrf2bEvgt7JDcXUSdTXaVIt1oCxzqfzJVmf1rvcpHz9YMRjUVo85o69WPp19Wh584JTsw+PuuK9mNFXaCTKXRWseL1iD3ejFIe70xZYrKC5R+bnzalGxlaXOktYSoiy9kxpluOBiTKdbY/+m6BeYOipxRy9iUEQ4UACmv0azSBqfGgM//j9bpLCCSoWWBAAPgQBEn+JlQFhX3RYov74UqYWVzh3YuHwGBdCqBgqFRGCdrhpLTj6XH7Qs5eiCqAR/mtQB62RXPUCfakRdcOi0U59Ccg3V04WW7qrciqz/pi62vsXtmAvOK0Vd46njx7IKDwZz91bEkJufF+2XTlXMVszk86Tg2P4WHTlqzC6HPETzdUk0AjSp2gO+IsMYjNBaxT2kCyF8gv+fS2ea+P2gEJ6oZrcMRCz0Po24tVxwqLFxk3XPMgIufD+Rn6nF1Kelp1drRYlTBqBhWp/3fhxeqnvGSm0bTeQgld+mGIExnsght8dY9WGnWRmNysj79j98FjvXutA13Pg8doYkn15hQSKlkGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(31686004)(86362001)(508600001)(8676002)(6486002)(6512007)(36756003)(31696002)(8936002)(53546011)(2906002)(83380400001)(4326008)(66556008)(66476007)(186003)(6506007)(2616005)(38100700002)(5660300002)(6666004)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzJ0SWlvZG1RNjVrU2x4eC82V0ZwbFZoODE3MDV3ZVJvWUljQWVsK2FFaUtN?=
 =?utf-8?B?N2tnSkVOa0ZWK2lESDE5eGl5ajhuNjRTYXMwN2lmUHA3Z0M0QmVEUVY4T0ZF?=
 =?utf-8?B?OEphN0hYYU0rTlhDVVpod2RNMEk2dnNPdlVKSlQ2MGx3SmREOVN6YU5wcHB6?=
 =?utf-8?B?SFpEZXBEcDJpMkJzaklXNWVNWDdjM0JPcU1CMmt1b2tZaCtzWHJpVE5SUXd5?=
 =?utf-8?B?K3dacnNoSDkvZ0ZlblVYb0VTZ3d1a25pWEs2QStKUnBlK3FXYTZSa3p0bkM5?=
 =?utf-8?B?L3B6ZlBLbjJBNmxlUkxWVWlRT2xnTHIwMFhkVmFRRG1tZ0o3ejdPMWZ1LzVL?=
 =?utf-8?B?aTFYbXo1bGpDa3U0VEVobUdkK0N4OHhZYnNQSGlwOXM0NXFYdnQ3d0JMSjBP?=
 =?utf-8?B?cFB1TnBBTkdNenYxMVZra0tGMDV6dVgwTngraDJ0YTVsV2VuWVMwclpCUHN5?=
 =?utf-8?B?RUlacS84Szc4S0FrVmNUMU1MRTZEck1OSnJqNi9tUjNNVVRIeU9EaTBDaVIy?=
 =?utf-8?B?VlZQcWl3VlFrSmMzOVZVaDI1Mkt4TTNKc1hFdWt5QjVGT2RHa2NuK3B2SFVH?=
 =?utf-8?B?UHRreUNpWEVsaGQzWnkyWm5hWlpPdmo2Vmg3bCsxQ1MwLzN2aDd5THpPNDRn?=
 =?utf-8?B?Z21CQ21qd0YzeEZTNVkwVDlXeVU2MWN4dER2bTNhQ2I5OGlxRmh1RFBmV1A1?=
 =?utf-8?B?QVpmOGwxWUFCYzBGQXRvUGJvbHU5Q3dvZFpQakl2WWJJYloxTEt1TmRuU3c5?=
 =?utf-8?B?eGUxUFRzRDJqMnNJaG1YZktpMHQ2cTlMcnNuR0ZtdHVvTUVZUFBUMk1IMEhI?=
 =?utf-8?B?M3VNaUl3eDYzSmNtdWxTZ2xrcW9HdjI4R1hua0hLcVVaV215NFpraHhYVVdy?=
 =?utf-8?B?QjFubHl0d0ZEZndLdlpMa3ZsSnRibmdVdXgxeW5URU5EZkVkWlB5S1BVZU9Z?=
 =?utf-8?B?bUY0d2pkenU0RXhTaU1mN256SlFrNXh5TUZ1Mk8wTHgyRUtSSDl3dCtaUTg2?=
 =?utf-8?B?NXpkSmlEdUpXUHFzZFltOENmTnI1YWozcmxBZ1VPajk1WTF3SVVRTTl1Znhh?=
 =?utf-8?B?ejRWN2NjdzN5MWJkSjBaWkxCd2hhdWRQd1VSQjArc3BPNGgrKzVFUk5TL3Rz?=
 =?utf-8?B?bFJLQkFseERIbk43YVRJakU1ei9pZ2VqakFNdzBTeUM2emZ6bnRFZWgrOE9K?=
 =?utf-8?B?NjJrZGlrSVZaNmlNZmhuVEVYcjdNcUNkc0ovMXJVNTJQN29WbWVXSWYrc1VS?=
 =?utf-8?B?Z3l4MGlwYjkvZzJRMWtSekZQQTgrVTMwK3kxUFR5V21vZFEwWmZuQ1EwakZw?=
 =?utf-8?B?OUpGdC9IN0M3TGZsV0t4dWtyK3JwUzRBVXhobExjT3k4c0Z6UFlRTWdEOW5Y?=
 =?utf-8?B?ZDFPK2hzLytVZHhMMXdTdWFoUUw2cVlwM1RKRU9yclpBdjJ1U2J4UHRlTFNy?=
 =?utf-8?B?d00yOXFsNzE1TGg5SnMvZ1J6QzhLOWtPUkhhMndwN3hnMmJDbERFb29pQ1Z2?=
 =?utf-8?B?NlBIeE5menp5TW5BQzZZRGdKQ1BrT1VpVWhRZjRTT1JKaU05OFFGbTJlZzlB?=
 =?utf-8?B?c1krMEZSZXQvNE1JZVdLNGM5QzN1U1Vrbk1kM2I1TnFPRmV5MURVUkJ6OE5u?=
 =?utf-8?B?Zmk2OGxyZ3NWcTgxVUhkWmlocE1uQ2piRjE5U1pSMG9uSHl0bVlFQmlDaGtF?=
 =?utf-8?B?bXBielJpSHpYWGlCUEVvWUI5YUJiTHpyRUNIU3VEbXRMR3cwZEUyN2l4TmI2?=
 =?utf-8?B?UCtMb2xveklxbDhQREFRYXp5S2psR2lHNGZmUnpISEhiWTVsNmlmM3g1T0Ur?=
 =?utf-8?B?SlZnNDI4YVlFVVNwRnlHMDVjcWtjRHFyZG1YYXhUbUhGZ3A1ckQ4K3paNFBJ?=
 =?utf-8?B?SnhDNmhaRXloU1p2S0dOWGkrSnlRVDdib1JlTVJRYVU2R0FqRnV6WjN0ZGs1?=
 =?utf-8?B?U0FrNi9uZmdVMWlUdGhhTzZtajFoZ0JLUG9HcUNhUGkweGtxZUhzemdkVEo4?=
 =?utf-8?B?TXlydUV0Ynk3bm1GekF6U2haTDVwRkYyNzAzeWhwT29ZYTVodnhwV3YrVGZ2?=
 =?utf-8?B?NmxKNWloSWJNajJ1UGRIaWkyL1ZpSkdYbVZnd2lGWFdBQXU1bWUvZU1sSXFt?=
 =?utf-8?Q?eJaX+P5noA0Fh8BaG+RM7LhPd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d196138-8da0-459c-8f1f-08d9d0e68236
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 07:31:09.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lllRl2Ye9SMmv7l4OMpcolTfsGTz/wKp32jqfn57gA+nYdCTaT83+HkY1uptg2Nn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4641
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: jUhlqTKnXnwxm6MsUgso-f04v3HuRdqr
X-Proofpoint-ORIG-GUID: jUhlqTKnXnwxm6MsUgso-f04v3HuRdqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_02,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060050
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/25/21 12:37 PM, grantseltzer wrote:
> From: Grant Seltzer <grantseltzer@gmail.com>
> 
> This adds documentation for:
> 
> - bpf_map_delete_batch()
> - bpf_map_lookup_batch()
> - bpf_map_lookup_and_delete_batch()
> - bpf_map_update_batch()
> 
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>   tools/lib/bpf/bpf.c |   4 +-
>   tools/lib/bpf/bpf.h | 112 +++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9b64eed2b003..25f3d6f85fe5 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -691,7 +691,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>   	return libbpf_err_errno(ret);
>   }
>   
> -int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
> +int bpf_map_delete_batch(int fd, const void *keys, __u32 *count,
>   			 const struct bpf_map_batch_opts *opts)
>   {
>   	return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
> @@ -715,7 +715,7 @@ int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
>   				    count, opts);
>   }
>   
> -int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
> +int bpf_map_update_batch(int fd, const void *keys, const void *values, __u32 *count,
>   			 const struct bpf_map_batch_opts *opts)
>   {
>   	return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH, fd, NULL, NULL,
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 00619f64a040..01011747f127 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -254,20 +254,128 @@ struct bpf_map_batch_opts {
>   };
>   #define bpf_map_batch_opts__last_field flags
>   
> -LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
> +
> +/**
> + * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
> + * elements in a BPF map.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys pointer to an array of *count* keys
> + * @param count number of elements in the map to sequentially delete

Here, "count" is an input/output parameter. We can describe its output
semantics like below.

When on output, if an error returns, **count** represents the number of
deleted elements if the output **count** value is not equal to the
input **count** value and if the error code is not EFAULT.

> + * @param opts options for configuring the way the batch deletion works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
> +LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
>   				    __u32 *count,
>   				    const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_batch()** allows for batch lookup of BPF map elements.
> + *
> + * The parameter *in_batch* is the address of the first element in the batch to read.
> + * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
> + * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to indicate
> + * that the batched lookup starts from the beginning of the map.
> + *
> + * The *keys* and *values* are output parameters which must point to memory large enough to
> + * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
> + * buffer must be of *key_size* * *count*. The *values* buffer must be of
> + * *value_size* * *count*.
> + *
> + * @param fd BPF map file descriptor
> + * @param in_batch address of the first element in batch to read, can pass NULL to
> + * indicate that the batched lookup starts from the beginning of the map.
> + * @param out_batch output parameter that should be passed to next call as *in_batch*
> + * @param keys pointer to an array large enough for *count* keys
> + * @param values pointer to an array large enough for *count* values
> + * @param count number of elements in the map to read in batch. If ENOENT is
> + * returned, count will be set as the number of elements that were read before
> + * running out of entries in the map
> + * @param opts options for configuring the way the batch lookup works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
>   LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
>   				    void *keys, void *values, __u32 *count,
>   				    const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_and_delete_batch()** allows for batch lookup and deletion
> + * of BPF map elements where each element is deleted after being retrieved.
> + *
> + * Note that *count* is an input and output parameter, where on output it
> + * represents how many elements were successfully deleted. Also note that if
> + * **EFAULT** is returned up to *count* elements may have been deleted without

if an non-**EFAULT** error code is returned and if the output **count** 
value is not equal to the input **count** value, up to **count** 
elements may have been deleted.

This applies to the above bpf_map_lookup_batch as well.

> + * being returned via the *keys* and *values* output parameters. If **ENOENT**
> + * is returned then *count* will be set to the number of elements that were read
> + * before running out of entries in the map.
> + *
> + * @param fd BPF map file descriptor
> + * @param in_batch address of the first element in batch to read, can pass NULL to
> + * get address of the first element in *out_batch*
> + * @param out_batch output parameter that should be passed to next call as *in_batch*
> + * @param keys pointer to an array of *count* keys
> + * @param values pointer to an array large enough for *count* values
> + * @param count input and output parameter; on input it's the number of elements
> + * in the map to read and delete in batch; on output it represents number of elements
> + * that were successfully read and deleted
> + * If ENOENT is returned, count will be set as the number of elements that were
> + * read before running out of entries in the map
> + * @param opts options for configuring the way the batch lookup and delete works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
>   LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
>   					void *out_batch, void *keys,
>   					void *values, __u32 *count,
>   					const struct bpf_map_batch_opts *opts);
> -LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
> +
> +/**
> + * @brief **bpf_map_update_batch()** updates multiple elements in a map
> + * by specifying keys and their corresponding values.
> + *
> + * The *keys* and *values* parameters must point to memory large enough
> + * to hold *count* items based on the key and value size of the map.
> + *
> + * The *opts* parameter can be used to control how *bpf_map_update_batch()*
> + * should handle keys that either do or do not already exist in the map.
> + * In particular the *flags* parameter of *bpf_map_batch_opts* can be
> + * one of the following:
> + *
> + * Note that *count* is an input and output parameter, where on output it
> + * represents how many elements were successfully updated. Also note that if
> + * **EFAULT** then *count* should not be trusted to be correct.

The semantics of **count** here is similar to bpf_map_delete_batch() above.

When on output, if an error returns, **count** represents the number of
deleted elements if the output **count** value is not equal to the
input **count** value and if the error code is not EFAULT.

> + *
> + * **BPF_ANY**
> + *     Create new elements or update existing.
> + *
> + * **BPF_NOEXIST**
> + *    Create new elements only if they do not exist.
> + *
> + * **BPF_EXIST**
> + *    Update existing elements.
> + *
> + * **BPF_F_LOCK**
> + *    Update spin_lock-ed map elements. This must be
> + *    specified if the map value contains a spinlock.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys pointer to an array of *count* keys
> + * @param values pointer to an array of *count* values
> + * @param count input and output parameter; on input it's the number of elements
> + * in the map to update in batch; on output it represents the number of elements
> + * that were successfully updated. If EFAULT is returned, *count* should not
> + * be trusted to be correct.
> + * @param opts options for configuring the way the batch update works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
> +LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values,
>   				    __u32 *count,
>   				    const struct bpf_map_batch_opts *opts);
>   
> +
>   LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>   LIBBPF_API int bpf_obj_get(const char *pathname);
>   
