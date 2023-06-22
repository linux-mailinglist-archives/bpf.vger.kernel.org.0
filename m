Return-Path: <bpf+bounces-3201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7223573AC4B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC6F2817F8
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58722575;
	Thu, 22 Jun 2023 22:03:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4D21091
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 22:03:36 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A341BD0
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:03:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so568755e9.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687471413; x=1690063413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMcV+4/sdw+OFU0WDHBWZd4oBGOkRoLYGPHp6GwWLQM=;
        b=pM5UDU0HftvBSY/uoe/oxgS3+ElCdFos9tG31KfWPxE7HnSQ+crgNV1ltvmmh+W2yN
         47LhE1IMhGKphLxSRvs31wBt8wEDq47mHHMLJtXtRZRgbxWEe4akD7B2Xroq+STsLJuc
         ipEOPxXkq82kg4RiuuuqAcaml++IURXo0x6ACVP4HSapxwwKlgfMf2lk+sD5nY236AF0
         aLwstWqNwvC4iKoiews/iu4DZgQZej7ttndOpMeAP600KZRp6U16awSotCdA6yk0BO8a
         Anx+PGgCCDrTcGWvM4VFMUE72EL1RgRRrfjzAu2aR+QOUyNZiL0t06ahTQz+o3Z/EbIP
         Wk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687471413; x=1690063413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMcV+4/sdw+OFU0WDHBWZd4oBGOkRoLYGPHp6GwWLQM=;
        b=XoCX1DUzTLI4b+gMtaVbVyNvlAwroVJeMqyl/rCm8QqwT+KcbiAm0KbkUK1ZhIjZ/9
         VDN2Q2Hu3B61X6N5Zv2MuUlQVL+vtrdijnBgVlkWhKbdZXqvz0lD0pRkn3fSTAhxMHWs
         KDHAwPpjojN6eUGwK2zYwLWWEC36lTbVNx6g7kprk1or47Q26gJGECPIcPMUwnjfOEvv
         TO7RmL3jab0wAUBbAsNdbOcYsK+XXUUIL6StURWtklnyTb59ZfUq3y+uOrs7m5Dyt2P2
         aQMbOStsRxm0Dh8HCsaUu88PKfa8Vniqs/q9MKy76py2t/2vdq1+MDZzlhWvKAwDa1fS
         hdEg==
X-Gm-Message-State: AC+VfDz34V8rpgQKM+zirJiuESrPWohlLV4dAx8a7py0ownh3mnkZ/ij
	9deYQQ6iAChUcyB+RxE1PVPCvsA7nULJbbJtQ2g=
X-Google-Smtp-Source: ACHHUZ7V+Pv0/bqfQUBakRrbd7Xm5ZcNLPIaP6dGxKVZbWUQDr+Qbe1DmpLs8FazqyDiIOoaXpATOVUBIIqPlsL0Oaw=
X-Received: by 2002:a1c:f70d:0:b0:3f8:b6c:84aa with SMTP id
 v13-20020a1cf70d000000b003f80b6c84aamr14330840wmh.24.1687471412709; Thu, 22
 Jun 2023 15:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616171728.530116-1-alan.maguire@oracle.com> <20230616171728.530116-5-alan.maguire@oracle.com>
In-Reply-To: <20230616171728.530116-5-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 15:03:21 -0700
Message-ID: <CAEf4BzbKaZm-STb3USz=T9jhtK+=TtFK_cpcoJfZ7rxqt=9TRA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/9] btf: support kernel parsing of BTF with
 kind layout
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 10:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> Use kind layout to parse BTF with unknown kinds that have a
> kind layout representation.
>
> Validate kind layout if present, and use it to parse BTF with
> unrecognized kinds. Reject BTF that contains a type
> of a kind that is not optional.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/bpf/btf.c | 102 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 82 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index bd2cac057928..ffe3926ea051 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -257,6 +257,7 @@ struct btf {
>         struct btf_kfunc_set_tab *kfunc_set_tab;
>         struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
>         struct btf_struct_metas *struct_meta_tab;
> +       struct btf_kind_layout *kind_layout;
>
>         /* split BTF support */
>         struct btf *base_btf;
> @@ -4965,22 +4966,41 @@ static s32 btf_check_meta(struct btf_verifier_env=
 *env,
>                 return -EINVAL;
>         }
>
> -       if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> -           BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> -               btf_verifier_log(env, "[%u] Invalid kind:%u",
> -                                env->log_type_id, BTF_INFO_KIND(t->info)=
);
> -               return -EINVAL;
> -       }
> -
>         if (!btf_name_offset_valid(env->btf, t->name_off)) {
>                 btf_verifier_log(env, "[%u] Invalid name_offset:%u",
>                                  env->log_type_id, t->name_off);
>                 return -EINVAL;
>         }
>
> -       var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> -       if (var_meta_size < 0)
> -               return var_meta_size;
> +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> +               btf_verifier_log(env, "[%u] Invalid kind:%u",
> +                                env->log_type_id, BTF_INFO_KIND(t->info)=
);
> +               return -EINVAL;
> +       }
> +
> +       if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_layou=
t &&
> +           (BTF_INFO_KIND(t->info) * sizeof(struct btf_kind_layout)) <
> +            env->btf->hdr.kind_layout_len) {
> +               struct btf_kind_layout *k =3D &env->btf->kind_layout[BTF_=
INFO_KIND(t->info)];
> +
> +               if (!(k->flags & BTF_KIND_LAYOUT_OPTIONAL)) {

same question as on previous patch, should kernel trust and handle
OPTIONAL flag?

I'd say let's drop it for now, doesn't seem worth the trouble

> +                       btf_verifier_log(env, "[%u] unknown but required =
kind %u",
> +                                        env->log_type_id,
> +                                        BTF_INFO_KIND(t->info));
> +                       return -EINVAL;
> +               }
> +               var_meta_size =3D sizeof(struct btf_type);
> +               var_meta_size +=3D k->info_sz + (btf_type_vlen(t) * k->el=
em_sz);
> +       } else {
> +               if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> +                       btf_verifier_log(env, "[%u] Invalid kind:%u",
> +                                        env->log_type_id, BTF_INFO_KIND(=
t->info));
> +                       return -EINVAL;
> +               }
> +               var_meta_size =3D btf_type_ops(t)->check_meta(env, t, met=
a_left);
> +               if (var_meta_size < 0)
> +                       return var_meta_size;
> +       }
>
>         meta_left -=3D var_meta_size;
>
> @@ -5155,7 +5175,8 @@ static int btf_parse_str_sec(struct btf_verifier_en=
v *env)
>         start =3D btf->nohdr_data + hdr->str_off;
>         end =3D start + hdr->str_len;
>
> -       if (end !=3D btf->data + btf->data_size) {
> +       if (hdr->hdr_len < sizeof(struct btf_header) &&
> +           end !=3D btf->data + btf->data_size) {
>                 btf_verifier_log(env, "String section is not at the end")=
;
>                 return -EINVAL;
>         }
> @@ -5176,9 +5197,41 @@ static int btf_parse_str_sec(struct btf_verifier_e=
nv *env)
>         return 0;
>  }
>
> +static int btf_parse_kind_layout_sec(struct btf_verifier_env *env)
> +{
> +       const struct btf_header *hdr =3D &env->btf->hdr;
> +       struct btf *btf =3D env->btf;
> +       void *start, *end;
> +
> +       if (hdr->hdr_len < sizeof(struct btf_header) ||
> +           hdr->kind_layout_len =3D=3D 0)

let's make sure that kind_layout_off is zero in this case as well

> +               return 0;
> +
> +       /* Kind layout section must align to 4 bytes */
> +       if (hdr->kind_layout_off & (sizeof(u32) - 1)) {
> +               btf_verifier_log(env, "Unaligned kind_layout_off");
> +               return -EINVAL;
> +       }
> +       start =3D btf->nohdr_data + hdr->kind_layout_off;
> +       end =3D start + hdr->kind_layout_len;
> +
> +       if (hdr->kind_layout_len < sizeof(struct btf_kind_layout)) {

same as on libbpf side, more generally kind_layout_len should be a
multiple of sizeof(struct btf_kind_layout)

> +               btf_verifier_log(env, "Kind layout section is too small")=
;
> +               return -EINVAL;
> +       }
> +       if (end !=3D btf->data + btf->data_size) {
> +               btf_verifier_log(env, "Kind layout section is not at the =
end");
> +               return -EINVAL;
> +       }
> +       btf->kind_layout =3D start;
> +
> +       return 0;
> +}
> +

[...]

