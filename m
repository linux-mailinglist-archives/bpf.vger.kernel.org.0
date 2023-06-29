Return-Path: <bpf+bounces-3682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CB741E97
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF2E1C208C3
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 03:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D41855;
	Thu, 29 Jun 2023 03:12:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDF1365
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 03:12:38 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5572713
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 20:12:35 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-635d9e0aa6dso2130226d6.1
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688008354; x=1690600354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loeh9dtP7djU4WcoQLmUcOBkrmMzYO/XIvFnvpxIgLY=;
        b=HqSEzqJoox4gwweErmVSBvSdMTUXfOHeg272UqWqRr7M5xnsqbE/bSjHl4g3hL9GDO
         3j+xJFct2mY53d4wM18LRd0bwcXTGAnKmbrPZ8fSzahJA43mTGsZCqLTplaETOweUBpX
         1MgOp3UcBtqVLdbdfPVe6dbyklqUyngBouEG8R4L34Kjn+njQMadGV4EOxsFrIN1Z3iP
         YygfKeaSE908k8Ikvm3e8erEcHMGAHJGfOgKYo2CDgXD80nCMbjjsXnahUHRwzcPEzbO
         4lVlriL/gFN5/nJN9knuFFGzxXzs2X+yk3FqNIbyxMhfRTXoREy24el96VNgcp3ImMhD
         xmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688008354; x=1690600354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loeh9dtP7djU4WcoQLmUcOBkrmMzYO/XIvFnvpxIgLY=;
        b=XiRw+//5VttajJspNU+BzTRQNG6bJolJazyxC1Q6PKI1yNlRtUJALiD0xxnHfF+Hgi
         zMs7VujE2BB2/B3JdhnywNKDJZPU45A1Rl57XJp8ulqAIVnkW3++BBheo4hVjt4+i5tX
         83V4GpoMsmEgWmAoC59nN0iIeC+R7kt4tm/bnFd8gf292uMdS5cY+hbIKRplzqtx0EFk
         t+vRcmQvAUQNLZNXDPwkBUOQJ9xV36tRpqdIo0zQK4b3WJIjmRlkEIrkkNixrVb1ieiQ
         biD/RQwHLY5hEUWXaJkKKzx2Q+EUl1Je0V8fFe0ilSzlr7w2TldPLeJcj8B6xIFQ8nIk
         g/hg==
X-Gm-Message-State: AC+VfDw7fLS0FVcm+XD5Q40pq2KzxafBFiUGNXzTiuBhukF4xv6+D3N6
	l9UuvjdCQEmGA1FHAU0z7+jcRXkATAX2TyS/1Ek=
X-Google-Smtp-Source: ACHHUZ4YEBqZKtLcLkS8xsyyZHTziblBYCIYjAz3b/N6tP1NhewA4WuH4bA/cwS94JRohbM+KZpFX5tvXQYZ49dh3FE=
X-Received: by 2002:a05:6214:1311:b0:635:f2a4:9543 with SMTP id
 pn17-20020a056214131100b00635f2a49543mr8117233qvb.25.1688008354530; Wed, 28
 Jun 2023 20:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115205.248395-1-laoar.shao@gmail.com> <20230628115205.248395-2-laoar.shao@gmail.com>
In-Reply-To: <20230628115205.248395-2-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 Jun 2023 11:11:58 +0800
Message-ID: <CALOAHbCreRRkLwt0Vyp9rUbL7JVzD5A4CET=jKoUJwAHXPop7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix an error around PTR_UNTRUSTED
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 7:52=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Per discussion with Alexei, the PTR_UNTRUSTED flag should not been
> cleared when we start to walk a new struct, because the struct in
> question may be a struct nested in a union. We should also check and set
> this flag before we walk its each member, in case itself is a union.
>
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/btf.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 29fe21099298..e0a493230727 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6133,7 +6133,6 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
>         const char *tname, *mname, *tag_value;
>         u32 vlen, elem_id, mid;
>
> -       *flag =3D 0;
>  again:
>         tname =3D __btf_name_by_offset(btf, t->name_off);
>         if (!btf_type_is_struct(t)) {
> @@ -6142,6 +6141,14 @@ static int btf_struct_walk(struct bpf_verifier_log=
 *log, const struct btf *btf,
>         }
>
>         vlen =3D btf_type_vlen(t);
> +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && vlen !=3D 1)
> +               /*
> +                * walking unions yields untrusted pointers
> +                * with exception of __bpf_md_ptr and other
> +                * unions with a single member
> +                */
> +               *flag |=3D PTR_UNTRUSTED;
> +
>         if (off + size > t->size) {
>                 /* If the last element is a variable size array, we may
>                  * need to relax the rule.
> @@ -6302,15 +6309,6 @@ static int btf_struct_walk(struct bpf_verifier_log=
 *log, const struct btf *btf,
>                  * of this field or inside of this struct
>                  */
>                 if (btf_type_is_struct(mtype)) {
> -                       if (BTF_INFO_KIND(mtype->info) =3D=3D BTF_KIND_UN=
ION &&
> -                           btf_type_vlen(mtype) !=3D 1)
> -                               /*
> -                                * walking unions yields untrusted pointe=
rs
> -                                * with exception of __bpf_md_ptr and oth=
er
> -                                * unions with a single member
> -                                */
> -                               *flag |=3D PTR_UNTRUSTED;
> -
>                         /* our field must be inside that union or struct =
*/
>                         t =3D mtype;
>
> @@ -6476,7 +6474,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
>                           bool strict)
>  {
>         const struct btf_type *type;
> -       enum bpf_type_flag flag;
> +       enum bpf_type_flag flag =3D 0;
>         int err;
>
>         /* Are we already done? */
> --
> 2.39.3
>

Just noticed that it breaks test_sk_storage_tracing, because skb->sk
is in a union:
   struct sk_buff {
       ...
       union {
           struct sock             *sk;
           int                     ip_defrag_offset;
       };
       ...
   };

I will think about it.

--=20
Regards
Yafang

