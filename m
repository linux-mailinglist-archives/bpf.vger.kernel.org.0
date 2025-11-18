Return-Path: <bpf+bounces-74916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B0AC67BFD
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 07:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8A9D629401
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2A2EAD1B;
	Tue, 18 Nov 2025 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc/ODZev"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF42EA15C
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447847; cv=none; b=XMg8DE3ahpyQIAb15RtDLmugaPE29Tngw0taUVdVmc+2qrC1oNxjB6jElo+nZqfrmMZA05skojs+ygQPFgQgk38fZB4QJsSrCuWG8fyqBS0iicU8PwelJV3RgcaQRioaTA4vz4z72W+r8AiodbqONAp/OL5yov/NFT4QhoGs+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447847; c=relaxed/simple;
	bh=RY1GxG6MBqh6NCveOLSrf90a2ONzNoxjMM6LXqGyRiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuWT8jjEOr3b2pryemrBHu9M99M879wJk7tVUza1yZ8j7/jHkZsey/kGGdUvwt2CGxqbSWM1MZueWRZedjnmsVgCRcAWDCb4gKfiRmFaPsbdwv7tTbsKEJbSlJ0moLUdz0mKrrLeD3MgyCfch8zgU4UAmkszv4KToRU5thHcod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc/ODZev; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so2067653b3a.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 22:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763447845; x=1764052645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKXeu+SiVQVquAoWhSPWf0RcZCWL+HzPZuMMI7btDH4=;
        b=Mc/ODZeveQVtJhS+j7s+6Dkxi3/KBiwE1B3HKZii02X+XfUCpUZqcwzspsnzgbv8x/
         st1F21oraNhSAnB+XmH3F07a/c/5McEGpce5+dIQ5EcajwiS5KJ3fMT0riZg0I7rLZAi
         tiMNurTSGAqeVdsqzCtPk4EBB8CtB5hzp6BJdoWrNyXLnX9Jxmqs+OKVPrGWzF2PHcQT
         3G9LYlnC8AL1kYvryAR4tkY0xarlGsCGrO6z+zOQJdI/1cO3myXytD93xB57xUnCyNsA
         0ZZz+f62NK7Mf+3G2Ds6APEAn8u05qH5+mPmpWe1aRyJ/5OriCMoYQpdS54iPVU4csyy
         AI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763447845; x=1764052645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKXeu+SiVQVquAoWhSPWf0RcZCWL+HzPZuMMI7btDH4=;
        b=Jhn9d4zKrRFrWY4QFbhq4kxip6ww04z4afbD7N8Gaz8sZfMJg7cDUg9Ox9YBApuCbg
         8g1IzsoY83LaRb5JguFw+XiS4BuscMeU7LsHhBm8sMJ9G7rgWocQ5w2XUJItbF5T8EpH
         hRZJAPPtJKYNinjqiW59jRPxZZbnz4aRSPSJOm1Bb+MU+geKWfUR67Egx8V99vtX8AFP
         CbGwSmJWL9gsKrKJKpoyA/tA+wd/7/qYNermy8qDNV9zpm9pN6EpmZoaAPs8GrEpVfPs
         WwmW1/IflHa9/yrT8sybflnGaeQ2zJnECz2qYOxl+oeb2rRp3OUtTQnFUXVGANtyoEHt
         bupg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1eREocqaRi8JfvX4zrd+TFzA/qHZYlr9PAd2yj5KD3TtKFrOvFyFhwfczTUqpan6Q5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjGcMtavsBLlsGP7+zcI7YKyrdKOdp5vWwSNmOjHXrinA3o8s
	0fyiKthI5lfSFdd8LSF8QltP+ad5rsDNmNRbMsLSNRGnK5FJXlUll4yp
X-Gm-Gg: ASbGncuqzqbAGH8JPeEwa+ytGr2QWUCZ/CGBd+eBhgTxyojaWcW8BqfAI6mnhmiwRbm
	q15slg2xMwIHGyq/hiQF23erw+v39oA/3mqqLFN7hPgxMrveWkAjfdKliYbqE/RwDVTx1+uy7SM
	Gz2P9xVkEBet/NwmgWdnZn3REUo5bkA+pIBX9Fbroje33x/JJBVUMlmyjpg29GCHmQl/3BkiJrC
	zjzYeEU4koh9Y2PtCJABOVdwQo05FPDg+4XglAjkVErgEULYdfZ24E+HQosnjrhUL68u2XLiJUB
	c+ra57xXnTYVJobDNFV1GAOHOB2fpNvgTj7Qo2XAH/ks6vjObb2MobgUansVoCFhPHQg8HlNHqP
	BbJDvvvMWxYvjFW1r00WfVkQpKAQe2c15UQ6WkxuebZizevvH8Jvh5o6L25i6PdFJRZix3fZ5J5
	5AA7SC/4ZJAQW6+et8jIZvp5XJi5Q2hSrhJQQ7Ng+fdNZnrU59
X-Google-Smtp-Source: AGHT+IHXALiriWwJLx7SmcMxCfVQY5rBvQyEVgIoRqwO0R8z37/xvVCwrwjnmjxza5ZezAx2KyQwnw==
X-Received: by 2002:a05:6a00:2405:b0:7a2:8d06:fa0e with SMTP id d2e1a72fcca58-7ba3bb8ed5bmr18001534b3a.26.1763447845354;
        Mon, 17 Nov 2025 22:37:25 -0800 (PST)
Received: from lima-default ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9251c99aasm15364262b3a.28.2025.11.17.22.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 22:37:24 -0800 (PST)
Date: Tue, 18 Nov 2025 17:37:14 +1100
From: Alessandro Decina <alessandro.d@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aRwUGnyFBxrkjGl7@lima-default>
References: <20251113082438.54154-1-alessandro.d@gmail.com>
 <20251113082438.54154-2-alessandro.d@gmail.com>
 <aRcoGvqbT9V/HtoD@boxer>
 <aRgysZAaRwNSsMY3@lima-default>
 <aRtPXS8haLNHu8H1@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRtPXS8haLNHu8H1@boxer>

On Mon, Nov 17, 2025 at 05:37:49PM +0100, Maciej Fijalkowski wrote:
> This revision is much more clear to me. Only thing that might be bothering
> someone is doubled i40e_rx_bi() call in i40e_get_rx_buffer(). Not sure if
> we can do about it though as we need to use ntp from before potential
> increment.
> 
> ...maybe pass rx_buffer to i40e_get_rx_buffer() ?

Surely the compiler isn't going to actually reload here, but yeah not
great code wise. How about I pass it the buffer and rename to
i40e_prepare_rx_buffer to better match what's happening now?

