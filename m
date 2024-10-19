Return-Path: <bpf+bounces-42495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B01F9A4AC2
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 02:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EC32844E6
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB371990CD;
	Sat, 19 Oct 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfUIGGy9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280820E31C;
	Sat, 19 Oct 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729299072; cv=none; b=C0AwNNsEXR7oH85yZlLaKuY2r8nM6azOKoX/3NDDENx74uJ4Ce/9I4Z0lE8YfecULTRxVIwlGVVXJxm8hV6zuC4VrrjAIekDUPaBA4u5O4PRTGwimxguKA0ZcTtFPMKeuJAiVGjRGwJVa1mkrJ8V5qjNMCFFi0HoLlx/UcSvP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729299072; c=relaxed/simple;
	bh=MD5kkzyjVlGnny+gqQDDv1+RFxFDxvzSYdWohCFC5o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnwPpz23hgFWe7QZRy0Ab/NxN9azNsya7h3F4w2IpDulb7RIo8U9hpB7vW5HAUZn9JGt/tS3IR5W0E9LG1oQ4cddgN62h1abYsJqr2cvGGerrMORkdhy3pfazHpgQ3ICh+OeZsJdeci2bsBIVuJIWc+VJqmkCfke/dSG11uWn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfUIGGy9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c767a9c50so26156145ad.1;
        Fri, 18 Oct 2024 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729299069; x=1729903869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FL67X8g8ez0faSQl99ijSyvjCoKB8ojvzNqVtmVcfiE=;
        b=mfUIGGy9bR9aKPRo55Evj5Y0+Syw/iJz2/yhdhO+b63hHvIHvYDxUA4Ui3G3+UmBHF
         J1Iz8GUcEliAjAfmLwQqHL2mZKvgiWNxOcsfxrku6y4ZsOmRCTzsXz6nGHpxuZ1Vq1d6
         XUyGqsxaFwmAjY017JagKBpd9uY7PRmIupDMo59mPAYkYPwIFcIGR5ERu6qb2ytDIkOn
         Rvn6t8PFzt3PXkGZC405xgF0bzEfEyegSPqg+Zh3TrhApgKjaYqi1v4Rfd9KUMnVxAbh
         l+PI2T9OQ2LH6XTlWvnIOXHa3/Blz+X/eH6rNMkoIt6k5ijcibNIUC8v8Uvks2N8/9Gn
         Yh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729299069; x=1729903869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FL67X8g8ez0faSQl99ijSyvjCoKB8ojvzNqVtmVcfiE=;
        b=FQOxsZXfjPWufy8q3dUAS65HKcItAmG2JFBh4cmyFXbFNZp5+lvVyIPwthbejeQFiw
         cWFyktYcTc9+qT2DQlebuvo0xe/t3zG2HK+eYex6sH/3PfFargT6WCZnKCU3gKc8JWI/
         AJDaq/PXNQfgHvGOcjfx9NTb1/eFBkrH4t3qIKwZPyINODVxBBc4tw4HsDot8lt3h5Pq
         t82sBsLBeeyi6bofsVUM65cBxvBwzHI8agqeTVEGdqj9NmuiLxWL41gbHyGhdBfJskpF
         ATQDx5tCSnlYLLcTQcWyYNR/xyeQOVNCcIW4+A0nGhUR2OJMO7rvzqL+IQ3SUQng/6Fs
         TP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/LyoaH2bGNe0/sgXvMjjQUZXMFCVSpf5H1z2ffLdnBxrPtK6CuP/FgeC601IUWz6WnzsYzi89@vger.kernel.org, AJvYcCWQUCtrD+3m+iNCrq9EZKoG1qVniZX9lo2GwnAYHHLSqA+sNWKv0YC8Ziux0v6UHKh2pO8=@vger.kernel.org, AJvYcCWeyTMY2Y5TqnS3mTOXrQOFVZ9e/X1inVMrFjF5lHTK7pvmPjlJu+A89o4QO4ZNW+kDVR01MQowo4QV@vger.kernel.org, AJvYcCWmNlobGS9L1UAKuZWbmAEnYr9fVySSPLJJNXSE27qkT5VPQAngw/acEAS6EGcCx3WAjPBsI0xcFpYe9gCZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8ZRLsAmfKnPa+OB5/ptLDGVes3EN0HmxK16SVbZXOaV+SqU7
	8nvJ8+uen9u9+Qy/EWIGTZKOI3hWO7vIi1nwpajtH5i4e+AAGiwy
X-Google-Smtp-Source: AGHT+IEiV0cgKjHKe/2kpiCIm2aoibAX3dlE1cBZR9js0twjZlqgxio5Kuo8jbhyx35sK6LlhoZUUA==
X-Received: by 2002:a17:903:192:b0:20b:9c8c:e9f3 with SMTP id d9443c01a7336-20e5a7663c2mr41358935ad.14.1729299069456;
        Fri, 18 Oct 2024 17:51:09 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc28b869sm1967300a12.68.2024.10.18.17.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 17:51:09 -0700 (PDT)
Date: Sat, 19 Oct 2024 00:51:00 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv2 net-next 2/3] bonding: use correct return value
Message-ID: <ZxMCdP1X-h9qyU0u@fedora>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-3-liuhangbin@gmail.com>
 <878qumzszs.fsf@toke.dk>
 <ZxGv2s4bl5VQV4g-@fedora>
 <20241018094139.GD1697@kernel.org>
 <87o73hy7hh.fsf@toke.dk>
 <20241018142104.GP1697@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018142104.GP1697@kernel.org>

On Fri, Oct 18, 2024 at 03:21:04PM +0100, Simon Horman wrote:
> On Fri, Oct 18, 2024 at 01:29:30PM +0200, Toke Høiland-Jørgensen wrote:
> > Simon Horman <horms@kernel.org> writes:
> > 
> > > On Fri, Oct 18, 2024 at 12:46:18AM +0000, Hangbin Liu wrote:
> > >> On Thu, Oct 17, 2024 at 04:47:19PM +0200, Toke Høiland-Jørgensen wrote:
> > >> > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > >> > > index f0f76b6ac8be..6887a867fe8b 100644
> > >> > > --- a/drivers/net/bonding/bond_main.c
> > >> > > +++ b/drivers/net/bonding/bond_main.c
> > >> > > @@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> > >> > >  		if (dev_xdp_prog_count(slave_dev) > 0) {
> > >> > >  			SLAVE_NL_ERR(dev, slave_dev, extack,
> > >> > >  				     "Slave has XDP program loaded, please unload before enslaving");
> > >> > > -			err = -EOPNOTSUPP;
> > >> > > +			err = -EEXIST;
> > >> > 
> > >> > Hmm, this has been UAPI since kernel 5.15, so can we really change it
> > >> > now? What's the purpose of changing it, anyway?
> > >> 
> > >> I just think it should return EXIST when the error is "Slave has XDP program
> > >> loaded". No special reason. If all others think we should not change it, I
> > >> can drop this patch.
> > >
> > > Hi Toke,
> > >
> > > Could you add some colour to what extent user's might rely on this error code?
> > >
> > > Basically I think that if they do then we shouldn't change this.
> > 
> > Well, that's the trouble with UAPI, we don't really know. In libxdp and
> > xdp-tools we look at the return code to provide a nicer error message,
> > like:
> > 
> > https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L615
> > 
> > and as a signal to fall back to loading the programme without a dispatcher:
> > 
> > https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L1824
> > 
> > Both of these cases would be unaffected (or even improved) by this
> > patch, so in that sense I don't have a concrete objection, just a
> > general "userspace may react to this". In other words, my concern is
> > more of a general "we don't know, so this seems risky". If any of you
> > have more information about how bonding XDP is generally used, that may
> > help get a better idea of this?
> 
> Yes, that is the trouble with the UAPI. I was hoping you might be able to
> provide the clarity you ask for above. But alas, things are as clear as
> mud.
> 
> In lieu of more information I suggest caution and dropping this change for
> now.

OK, I will drop this one.

Thanks
Hangbin

