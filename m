Return-Path: <bpf+bounces-16904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF4580772D
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11891C20BCE
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E376E2B0;
	Wed,  6 Dec 2023 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5g65BRP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF42D4B
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 09:59:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1e2f34467aso41889866b.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 09:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701885585; x=1702490385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bSvPMHgdnmmKONIzwIh2uag+/ftJ+bjaf2gI2t0DrQ=;
        b=R5g65BRP21Tnu/RNHBSwX2JNU89SJMPT2U7dk0P/lceQkrVQYh6fkVS5x7sMH7zl1w
         B6mmwxAs/+MH2Z3bfdaacz769zNHtNsz3lbhtVikXmOPJ4aHRzbXQWyANYwJGbBBs67V
         /hvM7useu2KwS+CHo5qpjFm3yBrp729gzSCEjgUrD1JEMfERoODdlZAgVjbMy7apHcwQ
         r6NafQ9UEYkRb9y8s8uJxZ2anj3D4uHT1NRu6bn8FI2hMwcvZeoqE1EkBW7avD22Lzcn
         nbcDeARGrPm9y66FUQMcwOuhIO3NmNu3Y6/nGwfUtGQzQoFcpviDZ/UNkpwvFZvYdesD
         ZJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885585; x=1702490385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bSvPMHgdnmmKONIzwIh2uag+/ftJ+bjaf2gI2t0DrQ=;
        b=teWSdrYUP6eB66nprhNv4qceFL6smpqZKyNyAYr+U8lOtoWdoS7UgQ81WXe5mOYIwh
         0al+2ACat/uuyDwc7VC5jxvkTiuYCOiHL4U2PYYLiqstTtRmDd2OJPuc9GPaIVzX+X1D
         X52k/fDW1f4NNEaqj9AC1Z1EzSXURdxJPrvgFOP+cmOOhXtdZxCtEW53rPaoiPF1j3SG
         K/8UvRSmq3JUYESWxDJR2Y40/Y3QkW4JCfTPpSJgHQjWqJG9R0wmikEbb40ig4iH8dj+
         Vrp69Jv/4zYd1Q5zkZh/0rHaZWWDKiGIYhWT5FpHSk/xVHaXis5OpWx/Dzl9BUiBXjoO
         CxCA==
X-Gm-Message-State: AOJu0YwSvq4b3QZE/n4EgM8I/BlHikbKn72/9f2d5iZNTgq8c0rA6SGs
	eCR31L58xb1oh+jsEg5Ym3/NDj40pUgjyVeZWgM=
X-Google-Smtp-Source: AGHT+IE0tuJl11VWKBjomx3+ztKaxlxGwvNIsPlaw3hHI1SrxFMQ39JAL329J9PG6jGrrsmw/oei4/smkUO7bZ2j2Z8=
X-Received: by 2002:a17:906:7499:b0:9ff:1e84:76fc with SMTP id
 e25-20020a170906749900b009ff1e8476fcmr886591ejl.5.1701885585014; Wed, 06 Dec
 2023 09:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204233931.49758-1-andrii@kernel.org> <20231204233931.49758-4-andrii@kernel.org>
In-Reply-To: <20231204233931.49758-4-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 09:59:32 -0800
Message-ID: <CAEf4Bza652KDADkKwYgFXMjJdEg6NfOew-5nfgOb+7i9XaNz4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: tidy up exception callback management
 a bit
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:40=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Use the fact that we are passing subprog index around and have
> a corresponding struct bpf_subprog_info in bpf_verifier_env for each
> subprogram. We don't need to separately pass around a flag whether
> subprog is exception callback or not, each relevant verifier function
> can determine this using provided subprog index if we maintain
> bpf_subprog_info properly.
>
> Also move out exception callback-specific logic from
> btf_prepare_func_args(), keeping it generic. We can enforce all these
> restriction right before exception callback verification pass. We add
> out parameter, arg_cnt, for now, but this will be unnecessary with
> subsequent refactoring and will be removed.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h   |  2 +-
>  kernel/bpf/btf.c      | 11 ++--------
>  kernel/bpf/verifier.c | 51 ++++++++++++++++++++++++++++++++-----------
>  3 files changed, 41 insertions(+), 23 deletions(-)
>

[...]

> -static int do_check_common(struct bpf_verifier_env *env, int subprog, bo=
ol is_ex_cb)
> +static int do_check_common(struct bpf_verifier_env *env, int subprog)
>  {
>         bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
>         struct bpf_verifier_state *state;
> @@ -19842,9 +19860,22 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog, bool is_ex
>
>         regs =3D state->frame[state->curframe]->regs;
>         if (subprog || env->prog->type =3D=3D BPF_PROG_TYPE_EXT) {
> -               ret =3D btf_prepare_func_args(env, subprog, regs, is_ex_c=
b);
> +               u32 nargs;
> +
> +               ret =3D btf_prepare_func_args(env, subprog, regs, &nargs)=
;
>                 if (ret)
>                         goto out;
> +               if (subprog_is_exc_cb(env, subprog)) {
> +                       state->frame[0]->in_exception_callback_fn =3D tru=
e;
> +                       /* We have already ensured that the callback retu=
rns an integer, just
> +                        * like all global subprogs. We need to determine=
 it only has a single
> +                        * scalar argument.
> +                        */
> +                       if (nargs !=3D 1 || regs[BPF_REG_1].type !=3D SCA=
LAR_VALUE) {
> +                               verbose(env, "exception cb only supports =
single integer argument\n");
> +                               return -EINVAL;

this should set ret and do goto out, fixed locally

> +                       }
> +               }
>                 for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
>                         if (regs[i].type =3D=3D PTR_TO_CTX)
>                                 mark_reg_known_zero(env, regs, i);

[...]

