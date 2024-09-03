Return-Path: <bpf+bounces-38768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F8969B5D
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 13:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C7EB21E2A
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AEF18950A;
	Tue,  3 Sep 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv/o4yK3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416FA1B12E9
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362187; cv=none; b=J6et5Aeex0cCM8RZugiidjmzU/dWAUnuem/mqh1hw2M2LRKfER7IaEW6s40jbqbopRq0f4VtM8ZWofvf/fRbniEZ0b7GYBEpa6vMIwC51fJjCV9hM1TH8zSzjTsu40Gk5HbGxdyRWbAJ3uC7eTboUCh7WMCUG6OIMz+upQXTYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362187; c=relaxed/simple;
	bh=OuIJAZQYFa2LG3r7/F5Jj4akqg+Jw19BDeYLBc60cmI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMHi1/4rQlIz2wNWDPDCItZyXTIvhr9O4+zDMzkf80g+mkMIN8vJv3YrbFnROGo3FwLD8RMs2NEBo4YV7GmyH1orn+myTrbmywtPGo35Xb1N/KrF7CIflngjdhk3RO4pRcGM/JjnzeYLWl0skUQJzNM0crovyQGKLjsSLnnR0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv/o4yK3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374bb1a3addso2044719f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725362185; x=1725966985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz8aAmPv6HPyM+RGV8TbPNZqJAF6zaTRqagtnUKV9w8=;
        b=Hv/o4yK3NN+boPUdmJTJwBpdCpU8ED3tGdOqDdVdGLN6Dq6M4t1rcM7sbi0ZP4vmLP
         ez0g07ofEVzeE9Ak+2k4yS7xCfPal1RzsYhftATM2QDD2CPvUUZi8Qq9Ou+nwH+KSJ5R
         vmpTJJSGntJmwa5Ac3z7zOrHJvAn4hupNC33gvVvpMqS9znhkFft/YKDb7ZzP3eItKN7
         KGpbk5l5uVnWxHtke+8GZbrzi8vUEbReutsJNTF2fTSXrMfA6L+HCNKYAxny6dlNaAJq
         EIkk/4hqrh6QvtZ1cbUQiPNOeusJsvf12TtjUfgGils5xseMWBS5GPQaskCx9ftZv4rA
         spjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725362185; x=1725966985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz8aAmPv6HPyM+RGV8TbPNZqJAF6zaTRqagtnUKV9w8=;
        b=jaTcmOuIcBYUYdFnJNviRnQDCGgzGP0tWzWabKonUtyqgsr7wt4k7TzJ8fiYym+tRt
         GwiwvJahxRrSl9ZSkhak5IVvSqDHExvUtpF0bYQGqszz6VIHDg6JwwHfw0Dxyv/v0Fgq
         484xsJ7VjfaxCxVZ99CWIiU7qxWea4H/0g1eaID58IgQczshDw2iVREnzScZPXZXHCmy
         JVCU0pFBqLrU+6eojCuBe8EPCe0qCJ1P6c3a2J5U5WcwEib+YdsYk8eAHK1PcYa1ko1o
         jDI4417ikvNLoDAs1ITJcOdxdsls5vyxEj7EgFTiwcnl9TPLnNqKITNZnfKT8QWN5T3M
         zU6A==
X-Gm-Message-State: AOJu0Yw06DUyyQfBjlCEWDf5Je9HobxylaeryiighmCecS8JKxHZcRD7
	sbmDdXfmkHti6hK1lYDxIvbqhX0iHEZlUqdzWXRyexaSyGnyWT/P
X-Google-Smtp-Source: AGHT+IExa/amRcnvx1JDOXu2DQFvrennOREOC7ty+Q0OL1T9VDw8vUGlgBcD0rQBaDIk0xEKUEGyiA==
X-Received: by 2002:adf:ffc6:0:b0:374:c075:ff34 with SMTP id ffacd0b85a97d-376dea47229mr256659f8f.38.1725362184194;
        Tue, 03 Sep 2024 04:16:24 -0700 (PDT)
Received: from krava ([87.202.122.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1b0a62esm8583152f8f.47.2024.09.03.04.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 04:16:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Sep 2024 14:16:20 +0300
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC bpf-next 1/3] libbpf: Support aliased symbols in linker
Message-ID: <ZtbwBA8CG8s--8dt@krava>
References: <cover.1725016029.git.vmalik@redhat.com>
 <87e9970b63dede4a19ec62ec572e224eecc26fa3.1725016029.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e9970b63dede4a19ec62ec572e224eecc26fa3.1725016029.git.vmalik@redhat.com>

On Mon, Sep 02, 2024 at 08:58:01AM +0200, Viktor Malik wrote:
> It is possible to create multiple BPF programs sharing the same
> instructions using the compiler `__attribute__((alias("...")))`:
> 
>     int BPF_PROG(prog)
>     {
>         [...]
>     }
>     int prog_alias() __attribute__((alias("prog")));
> 
> This may be convenient when creating multiple programs with the same
> instruction set attached to different events (such as bpftrace does).
> 
> One problem in this situation is that Clang doesn't generate a BTF entry
> for `prog_alias` which makes libbpf linker fail when processing such a
> BPF object.

this might not solve all the issues, but could we change pahole to
generate BTF FUNC for alias function symbols?

jirka

> 
> This commits adds support for that by finding another symbol at the same
> address for which a BTF entry exists and using that entry in the linker.
> This allows to use the linker (e.g. via `bpftool gen object ...`) on BPF
> objects containing aliases.
> 
> Note that this won't be sufficient for most programs as we also need to
> add support for handling relocations in the aliased programs. This will
> be added by the following commit.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/lib/bpf/linker.c | 68 +++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 9cd3d4109788..5ebc9ff1246e 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -1688,6 +1688,34 @@ static bool btf_is_non_static(const struct btf_type *t)
>  	       || (btf_is_func(t) && btf_func_linkage(t) != BTF_FUNC_STATIC);
>  }
>  
> +static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
> +				   int sym_type, const char *sym_name)
> +{
> +	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
> +	Elf64_Sym *sym = symtab->data->d_buf;
> +	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
> +	int str_sec_idx = symtab->shdr->sh_link;
> +	const char *name;
> +
> +	for (i = 0; i < n; i++, sym++) {
> +		if (sym->st_shndx != sec_idx)
> +			continue;
> +		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
> +			continue;
> +
> +		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
> +		if (!name)
> +			return NULL;
> +
> +		if (strcmp(sym_name, name) != 0)
> +			continue;
> +
> +		return sym;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sym_name,
>  			     int *out_btf_sec_id, int *out_btf_id)
>  {
> @@ -1695,6 +1723,7 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
>  	const struct btf_type *t;
>  	const struct btf_var_secinfo *vi;
>  	const char *name;
> +	Elf64_Sym *s;
>  
>  	if (!obj->btf) {
>  		pr_warn("failed to find BTF info for object '%s'\n", obj->filename);
> @@ -1710,8 +1739,15 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
>  		 */
>  		if (btf_is_non_static(t)) {
>  			name = btf__str_by_offset(obj->btf, t->name_off);
> -			if (strcmp(name, sym_name) != 0)
> -				continue;
> +			if (strcmp(name, sym_name) != 0) {
> +				/* the symbol that we look for may not have BTF as it may
> +				 * be an alias of another symbol; we check if this is
> +				 * the original symbol and if so, we use its BTF id
> +				 */
> +				s = find_sym_by_name(obj, sym->st_shndx, STT_FUNC, name);
> +				if (!s || s->st_value != sym->st_value)
> +					continue;
> +			}
>  
>  			/* remember and still try to find DATASEC */
>  			btf_id = i;
> @@ -2132,34 +2168,6 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
>  	return 0;
>  }
>  
> -static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
> -				   int sym_type, const char *sym_name)
> -{
> -	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
> -	Elf64_Sym *sym = symtab->data->d_buf;
> -	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
> -	int str_sec_idx = symtab->shdr->sh_link;
> -	const char *name;
> -
> -	for (i = 0; i < n; i++, sym++) {
> -		if (sym->st_shndx != sec_idx)
> -			continue;
> -		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
> -			continue;
> -
> -		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
> -		if (!name)
> -			return NULL;
> -
> -		if (strcmp(sym_name, name) != 0)
> -			continue;
> -
> -		return sym;
> -	}
> -
> -	return NULL;
> -}
> -
>  static int linker_fixup_btf(struct src_obj *obj)
>  {
>  	const char *sec_name;
> -- 
> 2.46.0
> 

