Return-Path: <bpf+bounces-66599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72346B37494
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 23:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC391B25D81
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BB8299943;
	Tue, 26 Aug 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/QGV1+y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FBC72605;
	Tue, 26 Aug 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245504; cv=none; b=Mte/mELFE/0YV5muKWNIgMbFVuI1CeBpNR50/Hk2u2IkHWUnk4THzXLRFqtqPH7+x+ryj81Cz9jSw3mXc5AfD9AXSY7tEntJF2qvEf3fEqKWCOVITp0qt73XKF2QXuxA+Qs20HBO4yG8GM0xATVnc4jkVwii/+/vh8RsNIqQtqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245504; c=relaxed/simple;
	bh=7og0ebwTITtMBLgXjZzovotMGTTEhC8mG8IL7WcTZgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFevGSkU4sKJ63Jzrk+95ow12xmM4hTziaDQHnEo2DklZGRU2xUgkppDrv1eRHaWQrW4N6+eQfxNHFXEFvM3RwOAPcu4mTEU7wSIyEx2vlHUCEEtqIHwgjgQt9UaMqn5JJKIYP0h44yv5PBaIw651GFEebBVzXGxgotp7ftp0es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/QGV1+y; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5390240b3a.1;
        Tue, 26 Aug 2025 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756245503; x=1756850303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k5nnO3x/znO+lzylBCVNGWC7wrma/MeDdlI5AhhD234=;
        b=R/QGV1+yHUDubA/dlwBMZk1I7F4MYB/R0mIJxcjNzpqCU3+U91K1y1UGJWuIuR3pMf
         rBBVX5KaQNbXBmy7LyO0MfzZ/BqVJy3kWaP+5oJ+SNmK584On9VPLgVrJXXdaE/cuUQr
         iwqBcguTTB8yqW+4rSQpob+m2jK5neTTgEIDt7FiKxOueRKTvxUMoq9421Dv19/XMXKo
         QbXLbMkkoAGVvswHAAGE1IAcl1MK7EfKzFLmz6NXtsVrIEs35yglpn73qBBDa5OIkMDv
         gwcpTbI28cGjNHLxvCqmOSA1Js9mU9vXW7byHBMbFA3SvoBZ2/9dh2HfI7RnsPAtj2fy
         xVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756245503; x=1756850303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5nnO3x/znO+lzylBCVNGWC7wrma/MeDdlI5AhhD234=;
        b=iKA2iAnxaTIFfzwbcc/xhOGMqZFJFLr3At2ikWNdqQSToM3TqqQXdTOlAu6l82TzH4
         GTKEuw9lUDLXVo1b1UVXa7VG41K83jg/keK/aat80qWjOMGQQ+Q204vf49hvPQLUScpW
         WNg6BkmxIH2vNWdqBF0DTKUmOQhaPGTlPWpggMx8wSJ8dQicO/k/TofWJsikvFn5Ql5C
         /Fz+fFhFeGCDAcC+ajzSlrVgprTG4juA2LLznmz65S8/ZzIEPFPrlMkvvdGXZOVh0E8Y
         7A4bPNmsaUrJL4qRvcHQ1slwX6EIaL6vrIF3GALkVoUTcgMXFCTjpmJShHIzNUw5OXgr
         VDCw==
X-Forwarded-Encrypted: i=1; AJvYcCVicmy//OR4Xj4wUXuP6O+4SxdRy4JOmJOTBMcs9xw8wI0jlaSNDqM6CH7POG3/WmRfADnwd50F@vger.kernel.org, AJvYcCXx1AVRghvxKlOmzhtFdczH5AZGDrbmJBjIm4T/ZXoi4XJQ+5UgCiLdUilHpPQE8tXtB2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VeV0qxI1kr8Qz5yzZCsPsR5yCUphGkaua9u+0PeyHeTeM7jM
	/69Jd4ZM0k/Ckb7BygvBTV3/dNTAx7F799Xhj3UIu83ElFN8mDHyJsE=
X-Gm-Gg: ASbGncvuD+SDbEYxgadRbrcgwxCF7+x4QsQIptpDfgjd1XJS+WIebwPKuFlUAsovlTD
	6aQhGdgdRthxEnc1mNNkItOH1aRM78xBANcoP46JK94nWFz2MGD3XLPkUTbNfy/DLY71YTzcNTB
	rEGsdoSRhz185gryxk0Qp47rSGeTUvJ2sD+jufl3ordHjoEURzj5Z3cN2VQ8s0F+giGtvoR1GVB
	DWw3goFiFFwtlR/WG24XXXwZ5Duj6YXQWiDHTO5t4tlngXZT1IAX4x9ghgsyBxSwG2NwcC6mYQA
	bp/i6Yy/TMinTXlovqA9wChRoiuQKZxBVblkmD9cC6PQwitc28dbGB1agGpe0CkOv7qQ98Wa/cX
	P3an6muzj0dHarbswG7+7oJTBaPJLQHKgrxaPxSbZgvasnurntndVXg7QZS/cWiB0MmmAb2Z2Ks
	cpUa6ocGOp4V5aWAV4hVqp/GTPq1R9kRgFvuMijVL/TVPSxXQ2YfMfJH4mlGMtOqCDJvymX+tbu
	xBk
X-Google-Smtp-Source: AGHT+IGqHWsIihV89DVEObbsVPW7ishIdg+HsllpSsJhPdnfxoRVuM8uybMcvOlIZzkQPV0PL1Gujg==
X-Received: by 2002:a05:6a21:99aa:b0:21a:ecf5:ea71 with SMTP id adf61e73a8af0-24340b5b4cemr25802196637.15.1756245502773;
        Tue, 26 Aug 2025 14:58:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3275c05e1a6sm724812a91.1.2025.08.26.14.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:58:22 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:58:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for
 BPF_CGROUP_INET_SOCK_CREATE.
Message-ID: <aK4t_RfpophZTFWI@mini-arch>
References: <20250826183940.3310118-1-kuniyu@google.com>
 <20250826183940.3310118-3-kuniyu@google.com>
 <aK4g640zGakSxlD9@mini-arch>
 <CAAVpQUARxRTbmFiNE5GuO03qQAikddhT=BLcTWJVHvwK_Yq=Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUARxRTbmFiNE5GuO03qQAikddhT=BLcTWJVHvwK_Yq=Pg@mail.gmail.com>

On 08/26, Kuniyuki Iwashima wrote:
> On Tue, Aug 26, 2025 at 2:02 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 08/26, Kuniyuki Iwashima wrote:
> > > We will store a flag in sk->sk_memcg by bpf_setsockopt() during
> > > socket() or before sk->sk_memcg is set in accept().
> > >
> > > BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
> > > that passes a pointer to struct sock to the bpf prog as void *ctx.
> > >
> > > But there are no bpf_func_proto for bpf_setsockopt() that receives
> > > the ctx as a pointer to struct sock.
> > >
> > > Let's add a new bpf_setsockopt() variant for BPF_CGROUP_INET_SOCK_CREATE.
> >
> > [..]
> >
> > > Note that inet_create() is not under lock_sock().
> >
> > Does anything prevent us from grabbing the lock before running
> > SOCK_CREATE progs? This is not the fast path, so should be ok?
> > Will make it easier to reason about socket options (where all paths
> > are locked). We do similar things for sock_addr progs in
> > BPF_CGROUP_RUN_SA_PROG_LOCK.
> 
> We can do that, but the reasoning here is exactly same with
> how we allow unlocked setsockopt() for LSM hooks.  Also, SA_
> prog actually needs lock_sock() to prevent sk->{addr fields} from
> being changed concurrently.
> 
> ---8<---
> /* List of LSM hooks that trigger while the socket is _not_ locked,
>  * but it's ok to call bpf_{g,s}etsockopt because the socket is still
>  * in the early init phase.
>  */
> BTF_SET_START(bpf_lsm_unlocked_sockopt_hooks)
> #ifdef CONFIG_SECURITY_NETWORK
> BTF_ID(func, bpf_lsm_socket_post_create)
> BTF_ID(func, bpf_lsm_socket_socketpair)
> #endif
> BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
> ---8<---

Good point, I forgot about these :-(

