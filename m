Return-Path: <bpf+bounces-73050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 650ADC21469
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 17:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 746F14ECD6A
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB822E6CA0;
	Thu, 30 Oct 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwKxHfwC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F821FF55
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842620; cv=none; b=YlvyNKb+GNPtoeKgtgb5nwf7E2o1By9PhPfobX5YSuvXeKOkxDMMCcKO4SpwvsRuBnX6MMhjUPf2NkE8CMVbyDE18hJFwLs0r2XyPSW301ZxTq1Q5wBE/buhdRlsrf7wWyRy7oNctLKGfLdeSjLrBjABUCdb81ZUACoH2LpCcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842620; c=relaxed/simple;
	bh=ScsR3RF3FUX3H0ckwAV5EMhCJGDEfRpRd7qgc2we++s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prnqtlhhVjdroZUAf17O06hMYJlJc2VJOjeGsDmusc42pz5ee4pCsDsyMZY3z25ImH8vC3Vcjcy7CCNrPb86SUGsHHeN3Mw7OJBPE+EZZZOFZuJWRlbAe51pMMaWcrzX/dtI+VPlIHwExkwZw5aQeA+XMMCaPU3b9Yybz/L4Dr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwKxHfwC; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-945a6c8721aso50573239f.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842618; x=1762447418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScsR3RF3FUX3H0ckwAV5EMhCJGDEfRpRd7qgc2we++s=;
        b=gwKxHfwCYoDeF2l7+1rYYozkU19wcxaqNZNTmSchga5ZKcM2aj5JnnPI8emoYCA1CW
         EtJdkejzwNzd8Qoh0N3sdlthqKnl5P5EgCnCNuipEa4qvXWycwxZLkmkfKFTo9m/vugq
         Yikfam5ZQCaz+r/XfL5yPGBbiQL6wlMSGbM5grfQozd+C7AzCysjXV7grZbWS/XJmITD
         17ezdD1IRAhAtwCE1OAsnb1yRgguF8hX7RWtQvOLR0f0oE3tbXq2HadPmT6N7GHaeR+8
         Itg+UfDO6wBJ6h+ILddO5Vgpxv7GhuiPxcb2Y4xTSJcXP4rlDKnYkUkpVaBAbF4QDnyd
         1U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842618; x=1762447418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScsR3RF3FUX3H0ckwAV5EMhCJGDEfRpRd7qgc2we++s=;
        b=dR9jTAj7hhfllD6MtiEsqC9/avQFvVOJsjrCT6WWKWrrz0SM6f05SGZxmIr+S5nslq
         E6vzHcmiqwZWWTVFhDfbTcINan7CjuBN8+Lw0oiiDHuZTfLFEC2Gbqg8TgQXQQewT2Jz
         69FXQxH+ACSjevAoNu7ivAJL9rJrK7D6HsXjHfHWK/v6qPfLK8qnsjYYJTyO6O1dJvTA
         5Z3Z/mGUCUUysvPJ32VZrXMxQzN197fqgLAtkLlWh4AZFrOiQp6Kdujtonn8TpjBZnUo
         61gByPDDtjDRmWrp+sH+ISQBVloVfzoDYLIMwtWKOs3L03wWp7PCfhBWiUa9bwG5w9MR
         YNAw==
X-Forwarded-Encrypted: i=1; AJvYcCVWsX/L/DBNhM7ZqutiW6b3LBvrEs/Joze5Ltii/Po7chyaVDtlMQgMGm00IK2vhxqMAm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+LwNlUGXUxXwZugGUwv9iJECbVmiQkNvADK1mpVl13sUlHzx
	223156YtJswGzxPWvRZj1G0jBlZnjREivpsuRv1FUqblkT8aUHDVAcFnxvLz17tLxA29NmAclJz
	0jq55XYk1DfJgR0DlQfKKMLYnDUw+DiA=
X-Gm-Gg: ASbGncvlWat09WAfAEgt64yi5CF0cfWTCXiD/s915k84tLZG9ytZ5gGUXExFjskMeGu
	X1nQUCEzS86z4J5La6dLdgLyTEDkicbgt3u7CrT0LFef6ch3KvwZejbY900DaajVo7kB9GrcBT5
	VO/J0O95MQKMgWRrCpaFdpUHby68cNxqv95tJu/7IN1fpxldSgfMjrNHknPsfoq8nAsDMMqhP6J
	GSlYu8mbWBk4Yk9w/LiAgB1jho7kt3m8O3XLgsGLgk5rtn1JbpfgFpLFIsMEkarsEmSQ4U=
X-Google-Smtp-Source: AGHT+IHABHHYgP9UPdSaAL9Tyr/Tjj/DmATyHoB6SRmjVOqGejrhf07RZdi3a9r4TiomtoZ/2gaNdIWdCVNC+c/+k40=
X-Received: by 2002:a05:6e02:17ce:b0:430:d061:d9f7 with SMTP id
 e9e14a558f8ab-4330d1ea721mr5802175ab.23.1761842617639; Thu, 30 Oct 2025
 09:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
 <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com> <e290a675-fc1e-4edf-833c-aa82af073d30@intel.com>
 <20251030085535.4f658dd8@kernel.org>
In-Reply-To: <20251030085535.4f658dd8@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 31 Oct 2025 00:43:01 +0800
X-Gm-Features: AWmQ_bkAsHoydT5-J9trWZVBP9fFUV3qIY4KlwFsxFEgD--IX4m49PzB2kXlj48
Message-ID: <CAL+tcoAm_ScONpFUACi3TcrgKx_DUecZmEXpRJVOMwJHa29K9w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	edumazet@google.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 30 Oct 2025 11:59:58 +0100 Alexander Lobakin wrote:
> > >> managed to see a huge improvement[1], the same situation can also be
> > >> applied in xsk scenario.
> > >>
> > >> This patch adds an indirect call for xsk and helps current copy mode
> > >> improve the performance by around 1% stably which was observed with
> > >> IXGBE at 10Gb/sec loaded.
> > >
> > > If I follow the conversation correctly, Jakub's concern is mostly abo=
ut
> > > this change affecting only the copy mode.
> > >
> > > Out of sheer ignorance on my side is not clear how frequent that
> > > scenario is. AFAICS, applications could always do zero-copy with prop=
er
> > > setup, am I correct?!?
> >
> > It is correct only when the target driver implements zero-copy
> > driver-side XSk. While it's true for modern Ethernet drivers for real
> > NICs, "virtual" drivers like virtio-net, veth etc. usually don't have i=
t.
> > It's not as common usecase as using XSk on real NICs, but still valid
> > and widely used.
>
> To be clear my main concern is that the XDP<>skb conversions are
> an endless source of bugs and complexity. We have one fix for XDP->skb
> on the list from Maciej and another for AF_XDP from Fernando which
> tried to create an XDP skb_ext. We are digging a deeper and deeper
> hole with all this fallback stuff, and it will affect performance
> of both normal skb and XDP paths. Optimizing AF_XDP fallback is
> shortsighted.

Sorry, I have to say I'm against the whole point :(

1. Every feature has bugs. Just taking a look at the history of those
well-known features like LRO/GRO/GSO, you must be aware that so many
nasty bugs have been found.
2. The so-called fallback is not something that nobody uses and nobody
cares. It has its right valid position and has actually been used by
many applications. Searching in the github, you can find many related
supports in their own repos. Being generic doesn't mean being
shortsighted and useless. There are a few so-called fallback features
other than this, like SMC-R for RDMA.
3. Back to the main point we've discussed, there are many cases that
don't support zerocopy mode and I don't see anyone who volunteers to
complete the rest of them. So currently and at least in these recent
years I can predict that copy mode can be used widely.
4. I'm working on something that is really beneficial to me and some
people like me who need to accelerate the transmission in copy mode.
There's still a huge gap between zc and copy mode, but sadly we have
no chance to use zc mode. Optimizing the copy mode then becomes my
primary job after work.

I fully understand what you meant here. But the fact is the fact...

As to the maintenance, I believe we're able to cover this area and
make it better and better in every aspect. I really hope we don't get
stuck in these minor optimizations, shall we? I have more copy mode
patches on the way... I really appreciate that we can merge it and
move on. Many thanks here!

Thanks,
Jason

