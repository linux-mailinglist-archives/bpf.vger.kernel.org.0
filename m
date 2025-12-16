Return-Path: <bpf+bounces-76694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F13CC131A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 07:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 285E13010E1E
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8B336EE0;
	Tue, 16 Dec 2025 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbL6ObM/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418FD336EFB
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867890; cv=none; b=Oy2nMEG4CpeF1fY3EF2Jmfhcj4EUfWJ8SMnw/MvoUrRXlS6N+5tlcMUsc9fF28jkZGhv3ZQcKoTSjRXWcjpAxrcFmeLErAxbXCZcL3rS2wbasPgpiaHI8rujV5XTW143ojTjM03of7eiw3UR/OfuQm2yWQYhN7NxST0aFzCn6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867890; c=relaxed/simple;
	bh=o0kU/Nr1TmmImImnf9Iz1JacdKj7mtXAIX5NghTd5c0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8Jdl/dcwbnTsD5SxyW01GOJ+Tm1aztJ7zvoM0vsFQqtrtl4bu15Vm0aSZ/fxvU4Wtr6rqyMgpIKILSWREz/9FqAO8c1whzUY5ye/nkebkPUL6GWQl/VCAOJmQ+b88ujZpoxbi/ZP3vrG61QjSiTJYrE87AuMSpgMsAcko1tSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbL6ObM/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so4255314b3a.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 22:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765867878; x=1766472678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5QrcSQj7JAbNrFLpgKo6GO8x5j8W9VyOVwKxdYcyrM=;
        b=IbL6ObM/WMRxl/zF29uyflKoS10V1QZwmjMarMaZotovRb2ZhAaUUR6p7ioA+YWWIh
         /XrdoC4wwJX8d37scYryVTTxcKGul0zavWpcIO250jwEMrrKpGLVISfaPlRLw3nyGFJC
         sH6RSgzpEbjJT3gz/gH/dHQDvpl5ZI07ppjBbOOVhkRMbkWcHJURveXam2ut1on87AX0
         rDsXk0/pDbLjVmNn+AwrEJfMy3BI2GSvFBAmQlNPEfPsBu/dSI+6DjS8eMHa/vDYBWgp
         sOWvp8TN5i2FFeVQm01jM3cl+TDyRNkhVK5BVcfsddVWhIqQQkaK9eaIHSIQEKR7ugN8
         dtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765867878; x=1766472678;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5QrcSQj7JAbNrFLpgKo6GO8x5j8W9VyOVwKxdYcyrM=;
        b=WrHXReMewaRaCLAYTUcVOMy5A+LnH1ofKETNRZ3A6726nMROPuYaCgKTv1SjQ/3Nro
         jRm/jff3v16qe55COsdqRY+Ur57RgAwMexmAq9RZM/ZNnJqkRLzAxGDJAA5wexg7BjQ7
         Usx2vkLX4e4SkDBmgeCy/OCzzuvwtxnNHEjJAfQaZCKIUubEXGTtWi4ekXganbE+hb+y
         8Q3uCHqW4cM9gzR08eKm8S6eluy4VxXdZAu2QQ6sRF8Dw39cxiTozQ5LBPB9BhVWTXKX
         pcw5hwW9qmujj9zqu7cBYUmMFtpzinPSJxfheH6rZ+28lmLDsATp7zqp/CMg3ps+/Veo
         5auA==
X-Forwarded-Encrypted: i=1; AJvYcCX4eCeOaEJrIkCkftgQp7ZZQLh6HepKHm9XK1zpj7Qds4mSZk1h5pMwvyQHQhJj4DMymzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UmNN6XAgJqOuREeYG/+zUFthBo/I6lvngXCBZiENTMF3K8AE
	jYL1YykP2RDag8cQ1t4K1Kq95JxbYcZzrHZKqi5RK/vg9E805ea7m987
X-Gm-Gg: AY/fxX4R0Rcwb3clH+d400AwO5HgIAkzpxjJNz1spiGN8ZiysXsNrBHuN+Z+Q5T9nnt
	408sMIXcwz1EVD35+kwn3n3IQtoJ1AXBSxa8I9+H9PNmXQBQUE84/zD7vY9SkMkyRVB8Fm5V4+O
	zRz2P0z/LO57q0FYCWO9DRcF0DgUm98jpL4Xt15mNYLpCIVwSbN0Kklg7BPypdlOw3CzeenDtmY
	UzzcY1xFkXCefgdnFhsOHAW4ZlfHR155dBuXOpf65kpotUprDf5g49AH9pYmhNyki0Z/LbivSiz
	aMXUpYbUj1cmMLbj+9m6/dAdY7fAwJgqtUvA8IrH27j6DwB85tWpEhT64a68d6QQv5+AL1Q+TER
	6z+8OnJTfZTFyj4uLUPluMZ9HwtA7eRvAqBd3PLsJ9IsJu4uaYxHy7uULBSAy7AVtZ/Aeqq7r2x
	YJ0N8PZDPp
X-Google-Smtp-Source: AGHT+IHgoAPUzQ55SCQNMnSVoIE8Vay26cotcjWdxZjKE64zc68lJdcRegnaf3zSJHcV/ulmnyNTvA==
X-Received: by 2002:a05:6a00:8c0f:b0:7e8:4433:8fa0 with SMTP id d2e1a72fcca58-7f6694aa5bdmr12313689b3a.40.1765867878234;
        Mon, 15 Dec 2025 22:51:18 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c27769edsm14464814b3a.23.2025.12.15.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:51:17 -0800 (PST)
Message-ID: <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 06/10] btf: support kernel parsing of BTF
 with kind layout
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 22:51:14 -0800
In-Reply-To: <20251215091730.1188790-7-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-7-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:

If strict kind layout checks are the goal, would it make sense to
check sizes declared in kind_layout for known types?

[...]

> @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifier_env=
 *env,
>  		return -EINVAL;
>  	}
> =20
> -	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> -	    BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> +	if (!btf_name_offset_valid(env->btf, t->name_off)) {
> +		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> +				 env->log_type_id, t->name_off);
> +		return -EINVAL;
> +	}
> +
> +	if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
>  		btf_verifier_log(env, "[%u] Invalid kind:%u",
>  				 env->log_type_id, BTF_INFO_KIND(t->info));
>  		return -EINVAL;
>  	}
> =20
> -	if (!btf_name_offset_valid(env->btf, t->name_off)) {
> -		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> -				 env->log_type_id, t->name_off);
> +	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_layout &&
> +	    ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_kind_layout)) <
> +	     env->btf->hdr.kind_layout_len) {
> +		btf_verifier_log(env, "[%u] unknown but required kind %u",
> +				 env->log_type_id,
> +				 BTF_INFO_KIND(t->info));
>  		return -EINVAL;
> +	} else {
> +		if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> +			btf_verifier_log(env, "[%u] Invalid kind:%u",
> +					 env->log_type_id, BTF_INFO_KIND(t->info));
> +			return -EINVAL;
> +		}
> +		var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> +		if (var_meta_size < 0)
> +			return var_meta_size;
>  	}
> =20
> -	var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> -	if (var_meta_size < 0)
> -		return var_meta_size;
> -
>  	meta_left -=3D var_meta_size;

It appears that a smaller change here would achieve same results:

    -        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
    +        u32 layout_kind_max =3D env->btf->hdr.kind_layout_len / sizeof=
(struct btf_kind_layout);
    +        if (BTF_INFO_KIND(t->info) > layout_kind_max ||
                 BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
                     btf_verifier_log(env, "[%u] Invalid kind:%u",
                                      env->log_type_id, BTF_INFO_KIND(t->in=
fo));
                     return -EINVAL;
             }

    +        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
    +                btf_verifier_log(env, "[%u] unknown but required kind =
%u",
    +                                 env->log_type_id,
    +                                 BTF_INFO_KIND(t->info));
    +        }
    +
             if (!btf_name_offset_valid(env->btf, t->name_off)) {
                     btf_verifier_log(env, "[%u] Invalid name_offset:%u",
                                      env->log_type_id, t->name_off);

wdyt?

But tbh, the "unknown but required kind" message seems unnecessary,

> =20
>  	return saved_meta_left - meta_left;
> @@ -5405,7 +5419,8 @@ static int btf_parse_str_sec(struct btf_verifier_en=
v *env)
>  	start =3D btf->nohdr_data + hdr->str_off;
>  	end =3D start + hdr->str_len;
> =20
> -	if (end !=3D btf->data + btf->data_size) {
> +	if (hdr->hdr_len < sizeof(struct btf_header) &&
> +	    end !=3D btf->data + btf->data_size) {

Given that btf_check_sec_info() checks for overlap and total size,
is this check needed at all?

>  		btf_verifier_log(env, "String section is not at the end");
>  		return -EINVAL;
>  	}

[...]

