Return-Path: <bpf+bounces-18812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4F4822354
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF971F231ED
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC3168A8;
	Tue,  2 Jan 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvpDOW5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E403168A9
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d899205c7so15987875e9.2
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 13:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704231962; x=1704836762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEPBRZZ5qNyDneIr4bEy8RPz8SxNDLuj+T7t+bdwwCs=;
        b=OvpDOW5mykDhS+pTFUXnjovvJ5pTxird3vLLdbiV4saR75IaGZRTtK18cugyjsquZV
         hI/VmiLXdn5zbIRH0uWpyLQIwhs9mBumvk9ooW4/Kz+GmOgelke+H7cnVQNA+d6dF7J+
         4ClDSrC4wVJr0aX5fQwimomb3eZ3iW9m3DwRxXjCvq1mbrGuabB6H1E6P94/OZB3DVDX
         FAbr4HS6NpJ14ZVBnUy8wjfYU5GX8R0nMkHDwlKYg7Rck3z85PzJFgkRe9GkPu3PXhjS
         RGhSlUwdbT7aqFKdfgJl67EKpIJuzcc2eUELpqN+s18iLxs5kmYsCVlS/RtKHcgw7vse
         f4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704231962; x=1704836762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEPBRZZ5qNyDneIr4bEy8RPz8SxNDLuj+T7t+bdwwCs=;
        b=UzcFxfVh9MZLYdnJqEzaEG1tDKW+ulMVkH0QYALuFznrDh27bQapWZbsjXXIc1l7EE
         zy4qNQUwUFJcQRXdt15qtk0QLt44wvlE8U8ha+DBoIKXj/bHYdnyCwYLYDSHONhZ0ivh
         s7HqY9D3xIh8FLWBs29AAT/STyZN6iNQD7S+mPTEZK8e4rJv6KxwsDWsKGuFFANsCYqm
         PGtpNAL3O05J+qLnEN9kur7vFrUdWAwRfqLu9n6qsqYb0kF5bMMHhreumVf1FDUSO5rk
         npyic9a9u8NZmf76icw13teJuHIxcSOqAe9Jbdp3LYK1YCIW2MYxRsPXWHznZQD9eIaC
         NESQ==
X-Gm-Message-State: AOJu0YyzHA0pP3wtZgcfp4v3DtIfT3iIcgqhthX47kUmMyxPylAMkhzs
	KmEw069E62T/MEbN1bk1U/t2GkfZ2ov3lhDGFb/x+HdH
X-Google-Smtp-Source: AGHT+IFbMeuts+keWFu9Rb3jePt2mM6n5qOum4HVcjSwSwdpHsFKs7bLGy6u0T0tpsK8dg6/aLDizCAPGeIRN02/npE=
X-Received: by 2002:a05:600c:4f43:b0:40d:8590:a310 with SMTP id
 m3-20020a05600c4f4300b0040d8590a310mr2309404wmq.88.1704231962153; Tue, 02 Jan
 2024 13:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
In-Reply-To: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 13:45:49 -0800
Message-ID: <CAEf4BzbowzKU+8tZTSnxPTG-x-2ypT-EshZxS+G+c3DeLtsA0w@mail.gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 5:31=E2=80=AFPM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> I have a relatively complex program that fails to load on 6.5.6 with a
>
> if (data + 98 !=3D data_end) return TC_ACT_SHOT;
>

How realistic is such code in practice? Is there a situation in which
it's critical to ensure that the packet has exactly X bytes in [data,
data_end) range? Even in that case we can have data in frags, though,
right? So I'm just wondering if we are discussing some rather
theoretical situation?

> check, that loads fine if I change the above !=3D to (a you would think
> weaker) > check.
>
> It's not important, hit this while debugging, and I don't know if the
> cause is the verifier treating !=3D differently than > or the compiler
> optimizing !=3D somehow... but my gut feeling is on the former: some
> verifier logic special cases > without doing something similar for the
> stronger !=3D comparison.
>
> ...
> 453: (85) call bpf_trace_printk#6     ; R0_w=3Dscalar()
> ; if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> 454: (bf) r1 =3D r6                     ; R1_w=3Dpkt(off=3D0,r=3D42,imm=
=3D0)
> R6=3Dpkt(off=3D0,r=3D42,imm=3D0)
> 455: (07) r1 +=3D 98                    ; R1_w=3Dpkt(off=3D98,r=3D42,imm=
=3D0)
> ; if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> 456: (5d) if r1 !=3D r9 goto pc-23      ; R1_w=3Dpkt(off=3D98,r=3D42,imm=
=3D0)
> R9=3Dpkt_end(off=3D0,imm=3D0)
> *** IMHO here r=3D42 should be bumped to 98 ***
> 457: (bf) r3 =3D r6                     ; R3_w=3Dpkt(off=3D0,r=3D42,imm=
=3D0)
> R6=3Dpkt(off=3D0,r=3D42,imm=3D0)
> 458: (07) r3 +=3D 34                    ; R3_w=3Dpkt(off=3D34,r=3D42,imm=
=3D0)
> ; uint64_t cs =3D bpf_csum_diff(NULL, 0, data + 14 + 20, 98 - 14 - 20, 0x=
FFFF);
> 459: (b7) r1 =3D 0                      ; R1_w=3D0
> 460: (b7) r2 =3D 0                      ; R2_w=3D0
> 461: (b7) r4 =3D 64                     ; R4_w=3D64
> 462: (b7) r5 =3D 65535                  ; R5_w=3D65535
> 463: (85) call bpf_csum_diff#28
> invalid access to packet, off=3D34 size=3D64, R3(id=3D0,off=3D34,r=3D42)
> R3 offset is outside of the packet
>
> Side note: bpf_csum_diff() is super non user-friendly, but that's for
> another thread...
>
> Happy New Year,
> Maciej
>

