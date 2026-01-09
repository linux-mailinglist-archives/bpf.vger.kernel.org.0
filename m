Return-Path: <bpf+bounces-78384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1769DD0C4B4
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B3073041CE1
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8E33CEAF;
	Fri,  9 Jan 2026 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOQPNNBg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18531B133
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993979; cv=none; b=MV7A2LWwCAc9LK1P+hUicLZZpuOCgR6tziaCDJ32iOv0ilE3ha251vk3N9k0Jg55c1ZeJfHRm4dGfDMwHNNbOl+8nQIxrDwrBxDO9zldxyE7K/RLeVsB4gCU/yWe7c2+CUD7e3hPathUOPxthLO5LbwkzhR+WjeHJ9Q4l0eBVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993979; c=relaxed/simple;
	bh=jZb2DV3VYg3KTpCmGTHYH7dMKFtnWqFx+0+R4bze5cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMqu/304XDDu65Pfm/6qM6jU6g2C8OVB5chJiMdOS0eqQxfYlz76BRkOsBqUV1y1MpbAcTYv9IVf8uyGX14mYQaoDsBq4C3CEWXRBz/Gu2/UnVyaAoQYwY7hE5oOCwrt5QwK/rnb787WcXtlBta58g+ABgBHyKid22LygXWe/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOQPNNBg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso4518904a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993978; x=1768598778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PLTC6+WFDGXYqyG0uPpYDMGiGDWwjj9uk5WPWr0eHs=;
        b=AOQPNNBggvdqKmzvoJXQDMY0INnPimgRpKTgkODKf/gWW2gNMww5uJEA3wCEvinLxD
         xGEH7kogeMUEOq7slxXBtndu/Wp9sl6cyg7S+sWsgbMuGkPxiie/Fhy6VYQFVaQm2w3g
         tjjuvHH9Niazhz/cbN6DGb8yl+mvDTjATiGWg7PtXHEH+1fkOc2Ctr+YAlVkErYs3clG
         GWLYa2KqdqW/xXtLDLeRL8PbAJeRZ8WPqrXa+YYrQiIxODVVoh30DGXvlnLVIuiuP9Cj
         ZcMSuwSZjZSQFMsAWWaCgKgBKMZnfwxUREZogJA+VPyglesRLA2WsUY8YrVpP/Jc+Z5i
         4L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993978; x=1768598778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PLTC6+WFDGXYqyG0uPpYDMGiGDWwjj9uk5WPWr0eHs=;
        b=ZV7/nGlov6HFazYKm0XQdGtv6q/DE56E0IVWJqwqNEXWmKM/KYh+BJOjktiMJzkjXk
         GRBUQxSWn2/Rc1R0kTIH2KC1pzzie2vju4fZCiNeDIdqTuDMmAs89q/Jr2uK4ck+fW6i
         kSUXr+byM0t3HYEd5zadfyJXRJ+KBlfc+IlfB5LeiwV78p+MNo3bNn/9yqvRTtiUCprK
         HEQLsl4eqH0XHhwnCWTgTXN3KDHM8zcgO5fCtBeHtz4qhG5RfImfopWIDC50JOOdDEPa
         usuPakyTRyZwdPpcdoV3bYeG3+OAsjjiTrhbDF248F+ULmCpkZqK4cgVLAkRRis+wdiv
         r1tg==
X-Gm-Message-State: AOJu0YyQDJnckOx6vZMa+uJrgFDuIW/7YOQGDNLjh1pyh74Z6OcIboNa
	LoOMgOpSF1WJctOz5mfRQ1Ur4jqNj4FQEu40w9YrVpFPYFsLLTHQHRnCa5Gjq66eTLZwLJ4PuIr
	5U0XLLqEn4quTmvc0XUQZrdgjRg085b8=
X-Gm-Gg: AY/fxX5qS1RKImJvF0oH7nCE5CjkbPu2ZviAeQ3vRAKZUt6FJf4+NeaRx9QTq7BQSiT
	gpIerDDz8KGaanT/qHpNh0G4Og5JEB1Zm5nQryv1I3mDFHXilYSqa/QQWsvbfRt8ke2OLh6ogpi
	o8T+PGAyVadXnne5q2Lkd3MzSrLvIxu9aNCljA4km+CZvKu7d/7Q67IkFtdizVASLVuRQ5z9CmY
	PkvTulVa1jxt58Pt8iUy+kkHypXjIKx+/3QqJnMjMMntvqt/U0ND64bf/MXUT64OHRmfcXfP/GZ
	uw/cuMbX
X-Google-Smtp-Source: AGHT+IG/bpaUEpUOnATYkCSmrMI1j90hX8BsCLlB1BPNT9E9gm8iUxiAyX6vRCzuum9iILiu5dl8XQZnUi1RwTRnJAY=
X-Received: by 2002:a17:90b:3ec8:b0:341:88c1:6a7d with SMTP id
 98e67ed59e1d1-34f68cbe7aemr10617640a91.18.1767993977671; Fri, 09 Jan 2026
 13:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108175106.2731796-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260108175106.2731796-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 13:26:03 -0800
X-Gm-Features: AQt7F2odpb5g9J1rNncBWLsB4qfEEU8AeXZzQC6grHgtRIw-VDURjB-SEooiDxg
Message-ID: <CAEf4Bzaq9ZnXUWpVvxztGZujcQnsb474snoFZ7xuDtR54u+c6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Use reg_state() for register access in verifier
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:51=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace the pattern of declaring a local regs array from cur_regs()
> and then indexing into it with the more concise reg_state() helper.
> This simplifies the code by eliminating intermediate variables and
> makes register access more consistent throughout the verifier.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/verifier.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53635ea2e41b..9721f18cc34c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5654,8 +5654,7 @@ static int check_stack_write(struct bpf_verifier_en=
v *env,
>  static int check_map_access_type(struct bpf_verifier_env *env, u32 regno=
,
>                                  int off, int size, enum bpf_access_type =
type)
>  {
> -       struct bpf_reg_state *regs =3D cur_regs(env);
> -       struct bpf_map *map =3D regs[regno].map_ptr;
> +       struct bpf_map *map =3D reg_state(env, regno)->map_ptr;

nit: this one I'd probably do in two steps

struct bpf_reg_state *reg =3D reg_state(env, regno);
struct bpf_map *map =3D =3D reg->map_ptr;

>         u32 cap =3D bpf_map_flags_to_cap(map);
>
>         if (type =3D=3D BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {

[...]

