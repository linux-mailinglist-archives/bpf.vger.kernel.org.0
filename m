Return-Path: <bpf+bounces-7524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FC778796
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 08:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCE1281FC3
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFEF17F8;
	Fri, 11 Aug 2023 06:43:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F772A35
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:43:36 +0000 (UTC)
Received: from out-88.mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D78226B2
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 23:43:34 -0700 (PDT)
Message-ID: <371c72e1-f2b7-8309-0329-cdffc8a3f98d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691736212; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YxfTeMRGbEX8XAfgT0Mgd6kR4/eyN2zbW/mvn09rfA=;
	b=Qfh8J2/HmPzRKh04U308PejftZy0KeHqSLodeD5upZyY/RDTThEq0WHKV0caRRBxvy2wcE
	Nzynd5uivQOmkuBrv8Fo8xGXMuPF7JIcAT1Krysz6qibOW9cHjAS0mah0L7TrAnZPILtM6
	qsf9ooV+cZKcGiuHG4mR9amnNxd5UmM=
Date: Thu, 10 Aug 2023 23:43:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Content-Language: en-US
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
 clm@meta.com, thinker.li@gmail.com
References: <20230810220456.521517-1-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230810220456.521517-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 3:04 PM, David Vernet wrote:
> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
> define the .validate() and .update() callbacks in its corresponding
> struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
> in its own right to ensure that the map is unloaded if an application
> crashes. For example, with sched_ext, we want to automatically unload
> the host-wide scheduler if the application crashes. We would likely
> never support updating elements of a sched_ext struct_ops map, so we'd
> have to implement these callbacks showing that they _can't_ support
> element updates just to benefit from the basic lifetime management of
> struct_ops links.
> 
> Let's enable struct_ops maps to work with BPF_F_LINK even if they
> haven't defined these callbacks, by assuming that a struct_ops map
> element cannot be updated by default.

Maybe you want to add one map_flag to indicate validate/update callbacks
are optional for a struct_ops link? In this case, some struct_ops maps
can still require validate() and update(), but others can skip them?

> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index eaff04eefb31..3d2fb85186a9 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -509,9 +509,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	}
>   
>   	if (st_map->map.map_flags & BPF_F_LINK) {
> -		err = st_ops->validate(kdata);
> -		if (err)
> -			goto reset_unlock;
> +		err = 0;
> +		if (st_ops->validate) {
> +			err = st_ops->validate(kdata);
> +			if (err)
> +				goto reset_unlock;
> +		}
>   		set_memory_rox((long)st_map->image, 1);
>   		/* Let bpf_link handle registration & unregistration.
>   		 *
> @@ -663,9 +666,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	if (attr->value_size != vt->size)
>   		return ERR_PTR(-EINVAL);
>   
> -	if (attr->map_flags & BPF_F_LINK && (!st_ops->validate || !st_ops->update))
> -		return ERR_PTR(-EOPNOTSUPP);
> -
>   	t = st_ops->type;
>   
>   	st_map_size = sizeof(*st_map) +
> @@ -838,6 +838,11 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>   		goto err_out;
>   	}
>   
> +	if (!st_map->st_ops->update) {
> +		err = -EOPNOTSUPP;
> +		goto err_out;
> +	}
> +
>   	err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
>   	if (err)
>   		goto err_out;

