Return-Path: <bpf+bounces-57823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B2AB06A7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC84E1BA30BC
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F5230BC2;
	Thu,  8 May 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB654oJu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE122D78C
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747727; cv=none; b=Qct05qguboRxOwgwn+DhRlFT5R0JQ7QncWoxR6t6kWkc8qjardO0NCRHYNdUczvY1VeZRtAWFlH9Y65CAfuX/6ehGqLVMbFyDpd9rxKEk1oQLZEmxkHsjLXiWk4ZKtaVN3eXK4D20uFqaEqvnLPQVVizGHxi8RXtNTMYG5xpeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747727; c=relaxed/simple;
	bh=M8eVzhgS0cMnENifAIP2CHFnu0KxhaRhmxAqS0Qv2Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIkQhfZSCxpMZ6Itn6IXH+J2+Da9I+D8vmn8fm50ZWPgRozrNTLUv3RpGkYhlkevnPVaTQ0tdJN8giGRRaWBW/h9ERC/Tz0Y/sjvVFKJzjZti6XeAUA3hCL00viyt04fnBjZ9YwbDjHwuVneCROAogVKIqMKfekWMO1g8PO4lME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB654oJu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so16204465e9.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746747723; x=1747352523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc1OfLC34rdqk1mKxI/n+l8gMvIVSmCFy3GRv3Eu3Io=;
        b=AB654oJuykZkCSTl7gySivkIWx6BbILbHMgv6R/2eeIEo1ikdazSxOQiaRBZAGs9bR
         Dpv0E8wVkcBufOqsqvQ8nUfRjVFFChjmx7nnpgabfyBlGOKTV5pJbGigCuygt3D8gMbF
         cNN4EJSBF5vSYIbr6KqEcUFQet2RwZeBf5o5S1BmTe8OaulFVO6SOVXXq5YQv+JJLk3F
         d8zd52oloNnwO0ptSkcLfh6Txr15JQpV4PbEH4fVhFxKngl1WCI1hRafZhfXCeEad5U3
         mCKW49TlC8TwEaZbAEV2uljUSFLXKSkGKhDiw9UMFxTIFiX7e0jM3oL3mYIJFYdq68dn
         7cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746747723; x=1747352523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc1OfLC34rdqk1mKxI/n+l8gMvIVSmCFy3GRv3Eu3Io=;
        b=EsAvJ3WXppbZseaEsxlGvk0qvpBiWlc60davYOQazd8q8yjA1wN6jAHCaLiCPtESwL
         Hf4uCKA8IijGXuidjpkaMIvAnGgdJQ0Cc2WLQTYSQ1a8REPaIXEesCI+HmRIqYL3O13L
         vOvbt6b1V88Hkbs4TMjAvVqfhqyxkajomi1UUpmHpvnDpXmLYZzajaL2sgUGflwRBGPp
         7NqBXrxf7Cm+8taUYgdaXlLKdFxRZ/kNTZxFoZoMtdXLon8PqRne/7UsgGyq0or1m0Tn
         U/cf25p6SyGraeliaZOcQSWGhf2uUcuWgTuexkXcR+xe5PfjR7F9Gy83rus2onGqERyM
         tjFg==
X-Gm-Message-State: AOJu0Yw0lWg79oRn1JdEiIaX6bOyPN5TyQuTQjB6nhkxB+vBY3RO3Zxm
	NgsQ1AFXwBI4R0ExkANH2iSyx7rS++VKmJcWwReW8a7Js6A5MaDYJ62wYlj6ozQpARrfYtbqFn/
	BlOJiq2w6qJ8KLPC7HgjpcXA7jpk=
X-Gm-Gg: ASbGncvtsJ7alclANNOsufL4L0UZGznHVm0IHMri1aWrj2GM+uGZGL9lH8yYOeIOXfD
	EDyN7XPLTy/OwRaJA2dF3MoLBpoHx14t6fi4Z5oxZxfD9NGe9KHe0MKAElvffDUlwul1ym/WzI9
	zSjm5pFzhkniwJj/j+nMUpK1U4uDW3t16o3g7bIVkS8OJ6xoSu9A==
X-Google-Smtp-Source: AGHT+IH5UlbaVirGsg1kcPU+yLaTzkWk45quAR9D4r5rvKg1RoFYFALwqL2PiXl+2YPRPHuR/glBDyf74qwse4zWjBY=
X-Received: by 2002:a05:600c:1c84:b0:43e:ee80:c233 with SMTP id
 5b1f17b1804b1-442d6ddead9mr6625875e9.32.1746747723173; Thu, 08 May 2025
 16:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-10-memxor@gmail.com>
In-Reply-To: <20250507171720.1958296-10-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 May 2025 16:41:52 -0700
X-Gm-Features: AX0GCFuoqpFeoUwIIhEnWbXzsVpkbIfXii6G08OKv7Lgbh73pf3lU5b5KZbiFGQ
Message-ID: <CAADnVQKgUg38BhTF7dGa05474B+iqVPdwwvZu8Ab0cW00QX4Ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
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
> +       struct bpf_stream *___sptr =3D bpf_stream_get(___id, NULL);      =
         \
> +       if (___sptr)                                                     =
       \
> +               bpf_stream_vprintk(___sptr, ___fmt, ___param, sizeof(___p=
aram));\
> +})

Typically _get() is an acquire kfunc,
but here:

+BTF_ID_FLAGS(func, bpf_stream_get, KF_RET_NULL)
...
+BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)

This is odd and it makes above sequence look weird too.

This is inconsistent as well:
bpf_stream_printk(int stream,
bpf_stream_vprintk(struct bpf_stream *stream,

Existing helpers bpf_trace_printk() and bpf_trace_vprintk()
are consistent.

Not sure why bpf_stream_get() is needed at all.

Maybe
#define BPF_STDOUT ((struct bpf_stream *)1)
#define BPF_STDERR ((struct bpf_stream *)2)

not pretty, but at least api will be consistent.

Other ideas ?

