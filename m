Return-Path: <bpf+bounces-22369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE785CE70
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 03:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF56B21872
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E39C2B9DE;
	Wed, 21 Feb 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PWUk++kR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290D28DB5
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484323; cv=none; b=HSSrh0IYQkYMm+MzS6ESk+5Hfc/GRa4IHCyDyAenXttVb0z8VSHFFNSC4SkrTb04QuS5t5DKVoAIRTsJq2oEDmNmKm1/sG1qlchc0F2/7fF+5VWnkKaYalLXQc/8wxM2op4ZVqo2crGhIqNuZRLgrAEAqKtYX9Onjp/p0sR0ppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484323; c=relaxed/simple;
	bh=WkwMIU0zwW1Ee86vo8DeMZxLRmnrHnV97QWi27NY+4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM2rTf1XXirW7RnpguNz167FmIcnK6ue2trREU8XTuZFdjDGxwmaiSSpHxjiSupnxjIMqMHDOSRwMXkklx0afHfMxRsesk1I7nm2TCQHs8Ek0iTdEovP5e2tyq7ipGJBZHlXTIiLpkvvMDFqUq3Va2TJ4UX4Rs5oykEVjk8P65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PWUk++kR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2997c5fe6abso94373a91.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 18:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708484322; x=1709089122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjgXTVC6oX0aWWpC+csfhG9TVCjrVW0xpmQ2dYZci0Y=;
        b=PWUk++kREBMJXvFnKSzUd4I0p3WpzZ4rY84YikZ0wmnyJsVMelH8OEsdLSSfsHV7pu
         f/6tYq4kYfo7ZoWnZixaci7D3Rk+CZrgwsEXmSKVtnwNIB6dj1cOnHNlo6oGgk7nKAws
         /dPFnxj5BwtzZWJ8r4RHcJZZxxZL3Z6sla4Zake9ZlzTtxG//89ng1iTE5QKsH5eO9Zm
         vb9pCg43Asdlc4OeYXRNyuChUEYobHvGQUB6HmGlX69VPqLJ8EsKv3UE73iV9Mr4gYkp
         khN21ak/b5T+oBMLH+u5p+TWkt+ZonuijIiZNDycGiOI8tBKqblH1elLO6KZ23NMOCgs
         x7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484322; x=1709089122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjgXTVC6oX0aWWpC+csfhG9TVCjrVW0xpmQ2dYZci0Y=;
        b=pi49RsvPk1qQJ8oeTbLG+9wTO4nLT0hoNzAfwTsEoN5JeseRaFZvnVFMIfGo5nP2GT
         S8vFA40mddkr0R7YFO8X9Feo7wTBskhDXN7F1vFSfEBt6MyfXixCJuxYC5/hrWx9FaZP
         bP4/9JKuGU2f6Ms52VWPiopg2USlNK6vyIRsq6htYw0GHTrJ4IhcAjpg1rt8c5xEXOK/
         kLKjM2d38GqWb5PWRx6u5G4eNOlF0OvlQofgXDyMzeuHWbKwU9iJhZoj5fue7dLrA/b/
         2/XkA+uBsVYZLK+2Oo2/fpgnbvwEPT2wrK9TyP+56162i4lQtda9NOOO5bb+twA/oOU7
         gxtA==
X-Forwarded-Encrypted: i=1; AJvYcCWIPkfPTDdJFg0oXeJ0jQaAerHoV/yEQGreNSFoPm9vYz5PLyV0+uUxqbzawQxY2n3EcJ17iCxa0P+NFgUrxMGNxKdT
X-Gm-Message-State: AOJu0YwY7g0HESEDn+1FDeeRoHopS8M2ls2gEUejaCZJ6nsgaoXt6503
	WBd/5FT2FO055Csazdiye3Z1jcRrxZcSHLJfeHDaXUdGTFuSTo7NThYTqWQFIExnrzHbdS0Hj3N
	e6277NWJ4UjAzPNkLrZnI7iLpFMv6ZvJYg3LOOA==
X-Google-Smtp-Source: AGHT+IGltJy69FUVSMW4LFVXZqDrwd5KyyaGFkAwhbmHGcFXmgonDoEQpIPCZKcyRVy54yw6TCa3dvIpSJcZwwcjl98=
X-Received: by 2002:a17:90a:eb04:b0:299:6c50:c2a0 with SMTP id
 j4-20020a17090aeb0400b002996c50c2a0mr9639990pjz.23.1708484321762; Tue, 20 Feb
 2024 18:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <20240220035105.34626-2-dongmenglong.8@bytedance.com> <ZdTe8LteoqR43d4q@krava>
In-Reply-To: <ZdTe8LteoqR43d4q@krava>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 21 Feb 2024 10:58:30 +0800
Message-ID: <CALz3k9juJUBDV=wyCG7Ru6_OcMCpArL5MSGWrsb5xhx=u4+N2g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 1/5] bpf: tracing: add support to
 record and check the accessed args
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mykolal@fb.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, thinker.li@gmail.com, 
	zhoufeng.zf@bytedance.com, davemarchevsky@fb.com, dxu@dxuuu.xyz, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Feb 20, 2024 at 11:51:01AM +0800, Menglong Dong wrote:
>
> SNIP
>
> > +static int get_ctx_arg_idx_aligned(struct btf *btf, const struct btf_t=
ype *t,
> > +                                int off)
> > +{
> > +     const struct btf_param *args;
> > +     u32 offset =3D 0, nr_args;
> > +     int i;
> > +
> > +     nr_args =3D btf_type_vlen(t);
> > +     args =3D (const struct btf_param *)(t + 1);
> > +     for (i =3D 0; i < nr_args; i++) {
> > +             if (offset =3D=3D off)
> > +                     return i;
> > +
> > +             t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> > +             offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> > +             if (offset > off)
> > +                     return -1;
> > +     }
> > +     return -1;
> > +}
> > +
> > +/* This function is similar to btf_check_func_type_match(), except tha=
t it
> > + * only compare some function args of the function prototype t1 and t2=
.
> > + */
>
> could we reuse btf_check_func_type_match instead? perhaps just
> adding extra argument with arguments bitmap to it?
>

This is a little difficult, as the way we check the consistency of t1
and t2 is a little different.

in btf_check_func_type_match(), we check the args of t1 and t2
by index. But in btf_check_func_part_match(), we check the args
of t1 and t2 by offset. Reusing can make btf_check_func_type_match
become complex and hard to understand.

Anyway, let me have a try to see if it works to reuse
btf_check_func_type_match().

Thanks!
Menglong Dong

> jirka
>
> > +int btf_check_func_part_match(struct btf *btf1, const struct btf_type =
*func1,
> > +                           struct btf *btf2, const struct btf_type *fu=
nc2,
> > +                           u64 func_args)
> > +{
> > +     const struct btf_param *args1, *args2;
> > +     u32 nargs1, i, offset =3D 0;
> > +     const char *s1, *s2;
> > +
> > +     if (!btf_type_is_func_proto(func1) || !btf_type_is_func_proto(fun=
c2))
> > +             return -EINVAL;
> > +
> > +     args1 =3D (const struct btf_param *)(func1 + 1);
> > +     args2 =3D (const struct btf_param *)(func2 + 1);
> > +     nargs1 =3D btf_type_vlen(func1);
> > +
> > +     for (i =3D 0; i <=3D nargs1; i++) {
> > +             const struct btf_type *t1, *t2;
> > +
> > +             if (!(func_args & (1 << i)))
> > +                     goto next;
> > +
> > +             if (i < nargs1) {
> > +                     int t2_index;
> > +
> > +                     /* get the index of the arg corresponding to args=
1[i]
> > +                      * by the offset.
> > +                      */
> > +                     t2_index =3D get_ctx_arg_idx_aligned(btf2, func2,
> > +                                                        offset);
> > +                     if (t2_index < 0)
> > +                             return -EINVAL;
> > +
> > +                     t1 =3D btf_type_skip_modifiers(btf1, args1[i].typ=
e, NULL);
> > +                     t2 =3D btf_type_skip_modifiers(btf2, args2[t2_ind=
ex].type,
> > +                                                  NULL);
> > +             } else {
> > +                     /* i =3D=3D nargs1, this is the index of return v=
alue of t1 */
> > +                     if (get_ctx_arg_total_size(btf1, func1) !=3D
> > +                         get_ctx_arg_total_size(btf2, func2))
> > +                             return -EINVAL;
> > +
> > +                     /* check the return type of t1 and t2 */
> > +                     t1 =3D btf_type_skip_modifiers(btf1, func1->type,=
 NULL);
> > +                     t2 =3D btf_type_skip_modifiers(btf2, func2->type,=
 NULL);
> > +             }
> > +
> > +             if (t1->info !=3D t2->info ||
> > +                 (btf_type_has_size(t1) && t1->size !=3D t2->size))
> > +                     return -EINVAL;
> > +             if (btf_type_is_int(t1) || btf_is_any_enum(t1))
> > +                     goto next;
> > +
> > +             if (btf_type_is_struct(t1))
> > +                     goto on_struct;
> > +
> > +             if (!btf_type_is_ptr(t1))
> > +                     return -EINVAL;
> > +
> > +             t1 =3D btf_type_skip_modifiers(btf1, t1->type, NULL);
> > +             t2 =3D btf_type_skip_modifiers(btf2, t2->type, NULL);
> > +             if (!btf_type_is_struct(t1) || !btf_type_is_struct(t2))
> > +                     return -EINVAL;
> > +
> > +on_struct:
> > +             s1 =3D btf_name_by_offset(btf1, t1->name_off);
> > +             s2 =3D btf_name_by_offset(btf2, t2->name_off);
> > +             if (strcmp(s1, s2))
> > +                     return -EINVAL;
> > +next:
> > +             if (i < nargs1) {
> > +                     t1 =3D btf_type_skip_modifiers(btf1, args1[i].typ=
e, NULL);
> > +                     offset +=3D btf_type_is_ptr(t1) ? 8 : roundup(t1-=
>size, 8);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_=
type *t)
> >  {
> >       const char *name;
> > --
> > 2.39.2
> >

