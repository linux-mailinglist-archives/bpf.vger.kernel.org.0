Return-Path: <bpf+bounces-21718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B31850B47
	for <lists+bpf@lfdr.de>; Sun, 11 Feb 2024 20:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE3DB222B8
	for <lists+bpf@lfdr.de>; Sun, 11 Feb 2024 19:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C785DF17;
	Sun, 11 Feb 2024 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+ZOKog9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706933CD2
	for <bpf@vger.kernel.org>; Sun, 11 Feb 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707680588; cv=none; b=t1tkNqRxtq99m/3pczSzr0Uqoa+LN92BzeXawEGDl6kXaKCiHL878rCawVAbo2NnQ6JjT+mCqmW92ZyaKWMz5inTDQT7aRYD5UUa50a7JpIK975MbxlGJWLYFsLlDiUsfxJXYsyPK0CDCeHyhHWPo+a/I7Iz9D80BM48D7qSBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707680588; c=relaxed/simple;
	bh=Iw2CKSlvv2aDf5M9Tkf6kVh4g9QoIeazxiwaQFZi6vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=On9K2q/8O+v9hHTPJhowBg8ZtvFJ+eoMqjJY2N0HZESsGW3TiwFNaXr20dIHI+JO1KVxoRKJVqaHuaQYIUtlghfJ2bN85/YbwwsLT3OT4Ti7U1m57R4KCCs7XhgBlYxthijTdWANdK3I4MoQYRxBi3eMzSXI3ObRiHQJQcx+j/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+ZOKog9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so19985185e9.0
        for <bpf@vger.kernel.org>; Sun, 11 Feb 2024 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707680585; x=1708285385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrbHdLsyZnVflFTpvW2OBPAoWmqadRdOQdwJ6qgbNUY=;
        b=U+ZOKog9XixkhZysbIDz62rgAmhD7U9Pbn7HyEuJpDVpN1Mt33yJ2ZkjFEjix+uc5y
         30iDDCHbKfBmaCbqOjIe85raYtS0pWVXQNZRIEuP8m5koG1qCO0Q05g/V0XAVZrG67vw
         SQ2HM7PmPp3pQg4ocTinu/Odq08hfFwdzNOwN5PVoFAbve9bzn4pgLxraYErVb8nL+yx
         BOzTAwHcsUe3X5IbmMz8TxMInKYP41RmqDg64j0rVc4TIwT8I0vfuaEP1Vh2i2XBiHPi
         w5fz6T+kX/oUwqr6b8Uh6WAU/fxDYVbNojifmYKChm2A878BflUsVL19wfijRZG1SPV5
         dZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707680585; x=1708285385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrbHdLsyZnVflFTpvW2OBPAoWmqadRdOQdwJ6qgbNUY=;
        b=Fqz0UsLvtVuMLjwhtBxi4+/6xUbS3wxFfwsW+C6mOaR03dAsiAA4rCnq5eQDMK5dwf
         uBO9ptlABdziiPzHGzUMMsXgVAplBbkNrw37sBQwKCeCnLxzPRzA2n0U3Xs8pwEDS1XX
         8qH/Ndg/Sr0UoE45wgAisfORkzOBRe9yHCP8kDpCvrpJqMjSxq5+9Cx/0Ccb41hks3yG
         9vZC5HBRlQAA1HTarA+xMtZh1ypB3Nd/Xbtccg/h+dTztzCRgBv6uq5/bwkFDiVCt9SY
         aEUFXZiW/u/UJHs8zAynO0c/wrLqWQzC6OvZ9EZVQd1SI2MRD9UjQayBN7gMpFpp2pWa
         2k1g==
X-Gm-Message-State: AOJu0YwLqYfZP21fb2O+RmDQPNdDyjS3uGHKDTajdhOQzYZQSlkyXYOM
	M2yJQx7oxorGyI09wIG+3KiDWBlUf8G86LYVrBFZqc+5VBMUwvxXJCVpXsbTbECV39FPejmYCJz
	cCHR5m/oXcDzWUbM3DvO43s75WfA=
X-Google-Smtp-Source: AGHT+IGepxv9rbd5nD81DvQ9LBGVhlAogWA7rVXBndfPaNw5kmCh56Ckb7xoUyam7iLv2TTSwFVsXem4UxKkNBBkeKc=
X-Received: by 2002:a05:6000:d92:b0:33b:76bc:b395 with SMTP id
 dv18-20020a0560000d9200b0033b76bcb395mr2793965wrb.3.1707680584237; Sun, 11
 Feb 2024 11:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210003308.3374075-1-andrii@kernel.org>
In-Reply-To: <20240210003308.3374075-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 11 Feb 2024 11:42:52 -0800
Message-ID: <CAADnVQ+yvpZ=-gWtU_4w4wJ52ULZcqVRq+4E-BGNZmTjfKPYRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: emit source code file name and line number
 in verifier log
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 4:33=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> As BPF applications grow in size and complexity and are separated into
> multiple .bpf.c files that are statically linked together, it becomes
> harder and harder to match verifier's BPF assembly level output to
> original C code. While often annotated C source code is unique enough to
> be able to identify the file it belongs to, quite often this is actually
> problematic as parts of source code can be quite generic.
>
> Long story short, it is very useful to see source code file name and
> line number information along with the original C code. Verifier already
> knows this information, we just need to output it.
>
> This patch set is an initial proposal on how this can be done. No new
> flags are added and file:line information is appended at the end of
> C code:
>
>   ; <original C code> (<filename>.bpf.c:<line>)
>
> If file name has directory names in it, they are stripped away. This
> should be fine in practice as file names tend to be pretty unique with
> C code anyways, and keeping log size smaller is always good.
>
> In practice this might look something like below, where some code is
> coming from application files, while others are from libbpf's usdt.bpf.h
> header file:
>
>   ; if (STROBEMETA_READ( (strobemeta_probe.bpf.c:534)
>   5592: (79) r1 =3D *(u64 *)(r10 -56)     ; R1_w=3Dmem_or_null(id=3D1589,=
sz=3D7680) R10=3Dfp0 fp-56_w=3Dmem_or_null(id=3D1589,sz=3D7680)
>   5593: (7b) *(u64 *)(r10 -56) =3D r1     ; R1_w=3Dmem_or_null(id=3D1589,=
sz=3D7680) R10=3Dfp0 fp-56_w=3Dmem_or_null(id=3D1589,sz=3D7680)
>   5594: (79) r3 =3D *(u64 *)(r10 -8)      ; R3_w=3Dscalar() R10=3Dfp0 fp-=
8=3Dmmmmmmmm
>
>   ...
>
>   170: (71) r1 =3D *(u8 *)(r8 +15)        ; frame1: R1_w=3Dscalar(smin=3D=
smin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff)) R8_w=
=3Dmap_value(map=3D__bpf_usdt_spec,ks=3D4,vs=3D208)
>   171: (67) r1 <<=3D 56                   ; frame1: R1_w=3Dscalar(smax=3D=
0x7f00000000000000,umax=3D0xff00000000000000,smin32=3D0,smax32=3Dumax32=3D0=
,var_off=3D(0x0; 0xff00000000000000))
>   172: (c7) r1 s>>=3D 56                  ; frame1: R1_w=3Dscalar(smin=3D=
smin32=3D-128,smax=3Dsmax32=3D127)
>   ; val <<=3D arg_spec->arg_bitshift; (usdt.bpf.h:183)
>   173: (67) r1 <<=3D 32                   ; frame1: R1_w=3Dscalar(smax=3D=
0x7f00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_o=
ff=3D(0x0; 0xffffffff00000000))
>   174: (77) r1 >>=3D 32                   ; frame1: R1_w=3Dscalar(smin=3D=
0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>   175: (79) r2 =3D *(u64 *)(r10 -8)       ; frame1: R2_w=3Dscalar() R10=
=3Dfp0 fp-8=3Dmmmmmmmm
>   176: (6f) r2 <<=3D r1                   ; frame1: R1_w=3Dscalar(smin=3D=
0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R2_w=3Dscalar()
>   177: (7b) *(u64 *)(r10 -8) =3D r2       ; frame1: R2_w=3Dscalar(id=3D61=
) R10=3Dfp0 fp-8_w=3Dscalar(id=3D61)
>   ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
>   178: (bf) r3 =3D r2                     ; frame1: R2_w=3Dscalar(id=3D61=
) R3_w=3Dscalar(id=3D61)
>   179: (7f) r3 >>=3D r1                   ; frame1: R1_w=3Dscalar(smin=3D=
0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R3_w=3Dscalar()
>   ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
>   180: (71) r4 =3D *(u8 *)(r8 +14)
>   181: safe
>
> I've played with few different formats and none stood out as
> particularly better than other. Suggestions and votes are appreciated:
>
>   a) ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
>   b) ; if (arg_spec->arg_signed) [usdt.bpf.h:184]
>   c) ; [usdt.bpf.h:184] if (arg_spec->arg_signed)
>   d) ; (usdt.bpf.h:184) if (arg_spec->arg_signed)

Great idea.
I would drop parenthesis. Don't see a reason to wrap a text.
Since we already use ';' as a comment I would continue:

e) ; if (arg_spec->arg_signed) ; usdt.bpf.h:184

Note that that fragile test needs to be adjusted again:
Error: #137/3 log_fixup/bad_core_relo_trunc_full

pw-bot: cr

