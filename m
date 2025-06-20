Return-Path: <bpf+bounces-61186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5125AAE1F9D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC557AB269
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3652DCC0B;
	Fri, 20 Jun 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0x44QKF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0856919A297;
	Fri, 20 Jun 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435136; cv=none; b=VR6RrO+pZBDvNdz2J29Hrx/4kS5EgQ0cis9QexpY/uA++rxCw5srcHbrx2x7mAhXUBtAUGPVIbrr/724bTSM/O3ePqByZvqDaJWL6luyVFrdYHh6Rrx21Pvp0JndETY7lwDNWlr9WqJ98sUBgSlr9bqgXU+Jei1eDcmFEcXVsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435136; c=relaxed/simple;
	bh=okTH3Lz4aizn4CJfqFyaxCutsGlQDFV+MXR0OVw3Zuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdvvIww9cL/HjHVRHg1MKpFemohHoCTBt2wSddowG02y8A+XIFhzj7v1DCr/q2z5jnNmLln3fz7/75XIDxIkYq9IsmT1m1LHw4/ZcmIs27yZkV61/PXE9Y+xOUsgSVhPRzzVmtPeeZ6Q66ObMs8HyuSvEzHWqZ6ziw3ui2h+DLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0x44QKF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234b440afa7so21760405ad.0;
        Fri, 20 Jun 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750435133; x=1751039933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCLttPvOS3AE86Fe3hFay+XJOMSkRRHZEJZbK81KI9k=;
        b=J0x44QKFopnFzMB7jUjJ7mK2t9+pEunn1vIgd9YG9lly2hsxvKCA7ArsNq8cI7oVjO
         j2Vnvzv+4qOhaUzb4s5EYDXbPskKwAbH4aA9bK0t+Ys2Sp6Qxif1hGRtmqAbq9mDjHMg
         mlwJ3LjWwt1vWIiaZXTzdu3NP4i14mlOO8G/zKfpz0huxB0Pm90+CcrSQ7R8CIilJ132
         bjAp53AlcbkPxVSf3CxpHGvcjsI6lVCfZEV3JuU9tIl/bhU+oQFXBW6hV5RBMaaruRSR
         I/cQp8YGmjqjo2sxyxml136l/Y3oscKXvyHmu97eO3PxKt6vAJaPMnd+1jPaMTaZkI0w
         iGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750435133; x=1751039933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCLttPvOS3AE86Fe3hFay+XJOMSkRRHZEJZbK81KI9k=;
        b=FThGoXZAPyM3xdCyu6rjRhrRa3spbJYgO6KJh2SONkZ4wSNO+izPHMuHuGGdj5a1le
         D85JUaINT81B5DWY3b3NdlzbXexLJGCTDR+EPNEVgg853pCJiFDzFwDdkOc/UG/UJ34q
         RW4RxTt0AlFTEryvl410uuJaYFyvjz/9Im8Fg5eO9RM8Llekee5Srw8TTljZ3TNnfdkU
         fCdQ+SPokKEY1+IJJFJS1ZHIW4JsLqVa7TrAEN+uQ4pk29TazA99NUTdUlC0tmdhe63J
         u24hzTu2MiUJ2G8UiDEcpzCTK3j8IkouxvboK8EbPgd4uaydFdOJAi8tEnwf9+4yxcqP
         8F6A==
X-Forwarded-Encrypted: i=1; AJvYcCVRuCUtL2eRac+mk3BernOJrZfdDb8UV6k9D/nXeBo2Vc3ZqUVeE1+1msI3L/LSgttPdqwYdjeJ@vger.kernel.org, AJvYcCWX7ZZ2GZs11wb9xAp/8HmRrxPZ/njmzjPW/KYpuqbLqloc6BiHY4S0m32jqK0xSDAavW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuD6x0qk+lQ4eInaXEMaNIVYRUaidxbe52C8DyO8LhOarhAfi
	97h6TVdyXeGio67YGjbFrcyMJVmTRbL6DovA5qtojxZH2pDv9dLsKG8=
X-Gm-Gg: ASbGncuJgCia/W4dfM10qRA/Q05RTecutCV05k0ahk1IH6+HQRRfQiqpVjQU1jJgR1u
	bxduHs6pUTBszssqRbBloLTChujDQrbBCl3Me1lJtHAdVghTlsdkits9qpeGWUoS0fr9yfEXjpn
	J7p66YtqWp68kx687srKA9upS86UtITo+p/4HvbP6L/4pBv74DjJUJS42CZYJz/pAtzZrsHy7qn
	j5KbjVuPUl3v+dIjrG9nYLV91aVDIY+xjYK/A9Hrw7X56iThMy3WsY2+NbdEeeNhwt21Al1W5Jy
	hvxJGDM4jPFIkaPzxr14VvS3MW961apCiGS0/6Kt4UFMTnBRiDwkx3qFU8kaADrIIWlIWRDb0k1
	g20XzMDvgCWqo3z6o02a+vCs=
X-Google-Smtp-Source: AGHT+IHgkh6txZJYKIT6a0n+hPjamkqC97RixL76dBz+4WB/YAQjLEox9JR52FnYN9AedjdtB8EjWw==
X-Received: by 2002:a17:902:e842:b0:235:f1e4:3383 with SMTP id d9443c01a7336-237d96b63camr53538155ad.7.1750435133200;
        Fri, 20 Jun 2025 08:58:53 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d87391e5sm20716595ad.244.2025.06.20.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:58:52 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:58:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: xsk: update tx queue consumer immdiately
 after transmission
Message-ID: <aFWFO2SH0QUFArct@mini-arch>
References: <20250619093641.70700-1-kerneljasonxing@gmail.com>
 <aFVr60tw3QJopcOo@mini-arch>
 <CAL+tcoBLAMWXjBz9BYb84MmJxGztHFOLbqZL-YX0s7ykBjNT7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBLAMWXjBz9BYb84MmJxGztHFOLbqZL-YX0s7ykBjNT7g@mail.gmail.com>

On 06/20, Jason Xing wrote:
> On Fri, Jun 20, 2025 at 10:10 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 06/19, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > For afxdp, the return value of sendto() syscall doesn't reflect how many
> > > descs handled in the kernel. One of use cases is that when user-space
> > > application tries to know the number of transmitted skbs and then decides
> > > if it continues to send, say, is it stopped due to max tx budget?
> > >
> > > The following formular can be used after sending to learn how many
> > > skbs/descs the kernel takes care of:
> > >
> > >   tx_queue.consumers_before - tx_queue.consumers_after
> > >
> > > Prior to the current patch, the consumer of tx queue is not immdiately
> > > updated at the end of each sendto syscall, which leads the consumer
> > > value out-of-dated from the perspective of user space. So this patch
> > > requires store operation to pass the cached value to the shared value
> > > to handle the problem.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/xsk.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 7c47f665e9d1..3288ab2d67b4 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -856,6 +856,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >       }
> > >
> > >  out:
> > > +     __xskq_cons_release(xs->tx);
> > > +
> > >       if (sent_frame)
> > >               if (xsk_tx_writeable(xs))
> > >                       sk->sk_write_space(sk);
> >
> > So for the "good" case we are going to write the cons twice? From
> > xskq_cons_peek_desc and from here? Maybe make this __xskq_cons_release
> > conditional ('if (err)')?
> 
> One unlikely exception:
> xskq_cons_peek_desc()->xskq_cons_read_desc()->xskq_cons_is_valid_desc()->return
> false;
> ?
> 
> There are still two possible 'return false' in xskq_cons_peek_desc()
> while so far I didn't spot a single one happening.
> 
> Admittedly, your suggestion covers the majority of normal good ones. I
> can adjust it as you said.
> 
> >
> > I also wonder whether we should add a test for that? Should be easy to
> > verify by sending more than 32 packets. Is there a place in
> > tools/testing/selftests/bpf/xskxceiver.c to add that?
> 
> Well, sorry, if it's not required, please don't force me to do so :S
> The patch is only one simple update of the consumer that is shared
> between user-space and kernel.

My suspicion is that the same issue exists for the zc case. So would
be nice to test it and fix it as well :-p

