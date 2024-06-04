Return-Path: <bpf+bounces-31292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4618FACEE
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 09:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAEF1C20B40
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A191428FA;
	Tue,  4 Jun 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgKn2eVq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855701442FB;
	Tue,  4 Jun 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487800; cv=none; b=SYHyxjmQTvjF50A4FOBMlxULSrCxkFQm0Sij+4HXLvcjHHq56yEljx4bCf2wHIKfykH9pewb0mcwGvouicPgY6GUP2lvXBg+pZmYLVj+2/FvvtcnHEdorxcOEERMYJL9T8T0ryGqREcAu/1RHxaPeC4j+fz8Co27a1ZcCptsT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487800; c=relaxed/simple;
	bh=4P9STm7Tqu8zS5aS+jowLfgQpDvynJauXla8R+gW8oA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kidVf0M1c5JOrRKlE3IsIvunLi1VolKMIAZeAjCqre7YsEb3zeJTgwa0G3SZMj5H3QL1WrEARhsJ/5/yyt/d6yzV0OE3EFz5uKjjc0qoHpv26xAHMDpV1RdY77DmTiRLQhudI68eaSS4iYwIJauPCuMQ9yKK9hwKIzrxinJ8ff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgKn2eVq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42134bb9677so39241125e9.2;
        Tue, 04 Jun 2024 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717487797; x=1718092597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O350TIsq9YLAoOoYARKSfDq5NiQ/v55dRM6GNZLiR0Y=;
        b=NgKn2eVqAxsMISFWV4iN5LAOQ7BdGF6XdmwUBDMs264UpMqAm9MPYqY4NQKE5KhXkP
         6s/BT8nm1HDCd7+Y7OF8zj8GHLQEHvNsbszu4Aomvgy6OjH/gA4ulQTsfYGveJ3Ptm8W
         RkMllp7rWS0q2JSnFrQQcbjObE0Wl7RQnVS+Uul7nty1xdvoWIY6UUNZAhWeF+fxBilu
         psU9fn0CTlDUZBZkPJwK+vqbXJCYcVxE5MdCZoH2O2UhrqbEfWb/tPuD+Fbl5WUqTblu
         tKvZbSeQka0SZFAZgmHmk2wDGtw+nAXBJTu1jVb5magCqj35g9Gtgbp2GB32V5zyPjIz
         gYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717487797; x=1718092597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O350TIsq9YLAoOoYARKSfDq5NiQ/v55dRM6GNZLiR0Y=;
        b=Nvctj6ZqYU6igwZZ92Jaoexp8Te9BCd4MuvAnCTgil4BbAfhmHUA61RqvLlmJnYwW6
         ncgdYzeZpk20M1GvxHMHHrqhScqPVOM3rdgUst5CXQv3f9ZQp9/exZBHv7lxG9OdO7Go
         Pf9AUPuCraOU1lmG+LyQxZm9TACf8htZV3gOzvWSYh/gHofTqfp4FR6ASLPt+CP0klVl
         Jk1djHfbPGCs2ogC6MGHamO1wm56l7GlBlLgTEnLRhz0PVnc5j7d3t34ZiYewG63aW6f
         +zJ5nk2ZERst34Mo2sSDSS/FomVltwa43LNddl+sWmvcLyKdm4hfIGnxC5Woypnhx8j3
         JIXA==
X-Forwarded-Encrypted: i=1; AJvYcCUFEQTKzfyNkOInLANi4CKySYQtnK32pYltHUT3EKLSe6aEWayeQYF39yu4id81hwyEsM3ar0LA5csDZzawEHavp0bleuSD
X-Gm-Message-State: AOJu0Yw3CrdffXboqWxHlhQfeOzujDcfEFZu7YBrAQMdqO4UIOE1E0DF
	cWvIGUUKonr6dXtXAyzbFRd5aDYeWp8UOgtQR2AixpUIVfUhLqqZ
X-Google-Smtp-Source: AGHT+IHhG9sOTYVW20XrZDCQqFAC1654zHonmJAmvCtJ3YZzG5tFQWnvM95IUEMvAQZLQWekwWOZ7g==
X-Received: by 2002:a05:600c:1f14:b0:421:36da:9438 with SMTP id 5b1f17b1804b1-42136da9466mr91646945e9.28.1717487796665;
        Tue, 04 Jun 2024 00:56:36 -0700 (PDT)
Received: from krava ([212.20.115.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215447035bsm2945455e9.13.2024.06.04.00.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 00:56:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Jun 2024 09:56:33 +0200
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] bpf: Harden __bpf_kfunc tag against linker
 kfunc removal
Message-ID: <Zl7IscCtZVKjgP2h@krava>
References: <cover.1717413886.git.Tony.Ambardar@gmail.com>
 <cover.1717477560.git.Tony.Ambardar@gmail.com>
 <e9c64e9b5c073dabd457ff45128aabcab7630098.1717477560.git.Tony.Ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c64e9b5c073dabd457ff45128aabcab7630098.1717477560.git.Tony.Ambardar@gmail.com>

On Mon, Jun 03, 2024 at 10:23:16PM -0700, Tony Ambardar wrote:
> BPF kfuncs are often not directly referenced and may be inadvertently
> removed by optimization steps during kernel builds, thus the __bpf_kfunc
> tag mitigates against this removal by including the __used macro. However,
> this macro alone does not prevent removal during linking, and may still
> yield build warnings (e.g. on mips64el):
> 
>     LD      vmlinux
>     BTFIDS  vmlinux
>   WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
>   WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
>   WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
>   WARN: resolve_btfids: unresolved symbol bpf_key_put
>   WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
>   WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
>   WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
>   WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
>   WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
>   WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
>   WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
>   WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
>     NM      System.map
>     SORTTAB vmlinux
>     OBJCOPY vmlinux.32
> 
> Update the __bpf_kfunc tag to better guard against linker optimization by
> including the new __retain compiler macro, which fixes the warnings above.
> 
> Verify the __retain macro with readelf by checking object flags for 'R':
> 
>   $ readelf -Wa kernel/trace/bpf_trace.o
>   Section Headers:
>     [Nr]  Name              Type     Address  Off  Size ES Flg Lk Inf Al
>   ...
>     [178] .text.bpf_key_put PROGBITS 00000000 6420 0050 00 AXR  0   0  8
>   ...
>   Key to Flags:
>   ...
>     R (retain), D (mbind), p (processor specific)
> 
> Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202401211357.OCX9yllM-lkp@intel.com/
> Fixes: 57e7c169cd6a ("bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs")
> Cc: stable@vger.kernel.org # v6.6+
> Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>

tested on mips64 cross build and the warnings are gone
and related functions are in the vmlinux

patchset looks good to me

Tested-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  include/linux/btf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f9e56fd12a9f..7c3e40c3295e 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -82,7 +82,7 @@
>   * as to avoid issues such as the compiler inlining or eliding either a static
>   * kfunc, or a global kfunc in an LTO build.
>   */
> -#define __bpf_kfunc __used noinline
> +#define __bpf_kfunc __used __retain noinline
>  
>  #define __bpf_kfunc_start_defs()					       \
>  	__diag_push();							       \
> -- 
> 2.34.1
> 

