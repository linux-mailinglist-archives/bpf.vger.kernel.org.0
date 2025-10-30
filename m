Return-Path: <bpf+bounces-72996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B605C1FCAC
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8587189B22A
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A3355027;
	Thu, 30 Oct 2025 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb3kSYB+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C01D5ABA
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823086; cv=none; b=oCV7hkDY0k6aXCH3c7ZN7vXBnU0CyH1l92CryYfDLZeyNcpCBnxaLz4JW87D5957OzGT0MJkCsnGsuoAg3OMUGP5ZC0VyLQtmt+TP+6L84+JOHgVLEqCpH749pjxdAbEobZFyw6rCST2/6tpaClMZNxMZCP9xbooET3Sjegk9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823086; c=relaxed/simple;
	bh=zDrcC5GJxSK7Ji8wHBSk5s/mSLGf7VLCyLmVbQ62M6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTa1GYDbVm6BsS/UQr+Lujat3iI/174VhZ6VpLWRHw2ml88mWexT3jAPqShZzC5a2eEU7cHOsAaildE0JFkbxwMRc/DuzpF3F32VIAdJbxBjE6e1rmfSzyk1T8SBzmHboHZj3dLj5i94v+5kP25+rbOBLu144GCqwlprV+ty0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb3kSYB+; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-940dbb1e343so84475539f.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761823084; x=1762427884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnjkRvMkBIKfE5g1/0FeD48NJujoOxw0nQk05fABqm8=;
        b=Kb3kSYB+ldi+GbhDJUDhRYgsGgiDr9uf4s+cYNVfog4hG4P7s+Wp3WKRg7NQcHsvMQ
         sbmAnYA6Vlx82/GlGFjczzh1XqElrp4Xs/4IsfWpFRwVf9C4kUex9pmJwzc/JM9Djdc6
         wGQw1FjUesJKLVVX6rZhl9DaF7OiTjcqVBMmFTyKHyrI+j36aKkYu0QNYCcsrdep6w6W
         X0kxKrNoJSmQiw1YCcTL0GelFlo3bhNneku4sPC/DWMYdTCevvsxC1pDmS9TpcBbMGsR
         JbEGHR/it6YSp/XmA+FetRxIZVYvYudKrCGVHAy4B1dsfCjU7qkk3U238DO+HMplAHvw
         yAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823084; x=1762427884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnjkRvMkBIKfE5g1/0FeD48NJujoOxw0nQk05fABqm8=;
        b=uhAFDRjSHInksmjKcbw1/32c460Tv1KTGUZDbvS6l1BkKDmFW5fgFXvf29uUUvevt4
         augVPF2KLChJKAVDOZwDMAXXjTrsNYhv4IbPZXkjXwfKg9dQrRc5Ibvs7zljwClA3cJT
         Hr7IzFZ7O/gfC5Q0m4qHre3iWzrN1MvcbAfLNp8fXCOKRymMbFkVMUHM/ammh17rcuiP
         zN72u2osLtcj/Omvt+qcxzYg0xiQei+SxFrbCYJ4dtPZj3VeBtv6gSqRsiTdf5I6+Yrx
         47kMSua6JS/2EWC7tbH3BFbwVc9J380ar65a8jdx1j31XKKjjCFj+CMcUBzI0Egb4IYd
         v8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwQp3eP55th7WdDM2HoY/LQV75zcdEEtSTIi1Xlylc5/5dIr2vpsKo0fCINdYBhjxBbf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmesytpla8bsojUVH/LpLG7YZ5UC4FpIShcFNZl7DDWzQ3+tIL
	lI4G/nxa/KxESoYoNw7DcmnBs5nrRKH/EADT77y8zLQqCUNVHB7HqAKvfsck+2AUQ2bXI1dbbrE
	Rm6MF1b/gT8AAips25+WyuVqjkiEebIA=
X-Gm-Gg: ASbGncuHWZ/fJyCIYpfzwEa7zdA/OrRJSYxvRg0Lz2gowxpxf3OPC6MmXDnc+STP9lW
	nq5sBZ6paVc1lHNewLmtHy2oOLAS2XWEfG3U5wJj6ZVj9+p2A//Oh/6iETFBkfd+g/yI+4fY5nq
	qqbfsVE4sQMB5b//FrkGixIXCcfO7asPL/yDMQoVJr4yR56/5Tjb4rQ458bRgwmGQ4XfIcgUd3g
	PDs20RZizwEvc+X8P3SwwTohb9/4yf5wqet7ckMCQImQMLnhjUPVZ7mfIQMG2P40faEkTA=
X-Google-Smtp-Source: AGHT+IFjYZSNf5b3bFjLFO/ww09HkUIGFNXY28HL+DLlplYADC6BMo7pzFokHHmEQe3ahOaOb/z+WYSc4dOL8YKuAlY=
X-Received: by 2002:a05:6e02:228a:b0:431:d685:a32a with SMTP id
 e9e14a558f8ab-433011f4f3cmr39332745ab.6.1761823084219; Thu, 30 Oct 2025
 04:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
 <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com> <e290a675-fc1e-4edf-833c-aa82af073d30@intel.com>
In-Reply-To: <e290a675-fc1e-4edf-833c-aa82af073d30@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 Oct 2025 19:17:27 +0800
X-Gm-Features: AWmQ_bmnROwfpAdiuZGw8HjV-5Z0NcRHwx0YijpygGa_flsHGmonev7UefW_R34
Message-ID: <CAL+tcoCu=7MFm9kioQnQmAQYkqbC_PNr-j3UyVEqyxhe7T2Fig@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:00=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Thu, 30 Oct 2025 11:15:18 +0100
>
> > On 10/26/25 3:58 PM, Jason Xing wrote:
> >> From: Jason Xing <kernelxing@tencent.com>
> >>
> >> Since Eric proposed an idea about adding indirect call for UDP and
> >
> > Minor nit:                          ^^^^^^
> >
> > either 'remove an indirect call' or 'adding indirect call wrappers'
> >
> >> managed to see a huge improvement[1], the same situation can also be
> >> applied in xsk scenario.
> >>
> >> This patch adds an indirect call for xsk and helps current copy mode
> >> improve the performance by around 1% stably which was observed with
> >> IXGBE at 10Gb/sec loaded.
> >
> > If I follow the conversation correctly, Jakub's concern is mostly about
> > this change affecting only the copy mode.
> >
> > Out of sheer ignorance on my side is not clear how frequent that
> > scenario is. AFAICS, applications could always do zero-copy with proper
> > setup, am I correct?!?
>
> It is correct only when the target driver implements zero-copy
> driver-side XSk. While it's true for modern Ethernet drivers for real
> NICs, "virtual" drivers like virtio-net, veth etc. usually don't have it.
> It's not as common usecase as using XSk on real NICs, but still valid
> and widely used.
> For example, virtio-net has a shortcut where it can send XSk skbs
> without copying everything from the userspace (the no-linear-head mode),
> so there generic XSk mode is way faster there than usually.
>
> Also worth noting that there were attempts to introduce driver-side XSk
> zerocopy for virtio-net (and probably veth, I don't remember) on LKML,
> but haven't been upstreamed yet.

Thanks for the added context. One minor thing I need to say is that
virtio_net has zc mode but it requires the host to support a series of
features which means at a hyperscaler it's really hard to ask hosts to
upgrade their kernels and on the contrary it's effortless to upgrade
VMs. Indeed, veth doesn't have zc mode.

Thanks,
Jason

