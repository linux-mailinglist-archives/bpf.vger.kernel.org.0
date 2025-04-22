Return-Path: <bpf+bounces-56417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7160A96F0B
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6433ADF79
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7628A400;
	Tue, 22 Apr 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PePgqBsz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E724C061;
	Tue, 22 Apr 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332651; cv=none; b=MNy9iiVrloG9yv2BMKvrFCyHBJ2ZxzDFgOUwlHob4sa15HaagWu0+zAUNcKJCBTOisCdLNZ+RAHdyFhIoreXg3cAvVyR3CMtfq3v5ayTxiB0euBBFSw31K42s+GJ1bgt34EhK7AfFElrt1t3l7z4tttt58CAAns0QLEh7DP9L+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332651; c=relaxed/simple;
	bh=xmX3wFn4yklfFDUdyFQ1DZ2SHZtonDRd61YMLJM3MpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gt1/LNSXDxAKs3QyoAslj3dmqDfw1cLN/vMKSoAxEXpz37SNiEJhoVd1WmpsYaOkjp20P4nqw9BBR7IsDP9XFktWYIlgRvcvw0IrDiQUpOQuXFI4qVr/8m70o9WIq7MPAMDORrmgrqygCFVUhnJSxzNT11yNHJA7aKhoTu0bD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PePgqBsz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf848528aso39299265e9.2;
        Tue, 22 Apr 2025 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745332648; x=1745937448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVNRoD0RrSksEzR7JBfXuuef+5VZbaweuF4W6LsXFS4=;
        b=PePgqBszsdiRkab072Hmjgb9Cx4J2FC5I1Nk7O6bxJIlkeeZmxwM3qy+MXQ9Ki4qmk
         qrSxKTKcBhGitQTI4mAHG3dqMaQKf3xN3oXIfTOp5ucd+NrL5ICZqCpQ5LTSzSQjE1bQ
         7Q0THaOwAlRko2U2r4aA+73xOIVqt73q+iKFDxsMoQ3JO6H3j3w6YIlhmxAThFDgLJQP
         BLHrr18KzF/zO8alswywW2nNC60FPo4ORSxPLc5pKbaK3SkQdD9he2fAXf136eYI95fN
         jgOCg6pht8StVlT+hvtjZH4nCARxmYpI5QWwcm3PGpuvt5f9AqySb/ye7yO1XHHycsZA
         I/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745332648; x=1745937448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVNRoD0RrSksEzR7JBfXuuef+5VZbaweuF4W6LsXFS4=;
        b=l7uIAlwOB8nX8pIm8h8ON0shqahf2CjR0CrSZLobBZp2tljHkGlExhf0/vtu7MurwA
         QWJMPPiJNI3m2Q6O3mtZTBj4+pUP8+ovn7CLjU1z8DoiEYuM6vIeNiZwnMOhoy9PWnnP
         FdVQoK1f5IdEvZN3TyhM6xj1kX5z4z3X5F6G2loFOne41SUyayUnj7i3oh+19EqcNQQ5
         I8/kzzo3OEqyx7IUgPGl5FSuSk5Kft2JWeQg0PRlRoNtUFQWApSyk0JhdX6IatP+2Fii
         AXHDDW01yUWUfiyb6DolOK+52WSED6zMdgCmcQ1C0jZtHfoO49o2pWL/jBAd7rJffGTp
         b9mA==
X-Forwarded-Encrypted: i=1; AJvYcCUITHtbUQOrMdWrd1f9HJwhF2eaAiXkrfYVNBFSx8gjdvnhWzGdUEd+m5NBB6lcZmFHRcg=@vger.kernel.org, AJvYcCUN4NDsw6mzTZlzBk+hn43KjQDzYU0WV5ZHQEyArv+yiWvzzetVlmsnQh5crNA2gZOym46/Al08HN0DeqA9@vger.kernel.org, AJvYcCV4uSybK/JbuWSLkmHBiLdjA9rtctuv7oNmvkBTLbNoYqDLlI4MnchsmLTVLdZNKIEua+52OEfu@vger.kernel.org, AJvYcCVJVGA8rVK8TvsjeI5E8J9XcoBk4abWDwUauYTm2kLz3xb8G4+mxIfhQjZmSdoupURo3hY9n74tRgdi9kWcap68elAj@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDj8teaNUiaTk+6eDCOkQ4nOE6kr2bJGrJ/gFFcbVUd2p0rUt
	wI3IQTegNorKFI4liQ4UAJj7d47np+Ty2Do+qkFnTwBtfxlabK+vai6dyZdgm5zQtilcKcgw3RH
	7GIajTJoDWBIlyo2KYpLjXXJcrpQ=
X-Gm-Gg: ASbGnctfCyS5N+LjVRgt7vMQdyPPKKyp03A63oisCK2qv37brY0AmquQyAqeyrw2Zgm
	foHL0GGPGJKYxH30rx6xLSHQAuYFDnGgHK2HXGnYzpdBDFNVXjIjnZweXquVwd2GwFpo4mbd3yK
	gNK9b+yBBofIiq+CUiTvArE2mAwU/ufqbWjv29Ew==
X-Google-Smtp-Source: AGHT+IG4Cy/AdgYd6cpiRO8xYSkhTRhh8bYXvxmR0r57jfYKceNU82XctCFA4+x4WBeXTAS2Qil7GfTxuYlsebAtqlo=
X-Received: by 2002:a05:600c:1e10:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-4406ac62b75mr163192435e9.31.1745332647307; Tue, 22 Apr 2025
 07:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQLnij-d3Hif1x8ocoYD=8sZG67qACXPZhK78cpYKczwkw@mail.gmail.com>
 <20250422080419.322136-1-yangfeng59949@163.com>
In-Reply-To: <20250422080419.322136-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Apr 2025 07:37:15 -0700
X-Gm-Features: ATxdqUHuUYafvzTvLuzZ_1rXZfUvY0jWnby7h9IZIWMk-HqLMT-8ZLGhVONcJnY
Message-ID: <CAADnVQ+WYLfoR1W6AsCJF6fNKEUgfxANXP01EQCJh1=99ZpoNw@mail.gmail.com>
Subject: Re:
To: Feng Yang <yangfeng59949@163.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Song Liu <song@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 1:04=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> Subject: Re: [PATCH bpf-next] bpf: Remove bpf_get_smp_processor_id_proto
>
> On Mon, 21 Apr 2025 18:53:07 -0700 Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
>
> > On Thu, Apr 17, 2025 at 8:41 PM Feng Yang <yangfeng59949@163.com> wrote=
:
> > >
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > >
> > > All BPF programs either disable CPU preemption or CPU migration,
> > > so the bpf_get_smp_processor_id_proto can be safely removed,
> > > and the bpf_get_raw_smp_processor_id_proto in bpf_base_func_proto wor=
ks perfectly.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > > ---
> > >  include/linux/bpf.h      |  1 -
> > >  kernel/bpf/core.c        |  1 -
> > >  kernel/bpf/helpers.c     | 12 ------------
> > >  kernel/trace/bpf_trace.c |  2 --
> > >  net/core/filter.c        |  6 ------
> > >  5 files changed, 22 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 3f0cc89c0622..36e525141556 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -3316,7 +3316,6 @@ extern const struct bpf_func_proto bpf_map_peek=
_elem_proto;
> > >  extern const struct bpf_func_proto bpf_map_lookup_percpu_elem_proto;
> > >
> > >  extern const struct bpf_func_proto bpf_get_prandom_u32_proto;
> > > -extern const struct bpf_func_proto bpf_get_smp_processor_id_proto;
> > >  extern const struct bpf_func_proto bpf_get_numa_node_id_proto;
> > >  extern const struct bpf_func_proto bpf_tail_call_proto;
> > >  extern const struct bpf_func_proto bpf_ktime_get_ns_proto;
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index ba6b6118cf50..1ad41a16b86e 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -2943,7 +2943,6 @@ const struct bpf_func_proto bpf_spin_unlock_pro=
to __weak;
> > >  const struct bpf_func_proto bpf_jiffies64_proto __weak;
> > >
> > >  const struct bpf_func_proto bpf_get_prandom_u32_proto __weak;
> > > -const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
> > >  const struct bpf_func_proto bpf_get_numa_node_id_proto __weak;
> > >  const struct bpf_func_proto bpf_ktime_get_ns_proto __weak;
> > >  const struct bpf_func_proto bpf_ktime_get_boot_ns_proto __weak;
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index e3a2662f4e33..2d2bfb2911f8 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -149,18 +149,6 @@ const struct bpf_func_proto bpf_get_prandom_u32_=
proto =3D {
> > >         .ret_type       =3D RET_INTEGER,
> > >  };
> > >
> > > -BPF_CALL_0(bpf_get_smp_processor_id)
> > > -{
> > > -       return smp_processor_id();
> > > -}
> > > -
> > > -const struct bpf_func_proto bpf_get_smp_processor_id_proto =3D {
> > > -       .func           =3D bpf_get_smp_processor_id,
> > > -       .gpl_only       =3D false,
> > > -       .ret_type       =3D RET_INTEGER,
> > > -       .allow_fastcall =3D true,
> > > -};
> > > -
> >
> > bpf_get_raw_smp_processor_id_proto doesn't have
> > allow_fastcall =3D true
> >
> > so this breaks tests.
> >
> > Instead of removing BPF_CALL_0(bpf_get_smp_processor_id)
> > we should probably remove BPF_CALL_0(bpf_get_raw_cpu_id)
> > and adjust SKF_AD_OFF + SKF_AD_CPU case.
> > I don't recall why raw_ version was used back in 2014.
> >
>
> The following two seem to explain the reason:
> https://lore.kernel.org/all/7103e2085afa29c006cd5b94a6e4a2ac83efc30d.1467=
106475.git.daniel@iogearbox.net/
> https://lore.kernel.org/all/02fa71ebe1c560cad489967aa29c653b48932596.1474=
586162.git.daniel@iogearbox.net/
>

Ahh. socket filters run in RCU CS. They don't disable preemption or migrati=
on.
Then let's keep things as-is.
We still want debugging provided by smp_processor_id().
If we switch everything to raw_ may miss things. Like this example with
socket filters.

