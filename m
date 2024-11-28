Return-Path: <bpf+bounces-45838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827BA9DBC23
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02039B21363
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF581BD9D2;
	Thu, 28 Nov 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXwlaard"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9160537F8;
	Thu, 28 Nov 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818177; cv=none; b=h97KST78OtWADB7q8Ap1i/TSSC9lh0/IhAy48aTzrblFBTaWtREpWt4pqzibeBqailombKp+DDENFxR5N9ADGMUVahFCoYS2jZz+pLHqEV7MS7ffKLF/bLIJH547Bcqpb3LJzafxZm22qCaCSRrUmePaoDwNhYcGPVrXJ2IUrx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818177; c=relaxed/simple;
	bh=GfLASxZo+Yf2trxqcYfmDbxASqnTbjdg8oOvia43HxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnpqHojJr/tGLZNJNPb20LKiRVs06ArgXLTefF817zXRlZ1kcAstgyUJyVX+dg1Me0g95h+PCqyt5FBIV0xOM6vGXLNtAdksE0yzBbMVtnoF6kEldjKmjO1dPpHWNEqHnww6Foy95byOK2Rgky4lSdEfO7Ypv+bIBa+nw6TZJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXwlaard; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3822ba3cdbcso747565f8f.0;
        Thu, 28 Nov 2024 10:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732818174; x=1733422974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maEchboAXGaRsP4y4IkvMG/7KoHmadrlFmb4Cbg4uYE=;
        b=RXwlaardgrRqz2OH+r4+4+fec3LmzH0MYzE3mIMYQ8tyCnl847X79kuBc3jbY7+8JE
         /RRV7QvGhPPNEzOwuTtABOh2P3t8FVapbffP8QyqPJ2CGFZeTS2bbCnfzA42jVULrOf8
         tc15dqwKNafMjgtl7cMx3GbbZD/DyhJO+9PMI6cznW6+j+4Vhll7wE547wQzQ4YRUJmU
         nSqO6bfIKWiMKi2J0C2Sw2lDr1mO8GcLm1JWcHsJ+zg553PaSIWeS8Zl+hhKwa3AZFLC
         I7nbPwmHLfdEk6+aL0ds0JCQ1WZNE+7sudkqs2nG7dpSq3TeXXS0jyjXssNmwRip97V4
         MkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732818174; x=1733422974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maEchboAXGaRsP4y4IkvMG/7KoHmadrlFmb4Cbg4uYE=;
        b=FVAbMUoQ6NCYdBOtALrZisR58Bpd0+Fbc5PLBYysTx7UzB2bO31UBiXcX4e/Ymda6D
         FX+8mfSzOH0d+5uTa3cResVgAOo0BF+hi1pmX76E4i7CJ8uHh/wlMFmLCOqRsbRM3pPu
         rnux1jeiqmc8WJrw2MArQVnajiigbrGW9Mj2j+G+Lajj0a7jIrdDbRzVIJ/XqFWQ3sRJ
         TPvhNnJ7MwFQmgheDy0f9QH0xtuTMqzTRGJkRrAmbB1dUSeRUsgAdjxrgBaVl3yMuahP
         +8bI2ShllZkW6bWfOcQIPFJOAOAza8+a5q5BQWTDbE/sYCe4fpodFLB2OUS/a9Qr5cte
         M5aA==
X-Forwarded-Encrypted: i=1; AJvYcCVIXmSiqQeTqORg2/L1pc6XqYh8sEBlDJII6Q4njNcHBp1ou6LfPQmN+MBi5ADy+kUhtSA=@vger.kernel.org, AJvYcCWpdFmDIdQCW7B+H4Xrb+c5Aycqt9M2Z6OluWsTQ6vDR1p+M4w2R72DLKiJiLZ71w8/Blr1SFSG03SnUML0x3GDyuxP@vger.kernel.org, AJvYcCXSHNB9Wa1lhOg+Qulo3I84uUlJ+p/mn+APkenGyXLX0eZUuKxkUMAg2SNxw+NxGc2XYkALV+qUGwoUy1+D@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvde5P/NQZ1pkI8ZNBlPqIq2r6vvDodzYjYIMjIm0sy5q+bKjh
	0fVYSwe0e6qZMScQMMtUTKPVLV9wT1d3R1FS9ZKHzOQqkZAdc91bo7Ylm33db+KPn68J3wPjly6
	Avh+hfi2jZjoJdi0wBwZPWThcoF0=
X-Gm-Gg: ASbGncsT0vk4JjycakPuQWJLRmTkr3mQMwoRGbRxZ7qfhW7RWw5xFWKPzEWBz6BDLl6
	GKkjUO/IttMCrLczkNCFshuL8sEmEgA==
X-Google-Smtp-Source: AGHT+IFQcrLbnyRgCcLqsekhnhaN3SnuQlLNnXaFjPNbl7jpWMPnFg8Ptl0HnUnIVs70QLjwPVv76zvUlkttufPZkzY=
X-Received: by 2002:a5d:5f8f:0:b0:382:4503:728a with SMTP id
 ffacd0b85a97d-385c6ef3cd6mr7076347f8f.53.1732818173852; Thu, 28 Nov 2024
 10:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127140958.1828012-1-elver@google.com> <20241127140958.1828012-2-elver@google.com>
In-Reply-To: <20241127140958.1828012-2-elver@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Nov 2024 10:22:42 -0800
Message-ID: <CAADnVQL6yyRRUc1Xee4HOQ0QXEiqQ7M-xJ109w9aztYH4ZWHmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Refactor bpf_tracing_func_proto()
 and remove bpf_get_probe_write_proto()
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 6:10=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> With bpf_get_probe_write_proto() no longer printing a message, we can
> avoid it being a special case with its own permission check.
>
> Refactor bpf_tracing_func_proto() similar to bpf_base_func_proto() to
> have a section conditional on bpf_token_capable(CAP_SYS_ADMIN), where
> the proto for bpf_probe_write_user() is returned. Finally, remove the
> unnecessary bpf_get_probe_write_proto().
>
> This simplifies the code, and adding additional CAP_SYS_ADMIN-only
> helpers in future avoids duplicating the same CAP_SYS_ADMIN check.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v3:
> * Fix where bpf_base_func_proto() is called - it needs to be last,
>   because we may override protos (as is e.g. done for
>   BPF_FUNC_get_smp_processor_id).
>
> v2:
> * New patch.
> ---
>  kernel/trace/bpf_trace.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0ab56af2e298..9b1d1fa4c06c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -357,14 +357,6 @@ static const struct bpf_func_proto bpf_probe_write_u=
ser_proto =3D {
>         .arg3_type      =3D ARG_CONST_SIZE,
>  };
>
> -static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
> -{
> -       if (!capable(CAP_SYS_ADMIN))
> -               return NULL;
> -
> -       return &bpf_probe_write_user_proto;
> -}
> -
>  #define MAX_TRACE_PRINTK_VARARGS       3
>  #define BPF_TRACE_PRINTK_SIZE          1024
>
> @@ -1458,9 +1450,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
>                 return &bpf_perf_event_read_proto;
>         case BPF_FUNC_get_prandom_u32:
>                 return &bpf_get_prandom_u32_proto;
> -       case BPF_FUNC_probe_write_user:
> -               return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 =
?
> -                      NULL : bpf_get_probe_write_proto();
>         case BPF_FUNC_probe_read_user:
>                 return &bpf_probe_read_user_proto;
>         case BPF_FUNC_probe_read_kernel:
> @@ -1539,8 +1528,20 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>         case BPF_FUNC_trace_vprintk:
>                 return bpf_get_trace_vprintk_proto();
>         default:
> -               return bpf_base_func_proto(func_id, prog);
> +               break;
>         }
> +
> +       if (bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN)) {
> +               switch (func_id) {
> +               case BPF_FUNC_probe_write_user:
> +                       return security_locked_down(LOCKDOWN_BPF_WRITE_US=
ER) < 0 ?
> +                              NULL : &bpf_probe_write_user_proto;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       return bpf_base_func_proto(func_id, prog);

Moving bpf_base_func_proto() all the way to the top was incorrect,
but here we can move it just above this bpf_token_capable() check
and remove extra indent like:

func_proto =3D bpf_base_func_proto();
if (func_proto)
   return func_proto;
if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
   return NULL;
switch (func_id) {
case BPF_FUNC_probe_write_user:

that will align it with the style of bpf_base_func_proto().

pw-bot: cr

