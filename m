Return-Path: <bpf+bounces-59093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A1AC604E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598E59E7543
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9FB1FF610;
	Wed, 28 May 2025 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9CNlKvl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367151F4CB8
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404188; cv=none; b=fB2rBWC4XDfPR1lFUl4Ym2lDgh+usFop2Rt++2G3WiQHHA1CH2gMQB1aOq7ggq504XEMHXO/z98dtdPDD27hNn1525QAjUWGePz1KybXKp/oqvw1O3SpdRsq5+tx7uQPGkn4hBkYWFKuM7BXRiOLdRjtKf+9cDONsDXD7KbDlQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404188; c=relaxed/simple;
	bh=djgdSAqo0lPl/HQxOwsgy/FVp3+EiXLFi0SERa4skTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiN8SnJPXhQfcwso4wPoK97NAFClybN8ePRFtdoMUbJRJFnNJRC1TkiBUEBm8QREpSILqX3Zo6b1TKKJhqOTsEQZYj3vwX2MqnxwpC6eCrUhTz3yluokLGugS8DCA1mY8HBhAHY3lulVG0BMSMmV5FuS98pT5GtRZ1OaPaxPL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9CNlKvl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2348ac8e0b4so74685ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748404186; x=1749008986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIZ917XmidCIU+2XIPpmQyQty1mwxL1YD04GjAwgej4=;
        b=B9CNlKvl41Kxuc113WpagkzE9M+sDe/xnaBs2VeARYd+Zgyp82c9VM+ydGEpb0hFd7
         vmxq6Cnbjbrgym1zVKbmRjvkOdW32JHbkDUmrlS9rNf1JYkQPwCVWmGlO6/e0O9NklEf
         38JHk+QSsSqpH6we38dBTAmwjzrMIByMCBDXjNNR2ctpB/mT6H7QRLlx/+c+Fd/T1qY9
         VWnPPGENMMW/SCR4eyj8OHoV8rh4AKVR7LgzvNTQTwgZ+bsOaIWj4JHyrfboCI3KLL+o
         dGwNhsedWm6V9dOssnqKT1hmTOh+XITf9j9BsHyZZecBvrD3YEysWmi1Fkmwgk2K50zl
         yQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404186; x=1749008986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIZ917XmidCIU+2XIPpmQyQty1mwxL1YD04GjAwgej4=;
        b=NcQF6OLlF0FgOAxtEGCg5k7Jvp36dKm1oKmR8rf6z29m6CRGaewL4GxgpxpTnsgaCe
         FAGl6KvTOOLQoFmytXxYcAAnLcM/3zao+G6QmFo2HIu0dHNBcJm+hN9Otg1r7T0miJOz
         NNvHFe2mQKwHimhN9jzJkDUzH7kq1jk81M2RcrB/PTL9RVSn6FrSN1d0gtDupVAB9l0I
         y7uuunoNjkVwTmVwtFH2m7anzwzMwLGqH2iwhCNMUe7TYfrVkdf2oRNV8ghYP4BgGRvS
         dzETpns5bXbxQhYM52vPMu/u8kR2ZUeCXJxFlbEIMfedJyPhbNKJ4eRUrkfUvz58ELHD
         0elw==
X-Forwarded-Encrypted: i=1; AJvYcCW5kno1heDHUKsfOBOVYGEw+uL4dUPT9TOv3gEFL0DMNWg5E86j606pFRpaf4PhxhgpjA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxXqqGbupnna3rCjVZLCXf2zoTJE3eDzYejMs+bRXy7QRgx9A
	qyjCfK7ujWj1BQtQBxXZfE6gj8ZNIjW8gMue7Lr3asMFyO+qpVScGm3F84XDijM6ZF5HXMzfOzQ
	M7R0w/qZmbEGjW08PLpAletsNLmRA1aQNzPl2gpMU
X-Gm-Gg: ASbGncsobV2HyGURe9iqX5lP9AQLKHe3BCT477hvR4kqVjK7WyS7IcHypKbsMof81Bl
	3KCfGP0oavaBbo+lP8/mQWaiE6BLlibiZSyBbqENF06Zkece0JRgFIIwMBR/TZRkJ2gt4m2b7tO
	Te8H+zx/RcVufResOtbem7UiY/UK4XXs3X/ailfXkL3RAy
X-Google-Smtp-Source: AGHT+IE0LA2hqEVRyMO5ehQLuMQWJISVX52TwhBqaChHomSUcjr9ODU+fXdJxaZJ3LyPuCydsHtGJxM8rzUNEZb9LPE=
X-Received: by 2002:a17:902:e5c1:b0:234:a734:4ab6 with SMTP id
 d9443c01a7336-234c55ab4efmr1948105ad.26.1748404186143; Tue, 27 May 2025
 20:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
 <20250520205920.2134829-2-anthony.l.nguyen@intel.com> <20250527185749.5053f557@kernel.org>
In-Reply-To: <20250527185749.5053f557@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:49:33 -0700
X-Gm-Features: AX0GCFvTxVjd0Vo8S2abHdtE47I2E4xaEIIdVVQqhBxVl76iI_vqc-Ts1BrIJUw
Message-ID: <CAHS8izPope_UOF7saHHxaJSgqHWJWZvEKmp=0x6sB2OJAghqUw@mail.gmail.com>
Subject: Re: [PATCH net-next 01/16] libeth: convert to netmem
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, michal.kubiak@intel.com, 
	przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 6:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> > -     dst =3D page_address(hdr->page) + hdr->offset + hdr->page->pp->p.=
offset;
> > -     src =3D page_address(buf->page) + buf->offset + buf->page->pp->p.=
offset;
> > -     memcpy(dst, src, LARGEST_ALIGN(copy));
> > +     hdr_page =3D __netmem_to_page(hdr->netmem);
> > +     buf_page =3D __netmem_to_page(buf->netmem);
> > +     dst =3D page_address(hdr_page) + hdr->offset + hdr_page->pp->p.of=
fset;
> > +     src =3D page_address(buf_page) + buf->offset + buf_page->pp->p.of=
fset;
> >
> > +     memcpy(dst, src, LARGEST_ALIGN(copy));
> >       buf->offset +=3D copy;
> >
> >       return copy;
> > @@ -3302,11 +3306,12 @@ static u32 idpf_rx_hsplit_wa(const struct libet=
h_fqe *hdr,
> >   */
> >  struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 si=
ze)
> >  {
> > -     u32 hr =3D buf->page->pp->p.offset;
> > +     struct page *buf_page =3D __netmem_to_page(buf->netmem);
> > +     u32 hr =3D buf_page->pp->p.offset;
> >       struct sk_buff *skb;
> >       void *va;
> >
> > -     va =3D page_address(buf->page) + buf->offset;
> > +     va =3D page_address(buf_page) + buf->offset;
> >       prefetch(va + hr);
>
> If you don't want to have to validate the low bit during netmem -> page
> conversions - you need to clearly maintain the separation between
> the two in the driver. These __netmem_to_page() calls are too much of
> a liability.

Would it make sense to add a DEBUG_NET_WARN_ON_ONCE to
__netmem_to_page to catch misuse in a driver independent way? Or is
that not good enough because there may be latent issues only hit in
production where the debug is disabled.

--=20
Thanks,
Mina

