Return-Path: <bpf+bounces-53298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA9A4FA1D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 10:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CA2170C21
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ADC204F78;
	Wed,  5 Mar 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWkEo5Vb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F11FF7D0
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167092; cv=none; b=gcVy3gKnPGzJCHi8RPMz2Ux2sE59PBUVaQWvvE22w6GdK7DmEBNRtd1PYHlztR9dWozC+yfK3xznqkGp9qbhtwtLl8ymzLyZGTyfUOuH2AcAoRuqDov/usc7I/eOh5KrUiBLl1Dr+t87vfHRgbamLw+wcSV2EVceERzYENx82gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167092; c=relaxed/simple;
	bh=k0wiGyIgP1X375nTP6KgieVfEGHC5iiA/tF0wfZSE0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ai8AmrkNAQG9Q9YH0TEmACPkQ+XQEDjJcHZh99B5o821W8hbmycODVGDOLCIVaax5U0/wPvITt+9dttThAPHwlksaMnMSmNdn4jfDkPTYihuD3/PYuFB78g1+miayyBumONLCQo+hD450XdJ+M11pdHKsBVVeE47D52IywOkszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWkEo5Vb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2f391864so3629467f8f.3
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 01:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741167089; x=1741771889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGHqSgga9ZWqhfiXbeTFLx+tMRtdQJt+JKetm5hHuhA=;
        b=oWkEo5Vb20pRDdMqdX3bZprxk0t/SQtfvw0K/EE4zLnhVo+SjO/oHsX+X7YgvT9aC3
         NFEiMz2U1rWwbZdPUrNnC/vwqdwG9r0BYI0R2VttNx3BEu4B5YTLti84iSTDAHMhITv/
         A8ilEQCMDnfxV2Bht9XGz8KQGn3lyz1Z5H3h9O15faFRtL0dwhG9zYfkck0yxAJhHNMn
         LDRgVEa2bc69dEvwZiuSUDBPQ/57OYjHqecYrItmWmaW2Kv33vhgbJFi/87rcR3E+am/
         GyMhlFFjqQof8J6XBTjawi/iQHd7COQfzmyGF7q6UIFphmoro3oujw/uETjUaSE4JW5f
         cN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167089; x=1741771889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGHqSgga9ZWqhfiXbeTFLx+tMRtdQJt+JKetm5hHuhA=;
        b=vSrGYoIJtEwTqCB1rVJ+t3s56mBcl/5l6NL0aoKmoFN0ezC98Otdfq7g4xn0lif4yG
         XNU9lShtyCo8q+mxQYNHnXN2XRzwnQkoiZxGWSKwbO0/0zOrrbFwkKtLsKYLmkyEF55e
         b0wT1DDu9Iwk4btsRi+lUuh267La2KePyq0xnFXCVkMQmmXg75Qs1yTkWe5F6epW++Ij
         Bs0JFuO5P9VIt8tebrjbtFyo7/G7m/t4KfzbReBgZawV7JHAXK9n/ZWWdMF7sGzJ2UJ3
         ckWwPUMw8KuHDq3olZVNgccfV8P1pA3c7R46Te6h/wtG7t5MfYgZ5UNtbnf/yBwjd+NZ
         IDcA==
X-Forwarded-Encrypted: i=1; AJvYcCWKn7EeusyfeK9Q3lWtJyxeMJ3QriCrf/zL18Na9/4iM17kqO1blp6g9b0f/8BnPBmfJZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeB+3Q98qR93PUezSTvqluNEpNpK1mk03N9rdoH1xjE8DVaTn+
	eTxCpJwUaR0RQ4wQimc2h3o8h4YD/0j309nTreevkI4RAlHkST65UHV9oZOqNbk=
X-Gm-Gg: ASbGnctU6Y0a4JFf1jkrbVCojE4BiH+23oAnb9BTlRCwL4JF7y7O4/f4fZcXH++zv+k
	dWfzutB///NPElXQ7n+EjfjFLtqCLjfPyWOeeAFmr5una1M5Gt+hWoKCmYgc+TRwPWZXH8KFD1u
	L8+CWO2iU9mve/plOukE3WxVdN6lJtNUrgPv2PeZbtTfr77sfQ525uKDzn5eZgZDnF2QHi11jus
	7cGpWwL+vI3MbuJebNA5dhEwr7NOIjlVDFa6qB6xY8XYAp+zNcIbjGPvD94q9KNZd6o+07BwLGm
	7d6T0Ad6tWIy6L2XbxukmANSucAmqfiROLWpN8lpDU3MpTd5Dw==
X-Google-Smtp-Source: AGHT+IGBjeO6TeQERlVAAv2wJR2v/E9DyRfr/DsoCry1ZVSWVEJcRLW+vugv45aqXSWg1cQhm5oZnw==
X-Received: by 2002:a5d:5850:0:b0:391:4f9:a039 with SMTP id ffacd0b85a97d-3911f7400aamr2203099f8f.16.1741167088987;
        Wed, 05 Mar 2025 01:31:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd42c5b33sm12065705e9.22.2025.03.05.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:31:28 -0800 (PST)
Date: Wed, 5 Mar 2025 12:31:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, u.kleine-koenig@baylibre.com,
	matthias.schiffer@ew.tq-group.com, schnelle@linux.ibm.com,
	diogo.ivo@siemens.com, glaroque@baylibre.com, macro@orcam.me.uk,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth:
 Add XDP support
Message-ID: <5f716740-ac45-4881-a27d-91a93de6f8c7@stanley.mountain>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
 <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
 <21f21dfb-264b-4e01-9cb3-8d0133b5b31b@ti.com>
 <2c0c1a4f-95d4-40c9-9ede-6f92b173f05d@stanley.mountain>
 <40ce8ed3-b36c-4d5f-b75a-7e0409beb713@ti.com>
 <61117a07-35b5-48c0-93d9-f97db8e15503@stanley.mountain>
 <fd989751-e7f6-40bb-a0bf-058c752cc7bc@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd989751-e7f6-40bb-a0bf-058c752cc7bc@ti.com>

On Wed, Mar 05, 2025 at 02:53:07PM +0530, Malladi, Meghana wrote:
> Hi Dan,
> 
> On 3/3/2025 7:38 PM, Dan Carpenter wrote:
> > What I mean is just compile the .o file with and without the unlikely().
> > $ md5sum drivers/net/ethernet/ti/icssg/icssg_common. o*
> > 2de875935222b9ecd8483e61848c4fc9 drivers/net/ethernet/ti/icssg/
> > icssg_common. o. annotation 2de875935222b9ecd8483e61848c4fc9
> > ZjQcmQRYFpfptBannerStart
> > This message was sent from outside of Texas Instruments.
> > Do not click links or open attachments unless you recognize the source
> > of this email and know the content is safe.
> > Report Suspicious
> > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!
> > uldq3TevVoc7KuXEXHnDf- TXtuZ0bON9iO0jTE7PyIS1jjfs_CzpvIiMi93PVt0MVDzjHGQSK__vY_-6rO7q86rFmBMGW4SSqK5pvNE$>
> > ZjQcmQRYFpfptBannerEnd
> > 
> > What I mean is just compile the .o file with and without the unlikely().
> > 
> > $ md5sum drivers/net/ethernet/ti/icssg/icssg_common.o*
> > 2de875935222b9ecd8483e61848c4fc9  drivers/net/ethernet/ti/icssg/icssg_common.o.annotation
> > 2de875935222b9ecd8483e61848c4fc9  drivers/net/ethernet/ti/icssg/icssg_common.o.no_anotation
> > 
> > Generally the rule is that you should leave likely/unlikely() annotations
> > out unless it's going to make a difference on a benchmark.  I'm not going
> > to jump down people's throat about this, and if you want to leave it,
> > it's fine.  But it just struct me as weird so that's why I commented on
> > it.
> > 
> 
> I have done some performance tests to see if unlikely() is gonna make any
> impact and I see around ~9000 pps and 6Mbps drop without unlikely() for
> small packet sizes (60 Bytes)
> 
> You can see summary of the tests here:
> 
> packet size   with unlikely(pps)  without unlikely(pps)   regression
> 
>       60        462377                453251                 9126
> 
>       80        403020                399372                 3648
> 
>       96        402059                396881                 5178
> 
>      120        392725                391312                 4413
> 
>      140        327706                327099                 607
> 
> packet size  with unlikely(Mbps)  without unlikely(Mbps)  regression
> 
>      60         311                   305                    6
> 
>      80         335                   332                    3
> 
>      96         386                   381                    5
> 
>      120        456                   451                    5
> 
>      140        430                   429                    1
> 
> For more details on the logs, please refer:https://gist.github.com/MeghanaMalladiTI/cc6cc7709791376cb486eb1222de67be
> 

Huh.  That's very interesting.  Fine, then.

regards,
dan carpenter


