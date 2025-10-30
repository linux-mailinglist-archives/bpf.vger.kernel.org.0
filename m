Return-Path: <bpf+bounces-72993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD900C1F8F0
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBD7189CFDC
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C534355040;
	Thu, 30 Oct 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htPn6Ax/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C812F8BEE
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820137; cv=none; b=tGWU4dDOnV9yUh3Xd7HrGFPnydQ3eD3AZTVXZWWokadd8A8Wt13t4oFnWGHjn+5NrKkqOQwRNUzwcmp53sAm+WMTQ5unB0fFqbs9eBvFYkMzLfOw0yHdiMTwgbYmq43JJQWVvqT3l+W14LwJAJj73ScTTs2Bvd7KuEp5xKx7MEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820137; c=relaxed/simple;
	bh=jNBoWYaJyXehjfJui6hBOb2eVdvz/N6C+xIxssWLtWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9lgtP5PB1W+jVBIcLagCJ9mSocEF4O9y3KjqAW1xVxWlte9Jjq/a7ZOydMqdG1pDZt+TrVRNVeUTxdXfweYkvBvlNCdSXpteMw3RtXqrdKGWBxq9WUDRZ37cgoPm2b5eZ73qiOJ+dTi+K4teqmtBHv6tNWNYu/HS4M/yITJyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htPn6Ax/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430d06546d3so7866725ab.3
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761820135; x=1762424935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjigA2w1+8bqCkfLQcxmjCEh/gZYzzclBBO4UhUv1Os=;
        b=htPn6Ax/aHlm8UON0DWReBG0fj50YkfX2N6U5sMnaGza7uLZDsvpOp6uWYJm+vX5r3
         /iw3KB1o5ZlKZ4iIP4vr2g+tk4vvUVExnEMC/WWXIdnGwgV9A5d5568sNs5J2RSvzkVD
         gcuDGXgvERRqQNwaHrDzGvaNxpHcN6R/EaOn+RReMTjjTd94597vPXSRw7Qi9isCZcqR
         1tBXZ8KFPIL43gfA8WNL2eID8ekrsO2VGPIYIQsTFPTtrGpkRn/uCWY7ciA7OY7sbuhs
         r3JBOczByxBVwXXxuj/bb/QS5snENAyss3FObHDiCXzpqRhgcNPgKG2xEyqZS7Pd1P4b
         alCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820135; x=1762424935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjigA2w1+8bqCkfLQcxmjCEh/gZYzzclBBO4UhUv1Os=;
        b=UXOm59eUhyOi2ki46s6Rjh/2sLsbQ0vUq0jNyTWC9AQb3znvMm6pWsGEhH/lDa8Si/
         yqxS7pnyJC7gMBsIqS9gRUX/rcL6/8qd94XRAw1395iK0ZacJc1cBX6MvdBQEdpth9YB
         mfREn5VbTxA06dtXkS1zg7RIHmYeM/5sQtTsx25xW5fne5fbObma9WYq28pGq6vxdlNf
         +cDqQzlstY1MvMryQraHNriAgu2YwN0F3WZK71bR2ADkp4Re6A9zBkt/ZI9qcuGZLGx5
         /iAi0RpOCRST32nMCv2VoLszqpKOMA+wrVLn+1vmhhEY9oRpspvxGDvR0XsrBKluf4Hu
         ry4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXB+oODJfV3/eXCadw0lDAfo1RGKuMq5RsKc/K9fS1kzG1+RKCrRPvlmQNlmeNwoigTsc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZfckYsMwHAG9F+AKAjW30Z0CrktzQzYHZrgPDKhPMb366ex4
	1o54kjyaiv0jpUbcYH8cBo8FP+VBlTREVXNwGI2i3pAbAoJVJ68Hg1vGo91UoEEEbA6r62cIUwb
	NdUuTeHmnu0CAeRTMO1XbO2S1eg7dk+c=
X-Gm-Gg: ASbGncsBbUlqLSD55YDncVohs4ZPM2DNYcBTfdy9Y77jaqI0TOLadKtfGlVF4wI+SOa
	/CbhPlgoSXPmTOeeBxvCON0/DZC80/+fMITPo9mmZ6XaBiV3jDTVnkMN+wGsObHiPgn63nEmFTZ
	BInZaFcNSw6aLKjebZymXg474xebvv7h2+0IoJtjJr9tX0Z04t3RP5VstwQhcQsDHaNUuRmJvf/
	L0DddMBOZtxpq8zs5cQwVFsdPPAi/RAKUaafga2eFUD1JPVac+xhN0ihyJY0EN+tY+h555dj54v
	lOsauA==
X-Google-Smtp-Source: AGHT+IECoV3waLMBGW2VDD/GhN0MHNi5SgzaN95ahLWIpxZ39GGeEd2gaiibvGhbBYXakXaddVVs0NWE+UX8+u/LWo8=
X-Received: by 2002:a05:6e02:2385:b0:42e:2c30:285b with SMTP id
 e9e14a558f8ab-432f902b4afmr77878175ab.20.1761820135381; Thu, 30 Oct 2025
 03:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026145824.81675-1-kerneljasonxing@gmail.com> <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
In-Reply-To: <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 Oct 2025 18:28:18 +0800
X-Gm-Features: AWmQ_bmQi8GJMMAdtPGC0goZLlXFuCJ4nTdiqFQ0gnXknrj3Q3iOMn21WQjOVi4
Message-ID: <CAL+tcoDLLqr5q-hvcu0PapnMUwjsewwQjmACG3h3SRWEfSRhYA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/26/25 3:58 PM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Since Eric proposed an idea about adding indirect call for UDP and
>
> Minor nit:                          ^^^^^^
>
> either 'remove an indirect call' or 'adding indirect call wrappers'

Oh, right!

>
> > managed to see a huge improvement[1], the same situation can also be
> > applied in xsk scenario.
> >
> > This patch adds an indirect call for xsk and helps current copy mode
> > improve the performance by around 1% stably which was observed with
> > IXGBE at 10Gb/sec loaded.
>
> If I follow the conversation correctly, Jakub's concern is mostly about
> this change affecting only the copy mode.

Copy mode is worth optimization really. Please see below.

>
> Out of sheer ignorance on my side is not clear how frequent that
> scenario is. AFAICS, applications could always do zero-copy with proper
> setup, am I correct?!?

In my env, around 2,000,000 packets are sent per second which in turn
means the destruction function gets called the same number of times.

>
> In such case I think this patch is not worth.
>
> Otherwise, please describe/explain the real-use case needing the copy mod=
e.

I gave a detailed explanation in the cover letter [1]. The real use
case from my side is to support the virtio_net and veth scenario. This
topic has been discussed in the version 1 of [1] and Jesper also
acknowledged this point. I also noticed that there remain some
physical nics that haven't supported zerocopy mode yet and some of
them[2] are still in progress.

[1]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gma=
il.com/
[2]: https://lore.kernel.org/all/20251014105613.2808674-1-m-malladi@ti.com/

Thanks,
Jason

>
> Thanks,
>
> Paolo
>

