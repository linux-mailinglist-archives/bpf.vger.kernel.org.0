Return-Path: <bpf+bounces-64052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F4B0DE8E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5232E586849
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764352ECD2B;
	Tue, 22 Jul 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX4yvHWQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2A23F413;
	Tue, 22 Jul 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193809; cv=none; b=q72aQwbm5gyGY9UueOSE9lwd+EDcvU0uu8r47h4oMm91WVYlGonPNFU0JSpxuHqUHEHKvMJS1S87jfGlt5yOx+JwZKVKjtUkmi+gYgjE2AIVwLRhsADM2zYWz2PguUNPBpEe3YnuxbQwpSMvascLHKoqLFFpBonXReRLOS1/hPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193809; c=relaxed/simple;
	bh=tVf9s+VBrCxFX0/0lHXJexCtjFH2FtKEcOQbNsybb/U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zh6Wu5hSOWdzx7VHKwqicq4hYQSzTuTxrWFuYcsV6LMD0BgKdcsREG/VrP7jhZS35BaFxZIgzBGibBd3ePwq2Q2yeLxd4mqIJLMEu53f7XE6vxC4qR/rZhNSb6PUFJTyJPczRm8EDxioWkU9J7+jChVFycHNl2UMYtm3HPR0ZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX4yvHWQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5433251276.1;
        Tue, 22 Jul 2025 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753193806; x=1753798606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVf9s+VBrCxFX0/0lHXJexCtjFH2FtKEcOQbNsybb/U=;
        b=YX4yvHWQ84fejHo6aoCk5oT6uZZF6qCp6bGjA38cuwc5kyrnd3QGkcoiW3tdjgETsX
         y6olO8LGO50EMox9i9gh3JnnBKdR4/+lLlouTvWYEA0dU0zV+wWl3pbJrCGlgvKcBOcd
         suwf3o/7isM+qxnXpRXfKcu9FVvpMED22Rhtgjjq0Jw9a7N7YCKvb7d+pFklfOq4RYkh
         cTy5hX8UVj5ETn7/XMo76JQtuTnWydUd0/enpgfhrSIpAJgOso4YmzVfEI3nVcawGSXB
         g9Uu5B93hbzAGzGfvL75hPWnUJOVL8KaB17550CrVE06koWmmxCq/dq8yj6HJOqqX5bo
         IjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193806; x=1753798606;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tVf9s+VBrCxFX0/0lHXJexCtjFH2FtKEcOQbNsybb/U=;
        b=PAtZR/d4cKmyDdikFWaGsUQB+shWbkeI7EIxt2VLaHeh7bn2W1t2x1YV8NxKsxhDCU
         hGUD4CzD6XQG20mYPsmeLdDadhG9gVU3KVT9Oh/ZOhrfvrXjqmbyfxOzwjAfxVo0JGJL
         23sQ5LQMvteWkSDoi46tNhJTkA1DJ2e7sPR6EmhdYDLSqPiT9NSd3DL4OijdyIhuABpN
         KUe/N1U6YmcLQh0QE8WM9zv9QWRp6sMEqM/MOQaBYmfosGIV3PCm4dElEjf1dJ5vCaLJ
         1zy4dcjKHOrct9JkPWf1U5JGztyoBDuEqT2vh7YPQYoJspw4CZf+S4biiFMZ6lMat5fp
         xkAg==
X-Forwarded-Encrypted: i=1; AJvYcCUa6dXWeuWZpgZOFVPANWh1HR2uPfWKzYbD0EMGHR3uCMuX8jSavJfGqj/7tKyl7tXYBdI=@vger.kernel.org, AJvYcCVt8QiR+Bdnh+tnaYevhxT+7N7VmiMroJcZPP4lgo2zvnEHESkfW1HcseQiTDoX0XIgyDl3fHuD@vger.kernel.org
X-Gm-Message-State: AOJu0YyD21QcBC/S8S8zQnttKKZwZQufNnasOjw70jB9CHBQI6JRn+Yd
	EvpQWA+EtNdk9zFGpIx5TTdCcYGqwvmfhHQGQUDAW+6HsC6h17ENb3yw
X-Gm-Gg: ASbGncu0siLxX4LLkTDzGmiavy76Ff+5vhXi0y7qyyDU39K/KwNrEsCQ06Z7HU71DSk
	BKA8etKauZ9Zoq43nzjBd2s+EZw54UX89Cx0a4aW6t5lfDRvW8vOavuRaAHloIAM7ZZTi8KZJfb
	wNkvYpfzsnrUo3qORiY+yO7DpaMjNVhZrVoJ66G5SZ40jWHpdL707KxdViogvh8TaVMdQVQ+gij
	D+MCLTiUB+OuUpYAeWOP8vMNcymCPC5j+xmcSX4IWdrfS5gd+KJGG4XAJSN1nWe9VTNatejdZVr
	xzySFak7ctZuOMozGufqJ5g2Qo9yKPJHtuJL7l/PrLjO6TT9enJYIJhI3+l4voyMOeSTa8wem0D
	eO9OkJZzFIV3tnno/UJBbsZ8Q/+937LB3Ueut0/i6bRMeyW6zFPGPVRxyUoxopoJyDnRKHw==
X-Google-Smtp-Source: AGHT+IHP7FxitzXESY9w0S6KZhfv95yINoBxcZiXaQntPpFdLn7KC8PXaCXmQQWqLiwrO+Z+Yy7ijA==
X-Received: by 2002:a05:6902:2210:b0:e8b:b593:b06b with SMTP id 3f1490d57ef6-e8c5f8acfb2mr24476660276.28.1753193806375;
        Tue, 22 Jul 2025 07:16:46 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8d7cc0b1cesm3206309276.3.2025.07.22.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:16:45 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:16:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
Cc: anthony.l.nguyen@intel.com, 
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
Message-ID: <687f9d4cf0b14_2aa7cc29443@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAP7Zk7A4pzK-za+_NMoX11SGR3ubtY6R+aaywoEq_H+g@mail.gmail.com>
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com>
 <8c9e97e4-3590-49a8-940b-717deac0078d@molgen.mpg.de>
 <CAL+tcoAP7Zk7A4pzK-za+_NMoX11SGR3ubtY6R+aaywoEq_H+g@mail.gmail.com>
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
> Hi Paul,
> =

> On Mon, Jul 21, 2025 at 4:56=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg=
.de> wrote:
> >
> > Dear Jason,
> >
> >
> > Thank you for your patch.
> =

> Thanks for your quick response and review :)
> =

> >
> > Am 21.07.25 um 10:33 schrieb Jason Xing:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The issue can happen when the budget number of descs are consumed. =
As
> >
> > Instead of =E2=80=9CThe issue=E2=80=9D, I=E2=80=99d use =E2=80=9CAn u=
nderflow =E2=80=A6=E2=80=9D.
> =

> Will change it.
> =

> >
> > > long as the budget is decreased to zero, it will again go into
> > > while (budget-- > 0) statement and get decreased by one, so the
> > > underflow issue can happen. It will lead to returning true whereas =
the
> > > expected value should be false.
> >
> > What is =E2=80=9Cit=E2=80=9D?
> =

> It means 'underflow of budget' behavior.

A technicality, but this is (negative) overflow.

Underflow is a computation that results in a value that is too small
to be represented by the given type.=

