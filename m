Return-Path: <bpf+bounces-37701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A5959B7D
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B73285DE2
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F072516C86B;
	Wed, 21 Aug 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FAFpyTk8"
X-Original-To: bpf@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588B1D131E;
	Wed, 21 Aug 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242572; cv=none; b=hu/JQprJbEYpGHuYfiuQXfRCvTSAToKweCwwm7uE1K4O5M0LtQUE6Lna2ne8EBfKAysOIkSAvykmT6WtlM2ccgQF13Zaky40LHRJ5s6kFIGosbM9AX5kuVI2ctWIes6tASo/UFXElNSwmDMER3FlJtVile9P+/YnRl4JqMW/nXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242572; c=relaxed/simple;
	bh=7lPuFfHMXp0hkrYlhavQSxS6hoTLy3WgWRovN3zc2DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Msv+3xJxLwH1GvhFWeE2FQIILFfIg/Zh6aRu6qkj9sVFdRdYsw5FdzetQXWO8nPu2Q2PwsEZCtwD8VG4fw9F9uP0QA/W53QXb/MychoLPLALwph2h7Sn/h/FQIX5HPbx0TYNZ74s5s/997fPOMWRisyj0BfrNpAi6xg6ktIHeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FAFpyTk8; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gkFssFypPLYfJgkFssP5R2; Wed, 21 Aug 2024 14:16:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724242561;
	bh=Idh38J2a1UCLTfNYHMg5bSYi31mRdS8Tw6sXGnh7NjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=FAFpyTk8vTTilpyz3n+4+3WUGFu0yzWmk+FXQ6jDcVNsIO4CFd6rBubil+EQ5h3Z0
	 EwKsF6A46PqI8zHk4zEOJt2ArGyCaFuEHRkdg3+s6fr/varfdHtNCkrfXBew7LlDrm
	 X5zZWY+snFS5GZkv2jgm6nOhhiuH+kpLUmp70hB8xMv5nmmh7mZOypYF2RW0ktcNTy
	 LGChGvheu1HeWiob1+pxsI+MIDOFWiHc5/EDR4sGpR07g5MZRGTm67lcN8n3RGOsCt
	 2MBCJADQmUmhfGTpzpFZC4yL+Fh0Euv7cEfpYPwKWmTWcJJO/X8iNlrRwnVuUOnZyE
	 dr8t1OagmSARQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 14:16:01 +0200
X-ME-IP: 90.11.132.44
Message-ID: <ecd1af32-8e6b-45d3-8434-0e981fd198ea@wanadoo.fr>
Date: Wed, 21 Aug 2024 14:15:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libbpf: Initialize st_ops->tname with strdup()
To: Soma Nakata <soma.nakata01@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240821112344.54299-3-soma.nakata01@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240821112344.54299-3-soma.nakata01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 13:23, Soma Nakata a écrit :
> `tname` is returned by `btf__name_by_offset()` as well as `var_name`,
> and these addresses point to strings in the btf. Since their locations
> may change while loading the bpf program, using `strdup()` ensures
> `tname` is safely stored.
> 
> Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3be6f8fac09..f4ad1b993ec5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -496,7 +496,7 @@ struct bpf_program {
>   };
>   
>   struct bpf_struct_ops {
> -	const char *tname;
> +	char *tname;
>   	const struct btf_type *type;
>   	struct bpf_program **progs;
>   	__u32 *kern_func_off;
> @@ -1423,7 +1423,9 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
>   		memcpy(st_ops->data,
>   		       data->d_buf + vsi->offset,
>   		       type->size);
> -		st_ops->tname = tname;
> +		st_ops->tname = strdup(tname);
> +		if (!st_ops->tname)
> +			return -ENOMEM;

Certainly a matter of taste, but I would personally move it just after 
"st_ops->kern_func_off = malloc()" and add the NULL check with the 
existing ones.

BTW, there are some memory leaks if 1 or more allocations fail in this 
function.
Not sure if it is an issue or not, and what should be done in this case.

CJ


>   		st_ops->type = type;
>   		st_ops->type_id = type_id;
>   
> @@ -8984,6 +8986,7 @@ static void bpf_map__destroy(struct bpf_map *map)
>   	map->mmaped = NULL;
>   
>   	if (map->st_ops) {
> +		zfree(&map->st_ops->tname);
>   		zfree(&map->st_ops->data);
>   		zfree(&map->st_ops->progs);
>   		zfree(&map->st_ops->kern_func_off);


