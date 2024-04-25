Return-Path: <bpf+bounces-27772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D1A8B182E
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 02:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE305285810
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138E24C74;
	Thu, 25 Apr 2024 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoRbn4o9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167E5672
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006211; cv=none; b=U3vzSZaCo1IYapGPHCr3zdpfXKk257WpnmYM8U3UqvhSJKKOBsKrnxeuuPJYbe5x5lES+yzUiia7DRQocU1muoEYfqUqTkwJ/tl4HMcDD8kLSxS8wrfXxCfDPTJMPis4ncNsEgNTUwLfGezNGUcxRu59qZVReO0XnvojtvC4eiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006211; c=relaxed/simple;
	bh=rWj0PNe2f294p8EpsIK87TJpaSxJBQPLhhutqCAsOhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdJfMQvzQMYnKFvk61rUisKWORkdtbB9PtqRrmS1vqHh6+k79PUL7fLrChCKY2MwRUhz8lBRe6E5+BgoZ2KglGo4ccPzQ0+vPpmmjmh7+PL9w4XhqF8oUCsEpCvEyUTDSpmrXliTGbbLWDhlds5lV5Su6sNTuX6gP0R2BzxfWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoRbn4o9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-347e635b1fcso316068f8f.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714006208; x=1714611008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMR12sJmu+FKy13Eeddz7icueP3s0N9CtJfGPh3NR1c=;
        b=hoRbn4o9q108Xuc710hpdPewzDGbK4oqkU84W2sw87hwuUKZCxwLUtxStRmbmNcNPS
         OJHzYCjH3ITjHbYIYpH33IFnogM14G3qPQc7jgNCSbuHMMMYbOUdWMmcq4MgEX8PEK6A
         Q+RVW/uf6wSs0/x4Ip2hZFhSCTnF9M5iunufl9V+KbBc8bNV1KW8d+VhFT9TgRXdPMYn
         0T9oG1G+yFUPVixLbI08RuIVMMLM02cH1Zv2ZBnh/ouMtq7FzeyeWpWxKX5Nkpd0IY7e
         0i748yMTwcTbxrGLFa9bL4zXKbfijHCn+PaJ6XvQLrVimhliwv8o8iTMez8kfsOOqoVP
         Z4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714006208; x=1714611008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMR12sJmu+FKy13Eeddz7icueP3s0N9CtJfGPh3NR1c=;
        b=GGoraM5/ufmHUkQ77NdyEUlyLU7kAbIM1jTh/is93wgymBEjmqoRpoQ4gMQdUs8+1U
         EmQs46O1JJxnVRyytLa2/ZcYFL7eiEW7W1AdCAmI0IQJD487k4qAdL7zRUh7MemtvR8V
         HEZMUx2wlIiFb+suxLJ0n+ikQ2lR8+N9AYiukJ1gUPm4Ox/p9SDcJ9o9FHwh2BqRw+MG
         JwS9YEr47mXMIwPCUhWEYV38VNLAsVms7EI18yC0QoDeGoe8oLCXCvDRMTgm7B0j0WRo
         9qu2zykagHss27WPpzf8twk/8L1mLxnakXBzEEgkUDq7YSHmD3/1USqf02hYPePKrjRB
         YdYg==
X-Forwarded-Encrypted: i=1; AJvYcCX7g5D0JTpNsVxchRBbxIg2T4zXrwoxypDlubuxFqtCBlDvNxb54AMEjk5dYVcTga5keZQoNPLqWxPDanUbzPYxsyLV
X-Gm-Message-State: AOJu0YyyhaY4OVapx0/ARZJmV2A0xfa2rSNZ2Hfkuf5dHdrTgBbJb1AK
	dF3Hp51BGd76kkDLmi5hKeYZSVhw2iLA0pUsBIlQeACLpJ1gF5H+5R2hjmY6LwzqR8bhyyuMzCG
	5SmblIoT65AWvZqYqlI7Y5bo/yb8=
X-Google-Smtp-Source: AGHT+IHCxIX6x9rXA3iEHh+KllhGfVNkb5EMdCRSlSOyDXrsMuGiOVl9LAAZM3zYmRdovO3k79RuaGLU/hIa+G1swig=
X-Received: by 2002:a05:6000:1e8d:b0:346:b778:eaa7 with SMTP id
 dd13-20020a0560001e8d00b00346b778eaa7mr2407465wrb.18.1714006208087; Wed, 24
 Apr 2024 17:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210814.603377-1-thinker.li@gmail.com> <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
 <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com> <CAADnVQKjGFdiy4nYTsbfH5rm7T9gt_VhHd3R+0s4yS9eqTtSaA@mail.gmail.com>
 <6d25660d-103a-4541-977f-525bd2d38cd0@gmail.com> <CAADnVQ+hGv0oVx4_uPs2yr=vWC80OEEXLm_FcZLBfsthu0yFbA@mail.gmail.com>
 <57b4d1ca-a444-4e28-9c22-9b81c352b4cb@gmail.com> <90652139-f541-4a99-837e-e5857c901f61@gmail.com>
 <CAADnVQJFtRwwGm=zEa=CgskY57gXPsG240FA66xZFBONqPTYTg@mail.gmail.com> <c00b8c69-deb6-414c-a7ed-7f4a3c1ab83b@gmail.com>
In-Reply-To: <c00b8c69-deb6-414c-a7ed-7f4a3c1ab83b@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 17:49:56 -0700
Message-ID: <CAADnVQ+v7HPSxKV0f-BiwF3DntcYmpstyTDmnHuBsXN=GfB1Fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:32=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
> > struct map_value {
> >     struct {
> >        struct task __kptr *p1;
> >        struct thread __kptr *p2;
> >     } arr[10];
> > };
> >
> > won't be able to be represented as BPF_REPEAT_FIELDS?
>
>
> BPF_REPEAT_FIELDS can handle it. With this case, bpf_parse_fields() will
> create a list of btf_fields like this:
>
>      [ btf_field(type=3DBPF_KPTR_..., offset=3D0, ...),
>        btf_field(type=3DBPF_KPTR_..., offset=3D8, ...),
>        btf_field(type=3DBPF_REPEAT_FIELDS, offset=3D16, repeated_fields=
=3D2,
> nelems=3D9, size=3D16)]
>
> You might miss the explanation in [1].
>
> btf_record_find() is still doing binary search. Looking for p2 in
> obj->arr[1], the offset will be 24.  btf_record_find() will find the
> BPF_REPEATED_FIELDS one, and redirect the offset to
>
>    (field->offset - field->size + (16 - field->offset) % field->size) =3D=
=3D 8
>
> Then, it will return the btf_field whose offset is 8.
>
>
> [1]
> https://lore.kernel.org/all/4d3dc24f-fb50-4674-8eec-4c38e4d4b2c1@gmail.co=
m/

I somehow completely missed that email.
Just read it and tbh it looks very unnatural and convoluted.

> [kptr_a, kptr_b, repeated_fields(nelems=3D3, repeated_cnt=3D2),
>    repeated_fields(nelems=3D9, repeated_cnt=3D3)]

is kinda an inverted array description where elements come first
and then array type. I have a hard time imagining how search
in such thing will work.

Also consider that arrays won't be huge, since bpf prog
can only access them with a constant offset.
Even array[NR_CPUS] is unlikely, since indexing into it
with a variable index won't be possible.

