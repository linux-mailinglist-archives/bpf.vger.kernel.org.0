Return-Path: <bpf+bounces-22463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B185EB20
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3247D1F290F7
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3511292C7;
	Wed, 21 Feb 2024 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="g8BwUVvA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BA128819
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551509; cv=none; b=Kc4NeK6s/wyF+eywji0XclpiXnkmVXxVYzA8rJ4L7qOPKv0/cf83T8wqaK+Ahc02x/i1cRSzm57s1aR7zjQ2FLdIZU3cl29lXXx3jvjY9d3GymsJiS2e04bQ4JBwUA4+cWxnWUhy/+vViI0Asngf9NUxB74exty4+wUvV52QuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551509; c=relaxed/simple;
	bh=9INDsH3Gr+BHUOta8ArL20o+PQJV9ABIr/RusbSi2Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GW39We9mazLSeYXK2kcC+qaE7rrYrBExbKTWCdOfYvQttMrsPhYjcQdDDmG/vnK7jFKlsg4sH2hw4MS9jCDjH+1NjOpslupp69N4lCxL8WrHHGQ8Yw1IbEBn3d7jNceNT0Ma0T/KhgzUB7Odn6mXMdBX3iJ2nz/VlvHE+R9A9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=g8BwUVvA; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LJib3o025162;
	Wed, 21 Feb 2024 21:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=DmAc+CiXAKykXOZCpNKZALIPw/U1IXDb7vTLU5k8Ztc=; b=g8BwUVvAl5AU
	UOXUnZS7r34OuQOOFv6vFqebe9/FJLoERbQUFXnjZkdKLc49Uj1avGCSls/D17bp
	rASF1UPP5fa8jPXwNpZMzn5Wco8ZjKsNA/O6NiC/G66szEbklqC6V9GtRGtoxxap
	Ne3ASoaApJ6Yc0REDBUOYmEMPpTqgEneZE0rqOG8VGnq8EwBsEtIN4O31JPk9bCf
	c7kEWtSC6rm+28c+ACuk6+vqyUiT8nkZo6yg7hG/qPUf/gkMos4P7MdEYDQH029I
	LHkcnZiht78JpQmZlXcQkSnFMZRMr2gEHzHcUYSC6FWGNZth2Sxh6v+SV/g42EFa
	WcDtVUTbzg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3wdgqjh9yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 21:38:06 +0000 (GMT)
Received: from [10.82.58.119] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 21 Feb
 2024 21:38:04 +0000
Message-ID: <a382f71d-3677-4545-a4e2-4e93f0ae3864@crowdstrike.com>
Date: Wed, 21 Feb 2024 13:38:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: clarify batch lookup semantics
Content-Language: en-US
To: <bpf@vger.kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>
References: <20240221211838.1241578-1-martin.kelly@crowdstrike.com>
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <20240221211838.1241578-1-martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: 04wpexch04.crowdstrike.sys (10.100.11.94) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: en4sNxEgqgeTIS03nbNkhho4HjwGU9a8
X-Proofpoint-GUID: en4sNxEgqgeTIS03nbNkhho4HjwGU9a8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=860 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210169

On 2/21/24 13:18, Martin Kelly wrote:
> The batch lookup and lookup_and_delete APIs have two parameters,
> in_batch and out_batch, to facilitate iterative
> lookup/lookup_and_deletion operations for supported maps. Except NULL
> for in_batch at the start of these two batch operations, both parameters
> need to point to memory equal or larger than the respective map key
> size, except for various hashmaps (hash, percpu_hash, lru_hash,
> lru_percpu_hash) where the in_batch/out_batch memory size should be
> at least 4 bytes.
>
> Document these semantics to clarify the API.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>   include/uapi/linux/bpf.h       |  6 +++++-
>   tools/include/uapi/linux/bpf.h |  6 +++++-
>   tools/lib/bpf/bpf.h            | 17 ++++++++++++-----
>   3 files changed, 22 insertions(+), 7 deletions(-)

Yonghong, looks like I missed your comment to change from "clarify batch 
lookup semantics" to "Clarify batch lookup/lookup_and_delete semantics"; 
sorry about that. Feel free to change it if you merge this, or I can 
include it in a v3 if needed.

>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d96708380e52..d2e6c5fcec01 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -617,7 +617,11 @@ union bpf_iter_link_info {
>    *		to NULL to begin the batched operation. After each subsequent
>    *		**BPF_MAP_LOOKUP_BATCH**, the caller should pass the resultant
>    *		*out_batch* as the *in_batch* for the next operation to
> - *		continue iteration from the current point.
> + *		continue iteration from the current point. Both *in_batch* and
> + *		*out_batch* must point to memory large enough to hold a key,
> + *		except for maps of type **BPF_MAP_TYPE_{HASH, PERCPU_HASH,
> + *		LRU_HASH, LRU_PERCPU_HASH}**, for which batch parameters
> + *		must be at least 4 bytes wide regardless of key size.
>    *
>    *		The *keys* and *values* are output parameters which must point
>    *		to memory large enough to hold *count* items based on the key
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index d96708380e52..d2e6c5fcec01 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -617,7 +617,11 @@ union bpf_iter_link_info {
>    *		to NULL to begin the batched operation. After each subsequent
>    *		**BPF_MAP_LOOKUP_BATCH**, the caller should pass the resultant
>    *		*out_batch* as the *in_batch* for the next operation to
> - *		continue iteration from the current point.
> + *		continue iteration from the current point. Both *in_batch* and
> + *		*out_batch* must point to memory large enough to hold a key,
> + *		except for maps of type **BPF_MAP_TYPE_{HASH, PERCPU_HASH,
> + *		LRU_HASH, LRU_PERCPU_HASH}**, for which batch parameters
> + *		must be at least 4 bytes wide regardless of key size.
>    *
>    *		The *keys* and *values* are output parameters which must point
>    *		to memory large enough to hold *count* items based on the key
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index ab2570d28aec..df0db2f0cdb7 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -190,10 +190,14 @@ LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
>   /**
>    * @brief **bpf_map_lookup_batch()** allows for batch lookup of BPF map elements.
>    *
> - * The parameter *in_batch* is the address of the first element in the batch to read.
> - * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
> - * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to indicate
> - * that the batched lookup starts from the beginning of the map.
> + * The parameter *in_batch* is the address of the first element in the batch to
> + * read. *out_batch* is an output parameter that should be passed as *in_batch*
> + * to subsequent calls to **bpf_map_lookup_batch()**. NULL can be passed for
> + * *in_batch* to indicate that the batched lookup starts from the beginning of
> + * the map. Both *in_batch* and *out_batch* must point to memory large enough to
> + * hold a single key, except for maps of type **BPF_MAP_TYPE_{HASH, PERCPU_HASH,
> + * LRU_HASH, LRU_PERCPU_HASH}**, for which the memory size must be at
> + * least 4 bytes wide regardless of key size.
>    *
>    * The *keys* and *values* are output parameters which must point to memory large enough to
>    * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
> @@ -226,7 +230,10 @@ LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
>    *
>    * @param fd BPF map file descriptor
>    * @param in_batch address of the first element in batch to read, can pass NULL to
> - * get address of the first element in *out_batch*
> + * get address of the first element in *out_batch*. If not NULL, must be large
> + * enough to hold a key. For **BPF_MAP_TYPE_{HASH, PERCPU_HASH, LRU_HASH,
> + * LRU_PERCPU_HASH}**, the memory size must be at least 4 bytes wide regardless
> + * of key size.
>    * @param out_batch output parameter that should be passed to next call as *in_batch*
>    * @param keys pointer to an array of *count* keys
>    * @param values pointer to an array large enough for *count* values

