Return-Path: <bpf+bounces-57709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E63AAED35
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2848A9E14CF
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4128F953;
	Wed,  7 May 2025 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm58GYXC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECC28C5B5;
	Wed,  7 May 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650616; cv=none; b=tNQU+eUDY1gg+GLwHi5dL4egT5qfPQRra3k5gYj7D+gjQfb31sfiM/42pmrdBy0IZ2+s8InIPeugkG80jKH2rLf6OEcTgUXIjgs+lkl/y6VelCk1w+QQH3zt5vXimwSaItZ3tE3YIKq5xsIgnPAVj4IZEmPOcUEhJ7KdWQqQZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650616; c=relaxed/simple;
	bh=6rPxVYpokiEhO+TzLzqBvA7lWBd6HHd4fis1YLJuMvo=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XoMz0gA2pdXu6+uIZSVMGaR0SqsvFlvzOs0D8s+3XLkkKafEEUDyg6LmEn4z8rOuSbJcVWsSlcV2JxFirCSvKV+hK9vVHyjBL+3UIxycZjnVvz8wEeplhOft3BUzEGFYcNWoYwAzoj/feubcthsXGghHZckto7V8hf2K92bJAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm58GYXC; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c54f67db99so155253385a.1;
        Wed, 07 May 2025 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746650614; x=1747255414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTuvkoeLz9OFKlj9Dviyt8wquS2tMT58gS6cPYVlW1g=;
        b=mm58GYXCIAYWc89utE9BbYTDT8OYCkMJ67ebF3OMmovvbq9Nj++7MEzWPllYzajLSm
         7PGN3z8ehGmA/tZa5B/sj3IrkrI+axOF+3R3HWK2wY4E+9pC9QIZOIugtR9gv4a/x+rT
         V9PyPMklLzL6LH68HMZIrE+D+8hZXQZ9B8l4yhJ4vgwJSNSrGBBcKeKuznkqIyOflyNP
         sDwDdkNrUCdfj4KEwu3dMhW8UALIij0LGqgH+6YXq1fzuEb2SoQJb3ZIfr+zpvRsQifj
         yl5KnL+i9U8UlAhvah4xzkpn9rN3A1HOUmgbM6lAozaToUTyhb9lvQFRnS8TzvFpvbIc
         wO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650614; x=1747255414;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTuvkoeLz9OFKlj9Dviyt8wquS2tMT58gS6cPYVlW1g=;
        b=KHiUPWl6cemiiosheytubBmwrBLvoJGp9VL2d0+52J/ALbFTAwwY15sNVoG7ICNNFG
         xnDV9dxuyfygxXASTg1r0uaH0zS3GW2sZT1KMfCqFa1gyaGBUKPOIT26afWe5mLM56q4
         /vK5hzo5SK8vlciqPFy+zch8LtIfh6K7xZhvKep2i58L31JWJ1+6QVos3SLtsMHrPAeB
         +mNti9xL1d/h+udC2e1R82+y8or9NrmtblmBS8pyBHKHk/3Bz6Nhkl9iQe2AX1KKvfWk
         FRY9rQ/oExdAMHl0Y8rt6/8QGaA+CpD7zOkZ1upDgqpbFapvop8xHWXY5Ujpp6I/C3A+
         ymSg==
X-Forwarded-Encrypted: i=1; AJvYcCUsSzJMqc/fz9JP3RLld4XLQBIPlbPhnEO5h3pJZhAKRa6Zd1dQxQRrWWgzU4MRiIPLbBs=@vger.kernel.org, AJvYcCVAulJSsHQHg0yvMCx5vzw1Rmq/0aNAZNYvqzzIMsAELRirtn9pFtFB00nei4P4gEtRRq8D8eP4SmJTMs3P@vger.kernel.org, AJvYcCWT0v/La2/ZB7cEeiFmWwQtuFfy5WyvaBfohFwYKutiInGFJUdA3JRqFXDYUu3wpOrJ1tmahCy3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6r8tGrvckEQzkafY2oIBNCJQeppgE6pdOoHTlBM2igHgFT5mO
	G6jLwoeLgsprx8e8IzQZq0u3VAKS2x6D0ZZ68V70a1SJmhggp8e5
X-Gm-Gg: ASbGncssQQRND9tkpmPDfpNHcuJ6D5u616EJsdLwqB9Xv1lYVW0nf+/AbcyiZY46Rwh
	LRyYdZklKNK1nDvHKwMJ4iW0gJv49Rygea4FQ8o8vU7mUKDsjYgI5KgrNrAkArPoU5DRdTf+Qsh
	dJ65l9W2CcodtJ6F9edSOb58Z8gsC2uf1c9kX1eBWwcQUJwdc4e0YyXEo2FTc1MkCf7j18LvSa/
	QY3+1F56DJzC2z1PAnkVXRShuxto9YaHJyvI1Kq9o/bg36a4o4YjHF22A5pZKyQS5eK8wd/PZdK
	XZEDqfzgVE6wv74fqHUA3/HbR2dCGj/mNFMMdGzVlse+IzJIMJCJ/opdoPLvoobyRFz9/4pu4r/
	NKOHWC1TlGZqbpKj26d9X
X-Google-Smtp-Source: AGHT+IG0djn3yeJAK6hcpM8Kyq0xTsIur4G494vPRBrWDsVOBbqGXJBbHsOuIVLjON6Wq6XAQmt62g==
X-Received: by 2002:a05:620a:f01:b0:7c7:b8bf:35cf with SMTP id af79cd13be357-7ccf9961e16mr146671085a.7.1746650613685;
        Wed, 07 May 2025 13:43:33 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf75d97d9sm210196485a.101.2025.05.07.13.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:33 -0700 (PDT)
Date: Wed, 07 May 2025 16:43:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 jon@nutanix.com, 
 aleksander.lobakin@intel.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org (open list)
Message-ID: <681bc5f4b261e_20dc6429482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250506145530.2877229-2-jon@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <20250506145530.2877229-2-jon@nutanix.com>
Subject: Re: [PATCH net-next 1/4] tun: rcu_deference xdp_prog only once per
 batch
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Hoist rcu_dereference(tun->xdp_prog) out of tun_xdp_one, so that
> rcu_deference is called once during batch processing.

I'm skeptical that this does anything.

The compiler can inline tun_xdp_one and indeed seems to do so. And
then it can cache the read in a register if that is the best use of
a register.

> 
> No functional change intended.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>

