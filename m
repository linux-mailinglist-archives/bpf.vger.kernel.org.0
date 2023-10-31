Return-Path: <bpf+bounces-13751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62F57DD709
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 21:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0CB1C20C9F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 20:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC9225AE;
	Tue, 31 Oct 2023 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn9O2Fvy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DF11195
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:26:27 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D086AE4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:26:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so1151365e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698783984; x=1699388784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV4eeezoNIUUcRFQiZcy6bO4ROD3BEDg0wmKfuX1hi8=;
        b=Tn9O2Fvy5LZJIvdo9+EOWip8c2EdWPE/aKFtyGcepYYVnJO4X5MtVab4++FjlmAjRx
         Cc/o270Df6nqxDSJ3+KpiruY7lKsG1nKe9HQIuemdFaRIDEzZkOqipYmw9l3B3ruCFvH
         EgCm71TpHUEMCUIWWNiuKX0X/D7qQnStXslhUD9Cs+5m+k0b2D+fnHBBDO6dYMdDGMiM
         23VjYJm9s6i6CImT2ccJH3W0gukz8fA5TH+FAxDq2EKhGiJkbtHT3OJ8kAXQmLCS/OE4
         OJ75Dn11eontNDqBUnQmW4InxiyRz7O/SQH8b3S0Ldv8xuOjtgTDRKaXXpJF/C8cs+Tm
         CCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698783984; x=1699388784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV4eeezoNIUUcRFQiZcy6bO4ROD3BEDg0wmKfuX1hi8=;
        b=HeZWzI7+oHF7LY24ocN2k0eSBtqVEJ76wtu5tPBGWnYwxiS7sa9DreaCEQB1ZtzNk2
         q5YtD3xOb35TPTa0pTdWeSyyarY6vdfdgcf6vbzY38Gdi3Vhotwe6X9sxGR+L7a9ZQpH
         55EhXvpJfm48FknakTMzX6uPRaqg8SKN/WIFdpAXnwG7ciZU3XoU4Fx2qLBlDC8DHiwm
         u8rDiDOI6synmB+WKM/os1iiHVq0UG2rt5EI3G2nxU8fQlrhZMxk1Va5783BinlMplPV
         ppv9BaD7ELIb5LDoS+bsZkjME8LJXvdOPabIa4vHvq0lzlThhLbhsJuIpoB08+g+bePG
         rc+Q==
X-Gm-Message-State: AOJu0YxKSDdkD6LPYNTaMBIlGD1SmJ+UL3nWLP0KDGDZJcLtkyvQjWf9
	0RSCsqRcAXrjhMrPVeJQGpzsGvr5Z7drFm9ni0I=
X-Google-Smtp-Source: AGHT+IEkesCqy1vW2AW+ZsM3v7Z6iUckqPVR5XqAYg67VJ+aTdH3WtkU8UqnpClrcnW0rmSjgcj36yWHJ1N4knOt3yo=
X-Received: by 2002:a05:6000:156d:b0:32d:a366:7073 with SMTP id
 13-20020a056000156d00b0032da3667073mr961122wrz.14.1698783984080; Tue, 31 Oct
 2023 13:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-8-andrii@kernel.org>
In-Reply-To: <20231027181346.4019398-8-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 13:26:12 -0700
Message-ID: <CAADnVQLDDVJuhFM3Q-Dith4-r5SXCemFntCbisz8SfGeSBsz5Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 07/23] bpf: improve deduction of 64-bit bounds
 from 32-bit bounds
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 11:17=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Add a few interesting cases in which we can tighten 64-bit bounds based
> on newly learnt information about 32-bit bounds. E.g., when full u64/s64
> registers are used in BPF program, and then eventually compared as
> u32/s32. The latter comparison doesn't change the value of full
> register, but it does impose new restrictions on possible lower 32 bits
> of such full registers. And we can use that to derive additional full
> register bounds information.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 47 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 38d21d0e46bd..768247e3d667 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2535,10 +2535,57 @@ static void __reg64_deduce_bounds(struct bpf_reg_=
state *reg)
>         }
>  }
>
> +static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
> +{
> +       /* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-b=
it
> +        * values on both sides of 64-bit range in hope to have tigher ra=
nge.
> +        * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
> +        * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fff=
ffff].
> +        * With this, we can substitute 1 as low 32-bits of _low_ 64-bit =
bound
> +        * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
> +        * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at=
 a
> +        * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
> +        * We just need to make sure that derived bounds we are intersect=
ing
> +        * with are well-formed ranges in respecitve s64 or u64 domain, j=
ust
> +        * like we do with similar kinds of 32-to-64 or 64-to-32 adjustme=
nts.
> +        */
> +       __u64 new_umin, new_umax;
> +       __s64 new_smin, new_smax;
> +
> +       /* u32 -> u64 tightening, it's always well-formed */
> +       new_umin =3D (reg->umin_value & ~0xffffffffULL) | reg->u32_min_va=
lue;
> +       new_umax =3D (reg->umax_value & ~0xffffffffULL) | reg->u32_max_va=
lue;
> +       reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
> +       reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
> +
> +       /* s32 -> u64 tightening, s32 should be a valid u32 range (same s=
ign) */
> +       if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
> +               new_umin =3D (reg->umin_value & ~0xffffffffULL) | (u32)re=
g->s32_min_value;
> +               new_umax =3D (reg->umax_value & ~0xffffffffULL) | (u32)re=
g->s32_max_value;
> +               reg->umin_value =3D max_t(u64, reg->umin_value, new_umin)=
;
> +               reg->umax_value =3D min_t(u64, reg->umax_value, new_umax)=
;
> +       }
> +
> +       /* u32 -> s64 tightening, u32 range embedded into s64 preserves r=
ange validity */
> +       new_smin =3D (reg->smin_value & ~0xffffffffULL) | reg->u32_min_va=
lue;
> +       new_smax =3D (reg->smax_value & ~0xffffffffULL) | reg->u32_max_va=
lue;
> +       reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
> +       reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
> +
> +       /* s32 -> s64 tightening, check that s32 range behaves as u32 ran=
ge */
> +       if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {

There is no typo in this check, right?
To make sure somebody doesn't ask this question again can we
combine the same 'if'-s into one?
In order:
u32->u64
u32->s64
if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
  s32->u64
  s32->s64
}
?
imo will be easier to follow and the same end result?

