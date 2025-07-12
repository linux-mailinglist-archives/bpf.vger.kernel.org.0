Return-Path: <bpf+bounces-63109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F06AB028D5
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 03:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4EC1C84972
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1E14D70E;
	Sat, 12 Jul 2025 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="AcRek1df"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E013C82E
	for <bpf@vger.kernel.org>; Sat, 12 Jul 2025 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752283552; cv=none; b=R8ApiezFTLiaBYJRIxG1LqafgIUAQW324i/tNC4R5O/BbR3ObWOjbqbcUZVt6ZV+joUn2zZ4E3uqa5SPymmQ7xxLNaqBPEBsYTygM099wE0hr1yP21/NS8K6FNZYx5bf5mP/b+R0hYQCpQ8ADIdWm0u72Whe8+WxNyQ7Z4z8wAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752283552; c=relaxed/simple;
	bh=PS2YgBqI+n0K9OhdaYssPwqWk1XPSWBqfkuPRBvwZM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enpVIm63FXRxnEtyfsWbgvYeXigVuJfOT1GkqM5iNzMym7vzAxkmdN6NXIJjYu8Xuvhl25zN9PWWXaGqBISJ1oaQzbn6O7YaYVfkgjJLEwmOhT0O8ZY4d0xAH7lqEtMRjVEfKGLRTmyNwvdE7ectodT+N9IEUwxEfYw06H6B7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=AcRek1df; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31306794b30so439316a91.2
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752283550; x=1752888350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm6O7L5piyBZEAF6L3BH1tqbFWWMqUD4pr03r8tz/i8=;
        b=AcRek1dfD6NvJvobvk2gb9M0zZKloTJD22zrSH6ZflwLglr3X6dwRbZOH1G1UsDCZn
         ZjpAo8NZ61BAUPo8AXFRT5AF98i0m9BG9T/0+vQg7n+pI/sxgtOgpfhTgaAsvJTJnu4C
         JnD35NQfIghkultM0Y7Q1Z8DNw1bMBY8SSdOBS8p/SjkqeAC/yqAuZjHvxazN9L676DR
         npdtcsc3f1nNZh9GF2n/RIDaGXyEOsq6qUVuAF55tW2deYW6uJevvbIKOCy6s/fpJeoJ
         gVvK/MqCgYm5Wr0j0HBB2y/L75Sd1yndJBF9mCb6m02bvGBotATIPikGeu7TBzOnDAEy
         skiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752283550; x=1752888350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm6O7L5piyBZEAF6L3BH1tqbFWWMqUD4pr03r8tz/i8=;
        b=S1nXsse4/CAQbhvY5k1g6eFB5kumOShRpGPUuwJ0q+dKw2V55I7atYVV9I6MhTAgxc
         jui82Uk/YE9Kw6CP50cqkFxK+g6aK4iAi2SJw0gBgpZ2Kd1gZeemLVtn37XGpiTpxXjD
         D6n9fh8ymNqNMddU9KGSlyFx+SBGSvTKR4SYBKnTEfEY+NGwe1pSjoB9Y1J3lDtOjgui
         3qOH0COeOJ/Gjd/vkHRnAFfu99oMbtzLnxAXUW4dtqj/X7Qdv9FsHLiPa0g4EeUYZXcV
         f7Ni/mW3g76oRYOv8yhc8RWF6QBr5Uw/0P8huakVCKxV3HQcYSI71Dladr3L38Msd+rT
         DhVg==
X-Forwarded-Encrypted: i=1; AJvYcCXxAOG2QkzNQAJLiRY6IlW2wh756+7BHi3useGvo+fSmmOwYlOQ+/fvnBAxSLfoEbZGd8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNn2VLRUh4rO647H3z/mn2woEpmbX8BgVva7QMdYPMoRLPzBP
	9vlksOCzBx45s+SjVIKYRl8//IbedLWmf1wI+TkrHZtJqctLPxv8XIokdF+qojEXo7s=
X-Gm-Gg: ASbGncsuQOwi5lrfamXu5Lkh0xtCqAE/+8Ux0gI9/y7dhK1rrL3ULJ7kmH/iQw6eunD
	6MDCe9K8ncAaryYbmcXDZ6Crq5GMqd7LrFHY4niZm3sEKN8CxWCUhJUAvt+giSXBurXy1Rus50P
	vkHQEZuwK5o+S386yx6hgmWaTRiEwbRXy1J8KlhqZbddALXHg3yFBJyoo1DgkrUcQQjGhclNX39
	lI9Yq9a+/rcYg3iFGFT/1/WSu7qjks0BWCdkdZp7M72XE1uAfA8xDrW6PbUVuknBIyuPOFD7dEL
	uyk/7XxO7B1QAQWMprBe9MLMDoJxMfKGeaA+Uz50N62/hS7fm54nuXLv5pc45iQs6U1Ze1ONVJb
	9xGEIYb0=
X-Google-Smtp-Source: AGHT+IGZCes+k3Vgx7XWiAeA3ycb+6xDmUCazWi2pxvLOmeNDxdiC/fXDYp+kKtkRTAXwgnG+QF8Ag==
X-Received: by 2002:a17:90b:4e87:b0:311:488:f506 with SMTP id 98e67ed59e1d1-31c4f545d00mr2518810a91.6.1752283549493;
        Fri, 11 Jul 2025 18:25:49 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:e3b0:5676:c947:423])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434141fsm53894615ad.168.2025.07.11.18.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 18:25:49 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:25:46 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next 10/12] selftests/bpf: Create established
 sockets in socket iterator tests
Message-ID: <4hymd6ivknwleq7fvdicod6fdnbtlf3fqwkbjadfg5dsumfhcz@7gdrkdbocywe>
References: <20250709230333.926222-1-jordan@jrife.io>
 <20250709230333.926222-11-jordan@jrife.io>
 <2c66f688-988f-4f55-a822-de5686178b1a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c66f688-988f-4f55-a822-de5686178b1a@linux.dev>

> > +		i++;
> > +		established_socks[i] = accept_from_one(server_fds,
> > +						       server_fds_len);
> 
> I am not sure the final ack is always received by the server at this point.
> If not, the test could be flaky. Is this case possible? and is it better to
> poll/select for a fixed number of seconds?

Fair point. It definitely seems like a potential source of flakiness.
Using poll with a timeout sounds reasonable to me. I think this
eliminates the need for setting the O_NONBLOCK flag as well, which is
nice. I'll make some adjustments and send out another version.

Thanks for catching this!

Jordan

