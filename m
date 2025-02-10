Return-Path: <bpf+bounces-51049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12219A2FB24
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5ECA3A5FEA
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F571BDA89;
	Mon, 10 Feb 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4ZJaU32"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A8264609;
	Mon, 10 Feb 2025 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221030; cv=none; b=ZRLp/GtMBq65bfG3UuLui5t3ldi3JjF1giJJ/dZrc2BW6Nvyeoc8qC5FNP71hO2FHCnXm7vKTpsrkkz4XIts8QtI8V8cXOkB1q1L2CPsI7yJQG22+lGbpnbn6zefVVbBN24HMOsH6CYOHOJxVTU2mKEuIkVdEL9KVsBqZcxLwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221030; c=relaxed/simple;
	bh=UhJW72683R3Q+lyVf9UaFRZj2KU90HIu69PIZbsRMhs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nq0KW8+wAmiOnBb/FVDU/UILpcFTBE0Tjtm5A9QjzWpanhN8+5SFeqvHNG8aq0N/hFdLr8YsUznaA2qIj+ewy9NuYfItfvGkaV7cZMi8RJ9dle9gbdVjZFFeG0BdGJpCTHKC6G6J1N5tk5Q5CETTRvTdF3xuFDywsJ3D/Nk/qsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4ZJaU32; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f92258aa6so40008965ad.3;
        Mon, 10 Feb 2025 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739221028; x=1739825828; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eNNdNjKpO0UWZNVC6Qa5gHUcXPnEusrX11Ztv0IYjWc=;
        b=T4ZJaU32HkuVTRF42LxwsLTiXdtsqhmH964wG0ifYfnzoV8VMXiPqcbsWXRfakoQqL
         sZSAT3GCUXemN2eVgJwGSfjaQhH+zriYu69Tf/jikY0Kh2cGzwUWUwEZvz09MayyWsHO
         Y6XIG73Z+qQMJhKO9nxKfgEetrmaYuRx3vPd6Gz5a3ogjbdLnYFa2cGJRgQyLX7+sQFd
         PIAM4Qp7Y8DIYkQorrQF0gPiw75k4vIDeTODw+v0TdKXBC1k5ri40EDtABSVC1/vrhJN
         K7mi5eTPojwhjZRbrJeTrPC0zHByeJ0yosRdMMgcFhW+xeXWSpPSxqwOCt07LkgxTc6E
         XECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739221028; x=1739825828;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNNdNjKpO0UWZNVC6Qa5gHUcXPnEusrX11Ztv0IYjWc=;
        b=qAQR640ilovYYNcFq4wii6rTSUPfD15CA7+Ir9P8QUuiLDRR53bO1XgpBicDs/+KpG
         Kj+eWE3qFEIqEnwkxe4szQn1fIqVCr5I/l7gViQOCZtQC2md5vnlRQCgIrtR+QKmPd5W
         xEW2/PkP9k93r0mPw5siSfVLgpKT1t5eBkezn7O4JF/1gLzBhXmKI7cFKaRZS/mKe61y
         3kl00D6HQCymCJLrknpHBqbrurRvghvcORPZj4OKWpuhCUBcpYgIiGQuxMDE8WOQhmRs
         0Wqfv8Fs+4tVQO3YYTT4TAx2kxbK8/x/xvrQE54inElXMWR3jhU3/u7pmg8KMFAICOwr
         08QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVh8eBN7WQR7QOMRgyikSGv+MxuSqgkFsA5wXJ+8fwbeqN6V3Mld1R0tBfetWA0NH8jMauKUdgwg==@vger.kernel.org, AJvYcCVpMTWVQubFTRTO7URG9U65AoWga++LkZzjUAqB8gVi2vfxlw8sV0OOlCqOWVuVhsILHDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQa111IWmWLZhxkQjTPaYCMwtZWAUaCzrFCzkk/Ioy/Ot8nm1
	t2/4rJp5KumyZcMfzm6qU0E9unN2cHdZPY9kTrLY4v/Bo2f/EcpJ
X-Gm-Gg: ASbGncuQpFz49+idx4bZFKT6LVJp5QKYQ0WTEdw4l64RZQ4yaVM3TIDAqIxFSiDOp+q
	sLDglE8daMnbIm9KeZNYR21WfzprxBkTveED5wJNyBIUe0iwXj9mkFte/Z+uG7FWGPCwXt6KPcu
	QqEhSAuLSzfHQboeSQe4xRE/QMfJfjZ4CpvoJVxGSJNE7PGQjd4KPC3F6YJprlwCWhepSQpiKfi
	w1bzvvBrzRtwf5DnmUQ/6es5YwP15h0IsPNA8jWhmpFVmkCNGwZNu7ZHGbwA3w0a6ffi6j2VjMh
	YkCaJfvQ2sgg
X-Google-Smtp-Source: AGHT+IH2aJgRCueE1Bda7oylKc6ARRESJefFBHlyWD3ExIghaZ3M6X/JNmZZXdBWp0KPc9Go25ZXzw==
X-Received: by 2002:a05:6a20:c707:b0:1ed:a524:5567 with SMTP id adf61e73a8af0-1ee03a242d9mr25352528637.9.1739221027849;
        Mon, 10 Feb 2025 12:57:07 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7309569d5e4sm1775510b3a.162.2025.02.10.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:57:07 -0800 (PST)
Message-ID: <3782640a577e6945c86d6330bc8a05018a1e5c52.camel@gmail.com>
Subject: Re: [PATCH dwarves 1/3] btf_encoder: collect kfuncs info in
 btf_encoder__new
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, 	mykolal@fb.com, kernel-team@meta.com
Date: Mon, 10 Feb 2025 12:57:02 -0800
In-Reply-To: <20250207021442.155703-2-ihor.solodrai@linux.dev>
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
	 <20250207021442.155703-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 18:14 -0800, Ihor Solodrai wrote:
> From: Ihor Solodrai <ihor.solodrai@pm.me>
>=20
> btf_encoder__tag_kfuncs() is a post-processing step of BTF encoding,
> executed right before BTF is deduped and dumped to the output.
>=20
> Split btf_encoder__tag_kfuncs() routine in two parts:
>   * btf_encoder__collect_kfuncs()
>   * btf_encoder__tag_kfuncs()
>=20
> btf_encoder__collect_kfuncs() reads the .BTF_ids section of the ELF,
> collecting kfunc information into a list of kfunc_info structs in the
> btf_encoder. It is executed in btf_encoder__new() when tag_kfuncs flag
> is set. This way kfunc information is available during entire lifetime
> of the btf_encoder.
>=20
> btf_encoder__tag_kfuncs() is basically the same: collect BTF
> functions, and then for each kfunc find and tag correspoding BTF
> func. Except now kfunc information is not collected in-place, but is
> simply read from the btf_encoder.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Tbh, I don't think this split is necessary, modifying btf_type
in-place should be fine (and libbpf does it at-least in one place).
E.g. like here:
https://github.com/acmel/dwarves/compare/master...eddyz87:dwarves:arena-att=
rs-no-split
I like it because it keeps the change a bit more contained,
but I do not insist.

[...]

> @@ -1876,11 +1886,10 @@ static int btf_encoder__tag_kfunc(struct btf_enco=
der *encoder, struct gobuffer *
>  	return 0;
>  }
> =20
> -static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
>  {
>  	const char *filename =3D encoder->source_filename;
>  	struct gobuffer btf_kfunc_ranges =3D {};
> -	struct gobuffer btf_funcs =3D {};
>  	Elf_Data *symbols =3D NULL;
>  	Elf_Data *idlist =3D NULL;
>  	Elf_Scn *symscn =3D NULL;
> @@ -1897,6 +1906,8 @@ static int btf_encoder__tag_kfuncs(struct btf_encod=
er *encoder)
>  	int nr_syms;
>  	int i =3D 0;
> =20
> +	INIT_LIST_HEAD(&encoder->kfuncs);
> +

Nit: do this in the btf_encoder__new?

>  	fd =3D open(filename, O_RDONLY);
>  	if (fd < 0) {
>  		fprintf(stderr, "Cannot open %s\n", filename);
> @@ -1977,12 +1988,6 @@ static int btf_encoder__tag_kfuncs(struct btf_enco=
der *encoder)
>  	}
>  	nr_syms =3D shdr.sh_size / shdr.sh_entsize;
> =20
> -	err =3D btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
> -	if (err) {
> -		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
> -		goto out;
> -	}
> -
>  	/* First collect all kfunc set ranges.
>  	 *
>  	 * Note we choose not to sort these ranges and accept a linear
> @@ -2015,12 +2020,13 @@ static int btf_encoder__tag_kfuncs(struct btf_enc=
oder *encoder)
>  	for (i =3D 0; i < nr_syms; i++) {
>  		const struct btf_kfunc_set_range *ranges;
>  		const struct btf_id_and_flag *pair;
> +		struct elf_function *elf_fn;
> +		struct kfunc_info *kfunc;
>  		unsigned int ranges_cnt;
>  		char *func, *name;
>  		ptrdiff_t off;
>  		GElf_Sym sym;
>  		bool found;
> -		int err;
>  		int j;
> =20
>  		if (!gelf_getsym(symbols, i, &sym)) {
> @@ -2061,18 +2067,26 @@ static int btf_encoder__tag_kfuncs(struct btf_enc=
oder *encoder)
>  			continue;
>  		}
> =20
> -		err =3D btf_encoder__tag_kfunc(encoder, &btf_funcs, func, pair->flags)=
;
> -		if (err) {
> -			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> -			free(func);
> +		elf_fn =3D btf_encoder__find_function(encoder, func, 0);
> +		free(func);
> +		if (!elf_fn)
> +			continue;
> +		elf_fn->kfunc =3D true;
> +
> +		kfunc =3D calloc(1, sizeof(*kfunc));
> +		if (!kfunc) {
> +			fprintf(stderr, "%s: failed to allocate memory for kfunc info\n", __f=
unc__);
> +			err =3D -ENOMEM;
>  			goto out;
>  		}
> -		free(func);
> +		kfunc->id =3D pair->id;
> +		kfunc->flags =3D pair->flags;
> +		kfunc->name =3D elf_fn->name;

If we do go with split, maybe make refactoring a bit more drastic and
merge kfunc_info with elf_function?
This would make maintaining a separate encoder->kfuncs list unnecessary.
Also, can get rid of separate 'struct gobuffer *funcs'.
E.g. see my commit on top of yours:
https://github.com/acmel/dwarves/compare/master...eddyz87:dwarves:arena-att=
rs-merge-kfunc-info

> +		list_add(&kfunc->node, &encoder->kfuncs);
>  	}
> =20
>  	err =3D 0;
>  out:
> -	__gobuffer__delete(&btf_funcs);
>  	__gobuffer__delete(&btf_kfunc_ranges);
>  	if (elf)
>  		elf_end(elf);
> @@ -2081,6 +2095,34 @@ out:
>  	return err;
>  }
> =20

[...]


