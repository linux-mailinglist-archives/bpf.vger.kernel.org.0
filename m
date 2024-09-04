Return-Path: <bpf+bounces-38935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F096C986
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 23:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9801EB222DF
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E815573D;
	Wed,  4 Sep 2024 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTrvo4pQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D941547EB
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485179; cv=none; b=BvX4Qymdv6oBN+oqgmET1oMWKKqo/wa8KQ0A3FO8wu3QsnYDZBKjf8EVTjLrvQN18N71mf2dOKNKyAgjpvCUtsIPmIGOMu8ZUWJ2xZDcuzoCBTZr07g+X/SbLEtBqjKREAzhc3vW+7npPEm+egowh/zxOMTN/w8kvUYRYw0mV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485179; c=relaxed/simple;
	bh=JB9sxrQ5Evc1MwG22sDSfy9dec6DBfJI4WK/wjJvJeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv+nVVi2yBy1f8yx9iKQdH+qmttWC6ECIAG1NtZh9iFDeBmJBTvkHXr4VCk5wygzVG50aWh5d1+lWumBByy5UmRx0koYZhTlndiXXDioi2qWxwgyFaaMN33uqpNsOvGFwC8D/QpW+x1WcXN0ms2CLUxeJvWbeEUWP/pOH+F+u3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTrvo4pQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725485176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHg8j7v3tAkrGbKIx0peuwn2yfQMcilA5Qy8cOHgpzE=;
	b=cTrvo4pQKe7WBJVW4EIJI+8v+iGazMH/u0Z/fTx9ks2fReNuCFODXIFQrr7HL600riPW3P
	tHVTRIPUdiKJRbn5XdbRi5HqG6uGt2yhRqZ4RnZ5vTF+MRHal4sw+dL0ebbgjVIr5pszPt
	fySSL4n4MtjRusRsf1lajJJ+siIcwWo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-FLlQsjsLNhOLUbWT1G3Jug-1; Wed, 04 Sep 2024 17:26:15 -0400
X-MC-Unique: FLlQsjsLNhOLUbWT1G3Jug-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a22118ed8so1075239f.2
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 14:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725485175; x=1726089975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHg8j7v3tAkrGbKIx0peuwn2yfQMcilA5Qy8cOHgpzE=;
        b=cqioKgYSl7y80zEjkh+5Rd55MdYY3UzCoayy/Ba/7ZRiWKMtF8lOsGp51b0xJ+kOn4
         j2NNv7DEsDpFqW8P4U399XBOqNEOkQGjKLxTBYNBEyb6Lorj+ou50zXW4J1tNnOveQVS
         pmOFW3gqhRbV63ekz/Fb4qq/GWP1qiDQZQPmE9KHmlfV4QWtBgWYYYB39ZxG0BSVOo7G
         tiJY097cRvLJRL/wqY3k4AhUkXPCjgke/h5eKiyyrpl6DnuV4loVBBSDvAj/wUigggIJ
         MRg0grBOrB9cUp/JpuOPHs3upp9dWiW5I6bkwAoCh9wJ3tZlfB/IQX/aQLB6ZPAQHpEf
         m95A==
X-Forwarded-Encrypted: i=1; AJvYcCUwWBm/tTTOCw0cSO5Z/Bc6Sv7ZXKMTX7imMkQpEXrhm7UL3XrXLdXiNDFAojOhNYikZA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Weznqm+KTsShXZW64d6UBXwuBi80rZu57LsxFo4eeOh7xmvi
	o3pxtj+7yujo/7OHnNy/OfmdQLzs1oZZ4MNOJ2HmsRie3/R3rbXkrAB+IriyUmrFgRKHbW4hv7O
	saLC/Y58LVJkbmkMhPfUa+YimIFZfpi7MiCmAa0y588JmgNkZWA==
X-Received: by 2002:a05:6602:6307:b0:82a:4419:6156 with SMTP id ca18e2360f4ac-82a44196334mr1412310339f.14.1725485174776;
        Wed, 04 Sep 2024 14:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS6tEkpDev46DvGWy32ljDhFfJQqROmsOKpChFn5k1kOh3E+WhWO8dKQaAJANfqBFpAGf7bQ==
X-Received: by 2002:a05:6602:6307:b0:82a:4419:6156 with SMTP id ca18e2360f4ac-82a44196334mr1412307439f.14.1725485174374;
        Wed, 04 Sep 2024 14:26:14 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a2f0d9fsm379507539f.7.2024.09.04.14.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 14:26:14 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:26:11 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jose Abreu <joabreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Sneh Shah <quic_snehshah@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next v4 00/14] net: stmmac: convert stmmac "pcs"
 to phylink
Message-ID: <ce42fknbcp2jxzzcx2fdjs72d3kgw2psbbasgz5zvwcvu26usi@4m4wpvo5sa77>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
 <rq2wbrm2q3bizgxcnl6kmdiycpldjl6rllsqqgpzfhsfodnd3o@ymdfbxq2gj5j>
 <ZrM8g5KoaBi5L00b@shell.armlinux.org.uk>
 <d3yg5ammwevvcgs3zsy2fdvc45pce5ma2yujz7z2wp3vvpaim6@wgh6bb27c5tb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3yg5ammwevvcgs3zsy2fdvc45pce5ma2yujz7z2wp3vvpaim6@wgh6bb27c5tb>

On Thu, Aug 08, 2024 at 11:42:53PM GMT, Serge Semin wrote:
> On Wed, Aug 07, 2024 at 10:21:07AM +0100, Russell King (Oracle) wrote:
> > On Tue, Aug 06, 2024 at 09:56:04PM +0300, Serge Semin wrote:
> > > Hi Russell
> > > 

...

> 
> > I guessed that you would dig your heals in over this, and want to do
> > it your own way despite all the points I raised against your patch
> > series on my previous posting arguing against much of this.
> > 
> > So, at this point I give up with this patch series - clearly there is
> > no room for discussion about the way forward, and you want to do it
> > your way no matter what.
> 
> I actually thought that in general the approach implemented in my
> patches didn't meet much dislikes from your side. Just several notes
> which could be easily fixed in the next revisions.
> 
> Anyway thanks for understanding. I'll wait for your series to be
> merged in. Then I'll submit my patch set based on top of it (of course
> taking into account all the notes raised by you back then).
> 

Hmmm, I'll poke the bears :)

Any chance this series will be rebased and sent out again? I
really liked the direction of this and it seems a waste to end it at a
stalemate here despite some differing opinions on the design and
possible future changes.

I think we're all in agreement that stmmac's current PCS usage behind
phylink's back is not good, and this is a massive improvement.

Thanks,
Andrew


