Return-Path: <bpf+bounces-76520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B5CB8588
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 09:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5DA23028F7A
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05C30B511;
	Fri, 12 Dec 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W87UPNQP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BE2741A0
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529884; cv=none; b=fhogo0s1XuZj40tbDfQjuEp+78A5etFb/Rx5lWJqDWSrngJp4WlgkPY8wIX0az6UNVfcplMtl/bYEz9fLSBGSkh3c35YHakRjMX0j26vl/7bXMhqEW/GgeEtA9W3lxNA5YpM0R+mVozs8vKS5DEOGOPRscooqzM5dCPJsbqxfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529884; c=relaxed/simple;
	bh=PcDog/To0UjbKuyFLuDAwEJCCxk0v1Bgpl+ObyVOA/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ggdV/Yr195u+u6mAu5zvCkBG/ctZBE/77xnWFy0GNAfvCYQlTSidywRfWIgTqoG97XNWEcDfcc8+LR7X4plIrJ/jjk7akFCJxS5W7gY+JLDG8m3xOMxKKk4zPEYlvyO/ciZgdRfOh1esESreWhnoyL+QMW+OfeGDrFIerkQyAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W87UPNQP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-888310b91c5so9267476d6.1
        for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765529882; x=1766134682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HA/4sr3TqfG74qmcWJYKn1Au1cNj4XE5l8roaw6U9kQ=;
        b=W87UPNQPqCTBDdLCQj+TZQyV6qMZobyMn+sy0hFJ/vYdPYGa7V8/eHE1Bq4EdpKFQl
         13uOopJYmsyRip51YfFVR/Mt1hk7rcZRF/3WqZfwbGexL9G6itkoPrfF/UzbpjDlQLZG
         bCPSLzmQ89WJiBUZNaDLCemaqQqLCEnkspkJI1UiepjkNvydmzr0VPJZrcN1O/7veIIE
         oGWZ94RGts1kgDxTAoxg500lhqlCmsWsyXiOUm/ePK83WzSrABNcUMxMxC6Fd4yD0Zw6
         RSy2tZb0Pga8e5kdukTZAk/UoWlmflTf6mrXBHr9hhYIxXDPPBse3IFFul6yAfMCmA/6
         u4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765529882; x=1766134682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HA/4sr3TqfG74qmcWJYKn1Au1cNj4XE5l8roaw6U9kQ=;
        b=udTrLFmoZ5krVT/mEjS2L/eg0vVhKuNWEoZEdoiM+s1f0IW5OPa+vB+GrSLJy1Deaq
         lRYyEBVfyyaLvv504TU2WgYfa73sQlAL9ckzeRUU34qpAmOq7k5PQVEl3qchpl7gzsjq
         5sU3tQrdb5AUJZpw9bzETH6uZI7OfsBGQDuXr4EBQBm/1uQNqwRv8cJGZE7MKVjZidpU
         jUJm5dQVvSzNx82UVU9DG/vzmG3P1k7CPbuGuBueh6lvdc+CynpbMcIyIg41u4D1AyOc
         6V6P1yuhmfmLdg9PGRdYIDzMGra2ou+HRAGL699yv5QnhgejZIim5HOahIc3FgjL8Nlh
         9G1Q==
X-Gm-Message-State: AOJu0YwXj0ruMT0YwK7PBvP0wn+HEHvYIK5okncUFsjeehUrrHVm24rP
	1u0aMpRuKxQOxPsbHYRF9hKylAl8pQoSXK5XfzcYZrtzPKoO3YwM8AZgV5K5mSPF
X-Gm-Gg: AY/fxX6xIbChSUiWeaV9X/iSmTUFasdjiBqkkQ2s1FTuSei7vdKhcuMh3c7qKhmN7LA
	66kJhxnLi6VtTKCSw6IlHquxONV8do9UJwPYdSU+DtUmERoTGSycJy9OWX2Ok1vzXQFq9ZHR243
	snXZduCm8Wv4G9JkeSqRw3atN/JDNyMd/O89+CoSl8phUhh9nXb7ZlNWaPhI2xlzZa6z17d+1bl
	BTnsYGrDBPolqwTSW3ukAO9CzTiPdV60eXgHFpsWK2XCYcpbdFzjRic5ch3EO0A95PbXkiquhH4
	8DxI60jHXw+Kh2SX0FewrIUeCvhzj0PL7N40NMBjUyRH9BOn1D7xBGLd4+iGVpe6lqmsUwzatUG
	9HjU7S6DDc4j95K+RZfVBXoJ7qclCzBpwyUc6lkPWu3GT0K0h530UrNTKZ8rafsGmc62c4j1JFC
	hxUAm8kvQp0EJHlEQr+UDiacRDcA5qrPk/TgdxLUq42r4=
X-Google-Smtp-Source: AGHT+IFWTMFJQMKXlJUDxuMrVm62gSFXENwTcyB18RGeM1BcBDoReByl3fxu8tZ+slqa0tRQxxkuxQ==
X-Received: by 2002:a17:902:d3ca:b0:298:68e:4042 with SMTP id d9443c01a7336-29eeec1d557mr31575955ad.26.1765523343711;
        Thu, 11 Dec 2025 23:09:03 -0800 (PST)
Received: from [10.200.2.32] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38b98sm44760935ad.34.2025.12.11.23.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:09:03 -0800 (PST)
Message-ID: <b11c1ae3816842f7b1768072982680c0bc80d8f4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] resolve_btfids: change in-place update
 with raw binary output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Fri, 12 Dec 2025 16:08:54 +0900
In-Reply-To: <20251205223554.4159772-1-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-6-ihor.solodrai@linux.dev>
	 <20251205223554.4159772-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 14:35 -0800, Ihor Solodrai wrote:
> Currently resolve_btfids updates .BTF_ids section of an ELF file
> in-place, based on the contents of provided BTF, usually within the
> same input file, and optionally a BTF base.
>=20
> Change resolve_btfids behavior to enable BTF transformations as part
> of its main operation. To achieve this, in-place ELF write in
> resolve_btfids is replaced with generation of the following binaries:
>   * ${1}.BTF with .BTF section data
>   * ${1}.BTF_ids with .BTF_ids section data if it existed in ${1}
>   * ${1}.BTF.base with .BTF.base section data for out-of-tree modules
>=20
> The execution of resolve_btfids and consumption of its output is
> orchestrated by scripts/gen-btf.sh introduced in this patch.
>=20
> The motivation for emitting binary data is that it allows simplifying
> resolve_btfids implementation by delegating ELF update to the $OBJCOPY
> tool [1], which is already widely used across the codebase.
>=20
> There are two distinct paths for BTF generation and resolve_btfids
> application in the kernel build: for vmlinux and for kernel modules.
>=20
> For the vmlinux binary a .BTF section is added in a roundabout way to
> ensure correct linking. The patch doesn't change this approach, only
> the implementation is a little different.
>=20
> Before this patch it worked as follows:
>=20
>   * pahole consumed .tmp_vmlinux1 [2] and added .BTF section with
>     llvm-objcopy [3] to it
>   * then everything except the .BTF section was stripped from .tmp_vmlinu=
x1
>     into a .tmp_vmlinux1.bpf.o object [2], later linked into vmlinux
>   * resolve_btfids was executed later on vmlinux.unstripped [4],
>     updating it in-place
>=20
> After this patch gen-btf.sh implements the following:
>=20
>   * pahole consumes .tmp_vmlinux1 and produces a *detached* file with
>     raw BTF data
>   * resolve_btfids consumes .tmp_vmlinux1 and detached BTF to produce
>     (potentially modified) .BTF, and .BTF_ids sections data
>   * a .tmp_vmlinux1.bpf.o object is then produced with objcopy copying
>     BTF output of resolve_btfids
>   * .BTF_ids data gets embedded into vmlinux.unstripped in
>     link-vmlinux.sh by objcopy --update-section
>=20
> For kernel modules, creating a special .bpf.o file is not necessary,
> and so embedding of sections data produced by resolve_btfids is
> straightforward with objcopy.
>=20
> With this patch an ELF file becomes effectively read-only within
> resolve_btfids, which allows deleting elf_update() call and satellite
> code (like compressed_section_fix [5]).
>=20
> Endianness handling of .BTF_ids data is also changed. Previously the
> "flags" part of the section was bswapped in sets_patch() [6], and then
> Elf_Type was modified before elf_update() to signal to libelf that
> bswap may be necessary. With this patch we explicitly bswap entire
> data buffer on load and on dump.
>=20
> [1] https://lore.kernel.org/bpf/131b4190-9c49-4f79-a99d-c00fac97fa44@linu=
x.dev/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/link-vmlinux.sh?h=3Dv6.18#n110
> [3] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encod=
er.c?h=3Dv1.31#n1803
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/link-vmlinux.sh?h=3Dv6.18#n284
> [5] https://lore.kernel.org/bpf/20200819092342.259004-1-jolsa@kernel.org/
> [6] https://lore.kernel.org/bpf/cover.1707223196.git.vmalik@redhat.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -552,6 +528,13 @@ static int symbols_collect(struct object *obj)
>  	return 0;
>  }
> =20
> +static inline bool is_envvar_set(const char *var_name)
> +{
> +	const char *value =3D getenv(var_name);
> +
> +	return value && value[0] !=3D '\0';
> +}
> +

This is a leftover, not used anywhere.

[...]

> @@ -860,23 +913,34 @@ int main(int argc, const char **argv)
>  	 */
>  	if (obj.efile.idlist_shndx =3D=3D -1 ||
>  	    obj.efile.symbols_shndx =3D=3D -1) {
> -		pr_debug("Cannot find .BTF_ids or symbols sections, nothing to do\n");
> -		err =3D 0;
> -		goto out;
> +		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resol=
ution\n");
> +		goto dump_btf;
>  	}
> =20
>  	if (symbols_collect(&obj))
>  		goto out;
> =20
> -	if (load_btf(&obj))
> -		goto out;
> -
>  	if (symbols_resolve(&obj))
>  		goto out;
> =20
>  	if (symbols_patch(&obj))
>  		goto out;
> =20
> +	err =3D make_out_path(out_path, obj.path, BTF_IDS_SECTION);
> +	if (err || dump_raw_btf_ids(&obj, out_path))
> +		goto out;
> +
> +dump_btf:
> +	err =3D make_out_path(out_path, obj.path, BTF_ELF_SEC);
> +	if (err || dump_raw_btf(obj.btf, out_path))

Nit: 'err' is not set if dump_raw_btf() errors out.
     Maybe use:

     	   err =3D make_out_path(out_path, obj.path, BTF_ELF_SEC);
     	   err =3D err ?: dump_raw_btf(obj.btf, out_path);
	   if (err)
	      goto out;
     ?

> +		goto out;
> +
> +	if (obj.base_btf && obj.distill_base) {
> +		err =3D make_out_path(out_path, obj.path, BTF_BASE_ELF_SEC);
> +		if (err || dump_raw_btf(obj.base_btf, out_path))
> +			goto out;
> +	}
> +
>  	if (!(fatal_warnings && warnings))
>  		err =3D 0;
>  out:

[...]

