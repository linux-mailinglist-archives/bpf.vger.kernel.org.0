Return-Path: <bpf+bounces-71833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D25BFDA31
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F431A080DD
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953132D978A;
	Wed, 22 Oct 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0fLYb71"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE562D8DCF
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154781; cv=none; b=XmGyXfoXhqLnto4AuBZ4u4lm3ZM+u65we4/5lKwO+DbAoe/1+AXVfBse+9CbIUjPdCgZwMOIo4TdbCht/QqHpMr12MrUQJzAQ9TN4OXcBi8m2+VCopMzg555qYc9b7IuJC1X8GsHKQdSdGVwoPede8o+8R7XUJfdx/BpGmZko/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154781; c=relaxed/simple;
	bh=O2rS9th93VdiObqGHqJg9tF9FtBIZpNefdSGlMkHdmY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9S5+lN2ZqSldxmrEY4stI/K1XsGtMvSATWQeCmG+QyZShOLW1ZMwT7YN09BZwCGPxIjxicoHiPi06vfEiZXQESd4NdPAHjm40REk43vPTmM+WgpGqMzPsjI+ca56y6WD5+R7BrdReVAo6sJqJMBbIpUWbSJF3kxXg7locB8p+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0fLYb71; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so582149a91.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154778; x=1761759578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQdE14qwP3ArpvNj7koaLBKy4oXNS6rDuyXrc8Mb3G8=;
        b=V0fLYb71LWnbHwu7vx+4+aT/VvkpyKipsXg1ezt52QvFAnKAfO/rz8U9SAK3QD+I6M
         a3HuAHR/dntApw2kb4XyxrlPKGsIblTNQGIM7K4tFoGHgZ6ops7ZEi4ej4IlWOObDJm2
         IGIrsJfG3ZqjSKhfdC+6zndkFNPU5yo3U9KEVSZ91FQWAFQOEtArWzGhABH71QcRTZOg
         uvcGXrc7+cns1KPyTfU9cemH2ySU+42kbSGJIqEf8kt2hiXVHOmLb56+1/ID69JrZMux
         A9Y8GYgN8ATvaCfykkSZtFExjj/YN5o1fkoz8QhJi46JrLqbTSz3oNTO72YXBpdF6oLg
         QBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154778; x=1761759578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQdE14qwP3ArpvNj7koaLBKy4oXNS6rDuyXrc8Mb3G8=;
        b=cc8jONkWdLvHt3jEWmyhrrwb6yrsZzYWDhlntQmzdEZylLcnKIGFUOTMU8gSp/Sd95
         tYBJT4nGUvbW0VDDScLBjhE1Ak0xuayHZgT3PXvYP5oEQNxXomQ3hQjuL9bCnWTr+5Rm
         C1npWIJfVYEq5jjOWQaU38U3lyKXkEuyonqxym+QFKN5WDzLZXaI5ZcojoYtL8IxcPvb
         76ORF0p2EF0odfnw2lMajloIZl1Czj5x1JxqcHAks+jLRJBX0edf+Cjm5FY6YM218iSX
         TtrrQrd5T1O1ZvV2fKgEQfIAWKk0QzDtzHe0kKlGzzFRabZXamb3P9x66ncKK3Bwt9Tk
         RgnA==
X-Forwarded-Encrypted: i=1; AJvYcCWjZ63apjBlCbGxkaNNJ84ta3qpv/cnqIdSNndfFQbvxmBrqWWGLFfY3sQCPgmaTaH/nic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjOZty/dQgZY93ecYxHkuBvhJP1BBo+Y9c0yyy5Z8l8gwz1QJB
	jUmzJIaZpFzzzHLbUIhwiR/iPyBLV4TnSEL8ieNLONPC9hAQ4BQK5xmh
X-Gm-Gg: ASbGnctijp0LVcWW7JnZoEkgBqth2nohjoIWA5LS/iNmDmGkO+y2U3LpthBTSmda4eN
	wriV653/UmwjdY4S3OInSengi9tlGe/x7CThZN+5W2lNBnByi+ogdkGwzOh9SxjvFo+YFUTcQgT
	YCVNKib46T8W/I5dvSjZF2Vkk5nrmX0flfjt03+1+7DaNgNBxy/r5AAlr4U91GOoXUpp2SwnNPX
	gTYBLfmoGMMtOtx3HcMFjUVvAiqxMgeK58MRlh6fpwOUdU9iZBXYKhn5x0Yy0OXZ19Xkgzg4M0V
	lk4XS1dA93/A9k2S3+mjjY2omVE9xIwUaDfNZ00fgdr1v6hK9YQnuR74i7rhFd3/7Mm6LGmrVB8
	n5+S8YcGpQjT5bYTgz5YH4fB474Afai6gzrGNcr2WAxgsA+xPN8cTY1laesMrLtdmcVVnmpKWE4
	sig/8=
X-Google-Smtp-Source: AGHT+IF/wQlvN1PHS4P0FuXHnhUI6gRONo719YP7lTtUWQHYnX87iTmhZHJVAyR2zlOCWjra1Hg12w==
X-Received: by 2002:a17:90b:3c88:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-33bcf85d01dmr25963979a91.5.1761154778032;
        Wed, 22 Oct 2025 10:39:38 -0700 (PDT)
Received: from lima-default ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d11c8sm3174342a91.4.2025.10.22.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:39:37 -0700 (PDT)
From: Your Name <alessandro.d@gmail.com>
X-Google-Original-From: Your Name <you@gmail.com>
Date: Thu, 23 Oct 2025 04:39:29 +1100
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alessandro Decina <alessandro.d@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aPkW0U5xG3ZOekI0@lima-default>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <aPkRoCQikecxLxTS@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkRoCQikecxLxTS@boxer>

On Wed, Oct 22, 2025 at 07:17:20PM +0200, Maciej Fijalkowski wrote:
> On Wed, Oct 22, 2025 at 12:32:00AM +0700, Alessandro Decina wrote:
> 
> Hi Alessandro,

Hey,

Thanks for the review!


> 
> > Whenever a status descriptor is received, i40e processes and skips over
> > it, correctly updating next_to_process but forgetting to update
> > next_to_clean. In the next iteration this accidentally causes the
> > creation of an invalid multi-buffer xdp_buff where the first fragment
> > is the status descriptor.
> > 
> > If then a skb is constructed from such an invalid buffer - because the
> > eBPF program returns XDP_PASS - a panic occurs:
> 
> can you elaborate on the test case that would reproduce this? I suppose
> AF_XDP ZC with jumbo frames, doing XDP_PASS, but what was FDIR setup that
> caused status descriptors?

Doesn't have to be jumbo or multi-frag, anything that does XDP_PASS
reproduces, as long as status descriptors are posted. 

See the scenarios here https://lore.kernel.org/netdev/aPkDtuVgbS4J-Og_@lima-default/

As for what's causing the status descriptors, I haven't been able to
figure that out. I just know that I periodically get
I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS. Happy to dig deeper if you
have any ideas!

> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..dbc19083bbb7 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> >  		dma_rmb();
> >  
> >  		if (i40e_rx_is_programming_status(qword)) {
> > +			u16 ntp;
> > +
> >  			i40e_clean_programming_status(rx_ring,
> >  						      rx_desc->raw.qword[0],
> >  						      qword);
> >  			bi = *i40e_rx_bi(rx_ring, next_to_process);
> >  			xsk_buff_free(bi);
> > -			if (++next_to_process == count)
> > +			ntp = next_to_process++;
> > +			if (next_to_process == count)
> >  				next_to_process = 0;
> > +			if (next_to_clean == ntp)
> > +				next_to_clean = next_to_process;
> 
> I wonder if this is more readable?
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..36f412a2d836 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -446,6 +446,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  						      qword);
>  			bi = *i40e_rx_bi(rx_ring, next_to_process);
>  			xsk_buff_free(bi);
> +			if (next_to_clean == next_to_process) {
> +				if (++next_to_clean == count)
> +					next_to_clean = 0;
> +			}
>  			if (++next_to_process == count)
>  				next_to_process = 0;
>  			continue;
> 
> >  			continue;
> >  		}

Probably because I've looked at it for longer, I find my version clearer
(I think I copied it from another driver actually). But I don't really
mind, happy to switch to yours if you prefer!

Ciao
Alessandro


