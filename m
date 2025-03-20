Return-Path: <bpf+bounces-54502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302EA6B136
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 23:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B749487A6A
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0341F21D3FB;
	Thu, 20 Mar 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlSyShOY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AFB21B9D5
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510715; cv=none; b=VSZGBxQT0RbQKfRj2ikXp+65OF1mzDeXQfQ4BWzW9uwlIW15tJ5ZWw6OaHw2K1JKNKbeEwMkatgiGSbWp/f+UZgwnj9wsZDD1459AC4NXEe9doAr9DBUIbea9+P7KYCXUsHEa/IjH7ZtmXi/CYPmSdrCMsrqbwIKfooyqTw/5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510715; c=relaxed/simple;
	bh=KozVLkDaZHvZhX5aEySS/3DEvUL5IzqE90xYQgsFTqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIXayNjmFvQXMksOIDqryInBbveQcdKzX6f9AmGhjcsGloKV5sZF1MUwgtTX53ezedFAQwiL7WSxumUVWtmdKLj4bujR/kBXcAadYfY8kkkFiuGppbz8kT7OQUOP+AKbFHUfoOcU9sVD6Q9uY9BHnUj4lwMgP7MAhsz2aA1gzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlSyShOY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so1823876a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742510713; x=1743115513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nv8dvRWi6/U83DbcOJL00P16MANo95AghR2yR2lU31Y=;
        b=LlSyShOY48WS0p5R1nDlSSk7+qU81sO4xyEHZqygRyYROSSgdfhrRWzKXrd1qmjhsB
         xYeuhs3VCUSMsdWBxpCmCxs1uk6dN7y98Gqg23DVwl6fDj6M1PR5jLt4LDd+FbcL4oNN
         TvVLYsxWQYXqMZuBfAE4PbU6oSP2cDR+iU8tEvztegIXoxSGiNyCbkWb/5uYu+Mnnvfc
         lnrSLpgtGsKrV5iJK+zYEWpiTjGp4RJvnw37/mzz4gswQWiY9C3UAJB44ZhLqlzadh7G
         ETCD7gw6OpaGTc9l3BcwFn88ZU6ssEy5WrESr1MVxa/fCItFLitrnxKvmuYmkk8MtX2M
         ES5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510713; x=1743115513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nv8dvRWi6/U83DbcOJL00P16MANo95AghR2yR2lU31Y=;
        b=iWo7/dBjEW79G4YEnwmlc+YUEEtQR9XBrSDpZmKna1fKgOytv8DgVdcSIXz9KXsfEG
         /xwBK5i2SHnEKt/A7dG3r0wHvEW6MIulCApmdVhaGakS825xa6tGHax1vryDzjW/UHhA
         2CJwp19JMabxGxCeebKW3wpENtGrTxWw3QhtA/DMhKe8KfPQ6duF5766dL0hljNV9+K/
         QJDFr+uUTuyO+Tlhjq1dPOK6GVDmos5cEEydBvGAiZoExCA+jWcCYWJzyTr0rNyMxV74
         IVKPP7f16SsEDU/uJYkq/a9EohvX6ez6m4SsiLywyufhk22E7SangeLTsCAvVeL10X+p
         n6/A==
X-Gm-Message-State: AOJu0YxdxHDtMYc4x5Xx/DwTFSisboQsygv/X1R4PnRybE/xqMrrDn/U
	MtXlaxVp7GfBDnZD3Yl/omlwCJAMt8murjmOY1+YymjmLS6CgRyLD/odCMO7fUB/QE1fxWKZEkb
	N0Xf2ovDOtcufi2LYpNWai4l53mY=
X-Gm-Gg: ASbGncse/DGLAFucVGIbO1Mv1ugWxhGo1ua6H9kjHXTEtxRUimnAdjxpXGDJj6Abc+H
	H/spumoihypFZEToNqJY4r4coyiznn0mn4FgXg2dCniUUN/0itUmTuMbpaSEREKZOrqOAuh5WZd
	U2btk24tZp5wPSAFdEqnAbLyVHfij9ggCL/0+2RMo2Cap9QR9lul0f
X-Google-Smtp-Source: AGHT+IHb+ShTQ/tBi8eIm1y0PZXzchjTFMjlcygEECaBSpyfb0mceH9I7s9yFd+3J9XJlWnsYuJqTrWxM2PcWLGyiXw=
X-Received: by 2002:a17:90b:38cb:b0:2fe:b907:3b05 with SMTP id
 98e67ed59e1d1-3030ff0d9f3mr1079356a91.29.1742510713073; Thu, 20 Mar 2025
 15:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320214058.2946857-1-ameryhung@gmail.com> <20250320214058.2946857-2-ameryhung@gmail.com>
In-Reply-To: <20250320214058.2946857-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Mar 2025 15:45:01 -0700
X-Gm-Features: AQ5f1Jpf5ks6YOTuckrNnxjWSiijOvSRE2XYHKFkIZMTjoC9dQpibb73OipAXN8
Message-ID: <CAEf4Bza-WiBjEEhtk-kXCjrkP_d5_-mGpezqm6_S+qiuDoEc1g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] bpf: Allow creating dynptr from uptr
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 2:41=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Currently, bpf_dynptr_from_mem() only allows creating dynptr from local
> memory of reg type PTR_TO_MAP_VALUE, specifically ringbuf. This patch
> futher supports PTR_TO_MEM as a valid source of data.
>
> For a reg to be PTR_TO_MEM in the verifier:
>  - read map value with special field BPF_UPTR
>  - ld_imm64 kfunc (MEM_RDONLY)
>  - ld_imm64 other non-struct ksyms (MEM_RDONLY)
>  - return from helper with RET_PTR_TO_MEM: ringbuf_reserve (MEM_RINGBUF)
>    and dynptr_from_data
>  - return from helper with RET_PTR_TO_MEM_OR_BTF_ID: this_cpu_ptr,
>    per_cpu_ptr and the return type is not struct (both MEM_RDONLY)
>  - return from special kfunc: dynptr_slice (MEM_RDONLY), dynptr_slice_rdw=
r
>  - return from non-special kfunc that returns non-struct pointer:
>    hid_bpf_get_data
>
> Since this patch only allows PTR_TO_MEM without any flags, so only uptr,
> global subprog argument, non-special kfunc that returns non-struct ptr,
> return of bpf_dynptr_slice_rdwr() and bpf_dynptr_data() will be allowed
> additionally.
>
> The last two will allow creating dynptr from dynptr data. Will they creat=
e
> any problem?

Yes, I think so. You need to make sure that dynptr you created from
that PTR_TO_MEM is invalidated if that memory "goes away". E.g., for
ringbuf case:

void *r =3D bpf_ringbuf_reserve(..., 100);

struct dynptr d;
bpf_dynptr_from_mem(r, 100, 0, &d);

void *p =3D bpf_dynptr_data(&d, 0, 100);
if (!p) return 0; /* can't happen */

bpf_ringbuf_submit(r, 0);


*(char *)p =3D '\0'; /* bad things happen */


Do you handle that situation? With PTR_TO_MAP_VALUE "bad things" can't
happen even if value is actually deleted/reused (besides overwriting
some other element's value, which we can do without dynptrs anyways),
because that memory won't go away due to RCU and it doesn't contain
any information important for correctness (ringbuf data area does have
it).


>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/uapi/linux/bpf.h | 4 +++-
>  kernel/bpf/verifier.c    | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index beac5cdf2d2c..2b1335fa1173 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5562,7 +5562,9 @@ union bpf_attr {
>   *     Description
>   *             Get a dynptr to local memory *data*.
>   *
> - *             *data* must be a ptr to a map value.
> + *             *data* must be a ptr to valid local memory such as a map =
value, a uptr,
> + *             a null-checked non-void pointer pass to a global subprogr=
am, and allocated
> + *             memory returned by a kfunc such as hid_bpf_get_data(),
>   *             The maximum *size* supported is DYNPTR_MAX_SIZE.
>   *             *flags* is currently unused.
>   *     Return
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 22c4edc8695c..d22310d1642c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11307,7 +11307,8 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                 }
>                 break;
>         case BPF_FUNC_dynptr_from_mem:
> -               if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE) {
> +               if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE &&
> +                   regs[BPF_REG_1].type !=3D PTR_TO_MEM) {
>                         verbose(env, "Unsupported reg type %s for bpf_dyn=
ptr_from_mem data\n",
>                                 reg_type_str(env, regs[BPF_REG_1].type));
>                         return -EACCES;
> --
> 2.47.1
>

