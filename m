Return-Path: <bpf+bounces-36372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F4494792C
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DB41C20E46
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3135D1547D8;
	Mon,  5 Aug 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HZrBhC2J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329114F122
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852874; cv=none; b=pESTAUGZR4/DV64MJRDFB4xOm8Uc6eWjLYu+IB6S9Q4GXcBycN2KPdlCBhiyurxI71nyPQcJftqGwUvUgAJR4cd+ZvmwAufOPG554DbVAWKAj/0B7epV2IPsOSbHQhgAsZEl08yWPiLhI/xgTc0IftUinLtfnY/r2tCjG/UTB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852874; c=relaxed/simple;
	bh=KUTXv/4BMVQwGdjDsbktTy1NxZw7vMmfKE8tNFfq/Qo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8Fz4SPduh1Q7Fw5WF4som+6J+y1CFVkhTkiv9N9hM2sG/pG3b/9x/CkUYDb2XFIZVA0Xq6kMIQMmqmVrii+MehjMrSAdN6FbScrLH8rMOGnqk8AEM6S24phtwdB6W2WEdLwy7Ii/5KIMMcv7tK/sfD2xuCTmcdvsHTj5XFGV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HZrBhC2J; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f04150796so15912673e87.3
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722852871; x=1723457671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUTXv/4BMVQwGdjDsbktTy1NxZw7vMmfKE8tNFfq/Qo=;
        b=HZrBhC2J72GmBS5YErUjtE3F4mtbcGUtn0vPnMepRI256xkkAtAwesXGjGOIz8izsa
         aHOTAqkXd8VtTiwn04WqhtY8Kgxuk+6g4kioFlu812bFwXnDMD/3pI1ANIbzhdxJUPwj
         CvJQVAOGYF3j9Ycd2IZYdsTelbTB4vT/zlLSL7Dd4VGjYgfp6sZ4HXB2KBvNZWk3p7nx
         QhAHj9pz8WQYkS3kPDUy8h6vwF1R+4IuhibO2QFpl+I87ED3g8clX2mSgM7D09F2RW+N
         GROMcyOHSsGdweRGX2NKYv6e076pcaM1bsDZBzXV4DEdS/nqJxn1b0w2/VEaKkjhTmop
         Ou2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852871; x=1723457671;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUTXv/4BMVQwGdjDsbktTy1NxZw7vMmfKE8tNFfq/Qo=;
        b=F6xKAc7tyIpYGpXLYHSt1JHpl+ZXs+GNhyDgHKJh0iZe7jPiBgkQcJBqYwFm33rCWp
         a3yeRSkhuUEwU3aEPy7/6KZxaqGDjlahi+hdZu1RuaGmtUCkHgUbkIIoF/prOe8J1WWc
         bddFo7ijHk1X17WnVpc/6TARFyPf9LBDchB8dcfHA7cbueG0QXi4gdnWfhBr2sFekJbV
         mKHuHmaDx7sydD3dqIMDgbc33jJt9cMd7+YybClyEhK6Hxqrfr6pRm4Ygotgm5lBSM7B
         AFcwXKGtXdsa+hMO7t6jeF7WXCdHRpHRzwQ9Nb88tVdAfz9oYjwp+0FWXy6aZUOVj/3v
         9QdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ReKqm7YRYbbzS1xXd+LS1QDWeX4TVWK1UnAyVahmmZqxTAeiol+uOcbQNStvsE1jdoDULRz9opGWIzk8QPg5Rpyh
X-Gm-Message-State: AOJu0Yy80bP1zjmsBdPL0Awj6ZcKXYF3iXhOMhgS4m8jI4JrB6Memi+v
	0fz9RCQ/8GY4p0f0gv7j790x1nX4mTI2gDF6f2AG6o59XIr/Z3Qw4Qif7vNVVTe+05aTjO7pT47
	E3U5UvU35Yb7yu/gTwyS2Kw+0q7VquMEjWTmDHg==
X-Google-Smtp-Source: AGHT+IFsaV3LKwGCMOQn0O4QgIlm4dsCb2VYE13IUfFYBk5I+7bdruiCzlImY6gmpq5Iem9oqay4dFWaow8fEqE5Kl0=
X-Received: by 2002:a05:6512:3ba9:b0:52e:6d71:e8f1 with SMTP id
 2adb3069b0e04-530bb3b434bmr7719818e87.53.1722852871307; Mon, 05 Aug 2024
 03:14:31 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Aug 2024 03:14:30 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
Date: Mon, 5 Aug 2024 03:14:30 -0700
Message-ID: <CAMRc=Mc7tnjWnWDUjeSfva-XuHp_J25sGXjsa78UjsGG69hwag@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/14] net: stmmac: convert stmmac "pcs" to phylink
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 12:45:21 +0200, "Russell King (Oracle)"
<linux@armlinux.org.uk> said:
> Hi,
>
> This is version 3 of the series switching stmmac to use phylink PCS
> isntead of going behind phylink's back.
>

Sorry for the noise but I had the line wrapping on. Here's the tag once again:

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> #
sa8775p-ride-r3

(The board is a more recent revision of the one Andrew tested this series on)

