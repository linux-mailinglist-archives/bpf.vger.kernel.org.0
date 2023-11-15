Return-Path: <bpf+bounces-15095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD877EC651
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 15:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E03B20B87
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F5B2EB04;
	Wed, 15 Nov 2023 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="LvGMCYzp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048232E658
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 14:51:17 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA89E
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 06:51:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40859dee28cso56696725e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 06:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700059874; x=1700664674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nX+xema9s4Hz9Lqfny87q+3qZkRl+bWzN8QX3+r9hn8=;
        b=LvGMCYzpiXrMXL2ygS6ZacDm0R3oNRNObaNLCElLYl73Rgo5/BpzgcnGagHWa/HIXf
         itTP5lsnulLsPvQdgRxM1sREalXoKv+6Jk4U2nAGzOVRzHbAXct63bnTDH/OXQ+B4Cn1
         Ju3ZIZkHpgm0fh9tlZrDocp9+ieaviJzxZuKqvvZWNyAXvpoB2hIVeMjZSG/P1EtFVAX
         6onAAgQ9Mz2CM0acIOHkrfjGxmFFOVtGl5S/8Jf5PjV8aCGveVDXnu2nzu2GMR6ujRGP
         GflYCvSShwpmERn20IxS8D3Low7JpD+MGpaw4JKHDWBAoDsVoZhSL829ziz0k7jiqmAT
         NAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059874; x=1700664674;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nX+xema9s4Hz9Lqfny87q+3qZkRl+bWzN8QX3+r9hn8=;
        b=bMAMnrIggTlR90hIRAOVPuQozHgIt+RO8hZ/5hygdviC4BElT0rMdMVivghtKgXiWY
         /RSuQvZqo/xKwidxhkzGvHNy7ck7DCSmh+bQM8zXzI06iXXsvunYt9v4/Cr7W26wAgl+
         7hEHNDMCIvHObIa4AQ1itUdm73F+BdYxpKcPG5hPUAi5Pha8zvK1ZJDwl0gFHFSzqbgf
         kqL545Zl+EEf2kvsHvQQQ5Luaxn36b+s7LOoNrIVl/utBCPaFhrN3d8568nlaj8ojAgu
         /EHszH+TBGdWQINdcL0gdfbtKYurDU/uuBORXVysM4uv3lHLQZqgbKNbsgde0eWJTNs4
         SpyA==
X-Gm-Message-State: AOJu0YzlJIkGADfXYayCvimeWyeCHsZG1udJUtr8TgwxKxL4D6BDgiBg
	0bPU6Z/sJ35Zuy7j8+2rpp/ndA==
X-Google-Smtp-Source: AGHT+IGNsU4PWzelrf0hEKIQvtQ7Q6tKDLHX3kGehEVKIoRfkeDq8vZTcyJKscP2u7kV0NWG9LqtEg==
X-Received: by 2002:a05:600c:4f81:b0:409:79df:7f9c with SMTP id n1-20020a05600c4f8100b0040979df7f9cmr10276225wmq.36.1700059873733;
        Wed, 15 Nov 2023 06:51:13 -0800 (PST)
Received: from [127.0.0.1] ([37.168.21.211])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b0040836519dd9sm15687229wmb.25.2023.11.15.06.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 06:51:13 -0800 (PST)
Date: Wed, 15 Nov 2023 09:51:11 -0500
From: Quentin Monnet <quentin@isovalent.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jolsa@kernel.org
CC: eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, masahiroy@kernel.org, bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_bpf-next_10/17=5D_bpftool=3A_add_B?= =?US-ASCII?Q?TF_dump_=22format_meta=22_to_dump_header/metadata?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b6368b81-e141-13c0-7fde-c4cada3e242c@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com> <20231112124834.388735-11-alan.maguire@oracle.com> <ebb1d463-68f5-4668-b930-f5dfe1f52230@isovalent.com> <b6368b81-e141-13c0-7fde-c4cada3e242c@oracle.com>
Message-ID: <F129A42C-3E63-4B94-BBB6-5B13AFC9A73A@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15 November 2023 03:45:41 GMT-05:00, Alan Maguire <alan=2Emaguire@oracl=
e=2Ecom> wrote:
>On 14/11/2023 05:10, Quentin Monnet wrote:
>> 2023-11-12 12:49 UTC+0000 ~ Alan Maguire <alan=2Emaguire@oracle=2Ecom>
>>> Provide a way to dump BTF metadata info via bpftool; this
>>> consists of BTF size, header fields and kind layout info
>>> (if available); for example
>>>
>>> $ bpftool btf dump file vmlinux format meta
>>> size 5161076
>>> magic 0xeb9f
>>> version 1
>>> flags 0x1
>>> hdr_len 40
>>> type_len 3036368
>>> type_off 0
>>> str_len 2124588
>>> str_off 3036368
>>> kind_layout_len 80
>>> kind_layout_off 5160956
>>> crc 0x64af901b
>>> base_crc 0x0
>>> kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
>>> kind 1    INT        flags 0x0    info_sz 0    elem_sz 0
>>> kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
>>> kind 3    ARRAY      flags 0x0    info_sz 0    elem_sz 0
>>> kind 4    STRUCT     flags 0x35   info_sz 0    elem_sz 0
>>> =2E=2E=2E
>>>
>>> JSON output is also supported:
>>>
>>> $ bpftool -j btf dump file vmlinux format meta
>>> {"size":5161076,"header":{"magic":60319,"version":1,"flags":1,"hdr_len=
":40,"type_len":3036368,"type_off":0,"str_len":2124588,"str_off":3036368,"k=
ind_layout_len":80,"kind_layout_offset":5160956,"crc":1689227291,"base_crc"=
:0},"kind_layouts":[{"kind":0,"name":"UNKNOWN","flags":0,"info_sz":0,"elem_=
sz":0},{"kind":1,"name":"INT","flags":0,"info_sz":0,"elem_sz":0},{"kind":2,=
"name":"PTR","flags":0,"info_sz":0,"elem_sz":0},{"kind":3,"name":"ARRAY","f=
lags":0,"info_sz":0,"elem_sz":0},{"kind":4,"name":"STRUCT","flags":53,"info=
_sz":0,"elem_sz":0},{"kind":5,"name":"UNION","flags":0,"info_sz":0,"elem_sz=
":0},{"kind":6,"name":"ENUM","flags":60319,"info_sz":1,"elem_sz":1},{"kind"=
:7,"name":"FWD","flags":40,"info_sz":0,"elem_sz":0},{"kind":8,"name":"TYPED=
EF","flags":0,"info_sz":0,"elem_sz":0},{"kind":9,"name":"VOLATILE","flags":=
0,"info_sz":0,"elem_sz":0},{"kind":10,"name":"CONST","flags":0,"info_sz":0,=
"elem_sz":0},{"kind":11,"name":"RESTRICT","flags":1,"info_sz":0,"elem_sz":0=
},{"kind":12,"name":"FUNC","flags":0,"info_sz":0,"elem_sz":0},{"kind":13,"n=
ame":"FUNC_PROTO","flags":80,"info_sz":0,"elem_sz":0},{"kind":14,"name":"VA=
R","flags":0,"info_sz":0,"elem_sz":0},{"kind":15,"name":"DATASEC","flags":0=
,"info_sz":0,"elem_sz":0},{"kind":16,"name":"FLOAT","flags":53,"info_sz":0,=
"elem_sz":0},{"kind":17,"name":"DECL_TAG","flags":0,"info_sz":0,"elem_sz":0=
},{"kind":18,"name":"TYPE_TAG","flags":11441,"info_sz":3,"elem_sz":0},{"kin=
d":19,"name":"ENUM64","flags":0,"info_sz":0,"elem_sz":0}]}
>>>
>>> Signed-off-by: Alan Maguire <alan=2Emaguire@oracle=2Ecom>
>>> ---
>>>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>>>  tools/bpf/bpftool/btf=2Ec                   | 91 ++++++++++++++++++++=
++-
>>>  2 files changed, 90 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpf=
tool/bash-completion/bpftool
>>> index 6e4f7ce6bc01=2E=2E157c3afd8247 100644
>>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>>> @@ -937,7 +937,7 @@ _bpftool()
>>>                              return 0
>>>                              ;;
>>>                          format)
>>> -                            COMPREPLY=3D( $( compgen -W "c raw" -- "$=
cur" ) )
>>> +                            COMPREPLY=3D( $( compgen -W "c raw meta" =
-- "$cur" ) )
>>>                              ;;
>>>                          *)
>>>                              # emit extra options
>>> diff --git a/tools/bpf/bpftool/btf=2Ec b/tools/bpf/bpftool/btf=2Ec
>>> index 91fcb75babe3=2E=2E208f3a587534 100644
>>> --- a/tools/bpf/bpftool/btf=2Ec
>>> +++ b/tools/bpf/bpftool/btf=2Ec
>>> @@ -504,6 +504,88 @@ static int dump_btf_c(const struct btf *btf,
>>>  	return err;
>>>  }
>>> =20
>>> +static int dump_btf_meta(const struct btf *btf)
>>> +{
>>> +	const struct btf_header *hdr;
>>> +	const struct btf_kind_layout *k;
>>> +	__u8 i, nr_kinds =3D 0;
>>> +	const void *data;
>>> +	__u32 data_sz;
>>> +
>>> +	data =3D btf__raw_data(btf, &data_sz);
>>> +	if (!data)
>>> +		return -ENOMEM;
>>> +	hdr =3D data;
>>> +	if (json_output) {
>>> +		jsonw_start_object(json_wtr);   /* btf metadata object */
>>=20
>> Nit: Please make sure to be consistent when aligning these comments:
>> there are several occurrences with spaces (here three spaces), several
>> ones with tabs=2E For these, I'd prefer tabs to align the start and end
>> comments for a given object/array, although I don't really using a
>> single space as well as long as we keep it consistent=2E
>>=20
>>> +		jsonw_uint_field(json_wtr, "size", data_sz);
>>> +		jsonw_name(json_wtr, "header");
>>> +		jsonw_start_object(json_wtr);	/* btf header object */
>>> +		jsonw_uint_field(json_wtr, "magic", hdr->magic);
>>> +		jsonw_uint_field(json_wtr, "version", hdr->version);
>>> +		jsonw_uint_field(json_wtr, "flags", hdr->flags);
>>> +		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
>>> +		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
>>> +		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
>>> +		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
>>> +		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
>>> +	} else {
>>> +		printf("size %-10d\n", data_sz);
>>> +		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10d\=
n",
>>> +		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
>>> +		printf("type_len %-10d\ntype_off %-10d\n", hdr->type_len, hdr->type=
_off);
>>> +		printf("str_len %-10d\nstr_off %-10d\n", hdr->str_len, hdr->str_off=
);
>>> +	}
>>> +
>>> +	if (hdr->hdr_len < sizeof(struct btf_header)) {
>>> +		if (json_output) {
>>> +			jsonw_end_object(json_wtr); /* header object */
>>> +			jsonw_end_object(json_wtr); /* metadata object */
>>=20
>> Similarly, can you please keep consistent comment strings? "metadata
>> object" here vs=2E "end metadata" below=2E
>>=20
>
>Sure, I'll fix indent consistency/naming and the docs issue in the
>next revision=2E Thanks!
>
>>> +		}
>>> +		return 0;
>>> +	}
>>> +	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
>>> +		k =3D (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
>>> +		nr_kinds =3D hdr->kind_layout_len / sizeof(*k);
>>> +	}
>>> +	if (json_output) {
>>> +		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len)=
;
>>> +		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_o=
ff);
>>> +		jsonw_uint_field(json_wtr, "crc", hdr->crc);
>>> +		jsonw_uint_field(json_wtr, "base_crc", hdr->base_crc);
>>> +		jsonw_end_object(json_wtr); /* end header object */
>>> +
>>> +		if (nr_kinds > 0) {
>>> +			jsonw_name(json_wtr, "kind_layouts");
>>> +			jsonw_start_array(json_wtr);
>>> +			for (i =3D 0; i < nr_kinds; i++) {
>>> +				jsonw_start_object(json_wtr);
>>> +				jsonw_uint_field(json_wtr, "kind", i);
>>> +				if (i < NR_BTF_KINDS)
>>> +					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
>>=20
>> I prefer to avoid conditional fields in JSON, especially in an array
>> it's easier to process the JSON if all items have the same structure=2E
>> Would it make sense to keep the "name" field, but use jsonw_null() (or
>> "UNKNOWN") for the value when there's no name to print?
>>
>
>The only thing about UNKNOWN is that there is a BTF_KIND_UNKN that
>is displayed as UNKNOWN; what about "?" to be consistent with the
>non-json output (or if there's another option of course, we could
>use that for both)? Thanks!

Right, sorry, I realised just after sending my message=2E
In that case we could just use a 'null' value in JSON with jsonw_null()? T=
he object '{"name": null}' is valid=2E The question mark is another possibi=
lity but requires comparing strings when parsing the JSON=2E

Thanks,
Quentin

