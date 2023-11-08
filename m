Return-Path: <bpf+bounces-14528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5832D7E6079
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0471C20B1E
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2F619BA7;
	Wed,  8 Nov 2023 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITi5IGNZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E35199BE
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 22:46:53 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4A22587
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 14:46:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so286700a12.0
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699483611; x=1700088411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR1ua4QGvYfvQRDANHUyJ3hhbBvRiXgQBSeEeXP8j/c=;
        b=ITi5IGNZC9E/KtL2GwEHHLzZ9b/o75zE2VytlyDy5rtMZMeaMlJgmj+9acgy8Ovw62
         z/kl2Gd2Zexjxz4rVOPl+btEqLZ+EaRN5Afh3jNsPiu2u8rd8/2ZiJsPO8bwUEcaPo43
         1SI6IqFSaAc49aq1dTUj4GY6FffE5BJ0pDRAxY7sjRp5Cg5yHaGF7hXAW7Lx70N+LHAH
         /tDmPoEnpsUKT4WaA+Dn3gFgy93nZuZAQ1N74XWydibHpGrOEMxbSBwoWx850S8QRlKo
         WGETCGa7MkPAQwNSYdIL9Dd3ZVOjbvKoLOe8d4yvxPMDD1+ZUSQs5tw4z081a1VO4zGS
         kOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699483611; x=1700088411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR1ua4QGvYfvQRDANHUyJ3hhbBvRiXgQBSeEeXP8j/c=;
        b=Ob9vKpi0JtMZoqM4okCp/gfCPH9ZFlmX27cZOmMkCWqKVAzvz0oOsNS2JyUGgfqqlZ
         QJ03BwE5+s5DYAITN/Sx3s02tzymoIsNBuGZLqZdQ9F9G6VkRDKqN03YiW99njCYy2rS
         4EEAF04mNPWiA4s1/jQJ1qs5qFyImsIjRKl9XO0mn90+Wu2+dWeo//0o2u7DkWsCumQk
         jDDRw5+aon4Y2G2mWoVLRmfP0YqViTKqWVqN1erLTEGxum67aDd2i0QewFAMWf1nyjSA
         Lh6I3+dL+kPqz8EtH9o7zpQmr8zA4zd4UA1/3jdlJaQ6+Gvwdo00+nE4MpkvlEv+z0qV
         WCdg==
X-Gm-Message-State: AOJu0YzmsF3/663tmedXBSF9pahVjtH9vWJoBSE1MiXd6MpO03Cd5K43
	qFMdI7Cl5sZ5OfCfNJNsUStWryIfRvWI5WAKopveCkgcRmc=
X-Google-Smtp-Source: AGHT+IHXpZpOquAGTDDIkjeoNHPgbttPSTHw2K9UiSd3WSW87ec0qskoUnXaQl/nq6Vj42D0Iu0oXILbGHcsqUcOLzs=
X-Received: by 2002:a17:907:948e:b0:9bf:1142:4361 with SMTP id
 dm14-20020a170907948e00b009bf11424361mr2489667ejc.10.1699483611238; Wed, 08
 Nov 2023 14:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108140043.12282-1-shung-hsi.yu@suse.com>
In-Reply-To: <20231108140043.12282-1-shung-hsi.yu@suse.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 Nov 2023 14:46:39 -0800
Message-ID: <CAEf4Bzb5WqyOx_tuna5u7n_6CDBshcCOS=S2sMs4wBDRWDHWpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: replace register_is_const() with is_reg_const()
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 6:01=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> The addition of is_reg_const() in commit 171de12646d2 ("bpf: generalize
> is_branch_taken to handle all conditional jumps in one place") has made t=
he
> register_is_const() redundent. Give the former has more feature, plus the

typo: redundant

> fact the latter is only used in one place, replace register_is_const() wi=
th
> is_reg_const(), and remove the definition of register_is_const.
>
> This requires moving the definition of is_reg_const() further up. And sin=
ce
> the comment of reg_const_value() reference is_reg_const(), move it up as
> well.
>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  kernel/bpf/verifier.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>

I didn't notice duplication, but agree that it's best to unify. Thanks

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2197385d91dc..a7651a861e42 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4685,9 +4685,17 @@ static bool register_is_null(struct bpf_reg_state =
*reg)
>         return reg->type =3D=3D SCALAR_VALUE && tnum_equals_const(reg->va=
r_off, 0);
>  }
>
> -static bool register_is_const(struct bpf_reg_state *reg)
> +/* check if register is a constant scalar value */
> +static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
>  {
> -       return reg->type =3D=3D SCALAR_VALUE && tnum_is_const(reg->var_of=
f);
> +       return reg->type =3D=3D SCALAR_VALUE &&
> +              tnum_is_const(subreg32 ? tnum_subreg(reg->var_off) : reg->=
var_off);
> +}
> +
> +/* assuming is_reg_const() is true, return constant value of a register =
*/
> +static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
> +{
> +       return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.=
value;
>  }
>
>  static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
> @@ -10030,7 +10038,7 @@ record_func_key(struct bpf_verifier_env *env, str=
uct bpf_call_arg_meta *meta,
>         val =3D reg->var_off.value;
>         max =3D map->max_entries;
>
> -       if (!(register_is_const(reg) && val < max)) {
> +       if (!(is_reg_const(reg, false) && val < max)) {
>                 bpf_map_key_store(aux, BPF_MAP_KEY_POISON);
>                 return 0;
>         }
> @@ -14167,19 +14175,6 @@ static void find_good_pkt_pointers(struct bpf_ve=
rifier_state *vstate,
>         }));
>  }
>
> -/* check if register is a constant scalar value */
> -static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
> -{
> -       return reg->type =3D=3D SCALAR_VALUE &&
> -              tnum_is_const(subreg32 ? tnum_subreg(reg->var_off) : reg->=
var_off);
> -}
> -
> -/* assuming is_reg_const() is true, return constant value of a register =
*/
> -static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
> -{
> -       return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.=
value;
> -}
> -
>  /*
>   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
>   */
>
> base-commit: 856624f12b04a3f51094fa277a31a333ee81cb3f
> --
> 2.42.0
>

