Return-Path: <bpf+bounces-58753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3106AC1543
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCFCA281F9
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003FB2BF3C0;
	Thu, 22 May 2025 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E374IYL6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3321EEA3C
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944353; cv=none; b=gzfXdKL6M2ZglTpQ5P3qG7qSvQw/GvviXmwsYnLmR4KpdWxipIizbuCGyucGZnufShtiYqZuEMh99YZadlUR/NGWvB/OK9VxVl7DfeeqWrinzAqV+SUpyCoI31tjV96QOsVFCW5XsFPjVA4qCxRJHj6VBLv+svcSmblgloWkCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944353; c=relaxed/simple;
	bh=lrCpnZI7/SB/1HL2TspgyLPhWSOOEYw2pyraRBS4yW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiQFiUskXHPwy08vZA+XkvgssqCvuU9xLvOAcM/Sjrq/X+aMGzquYZrnAdp/oO7MHLaxIZ74pP1Xrj1VzD74NfcIGo3J0mHJsGin3IvKqkhHJbh7RsJnfs7yVhMFH/ospo9NXw91dTFX8lXiZA+pr8nzQRhTL6+KeTW9EjdLsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E374IYL6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30e7bfef27dso5705766a91.0
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747944351; x=1748549151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiF78Qpn+e1RVG0stqUmSDYsvpBgCoLSPqR6fb4JLog=;
        b=E374IYL6iA703utS8Tg9X7gVawaL3XB4J1Mdux4JV9ffzf1+9NfFNXWJqagRp56uMQ
         5JhHMJGvl+tN8O0QDn1IO/EVfemLHutlrvh91MeN64PPGhF9sT0q9EPmU3XhDH6+JWLf
         COKpJJqwnhdKRNZmpQxZarBmy5zWnOEnmOvd18bUEzkU+C0FCedxXdP0ZuXyUrXFJkdG
         8d5S50a9EPRDfxrniihtoEja7EbVScC5tdMFReWKh5ebTylEWE5fgUTNsPnUXq5N5VnF
         p39ddoANVWTp7muM031hK1C0rH2pwP17cm2lsxX2BuS4ui7oUsNFZ2+UTmsKGdJ04Ufm
         xccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747944351; x=1748549151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiF78Qpn+e1RVG0stqUmSDYsvpBgCoLSPqR6fb4JLog=;
        b=L6+LIZXbjqYYlcOfm9IjM0sUFyh4dxWdnAfNaY/uydL4YrFnZWvf0+lR74g/AH9fPF
         Bw1wHmN6oleMYRbezZXdNR2OUmE6S32knvyF8qn/549nBDfYmtouJrADGigslGGKnJ02
         ZwaJlYQdkmz6vbW9u+3naJi96B64bWA+qvyRXNP9Xa0Jw9MeqrAYJFUNywRYISBMMnfd
         AEKHHKRvyLdbG294B66I9L1lDmJ/IqOgt/w7t2VeaMpgqUl0N1t7Sk+CCzQfUsNcmQcw
         j9rqrebrFrznN1G7FxUAMxmBpKv3kStKwJdDWMSx93ic8/g5kn2WxhKwSw27sOJlRzFp
         QUAw==
X-Forwarded-Encrypted: i=1; AJvYcCUFpLZwp/FTo00lYU7tHlbwCaOU+i+KLvMhUPkdMV3B/iEnfxxaUHBAVaySe2EwED1j7e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZaE6bKNrOUdxT7SOXj/dx+DJiLbO1VefSJCqSMFE/kUr41Hmr
	Fyhu/8hsQUDkB6f4Kv2x19bRbBj7lOUWcYegja0gzfXy6j7hsiJG2bcpZoUCojwLyaLCcQoicMT
	bvZxMVXXO5eN4K728RlBiDkTK6sRKMl8=
X-Gm-Gg: ASbGncvoaKwHvtseDXjS3Oc+3g1gPSgyUAqZQAlLz9ZRZIVATQbaTSWbQsoDAVssYkN
	sZoUKzjTOg11x0FVnNlVcns9aeAExBqGfLaLp5T0zO04TQoorPvCzUOHPkV/zTUylgCRCCrv0nY
	J8Qfpwd3z7JBMDm8m9B6iYSEbQx3NApqKzoNiVn1WFMotvrdFq
X-Google-Smtp-Source: AGHT+IGNqykCi+f8lAO37vWhjPm9NAiR2YUZIvA9hoDJafEz0vMMiuGOwBjLt63kuenkjkUa+sHRF061BIgAGJdbl04=
X-Received: by 2002:a17:90b:4b82:b0:2ff:7b28:a51a with SMTP id
 98e67ed59e1d1-30e8314db35mr44818213a91.17.1747944351261; Thu, 22 May 2025
 13:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
 <45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com> <2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
 <CAEf4Bzbx6xHc2LMCWpY_yQExgjauo0UaDmF4rDuFjefNvOhqRg@mail.gmail.com> <m2jz69bmui.fsf@gmail.com>
In-Reply-To: <m2jz69bmui.fsf@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 May 2025 13:05:38 -0700
X-Gm-Features: AX0GCFt8am8hvDZs9TdWyuCcUpI-xKCRaeheX-P7rbDTAozT_BRCqDPeP8Yu2g8
Message-ID: <CAEf4Bza6isw6SQWOpvFC+Of2n-sN3=t4uEo+e+hz2J2i6QdTRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register in
 precision backtracking bookkeeping
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Wed, May 21, 2025 at 1:35=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >>
> >>
> >> On 5/21/25 11:55 AM, Eduard Zingerman wrote:
> >> > [...]
> >> >
> >> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verif=
ier.h
> >> >> index 78c97e12ea4e..e73a910e4ece 100644
> >> >> --- a/include/linux/bpf_verifier.h
> >> >> +++ b/include/linux/bpf_verifier.h
> >> >> @@ -357,6 +357,10 @@ enum {
> >> >>       INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
> >> >>         INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
> >> >> +
> >> >> +    INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK *=
/
> >> >> +    INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK *=
/
> >> >
> >> > INSN_F_STACK_ACCESS can be inferred from INSN_F_DST_REG_STACK
> >> > and INSN_F_SRC_REG_STACK if insn_stack_access_flags() is adjusted
> >> > to track these flags instead. So, can be one less flag/bit.
> >>
> >> You are correct, we could have BIT(9) for both INSN_F_STACK_ACCESS and=
 INSN_F_DST_REG_STACK,
> >> and BIT(10) for INSN_F_SRC_REG_STACK. But it makes code a little bit
> >> complicated. I am okay with this if Andrii also thinks it is
> >> worthwhile to do this.
> >
> > I originally wanted to replace INSN_F_STACK_ACCESS with either
> > INSN_F_DST_REG_STACK or INSN_F_SRC_REG_STACK depending on STX/LDX. But
> > then I realized that INSN_F_STACK_ACCESS implies the use of that spi
> > mask, while xxx_REG_STACK doesn't. So it might be a bit simpler if we
> > keep them distinct, and for LDX/STX we'll set either just
> > INSN_F_STACK_ACCESS or INSN_F_STACK_ACCESS|INSN_F_xxx_REG_STACK
> > (whichever makes most sense).
> >
> > We have enough bits, so I'd probably use two new bits and keep the
> > existing STACK_ACCESS one as is. Unless Eduard thinks that this setup
> > is actually more confusing?
>
> Idk, I don't see much difference between these flags for LDX/STX or JMP.
> In both cases it's a signal PTR_TO_STACK on the left / PTR_TO_STACK on
> the right. So, having two ways to express the same thing seems a bit
> confusing to me.

The difference is that in one case we need to know (and keep track of)
stack frame index, while in others we just record the fact that
dst/src reg is a stack pointer. I'd probably start with setting both
ISNS_F_STACK_ACCESS and INSNS_F_{SRC,DST}_REG_STACK for LDX/STX
instruction for now, knowing that we can squeeze out that one extra
bit, if absolutely necessary.

>
> Defer to your best judgement.
>
> [...]

