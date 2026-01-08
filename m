Return-Path: <bpf+bounces-78265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FCDD0687D
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 00:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E5DD3012ABA
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 23:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E26333D6CE;
	Thu,  8 Jan 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoYU/nyR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DE279DCA
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914462; cv=pass; b=YT17OnZXwaZ4BJSWCxMis4/h/WUpx2qumqt3wykO8HMtUFQ1IxAlE3NBi1gFD0kmvLzqsfKI9iImFty2+DWO7gljKRzBk8xmb1PqElgz5owGhQMBX1JiBPkqWMZOLr0QHS9kzSTzLoKJF239C4OhjxRfzaGUgUY1m86XpqUgk4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914462; c=relaxed/simple;
	bh=rhCQWH/yPA2hIsQ82SImjkWBzo10eMRYT8Mz8RFa9JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+PA7Yois/tLzvtnhxR8MDrYW2xIQjsFZ0IPZn19QwfgJ8kMWY4ycZuJhmE0oy6IFzYe02ozXJvMDfxttKjgBpnZ0kq+PXslxSjt2HCfE5L/tHsfSP04JyNZwOUOErYdXFClFGxrpJxe5HZ/uQDQO8GF0jN0ZqgAtGllK7XETzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoYU/nyR; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee243b98caso79631cf.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 15:20:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767914458; cv=none;
        d=google.com; s=arc-20240605;
        b=LOZjZ+V6rpD3hWW4oWWt2/BviIW3Ngrd1PQIsYXQo9KD2sjMvvvenm8DqhlMrwKAwk
         ZrZhP35SOcyrNFu4Tl17GZxIG6dp6CSJIa7k3qBsYJsumamdWVyoSFfPJ/fEb7Jin/lq
         FJQvXRzmAANE+vHOZUWrPUe2GKwHzRMabOE2DJYLhJ7BVDHI3ffDsqWIpnzwEbrJdCiS
         Bs5/XvZddX61PTJ4T8NyZuK7ubz8OoUwy0ZTXRNcOOff1/+eAcrGlTorPUAG3op2YcQ9
         qbr7wAIH/h7ErmbbjeNuKCZpCLH/AkM3MT45zk/9Nenjz4q4InJ5h0cQUKRNTZ6q2Ji4
         QRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        fh=4/W5F26rSOLOtAQ5Tmqbhyl62Y75GPPW45XOjlvuqyU=;
        b=LCc5ramh0oSh6AoH01hm/AY3CUKGrkk7tuHGA3ngDtpJ305J/Z1p24lGgvxuUzk6+9
         cLXXSS5HF6NwmqjrBoH7XFIQyhI+RlFqwuXQ/Enu+8Pkyv2z4bSYIuZGMAyWtXLYMBTC
         AZJ0LCfd3fY4c7Y1nAAPBMZ3b5dZKSSdyUJ8TJphDtcLXh4uBHf6R3Z8lRTeGGURbvoK
         nFWQGDlycWrLBGzYDypbnFoGaUypuLUpiBoCjShaGNXEGTK0EXAe/7f/t0SthTw6I2Ea
         hNx7Cs9PjP5ZO8aiv0QNbVhdMsNbIcnUfmVF2Po+byUXS76JR3OGwtdKsBjvqoE/Wjgh
         a8OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767914458; x=1768519258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        b=PoYU/nyRL6U8AMm+w6+xHu6Rp4iz1e1Zjwndtf1P91rPFzimAMia/xk5fhd449Yzxq
         wOals5bwl/YzYefe3/yTZAjAWkISnRAZn8K1QbpSXs2ccRYiBBAN7hFiMcvfG2xwNXC1
         K57zh+rov+V7kAdpWShLKBCoQ9SSw7P9vZDUIf9q4Q8vTWZJ0QcuRBaPhvGnNIkmk64d
         tEo937ako0z2KeIh2dBrKuWwBp5257PoYUZg7RYNYYdqCoTlndR5zq6h3fwcT3bizaPf
         M86h+FD6RdajgFP379GAaSe+QJc4JG99+Zv5ieYjS26cJc7oZwDse17dx9FHSYA2SaM6
         5gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767914458; x=1768519258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        b=kAEJprZbNtYmNvmCPAzL4rSpRaeFpRI63YUZYS7GqUp4lUkhP509wF5iDEyr4oZVeA
         fvHVKvYMOqYe7OvfDWzsvBrKYJONFFhkyvJYWDIh1v5J7ckTxUF+Qoi25m9JKj0TCSya
         KNjU3twAVFolqQaReZCIAi4G2PGqGHgi7l7QCngZwdZJjNiXmbaG98FirRmTxDa2kTIw
         Jhm3DyfI52cslU3goXZIdMCTCLSuVxWJdWXXET0hoa4nmokKfZ2DGTOr0Qpe99szNKz9
         2KU7Vg4wyBsTFcvQ111BSJOjAPiURuizLB9jsl2lXLE+S3emHMneYPcVPLm917udYb7e
         CFhA==
X-Forwarded-Encrypted: i=1; AJvYcCUiwIgitldBhz5td2utFIrq34iY7M7JT1z4qEdoGPH6d3w2pg1wJIGIcnJiLd0+2JLB/vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhE5OwsXvu2odJbEXGKH6etEHL5zmuGBqs5gvfNds0cVjhEpO
	eb0LU3hL3BkGmAuYKSrAhgokHyz5azOBVR0FRbo+J57KrbP1kh9HkXhbdH9KnlUJ5E4+Q+dkfVD
	C7VXUJUvj7UuXTL3xZcDfqWU0Jv2xzyYk6j25C+Cd
X-Gm-Gg: AY/fxX5briW3lkq4cU7N3cAGIyGlL7Ww66LMiiXU1I9XjwCtOzICNgMJ95Y0KnIpQx+
	JRlOz9HyeYQGwh9OYronsP9zPAuDmKpdcFBcv5735+ZYCDetm51F6Lm5N8HWXVjOzaGK36YyQi9
	w4g4lvc5c2I/03j8OhIOHcmF0yfLMfHWdmsARTAeE86ojaVq7O3oqOKDOrBv0Ims94HSRMBex13
	Qr1s2guRCMMHbgK3mZxTlqPSTfj/EZSzxKoAugbpzf5vGg89oHq3RKFj/uLHwwymaqJXG5vZPBs
	d8kfDqtRqPNtfCJ0myIivAafEuaiSgfLLUcwgjAXPkUFg5XoXzMoWgueUE2XdveW0LvIYQ==
X-Received: by 2002:a05:622a:451:b0:4ff:bffa:d9e4 with SMTP id
 d75a77b69052e-4ffcb20efa3mr2340841cf.13.1767914457681; Thu, 08 Jan 2026
 15:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 18:20:40 -0500
X-Gm-Features: AQt7F2pqVzz9M7qiJp7DfsnUleYfVSMGUfqYVX43z4keU7aZSTGIZ7pkvS8mv_0
Message-ID: <CADVnQynohH4UyvyKm9rUNcCMbnepJKMwhOCPRFzM5wTvpDR1ZA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---
>
> Chia-Yu, thank you for posting the packetdrill tests.
>
> A couple thoughts:
>
> (1) These tests are using the experimental AccECN packetdrill support
> that is not in mainline packetdrill yet. Can you please share the
> github URL for the version of packetdrill you used? I will work on
> merging the appropriate experimental AccECN packetdrill support into
> the Google packetdrill mainline branch.

Oh, for that part I see you mentioned this already in the cover letter:

  The used packetdrill is commit 6f2116af6b7e1936a53e80ab31b77f74abda1aaa
  of the branch: https://github.com/minuscat/packetdrill_accecn

Thanks!
neal

