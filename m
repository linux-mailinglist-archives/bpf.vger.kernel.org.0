Return-Path: <bpf+bounces-8525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8775D787A12
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 23:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85021C20EFA
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BA8BEB;
	Thu, 24 Aug 2023 21:17:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C917F
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 21:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B0EC433CA
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692911871;
	bh=RnKCKj+TdG4MLzSh36aROXkCpLnwUM4FKUHFkpOFfaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t9bE0Msv79DVd4JR/DzU1gEB4704s8z8pTLS060M21e0MwjGao9BJjjWHAF4HPx7k
	 GE7FZanDtgImjjNMZmXnreAybTOOlk3Zpwh6UMeM7BE66nZuzHFf5QbJDRkcaWtVYC
	 37pdqTaduu1UMBKjC0QQ446PlahIEun2Vs5jO+Wfy5Apt0LEqnxy5MhQ6KJq0JQqgs
	 EcAeCkfnDVVSwr/Z2S0MM8SdjOC+EooxiRHQACiZo1lmdtZCD1AVKlMMIt0F4PV7FZ
	 LxqxlK/Ex2KV720TGuIHKZcHMNUewz8KoPDzSFjNUapQ3IWdIDJiTJrYTrc10J9Sbo
	 QJmoAGs3wmPaQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5008faf4456so354668e87.3
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 14:17:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YwX+zGHujB8/5bxIvcwKV2R9gbjHqP/GoHvjVIzY9qH3Gu/lDEl
	U1SexBXFObGA8ZCcaoqHGcP64USe6BowjGIJysY=
X-Google-Smtp-Source: AGHT+IFvGCyPZMx+7FaOs1DMcsTabBB8J8ZDTvibEEHeBShiFzT2pDf9bgt0PpEtnwsK57qnpv6mL+X/V2oRuSIeqRs=
X-Received: by 2002:a05:6512:ba0:b0:500:882b:e55a with SMTP id
 b32-20020a0565120ba000b00500882be55amr9812978lfv.45.1692911869096; Thu, 24
 Aug 2023 14:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824201358.1395122-1-andrii@kernel.org>
In-Reply-To: <20230824201358.1395122-1-andrii@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 24 Aug 2023 14:17:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Qw1xOXruC5E7WjxwdMom3BwyU_2NsAjSx7rmFb7e16g@mail.gmail.com>
Message-ID: <CAPhsuW6Qw1xOXruC5E7WjxwdMom3BwyU_2NsAjSx7rmFb7e16g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: add basic BTF sanity validation
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 1:14=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
[...]
> +
> +static int btf_validate_type(const struct btf *btf, const struct btf_typ=
e *t, __u32 id)
> +{
> +       __u32 kind =3D btf_kind(t);
> +       int err, i, n;
> +
> +       err =3D btf_validate_str(btf, t->name_off, "type name", id);
> +       if (err)
> +               return err;
> +
> +       switch (kind) {
> +       case BTF_KIND_UNKN:
> +       case BTF_KIND_INT:
> +       case BTF_KIND_FWD:
> +       case BTF_KIND_FLOAT:
> +               break;
> +       case BTF_KIND_PTR:
> +       case BTF_KIND_TYPEDEF:
> +       case BTF_KIND_VOLATILE:
> +       case BTF_KIND_CONST:
> +       case BTF_KIND_RESTRICT:
> +       case BTF_KIND_FUNC:
> +       case BTF_KIND_VAR:
> +       case BTF_KIND_DECL_TAG:
> +       case BTF_KIND_TYPE_TAG:
> +               err =3D btf_validate_id(btf, t->type, id);
> +               if (err)
> +                       return err;

We can "return err;" at the end, and then remove all these "if (err)
return err;", right?

Thanks,
Song

> +               break;
> +       case BTF_KIND_ARRAY: {
> +               const struct btf_array *a =3D btf_array(t);
> +
> +               err =3D btf_validate_id(btf, a->type, id);
> +               err =3D err ?: btf_validate_id(btf, a->index_type, id);
> +               if (err)
> +                       return err;
> +               break;
> +       }
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION: {
> +               const struct btf_member *m =3D btf_members(t);
> +
> +               n =3D btf_vlen(t);
> +               for (i =3D 0; i < n; i++, m++) {
> +                       err =3D btf_validate_str(btf, m->name_off, "field=
 name", id);
> +                       err =3D err ?: btf_validate_id(btf, m->type, id);
> +                       if (err)
> +                               return err;
> +               }
> +               break;
> +       }
> +       case BTF_KIND_ENUM: {
> +               const struct btf_enum *m =3D btf_enum(t);
> +
> +               n =3D btf_vlen(t);
> +               for (i =3D 0; i < n; i++, m++) {
> +                       err =3D btf_validate_str(btf, m->name_off, "enum =
name", id);
> +                       if (err)
> +                               return err;
> +               }
> +               break;
> +       }
> +       case BTF_KIND_ENUM64: {
> +               const struct btf_enum64 *m =3D btf_enum64(t);
> +
> +               n =3D btf_vlen(t);
> +               for (i =3D 0; i < n; i++, m++) {
> +                       err =3D btf_validate_str(btf, m->name_off, "enum =
name", id);
> +                       if (err)
> +                               return err;
> +               }
> +               break;
> +       }
> +       case BTF_KIND_FUNC_PROTO: {
> +               const struct btf_param *m =3D btf_params(t);
> +
> +               n =3D btf_vlen(t);
> +               for (i =3D 0; i < n; i++, m++) {
> +                       err =3D btf_validate_str(btf, m->name_off, "param=
 name", id);
> +                       err =3D err ?: btf_validate_id(btf, m->type, id);
> +                       if (err)
> +                               return err;
> +               }
> +               break;
> +       }
> +       case BTF_KIND_DATASEC: {
> +               const struct btf_var_secinfo *m =3D btf_var_secinfos(t);
> +
> +               n =3D btf_vlen(t);
> +               for (i =3D 0; i < n; i++, m++) {
> +                       err =3D btf_validate_id(btf, m->type, id);
> +                       if (err)
> +                               return err;
> +               }
> +               break;
> +       }
> +       default:
> +               pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kin=
d);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
[...]

