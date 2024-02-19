Return-Path: <bpf+bounces-22266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64B85ABB6
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 20:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E62AB2319A
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A948791;
	Mon, 19 Feb 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQJGs8n3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263F446A1
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369325; cv=none; b=NBOpo/XaKUCA7//6qae2LwwgZH3aFm6Zy6Hj477SApd1WA/lNsUGDx8nkTbCYNFM6i6klz3PExNcd2y/kSmUMspiCsOQQTyhYAc2OB8FMEg5Qryixmlry1/CDuARFnMr2SlSbqjeReBCqmlzWZ1El7KuPAcAu/IcAb92h4u7afM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369325; c=relaxed/simple;
	bh=rKlBpXyDtOEf30UmcMRMBWdxniIn3ZG5ZkeubOiAhNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GuSpw/CmoC4HvSfpd9st5jpqzE1RmZnY//4Z7HXEdX5MuXCjJnqFccL40c6NI6UfhRDJYeBd20qDvRk+5P3NTgZy9B3Z1F9qTyRRy15OVCLANPZ0NcNXeqG/y6ULj2FtfRHptesz6iqGzzMXKMjCF7fbB8zGhIz5WxH/P3mozwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQJGs8n3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708369323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gn3YA4vqhMivZbps/7I6FcOGwvcl770EUBqrLg51dFQ=;
	b=WQJGs8n3pmXtXQvXrTGoPXje2nFNnfRuLSuynOTc2c0JIA7vrZkg0YA3PhzkuIk/yRCg6S
	0lTo3yYlifGf87yT4p7RjUJ0h4tcoFVoPXeOrR/LoMpCZqvW5NNOhabVBDsP1yHDTL4VKQ
	DLtJqpIX+6JkAniIuCPzLyk2YjyIlfU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-TMVxt0RvOUuv_DA6P5btDg-1; Mon, 19 Feb 2024 14:02:01 -0500
X-MC-Unique: TMVxt0RvOUuv_DA6P5btDg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-512a00a2629so2222304e87.1
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 11:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708369320; x=1708974120;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn3YA4vqhMivZbps/7I6FcOGwvcl770EUBqrLg51dFQ=;
        b=v3EAmKDH3p9pEdYISOb/vnNlV7j/p0WDwWM/DO0L8I1S69Oiqu5U8PalI7eoeNsX7d
         3As7DIvgZrwABsw48EjZ3lh2swe8KBoryHewzBzJA72veXGaGYg0Oy28ZVYz/9vt5GUN
         GiPX8zt8z+JbRGObGUhKiabR/YSLwZtp/rOKMGjX06pTGanW0O5Cijg7raOd6L7rM7/0
         3RE2o6EP7w/2P4OMkrBdvRZbteGREe320uqRxW7ArYiTkoRy0gurkB0vkV+tcyxoc+9R
         CH7/5eLC7Fu+Ak8hMU2mkAQcnfENWD2j0Y76EA8rNXEX8vDlMh6FQwCs8GA4Yv4tVlHr
         gKwA==
X-Forwarded-Encrypted: i=1; AJvYcCXURrYOMoeXNRLSf8UvxRLFXBsa0OONPpiVmOJKiFCTFRJ4IdAFTm0ji6xfnLMPRCncyT1eO54UxyXcLbwsB5xaB89f
X-Gm-Message-State: AOJu0Yx2pdB97eC8NKSqInZq1ma5sez+chO1cdMy/afrPq7fckWbdVDc
	DY/xhNHzOjFhd9flAg8C/7/bibUMICHOe/MBrtOibuY0A8PSIfTu90PWCb1ltPq4NBiLxK8aysk
	76vaCW2YWKlDTWmV0SVRJnS/7JXBcf4SKEM9iij4ExVCbp3TR2Q==
X-Received: by 2002:a05:6512:124f:b0:512:8d8f:db7a with SMTP id fb15-20020a056512124f00b005128d8fdb7amr9680569lfb.65.1708369319895;
        Mon, 19 Feb 2024 11:01:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPHeFM9ofMDSdx2TIqxuySA98SIhicEgnhduQJpx/NVrDhgAHyYM18EPPJ9duIEmTJZclSBA==
X-Received: by 2002:a05:6512:124f:b0:512:8d8f:db7a with SMTP id fb15-20020a056512124f00b005128d8fdb7amr9680553lfb.65.1708369319506;
        Mon, 19 Feb 2024 11:01:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jw9-20020a170906e94900b00a3e289d6800sm2726361ejb.89.2024.02.19.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:01:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A886010F6173; Mon, 19 Feb 2024 20:01:58 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240216165737.oIFG5g-U@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de> <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de> <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de> <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 19 Feb 2024 20:01:58 +0100
Message-ID: <87ttm4b7mh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-02-15 21:23:23 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The tricky part is that the traffic actually has to stress the CPU,
>> which means that the offered load has to be higher than what the CPU can
>> handle. Which generally means running on high-speed NICs with small
>> packets: a modern server CPU has no problem keeping up with a 10G link
>> even at 64-byte packet size, so a 100G NIC is needed, or the test needs
>> to be run on a low-powered machine.
>
> I have 10G box. I can tell cpufreq to go down to 1.1Ghz and I could
> reduce the queues to one and hope that it is slow enough.

Yeah, that may work. As long as the baseline performance is below the
~14Mpps that's 10G line rate for small packets.

>> As a traffic generator, the xdp-trafficgen utility also in xdp-tools can
>> be used, or the in-kernel pktgen, or something like T-rex or Moongen.
>> Generally serving UDP traffic with 64-byte packets on a single port
>> is enough to make sure the traffic is serviced by a single CPU, although
>> some configuration may be needed to steer IRQs as well.
>
> I played with xdp-trafficgen:
> | # xdp-trafficgen udp eno2  -v
> | Current rlimit is infinity or 0. Not raising
> | Kernel supports 5-arg xdp_cpumap_kthread tracepoint
> | Error in ethtool ioctl: Operation not supported
> | Got -95 queues for ifname lo
> | Kernel supports 5-arg xdp_cpumap_kthread tracepoint
> | Got 94 queues for ifname eno2
> | Transmitting on eno2 (ifindex 3)
> | lo->eno2                        0 err/s                 0 xmit/s
> | lo->eno2                        0 err/s                 0 xmit/s
> | lo->eno2                        0 err/s                 0 xmit/s
>
> I even tried set the MAC address with -M/ -m but nothing happens. I see
> and on drop side something happening when I issue a ping command.
> Does something ring a bell? Otherwise I try the pktgen. This is a Debian
> kernel (just to ensure I didn't break something or forgot a config
> switch).

Hmm, how old a kernel? And on what hardware? xdp-trafficgen requires a
relatively new kernel, and the driver needs to support XDP_REDIRECT. It
may be simpler to use pktgen, and at 10G rates that shouldn't become a
bottleneck either. The pktgen_sample03_burst_single_flow.sh script in
samples/pktgen in the kernel source tree is fine for this usage.

-Toke


