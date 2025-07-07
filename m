Return-Path: <bpf+bounces-62508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA18CAFB6DB
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E313A4A2836
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E302E2653;
	Mon,  7 Jul 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1eKC47q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43DD24B26;
	Mon,  7 Jul 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900785; cv=none; b=gV60nd0OfegAw70oA1AcscYRuFqN7sFr1B77T5DG3perKOhwtQmM/S3UqBtJMUSBn2LT4WgPzZqRx9YZ6mu4BbT46Xh3ri4OWd+ytgr0jXe82xz3lmoE9PBbMiLMHNrU3r65/XWVpUWDNQ9R8g2Gaqo+c8P6Fgip1X9f9vBvkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900785; c=relaxed/simple;
	bh=OtZTlc41xEUSAFuDvcnp3QF+S8jjt8sKIbxXecNYARU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk/+5n7wBk9ggK1ddL56iKPeCNSuyKGOfjYApqCzNSn9ubAYBgqy9eirED9c4lrGlYG/i7xN3p4h7c5dKUx6GnqT3ofnHCxb9aJAOtqpPnqTBacyrbgoWthE//iRq/fzrF/8lvT0kNitsu0AyY7xhpZ2XlDIR0C3+Tn3xrZgRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1eKC47q; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747e41d5469so3622465b3a.3;
        Mon, 07 Jul 2025 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751900783; x=1752505583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBwTkO1i6uyUmtXk9j5iWD5gRAXh5Ag4QOoLfLwpMgM=;
        b=h1eKC47qTTq2HSCxMwJxjJb6V5JPzrgGUTxsFtZMVwCcMDD4/JFK3y27XslPGq8l1U
         I5NQ7vZlWgrPSk9bZBIVuo66jQCbyftj9vPDkuq+7A+yHFctv8hMr/Gw3AzTSnhDVOXL
         O5LUoJyxn3Nh7BDbfSqBsuO+VHm/D7NL7Ybu+FOKxgqfC+ZWzoeH9Ew5lk6CmTdFs9ts
         iqgNgphYxzlDO1yuzonxIoeR49Pt0ZSWKeVki5ZWKg0NeRpIn25vsX6uA9t3m844zMXp
         aiKyPJDmggc/gjQ5zHQFFyYD/EH/+O/zCBTBnH9k6iBDAatv0eoX220bHrtX4786ZF0Q
         f56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751900783; x=1752505583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBwTkO1i6uyUmtXk9j5iWD5gRAXh5Ag4QOoLfLwpMgM=;
        b=TdqO+BxQwjJH54mu3467J2TSt2heLFIdquDVmiz4DOFHJ7NmZ7WiMHWVP4wVR4jzBp
         KlNqxOkbf7vJIBr17hAkw7gyQdBQTjW+pifmXXtbcP7q0ggx3setil5Y8L0Ui/SEunCB
         nFvVfoPa4Mu3+Q/2Bxd/6UQsl5QItqpHamJN7gOwxvINUfDm15jYnHSyDcd/MBdWeD9p
         +RTeHGv6YI5eQZxONzCWF/FPz6BohJAw2woLXUE9T+ALQQ8hX6JVtQqS8Y599yqF614I
         obH/bEo6J6r9B0We7Xy3XJzUR8AYJjjo/figngJtA1dCc9y6Q4QALzb37VZbTuEZso1W
         Ly0w==
X-Forwarded-Encrypted: i=1; AJvYcCUITl3elAFsEnJLZSJ2DtkhCjJK8+UYxjnh5qHEFeY8McLZMfAHzZ8/t34gp/1GxNgisXQ=@vger.kernel.org, AJvYcCX9gEMWMuleHlURsEwsC7b8ZFNj1+DvcxE/Q1a3nhGZNu8ILFKlDF/n9SRwOWA9htDSSTWLviHZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjlnF1SRKIjRpOr+FDz1tzTJQrJgTnTl1T9+XtLmZV0q7sQrs
	7+HSEPyfiby1EmSNj4AXb+4VwEVtG/USSzVaz2M19D+oetgFBs6t6dA=
X-Gm-Gg: ASbGncsryxjWUZazwjzOabTXYfDKS9dv9SNnZx4IOUVGkQkNyLF2s5P/B6l5vF1m38h
	JFYs5noHGem0+elnYKYL2Fo3JMCJQmf4OXG4Fn3BuElTotbIgl5xxoi04D44fGrAbfClbTkyhtn
	nGCrOz5Z9Fvuykz2wsCFdMGdpeXdZzq1fz4Lom+h47Q6dlqpJ6zvQx+Fj/MzwEcO8UWF9P91pzA
	MzDVCRGcSNLnCb/vMyL1JEKntyiwCxfI4wDlvzmd3lEUlf2XV0hEFFKj7UcVVKkP6rMTYPM3l6B
	+Dy9GZzFIfMak/ebCMAIiwtnHf2JsDVVa/kGW6TcQQNuiyxyEoPcogr9O1Qq0rj3qBsckBlPOA+
	i8oumCkrwJROIck9vasxiJbk=
X-Google-Smtp-Source: AGHT+IHvJfhixLT7bcWwkcxX64R8rNpGvST8CW9NVhZs9Vy4EHGpO+QVgRb0plujhQ6UjhYUzyE4yw==
X-Received: by 2002:a05:6a20:734a:b0:215:ee6e:ee3b with SMTP id adf61e73a8af0-2260a794581mr19874078637.15.1751900783014;
        Mon, 07 Jul 2025 08:06:23 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b38ee7410a0sm9098766a12.67.2025.07.07.08.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:06:22 -0700 (PDT)
Date: Mon, 7 Jul 2025 08:06:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	netdev@vger.kernel.org, magnus.karlsson@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
Message-ID: <aGvibV5TkUBEmdWV@mini-arch>
References: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
 <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com>

On 07/07, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Sat,  5 Jul 2025 15:55:12 +0200
> 
> > Eryk reported an issue that I have put under Closes: tag, related to
> > umem addrs being prematurely produced onto pool's completion queue.
> > Let us make the skb's destructor responsible for producing all addrs
> > that given skb used.
> > 
> > Commit from fixes tag introduced the buggy behavior, it was not broken
> > from day 1, but rather when xsk multi-buffer got introduced.
> > 
> > Introduce a struct which will carry descriptor count with array of
> > addresses taken from processed descriptors that will be carried via
> > skb_shared_info::destructor_arg. This way we can refer to it within
> > xsk_destruct_skb().
> > 
> > To summarize, behavior is changed from:
> > - produce addr to cq, increase cq's cached_prod
> > - increment descriptor count and store it on
> > - (xmit and rest of path...)
> >   skb_shared_info::destructor_arg
> > - use destructor_arg on skb destructor to update global state of cq
> >   producer
> > 
> > to the following:
> > - increment cq's cached_prod
> > - increment descriptor count, save xdp_desc::addr in custom array and
> >   store this custom array on skb_shared_info::destructor_arg
> > - (xmit and rest of path...)
> > - use destructor_arg on skb destructor to walk the array of addrs and
> >   write them to cq and finally update global state of cq producer
> > 
> > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> > v1:
> > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > 
> > v1->v2:
> > * store addrs in array carried via destructor_arg instead having them
> >   stored in skb headroom; cleaner and less hacky approach;
> 
> Might look cleaner, but what about the performance given that you're
> adding a memory allocation?
> 
> (I realize that's only for the skb mode, still)
> 
> Yeah we anyway allocate an skb and may even copy the whole frame, just
> curious.
> I could recommend using skb->cb for that, but its 48 bytes would cover
> only 6 addresses =\

Can we pre-allocate an array of xsk_addrs during xsk_bind (the number of
xsk_addrs is bound by the tx ring size)? Then we can remove the alloc on tx
and replace it with some code to manage that pool of xsk_addrs..

