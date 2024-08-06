Return-Path: <bpf+bounces-36480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 961519496FA
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8F61F21304
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8684C62E;
	Tue,  6 Aug 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JgpZ4dT2"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B669057CBB
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965906; cv=none; b=CkZsZvEJWhi7qiMeQF7LH00m9EUGT+erpqbGvh0LxjDof6t3gEkAYxrXEu83ZEX/I7e3Ur8eRd62yr2EMd2QCMlDqN8bYhjCIFUEuzmPEFhyl3m3QR6MF0iyPSumCySH5fl3Bc+L7ZV7evQHz0boTkDY/6WQqs0wzaWEWSaWByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965906; c=relaxed/simple;
	bh=V1hSo3ElJzhOnMEsCQDzGS70lDlnikQOX+/8vkbszMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f43tsbnBjMaNeFj9J6qCqZfnzI4YANgK2eWRVbM1u0nuz9ZXFc2k+FbHkHVRJDZiazRDsQvQzHD7I8DMykQNPkqkn8sGhXO1P+emJzxz0HYUDtuPlUIqR0EbnYvDNJYn6v+IOhSze+PLMyJr0nwzR5i+cuLXdd6T5Dny0AlwI7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JgpZ4dT2; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <57d88cd3-3cbc-4d30-be82-92990a7a50fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722965901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNlj7WyzKqKRkeKGCEt9rJm15yPVo4W++ljZ97nJ4R0=;
	b=JgpZ4dT2ytld+u40caVuwhlu+MrE2Pz7yF7H9S5pJaKQ7gGNw01U2kf1dHw/7mGx9hN5Vz
	Mg/BwNkCCCAhXQe/Xhwuz+0eDe9lc/9YJ/SuumFcXdi4+Huxidf/ysNeyQz4jVH2+WYvKB
	XP/Q7V7eHm8TL/OjO4bSx67sbF4+yxQ=
Date: Tue, 6 Aug 2024 10:38:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: check the btf_type kind to prevent error
Content-Language: en-GB
To: Ma Ke <make24@iscas.ac.cn>, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, delyank@fb.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240806105142.2420140-1-make24@iscas.ac.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240806105142.2420140-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/6/24 3:51 AM, Ma Ke wrote:
> To prevent potential error return values, it is necessary to check the
> return value of btf__type_by_id. We can add a kind checking to fix the
> issue.
>
> Cc: stable@vger.kernel.org
> Fixes: 430025e5dca5 ("libbpf: Add subskeleton scaffolding")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   tools/lib/bpf/libbpf.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3be6f8fac09..d1eb45d16054 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13850,6 +13850,9 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
>   		var = btf_var_secinfos(map_type);
>   		for (i = 0; i < len; i++, var++) {
>   			var_type = btf__type_by_id(btf, var->type);
> +			if (!var_type)
> +				return libbpf_err(-ENOENT);

Could you give a detailed example when this error could be triggered?

> +
>   			var_name = btf__name_by_offset(btf, var_type->name_off);
>   			if (strcmp(var_name, var_skel->name) == 0) {
>   				*var_skel->addr = map->mmaped + var->offset;

