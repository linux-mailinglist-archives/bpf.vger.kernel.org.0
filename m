Return-Path: <bpf+bounces-15045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E97EA9F9
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 06:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD031F2408F
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 05:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFBDC121;
	Tue, 14 Nov 2023 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="PS+yMNid"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63CC2C3
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 05:11:55 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECDA123
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 21:11:53 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c742186a3bso65658381fa.1
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 21:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1699938711; x=1700543511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGOjtZyXFGwxrPZgmE+EAeXM8qWcj5RID6nggzYHJRk=;
        b=PS+yMNidrQUESyzBRAzfMuHYW0XrvdI+5ce/27bzdXtYzm0VgpPOC6ToGIWa4XEVx6
         7+kdpoKnXDHVO4sfi5BRZS6tBykUvq76TuTA+/f/+xyCjIAvNRSFoltN7kYLAvKvxlZk
         sKTGuGmW3lGJmDubUSIfqIS1HMiOJlsxVsLT2ve6pMRhWxALj+lMxg43mJxrcNdWGV8e
         WcYUOS9hrXISj9dBSa19PxSr0jCyGyKg4kYmTbV603qlTE3ffeJu+5EvBp1ZWTduP1/N
         055PqiYXfwoh/lR2brwQIV3YTT+xyLu9bzJtyfoiZF59zRM0rb71RKwhJjHAWTXPu50g
         9nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699938711; x=1700543511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGOjtZyXFGwxrPZgmE+EAeXM8qWcj5RID6nggzYHJRk=;
        b=ZrFCS5BpsRHfiYCQYKcgq9J8wpGZ6X+Wap0lxDrYzb4pU69F76/pbuhRsj/3JADEAQ
         ByB9Uu5xwXG2+aHAlLJA4CDLe1u8xYsrJHwumkJVoRnziR7PDVOCD6gUjvWZCzHkJl2E
         TzcMWS3/1o/y5rvWJ1dUkjHg/UXoMxaDYpfkRPiLjQyp4iyi01ss4W4NJrWw93QljJqY
         JzHxjCttOSY9f0GBDDSG/K+7ruYLUDn7QTeS1f06Dl1KTn7vt2W8WzU+8RErrMeBTmpp
         xj+FPSv9cwvOS9CI/Uva+ZG3rSAAyrHSFLReeq7qC2Mjnh5ObxpADDBU1+FOuN5ARAfm
         Zzcw==
X-Gm-Message-State: AOJu0YxBk/m2tUcgblwloB1xutzmxXpYSdjcijkC8qVz5Z8P/JkMlxia
	uDG8s1Ded2zJ0lCWkdk6ig4p3w==
X-Google-Smtp-Source: AGHT+IGQ9J/jqMWJGJ1VVSPtqNmzo+gRbK4RGtFgft0m0Gamwh00vPSrRoII33gIFWO51w+OE0lM9Q==
X-Received: by 2002:a2e:2414:0:b0:2c5:2103:6049 with SMTP id k20-20020a2e2414000000b002c521036049mr805975ljk.45.1699938711363;
        Mon, 13 Nov 2023 21:11:51 -0800 (PST)
Received: from [192.168.97.254] ([37.168.99.178])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c2d0c00b0040a43d458c9sm12989703wmf.25.2023.11.13.21.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 21:11:51 -0800 (PST)
Message-ID: <ebb1d463-68f5-4668-b930-f5dfe1f52230@isovalent.com>
Date: Tue, 14 Nov 2023 05:10:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 10/17] bpftool: add BTF dump "format meta" to
 dump header/metadata
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, masahiroy@kernel.org, bpf@vger.kernel.org
References: <20231112124834.388735-1-alan.maguire@oracle.com>
 <20231112124834.388735-11-alan.maguire@oracle.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231112124834.388735-11-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2023-11-12 12:49 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
> Provide a way to dump BTF metadata info via bpftool; this
> consists of BTF size, header fields and kind layout info
> (if available); for example
>=20
> $ bpftool btf dump file vmlinux format meta
> size 5161076
> magic 0xeb9f
> version 1
> flags 0x1
> hdr_len 40
> type_len 3036368
> type_off 0
> str_len 2124588
> str_off 3036368
> kind_layout_len 80
> kind_layout_off 5160956
> crc 0x64af901b
> base_crc 0x0
> kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
> kind 1    INT        flags 0x0    info_sz 0    elem_sz 0
> kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
> kind 3    ARRAY      flags 0x0    info_sz 0    elem_sz 0
> kind 4    STRUCT     flags 0x35   info_sz 0    elem_sz 0
> ...
>=20
> JSON output is also supported:
>=20
> $ bpftool -j btf dump file vmlinux format meta
> {"size":5161076,"header":{"magic":60319,"version":1,"flags":1,"hdr_len"=
:40,"type_len":3036368,"type_off":0,"str_len":2124588,"str_off":3036368,"=
kind_layout_len":80,"kind_layout_offset":5160956,"crc":1689227291,"base_c=
rc":0},"kind_layouts":[{"kind":0,"name":"UNKNOWN","flags":0,"info_sz":0,"=
elem_sz":0},{"kind":1,"name":"INT","flags":0,"info_sz":0,"elem_sz":0},{"k=
ind":2,"name":"PTR","flags":0,"info_sz":0,"elem_sz":0},{"kind":3,"name":"=
ARRAY","flags":0,"info_sz":0,"elem_sz":0},{"kind":4,"name":"STRUCT","flag=
s":53,"info_sz":0,"elem_sz":0},{"kind":5,"name":"UNION","flags":0,"info_s=
z":0,"elem_sz":0},{"kind":6,"name":"ENUM","flags":60319,"info_sz":1,"elem=
_sz":1},{"kind":7,"name":"FWD","flags":40,"info_sz":0,"elem_sz":0},{"kind=
":8,"name":"TYPEDEF","flags":0,"info_sz":0,"elem_sz":0},{"kind":9,"name":=
"VOLATILE","flags":0,"info_sz":0,"elem_sz":0},{"kind":10,"name":"CONST","=
flags":0,"info_sz":0,"elem_sz":0},{"kind":11,"name":"RESTRICT","flags":1,=
"info_sz":0,"elem_sz":0},{"kind":12,"name":"FUNC","flags":0,"info_sz":0,"=
elem_sz":0},{"kind":13,"name":"FUNC_PROTO","flags":80,"info_sz":0,"elem_s=
z":0},{"kind":14,"name":"VAR","flags":0,"info_sz":0,"elem_sz":0},{"kind":=
15,"name":"DATASEC","flags":0,"info_sz":0,"elem_sz":0},{"kind":16,"name":=
"FLOAT","flags":53,"info_sz":0,"elem_sz":0},{"kind":17,"name":"DECL_TAG",=
"flags":0,"info_sz":0,"elem_sz":0},{"kind":18,"name":"TYPE_TAG","flags":1=
1441,"info_sz":3,"elem_sz":0},{"kind":19,"name":"ENUM64","flags":0,"info_=
sz":0,"elem_sz":0}]}
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>  tools/bpf/bpftool/btf.c                   | 91 ++++++++++++++++++++++-=

>  2 files changed, 90 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpft=
ool/bash-completion/bpftool
> index 6e4f7ce6bc01..157c3afd8247 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -937,7 +937,7 @@ _bpftool()
>                              return 0
>                              ;;
>                          format)
> -                            COMPREPLY=3D( $( compgen -W "c raw" -- "$c=
ur" ) )
> +                            COMPREPLY=3D( $( compgen -W "c raw meta" -=
- "$cur" ) )
>                              ;;
>                          *)
>                              # emit extra options
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..208f3a587534 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -504,6 +504,88 @@ static int dump_btf_c(const struct btf *btf,
>  	return err;
>  }
> =20
> +static int dump_btf_meta(const struct btf *btf)
> +{
> +	const struct btf_header *hdr;
> +	const struct btf_kind_layout *k;
> +	__u8 i, nr_kinds =3D 0;
> +	const void *data;
> +	__u32 data_sz;
> +
> +	data =3D btf__raw_data(btf, &data_sz);
> +	if (!data)
> +		return -ENOMEM;
> +	hdr =3D data;
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);   /* btf metadata object */

Nit: Please make sure to be consistent when aligning these comments:
there are several occurrences with spaces (here three spaces), several
ones with tabs. For these, I'd prefer tabs to align the start and end
comments for a given object/array, although I don't really using a
single space as well as long as we keep it consistent.

> +		jsonw_uint_field(json_wtr, "size", data_sz);
> +		jsonw_name(json_wtr, "header");
> +		jsonw_start_object(json_wtr);	/* btf header object */
> +		jsonw_uint_field(json_wtr, "magic", hdr->magic);
> +		jsonw_uint_field(json_wtr, "version", hdr->version);
> +		jsonw_uint_field(json_wtr, "flags", hdr->flags);
> +		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
> +		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
> +		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
> +		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
> +		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
> +	} else {
> +		printf("size %-10d\n", data_sz);
> +		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10d\n=
",
> +		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
> +		printf("type_len %-10d\ntype_off %-10d\n", hdr->type_len, hdr->type_=
off);
> +		printf("str_len %-10d\nstr_off %-10d\n", hdr->str_len, hdr->str_off)=
;
> +	}
> +
> +	if (hdr->hdr_len < sizeof(struct btf_header)) {
> +		if (json_output) {
> +			jsonw_end_object(json_wtr); /* header object */
> +			jsonw_end_object(json_wtr); /* metadata object */

Similarly, can you please keep consistent comment strings? "metadata
object" here vs. "end metadata" below.

> +		}
> +		return 0;
> +	}
> +	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
> +		k =3D (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
> +		nr_kinds =3D hdr->kind_layout_len / sizeof(*k);
> +	}
> +	if (json_output) {
> +		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len);=

> +		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_of=
f);
> +		jsonw_uint_field(json_wtr, "crc", hdr->crc);
> +		jsonw_uint_field(json_wtr, "base_crc", hdr->base_crc);
> +		jsonw_end_object(json_wtr); /* end header object */
> +
> +		if (nr_kinds > 0) {
> +			jsonw_name(json_wtr, "kind_layouts");
> +			jsonw_start_array(json_wtr);
> +			for (i =3D 0; i < nr_kinds; i++) {
> +				jsonw_start_object(json_wtr);
> +				jsonw_uint_field(json_wtr, "kind", i);
> +				if (i < NR_BTF_KINDS)
> +					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);

I prefer to avoid conditional fields in JSON, especially in an array
it's easier to process the JSON if all items have the same structure.
Would it make sense to keep the "name" field, but use jsonw_null() (or
"UNKNOWN") for the value when there's no name to print?

Thanks,
Quentin

