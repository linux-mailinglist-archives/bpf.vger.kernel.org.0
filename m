Return-Path: <bpf+bounces-9942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CC779EFC6
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B951C2153E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B31F952;
	Wed, 13 Sep 2023 16:58:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6EAD52
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 16:58:48 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5B1BE8
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:58:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so156205a12.1
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624326; x=1695229126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N2eBdDT+tOncUBfdz057iQqtMUPvmT8RT2fDwWhZqow=;
        b=StaRbqcZzG15mD4eIJRwBgz5yAnFO3+B29+RSmGroD4HTJELyLsDcHg5VVosVv5qSn
         vhnG87yp9ZD9xoUq9lLH5794OnLA+COaUD8x/D5gZuIxCKk/zj0jtjcN80daQyVj6xNe
         fZQU+TvIoNF8YEUosOdxvKvOQIeWlcjMufV+WZn8YvIJTptL7mEbxnNIdeWcHd5ShpIr
         x/ovBsc2VtHKm3PoZy+TNAv85dLKeOcElOfQ7HSMkAjjcAZt6sF8DpUvQNZu7oYgubC4
         8YOb0Q0OXsHYzOYXWVP/RuRWpePjN5lHDAVU5rjrpvivCXGkaTmqVDwnugekpM0RmBui
         MfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624326; x=1695229126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2eBdDT+tOncUBfdz057iQqtMUPvmT8RT2fDwWhZqow=;
        b=ry9+AkMc4HgKyfPoC9ubBI+RoZ7cd2ThmIGMB9PGK38hoDFy9CaFxCeTUNBL8bnDtb
         RhO040d2+brDVFlZ2e/Hj1WdIpk3egTLAQuzn00SqQmyitDAwS6exgxxzS8kXO3YarzA
         ahcP1OzTuQn2BQQQiAjwl1WztjD0KZ0m6lj3BkzD7Fv/iYOqrWiMjTP2Jmg0lWZyz83j
         I3G7INzK9HybZMeFNP3HQ4PS7pRAflwrgdrBIXtoFzrOm4e2AA8d+Mpq2aJns4c4F74h
         s0ORM1ocoB2tBtT+viyfYeePLMwUKV2HBe63tNnRg9BMEGoDZWNiQokyhTumBgeNt9T6
         Fwag==
X-Gm-Message-State: AOJu0YwXcWHR15WZMuw6FRU6Q7AjBoKf/EgLofBdDG6VoeVilDh7RsOS
	i/gEpumtASItqlWqu539qaQ=
X-Google-Smtp-Source: AGHT+IGx5eTVUJoJS+WU5DyY4Rtpj3t0euqpCdqxUzGWYNW1w2Djdwb7AqWMBgf2OwKdoaPjot1jZg==
X-Received: by 2002:a05:6402:518b:b0:51e:5bd5:fe7e with SMTP id q11-20020a056402518b00b0051e5bd5fe7emr8690715edd.17.1694624325740;
        Wed, 13 Sep 2023 09:58:45 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7c64b000000b0052333e5237esm7563669edr.88.2023.09.13.09.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:58:45 -0700 (PDT)
Message-ID: <69a3fa8112195551e6ed6e63785c80816f205d6c.camel@gmail.com>
Subject: Re: [PATCH dwarves 1/3] dwarves: auto-detect maximum kind supported
 by vmlinux
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
 jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com,  mykolal@fb.com, bpf@vger.kernel.org
Date: Wed, 13 Sep 2023 19:58:44 +0300
In-Reply-To: <20230913142646.190047-2-alan.maguire@oracle.com>
References: <20230913142646.190047-1-alan.maguire@oracle.com>
	 <20230913142646.190047-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-09-13 at 15:26 +0100, Alan Maguire wrote:
> When a newer pahole is run on an older kernel, it often knows about BTF
> kinds that the kernel does not support.  This is a problem because the BT=
F
> generated is then embedded in the kernel image and read, and if unknown
> kinds are found, BTF handling fails and core BPF functionality is
> unavailable.
>=20
> The scripts/pahole-flags.sh script enumerates the various pahole options
> available associated with various versions of pahole, but the problem is
> what matters in the case of an older kernel is the set of kinds the kerne=
l
> understands.  Because recent features such as BTF_KIND_ENUM64 are added
> by default (and only skipped if --skip_encoding_btf_* is set), BTF will
> be created with these newer kinds that the older kernel cannot read.
> This can be fixed by stable-backporting --skip options, but this is
> cumbersome and would have to be done every time a new BTF kind is
> introduced.
>=20
> Here instead we pre-process the DWARF information associated with the
> target for BTF generation; if we find an enum with a BTF_KIND_MAX
> value in the DWARF associated with the object, we use that to
> determine the maximum BTF kind supported.  Note that the enum
> representation of BTF kinds starts for the 5.16 kernel; prior to this
> The benefit of auto-detection is that no work is required for older
> kernels when new kinds are added, and --skip_encoding options are
> less needed.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_encoder.c  | 12 ++++++++++++
>  dwarf_loader.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  dwarves.h      |  2 ++
>  3 files changed, 66 insertions(+)
>=20
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 65f6e71..98c7529 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1889,3 +1889,15 @@ struct btf *btf_encoder__btf(struct btf_encoder *e=
ncoder)
>  {
>  	return encoder->btf;
>  }
> +
> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind=
_max)
> +{
> +	if (btf_kind_max < 0 || btf_kind_max >=3D BTF_KIND_MAX)
> +		return;
> +	if (btf_kind_max < BTF_KIND_DECL_TAG)
> +		conf_load->skip_encoding_btf_decl_tag =3D true;
> +	if (btf_kind_max < BTF_KIND_TYPE_TAG)
> +		conf_load->skip_encoding_btf_type_tag =3D true;
> +	if (btf_kind_max < BTF_KIND_ENUM64)
> +		conf_load->skip_encoding_btf_enum64 =3D true;
> +}
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index ccf3194..8984043 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3358,8 +3358,60 @@ static int __dwarf_cus__process_cus(struct dwarf_c=
us *dcus)
>  	return 0;
>  }
> =20
> +/* Find enumeration value for BTF_KIND_MAX; replace conf_load->btf_kind_=
max with
> + * this value if found since it indicates that the target object does no=
t know
> + * about kinds > its BTF_KIND_MAX value.  This is valuable for kernel/mo=
dule
> + * BTF where a newer pahole/libbpf operate on an older kernel which cann=
ot
> + * parse some of the newer kinds pahole can generate.
> + */
> +static void dwarf__find_btf_kind_max(struct dwarf_cus *dcus)
> +{
> +	struct conf_load *conf =3D dcus->conf;
> +	uint8_t pointer_size, offset_size;
> +	Dwarf_Off off =3D 0, noff;
> +	size_t cuhl;
> +
> +	while (dwarf_nextcu(dcus->dw, off, &noff, &cuhl, NULL, &pointer_size, &=
offset_size) =3D=3D 0) {
> +		Dwarf_Die die_mem;
> +		Dwarf_Die *cu_die =3D dwarf_offdie(dcus->dw, off + cuhl, &die_mem);
> +		Dwarf_Die child;
> +
> +		if (cu_die =3D=3D NULL)
> +			break;
> +		if (dwarf_child(cu_die, &child) =3D=3D 0) {
> +			Dwarf_Die *die =3D &child;
> +
> +			do {
> +				Dwarf_Die echild, *edie;
> +
> +				if (dwarf_tag(die) !=3D DW_TAG_enumeration_type ||
> +				    !dwarf_haschildren(die) ||
> +				    dwarf_child(die, &echild) !=3D 0)
> +					continue;
> +				edie =3D &echild;
> +				do {
> +					const char *ename;
> +					int btf_kind_max;
> +
> +					if (dwarf_tag(edie) !=3D DW_TAG_enumerator)
> +						continue;
> +					ename =3D attr_string(edie, DW_AT_name, conf);
> +					if (!ename || strcmp(ename, "BTF_KIND_MAX") !=3D 0)
> +						continue;
> +					btf_kind_max =3D attr_numeric(edie, DW_AT_const_value);

Nitpick: attr_numeric() returns 0 in case of an error, when 0 is passed to
         dwarves__set_btf_kind_max() it would turn off all optional kinds.
         Probably should bail out on 0 instead.

> +					dwarves__set_btf_kind_max(conf, btf_kind_max);
> +					return;
> +				} while (dwarf_siblingof(edie, edie) =3D=3D 0);
> +			} while (dwarf_siblingof(die, die) =3D=3D 0);
> +		}
> +		off =3D noff;
> +	}
> +}
> +
>  static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
>  {
> +	dwarf__find_btf_kind_max(dcus);
> +
>  	if (dcus->conf->nr_jobs > 1)
>  		return dwarf_cus__threaded_process_cus(dcus);
> =20
> diff --git a/dwarves.h b/dwarves.h
> index eb1a6df..f4d9347 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -1480,4 +1480,6 @@ extern const char tabs[];
>  #define DW_TAG_skeleton_unit 0x4a
>  #endif
> =20
> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind=
_max);
> +
>  #endif /* _DWARVES_H_ */



