Return-Path: <bpf+bounces-27948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BE8B3D7D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0441F25316
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAD15B55F;
	Fri, 26 Apr 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpRiJfSV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1811598F5;
	Fri, 26 Apr 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150890; cv=none; b=uuLgPrq15ur/WH9lllWY0dIcNih4KxE7nEruca+gMk6aibJ3pdDgIglTRHT4xqGHY8wI+rNRDT6phrGnAL4kTL6ow1rvfwD1S79jjGfQqaBtNBDz2fUGJZMBe9/8dn2Kw5FsG3g1ieT9qptx4b5lNqH6A6zvyMmI4tyk6dGx+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150890; c=relaxed/simple;
	bh=cNkmau+vywNzy8mqG0zMAbEK0MlUjcRhEGqQHIaW/AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwk82JuZdO5mk3OH9Z7UMQvI8FHIZJKD9zvaFFiLSH1eSabpLMafRrTIkOafbjrYigE5x628JWEbfNxO8Y8n/XYDGUGPZt9WodkMtJVCveiueum2HV9NaTppDsZBkFBDoLGotT7x4pb2cWLaGu0+/Vw2OP+12L7wo+ZndgT8rnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpRiJfSV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2af71daeec1so624513a91.0;
        Fri, 26 Apr 2024 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714150888; x=1714755688; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7usDOprlF0r0X4lUDaDQW+qbxy362dPjy11nZWPpOJM=;
        b=DpRiJfSVMQsuMoySQcMW+KpoZK3v3IGm972SOe7BKT8KSJoR34LebsHEGk9Gjneo3N
         cCOtKtxLPrW+2ZA0tbphL+dfeW5GRDIZOLW+uh1e8UTrzrwVNRjkSOGl310PxW6yrxLS
         4o6K24TJnhi0TACnwAm1tCo57gnZ8W0wuUzs9sZ+h4kOzYjdGK5n6Tc9OZp4wZgRSRhr
         p8vqT57TnRLFNwAjq6oiEerGyQUZA7mEdFJn7/3tJKqhohk+bNyI/SubZmja7B4dGMZA
         fC8NnOdl1SWlenhjAVOLeZjWZz6IRKvevNKR8wopvk1KmfjXUxjiD2fvUs81sOjIODgB
         8CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150888; x=1714755688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7usDOprlF0r0X4lUDaDQW+qbxy362dPjy11nZWPpOJM=;
        b=Dfv5PtxrVPuGLXJKUtUMNvrk85vYQMQ2KVjHNXySrN3dQ5OKp6VBqq50fvtq7rLWrQ
         nAHCJpVUwwNblgBnkQavJcMF6xy538XTDoVKeLaBaaWx4iebFF+Ad28UDAm2XAkxFiQc
         JcilyPPEJYb/rhl1MP7P79L5gA7GV78/hy4ck8Wq+w54e9OwWPocMSjmJYEKfIqp4dW5
         FpcoOGOikIlfHBwNZ7ndxGPIeFLJVsue9xnOUNXWS4J1UbL7KQic+3ee5RZ1T7ImqPko
         Jj5rDYrmD0bBL3sgcnAkKhNF77vitkjpK2b+LTzbt7qnnPJY9yZct/nNUt1PLHgVPHzb
         GIww==
X-Forwarded-Encrypted: i=1; AJvYcCVjLPPOkbnMNEVE1dVstMy4WPhD8/sLUmACui7FaFnS2qCPqnkIfe36UReIky2oVq4TDZVL6vl2va/neCEdeRaA7mOGewWqPdF/ApnxoWbiUIU3I6jzHuZXFUBsdWxaj5dM9Qxe3VI5jOzvibjWxq8yMwRsVu2HjQY9
X-Gm-Message-State: AOJu0YxrPueAKY9jF1bbHHWrITewNourrMktAdjcttLNQ37JFyO66qqa
	lyIb6dX1i4pFa21pKVXRjE5N+axVWiTfZnRH4FHAWpph4izX9sFWpmqwOmQU
X-Google-Smtp-Source: AGHT+IESGyjLNOkbXq8I9S38SiHy0c/8WwKj54ERKLE9U1/0jRSqfrV7UJtLAfgyqC5Ls4scbGJHIA==
X-Received: by 2002:a05:6a00:8b87:b0:6e9:ca7b:c150 with SMTP id ig7-20020a056a008b8700b006e9ca7bc150mr3883378pfb.3.1714150886677;
        Fri, 26 Apr 2024 10:01:26 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:751f:9418:61f4:229e])
        by smtp.gmail.com with ESMTPSA id fv3-20020a056a00618300b006eb3c3db4afsm15036186pfb.186.2024.04.26.10.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:01:26 -0700 (PDT)
Date: Sat, 27 Apr 2024 01:01:21 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tcp_bbr: replace lambda expression with bitwise
 operation for bit flip
Message-ID: <Zivd4agQ8D6rUKvt@vaxr-BM6660-BM6360>
References: <20240426152011.37069-1-richard120310@gmail.com>
 <CANn89iKenW5SxMGm753z8eawg+7drUz7oZcTR06habjcFmdqVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKenW5SxMGm753z8eawg+7drUz7oZcTR06habjcFmdqVg@mail.gmail.com>

On Fri, Apr 26, 2024 at 05:32:57PM +0200, Eric Dumazet wrote:
> On Fri, Apr 26, 2024 at 5:20 PM I Hsin Cheng <richard120310@gmail.com> wrote:
> >
> > In the origin implementation in function bbr_update_ack_aggregation(),
> > we utilize a lambda expression to flip the bit value of
> > bbr->extra_acked_win_idx. Since the data type of
> > bbr->extra_acked_win_idx is simply a single bit, we are actually trying
> > to perform a bit flip operation, under the fact we can simply perform a
> > bitwise not operation on bbr->extra_acked_win_idx.
> >
> > This way we can elimate the need of possible branches which generate by
> > the lambda function, they could result in branch misses sometimes.
> > Perform a bitwise not operation is more straightforward and wouldn't
> > generate branches.
> >
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > ---
> >  net/ipv4/tcp_bbr.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> > index 146792cd2..75068ba25 100644
> > --- a/net/ipv4/tcp_bbr.c
> > +++ b/net/ipv4/tcp_bbr.c
> > @@ -829,8 +829,7 @@ static void bbr_update_ack_aggregation(struct sock *sk,
> >                                                 bbr->extra_acked_win_rtts + 1);
> >                 if (bbr->extra_acked_win_rtts >= bbr_extra_acked_win_rtts) {
> >                         bbr->extra_acked_win_rtts = 0;
> > -                       bbr->extra_acked_win_idx = bbr->extra_acked_win_idx ?
> > -                                                  0 : 1;
> > +                       bbr->extra_acked_win_idx = ~(bbr->extra_acked_win_idx);
> >                         bbr->extra_acked[bbr->extra_acked_win_idx] = 0;
> >                 }
> >         }
> 
> Or
> 
> bbr->extra_acked_win_idx ^= 1;
> 
> Note that C compilers generate the same code, for the 3 variants.
> 
> They do not generate branches for something simple like this.

I see, thanks for your explanation.
I thought the compilers behavior might alters due to different 
architecture or different compilers.
So would you recommend on the proposed changes or we should stick to
 the original implementation? 
Personally I think my version or your proposed change are both more 
understandable and elegant than the lambda expression.



