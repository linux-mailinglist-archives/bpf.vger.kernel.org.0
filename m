Return-Path: <bpf+bounces-68060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157B2B523A3
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 23:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0987BB3E3
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96F313535;
	Wed, 10 Sep 2025 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="kiFd3BT9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B63126CF
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540483; cv=none; b=ALBVfXjpmjKI+Q8D+sVC4L+Zj8ikOGTa4IqdTh0NlxaiHTAvgWG/w3URWnCNf7wR6i2dQSV0fPNpT578lvuuDeFfUAwZLoTkrqiOrX4GKVPN2kNqH7ObRdMXdQ8s5gwUsRxWsHnat/Wia8EwJw1ZkQx2j0Rol1+DPFf9Y2KN0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540483; c=relaxed/simple;
	bh=rBTNYVsF3YFvmX+4VP6dC8AXXIIfKsebSpVauz6I77Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuOI30hUz0p698jU6fKgipOE/1HRTNemVptRWtVR/j67FmtCVfxTE90HHONbIbv6hyAjEzTw81+gM4AunsHIMJqv0mA3uByHdBYKOv//LQyrvEA65jG1z7ouHLbO1L5PlzxIvd1qu9885hOjywSJNRMq9NfgmHNJdlMDjv/ipZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=kiFd3BT9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b132bd90dso65065ad.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757540479; x=1758145279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzId/RkTQL8EC0WDO7Pec0MLfxYUok0E0Fzx4XPk7rs=;
        b=kiFd3BT9cs2JZzyLlLLN0uZEoNJ088qMuSkl56MQAQMoZxK8cZ4iWKjNAXbOklQjBJ
         KXGIxng6lA1YaxgW4yEYqWmcVjSy42APmLyW1A0P/W+r+WvnwdUJLmgL+EiTUbZP62Xj
         MCvVjIptboEvqmARIHcuH5cI8Fb8v1J89nT/yf3V1U/jmajVb1xAhlkiTwUfUBBtW6DW
         sL7edHOuLrHQWdNdUhw2/+yzOmm0Zmq0qNcxUcbH27fzyHpKsISTPbkr/a8ftjLfLGoo
         KYoDq9yM5yyY8ZX/oI4yCruN7/wP3uQym1LU1sAJYwJkWZA6AhYgopej0hs1oGXSQjJQ
         ylRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540479; x=1758145279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzId/RkTQL8EC0WDO7Pec0MLfxYUok0E0Fzx4XPk7rs=;
        b=s2Bu6wLmwmHdNlz+6pLAYJH4Ngjb4gcjeZ+P9x0s2Abg6cip2Ds1pZerDunqJxQfXL
         C0Zx29Cs+rRqjO2+P0BsRuMSpMxqiAaWSBNj8YvEuge/J0mXDiF0uwPuN6/b7c2kPts8
         UM8Z3NI9YgUWqeAPFCfB+JxCqdoO12e78cOdG8NeMXUDN/zY+HcLEu52tB0VTUyMZ23J
         zGFendjA5Nmz5BKKlW+gs0oHxnk61oRqsOylqZCMqA78UXWTYxtaKNc2j6+o/+d9LAyE
         Bt9ptZ6Emu+ovp2PeRQUAwmpZVgrE8So4t06uqAVTglfZT0sHQ3ZNQoIAOe+mQ7tHS/N
         RVwQ==
X-Gm-Message-State: AOJu0YziqTh3IIos77M0GzFaXk0syem7/EN2VMOFgb7bCEEBiOK35w7K
	TyKLVf1DRSPwPcuBSyT0NCPa7dNQdVMaGZGq11hDEgDOde1A42W5ufaUSyKy7jrp2h4=
X-Gm-Gg: ASbGncsdiKjkwIpY5VZz5bp4sfifPha6Ix3lJQhK0Z3kl38e7Yv5SVCZHtvo9pWxy4J
	X8C2Cv3tGC6sPp961e0Pal9mqvjCy3vFoQKT+ZTBZL1cR0RqEutOlIV/ubUDNyQjYaM3vXzK+Zj
	0D9TNFYN0RvRvVvdMho6RA016iPIeHQfnP9XkpGpzxXoFnuJ7nYCcujA3S4LMIX7FoOG7NN91xB
	wyKC68NFTVBAqwlNhXhnmJQ0+4RXMqJ4m7OWrmhnKEpoy9cxC28EbQhIy9xlJAAa9P4MfeCukMP
	7z25JN+ipotW/BQNkJ8ChFhOoUxR4X9KkCWzApfVkxJ53ugXzd+m/HMOrjXu3LALzPgFtHJ99ip
	fWdd9Eh/A
X-Google-Smtp-Source: AGHT+IFc3gLRJ6cR/FpRGzTCp6rzCTj3/EJpFuXvGDWz9QQY3e21hQurVVFTNe86D+WDyYrwdADdpw==
X-Received: by 2002:a17:902:ecc9:b0:248:f683:e981 with SMTP id d9443c01a7336-25174c234ddmr117757125ad.8.1757540479412;
        Wed, 10 Sep 2025 14:41:19 -0700 (PDT)
Received: from t14 ([2001:5a8:4519:2200:5e8f:88f7:48b0:e920])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a924eeasm37135765ad.108.2025.09.10.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:41:19 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:41:16 -0700
From: Jordan Rife <jordan@jrife.io>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Aditi Ghag <aditi.ghag@isovalent.com>
Subject: Re: [RFC PATCH bpf-next 11/14] bpf: Introduce
 BPF_SOCK_OPS_UDP_CONNECTED_CB
Message-ID: <aqvluk774lxbko2znaeozteef246mcvwd4qhvcqsqahr5zdmyw@kmbefshxxm53>
References: <20250909170011.239356-1-jordan@jrife.io>
 <20250909170011.239356-12-jordan@jrife.io>
 <CAAVpQUA8VyP=eHtQ3p4XJYwsU5Qq7L-k1FRGhPN+K9K+OeBZ+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpQUA8VyP=eHtQ3p4XJYwsU5Qq7L-k1FRGhPN+K9K+OeBZ+w@mail.gmail.com>

> >         res = __ip4_datagram_connect(sk, uaddr, addr_len);
> >         if (!res)
> >                 udp4_hash4(sk);
> > +       udp_call_bpf(sk, BPF_SOCK_OPS_UDP_CONNECTED_CB);
> 
> Why is this called on failure ?
> 
> Same for IPv6.

My mistake, it should only be called on success.

	if (!res) {
		udp4_hash4(sk);
		udp_call_bpf(sk, BPF_SOCK_OPS_UDP_CONNECTED_CB);
	}

I'll fix this in a later revision.

Jordan


