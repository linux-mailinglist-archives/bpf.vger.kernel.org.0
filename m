Return-Path: <bpf+bounces-37675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD64959616
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 09:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB95F1F22FEE
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E21B81B8;
	Wed, 21 Aug 2024 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Htifxzzx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20E1B81A8;
	Wed, 21 Aug 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225364; cv=none; b=OwskhcyDXO0bsX2c525CTLboVf023XHnUkPcOrSQXIfkHb7EMkrx5itNd0/MWTektqj99PfRbT4Lvjy9lEpL8Xeew6c9+DCCDS84/waeJ6T23bCdMku7gCbtIux7Epiwy3kWrwXnRKMukC1iHZusJQjj9nvm4BOBgZMyzlg1so8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225364; c=relaxed/simple;
	bh=R4TFGa0Fzr4QREs6Be+nUD+wyPp3r2ef9dC3hQUUFeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVrPsjEE/m81VYI5ckolI92MXfO1exUWXJhPlIUUJ8hTvHGMtarzxGZ1an1N7Qqz5L8LDj2gv1zM1b3gyTU7hkLwdkRLungHe31H+l/PltBY8X48BxIDvzDWoCSHVnS51pqHZ4kvEFp6Ycq5wsDGBTJRIJM7sjnFmGt1hAmLV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Htifxzzx; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gfdUspADtIA0BgfdVsFhuY; Wed, 21 Aug 2024 09:20:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724224808;
	bh=sOKhiPU3qe1blgsVYJFPYciM8LnA2gN9PupD9D8luQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HtifxzzxHbP4xgAZ94mmoSNI+C+Numay9siSlZBUdjLuFzKxGkE/IXD+IW9OwxqJq
	 rKijuHJddDrlgGljmz1feBG4wDls/spgM/IOTJJfsNKVB4YyJdbX0HcvWbE7dzlVPY
	 XV4mbeK1vtjb0qaRM/gAkd9IS2ttdzTNYATRD68U1PEN3eAnURtwwQZBVCmugX7hBZ
	 A84mkbC82y6QAWeL4BIMArk9cuLJ5gqIDLMo2EzOUr0FHhQjclFRGFEZ2JYHsqRNuU
	 A78uTtFskiJqBz1IoYljQfYVfm4i0EvgNwCQwQ9/UDMkrET9zfMplLTTpov9cqYlUk
	 GHC8MPIRL4ypA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 09:20:08 +0200
X-ME-IP: 90.11.132.44
Message-ID: <66d4df96-3493-4b12-8bd8-e26c42cd342d@wanadoo.fr>
Date: Wed, 21 Aug 2024 09:20:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: Initialize st_ops->tname with strdup()
To: Soma Nakata <soma.nakata01@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240821064632.38716-3-soma.nakata01@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240821064632.38716-3-soma.nakata01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 08:46, Soma Nakata a écrit :
> `tname` is returned by `btf__name_by_offset()` as well as `var_name`,
> and these addresses point to strings in the btf. Since their locations
> may change while loading the bpf program, using `strdup()` ensures
> `tname` is safely stored.
> 
> Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3be6f8fac09..ece1f1af2cd4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1423,7 +1423,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
>   		memcpy(st_ops->data,
>   		       data->d_buf + vsi->offset,
>   		       type->size);
> -		st_ops->tname = tname;
> +		st_ops->tname = strdup(tname);

Hi,

Should a NULL check be added (as done a few lines above for the 
[cm]alloc()) and bpf_map__destroy() updated with a 
zfree(&map->st_ops->tname) ?

CJ

>   		st_ops->type = type;
>   		st_ops->type_id = type_id;
>   


