Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716F547B93E
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 05:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhLUEyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 23:54:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9494 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhLUEyO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Dec 2021 23:54:14 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BL1pvsN008121;
        Mon, 20 Dec 2021 20:54:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=h5itWYlSLsqlFgS2c6+L+ubyiubJ9Mt7NwbmgQ1j/bQ=;
 b=p0iOMANWwQWPnX5nFtiqVHWvlhFWqZpUL6yGDh7XOz3Vcn71CNnfjLYwK4o6leOS1JY4
 fCwN/3DKYQOOERAxObdDsEKSHjoHMGyZYcxsS3hAxaUOvydlJT46rj2I4XSJvmQaHiUu
 e89ko8Q370IlMezg9ncvLuGW4sWO1qhAEqA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d35mu0t90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Dec 2021 20:54:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 20:54:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4SWH0THPuEGUuHvSvJX0wISgsx6SB6O/cfZt0li67bN3IP68rO+6Mk+MzVYJso+WxvjxjZn+jYWFdc/WScS2p7TplfInQkhlW/N5ZR7fyTObkhTUHF83SZ9kVmiCz3Ht07DC9mquGnEXyQjAKnjG5G3LWszJ/znDXFEbg/kBM1GmWnmsQbEjJtoa8QeFyhhDlIsGy/R8dQ68yh/yFVzCYaV7J3GsZkwRjOpz1QuNTwcKCcDxwkz7bz0zRS6NkGyqc1D4MgHic3XGwIhv0b7TgT2u6j+Oi3Irw1551lqSxaB8sU4JpgaFV96c+wTnirhDrMBQtZc62GvNvvAkm+IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5itWYlSLsqlFgS2c6+L+ubyiubJ9Mt7NwbmgQ1j/bQ=;
 b=Y5L0I4nO/FzFGkGZ71ciMAkpVQJ4K3LvsGhs/4q+DEOG1GY+aHOarnAc+5GuHAbZ9iMxhmwIoKq/Kg1ElmGGVJzsoVXe4STRQFaXqPDY6n6dEAGOZrvGLgdlU7yXhHVzWKP4SQB/UCN+9+BhTJp3yfTD52KejUJkIBE6it5R9IlWM0V2Zl0WQGfcTrL5NvsjfIfE9WSbNkK8CKQK3ypCh/WBtC+yrsLXE41ZSSmLixyMyOO6Allx0PVVqwgdUciKnJFyuq+f5znjkhEtfbZmun7J76MjjS/UGm6+cFCGVYQkxROp3WhPyqcZgMCPAKeQ2DPtsXb8yVXxXedkINYQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1965.namprd15.prod.outlook.com (2603:10b6:805:3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Tue, 21 Dec
 2021 04:54:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 04:54:07 +0000
Message-ID: <ad273039-ff34-74ec-acd1-321136f27285@fb.com>
Date:   Mon, 20 Dec 2021 20:54:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next] libbpf: Add documentation for bpf_map batch
 operations
Content-Language: en-US
To:     grantseltzer <grantseltzer@gmail.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>
References: <20211220054048.54845-1-grantseltzer@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211220054048.54845-1-grantseltzer@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05eb1f01-0da2-4061-d439-08d9c43deb83
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1965:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB1965B00ABE292F01A0C46839D37C9@SN6PR1501MB1965.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjrm2GLJEI2jHeS4bbnHfjd/El7FMVk5FbqAO9dk2LexRDVLndkLzZZqjSNOAtqbv2x40ZGclS8Vr/zjGsi9FOtPw8zND8pq4BIexdg0Yv4MCCyWp42DrQ20xlWTpg4b/ppwgfhPQRJVABtY+uKW76az4c12y+kaH2vZLGZQe7J2lcukLhCANT5guL5ISeUBqQFLdleSowCor8+WmvYZoD6qU9pR9/PUJ2Wpu2dM4bDeOYbOvawg9uTMsSEPm/74kutFvUSp9yTlaR07KjhkTSPOyKxVPPdb5WrJ0uPJVpQDUAPAS/KqAVlGSGMszPuSmJTIVXS1RItCx2QGeVBJasIzSX+TnsbVbQi0rMQPIn/uOCD/20ekIm+ARz1Wv2DwxpPbiOzND/Ap5ma0D27DrQ8RMeF99EXnfq621ICl4z1/OJVqy+LV9YYMTHQBtNBMTYtkblDdclqALQ7lDDLDkXEnmCQR/6P1k+/SunQpLY9jdQDM6cCgxBsqFplIe+EDC+mBydbB8YaWGv0sJ4VVlta+3C0kicUbmUIyeRJKtFV/ICUO6EiF0aqHOdjuERRqyLG/5T4QPkScu5XoWdmnaZ+l7QiVVyEyaKt1xJyr5A/VSaVzxZ5HU0LVNiQdwyXfkQ4IjQuUWjJAh6iQjVkSI0yVsaF+re4NCNPeIpra3KMM6pBd6qCh0kR021pWvAgLzJekbflT+yvTqUwgH1uaUx1KD8lJ9VReEjR/10WNO4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(186003)(4326008)(508600001)(2616005)(2906002)(6506007)(6486002)(31686004)(5660300002)(8676002)(6512007)(38100700002)(53546011)(52116002)(66946007)(36756003)(66556008)(66476007)(316002)(31696002)(6666004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ays0dXBCVGhGTk5YM25KSitPek1QQ0dOTlJXU0NRSVl2Z29iWldleURObm1j?=
 =?utf-8?B?NXRScEhlZlF3ZkNRRXRkbHVQSVd6TzhXYmZWUjRtQldBNDVyaDNXLzVqRFFD?=
 =?utf-8?B?L3R0d2QzTFNmbG8xR1JZWjluNE9ZN25wNkloMGk3STdWZUV2eFFIdXhraXBX?=
 =?utf-8?B?blJoRVpLVW5sWnBqR2xndDBuNUdXRWNaejYvMVdyZk5BVmppek1nRkZrZkhx?=
 =?utf-8?B?bTdBR0VTcGlLdlcrOGxWcGswQU5RNitVNjVTN0NuaDAyZU1pWkYvbXpqN0JD?=
 =?utf-8?B?TFFNQ093NWk3ZGxBbTB4SUw3QXJSVUN6MnJBb0xobzYzQi9HVlZXaVFWNzBV?=
 =?utf-8?B?UmhVNG9rZlVteXU4aHQvN21QTTdrcHd0bzBWZ1N1c1NXUVBmVHdkc3NHZGp4?=
 =?utf-8?B?Rnk2N2dTWkhQbGptU1p5aGE3S09FZnJNRFdWdmljN0w1KzNpTGZHUDhZTFRw?=
 =?utf-8?B?YnU0UE5ERSs3ekxyMHhpbnBWRDl6UzdFUUhUamF5UXpybVhkMFdScUJOR1lE?=
 =?utf-8?B?cytuL2wwQ0VMekhzbVdrMnNoYjh5YlVMRHdUUEIwNzhicWFCMFBpUnRmaXVD?=
 =?utf-8?B?b0NKNlRCRVFWR2tnSkxpMzVkTXA1cDBzSFJHN0g2TjkwY3ZwRVVVNXFQaTBz?=
 =?utf-8?B?c3lvRjBYdW54Y1dxUGNyYTMrZUR3M1Y2OUtXTjRvemxDMFl3Qm4wWldUR21J?=
 =?utf-8?B?YnZ2dGpIS0hNc0pXRmoyYkM3NGRSZXVOZHpObDRhSDBvZWVwWFF0eUNlMWNV?=
 =?utf-8?B?QWZkaDYvbnlDRE96Z0xjQU40U0ZqWmpUVkhzTVRPSVg4SXgxL3lOZm9GaWZo?=
 =?utf-8?B?MWtjQXZLRzgrTXlFVmdPeGxlZlVwbExVTDdWdkw1NWNWVCtyNFYxMHQzR0Vy?=
 =?utf-8?B?OXQxMThMN21UU0xTRFFUaFIzUU52SVJGYzNlQ3ZaaldsYnB1a3NYUFpKK09a?=
 =?utf-8?B?U1VNSzlPNDlSREFWOHBiUjZ0WWYyUkJJcyswbEtwUHFIc3Q4a1FNc2pFdyti?=
 =?utf-8?B?U3QzaTNuSUVrZS9TTFhLbUFXMXQ5MktYZUpWNDZ1U056Z2p1YndkWmVIZGFM?=
 =?utf-8?B?dllNSlZKcW1sMkoxLzh5R1dLRG8yQllPTk5lNTlYYTUvSVE0VW5xQTJJa250?=
 =?utf-8?B?YkUxcnl1SFgzajl3RWxtaUFQZ3ZydXRFMWNlTHhnQWJaWGhvOVcvNlBudTNH?=
 =?utf-8?B?OFpaMFVWWlVWUmZnS0tIdUpzVkdvdDBhdmFFdnBHTXFXdW5xVDhQMXVPTW0z?=
 =?utf-8?B?S1NNYjJsZk5HT0ZIOFQzMjdFSExNRWMvMG1vOHp4b3RLOEdlOXBZTmUyaVlj?=
 =?utf-8?B?bllkaFRlWit3VWZidGwzRHZUWEJrM2NQQUcwd2ViSDhPNm1VS1VrNW85Mytv?=
 =?utf-8?B?cHNjQ3BJWDVPRnQrcm9MbTZwd0E5TFQ5TWs1VmpFMUFEU3RUU2NTdnFobi9j?=
 =?utf-8?B?TTlmZ1Q4SFM2a0k0aU5zcGt1RWVjMUVGbVR1V3ByMDRONnAxTXkvZ09CTHdY?=
 =?utf-8?B?MEJTVXdYM2lWdlhzT3N5VW5ZZDZNTWpQSHNETi9xREJRa2poK1dnWENZQVN1?=
 =?utf-8?B?UDNFY2J6R2gzVThMcFk3bkc5SXpSa3NMZTFsQndiR2E1d2NpbU1aTlJsZjMy?=
 =?utf-8?B?L2RQa3NZbGNYNGdGUTJmSnY4TjBkUnoraFF1aURrbG54QXFRbDlDdXNDRUV2?=
 =?utf-8?B?MnRnTTZvWE5ONFNmOTBmL0xMblBNRkxqY3Z0c3pxdy91SlIvZkRxRVNTMG1G?=
 =?utf-8?B?bXFkTy9VdDFFRml0bE9relZ0NHRLZTJUN1N6dnFGZk5zc0JzK2dYbmJSclJw?=
 =?utf-8?B?TWRjM1VmZERacm1hN0tJU3o1dG9hL2hDVjFXK2xONVV0YXlFWmg0ajFFYUU0?=
 =?utf-8?B?Y0V6Y0Rrd0RMV1B1YmgvS1lzdDdWdHhWV0JxVk1WdFFXNXN6T2JpcWFsdlk5?=
 =?utf-8?B?NEpUNGdoY2M0YmtURTlORzRpTmJ4c1lFakJQUi9pYmNmcjV4OUhyOXpkSkZL?=
 =?utf-8?B?anFtdEdCcEI0dFV0VnBWaWNaZkVMM3YrNzA3MVVlNXYxQ1RkZWJCY0JSQVli?=
 =?utf-8?B?TmkrYXMxSVRaV3dNbmtDTlNWTGZoZllaWXlpWUdMM2h6Q1JteTVvbmZ0MTla?=
 =?utf-8?Q?VGMYA7sB7IQh8+lXg6z8tcpmO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05eb1f01-0da2-4061-d439-08d9c43deb83
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 04:54:07.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcxHkWDTagY9kOplP7CuUmjBsvIvvOOfn0+5LGZ7DghLsKLFYGBUzimZaRc9cuUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1965
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: U42u2JuH4nECNPuRPPiK9kXdfTs4qlRE
X-Proofpoint-ORIG-GUID: U42u2JuH4nECNPuRPPiK9kXdfTs4qlRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_01,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/19/21 9:40 PM, grantseltzer wrote:
> From: Grant Seltzer <grantseltzer@gmail.com>
> 
> This adds documention for:
> 
> - bpf_map_delete_batch()
> - bpf_map_lookup_batch()
> - bpf_map_lookup_and_delete_batch()
> - bpf_map_update_batch()
> 
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>   tools/lib/bpf/bpf.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 93 insertions(+)
> 
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 00619f64a040..b1a2ac9ca9c7 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -254,20 +254,113 @@ struct bpf_map_batch_opts {
>   };
>   #define bpf_map_batch_opts__last_field flags
>   
> +
> +/**
> + * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
> + * elements in a BPF map.
> + *
> + * The parameter *keys* points to a memory address large enough to hold
> + * *count* keys of elements in the map *fd*.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys memory address large enough to hold *count* * *key_size*
> + * @param count number of elements in the map to sequentially delete
> + * @param opts options for configuring the way the batch deletion works
> + * @return  int error code, 0 if no error (errno is also set to error)
> + */
>   LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
>   				    __u32 *count,
>   				    const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_batch()** allows for iteration of BPF map elements.

"for iteration" => "for batch lookup"

> + *
> + * The parameter *in_batch* is the address of the first element in the batch to read.
> + * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
> + * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to set
> + * *out_batch* as the first element of the map.

NULL can be passed for *in_batch* to indicate that the batched lookup 
starts from the beginning of the map.

> + *
> + * The *keys* and *values* are output parameters which must point to memory large enough to
> + * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
> + * buffer must be of *key_size* * *count*. The *values* buffer must be of
> + * *value_size* * *count*.
> + *
> + * @param fd BPF map file descriptor
> + * @param in_batch address of the first element in batch to read, can pass NULL to
> + * get address of the first element in *out_batch*

can pass NULL to indicate that the batched lookup starts from the 
beginning of the map.

> + * @param out_batch output parameter that should be passed to next call as *in_batch*
> + * @param keys memory address large enough to hold *count* * *key_size*
> + * @param values memory address large enough to hold *count* * *value_size*
> + * @param count number of elements in the map to read in batch

count is an input/output parameter. It may return the actual number of 
lookup elements if it returns 0 or return ENOENT. Please take a look at
selftest map_tests/htab_map_batch_ops.c for a usage of the function.

> + * @param opts options for configuring the way the batch lookup works
> + * @return int error code, 0 if no error (errno is also set to error)
> + */
>   LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
>   				    void *keys, void *values, __u32 *count,
>   				    const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_and_delete_batch()** allows for iteration of BPF map
> + * elements where each element is deleted after being retrieved.

"for iteration" => "for batch lookup and delete"?

> + *
> + * Note that *count* is an input and output parameter, where on output it
> + * represents how many elements were succesfully deleted. Also note that if

successfully

> + * **EFAULT** is returned up to *count* elements may have been deleted without
> + * being returned via the *keys* and *values* output parameters.

Okay, I see you mention *count* as input/output here. Again ENOENT might 
need to be handled specially.

> + *
> + * @param fd BPF map file descriptor
> + * @param in_batch address of the first element in batch to read, can pass NULL to
> + * get address of the first element in *out_batch*
> + * @param out_batch output parameter that should be passed to next call as *in_batch*
> + * @param keys memory address large enough to hold *count* * *key_size*
> + * @param values memory address large enough to hold *count* * *value_size*
> + * @param count number of elements in the map to read and delete in batch
> + * @param opts options for configuring the way the batch lookup and delete works
> + * @return int error code, 0 if no error (errno is also set to error)
> + * See note on EFAULT.
> + */
>   LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
>   					void *out_batch, void *keys,
>   					void *values, __u32 *count,
>   					const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_update_batch()** updates multiple elements in a map
> + * by specifiying keys and their corresponding values.

specifying

> + *
> + * The *keys* and *values* paremeters must point to memory large enough

parameters

> + * to hold *count* items based on the key and value size of the map.
> + *
> + * The *opts* parameter can be used to control how *bpf_map_update_batch()*
> + * should handle keys that either do or do not already exist in the map.
> + * In particular the *flags* field of *bpf_map_batch_opts* can be
> + * one of the following:
> + *
> + * **BPF_ANY**
> + * 	Create new elements or update a existing elements.
> + *
> + * **BPF_NOEXIST**
> + * 	Create new elements only if they do not exist.
> + *
> + * **BPF_EXIST**
> + * 	Update existing elements.
> + *
> + * **BPF_F_LOCK**
> + * 	Update spin_lock-ed map elements. This must be
> + * 	specified if the map value contains a spinlock.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys memory address large enough to hold *count* * *key_size*
> + * @param values memory address large enough to hold *count* * *value_size*
> + * @param count number of elements in the map to update in batch

Again, count is an input/output parameter. Here ENOENT is not involved.
As you mentioned in the above, if error code is EFAULT, return count 
value cannot be trusted. Otherwise, it should tell how many have been
successfully updated.

> + * @param opts options for configuring the way the batch update works
> + * @return int error code, 0 if no error (errno is also set to error)
> + */
>   LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
>   				    __u32 *count,
>   				    const struct bpf_map_batch_opts *opts);
>   
> +
>   LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>   LIBBPF_API int bpf_obj_get(const char *pathname);
>   
