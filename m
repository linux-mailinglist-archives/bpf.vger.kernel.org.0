Return-Path: <bpf+bounces-64921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A46B18778
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 20:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A591C266D4
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDAF28D8EF;
	Fri,  1 Aug 2025 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fou+xrGB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E11A01C6;
	Fri,  1 Aug 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074272; cv=none; b=BTSG1QkIEitd6/INE1msqzLyOk4n0PJX2Zj1tyMyFCjzjhhKAN9z8bJWJx3wqT5AInB/Th7BaUzhs7d8zzpR3cBvzM+uvjr1EyRrqTu2b+mqvXh1daOOqlkm949uQ7CdgBgR8RYsET82MN7GFYG5ea/gwrMGagbUPFNdSy/WuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074272; c=relaxed/simple;
	bh=GJtOm3slrvof6q+hTzB/Ofv3KWMB/gG+He2meHC94sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1CW6wY3J7ZyJwbjmsRLSZF+tzgBWVFkqQlQSH3xR+njYc37Jjltd6WPWo2ZhY/pCYeq3FEg700WI9xl1wXHljQbghpig5PDqNhiiTlXkdcrrHoYL854qMzfl5J3UlkMp9oLU1MnFuJP6D/tij1Y6BKH4JGm6px0tNnk1lSZmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fou+xrGB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7886bee77so2013140f8f.0;
        Fri, 01 Aug 2025 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754074269; x=1754679069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SK9F1RiLyxBRk7x2ImhfvuGUVVv8TtKtiEni0Ha8RRY=;
        b=Fou+xrGB/2LLtRmffHe4soy1RC0VIUgKbSDuKhFS5QwId4X8mwOmf+P0ttZGYac+Up
         Y+LhGVn78n3Ko/7NvrZzmF53DH00ZIfCHtsCrL2VHM1jAL/XR6ozLIztX3/9+ifDI3an
         1ZGLNq+DuHtgXPuDej0up/ntbd5vVSuHkYuZRUwMl6pAarEgK3bNZoMy5jvW9bzYzhLA
         2CaVqOpEly0xWyvCr4O2EF7ZM8JCBTjA66zLo3kIwabPUbn9VjvFf7BtTwNKLHkfUzgv
         IKBF5wLFWmxd7DUvGT1fUh0ODlCX3wx945PPP4oc1A+Ttf/kQZjucmVLXgSa8NJjd7Sy
         zw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754074269; x=1754679069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK9F1RiLyxBRk7x2ImhfvuGUVVv8TtKtiEni0Ha8RRY=;
        b=abNMCNFCLS2miFu1OkCGkM5fs9vD9KvDj2cGDQIFE+49dVTCyE74xdwUrNmeK5L9sL
         7O3OcZa9D3vw0zv4S/aUIf7l7Rn+s89O1kbdWyfbe+9ZAewYWaIUp9rmWUvvM0374gtt
         SIpge162SPwefrkBbeTPc8saMNBCU3DIv4banqHvT66/izDWa5WlpxZQWny5qrByZ4C8
         k5143mBM1Qs8YlGI9dT9I9kXksQckzQPGNA/TqE0qSyj/Bq7yBXukSa2rRr7RU0nn3Q7
         MewF2D1kxAQ0xQMGtl6QMTyNmpbArZ2Tqn3eLeKN/uLsRFOha8Ngog0zgHiGVnVTO/n9
         88Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU5sOakpuPIIoZyWO+bhGoRLlnVbOefzjKfsDHuu20DwjHAfeQh1fdZgi4Zrzlt5m4W6B4=@vger.kernel.org, AJvYcCW3BIeftINPK8qzw47PfPI2cGAlu9EIOwWcGLBbwxnXjVJvlznCxJZOqyFFjP11E4bmp2HduvCH+dQr6ypZSEs3@vger.kernel.org, AJvYcCXd3kGrbNUOfU7ZubMZhtziBya6gjjQo7q9kz0ey206c4AASd4mdVRFWfBQN1vTUowsiY3VRWVC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgpa/ORiL8977M9kJT0OtYDW23fDAfIqO6XICa64WCO2HD5j+G
	t+PphkQPRLoqSBa4T4VpRmJmgHtzL1xVfEf4oAdUKoagrWJrCjTPyBjSlGkbmNvq
X-Gm-Gg: ASbGncv9N5y23a+0Zg7BhAuPtGt1NQ/83dhOSCMfD3wnM251yfWepm6YBGMgl4nJynj
	yYMXp+8GzdWkcW8Xz3aQXhYaKBNxc3DbhBYSdh5WR7WMT+cB0w1w9I94DyAluqzw2CKYxLApWUU
	W3xxjUPuklcSkHz8PH7w7DxmwNdkB0/RWUBFk5KcoBYQWI8ej5MYF26F4R6b8SuKLqx/vBN+q4U
	lBG4kALB0vmlDCJ/ibDqVv62qqZlm+E5ZrCmKrok0JfFI3UuVtojnWFfMNaO8cT8xtbTOeCA6XA
	+I6QNrQ4bqrXsNsMNDnQcTMFy2O2o3vk/xkxorZmGUY2Azxt9L0M8XqM/4fZAOP7jHpsi47q3xF
	rWSJHj/jHtPrtMVPeWrPB6aG0H0YYfTVL5KJMpF7QO5Io+NGpzTkvjKzt4lQzp7kezg==
X-Google-Smtp-Source: AGHT+IHzu2OCBXlhfBQt056QzK8rnB23WlUCbZ2hbfwLiegFccJTuK4y21n6xhQsjPwJw9oOLIefxg==
X-Received: by 2002:a05:6000:1a86:b0:3b7:75e8:bd17 with SMTP id ffacd0b85a97d-3b8d9468cd1mr693243f8f.8.1754074268866;
        Fri, 01 Aug 2025 11:51:08 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm6981732f8f.40.2025.08.01.11.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:51:03 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:50:56 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, lkp@intel.com
Subject: Re: [PATCH bpf-next v3 0/4] bpf: add icmp_send_unreach kfunc
Message-ID: <aI0MkNvWlE4FXMV8@gmail.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <b36532a2-506b-4ba5-b6a3-a089386a190e@linux.dev>
 <aIiaB2QUxKmhvPlx@gmail.com>
 <7083544f-5b0c-432e-bec8-509ca733f316@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7083544f-5b0c-432e-bec8-509ca733f316@linux.dev>

On Tue, Jul 29, 2025 at 06:54:58PM -0700, Martin KaFai Lau wrote:
> On 7/29/25 2:53 AM, Mahe Tardy wrote:
> > > Which other program types do you need this kfunc to send icmp and the future
> > > tcp rst?
> > 
> > I don't really know, I mostly need this in cgroup_skb for my use case
> > but I could see other programs type using this either for simplification
> > (for progs that can already rewrite the packet, like tc) or other
> > programs types like cgroup_skb, because they can't touch the packet
> > themselves.
> 
> I also don't think the tc needs this kfunc either. The tc should already
> have ways to do this now.
> 
> > 
> > > 
> > > This cover letter mentioned sending icmp unreach is easier than sending tcp
> > > rst. What problems do you see in sending tcp rst?
> > > 
> > 
> > Yes, I based these patches on what net/ipv4/netfilter/ipt_REJECT.c's
> > 'reject_tg' function does. In the case of sending ICMP unreach
> > 'nf_send_unreach', the routing step is quite straighforward as they are
> > only inverting the daddr and the saddr (that's what my renamed/moved
> > ip_route_reply_fetch_dst helper does).
> > 
> > In the case of sending RST 'nf_send_reset', there are extra steps, first
> > the same routing mechanism is done by just inverting the daddr and the
> > saddr but later 'ip_route_me_harder' is called which is doing a lot
> > more. I'm currently not sure which parts of this must be ported to work
> > in our BPF use case so I wanted to start with unreach.
> 
> I don't think we necessarily need to completely borrow from nf, the hooks'
> locations are different and the use case may be different.
> 
> A concern that I have is the icmp6_send called by the kfunc. The icmp6_send
> should eventually call to ip6_finish_output which may call the very same
> "cgroup/egress" program again in a recursive way. The same for v4 icmp_send.
> 
> The icmp packet is sent from an internal kernel sk. I suspect you will see
> this recursive behavior if the test is done in the default cgroup
> (/sys/fs/cgroup). I think the is_ineligible(skb) should have stopped the
> second icmpv6_send from replying to an icmp error and the cgroup hook cannot
> change the skb. However, I am not sure I want to cross this bridge. Is there
> a way to avoid the recursive bpf prog?
> 

Thanks Martin for the review. Indeed the recursive BPF prog call is a
concerning issue. I'll take some time to think about it and hopefully
propose something.

