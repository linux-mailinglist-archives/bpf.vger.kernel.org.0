Return-Path: <bpf+bounces-50730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0ABA2B8C6
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BCE3A81AF
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170C1632FE;
	Fri,  7 Feb 2025 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eioajcph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF38155321;
	Fri,  7 Feb 2025 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894734; cv=none; b=EmzVV0ji6/Hr/M95ZmzIEF7l+E/PLLsvjNj9YvPzj+CYa1JtEOuNkSLRcFkhkCkxtc3yegOQ7d/3CxzNr3AGRi/t5KkpaaMX3bZJUtDgpoZ7Of4QcromRSI4SvEdXdvqyynAYYht+azX81f2A9UdEp3aJikAyp6aSMYyVB6xsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894734; c=relaxed/simple;
	bh=KmwZr5sT2NjPMDMmE/d/YlIe/CoYmK1UTGkMCk91UOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHCAFhgF4pWaoqlIXDb4CiKgBTRsAKx44oah9fNwi+ycRU/f+YdeGsiHZ4v9Zi195HYKpGf+Nftog7a1LxyoU2McRi20/zcKRTc1g5B+g4+vtrjJRBa57XzBSYHZgTeiH7NV/IDxsU5PmZ3m+OGBtxwgsD6BateYp/fJ2MUiFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eioajcph; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso12264755ab.0;
        Thu, 06 Feb 2025 18:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738894732; x=1739499532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmwZr5sT2NjPMDMmE/d/YlIe/CoYmK1UTGkMCk91UOE=;
        b=Eioajcph3pmeOBwMWP0ySjM9FXITW/T8LNfoW/dI26Ih/AUSLSKu94UUBshAkUDsI5
         QWjxjoS0vDNFhUpjtGSOA1kO4cMlYgNEM3nJLuYnij+O7FZbL4+K4Mkty4zHkRZ7QT1e
         pxVWR644oELs8gjFJShR0ncGS7jDkxZprkvZrbfihRFPcy72o156VQ70uyMN2fUzuCon
         U0qWSQpket+qy2UUga0N7ImM2sGGGKtfkRPxpn+mx+sEkDh+tGnTgx+fOnXta0gYrwle
         dJfXftSrc422w23LnmpXDPn5zhixzG+C8wV0+Eqm2T0kC/1ZWnNjfBle9AOMfM5JrLIy
         8tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738894732; x=1739499532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmwZr5sT2NjPMDMmE/d/YlIe/CoYmK1UTGkMCk91UOE=;
        b=TCltDe+gPkjsXQWtl5I0aSIH/eaL+ooWCW8VO2nU+O2DEX2p6NN51lFMFN0ynwZ9/q
         ukb6TZlvWvjzan3NhWJAMBurub8yDDdeCA6meOjkLGle3kQpmQitTPqziShEZxzDpW2S
         ibEAXPl/oerdxeR4WFDb0TCr38LM7U3mkYewtFwAQtqpbFWN1sucumyWKsOH8SsyHo1r
         DGn0lzzW2A1sSZT+6phoc79YA3PYN5xMDxPc1HaKTDTZXjUiHXY5VYrGiC6A5ac/jwox
         Xuy5R9YXXDGs/4dP68i7eh9CbF4KbrS8pwN6c05xQQOm9oowVXTcawj7At17Sdk/RQnx
         OCMw==
X-Forwarded-Encrypted: i=1; AJvYcCWVkUnW6J2mpAl1xKfkrhWLb4nBv0t8iQWaxlwe9IA1Iozg4yZFxC+Pf5Tf+RBg5BtoUZI=@vger.kernel.org, AJvYcCWnkDRlOylqpUYkkv/Zl7H+Pe8IRVADLQKGYwyAPB6EpyVaWTGImBbX5quyp62XN0CGXgdcjTag@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOjHs1znhKIGwlfdxUgZjdH4Ad+M/pvMBngI6ZPxgLi/03Dir
	CUbdJXCT2oirbfly0JnK6d/H9Tt+SlOF+wdXVsMqQytyOgoCSzcBZdWqjpH1lXrdJK5f6a64UXI
	GGQWPyxyOuLgz0i4sdMFjIL4Z9L4=
X-Gm-Gg: ASbGncvCowKvw5gJN5Z/BJZyVDL4f2wmKJsp2FOAyeU544YrMHRRWGNtoQUyupiE3wJ
	t1Lcwok/SsKbS4SREqGjwQLdsKwbiEsC+Pbz+he3SFwlQxUoKWXbrG1QHzguolN+dT23jQ7wm
X-Google-Smtp-Source: AGHT+IH7edokaLdkL19wcu3HtxjuxMkGzZpyMABrC9vgmJTIrKdeEopLKAESdWhlr0Uudn5UNwopeqdxtF5x5zdUm5E=
X-Received: by 2002:a05:6e02:20c8:b0:3d0:2280:ce30 with SMTP id
 e9e14a558f8ab-3d13dd2a3f2mr13590755ab.8.1738894732304; Thu, 06 Feb 2025
 18:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com> <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev> <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev> <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
 <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
 <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
 <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
 <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev> <CAL+tcoCUjxvE-DaQ8AMxMgjLnV+J1jpYMh7BCOow4AohW1FFSg@mail.gmail.com>
 <739d6f98-8a44-446e-85a4-c499d154b57b@linux.dev>
In-Reply-To: <739d6f98-8a44-446e-85a4-c499d154b57b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Feb 2025 10:18:16 +0800
X-Gm-Features: AWEUYZnxJVBLz5gsPxeZ6r4_kovja0PiytsLg4mDciHz9gby5YynZ5wu7fqw3ds
Message-ID: <CAL+tcoA14HKQmG9dtMdRVqgJJ87hcvynPjqVLkAbHnDcsq-RzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:07=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/5/25 10:56 PM, Jason Xing wrote:
> >>> I have to rephrase a bit in case Martin visits here soon: I will
> >>> compare two approaches 1) reply value, 2) bpf kfunc and then see whic=
h
> >>> way is better.
> >>
> >> I have already explained in details why the 1) reply value from the bp=
f prog
> >> won't work. Please go back to that reply which has the context.
> >
> > Yes, of course I saw this, but I said I need to implement and dig more
> > into this on my own. One of my replies includes a little code snippet
> > regarding reply value approach. I didn't expect you to misunderstand
> > that I would choose reply value, so I rephrase it like above :)
>
> I did see the code snippet which is incomplete, so I have to guess. afaik=
, it is
> not going to work. I was hoping to save some time without detouring to th=
e
> reply-value path in case my earlier message was missed. I will stay quiet=
 and
> wait for v9 first then to avoid extending this long thread further.

I see. I'm grateful that you point out the right path. I'm still
investigating to find a good existing example in selftests and how to
support kfunc.

Thanks,
Jaosn

