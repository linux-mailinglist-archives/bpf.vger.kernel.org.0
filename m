Return-Path: <bpf+bounces-60880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07064ADE001
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 02:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5BD164ED4
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C882746A;
	Wed, 18 Jun 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4+6Mc3j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26C2F5313;
	Wed, 18 Jun 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750206753; cv=none; b=Vt7/gREeU8S7ni2R18uh4xPDm43IS1AdApvwC5XqlyKEgnqz3aHOGci7rFov2G6BF+drQred3enXZSW5/TWgMEyD3qC8HycYda7ualAg6GCKPRd2kwTYOw4Iez72UWbHtxIDJrGpWFPlVZ5gu1b6X+Hu8j50J1XTjcsS9AxVfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750206753; c=relaxed/simple;
	bh=gRD63paj8zYb8vqRhC7emST10NJ6H4lIO2wH0ZxCBVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XcXOJZl4eBG3M5o1+vdSSQ7PGd71EqUeIoy/jwJGCFLM7tjioYyzFhqx0AgTtfU8y0Z/gM9XK0THEUuXNSudJO6J4XhJLBnEGOzIyzzrGABJoSguBneC5CNu3sikHqYTiFQDl/9/1ox9tkOgttBYwp7+0PW1Psi2YMreOrlIWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4+6Mc3j; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3de252f75d7so10145485ab.3;
        Tue, 17 Jun 2025 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750206751; x=1750811551; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRD63paj8zYb8vqRhC7emST10NJ6H4lIO2wH0ZxCBVs=;
        b=e4+6Mc3jGEnU8Wba0LCzIxbbGFnrrgN9jRTdNqxoRclegUfzZjPIbUz6a3eagh9DrY
         w2JvORFnqQKxBZzVX3WdT9t8kgLHJCMr2vwZeOI1Nu1RvhPErBiUbexrZGVYivYwFU6w
         s6tK/U2B9KQxzEVuwLpA2FSq89OlzCM9ZOYRshN3ZI1UXcmU4kMOYM2eoDAX3fVD8fcB
         qek5dc9v44cHBRHmoAOx7wCBOZ6jp9hDi0ZCmyc6pljUqOwsTiG0r7azZMrunbw8NkO3
         w4aMvIcQY7l9cCW6yIkCu1fqUztPW5sKGJoJUQI5HNmSuTB5iPUkSKErd+xvy+UDCfwK
         814w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750206751; x=1750811551;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRD63paj8zYb8vqRhC7emST10NJ6H4lIO2wH0ZxCBVs=;
        b=iULTfm9FyHVMPYiRacecmTI5XUuPUH+Vq33rDENk3h8b2Lu3PtlLsSj5VRGA8tmiRI
         mm/G9+eAEWUCPebIPZkOTBq81biDRE4pdxpSR/iTGD0SljRfwSVHYlID9B6wqsYttAjY
         2Ksz0cPh6w5BO8BREczm5fALg6S3F0Gkcei4eQEknmMPJXELyEETTAyCb+zqSKiPBtph
         Ptj+e4xRXScsFk01ESux3nkf7lnMai2kNF+RvF9qocv1hGZXKoJtMio6BfxCORNyayd0
         2tc6XomrtlC8pj2LlG0fAxUdbO8ppdTJvQ5eVeJzKbCTmSYAqlDmKzZvEVjNUFe2+hBh
         hYzA==
X-Forwarded-Encrypted: i=1; AJvYcCVLn9sySoBf2rskfyiUve8WRFgOtGGkQs+zWsUiw3LJXVGSElC30SlC0MEm+I2aJPOoLDFARQjo@vger.kernel.org, AJvYcCVcNXeZN99vLleH7QBv238UUjxDXQU8sCubjVmzMDDn5b9YGr+3u4mM8MM7omHWBBM2I9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9d3djy5rMYuB4ZOyWdfxDC7HXx80QAyn4mrVkpSttQWUS1Is
	8oITBjOQcrE4S5jotvJcXUM143FdMrEAkSLRinpsjIWdjPl5gCbIlm017s4uzGNvgCikfIZ7xzR
	FSXxrFj68cys7lN4jn4lGi3F/bl94wB0=
X-Gm-Gg: ASbGnctqB5QFj6YOkSe7Lb9ygPrR4aVKrcMXanXTZ41CuWo4n4k1l2jZUIVBsb9Tlta
	sW4MIqF2vuVhelfkqNYOB8+ZobqdY6yx6fNeAcbT/P1lkEPrg5tyXhqv2W4ht9iXwNxbnIP1x/4
	gXrFiyCQHTNQCBs1ZUQLt1YM5iHRWuclz84/YPldDvPODHqS+Zb/tv
X-Google-Smtp-Source: AGHT+IEoUjHGuMcbn0vuucku2ubMhfDr2MZ9mzCwsctHfGG771naqIAzGep2J28JD1GOwIRFuYZWt6iybjoANyhJ5AI=
X-Received: by 2002:a05:6e02:1a2b:b0:3dd:d746:25eb with SMTP id
 e9e14a558f8ab-3de07cd170amr178487945ab.16.1750206751301; Tue, 17 Jun 2025
 17:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
 <aFDAwydw5HrCXAjd@mini-arch> <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
 <aFGp8tXaL7NCORhk@mini-arch> <aFG_U2lGIPWTDp1E@MacBook-Air.local>
In-Reply-To: <aFG_U2lGIPWTDp1E@MacBook-Air.local>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 18 Jun 2025 08:31:55 +0800
X-Gm-Features: AX0GCFvHM96B6Xidefi7yZNbGcKX7cv5xfztkil6L5CcZTJxtBwwX90cywalQ6M
Message-ID: <CAL+tcoA67FiFZ_DVO-22vvWEcPjt1UScb_hcTvJhuWsiEYd5EA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
To: Joe Damato <joe@dama.to>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 3:17=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Tue, Jun 17, 2025 at 10:46:26AM -0700, Stanislav Fomichev wrote:
> > On 06/17, Jason Xing wrote:
>
> > > >
> > > > Also, can we put these settings into the socket instead of (global/=
ns)
> > > > sysctl?
> > >
> > > As to MAX_PER_SOCKET_BUDGET, it seems not easy to get its
> > > corresponding netns? I have no strong opinion on this point for now.
> >
> > I'm suggesting something along these lines (see below). And then add
> > some way to configure it (plus, obviously, set the default value
> > on init).
>
> +1 from me on making this per-socket instead of global with sysfs.
>
> I feel like the direction networking has taken lately (netdev-genl, for
> example) is to make things more granular instead of global.

Agree. Previously I missed using sock_net(sk)->core->xxx to make it
namespecified :(

Thanks,
Jason

