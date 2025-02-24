Return-Path: <bpf+bounces-52441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E618A42FC1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94503B80C1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688B1DA617;
	Mon, 24 Feb 2025 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8j1ZAj3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076AA15886C
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434734; cv=none; b=WnQqA6bALIr9vFD5pZffhqEd011c39rscz9ml1HK4WVz+4gf9YyYlRl5zZaX504FKzolVJer+dqGUBkQwPnizVAPehnndVDD15kwfX/TmhNHbclakrp3KRygTaGvr61ZbZ301iRXc9GgtBignZZgnw5wjvFpYd8ncuuU2g5yBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434734; c=relaxed/simple;
	bh=EKQvSvGXIBXYuHudbDvjJVFjfjSjtZh7tgwFDIsyd38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzDkykBMVlr/uIdUIE90wIznl6jE3JFdH6L84MrAobRhiqbzdVboH1w9IrdQ2A+l+ZRcB/c9mmFoj6ykxTiVv9vpy9oOhJjsFRlZzXkXovbrGOQCDVYZwZlxfqhAIjzG4uLpcx/QZ//SjXnqY72tdeFdt9wIkK0viFA9pCbk0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8j1ZAj3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f441791e40so7614780a91.3
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 14:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740434732; x=1741039532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFKXcY3xWuZv7fLNCHJOwdT6hUZmjiogHpqGkhcnxmo=;
        b=T8j1ZAj38zaMzmi9uzD7cyUze6JQ7tTCnnKdfpnfIV04Ofuh2rEkViONPjh3KMypL2
         DlAWjD9LLtwybmUIbpl2angFyC0MuYZgV3CCXsYlFNsnWD7xh0oOFN2C5DWlhHEoFb/8
         q1jKZmY6XmgoMiCyneey7X0CC7WgYBiCuEnysWEuMGdwRuqLCLYl4iODns/3EEhhfmdR
         h0QoRyFrWl8QKfy8kCK6PgbLmhCjzgehSdLGd48GpVDgIR8vDonc66hPPjj4eE3CRmZs
         LSok+u2F2Muxiptf8iE+sLOw+bRpoPkrVvAFXHogSOpMLMgvSQTcPWYSSm8E+qXK8Uef
         OAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434732; x=1741039532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFKXcY3xWuZv7fLNCHJOwdT6hUZmjiogHpqGkhcnxmo=;
        b=qZ9rcsbDMjuaSSEIJslj02oO/5BOpEaI+q9MZnlJFjCy+AfnUngmCckH7asKjiM9l8
         LRl6MkFYe+n06oK7BUhrt6fpm0dhaEsz0oJe6PzJ/sVXEKvJ90+t+WT52pMpACO6RzZA
         1wDdFMPDpEQHaizUjyPX+xjUxcrvt8LpwT+y2tt4vMVfYdiDmiFWp2m3Z/CK37OsF9Jr
         aVtO/FQhUcObRln8T5S8R3HpptG/l4qhu0bJDXkDdD1UsxwlhXZKbDnbNEdTQ7Lm3d96
         d3+Rj8wb0+NAq+UpaT3HVrVUvrtCwxh6/aLIqrl6mRgzfP+Jp/oFB3jkkaAHxjxk/eb6
         FYIA==
X-Gm-Message-State: AOJu0YxquuMVKpIUKCFKAMbiJBvY2dsQlATDS1+536RxMTFJR2SVXhGJ
	8AA9npTOU0TUyroZZKfyEXenRuW70GTETWMSsXly5+Qi8bv4EWISKCNmeAK9/9B2r+mvffF2dtU
	hgXa3Wix8Jbmj0kfKORJENUBMgEo=
X-Gm-Gg: ASbGncvRQ8APQMbfsVezNfs/HNCMmrSpfWQOt0WHV2KkJ5/BRWTQZSB+igBvoCuUCay
	Vfbjfx2F7lPoljPWUJT9+/ycRqiR6RC8sSiUv5bv5hsl8wmyfy1Qa2LNJNnfikyKgQQoJq630UN
	n3Y51uuLUYRUTxJMeflpp2cn0=
X-Google-Smtp-Source: AGHT+IEiZYdYmAQVcczOdjzi7MbGSXooFEvdQw5Dw/HRB+iw6mVL4VwTD46S5B6ooe1RrmX8PTT0RaAxTeEJat2HGEw=
X-Received: by 2002:a17:90b:5202:b0:2fa:b8e:3d26 with SMTP id
 98e67ed59e1d1-2fce875bd28mr23102136a91.30.1740434732187; Mon, 24 Feb 2025
 14:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220215904.3362709-1-ihor.solodrai@linux.dev>
In-Reply-To: <20250220215904.3362709-1-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 14:05:20 -0800
X-Gm-Features: AQ5f1JpVmF3G5_25AIEeuphgFnqG1bmCgTW49uiWFjjiGfE0axFyXwW7J4oEy3s
Message-ID: <CAEf4Bzb4T3DcySAyyCXWBK-ShyW9iuE-OM9f7EHXmBJg5Qm0eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: implement bpf_usdt_arg_size BPF function
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 1:59=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Information about USDT argument size is implicitly stored in
> __bpf_usdt_arg_spec, but currently it's not accessbile to BPF programs
> that use USDT.
>
> Implement bpf_sdt_arg_size() that returns the size of an USDT argument
> in bytes.
>
> Factor out __bpf_usdt_arg_spec() routine from bpf_usdt_arg(). It
> searches for arg_spec given ctx and arg_num.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/lib/bpf/usdt.bpf.h | 59 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 12 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index b811f754939f..6041271c5e4e 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -108,19 +108,12 @@ int bpf_usdt_arg_cnt(struct pt_regs *ctx)
>         return spec->arg_cnt;
>  }
>
> -/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value into =
*res.
> - * Returns 0 on success; negative error, otherwise.
> - * On error *res is guaranteed to be set to zero.
> - */
> -__weak __hidden
> -int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
> +/* Validate ctx and arg_num, if ok set arg_spec pointer */
> +static __always_inline
> +int __bpf_usdt_arg_spec(struct pt_regs *ctx, __u64 arg_num, struct __bpf=
_usdt_arg_spec **arg_spec)
>  {
>         struct __bpf_usdt_spec *spec;
> -       struct __bpf_usdt_arg_spec *arg_spec;
> -       unsigned long val;
> -       int err, spec_id;
> -
> -       *res =3D 0;
> +       int spec_id;
>
>         spec_id =3D __bpf_usdt_spec_id(ctx);
>         if (spec_id < 0)
> @@ -136,7 +129,49 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num,=
 long *res)
>         if (arg_num >=3D spec->arg_cnt)
>                 return -ENOENT;
>
> -       arg_spec =3D &spec->args[arg_num];
> +       *arg_spec =3D &spec->args[arg_num];
> +
> +       return 0;
> +}
> +
> +/* Returns the size in bytes of the #*arg_num* (zero-indexed) USDT argum=
ent.
> + * Returns negative error if argument is not found or arg_num is invalid=
.
> + */
> +static __always_inline
> +int bpf_usdt_arg_size(struct pt_regs *ctx, __u64 arg_num)
> +{
> +       struct __bpf_usdt_arg_spec *arg_spec;
> +       int err;
> +
> +       err =3D __bpf_usdt_arg_spec(ctx, arg_num, &arg_spec);

let's not extract this into a separate function. I don't particularly
like the out parameter, and no need to add another function that could
be used by users. There isn't much duplication, I think it's fine if
we just copy/paste few lines of code.

pw-bot: cr

> +       if (err)
> +               return err;
> +
> +       /* arg_spec->arg_bitshift =3D 64 - arg_sz * 8
> +        * so: arg_sz =3D (64 - arg_spec->arg_bitshift) / 8
> +        * Do a bitshift instead of a division to avoid
> +        * "unsupported signed division" error.
> +        */
> +       return (64 - arg_spec->arg_bitshift) >> 3;

arg_bitshift is stored as char (which could be signed), so that's why
you were getting signed division, just cast to unsigned and keep
division:

return (64 - (unsigned)arg_spec->arg_bitshift) / 8;

> +}
> +
> +/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value into =
*res.
> + * Returns 0 on success; negative error, otherwise.
> + * On error *res is guaranteed to be set to zero.
> + */
> +__weak __hidden
> +int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
> +{
> +       struct __bpf_usdt_arg_spec *arg_spec;
> +       unsigned long val;
> +       int err;
> +
> +       *res =3D 0;
> +
> +       err =3D __bpf_usdt_arg_spec(ctx, arg_num, &arg_spec);
> +       if (err)
> +               return err;
> +
>         switch (arg_spec->arg_type) {
>         case BPF_USDT_ARG_CONST:
>                 /* Arg is just a constant ("-4@$-9" in USDT arg spec).
> --
> 2.48.1
>

