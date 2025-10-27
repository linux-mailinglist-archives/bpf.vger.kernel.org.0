Return-Path: <bpf+bounces-72376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A7CC1192E
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 22:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADB9E4E4024
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 21:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D59328627;
	Mon, 27 Oct 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB4Ycvk4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F62D839A
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601467; cv=none; b=NNJm2xfT6qOB3SOxSWe/xdCzz62V/maCh/wxl4KbvzNiPmYbLV9+FXRuEmrDxHiU0vDXmUxe77PU1JpN8IS/aAnJGT2HC5QFmSHSfF+fJ0E9eclYCpeP3ouVkUrBSwjIwQsksfundvkcGL76Lq8ChZkVSSLzdhp/QwFNjWIb69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601467; c=relaxed/simple;
	bh=jVsrt2Bkv9Yc2EETsreonNXCC8bxO2xU+uDqcn5PL2k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Elt98IbND4JBcv+OL7TXOcns79Xo9QgKLjGGdvyqthX6x4n/cIs+57nxn97gbXqxUsHLAyoXG4r7Mrs5iCgWW4zXmv8tlGbc4WsgzVo3PdSEM/a1CKrNmPg7eCbvaZDoZzf+NENrz8TEJtbuM7coyvzpK7/TXYAUdtgGPwmKFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB4Ycvk4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a4176547bfso2241388b3a.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601465; x=1762206265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRJAccHcapvQansScNGZ+8/FAwvwd4bpFQNkX/z5J38=;
        b=QB4Ycvk4GiEH5NDCJRDg6q9ZLsDC9s+q/T2Tk41d2wwiHHdYAe3tCr87kC8evk6dPy
         bcwquWL9N9yMfpktgh35F8ei/eiaRiCLQjzmb3KR8y1GTIhAz+Wi0XCJt9sFd/Dp/FtO
         sTF3dZ8nJux0Pz2PhYSnAiIsAjKbBhrtxpTtzhCop4VOXvS7h2rY0kFOhUL57sSVQGry
         kZa0trMDg+Agui6MhnEHksgXpqA5xbzqFSSGuujSh74ftdoIzTo6D1p07RYytJbITa08
         DSLZVtKqU/os7VmttgERxfFxE62abZ3tfJ67HJ3M4IKCxBHHvqMD5SHBe315V7xDsj9P
         0New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601465; x=1762206265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRJAccHcapvQansScNGZ+8/FAwvwd4bpFQNkX/z5J38=;
        b=TCc0weume6iM0TJebB8Y1d5M7rUUtdzTdh6gsDc9cav+Goj0OksiLQt7212CP24tpZ
         3+tNE6lyLFCVAgRoQMT3w5LlWoubf3T31G7CSQZu+Lcxz4+pZiXYQ0qnx2FVIISIWN6J
         PCqCzUV6Ybjkj1W/NuLfqYFkEcwst3LmDfqRVqcuy4zWNzJuhqEgdApk52LePOZWHUId
         rm2mxw0di08hWmqzV9nVhLAii56fTlH5bd7BmWlmPvPXU9yN8Epmg7siWu7jqfn8A/cB
         FSarHXcey1wIrtQdnKBhNTUV3/LwVWFDgsJGJcE5Hh+z/nTcV5MJvhsS8dx9USTVl83M
         e4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+kHQjh3LTMWgPso7t7KJMXqLa14l/TjuMetZCXBxZK4Ndm9CLqsXhEXDiPUVjUKHuXZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUg6DgVn4SGEqvBwrruC8KwL1IHAmXqbiiWVdao5WK2czniXAb
	JUPMpnzbNxvNjrYCu4Ro7E10f2RsELoK7Hxln2qKhGdqw9syHstZfQKX
X-Gm-Gg: ASbGncvvcO1vn4/dP5Gaj+t0i3IORrzAwHodIQvYfCK/Sr27hVBwP2vIAHMoiztFbDt
	pLGWWAY4hhLteitew4BK8Pqv9sjngBGGKs77z048KGX+0Ig0yP+lQrSAGzJMVjJbw+j9GFa3g2v
	xbbuT0UQi2/z4/mwajshh9J3NnnEnT5O7anArCb+Hv61ad93K/34EUVwEryO2uhffmtqj7ehYMG
	IrCnut7AWRPXWunWSLbsjK2XFrDyzAAEqb+QKRiZHU+xBi1ekRr9iMEkvnmiE7PCb25o19wRgJ4
	jXSAYLtpQ5d2MEZokei685wIHLSYdC7t1p202geWwwXVDxNScX2CUgxCq2l3d7SXqoilqEScGL7
	amwV1kazsEDuOXApQVVRhKo9ZrlnyZSDPdOCCo9qDUj8+PprW4lf0u2Ltno+fldxTF2nBtX5uXs
	bMVIL3oONq
X-Google-Smtp-Source: AGHT+IHLxyQuzl25eA6zovU730kZONmsrhBSb8Q83sHKIa3jDTY+Cw2UF1Psajm7oIST9d+JbaCMwA==
X-Received: by 2002:a17:902:ea03:b0:270:4964:ad82 with SMTP id d9443c01a7336-294cb522a71mr14974575ad.38.1761601465065;
        Mon, 27 Oct 2025 14:44:25 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e416a2sm92454985ad.97.2025.10.27.14.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 14:44:24 -0700 (PDT)
Message-ID: <d2c4c93fcc4d7d6c8faef63e918ba4e625ae7b03.camel@gmail.com>
Subject: Re: [PATCH v7 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 27 Oct 2025 14:44:21 -0700
In-Reply-To: <20251026192709.1964787-2-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
	 <20251026192709.1964787-2-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-26 at 19:26 +0000, Anton Protopopov wrote:

[...]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4c93d9e73e4..d8ee0c4d9af8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3648,6 +3648,22 @@ struct x64_jit_data {
>  	struct jit_context ctx;
>  };
> =20
> +struct insn_ptrs_data {
> +	int *addrs;
> +	u8 *image;
> +};
> +
> +static void update_insn_ptr(void *jit_priv, u32 xlated_off, u32 *jitted_=
off, long *ip)
> +{
> +	struct insn_ptrs_data *data =3D jit_priv;
> +
> +	if (!data->addrs || !data->image || !jitted_off || !ip)
> +		return;
> +
> +	*jitted_off =3D data->addrs[xlated_off];
> +	*ip =3D (long)(data->image + *jitted_off);
> +}
> +
>  #define MAX_PASSES 20
>  #define PADDING_PASSES (MAX_PASSES - 5)
> =20
> @@ -3658,6 +3674,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
>  	struct bpf_prog *tmp, *orig_prog =3D prog;
>  	void __percpu *priv_stack_ptr =3D NULL;
>  	struct x64_jit_data *jit_data;
> +	struct insn_ptrs_data insn_ptrs_data;
>  	int priv_stack_alloc_sz;
>  	int proglen, oldproglen =3D 0;
>  	struct jit_context ctx =3D {};
> @@ -3827,6 +3844,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
>  			jit_data->header =3D header;
>  			jit_data->rw_header =3D rw_header;
>  		}
> +
> +		/* jit_data may not contain proper info, copy the required fields */
> +		insn_ptrs_data.addrs =3D addrs;
> +		insn_ptrs_data.image =3D image;
> +		bpf_prog_update_insn_ptrs(prog, &insn_ptrs_data, update_insn_ptr);
> +
>  		/*
>  		 * ctx.prog_offset is used when CFI preambles put code *before*
>  		 * the function. See emit_cfi(). For FineIBT specifically this code

[...]

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> new file mode 100644
> index 000000000000..f9f875ee2027
> +++ b/kernel/bpf/bpf_insn_array.c

[...]

> +void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
> +			       update_insn_ptr_func_t update_insn_ptr)
> +{

Nit: I think the control flow becomes a bit convoluted with this
     function pointer. Wdyt about changing the signature to:

       void bpf_prog_update_insn_ptrs(struct bpf_prog *prog,
                                      u32 *offsets /* maps xlated_off to of=
fset in image */,
                                      void *image)

     x86 jit provides this info, it looks like arm64 and riscv jits do too
     (arch/arm64/net/bpf_jit_comp.c:jit_ctx->offset field,
      arch/riscv/net/bpf_jit.h:rv_jit_context->offset).
     So, seem to be a reasonable assumption.

     Wdyt?

> +	struct bpf_insn_array *insn_array;
> +	struct bpf_map *map;
> +	u32 xlated_off;
> +	int i, j;
> +
> +	for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +		map =3D prog->aux->used_maps[i];
> +		if (!is_insn_array(map))
> +			continue;
> +		insn_array =3D cast_insn_array(map);
> +		for (j =3D 0; j < map->max_entries; j++) {
> +			xlated_off =3D insn_array->values[j].xlated_off;
> +			if (xlated_off =3D=3D INSN_DELETED)
> +				continue;
> +			if (xlated_off < prog->aux->subprog_start)
> +				continue;
> +			xlated_off -=3D prog->aux->subprog_start;
> +			if (xlated_off >=3D prog->len)
> +				continue;
> +
> +			update_insn_ptr(jit_priv, xlated_off,
> +					&insn_array->values[j].jitted_off,
> +					&insn_array->ips[j]);
> +		}
> +	}
> +}

[...]

