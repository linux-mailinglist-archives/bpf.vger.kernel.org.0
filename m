Return-Path: <bpf+bounces-45973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE1C9E0F80
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7910B222F5
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34E64D;
	Tue,  3 Dec 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV0odROx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BB173
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184604; cv=none; b=cH94sLDdz9jQqLsR4AJ85Q/3UX4L5KBpTLkAuyldsU+X9CiItv8JOaLWVWeRCUhlvZDP/zxMW7zS2LM23QSKeEmw4YuXNUtjH08aIk4JD5mlb0xP5j7oTFuFjDXoGxIgt83NtaqmRR2heZeS7QoWIzCkdwTF9gxTg2ZM8DXAWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184604; c=relaxed/simple;
	bh=lyEJ2oGhGf1HkXeRH5gMQBx6rn7YarN4bJYJDMOjHTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdQleLbUWH0CowR0YAIyHjCyCmfAO3GWk19ct4rVUO4o7xA9RRCZHDfzwLl4fSpy3aOwsPOJX84YYy62GkB3jOQ/kacLxgB67zC8jpHUYheebbR0pN6lAX+mdDUut457WVHlAImskXnF5YjPAlK6JwyF3WjeNu9ZhuNeeXHPSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV0odROx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee6dd1dd5eso2561229a91.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184602; x=1733789402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHlZ/KfgQWVI3kp+yRWNE9ShrP5t/rJgSBcxAWqOIMU=;
        b=cV0odROxXat0XFbdBkq+w/h5ZrqRAt2c7owMUT+Fwvt/1HoIHQOkofIpOJzop/u67m
         CpcgLbizpc1zdLofGRIVvZDAwcM8uAXAPFd6oJwqPkiCu1B/tyVkKMI9lut2xXaWyTqy
         6kadLmTgpP4QdorRfX0yU50TsFV5BfGJ5FDHUTQVayNkSXKVDGzWSM3xE7ZHoCBN8pPd
         GElWY8vaayjxgx7Uo/iC++bJvssnLxnSbXLcERQ+pc4oqsLo/JbPkHiBULYdutDjhN33
         1lPMYDbaeP6RIOExGdX+nkMDQlYOXhSnwKznDc5PVt2vQ0XYiZzzVNeubKsEcy0GpcIp
         CIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184602; x=1733789402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHlZ/KfgQWVI3kp+yRWNE9ShrP5t/rJgSBcxAWqOIMU=;
        b=t1LmTvYtcmYbwr5dO68E+AoKYnyV+pV6uYcX66wjKGuXY8YDJhrS9ips/FC/U28pVb
         gbxpOOlR3W+GG2gAMisHmamLmX5t9kpPUvaF5IckuG3Y4uTtaGAHX2x4QDmpRAoMYXdQ
         S/tXkfw8plCfP7cWZiHWO26ZVqSybySWSkMm6p2j87LMipIkrqpViMcwLe2tSQbZLCze
         ejkK2d3F2l+A9zl49QFO9oVzTXqW8ntu58dNpZQ3HK3z78qnnBXt7Z7Jxj/LNyNmy9tw
         jbWZVT7mS2Gfy/VwPBz8Y2bevvS2Ts/WQYiuOMLnG38lguIW4EZkzctcVoYKkz9mOhEM
         qagA==
X-Gm-Message-State: AOJu0YyVZML8KuzEfQG8Jtnm3EzHvp/jXW0/u3nv0i1RJoY4nKm05f+X
	Uzi9qaoXSMIKoDbSGggQDIZaMGQMLKQX7R47C7ibNjIVCOssAPzgc+MDpaOvxdX7vOyt4H11IHS
	uebmtxUpj0ZG/Rx3Ew+JX4EDkUx4=
X-Gm-Gg: ASbGncskq8axIMqpg5kz5LVp3cOppkxXx9li5EAXWAW3DQaysBZ9BN03btSl8L95OQy
	ikMtbeZoulxlJ4eI9D24VQbe6Dmi8FlpL7Ura2DkRddGUPfI=
X-Google-Smtp-Source: AGHT+IFpygw97bBlREqjRp03UgSujPeDGaGBlH9nweUg/8xtkBt8+8bjtVH/dtwEIdDC9GZ4HHpctZijXS2PLCMpLQU=
X-Received: by 2002:a17:90b:4c07:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-2ef0120fa48mr782402a91.19.1733184602205; Mon, 02 Dec 2024
 16:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202083814.1888784-1-memxor@gmail.com> <20241202083814.1888784-2-memxor@gmail.com>
In-Reply-To: <20241202083814.1888784-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Dec 2024 16:09:47 -0800
Message-ID: <CAEf4BzbQamn5x4aU+ytG0bT04_tKM_kTf8rXv86_TdJobCUaDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Don't mark STACK_INVALID as
 STACK_MISC in mark_stack_slot_misc
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Tao Lyu <tao.lyu@epfl.ch>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mathias Payer <mathias.payer@nebelwelt.net>, 
	Meng Xu <meng.xu.cs@uwaterloo.ca>, Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:38=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Inside mark_stack_slot_misc, we should not upgrade STACK_INVALID to
> STACK_MISC when allow_ptr_leaks is false, since invalid contents
> shouldn't be read unless the program has the relevant capabilities.
> The relaxation only makes sense when env->allow_ptr_leaks is true.
>
> However, such conversion in privileged mode becomes unnecessary, as
> invalid slots can be read without being upgraded to STACK_MISC.
>
> Currently, the condition is inverted (i.e. checking for true instead of
> false), simply remove it to restore correct behavior.
>
> Fixes: eaf18febd6eb ("bpf: preserve STACK_ZERO slots on partial reg spill=
s")
> Reported-by: Tao Lyu <tao.lyu@epfl.ch>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c4ebb326785..c6a5c431495c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1202,14 +1202,17 @@ static bool is_spilled_scalar_reg64(const struct =
bpf_stack_state *stack)
>  /* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, in=
 which
>   * case they are equivalent, or it's STACK_ZERO, in which case we preser=
ve
>   * more precise STACK_ZERO.
> - * Note, in uprivileged mode leaving STACK_INVALID is wrong, so we take
> - * env->allow_ptr_leaks into account and force STACK_MISC, if necessary.
> + * Regardless of allow_ptr_leaks setting (i.e., privileged or unprivileg=
ed
> + * mode), we won't promote STACK_INVALID to STACK_MISC. In privileged ca=
se it is
> + * unnecessary as both are considered equivalent when loading data and p=
runing,
> + * in case of unprivileged mode it will be incorrect to allow reads of i=
nvalid
> + * slots.
>   */
>  static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype=
)
>  {
>         if (*stype =3D=3D STACK_ZERO)
>                 return;
> -       if (env->allow_ptr_leaks && *stype =3D=3D STACK_INVALID)
> +       if (*stype =3D=3D STACK_INVALID)

It's a bit worrying that my original comment explicitly states that in
unpriv mode we *have* to set STACK_MISC, but I can't recall why.
Looking at this now, it looks good, so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>                 return;
>         *stype =3D STACK_MISC;
>  }
> --
> 2.43.5
>

