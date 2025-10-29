Return-Path: <bpf+bounces-72668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033FBC17EEB
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9423A9D16
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7E2DECBA;
	Wed, 29 Oct 2025 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn/50x1L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B72D063E
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701846; cv=none; b=TEW/kpAMUM5gTGsAaEVNDSRV7wiF0l1jYmv6cqNbcsVWjMW1+jXMwKzbmlNs+UY+0mbyjgP3UmHM8bUOw1gpGt9t5A0NQypd9GqSOwyO6zIbgFwXkltNcB5jufcoQQY/tely4lwdOLhRdTAKwqMYLffL2u8Xfy/fKj+8xdWXLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701846; c=relaxed/simple;
	bh=zcE89Qfzpg/a8Ic1pSZI3SQfTyKmPOCwz5Hme+dQsCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz0P+l8ij1h0tpfS+XEJ+toa1a+cJoL+hNRlhHyuLElO3onf54Z/gTlbJ4JJewj7DNFthiEFXuyuTatG3OFsWGNuI9xVQ9Jt58+PDzvMmF0wy9fm9M7aOjwS+4cCl7eLuErkC/9/YtmP4AXWbOpZG9H2s4AmWwnuklLWbiLUds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn/50x1L; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430e182727dso29067805ab.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761701844; x=1762306644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3/zTtHXFt9g714ZItEP4tvd61nHhi95RvsnW2TZsOU=;
        b=hn/50x1LN2xpR4o+d1uuXRVOUkNhlQzUw3xZfLoR7qA+UDDfWSeBSnZHSujawYc7V6
         mhcRetaCW4cQg9iQ3OTIgzku37jBOzA7gUSCRiVJ2wmSpeLdytO2VXDU3wDEnXytF7aO
         BPYVW9GWAMOs2kgRzfVGUp8DT5Se8tZY91C9199fIB+V2EMW54TdQ0Tc36zYsypqYbqf
         15B67+BQeAb4g0rbP9Ewp1YNOdw7qakFS/VOkW2wDwW4YS2oXd+OMvwgtOX0tWb6Dude
         wISPbEAGZcvfgzrEq7xH0bYi8hY8lfULRn8ehfrFCxmf105cW2h4OdhMHtqlEh0F2aWN
         r27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761701844; x=1762306644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3/zTtHXFt9g714ZItEP4tvd61nHhi95RvsnW2TZsOU=;
        b=LXBoSCwVsysKrC4jchciWyacox51FVKW3vI7UJB5LJZ4qo3TOnkplqFANdyrrluIhS
         5bQ/i+P488UkYwu2bmLpAggQhrrh3qLKogPgQ+1OwQu5G9dWoxd6hb+O0zsMRuOBzVby
         5y6wjEl4j1NOSDY4VFEFdxYweUb0azTOJA/z49Y7N+1MbQ3TOD9Pel9ZaN3shv4VecQp
         /LsFeuVO5YlOzu5glHmxeNohRKi0sePSwjU/4s7FD/p/cF65X6nM5tn+N2A7UEsvyMnL
         nsgHAse2xJ+k3Y3a/Y4QHkGRXbHWSPLI/lAajt38MAFtStpzCTSFczz63tpMWsne2mkL
         NOIg==
X-Forwarded-Encrypted: i=1; AJvYcCUFZZ63NstWvJWxkNfnPu8rOCgytA3EWpnQzFJa/gtLjkObJwBsAOV915cZfP7txCVwRAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCpSwox+EPWmIfONzQuqH2xhT5fnxXvZ7CpZ0I0KUNsBAYXWM
	AcRtiN/YfkcTBxxrD4VjwKGcvr2KOkR+wnluEbWu17FyvRTMV3cBCwBlANIerPSW79SVRpGsAVD
	91uT9i7XcFfX1/tNozBtv+N913mwAePE=
X-Gm-Gg: ASbGncvkddG9/vi7mGyq9uOiR6iALrHDde4lEZ3UnV7pJ/8y+XOaTq5Ku+saS7COKDo
	h62XnysENsDTLeM1rDHNgM5QwtDww/b8xiVF9bzkm4gjwOHay+7P8vB78d13Ip1gwxAr4IrygZP
	L9W6ZuBIzl3xpqv+5jB5+H/KUEE5STyafu0nHwbOpVVVQ3ZGd5VUrWZ/msCicol5ZB7RKAD89xK
	uVuHGAShi1D7tgWwmXv4JrQSfc6T4Cp6fvmQ9BoDc4pcQKgYjaiwrSuP80S
X-Google-Smtp-Source: AGHT+IGbWpCA71HkuR7oTqa22GcL0bg9YQlpIglFomWMKZV3mrbvcuAL6aKEYrdGScMS93ygQSm1nWdSdxNKw6Zviyw=
X-Received: by 2002:a05:6e02:97:b0:42f:6790:476c with SMTP id
 e9e14a558f8ab-432f905fc3dmr20080875ab.23.1761701843727; Tue, 28 Oct 2025
 18:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
 <20251025065310.5676-2-kerneljasonxing@gmail.com> <20251028172903.677f46ba@kernel.org>
In-Reply-To: <20251028172903.677f46ba@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Oct 2025 09:36:47 +0800
X-Gm-Features: AWmQ_bnEufjN7yrxinjG1cqV4mzmcqDGdKn-kje9_FXsPptovuxlRGztF4a-4NA
Message-ID: <CAL+tcoDJ00BzKAta6=M0K9JkoT80DVkSDvevGug28b7RrTf6hQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] xsk: avoid using heavy lock when the pool is
 not shared
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 25 Oct 2025 14:53:09 +0800 Jason Xing wrote:
> >  static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> >  {
> > +     bool lock =3D !list_is_singular(&pool->xsk_tx_list);
> >       unsigned long flags;
> >       int ret;
> >
> > -     spin_lock_irqsave(&pool->cq_lock, flags);
> > +     if (lock)
> > +             spin_lock_irqsave(&pool->cq_lock, flags);
> >       ret =3D xskq_prod_reserve(pool->cq);
> > -     spin_unlock_irqrestore(&pool->cq_lock, flags);
> > +     if (lock)
> > +             spin_unlock_irqrestore(&pool->cq_lock, flags);
>
> Please explain in the commit message what guarantees that the list will
> remain singular until the function exits.

Thanks for bringing up a good point that I missed before. I think I
might acquire xsk_tx_list_lock first to make sure xp_add_xsk() will
not interfere with this process. I will figure it out soon.

Thanks,
Jason

> --
> pw-bot: cr

