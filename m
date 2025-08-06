Return-Path: <bpf+bounces-65153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E835DB1CD7D
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 22:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7BA18C538A
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E847621C9E5;
	Wed,  6 Aug 2025 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUtk5i5S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46071D7E31;
	Wed,  6 Aug 2025 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512547; cv=none; b=kptPkWeEQyEAMc+dWr/56CXno1Qz2cvivwkWPSd1N3m9Ie0dW6NkyegzOnmlhkZyIGa+Sf0F6GA+EySG4ByCP7D2gzRot+E14x1iseWjYxEDg0V2+rK8p9VZWFD8Qm2wDbWjEI7HidODNnfRLE7fsarYfHMeU8PjmJEVRDRoDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512547; c=relaxed/simple;
	bh=OZRTbOosI+HfV57rOwrfQhNgNUHJWvSeWn/Qed7pweQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPpYH8XzFJMVSZD2Hzt+H7FFdGGcyvtxkFAcSKdeXGzSeYqjVVSAE9y0UzVmnNSyhhLaUiTwci4w5ESWmHKY/HDs+S+kpnUfN34FpUqxbi9uU+iP2uv6/7SNs6T98JsQk0de/MqboKNSIGR/bMYql2eFaJtnPK1zbGWWxngZJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUtk5i5S; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af9618282a5so53792066b.2;
        Wed, 06 Aug 2025 13:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754512544; x=1755117344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVYj6hbGPS0zGIL23SIzAwXYmL/YqGovv0coXv4a9ow=;
        b=MUtk5i5SIBoRZSo6bkdtLEJxgCbRX1btJU9wzJmdfVsEPlit0Shsh31Swam0KSdGdK
         WH36eBVz/p5uAupSid8xO9vRu3NioCSvVoxrjbt4vx3ROcEAQzNCaslPlHzHNRtqj1Q7
         Ilm60bKknBYbo8ANWldw2VxhyltlGHG48/LMfXTshkbwrpyHN/2D14SndfrTXxvUPSjM
         RHuLWXUj4XO0JiP27WJxKuY4GMsxdxc3opNKvxgad25OoQrsxT7hEeBpbPVuYLXtSsbG
         OiMzs/P0fTtQ14aqK6PirwQtxkwoBjDLj7B852rz5xURTkYEeZO3j4O04CmI2zmgV/j0
         nprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754512544; x=1755117344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVYj6hbGPS0zGIL23SIzAwXYmL/YqGovv0coXv4a9ow=;
        b=cbZ3Ya0kEQCw1LsslkmKoBi2gJIyNx/H+J/Pyt/8szZjuPFbKvU2enwMkWTNfFCUqO
         YB1oZ63Hi8DK2B7YI+qG3pN9E/J3toErg3kZ73syGyhyDHhaNCYeIy34qsUUWqiBFU33
         9orf/DXj4kcoZvpR43R2dDgVKgBjIgFYqw0llb23CFHFg8jjKFE8WCFyAMdiNVUtJ8VH
         5+Q7NRG0qv+obyBNUX2DLiUTlSZeE7xRiOa0kNckGeUDapTL4jOcf39PkEFFbRui5TPM
         5DOkt5Y4ZGI2dhJreSnw7W5h8c1uo2Ortqok2SMjBJsN6BX9oLYzF0yBe9dcno6Sk4E9
         BznQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKhR/+3t2KhqNoj463lWdm872/+Ey7eIdSJvLuh1p2SnjpL8spofU9hHzCMi+bSJpC1DQkJcoI@vger.kernel.org, AJvYcCUctrhwKqc0aWCz11M7lQfM36o6MSObUNkp0IzOMRcVFKKrdMUjhUR50Lt3xPhiNVMRYps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4cMAR2BdNItxwQ/kcLEhyD7YW4HJMCoFevmt5vSDScANi/zb
	11bDiLfXZ3iOoz5/GNVJgPmNh3nUJs+fc0no2ovJM081Wey7zlG8WjkiToVegKz6JRd2rT6eRcv
	8Y3KR+GDof0U1TChukQCBpApmpxqfvzw=
X-Gm-Gg: ASbGncsoPiubzHSftZEOlfWllUBu7iZYEq/K73F29ELykgCgbNTqgHfRF6qamXYesa4
	+Ht9yL6nTMtXnChYmeFQIWYkt+MhrXq4ivXm/TzAnMhr8p2HrbYt3afKKSigNsF1R6qBdQgCxv7
	98iMqg6ZQ59WP+5Z+FcoM+3GIKXQjO9POMFLN26eyMk6JzNcHsKGJ9ZHGqOgLUTan7Hl7imppKA
	Q7v0SLZDRbcdQ88jQNCSNa2ftzq2zP19jNPOrf0+CPkFSE=
X-Google-Smtp-Source: AGHT+IHKDOX5aixOd1ei+KXOS1Ga7pkHe/x0FWQdj9rcIO/sKhWTTIp4Kr7jJqk7t7U3LqFxKZXR2IQfInMoBAQ+0Ag=
X-Received: by 2002:a17:907:3cca:b0:af9:5a60:3319 with SMTP id
 a640c23a62f3a-af9900959cemr437630566b.19.1754512543715; Wed, 06 Aug 2025
 13:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801121053.7495-1-dev@der-flo.net> <f871d538-31b8-437a-b838-900836e13eb8@linux.dev>
 <aJOhPoTLdYnZmHYA@der-flo.net>
In-Reply-To: <aJOhPoTLdYnZmHYA@der-flo.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Aug 2025 13:35:30 -0700
X-Gm-Features: Ac12FXzbiG0z9783v9tVISOKGHouMioXSjY--G47231-u0wHXQdQY_jWWq4pSWU
Message-ID: <CAADnVQLJGNq5SqwuNcqMCxg_YbxH8R+QOrzZZrZSyRk75_zt5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add LINK_DETACH for iter and perf links
To: Florian Lehner <dev@der-flo.net>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:39=E2=80=AFAM Florian Lehner <dev@der-flo.net> wr=
ote:
>
> On Tue, Aug 05, 2025 at 02:07:20PM -0700, Yonghong Song wrote:
> >
> >
> > On 8/1/25 5:10 AM, Florian Lehner wrote:
> > > 73b11c2a introduced LINK_DETACH and implemented it for some link type=
s,
> > > like xdp, netns and others.
> > >
> > > This patch implements LINK_DETACH for perf and iter links, re-using
> > > existing link release handling code.
> [..]
> > >   static void bpf_iter_link_dealloc(struct bpf_link *link)
> > >   {
> > >     struct bpf_iter_link *iter_link =3D
> > > @@ -490,6 +496,7 @@ static int bpf_iter_link_fill_link_info(const str=
uct bpf_link *link,
> > >   static const struct bpf_link_ops bpf_iter_link_lops =3D {
> > >     .release =3D bpf_iter_link_release,
> > > +   .detach =3D bpf_iter_link_detach,
> >
> > Not sure how useful for this one. For bpf_iter programs,
> > the loaded prog will expect certain bpt_iter (e.g., bpf_map_elem, bpf_m=
ap, ...).
> > So even if you have detach, you won't be able to attach to a different
> > bpf_iter flavor.
> >
> > Do you have a use case for this one?
> >
>
> A key reason for adding this was to enable the temporary disabling and re=
-enabling of
> an attached BPF program while keeping the same bpf_iter flavor. If you do=
n't think
> this is a strong enough use case, I'm open to removing this from the patc=
h.
>
> > >   static void bpf_perf_link_dealloc(struct bpf_link *link)
> > >   {
> > >     struct bpf_perf_link *perf_link =3D container_of(link, struct bpf=
_perf_link, link);
> > > @@ -4027,6 +4033,7 @@ static void bpf_perf_link_show_fdinfo(const str=
uct bpf_link *link,
> > >   static const struct bpf_link_ops bpf_perf_link_lops =3D {
> > >     .release =3D bpf_perf_link_release,
> > > +   .detach =3D bpf_perf_link_detach,
> >
> > This one may be possible. You might be able to e.g., try a different bp=
f_cookie, or
> > different perf event.
> >
>
> The primary use case for this feature is to allow for the temporary disab=
ling of
> uprobes that are attached using bpf_perf_links.

I guess the use case makes sense, but pls provide
corresponding libbpf and selftest that demonstrates such usage.

--
pw-bot: cr

