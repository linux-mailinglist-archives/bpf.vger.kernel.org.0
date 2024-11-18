Return-Path: <bpf+bounces-45087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8359D1090
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF7F1F226BF
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A1915250F;
	Mon, 18 Nov 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWzZ1ooj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9C2747B
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933015; cv=none; b=E7hlwFqUn8MkzGgbaZFNuKK5gnuomXii+zLB4JDfiumR5yxLwE0nkbw+qU0zbHHbJQTT9sc184iieRzMCgH8K/w6aSI6i1uXDRU5YdDv/IjK8j6FssAJMlbd/EYhhw86vg4BDY+NL/yL2mnjf0200l7Nk13joFVQqI5ZuFF/L54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933015; c=relaxed/simple;
	bh=NO6EOQUTyDmVY3USQKNqdzZmkrIFfdaDhePgnUCOeS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u2/MrNse0tzgnQsMW8SLWjjxbjNmXLSh30b4DHDZUDV2HqrTeStWrhYmmCiRTo0roMibwuHYWTOEn940JkeOzs+xAUIK+gFM+vKLsbSyTb9U2dwAwphGDtCDvdKH6yIm+PhkrOF+01wxnwqxbgYlc41ddmLSnF+ffv8NQtQHNOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWzZ1ooj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731933013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NO6EOQUTyDmVY3USQKNqdzZmkrIFfdaDhePgnUCOeS4=;
	b=gWzZ1ooj5TkE4mTkujbL++zzAY2AB5NYEZvwzhv1/y0T4gUo7bSQnLjO+xkFz/sfuHCc8d
	VXXrawR3Nom2XP88ngGWY+asgrol8UAMKb2onFNw5eET5sjq+WHvxwP0aXBo8MoKjxO0ES
	NxhXV7/fi7pdTgBsGDnMDJQAYHsjWf8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-OHX8cQsNP0e6bXTscEUZYw-1; Mon, 18 Nov 2024 07:30:11 -0500
X-MC-Unique: OHX8cQsNP0e6bXTscEUZYw-1
X-Mimecast-MFC-AGG-ID: OHX8cQsNP0e6bXTscEUZYw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so22231835e9.1
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 04:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731933010; x=1732537810;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO6EOQUTyDmVY3USQKNqdzZmkrIFfdaDhePgnUCOeS4=;
        b=cQ8ApT75eS0wDBvtlUbY1qIrERGcMsAQMu/Tbi32ecfJV83nOef8SNLACg5kEbxRYH
         kku2WAyxxqcGywpUpulWOqvJf6n3HKbubTEAI0K8jpZKRCPVPmZ7cSbkIHC0REnRMP09
         47LIPXqF38VNubzjnmCeVoaAGsiWeKEjlNy2Jkrpf3gEJmDPZF4Y6aOMXyFhwfphrLj+
         mJA7MGtCf/BWxkbHNNjAFTZD18J4N+O5q1/oDZbZzu+GS8Oz7ehpBuSl7+P3LsDOqNUe
         X/E/yVP4EhIlCxzHXMIk6GUXpapjCgvcfNltPC28pdbpQa//RxiZTv8BZe6fxB5oEfDu
         Eujg==
X-Forwarded-Encrypted: i=1; AJvYcCUwxbsfgSUtVkhodZsZPkIg75X1juIGvloG5egRCwKteJjet1jYSWChWu1OMqhZHc98OMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUY0y3ZC11QGeJcUgdyn2mqWsCb1secpgL3jSndJw3OGJpjMsQ
	WrnSTegWfOkqfvLbkbShXOTdM2rUpZ7h53eJNcYL+IElNdiH9h10jQWQnyIyDTVzchJwixxB7lh
	JDxhJwpviSMm9EYE/Xts0+3YKCkUI8D/ndccpunomF8L48QLt2Q==
X-Received: by 2002:a05:600c:1e27:b0:431:5043:87c3 with SMTP id 5b1f17b1804b1-432df78bb53mr83701305e9.22.1731933010545;
        Mon, 18 Nov 2024 04:30:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7oK0+2Gv2ZYhVUhG0VyLtCz8pqw41xvHq2CRum6J9E5cnOuLJcYos2MdCEG+4t+BLPsAE8Q==
X-Received: by 2002:a05:600c:1e27:b0:431:5043:87c3 with SMTP id 5b1f17b1804b1-432df78bb53mr83701165e9.22.1731933010270;
        Mon, 18 Nov 2024 04:30:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab72085sm158073035e9.3.2024.11.18.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 04:30:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A8597164D318; Mon, 18 Nov 2024 13:30:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ryan Wilson <ryantimwilson@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development
 <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, ryantimwilson@meta.com, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
In-Reply-To: <CA+Fy8UaKWJ+8SoF_purtcOju-Xdt-m5qeUvg5keK3KGW9=ApQw@mail.gmail.com>
References: <20241114170721.3939099-1-ryantimwilson@gmail.com>
 <CAADnVQJ2V6JnDhvNuqRHEmBcK-6Aty9GRkdRCGEyxnWnRrAKcA@mail.gmail.com>
 <CA+Fy8Ub7b1SXByugjDo-D13H_12w0iWzQhO-rf=MMhSjby+maA@mail.gmail.com>
 <874j48rc13.fsf@toke.dk>
 <CA+Fy8UaKWJ+8SoF_purtcOju-Xdt-m5qeUvg5keK3KGW9=ApQw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 18 Nov 2024 13:30:08 +0100
Message-ID: <87ed38ragf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ryan Wilson <ryantimwilson@gmail.com> writes:

> On Fri, Nov 15, 2024 at 3:07=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Hi Ryan
>>
>> I'll take a more detailed look at your patch later, but wanted to add
>> a few smallish comment now, see below:
>>
>>
>> Ryan Wilson <ryantimwilson@gmail.com> writes:
>> > On Thu, Nov 14, 2024 at 4:52=E2=80=AFPM Alexei Starovoitov
>> > <alexei.starovoitov@gmail.com> wrote:
>> >>
>> >> On Thu, Nov 14, 2024 at 9:07=E2=80=AFAM Ryan Wilson <ryantimwilson@gm=
ail.com> wrote:
>> >> >
>> >> > Currently, network devices only support a single XDP program. Howev=
er,
>> >> > there are use cases for multiple XDP programs per device. For examp=
le,
>> >> > at Meta, we have XDP programs for firewalls, DDOS and logging that =
must
>> >> > all run in a specific order. To work around the lack of multi-progr=
am
>> >> > support, a single daemon loads all programs and uses bpf_tail_call()
>> >> > in a loop to jump to each program contained in a BPF map.
>> >>
>> >> The support for multiple XDP progs per netdev is long overdue.
>> >> Thank you for working on this!
>>
>> +1 on this!
>>
>>
>> [...]
>>
>> > Note for real drivers, we do not hit this code. This is how it works
>> > for real drivers:
>> > - When installing a BPF program on a driver, we call the driver's
>> > ndo_bpf() callback function with command =3D XDP_QUERY_MPROG_SUPPORT. =
If
>> > this returns 0, then mprog is supported. Otherwise, mprog is not
>> > supported.
>>
>> We already have feature flags for XDP, so why not just make mprog
>> support a feature flag instead of the query thing? It probably should be
>> anyway, so it can also be reported to userspace.
>
> Oh wow can't believe I missed the feature flag API. Yes, I'll use this
> in v2 instead. Thanks for the suggestion!

Cool! You're welcome.

> And if it's exposed to userspace, users no longer need to guess if
> their driver supports mprog or not - although hopefully this is an
> intermediary state and the mprog migration for all drivers will be
> relatively quick and painless.

Famous last words? ;)

-Toke


