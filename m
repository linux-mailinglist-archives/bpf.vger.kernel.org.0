Return-Path: <bpf+bounces-37877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0644B95BC77
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012C71C22F7C
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D01CDFB3;
	Thu, 22 Aug 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIsVYnVV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D471CDA2E
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345474; cv=none; b=Lz4SXGNXrEIXi9yVf4LM3/f4UyqgBaYKpVQ/ndtcb0cgYpFc7D0cI4b8bUuPm+p1OgSOBO436wXHWlq+1Cz9FBGpcXZr5ztnvZ0a3/nDqGGyApfod6xse4RJum7q9X375PX/N8uqfXrk/A3qXgFvX8ALc7HZE0xmewlN0LlZcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345474; c=relaxed/simple;
	bh=o45xJug2MmP7E1TxEhBT+37cvt2UJ2TH6sSSALV2np0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqHoOEeJZkqMvkhbpx4z56K6jf5r8k4gS7/jnBD7gl+SFZVhhLLpc8ynVrz5gAX5jBw1ew28q2l7mFomONjhG0zIFvnBGaVxV1MGgTlWZIM/lBuG+gav5cw3lzww0CL3tj5aunCzu+YBSJFtWZY7Ky0mbPp4dzp23SXPRhCDXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIsVYnVV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso795894a91.1
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724345473; x=1724950273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv5KbJq4B5SQSGy6wZlq9Zwb64/H14oGOYufeLUftj8=;
        b=aIsVYnVVfknioLd+oXTlK7x8saGseiznwSoHHoqtxZM5R5y/BH0vrPdbEJ/1xlCbQu
         xgXJTtHjLD4d46fJ3mYbyDZMlZqKvfDovWiKkTVEeg9VP1RnScUHhpCCKAO6S2npwYbo
         ZShWI2xi9PJ0H+Qf3xXFiOjtoKIweL0NQZd9CDVvE37BasvFJdNm843rJU/pX/pjqrlb
         4rkD9+mzsSbOak6Xo3V9DKVAc4cOa3OPrptZBPz+DWDCbZvY31Yt+McaiwjzJtnI2oD8
         DyYJx364lDEHL4qoscSsq4kKKG5y6x1MamTvwkTsoqNmUV4nGgeBPhGm5teFXgGWFKs9
         qzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345473; x=1724950273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv5KbJq4B5SQSGy6wZlq9Zwb64/H14oGOYufeLUftj8=;
        b=Fup+pZZFa7FEIxduue3vgJ+5uB2WsLsFExLh4SoaR01ECvqJiHuLVYol/trua+PzPx
         IJreE1ceqLbZVJAmcKl25/0hyyXAbqrOOJECucP66Tq1HHNSzQSB0NNlg3csqwVBYbKn
         QSvCbyLUGQRx9hp9vUeGjw/Kr3A36v5ELKoCugL8+rVTo2Qp0FAxTR8Rjpmtj4IYfV+3
         lGlA1mJceQIjOnD7UW5lC0nD3yhn4qqhksOh1igT4wcaTkhc9N6J9n6NvcyXXOk6vClB
         jp/ZFc9U+pGqPjRXJUb64HawFukPG9hLjIEM5cdjMwNe17z2fzaNK2ggvz04CGmPGt30
         j1FQ==
X-Gm-Message-State: AOJu0YzAVctaX1LFKZgfbThH+wXal2UZI3PipednKNXZ28sCPwLNGUQl
	ORdbAznuPKpgKF3QHWw5RDVzGkEivlZsDUgeu/On0A4A3yiT+7kNxjpON9zowtsWRdLwZefC3qU
	+9AZMKI4U3uvio76nnIl0VBtmle8=
X-Google-Smtp-Source: AGHT+IHKReJ83UG3bEN4a+odC44wzaH4ZUCgU8u3tpYDVTZrCteuoE+Q/ViS5U82X6n65KvH5eTzcXgCk/AP7prb4NU=
X-Received: by 2002:a17:90b:4b10:b0:2c9:61f9:a141 with SMTP id
 98e67ed59e1d1-2d5e9a74ac1mr7569601a91.16.1724345472424; Thu, 22 Aug 2024
 09:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822001837.2715909-1-eddyz87@gmail.com> <20240822001837.2715909-3-eddyz87@gmail.com>
 <CAEf4BzaVjrHSi9eh9-YP37tsH2B5n0ah3m290Y7_v6zBXrEBiw@mail.gmail.com> <b058840690d79648405839c2af767a783a41bef8.camel@gmail.com>
In-Reply-To: <b058840690d79648405839c2af767a783a41bef8.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Aug 2024 09:51:00 -0700
Message-ID: <CAEf4BzYK9JpdPonHhSARkLRbStMA94URxZ0r5fpaOg693jtLpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test for malformed
 BPF_CORE_TYPE_ID_LOCAL relocation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cnitlrt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-21 at 21:29 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > +       btf_fd =3D bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
> > > +       saved_errno =3D errno;
> > > +       if (btf_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
> > > +               printf("-------- BTF load log start --------\n");
> > > +               printf("%s", log);
> > > +               printf("-------- BTF load log end ----------\n");
> > > +       }
> > > +       if (btf_fd < 0) {
> > > +               PRINT_FAIL("bpf_btf_load() failed, errno=3D%d\n", sav=
ed_errno);
> > > +               return;
> > > +       }
> > > +
> > > +       memset(log, 0, sizeof(log));
> >
> > generally speaking there is no need to memset log buffer (maybe just a
> > first byte, to be safe)
>
> Will change.
>
> > on the other hand, just `union bpf_attr attr =3D {};` is breakage
> > waiting to happen, I'd do memset(0) on that, we did run into problems
> > with that before (I believe it was systemd)
>
> Compilers optimize out 'smth =3D {}' where 'smth' escapes?
> I mean, I will change it to memset(0), but the fact that you observed
> such behaviour is disturbing beyond limit...

compiler is not obligated to zero out padding in the struct/union, and
kernel is pretty strict about that, that's the issue. memset(0)
guarantees all the bytes are set to zero, not just those that belong
to fields

>
> I already run into gcc vs clang behaviour differences for the first
> iteration of this test where I had:
>
>     union bpf_attr {
>         .prog_type =3D ...
>     };
>
> clang did not zero out all members of the union, while gcc did.
>
> > > +       attr.prog_btf_fd =3D btf_fd;
> > > +       attr.prog_type =3D BPF_TRACE_RAW_TP;
> > > +       attr.license =3D (__u64)"GPL";
> > > +       attr.insns =3D (__u64)&insns;
> > > +       attr.insn_cnt =3D sizeof(insns) / sizeof(*insns);
> > > +       attr.log_buf =3D (__u64)log;
> > > +       attr.log_size =3D sizeof(log);
> > > +       attr.log_level =3D log_level;
> > > +       attr.func_info =3D (__u64)funcs;
> > > +       attr.func_info_cnt =3D sizeof(funcs) / sizeof(*funcs);
> > > +       attr.func_info_rec_size =3D sizeof(*funcs);
> > > +       attr.core_relos =3D (__u64)relos;
> > > +       attr.core_relo_cnt =3D sizeof(relos) / sizeof(*relos);
> > > +       attr.core_relo_rec_size =3D sizeof(*relos);
> >
> > I was wondering for a bit why you didn't just use bpf_prog_load(), and
> > it seems like it's due to core_relos fields?
>
> Yes, it is in commit message :)
>

ain't nobody got time for reading commit messages ;)

> > I don't see why we can't extend the bpf_prog_load() API to allow to
> > specify those. (would allow to avoid open-coding this whole bpf_attr
> > business, but it's fine as is as well)
>
> Maybe extend API as a followup?
> The test won't change much, just options instead of bpf_attr.

yep, follow up is good, thanks

>
> [...]
>

