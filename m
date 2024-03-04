Return-Path: <bpf+bounces-23291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1D88701F1
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC61C22F8B
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81A3D3BE;
	Mon,  4 Mar 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emTwkf0P"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125083B797
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557334; cv=none; b=ZdTd1ex/SOURjwaib9H8rOkNoQbwFWAEpiWpXOBvBSIO+qIIpl8dJ72ReanDlzmBeVk8IsCiSaXVWKsi3fec5okoUh8JeNwK7bAX7w+BSvhZ6bLLbtcR2PwGsQgadlnhWWtPev823JvbMdH0IXXtjbdi4mocbCFfp5kZdAx3f9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557334; c=relaxed/simple;
	bh=5M5V0DDCogKvRGIeGUSdnfpMyYAEumhFT9WYEfVcLyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eM4NUTeqWsj7wTMy5/goSsC8pZWGCoCSxWecTbGzA+YUVhwvwnrW/FCY/Uu+imzfyn4FJQtY7tg2K5qoFbS0T8tGSMlf0J4ZBR3EQRIV+kV0EWvjs+SXFhcYp6Baufd/syUU3IB7hnkXQbio0xDirZn0WCDvFQPLzvzer5u7reg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emTwkf0P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709557332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAOwLpzxgUMqOOg0669y1n3/EdHToBJ2IPeng0bW5dw=;
	b=emTwkf0Pt52GVffFUmRYDStUkX93wchwSpYgzi/A6Q6BL1/GFOdzZBBoAOdpORED4Ru7vk
	upBB59xJgsBZNcLtnxVL69AFC3OZ8HExMkWa6EBbIt58tmyVCRLlRAxW4yf97X2cJaHWWn
	uj7udLEy6GQsJMtjHHpbEdwsF788mG4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-IqmcSASAMzi2_bF_DG4j9A-1; Mon, 04 Mar 2024 08:02:10 -0500
X-MC-Unique: IqmcSASAMzi2_bF_DG4j9A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a45190fd2fcso79385066b.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 05:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709557329; x=1710162129;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAOwLpzxgUMqOOg0669y1n3/EdHToBJ2IPeng0bW5dw=;
        b=xMeRaVhVXUGgcVoZFIlJSZJCsSoWHe3D4mDrXs+qIMof7s4Rz4ltzYf6kjmz8cVzSz
         zWGc/Sq5/AXPlaZlWj6TMu3ImrkHCuBgxxzxVMZCAYpMgGvgTL+CCrm0NH88S3ZxNq2X
         nrRVsO7//56bzZivxIoNCa73oz+/NN2ot3U6ghf+urby0jR64QxdGjGkQSIiyHnbvH67
         pN+vsapZDSs8/pNKfThJA2ln0tm51JuawLy5cPwWzQ+xX5SpNWH9NrwHySLvBwMBrCZo
         CTVcKVdGR9k7T7N2zjEa6PNLfOZhgPJ3LnOzMZKJuDFe8TATm7aELIiYaq1+DTjBZp9N
         3a/w==
X-Forwarded-Encrypted: i=1; AJvYcCUbs0KH+qexvEeaXOqo6AUsdHPzzOcDMaeXUm5pW50wAeUpnnmaVJQ0x0+u6T218Itm2U4FkDK3YZJbuasIamkIx8wQ
X-Gm-Message-State: AOJu0YyJoxNA9T5M/z2IRoko2gvkNd3GSZIlRPm/+GOma8wImZOsV/nU
	klSYups+rTppgkh5HBGC1uZYXs2hq8PKuJhqrLnjtRefyz5WUKdP4rNvA0EV9DJm6Wkg1OvC1H2
	PvC/qSTgaEODnY/stqzzy9n1tctt04QYlCRsNDGFRZP62aWHGcQ==
X-Received: by 2002:a17:906:c355:b0:a3e:7d36:62b1 with SMTP id ci21-20020a170906c35500b00a3e7d3662b1mr6522004ejb.46.1709557329563;
        Mon, 04 Mar 2024 05:02:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETE0MIw9GAw5FGZ8OHOSQsq0enWqFqm0Jab1zJM3q5ByFZ5FivbKUkBulc1DyUzkfMlJ7buQ==
X-Received: by 2002:a17:906:c355:b0:a3e:7d36:62b1 with SMTP id ci21-20020a170906c35500b00a3e7d3662b1mr6521976ejb.46.1709557329098;
        Mon, 04 Mar 2024 05:02:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906111500b00a45464679b1sm1122035eja.127.2024.03.04.05.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:02:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 614EF112EDBF; Mon,  4 Mar 2024 14:02:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit
 arches
In-Reply-To: <CAADnVQLzVJRut0v2dQPbBUDW971Fd-EjkOf0pyLh5-W7wYwiYA@mail.gmail.com>
References: <20240229112250.13723-1-toke@redhat.com>
 <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
 <65e10367cb393_33719208c2@john.notmuch> <878r32b04u.fsf@toke.dk>
 <CAADnVQLzVJRut0v2dQPbBUDW971Fd-EjkOf0pyLh5-W7wYwiYA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 04 Mar 2024 14:02:08 +0100
Message-ID: <87plwa6tgv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Mar 1, 2024 at 4:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> John Fastabend <john.fastabend@gmail.com> writes:
>>
>> > Alexei Starovoitov wrote:
>> >> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
>> >> >
>> >> > The hashtab code relies on roundup_pow_of_two() to compute the numb=
er of
>> >> > hash buckets, and contains an overflow check by checking if the res=
ulting
>> >> > value is 0. However, on 32-bit arches, the roundup code itself can =
overflow
>> >> > by doing a 32-bit left-shift of an unsigned long value, which is un=
defined
>> >> > behaviour, so it is not guaranteed to truncate neatly. This was tri=
ggered
>> >> > by syzbot on the DEVMAP_HASH type, which contains the same check, c=
opied
>> >> > from the hashtab code. So apply the same fix to hashtab, by moving =
the
>> >> > overflow check to before the roundup.
>> >> >
>> >> > The hashtab code also contained a check that prevents the total all=
ocation
>> >> > size for the buckets from overflowing a 32-bit value, but since all=
 the
>> >> > allocation code uses u64s, this does not really seem to be necessar=
y, so
>> >> > drop it and keep only the strict overflow check of the n_buckets va=
riable.
>> >> >
>> >> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing over=
flow and zero size checks")
>> >> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> > ---
>> >> >  kernel/bpf/hashtab.c | 10 +++++-----
>> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >> >
>> >> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> >> > index 03a6a2500b6a..4caf8dab18b0 100644
>> >> > --- a/kernel/bpf/hashtab.c
>> >> > +++ b/kernel/bpf/hashtab.c
>> >> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union bpf=
_attr *attr)
>> >> >                                                           num_possi=
ble_cpus());
>> >> >         }
>> >> >
>> >> > -       /* hash table size must be power of 2 */
>> >> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entrie=
s);
>> >> >
>> >> >         htab->elem_size =3D sizeof(struct htab_elem) +
>> >> >                           round_up(htab->map.key_size, 8);
>> >> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(union b=
pf_attr *attr)
>> >> >                 htab->elem_size +=3D round_up(htab->map.value_size,=
 8);
>> >> >
>> >> >         err =3D -E2BIG;
>> >> > -       /* prevent zero size kmalloc and check for u32 overflow */
>> >> > -       if (htab->n_buckets =3D=3D 0 ||
>> >> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
>> >> > +       /* prevent overflow in roundup below */
>> >> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
>> >> >                 goto free_htab;
>> >>
>> >> No. We cannot artificially reduce max_entries that will break real us=
ers.
>> >> Hash table with 4B elements is not that uncommon.
>>
>> Erm, huh? The existing code has the n_buckets > U32_MAX / sizeof(struct
>> bucket) check, which limits max_entries to 134M (0x8000000). This patch
>> is *increasing* the maximum allowable size by a factor of 16 (to 2.1B or
>> 0x80000000).
>>
>> > Agree how about return E2BIG in these cases (32bit arch and overflow) =
and
>> > let user figure it out. That makes more sense to me.
>>
>> Isn't that exactly what this patch does? What am I missing here?
>
> I see. Then what are you fixing?
> roundup_pow_of_two() will return 0 and existing code is fine as-is.

On 64-bit arches it will, yes. On 32-bit arches it ends up doing a
32-bit left-shift (1UL << 32) of a 32-bit type (unsigned long), which is
UB, so there's no guarantee that it truncates down to 0. And it seems at
least on arm32 it does not: syzbot managed to trigger a crash in the
DEVMAP_HASH code by creating a map with more than 0x80000000 entries:

https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com

This patch just preemptively applies the same fix to the hashtab code,
since I could not find any reason why it shouldn't be possible to hit
the same issue there. I haven't actually managed to trigger a crash
there, though (I don't have any arm32 hardware to test this on), so in
that sense it's a bit theoretical for hashtab. So up to you if you want
to take this, but even if you don't, could you please apply the first
patch? That does fix the issue reported by syzbot (cf the
reported-and-tested-by tag).

-Toke


