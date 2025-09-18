Return-Path: <bpf+bounces-68856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF21B86CF8
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31521CC429B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3503B306B0C;
	Thu, 18 Sep 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+W3EPWD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283A30C607
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225566; cv=none; b=kDU19Y9sn3wXLNy17ohGGFnSGu7+2UPJkBQhaTXcB50tf3CSCUFxBA6EaILIq98I2S9CH2XbP+1rW1uIrZzHMLk/7I2zNvp+eKrGeDBti1iLLs6RSZOIP6Df0OaPMV+R0k8F6DGNiAOniAtUbcxwGjqxeKFK94ve/36FUG3u/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225566; c=relaxed/simple;
	bh=tF9uXT6v471WBWBNSVmnmeogbMyUO7OckI++a5XiTM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KI37nRJzuHb2uQUansMaTtBW4ruzx2LLs1+Ru8QvDeAlyhv0AuSaqwfIj6H7LtsnPeaU3PMJwT2x7vlClGidbBmBBajWewJ0FJHWLhsz+oQKRDK8s/VGvzioltaNlGiBN0/bRI8PpmcIJsMlw0IP43pBiIxdqQEsH0vL3LakZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+W3EPWD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1428205b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758225564; x=1758830364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKmPfTNthg/whMVRrrJsoR9rY6P+e0lO2n44gV7t9S8=;
        b=C+W3EPWDOSlTbkwcbzbTw+/jflMcKFzH2bwdFoFTVqhRwC471GcpggyNUjE1EwW6gu
         dPHB1qXxZf3xbDn8mPVYm6a/N8vSBNtjUlrQI+x+vAXT9bZ3fnvQ+PkkNydKW8VCiC7M
         +KTYu1n4HO/haUBUIUnFDhnqKt3D4DfhmySd+6qjGnzQC5b0lwCUuloRvxeB04kgabMP
         CPLXiotbbYBIt/GmewpovAG1uiJ6N4o1biFRqtbIAWYjDBNk16vMUxmflVDUWqD72n7z
         utyhYXw1R/5maCj1yeYUWDwaEThpSqSKnUgp7Z3/ClkHGWCXLWcI6LSj1GAvCOyP1rYA
         UAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225564; x=1758830364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKmPfTNthg/whMVRrrJsoR9rY6P+e0lO2n44gV7t9S8=;
        b=RfMI3hBWfNvz766WOxV37hjKFh+Jm0L4KE7g0SJkzBe/6sugAnmD6LWvU2+qHuyiym
         STwtjKqP+tnNbKCtVCAkcuWhdfQpWyJdd72roNI3DfHhw5Bpfs15mGYeE6XgSBjg9LNJ
         fGcGx3y+ZNliRaUIXH8IwRbF/9LDbO7yUA7KTqn6vDocykM/rQdxHWE6S5HZ7aQ9FQZH
         nC/Hay5ycTuhGAtl3AsS0v3tuiSAVUuSTEI3Ny7su7inRQPqLBvmI29hiaeqQFidssHJ
         IO8WM1+cDyyXVgIK5OgHqvULtmQiwd05ac+O/nUXmFKkdn95Wt2Vx3E1x0IY/VHqDtiO
         /1MA==
X-Gm-Message-State: AOJu0YzcFg8H7lXCdOOC+zLChun9z7MgTGuH/IyOo8JLH93tMuJFvN1B
	mEAtgKite30NflvrfdR1b0UrAeLxZd5RtW69sYxrwsVwnMbeSi1zcV5y05N3agTpfXA/dTiPi6g
	2O+B3ggbTyFx+E1Q2XEmvc8z6qbevOOQ=
X-Gm-Gg: ASbGncvwouNb1iF/ryv9X5oafjQRtUhse/ffZJ4WyUafmIy5I7waYpWjXQCj06JOVUd
	3nXnmN4Te8/1YQnyBecCN9VGncpjYFhvLZ/4ylgSGW/3Eg0FQmA4sjCAAAqAxl/Br4cdMd3aCc0
	Da3J3Fbkm4uNPalTKFcGTIhwQqLYYUuHLRzNLgQc6cT5X/9BR7dnBD8w5cAUzeApnOdEzl+XiaW
	WvcxtiS74Fj10VRsU6K3vkbucBw4hS+p2WUPe1KrA==
X-Google-Smtp-Source: AGHT+IGja0NJL0CVNz8a6AVrCj5cJ3VRmS33MuA2M8frx7DZxv1nCq+EaSWBp0kEPKoX67Si+biQdCRd/ZRWUxHq5G4=
X-Received: by 2002:a05:6a20:1591:b0:259:f746:336e with SMTP id
 adf61e73a8af0-2925ca24e8emr1088131637.23.1758225564440; Thu, 18 Sep 2025
 12:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com> <20250918132615.193388-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250918132615.193388-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Sep 2025 12:59:09 -0700
X-Gm-Features: AS18NWAI1MwTtMYhz3zw5PySTdetM86Th2d4KRGzZLYfbdcuw41QhHOuy1CkFdE
Message-ID: <CAEf4Bzbij5du4WbN2HhLDwNEyLGLEmbVSb9y88Lh8NUDE=_Vug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/8] bpf: extract generic helper from process_timer_func()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:26=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Refactor the verifier by pulling the common logic from
> process_timer_func() into a dedicated helper. This allows reusing
> process_async_func() helper for verifying bpf_task_work struct in the
> next patch.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> ---
>  kernel/bpf/verifier.c | 46 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b9394f8fac0e..c5a341ecbbaf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8520,34 +8520,58 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno, int flags)
>         return 0;
>  }
>
> -static int process_timer_func(struct bpf_verifier_env *env, int regno,
> -                             struct bpf_call_arg_meta *meta)
> +/* Check if @regno is a pointer to a specific field in a map value */
> +static int check_map_field_pointer(struct bpf_verifier_env *env, u32 reg=
no,
> +                                  enum btf_field_type field_type)
>  {
>         struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regn=
o];
>         bool is_const =3D tnum_is_const(reg->var_off);
>         struct bpf_map *map =3D reg->map_ptr;
>         u64 val =3D reg->var_off.value;
> +       const char *struct_name =3D btf_field_type_name(field_type);
> +       int field_off =3D -1;
>
>         if (!is_const) {
>                 verbose(env,
> -                       "R%d doesn't have constant offset. bpf_timer has =
to be at the constant offset\n",
> -                       regno);
> +                       "R%d doesn't have constant offset. %s has to be a=
t the constant offset\n",
> +                       regno, struct_name);
>                 return -EINVAL;
>         }
>         if (!map->btf) {
> -               verbose(env, "map '%s' has to have BTF in order to use bp=
f_timer\n",
> -                       map->name);
> +               verbose(env, "map '%s' has to have BTF in order to use %s=
\n", map->name,
> +                       struct_name);
>                 return -EINVAL;
>         }
> -       if (!btf_record_has_field(map->record, BPF_TIMER)) {
> -               verbose(env, "map '%s' has no valid bpf_timer\n", map->na=
me);
> +       if (!btf_record_has_field(map->record, field_type)) {
> +               verbose(env, "map '%s' has no valid %s\n", map->name, str=
uct_name);
>                 return -EINVAL;
>         }
> -       if (map->record->timer_off !=3D val + reg->off) {
> -               verbose(env, "off %lld doesn't point to 'struct bpf_timer=
' that is at %d\n",
> -                       val + reg->off, map->record->timer_off);
> +       switch (field_type) {
> +       case BPF_TIMER:
> +               field_off =3D map->record->timer_off;
> +               break;
> +       default:

verbose(env, "WE FORGOT TO UPDATE THIS SWITCH?");
return -EINVAL;

> +               break;
> +       }
> +       if (field_off !=3D val + reg->off) {

can `val + reg->off` end up being equal to -1? Even if not, why do we
need to worry about this?

> +               verbose(env, "off %lld doesn't point to 'struct %s' that =
is at %d\n",
> +                       val + reg->off, struct_name, field_off);
>                 return -EINVAL;
>         }
> +       return 0;
> +}
> +
> +static int process_timer_func(struct bpf_verifier_env *env, int regno,
> +                             struct bpf_call_arg_meta *meta)
> +{
> +       struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regn=
o];
> +       struct bpf_map *map =3D reg->map_ptr;
> +       int err;
> +
> +       err =3D check_map_field_pointer(env, regno, BPF_TIMER);
> +       if (err)
> +               return err;
> +
>         if (meta->map_ptr) {
>                 verifier_bug(env, "Two map pointers in a timer helper");
>                 return -EFAULT;
> --
> 2.51.0
>

