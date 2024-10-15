Return-Path: <bpf+bounces-41913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E380F99DB4A
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C9FB21ADE
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C3184F;
	Tue, 15 Oct 2024 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx/MIqza"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF156446;
	Tue, 15 Oct 2024 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955701; cv=none; b=WGI7OIOwzScJ4ObiWdFRGd9FLctGyo2LeF66M38BTw3KIZATgEJx0D0HLfaoGuEO8Smpf4cp/Xu9OlDf+CihsxxGyZkd5rHty2YeHD7dVsZrDJWKBTDQ8sI5lNk4Xt/65IVftXcDSM4UwyAU9IJDRREYGSwDS1tXQywp2fiepWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955701; c=relaxed/simple;
	bh=1ifIzOqSg/gy3GtICQKbqoPB5zo10Mse0UinLe2gNus=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ty+WZwahg7+3AH3Zyhsd7Wb0CPn6NgGZLCTdGLM8E9hU4cCspvlawQ1myUI7lsi/k2Ok1uzBMl+mmH2E9tkDXdeHplNHoCFbZRPqACKIOi+V7h/Lk1HgfzzGPwf5k3SGMUum/zsUE5yM9kupZ3q76yKQ8uEwX3dJJffGi4DyJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx/MIqza; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7afc847094fso380659085a.2;
        Mon, 14 Oct 2024 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728955698; x=1729560498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ifIzOqSg/gy3GtICQKbqoPB5zo10Mse0UinLe2gNus=;
        b=Nx/MIqzabBbwCSAgECJ4URP0bLpiLComsBkK0Ak30FA/0H+NucGc/3ounLfZRCeDO3
         IC3SWs3luMY0w7x7IS1ov3Obsoq3dS4oouC3S4jcfG2Y36nDXnuXZt/Tsqtj7W5YXOm5
         anck2JKXjXN+wdwk3tXRmgdsMcTDnxGP3NDWn4Hg6+76SIlnK2akWqol1yrWL9nZdI+p
         gZ5HZkvkMcn6DfUvUgBcCttgsnJr9Ak7WVadU2h7nar6IBERPEZaCbhDZI0NZXhJfCAe
         G+c/xzXzgUEM1fJStoaVmnx6XG3aNbfWuPF/XP6hoBkogf6mmcfqhlwqQmTsK+1brsel
         H/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728955698; x=1729560498;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ifIzOqSg/gy3GtICQKbqoPB5zo10Mse0UinLe2gNus=;
        b=u5CBoUTTdzRUetLW4T9UAZj9XGZS8LcTwu1wHP4pOMqgJjhKIBYO6EXi7r5MpUShAj
         mRpNbtCeHueK2dwLRrFbRC7AksdnQDPH30FVGQvpEyAyi/AiU2HjJGPOQ31BF4Qv01Mr
         hkjL+CUaB8ZN3EQuAN3BKwy9GcVfGrWvovMuNrAU4f4gmE5XkonC0D0Kg0F9DtidNwjh
         pB6AKj37TFyRPr/pvk3HwnlmZ9CEX2wUDNSqDPihfScFnf1RfCz6eB4pxiBGhVPZfDxm
         ZJ8RaAk+phDQCrlYM5vSK5ROXCV9T/1byEroJKW8F/UzYDp4fzXoPsF/7tpVYujPZB9+
         jIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmEAvW1Jsrxn0SDcGufl/ZsaJQKjfxwoQobWyti8VOi8jNcsZAUVVrBet6pttdQIStbNm00c4B@vger.kernel.org, AJvYcCXqcy8RzX1pHDsm2fHWHVPo6e/+ZGFjoW7OLtbod0q7L/XXt5N5lv4OhqjDI5kDF9P8nnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBE+VZRg8JQuc0pWtQB/rRqpG/aq4BdwdZ97EmkDDiIb0i+89
	ihrd4fjTfr6n3o4uZz92HANdDsni/SS267CNlBkRzWmJ5am0kupa
X-Google-Smtp-Source: AGHT+IE+DwzYzSjv/4pHwa1wYGRHARTlr0R1JiZgXfDwTZIc/fLXlbWPJlsgMKEG2RK20mILJDoNiw==
X-Received: by 2002:a05:620a:4709:b0:7a6:6b98:8e36 with SMTP id af79cd13be357-7b11a35f48bmr1948265285a.16.1728955698097;
        Mon, 14 Oct 2024 18:28:18 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1361716dasm12296785a.48.2024.10.14.18.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:28:17 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:28:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670dc531710c_2e1742294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch>
 <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] net-timestamp: bpf extension to equip
 applications transparently
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
> On Sun, Oct 13, 2024 at 1:48=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by us=
ing
> > > tracepoint to print information (say, tstamp) so that we can
> > > transparently equip applications with this feature and require no
> > > modification in user side.
> > >
> > > Later, we discussed at netconf and agreed that we can use bpf for b=
etter
> > > extension, which is mainly suggested by John Fastabend and Willem d=
e
> > > Bruijn. Many thanks here! So I post this series to see if we have a=

> > > better solution to extend. My feeling is BPF is a good place to pro=
vide
> > > a way to add timestamping by administrators, without having to rebu=
ild
> > > applications.
> > >
> > > This approach mostly relies on existing SO_TIMESTAMPING feature, us=
ers
> > > only needs to pass certain flags through bpf_setsocktop() to a sepa=
rate
> > > tsflags. For TX timestamps, they will be printed during generation
> > > phase. For RX timestamps, we will wait for the moment when recvmsg(=
) is
> > > called.
> > >
> > > After this series, we could step by step implement more advanced
> > > functions/flags already in SO_TIMESTAMPING feature for bpf extensio=
n.
> > >
> > > In this series, I only support TCP protocol which is widely used in=

> > > SO_TIMESTAMPING feature.
> > >
> > > ---
> > > V2
> > > Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljaso=
nxing@gmail.com/
> > > 1. Introduce tsflag requestors so that we are able to extend more i=
n the
> > > future. Besides, it enables TX flags for bpf extension feature sepa=
rately
> > > without breaking users. It is suggested by Vadim Fedorenko.
> > > 2. introduce a static key to control the whole feature. (Willem)
> > > 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature =
in
> > > some TX/RX cases, not all the cases.
> > >
> > > Note:
> > > The main concern we've discussion in V1 thread is how to deal with =
the
> > > applications using SO_TIMESTAMPING feature? In this series, I allow=
 both
> > > cases to happen at the same time, which indicates that even one
> > > applications setting SO_TIMESTAMPING can still be traced through BP=
F
> > > program. Please see patch [04/12].
> >
> > This revision does not address the main concern.
> >
> > An administrator installed BPF program can affect results of a proces=
s
> > using SO_TIMESTAMPING in ways that break it.
> =

> Sorry, I didn't get it. How the following code snippet would break user=
s?

The state between user and bpf timestamping needs to be separate to
avoid interference.

Introducing a new sk_tsflags for bpf goes a long way. Though I prefer
a separate sk_tsflags_bpf and not touching existing sk_tsflags over
the array approach of patch 1. Also need to check pahole and maybe
move sk_tsflags_bpf elsewhere in the struct.

Other state is sk_tskey. The current approach can initialize the key
in bpf before the user attempts it for the same socket. Admittedly
unlikely. But hard to reach states creates hard to debug issues.

This field cannot easily be duplicated, because the key is tracked
in skb_shinfo. Where there is not sufficient room for two keys.

The same goes for txflags.

The current approach is to set those flags if either user or bpf
requestss them, then on __skb_tstamp_tx detect if the user did not set
them, and if so skip output to the user. Need to take a closer look,
but seems to work.

So getting closer.

