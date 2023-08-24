Return-Path: <bpf+bounces-8462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A252D786EC5
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A28281552
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7434100AD;
	Thu, 24 Aug 2023 12:11:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94D2454A
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 12:11:06 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E04E7D
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 05:11:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-997c4107d62so885030066b.0
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692879060; x=1693483860;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0EAJAoNO+DLUnQwwLi/FlmnQuaAUZvdG/VahZ/SbUrQ=;
        b=V5QQ3BG+vyXKsihH+Qz/mjLbS+IkWhbUPzewi7ohP+Sxt4hRrJrb39E3iGX9woMbLK
         hAHd+6+kiBsp/Z/Ut6TqqDmutlKbc00VxGdLGiWUSvcnvDsMdIIKf1CUjefXVfXB+Ulg
         JOXoGYVdqQcl/PXZcpMh46GYyfHuwN7WUcQBbQKTza1NwLp0C3P7uZ10BKmyNnBBjXdc
         079fcO85tixpd2lUbCHvzmgrvxS51a8Y8MDdM9+qLpgMcU7rGmMT1AayvGq6dBk1fGCq
         46ec9LqlRHQQ+ZkUuy9aSRF6D6iTA4XhsG7DYp3ZZg7X+5XJidL3dLZ2x6OBQLx8UK1n
         cl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692879060; x=1693483860;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EAJAoNO+DLUnQwwLi/FlmnQuaAUZvdG/VahZ/SbUrQ=;
        b=Zn63mXRPkJNWpALvIYBkOoyKXyB5+F2A6q1W0TIkaMtU6ELfBySSKNOJnc96oeXibj
         ZbAuauTFzVWg9zpGINWB9J2Et/tfPYGtUZ3yQwOHuymmhR5EFFtLCu0j9McP1PST97tE
         bmCKYqEf35Xcun8opKOvZ1M5RdmzOEBEQ+syI8GMyPShwKG/8kqbP6hY9z7Xb1PgrQwF
         d4VRixT+Y58PWJEQJjcYpOF3vNLVJ1g64L5kg5p4MuN0V2aKlkjvkToyxnbupPfnq+LB
         3/taBhoSfhoX293JIlBpFue7jHd6A++xGt8GZj5Ss5/dryhKddKBjQ9azxHAEFeORB8R
         NC1Q==
X-Gm-Message-State: AOJu0YxeUEzfGVyJ5d4mAC6juorlRQorWnJ9N89URJcn8Cl95qNGmfC6
	128Yg+mrRPsVZJHJo/AaFVCR9c1XduE=
X-Google-Smtp-Source: AGHT+IFGVHVC+kf8R+UUKDrAG/Y8qbRzXIuCZmSMQmkyIR3nzzt91tRYM8vXjB3FSKXrPRKSdgFrQA==
X-Received: by 2002:a17:906:3191:b0:9a2:2635:dab5 with SMTP id 17-20020a170906319100b009a22635dab5mr550863ejy.7.1692879060225;
        Thu, 24 Aug 2023 05:11:00 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lf15-20020a170907174f00b009937e7c4e54sm10975854ejc.39.2023.08.24.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:10:59 -0700 (PDT)
Message-ID: <a4da3e50153720d8ba437182f66050910d669f05.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add basic BTF sanity validation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 24 Aug 2023 15:10:58 +0300
In-Reply-To: <20230823234426.2506685-1-andrii@kernel.org>
References: <20230823234426.2506685-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-08-23 at 16:44 -0700, Andrii Nakryiko wrote:
> Implement a simple and straightforward BTF sanity check when loading BTF
> information for BPF ELF file. Right now it's very basic and just
> validates that all the string offsets and type IDs are within valid
> range. But even with such simple checks it fixes a bunch of crashes
> found by OSS fuzzer ([0]-[5]) and will allow fuzzer to make further
> progress.
>=20
> Some other invariants will be checked in follow up patches (like
> ensuring there is no infinite type loops), but this seems like a good
> start already.
>=20
>   [0] https://github.com/libbpf/libbpf/issues/482
>   [1] https://github.com/libbpf/libbpf/issues/483
>   [2] https://github.com/libbpf/libbpf/issues/485
>   [3] https://github.com/libbpf/libbpf/issues/613
>   [4] https://github.com/libbpf/libbpf/issues/618
>   [5] https://github.com/libbpf/libbpf/issues/619
>=20
> Closes: https://github.com/libbpf/libbpf/issues/617
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf.c             | 146 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          |   7 ++
>  tools/lib/bpf/libbpf_internal.h |   2 +
>  3 files changed, 155 insertions(+)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8484b563b53d..5f23df94861e 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1155,6 +1155,152 @@ struct btf *btf__parse_split(const char *path, st=
ruct btf *base_btf)
>  	return libbpf_ptr(btf_parse(path, base_btf, NULL));
>  }
> =20
> +static int btf_validate_str(const struct btf *btf, __u32 str_off, const =
char *what, __u32 type_id)
> +{
> +	const char *s;
> +
> +	s =3D btf__str_by_offset(btf, str_off);
> +	if (!s) {
> +		pr_warn("btf: type [%u]: invalid %s (string offset %u)\n", type_id, wh=
at, str_off);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btf_validate_id(const struct btf *btf, __u32 id, __u32 ctx_id=
)
> +{
> +	const struct btf_type *t;
> +
> +	t =3D btf__type_by_id(btf, id);
> +	if (!t) {
> +		pr_warn("btf: type [%u]: invalid referenced type ID %u\n", ctx_id, id)=
;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btf_validate_type(const struct btf *btf, const struct btf_typ=
e *t, __u32 id)
> +{
> +	__u32 kind =3D btf_kind(t);
> +	int err, i, n;
> +
> +	err =3D btf_validate_str(btf, t->name_off, "type name", id);
> +	if (err)
> +		return err;
> +
> +	switch (kind) {
> +	case BTF_KIND_UNKN:
> +	case BTF_KIND_INT:
> +	case BTF_KIND_FWD:
> +	case BTF_KIND_FLOAT:
> +		break;
> +	case BTF_KIND_PTR:
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_FUNC:
> +	case BTF_KIND_VAR:
> +	case BTF_KIND_DECL_TAG:
> +	case BTF_KIND_TYPE_TAG:
> +		err =3D btf_validate_id(btf, t->type, id);
> +		if (err)
> +			return err;
> +		break;
> +	case BTF_KIND_ARRAY: {
> +		const struct btf_array *a =3D btf_array(t);
> +
> +		err =3D btf_validate_id(btf, a->index_type, id);

`a->index_type` should probably be `a->type` here, otherwise these two
checks are identical.

> +		err =3D err ?: btf_validate_id(btf, a->index_type, id);
> +		if (err)
> +			return err;
> +		break;
> +	}
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION: {
> +		const struct btf_member *m =3D btf_members(t);
> +
> +		n =3D btf_vlen(t);
> +		for (i =3D 0; i < n; i++, m++) {
> +			err =3D btf_validate_str(btf, m->name_off, "field name", id);
> +			err =3D err ?: btf_validate_id(btf, m->type, id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_ENUM: {
> +		const struct btf_enum *m =3D btf_enum(t);
> +
> +		n =3D btf_vlen(t);
> +		for (i =3D 0; i < n; i++, m++) {
> +			err =3D btf_validate_str(btf, m->name_off, "enum name", id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_ENUM64: {
> +		const struct btf_enum64 *m =3D btf_enum64(t);
> +
> +		n =3D btf_vlen(t);
> +		for (i =3D 0; i < n; i++, m++) {
> +			err =3D btf_validate_str(btf, m->name_off, "enum name", id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_FUNC_PROTO: {
> +		const struct btf_param *m =3D btf_params(t);
> +
> +		n =3D btf_vlen(t);
> +		for (i =3D 0; i < n; i++, m++) {
> +			err =3D btf_validate_str(btf, m->name_off, "param name", id);

Maybe check `m->type` here as well?

> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_DATASEC: {
> +		const struct btf_var_secinfo *m =3D btf_var_secinfos(t);
> +
> +		n =3D btf_vlen(t);
> +		for (i =3D 0; i < n; i++, m++) {
> +			err =3D btf_validate_id(btf, m->type, id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	default:
> +		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +/* Validate basic sanity of BTF. It's intentionally less thorough than
> + * kernel's validation and validates only properties of BTF that libbpf =
relies
> + * on to be correct (e.g., valid type IDs, valid string offsets, etc)
> + */
> +int btf_sanity_check(const struct btf *btf)
> +{
> +	const struct btf_type *t;
> +	__u32 i, n =3D btf__type_cnt(btf);
> +	int err;
> +
> +	for (i =3D 1; i < n; i++) {
> +		t =3D btf_type_by_id(btf, i);
> +		err =3D btf_validate_type(btf, t, i);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>  static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool s=
wap_endian);
> =20
>  int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, =
__u32 log_level)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4c3967d94b6d..71a3c768d9af 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2833,6 +2833,13 @@ static int bpf_object__init_btf(struct bpf_object =
*obj,
>  			pr_warn("Error loading ELF section %s: %d.\n", BTF_ELF_SEC, err);
>  			goto out;
>  		}
> +		err =3D btf_sanity_check(obj->btf);
> +		if (err) {
> +			pr_warn("elf: .BTF data is corrupted, discarding it...\n");
> +			btf__free(obj->btf);
> +			obj->btf =3D NULL;
> +			goto out;
> +		}
>  		/* enforce 8-byte pointers for BPF-targeted BTFs */
>  		btf__set_pointer_size(obj->btf, 8);
>  	}
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index f0f08635adb0..5e715a2d48f2 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -76,6 +76,8 @@
>  #define BTF_TYPE_TYPE_TAG_ENC(value, type) \
>  	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
> =20
> +int btf_sanity_check(const struct btf *btf);
> +
>  #ifndef likely
>  #define likely(x) __builtin_expect(!!(x), 1)
>  #endif


