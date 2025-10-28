Return-Path: <bpf+bounces-72485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2EAC12B04
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 03:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D642A351D89
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7A274FC1;
	Tue, 28 Oct 2025 02:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwHicbBY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D122D4C8
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619688; cv=none; b=Vt7M5FieXL28OwV029ZcJiBIzU0VGLOBRdhJjPa5bYAHGv3cdDzByKdyVDqlMlAqbKX1pw/LIJHHyliqbojhZuyz2F1aVmt/iSJLS9KyrJhwwIXLJOZbnVWvUoGj/pmF455E8d8PZXMdFce3etY9MwnHrgC3iOElTxympBmnLCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619688; c=relaxed/simple;
	bh=w+USCM3LY9ohDzmgy14e6xR4jWwooOa9gPxWLpvQy2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXFWvWyiOotOzYE9tKQi2NDMjxARcBpvzIL54l6vXnU4u8nIhofNUh8/3vz4Vg8mG9++ptD9kihK2tqKIj+6Am1GY3pUuIlqvLZ+9p8LvSg1hYw6jInhcy4Di7qGHTpgCMisGK0QY1FPohLK+OaA074V3A2KmIiJyVJtNUsow1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwHicbBY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so5235477a91.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 19:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761619685; x=1762224485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt4TQfTwKB5E13fts+rBc3XV1AjtBFD3OMw1USrDzOk=;
        b=AwHicbBYsLKzLMbc95HDoV8PnldE/PRGf/oqq6aX2iBgRKEomnvkdsAWevwFIGbZRl
         BUNEzyQE+HkWthUKhwrIgryZmDdj1MlIOr9T7vD0LYJp/Fxsv2eXcWGo6FZpq0TXjLK5
         Lh6cnumn02Z2cwUyU9GDnQKU2LAOgZWThi0Bm7ZoveVsUzvO3mE0gC4hyb0BoV6DcwJO
         EBz8fQKTsL/bnYHNnkTpy4Yab6t2UJQDt/NBDn0lYSA1ObdDjaDQVp2hf6N3MKREs0//
         qAz7fRCKslT7eKnpiWfSpOq34/sD0O23NFgcV24gcoFR4QC74fEaCmKemJUad+LGoNR4
         z6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761619685; x=1762224485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt4TQfTwKB5E13fts+rBc3XV1AjtBFD3OMw1USrDzOk=;
        b=h9cVmAhM7RMqqnN0et7VsBdyP45wLdhITHWUoM7hS98tcOOXv6E1TjYq3PKf6ouvYr
         mqKKrMA8/Ba3JLcVhsggZfJCXIzuT0f1hAaXdJDvxr6G1xk6BuNtagU7eg/HfBRQGHmi
         qxw4UPG1U6i3eS3fj3rYqfwOd5/kkfUCsHjMvYY6dCmyBoyWkIr+yZameVvU/MsjwtJy
         +883EDlSDUrfO60G4qytbz+83ylqC+gjhYfzqonOFmBfE/7tx3Of0dkNQY+5qWWXM67K
         8zgaoDSP22G9xGXutVkkK2IlMyNpYjwrPqwoCU13dwgMxQebydEtJFVX1qYg2dwAZp7n
         YpEA==
X-Gm-Message-State: AOJu0YzVay2UTGElGnRyfofTutuBrxQSXN1V9wr1vpn1eyyXQ0J4o/Xd
	+TnzovjUOEF8CVzAKtdBKM3qeKO8dBhKU1ET+FDgswaQL8VidOw9C9hTdtiZ/sTUdJqqBlI2LX1
	rj9O+QFt+NC5CyhRSc/DF/slNy+gV2l+WaQ==
X-Gm-Gg: ASbGncuWHMamMcnQ8967xXmTcqAq/c5dCWvY7S5OLpzheFacerNPgUNHLwCUyS7kRXc
	R1dY3eKI9qAKtMXX1Z9/Fit3EDTOZCRj1ykGr7GHNO30NDPlpBQaD5+it0M9vTHFAOP8l+hWegi
	0M6odbnWAsBVvLSz/NljXAMUTNIAG29GaQ4jsYJKf27e39OsvrblSdadARG63ct1OGUR6iI3I/4
	Thg2H5US7uJFfFDGVk9kHBm5RAQLvmGBKSJx++OF+HSO7aiZMytdkt811z8
X-Google-Smtp-Source: AGHT+IHoksvZgeUosGMyGToIs9kU4CnjCQxNfwX4jL6e/9vvFSUZfsCuQ29bbkLJxFe4e5wsTYHYyEwkZbzhrWxe9dI=
X-Received: by 2002:a17:90b:3c08:b0:33e:1ed8:334d with SMTP id
 98e67ed59e1d1-34027a09e32mr2388732a91.16.1761619684841; Mon, 27 Oct 2025
 19:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018035738.4039621-1-xukuohai@huaweicloud.com> <20251018035738.4039621-2-xukuohai@huaweicloud.com>
In-Reply-To: <20251018035738.4039621-2-xukuohai@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Oct 2025 19:47:52 -0700
X-Gm-Features: AWmQ_bknZJdbbO-dNIjyRI-vSXHy6pG3q79FmoA3aU8EtGKMsB9z5kmP42gqD-I
Message-ID: <CAEf4BzZqHo0kOa1Zc-syy9GZHUhEHEK0_0zLxFFpMhSZUc2_Qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add overwrite mode for BPF ring buffer
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:04=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> When the BPF ring buffer is full, a new event cannot be recorded until on=
e
> or more old events are consumed to make enough space for it. In cases suc=
h
> as fault diagnostics, where recent events are more useful than older ones=
,
> this mechanism may lead to critical events being lost.
>
> So add overwrite mode for BPF ring buffer to address it. In this mode, th=
e
> new event overwrites the oldest event when the buffer is full.
>
> The basic idea is as follows:
>
> 1. producer_pos tracks the next position to record new event. When there
>    is enough free space, producer_pos is simply advanced by producer to
>    make space for the new event.
>
> 2. To avoid waiting for consumer when the buffer is full, a new variable,
>    overwrite_pos, is introduced for producer. It points to the oldest eve=
nt
>    committed in the buffer. It is advanced by producer to discard one or =
more
>    oldest events to make space for the new event when the buffer is full.
>
> 3. pending_pos tracks the oldest event to be committed. pending_pos is ne=
ver
>    passed by producer_pos, so multiple producers never write to the same
>    position at the same time.
>
> The following example diagrams show how it works in a 4096-byte ring buff=
er.
>
> 1. At first, {producer,overwrite,pending,consumer}_pos are all set to 0.
>
>    0       512      1024    1536     2048     2560     3072     3584     =
  4096
>    +---------------------------------------------------------------------=
--+
>    |                                                                     =
  |
>    |                                                                     =
  |
>    |                                                                     =
  |
>    +---------------------------------------------------------------------=
--+
>    ^
>    |
>    |
> producer_pos =3D 0
> overwrite_pos =3D 0
> pending_pos =3D 0
> consumer_pos =3D 0
>
> 2. Now reserve a 512-byte event A.
>
>    There is enough free space, so A is allocated at offset 0. And produce=
r_pos
>    is advanced to 512, the end of A. Since A is not submitted, the BUSY b=
it is
>    set.
>
>    0       512      1024    1536     2048     2560     3072     3584     =
  4096
>    +---------------------------------------------------------------------=
--+
>    |        |                                                            =
  |
>    |   A    |                                                            =
  |
>    | [BUSY] |                                                            =
  |
>    +---------------------------------------------------------------------=
--+
>    ^        ^
>    |        |
>    |        |
>    |    producer_pos =3D 512
>    |
> overwrite_pos =3D 0
> pending_pos =3D 0
> consumer_pos =3D 0
>
> 3. Reserve event B, size 1024.
>
>    B is allocated at offset 512 with BUSY bit set, and producer_pos is ad=
vanced
>    to the end of B.
>
>    0       512      1024    1536     2048     2560     3072     3584     =
  4096
>    +---------------------------------------------------------------------=
--+
>    |        |                 |                                          =
  |
>    |   A    |        B        |                                          =
  |
>    | [BUSY] |      [BUSY]     |                                          =
  |
>    +---------------------------------------------------------------------=
--+
>    ^                          ^
>    |                          |
>    |                          |
>    |                   producer_pos =3D 1536
>    |
> overwrite_pos =3D 0
> pending_pos =3D 0
> consumer_pos =3D 0
>
> 4. Reserve event C, size 2048.
>
>    C is allocated at offset 1536, and producer_pos is advanced to 3584.
>
>    0       512      1024    1536     2048     2560     3072     3584     =
  4096
>    +---------------------------------------------------------------------=
--+
>    |        |                 |                                   |      =
  |
>    |    A   |        B        |                 C                 |      =
  |
>    | [BUSY] |      [BUSY]     |               [BUSY]              |      =
  |
>    +---------------------------------------------------------------------=
--+
>    ^                                                              ^
>    |                                                              |
>    |                                                              |
>    |                                                    producer_pos =3D =
3584
>    |
> overwrite_pos =3D 0
> pending_pos =3D 0
> consumer_pos =3D 0
>
> 5. Submit event A.
>
>    The BUSY bit of A is cleared. B becomes the oldest event to be committ=
ed, so
>    pending_pos is advanced to 512, the start of B.
>
>    0       512      1024    1536     2048     2560     3072     3584     =
  4096
>    +---------------------------------------------------------------------=
--+
>    |        |                 |                                   |      =
  |
>    |    A   |        B        |                 C                 |      =
  |
>    |        |      [BUSY]     |               [BUSY]              |      =
  |
>    +---------------------------------------------------------------------=
--+
>    ^        ^                                                     ^
>    |        |                                                     |
>    |        |                                                     |
>    |   pending_pos =3D 512                                  producer_pos =
=3D 3584
>    |
> overwrite_pos =3D 0
> consumer_pos =3D 0
>
> 6. Submit event B.
>
>    The BUSY bit of B is cleared, and pending_pos is advanced to the start=
 of C,
>    which is now the oldest event to be committed.
>
>    0       512      1024    1536     2048     2560     3072     3584     =
  4096
>    +---------------------------------------------------------------------=
--+
>    |        |                 |                                   |      =
  |
>    |    A   |        B        |                 C                 |      =
  |
>    |        |                 |               [BUSY]              |      =
  |
>    +---------------------------------------------------------------------=
--+
>    ^                          ^                                   ^
>    |                          |                                   |
>    |                          |                                   |
>    |                     pending_pos =3D 1536               producer_pos =
=3D 3584
>    |
> overwrite_pos =3D 0
> consumer_pos =3D 0
>
> 7. Reserve event D, size 1536 (3 * 512).
>
>    There are 2048 bytes not being written between producer_pos (currently=
 3584)
>    and pending_pos, so D is allocated at offset 3584, and producer_pos is=
 advanced
>    by 1536 (from 3584 to 5120).
>
>    Since event D will overwrite all bytes of event A and the first 512 by=
tes of
>    event B, overwrite_pos is advanced to the start of event C, the oldest=
 event
>    that is not overwritten.
>
>    0       512      1024    1536     2048     2560     3072     3584     =
  4096
>    +---------------------------------------------------------------------=
--+
>    |                 |        |                                   |      =
  |
>    |      D End      |        |                 C                 | D Beg=
in|
>    |      [BUSY]     |        |               [BUSY]              | [BUSY=
] |
>    +---------------------------------------------------------------------=
--+
>    ^                 ^        ^
>    |                 |        |
>    |                 |   pending_pos =3D 1536
>    |                 |   overwrite_pos =3D 1536
>    |                 |
>    |             producer_pos=3D5120
>    |
> consumer_pos =3D 0
>
> 8. Reserve event E, size 1024.
>
>    Although there are 512 bytes not being written between producer_pos an=
d
>    pending_pos, E cannot be reserved, as it would overwrite the first 512
>    bytes of event C, which is still being written.
>
> 9. Submit event C and D.
>
>    pending_pos is advanced to the end of D.
>
>    0       512      1024    1536     2048     2560     3072     3584     =
  4096
>    +---------------------------------------------------------------------=
--+
>    |                 |        |                                   |      =
  |
>    |      D End      |        |                 C                 | D Beg=
in|
>    |                 |        |                                   |      =
  |
>    +---------------------------------------------------------------------=
--+
>    ^                 ^        ^
>    |                 |        |
>    |                 |   overwrite_pos =3D 1536
>    |                 |
>    |             producer_pos=3D5120
>    |             pending_pos=3D5120
>    |
> consumer_pos =3D 0
>
> The performance data for overwrite mode will be provided in a follow-up
> patch that adds overwrite-mode benchmarks.
>
> A sample of performance data for non-overwrite mode, collected on an x86_=
64
> CPU and an arm64 CPU, before and after this patch, is shown below. As we =
can
> see, no obvious performance regression occurs.
>
> - x86_64 (AMD EPYC 9654)
>
> Before:
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rb-libbpf nr_prod 1  11.623 =C2=B1 0.027M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 2  15.812 =C2=B1 0.014M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 3  7.871 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 4  6.703 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 8  2.896 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 12 2.054 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 16 1.864 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 20 1.580 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 24 1.484 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 28 1.369 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 32 1.316 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 36 1.272 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 40 1.239 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 44 1.226 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 48 1.213 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 52 1.193 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
>
> After:
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rb-libbpf nr_prod 1  11.845 =C2=B1 0.036M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 2  15.889 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 3  8.155 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 4  6.708 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 8  2.918 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 12 2.065 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 16 1.870 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 20 1.582 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 24 1.482 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 28 1.372 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 32 1.323 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 36 1.264 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 40 1.236 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 44 1.209 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 48 1.189 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 52 1.165 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
>
> - arm64 (HiSilicon Kunpeng 920)
>
> Before:
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rb-libbpf nr_prod 1  11.310 =C2=B1 0.623M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 2  9.947 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 3  6.634 =C2=B1 0.011M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 4  4.502 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 8  3.888 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 12 3.372 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 16 3.189 =C2=B1 0.010M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 20 2.998 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 24 3.086 =C2=B1 0.018M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 28 2.845 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 32 2.815 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 36 2.771 =C2=B1 0.009M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 40 2.814 =C2=B1 0.011M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 44 2.752 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 48 2.695 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 52 2.710 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
>
> After:
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rb-libbpf nr_prod 1  11.283 =C2=B1 0.550M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 2  9.993 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 3  6.898 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 4  5.257 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 8  3.830 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 12 3.528 =C2=B1 0.013M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 16 3.265 =C2=B1 0.018M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 20 2.990 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 24 2.929 =C2=B1 0.014M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 28 2.898 =C2=B1 0.010M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 32 2.818 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 36 2.789 =C2=B1 0.012M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 40 2.770 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 44 2.651 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 48 2.669 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 52 2.695 =C2=B1 0.009M/s (drops 0.000 =C2=B1 0.000M/s)
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/uapi/linux/bpf.h       |   4 ++
>  kernel/bpf/ringbuf.c           | 109 +++++++++++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h |   4 ++
>  3 files changed, 98 insertions(+), 19 deletions(-)
>

[...]

> @@ -72,6 +73,8 @@ struct bpf_ringbuf {
>          */
>         unsigned long consumer_pos __aligned(PAGE_SIZE);
>         unsigned long producer_pos __aligned(PAGE_SIZE);
> +       /* points to the record right after the last overwritten one */
> +       unsigned long overwrite_pos;

I moved this after pending_pos, as all these fields are actually
exposed to the user space, so didn't want to unnecessarily shift
pending_pos.

>         unsigned long pending_pos;
>         char data[] __aligned(PAGE_SIZE);
>  };
> @@ -166,7 +169,7 @@ static void bpf_ringbuf_notify(struct irq_work *work)
>   * considering that the maximum value of data_sz is (4GB - 1), there
>   * will be no overflow, so just note the size limit in the comments.
>   */
> -static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_no=
de)
> +static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_no=
de, bool overwrite_mode)
>  {
>         struct bpf_ringbuf *rb;
>
> @@ -183,17 +186,25 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t=
 data_sz, int numa_node)
>         rb->consumer_pos =3D 0;
>         rb->producer_pos =3D 0;
>         rb->pending_pos =3D 0;
> +       rb->overwrite_mode =3D overwrite_mode;
>
>         return rb;
>  }
>
>  static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
>  {
> +       bool overwrite_mode =3D false;
>         struct bpf_ringbuf_map *rb_map;
>
>         if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
>                 return ERR_PTR(-EINVAL);
>
> +       if (attr->map_flags & BPF_F_RB_OVERWRITE) {
> +               if (attr->map_type =3D=3D BPF_MAP_TYPE_USER_RINGBUF)

this seemed error prone if we ever add another ringbuf type (unlikely,
but still), so I inverted this all to allow BPF_F_RB_OVERWRITE only
for BPF_MAP_TYPE_RINGBUF. We should try to be as strict as possible by
default.

> +                       return ERR_PTR(-EINVAL);
> +               overwrite_mode =3D true;
> +       }
> +
>         if (attr->key_size || attr->value_size ||
>             !is_power_of_2(attr->max_entries) ||
>             !PAGE_ALIGNED(attr->max_entries))
> @@ -205,7 +216,7 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_at=
tr *attr)
>
>         bpf_map_init_from_attr(&rb_map->map, attr);
>
> -       rb_map->rb =3D bpf_ringbuf_alloc(attr->max_entries, rb_map->map.n=
uma_node);
> +       rb_map->rb =3D bpf_ringbuf_alloc(attr->max_entries, rb_map->map.n=
uma_node, overwrite_mode);
>         if (!rb_map->rb) {
>                 bpf_map_area_free(rb_map);
>                 return ERR_PTR(-ENOMEM);
> @@ -293,13 +304,25 @@ static int ringbuf_map_mmap_user(struct bpf_map *ma=
p, struct vm_area_struct *vma
>         return remap_vmalloc_range(vma, rb_map->rb, vma->vm_pgoff + RINGB=
UF_PGOFF);
>  }
>
> +/* Return an estimate of the available data in the ring buffer.

Fixed up comment style

[...]

>  static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
> @@ -402,11 +425,41 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr=
 *hdr)
>         return (void*)((addr & PAGE_MASK) - off);
>  }
>
> +static bool bpf_ringbuf_has_space(const struct bpf_ringbuf *rb,
> +                                 unsigned long new_prod_pos,
> +                                 unsigned long cons_pos,
> +                                 unsigned long pend_pos)
> +{
> +       /* no space if oldest not yet committed record until the newest
> +        * record span more than (ringbuf_size - 1).
> +        */

same, keep in mind that we now use kernel-wide comment style with /*
on separate line. Fixed up all other places as well.

> +       if (new_prod_pos - pend_pos > rb->mask)
> +               return false;
> +
> +       /* ok, we have space in overwrite mode */
> +       if (unlikely(rb->overwrite_mode))
> +               return true;
> +
> +       /* no space if producer position advances more than (ringbuf_size=
 - 1)
> +        * ahead of consumer position when not in overwrite mode.
> +        */
> +       if (new_prod_pos - cons_pos > rb->mask)
> +               return false;
> +
> +       return true;
> +}
> +

[...]

