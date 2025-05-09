Return-Path: <bpf+bounces-57946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04668AB1F0B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6487B389A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E425F992;
	Fri,  9 May 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/Aiv+a0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20222DF80
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826014; cv=none; b=Nm+5d3qjgVGTKAK3kFLLpcKcPInUqTRln+EDqSe7ZMmT4vu3dRbmMPZvlO5LDR/ZH9bIJxwIjcVODwSDhDWIBRiquCVh55plYzWVbiTbFnXbRmO3wB33+OK35FqyDXO6Ai1EWfbWdqFplz3P8a5CbugX0r5Wvm6k/Ps216j/UQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826014; c=relaxed/simple;
	bh=MdnA+sXJRDJ5bU/YWRrva+tm22U53L2FZXYkHln4Aqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmiVlPfCowwFDJLSlEoeLRrtvFwj/CsldbJ0JgUJXla94ovM1A7mN1kj3Zfh2d1L5HTCeKq08Kb8tBlMbUYcsOvxgj/xu2CCwdoN5QeaHtgfAng9/O+gqCXhgUVEwbCYUSrcp0uxoGSP3UVlPb0uvSIOhH0BKX2nYoAMcfcM+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/Aiv+a0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30a93117e1bso3426425a91.1
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746826012; x=1747430812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0Ii/1A/vjdkJB23/NiHF2o6TlVjKR94QrN/eiGwLHs=;
        b=j/Aiv+a0aqyZusp+P9CM1ALiJTFyzknZcoMBXltuvz7cnlodvX4sx15sEN3wHxDauT
         WhqjuEAslRSZAvjPUTzW3VN1nFun6uUCGwMxPzYGS1IiYteb7WnlLQgai/m1kds91QsX
         f4AG1/snLp7q3KGSlby0wZNbnGepCkBi9PE6J4vroea0Y7k+suMFyOr1JplVN1NKxDC2
         zUovezICHWbY0p7ca4ZLWCX8/7ZZv/lCwtJbE4KoHH+be/akTrIRpPosllxBiX0Pfl+c
         CrnL94cclV6dxAMrOkNkUvvRPipu50x7ljFQ6Oz8HpZUGa+logPvBINRZWGzyu6hnuZE
         M9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746826012; x=1747430812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0Ii/1A/vjdkJB23/NiHF2o6TlVjKR94QrN/eiGwLHs=;
        b=A0nIBMNXxXB3+ppJPj9wnmuB0r7KQVPVdRU4WM3NI6VHYgskmbi97pye2zSyYk5MaD
         +IA34R0GGBmqKC3s0POm43E589OYb1VgcIo4cd3KS3pP3uIz2bvFcWCcOkwDJ2ue5tHb
         rn8xdnkGe6TRft83sn9+OuiV4KL90MgkslROjPFfBUoAF0vpjBM3TTWfp/hrT2JXqdFT
         xJ3xIzBOT4tjFcdCXb+RFfIWSz6CtrThbZ9cJG8Ymd/XPPL0z4w78BRGP1Truj6kCogM
         jmHw7RcGUF4JykWCAX66uvHHj91w/BZ2/u2Tr3BcxHdhJg+VFEt4DVB/F2EIkd0MmZkY
         N8/g==
X-Gm-Message-State: AOJu0Yw4O6502pzz058DAzSXzoJQNEbv2HIZLvn13/Ojnre9JvyKiQ+I
	y5gtDnRm2LzeikFWt4HRI0hG0E3WQC1ar5EDJFiLt52Fpll0keVat3m4Tt1gwYIKAAhS/6saHQl
	Z2fKVhL/BqWw+YR5RiZxdr2zU9isPqjmd
X-Gm-Gg: ASbGncupxt01R7GfIk1N187dBx3jbFA0dV9bF1DG+oH7MuLzLJ5LBqwv46GP/2ccOLs
	oRHuBWHXnPFfiEURh4xlKD65t2900UgTslO5uaFftlD6DhpoqSF7SrW+qzd90vf3RtWkzACfGv4
	IXV3+PMX8HD2ifhcuitG3vgs0q45/43qC/rmSLDr5956enU9rNrKg2kTuRm3E=
X-Google-Smtp-Source: AGHT+IGA0i+Dq47s7WPJ+jj6aD44gMKVwgmTFnTIUXxuCLlauK9sVbBBMwikw1NHc391UX1F+K2C2AhqiG7HTgsIJYY=
X-Received: by 2002:a17:90b:4a10:b0:30a:204e:3271 with SMTP id
 98e67ed59e1d1-30c3d2e2d05mr9158136a91.17.1746826012050; Fri, 09 May 2025
 14:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-10-memxor@gmail.com>
In-Reply-To: <20250507171720.1958296-10-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 14:26:40 -0700
X-Gm-Features: ATxdqUGP_f8BnDDH5KQklYyHN4p6JSXpaQDx5f-6loVYeHEBJKpqleLJ_Iw4PCI
Message-ID: <CAEf4Bzant+2eULKoX5J4SPeAa4YM8MYhGykwe8G6jpMB6ovPuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:17=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Introduce a new macro that allows printing data similar to bpf_printk(),
> but to BPF streams. The first argument is the stream ID, the rest of the
> arguments are same as what one would pass to bpf_printk().
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/stream.c         | 10 +++++++--
>  tools/lib/bpf/bpf_helpers.h | 44 +++++++++++++++++++++++++++++++------
>  2 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index eaf0574866b1..d64975486ad1 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -257,7 +257,12 @@ __bpf_kfunc int bpf_stream_vprintk(struct bpf_stream=
 *stream, const char *fmt__s
>         return ret;
>  }
>
> -__bpf_kfunc struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_=
id, void *aux__ign)
> +/* Use int vs enum stream_id here, we use this kfunc in bpf_helpers.h, a=
nd
> + * keeping enum stream_id necessitates a complete definition of enum, bu=
t we
> + * can't copy it in the header as it may conflict with the definition in
> + * vmlinux.h.
> + */
> +__bpf_kfunc struct bpf_stream *bpf_stream_get(int stream_id, void *aux__=
ign)
>  {
>         struct bpf_prog_aux *aux =3D aux__ign;
>
> @@ -351,7 +356,8 @@ __bpf_kfunc struct bpf_stream_elem *bpf_stream_next_e=
lem(struct bpf_stream *stre
>         return elem;
>  }
>
> -__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(enum bpf_stream_id st=
ream_id, u32 prog_id)
> +/* Use int vs enum bpf_stream_id for consistency with bpf_stream_get. */
> +__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(int stream_id, u32 pr=
og_id)
>  {
>         struct bpf_stream *stream;
>         struct bpf_prog *prog;
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index a50773d4616e..1a748c21e358 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -314,17 +314,47 @@ enum libbpf_tristate {
>                           ___param, sizeof(___param));          \
>  })
>
> +struct bpf_stream;
> +
> +extern struct bpf_stream *bpf_stream_get(int stream_id, void *aux__ign) =
__weak __ksym;
> +extern int bpf_stream_vprintk(struct bpf_stream *stream, const char *fmt=
__str, const void *args,
> +                             __u32 len__sz) __weak __ksym;
> +
> +#define __bpf_stream_vprintk(stream, fmt, args...)                      =
       \
> +({                                                                      =
       \
> +       static const char ___fmt[] =3D fmt;                              =
         \
> +       unsigned long long ___param[___bpf_narg(args)];                  =
       \
> +                                                                        =
       \
> +       _Pragma("GCC diagnostic push")                                   =
       \
> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")           =
       \
> +       ___bpf_fill(___param, args);                                     =
       \
> +       _Pragma("GCC diagnostic pop")                                    =
       \
> +                                                                        =
       \
> +       int ___id =3D stream;                                            =
         \

What's the point of ___id variable? Just use `stream` in
bpf_stream_get() directly?

> +       struct bpf_stream *___sptr =3D bpf_stream_get(___id, NULL);      =
         \
> +       if (___sptr)                                                     =
       \
> +               bpf_stream_vprintk(___sptr, ___fmt, ___param, sizeof(___p=
aram));\
> +})
> +
>  /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
> - * Otherwise use __bpf_vprintk
> + * Otherwise use __bpf_vprintk. Virtualize choices so stream printk
> + * can override it to bpf_stream_vprintk.
>   */
> -#define ___bpf_pick_printk(...) \
> -       ___bpf_nth(_, ##__VA_ARGS__, __bpf_vprintk, __bpf_vprintk, __bpf_=
vprintk,       \
> -                  __bpf_vprintk, __bpf_vprintk, __bpf_vprintk, __bpf_vpr=
intk,          \
> -                  __bpf_vprintk, __bpf_vprintk, __bpf_printk /*3*/, __bp=
f_printk /*2*/,\
> -                  __bpf_printk /*1*/, __bpf_printk /*0*/)
> +#define ___bpf_pick_printk(choice, choice_3, ...)                      \
> +       ___bpf_nth(_, ##__VA_ARGS__, choice, choice, choice,            \
> +                  choice, choice, choice, choice,                      \
> +                  choice, choice, choice_3 /*3*/, choice_3 /*2*/,      \
> +                  choice_3 /*1*/, choice_3 /*0*/)
>
>  /* Helper macro to print out debug messages */
> -#define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
> +#define __bpf_trace_printk(fmt, args...) \
> +       ___bpf_pick_printk(__bpf_vprintk, __bpf_printk, args)(fmt, ##args=
)
> +#define __bpf_stream_printk(stream, fmt, args...) \
> +       ___bpf_pick_printk(__bpf_stream_vprintk, __bpf_stream_vprintk, ar=
gs)(stream, fmt, ##args)
> +
> +#define bpf_stream_printk(stream, fmt, args...) __bpf_stream_printk(stre=
am, fmt, ##args)
> +
> +#define bpf_printk(arg, args...) __bpf_trace_printk(arg, ##args)
>
>  struct bpf_iter_num;
>
> --
> 2.47.1
>

