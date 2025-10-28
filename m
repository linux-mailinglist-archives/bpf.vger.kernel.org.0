Return-Path: <bpf+bounces-72632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC6C16BDB
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEAD188ADBD
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C0A350282;
	Tue, 28 Oct 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzXd+4mN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888EB34EEEC
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682293; cv=none; b=YvavErthc99cY/Rbt6Cn5NCpAPxKt5IrmSpDKyKqUcPcpWKTioUa2VS9a8JflNwWq3yeXLiWcsA+0+h1rFvsIETiCTmaPcotnrnuP/PMeEy5N68im2yNr26CjvfJyxFOwdJkSbv70DE8p+gRW0sI4sokdOAHVt5CKQ+mVJFItXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682293; c=relaxed/simple;
	bh=K+H2nx3VbZaZKrl6dHTwBE/8RV3cqcAGfSNCfNGffdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clrWgB5iDXmYK54ez44amb6LFzgsgNG8D/hwnjf8seFJYVOlx/Tnf7uqlG4awr0+XU2Vc8mlc0tX46ibMlHLoYWMDA9w/j8SLrT3n+5N5FHtDzdpKs8kb2r577VsN+GPpscWuiZUxL1qA18y9eJktL/iLKVd0d7lHtrECi6jMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzXd+4mN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f5d497692so7816963b3a.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682291; x=1762287091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAMB+66/8RgPrQyP1peoZh6XPQRO/XAgmIL4P6A0sHQ=;
        b=VzXd+4mN+hKnaooo2noyDSmaF7E+C5bwg/R535eBfUgT13aT438VwbrbWJw2QzDR+H
         ACL9+RixQrb1/gwUQWXuYA8eDkint8VeKyiablXrPgKFjfWO32wdB4eLLb0zhUSJxNC/
         qlSlLOgXIDggSsh6vGmwjs/6GVfiGu8hl5TkQ1aJZ5QfokGrYBEUkKC0o4VZqH6SLhFh
         L2sV2LAMCAxVGzF8Iod6foY6Oq/BjTvKzZlfvuHv9S9JNBA5A3kimjyU+d+Y/aNSid7u
         yfYoMKPzRhOD42zY6SBGbt6k6S+ukAcGR7VY7MR6pQHWkP6n8lMwvCbEUA3X2d545zJ7
         pQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682291; x=1762287091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAMB+66/8RgPrQyP1peoZh6XPQRO/XAgmIL4P6A0sHQ=;
        b=EfwMWyyqQd5vcUGqVCh5i2WJhMHr0UqSsNxPuBQIGjbhNEnEEjJWuOHDtIfYs8yBkb
         QgimPWYHEDoT9mQGd5DhancVtaVQ1/TxXiQVVeinPuEWZyzUxgffyDK1UQyDyaAwCo1d
         LollUWVBC3g2kK0AAUBqOM4nOVyKONqQLyeCjFWH3dyubsoWuthXm7wRRXCmupRzf0JN
         Az2tMSIte+MKPIdjNoK0+aIrEH+QMnRXN4QQsYvDdpoyWtNB/IrBeXawMpmAaTkGRmJP
         6MAEnoC3ECofKLz1R+GBtRmpttomQv+mTUAduErsPL2F87A2/3kq4Zf9uyvMKaWtVXPa
         JSlw==
X-Forwarded-Encrypted: i=1; AJvYcCU8dWgu/KDOVbaX/LyvD4Am7HdeBzfDVaGPJ8g5F0xrID5JrSNXHVeGmt+nXbc+qsLomyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5r/IsUWtV/rBeUPftt3sVSZnVkB3eiXhBO+IQY/5sKs4nlaK
	sPUVjPI5kJXdVIsE6/EIeaPTn46yYgePU9eYsvB4slegvH7vHAqklVUURLhjVZzX8w52lPStBwV
	a1YI/7lYMF0muge5ofYXRHOPIGrW4tfU=
X-Gm-Gg: ASbGncuQnWt2tQC8GFAH+LiB5dEhCLnvVjAXcewy+1g6V+6t82D5AXTSpHtkbYqKg+T
	C1QOWB8697ItQVVuaPG4q/C03IddFXlSJ+SniNUk9ERfL23F0VBciN6JYDh1VGv+cH8mRuxmkkR
	azTzlN/2X2+pE/cXCEEIFVjvSgGkTGksUcQX4SScRIGWp1GXVTBPdtq2f0/SEs6LmUPp6XnhWGZ
	yS99BNzumDvJZqVmVeBoF6bkKiiX07xQGAP+i8AwXPm588bb6x1KgDd6wNJW4yuK7YrG0eR28el
X-Google-Smtp-Source: AGHT+IFzsBsQTAFp7umFDVo+aRmckZxX6XD1drtoFzR5noOU1iEbiYO67oU7FmFGU0Mw/mDX+kzx8HnguV+IM/uMCec=
X-Received: by 2002:a05:6a20:12c1:b0:334:8239:56dc with SMTP id
 adf61e73a8af0-3465412bf40mr283560637.56.1761682290809; Tue, 28 Oct 2025
 13:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028155709.1265445-3-alan.maguire@oracle.com>
 <478a9790d452e3ab4c846f673e7e6ed1b4cb347adfe9628d0fc71256d7f2edcc@mail.kernel.org>
 <CAEf4BzYYMyjFQMn+UKFBEK2bgFTYP=qEGg2aF_fGZif+GeMJfg@mail.gmail.com>
In-Reply-To: <CAEf4BzYYMyjFQMn+UKFBEK2bgFTYP=qEGg2aF_fGZif+GeMJfg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 13:11:16 -0700
X-Gm-Features: AWmQ_blSmpzCH8YvJvlcYUoDrT011tO-0x-TpYlvblk9PR0KU4YTnq1LOvqhfH4
Message-ID: <CAEf4BzZoqySO4Z59bYiKaG5ka+6hLhkaD7rbh8WK1Mt588NTZA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Test parsing of
 (multi-)split BTF
To: bot+bpf-ci@kernel.org
Cc: alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, acme@kernel.org, 
	ttreyer@meta.com, yonghong.song@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:01=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 28, 2025 at 9:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >
> >
> > ```
> > commit 8509f4500fb2dfaec7a383a802dffaf84995c434
> > Author: Alan Maguire <alan.maguire@oracle.com>
> >
> > selftests/bpf: Test parsing of (multi-)split BTF
> >
> > This commit adds test coverage for parsing split BTF data that has been
> > written to files. It writes raw BTF data to temporary files, parses the=
m
> > back, and compares the parsed results to the original in-memory BTF.
> >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/too=
ls/testing/selftests/bpf/prog_tests/btf_split.c
> > > index 3696fb9a0..ee1481c5f 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
> >
> > [ ... ]
> >
> > > @@ -123,6 +155,35 @@ static void __test_btf_split(bool multi)
> > >  "    int uf2;\n"
> > >  "};\n\n", "c_dump");
> > >
> > > +     /* write base, split BTFs to files and ensure parsing succeeds =
*/
> > > +     if (btf_raw_write(btf1, base_btf_file) !=3D 0)
> > > +             goto cleanup;
> > > +     if (btf_raw_write(btf2, split_btf_file) !=3D 0)
> > > +             goto cleanup;
> > > +     btf4 =3D btf__parse(base_btf_file, NULL);
> > > +     if (!ASSERT_OK_PTR(btf4, "parse_base"))
> > > +             goto cleanup;
> > > +     btf5 =3D btf__parse_split(split_btf_file, btf4);
> > > +     if (!ASSERT_OK_PTR(btf5, "parse_split"))
> > > +             goto cleanup;
> > > +     if (multi) {
> > > +             if (btf_raw_write(btf3, multisplit_btf_file) !=3D 0)
> > > +                     goto cleanup;
> > > +             btf6 =3D btf__parse_split(multisplit_btf_file, btf5);
> > > +             if (!ASSERT_OK_PTR(btf5, "parse_multisplit"))
> >                                  ^^^^^
> >
> > Should this check btf6 instead of btf5? The line above assigns to btf6,
> > but this assertion checks btf5 which was already validated earlier.
> > Following the pattern from the btf4 and btf5 checks above, it looks lik=
e
> > this should be checking the newly assigned btf6 pointer.
> >
>
> AI has a good point, I fixed it up while applying.
>
>
> Alan, while fixing this up, I noticed that __test_btf_split clean up
> path can dereference a bunch of uninitialized btfs (btf4 and btf5).
> Also, we can goto cleanup before we create
> {base,split,multisplit}_btf_file, so it would be nice if you could
> send a follow up fixing all that. Thanks!

Ok, so BPF CI noticed this as well. I ended up not pushing, please fix
the clean up path (unlink is pre-existing bug, but it doesn't cause
compiler to complain)

>
> > > +                     goto cleanup;
> > > +     } else {
> > > +             btf6 =3D btf5;
> > > +     }
> >
> > [ ... ]
> >
> >
> > ```
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > In-Reply-To-Subject: `selftests/bpf: Test parsing of (multi-)split BTF`
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/1888=
1352510

