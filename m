Return-Path: <bpf+bounces-54958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA1BA7652B
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436E27A23DD
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C61E3780;
	Mon, 31 Mar 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVdg0TaW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794653FFD
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421681; cv=none; b=iLJw9EvdT/wjJNAKmE5gSkl7CgPNxI8uIvL6u529hp63lWfGn88jTxbcXrGpZ42bWqOA8kSyAzr7qheGCqxzAkECOAaJvSIqfXNhCHJ3jjXzdlis2+35zLN66bVQHx3j7Lt27TcyX7/oVBbeUiDjpgsDcz5zLoBixdL91/EYW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421681; c=relaxed/simple;
	bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeorAvZ8OgLIhxjo9IukIMKO/yzMHZ5IVZkL5ycMXPIH8E2b6UE32YRQ5edzRwPS957zYsmN1RYt1Ujv0+4z2NYZBkGszHm/lDeDz/4v3OnqANCmZlvp4jkh/OKEaBx+c9L+k/BuPPNSe0kKTKPojUG+mDyllAg+aeyVJ71VgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVdg0TaW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743421678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
	b=IVdg0TaWCdtV5/OIXUW7BVWyphAyE/LJeXQY2DnEjcCyL2/7XtgyWf2OywWPZ1r3PNhb1c
	ZA305tXeZDuLbJl+Bqpz85B/K828fEWuNFMm5Xek9+XTl1vKyZtg7Ad+SagtHMGAHBKaso
	StSz094ErrSsT1veEo0YGI8rkS4AVM8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428--awEjCBjP_uUD2KBdBcHzQ-1; Mon, 31 Mar 2025 07:47:55 -0400
X-MC-Unique: -awEjCBjP_uUD2KBdBcHzQ-1
X-Mimecast-MFC-AGG-ID: -awEjCBjP_uUD2KBdBcHzQ_1743421674
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac737973d03so145778666b.1
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421674; x=1744026474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
        b=XunpUl60QwPz59uJIX377WV0KX5Cd2qmskgGIRlM25gpt/FVOjNnrmuN4r2ozIoyyd
         3oLKJHHo7UHK/J/r1caskhxtEwUU2J0QqesMQ6tVhJa+RYNAIQwFUj4opue/4Y/YgpsB
         RZD0iie+gWLjbKm/shP7/I6UEHTYlVn+5ryvTWouprGbA2TAhcw/0XtpTkH1rZS50Cg2
         If5ldAA2fumWoV9IV6aSmDun2uJ3lIiQKO9fwlF8HUjkAyrIo4AERlXmg3uooKdGpl7z
         XS21GD4oQimgMsk+IeoDnCWw9D642DlQqk5nWCkytQ+Ds8/8YkWrX4a8NXtBxVVSuNOO
         HLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIlpfHxGk+8q9ZywYQltsGWhpKQs6EqLndwOCVZFaw3VbciM/FgxLLgI8e3xHL2UxHqSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczqrYQzy8Q+ZlgXvihTX1HbLLliGn/p0svUcmNqacdpPq1Kas
	qeEL6ip7LCm7l9mJ75k6rAi6Wv1tugulq6NVvuOcffKwfseeGDJ6BXH2aCOiGIg16pQ6khFu2p2
	XW2fDR2PmC5XhVaS/s+6gU04TE+rvQVA9qbytTmuLRZjypZapUnJOTHask11FFjfP0jSneLi+R2
	qpDN0U2I3hje/UDXU6rbD2gY5p
X-Gm-Gg: ASbGncspOzKaxEcj/iK3x6nNbi3cENRQT1KkDF6ICQmOdABx4AzI/FPRkNGJjdHg+8E
	Skk4hlsz8mUib4KsSMfsg/uVqOPclFh9IqfdkBxvkVRACkB1Et/GQ7VYJcs9G0SFp9XobrRXBNA
	==
X-Received: by 2002:a17:907:7e88:b0:abf:4b6e:e107 with SMTP id a640c23a62f3a-ac738a374efmr776688466b.25.1743421674157;
        Mon, 31 Mar 2025 04:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRmb2sP6u1Kcqc9voC0cuFc8cG9X4wanJkzT5G0J8qfH5D6leVLiwsM+zFjfRL7h+LKaFEAz4OgYXd5DAAjI4=
X-Received: by 2002:a17:907:7e88:b0:abf:4b6e:e107 with SMTP id
 a640c23a62f3a-ac738a374efmr776685266b.25.1743421673726; Mon, 31 Mar 2025
 04:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327134122.399874-1-jiayuan.chen@linux.dev>
 <67e5be3c65de3_10636329488@willemb.c.googlers.com.notmuch>
 <17a3bc7273fac6a2e647a6864212510b37b96ab2@linux.dev> <20250328043941.085de23b@kernel.org>
In-Reply-To: <20250328043941.085de23b@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 31 Mar 2025 19:47:16 +0800
X-Gm-Features: AQ5f1JpaEdK08-KL1Gf8Ek3oojs8QnopOUqDVrhQ8D9XsTzqJ71WtMtHpHShaOE
Message-ID: <CAPpAL=y2ysE6jJgVYAOOx9DQXOYkR627LF1nusb2-Jwx6gXR8A@mail.gmail.com>
Subject: Re: [PATCH net v1] net: Fix tuntap uninitialized value
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, bpf@vger.kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch with virtio-net regression tests, everything works fin=
e.

Tested-by: Lei Yang <leiyang@redhat.com>


On Fri, Mar 28, 2025 at 7:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 28 Mar 2025 09:15:53 +0000 Jiayuan Chen wrote:
> > I'm wondering if we can directly perform a memset in bpf_xdp_adjust_hea=
d
> > when users execute an expand header (offset < 0).
>
> Same situation happens in bpf_xdp_adjust_meta(), but I'm pretty
> sure this was discussed and considered too high cost for XDP.
> Could you find the old discussions and double check the arguments
> made back then? Opinions may have changed but let's make sure we're
> not missing anything. And performance numbers would be good to have
> since the main reason this isn't done today was perf.
>


