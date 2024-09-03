Return-Path: <bpf+bounces-38777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC872969FFB
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1141F26118
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3306257CA7;
	Tue,  3 Sep 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXInsSvK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5A1891BB
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372539; cv=none; b=iVD6GcYnnb9kiGYV6SSJsNyvQWo+FgcnOUkZ8fQp8Cz2k8sxM7sXJmtu/JI+g8HkFXIlIaDNE2tt2fiY/cTEhGossvUxA1Oa4oMjXFQvdK6z5G0rnmh88W2if+yOrVvNvEzpQbtbosM2dGazH3v7gVREvz0b/XX8FYo0WKHSncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372539; c=relaxed/simple;
	bh=r6yCtDhYTXGtceKbqBcmT7XfUQ5fyvGAnGrDHXA7/00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqGNez8/Kz13YFBRcLiEreYJdKQ1OKsUjUGp/DfeK8aE+0B/VcluWBavTHdljiJ0Kyv/w66PDM/5yXr3VUMzT/v1SwTBFGxZlCD3uegNCOWHS0d4+pCAc9bueaAlPKNJNUk3QQ7a2kD1r12h0cbjHbLh8GsTi9LLk2VxGNL3vaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXInsSvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B8FC4CEC4;
	Tue,  3 Sep 2024 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725372539;
	bh=r6yCtDhYTXGtceKbqBcmT7XfUQ5fyvGAnGrDHXA7/00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXInsSvK9vL/05b2zPRuaGtCveahkpJxK189H5lK7nY7Ehb1tVlaVWGN0lp5D8zLv
	 Sx8Tu2yPSbEBcjvyZBQy6RbkE/wLXGz0dUfFzquuNLxG49uUDoHEZqlegrAC5P6Aa7
	 LKqAaVo0g0zMc6iefz6/kK6eJS6Jo62D2x7CuZSDUcWdsCe93qYrnmJJ4vQvoA/gX9
	 s5MTPDsXd34tuGRGC6o1Uv1YB1cT1wQXLyCHEDBS8cHd25qXwT9jCv52sqOsjVOcC8
	 qo83qLdRY5X522USTjYY7qr/NxwbCzk4keljT5OVKCULNiV4mzvvOIcGpvC84l5rsW
	 47lr27AE8xkSw==
Date: Tue, 3 Sep 2024 11:08:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Viktor Malik <vmalik@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: Re: [RFC bpf-next 1/3] libbpf: Support aliased symbols in linker
Message-ID: <ZtcYdx8vZAbl_OVf@x1>
References: <cover.1725016029.git.vmalik@redhat.com>
 <87e9970b63dede4a19ec62ec572e224eecc26fa3.1725016029.git.vmalik@redhat.com>
 <ZtbwBA8CG8s--8dt@krava>
 <19327b3c-efe0-4242-a8bc-5ede33570cf9@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19327b3c-efe0-4242-a8bc-5ede33570cf9@redhat.com>

On Tue, Sep 03, 2024 at 03:08:25PM +0200, Viktor Malik wrote:
> On 9/3/24 13:16, Jiri Olsa wrote:
> > On Mon, Sep 02, 2024 at 08:58:01AM +0200, Viktor Malik wrote:
> >> It is possible to create multiple BPF programs sharing the same
> >> instructions using the compiler `__attribute__((alias("...")))`:
> >>
> >>     int BPF_PROG(prog)
> >>     {
> >>         [...]
> >>     }
> >>     int prog_alias() __attribute__((alias("prog")));
> >>
> >> This may be convenient when creating multiple programs with the same
> >> instruction set attached to different events (such as bpftrace does).
> >>
> >> One problem in this situation is that Clang doesn't generate a BTF entry
> >> for `prog_alias` which makes libbpf linker fail when processing such a
> >> BPF object.
> > 
> > this might not solve all the issues, but could we change pahole to
> > generate BTF FUNC for alias function symbols?
> 
> I don't think that would work here. First, we don't usually run pahole
> when building BPF objects, it's Clang which generates BTF for the "bpf"
> target directly. Second, AFAIK, pahole converts DWARF to BTF and
> compilers don't generate DWARF entries for alias function symbols either.

So, pahole adds BTF info that doesn't come from DWARF, and it could read
the BTF generated by clang for the bpf target and ammend/augment/add to
it if that would allow us to have something we need and that isn't
currently (or planned) to be supported by clang.

I.e. we have a BTF loader, we could pair it with the BPF encoder, in
addition to the usual DWARF Loader + BPF encoder as what the loaders do
is to generate internal representation that is then consumed by the
pretty printer or the BTF encoder.

In this case the BTF encoder would use what is the internal
representation, that it doesn't even know came from a BPF object
generated by clang's BPF target, and would add this extra aliases, if we
can get it from somewhere else.

- Arnaldo
 
> Viktor
> 
> > 
> > jirka
> > 
> >>
> >> This commits adds support for that by finding another symbol at the same
> >> address for which a BTF entry exists and using that entry in the linker.
> >> This allows to use the linker (e.g. via `bpftool gen object ...`) on BPF
> >> objects containing aliases.
> >>
> >> Note that this won't be sufficient for most programs as we also need to
> >> add support for handling relocations in the aliased programs. This will
> >> be added by the following commit.
> >>
> >> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >> ---
> >>  tools/lib/bpf/linker.c | 68 +++++++++++++++++++++++-------------------
> >>  1 file changed, 38 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> >> index 9cd3d4109788..5ebc9ff1246e 100644
> >> --- a/tools/lib/bpf/linker.c
> >> +++ b/tools/lib/bpf/linker.c
> >> @@ -1688,6 +1688,34 @@ static bool btf_is_non_static(const struct btf_type *t)
> >>  	       || (btf_is_func(t) && btf_func_linkage(t) != BTF_FUNC_STATIC);
> >>  }
> >>  
> >> +static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
> >> +				   int sym_type, const char *sym_name)
> >> +{
> >> +	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
> >> +	Elf64_Sym *sym = symtab->data->d_buf;
> >> +	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
> >> +	int str_sec_idx = symtab->shdr->sh_link;
> >> +	const char *name;
> >> +
> >> +	for (i = 0; i < n; i++, sym++) {
> >> +		if (sym->st_shndx != sec_idx)
> >> +			continue;
> >> +		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
> >> +			continue;
> >> +
> >> +		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
> >> +		if (!name)
> >> +			return NULL;
> >> +
> >> +		if (strcmp(sym_name, name) != 0)
> >> +			continue;
> >> +
> >> +		return sym;
> >> +	}
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >>  static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sym_name,
> >>  			     int *out_btf_sec_id, int *out_btf_id)
> >>  {
> >> @@ -1695,6 +1723,7 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
> >>  	const struct btf_type *t;
> >>  	const struct btf_var_secinfo *vi;
> >>  	const char *name;
> >> +	Elf64_Sym *s;
> >>  
> >>  	if (!obj->btf) {
> >>  		pr_warn("failed to find BTF info for object '%s'\n", obj->filename);
> >> @@ -1710,8 +1739,15 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
> >>  		 */
> >>  		if (btf_is_non_static(t)) {
> >>  			name = btf__str_by_offset(obj->btf, t->name_off);
> >> -			if (strcmp(name, sym_name) != 0)
> >> -				continue;
> >> +			if (strcmp(name, sym_name) != 0) {
> >> +				/* the symbol that we look for may not have BTF as it may
> >> +				 * be an alias of another symbol; we check if this is
> >> +				 * the original symbol and if so, we use its BTF id
> >> +				 */
> >> +				s = find_sym_by_name(obj, sym->st_shndx, STT_FUNC, name);
> >> +				if (!s || s->st_value != sym->st_value)
> >> +					continue;
> >> +			}
> >>  
> >>  			/* remember and still try to find DATASEC */
> >>  			btf_id = i;
> >> @@ -2132,34 +2168,6 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
> >>  	return 0;
> >>  }
> >>  
> >> -static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
> >> -				   int sym_type, const char *sym_name)
> >> -{
> >> -	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
> >> -	Elf64_Sym *sym = symtab->data->d_buf;
> >> -	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
> >> -	int str_sec_idx = symtab->shdr->sh_link;
> >> -	const char *name;
> >> -
> >> -	for (i = 0; i < n; i++, sym++) {
> >> -		if (sym->st_shndx != sec_idx)
> >> -			continue;
> >> -		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
> >> -			continue;
> >> -
> >> -		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
> >> -		if (!name)
> >> -			return NULL;
> >> -
> >> -		if (strcmp(sym_name, name) != 0)
> >> -			continue;
> >> -
> >> -		return sym;
> >> -	}
> >> -
> >> -	return NULL;
> >> -}
> >> -
> >>  static int linker_fixup_btf(struct src_obj *obj)
> >>  {
> >>  	const char *sec_name;
> >> -- 
> >> 2.46.0
> >>
> > 

