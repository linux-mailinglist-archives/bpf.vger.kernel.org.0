Return-Path: <bpf+bounces-23135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C53386E120
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 13:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3E71C225E2
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BC1374;
	Fri,  1 Mar 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwNjmL88"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF06ED8
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296536; cv=none; b=SREM0yCi3EJ4DOAwyVnZoMQhgVDGbXKVFEqukHZ8RkbHMgfwTCfyN63JmqjdQM2BfEDZB5gW9SZ8f+42YX+jRbEPH7FqiP2+QEr916vlP8Rio9C+XfEqX2MMTr9bcrS112mP3k2/m1sEWb6MEoPKWkve7bwpLetqRQaIGBovO1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296536; c=relaxed/simple;
	bh=5JN+p2VTTqthoMND4fEiCiX29A/o+Mh11xx6yeJz63I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=urfa2k1zxUKtnyGQKrybhAeCXV2D7hcM7bmK9XJJSC/I2pT5vQ2Li/WC7dKIwHY0aZsV8at2ecBBabHksRmmdXHlecOu4aXuoNnKgDfxqMDeCdv9x3UP/LD7OxxqOnZP+4ynvl10TAs8fdBYvBoPoFYfnOI3fo4RDUz/c2SdxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwNjmL88; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709296533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eR/FBX1j94Zg32r5xPFb0StT7NNmIsLpiG0Gldp3F8=;
	b=SwNjmL88eXl/qaJLVml2xecRYu0ld2kL+cUWbRSRauecWANQMpw/sZ/Lk+5PCpKNAE2pmp
	dEu6/0T/UATu6Fpy81LFlphidFJJZXAZHAzpb6UVCzNLBkpXRN3qrpmUxXCQxTlUgd9qcc
	XSkJZfw9H9FkYWLd9ucjeUq/uaJn4xo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-JZYMZJywOQaxzDjaU_2HOg-1; Fri, 01 Mar 2024 07:35:31 -0500
X-MC-Unique: JZYMZJywOQaxzDjaU_2HOg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3f9b549179so195571166b.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 04:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709296530; x=1709901330;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eR/FBX1j94Zg32r5xPFb0StT7NNmIsLpiG0Gldp3F8=;
        b=lF/wzlVFdSFCPjQedXQVCBAMWPCA6Lf2EzsL75zq06TGtXB6HBJaAeDecSfxLmEL5M
         kNowk8CD/90Uwt4letQi0pYxYXfz0+8RaHLMlAkQ2RS2BOyrmF1QVcQOr9+McFHtnb8t
         6e0A7OziWPMc1TI83uCLbiavU7eJQ7otj4/I+CxXpIMAnCa8MofUUNWskJJjQEFvdPa0
         cZCm0H7sTXKXVZ47/sL0Ch+AB4KWZLJcEB6R0huo2Cy9k9KyftVAl8q1SxNTnMshNYOd
         kbJ0EzTMu1jI9DIU8XKfZDWM0kk7LJns2jdol9thU+RCLyzkTTY4KBJa/6W+fA/ERmE/
         xQKw==
X-Forwarded-Encrypted: i=1; AJvYcCUNqsEdZXBoatdqD+ZXtxH+tJ+Hnc4RIj7db3rbfbiz+doOij1LCmjcqvaWizb6NMwqbQSo0MQ3MCysjm5d9POmOEIj
X-Gm-Message-State: AOJu0YwKkufYsftLRW1jdU6QqhuHMgu6qQuys15cP9nbGZSyp21IvKcm
	PpC3ydEZ0fuKtimosRDT966ACmCSlTpVw3EyL9SSn61q4ZinKbbTgjtZtJnRu6GPU1nQqo86ggZ
	kXxOmfaRfTWKAJSpr/CiZ+kdM87TP30d3PDf92B/XkY6uZ4aeCw==
X-Received: by 2002:a17:906:4091:b0:a43:a7:c683 with SMTP id u17-20020a170906409100b00a4300a7c683mr1190033ejj.42.1709296530737;
        Fri, 01 Mar 2024 04:35:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIaQttKwsIKw93zJmuMZQgfdpm1oLI4S7zCz5fePon9T2U5nhfy8aeBq8bIeLX9EPS/ZyG+w==
X-Received: by 2002:a17:906:4091:b0:a43:a7:c683 with SMTP id u17-20020a170906409100b00a4300a7c683mr1190015ejj.42.1709296530413;
        Fri, 01 Mar 2024 04:35:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906594800b00a42e4b5aaeesm1655145ejr.89.2024.03.01.04.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 04:35:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 96E47112E955; Fri,  1 Mar 2024 13:35:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit
 arches
In-Reply-To: <65e10367cb393_33719208c2@john.notmuch>
References: <20240229112250.13723-1-toke@redhat.com>
 <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
 <65e10367cb393_33719208c2@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Mar 2024 13:35:29 +0100
Message-ID: <878r32b04u.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Fastabend <john.fastabend@gmail.com> writes:

> Alexei Starovoitov wrote:
>> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
>> >
>> > The hashtab code relies on roundup_pow_of_two() to compute the number =
of
>> > hash buckets, and contains an overflow check by checking if the result=
ing
>> > value is 0. However, on 32-bit arches, the roundup code itself can ove=
rflow
>> > by doing a 32-bit left-shift of an unsigned long value, which is undef=
ined
>> > behaviour, so it is not guaranteed to truncate neatly. This was trigge=
red
>> > by syzbot on the DEVMAP_HASH type, which contains the same check, copi=
ed
>> > from the hashtab code. So apply the same fix to hashtab, by moving the
>> > overflow check to before the roundup.
>> >
>> > The hashtab code also contained a check that prevents the total alloca=
tion
>> > size for the buckets from overflowing a 32-bit value, but since all the
>> > allocation code uses u64s, this does not really seem to be necessary, =
so
>> > drop it and keep only the strict overflow check of the n_buckets varia=
ble.
>> >
>> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing overflo=
w and zero size checks")
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> > ---
>> >  kernel/bpf/hashtab.c | 10 +++++-----
>> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> > index 03a6a2500b6a..4caf8dab18b0 100644
>> > --- a/kernel/bpf/hashtab.c
>> > +++ b/kernel/bpf/hashtab.c
>> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union bpf_at=
tr *attr)
>> >                                                           num_possible=
_cpus());
>> >         }
>> >
>> > -       /* hash table size must be power of 2 */
>> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries);
>> >
>> >         htab->elem_size =3D sizeof(struct htab_elem) +
>> >                           round_up(htab->map.key_size, 8);
>> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(union bpf_=
attr *attr)
>> >                 htab->elem_size +=3D round_up(htab->map.value_size, 8);
>> >
>> >         err =3D -E2BIG;
>> > -       /* prevent zero size kmalloc and check for u32 overflow */
>> > -       if (htab->n_buckets =3D=3D 0 ||
>> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
>> > +       /* prevent overflow in roundup below */
>> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
>> >                 goto free_htab;
>>=20
>> No. We cannot artificially reduce max_entries that will break real users.
>> Hash table with 4B elements is not that uncommon.

Erm, huh? The existing code has the n_buckets > U32_MAX / sizeof(struct
bucket) check, which limits max_entries to 134M (0x8000000). This patch
is *increasing* the maximum allowable size by a factor of 16 (to 2.1B or
0x80000000).

> Agree how about return E2BIG in these cases (32bit arch and overflow) and=
=20
> let user figure it out. That makes more sense to me.

Isn't that exactly what this patch does? What am I missing here?

-Toke


