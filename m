Return-Path: <bpf+bounces-55910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53970A89047
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 01:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C5218909BA
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FEB204C2E;
	Mon, 14 Apr 2025 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Twbx75Id"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5901F4CB8
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675153; cv=none; b=rnKRBLSjt+cN84IaepJkrRqOA8BKgEpsxTjJ2SJ85RLi1mfl/n2/7aY1k47RMBlBUaK0G+XdWwJqMMbXuxHqECBJFD/J0ZB47lf8zLHU/PhRWicHUHjHX3IUOY4mmyJbJW3csmn1KhirV1fQmU7ZcYEWcFTf7KrWggsqpg8doPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675153; c=relaxed/simple;
	bh=xNkzooea7wO9i95Byjx+9af2yx2t3txiBFt7vNQM9RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fas7vJsPMjPHSYr0LHOp8UTtcXTueQmTUY6JGDfuCgiAiCliVJITzIad8Z2Kvvlghxg07EU/dwHjdFRVcROaKnNPb3uaQsphhn8YNcjXVPbyr3WYi+2y15NyW5W5SxZkFSo8cazpsj0s15knBv8xl+1MoV1nqZ8HWXivonVBXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Twbx75Id; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224172f32b3so3727405ad.2
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744675151; x=1745279951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7car5NrNYMGdJCt65Ei+bPHffNt2gDHXoe8QlFIKhY=;
        b=Twbx75IdGP2EG9s8ko2YgTCkmx1iYQbucu7Jtpt8BO0Jnl54YF/eioBFrYdf0CUAvu
         cpex0w/GJdEDHdtlDCZ1npvhiNAnFMXsZfRJlLPjmKBLv7WKcnied5M1Myu7d6QSqc5c
         e7gNhZ2ev4lRAV5p+H5h9IZZ9OEoKEZf0RsUb/hJDKvKuoszDUO9g3FwC9O57pwsmvX+
         7HcaX6XE07Hq4EoZNCHaO5BnG+OucZ/Ro9Yryp+s1t0K2Kp6oVYKo5Fyc56RRUJTgtj2
         D/D0GaCvu9umwNFSZb3L+c1s/1m7VMbc+JFwD+fNxRClcZPD715mPIAjrw5XiW0j17ob
         ztrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675151; x=1745279951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7car5NrNYMGdJCt65Ei+bPHffNt2gDHXoe8QlFIKhY=;
        b=dJneyy/DzT19foGWEQg4b+P6qBSLfRlreoDgbPSjq56NZL1zasnwll+T3Ws2P/HHtZ
         jJ/+7NpfU9USDB63DGWXGh93qGoExrBB/Ap6frdlyfddg/ouQndG7bzoSveNLVuZT/mh
         Hrmu1s3zrc7AwcLGf8MjffLuHp5nuA9x/eFx31olYFkjT1r60oTPKxZwaGdvwMAJYrHj
         zfyntxLTZNZd4i52oH1K6NksbZRA0QFbShUyPe6SCGdBGTnDZQmSr5WZ6n/eWWNjmCNn
         1G7W9Jyyn5Jr+5AfuN6A5puoL1Z1lbEoChX/GSs2gr635EXnIa39WK5lAYb+Ste055zD
         alCA==
X-Forwarded-Encrypted: i=1; AJvYcCWK6Cn7B42qYo9P/JbORKX7jlJXdL1DIJDYWDqetDWFhMqqkl+o9pHMkgAhxYmZX/E0+Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwMC6YARBaZeHrIlcc57jjam6gO0mFV9cCw8kVhuBe9kpYs6I
	Rcru3smabEiQawo+VvphyF4wuyVUtBH5p/Sh2uVAhpGFFwaHdrwQO8m0CkvBakU=
X-Gm-Gg: ASbGnctw0pUooHSndfeEaYIJTmWgmIm49Fg4h2Ul9YCuBW3lidADuvL6ONQ5B3+LGJ4
	uhyWaqZFAV256R+MjxxL2F/ryD8oD00AhRSsEvcOX5Yg+By1g7N+/SiBIL0VQvhFD5wUYVbEKac
	zVoipge9k1WmQERYxaw7EHgh0mjdMj+yVFVREo3W+UuFeGUNSjKHwbOL+eukcCAnzDRydPU5QeM
	DIuxVJrhqNympYhteIm/4qAguvdQaOmKtLOYanf/Ov5LihrVPTxQqaS4sBVMCwOsYHfkknmRgMQ
	H0+S9lsf8v66qxtgGHSpdRmqn+JBlGWxXjNLREewo6XzaSSD+NyP/8TJvdrCBvi0/s0K4A==
X-Google-Smtp-Source: AGHT+IEncpwr1BPBr5aS/F9FwkRUDjNREYimba2t6+AUnVQoT7I5TIIS9q90QQCYEzbLcH//6PEdEw==
X-Received: by 2002:a17:902:e74e:b0:215:b75f:a1d8 with SMTP id d9443c01a7336-22bea496161mr75171075ad.2.1744675151450;
        Mon, 14 Apr 2025 16:59:11 -0700 (PDT)
Received: from t14 (135-180-121-220.fiber.dynamic.sonic.net. [135.180.121.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccbf2bsm105200065ad.245.2025.04.14.16.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 16:59:11 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:59:08 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: udp: Propagate ENOMEM up from
 bpf_iter_udp_batch
Message-ID: <Z_2hTDs1Y52ozsnF@t14>
References: <20250411173551.772577-1-jordan@jrife.io>
 <20250411173551.772577-3-jordan@jrife.io>
 <7ed28273-a716-4638-912d-f86f965e54bb@linux.dev>
 <CABi4-ojQVb=8SKGNubpy=bG4pg1o=tNaz9UspYDTbGTPZTu8gQ@mail.gmail.com>
 <daa3f02a-c982-4a7a-afcd-41f5e9b2f79c@linux.dev>
 <Z_xQhm4aLW9UBykJ@t14>
 <d323d417-3e8b-48af-ae94-bc28469ac0c1@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d323d417-3e8b-48af-ae94-bc28469ac0c1@linux.dev>

> I am concerned having higher unnecessary failure chance (although unlikely)
> for the current use cases that do not care for a sk repeated or not. For
> example, the bpf prog has checked the sk conditions
> (address/port/tcp-cc...etc) before doing setsockopt or doing
> bpf_sock_destory.
> 
> I may have over-thought here. ok to bite the bullet on GFP_ATOMIC but I will
> be more comfortable if it can retry a few times on the "resized == true"
> case first with GFP_USER before finally resort to GFP_ATOMIC. or may be
> another way around GFP_ATOMIC fist and falls back to GFP_USER. Thoughts?

Sure, this sounds like a good balance. I'm leaning towards falling back
to GFP_ATOMIC if trying GFP_USER first hits the resized == true case,
since then most of the time you wouldn't have to hold onto the spin lock
any longer we already are. Maybe try with GFP_USER two times before
falling back? I can add a new patch to then next version of this series
with a PoC to review.

> 
> For tracking the maximum list length, not sure how much it will help
> considering it may still change, so it still needs to handle the
> resize+realloc situation regardless.

Yeah, thinking about this more today it's not very helpful. Also,
tracking the current longest list length gets a bit messy.

-Jordan

