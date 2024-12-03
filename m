Return-Path: <bpf+bounces-45970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC99E0F79
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A7F162356
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF88646;
	Tue,  3 Dec 2024 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUb/8u7q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F32645
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184235; cv=none; b=aYxewFiW9F4DQJruGOGwMVcLLpoDPZf4z0NUejT1L8Hf0yA4lRLHyGulVCN/cy2OJ6elfq/fxO7/irkZjFSmfaR0eWfsB73JjCPGKCUuujkDALRI+Qa4JrOHpoRG9e/UG1eWAfrKil5OYxieZZPTU10x29mVHFl9WFJ/WxR01o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184235; c=relaxed/simple;
	bh=uJX+Nz1S5dEEYMjv605iz1ONvLYOlfD8SBQEIw2y0Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJUo9ntPPRLermHUxncSRspXjpz/P+uQOY+625r5kf4YqARFFocRGrxzol2fDI89gz2xL99lb/9qCJMMrfv+rAmXonHw76PVXUEAki+JpkUEIW3LQpv4BsK5t5VYfn+Lrj4EMAPub4RYMT+D1AcsoHak29x+jHsbGZloo3aNHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUb/8u7q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so44076685e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184232; x=1733789032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zRZ+XHwUxdlAHQmeKanlVpxjt3hM23FGsJYqBn/sic=;
        b=FUb/8u7qal6Y1B/KiqG1dztynq2y/Y8S3JtYZp2m7zhX/jbIVtAfuy8y6wd4CnP5DV
         KpsCo9V799qXFAaxFTX5ORYjSCy7UXt+e/0nImdac0mQ7Sb4Y64s9H1n5dFRnJP57hDe
         qp/xbA2sQ+3d4mXwt1gfQlpuLBZpsvGYtb4ycraP6e7Am+77zjXsZVl/WZFZovrCubqa
         1cAfK2S8zCjbnoHfFtkpI+SA0XC7PqO2CZV3lgdWkk9ZohBK31BGK6fiLTAv2yHBPlU/
         FxeUK7TP5ZoosuPHz1EfutZq6kPk0uf93GySaj/upb6fy7OAsEGZwKYpdb11yENj9zqI
         RHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184232; x=1733789032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zRZ+XHwUxdlAHQmeKanlVpxjt3hM23FGsJYqBn/sic=;
        b=As72KCpZ8JKm6TbEHg6Rq4r+OBRxnPqnHgpih5et9wUVMz9PB0J9r9UogXDS8ogeQ/
         bof/bNj1oAVXoVy+Etq4yFJmrBq0neyXVcjhmcGV2ehGibIo+AB5stY9b9j+wP0/gSVD
         ZERbd39vVfuSx3msBiohZ6PWQTjryd67MzeOohH10C3HNuHwQKgFzS79eUDNzfOM1/Bj
         Jmp4mgkikjseRu/yZ1evpu/BxMrPux3MA/FCx9AJoYiiQKDSHVEQgNE4VhymiDHhNJJt
         vXIvDISnHtkxM93yLEKSPtb5uVRTvXz6wy6mXVN/yzIZJROn5U/0oK2o/o8hLlcBdWFY
         RYPw==
X-Gm-Message-State: AOJu0Yx8U6MG1zASXXacK2/fGfqbyiiAj6tYRG3vIeWrh0ewd/NzwoaV
	7jT89Tm5noe1Q0Kdfvfb78Q4xSl1UYnR49mwHpnFvG+Oe+F+a3a5iIfFGIXPTMkRyf0w70XVFZ4
	p43IgtrwfNrEDYZC9AyQBvakVPfk=
X-Gm-Gg: ASbGnctX6oVOCkSZRRZTDK1vuANdET8uwTSTvjby4ulM9VW+z0jqHsM1cs9l8KfuLFk
	ST0qWFAqDBLT0krTGkQLnGkB5PN8PWD8Gff0Nc7OeKtTQjiI=
X-Google-Smtp-Source: AGHT+IE2IacqASqFB0mlOE4OpC6e1rAPr+SXdldiWKdRcT+mXBvjqJNOebBslj6b/UcGh/ITj62E4MCESpTb0RZ9CK8=
X-Received: by 2002:a05:600c:19cc:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-434d09b4fdfmr3671365e9.10.1733184232246; Mon, 02 Dec 2024
 16:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129001632.3828611-1-memxor@gmail.com> <20241129001632.3828611-3-memxor@gmail.com>
In-Reply-To: <20241129001632.3828611-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Dec 2024 16:03:40 -0800
Message-ID: <CAADnVQLXvLj7US=cEtdFF5N0vESEKUTJKC72zDAev9_GXnqmcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Refactor {acquire,release}_reference_state
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> +static struct bpf_reference_state *acquire_reference_state(struct bpf_ve=
rifier_env *env, int insn_idx, bool gen_id)
>  {
>         struct bpf_verifier_state *state =3D env->cur_state;
>         int new_ofs =3D state->acquired_refs;
> -       int id, err;
> +       int err;
>
>         err =3D resize_reference_state(state, state->acquired_refs + 1);
>         if (err)
> -               return err;
> -       id =3D ++env->id_gen;
> -       state->refs[new_ofs].type =3D REF_TYPE_PTR;
> -       state->refs[new_ofs].id =3D id;
> +               return NULL;
> +       if (gen_id)
> +               state->refs[new_ofs].id =3D ++env->id_gen;

...

> +static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
> +{
> +       struct bpf_reference_state *s;
> +
> +       s =3D acquire_reference_state(env, insn_idx, true);
> +       if (!s)
> +               return -ENOMEM;
> +       s->type =3D REF_TYPE_PTR;
> +       return s->id;

Small nit.
I think 'bool gen_id' is not very readable, since
the callsite is not obvious.
Let's drop the flag and instead do:
  s->id =3D ++env->id_gen;
  return s->id;

> +       s =3D acquire_reference_state(env, insn_idx, false);
> +       s->type =3D type;
> +       s->id =3D id;
> +       s->ptr =3D ptr;

this bit will be easier to read too.

