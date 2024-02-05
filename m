Return-Path: <bpf+bounces-21259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B8C84AA89
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 00:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B086B20BCD
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 23:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4B4A990;
	Mon,  5 Feb 2024 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNyQNt6i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A1487B2
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175886; cv=none; b=Q4q4k0XOlsKlX56DYBIz88PJHtDihopgaPsvOmX+LcBnETdI9m8HkFVyWbdBNlFHxGKZCmAYEqpRC5Zwvbff27gzqTNgD8fit41v2KVmAkAjdFGcIbS7DdYTDP+fmne834IpYUUxBPQofpm+vR0RLaMQdUI3xF401oK0lyJNdao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175886; c=relaxed/simple;
	bh=LsJELHbgenZsyX1M0uBb0J1Uw/sT1ORMPdCFrRDwqJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bSqjImPSpZSkiFRS+hfQo82bxr1Z/FrrfKOJ6biERSionez/MngUqJEdMtqUw0uJvWCOg2jAVmeqpxw7JpFGuwyPfiNPegvbmqwAk3is8j1YbJeClfB43YhIO7f7rTMP+kVHTZ5uX6fi0259MFdIKAXE/C1EfCJElRK9VJGHWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNyQNt6i; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d051fb89fbso3020951fa.2
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707175882; x=1707780682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7NoP5yQoarAq5ikTLlS6/hAr8iXE8i2pX20Ez2w5f4c=;
        b=aNyQNt6iSTYNdyiWXu0pOjIM7OKaD8kpOQnERgsi5l1NZvmuzROu44Ewp9XqxdwPLc
         iI9xrXdJoC0Gt8mZL4JBAQdbBR73NYEZ392mGzeJsvtdfJ6jD68dvwJ3wCVWah4mRxUc
         xMG1gEKwji6cMiIWo2OTepD8ARLs7TtNSzVfaTkER5MnICh2emyLYPsHtQcrP3YRnkMh
         IbSr4cwejwfttmoCPNtkd+B/fXzXq95Px62/jAu3OSOwR3EyfbUCCtBJadAVDiEyUyEd
         SDI+EJxo86ghUcYZSSBstN+kcb0hin/2NuAT321nUxnaRuT+VmcfmVKcGFHcX9skdwXH
         72vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707175882; x=1707780682;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NoP5yQoarAq5ikTLlS6/hAr8iXE8i2pX20Ez2w5f4c=;
        b=HwWaMBwt7U9tbDq7OhvLt0D8A763Vn8PiA2LVjRSvsz/9HYlIzUtxVIbnsiMNiWGHa
         09EqpRY5HagpaNIXPAfqYk6kSfmTYj7QU2kcMw6SeGZ7Umw9AhXNQJANu/Ow9zfQvSxw
         9Do2IpwSL+HHxGnliU9TiGx9TOZm2br+xdbimcXM6q3Viebhy+puUHBfIegNacW+mZfa
         BNI8GaIMhA9WNUFHTqe3pRkEfHvGPwveqcpts216Eve9dwOjAHdpDmwaHpC5uVGRW2Dd
         hPIqL6MNWPZNdo+Mkrd94n2k6dEsPL3OAO7F5ZrAsAY9rpY0UVMv3OTCtYFZMAbIL+UQ
         uI5Q==
X-Gm-Message-State: AOJu0Yyv5LCL6IQc+NJaJ/OU2SPYthjDI24h0lrchpSircRzHfwjZubL
	XgBHhpK5lhSoE9wtwVDEzUiKarPUpgLaenI2GcwVWcw3Bpeu9+x8
X-Google-Smtp-Source: AGHT+IE/Ps784E7MSIh36K2s+k7H5rDjCmdsBuLfupjwtYHk2Xpuy9L5DTxcG8VctIZ0j63QsoRTyQ==
X-Received: by 2002:a2e:9611:0:b0:2d0:9efa:6667 with SMTP id v17-20020a2e9611000000b002d09efa6667mr851903ljh.4.1707175881677;
        Mon, 05 Feb 2024 15:31:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwHDchyDeNWYQ0XIjLzZLC9ZU/0MkLoMjsJl2isKlSObRQ7IbM2a/GExNxQG2uL+QOUjPc3tBMWqzUoUvm+KVpD2kU+OVsaxx1TOpX3rTHFR6CnoovB82mB6vncYMO0bnDSQkvW+lGlKYMqdxZZfaqtmyBBZvI4xUWkmJb82a2DXgGTFwRqPkx2E+ZQHV0wSSO8kg9B590hUOUNMHpk+UPYyebQyO1Gx1WpmxvVOWQCsb2ZTvEdWHSRxhJ3A==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x25-20020aa7dad9000000b0055ef0105f2fsm392876eds.80.2024.02.05.15.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:31:21 -0800 (PST)
Message-ID: <1853738ac796d75c53970e21b6d61bf5140a6cc1.camel@gmail.com>
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org, 
	quentin@isovalent.com, alan.maguire@oracle.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Date: Tue, 06 Feb 2024 01:31:20 +0200
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
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
>=20
> Example of encoding:
>=20
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfun=
c'" | wc -l
>         121
>=20
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=3D56336 linkage=3Dst=
atic
>         [127861] DECL_TAG 'bpf_kfunc' type_id=3D56337 component_idx=3D-1
>=20
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

I've tested this patch-set using kernel built both with clang and gcc,
on current bpf-next master (2d9a925d0fbf), both times get 124 kfunc definit=
ions.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

Two nitpicks below.

[...]

> +static char *get_func_name(const char *sym)
> +{
> +	char *func, *end;
> +
> +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> +		return NULL;
> +
> +	/* Strip prefix */
> +	func =3D strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> +
> +	/* Strip suffix */
> +	end =3D strrchr(func, '_');
> +	if (!end || *(end - 1) !=3D '_') {

Nit: this would do out of bounds access on malformed input
     "__BTF_ID__func___"

> +		free(func);
> +		return NULL;
> +	}
> +	*(end - 1) =3D '\0';
> +
> +	return func;
> +}

[...]

> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{

[...]

> +	elf =3D elf_begin(fd, ELF_C_READ, NULL);
> +	if (elf =3D=3D NULL) {
> +		elf_error("Cannot update ELF file");
> +		goto out;
> +	}
> +
> +	/* Location symbol table and .BTF_ids sections */
> +	elf_getshdrstrndx(elf, &strndx);

Nit: in theory elf_getshdrstrndx() could fail and strndx would remain
     uninitialized.

[...]

