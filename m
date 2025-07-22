Return-Path: <bpf+bounces-64085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C7B0E29B
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540521C85593
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739927FB37;
	Tue, 22 Jul 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4IhFijP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927A277CBA;
	Tue, 22 Jul 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205372; cv=none; b=EyVB4uX1cNEgc2sUNL24v+hvKAFneeAADMmEyJDuuUnaI2wK4tMSdmr9t0TRIYVKxqd9rTd3godeDT0t8JicqrzrIL1RztVm/h9vSP4Ii3/+CcYN6Aeuqt1i0qm1xP+L62XvIrPTEzMhgi4wMMa72MGI6F0ycrv9hpmZi230G/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205372; c=relaxed/simple;
	bh=wAsiexFpJG29+h65JJPZFpAJdqh8AwtAuRFszUNX74E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AwydX7YWJz+OBkw3Joshr6ZuY52U6XI+fhB7Tk7j7iWmp+YKOnEPEU8jz4bdzgRmKL2ZtgFTeLGNRkZ6JV99BZyq62jWJ4l3eazpdoDXr9TngcItlX/Kz9X14TbGuzKpAhGM7xM3A5T79Pb0F7j374R7foAhKkrqmvpXiMHUxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4IhFijP; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8bd3fbd9f7so4990324276.3;
        Tue, 22 Jul 2025 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753205369; x=1753810169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAsiexFpJG29+h65JJPZFpAJdqh8AwtAuRFszUNX74E=;
        b=k4IhFijPO9Ns6yLwHOMD0spvNj2poaoZmuWzus1Oqrf7S6oOfj0jJbWYGmQASwpfmI
         0iCYhJbE7yRqzyrcKRAajuCmVyN1u9AJ0MiuwsEBIefI9XYmBdwWEyNHnHXVH+wyVsUm
         Do6II7FMFGCcNn6AhOs/Tpj6NaevA2He+ZTjdgxDiUumzfxNnjAQO/fXqtYvzRz2EwqB
         WxaQhRafIJTEYwrpv5d/e4eOL2A7oV7PZVfIf2g7WgVikmFv44b/Xxzb28bjrMCs4+Zx
         p8dDRQR+RtQ69+Ya8sOUBjnBrmaJeBE5ti2UBxPkHtA7mgiS0UykMxZFtlwBgxQ4dO/u
         8Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205369; x=1753810169;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wAsiexFpJG29+h65JJPZFpAJdqh8AwtAuRFszUNX74E=;
        b=tlwU2wuJw4pQw+KenrerVSPu4KF9tYoIrVOFRLJVlAoXVx/GdWI+rBNCvOOtXlXDvF
         XAEGUB0Nbk/FZ249wCIrMaNClNSvYhUxlW+nuCwZkcy/PeeJEbsDqAkii53qA+MlJfpf
         0oqFgfhWnP6gv5jfSot/L3DEGRpf8+4mZb9kwZXvQoPeKVd5dSAzbJr0zxgDVRBB3eQM
         CJQHNJ1o64jtuf/u5HTcjIT8gFmn+8cLx8SW/xHCL+6SNgwbizU6S9meOLDX3TUrLRnM
         pRUN88vWzqlZpZkTa5GDrSqI/ug1YKWnalZKXhLiTkQsjCTVid33GXX0XMbdcKI5g1qL
         4Ffg==
X-Forwarded-Encrypted: i=1; AJvYcCWXbEcuDdxbG3t6gijDnLLJy39DpxFPYiy6gQfY6kOrhYNH+F5fJwkHpxXU0sX+CTj6BCQ=@vger.kernel.org, AJvYcCWdzHqPtJvJLcSdRy/jO8YlfLQjOMXWwv1mIoWsMKAbBJWqPvz2DS7B39L8PpLoYGcjrSTBqDZi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/yqvytZvQn32DriX2TQA9xTHb5MlRM8T8yj0gaUZ1agKY98a
	A4+iG0JlsIt9+tzij1RYe9BkYglZpwHih1hyv3MjiFjoXKqxLN6B4WKg
X-Gm-Gg: ASbGncvL7JXyavZ4UtZ1KveIz7tqtqlxsKxX4lUd0go0Q5aFf0hhSUgOXjtG9O0wEAF
	WHp6q82d1HYkkkgQrY02k9JWar0VGAB93yazNRc+yPxJhG1pubnKyO5NY8wnLPyZaJ9k3WhO14F
	L+OOrhSPd05drHV9udGKGoXBEHCxSv9bqkEhfkw3UfcEADGHtXCFNS5Sl9FWiOeSOhvb9oDFxun
	4MjjJDW9DOmj3rZKwHEU4pCPpywK/gYCTB0RPzeikaJ+xbB23sA+9bet/lQq97KoH6Nc7We5Ixr
	MZ5KQzUUtUUgtfXMo85vomdrqVSXF0yIfopFbcUjIXYtY0CdbEx2eMHXOkrrJGbkWg2ffbkMGf3
	e7oF7PHmpQCs2kmm6P0VVU8KdEmvsu285Fn/iq5svAzMdc+iGaWNWEXDSIOC8MPhCyAXxCQ==
X-Google-Smtp-Source: AGHT+IF7A13lSEqts+dgqsU65x9gG5+n8sudziRUQP5o9tvzg5UXPLY2Xux38fUj0ahxVpgCIrZuJA==
X-Received: by 2002:a05:690c:8c08:b0:719:4bd6:8ba6 with SMTP id 00721157ae682-7194bd68c99mr168256107b3.20.1753205369278;
        Tue, 22 Jul 2025 10:29:29 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719532c7cc0sm26018107b3.70.2025.07.22.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:29:28 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:29:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 bjorn@kernel.org, 
 magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, 
 jonathan.lemon@gmail.com, 
 sdf@fomichev.me, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, 
 linux-stm32@st-md-mailman.stormreply.com, 
 bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <687fca7852e84_2cbf622949d@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC5KnTuWKxKcUqFGh-nBSF+X+RWzr=RkkK86+jY1Q20Kw@mail.gmail.com>
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com>
 <8c9e97e4-3590-49a8-940b-717deac0078d@molgen.mpg.de>
 <CAL+tcoAP7Zk7A4pzK-za+_NMoX11SGR3ubtY6R+aaywoEq_H+g@mail.gmail.com>
 <687f9d4cf0b14_2aa7cc29443@willemb.c.googlers.com.notmuch>
 <CAL+tcoC5KnTuWKxKcUqFGh-nBSF+X+RWzr=RkkK86+jY1Q20Kw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] stmmac: xsk: fix underflow
 of budget in zerocopy mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Tue, Jul 22, 2025 at 10:16=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > Hi Paul,
> > >
> > > On Mon, Jul 21, 2025 at 4:56=E2=80=AFPM Paul Menzel <pmenzel@molgen=
.mpg.de> wrote:
> > > >
> > > > Dear Jason,
> > > >
> > > >
> > > > Thank you for your patch.
> > >
> > > Thanks for your quick response and review :)
> > >
> > > >
> > > > Am 21.07.25 um 10:33 schrieb Jason Xing:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > The issue can happen when the budget number of descs are consum=
ed. As
> > > >
> > > > Instead of =E2=80=9CThe issue=E2=80=9D, I=E2=80=99d use =E2=80=9C=
An underflow =E2=80=A6=E2=80=9D.
> > >
> > > Will change it.
> > >
> > > >
> > > > > long as the budget is decreased to zero, it will again go into
> > > > > while (budget-- > 0) statement and get decreased by one, so the=

> > > > > underflow issue can happen. It will lead to returning true wher=
eas the
> > > > > expected value should be false.
> > > >
> > > > What is =E2=80=9Cit=E2=80=9D?
> > >
> > > It means 'underflow of budget' behavior.
> >
> > A technicality, but this is (negative) overflow.
> >
> > Underflow is a computation that results in a value that is too small
> > to be represented by the given type.
> =

> Interesting. Thanks for sharing this with me:)
> =

> I just checked the wikipedia[1] that says " Underflow can in part be
> regarded as negative overflow of the exponent of the floating-point
> value.". I assume this rule can also be applied in this case? I'm
> hesitant to send the v3 patch tomorrow with this 'negative overflow'
> term included.

My point is very pedantic. I think these cases are not underflow.

But it is often called that, understandably. So choose as you see fit.

