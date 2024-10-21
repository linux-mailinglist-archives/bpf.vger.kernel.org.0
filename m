Return-Path: <bpf+bounces-42659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3979A6F8D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED60C283CEC
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9CA1EBA19;
	Mon, 21 Oct 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fyog8uog"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1151E884B
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528408; cv=none; b=HNTC9qsdUM9CzU4rKUrvYNnb/MbgVHQdR6hVkmv8698XswrFHAhxbN2wu19J7Hk2SqrJ5s3WA3I+JbmXBHWSwIJ2oQP1S0EuBWrF5VIYalLkLnWqOzt+1U9z94U+RhwXNJ+6oKdMFkq11BC/hudTDyHvWJB2w9+5LTdp/sHrXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528408; c=relaxed/simple;
	bh=VGX2BOoN5yaA0r3uurxYxFu+qq2+Od+7xX5jaP7gJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpnhKmE9kZmpzPS7H+t475VZRFjVeti8Ku0Yz0NC5GluznR8SZETYtsvtYNLAGqgnK1rAcai/8cGtIPDAyVpDLyjrP0nzWGfKTkZSGumHIjrxIj5/rV2Irl5MfScfzye6fVEH/xzjJTbeD82t+gK2IDfDQnQuCmoLWBJ6uSSqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fyog8uog; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3039402a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729528405; x=1730133205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rj7uTRFGZXMqC2YS9qWKHqBkcNhGSePp25EEQea4IH4=;
        b=fyog8uogkCoEEnfW34pGuFzVjVWeMVqRkLXKbTW4dFv8Db7AKw3nwI1WFhNV7xaFD9
         GYsqHE05l0QMuy6x6AiIGYmcv4tM4Cx3fvBv0fkIsMo+ZrMyz9cRL7SrPvkLSPJyqBW0
         SeCCxyizZo7gFiRMK3lHbBrLEnbcVnDNJCTPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528405; x=1730133205;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rj7uTRFGZXMqC2YS9qWKHqBkcNhGSePp25EEQea4IH4=;
        b=W2Brz8cNXIk24d1ur4l7SGRBuGkKD2znHAFiGHsp2yH1L6K5oeBr+EL3URH1fz8ZD6
         14mBrduTNBh+n3fuY6bOXWLpYN/DhP9Xw24Fuu/GrCOx60dwTQVPxEU18sm1Xc+4OiZy
         mFHSDBSb4/XzsomF3pbxpQKNdSLPyaEbTZ27vXY601Lj+mBNCuYQnXP+rhDOHwTcjk7f
         hyc8Fk9sCGlaaqeZm0PnZCoc8mxjNtEgvgW7RGcQrhJuIp6qSQhWHMSqfFF3TCVrLCzZ
         6TAfg2Lx0Jo3vxRMDxU1VKH+UPwStKpInTLAisi97P1e6Kt1IVCQ2hh4rk+doSIGgXLp
         q4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCV3IZGHO1Oephmkm/ZgZLa0MmTnSvwRfX/F6mVm001soDTSDc/weEpG+37Yor10w8yI0Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxInmX6eIK6/Q9LULlH5NMZ5r7WK3Wx/tW/5WxJnzKyPrc+ZA/g
	OEH8nK7Z4i+Rdvw1oLw6TnWeGaa5IXuGdPwwE7mPwGqo4THr1SjU/mTKtgiHYBY=
X-Google-Smtp-Source: AGHT+IE4BcYs0yAgU6r4RPKaASzilu3a+p3CUWGFBO9lYOqdLzl+wYFC2w3HC6qR2+jo3JZEXQ8WNg==
X-Received: by 2002:a05:6a21:1707:b0:1d9:2bed:c7d8 with SMTP id adf61e73a8af0-1d92c57e3c0mr16742734637.43.1729528404939;
        Mon, 21 Oct 2024 09:33:24 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d74d9sm3081883b3a.133.2024.10.21.09.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:33:24 -0700 (PDT)
Date: Mon, 21 Oct 2024 09:33:21 -0700
From: Joe Damato <jdamato@fastly.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Networking <netdev@vger.kernel.org>, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 6/6] docs: networking: Describe irq suspension
Message-ID: <ZxaCUZ5rNd86gDHG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Networking <netdev@vger.kernel.org>, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
References: <20241021015311.95468-1-jdamato@fastly.com>
 <20241021015311.95468-7-jdamato@fastly.com>
 <ZxYxqhj7cesDO8-j@archie.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxYxqhj7cesDO8-j@archie.me>

On Mon, Oct 21, 2024 at 05:49:14PM +0700, Bagas Sanjaya wrote:
> On Mon, Oct 21, 2024 at 01:53:01AM +0000, Joe Damato wrote:
> > diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
> > index dfa5d549be9c..3b43477a52ce 100644
> > --- a/Documentation/networking/napi.rst
> > +++ b/Documentation/networking/napi.rst
> > @@ -192,6 +192,28 @@ is reused to control the delay of the timer, while
> >  ``napi_defer_hard_irqs`` controls the number of consecutive empty polls
> >  before NAPI gives up and goes back to using hardware IRQs.
> >  
> > +The above parameters can also be set on a per-NAPI basis using netlink via
> > +netdev-genl. This can be done programmatically in a user application or by
> > +using a script included in the kernel source tree: ``tools/net/ynl/cli.py``.
> > +
> > +For example, using the script:
> > +
> > +.. code-block:: bash
> > +
> > +  $ kernel-source/tools/net/ynl/cli.py \
> > +            --spec Documentation/netlink/specs/netdev.yaml \
> > +            --do napi-set \
> > +            --json='{"id": 345,
> > +                     "defer-hard-irqs": 111,
> > +                     "gro-flush-timeout": 11111}'
> > +
> > +Similarly, the parameter ``irq-suspend-timeout`` can be set using netlink
> > +via netdev-genl. There is no global sysfs parameter for this value.
> 
> In JSON, both gro-flush-timeout and irq-suspend-timeout parameter
> names are written in hyphens; but the rest of the docs uses underscores
> (that is, gro_flush_timeout and irq_suspend_timeout), right?

That's right. The YAML specification uses hyphens throughout, so we
follow that convention there.

In the rest of the docs we use the name of the field which appears
in the code itself, which uses underscores.

> > +
> > +``irq_suspend_timeout`` is used to determine how long an application can
> > +completely suspend IRQs. It is used in combination with SO_PREFER_BUSY_POLL,
> > +which can be set on a per-epoll context basis with ``EPIOCSPARAMS`` ioctl.
> > +
> >  .. _poll:
> >  
> >  Busy polling
> > @@ -207,6 +229,46 @@ selected sockets or using the global ``net.core.busy_poll`` and
> >  ``net.core.busy_read`` sysctls. An io_uring API for NAPI busy polling
> >  also exists.
> >  
> > +epoll-based busy polling
> > +------------------------
> > +
> > +It is possible to trigger packet processing directly from calls to
> > +``epoll_wait``. In order to use this feature, a user application must ensure
> > +all file descriptors which are added to an epoll context have the same NAPI ID.
> > +
> > +If the application uses a dedicated acceptor thread, the application can obtain
> > +the NAPI ID of the incoming connection using SO_INCOMING_NAPI_ID and then
> > +distribute that file descriptor to a worker thread. The worker thread would add
> > +the file descriptor to its epoll context. This would ensure each worker thread
> > +has an epoll context with FDs that have the same NAPI ID.
> > +
> > +Alternatively, if the application uses SO_REUSEPORT, a bpf or ebpf program be
> > +inserted to distribute incoming connections to threads such that each thread is
> > +only given incoming connections with the same NAPI ID. Care must be taken to
> > +carefully handle cases where a system may have multiple NICs.
> > +
> > +In order to enable busy polling, there are two choices:
> > +
> > +1. ``/proc/sys/net/core/busy_poll`` can be set with a time in useconds to busy
> > +   loop waiting for events. This is a system-wide setting and will cause all
> > +   epoll-based applications to busy poll when they call epoll_wait. This may
> > +   not be desirable as many applications may not have the need to busy poll.
> > +
> > +2. Applications using recent kernels can issue an ioctl on the epoll context
> > +   file descriptor to set (``EPIOCSPARAMS``) or get (``EPIOCGPARAMS``) ``struct
> > +   epoll_params``:, which user programs can define as follows:
> > +
> > +.. code-block:: c
> > +
> > +  struct epoll_params {
> > +      uint32_t busy_poll_usecs;
> > +      uint16_t busy_poll_budget;
> > +      uint8_t prefer_busy_poll;
> > +
> > +      /* pad the struct to a multiple of 64bits */
> > +      uint8_t __pad;
> > +  };
> > +
> >  IRQ mitigation
> >  ---------------
> >  
> > @@ -222,12 +284,78 @@ Such applications can pledge to the kernel that they will perform a busy
> >  polling operation periodically, and the driver should keep the device IRQs
> >  permanently masked. This mode is enabled by using the ``SO_PREFER_BUSY_POLL``
> >  socket option. To avoid system misbehavior the pledge is revoked
> > -if ``gro_flush_timeout`` passes without any busy poll call.
> > +if ``gro_flush_timeout`` passes without any busy poll call. For epoll-based
> > +busy polling applications, the ``prefer_busy_poll`` field of ``struct
> > +epoll_params`` can be set to 1 and the ``EPIOCSPARAMS`` ioctl can be issued to
> > +enable this mode. See the above section for more details.
> >  
> >  The NAPI budget for busy polling is lower than the default (which makes
> >  sense given the low latency intention of normal busy polling). This is
> >  not the case with IRQ mitigation, however, so the budget can be adjusted
> > -with the ``SO_BUSY_POLL_BUDGET`` socket option.
> > +with the ``SO_BUSY_POLL_BUDGET`` socket option. For epoll-based busy polling
> > +applications, the ``busy_poll_budget`` field can be adjusted to the desired value
> > +in ``struct epoll_params`` and set on a specific epoll context using the ``EPIOCSPARAMS``
> > +ioctl. See the above section for more details.
> > +
> > +It is important to note that choosing a large value for ``gro_flush_timeout``
> > +will defer IRQs to allow for better batch processing, but will induce latency
> > +when the system is not fully loaded. Choosing a small value for
> > +``gro_flush_timeout`` can cause interference of the user application which is
> > +attempting to busy poll by device IRQs and softirq processing. This value
> > +should be chosen carefully with these tradeoffs in mind. epoll-based busy
> > +polling applications may be able to mitigate how much user processing happens
> > +by choosing an appropriate value for ``maxevents``.
> > +
> > +Users may want to consider an alternate approach, IRQ suspension, to help deal
> > +with these tradeoffs.
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
> > +
> > +  3. The ``prefer_busy_poll`` flag must be set to true. This can be done using
> > +     the ``EPIOCSPARAMS`` ioctl as described above.
> > +
> > +  4. The application uses epoll as described above to trigger NAPI packet
> > +     processing.
> > +
> > +As mentioned above, as long as subsequent calls to epoll_wait return events to
> > +userland, the ``irq_suspend_timeout`` is deferred and IRQs are disabled. This
> > +allows the application to process data without interference.
> > +
> > +Once a call to epoll_wait results in no events being found, IRQ suspension is
> > +automatically disabled and the ``gro_flush_timeout`` and
> > +``napi_defer_hard_irqs`` mitigation mechanisms take over.
> > +
> > +It is expected that ``irq_suspend_timeout`` will be set to a value much larger
> > +than ``gro_flush_timeout`` as ``irq_suspend_timeout`` should suspend IRQs for
> > +the duration of one userland processing cycle.
> >  
> >  .. _threaded:
> >  
> 
> The rest LGTM, thanks!

Thanks for the review.

> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> -- 
> An old man doll... just what I always wanted! - Clara



