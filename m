Return-Path: <bpf+bounces-14538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE37E6104
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6B92812FE
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752D374EB;
	Wed,  8 Nov 2023 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjVbSinu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E72374E1
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:23:43 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF4259F
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:23:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso46183066b.1
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 15:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699485821; x=1700090621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNDyTOfKBAdfIP52AIOHbRUdR4hjiJV2JcKLpqs5Edg=;
        b=YjVbSinuwunpCd0LVxHivl+gBc6/vFjWJl7U0kS9+qlCUIz+zPcWe+lqVXQ/un2q+i
         z8K63pZSSEvij6O7RmisOPE4UFt8zh4zf0tKoioTmQnDcOLd1FYI4HthhCbnHhHRG54W
         RHxnAGVfJAj72FzM+LiWixQ7fkU0bPF7X2WKs/kKFyMypy6Mlh6q+2O/F57vnW0R2+97
         yvu6TLw7N+TwYa3VgIfMq+6m2aqRfzNOuLCYjVF+ut2c7tutWrmA7Biy4w+YuppW0KCN
         Xj6EEZbw0naAtB3q48Q3Ft5kHUsvH+AXdXVUp4bXz3eVVZ2HWOoTSiMgVMReSdwfbGJS
         x0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699485821; x=1700090621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNDyTOfKBAdfIP52AIOHbRUdR4hjiJV2JcKLpqs5Edg=;
        b=dp5uTGAuSR5DVt5GrLebFfGCM5yJImKVmfS5msBIXuckz8H3E5rpfu5gL39kwhULxe
         M4IQUR2Ho6LyVze+Zmf33vsDQAJjn4PX+8bBI6Ij93jenIhOYbeExyv4oxjLUaLepmTt
         1vpwDN+U0NLbJBH8j9FNR0C0/s56SDko3nkc5W0eIijFeWPxRYXddv0eizBC08BeG5GH
         /j6PAw1OHQhX8RdC8ht6HLBQaYc1EPJoA4Zzj0OcM2MdcYsIpRz/wEA03I83co1QESLA
         M5N7+nv3XyMEzhFV9Ow0kooQHwDuKD6/NbRNXmKfHe/RWsSzwAsj3XLd4lkC5mjJhrft
         Zj1A==
X-Gm-Message-State: AOJu0YzY2oEmNePv6x9VhZ39JmhoqeRevOJsm4hqg6S0qNFHRGJEgSmt
	QXr0o/12EWpoF7o3qY0/6hrKz17s7ABUYdO8lrw=
X-Google-Smtp-Source: AGHT+IHY1Js48pK/KrWXXrhXsP02+mJQlZF/+6ak1QHaCjzYcg0O1hYCm9Hjn1PAEP4zUStbft4kln5E1dMvktCkHxA=
X-Received: by 2002:a17:907:7295:b0:9d5:ecf9:e6b8 with SMTP id
 dt21-20020a170907729500b009d5ecf9e6b8mr3123522ejc.12.1699485820617; Wed, 08
 Nov 2023 15:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-11-andrii@kernel.org>
 <e89051a718d676f6f73d354774c2161dfe562faf.camel@gmail.com>
In-Reply-To: <e89051a718d676f6f73d354774c2161dfe562faf.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 Nov 2023 15:23:29 -0800
Message-ID: <CAEf4BzacVodTEQX5S2nFd2Ndet-wU0JeNs9ZF54R=J+FOHRVmA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/23] selftests/bpf: BPF register range
 bounds tester
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> > On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
>
> I read through whole program and it seems to be a good specimen of an
> idiomatic C program. Aside from two nitpicks below I can't really complai=
n
> about the code.
>
> On the other hand, I'm a bit at odds with the core idea.
> The algorithm for ranges computation repeats the one used in kernel
> (arguably in a bit more elegant way). So, effectively we check if two
> implementations of the same algorithm end up with the same answers.

Yes, that was the point. It's a way to cross-check a delicate and
complicated logic that is very hard to cover through manual tests. So
generated testing seemed like a better approach, for which we have to
have an alternative implementation.

Note also that it's not really just a reimplementation. While the core
idea is the same, how we get there is quite different. Kernel
implementation doesn't have any notion of casting ranges. It also
employs and keeps in sync tnum, which selftests implementation doesn't
do.

So while they do strive to implement the same behavior, they do it in
quite a different way.

>
> It is a maintenance burden in a way.

It's unlikely to need changes, so I hope it won't be. But it's also
good to have as a cross-check for future work, like Shung-Hsi Yu's
attempt to make range tracking sign-agnostic.

If this becomes a burden to maintain, it's simple to remove the
selftest. But given it's written and debugged, it adds value and makes
verifier changes a bit less scary.

> What are the benefits of such approach?
> Simpler userspace prototyping for new range tracking features?
>
> [...]
>
> > +__printf(2, 3)
> > +static inline void snappendf(struct strbuf *s, const char *fmt, ...)
> > +{
> > +     va_list args;
> > +
> > +     va_start(args, fmt);
> > +     s->pos +=3D vsnprintf(s->buf + s->pos, s->buf_sz - s->pos, fmt, a=
rgs);
> > +     va_end(args);
> > +}
>
> The manpage for vsnprintf says the following about it's return value:
>
>   ... If the output was truncated due to this limit, then the return
>   value is the number of characters (excluding the terminating null
>   byte) which would have been written to the final string if enough
>   space had been available ...
>
> Which is definitely a footgun to say the least. So, I picked strbuf,
> DEFINE_STRBUF, snappendf definitions to a separate file and tried the
> following [0]:
>
>     $ cat test.c
>     ...
>     int main(int argc, char *argv)
>     {
>       DEFINE_STRBUF(buf, 2);
>       snappendf(buf, "kinda long string...");
>       printf("buf->pos=3D%d\n", buf->pos);
>       snappendf(buf, "will this overflow buf?");
>     }
>
>     $ gcc -O0 -g test.c && valgrind -q ./a.out
>     buf->pos=3D20
>     =3D=3D27408=3D=3D Jump to the invalid address stated on the next line
>     =3D=3D27408=3D=3D    at 0x6C667265766F2073: ???
>     =3D=3D27408=3D=3D    by 0x66756220776E: ???
>     =3D=3D27408=3D=3D    by 0x401244: snappendf (test.c:24)
>     =3D=3D27408=3D=3D    by 0x10040003F: ???
>     =3D=3D27408=3D=3D    by 0x1FFEFFF837: ???
>     =3D=3D27408=3D=3D    by 0x1FFEFFF837: ???
>     =3D=3D27408=3D=3D    by 0x3C9D8E3B01CC2FB5: ???
>     =3D=3D27408=3D=3D  Address 0x6c667265766f2073 is not stack'd, malloc'=
d or (recently) free'd
>     ...
>
> [0] https://gist.github.com/eddyz87/251e5f0f676a0f954d4f604c83b4922d
>
> [...]
>

I didn't bother to bullet-proofing it given it was added for
selftests, but you are right, it's trivial to guard against this:

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index a6b972036bfa..f446432bd776 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -49,7 +49,9 @@ static inline void snappendf(struct strbuf *s, const
char *fmt, ...)
        va_list args;

        va_start(args, fmt);
-       s->pos +=3D vsnprintf(s->buf + s->pos, s->buf_sz - s->pos, fmt, arg=
s);
+       s->pos +=3D vsnprintf(s->buf + s->pos,
+                           s->pos < s->buf_sz ? s->buf_sz - s->pos : 0,
+                           fmt, args);
        va_end(args);
 }

I'll do this in the next revision.

> > +#define str_has_pfx(str, pfx) \
> > +     (strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : =
strlen(pfx)) =3D=3D 0)
>
> Nitpick: both gcc and clang optimize away strlen("foobar"),
>          __builtin_constant_p check is not necessary.

it's a copy/paste from libbpf, but good to know it's actually
optimized! I can simplify it in the selftest, no problem.

>
> [...]

