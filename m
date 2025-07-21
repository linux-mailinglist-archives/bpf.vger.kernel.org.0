Return-Path: <bpf+bounces-63896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861AB0C136
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1F5402E9
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF828EA55;
	Mon, 21 Jul 2025 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByCMYwry"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975628D8EB;
	Mon, 21 Jul 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093364; cv=none; b=ZQK/N/uuxdk7QD8uTHNVkTYS5itAifOaKAkIe7c4uQJzJK7WeTMEiMAFvNdjETF0+8tmzMN+t6uu7aXZ5lJ+boM2Piunz0phrJXy8nwiWaTXiCITIsowX1yte5uN413s/79PHaz1XmJlzVsrAVoTLGLg2s8rWoCQzrdXGIJYVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093364; c=relaxed/simple;
	bh=9kolATwxanaQ4eXtJNZBmhJ9zzf7x+nrcF3EIRCywBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H26/8S8P3HFX4D84qN7ioxadVM9eXutQR/SkNhSl4iP1RuDaUOkTvfhv5QFnPHwtiDzgE7PNDzE6lgfqDBBX+iagd8GNiNZ0wIFCVlGkQwqD7JdXb+3BuwzPpjWs6JwHFI9tHRGgF4Vx0qqFiA80OjnzoCzhuR+HFGpcz0HFnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByCMYwry; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-87c14e0675dso86935039f.2;
        Mon, 21 Jul 2025 03:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753093362; x=1753698162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHEm6bHDLYflRAkB3nDyc8N9yM14dw/BsI6dT8qL9b8=;
        b=ByCMYwryX9lhUydg+HGHHwESnRoHFSxrCVq+0gJxlxmexw+tARDhU1ArCmXjQtmm4c
         UJZrT+hPChVxA0fyjxqSmzD4ehjNZQrhp6xDQs6A9WGi//CGcsaVFh/LzxnZEykzt0lf
         w+aMmM0/HTYTwbQRyJf1yyLa7rciFjbuj24DYM+jDmFV6kz4PPffzF1M9Ue2WrOlq8Dn
         52G+RqTsEHSYr7C1nOhhKyncEo3YF8BdRcSmMWoV2UNgfqL4JDwsPzjWmR2N9w/jt6YP
         7e4xF1qTqg+NkXnNmcvG2RkEwWB67GG3pTUbr5WrZwrJdUxTUo2bT7Y2UAAAlMZxTTIg
         g4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753093362; x=1753698162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHEm6bHDLYflRAkB3nDyc8N9yM14dw/BsI6dT8qL9b8=;
        b=bV1IlzT4a3dsMxAG2Xt+5dgGLU1Qzy8KpupMVmWQ6NiT8oWZzlpufbCQWSK1RO39Qs
         688BJdayn5g5hKclUyhXiD1Kd41BnXwViytbuNjDOhIQVvrE2LszVtZdCIdX+G8p/g2f
         voLyHgyFrNcdEABjTdOst63CYCnB67e/SK8anILGSDhm/hPPIYMzOE8uslpv2s+9ecxH
         ZIO1QnlmT/fRUuL6D8c6vKbc638wI9CcYjppeShu7I0GvTt8D+/k9JBbZ0PdkAQI9qtx
         NRb2YERRlOkn0lC8G7cJOnqQX9+c+V+EAMinIQ24njT7cd+OtE56Hpery5YhufWK452l
         dMTw==
X-Forwarded-Encrypted: i=1; AJvYcCUkUlkY5xp4Z7rqSnVepw7OUKTV3FRNtiDVtC9IFA/e1IZBHEsv0UIsk+MdjVg9jW7txZU=@vger.kernel.org, AJvYcCWOmll4AvHNyBXasEwIxOPkyiSx+em6ev0ehIk4XvOikzJkL8xURzqThA8MLPYzbYNCAyUS5pph@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDERI7W2yILdlVM0pgr0TaGgshKfgU9YGkPSMP+uJUhisNJ3g
	V/3FtXAae5JqZGHY9Q9+7/ddeR5gyEVcaNPSZMxRdB0iJe/bwxq8BsTEmmwr5M4GFcUFXGllxuY
	59nEyH6WEh0fE6L90cMrg9b0PMWqkZxo=
X-Gm-Gg: ASbGncubBlXiMl2TroIpNZhhSCRhrRnP4soGZHlX78FP51z9qXKXLL1uwxEelVYxKpH
	82gDMvblj2uLG5xFrKCXTuwAwMzc/jndm5Z+3hqGvNS046MU+PCjYaRmk35ENPJR+aETyntMd/k
	SkrYfvb3uIW4omnCIDv5q6ZxTyIov5OVwzPZKSzK0uZuSq4xXheZMOwpJAm+uWlAxP0fpj+W7wE
	8E0qyi+yu2xJQb9FA==
X-Google-Smtp-Source: AGHT+IFXBPH0yx8S02iqQkJZIi4L0Jm+RaJLQnvPek++YwE2QGcqsWI+nl8r2YrcQAJo6zGNTHvEyQhndIVsVoiBNsI=
X-Received: by 2002:a05:6e02:1806:b0:3e2:9e93:b673 with SMTP id
 e9e14a558f8ab-3e29e93b68cmr100435465ab.1.1753093361694; Mon, 21 Jul 2025
 03:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-3-kerneljasonxing@gmail.com> <20250721101217.GC2459@horms.kernel.org>
In-Reply-To: <20250721101217.GC2459@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Jul 2025 18:22:05 +0800
X-Gm-Features: Ac12FXxglQj0R4EkMw3SzP0qFiFwMjjIS-PnIkKo_EqhulukoCpP4A9yL3kNbVo
Message-ID: <CAL+tcoAEtRVvX5YkK980OtfaKHAf2+dw+WFR-HwPO2GO0nemyA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] igb: xsk: solve underflow of nb_pkts in
 zerocopy mode
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Jul 21, 2025 at 6:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Jul 21, 2025 at 04:33:43PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > There is no break time in the while() loop, so every time at the end of
> > igb_xmit_zc(), underflow of nb_pkts will occur, which renders the retur=
n
> > value always false. But theoretically, the result should be set after
> > calling xsk_tx_peek_release_desc_batch(). We can take i40e_xmit_zc() as
> > a good example.
> >
> > Returning false means we're not done with transmission and we need one
> > more poll, which is exactly what igb_xmit_zc() always did before this
> > patch. After this patch, the return value depends on the nb_pkts value.
> > Two cases might happen then:
> > 1. if (nb_pkts < budget), it means we process all the possible data, so
> >    return true and no more necessary poll will be triggered because of
> >    this.
> > 2. if (nb_pkts =3D=3D budget), it means we might have more data, so ret=
urn
> >    false to let another poll run again.
> >
> > Fixes: f8e284a02afc ("igb: Add AF_XDP zero-copy Tx support")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/eth=
ernet/intel/igb/igb_xsk.c
> > index 5cf67ba29269..243f4246fee8 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> > @@ -482,7 +482,7 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct x=
sk_buff_pool *xsk_pool)
> >       if (!nb_pkts)
> >               return true;
> >
> > -     while (nb_pkts-- > 0) {
> > +     while (i < nb_pkts) {
>
> Hi Jason,
>
> FWIIW, I think using a for loop is a more idiomatic way
> of handling the relationship between i, nb_pkts, and
> the iterations of this loop.

Sure, I can turn it into 'for (i =3D 0; i < nb_pkts; i++)' in the next vers=
ion.

Thanks,
Jason

