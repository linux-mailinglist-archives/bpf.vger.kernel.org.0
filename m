Return-Path: <bpf+bounces-4707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748AE74E47E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E8E1C20CD3
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 02:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1D210B;
	Tue, 11 Jul 2023 02:56:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBA7F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:56:06 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C85A120
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 19:56:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b708e49059so79532411fa.3
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689044160; x=1691636160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S90A21sshKardGr2EX9EvB+0vf3RHIDrUVXGwEQJTY=;
        b=dqkDAk8ILq6fZtvjiRtWrn3nLUPncti3vLIJAC7D6byjeOSQQxmp1Gneqw3RR5zCl5
         6Jj4t5Lv6EOQU4ff9aTzpDcYr1dIOilp7166455KO8T8+qVdSE82FAZcqBiZyOBBmLsL
         MC+wYPsHqhKwHUvv4EKHd1D3UNh0iF8SwTIVnibom07ELgu+ofEN+BdgLrRaOCvMJPrE
         Zio9c3mqrBYzLPY6BJr/eayIu8u7tAOyWA1+V+qaBiMx/kdu9gEsM9/iXTlQmQctomOa
         EsmapjdazcvO88FeBM58Mre0fByGo1vXKo0bEjgeZRxKgqwtBHCBgv2+cSXUtLueKH6B
         cCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689044160; x=1691636160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S90A21sshKardGr2EX9EvB+0vf3RHIDrUVXGwEQJTY=;
        b=Nx9H/ILNyTxpJqgoKXVEzPEMtn0OHL2J36ejWAZOmpnKG/ENXiEAaqc62dPcHH3cWn
         XGpNJe7RRxZjTJYs4NGamXqpJPUAFGLAJXWT1Dt96KWkjXnvpWv/eng/RCOwcbw2PnkR
         loHRiCmxCZfCAkt+BrhjMSzNIQlDrMlUDLizgaw3XV2+eLLe0xQPUGzzFaYryqfnSSAs
         xqBJ2OLXKKg0PyM2S7/LMKQoftENkVhM2P9f3j24q9enO6ue7/RuYU0oVlevU5rPTxJ9
         QzUPa4qu+f/uy2/t0rVFC8X3EeNou6hNgg2p9n194abi5VFIjihDYgoeq2CpKFYET0e6
         dANg==
X-Gm-Message-State: ABy/qLbRiSotU9jUPNddXl3M49Rsub/Q24fhSvy0B2hDoyNZPJHjStoH
	YiuKsyy2e0VrF9AVk6kpfoAKyL2ag7M3/2l78w4=
X-Google-Smtp-Source: APBJJlEIWlxwntmTtapghMqiFYc/5nFkGtDNGCVC7fpW2Hhyf4NdFc5Byaa/W42Uu54LTDG7fBOHYZK4ofRtlcivVZ8=
X-Received: by 2002:a2e:7a16:0:b0:2b5:7a87:a85a with SMTP id
 v22-20020a2e7a16000000b002b57a87a85amr3890490ljc.13.1689044160229; Mon, 10
 Jul 2023 19:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230709025912.3837-1-laoar.shao@gmail.com> <20230709025912.3837-2-laoar.shao@gmail.com>
In-Reply-To: <20230709025912.3837-2-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 19:55:48 -0700
Message-ID: <CAADnVQKQzxUGz3Mhr5kQi2Zao7CKryCPG2JWj2dGn07UDM=oeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce BTF_TYPE_SAFE_TRUSTED_UNION
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 7:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> When we are verifying a field in a union, we may unexpectedly verify
> another field which has the same offset in this union. So in such case,
> we should annotate that field as PTR_UNTRUSTED. However, in some cases
> we are sure some fields in a union is safe and then we can add them into
> BTF_TYPE_SAFE_TRUSTED_UNION allow list.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/btf.c      | 20 +++++++++-----------
>  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 3dd47451f097..fae6fc24a845 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6133,7 +6133,6 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
>         const char *tname, *mname, *tag_value;
>         u32 vlen, elem_id, mid;
>
> -       *flag =3D 0;
>  again:
>         if (btf_type_is_modifier(t))
>                 t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> @@ -6144,6 +6143,14 @@ static int btf_struct_walk(struct bpf_verifier_log=
 *log, const struct btf *btf,
>         }
>
>         vlen =3D btf_type_vlen(t);
> +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && vlen !=3D 1 &=
& !(*flag & PTR_UNTRUSTED))
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
> @@ -6304,15 +6311,6 @@ static int btf_struct_walk(struct bpf_verifier_log=
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
> @@ -6478,7 +6476,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
>                           bool strict)
>  {
>         const struct btf_type *type;
> -       enum bpf_type_flag flag;
> +       enum bpf_type_flag flag =3D 0;
>         int err;
>
>         /* Are we already done? */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11e54dd8b6dd..1fb0a64f5bce 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5847,6 +5847,7 @@ static int bpf_map_direct_read(struct bpf_map *map,=
 int off, int size, u64 *val)
>  #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
>  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or=
_null)
>  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
> +#define BTF_TYPE_SAFE_TRUSTED_UNION(__type)  __PASTE(__type, __safe_trus=
ted_union)
>
>  /*
>   * Allow list few fields as RCU trusted or full trusted.
> @@ -5914,6 +5915,11 @@ BTF_TYPE_SAFE_TRUSTED(struct socket) {
>         struct sock *sk;
>  };
>
> +/* union trusted: these fields are trusted even in a uion */
> +BTF_TYPE_SAFE_TRUSTED_UNION(struct sk_buff) {
> +       struct sock *sk;
> +};

Why is this needed?
We already have:
BTF_TYPE_SAFE_RCU_OR_NULL(struct sk_buff) {
        struct sock *sk;
};

> +       /* Clear the PTR_UNTRUSTED for the fields which are in the allow =
list */
> +       if (type_is_trusted_union(env, reg, field_name, btf_id))
> +               flag &=3D ~PTR_UNTRUSTED;

we cannot do this unconditionally.
The type_is_rcu_or_null() check applies only after
 in_rcu_cs(env) && !type_may_be_null(reg->type)).

