Return-Path: <bpf+bounces-18485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C680981AE24
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 05:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2027BB238F8
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEEF8C18;
	Thu, 21 Dec 2023 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi7soU6h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF88F52
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d352c826eso4983195e9.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 20:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703134277; x=1703739077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgkAt+F35s3WpUZyeENgTXn3Hxg79ppkUAEf4dETMiQ=;
        b=Bi7soU6hDQ+O0+2t6qE8W9j+vXlFBETMz2Cl8FGZPIpaaMVJhoiA0ki5VlM2ycrmWU
         DlxCvQJAMCO5ozOSiE4z9DTF6cM7Sd9UyKuxuq2eEl0lxhuRKWaKxPQm9c1q6NbyEdUx
         5d3fSCoqQTzG+zE5PxBS/4jUIVTtq8mPCeDagCgVhTCPZBUckz/FASk0kHMbZMeDvJso
         qjN39BWrMuihnkDCogOFZHUuNVJdK2LQsI7nQwV1FkFj9VEaHDjQ6ZhErODkXqtFATxv
         2nYbnJ+XPq11lgo6My5AeXL/uvZ702eDfBEkvqXRN2evYlMSDUy2EkvJU0uuS7vM7ByP
         mteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703134277; x=1703739077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgkAt+F35s3WpUZyeENgTXn3Hxg79ppkUAEf4dETMiQ=;
        b=pEY/Cp1S9rFRfwZYCI0l3di2Ya7c1RCHchHNmm79wr6jwYKBLNySn4vliixbMX/iMY
         mRput3X05hjDZs7QraLfJT3xNgP2MpHuJQhTWS6t4Tr2LXCMMxPgMPccn1cuytRwqJev
         b5sLOPwbnvJbO6gV9FQbgPHBoPChR4MQLMlLgfaaO8eNW0dZnna1/uF0U+SFFoVIT7eo
         LRsuuRl7QYRMZ9u3w6N2FaW9LH+bIJLwS6lgNus49qj4tJnXEdu730abQwqgtLBYn62O
         N0D1pZ5Je9pxvVpdz4UHa2ZUDYUgqeG+A23uEmxZ0SJBJkzARMqK37L3IWCMXbRgfO3h
         N0Mg==
X-Gm-Message-State: AOJu0YxZsl3LB/aexpP4v2inkOKG2FjFc+2rtv9+vZ14N2lr/fs84Ftl
	F7dnF/5bw//iROqOYOfgfEz/OLZkulkeE0YhTOI=
X-Google-Smtp-Source: AGHT+IHNF6pMzmCeaEcRWO3y0I5XkpMa8lzXJRHRAS2LW0IGI99z1el599af/MhOXzq1axgmf+2GB/5rDuWJhpeUXfw=
X-Received: by 2002:a05:600c:4708:b0:40d:3b17:2dbd with SMTP id
 v8-20020a05600c470800b0040d3b172dbdmr365809wmo.178.1703134276904; Wed, 20 Dec
 2023 20:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220170604.183380-1-andreimatei1@gmail.com> <20231220170604.183380-3-andreimatei1@gmail.com>
In-Reply-To: <20231220170604.183380-3-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Dec 2023 20:51:04 -0800
Message-ID: <CAEf4BzZKP6PVtQR96hkSrZS7LB=_=w9ZbpjJkAVYs8=O+yC-uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: improve error logging for zero-sized accesses
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:06=E2=80=AFAM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> This patch improves the verifier error messages for illegal zero-sized
> memory accesses. The previous patch made these messages focus on the
> register containing the size of the access, instead of focusing on the
> register containing the dereferenced pointer. This was more correct, but
> removed useful information about the pointer. This patch brings this
> information back and then some. We now have complete error messages that
> are also consistent across pointer types.
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 63 ++++++++++++++++++-
>  .../bpf/progs/verifier_helper_value_access.c  | 10 +--
>  .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
>  3 files changed, 69 insertions(+), 8 deletions(-)
>

I left a bunch of nitpicky comments. TBH, I now feel that the simple
message you added in the previous patch is probably adequate for the
error it is notifying about. Sorry for making you work on adding more
and now pushing back against it. But if others like the improved
message, then I don't feel strongly enough to argue against :)

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4409b8f2b0f3..6f333c5c47f8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7256,6 +7256,67 @@ static int check_helper_mem_access(struct bpf_veri=
fier_env *env, int regno,
>         }
>  }
>
> +/* Helper function for logging an error about an invalid attempt to perf=
orm a
> + * (possibly) zero-sized memory access. The pointer being dereferenced i=
s in
> + * register @ptr_regno, and the size of the access is in register @size_=
regno.
> + * The size register is assumed to either be a constant zero or have a z=
ero lower
> + * bound.
> + *
> + * Logs a message like:
> + * invalid zero-size read. Size comes from R2=3D0. Attempting to derefer=
ence *map_value R1: off=3D[0,4] value_size=3D48
> + */
> +static void log_zero_size_access_err(struct bpf_verifier_env *env,
> +                             int ptr_regno,
> +                             int size_regno)
> +{
> +       struct bpf_reg_state *ptr_reg =3D &cur_regs(env)[ptr_regno];
> +       struct bpf_reg_state *size_reg =3D &cur_regs(env)[size_regno];
> +       const bool size_is_const =3D tnum_is_const(size_reg->var_off);
> +       const char *ptr_type_str =3D reg_type_str(env, ptr_reg->type);
> +       /* allocate a few buffers to be used as parts of the error messag=
e */
> +       char size_range_buf[32] =3D {0}, max_size_buf[32] =3D {0}, off_bu=
f[64] =3D {0};
> +       s64 min_off, max_off;
> +
> +       if (!size_is_const) {
> +               snprintf(size_range_buf, sizeof(size_range_buf),
> +                       "[0,%lld]", size_reg->umax_value);
> +       }
> +
> +       if (tnum_is_const(ptr_reg->var_off)) {
> +               min_off =3D (s64)ptr_reg->var_off.value + ptr_reg->off;
> +               snprintf(off_buf, sizeof(off_buf), "%lld", min_off);
> +       } else {
> +               min_off =3D ptr_reg->smin_value + ptr_reg->off;
> +               max_off =3D ptr_reg->smax_value + ptr_reg->off;
> +               snprintf(off_buf, sizeof(off_buf), "[%lld,%lld]", min_off=
, max_off);
> +       }
> +

if var_off is const, smin=3D=3Dsmax (unless some unrelated bug). so I'd
just normalize this entire if/else to always be printing [%lld,%lld]
<- [smin+off, smax+off]. It's a bit more verbose for const cases, but
it feels acceptable for me.

> +       /* attempt to figure out info about the maximum offset that could=
 be allowed */
> +       switch (ptr_reg->type) {
> +       case PTR_TO_MAP_KEY:
> +               snprintf(max_size_buf, sizeof(max_size_buf), "key_size=3D=
%d", ptr_reg->map_ptr->key_size);
> +               break;
> +       case PTR_TO_MAP_VALUE:
> +               snprintf(max_size_buf, sizeof(max_size_buf), "value_size=
=3D%d", ptr_reg->map_ptr->value_size);
> +               break;
> +       case PTR_TO_PACKET:
> +       case PTR_TO_PACKET_META:
> +               snprintf(max_size_buf, sizeof(max_size_buf), "packet_size=
=3D%d", ptr_reg->range);
> +               break;
> +       case PTR_TO_MEM:
> +               snprintf(max_size_buf, sizeof(max_size_buf), "mem_size=3D=
%d", ptr_reg->mem_size);

break missing

> +       default:
> +               snprintf(max_size_buf, sizeof(max_size_buf), "max_size=3D=
N/A");
> +       }

again, subjective, but I feel like just calculating relevant memory
region size as int and then emitting generic `mem_size=3D%d` is probably
absolutely sufficient here (see example message below) and we won't
need to use yet another buffer for formatting.

> +
> +       verbose(env, "invalid %szero-size read. Size comes from R%d=3D%s.=
 "
> +               "Attempting to dereference *%s R%d: off=3D%s %s\n",

It's very subjective, and if others like it I won't insist, but the
style of this multi-sentence message just doesn't fit with the rest of
the verifier log format. Something along the lines of:

"invalid possible zero-size read of R2 bytes from R1 mem_size=3D%d"

it's simple and provides all the necessary information (what's the
actual R2 range is not relevant to this message, the important is that
zero size is possible; user should see R2 state few lines earlier in
the log where it's assigned anyways; same for R1 mem_size would help a
bit to identify what that thing is (e.g., which map it belongs to),
but again, R1 full state will be somewhere very close by, so maybe
even that is not necessary)

> +               size_is_const ? "" : "possibly ",
> +               size_regno, size_is_const ? "0" : size_range_buf,
> +               ptr_type_str, ptr_regno, off_buf, max_size_buf);
> +}
> +
> +
>  /* verify arguments to helpers or kfuncs consisting of a pointer and an =
access
>   * size.
>   *
> @@ -7298,7 +7359,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
>         }
>
>         if (reg->umin_value =3D=3D 0 && !zero_size_allowed) {
> -               verbose(env, "R%d invalid zero-sized read\n", regno);
> +               log_zero_size_access_err(env, regno-1, regno);

code style: regno - 1


>                 return -EACCES;
>         }
>

[...]

pw-bot: cr

