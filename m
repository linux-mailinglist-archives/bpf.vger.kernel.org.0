Return-Path: <bpf+bounces-60989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D11BADF6C3
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 21:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F393189D33C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2436B20CCD0;
	Wed, 18 Jun 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy4x/7PV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA23085AE;
	Wed, 18 Jun 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274542; cv=none; b=BvEU/ptkkp8L1awwQJ3ULZo723uoHaZVw5yLd8omLVgI9/k2tufn0NHq4AE7DcdgAzU6xQR10JSp07qlktib2NS5DrX9HdJ0wyb5n5gNhJG1dkh5ueLcirFCngEK8V9h7FCcZFxHmin3juP9Xaxd31EaoARJiNTT2lZIhgSwwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274542; c=relaxed/simple;
	bh=K+Sxn5ZFjdLNK4MAiVvRQ0Ik9p5RLUsRzxE55lXXHiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdfRwCZ5nPvN3/Fyawd6ebMmcdNtrpK5CVwPqEx5tRvilOPmfnEB3iOwL0p0805WMJ2UlrTtJeCJyYNYZG3GEY5cB7GNf59vVsInWbDiP7kEm3ixoKfBIGQyg5pGh/Tglo7uc66aXdhkw+Ho2Hx2M6D4RMM3dCjXIR4CKjdfXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy4x/7PV; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-875ce3c8e24so194293539f.1;
        Wed, 18 Jun 2025 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750274540; x=1750879340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+Sxn5ZFjdLNK4MAiVvRQ0Ik9p5RLUsRzxE55lXXHiQ=;
        b=Jy4x/7PVs+t67m5SWs2qRt14Ewq74gdp7CigkhWZNQ61pjXU02mcF/uheRzduCNxOq
         K/NOPWkbb+WzstX7ZiffzIm4llw3hJ/txNDlE0+w9ZFYpzKTh12cj3oNMHvFqN9e5EHr
         mqnNlCZ8HsX6uAq3/L/7fMxiKhC4WFWzxAp0ruSHaE3N3UNeIlMtOkwVVpkqfd6R/1uB
         FjYUMm5fjR8dm/pRT9MmY/PGeKPwcBCTnNe0+jbHkit+67cE0Qt6LpCOuZ7iQmPF6/Nu
         BjD8skLZchX1VEpkxyykmxyMO4h886y60kHWTvNiMntZID5ZRqhTlsKKZ6ubZg/L+dbu
         EPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750274540; x=1750879340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+Sxn5ZFjdLNK4MAiVvRQ0Ik9p5RLUsRzxE55lXXHiQ=;
        b=a5ZebYXLi7Vzu7RD+y8rjykxiF+pkZr0HoHonqWKIcBRf8YZMK/c0sx2sXQAAQass0
         1qnRIJ9d057tL2nhemk4F67s8IXAuPzudM+IObuhgpGzF4qWRVhI5Fdtnatc1rXXkMsJ
         yfEgZpvZb4HjhsHcluyjx96Om0yeEGOKbjwSrnYUMxZpRgR/t4SbPGBxsRSGwVFZpFmg
         uJLZ2RI322Veym2KXNbN8UMydIpAzG8J0jEWGqOwtAniL17yYOyHLIgUFCkfwvsXMZgP
         cAvkQNCPnUzfuWdsQxzgx5YvhRPy+cHa7uLHwrNer5qi896mS8qZauzp8TGYertaM/UQ
         nafQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4iI7uJb13Yuu6JDre81+BrEPdhWeyqDMo3782Yq6MG4ZQW0x73XMx7m/OBdRQPAdKeQw=@vger.kernel.org, AJvYcCVAV13g/2l5+qkxfI+/dZGY9qig4rb2W31dG8jYAibp/vX5nOwaPtyydJ3HJQG6XmIvIdCkD0Ym@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tSAIgatXJayb5Ecy7zYFSYH+AndQ/Vi9XBLMDO+AMYbtyluI
	AOu13ioRjiN93PGEpgxLmAeCfFosSM3M+W0+kw7h4HMOvfITwVxJk/qBZ3DZBay9hCWDsttRg6A
	YG8W3ywZ0Oe8jUMebHVwBIs1rQaVHRBY=
X-Gm-Gg: ASbGnct1507z7737lQPNQlTQdaTocaOMImhiiBCXd8xeiW8+HpB2b98qm8spS2+pmhX
	vKaR6Ddy/FSPEog5Hjv14vUgH78wleE2lh1sSRKL93tuWJ30da5QMGrOS5UfudnlvgNgnPvnmaA
	E85WlXwvJN1MwTT3k2oNySHsFtvfilL3MBiuMr13jPufY=
X-Google-Smtp-Source: AGHT+IG2hEsrQOuGjhv1gsjDmB2ZXYLINw/QptPg+a1sMwMqZJqieX7poWJ7RU1vqQ+Kr4d1fE7nLR3UqlHe0kkQqU8=
X-Received: by 2002:a05:6e02:1522:b0:3de:2102:f1d8 with SMTP id
 e9e14a558f8ab-3de2102f53dmr116891125ab.18.1750274540223; Wed, 18 Jun 2025
 12:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618065553.96822-1-kerneljasonxing@gmail.com> <aFLWpssHj9sE9vvc@mini-arch>
In-Reply-To: <aFLWpssHj9sE9vvc@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 19 Jun 2025 03:21:44 +0800
X-Gm-Features: AX0GCFtRPZS7-yuuAEBOnY_Nb8fXmLzjToI7h7V4uWl7SK5t0tRTC65U76KxMoY
Message-ID: <CAL+tcoDX=VOPQokJ+xZwyO1GcGwyyJtH2Vowh8d3T0SEzS8_6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: xsk: add sysctl_xsk_max_tx_budget in the
 xmit path
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 11:09=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/18, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For some applications, it's quite useful to let users have the chance t=
o
> > tune the max budget, like accelerating transmission, when xsk is sendin=
g
> > packets. Exposing such a knob also helps auto/AI tuning in the long run=
.
> >
> > The patch unifies two definitions into one that is 32 by default and
> > makes the sysctl knob namespecified.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v2
> > Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxin=
g@gmail.com/
> > 1. use a per-netns sysctl knob
>
> Why are you still insisting on the sysctl? Why not a per-socket (struct
> xdp_sock) value? And then you can add a setsockopt (xsk_setsockopt) to tu=
ne it.

Oh, I gave that thought too. At that time, I was thinking it requires
an extra system call to take effect. Maybe not that flexible?

I'll follow your advice in V3 if no other objections arise.

Thanks,
Jason

