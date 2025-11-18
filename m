Return-Path: <bpf+bounces-74846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F353EC670E6
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 02BB029B05
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9836328619;
	Tue, 18 Nov 2025 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wa2Ajy1W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09881328241
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434096; cv=none; b=bSjC8MM57PTvOT9aQhE4lHYqywuENjJIYux6o/KhQrmFEfIB1qhWAvuCltwY8boG9e2/nVh01u2ScFYkOuxqYVphDcfHJ6Zj/Nrp47GxCT/azeA1BE8IOWFVhWtSpCkZSVR8ym2LuwuF3Wz8TM/VKiSeCdPCc4Y0SHoYDUiNOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434096; c=relaxed/simple;
	bh=MEg6VBEVV2m8SvfiO9CWhvWYZd5LbSfbjXaNkQlbk9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4ZkHocfBJG7IQp6iPM/7n0dSUDiJazj/NC1+xqqNlxb6iFgWOtSA+MXe9COJ6bRtUX3wSTX5Q5bcFZh1Dp70zAwihON4eMANhXIdurd/NQ8mlrauWpBAxjTqMWy3BVt+hUPscKsAUyvjgvHtnIM2X0HjAo5W6NUEfa3B3cYFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wa2Ajy1W; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-786a85a68c6so52572037b3.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763434092; x=1764038892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c06NGCM9VdYp1GTTRIFTmtkJd9Z8kFTzkNdLeCh5FMA=;
        b=wa2Ajy1W9yUIBYkcZMx8mmUUEJuY7fLgrOgNRMt+c3a8D+Qo8/rP7tRL/3TvSq7MK9
         sbxpqNnxgQPvYQOorpMu9/K9AKML1jKyFahpZgYEN5cYOP/ZtkuulmuxhGfLbpdLCRAU
         JivII6Mx1QLEveykBE3TTcXKuvppBIEpruJFfd/MSt/GAmj0zZhNZvUJE4OOigfO/KKP
         yuwzTl0a3M8uW2ibDzC2552sGhWJD3g3Uxz2dYF/wE6CLFaUGjiDZ3I3CQ/vXhICjSHk
         LHbw1GOFV9lfzHnPrd07ecgO+fQ4Tw3qmuHC2ACqdsjo7pVMfQZRMennu4dWg+ueAuqj
         2/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434092; x=1764038892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c06NGCM9VdYp1GTTRIFTmtkJd9Z8kFTzkNdLeCh5FMA=;
        b=L5tKOPoG/6pzSAAZD3dgQvv654esDrjh1drF9KpahYWXSgdTp7xgXuAH8UYQYb5GMt
         1C67uAdbnrq42uLYorjJTXzf5IzpaHK/IBaeVoSVRHcUTWkGerBkYpLwN7Y0N8E9sWMn
         6VtKLWDxqNmQ5GhrqJJkH9sr5wn7PZSbUDpj471S3Iq0TgeMHx0WT9njg9eRVC69kk4b
         uzS+xwALVC39MGH0g7Isac0ZCpwXJLW+1gtuXpIpkbHDlfkoOqLVt3dTXaHD6gzOjGIh
         tNmwvCTDUCpN9thBCbiJ+UMpKMT1V9UH2LC5qksyVu2WjToG+YbO013MsnH30vmADmvJ
         HMMw==
X-Gm-Message-State: AOJu0YzaEoi5S7bDK9RP+M3+poICPHOym5f1i8bDyVFiHNjaqJXevppQ
	tW3G8IZ7cAgctkFRdoOKW6px0iRdqCetaLLp5W3o6Q+/zMV/pUFSS+99q6gRv55+zuhLttsldkh
	ErNYPcESHc257L3E7hfGVukr3l/LkvOGli7mQ2843EA==
X-Gm-Gg: ASbGncvEIEShnur2skkeK72ddHI7PhAHnWSt0G2rGVsCrgb/GK7jhwJjcnAaLyFPrcn
	JD9mrk5CNx6yo0i1bZqAESBWy88zO7qQ2Wk0Nf8l+Cn44ry2BLLj0teeG5hzk+P1b6CH2ITIItx
	lLP5veNXvxZbycCXna/EHYkEgxEDlsQZqQ//pOhDFSxB0iHL2fZfWpkH86FRjioMa5byG/yD9tq
	oUFeRq5U9dSxfwPz25iJn+BZcqv5eEMNQjD9V/YRSrKFzzXbSTvJASK2Sfr4FI=
X-Google-Smtp-Source: AGHT+IG0loNlbECLjmeTx+poBV/J1pUD+sDNUAhBS1hC33E+Qs+Ku/+A/b4ne0VDIwf1oUZtkS+1gPfv7AgEvTbm44E=
X-Received: by 2002:a05:690c:4489:b0:786:59d3:49b7 with SMTP id
 00721157ae682-78929e43b90mr135878527b3.13.1763434091889; Mon, 17 Nov 2025
 18:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117235636.140259-3-emil@etsalapatis.com> <0d256ee4485ea2c5142e8692b7dbbd559d05c41afb1f4ed81b78fd59eed9eb15@mail.kernel.org>
In-Reply-To: <0d256ee4485ea2c5142e8692b7dbbd559d05c41afb1f4ed81b78fd59eed9eb15@mail.kernel.org>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 17 Nov 2025 21:48:01 -0500
X-Gm-Features: AWmQ_bk-jximTozMYqE9OyzGFbp0wWsjVNYTI9cekv9TpjgOKO5HKwxB_-i_zLQ
Message-ID: <CABFh=a6njNeSbOL3BHhMaPRcZ+PE0mQSQicH0mSX79GDOZG-+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] libbpf: add stub for offset-related skeleton padding
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 7:18=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 993c7d948..6ed125b1b 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
>
> [ ... ]
>
> > @@ -269,7 +269,8 @@ static int codegen_datasec_def(struct bpf_object *o=
bj,
> >  static bool is_mmapable_map(const struct bpf_map *map, char *buf, size=
_t sz)
> >  {
> >       size_t tmp_sz;
> >
> >       if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_ARENA && bpf_map__init=
ial_value(map, &tmp_sz)) {
> >               snprintf(buf, sz, "arena");
> >               return true;
> >       }
> >
> >       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF=
_F_MMAPABLE))
> >               return false;
> >
> >       if (!get_map_ident(map, buf, sz))
> >               return false;
> >
> >       return true;
> >  }
>
> [ ... ]
>
> > @@ -287,6 +291,7 @@ static int codegen_datasecs(struct bpf_object *obj,=
 const char *obj_name)
> >       struct bpf_map *map;
> >       const struct btf_type *sec;
> >       char map_ident[256];
> > +     int var_off;
> >       int err =3D 0;
> >
> >       d =3D btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
>
> [ ... ]
>
> > @@ -303,7 +316,13 @@ static int codegen_datasecs(struct bpf_object *obj=
, const char *obj_name)
> >                       printf("        struct %s__%s {\n", obj_name, map=
_ident);
> >                       printf("        } *%s;\n", map_ident);
> >               } else {
> > -                     err =3D codegen_datasec_def(obj, btf, d, sec, obj=
_name);
> > +                     var_off =3D bpf_map__data_offset(map);
> > +                     if (var_off < 0)  {
> > +                             p_err("bpf_map__data_offset called on unm=
apped map\n");
> > +                             err =3D var_off;
> > +                             goto out;
> > +                     }
> > +                     err =3D codegen_datasec_def(obj, btf, d, sec, obj=
_name, var_off);
> >                       if (err)
> >                               goto out;
> >               }
>
> Can bpf_map__data_offset() be called here on an arena map that doesn't
> have its mmaped field set yet?
>
> During skeleton generation in do_skeleton(), the code calls
> bpf_object__open_mem() but never calls bpf_object__load(). Looking at
> is_mmapable_map() above, arena maps return true and will reach this code
> path. However, arena maps only get their mmaped field set during
> bpf_object__load() in libbpf.c around line 5615, not during
> bpf_object__open().
>
> This means bpf_map__data_offset() will be called on arena maps with
> map->mmaped =3D=3D NULL, causing it to return -EINVAL, which would fail
> skeleton generation for any program with arena maps.
>

This analysis seems incorrect. bpf_object__open_mem -> bpf_object_open ->
bpf_object__init_maps -> bpf_object__init_user_btf_maps -> init_arena_map_d=
ata
happens at opening time, and this call chain properly populates the ->mmape=
d
field of the arena map.

> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 706e7481b..32dac36ba 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10552,6 +10552,16 @@ const char *bpf_map__name(const struct bpf_map=
 *map)
> >       return map->name;
> >  }
> >
> > +int bpf_map__data_offset(const struct bpf_map *map)
> > +{
> > +     if (!map->mmaped)
> > +             return -EINVAL;
> > +
> > +     /* No offsetting for now. */
> > +     return 0;
> > +}
>          ^^^^
>
> The check for map->mmaped here causes the problem described above. Since
> this function is called during skeleton generation (before load), the
> mmaped field won't be set for arena maps yet. Should this check be
> removed, or should the skeleton generation code path be changed?
>

See above.

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/194488=
68610

