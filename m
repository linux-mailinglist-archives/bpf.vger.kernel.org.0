Return-Path: <bpf+bounces-70063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F9BAEA1F
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 23:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 623D87A1387
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 21:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E251119D087;
	Tue, 30 Sep 2025 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWs5CVnd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374516132F
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268935; cv=none; b=I1AxIF9bteWgZlE5pFZIk3mgKjv9Cg3DdM/VAA9wAcgLZtapHNRg9fCdv6xTeKos7dmGTOdEnjObW6GceN9J7+qeJE+xUYDlOogFZrGs+d196ApA/WmQjJChJ1d6HNuYuz3EaHvB0qD6P1vsPbUe9CqSIGJ3eUhk5MYuPc8Hz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268935; c=relaxed/simple;
	bh=GEHluQiE0bq1sqBOr/jIOS3GWqS2lnKfKhNZ6Pn+Dl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+Wu6NBwcoYCC2EJ07prkT92pe9zTuTzlo+qLltJXrShgJj1u3TBpGtc02jg8MU1ym8dop1jKP3aVwR96RbJ2WOjNTIHtiizx4RpxHyS5OVDMnOva2c8Ho14U2MMN4vpwi2LYtipDd7jVOD3hiLPIgNR3J26ZIFH+nf1UM+vQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWs5CVnd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso6351357a91.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759268933; x=1759873733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiuCZ8J2LOb9mc1h8YM6VbvszA18OMNaNkAGL17qwgo=;
        b=jWs5CVndHufNaYtc3CFnDfhCJzp8wuifxIVK7iwB+/DIpOQG25Qa6YkS1Z7cO6oRdq
         TLaYIQY3c8alenEDCQp8HD3seRK1wVggt7b3HXeKBqEmh4N3QGysJuS8UtGZeDaTYPu3
         AfOdUUavqfjLM/zya/sJ7hab3WIUL6h+rhoaNycwfbwFANgYoi8jkV5N98EOrVzFtII8
         O/A73nlG16iQdGJDb7VQayFewv5hZl1b4fI+2NoKJhdO3M4BE/xAFvlIUvcsKGMNgnKv
         QeG9NLWsLl2XTmQTfJ4028XkcHL8MVpsBLFSrDuxV1uAQTbAZhMb053qBDR2lBdbvhdS
         t6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759268933; x=1759873733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiuCZ8J2LOb9mc1h8YM6VbvszA18OMNaNkAGL17qwgo=;
        b=pjDfE9qMoHVVa+R3ZUCRH3EtDbmQSQCzKQHUcaHlWNqi2sPKV6yO/0X6hhaL21T/E4
         qM+UgeZxWu4fJ8NVsRXiPIlp/1RWhP9jlWibja/Q14ZQf7ViwKma6W+5vp3Zyz7EgS2k
         fisMA1h/bNeWt0Xrhqryt1GAYffQexOAxu9v6m52j3gVGbFoDQNtsbP0wDWWHzNVzDwJ
         80Bs2cF8Afkpp9Ggqr4i5nBEla3bLfJsDmtCm9hvYLodFQo3Zrpuhce0BQC0hVY8zBDH
         c5DbUaKzypaINdUkRL153Pcd5HtKGu8zPlmRj0pXYWrFn/RXF0aj93lFKi+l0GbzBVBz
         //XQ==
X-Gm-Message-State: AOJu0Yy4HqeYBqYbEM5LQ0sWm9QutdTevSjWn4muLQuApEHUpWXEjiXS
	SgolLHBvuZaMYmGZTh9NBMoX/6NpLYcHCu4Qivs6iV3SUnlNhkrh2Y4vMa3F0f2Npm2UuRJCcXr
	tx9DsOPKKJGHdEHsfndkDTEoKQzcjHXupNWFe
X-Gm-Gg: ASbGnctEiXGnu0zK+WaJlqqsTs6t6Tec7GMDaAB9++EtLPkU93RlihWzbKnSwHP3t8r
	kOOcxpAu9XCIUT3KWEk3Qmmq1SLl7a3nTOiwjfkPs0uUt1xY6jsqrlgvuwFOpfwFIVp2V2ZDmc2
	2JjHPo0X7CfbNX+UDUuS/K8XA6K8qQPZdgYnxtIUN84lCvRG/2eAqLgucX/AtDfdn13UZpvVnXt
	6qRa7xu07lp8elZ4SDq1XRk0L0qOqHJ+f2HZ/1A6B39qoc=
X-Google-Smtp-Source: AGHT+IFS+JR844b57BEve7hybLWwLxbJyROL/yVHoPGcN+Q+mnqMhrX6GovsYctgw7H7Zf9VicSaMYQBSvL2vaL3V6M=
X-Received: by 2002:a17:90b:1b03:b0:32e:8931:b59c with SMTP id
 98e67ed59e1d1-339a6f35b48mr841234a91.27.1759268933070; Tue, 30 Sep 2025
 14:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930212619.1645410-1-andrii@kernel.org> <20250930212619.1645410-6-andrii@kernel.org>
 <CAEf4BzZcX-H710BYjjRuAcu+ROHN+a+HDZCgGkMa3AZaC5sqpg@mail.gmail.com>
In-Reply-To: <CAEf4BzZcX-H710BYjjRuAcu+ROHN+a+HDZCgGkMa3AZaC5sqpg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Sep 2025 14:48:38 -0700
X-Gm-Features: AS18NWA6qQr8TJz0QHLJ1b-w8oWMajQlMcyIN3l5kva_yMWKJlyXW-55dHPDkKA
Message-ID: <CAEf4BzajJpRQ6KqEaAET6meTRYr8KuuJOsKKC9rS_g2jrERSCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] libbpf: remove linux/unaligned.h dependency
 for libbpf_sha256()
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:38=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 30, 2025 at 2:26=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > linux/unaligned.h include dependency is causing issues for libbpf's
> > Github mirror due to {get,put}_unaligned_be32() usage.
> >
> > So get rid of it by implementing custom variants of those macros that
> > will work both in kernel repo and in Github mirror repo.
> >
> > Also fix switch from round_up() to roundup(), as the former is not
> > available in Github mirror (and is just a subtle more specific variant
> > of roundup() anyways).
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf_utils.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.=
c
> > index f8290a0b3aaf..4189504fae75 100644
> > --- a/tools/lib/bpf/libbpf_utils.c
> > +++ b/tools/lib/bpf/libbpf_utils.c
> > @@ -13,7 +13,6 @@
> >  #include <errno.h>
> >  #include <inttypes.h>
> >  #include <linux/kernel.h>
> > -#include <linux/unaligned.h>
> >
> >  #include "libbpf.h"
> >  #include "libbpf_internal.h"
> > @@ -149,6 +148,14 @@ const char *libbpf_errstr(int err)
> >         }
> >  }
> >
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wpacked"
> > +struct __packed_u32 { __u32 __val; } __attribute__((packed));
> > +#pragma GCC diagnostic pop
> > +
> > +#define get_unaligned_be32(p) (((struct __packed_u32 *)(p))->__val)
> > +#define put_unaligned_be32(v, p) do { ((struct __packed_u32 *)(p))->__=
val =3D (v); } while (0)
>
> doh, obviously these miss be32 conversions, will fix in v2. But let's
> see if AI catches this.

It did, very nice ([0]):

  Can these custom macros produce incorrect results on little-endian system=
s?
  The original kernel get_unaligned_be32() uses be32_to_cpu() to convert fr=
om
  big-endian to CPU byte order, but this implementation appears to skip the
  endianness conversion entirely.

  Since libbpf_sha256() processes data in big-endian format per the SHA256
  specification, won't this cause incorrect hash computation on little-endi=
an
  architectures where most libbpf users run?


  [0] https://github.com/kernel-patches/bpf/pull/9901#issuecomment-33538963=
00

>
> > +
> >  #define SHA256_BLOCK_LENGTH 64
> >  #define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
> >  #define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
> > @@ -232,7 +239,7 @@ void libbpf_sha256(const void *data, size_t len, __=
u8 out[SHA256_DIGEST_LENGTH])
> >
> >         memcpy(final_data, data + len - final_len, final_len);
> >         final_data[final_len] =3D 0x80;
> > -       final_len =3D round_up(final_len + 9, SHA256_BLOCK_LENGTH);
> > +       final_len =3D roundup(final_len + 9, SHA256_BLOCK_LENGTH);
> >         memcpy(&final_data[final_len - 8], &bitcount, 8);
> >
> >         sha256_blocks(state, final_data, final_len / SHA256_BLOCK_LENGT=
H);
> > --
> > 2.47.3
> >

