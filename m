Return-Path: <bpf+bounces-19018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13C3824087
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 12:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4C01C21BD6
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 11:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21C21115;
	Thu,  4 Jan 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ3n2cCi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C721101;
	Thu,  4 Jan 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-556cd81163fso512837a12.1;
        Thu, 04 Jan 2024 03:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704367386; x=1704972186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nke4XniUn2EOirvKra06Codg8uMFEBhdGp5AdYnvb0=;
        b=bZ3n2cCiNLEH83+wyfd/Adw0ms6bpDs5O5LYsscpxT6pBaM8q8DnlE5AaFVNgFxBRk
         RJufODCVDllED98z9BocSYYZTJ243g6zMJAQ+P8KkpMu6UKLkQpAjwoA3+pOLCs8/sX6
         zoYif0sw0HrDKxn+cK3aFsilCLRWSMEUt97c44I6I2rmA0VjH/24pC9jNJ6FuFam3sSq
         YUYMpB9rJFuFZF4awgLJX2wSUsh1nMTkJK4uuibEeMZjTBPrevwKBS3didLp29MZdPOq
         k8eihhrv6Yx3ZJAJ3Nwz1dJnMHaCyVCl7PmTj3HbmL3GZ3Xifm1GdqUI2jKM7yqQbiNc
         EdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704367386; x=1704972186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nke4XniUn2EOirvKra06Codg8uMFEBhdGp5AdYnvb0=;
        b=NTVz8zugzwRY+q91cSV9pTyWsKeMLJh5y7v6hyQ7Lpb7079ird63qg9LMNz8o/4I+H
         +eLZCZ7JVrG9V/fH9ASPAm/r92c4cmsaeLVmmZCa+ypfmaVFcuPPMaKRXyZIZ/vptTfl
         PT3zILxqQwOcW6H1qFAnGZ69dYAHmU7MLGMS0XYjyY9w3GgkPe8aqaq7E3/Cb4sRpp96
         Jd4qokrbBTHg6l/lf8VEJ0iv/XCFYl7lKML2OW3K5lIgg0h0hU/ueoBOT+bMUXgFaiZW
         UNEPYMp0sBHapei/snZY0VYB5Cn4x964sOUZa+M2v6STnpI2kvFp/4f1yV8tbfndzQEW
         Hi0Q==
X-Gm-Message-State: AOJu0YzqpDmgYqFWfVTzpU/7RWre0a1pq4bsbnkoOv4VOvn0ntBGKMYp
	W97OuiZjB8BamGUkJIhLOrOtnYDDofWGSg==
X-Google-Smtp-Source: AGHT+IFWOl4poVCqgvWbk3yPyUvK/HetwToGlNhsWH5IZEbjwJu48azdUlEOAjHK09HJ3oXWL0ufhQ==
X-Received: by 2002:a50:d61d:0:b0:554:1a96:a8aa with SMTP id x29-20020a50d61d000000b005541a96a8aamr207101edi.90.1704367386034;
        Thu, 04 Jan 2024 03:23:06 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i21-20020a0564020f1500b0055344b92fb6sm18926218eda.75.2024.01.04.03.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:23:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jan 2024 12:23:03 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: martin.lau@linux.dev, andrii@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com,
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: btf: Support optional flags for
 BTF_SET8 sets
Message-ID: <ZZaVFxMvmMjbOlra@krava>
References: <cover.1704324602.git.dxu@dxuuu.xyz>
 <29644dc7906c7c0e6843d8acf92c3e29089845d0.1704324602.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29644dc7906c7c0e6843d8acf92c3e29089845d0.1704324602.git.dxu@dxuuu.xyz>

On Wed, Jan 03, 2024 at 04:31:55PM -0700, Daniel Xu wrote:
> This commit adds support for optional flags on BTF_SET8s.
> struct btf_id_set8 already supported 32 bits worth of flags, but was
> only used for alignment purposes before.
> 
> We now use these bits to encode flags. The next commit will tag all
> kfunc sets with a flag so that pahole can recognize which
> BTF_ID_FLAGS(func, ..) are actual kfuncs.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/btf_ids.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index a9cb10b0e2e9..88f914579fa1 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -183,17 +183,21 @@ extern struct btf_id_set name;
>   * .word (1 << 3) | (1 << 1) | (1 << 2)
>   *
>   */
> -#define __BTF_SET8_START(name, scope)			\
> +#define ___BTF_SET8_START(name, scope, flags)		\
>  asm(							\
>  ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
>  "." #scope " __BTF_ID__set8__" #name ";        \n"	\
>  "__BTF_ID__set8__" #name ":;                   \n"	\
> -".zero 8                                       \n"	\
> +".zero 4                                       \n"	\
> +".long " #flags                               "\n"	\
>  ".popsection;                                  \n");
>  
> -#define BTF_SET8_START(name)				\
> +#define __BTF_SET8_START(name, scope, flags, ...)	\
> +___BTF_SET8_START(name, scope, flags)
> +
> +#define BTF_SET8_START(name, ...)			\
>  __BTF_ID_LIST(name, local)				\
> -__BTF_SET8_START(name, local)
> +__BTF_SET8_START(name, local, ##__VA_ARGS__, 0)

I think it'd better to use something like:

  BTF_SET8_KFUNCS_START(fsverity_set_ids)

instead of:

  BTF_SET8_START(fsverity_set_ids, BTF_SET8_KFUNC)

and to keep current BTF_SET8_START without flags argument, like:

  #define BTF_SET8_START(name) \
    __BTF_SET8_START(... , 0, ...

  #define BTF_SET8_KFUNCS_START(name) \
    __BTF_SET8_START(... , BTF_SET8_KFUNC, ...


also I'd rename BTF_SET8_KFUNC to BTF_SET8_KFUNCS (with S)

do you have the pahole changes somewhere? would be great to
see all the related changes and try the whole thing

jirka


>  
>  #define BTF_SET8_END(name)				\
>  asm(							\
> @@ -214,7 +218,7 @@ extern struct btf_id_set8 name;
>  #define BTF_SET_START(name) static struct btf_id_set __maybe_unused name = { 0 };
>  #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
>  #define BTF_SET_END(name)
> -#define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
> +#define BTF_SET8_START(name, ...) static struct btf_id_set8 __maybe_unused name = { 0 };
>  #define BTF_SET8_END(name)
>  
>  #endif /* CONFIG_DEBUG_INFO_BTF */
> -- 
> 2.42.1
> 

