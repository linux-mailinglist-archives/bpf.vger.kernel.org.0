Return-Path: <bpf+bounces-29679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D618C4A48
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 01:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E09A1F244B6
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DCE8594E;
	Mon, 13 May 2024 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFa6UM/l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503A85936;
	Mon, 13 May 2024 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644405; cv=none; b=meXIWzZ6pNfecBwW/L0/mnLXuEveCyWmzf1uQh5kcjyGdCQb9vzDTVUy7OhjSN7yeIhhuBlU61MS1h6SRxfSkMcujWGRlBZlLZWRyeJz1ZlSn116NTifrlvWQBV8C1pdlO1L3d7hdvMm2drVmjvapZwhLM3WRGWKumSsR0Qll9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644405; c=relaxed/simple;
	bh=SpjL2EZuKW1ZuJ16hipqwcy6dePjkLqwtqhVcyM01Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMX9n7jy7hO9LtVFDKlowToveVcGHGZXqnGPZLIsBrdbDGngBK1fXrce9Rn7lYs2Ekyni6PF6hF3t8gXKhYt324znEq/20bvD4Lnk9DOzeRtXcP+Ma7/wJr9RRPesus/K6OttFKjXKfGOyU82Zjxt5mEh9reBuGQ4tWifqtNLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFa6UM/l; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f40b5e059so5819179e87.0;
        Mon, 13 May 2024 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715644402; x=1716249202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+cOP9mgHdcUT8syROC27GujJ57GKSD45vkWwJ1/n4w=;
        b=bFa6UM/l2fKR+Xy7FTI80lE2FJKJtRbYjUCQ3oGCxppLZJZ71Pzg/XeLus7PywQTnj
         4Mns7LsqwxP8iM4XlBqz/kT9ZzMnufuPT69X/GYuVVLe7kP29+IlaOCbtR/RiYR90ekB
         tyYXSe0Q8CqU5XIQX8CYAbA18kf1MIo4cO2ImWYD2H3+LaLy9Ik95mF2f+IMsEtZZWgn
         Mig+DXguQdgi967D97MsHsw/xheBU6DRApNoQ/oo4kc/mbfiGiZ5f+IEietpp3mwiudj
         tOvvb/L6TnK7Q0IT/4+TcVZ5GOIw38NnhyEy3colFyJSDrZwUqC5gEnHS2c1P5I6GRFI
         1Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715644402; x=1716249202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+cOP9mgHdcUT8syROC27GujJ57GKSD45vkWwJ1/n4w=;
        b=N6NyPIz9xpP0JDgXnRkW4b4NSW844tR9v8Ge9OTVWWsK6e1lyetGACYo6v3qZBSym4
         MXBW230HJKPVdg34ir2CpPaguOETYdiXoDc/jKttHDj1oNJLAaI3gAkisL0QKbJrPuiU
         6Sk8xu43+b3lajU/fSkC1Ptib/f/RPIt9VWBcCDrms3JUtGgwiWuNiYTt9FXpn4ptHq2
         hhtzoFElmgkv0Ov1PfX08+ClXITnOIf189jpIl0HZjUC6IZn7HHn3VN8QXe9EEU02ksH
         eUVtwLWEH1/RQD/ROyDjXjX4TMaH5RwxO+tLLy1vk+gqcs+CesD84SnGvQjjpw1oRdDl
         5JGA==
X-Forwarded-Encrypted: i=1; AJvYcCWBqUhZXwVlVOLLxsvXWUA2kvXCk1vmSZlwSm2HDUa+d+QpzsKEcGLYyXRi6a+HqCMbuRO3inwJHCaZQjQU439gsuw7B663CqVzxljLKZI7sMjkdXK9U5hEnokr
X-Gm-Message-State: AOJu0YxCLq/5xF0Mz/vwf31sHb/XtS8A1x5RXdFXv/QuhWdkCH0QrFFp
	Yiy+v505I2fg16CP4+EyIMxIIPeYOcURI2FX+iWATdb2n6BVuq4y
X-Google-Smtp-Source: AGHT+IE1GjZH3oJxU4HUXHyIk/vCKzT3VdKQBPxQK0G4bhVU96P+esjbYQj0lhElqTJLfthkCCFq6g==
X-Received: by 2002:a2e:8748:0:b0:2e3:4f79:4d26 with SMTP id 38308e7fff4ca-2e51fd3fd73mr66915891fa.11.1715644399831;
        Mon, 13 May 2024 16:53:19 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ce3113sm15856831fa.36.2024.05.13.16.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:53:19 -0700 (PDT)
Date: Tue, 14 May 2024 02:53:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jose Abreu <joabreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC 0/6] net: stmmac: convert stmmac "pcs" to phylink
Message-ID: <5v3ur3cm6xkuomu3eirbtjg6th32dreqyotfnqcuumb6bmkhkj@62r5gpaky2gd>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <y2iz5uhcj5xh3dtpg3rnxap4qgvmgavzkf6qd7c2vqysmll3yx@drhs7upgpojz>
 <ZkKghpox1r6ZqtyB@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkKghpox1r6ZqtyB@shell.armlinux.org.uk>

On Tue, May 14, 2024 at 12:21:42AM +0100, Russell King (Oracle) wrote:
> On Tue, May 14, 2024 at 02:04:00AM +0300, Serge Semin wrote:
> > Hi Russell
> > 
> > I'll give your series a try later on this week on my DW GMAC with the
> > RGMII interface (alas I don't have an SGMII capable device, so can't
> > help with the AN-part testing).
> 
> Thanks!
> 
> > Today I've made a brief glance on it
> > and already noted a few places which may require a fix to make the
> > change working for RGMII (at least the RGSMIIIS IRQ must be got back
> > enabled). After making the patch set working for my device in what
> > form would you prefer me to submit the fixes? As incremental patches
> > in-reply to this thread?
> 
> I think it depends on where the issues are.
> 

> If they are addressing issues that are also present in the existing
> code, then it would make sense to get those patched as the driver
> stands today, because backporting them to stable would be easier.
> 

Sure. If I get to find any problem with the existing code I'll submit
a fix as an independent patch.

> If they are for "new" issues, given that this patch series is more
> or less experimental, I would prefer to roll them into these
> patches. As mentioned, when it comes to submitting these patches,
> the way I've split them wouldn't make much sense, but it does
> make sense for where I am with it. Hence, I'll want to resplit
> the series into something better for submission than it currently
> is. If you want to reply to this thread, that is fine.

I was meaning the "new" issues. Ok then. I'll prepare the fixes as
incremental patches either on top of the entire series or on top of
the respective patches, so the altered parts could be spotted right
out of the patches body. Then I'll submit them in-reply to the
respective messages in this patch set. After that you'll be able to
squash them up into the commits in your repo and re-shuffle the
changes as would be more appropriate.

> 
> There's still a few netif_carrier_off()/netif_carrier_on()s left
> in the driver even after this patch series, but I think they're in
> more obscure paths, but I will also want to address those as well.

Yeah, I noticed that. I was going to discuss this matter after getting
the changes tested.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

