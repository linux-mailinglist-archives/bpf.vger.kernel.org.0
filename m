Return-Path: <bpf+bounces-64554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51BAB14217
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67B73A8927
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E0C27603F;
	Mon, 28 Jul 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMZXU9wA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8E2749E0
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728009; cv=none; b=i8BCBwV213eyMuRRMA81YYniUuHZJYvn6S9Tm6Wvs+zNfCIaM4r0XTqRBAylBwI3iccKZZOcK6panYxpxKgqbsQj5lKZzev7rw4nmJ48PnAHqT2o2GTJacFz8YgLpt4oOoyQRQNJyLfA6MlQo+Y3OhW6kddZL/qh5o2RQO9ct2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728009; c=relaxed/simple;
	bh=1kduXqhDQx0EAmkUNAhxPUmcHTqcewsbG3fh7mj6lrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDYw0k34qY5d1b6537j7jqx4IiLWAQ+p/GcTyf7gZ/45BwQp6Xt9x8nDYdZi9egVPriAh497S1Fyieip2onx7Zi2s4RYeDEy7N+rllj9XGE1xVpA7h7U1UkzVIzzKegAtBmnXGtjefahJhBsiAvzyEs8Oe2CtAbnwiXd6usqW8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMZXU9wA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so25925ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753728006; x=1754332806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kElooT4IAHvVgVX9pYB8yevgu/UwFxeJsat70xy7zh8=;
        b=YMZXU9wAN6Aysq4xnuQlAsDlrQLRbChbeYQIQKx6FdaFycJe+XINXD0KrjfLlGGFWA
         JtlB3xc4kMRmjuXIEseJC/MQRoIkbmc0saFgV+N1ONkgnVA0DN0beOZYWdWpEbJyD+x2
         rmahNsGA0GZGvuM4lGw460bnPxpCq6eW8c6i5Yh1CC4MC4GreWhY2EM/sUjnUFTIXzS8
         as5dZ1BAVQkHI6E/kooZkIHz4RDhpcvOeXOdx6tl8ZcTzE8YumLbNOWfzP+Xt/9W59xX
         UOIGr7lHZiNwXXrNi4RnB6QQ1r+NifBAHYiXMrQ8xhS7dIFEHP4oIiOKsrV8M2r9pe0y
         XPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753728006; x=1754332806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kElooT4IAHvVgVX9pYB8yevgu/UwFxeJsat70xy7zh8=;
        b=ez+q4ZaYZJE9sENUGtVS7UknBQzU3iz+9oJfNFtOWJ5K/5LV0kiXXz39r0fUqN/o7r
         pUu9AW+GqHkFxt1gGThsZwyfBF+UeX2btRRxzFF6H03wMPUFV/LLtwVK7frv0zyNwYa5
         yBD3Wz6HN9K4eFPconJBV3lI6+xCaCAiJvhxBmER+wGVsUxDJfKgpin1pa2XGhSS2Z0r
         qeOjWk6IT/34iYsAht6WGnFWKqPbmk7Gu4BJF/WJA+6FgDt75yv1TWoNCP7ywCXz6Vrk
         PkARJGKWHHh4v/cbfquoHBlokg8uoAkMmm2aFsMSJljLylXi0F3nWDFodYuP3z1N2goG
         IP2w==
X-Forwarded-Encrypted: i=1; AJvYcCUXM4kAPr8i7dvIVkYozb9tw5andF1JJz6U4I1ZYjRSfQcuDUbTYC2IsvSCl52Zv3djvK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uW5tiR+EaNs3ureaWsQYhUG8njc+xUG2kCTYm+WonYeKWVX6
	5sp9LlhWK35+HbB8Lgtsy9pB10wNP52u0+9mYjNag8JFRgDR96NThD6o563r3BFYGOF0J9RR+WI
	AIRByN4jP8XKzrGaGDjF3pb0AgKkyKaA7tA9gYk79
X-Gm-Gg: ASbGncsx3IqLzOa9QccLu2kNMuKtfpJZ35AHeW7PmWg6lKc/IyHfUXhzeXB0WL6lCki
	LZhuMkTOecfuKN1oMMCtF9geWgNqtGQ6G8EmEG5npnDovE92hHbXhkCi9SbaFiTMmiKAtfKCK48
	5hI1/gtweznLguH34GOQFL8BUaBTKbZUiKev8oaH9OHcr6SOzcTRCaBNKh2LPQmT7Kwhkb6LUe+
	zgwkHPTGN6Cu6ZMdqAAZTgnfDvt1TUwEGdw+KrPJWFo678olCdrgfl00GM=
X-Google-Smtp-Source: AGHT+IFiTjDeBpEApQbF4hYs7HgiAPbvdpocoITXlbamYX87A4mT1jZoFeAsOSv90fvuk8ivllMPYW7JIqK28FHHq+4=
X-Received: by 2002:a17:902:c949:b0:240:2bd5:7c98 with SMTP id
 d9443c01a7336-24068ef8cdfmr240575ad.11.1753728005408; Mon, 28 Jul 2025
 11:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728052742.81294-1-byungchul@sk.com> <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
In-Reply-To: <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 28 Jul 2025 11:39:52 -0700
X-Gm-Features: Ac12FXzdEF9xaTcLfGhZyp6hzC9OOZQrKTg5nGgx21xEL8_A7PY-4QwgLa-JD48
Message-ID: <CAHS8izO6t0euQcNyhxXKPbrV7BZ1MfuMjrQiqKr-Y68t5XCGaA@mail.gmail.com>
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page pool
 in page type
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:35=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 7/28/25 06:27, Byungchul Park wrote:
> > Changes from v1:
> >       1. Rebase on linux-next.
>
> net-next is closed, looks like until August 11.
>
> >       2. Initialize net_iov->pp =3D NULL when allocating net_iov in
> >          net_devmem_bind_dmabuf() and io_zcrx_create_area().
> >       3. Use ->pp for net_iov to identify if it's pp rather than
> >          always consider net_iov as pp.
> >       4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
>
> Oops, looks you killed my suggested-by tag now. Since it's still
> pretty much my diff spliced with David's suggestions, maybe
> Co-developed-by sounds more appropriate. Even more so goes for
> the second patch getting rid of __netmem_clear_lsb().
>
> Looks fine, just one comment below.
>
> ...> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> > index 100b75ab1e64..34634552cf74 100644
> > --- a/io_uring/zcrx.c
> > +++ b/io_uring/zcrx.c
> > @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *=
ifq,
> >               area->freelist[i] =3D i;
> >               atomic_set(&area->user_refs[i], 0);
> >               niov->type =3D NET_IOV_IOURING;
> > +             niov->pp =3D NULL;
>
> It's zero initialised, you don't need it.
>

This may be my bad since I said we should check if it's 0 initialized.

It looks like on the devmem side as well we kvmalloc_array the niovs,
and if I'm checking through the helpers right, kvmalloc_array does
0-initialize indeed.

--=20
Thanks,
Mina

