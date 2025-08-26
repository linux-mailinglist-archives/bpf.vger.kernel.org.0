Return-Path: <bpf+bounces-66483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78547B35016
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8963B1B261C1
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E53139D0A;
	Tue, 26 Aug 2025 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpfy1AyD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9ADF49;
	Tue, 26 Aug 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167230; cv=none; b=q8CCbDKo+tR+VJOYW79MaRfg2uSI2UlOTKfPb4adhQFMlWGOhpIehQuQcaqj/QB8vE13bVvpMTsl/9YPa08J/7RCp1NyZsCXWS6ueAI50QTYZsrk7BrnXI09lfexNWbBpiraAKi9sqQgWst3ZmNe6hmx1Ce3c0OAmz6NY1MYAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167230; c=relaxed/simple;
	bh=TI3E1caWndf12wBEakxIoMw329/lzJIf9otvle6Nu2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSUpdBsgzFBwm6TbyawLgr6b/dnJ1CaDL1GjL6tnhQ49xQkpMgumPQ4dln14U/RGfuQ3VUs59pCKFx6vCu3qgRs0YkfzFfkM/zPWh5GhHHEku6mIVTejsu1VaBuB0bXjhanc0Vj/dZCUim/Y9zlzDyKIQidFNnaP5pyoV4NRXq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpfy1AyD; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ea8b3a64a7so14040375ab.0;
        Mon, 25 Aug 2025 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756167228; x=1756772028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI3E1caWndf12wBEakxIoMw329/lzJIf9otvle6Nu2U=;
        b=jpfy1AyDRPGSxWKSvcYMZpdcuxwww5c+exInOIuvBjCDWY/Z/maXByF6bDDIjHK7/6
         U45XY0oBB+PdE+SPgCz1VQElWWCr5TysfPnWFSghvw/ebx9EgVzuoRir7E5mJF9YLJKO
         AewmdLuba7aeDXJ/bIAYV3OCBxe+3Ex/hj9ssUQCUGbNw5gqzLJP82XHSIZB9M06vqRb
         Cul6MkKdw0Y3UUTWPkoelodYAFQLO+5gvLkHCo4HbD0BQACEvXH7kW+WAlGWg3b8HV7y
         5kC2HT6s+1HF3XuIIjJd4rf1RNnYA4O4azcW4hLXxSGgMTaqc+e6xSsN1kLu10t6j1w1
         7vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756167228; x=1756772028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI3E1caWndf12wBEakxIoMw329/lzJIf9otvle6Nu2U=;
        b=BcuWjqUlUN2GsKQTkSkTi2BJVSqa6YMeZzg9hQfxpNd6e+UbEeqClI7MjFaFmWGpAK
         CqTyraDhJl1+KPBSxx5+KWyhpS1ksKmQm1JkpWz2Y1zEQk5luxwQ9FBtOpyW1MCZLSba
         CQ152WZPLsGA9VHpQKCYo04VlUwyTDbZsJGfSiPWxVKCh24etGuaokRPKZ2eth58lCfF
         M7XMra2S1OcZJvg73uLNBusXpGAvPX8ZMfthkNLTDQcOSEcLZ5NxunSiILH+1pyh9Jrm
         q19Rdoh2XjqW+fFOsOJBJ+k3Xvsk4EM8iiZ3mp8TrnNzX7JSiL2xD+uQ/jI3PnnfLBm0
         Nbeg==
X-Forwarded-Encrypted: i=1; AJvYcCWHDCVehWijoRyBJSN4U1LKjEIN6YFF7sbZp5b0IZSCWqpQRWdzouT+SuU6nOMy8dAq2w28VnC9@vger.kernel.org, AJvYcCXbcMTFyBvFNaifLwSa3jbUub7nt8mwMkc5cCwS5/0B0VTaRdFSVvQ45QbtrFk0NF3O2PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5z2KtkCWWHmPBQEyPK4vEdzUeUeh4AUYsKft0nMo+N1ksSWp6
	5mUDUhCXFz1MxsLEBBEUqeCNb+5FCYyCsTHjGx/2usm7xq2pubrNiCde21wj8tgfL2vi+I9S1mq
	KBeo4XIsyKxngykXbCIIW7jqz7A5j1usf7h8kt3I=
X-Gm-Gg: ASbGnctCCeO1lpefG6TiMGr1+j8C2K6712UTYa7mSsY50JwTIBjZ8DR0kq5QXkiAKhb
	ACT5OlAqxChiZRODfYAehTxMqUayCZda3MmzF27rNLHeuVpuex1Ojq4NcE/Gb1kFn3utiBZBymf
	EJf97nS/WpsXYaGx5uzYSo7GIg+ePehVf5MNY1RwiBb6+5tdvgR1uNYbOxLfnr8dJcWA1uaN4bH
	frppXrw5nSfU60Qjg==
X-Google-Smtp-Source: AGHT+IFo2CuYMKtENYuCFNtE/t/CHZ6hXuF2s2u+bH8Fbmxdincn8CVkuul/O8l0xnE3hFR8Hoo2weDO1NQb2Xx0Az0=
X-Received: by 2002:a05:6e02:1947:b0:3ec:461f:fccb with SMTP id
 e9e14a558f8ab-3ec461fff1dmr70928345ab.8.1756167228115; Mon, 25 Aug 2025
 17:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-4-kerneljasonxing@gmail.com> <aKzY4Ke0EdohiQXj@boxer>
In-Reply-To: <aKzY4Ke0EdohiQXj@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 08:13:12 +0800
X-Gm-Features: Ac12FXx0xnevsbWn825K52Qtxyg2vBRrS_FvqYNhGgXKIJ9V-wzhPeWYSc5uHR8
Message-ID: <CAL+tcoARrUz3Ao_ieELvLFisMy7F0hvDDjPB8hxdKSsQtpS4oQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/9] xsk: introduce locked version of xskq_prod_write_addr_batch
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:43=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 09:53:36PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add xskq_prod_write_addr_batch_locked() helper for batch xmit.
> >
> > xskq_prod_write_addr_batch() is used in the napi poll env which is
> > already in the softirq so it doesn't need any lock protection. Later
> > this function will be used in the generic xmit path that is non irq,
> > so the locked version as this patch adds is needed.
> >
> > Also add nb_pkts in xskq_prod_write_addr_batch() to count how many
> > skbs instead of descs will be used in the batch xmit at one time, so
> > that main batch xmit function can decide how many skbs will be
> > allocated. Note that xskq_prod_write_addr_batch() was designed to
> > help zerocopy mode because it only cares about descriptors/data itself.
>
> I am not sure if this patch is valid after patch I cited in response to
> your cover letter. in copy mode, skb destructor is responsible now for
> producing cq entries.

Please give me more time to think about it. Seems that I have to change a l=
ot.

Thanks,
Jason

