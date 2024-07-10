Return-Path: <bpf+bounces-34465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09992DA6A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 22:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4D0B20F8E
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15B197A99;
	Wed, 10 Jul 2024 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Bb11Bm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B0DF71
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644823; cv=none; b=GzUrYU3sYZsxDARUJSHTmfR6EEug+8A8pCz8+wo2E12hFQDsev6Qe2JoV7eP05pj+9roEDUBMX4eReLSxowRztnqy5gFhN7bRUt4BBxNvVFg7GoSm8SuCnhJ62jKgxT4gRzldIy3POFSwoiUuXE066OagM6Rd6L0HveLY2TRyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644823; c=relaxed/simple;
	bh=TrVjAXkv6yit6XCjWuqmkZlnUypqi9kVtfKlEzmmj20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/idnmMW+fWJORwF1QrB/MO8F/oibNfAHwKyX/G7YLVWvjBLg5M41+UK0GkRfoyGHsUyiqZpWMEaoFxj5b87TKTiQXgadB7XXSA+WPqTzNfe1H2iy+qG9mcdq8veeerXK9lQVtEXouOM3XwIJXAjB4cfh33Q0cJ8HjfFBroEEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3Bb11Bm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77bf336171so39861666b.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720644820; x=1721249620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkK9U166sGyL2mgKNrTUkPuaSLctLnuD4jDcoEWUIFY=;
        b=T3Bb11BmMCkFzl5mkrsm4G3ds9TwGAwLJsNgN5A4ZIgoiFg8Fd2XCOL+bekIFHXT7M
         pe1iLQoF0HuuiWyLha3kIPOPUygzQrKZc7/VsCAOFYDvmZ00qPhHps5D9J2hJSNgq03d
         BA62tiSPo091L5hozXeGPRjay5bzODiKy3q+kjyDB47fKjUfmkZniKbfeH5+AXM94KxC
         mqliJp1oiqeMO4Z94ao/Lq/XvdlBbfv3Vi+87TDJvZVTO4PxBQiEOmM/8rsPDrGU+5n+
         p+yXDJyCU2JPR2S01aHpn29mk+mQzFXn1OUyIk25jNuhBCOqZN4wdkLhRrfTJw0fv22O
         h+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720644820; x=1721249620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkK9U166sGyL2mgKNrTUkPuaSLctLnuD4jDcoEWUIFY=;
        b=Lz73S3e1T2rrqhk1PDkiaymjUCCmZ2Rmp8FVHNm81Wissy5dV+P42mG6PvRFZSPsCr
         2NVytJRcpKax/ovEmbQMLjtcAIkl7gbuY4z9akMhlTDVheHqverDbtqRC2DRY+hkVrVm
         j9US5xvDGVPIKJqKks8BjsT4bj5cz1dBscUb04k/ToJ7Xa/NM3PrWUpr1c3FTVKE79dT
         g11uzm6A0hRiydiS1OvcSuXf+MeyZubqzo+u2mwyMUPcOu5lwHEgQOXn420kL0V5ck4M
         tDEELIZMTzRprLNNQYFoYM2LHQvBxC8QHWYr14NPDPZynbkOAlw/JEAEck9Q7b509eLK
         VqHA==
X-Forwarded-Encrypted: i=1; AJvYcCXmYl2XzNQ2Nw7hG+7fZxgvJvwxOOew/FWbfGJvZo6UcGIi2hd39UqqGpzAvDi2HtIpp3xH7EmfgjjPHdjB/4kIdstD
X-Gm-Message-State: AOJu0YybjHvspQuveAMbEL/gul40QKPAfBLLweX1al/vonnGMSeTuEI2
	QPA4525ygo2Ou9z0vC3t0A9cLtZ/xQ9PhjoQvXG25aZaoCwT2R8EtVNO/D5jHSiF9DW6FRDkpod
	AvwO5B52o2v14v/iA9Gt/M1mVT/w=
X-Google-Smtp-Source: AGHT+IGsaPHTAeph1lS6C7ms6qfP7x13Ux3MujW8K/UUrVmwsG+Vy5csF32yPz82/fB8aAkInrdNbV8G7zu++GxliQU=
X-Received: by 2002:a17:906:480c:b0:a77:ce4c:8c9c with SMTP id
 a640c23a62f3a-a798a291a21mr55853466b.8.1720644819430; Wed, 10 Jul 2024
 13:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709204245.3847811-1-andrii@kernel.org> <20240709204245.3847811-8-andrii@kernel.org>
 <Zo7y0O8wm0_xZ0li@tassilo>
In-Reply-To: <Zo7y0O8wm0_xZ0li@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 13:53:23 -0700
Message-ID: <CAEf4BzbNttJUw2bntQ+GWLgJDxtwmC_NNBQ4Y7j2JuN6FuYQ9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] lib/buildid: harden build ID parsing logic
 some more
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, osandov@osandov.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:45=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Tue, Jul 09, 2024 at 01:42:42PM -0700, Andrii Nakryiko wrote:
> > Harden build ID parsing logic some more, adding explicit READ_ONCE()
> > when fetching values that we then use to check correctness and various
> > note iteration invariants.
>
> Just sprinkling READ_ONCE all over doesn't necessarily fix the code.
> It is only needed for values that affect a loop or reference.

Agreed, besides `READ_ONCE(nhdr->n_type) =3D=3D BUILD_ID` and
`READ_ONCE(phdr->p_type) =3D=3D PT_NOTE`, which I added mostly just for
consistency, the rest should be indeed read once and then checked, no?
Do you see any other unnecessary READ_ONCE()s in this patch?

>
> You have to fix stuff like this
>
> static inline int parse_build_id(const void *page_addr,
>                                  unsigned char *build_id,
>                                  __u32 *size,
>                                  const void *note_start,
>                                  Elf32_Word note_size)
> {
>         /* check for overflow */
>         if (note_start < page_addr || note_start + note_size < note_start=
)
>             ^^^^^^^^^^^^^^^^^^^^^^

this has been switched to u64-based offsets in patch #1, did you take
a look at it?

>                 return -EINVAL;
>
>
> which is C undefined (at least without -fwrapv-pointer) and can easily
> be miscompiled if it isn't already.
>
> I suspect the code will need more work, especially since you're
> unwilling to consider any defense in depth measures.
>

Can you be a bit more specific about the remaining issues? I'm happy
to fix whatever can and should be fixed (after the changes I already
did in this patch set).

If by "defense in depth" you mean allowing this functionality only for
executable VMAs, then yes, I refuse to do that, as I already
explained.

> -Andi
>

