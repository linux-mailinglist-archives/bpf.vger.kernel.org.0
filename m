Return-Path: <bpf+bounces-53830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5068A5C86A
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D48C1888191
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF825F795;
	Tue, 11 Mar 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz/gMVQK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D625EFAE;
	Tue, 11 Mar 2025 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707514; cv=none; b=VvHuyLl0XbhaUA9WoPLYfk5kcfTwHUVdJRmKeDZs+LpSxjBVYg1q6Yw5ZKatstAQFFoheaOvgqSob35CGibW5Kfw3id9R59lUFVp5ZgTXnhfBdMz0xFsgbXUEbAUyR+M8sn938MSfTc/KfNR0QuJnDYGbLZA4irsqs1sX4hyQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707514; c=relaxed/simple;
	bh=dhAYAn9+2lEWF14ymMRwOcFeADWYixCbyxEqLweieoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuO/XoSreUkW/3hdacrmpP9Gy8Pq1xU4hLg72notSzdykKpdBqpPbeyiT9UPfYPRv+dVAsUy5V4VZcVAy1RHiHxJewBP4caZr/aIFRZfT7otPDqvgMJ231JmJQ1KGqxDm/0i+uAVN72x1QQZwu8q2LfI+Jqggt4uoBEcYpdCvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz/gMVQK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223959039f4so114248745ad.3;
        Tue, 11 Mar 2025 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741707512; x=1742312312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/Ky3In7/Ggm4UvLRYbQ3yA1ZtXatNEqsRSJoVt65tc=;
        b=Jz/gMVQKQy7MyhDIGPfLE5i1proBmv5aPcs8SYaJQjiOGxTdFlyHCMPXfoxHOCtiw2
         Gz794ApEfqZBJQkDitrNiCy8WnI3CCD9Kt1c0H4ldydCnFNLAjO27aeZ4cW4Qkc4D+Kc
         Wb12XTb/1uTp5drFDjqCd1pUbDLY3Yqay/+aoXT5VrdVqxH8jFWDNbXFH/Z+7DEOYr2S
         DYU6XKLTY60qo+xtGsL/ub7xenVJCO9wZIvBmS4Am1fmyp3oG6bz5CIS9og4SiQeobQ6
         hQuX8lgP37vKCFfOo9l61QKoFxWl+/gO0kD3xtcBSyghqn1QoVdajVUtc65i0ApqZhgq
         Cgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707512; x=1742312312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/Ky3In7/Ggm4UvLRYbQ3yA1ZtXatNEqsRSJoVt65tc=;
        b=RlpBaSkLAa6OUHAmTo/3KXzlRwM2z/VGOjLWWBH89Hh80Mfn4RqWRwiIMBUSxLKmxL
         LUQsetq3qSxKcBsOOOtNpflDEPjaDDE+Xe8ynQzpHEqJlIRxQwuJ4OJ/wER9hGMqVLLc
         mF8e3MEDURcEMHMSZwnF1QSClDjZFly80FMs+cGkrCVccOGvlEOgD02bEyV6mm0IuZEg
         mmr5TDMdgNKvxb2iT1pu2UVpU1tS1LCG5+aVqAVPYIKkDZ9d6gBexl43yBRz6o0u+uB+
         WUjGIUml3HRBn2sZ11Q7ZpiQXU9F4b7bQ9Q8wikOIO52SfaSjJb5+E0W1IMNcFJfUW94
         ZGKg==
X-Forwarded-Encrypted: i=1; AJvYcCVsg766vWBU1M1hj1r/8VzztgwJHNanH6ESZU/mSTGKaPAZ8o1nXJ5Afar67Jm3mk9NkSU=@vger.kernel.org, AJvYcCVswLC+o/tJ9GYGjdGfkhCjZUvGnSwQYzMFmZz5Hu7/vEc/CYa3byBYYKWe0R93WYphgfFbmDBa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyytmx7EGJMB7GjZ1kE2bLC+Bdm9VjFFx4IDlgzZpNLoByXsdyd
	5gIVVXjhr4p1MJekv2yFwG3y69kVmkrotTvrY9Jp8m0Mps1+eOJY
X-Gm-Gg: ASbGncsOWsmdmu9Y+JY5yFBF1917p183ekt6pVJWPxLhGXbT/DNwf81uQiKS+56NIwm
	AVJR9wiQbLP6TL+AOilyXqP5/xBQex+fetfwiJ++t3YHVnSwcGu55bc7U/DKHVpUP1UBFbXLWWk
	pQ/JJtMAktTG3lcixWcEazo4xbXqE0brNINI3ExQfm6jOOnMqP6AJnwCLXjkhww1sA7e2QoRkNU
	/QcSt5l8iGRHqDEZdfrvIaa4T9XE2jmX6Y+W/61IGXz9f+J8LiazOmRfrvAvQffl6BP5NFyS8zi
	r38ZIIPGeVo3i+HfUusrBX3hRCrHOeTL8XSBDnqzpAEpmQ==
X-Google-Smtp-Source: AGHT+IEdi/Ha5devWvg+Gs493UDrboKmIhlhWS0Amn0g6O7h9KaL7t4xZ2Zdz9wyUx7vGyiLe6Us3w==
X-Received: by 2002:a17:903:283:b0:223:325c:89de with SMTP id d9443c01a7336-2242887ee6fmr296300085ad.1.1741707512111;
        Tue, 11 Mar 2025 08:38:32 -0700 (PDT)
Received: from gmail.com ([98.97.37.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a92716sm99004465ad.178.2025.03.11.08.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:38:31 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:38:03 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <20250311153803.fuamcj652omyx33j@gmail.com>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <be935429-2125-4fea-844b-abce83f7324e@rbox.co>
 <thza4ufhxxdy5lggglgqkzjtokl6shweszs3cqmdkxlhsg6wcq@6l6jn5samgsu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <thza4ufhxxdy5lggglgqkzjtokl6shweszs3cqmdkxlhsg6wcq@6l6jn5samgsu>

On 2025-03-10 16:00:09, Stefano Garzarella wrote:
> On Mon, Mar 10, 2025 at 12:42:28AM +0100, Michal Luczaj wrote:
> > On 3/7/25 10:27, Michal Luczaj wrote:
> > > Signal delivered during connect() may result in a disconnect of an already
> > > TCP_ESTABLISHED socket. Problem is that such established socket might have
> > > been placed in a sockmap before the connection was closed. We end up with a
> > > SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
> > > reassign (unconnected) vsock's transport to NULL, breaks the sockmap
> > > contract. As manifested by WARN_ON_ONCE.
> > > 
> > > Ensure the socket does not stay in sockmap.
> > > 
> > > WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
> > > CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
> > >  sock_recvmsg+0x1b2/0x220
> > >  __sys_recvfrom+0x190/0x270
> > >  __x64_sys_recvfrom+0xdc/0x1b0
> > >  do_syscall_64+0x93/0x1b0
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > 
> > > Fixes: 634f1a7110b4 ("vsock: support sockmap")
> > > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > 
> > This fix is insufficient; warning can be triggered another way. Apologies.
> 
> No need to apologize, you are doing a great job to improve vsock with bpf!

+1 thanks for working on it! I was out Monday but will catch up with
patches as well.

> 
> Thanks,
> Stefano
> 
> > 
> > maintainer-netdev.rst says author can do that, so:
> > pw-bot: cr
> > 
> 
> 

