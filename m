Return-Path: <bpf+bounces-21642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887384FC7C
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468841C223CF
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13080C18;
	Fri,  9 Feb 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWeItLrm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8832E3F7
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505212; cv=none; b=iHUXajP7Zh5heKMHwD67mTnp8kOGFx9Pdca0HGIyQJCKQuHyNeVp5vZDYhDUZD+Q0Y4xPNPSjM6jbe79OtyvS4YqFNaB4NXcK5A5zVzrtVLNm55DreYmNe7HUqAAB5fs4NIJ5Id5kDEJ9PPHThwD3RiPq4ruDCT84hrJNELMJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505212; c=relaxed/simple;
	bh=iVtpMzIOjKFa+UvNnvTekS+6lM8pUtiYLPIhw4BSu3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nddt1O5X/q5EL718nnlwbLuWqFJB1OVq9T7TuQuYMlQJsNH2eHHCxNOOuoX9DfAQ0iE2pIK1E5g5Gecp3pkasAmlIx1j7qR8/DOGb6+3dVH/UxDlgYcZ2Yd+c9c1gb/fb22B/0e7Ouf9vNCalQHdjBZl8qEzuqr8giduUtUfiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWeItLrm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41060e5b664so8816455e9.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 11:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707505209; x=1708110009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smNwYLt+u1Cm9MC8hNC+SwZPa650eVtwDGnMkvsD+dc=;
        b=HWeItLrmBVTb8CIc88gW0fchuSl+DyPVYY1e3Ur3kaFyg8kj5ONAlN/trY8JcC+rUT
         GTVzX/BjSshfWtoqLtBD/gT71ZdMAJivHl8usLEXlYTY0eQ+eMr0ZY/cCf4gqQL3Opmp
         eYn8uDnqjX7AEn2qgZPImuj7EzzZhyBhtpUCZb0D6JNOzb6YVp3kqVQU3AKMKNQ+Ue3i
         0Qh5rE+Fpuw+lSSTm/C7Y4I1TMbC9kX+dpE11Ja490v5E/Xer9qbPO5hH/2YZHMam2H/
         fe4HAsGTFGAqEpTV/yJLgZKKm64NgUvMMFJD0vuz6UghLqOxidk0oftfNuF+a9weCGuM
         FJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505209; x=1708110009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smNwYLt+u1Cm9MC8hNC+SwZPa650eVtwDGnMkvsD+dc=;
        b=CJ0jjBqbb9n48Q843sMXGENQaArzZNh0Df4i6QLX8IjS2POko7SEUfBE8W2+TA6hI0
         jBNwSfUWaJXjTwSI2M9taColzQS3C5BoQstUv2rkqjcvqVJEUgZTnqaAKVy0fc/9ezzk
         zUSlSeKl3ICIWxY04TZ8ZmzUiLivj/w/rXZkT9bfUpywaZf5LtvruGBotMQDEbaqHeM+
         /QOVNeyJ0RkUSXpQMQdc9E8GnUxMt0uIvKrffHAKKUJOZgkg36FPBqzPf5YPtO1W7yVY
         2pVcnBQnHiH3uXMavs8Q4k97/0C5go5gH8nGdni6JR+WSjr4SCIcrZWDbiVo63h9HP3M
         g1mw==
X-Gm-Message-State: AOJu0YzCvXTg+cGWe4RdRqsLfecCMxeyG+O5MTMRZRXrBJ1aPPTe0n5h
	n+zy3FtK2a/zhW+2ODe0om2aPCoq0mPhlaW6ckJNEQDKEvhnBm3uvRv6vR38EMPk7JvLvk5rGzv
	j6isU3UG/RItAO7Ym/dph8Plf1PW4mdrycBM=
X-Google-Smtp-Source: AGHT+IGI7oxTbV992uv5aSPiXKCc8DxS+VIVKigmITHg3SGGFhAZXsOeyex5sH/m4hTtfSlUcM7dTV54S5ZIm2nPuNc=
X-Received: by 2002:a05:6000:1aca:b0:33b:68a1:c71 with SMTP id
 i10-20020a0560001aca00b0033b68a10c71mr879070wry.18.1707505209000; Fri, 09 Feb
 2024 11:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-3-alexei.starovoitov@gmail.com> <20240209165745.GB975217@maniforge.lan>
 <jxfd2zufwee3rom5zt3pger5wkytwiuy3lepw5vacvg6lwuv7g@cxnjdxb3tr2d> <20240209181136.GD975217@maniforge.lan>
In-Reply-To: <20240209181136.GD975217@maniforge.lan>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Feb 2024 10:59:57 -0800
Message-ID: <CAADnVQ+9pKPVRvF-No60-9-brhSR+AYHotcPp36=6AqP9dEJLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/16] bpf: Recognize '__map' suffix in kfunc arguments
To: David Vernet <void@manifault.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 10:11=E2=80=AFAM David Vernet <void@manifault.com> w=
rote:
> >
> > Makes sense, but then should I add the following on top:
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e970d9fd7f32..b524dc168023 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11088,13 +11088,16 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_en=
v *env,
> >         if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
> >                 return KF_ARG_PTR_TO_CONST_STR;
> >
> > +       if (is_kfunc_arg_map(meta->btf, &args[argno]))
> > +               return KF_ARG_PTR_TO_MAP;
> > +
>
> Yeah, it's probably cleaner to pull it out of that block, which is
> already a bit of a mess.
>
> Only thing is that it doesn't make sense to invoke is_kfunc_arg_map() on
> something that doesn't have base_type(reg->type) =3D=3D CONST_PTR_TO_MAP
> right? We sort of had that covered in the below block beacuse of the
> reg2btf_ids[base_type(reg->type)] check, but even then it was kind of
> sketchy because we could have base_type(reg->type) =3D=3D PTR_TO_BTF_ID o=
r
> some other base_type with a nonzero btf ID and still treat it as a
> KF_ARG_PTR_TO_MAP depending on how the kfunc was named. So maybe
> something like this would be yet another improvement on top of both
> proposals that would avoid any weird edge cases or confusion on the part
> of the kfunc author?
>
> + if (is_kfunc_arg_map(meta->btf, &args[argno])) {
> +         if (base_type(reg->type) !=3D CONST_PTR_TO_MAP) {
> +                 verbose(env, "kernel function %s map arg#%d %s reg was =
not type %s\n",
> +                         meta->func_name, argno, ref_name, reg_type_str(=
env, CONST_PTR_TO_MAP));
> +                 return -EINVAL;
> +         }

This would be an unnecessary restriction.
We should allow this to work:

+SEC("iter.s/bpf_map")
+__success __log_level(2)
+int iter_maps(struct bpf_iter__bpf_map *ctx)
+{
+       struct bpf_map *map =3D ctx->map;
+
+       if (!map)
+               return 0;
+       bpf_arena_alloc_pages(map, NULL, map->max_entries, NUMA_NO_NODE, 0)=
;
+       return 0;
+}

verifier log:
0: R1=3Dctx() R10=3Dfp0
; struct bpf_map *map =3D ctx->map;
0: (79) r1 =3D *(u64 *)(r1 +8)          ; R1_w=3Dtrusted_ptr_or_null_bpf_ma=
p(id=3D1)
; if (map =3D=3D (void *)0)
1: (15) if r1 =3D=3D 0x0 goto pc+5        ; R1_w=3Dtrusted_ptr_bpf_map()
; bpf_arena_alloc_pages(map, NULL, map->max_entries, NUMA_NO_NODE, 0);
2: (61) r3 =3D *(u32 *)(r1 +36)         ; R1_w=3Dtrusted_ptr_bpf_map()
R3_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)=
)
; bpf_arena_alloc_pages(map, NULL, map->max_entries, NUMA_NO_NODE, 0);
3: (b7) r2 =3D 0                        ; R2_w=3D0
4: (b4) w4 =3D -1                       ; R4_w=3D0xffffffff
5: (b7) r5 =3D 0                        ; R5_w=3D0
6: (85) call bpf_arena_alloc_pages#42141      ; R0=3Dscalar()

the following two tests fail as expected:

1.
int iter_maps(struct bpf_iter__bpf_map *ctx)
{
  struct seq_file *seq =3D ctx->meta->seq;
  struct bpf_map *map =3D ctx->map;

  bpf_arena_alloc_pages((void *)seq, NULL, map->max_entries, NUMA_NO_NODE, =
0);

kernel function bpf_arena_alloc_pages args#0 expected pointer to
STRUCT bpf_map but R1 has a pointer to STRUCT seq_file

2.
  bpf_arena_alloc_pages(map->inner_map_meta, NULL, map->max_entries,
NUMA_NO_NODE, 0);

(79) r1 =3D *(u64 *)(r1 +8)          ; R1_w=3Duntrusted_ptr_bpf_map()
R1 must be referenced or trusted

