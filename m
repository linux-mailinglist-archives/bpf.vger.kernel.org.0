Return-Path: <bpf+bounces-17057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFA780960B
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 23:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15B11C20C22
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E79C50262;
	Thu,  7 Dec 2023 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdeQY2ls"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7811610E6;
	Thu,  7 Dec 2023 14:58:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c32df9174so1136875e9.3;
        Thu, 07 Dec 2023 14:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701989890; x=1702594690; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xeBW3wXtAMwCXVSAo4vP6HzHJze8zETsPwhWDDt4fqI=;
        b=BdeQY2lshZGsynKM4XWZz+IoJEvPalqy2xxYwjxvs+g1xV93ZHQJwO2qrBPMv3gwXx
         zoNbQzCoSsvV9qpg9F725SHv+MgGcVx0T5b2+PGcYKp6ieVeMWU36WYCf/66AWvpVGGh
         KVIIL8W5Wa5OVaqGJUKH4FzOGPzO+4EORMYxx5/192O3LYBM4xH99RpFYDeQ8vN4ufTl
         P3R+8oSEiHDW2hLb43ClQC8DSagfe64eVI/3POcZl+uNP1g2nCmuOTTUoF/q5MskGg6J
         P5wBqCY2Xt10K2p301pBxUE5NYxJEc/7guoQI58hl1c+t1N8GQYFdMBY2i/S0aAaDOnN
         bixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989890; x=1702594690;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeBW3wXtAMwCXVSAo4vP6HzHJze8zETsPwhWDDt4fqI=;
        b=Z7PfDdm1J+UCQVZ+mAf7a5iT6bGlDaoGxVSg8skO3ivUTlE49kdrCWesf/u6kC3jZ6
         7pgkdfkqe1AyupKFfETKh+kaoHgnl+RZmebUYEmozzxSrUa2UpJL9eLbeTsCOA8fPx+j
         uJZLLnL1jCHbboQcOC5nSS8MoZ4KTbL+FpJTMAvRq6DteqdL3bgdN1VH83bMERjm0YMs
         oNG2HX1e4XKoHm8mA8NMwW6ueuSyLqgMenH6jpvUEbyV2XNQTRZo4bs1obndlM13rRS6
         +nF691EDgS9b6gTDnq+Ys/nXWK1GjhMxDnrIcuVYSLJDO2Q2qd5/Di4BlGOwPQ6fJfRG
         RzfA==
X-Gm-Message-State: AOJu0Yzy/sOU8gyY2rFS1riBp0dfMaFrpcmwaB3k2fzykxkoQP8sBwTG
	5+IHl8nYawkDYcRMM0stOhU=
X-Google-Smtp-Source: AGHT+IHg/8vcE1uS5O/rAhOQd+0lhKxDsWs5dKOA9a/bUC7zAmfRV9jbPm9+RMlMw3+mh6oNO6wbJA==
X-Received: by 2002:a05:600c:4705:b0:40b:37f2:95b6 with SMTP id v5-20020a05600c470500b0040b37f295b6mr1386442wmo.0.1701989889727;
        Thu, 07 Dec 2023 14:58:09 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm1308229wmq.43.2023.12.07.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:58:09 -0800 (PST)
Message-ID: <159e94e7ce82e9432bd2bba0141c8feab0a9a2e6.camel@gmail.com>
Subject: Re: [PATCH] tools/lib/bpf: add pr_warn() to more -EINVAL cases
From: Eduard Zingerman <eddyz87@gmail.com>
To: Sergei Trofimovich <slyich@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Date: Fri, 08 Dec 2023 00:58:02 +0200
In-Reply-To: <20231207180919.2379718-1-slyich@gmail.com>
References: <20231207180919.2379718-1-slyich@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-07 at 18:09 +0000, Sergei Trofimovich wrote:
> Before the change on `i686-linux` `systemd` build failed as:
>=20
>     $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/c=
ore/bpf/socket_bind/socket-bind.bpf.unstripped.o
>     Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstr=
ipped.o': Invalid argument (22)
>=20
> After the change it fails as:
>=20
>     $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/c=
ore/bpf/socket_bind/socket-bind.bpf.unstripped.o
>     libbpf: ELF section #9 has inconsistent alignment in src/core/bpf/soc=
ket_bind/socket-bind.bpf.unstripped.o
>     Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstr=
ipped.o': Invalid argument (22)
>=20
> Now it's slightly easier to figure out what is wrong with an ELF file.

Hi Sergei,

Thank you for adding these prints.
Could you please make a few adjustments, as noted below.
Also, please add "libbpf:" prefix in subject and mention
linker_sanity_check_elf in it, e.g.:

  libbpf: add pr_warn() for EINVAL cases in linker_sanity_check_elf
 =20
or something like that.

[...]

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 5ced96d99f8c..71bb4916b762 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -719,13 +719,22 @@ static int linker_sanity_check_elf(struct src_obj *=
obj)
>  			return -EINVAL;
>  		}
> =20
> -		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign))
> +		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign)) =
{
> +			pr_warn("ELF section #%zu alignment is non pow-of-2 alignment in %s\n=
",
> +				sec->sec_idx, obj->filename);

Could you please also print values for shdr->sh_addralign here?
And also print shdr->sh_addralign/data->d_align, shdr->sh_size/data->d_size
in corresponding pr_warn() calls below.

>  			return -EINVAL;
> -		if (sec->shdr->sh_addralign !=3D sec->data->d_align)
> +		}
> +		if (sec->shdr->sh_addralign !=3D sec->data->d_align) {
> +			pr_warn("ELF section #%zu has inconsistent alignment in %s\n",
> +				sec->sec_idx, obj->filename);
>  			return -EINVAL;
> +		}
> =20
> -		if (sec->shdr->sh_size !=3D sec->data->d_size)
> +		if (sec->shdr->sh_size !=3D sec->data->d_size) {
> +			pr_warn("ELF section #%zu has inconsistent section size in %s\n",
> +				sec->sec_idx, obj->filename);
>  			return -EINVAL;
> +		}
> =20
>  		switch (sec->shdr->sh_type) {
>  		case SHT_SYMTAB:

A few lines below this one there is:

		case SHT_PROGBITS:
			if (sec->shdr->sh_flags & SHF_EXECINSTR) {
				if (sec->shdr->sh_size % sizeof(struct bpf_insn) !=3D 0)
					return -EINVAL;
			}
			break;

Could you please add pr_warn() there as well?

