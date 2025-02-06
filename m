Return-Path: <bpf+bounces-50601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731EA29F72
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 04:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BDC1888CEF
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57896158858;
	Thu,  6 Feb 2025 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCJHjxbg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AF46BF;
	Thu,  6 Feb 2025 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738813340; cv=none; b=j890uCW+VLnxL5eZWCfP/3VQ9AMw5ZCUUZOt/HxooHpS8TvcMwD/QUV9VqN+bVHE8+OUDmWa82mHWrgf8+CUl5GkV41oo/UXImQ3yLrDkOgNO8KK+q/un0Ss4DU+2ZgNUjBVFAYFbyc8DeRXqQspvOOqkjihFXcndmlLyvnpWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738813340; c=relaxed/simple;
	bh=M09cgB5RCxwtr2d4JyO1BLYtn4T3umEq8Z+02l6QoYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZxAmavVARY/gEzBWUDmtwHdoLL8/riIQTH9bwR7OB8g3fegX/Fozl5JFgAZtEGi3pLsIpwT450k6BHbqrNV90Wh2aY1H6r16k8GjFnJ12fcBvy4hR3bV/90rmHKAfdZQRizdyutaCOETwBUYE8zqh+5zi34cq6q3Tlxmi11b9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCJHjxbg; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d04932a36cso4079745ab.1;
        Wed, 05 Feb 2025 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738813338; x=1739418138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M09cgB5RCxwtr2d4JyO1BLYtn4T3umEq8Z+02l6QoYs=;
        b=ZCJHjxbgGdjTtBzn+AeobP1E/4TWh/SaVEux+AyzXCQsSzP08+jwpE0F2qcjT+Jlkd
         nQpO18g61hq41GkWFfLkclyD2KpRzUEMU3lGmnCJI4S3m9Ff7Cf8AtrHMMB43S32Mz+0
         jpOSlw4aQkNtpaQMKJ4aeUOmMctaaBQrd9UI7O2nahCJff2kLGcQqLtwvF0GnG+LiiXQ
         hyQJwBANLih7vtDA4Y7qKMHkYwfK4gQdOHy7M5OpHWTOe4FTiybwyLLP3AyRnPUCzkTS
         Hfb1jG2RaizDPxWjjs91dwSFQb1BdHC0GGcj1u5zoLL49UJjTW228ilsTOSQskgAbe8X
         6p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738813338; x=1739418138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M09cgB5RCxwtr2d4JyO1BLYtn4T3umEq8Z+02l6QoYs=;
        b=StD7tIM581BYZ2x8W79FurqSEZRHctq4M/meY38mT5k/GNRXUKF6TpcEj1WVFGX5iq
         VUQrbSqLdx6z7NhTzYJpaMrD3jYG9tpHfegTS/i811hpOiKDuWUL997iNaqZe64namQa
         b0WMTeis6wugNRJan9K7GcXySPYjRTKJg+C/L/aw25KQ8vpwiKpT/v8f4mZtaoN12Fma
         4wooPdU5nZJ3fFJh3pe1itZuNm1QwsnOqbKbyiRIcgaOpip8w7dU8Hw/DH3UQUbqS0Zr
         wl/JKm17tNb+IfAq0A+BsG4WYM9CN/F423XiB/xSYAKtKU+XaXukwpGBB4OeB7BdhLdp
         8CAA==
X-Forwarded-Encrypted: i=1; AJvYcCUclPi58rIecn85DS8EC2z82PJGHYsdr57s6qLWLaxIhFO2oN4luKgLobQBuwwIuZmf+8C97TAr@vger.kernel.org, AJvYcCXwkBgUYM3P7QccOHTTt3oU8TobA1CSQr1WCj2BiYdXzfsGwliqwLYI1MPGmO9O9XAyuXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+n7C0S9W9xRY1es6C/G3GqvJGn0Uxdz0gEj/0NZQtGDVgM9q
	9uXyhC13XiwLZrgmaJg4u8Fc5dz34FJrVb745tgsemc4apOte5IgaEp4/M3OGQkaMygd+8rEwNu
	vyexlGK0IZBkm57EUpg+C2uVAIRY=
X-Gm-Gg: ASbGncvKiS8vdmVhSwVeOUodDwM2hO9EEMyqRW8TY20mQSug/ij/oPCJCN+uHE/72Wi
	LdBpzcIyV6ts6DcdFhbDALpKjEbST/LMsncvyT7kA92LqcXJnLwkCHMExX+kM9JmMwze9jeYV
X-Google-Smtp-Source: AGHT+IHb4lKH8m4b+Gu+yM146DZ+pj4Z9M4+Pg3/HoUaZJDJw8gG3iwrOLWJuSw91/dy+DQeChg4hp4Zwh7G8XnI/90=
X-Received: by 2002:a05:6e02:370b:b0:3d0:25d0:8507 with SMTP id
 e9e14a558f8ab-3d04f4a4616mr55014695ab.6.1738813338349; Wed, 05 Feb 2025
 19:42:18 -0800 (PST)
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
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com> <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 11:41:42 +0800
X-Gm-Features: AWEUYZmtZZAzIHvxmm-aW7Kk3S8szuWOb3ZHQ7gLD-SylDJJP9kVVZcTOuDRebQ
Message-ID: <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 11:25=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > I think we can split the whole idea into two parts: for now, becaus=
e
> > > > of the current series implementing the same function as SO_TIMETAMP=
ING
> > > > does, I will implement the selective sample feature in the series.
> > > > After someday we finish tracing all the skb, then we will add the
> > > > corresponding selective sample feature.
> > >
> > > Are you saying that you will include selective sampling now or want t=
o
> > > postpone it?
> >
> > A few months ago, I planned to do it after this series. Since you all
> > ask, it's not complex to have it included in this series :)
> >
> > Selective sampling has two kinds of meaning like I mentioned above, so
> > in the next re-spin I will implement the cmsg feature for bpf
> > extension in this series.
>
> Great thanks.

I have to rephrase a bit in case Martin visits here soon: I will
compare two approaches 1) reply value, 2) bpf kfunc and then see which
way is better.

>
> > I'm doing the test right now. And leave
> > another selective sampling small feature until the feature of tracing
> > all the skbs is implemented if possible.
>
> Can you elaborate on this other feature?

Do you recall oneday I asked your opinion privately about whether we
can trace _all the skbs_ (not the last skb from each sendmsg) to have
a better insight of kernel behaviour? I can also see a couple of
latency issues in the kernel. If it is approved, then corresponding
selective sampling should be supported. It's what I was trying to
describe.

The advantage of relying on the timestamping feature is that we can
isolate normal flows and monitored flow so that normal flows wouldn't
be affected because of enabling the monitoring feature, compared to so
many open source monitoring applications I've dug into. They usually
directly hook the hot path like __tcp_transmit_skb() or
dev_queue_xmit, which will surely influence the normal flows and cause
performance degradation to some extent. I noticed that after
conducting some tests a few months ago. The principle behind the bpf
fentry is to replace some instructions at the very beginning of the
hooked function, so every time even normal flows entering the
monitored function will get affected.

Thanks,
Jason

>
> > >
> > > Jakub brought up a great point. Our continuous deployment would not b=
e
> > > feasible without sampling. Indeed implemented using cmsg.
> >
> > Right, right. I just realized that I misunderstood what Jakub offered.
> >
> > >
> > > I think it should be included from the initial patch series.
> >
> > I agree to include this in this series. Like what I wrote in the
> > previous thread, it should be simple :) And it will be manifested in
> > the selftests as well.
> >
> > Thanks,
> > Jason
>
>

