Return-Path: <bpf+bounces-37364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0CC954886
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 14:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67FB1C2262A
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC71ABEDD;
	Fri, 16 Aug 2024 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ef++zBT6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027913AA2B
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810355; cv=none; b=q6vimfwKz5ez2CrgzGzJVCBA/VwiLX3aOQ7J7AKdyK1gyxAeOovPbmDIfMQTD/tKNdS33wOpcra61xhZd1laxPiWz9FArZGvGoxC5a70PUFpYXpamA1M1HdfWXDm7si0O8cr3AIRDMUVkZmw/2rGfr92lS+ZGRA6RgKOKgYFC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810355; c=relaxed/simple;
	bh=Z3OsITij8iRw6MzDOPs42DX7dRqZPmILJxzzjwe7+v4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=etK5chlQYevCSSDH/ThGWmu4gG7eMDrbo8KsP075DW8mOlzb8KWK8nXuJ07ptMroHgL6RUqwmbIprS4YHhXdFRuIj71PBH4NXi5tTFx0geb1Gj4zlvOieB9Z6+blcTL5ltb/sNftWEYLTRNpOF8bnngEKQKANyLXF0L9tkf+FGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ef++zBT6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723810352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3OsITij8iRw6MzDOPs42DX7dRqZPmILJxzzjwe7+v4=;
	b=Ef++zBT6EUo4oHQwzUVGfUAt63MEk1nW77ZXATwBkswM04IfHxjMl8Ex2nDKPt9r3jCI1p
	8U/f0rsiETLhShvpDd6p3A0SEwrPIQYI23AFV3fYrEnHaAC47bhc8E/ft2jI5ksm6AbV6h
	u0SorkQRqCphHQIcakOKBzjS1bN/ujM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-bWA5cPD2OBKjgzgx7OUd7g-1; Fri, 16 Aug 2024 08:12:31 -0400
X-MC-Unique: bWA5cPD2OBKjgzgx7OUd7g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3717c75b265so1105733f8f.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 05:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723810350; x=1724415150;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3OsITij8iRw6MzDOPs42DX7dRqZPmILJxzzjwe7+v4=;
        b=BYbpbWd6pX3GIKMP3tvpvgBscR+amgjcTnJsrkkc0nPfEwWqbq7GZrrgAdxu+TAauB
         /Mxr5mrYr2H4Co0wzadMjAIHaqL+ZMeM9rvKVY4vhwcfp/nDuVkxK/hsL02izn1GHAnQ
         XqLpi1nkmt6ruSy/OSXZYcxXHgd3CqcBXLO5JOnOf6tuO3U0MwxP9VZTHR3kV1Db+aUI
         RTsa0SJpYGn1Ss9kaiHTNr27IPPPPL5gqboreB2nNAXdZDVZsSW4yR1rVGwgDnRrKZ+Q
         meg5xwiYuCZqpKVBf5cRjsZtTSZcAMthepdiqagb10y2acNGeMjCS+LoHZQx+XzeifMq
         Ltew==
X-Gm-Message-State: AOJu0YwoaZ+qRgUNJOOJR1PhIxSzDmB4tEIBFZUN6dWAbp1fpcAlx33p
	NiOhycdp9/P0AIf3ZAOXt04XlPnIdHJ8etPVv+NuwS4o9qYDtFr7CZBfNtMO+humYb28soCcLWh
	0K8Xxl1A0+tRO/eZ534bN3DVbw/MAwKIR6HWhFNT3ZRdf+rgFpg==
X-Received: by 2002:adf:e8c7:0:b0:371:8cd6:b2c2 with SMTP id ffacd0b85a97d-371946a4994mr1919320f8f.48.1723810350222;
        Fri, 16 Aug 2024 05:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPv25zqL6yUa6mNOIfdfg0gGN8v8qDRyWWiB7xsYgqkngqJeE4m8do+bUdWU8iQnOmAlJJYQ==
X-Received: by 2002:adf:e8c7:0:b0:371:8cd6:b2c2 with SMTP id ffacd0b85a97d-371946a4994mr1919285f8f.48.1723810349673;
        Fri, 16 Aug 2024 05:12:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896df5sm3520919f8f.69.2024.08.16.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:12:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D41CB14AE0A8; Fri, 16 Aug 2024 14:12:28 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: bpf-next experiment
In-Reply-To: <CAADnVQKNULb55aFOt1Di53Crf64TvF6p7upvUxLwSbrgMw=puw@mail.gmail.com>
References: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
 <87bk1ucctj.fsf@toke.dk>
 <CAADnVQKNULb55aFOt1Di53Crf64TvF6p7upvUxLwSbrgMw=puw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Aug 2024 14:12:28 +0200
Message-ID: <87wmkgbr9v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Aug 15, 2024 at 12:15=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > 2. Non-networking bpf commits land in bpf-next/master branch.
>> > It will form bpf-next PR during the merge window.
>> >
>> > 3. Networking related commits (like XDP) land in bpf-next/net branch.
>> > They will be PR-ed to net-next and ffwded from net-next
>> > as we do today. All these patches will get to mainline
>> > via net-next PR.
>>
>> So from a submitter PoV, someone submitting an XDP-related patch (say),
>> should base this off of bpf-next/net, and tag it as bpf-next in the
>> subject? Or should it also be tagged as bpf-next/net?
>
> This part we're still figuring out.
> There are few considerations...
> it's certainly easier for bpf CI when the patch set
> is tagged with [PATCH bpf-next/net] then CI won't try
> to find the branch,
> but it will take a long time to teach all contributors
> to tag things differently,
> so CI would need to get smart anyway and would need
> to apply to /master, run tests, apply to /net, run tests too.
> Currently when there is no tag CI attempts to apply to bpf.git,
> if it fails, it tries to apply to bpf-next/master and only
> then reports back "merge conflict".
> It will do this for bpf, bpf-next/master, bpf-next/net now.
>
> Sometimes devs think that the patch is a fix, so they
> tag it with [PATCH bpf], but it might not be,
> and after review we apply it to bpf-next instead.
>
> So tree/branch to base patches off and tag don't
> matter that much.
> So I hope, in practice, we won't need to teach all
> developers about new tag and about new branch.
> We certainly won't be asking to resubmit if patches
> are not tagged one way or the other,
> but if you want to help CI and tell maintainers
> your preferences then certainly start using
> [PATCH bpf-next] and [PATCH bpf-next/net] when necessary.
> Or don't :) and instead help us make CI smarter :)

Alright, sounds good, thanks for clarifying! And exciting change in
general :)

-Toke


