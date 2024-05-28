Return-Path: <bpf+bounces-30716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794288D1B13
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E2E282D03
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31316D9B8;
	Tue, 28 May 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez5Wmyq2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19CF13AD30;
	Tue, 28 May 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899023; cv=none; b=PF6U8MLilJZxiAWAgl7Z/RhbIIjwxsUSIkMzmZqZtHB9LgCIFbV80FsPCFVnw8WzMuJ91HfBi0vg+CIQLIrBPN4lqfikDB4EwjDl2QWZhT53dvyOUDpH1+Q75793BnAz5xYaNt9s+9l+8dIttcBbkZCJGmkseNW7gEtJ2S+yD+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899023; c=relaxed/simple;
	bh=2NXpz5mcHjtgnf3Pi3Kz583uD1DOKBbm6BYbngGKYxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHqbaSf9n+fD5o5BzLUFyfZ5a0yf8DUhnv5GVzUqnz7wsZRrupg64asZ6ceD0oOUY7464sh2HcTVXgdcU6XMLzTFiFPtDXYGhtVqD8c/QWIlvmd1YO7jODPZH8n2PFuCZrpCegSOGhto/vwhyZHDnKKATgJ4dlFLoFwCQKuRcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez5Wmyq2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so7656921fa.2;
        Tue, 28 May 2024 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716899019; x=1717503819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ6Bwt6k8qoK6vNlq9lM1iWxCwSqpepkOmDB+x80ufY=;
        b=ez5Wmyq2vGh1z++0rEmA+zbkFycIwd3Z+xPFEYZdOaT2/BjLCIgoMKvlPRuEfDEtx1
         hQnddwcybtkTmyVOu7DDPtBmYhOdUBkCI6SEsxv5VohTWmNPiSoynB3Qo01XGEZjwrU5
         nKOZ8yrN19QIguv2a78Xhrsv9/9Vb4rETFNwYR+dzaqFEw0RrJRND1UlFrjp0JsCpNt0
         NmVJdPQPeDHHFoEyTIAFQNUNqhJPN6tDYU2KbVZXMX8oWO45T2pObxWKodeCin2C31RX
         U69PXXdKICx+CtjGjEj7BQ1hkF2yMVEnByytXf76eQJ3bjwPiQmqe8imSQ5sq913zXDE
         He4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899019; x=1717503819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ6Bwt6k8qoK6vNlq9lM1iWxCwSqpepkOmDB+x80ufY=;
        b=gQHQnVlTV102h6iZICZ0Zn+XZYlr7QQZDQAoF00VsxjmXfHc8I64PpCCQ3P8lZzhiz
         bjQeuObipv7v0HNlvqa9ilwPniQ5aR0D1/Y9+5tmmJ9vnO44ogKnxNqKx4HQxDhxx3t6
         hs3WeleslZeWfBbGMs6vjee0wvpwH3cClUXik6Z4w9AAWojS4l2gL3/zsvOQnaYmb5QH
         cBJWfF+4WoJeRsBIHkLTw53GkCvD26mhHuMstKL8JVcWECASOk+FXE5FlnroLvHGSMDk
         oh+lS6cGf+lA5itVePntRzTDLioFXxnMYCQbKBbkXpOOzdHE6pAggVJ+D9xkKIsFbjCk
         AncQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW7xf6yIUFflGGCDouHnlPZw4dvrn2F/C1xc0tO+YDWyhTj0X/+6cwHNoUK98ub9c+fFmap1/ZT88gXhK2McbRWmAqiKJFFQFhjglmqJlVSdhXjcMEnMXksvMzCMxt5JEMNphwnUhZDONyFZewuDFps+UiJOS3nfVV
X-Gm-Message-State: AOJu0YyCJNMeB932Avty1R1bLivTYRd6YWpZNS/9FMEYHlWlY3XY553n
	zXpcdfSwXR7Su5gdK1JjQJWlwzF+/aqK4kdQ7mxAC7d4vCZOV+h0
X-Google-Smtp-Source: AGHT+IHz9ffk7NLOvFZgMKCrkgUQ1nrZnBgj6Z2qyuDmAybj85WSiQ54kGWQnsIP/wPIZZp0KHBKgA==
X-Received: by 2002:a2e:8203:0:b0:2e9:821a:82fd with SMTP id 38308e7fff4ca-2e9821a83d7mr20353621fa.27.1716899018827;
        Tue, 28 May 2024 05:23:38 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e9838eb29csm3340441fa.115.2024.05.28.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:23:38 -0700 (PDT)
Date: Tue, 28 May 2024 15:23:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] net: stmmac: Drop TBI/RTBI PCS flags
Message-ID: <f73mceuqpbj7nwmefahhwacpbol6meomywupvxw5abpojbpqie@hhrg3mgfql24>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-3-fancer.lancer@gmail.com>
 <ZlWwiQxvvAKd39gN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlWwiQxvvAKd39gN@shell.armlinux.org.uk>

On Tue, May 28, 2024 at 11:23:05AM +0100, Russell King (Oracle) wrote:
> On Sat, May 25, 2024 at 12:02:59AM +0300, Serge Semin wrote:
> > First of all the flags are never set by any of the driver parts. If nobody
> > have them set then the respective statements will always have the same
> > result. Thus the statements can be simplified or even dropped with no risk
> > to break things.
> > 
> > Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
> > registration will be bypassed. Why? It really seems weird. It's perfectly
> > fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
> > interface.
> > 
> > Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
> > simplifying the driver code.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> I think this patch can come first in the series, along with another
> few patches that remove stuff. Any objection?

No objection.

-Serge(y)

> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

