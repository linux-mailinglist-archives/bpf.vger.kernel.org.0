Return-Path: <bpf+bounces-59768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDEACF432
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F64F1725B2
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF811F2BAB;
	Thu,  5 Jun 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyGNAhrt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5282E659
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140688; cv=none; b=cabHEYLlCOgqQbZjaCOyTPIYUWvCQHPMhibzXO28QmaMUdkthsHHG79SWVIM4W4ny8iGjgyRu0oXAB84dItfRYFnwUxWACBVzJtv38i1tRwYANRJZhWxNfc/bzre5642rbXNuKCZiLdAAVkrklOcI8t4hgnCUKYnbr/EkdKGmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140688; c=relaxed/simple;
	bh=CDQJnxwUEI8fMsfbEsGGeZqDL2em8xMvikwL4GsghDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP5eh34iCiGLfoBZfqChSJWiwD7PoN2DiDeY2G0+1rZi58gxXjwDSztF4dB6b1cBpeTlZHMredCxnlSjGwOrb32AkUWgbOKr/Ya1U91rRjwk9xe+9O0tbNCirJzH0Wuias3dfbvR9vg3mG9xZNPESJ6SA9svpYDsS2sAS8z/38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyGNAhrt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2efa17ed25so2012126a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140686; x=1749745486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MOaCVjyPY5nmxzpCCv86KKWRgOufHFy/oKeaS4L3D0=;
        b=WyGNAhrticd4fyuyOM29YOQzRhDUKbKWKb+XRaO92HZ6M2G5AU+8V/4RRh/R6snnqf
         H0UdHGREoMwNz3oCEv10E8/mH9V9G5Hgbcq8bc7yHxoLF9XdMZ/wqaLD0DM5tZ5eHt0L
         Te6aFwrpzIrnqwQ66In001CPR7UcGuem0/lN5N0ugkDzeS+WCj8aRRAsTQVmmZNMYE41
         GvdJ+x7P2i1mbRtdTzdcmwASZpScJLv5pjCwnlt8LENpHdHqgZhggChwrFbJAk7VDSlS
         VbA9WDpJ3vdaYcyzb/H6WcwYd2x62uVF1adfEeZLY+WbWu9pMiOjSoXGCMOgTKb6m8yC
         tfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140686; x=1749745486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MOaCVjyPY5nmxzpCCv86KKWRgOufHFy/oKeaS4L3D0=;
        b=qYpPgpygApRGZcq+MNmlgDXDdIrU0+TnmwXMj95LAgy30vP9cd0mfmAeY/W9UR3nf4
         WKcax0W0qxnBW9Ux60Mak1oRFhokY0C0QAurpFtUStDP2eCaFz/FK8WteUUGKqtAyFlT
         kwsWQLn8OjFD8Y65pmYGallsnVeMsTXYxrnfx79JvSNsh1XkbqyyZ0LhPl3lDPqbrGrN
         LGPjbTEP7ZAIhGKHUWEtWpQ6ha6g5OE+xjwG21uD+U1X+isTv4MPuDrepIxCqwV5z6Zh
         vKMmmUdJ6tjuunHaqjH/k09Cw/mKAy52K5wrmHF0F37Ha3iOtc7WyAYnuAPKOlczRxPP
         0aFw==
X-Forwarded-Encrypted: i=1; AJvYcCU8nNMLvtPG0gZqkwBVjdr5xtp85ocvpu/2puJuBrk/L5paL1IWq2xmcKvlOLblPfP/46w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtHnBJF6Lh11/ffUZD6uBM03HPFeSVcNik2jjF8heS78BT+Rm
	durt/g6z02db7QBGk00IplxaM4sgJ6tAxel09PpxaOgAZwTzRlFTzuz2G6b66oBSbjpmj6c+TJs
	xIHAFm0OAotzAJf1cspOw9w7YTjpmVPw=
X-Gm-Gg: ASbGncsrlMgMvitcnt+tUQIrr9oaApyuvidSGIkYHoROucLPZBGFh0vG8GzSMuw2VKm
	B0rWQkgMbUzlvBlt7LIpBBMeOhaG3WBlOWYunplh1nTIxvrF5kkrWUVousnb6Ysc+Ysla/WRmaN
	U/ARfEW14w3BelcvTZP0Tvl/M9U2TpNY055DfddzFj8PEA4+PR
X-Google-Smtp-Source: AGHT+IFg000/MWU6vfhOv2NyKqu/SMPR0i6YGEw6Q9ZBlSS8WtNCNIQ1u5gQPL0GNeg0KuYYaeB3Txw7u4fUL1aYntk=
X-Received: by 2002:a17:90b:384b:b0:311:1617:5bc4 with SMTP id
 98e67ed59e1d1-31329014cd7mr5380766a91.12.1749140686156; Thu, 05 Jun 2025
 09:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com> <20250604222729.3351946-3-isolodrai@meta.com>
In-Reply-To: <20250604222729.3351946-3-isolodrai@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 09:24:33 -0700
X-Gm-Features: AX0GCFsixEd0OictWl4Y_26ngOrGI4tLGRknGWylOufC3qy5jK4we_cwmtuCYW8
Message-ID: <CAEf4Bzae53DDPQYUwOC2w=LO1yxPMU2=vDoS7=rCSv1BkcsJ5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases with
 CONST_PTR_TO_MAP null checks
To: ihor.solodrai@linux.dev
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	yonghong.song@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@meta.com> w=
rote:
>
> A test requires the following to happen:
>   * CONST_PTR_TO_MAP value is put on the stack
>   * then this value is checked for null
>   * the code in the null branch fails verification
>
> I was able to achieve this by using a stack allocated array of maps,
> populated with values from a global map. This is the first test case:
> map_ptr_is_never_null.
>
> The second test case (map_ptr_is_never_null_rb) involves an array of
> ringbufs and attempts to recreate a common coding pattern [1].
>
> [1] https://lore.kernel.org/bpf/CAEf4BzZNU0gX_sQ8k8JaLe1e+Veth3Rk=3D4x7MD=
hv=3DhQxvO8EDw@mail.gmail.com/
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  .../selftests/bpf/progs/verifier_map_in_map.c | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>

LGTM overall

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/to=
ols/testing/selftests/bpf/progs/verifier_map_in_map.c
> index 7d088ba99ea5..1dd5c6902c53 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> @@ -139,4 +139,81 @@ __naked void on_the_inner_map_pointer(void)
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +int map_ptr_is_never_null(void *ctx)
> +{
> +       struct bpf_map *maps[2] =3D { 0 };
> +       struct bpf_map *map =3D NULL;
> +       int __attribute__((aligned(8))) key =3D 0;

aligned(8) makes any difference?

> +
> +       for (key =3D 0; key < 2; key++) {
> +               map =3D bpf_map_lookup_elem(&map_in_map, &key);
> +               if (map)
> +                       maps[key] =3D map;
> +               else
> +                       return 0;
> +       }
> +
> +       /* After the loop every element of maps is CONST_PTR_TO_MAP so
> +        * the invalid branch should not be explored by the verifier.
> +        */
> +       if (!maps[0])
> +               asm volatile ("r10 =3D 0;");
> +
> +       return 0;
> +}
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __type(value, int);
> +       __array(values, struct {
> +               __uint(type, BPF_MAP_TYPE_RINGBUF);
> +               __uint(max_entries, 4096);

nit: use 64 * 1024 just in case, for arches where page size is 64KB

> +       });
> +} rb_in_map SEC(".maps");
> +
> +struct rb_ctx {
> +       void *rb;
> +       struct bpf_dynptr dptr;
> +};
> +
> +static __always_inline struct rb_ctx __rb_event_reserve(__u32 sz)
> +{
> +       struct rb_ctx rb_ctx =3D {};
> +       void *rb;
> +       __u32 cpu =3D bpf_get_smp_processor_id();
> +       __u32 rb_slot =3D cpu & 1;
> +
> +       rb =3D bpf_map_lookup_elem(&rb_in_map, &rb_slot);
> +       if (!rb)
> +               return rb_ctx;
> +
> +       rb_ctx.rb =3D rb;
> +       bpf_ringbuf_reserve_dynptr(rb, sz, 0, &rb_ctx.dptr);
> +
> +       return rb_ctx;
> +}
> +
> +static __noinline void __rb_event_submit(struct rb_ctx *ctx)
> +{
> +       if (!ctx->rb)
> +               return;
> +
> +       /* If the verifier (incorrectly) concludes that ctx->rb can be
> +        * NULL at this point, we'll get "BPF_EXIT instruction in main
> +        * prog would lead to reference leak" error
> +        */
> +       bpf_ringbuf_submit_dynptr(&ctx->dptr, 0);
> +}
> +
> +SEC("socket")
> +int map_ptr_is_never_null_rb(void *ctx)
> +{
> +       struct rb_ctx event_ctx =3D __rb_event_reserve(256);
> +       __rb_event_submit(&event_ctx);
> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.47.1
>

