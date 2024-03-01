Return-Path: <bpf+bounces-23160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8937386E711
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295521F22281
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8EF7491;
	Fri,  1 Mar 2024 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieSIvSFI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF546B7;
	Fri,  1 Mar 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313766; cv=none; b=NyItFm9B/kCUvi0LPnjiPZLAyJHIqF24+S+Y9Ew93oMpCHgISsGMZpZv66CAW38hZmjetse/TUYGMSk1OuDMyS0wS7vzr4oMHneqKKKWRwDqUVypeHqRRrf6P4LaTdYeJy4OeWwe72J64cROUfuzo053eq5MfPLbTLA+GhvaMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313766; c=relaxed/simple;
	bh=wW2s7YyaIK9Iukn6t9eAs4CLfP5e6OeU52MOIFTI8I0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FKlZEBLFe3Lcy98AnsNEUgwzNvZapdAb0Dpv5fhS48rPK1inCRxd215Q+ZZUhUJIss/tBu9wOllObdFTS9AB/ps8DZ+hg3K+ezbbEytjjH00Hq0jnJZsWheEvAcZVKQd3pAHNcLT7ZTtjNs21Mz3XR9r93EUACS9jRn714uQ4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieSIvSFI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso20013195ad.3;
        Fri, 01 Mar 2024 09:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313764; x=1709918564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhFa2goRKez+uHT4iHzjOn9C0bhpHsiRDeBzyE8GOxs=;
        b=ieSIvSFIFEoYJM+VhkWoVAlaiX4OaPCls2zfreJQhwg4RSvcpdCIGYwhMzwq2kXph3
         eMaq0/ErTIaqFNq6QelD4aXKpelmWPs5X/OgvnhieMzbH4AZyMAc7sl/Te8keFuIyXml
         pU0GIRH07CmM1cWbDfji1pzVluQeSyRswwHUUwswxz8Tb/npfuqUEfkFflRh7o5m00aN
         ZyHu9oDZtDsyJlTC1WwDbpy53HYJoJOF0NEHBPCRfhG3ZzuWIaOZLGm/uj97S6AG4JQr
         zShIn6PGHeGuZzdrafUDMGa9WEexU8Hpe+0m5gJG6UsQ14JrdK7Bxnd55pfz099RtZmY
         K2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313764; x=1709918564;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NhFa2goRKez+uHT4iHzjOn9C0bhpHsiRDeBzyE8GOxs=;
        b=pXJ1A6FIfemWric0mzdPdXCLRbEdObjM2n/vpNuzrvcIcjr0xQIT7Kt5gKlK6Zu7NQ
         aichxm6CnCahDoyO5SsNDy2epsiaOUg7NdTrREGk5puqeoiLYQCX/s5upUuanga06V/l
         pcxbXi9sYHtoljrXJSEnqaX8Bwbw/xOGqe3Rp8sOCjatSFrkyQgT4JnyFVHtbOfqgKlN
         Mo6aVHBYL6Gns03y5hcJU38U0kLbIpJsvxRmO7T/sGL8pNgEzGAmiAIdxwnXuwCUHKuR
         gnlEvsmfk8uFKfAFVE+Jw7iMHA4LKf4QIbhO7wQE3uMnQAquvI3UARy8O6iXNf83EXmu
         d3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWR1LZmG8rhfld2CSK88pxzTGsBNNPn5dXWw/opS73VwgiwUNHg+S8ZywDYPrweZVCpXG2NpyFzc0WzSqTqRc6OwYgyOXOJZqKZVjErpulD39CrOzSEZf8s9TqB
X-Gm-Message-State: AOJu0YzR3i/UfAqBiWSNUZxAJZhpJ1v6K2N03d2RR23cw2E6+Os2LOLo
	Otvlj9MNUjqWdJ3XsFrS9Qm1zID5dSjiBd/RHxnAshI6UdsaY16U
X-Google-Smtp-Source: AGHT+IGIl4MRpeVO5pqHzO0Z8I3OeGTQI3k7KLTOH3QGQe2gx5/r+tq8Dp+0AOZDGdM7KCkTdOYKtQ==
X-Received: by 2002:a17:902:c408:b0:1db:ecf1:3b67 with SMTP id k8-20020a170902c40800b001dbecf13b67mr2588723plk.66.1709313764035;
        Fri, 01 Mar 2024 09:22:44 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b001dce24ac4dbsm2632068pla.136.2024.03.01.09.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:22:43 -0800 (PST)
Date: Fri, 01 Mar 2024 09:22:42 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <65e20ee234bbe_5dcfe208a0@john.notmuch>
In-Reply-To: <875xy6ayvb.fsf@toke.dk>
References: <20240227152740.35120-1-toke@redhat.com>
 <65dfa50679d0a_2beb3208c8@john.notmuch>
 <87zfvj8tiz.fsf@toke.dk>
 <65e0eb87a079e_322af20886@john.notmuch>
 <875xy6ayvb.fsf@toke.dk>
Subject: RE: [PATCH bpf] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> John Fastabend <john.fastabend@gmail.com> writes:
> =

> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> John Fastabend <john.fastabend@gmail.com> writes:
> >> =

> >> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >> The devmap code allocates a number hash buckets equal to the next=
 power of two
> >> >> of the max_entries value provided when creating the map. When rou=
nding up to the
> >> >> next power of two, the 32-bit variable storing the number of buck=
ets can
> >> >> overflow, and the code checks for overflow by checking if the tru=
ncated 32-bit value
> >> >> is equal to 0. However, on 32-bit arches the rounding up itself c=
an overflow
> >> >> mid-way through, because it ends up doing a left-shift of 32 bits=
 on an unsigned
> >> >> long value. If the size of an unsigned long is four bytes, this i=
s undefined
> >> >> behaviour, so there is no guarantee that we'll end up with a nice=
 and tidy
> >> >> 0-value at the end.
> >
> > Hi Toke, dumb question where is this left-shift noted above? It looks=

> > like fls_long tries to account by having a check for sizeof(l) =3D=3D=
 4.
> > I'm asking mostly because I've found a few more spots without this
> > check.
> =

> That check in fls_long only switches between too different
> implementations of the fls op itself (fls() vs fls64()). AFAICT this is=

> mostly meaningful for the generic (non-ASM) version that iterates over
> the bits instead of just emitting a single instruction.
> =

> The shift is in the caller:
> =

> static inline __attribute__((const))
> unsigned long __roundup_pow_of_two(unsigned long n)
> {
> 	return 1UL << fls_long(n - 1);
> }
> =

> If this is called with a value > 0x80000000, fls_long() will (correctly=
)
> return 32, leading to the ub[0] shift when sizeof(unsigned long) =3D=3D=
 4.

Yep thanks I was looking in fls_long there walked past the pow-of_two()
bits. Thanks.=

