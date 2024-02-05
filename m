Return-Path: <bpf+bounces-21235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDEA849FFA
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016E4281DBA
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19B63F8DA;
	Mon,  5 Feb 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNzRfYcg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0973D392
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152080; cv=none; b=LSLEKPfhoQC2OTdt/I+KHKwP2nbpSzDu7+8NyMpqsFYy8bgYKSnhDMY0iVlErPRn1nwpkWzn2DO//60mv8fBzzJzvmW600eDfna4Hqo9nWBAtsgYRM0xh+QkIWKDau41GGcnDT2jAF/WNy13HVXo3iV5taIiSCD4FiHCCfdmzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152080; c=relaxed/simple;
	bh=ASlXXAmDDq22K917MwOZgM1Zjk/kIVS3mC318THgg0U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Auaz6m79VQZYpcaqpAtFSMvIZrMgUhX8Wx0ysBTt/csmDhbOb7EgXdCuq/rioDIxHtW1wi4oGDafpCZ545jv5vlep5zX9KMjpGxfzCPBOeVkxcUSIVs1Fb5N4EZ7ljb+eXgfuhAx/Xj9XvA8M4gqH0IWCFu2fYHB6etD+rd45BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNzRfYcg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a271a28aeb4so658577066b.2
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 08:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707152077; x=1707756877; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0/bCq24fnk6NDdKHZjMeVO1Zt7dAdkhawG43bmFtYsw=;
        b=XNzRfYcgwRuv5CarVILm4Pezh/Sr7KdmP83OcGrmmwHKN2v33/TL7dyuMdinxdCJdS
         hdPquboClSYfV6rTuNW9U63V221zLYb0ili61GtH6UTIW63DVi4Wnvg+vhbkfVfnIPcf
         GlYN+ryWwoE70DE8qMrxnHnZt3JmCeCqX3AUwlqhrUt/qQKWQXKUJB4sKpf/STJpYHxV
         Zd7yClt1KhmjobFPMSFUaWgd/eLOVz7zZCoTvlxNQJuqAgcpPxG67qVrAx87GpEF0qWu
         oYgy+mcXaPW1mUODO/UZvCJq2dlvFgfpmJcjYkuEF6aPhkELC0tmNqJdcaLmHfDFsqxC
         QsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152077; x=1707756877;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/bCq24fnk6NDdKHZjMeVO1Zt7dAdkhawG43bmFtYsw=;
        b=Ts7LmvgYvT+k6a0t+vXhehikHfE3H5ueX67oSnP09baJuOI+Mk7Ditob8tL3qK/cT8
         J5qApLqln+4n0El+QG2QpxxoYLRDRNPcUNXS/yd7dfFNrrohstgzeocuVteWfuK2xe+m
         x5RdcQoT4Rd25qf4057mZkb4XMF4P3I4K94ns5IeevhNY9VBm5PyTdPkdhipiFqXjZhK
         i7scOwm1F7djHrylNLlysppfJvlt2gI1ZXpDc/Lg02/KauvFM2OqaxeNgXCmkwCwRlKS
         3sVelvGA7G40PCUVROdcyCW95P3hGgzMyFNW04jy+Ugz+KQucigINaQqSxrjnjeXWBX0
         N0jw==
X-Gm-Message-State: AOJu0YxORekBncVNJLowj4RWYfxvAM+sS7U84h3MzSjd0h4aA9M1sWYZ
	3JP7g1gak31Ha7TJKcAJ1pdwLHPNhazf6K79lE4AIUgyElCdM4Ri
X-Google-Smtp-Source: AGHT+IHJyDL+NkCZb3sgXu7ba9nUqLA51Al1TzC7fPgg2mTiLwJXJeoEOvxDOFi6y7UE+HPHnjYfdA==
X-Received: by 2002:a17:907:7f17:b0:a37:69d6:af17 with SMTP id qf23-20020a1709077f1700b00a3769d6af17mr4569ejc.50.1707152076652;
        Mon, 05 Feb 2024 08:54:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUA5Y7syLzUz7tVj6qejgtUKrBaVM198c6H6yUKm9Fs5DbnykUJksjMEY03YjQSJA3IITP0L0kK/R8X2TrIgg7A9JsfTZsiiuy6zqBuwn5pBNbl4G2oN8PdWxOn5jW4a/PKej1c45EGFrcqjyaMOJnV18EVwD0Y2gXNqMLL382NtVxvnDBv1XOL6mkMc5jRe/hQXsC9gk+U+0GkNcaSHr/8LMJUiwjm2CX6fveCZ60V3d3KivJKE7N15Yh88Q==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vk8-20020a170907cbc800b00a36f9e61664sm20269ejc.107.2024.02.05.08.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:54:36 -0800 (PST)
Message-ID: <39f3d8a2163678cb5306caab338e9f3c6b7c003e.camel@gmail.com>
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org, 
	quentin@isovalent.com, alan.maguire@oracle.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Date: Mon, 05 Feb 2024 18:54:34 +0200
In-Reply-To: <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
References: <cover.1707071969.git.dxu@dxuuu.xyz>
	 <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-04 at 11:40 -0700, Daniel Xu wrote:
[...]
> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{
> +	const char *filename =3D encoder->filename;
> +	struct gobuffer btf_kfunc_ranges =3D {};
> +	struct gobuffer btf_funcs =3D {};
> +	Elf_Scn *symscn =3D NULL;
> +	int symbols_shndx =3D -1;
> +	int fd =3D -1, err =3D -1;
> +	int idlist_shndx =3D -1;
> +	Elf_Scn *scn =3D NULL;
> +	size_t idlist_addr;
> +	Elf_Data *symbols;
> +	Elf_Data *idlist;
> +	size_t strtabidx;
> +	Elf *elf =3D NULL;
> +	GElf_Shdr shdr;
> +	size_t strndx;
> +	char *secname;
> +	int nr_syms;
> +	int i =3D 0;

Note: when compiled in Release mode (e.g. using buildcmd.sh from the repo)
there is a number of false-positive warnings reported by GCC 13.2.1:

$ ./buildcmd.sh
...
In function =E2=80=98is_sym_kfunc_set=E2=80=99,
    inlined from =E2=80=98btf_encoder__tag_kfuncs=E2=80=99 at /home/eddy/wo=
rk/dwarves-fork/btf_encoder.c:1639:8,
    inlined from =E2=80=98btf_encoder__encode=E2=80=99 at /home/eddy/work/d=
warves-fork/btf_encoder.c:1724:29:
/home/eddy/work/dwarves-fork/btf_encoder.c:1395:29: warning: =E2=80=98idlis=
t_addr=E2=80=99 may be used uninitialized [-Wmaybe-uninitialized]
 1395 |         off =3D sym->st_value - idlist_addr;
      |               ~~~~~~~~~~~~~~^~~~~~~~~~~~~
/home/eddy/work/dwarves-fork/btf_encoder.c: In function =E2=80=98btf_encode=
r__encode=E2=80=99:
/home/eddy/work/dwarves-fork/btf_encoder.c:1538:16: note: =E2=80=98idlist_a=
ddr=E2=80=99 was declared here
 1538 |         size_t idlist_addr;
      |                ^~~~~~~~~~~
In function =E2=80=98btf_encoder__tag_kfuncs=E2=80=99,
    inlined from =E2=80=98btf_encoder__encode=E2=80=99 at /home/eddy/work/d=
warves-fork/btf_encoder.c:1724:29:

Same thing is reported for:
- btf_encoder.c:1630:22: warning: =E2=80=98symbols=E2=80=99 may be used uni=
nitialized
- btf_encoder.c:1385:15: warning: =E2=80=98idlist=E2=80=99 may be used unin=
itialized
- btf_encoder.c:1638:24: warning: =E2=80=98strtabidx=E2=80=99 may be used u=
ninitialized

GCC does not figure out that the variables above are guarded by -1 checks b=
elow.

[...]
> +	while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
[...]
> +		if (shdr.sh_type =3D=3D SHT_SYMTAB) {
> +			symbols_shndx =3D i;
> +			symscn =3D scn;
> +			symbols =3D data;
> +			strtabidx =3D shdr.sh_link;
> +		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> +			idlist_shndx =3D i;
> +			idlist_addr =3D shdr.sh_addr;
> +			idlist =3D data;
> +		}
> +	}
> +
> +	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
> +	if (symbols_shndx =3D=3D -1 || idlist_shndx =3D=3D -1) {
> +		err =3D 0;
> +		goto out;
> +	}
[...]

