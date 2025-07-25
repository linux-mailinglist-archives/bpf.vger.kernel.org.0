Return-Path: <bpf+bounces-64372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE3B11E22
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 14:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD32170FB9
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED156245023;
	Fri, 25 Jul 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQLQK/+m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08170244684;
	Fri, 25 Jul 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445332; cv=none; b=hs6JAELQvnRZ/XFA+DV8uayeKujG/KSTk+oFdCMm3KARtflpowJ8Okeu4GXWxGIyoD3uFIQTwuckVZ7SXLRe2mMxJTdR9fQD/nn7fYO+5QKOX2mUrrFWZA9aa29+G3tkKoMH6atbWMSlr11aN8/Vbz/ZUM8UPtrlthZP8vFNU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445332; c=relaxed/simple;
	bh=TG2LtX3donk6Ed77YQCRqF6WJ6SVdooidmIVvg9rxNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJlssFOrC+zIib3uDCJT88vj1oN1O93T38f2eEOf/yxJI9MlvFg/Z8BiAFuBLCZrmmReTNnZb2ba+bpiKnANOkhAoMFCuaxu5xigSnSGmY4FZrAsTC2Dpde4A9RMI3KLBS65JBcV+n+F3CfiPiEoFObjCsVKZMIwxs4sl5pdB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQLQK/+m; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df303e45d3so6651335ab.0;
        Fri, 25 Jul 2025 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753445330; x=1754050130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG2LtX3donk6Ed77YQCRqF6WJ6SVdooidmIVvg9rxNc=;
        b=EQLQK/+m3nWA8nFlWyeAHeIDxL70tpy6Krkj3Tu2bUaGw+jmCiXG+cpNc9goEMMm7D
         OhMScZsEKO7XZxFOfDdd7rT6eJrREa0qP3rRO9jr3+kuOoyCrjriy/BqQQOp8qSXo3WO
         OB0MTyDvLEqVMTIFWOF3aoXOyZAZegyP49rB+ZkxyRVC2GlZkssH43sl8RlEibjGVvNR
         F9SFnbpVP3G5l5Nu+oW+5Inf2OffK2xLdOn7NdvLO4MFgErdqiJmFrxt9pICHTqeWSfV
         l2D6FR0JG66pJyh0oZvuO0LFtLIcD4IHO62FXMIemAtg69azpqLNnupNCUvSfRGC66qU
         aGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445330; x=1754050130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG2LtX3donk6Ed77YQCRqF6WJ6SVdooidmIVvg9rxNc=;
        b=cg2IXH/gI+p8Fg9Jb5wPwoCtjLoUOUNZPKh/OuI24Lhv5He7ZXxUHWs8QuxNR/rwbP
         6JvXcJBpwbvqtGlyX2XjvmHe9syO/DXjrl1rluTA0ABqITeVlmuT2havb2N9qeJdAFsk
         ig3s9Sth8wS2MZRu4VpegoRiDyr7UeQGnZPR7xV0wiIxKT5XvNWMY8jJfFUnIfeMf2KT
         cJDwRP0cGR9BzLyDDMHeryuiKOI5MJNBw7/SqO3a21wTs4WbFUZ5mMTlkLQVGSeMboqr
         NXHvhAHV6IWmsOZelpu/YuKotfajmj2Cl5OudgfJt7SXbtwvKOSdl5ICEHjxGj3Qjsj5
         /yZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0m2ypUrxcgCQ2xqYeWuurfzdc1YecvrHH1wSoilShxHHyX6Cr2SE3uNNzFsk+LDo9mxyM9v+s@vger.kernel.org, AJvYcCXE7EgnosnoV2MPmc6ZcknJO4LZYW49zLXGNGcCOQyOLknHObnf+wyBSX9GhDSvfglbDoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4yPLmB+NOd8qN/H6CgqbzqaSs1UynVgD1viG0Ovx7JqSb41I
	z+Zf9r9iSOI4dpKmbOPWILD1ZVFQOcmuPqPQy3fKeUHaY5A6WcJfW9koa1seUOM0D1lUNxOGw90
	7IeqoCwkoxa5rQhM+ZZuvqvhxBIXvclQ=
X-Gm-Gg: ASbGnctKGKCxFbKwGV332T/cViSWiEf8YYjdGWNo0f4MfPc5cIHGq77ROvWx5GfJUy/
	FtRfyqmqQ500M4LiEbHFhhboKxto+U+0OiS18HF/dpKvFEQNkx1/qmUYAHCz2STcf3eq9wHhSg1
	AuXoCmxpX7MyxmQ9Gkn8yvh4HOkQ7bXD3R3rL0gojvDryHIX2B3sSqSoSIzitgHr4o2jlsgjnxY
	seyjhr7U+W+lsJK
X-Google-Smtp-Source: AGHT+IFTe1aGWEP1F2o5nZ8tomsl7n6MwFk0t5nMbJXavVUgt2Ch/wAgCL0LtA8gvNir66KP4ln8muVPeiyM0kbkd5w=
X-Received: by 2002:a05:6e02:3f0e:b0:3dd:f1bb:da0b with SMTP id
 e9e14a558f8ab-3e3c527d13dmr24001305ab.7.1753445329820; Fri, 25 Jul 2025
 05:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-3-kerneljasonxing@gmail.com> <6ecfc595-04a8-42f4-b86d-fdaec793d4db@intel.com>
 <CAL+tcoBTejWSmv6XTpFqvgy4Qk4c39-OJm8Vqcwraa0cAST=sw@mail.gmail.com> <aINjHQU7Uwz_ZThs@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aINjHQU7Uwz_ZThs@soc-5CG4396X81.clients.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 25 Jul 2025 20:08:13 +0800
X-Gm-Features: Ac12FXwtJZ9cIf9K60HL09QtqGDJ69_VP6hWxr5eIBL5FKMs6zgs-l1bssv_1Ug
Message-ID: <CAL+tcoD8BHkRhzqi2pcYYmYP-qaxQN9JMfEMAW6xwqvCiEpwGw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] ixgbe: xsk: resolve the underflow of budget
 in ixgbe_xmit_zc
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 6:58=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Fri, Jul 25, 2025 at 07:18:11AM +0800, Jason Xing wrote:
> > Hi Tony,
> >
> > On Fri, Jul 25, 2025 at 4:21=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@i=
ntel.com> wrote:
> > >
> > >
> > >
> > > On 7/20/2025 2:11 AM, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Resolve the budget underflow which leads to returning true in ixgbe=
_xmit_zc
> > > > even when the budget of descs are thoroughly consumed.
> > > >
> > > > Before this patch, when the budget is decreased to zero and finishe=
s
> > > > sending the last allowed desc in ixgbe_xmit_zc, it will always turn=
 back
> > > > and enter into the while() statement to see if it should keep proce=
ssing
> > > > packets, but in the meantime it unexpectedly decreases the value ag=
ain to
> > > > 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc =
returns
> > > > true, showing 'we complete cleaning the budget'. That also means
> > > > 'clean_complete =3D true' in ixgbe_poll.
> > > >
> > > > The true theory behind this is if that budget number of descs are c=
onsumed,
> > > > it implies that we might have more descs to be done. So we should r=
eturn
> > > > false in ixgbe_xmit_zc to tell napi poll to find another chance to =
start
> > > > polling to handle the rest of descs. On the contrary, returning tru=
e here
> > > > means job done and we know we finish all the possible descs this ti=
me and
> > > > we don't intend to start a new napi poll.
> > > >
> > > > It is apparently against our expectations. Please also see how
> > > > ixgbe_clean_tx_irq() handles the problem: it uses do..while() state=
ment
> > > > to make sure the budget can be decreased to zero at most and the un=
derflow
> > > > never happens.
> > > >
> > > > Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> > >
> > > Hi Jason,
> > >
> > > Seems like this one should be split off and go to iwl-net/net like th=
e
> > > other similar ones [1]? Also, some of the updates made to the other
> > > series apply here as well?
> >
> > The other three patches are built on top of this one. If without the
> > patch, the whole series will be warned because of build failure. I was
> > thinking we could backport this patch that will be backported to the
> > net branch after the whole series goes into the net-next branch.
> >
> > Or you expect me to cook four patches without this one first so that
> > you could easily cherry pick this one then without building conflict?
> >
> > >
> > > Thanks,
> > > Tony
> > >
> > > [1]
> > > https://lore.kernel.org/netdev/20250723142327.85187-1-kerneljasonxing=
@gmail.com/
> >
> > Regarding this one, should I send a v4 version with the current patch
> > included? And target [iwl-net/net] explicitly as well?
> >
> > I'm not sure if I follow you. Could you instruct me on how to proceed
> > next in detail?
> >
>
> What I usually do is send the fix as soon as I have it. While I prepare a=
nd test
> the series, the fix usually manages to get into the tree. Advise you do t=
he

I see, but this series is built on top of this patch, so in V2 I
should still cook these three patches based on the current patch?

> same, given you have things to change in v2, but the fix can be resent al=
most
> as it is now (just change the tree).

Got it, I will send it soon as a standalone patch.

Thanks,
Jason

>
> Tony can have a different opinion though.
>
> > Thanks,
> > Jason
> >

