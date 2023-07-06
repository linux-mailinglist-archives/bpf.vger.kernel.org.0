Return-Path: <bpf+bounces-4138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5093674930C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E1A28116F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE17A35;
	Thu,  6 Jul 2023 01:24:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7337F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:24:59 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4321994
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 18:24:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so94979e87.0
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 18:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688606696; x=1691198696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aduXOMIw4gc/1m/GHorhrIWfXAetKkR2Yed066R58g=;
        b=BBCIzLcd60OMI4574CHrintsbbolczqhr3yh1tP98pqYz2GREdDZUrtLls3KmIm8zc
         Fx7qeL9BUD5AB/SWp74SoiG3j3xruqR5INYnRXZPJ6xZSo4UZe3DOleUApQZbV+0A4jS
         BaYVkx2m+OWcGrFosjiLjrBGvHRG01IhQ+mKtv3eweFrG9zXDXc/MdlPS+EHsomK7Znt
         dq/YoYdrXigBMn+G4hfAV4J8YzfMifZgzl2Scbx4OntJLziUFQvtGPYSBfPecVKBjIvg
         P03OW0sngLlyxysGusMWdHBzaq9p8H1VDjU35R/1/Ft1VUhbeNE9OuGILC7so2A9jB5P
         2Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606696; x=1691198696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aduXOMIw4gc/1m/GHorhrIWfXAetKkR2Yed066R58g=;
        b=jjs2m1qJ7rdLm71z9dzrDIQfAwrSXQsQ2SiJYxYR6oY/O3rQH4tdR71O2Gj01ru8rX
         8QEX87/ep4u4YxQzkUAYxOg5hfkwp3mgFgghNwKQP7TV/0IiJ0aiBP7l3Gnbf1r/QaIz
         3S8hNWd0gXxxWIzKZs37vXbQYnG3fZ7SvxtNBkI5lZFTgXl6Po1AhOUUGym0viOe+eDV
         nHBnwIdQ02e3+Bni2Sp33TOPqZVdfq7MIVr62ZTLHb1U8lYS6eUjXLEqNpPdpERp2eb5
         dCAf7XeBPMvGej/B7Ict+JY6hvsLaKldV+3fkE2/w+6bN8lgRKIF+1UBMrYaOUPYoFx6
         IeWQ==
X-Gm-Message-State: ABy/qLbKOmRg43AJ2Drfp2AK5pOC6W8nbVEjjQRmyku1FQ9uAXtP8kfj
	G/KURU//B+eGlSQUZpL+VeJKt7feqFrux4Yiz6M=
X-Google-Smtp-Source: APBJJlGEjIXQWxt1tyK4YvwQp098LtBoh/uzfcBcWy484HEhRgH/IvY1mGmovZYlCgDaFsfleaJYQo0gNbpkGzSpKc0=
X-Received: by 2002:a05:6512:1ca:b0:4f8:6255:9e78 with SMTP id
 f10-20020a05651201ca00b004f862559e78mr356606lfp.60.1688606695869; Wed, 05 Jul
 2023 18:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705160139.19967-1-aspsk@isovalent.com> <20230705160139.19967-4-aspsk@isovalent.com>
In-Reply-To: <20230705160139.19967-4-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Jul 2023 18:24:44 -0700
Message-ID: <CAADnVQKX5Lu-frv38AAe15UmzRNMztB9vYSZTk986Y_UkPR30Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/6] bpf: populate the per-cpu
 insertions/deletions counters for hashmaps
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 9:00=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> Initialize and utilize the per-cpu insertions/deletions counters for hash=
-based
> maps. Non-trivial changes apply to preallocated maps for which the
> {inc,dec}_elem_count functions are not called, as there's no need in coun=
ting
> elements to sustain proper map operations.
>
> To increase/decrease percpu counters for preallocated hash maps we add ra=
w
> calls to the bpf_map_{inc,dec}_elem_count functions so that the impact is
> minimal. For dynamically allocated maps we add corresponding calls to the
> existing {inc,dec}_elem_count functions.
>
> For LRU maps bpf_map_{inc,dec}_elem_count added to the lru pop/free helpe=
rs.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  kernel/bpf/hashtab.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 56d3da7d0bc6..c23557bf9a1a 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -302,6 +302,7 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_=
htab *htab, void *key,
>         struct htab_elem *l;
>
>         if (node) {
> +               bpf_map_inc_elem_count(&htab->map);
>                 l =3D container_of(node, struct htab_elem, lru_node);
>                 memcpy(l->key, key, htab->map.key_size);
>                 return l;
> @@ -581,10 +582,17 @@ static struct bpf_map *htab_map_alloc(union bpf_att=
r *attr)
>                 }
>         }
>
> +       err =3D bpf_map_init_elem_count(&htab->map);
> +       if (err)
> +               goto free_extra_elements;
> +
>         return &htab->map;
>
> +free_extra_elements:
> +       free_percpu(htab->extra_elems);
>  free_prealloc:
> -       prealloc_destroy(htab);
> +       if (prealloc)
> +               prealloc_destroy(htab);

This is a bit difficult to read.
I think the logic would be easier to understand if bpf_map_init_elem_count
was done right before htab->buckets =3D bpf_map_area_alloc()
and if (err) goto free_htab
where you would add bpf_map_free_elem_count.

