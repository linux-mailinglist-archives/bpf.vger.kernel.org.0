Return-Path: <bpf+bounces-70525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA92BC27A8
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C27EC4E9B8B
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2FA2236F2;
	Tue,  7 Oct 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS5fuo+r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410B21C9FD
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864473; cv=none; b=tPj3fcd3JB9wvpIxpFE08XXFaLYjHHaLl7i9vE7UW/fM75iRKlE7m1EyJl9zlYsbSPjmhDs1DXSUjGEYmFYw+g32AE4au8j3GZxEFEuuGxa5kcbQfACwDyNSgh7JgDlgY3McgdhiDqpgESjnjmC3NO8oAKOSO1Z3uWRGUXOfXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864473; c=relaxed/simple;
	bh=JCRIHWzjITvq3//htgMoBxutIphrW4EWXZgBTt+Ibbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8qcwzpx6Kzmqgmqb5ZogARSnmgZT0z0Gl0H6OIq/hblDKifuI/DVOS5UMVUICDufqkGv26gAZpQT//EAIPq5SPltGi7AUEmJq93Is6ex2F8+nfAzDiYs9Xdp6O33LN3kVkLvscNtw3rVjLgtcSnm586SxcjqIVVu6FDKBuv7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS5fuo+r; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781251eec51so5084146b3a.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759864471; x=1760469271; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Fs3AUIWAIsYSFX/scB71p2OfSMFigR1DgYcyZ97SK4=;
        b=kS5fuo+rw3mrCiPOJcNDAPz+iOsruLp21s2INhpWV6fKPt4NiMocHJSLlhKOI2wOyW
         IJ4t2sITn2XbYkLPQH2KfpZXHMRO5yl6rSgmH0bjX9UYMu6bS8FYxslvpgOIfB9ZN9b4
         huUvLP/wWiX/OO9l9CnMTHQKJEtgvEDCxcafIeMgu3kvxUGkHlAZKeK2xh9sODaNN1TK
         QY3NSvNrvljumE+ABtUFKJonDbrPX3MKIAy2xbRZ2CgfXk0I66fH9wxm9JweKyJ6DQ4g
         q5MDyKtWZ8MWU2bDWMnRIe5YZMmdtMmZEc05wdK+UOtM6fGAYv0vHHXj0fq0LI8j1Xf0
         /tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864471; x=1760469271;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Fs3AUIWAIsYSFX/scB71p2OfSMFigR1DgYcyZ97SK4=;
        b=RC/Hucf8yUepeLhn5v6B+b0emZ6Yw23b2vSEkYx1NgRaovCPjlZ3Srh8HQ4kZPzRB4
         k3ZTn7+ED0AzBL8kfNsMX3hqcB+8RTTmV7FEHKN31HU4KsBbmIxOLVPQyIFdQbxd0n7j
         b0sy0iGY/38fbLFaptXquzM3+M+/0XcyHcEC2VffAg9KB0QYQ0+9UJc/RgdMdZuGl72/
         KhKZTtcgam1KyC0UBrO+AEaS4Dt22OcAyVOyJpnGAJ0dSKqIadgHZvK2ToQT6dl/hrmk
         ZiPqVY/AseBe6JuRjxIZKmHFgWcfG3IQcBwmjRp8j2bydWOfonCdHFXF1ZSnAWQ8YOJl
         WCmA==
X-Forwarded-Encrypted: i=1; AJvYcCWXhinlUyOELeocY7Wf0ZOSVJ8lmcgI1wyrnMJxFlDUk0TWbeorLV35+fC8vXXmtl6eGMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmlYkVGmWeGbQBMxMLhuchbk/Onv9+bqfICulVIYciV1FMKLr
	dd4cO/mYmL4MmL45eWpBiSHqzaoY0Pr2N1x1wQel/mN4xzl4LKmx52DO
X-Gm-Gg: ASbGncuW4PzSmUWJnBD/SWjkxiL4oXOQKZAnd848OXVnARHKxSNu731p3RtpfQOY59T
	XzbtB3PSaYt1k+/fK5ebwjrSOTeLu/OMbl8eVwi6Uz+jMXp7IwAzEk3O3Rq+3GVbTs0tDJxy/zc
	p8Oxz9ywboo1yVb4drKqOxRp86Inuo35plMU/XRwOeg/JL+OJ/bdnY4o81pni5g+hj/XJpePDgS
	+3VKknUkAFyYPCIxiTWpm4BD3LDuIGNP+NjFrnenm+8UeYUMSdt/KgY7Nh6p3SXBS3RXdl3hXlM
	X+C158mpVrlBYo0cnRvSwkwBZLES3tCnhIFO7CCDbgfloCbUtkJKsvmeiWaWNmLshkZRTIXBE1l
	URO3JzJBZe8lBdA3rbRkaojvxp0pP+VkCW9sTNn/wSEIcKe2AiesrYqpyVF8tGfncGkZyLwL8K+
	lSbAfW67o=
X-Google-Smtp-Source: AGHT+IH/a4D6jMt2ieMPRH/zRlf5Sc1+CUFnNGClNFEycW3ZWXKRkYNlmGmncjD7ykdQP+qQY2LMGQ==
X-Received: by 2002:a05:6a20:a123:b0:243:d1bd:fbc9 with SMTP id adf61e73a8af0-32da8462b41mr822363637.56.1759864471516;
        Tue, 07 Oct 2025 12:14:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053957sm16467882b3a.57.2025.10.07.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:14:31 -0700 (PDT)
Message-ID: <5ab5aa0dd0a769cfcee7fe9407f95d3956947794.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Fix GFP flags for non-sleepable
 async callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Tue, 07 Oct 2025 12:14:29 -0700
In-Reply-To: <20251007014310.2889183-3-memxor@gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
	 <20251007014310.2889183-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 01:43 +0000, Kumar Kartikeya Dwivedi wrote:

[...]

> @@ -11460,10 +11460,17 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>  			return -EINVAL;
>  		}
> =20
> -		if (in_sleepable(env) && is_storage_get_function(func_id))
> +		if (is_storage_get_function(func_id))
>  			env->insn_aux_data[insn_idx].storage_get_func_atomic =3D true;
>  	}
> =20
> +	/*
> +	 * Non-sleepable contexts in sleepable programs (e.g., timer callbacks)
> +	 * are atomic and must use GFP_ATOMIC for storage_get helpers.
> +	 */
> +	if (!in_sleepable(env) && is_storage_get_function(func_id))
> +		env->insn_aux_data[insn_idx].storage_get_func_atomic =3D true;
> +

Note this discussion:
https://lore.kernel.org/bpf/8e1e6e4e3ae2eb9454a37613f30d883d3f4a7270.camel@=
gmail.com/

It appears there is already a need to have a flag in struct
subprog_info, indicating whether subprogram might run in a sleepable
context. Maybe add this flag and remove .storage_get_func_atomic
altogether? (And check subprog_info in the do_misc_fixups()).

>  	meta.func_id =3D func_id;
>  	/* check args */
>  	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {

[...]

