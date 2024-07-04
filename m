Return-Path: <bpf+bounces-33858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7D92711D
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2FD1C22F57
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 08:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E61A0B02;
	Thu,  4 Jul 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AP4zp7r/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmIMVaSo"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C97E57C
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080041; cv=none; b=enZaMSMZ23KLrAfy9lT5KcCAxJoXPOEWzMu0qxQwkl3CDzed36el1zFMUHUeCfvU/aOuMu2qJxYErKcOn/e+dQZJCvo6TXx7M/UPKkQCEILVL5N2rOtKmIhMLLj/wRFNa/ynF6lgSQuwDiQGsj9m12wT1dp3rtLAKX+hQfEHJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080041; c=relaxed/simple;
	bh=Q8zzFi4MReS32svSMriO70/iKqluPhD656eUEJjn6Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE2yqdUElT2b1o1pNXIVriSe/mCuhdcbGbNlt9fvy2QVy5+4zwuWSrjVEjy9gjU6GnXz0BAIBNBxNDOtsIKViJvlQLHqbr7SRBta2vcGfHXtA6kav2MJzKTEtkw+VZRvfWat+tHhmRdiqoTGCOTuKwniFvK2UJCDu4mpon7+8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AP4zp7r/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fmIMVaSo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Jul 2024 10:00:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720080035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4x9YgAHmjHdXtIsxoDhUClIwA5bq4kUudNZ0CcJXYU=;
	b=AP4zp7r/Y1nAvglG/ed/hHLcwB37bKRcSqBH6jfy6xLBao1hfZG0iqJrmxiPfEFSc0u+XR
	v57/yXwFpPrxnHPgmaHbK/Rh1RAv+PnvZfb4sFWK9V9FoIRfar0p5HDprkDLn35p+gtgjz
	LiKSMAPkuz1TuQm/n1Q4kls2DVT40lcJW4tsH7txsIBuD3YHwL84+z8/nAp/VttKS7k76i
	rFw+Jl7pVjjolNXcfZg8WySrUMmVyDDVyH2z27TkyMswq6KtYbPtb/B+3khiDHw0OJtZCS
	jen/jLw71d7X8fbfkY+jcP4YNUOFGpxPX9CkthQcsjjKhbkbyC5P+bc/rJPuRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720080035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4x9YgAHmjHdXtIsxoDhUClIwA5bq4kUudNZ0CcJXYU=;
	b=fmIMVaSo5tCJhvd6sb0P3c1kDM3W3it/wjS5OiAn6twafWfkHsczGxpxcjRISu946fjB57
	hAoHS+eXa2bY6LBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add casts to keep sparse quiet.
Message-ID: <20240704080033.eaXWEjdS@linutronix.de>
References: <20240702142542.179753-1-bigeasy@linutronix.de>
 <20240702142542.179753-2-bigeasy@linutronix.de>
 <CAADnVQKPLGKWT9Dx750CcR6B53cw1cW_cihQtONwBmHqrCRjDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQKPLGKWT9Dx750CcR6B53cw1cW_cihQtONwBmHqrCRjDA@mail.gmail.com>

On 2024-07-03 14:39:16 [-0700], Alexei Starovoitov wrote:
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 25ea393cf084b..f45b03706e4e9 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6290,12 +6290,12 @@ struct bpf_tunnel_key {
> >   */
> >  struct bpf_xfrm_state {
> >         __u32 reqid;
> > -       __u32 spi;      /* Stored in network byte order */
> > +       __be32 spi;     /* Stored in network byte order */
> >         __u16 family;
> >         __u16 ext;      /* Padding, future use. */
> >         union {
> > -               __u32 remote_ipv4;      /* Stored in network byte order */
> > -               __u32 remote_ipv6[4];   /* Stored in network byte order */
> > +               __be32 remote_ipv4;     /* Stored in network byte order */
> > +               __be32 remote_ipv6[4];  /* Stored in network byte order */
> >         };
> >  };
> 
> I don't think we should be changing uapi because of sparse.
> I would ignore the warnings.

There are other struct member within this bpf.h which use __be32 so it
is known to userland (in terms of the compiler won't complain about an
unknown type due to missing include). The type is essentially the same
since the __bitwise attribute is empty except for sparse (which defines
__CHECKER_).
Therefore I wouldn't say this changes the uapi in an incompatible way.

Sebastian

