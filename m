Return-Path: <bpf+bounces-67623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5CB46586
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA01B22C4A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225AF2F068E;
	Fri,  5 Sep 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnmHrUDW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72625B1D2
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107767; cv=none; b=u9+IKUa1u6bxCCOW/jzYMmB5n9UCjFjxnBolxd/DDMUSqYcFbR+zj0wl2QWVVU0D+eByc0k4b2CE6C2bMxj3VYjqApDTngiMIVOolgQqy/LOV9ZenitqdPXhznVczgdvWOT3w4q1HD/6VB04P3+rrGrzK1SD5l/yLZw1L1+Qvr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107767; c=relaxed/simple;
	bh=3wEq4pi/oa0WMOvyHuzOqvu/N9xgUqai9Q+sgKSo87E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELEbuEndBiaRptZ+W9QFvAFVlQSgV1oE+FZUQeJ6Zkph+zm17f8FJIVwzu1jTviufpY7t9cmqg+uzXWqHq9qc9/HvXJFh7SXnZfts3EwSse29lJZbuMTn2ww0FUBR25QMXKB2maqV4wDK/5Ad11aq9qHiMbSdAGQWyC3a8ECz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnmHrUDW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7728815e639so1565650b3a.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107764; x=1757712564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRYAU10LVTQDC/Aitx+8lb55yUEpmXnAQoDx0k/A2ms=;
        b=nnmHrUDWIVdUlGyPp1Bh2Gw+xhWMRkaDgwBjcMyKYNvZsh4nPbMbpsYK2eeFXOirLt
         o498Rxk4H+JNq5BHr9quA2OagJjDttlJPcu9BkwOquFUIws/KFywOEf0qLRGkM3s69FB
         EvUTaLripVlJu0gJoC5x4JRmL8wQfFoIoJVU1rtpMz45/Da2y/v3Jhb86DsS5Aa1s/H3
         wp6fKWunmwNk/zU+Gtv/5wr2phUcOZmhh16etuKz7Nvl+q/7TbOEiqsn+Iiv313i0JjV
         OVPzYFUPDC0wILypsjtCUr0muHJlDmWIA+LnupZx/gM5BnsnzIVQe4+X48T91WFRv4y6
         Yl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107764; x=1757712564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRYAU10LVTQDC/Aitx+8lb55yUEpmXnAQoDx0k/A2ms=;
        b=myi0DXIb26Ma0E2sAXhO+WYWhS/FCPjK12W8K/zwQ7GLks6QdUGZuE2cjrdvhJVMtw
         CF4Bou2yNpA32SLY7PpkAdWLzod9qRGUmMhZPNBreLHWGWYNXttJOI2YIbvZAkmAVHCI
         /dF/efnoeJq6s1GtJa9GXVJf3lkOOP/gdSKeMA+/+oxU8Jf69wBPHDDWp0xGdYI4xkYk
         MKrEXoClBEXZZdhovQZD7MypmlitVqVyF32Fm/f4y7SqsaQYJ70PLgU8w03zOQ6mR0EQ
         dMYLK/7g4Je/iBPoEqVgGPILBK5JrBLK7jbUCl+724KYqSBBcQIodMCsb0AJPUcPfqkD
         aF3g==
X-Gm-Message-State: AOJu0Yy2lcIHuX7qv4x10/8s1zjIVFALHahYttjWR7922B4kVNermqi6
	8/iYPwSuYwNcIzT8e40cOlH9/kqGsdAX6oWRT+KQDQ3jindeUcKa9gCL9WhnSpuOAMURtXX7ZfD
	DlvMMwrTxGuqz7cbDyTk9PmdH0i9fakst9Q==
X-Gm-Gg: ASbGncvHiFK6By7ZGBzO8wlir/y0BhQH8KwA3q2EWlNKuCGf+KWZGR2YlxsUtwh+WOg
	zFwbh4kvev1MsFK97twtI6MXb1279BR9l3pMKfMHjF/pRPZ0despnlEcyIYg4ip3DF8Bsw8bEM8
	w3EVIYm+3rhlX4hOi4HABI7L56kUI01nWEmk/brHNXFX3CDkCOsII2ZKWo+93UCkJtewsmycuuy
	rYL3sfeqN1zWvY=
X-Google-Smtp-Source: AGHT+IEIMOtr/54YY/A2y6KGLSxlNfBcl9Mk3Vonic1zDHKb+prdUlM0PPFmmWG13ZJIHecnFABr9hhVNtjKBkC1wJU=
X-Received: by 2002:a05:6a20:3c8f:b0:24f:22af:ea26 with SMTP id
 adf61e73a8af0-25344415f0cmr364335637.45.1757107764317; Fri, 05 Sep 2025
 14:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com> <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:29:10 -0700
X-Gm-Features: Ac12FXwIhL9jZeXmgspnQF5VIm36w5Nzd2oSmgkr9nNq_Xr1tJICRbRDEgroL4U
Message-ID: <CAEf4BzaS5X2q0O0+eWYoYs0ohHcUYQD-v-gGNytUg4xWpYiHoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: extract generic helper from process_timer_func()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:45=E2=80=AFAM Mykyta Yatsenko
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
> ---
>  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>

lgtm, that process_eq_func's lack of use of process_async_func() is
suspicious, but not really something we have to solve right in this
patch set

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b9394f8fac0e..a5d19a01d488 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8520,43 +8520,52 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno, int flags)
>         return 0;
>  }
>
> -static int process_timer_func(struct bpf_verifier_env *env, int regno,
> -                             struct bpf_call_arg_meta *meta)
> +static int process_async_func(struct bpf_verifier_env *env, int regno, s=
truct bpf_map **map_ptr,
> +                             int *map_uid, u32 rec_off, enum btf_field_t=
ype field_type,
> +                             const char *struct_name)
>  {
>         struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regn=
o];
>         bool is_const =3D tnum_is_const(reg->var_off);
>         struct bpf_map *map =3D reg->map_ptr;
>         u64 val =3D reg->var_off.value;
> +       int *struct_off =3D (void *)map->record + rec_off;
>

no need for keeping this as a pointer, just fetch the value here and
keep the rest of the logic a bit cleaner?


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
> +       if (*struct_off !=3D val + reg->off) {
> +               verbose(env, "off %lld doesn't point to 'struct %s' that =
is at %d\n",
> +                       val + reg->off, struct_name, *struct_off);
>                 return -EINVAL;
>         }
> -       if (meta->map_ptr) {
> -               verifier_bug(env, "Two map pointers in a timer helper");
> +       if (*map_ptr) {
> +               verifier_bug(env, "Two map pointers in a %s helper", stru=
ct_name);
>                 return -EFAULT;
>         }
> -       meta->map_uid =3D reg->map_uid;
> -       meta->map_ptr =3D map;
> +       *map_uid =3D reg->map_uid;
> +       *map_ptr =3D map;
>         return 0;
>  }
>
> +static int process_timer_func(struct bpf_verifier_env *env, int regno,
> +                             struct bpf_call_arg_meta *meta)
> +{
> +       return process_async_func(env, regno, &meta->map_ptr, &meta->map_=
uid,
> +                                 offsetof(struct btf_record, timer_off),=
 BPF_TIMER, "bpf_timer");
> +}
> +
>  static int process_wq_func(struct bpf_verifier_env *env, int regno,
>                            struct bpf_kfunc_call_arg_meta *meta)

question more to Eduard and/or Alexei: why process_wq_func() checks
are so much more lax compared to timer's?... I'd expect them to be the
same. Is this just an omission or intentional?

>  {

> --
> 2.51.0
>

