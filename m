Return-Path: <bpf+bounces-33578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF6691EBDF
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B504A1C21523
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC3F523D;
	Tue,  2 Jul 2024 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+izEmiX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721B747F
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880908; cv=none; b=DxVZ1/fFmCM6a37pu3YC+xNzRy14GlnSrQYM+U8rz6QS8DhKQvYMPzIGJ9mVtTaolSSrxeODpUhmanQDqKqO4a3Uag3tdMMOzRpjUe07BgLr5bJLg3Kdt0fghogqkeZeRy0ykYm5YkRLT2IspOnLs1fW++2KBttvcJhN703z628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880908; c=relaxed/simple;
	bh=2xRrED+5gXdOoViJNpzPSD/XjLQoH37H8Gq5MpwzzOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8MlxR/YST/QR75MVhfmPXotGg9PjOvPEr1AvX3/ji6jwLpWLwzEnAJXexUyzdwz4vZabW5uiTHEPqKSqzthpNGFmMjmZq2SjgG1wa5RFJSMBYz0SyP7fRLONst65FRJ2UP8KTuJx5T0gvE534MZfMR89nf95JmBe055aT5nE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+izEmiX; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c4498dcc27so972912eaf.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880906; x=1720485706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IVobSvjeK52mOkAY2kgvh1HJGomtVebB2unBLm9znA=;
        b=X+izEmiXa/81VlDD8W5KrofrKM/sX7CG3CnnKhmRp0nRlyxDJD7qg7TW34kfrabpMe
         ESPvi3xwaZ8uDWaRAZb9SdP7G9DMd6bS8TWV35ucdNSwyaxe3B//vaPb1BheWboT9R0R
         IpQDTUJnIbXd5L8lOrFjj/0OWLIbuUF4jS2znEkSvm0GEDvmen3gZbRJr2RibeZar/pn
         /IgQJkMDEvviA6qCPmsRx/Rj7c1trwhWKdYJ52qInE8IuOlPHSW1r36nWxbZNL/tiB7l
         bwJMi6NT4cK7aTYecZszh/B9u4Gd89vhN48KQ1Kwx9pUFMqapVthoOe98s4XYpm0+gRF
         Sqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880906; x=1720485706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IVobSvjeK52mOkAY2kgvh1HJGomtVebB2unBLm9znA=;
        b=Yiry+ceBzSIXSbZWie4/MxZqpY8PkgHR/1uxy9hKlQwYTv3gFImV1QVLJ3t1O4gr/o
         9V/+Hwu9MqIkFAzeuTPhV1gyOlU4qZqR6uPq+/gW640Q3O4RGIaxKAdj/F7bmIW9vphU
         J/JBuuyS84daIb9xZdnOZJp1No9PhyT1cmVEvsA3EyJy81hQDh+iSswSXPm3uh93jLBV
         J2DZgg4B382E10hiuLjyvYqP6JfR1hCVSzJ0hNEZF3DjKt1DuuHKv8/lFhhadYBk1xVb
         jWuiLuahIRd++Vp3fpWILw9P4q3iyd3lR4+3wqlqjetJn2iYntKT0V/FvxlrCh3AHXTf
         fy4A==
X-Gm-Message-State: AOJu0YzN2eb3T4FCXpHu1tMRYCb/lD+yTk067fhkXlPJerHE9pW+2Qv1
	zED0qC3AeTIaUXIviqg0OmE4MBK8QjvzwZAaFsfqH7zUAWTSHdnkXvRJtjDnyIWwFkOmoujjEWJ
	fBo5o07YYSnXefXc5Q1YccM/KzMI=
X-Google-Smtp-Source: AGHT+IGxMGsZc1hZ2/Tfb2DG/KmwPzONx05UIqZbOIv1+mCbVg5qneYXb2zN2DPc+zJYOJYKx33ObioDFkxwBWrNt74=
X-Received: by 2002:a05:6870:1609:b0:259:89af:7af8 with SMTP id
 586e51a60fabf-25db334c508mr6169001fac.10.1719880905584; Mon, 01 Jul 2024
 17:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-2-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:41:33 -0700
Message-ID: <CAEf4BzZE8=PsHx7SY_bYJbEvEnt_BRhmxupk6GaRO3DnjDF8Mw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 1/8] bpf: add a get_helper_proto() utility function
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Extract the part of check_helper_call() as a utility function allowing
> to query 'struct bpf_func_proto' for a specific helper function id.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d3927d819465..8dd3385cf925 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10261,6 +10261,24 @@ static void update_loop_inline_state(struct bpf_=
verifier_env *env, u32 subprogno
>                                  state->callback_subprogno =3D=3D subprog=
no);
>  }
>
> +static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
> +                           const struct bpf_func_proto **ptr)
> +{
> +       const struct bpf_func_proto *result =3D NULL;
> +
> +       if (func_id < 0 || func_id >=3D __BPF_FUNC_MAX_ID)
> +               return -ERANGE;
> +
> +       if (env->ops->get_func_proto)
> +               result =3D env->ops->get_func_proto(func_id, env->prog);
> +
> +       if (!result)
> +               return -EINVAL;
> +
> +       *ptr =3D result;
> +       return 0;
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
>                              int *insn_idx_p)
>  {
> @@ -10277,17 +10295,14 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>
>         /* find function prototype */
>         func_id =3D insn->imm;
> -       if (func_id < 0 || func_id >=3D __BPF_FUNC_MAX_ID) {
> -               verbose(env, "invalid func %s#%d\n", func_id_name(func_id=
),
> -                       func_id);
> -               return -EINVAL;
> -       }
> -
> -       if (env->ops->get_func_proto)
> -               fn =3D env->ops->get_func_proto(func_id, env->prog);
> -       if (!fn) {
> -               verbose(env, "program of this type cannot use helper %s#%=
d\n",
> -                       func_id_name(func_id), func_id);
> +       err =3D get_helper_proto(env, insn->imm, &fn);
> +       if (err) {
> +               if (err =3D=3D -ERANGE)
> +                       verbose(env, "invalid func %s#%d\n", func_id_name=
(func_id),
> +                               func_id);
> +               else
> +                       verbose(env, "program of this type cannot use hel=
per %s#%d\n",
> +                               func_id_name(func_id), func_id);
>                 return -EINVAL;
>         }

subjective, but this might be cleaner and will keep first verbose() on
a single line:

err =3D get_helper_proto(...);
if (err =3D=3D -ERANGE) {
    verbose(...);
    return -EINVAL;
} else if (err) {
    verbose(...);
    return err;
}


>
> --
> 2.45.2
>

