Return-Path: <bpf+bounces-16106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFC67FCD8E
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 04:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EB528346E
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 03:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2E05690;
	Wed, 29 Nov 2023 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZitadbgJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DCB1AD
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 19:41:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bc395aa7fso627852e87.3
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 19:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701229262; x=1701834062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEtiqMYLvUJWF4VIacnwQ3vCQGH12K2lrLYfOdOEw3M=;
        b=ZitadbgJ6XK8DaWgvdIInYaGWury9VcGbV22EPaHKi6oaRQHuFceuudiERv9alj3tp
         /Vxq2TQy9kQrZaWN8PqsfI08AqkKxkh+fEf7rTyHhraBiMhD5UMc1LHy4eatNEeDO8lu
         ER1eFxQkNWbBWwpAEg1CkbSnLoHbeG0z1JdBX8RDJVcJZYvxM8BVPQs7GIQel7q1YJUV
         v+TyMRAKroqsqbOgkb5QrrfU/1RhkkE6BR+Qchem21fokeU9Ru/X5zeVurQkx3XtoUfD
         yRumCqEDkkqkCVmnAw+32IWMZ6jGEMhwZxscyuLFKvtFSurUxkG9nZw8VoG2WYg7KlpO
         UuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701229262; x=1701834062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEtiqMYLvUJWF4VIacnwQ3vCQGH12K2lrLYfOdOEw3M=;
        b=PYMCyN3VQIDqbNJwu6t9CP6smIpsUBlci4Qz0uxSGq+1CYNH2KoAqbEZ0FR4sw8Cy4
         RnwLGFbeObwUq2vAvJCAf1xOTBGeOuYfkVpc0mQAJuA6G9FSe8Fu2U3eKWdaNKBmqOWr
         Rz86nqCOr2xCXQBIxVSug0obdaQb7KZQFfAAYBZr56d1BLSXe2brl9fYzfQKtFyFu65U
         AhM3lbhccGTg1aAHhehJIZGVxUg8ZkOAD7F+VrEJWoh0mu/uN7VkTwlAfwVH2Cwh2QWP
         dBKfRcp824VB2XwbjbkGHO3cc8jiCQehts0GHnbBDEc3IY3POwaXZOTdsGMHPF0FAQyL
         HNvQ==
X-Gm-Message-State: AOJu0YzM5qAFT32pyxDw8R12ocr8LdX4W/3MmqmFw6yu5g7FAEDZCO4f
	IL2rbnqeKItdPzliUhj8PHBuzM+UbfNTufzvnZs=
X-Google-Smtp-Source: AGHT+IGCXAO6Epyjc3z6L3d1mKu1gG1HdVeuaxOaLrGbv/wx4aO3m+CO9y/+uOWSzaPBoGVaITxMWv7SESC46rUPZC0=
X-Received: by 2002:ac2:599d:0:b0:50b:ba79:9589 with SMTP id
 w29-20020ac2599d000000b0050bba799589mr2398721lfn.45.1701229261969; Tue, 28
 Nov 2023 19:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003620.1049610-1-andrii@kernel.org> <20231129003620.1049610-4-andrii@kernel.org>
In-Reply-To: <20231129003620.1049610-4-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Nov 2023 19:40:49 -0800
Message-ID: <CAEf4BzYXSV2tHas4rAAsqRJXzHkZt_78TH-0rU9+jC08T7wTOg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/10] bpf: enforce exact retval range on
 subprog/callback exit
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 4:36=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Instead of relying on potentially imprecise tnum representation of
> expected return value range for callbacks and subprogs, validate that
> umin/umax range satisfy exact expected range of return values.
>
> E.g., if callback would need to return [0, 2] range, tnum can't
> represent this precisely and instead will allow [0, 3] range. By
> checking umin/umax range, we can make sure that subprog/callback indeed
> returns only valid [0, 2] range.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h |  7 ++++++-
>  kernel/bpf/verifier.c        | 40 ++++++++++++++++++++++++++----------
>  2 files changed, 35 insertions(+), 12 deletions(-)
>

[...]

> @@ -9531,7 +9536,7 @@ static int set_rbtree_add_callback_state(struct bpf=
_verifier_env *env,
>         __mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
>         __mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
>         callee->in_callback_fn =3D true;
> -       callee->callback_ret_range =3D tnum_range(0, 1);
> +       callee->callback_ret_range =3D retval_range(0, 1);
>         return 0;
>  }
>
> @@ -9560,6 +9565,19 @@ static bool in_rbtree_lock_required_cb(struct bpf_=
verifier_env *env)
>         return is_rbtree_lock_required_kfunc(kfunc_btf_id);
>  }
>
> +static bool retval_range_within(struct bpf_retval_range range, const str=
uct bpf_reg_state *reg)
> +{
> +       return range.minval <=3D reg->umin_value && reg->umax_value <=3D =
range.maxval;

argh, I didn't update the core piece of logic to use smin/smax here.

I'll send v3 tomorrow, sorry for the spam...

> +}
> +
> +static struct tnum retval_range_as_tnum(struct bpf_retval_range range)
> +{
> +       if (range.minval =3D=3D range.maxval)
> +               return tnum_const(range.minval);
> +       else
> +               return tnum_range(range.minval, range.maxval);
> +}
> +

[...]

