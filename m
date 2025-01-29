Return-Path: <bpf+bounces-50043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2AA22304
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDF53A54CE
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7681DFDA3;
	Wed, 29 Jan 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kYZqUmTd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A01DF987
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172060; cv=none; b=UsKsYIi2iVyGnHwHhx9Z1nENNfuy8voW4lykgy0Fgt+I2Cwx8d15p3PNOgWh4yYOkQF0NpNq0Mw8CqQRrcdCEWcgrtBICQG1Juyq093b6Jjp8nv1bDUYVguePBp2UIcip6VXBZw4jwAlaatlaWsb1gu9J6CgnP1nnQnzhitNUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172060; c=relaxed/simple;
	bh=zGljS/9FhfUb47+VGIh8ikTRIRMMgOhXhmPgPUZSEIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF4mucosrc6EMCkCWLvN7O2MaZo2hKhZUiLSVmkAvwv05yfOaJmsgRNSoZ3gvtAW7D3KQ3sPEjdJUNbcRKjfDfNxdPKvr4UpL8OY/qFUkW2z6+7UdILOB5aor58xZ33unxxn6+MpzW3wLCVeXIaCK51NNttmdvjJ2k79U5tmGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kYZqUmTd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso105784156d6.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738172058; x=1738776858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoQDpS1qfePfDFzhVnadb3EAh/sAqIsSZHWqGtMfdWk=;
        b=kYZqUmTdziQYxynReb2cOavmQh9Jbl2OPXXLWAvTm018EAB5qFGONw5033h0NrQ6Wj
         FXzIO/y3Oq4mCBQdTi7sGutH/TecQgxbOpfIMmom7EFgQtNYt8qNgpzNX/0vWXFVHDgt
         f95BWMSqFtTfLlUo/DxgNQuJc+bUBUo7flIb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738172058; x=1738776858;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoQDpS1qfePfDFzhVnadb3EAh/sAqIsSZHWqGtMfdWk=;
        b=Lq2Fg9PhJufMLdUgD/N4luM3H2iHAoo2jnvEWP/AmFP3A6QwJzSaV/3xxIAtw0WVni
         xBNJDGZA86Vdx88K0TUseObj0t6f0ee7qXoCC//3imwr1X0zrFLBS6OGwzpwazMg5jBT
         BqzAf4fwxzPYp4IyqBFa+18LPp33JsRpqqpU1NUA2SGV03KmQgtC0zaP+MHB292t1dKe
         SB0S5rl3qJAigQGv63sro1HZfMMEReOwjiyKPXBlI1kIA2iiIjaN7kiukEKhjjr5cDdW
         0v7+lpUYZe+lxXnH3Sqxv04Ox175E0x4LxYdMZ258w+1ljp0zLLZ0XvmI/C4mgHjSHcN
         QIbw==
X-Forwarded-Encrypted: i=1; AJvYcCXHH/Km3IubUbcDd9F849TAfcSFfI4w18DJwsApd83ZWiDg/KRq6Q2b6PjhjaDvKwgb0hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4yvHvq24EA7R9VAhv0VPnapLRLdeIOw+0FU/sWRQzRww6ZNj3
	4Gwn5rXQHcDL1MhF9xxbWoCL/o0rlsphHlDVC7eZy39DE6JCQ/7eWlw/vnaLaCo=
X-Gm-Gg: ASbGncv+R3glqdUlIHf6qV7qcS46CbtttxUoh4UxC2uO6CcVEQao/pgvBAV7WobVU81
	gguUi7Rr0GhgGj3dq1rhANNibTejpifgZWAFIRE9em1PcYVn6HjYMGb79TKjgFO2rVqFWMHxhat
	1SCAmS7p5FaCgAkHeJUCXK3We11NCkowPPJQr4TC+WrvYKX2E1p2qzq0uhG31yevMGWyKXKq0If
	8Q0myfj16VF9IAqmEBHcqQtaCGuYycEv3QWkvlhkBpL6NfDa02jq1SF6LzYuCdGQCs421NGmC1A
	B7ZONRzKDNhCDn0TxHn9YZenHda8m6L8y+MKlVKvkiKkq3Har1RALQ==
X-Google-Smtp-Source: AGHT+IF4BBG8e6/7GOvUoRvTwqooHavsdcNd1DktR9rvgjZFPh+v5/6zznBp3CHsRrcIltj/YWsCgg==
X-Received: by 2002:a05:6214:1307:b0:6d4:e0a:230e with SMTP id 6a1803df08f44-6e243bbba57mr62866726d6.16.1738172057768;
        Wed, 29 Jan 2025 09:34:17 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20525aabcsm56814206d6.58.2025.01.29.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:34:17 -0800 (PST)
Date: Wed, 29 Jan 2025 12:34:15 -0500
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: sridhar.samudrala@intel.com, Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next 0/2] netdevgenl: Add an xsk attribute to queues
Message-ID: <Z5pml3Hn3m3Km7Yk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20250129172431.65773-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129172431.65773-1-jdamato@fastly.com>

On Wed, Jan 29, 2025 at 05:24:23PM +0000, Joe Damato wrote:
> Greetings:
> 
> This is an attempt to followup on something Jakub asked me about [1],
> adding an xsk attribute to queues and more clearly documenting which
> queues are linked to NAPIs...
> 
> But:
> 
> 1. I couldn't pick a good "thing" to expose as "xsk", so I chose 0 or 1.
>    Happy to take suggestions on what might be better to expose for the
>    xsk queue attribute.
> 
> 2. I create a silly C helper program to create an XDP socket in order to
>    add a new test to queues.py. I'm not particularly good at python
>    programming, so there's probably a better way to do this. Notably,
>    python does not seem to have a socket.AF_XDP, so I needed the C
>    helper to make a socket and bind it to a queue to perform the test.
> 
> Tested this on my mlx5 machine and the test seems to pass.

I should have been slightly more specific, I ran queues.py two ways:

1. By setting NETIF= to my mlx5 NIC
2. By just running queues.py (without NETIF) set (which I presume
   uses netdevsim)

The test passes in both cases.

