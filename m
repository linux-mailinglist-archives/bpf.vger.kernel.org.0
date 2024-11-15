Return-Path: <bpf+bounces-44939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C904B9CDD3B
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D532B22590
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA031B6CF9;
	Fri, 15 Nov 2024 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdqgR3Re"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1731B3949
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668832; cv=none; b=S6LtoyVWUF8JsMT6Ufme/4KpToDczS3ns6CyQwayiTq6wa46EGh22u0X2VzIQ+W9KKKqFy1vFcFIbtxIUeXqMpKiZs4Zrdi64IGDyAeZ48bWw+qp2xCQc2rz52coFV0+H8uEx/4e4HYF3AO6fZDehI5K/1ZdbwXeM0t1+YWtznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668832; c=relaxed/simple;
	bh=/Be/Q3Pv/gZYXqIqwnuQYODJ0P9sar7TAP2czlgo7NI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3FmeEkLkxLv6gHgJzJZhV+Mg/r8+eryv6ky8vQoqeATdB1PhM5Whk5mYOvuzAZGDkLle2aaTLxttgUuPCbmfVP1+1ZGz3MUnGwpG8l0tQWztmrEPoqcVi0ktEIC2BDLWXUoBIr1HDmi1y8IY9P5+kt6WkU95jVl2VEN0PbZSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdqgR3Re; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731668829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Be/Q3Pv/gZYXqIqwnuQYODJ0P9sar7TAP2czlgo7NI=;
	b=cdqgR3ReE07wB67c5esPtHaq+VRJXtgZe46+nCezWfEyRyOxOCW7KELBaoRowak3UVoHCn
	F2kQ/hfS8UvipGEZA9dVhl8gBITNOfoGZquWo+qE4OUawZIHWWTbKyw/ZqJG84VXL4CAu5
	JqcoujIlDpn9Sw/5gQjN3+yKn+hNHTo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-eViNLZ2gPkqoELnIRm6bMw-1; Fri, 15 Nov 2024 06:07:08 -0500
X-MC-Unique: eViNLZ2gPkqoELnIRm6bMw-1
X-Mimecast-MFC-AGG-ID: eViNLZ2gPkqoELnIRm6bMw
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c943824429so1141671a12.1
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 03:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668827; x=1732273627;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Be/Q3Pv/gZYXqIqwnuQYODJ0P9sar7TAP2czlgo7NI=;
        b=c1j8gyWU1qZRW+RO1/e9tcnZDYv4IhJpSPcmM4R+W+4c163Q89zfwKAEoekf4yz6+B
         6elUNoNGzdU59C0zEJVmSbTPrrYwQJ3TV+CF5+ROTp9fvJD/VRWGNjMtpAzO8VcE4cnX
         ONrv40nSgTHId+4B9L/skM0sNVY4H7pGBnOBjcJGJu1mWxVCkrppvRqSwProgzUiyjkL
         kFFnoRXGyaRtyzhYOdfZGkYy8MgtqiSsTQ4AeoQANMsvHvdY3xszMh7b1H1C6MZibunT
         IlZhb0+syyp+GULooxwYobBQc19bkVtb0Wy0F0VDedqpvlcMO1XsvoORc2k4S+Fou0HA
         nU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqPVmxtbWE3sMS6HyknUOr0iIVfKlulwzQIEj8Ggpu+kUdzt1tzm12X6wprGfpc+jANys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNReDLvwnp/pPN/g26fgvY+0d5Y/98xlzHyslw1D4SfQ5Ue2k9
	9dtn+m34LUxjiw9sabIp1cNGGVKn348HYZ/SdoZpHP8xW/CiBYRRFcMZgD3MpLi+LSnTvtCjiuD
	izlzxnYEjTNOKbh0e9THT6ztS+k1fgzvSgkrtkFOr2XdTZ4kvOw==
X-Received: by 2002:a17:907:3ea6:b0:a9e:e1a9:792f with SMTP id a640c23a62f3a-aa48347e6acmr192610666b.25.1731668826837;
        Fri, 15 Nov 2024 03:07:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFErEXMy1ftFsgtlFkean6KMt2WjV+feVxB3C/tYQRW2vJwMK02kXKvbvss1qizejGe1PQew==
X-Received: by 2002:a17:907:3ea6:b0:a9e:e1a9:792f with SMTP id a640c23a62f3a-aa48347e6acmr192607366b.25.1731668826413;
        Fri, 15 Nov 2024 03:07:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df501f9sm167303366b.46.2024.11.15.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:07:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 964DE164D1A8; Fri, 15 Nov 2024 12:07:04 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ryan Wilson <ryantimwilson@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 ryantimwilson@meta.com, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
In-Reply-To: <CA+Fy8Ub7b1SXByugjDo-D13H_12w0iWzQhO-rf=MMhSjby+maA@mail.gmail.com>
References: <20241114170721.3939099-1-ryantimwilson@gmail.com>
 <CAADnVQJ2V6JnDhvNuqRHEmBcK-6Aty9GRkdRCGEyxnWnRrAKcA@mail.gmail.com>
 <CA+Fy8Ub7b1SXByugjDo-D13H_12w0iWzQhO-rf=MMhSjby+maA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 15 Nov 2024 12:07:04 +0100
Message-ID: <874j48rc13.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ryan

I'll take a more detailed look at your patch later, but wanted to add
a few smallish comment now, see below:


Ryan Wilson <ryantimwilson@gmail.com> writes:
> On Thu, Nov 14, 2024 at 4:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Nov 14, 2024 at 9:07=E2=80=AFAM Ryan Wilson <ryantimwilson@gmail=
.com> wrote:
>> >
>> > Currently, network devices only support a single XDP program. However,
>> > there are use cases for multiple XDP programs per device. For example,
>> > at Meta, we have XDP programs for firewalls, DDOS and logging that must
>> > all run in a specific order. To work around the lack of multi-program
>> > support, a single daemon loads all programs and uses bpf_tail_call()
>> > in a loop to jump to each program contained in a BPF map.
>>
>> The support for multiple XDP progs per netdev is long overdue.
>> Thank you for working on this!

+1 on this!


[...]

> Note for real drivers, we do not hit this code. This is how it works
> for real drivers:
> - When installing a BPF program on a driver, we call the driver's
> ndo_bpf() callback function with command =3D XDP_QUERY_MPROG_SUPPORT. If
> this returns 0, then mprog is supported. Otherwise, mprog is not
> supported.

We already have feature flags for XDP, so why not just make mprog
support a feature flag instead of the query thing? It probably should be
anyway, so it can also be reported to userspace.

>> I think it will remove this branch and XDP performance will remain
>> the same ?
>> Benchmarking on real NIC matters, of course.
>
> Good point. I will migrate a real driver and add XDP benchmarking
> numbers to v2.

Yes, please, looking forward to seeing benchmark numbers!

-Toke


