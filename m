Return-Path: <bpf+bounces-66912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07C4B3AF7D
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 02:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A9A17C6EB
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 00:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42FE14B08A;
	Fri, 29 Aug 2025 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neO4ie+3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37072614;
	Fri, 29 Aug 2025 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427517; cv=none; b=IPy1NW7wGotPjPnMqMbex/Sax/Y8ci5J/VOB4ahO6BsEF1dt64oMhaWaUbdCYeaJUGeyKjWA1AguGR6QZv1w+0w64Es0SFHGtV7PT84NzuPg04shJLjjOb7A4d6h5hc3VyKAfpIdwSmlYXPKwTu2U/LVgYizt5z0q+mcWAuj8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427517; c=relaxed/simple;
	bh=ABlFmf0bedrZpweMBtl9WZsWU1lfwK8DnF8GKtSqjXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tnha1GwDlrK/cSY/Ocoqdrbh8X1EKdesfdNYDGPNC1BjGfD2fxdgFTC6vUi4i0444nLP4gRb+3NLisQhRT7gudkTAp2v451NorPkIBOb0eP531vQPC8cBStF9/BVCzw0cWa/9tV/bKN9bWndpk1QstHk/Pf+qlpiWKtFB1ko4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neO4ie+3; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88432daa973so44147239f.1;
        Thu, 28 Aug 2025 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756427514; x=1757032314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jcV9IGK1Y8AbgjMsYPO/NSZt2dKq8a3BQdAP04HXA4=;
        b=neO4ie+3I/IINS0rnZb6EEnib4dT1YPsdNg5jKEyKIjgWvp2zy+ozltMdkozVMaq3w
         tUpqy83djdL8qudNqb3MGy81fNsr3IglDKhmIHtFA1s3/jxTsYRjwA6IXkIXpZdeiLne
         ZXzn+Yrk73O/Wi22DqdHXqBV7RE09XldvxNZxZnwarXmLvVz30EyPlmugnuUKXiVO7hJ
         rOT+k1IPtwkB6R+MNEV01qj4iNeyR1rg4fRa+HLfLrhcJRu+lwElQjKLUmqsI4+eckOs
         j5/qG4+QtVv8vRJg4suEXVcgFRcWUlL3+Nk2eGNvxfiL1S0CbUAmK1VIjAXaRwTw75LL
         xJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427514; x=1757032314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jcV9IGK1Y8AbgjMsYPO/NSZt2dKq8a3BQdAP04HXA4=;
        b=wnLVAQuf0DTTR5M+fs1pGf44J42F87YJUITqLYcQyvkLDRZKaJZsRvU5nsMyBhkI9V
         C+dZctS1xk73+EeetKrcWjVi6kgeXVveTmtp8TtIMvedNj1hG4UhQ1R9LT4gGuQ6/ReT
         ENkzrxXYDGSFG2WOeLrIy5MeKWQQBKIkhtsvhHagl4Qz4H/9u35RZ34jC2fnGXmbnCmS
         f71k/yzzFxBdbwj2r4ssv8dHnNHRsftZ1rntTcRN/i8aiMx3ZSQgmPc5I5kZu3dsMzoO
         abNyHwqV0iqTP1bqhsXcuRysApojYO3za6o1Uhg7+caaY0ojym2/CB0oVC1wnbo8vWfV
         gD3A==
X-Forwarded-Encrypted: i=1; AJvYcCUfUMTvJVw9sj57pcY0gXo46isRq0Lzzm/evbipGx6gmgYLUwmwbQ11kwe4H/Vwcy8oXLI=@vger.kernel.org, AJvYcCWj+aNDhbTb4q62C6CJzD5YzeKFItbACIYpAEFy6gJBs9NHH6H5WaK1qpMHvRLEh/4KAba9nUw6@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKA84CYuWKr+IUguqn43aRbWfMPv5hSKx5TicdZvzV+OmdxXQ
	7vpuGidzsgPL2007/049S7lmOxUPcbe1KNOr7vAsCMpOncZr1zGS1ykf1j+eA+8SFyMXG+ywyAF
	ZE21vs25hKcrMFjtWbt7sasyLrWDofNU=
X-Gm-Gg: ASbGncvHCH9tyIvElgzUrbi0NZxYtrj/B1v4FZcEdA+WEdy2VkQYXddJz8uDOOez7C4
	ksEJsnFjUprnoDJn2nrLw3C7H97Epf5bFPgejXkJ26tHsYeAuNUmkUlAY4JwSem5hpNzuJoJzO0
	FHK7wmRE1cPvkxhMHMI0uwjVuJUDmlE2OzrTYZC7KlEZwrwv4EobaXJD+otk51p5OmgFAJA09hj
	euh9zwGT86l9UUa8A==
X-Google-Smtp-Source: AGHT+IEhL6L6wkVDdfsa52WM29fU7WimldoM+zsyqxjY2CHMH+r5eyoO3bh9RbQvKDE0dOYoGh5A3vMPuPyyAmggkZY=
X-Received: by 2002:a05:6e02:228c:b0:3f1:87a1:32fa with SMTP id
 e9e14a558f8ab-3f187a134damr48708765ab.27.1756427513901; Thu, 28 Aug 2025
 17:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-6-kerneljasonxing@gmail.com> <951bc347-0c33-4359-8d15-0e5e054b951c@intel.com>
 <CAL+tcoCBTS0T-DNRjC0k2pH+qveM6=OHQ98eatp7nG5g1DA=bA@mail.gmail.com> <f0c0a512-900b-4d12-9e59-5fbcd35ed495@intel.com>
In-Reply-To: <f0c0a512-900b-4d12-9e59-5fbcd35ed495@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 29 Aug 2025 08:31:17 +0800
X-Gm-Features: Ac12FXw_2Wf-fkbu7TvZ5qNodmMkCKXbC_RtSpfX6TavoARY_8oV1AMorpyjN0w
Message-ID: <CAL+tcoCDpyyVd1kiutPsH8abNRkAcoo=SkXKVJG+U90pAd+3tw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] xsk: add xsk_alloc_batch_skb() to build
 skbs in batch
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:29=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 28 Aug 2025 08:38:42 +0800
>
> > On Wed, Aug 27, 2025 at 10:33=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Jason Xing <kerneljasonxing@gmail.com>
> >> Date: Mon, 25 Aug 2025 21:53:38 +0800
> >>
> >>> From: Jason Xing <kernelxing@tencent.com>
> >>>
> >>> Support allocating and building skbs in batch.
> >>
> >> [...]
> >>
> >>> +     base_len =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headro=
om));
> >>> +     if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> >>> +             base_len +=3D dev->needed_tailroom;
> >>> +
> >>> +     if (xs->skb_count >=3D nb_pkts)
> >>> +             goto build;
> >>> +
> >>> +     if (xs->skb) {
> >>> +             i =3D 1;
> >>> +             xs->skb_count++;
> >>> +     }
> >>> +
> >>> +     xs->skb_count +=3D kmem_cache_alloc_bulk(net_hotdata.skbuff_cac=
he,
> >>> +                                            gfp_mask, nb_pkts - xs->=
skb_count,
> >>> +                                            (void **)&skbs[xs->skb_c=
ount]);
> >>
> >> Have you tried napi_skb_cache_get_bulk()? Depending on the workload, i=
t
> >> may give better perf numbers.
> >
> > Sure, my initial try is using this interface. But later I want to see
> > a standalone cache belonging to xsk. The whole xsk_alloc_batch_skb
> > function I added is quite similar to napi_skb_cache_get_bulk(), to
> > some extent.
> >
> > And if using napi_xxx(), we need a lock to avoid the race between this
> > context and softirq context on the same core.
>
> Are you saying this particular function is not run in the softirq

No, it runs in process context. Please see this chain:
sendto->__xsk_generic_xmit-> (allocating skbs function handling).

Thanks,
Jason

> context? I thought all Tx is done in BH.
> If it's not BH, then ignore my suggestion -- napi_skb_cache_get_bulk()
> requires BH, that's true.
>
> >
> > Thanks,
> > Jason
>
> Thanks,
> Olek

