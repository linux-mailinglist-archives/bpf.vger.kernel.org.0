Return-Path: <bpf+bounces-64123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426D9B0E6E4
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 01:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D9BAC2D5C
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 23:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1322288CA8;
	Tue, 22 Jul 2025 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMSvV9I4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77819DF62;
	Tue, 22 Jul 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225507; cv=none; b=OcsahiPGsXNjpPeUjt0Yz6xk6tO5iTwmT9qsQwKQP3wVt4eRgx22Kq1yDyBg2F35qLQr60/PRDCH2af5ADb1J6uvSQHkVXEWQvQD0D7xt0PFa03O4seKkHIf/8cXLxBgNXpQb7tq8BdMaLiczSK8vb9FtLQotvIDq0zNqomBTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225507; c=relaxed/simple;
	bh=o7EJqvbx78jyg/AF+HgULO5h7plKJg0CprdQbemfJYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAHVuUNy1sQhPEBjNzPcqaZ4ZlN/p72TiVFp44LD/kHoMV749HOP9tmplUrGQAUaFNOLRQk28h+mpL5Q+JBvH52M+Tpb1qXxZ18uwOzMa9KWXdgaPZq7ABLh7Xkph+sDhiBuE9YeTITmnVk3SLXRDP7aFnDt8Q+9Y2ldqrgjmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMSvV9I4; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e293a3b426so59669595ab.1;
        Tue, 22 Jul 2025 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753225504; x=1753830304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7EJqvbx78jyg/AF+HgULO5h7plKJg0CprdQbemfJYI=;
        b=EMSvV9I4/6y1+0wwHtJzaQEKlTsO+qhJDIEKjLDpXmPi6UIPUGRUfCIvw8ETrkW3Bf
         stX1VxzVdq3/PwkfMFBl10lS4kFoQAi4oX92wR4QSkno1sfwygYmXyUlGDzOMBpLwuFZ
         LmmC+LvyAInbyKR+LyRaIwthBZfizZZPyDOEnF6oEIkFtv4QhhgIRGy6g2hMnsjHVYG/
         euu74JSmnevp3RFWpFbnpEP7OtwsVfymnRUhwJ99BoTG8a4nT/5e5uajhQQgvsh7Kg8L
         YLNn9ilihw8L4V6bB1df/H3Nj5D213nl7VvXbL+Bk48nESBID2y+Do3FNxMLRX64byjA
         v3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753225504; x=1753830304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7EJqvbx78jyg/AF+HgULO5h7plKJg0CprdQbemfJYI=;
        b=N8SS+DPE/vXztJI+XnFmmhV6QSrTWeg6uZOCWnsw9YKjLSgi/7Ceez6IliLzSVbHWh
         Vl1Ka25BTbdX/AsKcefuhL5LoajWWSOKKysqHBTBStmWWU9OwFAOZi3STFz4ZSsRo5Td
         Y2oZLFD8/5+VZf70y4fdbU6Ywqe7eoN2pQ72oFpVbgn8IBaHepeo+Odhu8gkM8Bp4RCH
         0erwN9s9XgCe/ws3sW4ni78QI/x8R7/kYwVnL/xEoc53s2XpDTR27IMLfpOxzRWX2HOu
         BdlQGa20GfFiqflJqwMkzpoP5hHs7+OqdPp9/zQQJuc52wVNvi5DggBafa3EVIWxL9Kx
         AWsA==
X-Forwarded-Encrypted: i=1; AJvYcCVxvIzJbzsxepBKA5I3/Ynv06Od9rQ3VwkYeYQ9qjQHnZ+r+H9QyBVVR8tPU+gH9MfRKILXmkBQ@vger.kernel.org, AJvYcCXO8uAYSEmj61HpyxdPVDDjIusz00XcC/dOUdRGhzpmeyYL9uZKHiq60C5vMmjY2GxavRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoynB8TOWdeWRGo+7hV6aVQKjLZfrBsS8S79rAE/5uHT0RDLj
	CxQvO7NJ0dNGBGnnaTcm/y93LGKJmW4ATqv6lRidBbB4a4Ht4ktlqbIKaF2m6/6wtUnoRjwo6z5
	ZBHsw11M3cDGbS9V9eQM4KMhRj8TJ/yQ=
X-Gm-Gg: ASbGncuw+WGTP/SBH9JHW5zORD3aV9QZGknR874HjMtlu/ISYMr2j0Fza33j+mghNeM
	baz9MKPjPoI/6kLqi8hLQCAWuKTk5nQBEjDnyJ0bYMBPjafj24rx3K4d+1fROws/dUtbGycf9Ai
	/DEzDSaXyF7cVV2XBP3vYAaVyeRx2LUDV6u1DqvDYAc1ZhhTfQvuTpd/sdrNjNe86gEd7tvSJMQ
	EIdsmE=
X-Google-Smtp-Source: AGHT+IGM9UuN6Ixs1sIL8NACSug2SQUUVxyblxGzqYvFhlPX7uYT59jMr39yoO6RCwIf1f0wFOILXKZ+Lj8MuW7dEg8=
X-Received: by 2002:a05:6e02:3c8a:b0:3df:49fa:7af5 with SMTP id
 e9e14a558f8ab-3e3354b36d0mr17914325ab.21.1753225503835; Tue, 22 Jul 2025
 16:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com> <8c9e97e4-3590-49a8-940b-717deac0078d@molgen.mpg.de>
 <CAL+tcoAP7Zk7A4pzK-za+_NMoX11SGR3ubtY6R+aaywoEq_H+g@mail.gmail.com>
 <687f9d4cf0b14_2aa7cc29443@willemb.c.googlers.com.notmuch>
 <CAL+tcoC5KnTuWKxKcUqFGh-nBSF+X+RWzr=RkkK86+jY1Q20Kw@mail.gmail.com> <687fca7852e84_2cbf622949d@willemb.c.googlers.com.notmuch>
In-Reply-To: <687fca7852e84_2cbf622949d@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 23 Jul 2025 07:04:27 +0800
X-Gm-Features: Ac12FXxlIdpCobXEpYuKgIInC5aDftS0FkSg-5UHsYyoMLW8D0PgDpjZEO7FH-U
Message-ID: <CAL+tcoA7W=3m2+=EGicrAkiwc2HUGTn3js=0r_gm9=z0BKR3ag@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] stmmac: xsk: fix underflow
 of budget in zerocopy mode
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:29=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Jul 22, 2025 at 10:16=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > Hi Paul,
> > > >
> > > > On Mon, Jul 21, 2025 at 4:56=E2=80=AFPM Paul Menzel <pmenzel@molgen=
.mpg.de> wrote:
> > > > >
> > > > > Dear Jason,
> > > > >
> > > > >
> > > > > Thank you for your patch.
> > > >
> > > > Thanks for your quick response and review :)
> > > >
> > > > >
> > > > > Am 21.07.25 um 10:33 schrieb Jason Xing:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > The issue can happen when the budget number of descs are consum=
ed. As
> > > > >
> > > > > Instead of =E2=80=9CThe issue=E2=80=9D, I=E2=80=99d use =E2=80=9C=
An underflow =E2=80=A6=E2=80=9D.
> > > >
> > > > Will change it.
> > > >
> > > > >
> > > > > > long as the budget is decreased to zero, it will again go into
> > > > > > while (budget-- > 0) statement and get decreased by one, so the
> > > > > > underflow issue can happen. It will lead to returning true wher=
eas the
> > > > > > expected value should be false.
> > > > >
> > > > > What is =E2=80=9Cit=E2=80=9D?
> > > >
> > > > It means 'underflow of budget' behavior.
> > >
> > > A technicality, but this is (negative) overflow.
> > >
> > > Underflow is a computation that results in a value that is too small
> > > to be represented by the given type.
> >
> > Interesting. Thanks for sharing this with me:)
> >
> > I just checked the wikipedia[1] that says " Underflow can in part be
> > regarded as negative overflow of the exponent of the floating-point
> > value.". I assume this rule can also be applied in this case? I'm
> > hesitant to send the v3 patch tomorrow with this 'negative overflow'
> > term included.
>
> My point is very pedantic. I think these cases are not underflow.
>
> But it is often called that, understandably. So choose as you see fit.

I see. Thanks for pointing that out. I will change it :)

Thanks,
Jason

