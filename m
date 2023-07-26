Return-Path: <bpf+bounces-5920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E8A763162
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11417281CD5
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C4BA28;
	Wed, 26 Jul 2023 09:13:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1CAD4F
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:13:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3D1FFA;
	Wed, 26 Jul 2023 02:13:08 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9p7J41TDzrRyF;
	Wed, 26 Jul 2023 17:11:56 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 17:12:49 +0800
Subject: Re: [PATCH bpf-next 2/2] bpf: update uapi/linux/bpf.h docs on the
 batch map ops
To: Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov
	<ast@kernel.org>, <bpf@vger.kernel.org>
References: <20230717114307.46124-1-aspsk@isovalent.com>
 <20230717114307.46124-3-aspsk@isovalent.com>
From: Hou Tao <houtao1@huawei.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Brian Vazquez <brianvv@google.com>, Joe Stringer <joe@isovalent.com>,
	<linux-kernel@vger.kernel.org>
Message-ID: <dfb8a282-be49-d1a5-12c5-366307fbc2c9@huawei.com>
Date: Wed, 26 Jul 2023 17:12:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230717114307.46124-3-aspsk@isovalent.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/17/2023 7:43 PM, Anton Protopopov wrote:
> The map_lookup{,_and_delete}_batch operations return same values. Make
> this clear in documentation. Also, update the comments so that this is
> more clear that -ENOENT is a valid return value in case of success. (In
> fact, this is the most common return value, as this is reasonable to do
> map_lookup_batch(MAX_ENTRIES), which, in case of success, will always
> return -ENOENT.)
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/uapi/linux/bpf.h | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 600d0caebbd8..9e6e277bedab 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -632,17 +632,19 @@ union bpf_iter_link_info {
>   *			returning the lock. This must be specified if the
>   *			elements contain a spinlock.
>   *
> - *		On success, *count* elements from the map are copied into the
> - *		user buffer, with the keys copied into *keys* and the values
> - *		copied into the corresponding indices in *values*.
> - *
> - *		If an error is returned and *errno* is not **EFAULT**, *count*
> - *		is set to the number of successfully processed elements.
> + *		On success, up to *count* elements from the map are copied into
> + *		the user buffer, with the keys copied into *keys* and the
> + *		values copied into the corresponding indices in *values*.
>   *
>   *	Return
>   *		Returns zero on success. On error, -1 is returned and *errno*
>   *		is set appropriately.
>   *
> + *		If an error is returned and *errno* is not **EFAULT**, then

Maybe we should say "is not EFAULT or EINVAL" ? Otherwise, the update
looks good to me, so

Acked-by: Hou Tao <houtao1@huawei.com>

> + *		*count* is set to the number of successfully processed
> + *		elements. In particular, the *errno* may be set to **ENOENT**
> + *		in case of success to indicate that the end of map is reached.
> + *
>   *		May set *errno* to **ENOSPC** to indicate that *keys* or
>   *		*values* is too small to dump an entire bucket during
>   *		iteration of a hash-based map type.
> @@ -655,15 +657,15 @@ union bpf_iter_link_info {
>   *		**BPF_MAP_LOOKUP_BATCH** with two exceptions:
>   *
>   *		* Every element that is successfully returned is also deleted
> - *		  from the map. This is at least *count* elements. Note that
> - *		  *count* is both an input and an output parameter.
> + *		  from the map. The *count* parameter is set to the number of
> + *		  returned elements. This value can be less than the actual
> + *		  number of deleted elements, see the next item.
>   *		* Upon returning with *errno* set to **EFAULT**, up to
>   *		  *count* elements may be deleted without returning the keys
>   *		  and values of the deleted elements.
>   *
>   *	Return
> - *		Returns zero on success. On error, -1 is returned and *errno*
> - *		is set appropriately.
> + *		Same as the BPF_MAP_LOOKUP_BATCH return values.
>   *
>   * BPF_MAP_UPDATE_BATCH
>   *	Description


