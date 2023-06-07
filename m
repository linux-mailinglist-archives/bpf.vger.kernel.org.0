Return-Path: <bpf+bounces-2022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42C0726A2F
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3C31C20ED2
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6287D39240;
	Wed,  7 Jun 2023 19:52:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB9182AE
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 19:51:59 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFE1715
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 12:51:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1acd41ad2so72673381fa.3
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686167512; x=1688759512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0C9Z7fmO1gZi/NBQSnhkdNlc+dig0lX+KOSMPtej0K8=;
        b=jxXa2FoUe/J0mWbS+Fw5Ih//+rHDbj4Sje3RJt8wQhGspPJsX7j85a/pzX/msNdr4u
         zlfA0yEbKKqdvibfIcDeC9d6QQd5Q3+2v6kzwONICp0vbW14N786jAZ2FhCkJ5t7k67w
         8JrqJb0FXKfztXdk1KtvxKsmrFr/EKJgBZysArOHFlRTm5aoo6SpM8WOW7B8dFofPjgk
         qJeWwpVYQyvxrXNSjfoWEj9FGpjXBRxhuLmzogfe1YZ2yC/W+Ro0NJwJwoR7zl5RBAKV
         wx1VD5UWH9iKEcTlkar75PR6wBy5rgHjAVC1lPvaow4sreXWL156BEJZqJcDT854H+lJ
         +g5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686167512; x=1688759512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0C9Z7fmO1gZi/NBQSnhkdNlc+dig0lX+KOSMPtej0K8=;
        b=lil87ABCgwSyCvFlurrmfRLidKuKvWyDxDzZsbxW71R0b+j1Vevcao8daEdvl0TjN+
         K387bn6xEYeaBUY1MpJTE+8Yr7kvh/zA9FOKU6Cb0yZx1dRNfsbgQ5zlUBuYr1tIDGHj
         xM5bkvXufGPqry1mt15sc8asSjGVN+wplfhzHYAoZ4Lz2q0qbCuA3nTbXYc2qozV1a7K
         f3cZOxeaKsUc9I/uAdkp660DK3PnxySNuIi/Cz7ERiH3r3NpdKYMqStUrp3+S7CkS6ac
         0C8I9OHdP708jP68nrtB2+iih7iy1Se1cRCAlhMafktUF8WQNRNYl1jHVdTEKeiP60yZ
         Cf7w==
X-Gm-Message-State: AC+VfDz/rkJl6LGHr1UIzscIGaAyWzgRotVT741xU5bN6Kn41k4fAM30
	Wu/6VSly+gwt7ueSGyIL1l0=
X-Google-Smtp-Source: ACHHUZ5HW4jJX/QDuD5hIUVQGw8Pp0bVyePVloG8Jr4OuUSsCNLyEYmAFsOVP3PVyasIpxG7VljH3Q==
X-Received: by 2002:a2e:b16f:0:b0:2b1:d19a:f190 with SMTP id a15-20020a2eb16f000000b002b1d19af190mr2375885ljm.49.1686167511913;
        Wed, 07 Jun 2023 12:51:51 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z12-20020a2e8e8c000000b002b1a3ceb703sm2380994ljk.6.2023.06.07.12.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:51:51 -0700 (PDT)
Message-ID: <d2e61cf5ee93f0bb6f6d402208c19be1a7b55838.camel@gmail.com>
Subject: Re: [RFC bpf-next 4/8] btf: support kernel parsing of BTF with
 metadata, use it to parse BTF with unknown kinds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org,  quentin@isovalent.com,
 mykolal@fb.com, bpf@vger.kernel.org
Date: Wed, 07 Jun 2023 22:51:49 +0300
In-Reply-To: <20230531201936.1992188-5-alan.maguire@oracle.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
	 <20230531201936.1992188-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-05-31 at 21:19 +0100, Alan Maguire wrote:
> Validate metadata if present, and use it to parse BTF with
> unrecognized kinds. Reject BTF that contains a type
> of a kind that is not optional.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/bpf/btf.c | 102 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 85 insertions(+), 17 deletions(-)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index bd2cac057928..67f42d9ce099 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -257,6 +257,7 @@ struct btf {
>  	struct btf_kfunc_set_tab *kfunc_set_tab;
>  	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
>  	struct btf_struct_metas *struct_meta_tab;
> +	struct btf_metadata *meta_data;
> =20
>  	/* split BTF support */
>  	struct btf *base_btf;
> @@ -4965,22 +4966,41 @@ static s32 btf_check_meta(struct btf_verifier_env=
 *env,
>  		return -EINVAL;
>  	}
> =20
> -	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> -	    BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> -		btf_verifier_log(env, "[%u] Invalid kind:%u",
> -				 env->log_type_id, BTF_INFO_KIND(t->info));
> -		return -EINVAL;
> -	}
> -
>  	if (!btf_name_offset_valid(env->btf, t->name_off)) {
>  		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
>  				 env->log_type_id, t->name_off);
>  		return -EINVAL;
>  	}
> =20
> -	var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> -	if (var_meta_size < 0)
> -		return var_meta_size;
> +	if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> +		btf_verifier_log(env, "[%u] Invalid kind:%u",
> +				 env->log_type_id, BTF_INFO_KIND(t->info));
> +		return -EINVAL;
> +	}
> +
> +	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->meta_data &&
> +	    BTF_INFO_KIND(t->info) < env->btf->meta_data->kind_meta_cnt) {
> +		struct btf_kind_meta *m =3D &env->btf->meta_data->kind_meta[BTF_INFO_K=
IND(t->info)];
> +
> +		if (!(m->flags & BTF_KIND_META_OPTIONAL)) {
> +			btf_verifier_log(env, "[%u] unknown but required kind '%s'(%u)",
> +					 env->log_type_id,
> +					 btf_name_by_offset(env->btf, m->name_off),
> +					 BTF_INFO_KIND(t->info));
> +			return -EINVAL;
> +		}
> +		var_meta_size =3D sizeof(struct btf_type);
> +		var_meta_size +=3D m->info_sz + (btf_type_vlen(t) * m->elem_sz);
> +	} else {
> +		if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> +			btf_verifier_log(env, "[%u] Invalid kind:%u",
> +					 env->log_type_id, BTF_INFO_KIND(t->info));
> +			return -EINVAL;
> +		}
> +		var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> +		if (var_meta_size < 0)
> +			return var_meta_size;
> +	}
> =20
>  	meta_left -=3D var_meta_size;
> =20
> @@ -5155,7 +5175,8 @@ static int btf_parse_str_sec(struct btf_verifier_en=
v *env)
>  	start =3D btf->nohdr_data + hdr->str_off;
>  	end =3D start + hdr->str_len;
> =20
> -	if (end !=3D btf->data + btf->data_size) {
> +	if (hdr->hdr_len < sizeof(struct btf_header) &&
> +	    end !=3D btf->data + btf->data_size) {
>  		btf_verifier_log(env, "String section is not at the end");
>  		return -EINVAL;
>  	}
> @@ -5176,9 +5197,47 @@ static int btf_parse_str_sec(struct btf_verifier_e=
nv *env)
>  	return 0;
>  }
> =20
> +static int btf_parse_meta_sec(struct btf_verifier_env *env)
> +{
> +	const struct btf_header *hdr =3D &env->btf->hdr;
> +	struct btf *btf =3D env->btf;
> +	void *start, *end;
> +
> +	if (hdr->hdr_len < sizeof(struct btf_header) ||
> +	    hdr->meta_header.meta_len =3D=3D 0)
> +		return 0;
> +
> +	/* Meta section must align to 8 bytes */
> +	if (hdr->meta_header.meta_off & (sizeof(u64) - 1)) {
> +		btf_verifier_log(env, "Unaligned meta_off");
> +		return -EINVAL;
> +	}
> +	start =3D btf->nohdr_data + hdr->meta_header.meta_off;
> +	end =3D start + hdr->meta_header.meta_len;
> +
> +	if (hdr->meta_header.meta_len < sizeof(struct btf_meta_header)) {
> +		btf_verifier_log(env, "Metadata section is too small");
> +		return -EINVAL;
> +	}
> +	if (end !=3D btf->data + btf->data_size) {
> +		btf_verifier_log(env, "Metadata section is not at the end");
> +		return -EINVAL;
> +	}
> +	btf->meta_data =3D start;
> +
> +	if (hdr->meta_header.meta_len !=3D sizeof(struct btf_metadata) +
> +					(btf->meta_data->kind_meta_cnt *
> +					 sizeof(struct btf_kind_meta))) {
> +		btf_verifier_log(env, "Metadata section size mismatch");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static const size_t btf_sec_info_offset[] =3D {
>  	offsetof(struct btf_header, type_off),
>  	offsetof(struct btf_header, str_off),
> +	offsetof(struct btf_header, meta_header.meta_off),
>  };
> =20
>  static int btf_sec_info_cmp(const void *a, const void *b)
> @@ -5193,15 +5252,19 @@ static int btf_check_sec_info(struct btf_verifier=
_env *env,
>  			      u32 btf_data_size)
>  {
>  	struct btf_sec_info secs[ARRAY_SIZE(btf_sec_info_offset)];
> -	u32 total, expected_total, i;
> +	u32 nr_secs =3D ARRAY_SIZE(btf_sec_info_offset);
> +	u32 total, expected_total, gap, i;
>  	const struct btf_header *hdr;
>  	const struct btf *btf;
> =20
>  	btf =3D env->btf;
>  	hdr =3D &btf->hdr;
> =20
> +	if (hdr->hdr_len < sizeof(struct btf_header))
> +		nr_secs--;
> +
>  	/* Populate the secs from hdr */
> -	for (i =3D 0; i < ARRAY_SIZE(btf_sec_info_offset); i++)
> +	for (i =3D 0; i < nr_secs; i++)
>  		secs[i] =3D *(struct btf_sec_info *)((void *)hdr +
>  						   btf_sec_info_offset[i]);
> =20
> @@ -5216,9 +5279,10 @@ static int btf_check_sec_info(struct btf_verifier_=
env *env,
>  			btf_verifier_log(env, "Invalid section offset");
>  			return -EINVAL;
>  		}
> -		if (total < secs[i].off) {
> -			/* gap */
> -			btf_verifier_log(env, "Unsupported section found");
> +		gap =3D secs[i].off - total;
> +		if (gap >=3D 8) {
> +			/* gap larger than alignment gap */
> +			btf_verifier_log(env, "Unsupported section gap found");

I have two `prog_tests` tests failing with this patch applied:
* btf/btf_header test. Gap between hdr and type
  Here expected string should be updated:

--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -1579,7 +1579,7 @@ static struct btf_raw_test raw_tests[] =3D {
        .max_entries =3D 4,
        .btf_load_err =3D true,
        .type_off_delta =3D 4,
-       .err_str =3D "Unsupported section found",
+       .err_str =3D "Unsupported section gap found",
 },

* btf/btf_header test. Overlap between type and str
  This test expects error string "Section overlap found",
  but instead "Section overlap found" is printed.
  This happens with the following values of local variables:
   =C2=A0
    total=3D20, secs[2].off=3D16, gap=3D-4

  (`gap` is printed as signed using %d).

>  			return -EINVAL;
>  		}
>  		if (total > secs[i].off) {
> @@ -5230,7 +5294,7 @@ static int btf_check_sec_info(struct btf_verifier_e=
nv *env,
>  					 "Total section length too long");
>  			return -EINVAL;
>  		}
> -		total +=3D secs[i].len;
> +		total +=3D secs[i].len + gap;
>  	}
> =20
>  	/* There is data other than hdr and known sections */
> @@ -5530,6 +5594,10 @@ static struct btf *btf_parse(const union bpf_attr =
*attr, bpfptr_t uattr, u32 uat
>  	if (err)
>  		goto errout;
> =20
> +	err =3D btf_parse_meta_sec(env);
> +	if (err)
> +		goto errout;
> +
>  	err =3D btf_parse_type_sec(env);
>  	if (err)
>  		goto errout;


