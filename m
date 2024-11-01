Return-Path: <bpf+bounces-43702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F009B8A43
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 05:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4441F22901
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 04:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A09149DFA;
	Fri,  1 Nov 2024 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QoaI2uOx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030E1494B5
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 04:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435949; cv=none; b=bOmz3FxJIwSLy+cT+D1RAQs2MIh8/fio2BEuWF8XW6jzgMHBuR1xu+QBooQUX6MUXNT1OpEW/hmAWS92B8q6o45q5lCkIHqWbO50l/wkZSL+q9aPYFGpJdOmPToAibpZAAOzQG3kPCMUP4Xi7r2fupFEpUGlJIg3B4DibC/27jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435949; c=relaxed/simple;
	bh=ZekkZF+UkdHn0Q91alOKmAiQsy9GAM3MuhejYi4hJYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpJ8sMZeFxGHflBfcdOOCm33fIgrUukWVf8QyCopTZlZqFQ1rAwAuh1CW8fBXJXbj5pAJIjOhxwDGn9WGm/YjtKDvWAw4KMBNlExrkJgV4Any2/LtGHFJAEdHlhR2Ntj9RUVs9VRweSTZkgOB1yfKe0dqygIfI9B2SRCqfEaat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QoaI2uOx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c714cd9c8so17428665ad.0
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 21:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730435946; x=1731040746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjTMm7UeOMlkBJOsYxfUqt1WhI+YrUl78uiV5XzaxbI=;
        b=QoaI2uOxgBIC9UnQxUy+RgUg5F/39CGqMiEu018qxqfBHVNOeoXazCJ+BNQr0XVb8K
         RAmh1MGUOdCjLDRLZ5j38uJo7Zq4IZD9rDyEv3upVFy+wom+oeZvBH1GykQm34qHCd3g
         S30Nn0YynwzgYHue8L4c2Q8IyxONot2DcUn6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730435946; x=1731040746;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjTMm7UeOMlkBJOsYxfUqt1WhI+YrUl78uiV5XzaxbI=;
        b=k0jJ24MBK5u6eX6gOaJxJNmlHK5PAxhUy8FhVgFlEuu6fq0NkpOUWfXVPDW3ymYiYb
         s0FGinbuBq0Pj9CBuan3hp+xEbsOrQ9JoC76nYNekumQ8JhRrp5qqaztMB8PmpkLlMWe
         EZ30fJWOsgKdIAHEkWKdQqXqpMOcqbwpCiheZ3juYaMswGeAiAv67cD4/CS9Ic95sKLF
         Sp08d0+523JqaYTZLPJe5Zr9QZiV9FTNrQjb189YPNaRb/iHc+lJXGNQj/KJF69uqAKM
         AJr5bLwmOzNVeQCVtqXWXcADGxZ0wIPgse0ksqon+9oJ/aI6RvQwhEKKx1KqfI2XwyYW
         lE+A==
X-Forwarded-Encrypted: i=1; AJvYcCUYb5QKs65i7XSZTLMgwsdq7FGg3hW511kyW4Fak+ohuQ1jVCpqexwhkyPsrNpbRgdnw7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyeW/wr/gsg16YZKkjfhEhPETrM6AZQnQq5Z4nDn27CYDKiWPg
	mR+7JPCPaSXw9OnA4z4RhX59OxKoItbya+IN9ne7x2qlq9Smx++cwUpsd2BfOW4=
X-Google-Smtp-Source: AGHT+IHFzA8goxLg/i7aPIPHLWpnxlZs+6kU062+Winb+Bwot9ysYkafB2xRqmetM9tiBbmc4yIqqA==
X-Received: by 2002:a17:903:1c7:b0:206:a87c:2864 with SMTP id d9443c01a7336-2111afd6ca6mr22884905ad.42.1730435946221;
        Thu, 31 Oct 2024 21:39:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc7csm15778075ad.36.2024.10.31.21.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 21:39:05 -0700 (PDT)
Date: Thu, 31 Oct 2024 21:39:02 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com, sdf@fomichev.me,
	peter@typeblog.net, m2shafiei@uwaterloo.ca, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 7/7] docs: networking: Describe irq suspension
Message-ID: <ZyRbZpCiANaxNNlv@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com, sdf@fomichev.me,
	peter@typeblog.net, m2shafiei@uwaterloo.ca, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
References: <20241101004846.32532-1-jdamato@fastly.com>
 <20241101004846.32532-8-jdamato@fastly.com>
 <cd033a99-014c-4b41-bfca-7b893604fe5a@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd033a99-014c-4b41-bfca-7b893604fe5a@intel.com>

On Thu, Oct 31, 2024 at 10:47:05PM -0500, Samudrala, Sridhar wrote:
> 
> 
> On 10/31/2024 7:48 PM, Joe Damato wrote:
> > Describe irq suspension, the epoll ioctls, and the tradeoffs of using
> > different gro_flush_timeout values.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> <snip>
> 
> 
> > +
> > +IRQ suspension
> > +--------------
> > +
> > +IRQ suspension is a mechanism wherein device IRQs are masked while epoll
> > +triggers NAPI packet processing.
> > +
> > +While application calls to epoll_wait successfully retrieve events, the kernel will
> > +defer the IRQ suspension timer. If the kernel does not retrieve any events
> > +while busy polling (for example, because network traffic levels subsided), IRQ
> > +suspension is disabled and the IRQ mitigation strategies described above are
> > +engaged.
> > +
> > +This allows users to balance CPU consumption with network processing
> > +efficiency.
> > +
> > +To use this mechanism:
> > +
> > +  1. The per-NAPI config parameter ``irq_suspend_timeout`` should be set to the
> > +     maximum time (in nanoseconds) the application can have its IRQs
> > +     suspended. This is done using netlink, as described above. This timeout
> > +     serves as a safety mechanism to restart IRQ driver interrupt processing if
> > +     the application has stalled. This value should be chosen so that it covers
> > +     the amount of time the user application needs to process data from its
> > +     call to epoll_wait, noting that applications can control how much data
> > +     they retrieve by setting ``max_events`` when calling epoll_wait.
> > +
> > +  2. The sysfs parameter or per-NAPI config parameters ``gro_flush_timeout``
> > +     and ``napi_defer_hard_irqs`` can be set to low values. They will be used
> > +     to defer IRQs after busy poll has found no data.
> 
> Is it required to set gro_flush_timeout and napi_defer_hard_irqs when
> irq_suspend_timeout is set? Doesn't it override any smaller
> gro_flush_timeout value?

It is not required to use gro_flush_timeout or napi_defer_hard_irqs,
but if they are set they will take over when epoll finds no events.
Their usage is recommended. See the Usage section of the cover
letter for details.

While gro_flush_timeout and napi_defer_hard_irqs are not strictly
required, it is difficult for the polling-based packet delivery loop
to gain control over packet delivery.

Please see a previous email about this from the RFC for more
details:

https://lore.kernel.org/netdev/2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca/

In the cover letter, you can note the difference in performance when
gro_flush_timeout is set to different values. Note the explanation
of suspendX; each suspend case is testing a different
gro_flush_timeout.

Let us know if you have any other questions; both Martin and I are
happy to help or further explain anything that is not clear.

