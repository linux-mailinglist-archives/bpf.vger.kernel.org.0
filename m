Return-Path: <bpf+bounces-61932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA61AEEC65
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDE63ACF83
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CA71A3155;
	Tue,  1 Jul 2025 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqFxtGTT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4441442E8
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336425; cv=none; b=Ye2zTPcKQysVN5ax4pQManRpeqHo4vonlLKLUHR25MKrABfqm6zdI7SeyLL2FNa5i4IfvRvMzUwUSjhSmsnNgfpaAiEtukCwvv4uQgBjdl+Gius0TuVFUZ3cbRe8mnkvXV9PY8LIGgeMZoQMmfLFPBvn97qbio5lMzYRSMPEhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336425; c=relaxed/simple;
	bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3CWLlHjvp8RfYVcSIHD691WaVS24HxNDM4RU2P3lefeq3V/guJD0T8z3Eih9xaYs7+O95gsfpfotAGai1HPSd/HiyIUWXbOtsx6hmzVLmlTbZeiI0Df8Kg5FvHPRikY3uGSlZ6ceNw/yOOW6Ot1VBuSBBHo8EBx8cIj0BiwwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqFxtGTT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
	b=TqFxtGTT+Xl6hV9PvImmZ8naU+2SeXAa0BWxPSkCSB+6r4gn7fpPTwDH6kTP2OaIeVFz0X
	DRpzfvBALO1PAj3rd/IZFhbpWJh5U4rbrXDpKFJF1eXD9i7RxIlE69VxNeuJbRh5RN3ANI
	d0JluGzzKDA0nb8/CrFblcdiQCjYYzo=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-xUyLDdSXO4m0uCaqR2-V1w-1; Mon, 30 Jun 2025 22:20:21 -0400
X-MC-Unique: xUyLDdSXO4m0uCaqR2-V1w-1
X-Mimecast-MFC-AGG-ID: xUyLDdSXO4m0uCaqR2-V1w_1751336421
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5314cb7972dso727344e0c.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 19:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336421; x=1751941221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
        b=OhsjpqW8x7ogoQkZpbg+CqVf1XHz0Dqu4IErHMV+oZV6YoUl6EGbmZ5sPJLmXwlQ7i
         fEIfc0eshrKCIj7s0G11LUJ1beabc7bPvTKZvHlz1lkLjGnS3MZEahKsXx036Cc0SKjY
         yFMTgqpj39JSRBTmxxN8iUmTOjbfL/iCPU+DrYHunUd7SxPrB4vdNKW12f086UGkektc
         4qzodLRM/D6xhCa+2cp/+ztvXVJATy1zxlx6jryz8FacmOwA3nodAEtTDwVLx06FCrOp
         sFJ14d37N8lzN7/Cl4iz+95ExEraQi+weM8CFnNeNakzHJs/lUceSSdYDB8UxWQjvMas
         73xw==
X-Forwarded-Encrypted: i=1; AJvYcCWntxX3HyP+5lPfunkBO2PROJhCatvlNSohNFQ5DN7+gAcs2m8grX0I/E3HEl0qho2a18Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9OmiQ75vghhF61Kwmpyx78gFvPTu/7EbAOex0tZxxaLMZVSX
	lerAy2eymNOfEADliFlVd0PqYiGY6Q1RBrS0zdGcPHRNbmWfkpoDUbNYScKyngONkoQHr8wi1vw
	/qWzVcAylfpesftxbBENnCN4ghHwhV2eQvJp2Yw/NMGb3iI8EAEzJijdEDrgPhR5jtENpycJTCe
	11r5rCZ+01FjujcsfdaYEws/TotPDd
X-Gm-Gg: ASbGnctsUOPU7fo5RKoxWq5lYNjoVwCAu1cSXqfwYkZWKNVNuVhW+CJRP6OuPoWZz+h
	RXueSBwAL3Czgvl8uJiM41F7nHN0eAeez9g2lZizr3QFp7QPMTjllLdynVMjM780uDpUywCReA0
	Om
X-Received: by 2002:a05:6102:2c05:b0:4e5:abd3:626e with SMTP id ada2fe7eead31-4ee4f9e6313mr10405280137.24.1751336421325;
        Mon, 30 Jun 2025 19:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcgqA4GY5HeNzIXNDy3m2/0QUTCkMPWazV2oM4SlXLsY44Iog87PMmTUv3dD5hme1ectzbCFF6OxMHcOYRnvk=
X-Received: by 2002:a05:6102:2c05:b0:4e5:abd3:626e with SMTP id
 ada2fe7eead31-4ee4f9e6313mr10405270137.24.1751336420966; Mon, 30 Jun 2025
 19:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630144212.48471-1-minhquangbui99@gmail.com> <20250630144212.48471-4-minhquangbui99@gmail.com>
In-Reply-To: <20250630144212.48471-4-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:20:08 +0800
X-Gm-Features: Ac12FXzTGbPc8d1stXK-UyjLYhm6Mh_lf0LlWolyX6yBYCOFZ2SRlUxOM8CEHbs
Message-ID: <CACGkMEt9za5v2tWDBOs_1d8nCk20CC4XyadszKB7ezKRz=sBmg@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] virtio-net: use the check_mergeable_len helper
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:43=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Replace the current repeated code to check received length in mergeable
> mode with the new check_mergeable_len helper.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


