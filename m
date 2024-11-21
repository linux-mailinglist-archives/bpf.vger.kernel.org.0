Return-Path: <bpf+bounces-45405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8621C9D52AB
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4715E281E25
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3711C1F3A;
	Thu, 21 Nov 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCPgxIPG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1A139597;
	Thu, 21 Nov 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214532; cv=none; b=JM9/AW9H6AZJnqYPMQPm02V+nw9AOUmqLhPODyJTFlBdiEBU/49i19dmmdALJVkI84v/c9ZURUmM1SQDxKiAWxdlwDDQzUVTbdy81rTXrx4vUOAaO9ozXI8GLR7HG42wVFg17dS3OcvJ982VpkJ9TOOBZJQvYXiTSuD2hAChY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214532; c=relaxed/simple;
	bh=4ZOZYSGT9MiXACTC9i0gSBIs254zlFZ1yEDhRSCBbzw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h5FOeDdT9t+Ga4Mxstq5Hspqby5omNwfzU1GoHACJCoMQNXo+g3f+D82tdi3uTBPHHZjeBKh305ffWld9dEDOEHh0Tdb6FCXOYknhjgBTBTilkioy7vDFNznlNAL2/BwHCKB2BAX8xJLO5Miht+Zm95+dtPVTaRugI4GKJRsHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCPgxIPG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b157c9ad12so77528385a.1;
        Thu, 21 Nov 2024 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732214530; x=1732819330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmdOgbqBPUJl7sAppIUwjIKcePWDsMluXPvHfEsrgt8=;
        b=bCPgxIPGElLhlD7gSotFb/IK9BPHIs8yBHgIfaf3QxOb7ZgT2DNs4MRU3WZi21EshR
         pJKF9C8h/NuAt0/uE2KcL8JtdR27uV/CSIKEfmuzFoSiA8IgreHg+EsMh8hJhAGSbWZg
         BPNL5Dcr9dyYk6f4A1JmKaFWD5ltTAIs4bloF6W0uYe/yvphdvsv7mEckH5WyHU7uzr7
         NIA/79XUW8FP8QldDzvgZpPBeSIFlncrAXAqytFBm+cqPsZZgRd4E3WogvI3jecyILuO
         EkR7ESc/YG/pVL2SorgjXWu4ChgW7ZzoNLXm5LIJDXVvGPtGSQ8kPMJ8fs+o1NSIRZf5
         WlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214530; x=1732819330;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jmdOgbqBPUJl7sAppIUwjIKcePWDsMluXPvHfEsrgt8=;
        b=Z5jkGqpU6iFqbrYLvxDN5IuqL5nhjZ4MlgoRh25p3oar+saOu6WCBhcpBljwpa1czl
         vAvi9hK7ojDEELT7SAPYt/FNZVAbMu095K3ZgXAXd0OV/t9b0MvpZZEVfRPPydc7rLt8
         X/ty2Uq8qYhjflSLiEuPweVPGM/HCKSkDBEfe+yJEZe4ngvGi4mTb0J/F0yNfT17TnC8
         vOibI3wL06G9IhUY+tt1iv65Y+blWXkC1pbvKp1KU/PZljHj1bTPmyP4VlA6/1jT3QDo
         30vF2KWF6YzAvYIItCpOeVPdZjIXJZJ5PVnfdZcok/kdKMTMtEbkpD8vV/x5BkZGrmyw
         Kdmg==
X-Forwarded-Encrypted: i=1; AJvYcCV8mJj75tlV5q1uHZRNIUEHunXV1JT93X5nxtkTccsSJpGeDYa+Rrlx4blxDxauMxcdODfChBZF5bnnv5qB@vger.kernel.org, AJvYcCVwN+8OZ7b4oh+ZPSIBHt5pOtenTFdAKitFuXuA7AOAL3Ap5AzQMcOeMawAD0cl/TuwFMw=@vger.kernel.org, AJvYcCWMlYa2Vdwmw3+Bf66ekuvW1KeX87bqaMZHBOEGDTZ0/qK+i5ERvsgnT/qC65wdJbfrUFTQmPgW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7oknn7erqvVMhej0qkB4mXqkta3jbU8KlzMPuj2kyRZQnGur
	3NC1a4yvvKNPplQzGzxc+rnTMUnmhzAdTJK8CvSVmPnIZn4vQVRT
X-Gm-Gg: ASbGncuSGqrYRwqMVeD+UFKzoH86tYHtIfEGTbnXWbpOF0WPJhdpYATExny2R+k9Ij7
	ZYJGImeHvDBX8sjYb4/PqYm7n21e/UtePkw35YYv88hhrx6AHvW0c4tbW0wkz5BWHMQXWKIHAPi
	jMrkfXd5js3d+OFggQNUbw5vmit04esRl/kneS42gY5oPfkPHr1fZ9svcjtukma++739NuiaZtE
	rcC8MaZAEYCsEIXZGih6e0TUsXqrKkNMTUJQ28l0eZ8DeDlz23munlUIqm7Bvaryr2K5Hh+C4cu
	VBp/RPKnAIuW9YqWkmZSGQ==
X-Google-Smtp-Source: AGHT+IFofUQ3XTph+PXQDeyalPqr8Wf++DjeBHaM1eFHOLZvndMCNCiX5H/I12tKbgyZy4m8Ghrrkw==
X-Received: by 2002:a05:620a:19a4:b0:7a9:b8dd:eb96 with SMTP id af79cd13be357-7b51455cce1mr9934085a.30.1732214530165;
        Thu, 21 Nov 2024 10:42:10 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51416aae7sm6088585a.115.2024.11.21.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:42:09 -0800 (PST)
Date: Thu, 21 Nov 2024 13:42:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <673f7f013a3b0_d495a294be@willemb.c.googlers.com.notmuch>
In-Reply-To: <55628623-220c-4512-acdc-0b3bd38685e1@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
 <6738babc4165e_747ce29446@willemb.c.googlers.com.notmuch>
 <52650a34-f9f9-4769-8d16-01f549954ddf@intel.com>
 <673cab54db1c1_2a097e2948c@willemb.c.googlers.com.notmuch>
 <6af7f16f-2ce4-4584-a7dc-47116158d47a@intel.com>
 <673f55109d49_bb6d229431@willemb.c.googlers.com.notmuch>
 <55628623-220c-4512-acdc-0b3bd38685e1@intel.com>
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Thu, 21 Nov 2024 10:43:12 -0500
> 
> > Alexander Lobakin wrote:
> >> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> >> Date: Tue, 19 Nov 2024 10:14:28 -0500
> >>
> >>> Alexander Lobakin wrote:
> >>>> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> >>>> Date: Sat, 16 Nov 2024 10:31:08 -0500
> >>
> >> [...]
> >>
> >>>> libeth_xdp depends on every patch from the series. I don't know why you
> >>>> believe this might anyhow move faster. Almost the whole series got
> >>>> reviewed relatively quickly, except drivers/intel folder which people
> >>>> often tend to avoid.
> >>>
> >>> Smaller focused series might have been merged already.
> >>
> >> Half of this series merged wouldn't change that the whole set wouldn't
> >> fit into one window (which is what you want). Half of this series merged
> >> wouldn't allow sending idpf XDP parts.
> > 
> > I meant that smaller series are easier to facilitate feedback and
> > iterate on quickly. So multiple focused series can make the same
> > window.
> 
> You get reviews on more patches with bigger series. I'm not saying 19 is
> fine, but I don't see any way how this series split into two could get
> reviewed and accepted in full if the whole series didn't do that.
> And please don't say that the delays between different revisions were
> too long. I don't remember Mina sending devmem every single day. I
> already hit the top negative review:series ratio score this window while
> I was reviewing stuff when I had time.
> Chapter II also got delayed a bit due to that most of the maintainers
> were on vacations and I was helping with the reviews back then as well.
> It's not only about code when it comes to upstream, it's not just you
> and me being here.
> 
> [...]
> 
> >> I clearly remember Kuba's position that he wants good quality of
> >> networking core and driver code. I'm pretty sure every netdev maintainer
> >> has the same position. Again, feel free to argue with them, saying they
> >> must take whatever trash is sent to LKML because customer X wants it
> >> backported to his custom kernel Y ASAP.
> > 
> > Not asking for massive changes, just suggesting a different patch
> > order. That does not affect code quality.
> > 
> > The core feature set does not depend on loop unrolling, constification,
> 
> I need to remind once again that you have mail from me somewhere
> describing every patch in detail and why it's needed?
> When we agreed with Kuba to drop stats off the Chapter II, it took me a
> while to resolve all the dependencies, but you keep saying that wasting
> time on downgrading code is better and faster than upstreaming what was
> already done and works good.
> 
> > removal of xdp_frame::mem.id, etcetera. These can probably be reviewed
> 
> You see already that I even receive additional requests (Amit).
> Sometimes generic (and not only) changes cause chain reaction and you
> can't say to people "let me handle this later", because there's once
> again no "later" here.
> idpf still has 3 big lists of todos/followups to be done since it was
> upstreamed and I haven't seen any activity here (not my team
> responsibility), so I don't believe in "laters".
> 
> > and merged more quickly independent from this driver change, even.
> > 
> > Within IDPF, same for for per queue(set) link up/down and chunked
> > virtchannel messages. A deeper analysis can probably carve out
> > other changes not critical to landing XDP/XSK (sw marker removal).
> 
> You also said once that XDP Rx Hints can be implemented in 3 lines,
> while it took couple hundred and several revisions for Larysa to
> implement it in ice.
> 
> Just BTW, even if Chapter 3 + 4 + 5 is taken literally today, XDP
> doesn't work on C0 board revisions at all because the FW is broken and I
> also doesn't have any activity in fixing this for half a year already.

I am not aware of this restriction. Definitely have been running
variants of your github version on various boards. Let's discuss
offline.

