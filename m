Return-Path: <bpf+bounces-50994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695EA2F1C1
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BB3161AD5
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18B23BF99;
	Mon, 10 Feb 2025 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZSpO/DT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21391CD219
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201497; cv=none; b=XYQGa95w4WKJIhuXWl4NCSraEC+LiVxcQ/k3NevfngObSZiwZ+/NQlT3KzMzQjUetVwN3clU6zuAgLoBlZEUPrTgwVPMeb+W/wKSqxuvIHb6FX5bttPjBm7rtwv6X2gZ5cuLTGlzrPf0wBkjKUbrhhhI+hFSgR9JvQSUdjfftKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201497; c=relaxed/simple;
	bh=5xis8As8jO2Rt3mwgcf/kMRAOKhitW+ScGDLCUM47is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH+3mkbu0I1vFLN9s4y8lQcL7QxkvDDkbBfdPpO3kkNruALoKB819xIfnyCPjz//1k2avGIWbr2upwYBO0idh9oxo7oJKyIaq9VqHYwfqsHaa+V1a7fidDKa7nYcsGXxFg5EyAS7LlvjpiQkntmtxRiC0iBf8bzcOJcK+rZrExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZSpO/DT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5de47cf9329so5323102a12.3
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 07:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739201494; x=1739806294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xis8As8jO2Rt3mwgcf/kMRAOKhitW+ScGDLCUM47is=;
        b=aZSpO/DTLrPp5XzyAzg2zy0ia+GSED0iUcYxC+QiPQR4GRRHR1PVY29eOwoxBu1j1x
         FEgiJTkg5DCxqXlWPUaYeeWS7fti/jrXtN24h6VSN2MhvHDGix/+QywKoEAqJ8pJV+CY
         avasHE4ZV5kw9nY2Frfgc2WUNa6N7py0Z8bTzWvAKW20kD7b21oPELyBKz4kltdl3BOn
         fDjZViCtRnWpWBysy08VKLduuPt+pl7W3EcZ1I3Qcb1qERF5n10ZgUuvkUVtbqQJACm9
         8QsoJ4v4q7mJJdTCKtY21vtyNMARa1nifZ0d9VtKEPNKOcnzcv4Y1NayU5ffQlkRFAyu
         C0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739201494; x=1739806294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xis8As8jO2Rt3mwgcf/kMRAOKhitW+ScGDLCUM47is=;
        b=a/9aoyX4gGRRnpzBewO9EKTOAixGY1+1pehuwvbWYV1jne3SRd0dhrSgI3EnxMAPFM
         empKzGsEFGtP3FsjEIEMN4ibwuahPUKcvcuTnGJYMvzGJ3pBa2kau/0F/d/4XDvoJVpI
         +8G/0i2HwwJAm5Qq8LjB4H77/ZH/9qHEZoHyMHgxKr+egCR09jR7GPVK5h+Hq9Mly8sa
         Nnmqp4XFaTwFIam90fTslO6hrs5kU7sKnou8QYRHRhrkgWuI3bdvt4lGI4E8pHu+9IEk
         tDReyllnVHkB/iNLoS+8eX/I+AYNhjFbZ6zMTfloRYHhPheJeJHW/DIQo2CXGbzkbMzZ
         QBqw==
X-Forwarded-Encrypted: i=1; AJvYcCV+o5dOLKaD/3xUOlo7nUgkDdhVlJt1yrF4AebUfTlDigwM28/bWA4kB3zhkMfGvTLYeSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKY8ZLu9FM5z5LAfQMu54xvY32/cnx4kSMJKqXhMH+Idvrcptn
	3Pfc3tHyzYAlbEH6Ae4BMUyvkvDMHV6i96SPLKnTeo5tjmHcgIUAF6CfGDLQdRxghFfSEgqE9Q2
	BM9wAxS5iecDRLdXyTm2/sHTAXVTquD1LAp+l
X-Gm-Gg: ASbGnctpRF5Dj/uzwrQsChsBw6iFPll8wrIYdyDwE7JSVw3GdDX27XV8KsTqFiaR9bK
	iFTXxIXlJMtGLQYONYQ2EUQneBe62nhsNbV0SZc82QrQZYj36n1DhVntw6c9olMKFziJaQHNv
X-Google-Smtp-Source: AGHT+IGYIDEKbs6dmHrwg0RTMVkj/Q1gAgz9hIfVyXJeXBAoeGn345KmetsEUL3Ngq0krWxUFJbHxMyoe+5b2fWRQs8=
X-Received: by 2002:a05:6402:5214:b0:5dc:71f6:9723 with SMTP id
 4fb4d7f45d1cf-5de9a4645eemr88173a12.21.1739201493753; Mon, 10 Feb 2025
 07:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com> <79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
In-Reply-To: <79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 16:31:22 +0100
X-Gm-Features: AWEUYZlWeDdRtwGn76PnjMKTNXzuvPG4UPRC8NQ_4EEIUAmtn9Mnehmfqoc219k
Message-ID: <CANn89iLpDW5GK5WJcKezFY17hENaC2EeUW7BkkbJZuzJc5r5bw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] bpf: cpumap: enable GRO for XDP_PASS frames
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 3:10=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Wed, 5 Feb 2025 17:36:01 +0100
>
> > Several months ago, I had been looking through my old XDP hints tree[0]
> > to check whether some patches not directly related to hints can be sent
> > standalone. Roughly at the same time, Daniel appeared and asked[1] abou=
t
> > GRO for cpumap from that tree.
>
> I see "Changes requested" on Patchwork. Which ones?
>
> 1/8 regarding gro_node? Nobody proposed a solution which would be as
> efficient, but avoid using struct_group(), I don't see such as well.
> I explain in the commitmsgs and cover letter everything. Jakub gave me
> Acked-by on struct_group() in the v3 thread.

One of the points of your nice series is to dissociate GRO from NAPI,
so defining gro_node inside napi_struct is not appealing.

I suggested not putting napi_id in the new structure.

If you need to cache a copy in it for "performance/whatever reason",
you can cache napi_id, because napi->napi_id is only set once
in __napi_hash_add_with_id()

gro->napi_id_cache =3D napi->napi_id;

