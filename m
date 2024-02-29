Return-Path: <bpf+bounces-23032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E8586C6A7
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 11:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0E1F21A39
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4704864CC3;
	Thu, 29 Feb 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ettFf7a3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6863511
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201803; cv=none; b=Vqjfyc8Vb+L01s8Vw8A7nLcP0DI+saEOlNYI0YnZas8pY7j8htnVPkbkpizT4juWrRhG/YGEOHCe12AWZelmhYWJbkkOGe7mo3xEs2DTl81N+/4LuYxGYbjKvf+KRdsRnMFqZ2lyGCwXVhwp3ZaULk1lxulNEZ+Y1dUQGq9bviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201803; c=relaxed/simple;
	bh=nHA2bLRR0w5ty/uYtl72tVBzPcVMRoNEFKKHoF2YVGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PpD6OSf3tCF5BWFZ9xE8KnCAQc03g8iYzU/+vt8MqF43bmVPOS2+mAtQdD/C71HsdgaWK7RUryaMsx/hlKTPetxiqhBj4bOeG9vgMC2DhvP33bk2xuypWHQ0RJ8fsux69DR1XlTl//jH/xGUQ34KhmCJ2DxBTVcSQCTAkq95jWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ettFf7a3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709201801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmzyp2XtylkPDgv3PN/UwxcVjHWMqp3hAI2ypdxpxR8=;
	b=ettFf7a35cr1Pv581Qz62IX8NyeeO0/gy927dXlLpFvw3p/D4ZkqL/m2Ki0Lryb9qoHrx9
	DNW8GX2NHwzyhiSLqCIa2AD58+NgCFsAVljXHdHxYkevPevx6EFtr9ye3Lk1pYuRvWE3T6
	pW1g+Xh/VC3M2logpmg4G/ihzG7b6R0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-r8p-WMawOHyUq8zgpRVvzQ-1; Thu, 29 Feb 2024 05:16:38 -0500
X-MC-Unique: r8p-WMawOHyUq8zgpRVvzQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-565acc6c939so509976a12.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 02:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201797; x=1709806597;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmzyp2XtylkPDgv3PN/UwxcVjHWMqp3hAI2ypdxpxR8=;
        b=JxQN1WonnO8T/b7A70ABJOiqB5sEZvc5VFish9fdXJwKdNK5GqWDhQJFCpht6hitmC
         RQLkGWeiB+xGy8wKYZA3GoYIOAdp2KZku0+LGlDTspjpzhLUoTwLCFU2IGkEdN77Vl9g
         l2fJZfxPUH/MOt89IVj3WmtG9OkP07tXWnGQPG9uVzLa+LEnNk0wY4GylMHJGCcth4vk
         oSkYy2LnHbMNueMXYRUmjsmHNBck3zqS82IZxGb3lHf9Lr4XpAJDKa6fCIldkkxYKulM
         2vvOPZC2sxqz3EKEDb/V+IMeCZqLh1Tafuwbw0O351k9OOgzUBiWwJa0dxcLw0/1hgJn
         9TAA==
X-Forwarded-Encrypted: i=1; AJvYcCWs4zgLZ2oLCsSwet9L/ID1jwpubmmqxqWmRulRwfgknDIgi+6ktWG9dgtVg0NUkqD5REd0H/YL2crwKuiJXCa9EHr0
X-Gm-Message-State: AOJu0YwG2o+zTHcc7P83ZAjG2/w+YivBHJ/yuFM9qQWRuSTWgmBZKGMD
	+YeFjGjx4AqEMu2bG2tqm+3C/rjPPCtxNx0zl0YMlFvvB32Bdac/fLSIocnVQejUUFEnTf7KcF/
	2FKcTYCc2RiZlrjx85SuwUZl0djfIIlVYRa64VOvxQoNIXqU1bA==
X-Received: by 2002:a05:6402:350d:b0:566:adb8:33f1 with SMTP id b13-20020a056402350d00b00566adb833f1mr511460edd.28.1709201797782;
        Thu, 29 Feb 2024 02:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwcWt8RSAA/OU2JwuC42upbgo2f40JvcB5oEZu8GDP+PsIv0Yxwu8AFeQYVu392NKhsAYjLA==
X-Received: by 2002:a05:6402:350d:b0:566:adb8:33f1 with SMTP id b13-20020a056402350d00b00566adb833f1mr511435edd.28.1709201797476;
        Thu, 29 Feb 2024 02:16:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b005657eefa8e9sm473070edb.4.2024.02.29.02.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:16:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9C2CB112E7D8; Thu, 29 Feb 2024 11:16:36 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: RE: [PATCH bpf] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
In-Reply-To: <65dfa50679d0a_2beb3208c8@john.notmuch>
References: <20240227152740.35120-1-toke@redhat.com>
 <65dfa50679d0a_2beb3208c8@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Feb 2024 11:16:36 +0100
Message-ID: <87zfvj8tiz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Fastabend <john.fastabend@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The devmap code allocates a number hash buckets equal to the next power =
of two
>> of the max_entries value provided when creating the map. When rounding u=
p to the
>> next power of two, the 32-bit variable storing the number of buckets can
>> overflow, and the code checks for overflow by checking if the truncated =
32-bit value
>> is equal to 0. However, on 32-bit arches the rounding up itself can over=
flow
>> mid-way through, because it ends up doing a left-shift of 32 bits on an =
unsigned
>> long value. If the size of an unsigned long is four bytes, this is undef=
ined
>> behaviour, so there is no guarantee that we'll end up with a nice and ti=
dy
>> 0-value at the end.
>>=20
>> Syzbot managed to turn this into a crash on arm32 by creating a DEVMAP_H=
ASH with
>> max_entries > 0x80000000 and then trying to update it. Fix this by movin=
g the
>> overflow check to before the rounding up operation.
>>=20
>> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devic=
es by hashed index")
>> Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
>> Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmai=
l.com
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  kernel/bpf/devmap.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> index a936c704d4e7..9b2286f9c6da 100644
>> --- a/kernel/bpf/devmap.c
>> +++ b/kernel/bpf/devmap.c
>> @@ -130,13 +130,11 @@ static int dev_map_init_map(struct bpf_dtab *dtab,=
 union bpf_attr *attr)
>>  	bpf_map_init_from_attr(&dtab->map, attr);
>>=20=20
>>  	if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
>> -		dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_entries);
>> -
>> -		if (!dtab->n_buckets) /* Overflow check */
>> +		if (dtab->map.max_entries > U32_MAX / 2)
>>  			return -EINVAL;
>> -	}
>>=20=20
>> -	if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
>> +		dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_entries);
>> +
>>  		dtab->dev_index_head =3D dev_map_create_hash(dtab->n_buckets,
>>  							   dtab->map.numa_node);
>>  		if (!dtab->dev_index_head)
>> --=20
>> 2.43.2
>>=20
>
> I'm fairly sure this code was just taken from the hashtab implementation.

Yup, it was :)

> Do we also need a fix there?
>
>         /* hash table size must be power of 2 */
>         htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries);
>
> The u32 check in hashtab is,
>
>         /* prevent zero size kmalloc and check for u32 overflow */
>         if (htab->n_buckets =3D=3D 0 ||
>             htab->n_buckets > U32_MAX / sizeof(struct bucket))
>                 goto free_htab;

Yeah, I don't see any reason why this wouldn't be susceptible to the
same issue. I'll send a follow-up to apply the same fix there.

-Toke


